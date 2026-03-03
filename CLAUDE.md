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

## Sub-Agent Invocation

Use Claude Code's subagent capability to spawn each sub-agent
with its instruction file and curated input context. Capture
outputs as files in the output directory.

## Quality Gates

- No sub-agent output is accepted without passing its internal
  quality checks.
- The pipeline does not proceed past SA6/SA7 if ERROR-level findings
  remain after 3 correction cycles per gate.