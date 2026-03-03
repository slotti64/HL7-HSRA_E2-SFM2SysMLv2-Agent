# PIM Behavioral/Composition Architect Memory

## Key Project Paths
- Output: `output/ServiceFunctionalModel_IdentificationService/PIM/`
- CIM: `output/ServiceFunctionalModel_IdentificationService/CIM/`
- SysML examples: `SysMLv2Example/`
- SFM source: `input/IS_sfm.md`

## SysML v2 Syntax (verified against reference examples)
- See `sa5_pim_behavioral/MEMORY.md` for detailed syntax patterns
- State machines: `state def`, `transition first ... accept ... then ...`
- Actions: `action def`, `then` for sequential, `if/else` for branching
- Composition: `part def`, `port`, `~` for conjugation, `connection def`

## Conservatism Principle
- Only model flows with explicit multi-step evidence from SA1 WORKFLOW entries
- Single-operation scenarios do NOT get flow wrappers
- Never add error handling, retry, logging, or notification steps unless input says so
