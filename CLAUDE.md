# SysML v2 Model Transformation Pipeline

This project transforms textual Service Functional Specifications
into formal SysML v2 models at CIM and PIM levels.

## Agent Instructions

The orchestrator agent (`agents/orchestrator.md`) coordinates seven sub-agents (SA1-SA7). Each sub-agent has its own instruction file in `agents/`.

## Prerequisites

Before starting a transformation, verify:

1. The SFM source document exists in `OriginalSFM/` (docx, pdf, or pre-converted markdown)
2. The `SysMLv2Example/` directory contains reference examples
3. The target output directory `Services/{ServiceName}/` can be created

## Variable Definitions

At the start of every transformation, establish these variables:

| Variable | Description | Example |
|---|---|---|
| `{SC}` | Service code (short uppercase) | `IS` |
| `{ServiceName}` | Full service name (for directory) | `IdentificationService` |
| `{SFM_PATH}` | Path to the SFM source document | `OriginalSFM/HL7_IS_SFM.docx` |
| `{SFM_MD}` | Path to the markdown conversion | `input/{SC}_sfm.md` |
| `{OUT}` | Output directory | `Services/{ServiceName}/` |

## Execution

1. Place the input specification in `OriginalSFM/`.
2. If the specification in `OriginalSFM/` is docx/pdf Use Bash: markitdown "{SFM_PATH}" > "/input/{SC}_sfm.md", if the source is already markdown, copy to {SFM_MD}.
2. The orchestrator reads the specification `input/` and dispatches
   to sub-agents in the prescribed order.
3. Outputs are written to `output/` in the prescribed structure.
4. The verification report and transformation log are the
   final deliverables.

## Output Specification

The agent shall produce a single SysML v2 textual model organized as follows:

ServiceFuctionalModel_<ServiceName>/
│
├── CIM/
│   ├── BusinessDomain          — Domain ontology
│   ├── StakeholderModel         — Roles and concerns
│   ├── BusinessCapabilities     — Use cases
│   ├── BusinessRules            — Policies and constraints
│   ├── CIM_Requirements/
│   │   ├── FunctionalRequirements
│   │   ├── QualityRequirements
│   │   └── ComplianceRequirements
│   └── CIM_Traceability         — Cross-element links
│
├── PIM/
│   ├── DataModel                — Item and attribute definitions
│   ├── ServiceContracts         — Interface and port definitions
│   ├── Operations               — Action definitions with parameters
│   ├── BehavioralFlows          — Interaction orchestration
│   ├── Composition              — Part definitions and connections
│   └── PIM_Traceability         — PIM-internal and CIM→PIM links
│
└── TransformationLog            — Decisions, assumptions, open issues

## PSM Pipeline (FHIR R5)

After the SFM→SysML transformation completes, run the PSM pipeline to map
the PIM onto FHIR R5 resources and produce native FHIR artifacts.

### PSM Variable Definitions

| Variable | Description | Example |
|---|---|---|
| `{ServiceName}` | Full service name (matches SFM→SysML variable) | `IdentificationService` |
| `{PIM_PATH}` | Path to PIM package directory | `output/ServiceFunctionalModel_{ServiceName}/PIM` |
| `{PSM_OUT}` | PSM output directory | `output/ServiceFunctionalModel_{ServiceName}/PSM` |
| `{FHIR_VERSION}` | FHIR version target | `R5` |
| `{FHIR_VALIDATOR_JAR}` | Path to the official HL7 FHIR Validator JAR used by SB5 FV-02 | `tools/validator_cli.jar` (default; override via `FHIR_VALIDATOR_JAR` env var) |

### PSM Prerequisites

In addition to the core prerequisites:
1. A JDK 17+ `java` executable must be on `PATH` (for the FHIR Validator).
2. The official HL7 FHIR Validator JAR must be available at `{FHIR_VALIDATOR_JAR}`. If absent, SB5 phase=FHIR FV-02 fails with `FV-02-MISSING-TOOLING` and the pipeline halts.
   Install with:
   ```
   curl -L -o tools/validator_cli.jar https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar
   ```
   (Or download the pinned release that matches the target R5 revision used in the PSM.)
