# SA1 Input Analyzer Memory

## Patterns Discovered

### HL7 SFM Structure Pattern
- HL7 SFMs follow: Introduction > Service Overview > Business Scenarios > Detailed Functional Model > Glossary
- Section 4 (Detailed Functional Model) is the normative core; Section 3 (Scenarios) is non-normative
- Operations defined in table format: Description, Precondition, Inputs, Outputs, Postconditions, Exceptions, Misc
- Meta-model classes defined via PlantUML class diagrams embedded in markdown

### Common Delegation Pattern
- HL7 SFMs heavily delegate to "Technical Specifications" -- security, error handling, data types, reason codes, profiles
- This creates systematic gaps that must be documented but NOT treated as specification defects

### Classification Decisions
- "Semantic Signifier" = DOMAIN_CONCEPT (not DATA_STRUCTURE) because it is a concept/mechanism, not a concrete structure
- Operation tables: split into OPERATION (the function) + DATA_STRUCTURE (inputs/outputs) + RULE (pre/post/exceptions)
- Scenarios = WORKFLOW, individual steps within = OPERATION
- "shall"/"must" language rare in HL7 SFMs; most requirements are implicit from operation definitions

### Common Gaps in HL7 SFMs
- No security model (explicitly excluded as orthogonal)
- No quantified non-functional requirements
- No state machines (only minimum state sets)
- No batch/bulk operations
- No concurrency model
- Metadata lifecycle operations missing (PolicyDomain, EntityType CRUD)

### Key Ambiguity Types
- Scope contradictions (e.g., "only demographic data" vs. "generic information structure")
- Required vs. optional parameter inconsistencies across operations
- Transitivity/closure semantics for links
- Match quality representation (simple vs. composite)

See also: `hl7-sfm-patterns.md` for detailed notes.
