# HL7 HSRA E2 — SFM → SysML v2 → FHIR R5: descrizione del funzionamento

## 1. Scopo e principio architetturale

Il sistema è una catena di agenti LLM orchestrati che trasforma un HL7 *Service Functional Model* (SFM),
documento in linguaggio naturale prodotto da HL7-OSA, in un modello SysML v2 formale e computabile e,
successivamente, in una bozza di Implementation Guide FHIR R5 pubblicabile.

La struttura del modello segue lo schema MDA classico **CIM → PIM → PSM**, ma la meccanica di
trasformazione non è deterministica come nell'MDA tradizionale: ogni passaggio è eseguito da un LLM.
L'affidabilità non deriva quindi dal singolo prompt, bensì dal **harness** che circonda gli agenti — una
"gabbia logica" fatta di tre elementi: (a) formato di output strutturato obbligatorio per ogni handoff
(tabelle di classificazione, package SysML v2, JSON FHIR); (b) gate di verifica automatici con findings
tipizzati ERROR/WARNING/INFO; (c) cicli di correzione instradati all'agente responsabile, con numero
massimo di iterazioni ed escalation all'utente. Il linguaggio strutturato (SysML v2, FHIR JSON) è quindi
il vero contratto fra gli step, non il testo libero.

Attualmente la catena comprende **2 macro-agenti (orchestratori) e 16 sub-agenti**.

## 2. Ingressi, risorse e configurazione

| Elemento | Ruolo |
|---|---|
| `OriginalSFM/` | SFM sorgente in formato docx/pdf (es. `HL7_V3_IS_R1.docx`) |
| MCP `markitdown` | Converte il sorgente in markdown; l'esito è salvato come `input/{SC}_sfm.md` |
| `SysMLv2Example/` | Esempi SysML v2 di riferimento (fra cui `FHIR_R5_Base.sysml`) usati come oracolo notazionale e come base tipi FHIR |
| `.claude/agents/*.md` | Istruzioni (system prompt) di orchestratori e sub-agenti |
| `.claude/agent-memory/<agente>/MEMORY.md` | Memoria persistente per agente: pattern ricorrenti, errori tipici, convenzioni consolidate fra esecuzioni |
| `.claude/hooks/` | Hook di sessione: backup automatico dei file prima di ogni modifica, pulizia dei backup a fine sessione |
| `tools/` | Binari esterni: `validator_cli.jar` (HL7 FHIR Validator), `publisher.jar` (IG Publisher), script Python di staging/build IG |
| `output/ServiceFunctionalModel_{ServiceName}/` | Albero di output del servizio trasformato |

## 3. Macro-agente 1 — SFM → SysML v2 (CIM + PIM)

L'orchestratore (`sysml-pipeline-orchestrator`) non trasforma nulla: instrada, applica i gate, gestisce lo
stato di pipeline e assembla il deliverable. Sequenza:

1. **SA1 — Input Analyzer**: classifica ogni enunciato dello SFM in una delle categorie
   `DOMAIN_CONCEPT, STAKEHOLDER, CAPABILITY, RULE, REQUIREMENT_FUNCTIONAL, REQUIREMENT_QUALITY,
   REQUIREMENT_COMPLIANCE, OPERATION, DATA_STRUCTURE, WORKFLOW`. Produce tre artefatti: *Classification
   Table* (ogni riga con ID `ST-nnn`, testo sorgente, categoria, riferimenti incrociati), *Cross-Reference
   Map* e *Ambiguity & Gap Report*. Regole di inferenza esplicite gestiscono stakeholder impliciti,
   riferimenti normativi vaghi e enunciati composti (che vengono splittati in due entry correlate).
2. **SA2 — CIM Ontology Builder**: da DOMAIN/STAKEHOLDER/CAPABILITY/RULE produce i package
   `BusinessDomain`, `StakeholderModel`, `BusinessCapabilities` (use case), `BusinessRules`.
3. **SA3 — CIM Requirements Engineer**: formalizza i requisiti in `FunctionalRequirements`,
   `QualityRequirements`, `ComplianceRequirements` e costruisce `CIM_Traceability` con
   `#derivation connection` verso gli elementi SA2.
4. **SA4 — PIM Data & Operations**: da CIM + categorie OPERATION/DATA_STRUCTURE produce `DataModel`
   (item def e attributi), `ServiceContracts` (interface def, port def, flow) e `Operations` (action def
   con parametri `in`/`out`).
5. **SA5 — PIM Behavioral & Composition**: produce `BehavioralFlows` (orchestrazione delle interazioni),
   `Composition` (part def e connessioni) e `PIM_Traceability` (link interni al PIM e CIM→PIM).
6. **SA6 — Consistency Verifier**: gate di contenuto. Esegue famiglie di controlli su tracciabilità
   (CC-01..CC-10: es. ogni requisito funzionale deve derivare da almeno uno use case; ogni operazione PIM
   deve tracciare a uno use case CIM; ogni `action def` deve avere almeno un `in` e un `out`), naming
   (NC-01..NC-05: PascalCase/camelCase/UPPER_SNAKE_CASE, nessun duplicato, pattern ID `FR/QR/CR-NNN`) e
   semantica/struttura (SC-01..SC-14: nessun riferimento tecnologico nel CIM, nessun protocollo di
   piattaforma nel PIM, coerenza delle direzioni di flusso, uso corretto di `use case`/`requirement` come
   *usage* e non come *def*, ecc.).
