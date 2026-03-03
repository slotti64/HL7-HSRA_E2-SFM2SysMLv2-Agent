# Input Analyzer Memory

## Project Context
- Pipeline: SFM -> SysML v2 transformation (CIM + PIM levels)
- Input specs in `input/` directory as markdown
- Output to `output/ServiceFunctionalModel_{ServiceName}/`
- SA1 output filename: `SA1_Classification.md`

## Classification Approach
- 264 statements classified for HL7 IS SFM
- Categories used: DOMAIN_CONCEPT(62), RULE(92), CAPABILITY(17), OPERATION(24), DATA_STRUCTURE(35), WORKFLOW(15), STAKEHOLDER(16), REQ_FUNCTIONAL(4), REQ_QUALITY(10), REQ_COMPLIANCE(1)
- RULE is the dominant category in HL7 SFMs due to many preconditions, postconditions, exceptions, and design constraints
- Inferred 10 stakeholders beyond those explicitly named

## Key Decisions
- Scenario steps classified as OPERATION cross-referenced to formal operations in Section 4
- Meta-model relationships classified as DATA_STRUCTURE
- Glossary terms classified as DOMAIN_CONCEPT
- Compound statements split per inference rules (capability + requirement)
