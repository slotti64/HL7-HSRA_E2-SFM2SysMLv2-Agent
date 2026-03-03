# HL7 SFM Pattern Notes

## HL7 IS SFM Specific Patterns (2026-02-25)

### Document Structure
- Line 1-2: markitdown conversion warnings (ignore)
- Section 1 (Introduction): Service purpose, SOA positioning, abstraction principles
- Section 2 (Service Overview): Scope, structure, assumptions, meta-model, model notes
- Section 3 (Business Scenarios): Non-normative, PlantUML sequence diagrams with narrative
- Section 4 (Detailed Functional Model): Normative operation tables
- Section 5 (Glossary): Term definitions

### IS SFM Operation Table Pattern
Each operation defined with: Description, Precondition, Inputs, Outputs, Postconditions, Exception Conditions, Miscellaneous notes/aspects left to Technical Specification
- Preconditions often empty (means no precondition)
- Postconditions sometimes empty (ambiguity - flagged as GAP-015)
- Exception Conditions use bullet lists starting with special char (diamond)
- "Miscellaneous" section contains delegation notes and implementation guidance

### IS SFM Meta-model Classes (6 total)
1. PolicyDomain (id, name, description, versionId, status, forCrossReference, languageSupported, defaultLanguageId)
2. EntityConcept (id, name, description, versionId)
3. EntityType (id, name, description, status, versionId, schemaDefinition, validationRuleSet)
4. EntityTypeAssignment (id, status, versionId, constrainedSchemaDefinition, constrainedValidationRuleSet)
5. IdentityInstance (id, versionId, status, populatedSchemaValue)
6. IdentityLink (linkType, linkMethod, reason, provenanceInformation)

### IS SFM Operations (14 total)
Management (8): Register Identity, Create Identity, Update Identity Property Values, Update Identity State, Merge Identities, Unmerge Identities, Link Identities, Unlink Identity, Remove Identity Instance
Query (5): Get All Information for an Identity, Find Identities by Property, List Linked Identities, Request Identity Update Notifications, Update Identity Notification Request, Notify Identity Updates

### Classification Statistics (IS SFM)
- 222 total statements classified
- 74 rules (33%) - very rule-heavy specification
- 42 domain concepts, 30 operations, 30 data structures, 21 workflows
- 15 capabilities, 6 stakeholders, 4 functional requirements, 1 compliance requirement
- 0 quality requirements (typical for HL7 SFMs)
- 9 ambiguities, 17 gaps identified

### Stable Patterns Confirmed
- HL7 SFM delegation pattern: security, error handling, state models, data types, matching algorithms, metadata management all delegated to Technical Specifications
- IS/XIS duality: spec written from XIS superset perspective; IS constrains via profiles
- Semantic Signifier mechanism provides content-behavior separation
- Non-normative scenarios (Section 3) vs. normative contract (Section 4)
- PolicyDomain and EntityType IDs are conditionally optional based on IS scope
