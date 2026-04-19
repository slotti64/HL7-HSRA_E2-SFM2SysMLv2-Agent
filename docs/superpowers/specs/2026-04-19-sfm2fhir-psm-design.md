# SFM2FHIR-PSM Pipeline Design

**Date**: 2026-04-19  
**Status**: Approved for implementation planning  
**Target**: FHIR R5  
**Pipeline**: Standalone (reads PIM output from SFM→SysML pipeline)

---

## 1. Purpose

The SFM2FHIR-PSM pipeline transforms the PIM layer of a SysML v2 Service Functional Model into a Platform-Specific Model (PSM) targeting HL7 FHIR R5. It produces two parallel output streams:

1. **SysML v2 PSM packages** — FHIR resources, profiles, API contracts, and workflow patterns expressed in SysML v2 textual notation with FHIR metadata stereotypes
2. **Native FHIR R5 JSON artifacts** — StructureDefinition, OperationDefinition, SearchParameter, CapabilityStatement, SubscriptionTopic

---

## 2. Architecture: Two-Track Parallel Pipeline

The pipeline uses two independent mapping tracks that run in parallel, merge at an Integrator agent, then produce both output formats.

```
[PIM packages]
      │
      ├── Data Track ─────────────────────────────────────────────────────┐
      │    SB1-D: Resource Mapper → ResourceModel.sysml                   │
      │    SB2-D: Profile Builder → ProfileDefinitions.sysml              │
      │                                                                    │
      ├── Behavior Track ──────────────────────────────────────────────────┤
      │    SB1-B: API Mapper     → APIContracts.sysml                     │
      │    SB2-B: Capability Builder → WorkflowPatterns.sysml             │
      │                                                                    │
      └────────────────────────────────────────────────────────────────────┘
                                    │
                             SB3: PSM Integrator
                             → PSM_Traceability.sysml + reconciled packages
                                    │
                    ┌───────────────┴───────────────┐
             SB4: FHIR JSON Serializer        SB5: Conformance Validator
             → FHIR/**.json                  → Validation report
```

---

## 3. Pipeline Inputs

**Trigger variables**:

| Variable | Description | Example |
|---|---|---|
| `{PIM_PATH}` | Path to PIM package directory | `Services/IdentificationService/PIM/` |
| `{ServiceName}` | Full service name | `IdentificationService` |
| `{FHIR_VERSION}` | FHIR version target | `R5` |
| `{OUT}` | PSM output directory | `Services/IdentificationService/PSM/` |

**Expected PIM inputs**:

| File | Consumed By |
|---|---|
| `DataModel.sysml` | SB1-D (Data Track) |
| `ServiceContracts.sysml` | SB1-B (Behavior Track) |
| `Operations.sysml` | SB1-B (Behavior Track) |
| `BehavioralFlows.sysml` | SB2-B (Behavior Track) |
| `PIM_Traceability.sysml` | SB3 (Integrator) |

---

## 4. Agent Definitions

### Data Track

**SB1-D: Resource Mapper**
- Input: `DataModel.sysml`
- Responsibility: Maps each `item def` to a FHIR R5 base resource; identifies attributes requiring extensions; scores mapping fit quality
- Output: `ResourceModel.sysml` — FHIR resources as `item def :> FHIRResource` with `fhirResource` metadata

**SB2-D: Profile Builder**
- Input: `ResourceModel.sysml` + `DataModel.sysml`
- Responsibility: Produces StructureDefinition constraints; sets cardinality and must-support flags; defines extensions for unmapped attributes
- Output: `ProfileDefinitions.sysml` — `attribute def` constraints + `FHIRExtension` definitions

### Behavior Track

**SB1-B: API Mapper**
- Input: `Operations.sysml` + `ServiceContracts.sysml`
- Responsibility: Maps each `action def` to a FHIR R5 interaction (create/read/update/delete/search) or `$operation`; maps ports to FHIR endpoints; defines SearchParameters
- Output: `APIContracts.sysml` — `action def` with `fhirInteraction` and `fhirMethod` metadata

**SB2-B: Capability Builder**
- Input: `APIContracts.sysml` + `BehavioralFlows.sysml`
- Responsibility: Assembles CapabilityStatement resource; maps behavioral flows to Task/Subscription/Bundle patterns; defines SubscriptionTopics for event-driven flows
- Output: `WorkflowPatterns.sysml` — workflow `action def` sequences with FHIR R5 resource bindings

### Shared / Merge Agents

**SB3: PSM Integrator**
- Input: `ResourceModel.sysml`, `ProfileDefinitions.sysml`, `APIContracts.sysml`, `WorkflowPatterns.sysml`, `PIM_Traceability.sysml`
- Responsibility: Reconciles both tracks; resolves naming conflicts; builds PIM→PSM traceability map; flags unmapped PIM elements
- Output: `PSM_Traceability.sysml` + reconciled package set

**SB4: FHIR JSON Serializer**
- Input: All reconciled PSM SysML packages from SB3
- Responsibility: Serializes all FHIR R5 artifacts to valid R5 JSON
- Output: `PSM/FHIR/` directory with all JSON artifacts

**SB5: Conformance Validator** (runs twice — two-phase validator)
- Phase 1 input: All reconciled PSM SysML packages from SB3
- Phase 1 responsibility: Validates SysML PSM layer; routes corrections to responsible agents; blocks progression on errors
- Phase 2 input: All FHIR JSON artifacts from SB4
- Phase 2 responsibility: Validates FHIR R5 JSON layer; routes corrections to SB4
- Output: `PSM_ConformanceReport.md` + correction directives per phase

