# SA2 CIM Ontology Builder Memory

## Project Structure
- Output: `output/ServiceFunctionalModel_IdentificationService/CIM/`
- Four packages: BusinessDomain.sysml, StakeholderModel.sysml, BusinessCapabilities.sysml, BusinessRules.sysml
- Service code: IS, ServiceName: IdentificationService
- Top-level namespace: `CIM_IS` (each file wraps in `package CIM_IS { package <SubPkg> { ... } }`)

## SysML v2 Patterns for CIM
- `item def` for domain entities (EntityConcept, PolicyDomain, etc.)
- `attribute def` for value types (names, descriptions, designations)
- `enum def` for status categories; enum literals in UPPER_SNAKE_CASE
- `part def :> BusinessStakeholder` for stakeholder roles
- `use case` (usages, NOT `use case def`) with `subject`, `actor`, `objective`, `action`, `ref first...then...` for capabilities
- `constraint def` for business rules; `constraint {}` block for formalizable rules
- `ref` attributes for associations, nested attributes for composition
- Package nesting: `package CIM_IS { package BusinessDomain { ... } }`
- No `import` statements in nested packages -- use qualified names instead
- Do NOT reference standard library types like `Boolean` without import; use untyped attributes at CIM level

## CIM Purity
- Forbidden terms to check: database, API, server, JSON, HTTP, transaction, microservice, queue, cache, table, column, REST, SOAP, SQL, NoSQL, cloud, container, deploy, middleware, endpoint, payload
- Also avoid in ELEMENT NAMES: id, code, timestamp, key, index, record
- "schema" is acceptable in doc comments when referring to Semantic Signifier (domain concept in IS SFM)
- "request" is acceptable for NotificationRequest/subscription (business concept per SFM)

## IS Domain Specifics
- 6 core entities + 7 supporting: EntityConcept, PolicyDomain, EntityType, EntityTypeAssignment, IdentityInstance, IdentityLink, RealWorldEntity, UpdateQualifier, SearchQualifier, NotificationSubscription, ServiceMetadata, HospitalInformationSystem, MasterPatientIndex
- 5 enumerations: IdentityStatus, LinkTypeCategory, LinkMethodCategory, UpdateMode, MatchQualityTier
- 10 stakeholders: RegistrationClerk, ClinicalUser, LaboratoryClerk, IdentityResolutionClerk, ServiceAdministrator, ExternalSystem, PolicyDomainOwner, Patient, ReferralSystem, RegionalHealthNetwork
- 15 normative capabilities (9 management + 6 query), 14 business scenarios (11 single-domain + 3 multi-domain)
- 48 constraint defs covering preconditions, postconditions, invariants, and policies
- Total: 2123 lines across 4 files

## Lessons Learned
- SA7 previously found: `entry state` invalid in SysML v2 (use `state` + `transition start`), `then if/else` invalid (use `decide` nodes)
- Always check bracket balance after writing files
- Business scenarios modeled as `include use case` inside `part` containers
- Use `include use case` pattern inside `part identificationService` for normative capabilities
