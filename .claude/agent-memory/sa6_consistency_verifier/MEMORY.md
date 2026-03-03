# SA6 Consistency Verifier - Memory

## Verification Patterns

### Common WARNING Patterns (IS Model, 2026-02-25)
- **CC-02**: Non-normative business scenario use cases (14 in IS model) lack direct requirement links. By design per ST-202.
- **CC-03**: ~50% of business rules unrefined. Exception-list rules covered generically by FR-038. Guidance/meta-rules intentionally not linked.
- **CC-05**: PIM_Traceability self-referential dependency pattern (`from X to X` with doc annotation). SA5 recurring issue.
- **SC-06**: ~85% of CIM business rules documentary only. Only rules with navigable attribute paths get formalized. Acceptable at CIM level.
- **SC-08**: Cross-cutting FR requirements (architectural, governance, exception handling) don't map to dedicated PIM operations.

### Common ERROR Patterns (IS Model, 2026-02-25)
- **CC-10**: SA3 puts regulatorySource in doc annotations as free text, not as formal attribute. All CR requirements affected.
- **SC-09**: SA3 uses `private import` in nested CIM_Traceability package. Must use qualified names instead.

### Model Structure (HL7 IS, 2026-02-25)
- CIM: 177 elements (14 item defs, 14 attr defs, 5 enum defs, 9 part defs, 29 use cases, 42 constraint defs, 62 requirements, 77 derivation connections)
- PIM: 170 elements (45 item defs, 7 enum defs, 2 port defs, 2 interface defs, 32 flows, 15 action defs, 6 flow action defs, 5 part defs, 1 state def, 71 dependencies)
- 15 normative use cases -> 15 PIM operations (1:1), 14 non-normative scenarios
- 62 requirements: FR=41, QR=11, CR=10
- 225 traceability links total

### SysML v2 Notation (confirmed patterns)
- `include use case` = correct usage syntax (not `use case def`)
- `requirement <'XX-NNN'>` = correct usage syntax (not `requirement def`)
- `interface :` with `connect` = correct for composition connections (not `connection`)
- `.` for feature access, `::` for namespace paths
- `ref first X then Y` = succession (OK in CIM use cases, not conditional)
- `decide` + `merge` + `first X if "guard" then Y` = PIM-only behavioral constructs
- PIM enums: bare literals (`ACTIVE;`); CIM enums: `enum ACTIVE;` -- both valid

### Verification Process
- 35 checks: CC (10), NC (5), SC (13), DC (7) -- includes new SC-09 through SC-13
- Always read ALL 14 model files before starting verification
- Check exhaustively - list every element, never sample
- SA2=CIM ontology, SA3=CIM reqs/traceability, SA4=PIM data/ops, SA5=PIM behavior/comp
