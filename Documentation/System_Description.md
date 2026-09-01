# HL7 HSRA E2 — SFM → SysML v2 → FHIR R5: description of how the system works

## 1. Purpose and architectural principle

The system is a chain of orchestrated LLM agents that transforms an HL7 *Service Functional Model* (SFM), a natural-language document produced by HL7-OSA, into a formal, computable SysML v2 model and, subsequently, into a draft publishable FHIR R5 Implementation Guide.

The system is designed for dual use. On the one hand, the models it produces—accessible via the standard SysML v2 APIs and the MCP protocol—serve as a knowledge base for the creation of eHealth architectures. On the other hand, it can support the development of the HL7 FHIR Implementation Guide.

The system structure currently follows the classical MDA schema **CIM → PIM → PSM**, but the transformation mechanics are not deterministic as in traditional MDA: every step is executed by an LLM. Reliability therefore does not come from the individual prompt, but from the **harness** surrounding the agents — a "logical cage" made of three elements: (a) a mandatory structured output format for every handoff (classification tables, SysML v2 packages, FHIR JSON); (b) automated verification gates with typed ERROR/WARNING/INFO findings; (c) correction cycles routed to the responsible agent, with a maximum number of iterations and escalation to the user. The structured language (SysML v2, FHIR JSON) is thus the real contract between steps, not free text.

The chain currently comprises **2 macro-agents (orchestrators) and 16 sub-agents**.

## 2. Inputs, resources and configuration

| Element | Role |
|---|---|
| `OriginalSFM/` | Source SFM in docx/pdf format (e.g. `HL7_V3_IS_R1.docx`) |
| MCP `markitdown` | Converts the source to markdown; the result is saved as `input/{SC}_sfm.md` |
| `SysMLv2Example/` | Reference SysML v2 examples (including `FHIR_R5_Base.sysml`) used as the notation oracle and as the FHIR type base |
| `.claude/agents/*.md` | Instructions (system prompt) for orchestrators and sub-agents |
| `.claude/agent-memory/<agent>/MEMORY.md` | Per-agent persistent memory: recurring patterns, typical errors, conventions consolidated across runs |
| `.claude/hooks/` | Session hooks: automatic file backup before every modification, backup cleanup at session end |
| `tools/` | External binaries: `validator_cli.jar` (HL7 FHIR Validator), `publisher.jar` (IG Publisher), Python staging/build scripts for the IG |
| `output/ServiceFunctionalModel_{ServiceName}/` | Output tree of the transformed service |

## 3. Macro-agent 1 — SFM → SysML v2 (CIM + PIM)

The orchestrator (`sysml-pipeline-orchestrator`) transforms nothing itself: it routes work, applies the
gates, manages pipeline state and assembles the deliverable. Sequence:

1. **SA1 — Input Analyzer**: classifies every statement of the SFM into one of the categories
   `DOMAIN_CONCEPT, STAKEHOLDER, CAPABILITY, RULE, REQUIREMENT_FUNCTIONAL, REQUIREMENT_QUALITY,
   REQUIREMENT_COMPLIANCE, OPERATION, DATA_STRUCTURE, WORKFLOW`. It produces three artifacts: the
   *Classification Table* (each row carrying an `ST-nnn` ID, source text, category, cross-references), the
   *Cross-Reference Map* and the *Ambiguity & Gap Report*. Explicit inference rules handle implicit
   stakeholders, vague regulatory references, and compound statements (which are split into two
   cross-referenced entries).
2. **SA2 — CIM Ontology Builder**: from DOMAIN/STAKEHOLDER/CAPABILITY/RULE it produces the packages
   `BusinessDomain`, `StakeholderModel`, `BusinessCapabilities` (use cases), `BusinessRules`.
3. **SA3 — CIM Requirements Engineer**: formalizes requirements into `FunctionalRequirements`,
   `QualityRequirements`, `ComplianceRequirements` and builds `CIM_Traceability` with
   `#derivation connection` links to the SA2 elements.
4. **SA4 — PIM Data & Operations**: from the CIM plus the OPERATION/DATA_STRUCTURE categories it produces
   `DataModel` (item defs and attributes), `ServiceContracts` (interface defs, port defs, flows) and
   `Operations` (action defs with `in`/`out` parameters).
5. **SA5 — PIM Behavioral & Composition**: produces `BehavioralFlows` (interaction orchestration),
   `Composition` (part defs and connections) and `PIM_Traceability` (PIM-internal and CIM→PIM links).
6. **SA6 — Consistency Verifier**: the content gate. It runs families of checks on traceability
   (CC-01..CC-10: e.g. every functional requirement must derive from at least one use case; every PIM
   operation must trace to a CIM use case; every `action def` must have at least one `in` and one `out`),
   naming (NC-01..NC-05: PascalCase/camelCase/UPPER_SNAKE_CASE, no duplicates, `FR/QR/CR-NNN` ID pattern)
   and semantics/structure (SC-01..SC-14: no technology reference in the CIM, no platform protocol in the
   PIM, consistency of flow directions, correct use of `use case`/`requirement` as *usages* rather than
   *defs*, etc.).
