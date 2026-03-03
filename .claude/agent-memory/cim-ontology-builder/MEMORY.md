# CIM Ontology Builder Memory

## SysML v2 Syntax Patterns
- `item def` for domain entities, `attribute def` for value types, `enum def` for enumerations
- `part def :> BusinessStakeholder` for stakeholder roles in StakeholderModel
- `use case def` with `actor : StakeholderType` and `include use case SubCapability` for capabilities
- `constraint def` with optional `constraint { expr }` for formalizable rules, doc-only for non-formalizable
- `ref` for associations, nested `attribute` for composition; `[0..1]`, `[0..*]`, `[1..*]` for multiplicity
- Package structure: `package CIM_<SC> { package <PackageName> { ... } }`
- Cross-package references: `CIM_IS::StakeholderModel::PolicyDomainOwner`

## CIM Purity Violations to Watch
- "record" -> use "entry" or "instance"; "id" -> use "identifier" or domain-specific name
- "code" -> use "category" or "designation"; "timestamp" -> use date-related business term
- "schema" is acceptable when the domain specification explicitly uses it (e.g., IS SFM "Semantic Signifier = schema")
- "request" is acceptable for business-level subscription concepts (NotificationRequest)
- Always run forbidden-term grep after generation: database, API, server, JSON, HTTP, transaction, microservice, queue, cache, table, column, REST, SOAP, SQL, NoSQL, cloud, container, deploy, middleware, endpoint, payload

## Naming Conventions
- Type definitions (item/part/enum/use case/constraint def): PascalCase
- Attributes: camelCase
- Enum literals: UPPER_SNAKE_CASE
- Package names: PascalCase

## IS Service Domain Model
- See sa2_cim_ontology/MEMORY.md for IS-specific patterns
