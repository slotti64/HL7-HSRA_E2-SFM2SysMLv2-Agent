# SA4 PIM Data & Operations Architect - Memory

## Project: HL7 HSRA E2 SFM-to-SysMLv2 Pipeline

### Key Decisions and Patterns

1. **CIM attribute defs -> PIM typed attributes**: CIM uses narrative `attribute def` types (e.g., `EntityConceptName`, `DomainName`). At PIM level, these map to `String` typed attributes since the CIM defs are descriptive wrappers around text values.

2. **CIM item def -> PIM item def (not part def)**: The system prompt says `item def` for PIM types. Used `item def` consistently.

3. **Technical ID naming**: `<conceptName>Id` in camelCase. E.g., `entityConceptId`, `policyDomainId`, `identityInstanceId`.

4. **Service boundary grouping**: IS SFM Section 2.3.1 explicitly defines two interfaces: IdentificationManagement (9 mutation ops) and Query (6 read/notification ops). Notifications are grouped under Query per the SFM classification.

5. **All 15 use cases map 1:1 to operations**: No decomposition or aggregation needed. Supporting use cases (ValidateIdentifyingProperties, DetectPotentialMatches, ValidateMergeEligibility) are internal behavior, not exposed PIM operations.

6. **SysML v2 interface patterns**: Use `end requester : ~PortDef; end provider : PortDef;` pattern with `ref flow name of Type from X.member to Y.member;` for message flows. Every interface must include `flow of ServiceFault`.

7. **Request/Response naming**: `<OperationName>Request` and `<OperationName>Response`. All in DataModel package.

8. **PIM-derived enums**: Added `NotificationEventCategory` from CIM narrative concepts that needed typed representation.

9. **MatchResult and IdentityNotification**: PIM-derived item defs that wrap search results and notification payloads respectively.

10. **No import statements in nested packages**: Use qualified names like `PIM_IS::DataModel::TypeName` instead of `private import` statements. This avoids SA7 validation errors.

11. **No assert constraint**: Use doc annotations for pre/postconditions instead of `assert constraint` blocks. SA7 previously flagged `assert constraint` as invalid in action def contexts.

12. **Port defs need typed items**: `out item name : Type;` and `in item name : Type;` inside port def blocks. Each operation gets a request (out) and response (in) item.

13. **Interface flows are named**: `ref flow registerIdentityRequestFlow of Type from src.member to tgt.member;` -- naming helps traceability.

### Output File Locations
- DataModel.sysml: `output/ServiceFunctionalModel_IdentificationService/PIM/DataModel.sysml` (584 lines)
- ServiceContracts.sysml: `output/ServiceFunctionalModel_IdentificationService/PIM/ServiceContracts.sysml` (320 lines)
- Operations.sysml: `output/ServiceFunctionalModel_IdentificationService/PIM/Operations.sysml` (459 lines)

### SysML v2 Syntax Notes (from reference examples and SA7 corrections)
- `port def X { out item ...; in item ...; }` for port definitions
- Actions use `in item`/`out item` parameters, doc annotations for pre/postconditions
- `ref flow name of Type from source.member to target.member;` inside interface defs
- `doc /* ... */` for documentation annotations
- No `private import` in nested packages -- use fully qualified names
- No `assert constraint` in action defs -- use doc annotations
- `entry state` is invalid -- use `state` + `transition start`
- `then if/else` is invalid -- use `decide` nodes
- Self-typed interface endpoints are invalid -- type to port defs

### Common SA6 Corrections to Watch For
- Missing traceability doc annotations
- Missing ServiceFault flows in interfaces
- Missing Request/Response pairs for operations
- Duplicate type names across packages

### PIM Element Counts (IS Service)
- Domain entity types: 13 (11 from CIM + 2 PIM-derived: MatchResult, IdentityNotification)
- Enumerations: 7 (6 from CIM + 1 PIM-derived: NotificationEventCategory)
- Request/Response pairs: 15 (one per operation)
- Operations: 15 (9 management + 6 query)
- Interfaces: 2 (IdentificationManagementAPI, QueryAPI)
- Port defs: 2 (IdentificationManagementPort, QueryPort)
- Standard types: 2 (ServiceFault, FaultCategory)