7. **SA7 — Notation Validator**: gate di sintassi SysML v2 (keyword, operatori `:>`, `:>>`, `::>`, `~`,
   `=`, `#`, `::`, pattern strutturali e comportamentali), validato contro gli esempi in `SysMLv2Example/`.
   Per ogni errore fornisce la sintassi sostitutiva esatta.

**Recupero errori**: ogni finding ERROR viene classificato (gap di tracciabilità, violazione di naming,
incoerenza semantica, gap di completezza, errore notazionale) e instradato al sub-agente che ha prodotto
l'elemento, con istruzione di correggere preservando tutto il resto; il gate viene poi rieseguito. Il
limite è di **3 cicli di correzione per errore**, oltre il quale l'orchestratore escala all'utente
descrivendo l'errore, i tentativi effettuati e la raccomandazione di risoluzione manuale. Se le correzioni
di SA7 hanno toccato tracciabilità, flussi, interfacce o import, SA6 viene rieseguito sul sottoinsieme di
controlli impattato.

**Context minimization**: ciascun sub-agente riceve solo il contesto che gli serve (SA2 riceve le sole
categorie CIM, SA4 riceve CIM + categorie OPERATION/DATA_STRUCTURE, ecc.); solo SA6 e SA7 vedono il
modello completo. È un criterio di qualità, non solo di costo: riduce la deriva e le allucinazioni
prodotte da contesti troppo ampi.

**Output**: albero `CIM/` + `PIM/` in SysML v2 testuale, più `TransformationLog.md` con decisioni,
assunzioni e questioni aperte.

## 4. Macro-agente 2 — PIM → PSM FHIR R5

Il `psm_orchestrator` verifica la presenza dei package PIM e del `validator_cli.jar`, crea l'albero di
output ed esegue **due track paralleli** che convergono in un merge:

- **Data Track**: **SB1-D** mappa ogni `item def` del PIM sulla risorsa FHIR R5 più appropriata
  (`MAPPED`/`EXTENDED`/`CUSTOM`) producendo `ResourceModel.sysml`; **SB2-D** genera
  `ProfileDefinitions.sysml` (vincoli, estensioni, must-support) e `TerminologyManifest.sysml`
  (chiusura ValueSet/CodeSystem/NamingSystem).
- **Behavior Track**: **SB1-B** mappa ogni `action def` su interazione REST o `$operation`
  (`APIContracts.sysml`); **SB2-B** mappa i flussi comportamentali su pattern FHIR (Task, Bundle,
  Subscription/SubscriptionTopic) e aggrega il riepilogo del CapabilityStatement
  (`WorkflowPatterns.sysml`).
- **SB3 — Integrator**: riconcilia i due track (conflitti di naming, riferimenti incrociati) e produce
  `PSM_Traceability.sysml` con copertura PIM→PSM richiesta al **100%**.
- **SB5 (fase SysML)**: gate sui package PSM — completezza (SC-01..SC-06), copertura attributi/parametri/
  eventi (PC-01..PC-03), metadati FHIR obbligatori (MC-01..MC-03), sintassi (SY-01..SY-04). Si prosegue
  solo con zero ERROR.
- **SB4 — Serializer**: traduce i package SysML PSM in JSON FHIR R5 nativo (StructureDefinition,
  OperationDefinition, SearchParameter, SubscriptionTopic, ValueSet, CodeSystem, NamingSystem, esempi,
  CapabilityStatement).
- **SB5 (fase FHIR)**: controlli strutturali e di coerenza sul JSON (FS-*, FC-*, FV-01) e soprattutto
  **FV-02**, che esegue il **validatore ufficiale HL7 FHIR** sull'intera directory come pacchetto IG.
  L'assenza del JAR non è tollerata: produce `FV-02-MISSING-TOOLING` e blocca la pipeline, perché nessun
  PSM può dirsi conforme senza validazione esterna.
- **SB6-IG — Packager**: con zero ERROR, emette `ImplementationGuide.json`, `package.json` e `ig.ini`,
  rendendo la directory `PSM/FHIR/` un input valido per `publisher.jar` (generazione dell'IG HTML).

Anche qui vale il routing delle correzioni: una tabella associa ogni check ID all'agente responsabile e al
numero massimo di cicli (tipicamente 3, 2 per SB3).

## 5. Esempio di esecuzione — HL7 Identification Service (IS)

Dal solo documento `HL7_V3_IS_R1.docx` la catena ha prodotto: ~6.600 righe di SysML v2 fra CIM e PIM
(8 package CIM, 6 package PIM); a livello PSM 10 `item def` FHIR, 14 `action def` mappate su interazioni
REST/`$operation`, 6 flussi comportamentali, 1 SubscriptionTopic; in JSON: 37 StructureDefinition,
4 OperationDefinition, 9 ValueSet, 9 CodeSystem, 2 NamingSystem, 10 istanze di esempio,
CapabilityStatement e pacchetto IG. Il `PSM_ConformanceReport.md` registra 0 ERROR e 0 WARNING in fase
SysML e l'esito del validatore HL7 FHIR 6.9.6 su `hl7.fhir.r5.core#5.0.0` in fase FHIR.

## 6. Stato e limiti

Stato del progetto: **Alpha 1**. L'umano resta nel ciclo per i casi che i gate non risolvono entro il
numero massimo di correzioni e per la validazione delle assunzioni registrate nel TransformationLog
(in particolare requisiti di qualità generati come placeholder da gap dello SFM sorgente). Il package
PIM `Composition.sysml` è prodotto da SA5 e verificato in pre-flight, ma non è consumato da alcun agente
PSM. La generazione dell'IG HTML tramite `publisher.jar` è un passo successivo, esterno alla pipeline.