---

## 5. Orchestration Sequence

```
Step 1: [SB1-D || SB1-B]                         — parallel dispatch
Step 2: [SB2-D(SB1-D) || SB2-B(SB1-B)]          — parallel, each waits on own track
Step 3: SB3(SB2-D + SB2-B + PIM_Traceability)    — sequential merge
Step 4: SB5(SB3, phase=SysML)                     — validate SysML PSM; block on errors
Step 5: SB4(SB5)                                  — serialize to FHIR JSON only after SysML passes
Step 6: SB5(SB4, phase=FHIR)                      — validate FHIR JSON
```

---

## 6. PSM Output Structure

```
PSM_{ServiceName}/
├── SysML/
│   ├── ResourceModel.sysml          — FHIR resources as item def specializations
│   ├── ProfileDefinitions.sysml     — Constraints, extensions, must-support
│   ├── APIContracts.sysml           — REST interactions + $operations as action defs
│   ├── WorkflowPatterns.sysml       — Task/Subscription/Bundle flows
│   └── PSM_Traceability.sysml       — PIM→PSM traceability links
└── FHIR/
    ├── StructureDefinitions/         — Per-resource profile JSON
    ├── OperationDefinitions/         — Per-$operation JSON
    ├── SearchParameters/             — Per-parameter JSON
    ├── SubscriptionTopics/           — R5 subscription topic JSON
    └── CapabilityStatement.json      — Full service capability declaration
```

---

## 7. SysML v2 PSM Notation Conventions

FHIR-specific metadata applied via `metadata` annotations:

```sysml
package PSM_IdentificationService {
    import FHIR_R5_Base::*;

    item def FHIRPatient :> FHIRResource {
        doc /* Maps PIM::DataModel::Identity */
        attribute id : String;
        attribute identifier[0..*] : FHIRIdentifier;
        attribute active : Boolean;
        metadata fhirResource { value "Patient"; }
        metadata fhirProfile { value "http://hl7.org/fhir/StructureDefinition/Patient"; }
    }

    action def MatchPatient {
        doc /* Maps PIM::Operations::FindMatchingIdentities */
        in item parameters : MatchPatientParameters;
        out item result : Bundle;
        metadata fhirInteraction { value "$match"; }
        metadata fhirMethod { value "POST"; }
    }
}
```

**Traceability convention** (comment-based, matches existing PIM pattern):

```sysml
/* PSM → PIM Traceability Map
   PSM::ResourceModel::FHIRPatient      → PIM::DataModel::Identity (realizes)
   PSM::APIContracts::MatchPatient      → PIM::Operations::FindMatchingIdentities (realizes)
   PSM::WorkflowPatterns::CreatePatient → PIM::BehavioralFlows::CreateNewPatientFlow (realizes)
*/
```

---

## 8. Reference Library: FHIR_R5_Base.sysml

A lightweight stub package shipped with the pipeline (not fetched at runtime) declaring ~20 base FHIR R5 types:

```sysml
package FHIR_R5_Base {
    item def FHIRResource;
    item def FHIRElement;
    item def FHIRExtension;
    item def FHIRIdentifier;
    item def FHIRReference;
    item def FHIRCodeableConcept;
    item def FHIRPeriod;
    item def FHIRContactPoint;
    item def FHIRHumanName;
    item def FHIRAddress;
    item def Bundle;
    item def Task;
    item def Parameters;
    item def OperationOutcome;
    item def Subscription;
}
```

---

## 9. Error Handling and Correction Routing

| Error Source | Routed Back To | Max Correction Cycles |
|---|---|---|
| Resource mapping gap (no FHIR R5 resource fits) | SB1-D | 3 |
| Profile constraint violation | SB2-D | 3 |
| Unmapped PIM operation | SB1-B | 3 |
| CapabilityStatement inconsistency | SB2-B | 3 |
| Cross-track naming conflict | SB3 | 2 |
| Invalid FHIR R5 JSON | SB4 | 3 |

**Escalation**: If any ERROR persists after max cycles, orchestrator halts and produces a structured gap report for user review.

---

## 10. Conformance Validation Checks (SB5)

**SysML PSM layer:**
- Every PIM `item def` has at least one PSM mapping
- Every PSM `item def` carries `fhirResource` metadata
- Every PSM `action def` carries `fhirInteraction` metadata
- `PSM_Traceability.sysml` covers 100% of PSM elements
- MagicDraw 2026x compatibility rules from existing pipeline apply

**FHIR R5 layer:**
- All `StructureDefinition.baseDefinition` URLs are valid R5 canonical URLs
- All `CapabilityStatement.rest.resource` entries match a produced StructureDefinition
- All `$operation` parameters use valid FHIR R5 primitive or resource types
- No `SubscriptionTopic` references a resource absent from the CapabilityStatement

---

## 11. End-to-End Verification

Reference test: run the pipeline against the existing Identification Service PIM at  
`output/ServiceFunctionalModel_IdentificationService/PIM/`

Expected output: complete FHIR R5 PSM for the IS service including:
- Patient, Person, RelatedPerson, Identifier resource profiles
- `$match`, `$link`, `$unlink` OperationDefinitions
- CapabilityStatement covering both IdentificationManagement and Query interfaces
- SubscriptionTopics for identity event notifications
- Full `PSM_Traceability.sysml` covering all 15 PIM operations
