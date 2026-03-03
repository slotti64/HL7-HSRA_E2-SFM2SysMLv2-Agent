# SA5 PIM Behavioral/Composition Architect Memory

## SysML v2 Syntax Patterns (from reference examples)

### Action Flows (CONFIRMED from Actions.sysml reference)
- Sequential: `ref first X then Y;` (with `ref` prefix for non-guard successions)
- Guard successions from decide nodes: `first decideNode if "guard" then target;` (NO `ref` prefix)
- Parallel: sibling `action` without `then`
- Parameter wiring: `in item request = FlowName::paramName;` (use `::` for enclosing action)
- Sub-action typing: `action stepName : Operations::OperationName { ... }`
- Decide/merge for branching: `decide nodeName;` and `merge nodeName;`

### State Machines (CORRECTED by SA7)
- Use `state def` for definitions, `exhibit state` for usage on parts
- Transitions: `transition <name> first <source> then <target>;` (single-line)
- Initial state: use `state initial;` + `transition creation first initial then active;`
- DO NOT use `entry state` (invalid in SysML v2)
- DO NOT use `then if/else` branching in transitions (use `decide` in actions instead)

### Composition
- Provider ports: `port endpointName : ServiceContracts::PortDef;`
- Consumer (conjugated) ports: `port accessName : ~ServiceContracts::PortDef;`
- Connection usage: `interface : ServiceContracts::InterfaceDef connect partA.portA to partB.portB;`
- DO NOT use `connection` keyword for interface connections (use `interface` keyword)

### Naming Conventions
- `.` for feature access on parts/usages: `provider.managementEndpoint`
- `::` for namespace paths only: `DataModel::PolicyDomain`, `Operations::RegisterIdentity`
- No imports in nested packages -- always use qualified names

## HL7 IS Service Patterns

### Port Definitions (SA4)
- `IdentificationManagementPort` (9 mutation ops)
- `QueryPort` (6 query/notification ops)
- `IdentificationManagementAPI` (interface def with requester/provider ends)
- `QueryAPI` (interface def with requester/provider ends)

### Behavioral Flows Created (6 total)
1. CreateNewPatientFlow [ST-048]: search -> broader search -> register
2. LinkOrMergeEntitiesFlow [ST-052]: search -> decide(link|merge)
3. UpdateDemographicsFlow [ST-056]: search -> retrieve -> update
4. UnlinkEntityFlow [ST-064]: search -> list links -> unlink
5. UnattendedEncounterFlow [ST-187]: search -> decide(3 outcomes)
6. CrossRegionLinkFlow [ST-200]: search -> register local -> link cross-domain

### Workflows NOT Modeled (conservatism)
- Single-op: Inactivate [ST-059], Activate [ST-062], Remove [ST-192]
- Single-op: Lookup single [ST-181], Merged entries [ST-185]
- Iterated same-op: Lookup multiple [ST-183]
- Infrastructure routing: Cross-region lookup [ST-196, ST-198]

### Consumer Categories (from SFM)
- ClinicalSystemConsumer (HIS, operated by clerks/nurses/admins)
- ReferralSystemConsumer (unattended system-to-system)
- FederatedISConsumer (RHIO/XIS intermediary)

### Identity State Model
- States: initial, active, inactive, deprecated
- Transitions: creation, inactivation, reactivation, mergeDeprecation, unmergeReinstatement

## Traceability Mapping Convention
- Operations -> CIM Use Cases (1:1, all 15)
- Domain items -> CIM BusinessDomain items (direct derivation)
- Request/Response items -> CIM Use Case I/O they serve
- PIM-derived types (MatchResult, ServiceFault) -> CIM supporting use case
- Enums -> CIM enums or supporting concepts
- Flows -> CIM business scenarios they orchestrate
- Ports/Interfaces -> CIM capability groups + actor roles
- Composition parts -> CIM stakeholders
- State model -> CIM IdentityStatus + BusinessRules
- Cross-model traceability uses structured doc comments (NOT formal dependency)
- Self-referential `dependency from X to X` with doc comment is the pattern

## SA7 Known Issues (from previous pipeline run)
- `entry state` is invalid -- use `state` + `transition`
- `then if/else` is invalid in action flows -- use `decide`/`merge` nodes
- Self-typed interface endpoints are invalid -- type to port defs
