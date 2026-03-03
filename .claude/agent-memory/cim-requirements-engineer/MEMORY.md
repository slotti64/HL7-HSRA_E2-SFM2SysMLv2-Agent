# CIM Requirements Engineer - Agent Memory

## Project: HL7 HSRA E2 SFM-to-SysMLv2 Transformation Pipeline
- Repository: `c:\Users\slotti\Documents\HL7-HSRA_E2-SFM2SysMLv2-Agent`
- See `sa3_cim_requirements/MEMORY.md` for detailed patterns

## Key Conventions
- Service code for Identification Service: IS
- Package prefix: CIM_IS
- FR/QR/CR numbering: sequential, gaps allowed
- All requirement doc text: active voice, "shall" for mandatory, "should" for desirable
- Subject always: "The system" or named stakeholder role
- Placeholder requirements from gaps: marked with `/* PLACEHOLDER -- from GAP-NNN */`
- Ambiguity resolutions documented in CIM_Traceability as comments

## Common Ambiguity Resolution Patterns
- Unquantified quality attributes -> express qualitatively at CIM, flag for PIM decomposition
- Unspecified data types -> model as abstract, defer to PIM
- Optional vs. required discrepancies -> adopt conservative (required) interpretation, flag for stakeholder
- Implementation details mentioned in SFM -> exclude at CIM, note for PIM
