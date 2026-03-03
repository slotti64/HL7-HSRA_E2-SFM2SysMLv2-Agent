# SA7 Notation Validator Memory

## Common SA4 Error: Missing `enum` keyword on enum members
- SA4 (DataModel generator) consistently omits the `enum` keyword prefix on enumeration members
- CIM-level enums (SA2) use correct `enum ACTIVE;` form but PIM-level enums omit it
- Pattern: `ACTIVE;` instead of `enum ACTIVE;`
- Always check PIM/DataModel.sysml enum defs first

## Common SA5 Error: Non-canonical initial transitions
- SA5 sometimes declares `state initial;` + `transition creation first initial then active;`
- Canonical SysML v2 pattern is `transition start then <target>;` (no named initial state needed)
- Reference: States.sysml:46 -- `transition start then off;`
- This was classified as WARNING (valid but non-idiomatic) in IS transformation

## Valid Patterns Confirmed
- `#derivation connection` with one `#original` + multiple `#derive` endpoints is VALID (ref: Requirements Derivation.sysml:55-60)
- `#derivation connection :> RequirementDerivation` specialization form is valid
- `interface : <InterfaceDef> connect <portA> to <portB>` is valid for connection instances
- `include use case <name>` usage form (not def) is correct for use case inclusions
- `requirement <'ID'> '<name>'` usage form (not def) is correct for requirements
- `in item` / `out item` inside port defs is valid
- `=` binding in action parameters (`in item request = Flow::param;`) is valid
- `private import X::*;` inside nested packages is valid SysML v2

## Reference File Index
- Actions: fork/join/decide/merge, ref first, ref succession flow, ref bind, perform, ::>
- Flows: port def with items, ref flow...from...to, ref bind, conjugation ~
- Interfaces: interface def with end keyword, port def with nested ports, interface...connect
- States: exhibit state, transition syntax, entry/exit/do actions, parallel states
- Requirements Derivation: #derivation connection, #original/#derive endpoints
- Use Case: include use case, subject, actor, objective, ::> specialization
- Individual: individual part def, timeslice, :>>, comment about
- Import: public/private import, ::*, ::** forms
