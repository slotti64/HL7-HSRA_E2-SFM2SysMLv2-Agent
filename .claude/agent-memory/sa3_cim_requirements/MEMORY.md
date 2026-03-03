# SA3 CIM Requirements Engineer - Agent Memory

## Project Structure
- Input SFM: `input/IS_sfm.md`
- SA1 output: `output/ServiceFunctionalModel_IdentificationService/SA1_Classification.md`
- SA2 CIM packages: `output/ServiceFunctionalModel_IdentificationService/CIM/`
- SA3 output: `CIM/CIM_Requirements/` and `CIM/CIM_Traceability.sysml`
- SysML v2 examples: `SysMLv2Example/`

## IS Transformation (2026-02-25) - Completed
- 62 requirements total: 41 FR + 11 QR + 10 CR
- 97 #derivation connections in CIM_Traceability
- 5 expected orphan requirements (governance/meta-requirements)
- 20 unrefined rules (11 exception-list rules covered by FR-038 + 9 guidance/meta-rules)
- 0 unjustified normative capabilities

## Patterns Discovered

### Requirement Derivation from SFM
- SA1 classifies very few direct REQUIREMENT_* statements (4 functional, 0 quality, 1 compliance for IS)
- Most functional requirements must be derived from OPERATION, CAPABILITY, and RULE classifications
- Each OPERATION typically yields 1-3 functional requirements (the operation itself + key constraints)
- RULE statements split into: preconditions (refine FR), postconditions (refine FR), invariants (refine QR/FR)
- Exception-list rules (one per operation) are best covered by a single cross-cutting FR (FR-038)

### Gap-to-Requirement Mapping (IS-specific)
- GAP-001 (security) -> CR-002, CR-003 (compliance) -- security is always compliance
- GAP-002 (NFR quantification) -> QR-001 through QR-006 expressed qualitatively
- GAP-003 (error handling) -> FR-038 placeholder (functional)
- GAP-005 (batch/bulk) -> QR-004 (scalability)
- GAP-006 (concurrency) -> QR-005 (reliability)
- GAP-007 (data retention) -> CR-006, FR-039 -- retention spans compliance + functional
- GAP-008 (metadata lifecycle) -> FR-040 placeholder (functional, orphaned)
- GAP-009 (notification delivery) -> QR-006 (reliability)
- GAP-011 (conformance) -> CR-008 placeholder (compliance)
- GAP-014 (versioning) -> QR-008 (data integrity)
- GAP-016 (i18n) -> QR-009 placeholder (usability)
- GAP-017 (match algorithm) -> QR-007 (accuracy)

### SysML v2 Syntax Conventions (UPDATED)
- Use `requirement <'ID'> 'name' { doc /* ... */ }` (usages with angle-bracket short-name IDs)
- NOT `requirement def` -- use usages per Requirements Derivation.sysml example
- Regulatory sources go in doc annotations, not as separate attributes
- `#derivation connection :> RequirementDerivation { end #original requirement ::> ...; end #derive requirement ::> ...; }`
- Qualified names for cross-package refs: `BusinessCapabilities::identificationService::registerIdentity`
- `private import RequirementDerivation::*;` at the traceability package level only
- No imports needed in nested requirement packages (they don't cross-reference)

### Traceability Patterns
- Quality requirements link to the broadest applicable use case
- Compliance requirements link to the specific operations they constrain
- Cross-cutting requirements (security, availability) link to registerIdentity as representative
- Non-normative business scenarios (Section 3) are NOT linked to requirements (per ST-202)
- Exception-list rules covered generically by a single FR rather than one-to-one

### IS-Specific Stakeholder Roles (from SA2)
- Service Consumer: primary actor for most operations (used in requirement text)
- Identity Resolution Clerk: merge, link, unlink, unmerge (sensitive ops)
- Service Administrator: state changes, removal, inactive identity access
- Registration Clerk: registration, search, demographic updates
- PolicyDomainOwner: governance requirements
- Patient: beneficiary, not direct actor