3. An internet connection at validator-run time, unless the validator has been pre-warmed with the R5 package cache (`~/.fhir/packages/`).

### PSM Execution

1. Verify PIM output exists at `{PIM_PATH}/` with all six PIM packages (five are consumed by the PSM pipeline; `Composition.sysml` is produced by SA5 but not passed to any PSM agent).
2. Invoke `psm_orchestrator` with `{ServiceName}`, `{PIM_PATH}`, `{PSM_OUT}`, `{FHIR_VERSION}`.
3. PSM SysML packages are written to `{PSM_OUT}/SysML/`.
4. FHIR JSON artifacts are written to `{PSM_OUT}/FHIR/`.
5. Conformance report is written to `{PSM_OUT}/PSM_ConformanceReport.md`.

### PSM Output Specification

```
PSM_{ServiceName}/
├── SysML/
│   ├── ResourceModel.sysml          — FHIR resources as item def specializations
│   ├── ProfileDefinitions.sysml     — Constraints, extensions, must-support
│   ├── TerminologyManifest.sysml    — ValueSet / CodeSystem / NamingSystem closure
│   ├── APIContracts.sysml           — REST interactions + $operations as action defs
│   ├── WorkflowPatterns.sysml       — Task/Subscription/Bundle flows
│   └── PSM_Traceability.sysml       — PIM→PSM traceability links
└── FHIR/
    ├── StructureDefinitions/         — Per-resource and extension profile JSON
    ├── OperationDefinitions/         — Per-$operation JSON
    ├── SearchParameters/             — Per-custom-parameter JSON (base params referenced by URL, not cloned)
    ├── SubscriptionTopics/           — R5 subscription topic JSON
    ├── ValueSets/                    — Per-ValueSet JSON
    ├── CodeSystems/                  — Per-CodeSystem JSON
    ├── NamingSystems/                — Per-NamingSystem JSON
    ├── Examples/                     — One-or-more example instances per profile
    ├── CapabilityStatement.json      — Full service capability declaration
    ├── ImplementationGuide.json      — R5 IG resource enumerating every artifact (emitted by SB6-IG)
    ├── package.json                  — NPM IG manifest for HL7 IG Publisher (emitted by SB6-IG)
    └── ig.ini                        — IG Publisher configuration (emitted by SB6-IG)
```

### PSM Pipeline Agents

| Agent | Role |
|---|---|
| `psm_orchestrator` | Coordinates the seven PSM agents and enforces phase ordering |
| `sb1_d_resource_mapper` | Data Track — maps PIM item defs to FHIR R5 base resources |
| `sb2_d_profile_builder` | Data Track — emits StructureDefinitions, extensions, and TerminologyManifest |
| `sb1_b_api_mapper` | Behavior Track — maps PIM action defs to FHIR REST interactions / `$operation`s |
| `sb2_b_capability_builder` | Behavior Track — emits WorkflowPatterns + CapabilityStatement summary |
| `sb3_psm_integrator` | Reconciles both tracks, builds PSM_Traceability, enforces MS coverage |
| `sb4_fhir_json_serializer` | Serializes SysML PSM to FHIR R5 JSON (profiles, ops, VS/CS/NS, examples) |
| `sb5_conformance_validator` | Two-phase validator (SysML + FHIR) — runs HL7 FHIR Validator for FV-02 |
| `sb6_ig_packager` | Packages all FHIR R5 JSON into a publishable IG (ImplementationGuide + package.json + ig.ini) |

### Publishing the IG

After the PSM pipeline completes, the `{PSM_OUT}/FHIR/` directory is a valid IG Publisher input. To produce the HTML IG:

```
java -jar tools/publisher.jar -ig {PSM_OUT}/FHIR/ig.ini
```

(Install `publisher.jar` from https://github.com/HL7/fhir-ig-publisher/releases as needed. This is not required for PSM pipeline execution; SB6-IG only produces the NPM package inputs.)


## Sub-Agent Invocation

Use Claude Code's subagent capability to spawn each sub-agent
with its instruction file and curated input context. Capture
outputs as files in the output directory.

## Quality Gates

- No sub-agent output is accepted without passing its internal
  quality checks.
- The pipeline does not proceed past SA6/SA7 if ERROR-level findings
  remain after 3 correction cycles per gate.