7. **SA7 — Notation Validator**: the SysML v2 syntax gate (keywords, the `:>`, `:>>`, `::>`, `~`, `=`,
   `#`, `::` operators, structural and behavioral patterns), validated against the examples in
   `SysMLv2Example/`. For every error it supplies the exact replacement syntax.

**Error recovery**: every ERROR finding is classified (traceability gap, naming violation, semantic
inconsistency, completeness gap, notation error) and routed to the sub-agent that produced the element,
with the instruction to correct it while preserving everything else; the gate is then re-run. The limit is
**3 correction cycles per error**, beyond which the orchestrator escalates to the user, describing the
error, the attempts made and the recommendation for manual resolution. If SA7 corrections touched
traceability, flows, interfaces or imports, SA6 is re-run on the affected subset of checks.

**Context minimization**: each sub-agent receives only the context it needs (SA2 receives only the CIM
categories, SA4 receives the CIM plus the OPERATION/DATA_STRUCTURE categories, and so on); only SA6 and
SA7 see the complete model. This is a quality criterion, not merely a cost one: it reduces the drift and
hallucinations produced by overly broad contexts.

**Output**: a `CIM/` + `PIM/` tree in textual SysML v2, plus `TransformationLog.md` recording decisions,
assumptions and open issues.

## 4. Macro-agent 2 — PIM → PSM FHIR R5

The `psm_orchestrator` verifies the presence of the PIM packages and of `validator_cli.jar`, creates the
output tree, and runs **two parallel tracks** that converge in a merge:

- **Data Track**: **SB1-D** maps each PIM `item def` onto the most appropriate FHIR R5 resource
  (`MAPPED`/`EXTENDED`/`CUSTOM`), producing `ResourceModel.sysml`; **SB2-D** generates
  `ProfileDefinitions.sysml` (constraints, extensions, must-support) and `TerminologyManifest.sysml`
  (the ValueSet/CodeSystem/NamingSystem closure).
- **Behavior Track**: **SB1-B** maps each `action def` onto a REST interaction or an `$operation`
  (`APIContracts.sysml`); **SB2-B** maps the behavioral flows onto FHIR patterns (Task, Bundle,
  Subscription/SubscriptionTopic) and aggregates the CapabilityStatement summary
  (`WorkflowPatterns.sysml`).
- **SB3 — Integrator**: reconciles the two tracks (naming conflicts, cross-references) and produces
  `PSM_Traceability.sysml` with the required **100%** PIM→PSM coverage.
- **SB5 (phase=SysML)**: the gate over the PSM packages — completeness (SC-01..SC-06), attribute/parameter/
  event coverage (PC-01..PC-03), mandatory FHIR metadata (MC-01..MC-03), syntax (SY-01..SY-04). Execution
  proceeds only with zero ERRORs.
- **SB4 — Serializer**: translates the SysML PSM packages into native FHIR R5 JSON (StructureDefinition,
  OperationDefinition, SearchParameter, SubscriptionTopic, ValueSet, CodeSystem, NamingSystem, examples,
  CapabilityStatement).
- **SB5 (phase=FHIR)**: structural and consistency checks over the JSON (FS-*, FC-*, FV-01) and, above all,
  **FV-02**, which runs the **official HL7 FHIR Validator** over the whole directory as an IG package.
  A missing JAR is not tolerated: it yields `FV-02-MISSING-TOOLING` and blocks the pipeline, because no
  PSM can be called conformant without external validation.
- **SB6-IG — Packager**: with zero ERRORs, it emits `ImplementationGuide.json`, `package.json` and
  `ig.ini`, making the `PSM/FHIR/` directory a valid input for `publisher.jar` (HTML IG generation).

Correction routing applies here as well: a table associates every check ID with the responsible agent and
with the maximum number of cycles (typically 3, and 2 for SB3).

## 5. Execution example — HL7 Identification Service (IS)

From the single document `HL7_V3_IS_R1.docx` the chain produced: ~6,600 lines of SysML v2 across CIM and PIM (8 CIM packages, 6 PIM packages); at PSM level 10 FHIR `item def`s, 14 `action def`s mapped onto REST interactions/`$operation`s, 6 behavioral flows, 1 SubscriptionTopic; in JSON: 37 StructureDefinitions, 4 OperationDefinitions, 9 ValueSets, 9 CodeSystems, 2 NamingSystems, 10 example instances, the CapabilityStatement and the IG package. `PSM_ConformanceReport.md` records 0 ERRORs and 0 WARNINGs in the SysML phase, and the result of HL7 FHIR Validator 6.9.6 against `hl7.fhir.r5.core#5.0.0` in the FHIR phase.

## 6. Status and limitations

Project status: **Alpha 1**. The human stays in the loop for the cases the gates do not resolve within the maximum number of corrections, and for validating the assumptions recorded in the TransformationLog (in particular quality requirements generated as placeholders from gaps in the source SFM). The PIM package `Composition.sysml` is produced by SA5 and verified during pre-flight, but is not consumed by any PSM agent. HTML IG generation via `publisher.jar` is a subsequent step, external to the pipeline.
