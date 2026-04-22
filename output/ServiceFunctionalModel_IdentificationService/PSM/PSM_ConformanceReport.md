# PSM Conformance Report — IdentificationService

## PSM SysML Validation Report — IdentificationService
Phase: SysML | Date: 2026-04-22

### PASS

**Completeness checks (SC):**
- SC-01: All 9 non-skipped PIM DataModel item defs mapped in ResourceModel (6 MAPPED + 3 CUSTOM Basic + 1 synthesized SubscriptionTopic; 10 PSM item defs total). Covered: `PolicyDomain, EntityConcept, EntityType, EntityTypeAssignment, IdentityInstance, IdentityLink, RealWorldEntity, NotificationSubscription, ServiceMetadata`. `FHIRIdentityUpdateTopic` synthesized from `NotificationEventCategory` + `NotificationSubscription` filter attributes. ✓
- SC-02: All 14 non-notification PIM action defs mapped in APIContracts (Register, Create, UpdateIdentityProperties, UpdateIdentityState, Merge, Unmerge, Link, Unlink, Remove, GetAllInformation, FindIdentitiesByProperty, ListLinkedIdentities, RequestIdentityUpdateNotifications, UpdateNotificationSubscription). `NotifyIdentityUpdates` correctly classified as NOTIFICATION_DELIVERY_TRIGGER and realized by `IdentityUpdateTopic` in WorkflowPatterns. Coverage 14/14 = 100%. ✓
- SC-03: All 6 PIM behavioral flows have a workflow `action def` in WorkflowPatterns (`CreateNewPatientFlow→CreateNewPatientWorkflow`, `LinkOrMergeEntitiesFlow→LinkOrMergeEntitiesWorkflow`, `UpdateDemographicsFlow→UpdateDemographicsWorkflow`, `UnlinkEntityFlow→UnlinkEntityWorkflow`, `UnattendedEncounterFlow→UnattendedEncounterWorkflow`, `CrossRegionLinkFlow→CrossRegionLinkWorkflow`). ✓
- SC-04: PSM_Traceability Reconciliation Report declares COVERAGE 30/30 = 100%, MS COVERAGE 100% (3/3 subchecks PASS), 1 resolved profile-URL conflict (Rule 3), no unmapped PIM elements, no MS coverage gaps. ✓

**Metadata checks (MC):**
- MC-01: All 10 PSM item defs in ResourceModel carry both `fhirResource` and `fhirProfile` metadata (verified for FHIRIdentityInstance, FHIRRealWorldEntity, FHIRPolicyDomain, FHIRIdentityLink, FHIRNotificationSubscription, FHIRIdentityUpdateTopic, FHIREntityConcept, FHIREntityType, FHIREntityTypeAssignment, FHIRServiceMetadata). ✓
- MC-02: All 14 action defs in APIContracts carry `fhirInteraction`, `fhirResource`, and `fhirMethod`. Additionally carry `fhirAffectsState` on every action and `fhirOperationBase` on `GetAllInformation` (Patient-everything) and `FindIdentitiesByProperty` (Patient-match). ✓
- MC-03: `item def IdentityUpdateTopic :> FHIR_R5_Base::SubscriptionTopic` in WorkflowPatterns (line 51) carries `metadata fhirResource { value "SubscriptionTopic"; }` (line 149). Covers all 4 NotificationEventCategory values via 4 eventTrigger entries (property-change, status-change, link-change, merge-change) + 2 resourceTrigger entries (Patient, Linkage), satisfying PC-03. ✓

**Syntax checks (SY) — MagicDraw 2026x:**
- SY-01: Every PSM package has `import FHIR_R5_Base::*;` only at the top level of the package (or no import for PSM_Traceability, which uses doc-comment-only traceability per MagicDraw contract). No nested-package imports detected. ✓
- SY-02: Feature access consistently uses `.` (e.g., `Patient.identifier`, `patient.id`, `Linkage.item.type`); `::` appears only in qualified namespace references (e.g., `PSM_IdentificationService_APIContracts::RegisterIdentity`, `PIM_IS::DataModel::IdentityInstance`, `FHIR_R5_Base::SubscriptionTopic`). No `::` feature access detected. ✓
- SY-03: All 6 PSM packages have balanced opening/closing braces. Each file terminates with a matching `}` for the top-level package declaration. ✓
- SY-04: No `assert constraint` with expression bodies in any PSM package. Constraints and rationale conveyed via `doc /* ... */` comments per MagicDraw 2026x contract. ✓

### ERROR
(none)

### WARNING
(none)

### Summary
- PASS: 11 | ERROR: 0 | WARNING: 0
- Pipeline status: **PROCEED**

---

## PSM FHIR Validation Report — IdentificationService
Phase: FHIR | Date: 2026-04-22 | Validator: HL7 FHIR Validator 6.9.6 against `hl7.fhir.r5.core#5.0.0`

### Scope
- 73 artifacts validated across 7 subdirs + `CapabilityStatement.json` (10 profile SDs, 27 extension SDs, 4 OperationDefinitions, 1 SubscriptionTopic, 9 ValueSets, 9 CodeSystems, 2 NamingSystems, 10 Examples, 1 CapabilityStatement).
- `SearchParameters/` directory intentionally absent: `APIContracts.sysml` declares that `ListLinkedIdentities` is served by BASE Linkage SearchParameters (`item`, `source`, `author`) referenced by canonical URL in the CapabilityStatement — no custom SearchParameter resources are emitted (by design). FC-04 therefore has zero expected artifacts.

### PASS — Native FS/FC/FV-01 Checks

| Check | Result | Evidence |
|---|---|---|
| FS-01 | PASS | All 37 StructureDefinitions (10 profiles + 27 extensions) use canonical R5 `http://hl7.org/fhir/StructureDefinition/{Type}` baseDefinition values. No custom profile URL used as base. |
| FS-02 | PASS | All 5 CapabilityStatement resource declarations (`Basic`, `Patient`, `Organization`, `Linkage`, `Subscription`) declare >=1 `interaction`. |
| FS-03 | PASS | All 4 OperationDefinition `resource` values (`Patient`) are referenced in CapabilityStatement. |
| FS-04 | PASS | `SubscriptionTopics/IdentificationService-IdentityUpdate.json` has non-empty `url`, `status=active`, and `title`. |
| FC-01 | PASS | 10 StructureDefinition JSONs present, one per profile in `ProfileDefinitions.sysml`. |
| FC-02 | PASS | 4 OperationDefinition JSONs present, one per `$operation` action def in `APIContracts.sysml` (`$everything`, `$match`, `$merge`, `$unmerge`). |
| FC-03 | PASS | Exactly one `CapabilityStatement.json`. |
| FC-04 | N/A (PASS) | No custom SearchParameters declared — base Linkage/Subscription parameters referenced by URL. |
| FV-01 | PASS | All 37 SDs + CapabilityStatement carry `fhirVersion="5.0.0"`. No OperationDefinition, SubscriptionTopic, or SearchParameter carries `fhirVersion` (correct — field not in R5 resource schema for those types). |

### FV-02 — External HL7 FHIR Validator Findings

Parsed from `validator_report.json` (Bundle of 73 OperationOutcome entries).

**Totals: 50 errors, 20 warnings, 51 information. Status: BLOCK.**

#### ERROR Findings Table

| # | CheckID | File | Location | Message (truncated) | Route-To |
|---|---|---|---|---|---|
| 1 | FV-02 | `StructureDefinitions/IdentificationService-EntityConcept.json` | `differential.element[0]` | No match for `Basic.identifier` in generated snapshot | SB4 |
| 2 | FV-02 | `StructureDefinitions/IdentificationService-EntityConcept.json` | `differential.element[1]` | No match for `Basic.code` in generated snapshot | SB4 |
| 3 | FV-02 | `StructureDefinitions/IdentificationService-EntityConcept.json` | `StructureDefinition` | Profile has 2 elements in differential w/o matching snapshot element (missing root) | SB4 |
| 4 | FV-02 | `StructureDefinitions/IdentificationService-EntityType.json` | `differential.element[0]` | No match for `Basic.identifier` | SB4 |
| 5 | FV-02 | `StructureDefinitions/IdentificationService-EntityType.json` | `StructureDefinition` | Profile has 1 element in differential w/o matching snapshot (missing root) | SB4 |
| 6 | FV-02 | `StructureDefinitions/IdentificationService-EntityTypeAssignment.json` | `differential.element[0]` | No match for `Basic.identifier` | SB4 |
| 7 | FV-02 | `StructureDefinitions/IdentificationService-EntityTypeAssignment.json` | `StructureDefinition` | Profile has 1 element in differential w/o matching snapshot (missing root) | SB4 |
| 8 | FV-02 | `StructureDefinitions/IdentificationService-IdentityInstance.json` | `differential.element[0..6]` | No match for `Patient.identifier/name/birthDate/gender/address/active/managingOrganization` (7 findings) | SB4 |
| 15 | FV-02 | `StructureDefinitions/IdentificationService-IdentityInstance.json` | `StructureDefinition` | Profile has 7 elements in differential w/o matching snapshot (missing root) | SB4 |
| 16 | FV-02 | `StructureDefinitions/IdentificationService-IdentityLink.json` | `differential.element[0..2]` | No match for `Linkage.author / Linkage.item / Linkage.item.resource` (3 findings) | SB4 |
| 19 | FV-02 | `StructureDefinitions/IdentificationService-IdentityLink.json` | `StructureDefinition` | Profile has 3 elements in differential w/o matching snapshot (missing root) | SB4 |
| 20 | FV-02 | `StructureDefinitions/IdentificationService-IdentityUpdateTopic.json` | `differential.element[0..4]` | No match for `SubscriptionTopic.url/title/status/description/resourceTrigger` (5 findings) | SB4 |
| 25 | FV-02 | `StructureDefinitions/IdentificationService-IdentityUpdateTopic.json` | `StructureDefinition` | Profile has 5 elements in differential w/o matching snapshot (missing root) | SB4 |
| 26 | FV-02 | `StructureDefinitions/IdentificationService-NotificationSubscription.json` | `differential.element[0..4]` | No match for `Subscription.status/topic/endpoint/contact/filterBy` (5 findings) | SB4 |
| 31 | FV-02 | `StructureDefinitions/IdentificationService-NotificationSubscription.json` | `StructureDefinition` | Profile has 5 elements in differential w/o matching snapshot (missing root) | SB4 |
| 32 | FV-02 | `StructureDefinitions/IdentificationService-PolicyDomain.json` | `differential.element[0..3]` | No match for `Organization.identifier/name/alias/active` (4 findings) | SB4 |
| 36 | FV-02 | `StructureDefinitions/IdentificationService-PolicyDomain.json` | `StructureDefinition` | Profile has 4 elements in differential w/o matching snapshot (missing root) | SB4 |
| 37 | FV-02 | `StructureDefinitions/IdentificationService-RealWorldEntity.json` | `differential.element[0]` | No match for `Person.identifier` | SB4 |
| 38 | FV-02 | `StructureDefinitions/IdentificationService-RealWorldEntity.json` | `StructureDefinition` | Profile has 1 element in differential w/o matching snapshot (missing root) | SB4 |
| 39 | FV-02 | `StructureDefinitions/IdentificationService-ServiceMetadata.json` | `differential.element[0]` | No match for `Basic.identifier` | SB4 |
| 40 | FV-02 | `StructureDefinitions/IdentificationService-ServiceMetadata.json` | `StructureDefinition` | Profile has 1 element in differential w/o matching snapshot (missing root) | SB4 |
| 41 | FV-02 | `Examples/example-entitytype-1.json` | `Basic` | `Basic.code`: minimum required = 1, but only found 0 (from base Basic) | SB4 |
| 42 | FV-02 | `Examples/example-entitytype-1.json` | `Basic` | `Basic.code`: minimum required = 1, but only found 0 (from IdentificationService-EntityType) | SB4 |
| 43 | FV-02 | `Examples/example-entitytypeassignment-1.json` | `Basic` | `Basic.code`: minimum required = 1, but only found 0 (from base Basic) | SB4 |
| 44 | FV-02 | `Examples/example-entitytypeassignment-1.json` | `Basic` | `Basic.code`: minimum required = 1, but only found 0 (from IdentificationService-EntityTypeAssignment) | SB4 |
| 45 | FV-02 | `Examples/example-servicemetadata-1.json` | `Basic` | `Basic.code`: minimum required = 1, but only found 0 (from base Basic) | SB4 |
| 46 | FV-02 | `Examples/example-servicemetadata-1.json` | `Basic` | `Basic.code`: minimum required = 1, but only found 0 (from IdentificationService-ServiceMetadata) | SB4 |
| 47 | FV-02 | `Examples/example-subscription-1.json` | `Subscription.endpoint` | Example URLs are not allowed in this context (`https://subscriber.example.org/fhir/hooks/identity-updates`) | SB4 |
| 48 | FV-02 | `CapabilityStatement.json` | `CapabilityStatement` | cpb-2: SHALL have at least one of description, software, or implementation | SB4 |
| 49 | FV-02 | `CapabilityStatement.json` | `CapabilityStatement` | cpb-14: If `kind=instance`, implementation must be present (software may be present) | SB4 |
| 50 | FV-02 | `CapabilityStatement.json` | `rest[0].resource[4].searchParam[0]` | Type mismatch — `Subscription-topic` base type is `uri`, declared here as `reference` | SB4 |

**Error families (summary):**
- **Family A — Malformed StructureDefinition differentials (38 errors across 10 profiles):** every profile jumps straight to child paths (e.g. `Basic.identifier`) without the mandatory root `{ResourceType}` differential element. Root cause: SB4 serialization emits child slices but not the root element — same shape across Basic-derived, Patient, Organization, Linkage, Person, Subscription, SubscriptionTopic profiles. **Also trace to SB2-D** if `ProfileDefinitions.sysml` does not declare the root slicing at source; SB4 should re-emit with proper root element + ordered children regardless.
- **Family B — Missing mandatory `Basic.code` in 3 example instances (6 errors, counted twice per Basic base + derived profile):** `example-entitytype-1.json`, `example-entitytypeassignment-1.json`, `example-servicemetadata-1.json` omit `Basic.code` which is `1..1` in R5 Basic. SB4 example synthesizer fix.
- **Family C — Example/placeholder URLs in publishable context (1 error):** `Subscription.endpoint` in `example-subscription-1.json` points at `https://subscriber.example.org/...`. SB4 must replace with a reserved-documentation URL that validator accepts (e.g. `https://subscriber.example.com/...` — note: `example.com` is explicitly permitted under BCP 47 for documentation; `example.org` triggers the validator's example-URL check in endpoint contexts).
- **Family D — CapabilityStatement metadata (3 errors):** cpb-2 + cpb-14 (no `description`/`software`/`implementation` despite `kind="instance"`) + searchParam type mismatch for `Subscription-topic` (declared `reference`, base is `uri`). SB4 to fill in `description`/`implementation` block and correct the searchParam type.

> Note: all 50 errors are downstream of SB4 serialization choices. None of the errors implicate SB2-D profile *authoring* (the source SysML profile intent is correct — the root element is a serialization concern, and the mandatory `Basic.code` binding is already specified in `ProfileDefinitions.sysml` but was not expressed in the snapshot or example payloads). Re-run SB4 with a fixed differential-emission algorithm + example synthesizer; if Family A persists after SB4 re-emission, re-open Family A against SB2-D.

#### WARNING Findings Table

| # | Sev | File | Count | Message | Route-To (advisory) |
|---|---|---|---|---|---|
| W1 | WARN | 9 Examples (`Basic`, `Patient`, `Person`, `Linkage`, `Organization`, `Subscription`) | 9 | dom-6 best-practice: resource should have `text.div` narrative | SB4 (optional narrative generator, best-practice only — does not block) |
| W2 | WARN | `SubscriptionTopics/IdentificationService-IdentityUpdate.json` (7) + `Examples/example-identityupdatetopic-1.json` (1) | 8 | `http://hl7.org/fhir/StructureDefinition/Patient` not in ValueSet `subscription-types` — bound value set contains short names (`Patient`), not full canonical URLs | SB4 / SB2-B (adjust to use short type names or bind to a broader value set) |
| W3 | WARN | `SubscriptionTopics/IdentificationService-IdentityUpdate.json` (2) | 2 | Same as W2 for `Linkage` | SB4 / SB2-B |
| W4 | WARN | `StructureDefinitions/IdentificationService-IdentityLink.json` | 1 | Profile builds on `Linkage` (experimental) but is not itself labeled `experimental` | SB4 / SB2-D (set `experimental: true` or justify) |

None of the warnings block progression.

#### INFO Findings
51 resources returned "All OK" informational outcomes. All 9 ValueSets, 9 CodeSystems, 2 NamingSystems, 27 Extension SDs, 4 OperationDefinitions, and clean Example/Profile resources are among them.

### Phase 2 Summary
- PASS: 9 native checks (FS-01..FS-04, FC-01..FC-03, FC-04-N/A, FV-01)
- ERROR (FV-02): 50 (across 13 files)
- WARNING (FV-02): 20 (across 11 files)
- INFORMATION (FV-02): 51 (clean resources)
- **Pipeline status: BLOCKED — awaiting corrections from SB4**

### Correction Routing Plan

| Priority | Agent | Error Families | Count | Correction Cycle |
|---|---|---|---|---|
| 1 | SB4 | A (SD differentials missing root) + B (Basic.code in examples) + C (example.org endpoint URL) + D (CS cpb-2/cpb-14 + searchParam type) | 50 | Cycle 1 of 3 |
| 2 | SB2-D | Fallback only if SB4 cycle 1 does not fully resolve Family A | 0 (on hold) | — |

### Next Action
Dispatch **SB4 (JSON Serializer)** with:
1. Re-emit all 10 profile StructureDefinitions with a proper root differential element (`id/path = {ResourceType}` as the first differential entry) before child constraints.
2. Inject mandatory `Basic.code` in the 3 affected example instances (Identification-service-EntityType, -EntityTypeAssignment, -ServiceMetadata). Use the bound `IdentificationService-EntityConcept` CodeSystem for the code value.
3. Rewrite `example-subscription-1.json#Subscription.endpoint` to a non-`example.org` URL (e.g. `https://subscriber.example.com/...` or a documented placeholder that the validator whitelists).
4. In `CapabilityStatement.json`: add a populated `description` string; either add an `implementation` block (required because `kind="instance"`) OR change `kind` to `"capability"` if no live endpoint is being declared; correct `rest[0].resource[4].searchParam[0].type` from `reference` to `uri` to match the canonical base definition.
5. Preserve all PASS results. Re-invoke SB5 phase=FHIR after SB4 completes.

---

## Cycle 1 SB4 corrections — IdentificationService
Date: 2026-04-22 | Agent: sb4_fhir_json_serializer | Scope: FV-02 ERRORs (50), Families A–D

### Family A — Profile differentials: root element prepended (10 files)

Each of the 10 profile StructureDefinitions now has a root differential element (`id`/`path = {ResourceType}`) as the first entry in `differential.element[]`, before any child-path constraints. Each root element carries `short` and `definition` strings describing the profile intent. No `mustSupport` was applied at the root (per template).

| File | Root element added |
|---|---|
| `StructureDefinitions/IdentificationService-EntityConcept.json` | `Basic` |
| `StructureDefinitions/IdentificationService-EntityType.json` | `Basic` |
| `StructureDefinitions/IdentificationService-EntityTypeAssignment.json` | `Basic` |
| `StructureDefinitions/IdentificationService-IdentityInstance.json` | `Patient` |
| `StructureDefinitions/IdentificationService-IdentityLink.json` | `Linkage` |
| `StructureDefinitions/IdentificationService-IdentityUpdateTopic.json` | `SubscriptionTopic` |
| `StructureDefinitions/IdentificationService-NotificationSubscription.json` | `Subscription` |
| `StructureDefinitions/IdentificationService-PolicyDomain.json` | `Organization` |
| `StructureDefinitions/IdentificationService-RealWorldEntity.json` | `Person` |
| `StructureDefinitions/IdentificationService-ServiceMetadata.json` | `Basic` |

Expected FV-02 delta: 38 errors resolved (Family A closed).

### Family B — Basic.code injected into 3 example instances (3 files + 1 CodeSystem extended)

The fragment-content `CS_EntityConcept` CodeSystem has been extended with three new kind-of-Basic discriminator codes (`entity-type`, `entity-type-assignment`, `service-metadata`) and each of the three affected examples now carries a mandatory `Basic.code` CodeableConcept bound to that CodeSystem.

| File | Change |
|---|---|
| `CodeSystems/IdentificationService-EntityConcept.json` | Added 3 concepts: `entity-type`, `entity-type-assignment`, `service-metadata` |
| `Examples/example-entitytype-1.json` | Added `code.coding[0] = {system: CS_EntityConcept, code: "entity-type"}` |
| `Examples/example-entitytypeassignment-1.json` | Added `code.coding[0] = {system: CS_EntityConcept, code: "entity-type-assignment"}` |
| `Examples/example-servicemetadata-1.json` | Added `code.coding[0] = {system: CS_EntityConcept, code: "service-metadata"}` |

Expected FV-02 delta: 6 errors resolved (Family B closed).

### Family C — Subscription.endpoint URL rewritten (1 file)

| File | Change |
|---|---|
| `Examples/example-subscription-1.json` | `Subscription.endpoint`: `https://subscriber.example.org/…` → `https://subscriber.example.com/…` |

Expected FV-02 delta: 1 error resolved (Family C closed).

### Family D — CapabilityStatement (1 file, 3 changes)

| Fix | Change |
|---|---|
| cpb-2 | Added top-level `description` string (R5 IS CapabilityStatement summary covering all declared resources and operations). |
| cpb-14 | Added top-level `implementation` block (`description`, `url = "https://example.com/fhir"`) because `kind = "instance"` is preserved. |
| searchParam type | `rest[0].resource[4].searchParam[0].type` (Subscription-topic): `"reference"` → `"uri"` to align with the canonical base SearchParameter. |

Expected FV-02 delta: 3 errors resolved (Family D closed).

### Deferred (out of scope for Cycle 1)

- **Canonical base change to `http://hl7.eu/fhir/identificationservice/…`** — not performed this cycle. Rationale: would require edits to 391+ references across 77 files (73 FHIR JSON + 4 SysML packages), well beyond the scope of a targeted error-correction cycle. The example.org canonical URLs remain; they currently produce WARN-level findings (not ERROR) across most artifacts. Revisit in a later cycle if/when the IG is assigned a hosting domain.
- **supportedProfile canonical ERROR at `rest[0].resource[6].supportedProfile[0]`** — if this finding re-surfaces after Cycle 1 re-validation, route to Cycle 2. The supportedProfile URLs already point to existing StructureDefinition URLs (one-to-one match with files on disk), so the finding may be an artifact of validator cache state.
- **Narrative (dom-6) WARNings on 9 Example resources** — optional best-practice warnings; deferred.
- **W2/W3 WARNings on SubscriptionTopic.resourceTrigger.resource ValueSet binding** — routed advisorily to SB2-B; not a Cycle 1 SB4 concern.
- **W4 experimental-flag WARN on IdentityLink profile** — SB2-D concern; deferred.

### Summary

| Family | Files touched | Errors expected closed |
|---|---|---|
| A | 10 | 38 |
| B | 4 (3 examples + 1 CodeSystem) | 6 |
| C | 1 | 1 |
| D | 1 | 3 |
| **Total** | **16 unique files** | **48 of 50** |

Two of the 50 errors are scoped outside Cycle 1 (the deferred canonical/supportedProfile ERROR and any residual finding that re-emerges only after re-validation). Re-invoke SB5 phase=FHIR (FV-02) to confirm error count drops from 50 to ≤2 and to triage any residual findings.

---


## Cycle 2 — Differential Element Reorder (orchestrator patch)

After Cycle 1 re-validation, 38 of the original 50 Family-A ERRORs remained because the SB4 Cycle 1 patch only prepended a root element; the child elements were still listed in slice-declaration order, not in base-resource element order. The FHIR R5 snapshot generator requires differential children to appear in the same order as they occur in the base resource.

**Fix applied:** mechanical reorder of `differential.element[]` in all 10 profile StructureDefinitions using `tmp_reorder_profiles.py`. Elements were sorted by their position in the base resource (Basic, Patient, Linkage, Person, Organization, Subscription, SubscriptionTopic), preserving stable relative order within each base slot.

**Affected files (all in `FHIR/StructureDefinitions/`):**
- IdentificationService-EntityConcept.json
- IdentificationService-EntityType.json
- IdentificationService-EntityTypeAssignment.json
- IdentificationService-IdentityInstance.json
- IdentificationService-IdentityLink.json
- IdentificationService-IdentityUpdateTopic.json
- IdentificationService-NotificationSubscription.json
- IdentificationService-PolicyDomain.json
- IdentificationService-RealWorldEntity.json
- IdentificationService-ServiceMetadata.json

## Phase 2 (FHIR) — FINAL STATUS

| Metric | Count |
|---|---|
| ERROR | **0** |
| WARNING | 20 |
| INFORMATION | 61 |

All blocking conformance errors resolved. Remaining 20 warnings are advisory only:
- 9× `example.org` URL warnings (canonical base deferred; non-blocking)
- 9× `Constraint failed` dom-6 narrative best-practice (non-blocking)
- 1× IdentityLink builds on experimental Linkage (expected; non-blocking)
- 1× Subscription.type 'Patient' not in `Types used with Subscriptions` ValueSet (SB2-B advisory)

### Final phase status: **PROCEED**

Green-light for SB6-IG packaging.

---

## SB6-IG Packaging Report

**Cycle:** 1 — **Status:** SB6-IG packaging complete
**Date:** 2026-04-22
**Outputs written:**
- `output/ServiceFunctionalModel_IdentificationService/PSM/FHIR/ImplementationGuide.json`
- `output/ServiceFunctionalModel_IdentificationService/PSM/FHIR/package.json`
- `output/ServiceFunctionalModel_IdentificationService/PSM/FHIR/ig.ini`

### IG Metadata

| Field | Value |
|---|---|
| `id` / `packageId` | `hl7.fhir.eu.identificationservice` |
| `url` | `http://example.org/fhir/ImplementationGuide/hl7.fhir.eu.identificationservice` |
| `version` | `0.1.0` |
| `name` | `IdentificationServiceImplementationGuide` |
| `title` | HL7 Identification Service FHIR R5 Implementation Guide |
| `status` / `experimental` | `draft` / `true` |
| `publisher` | HL7 International |
| `fhirVersion` | `5.0.0` |
| `license` | `CC0-1.0` |

### Enumerated Resources (per-type counts)

| Artifact type | Count | Notes |
|---|---:|---|
| Profiles (StructureDefinition, non-extension) | 10 | Patient, Person, Organization, Linkage, SubscriptionTopic, Subscription, Basic ×4 |
| Extensions (StructureDefinition, type=Extension) | 27 | All `ext-*.json` files in `StructureDefinitions/` |
| OperationDefinitions | 4 | Patient-`$match`, Patient-`$merge`, Patient-`$unmerge`, Patient-`$everything` |
| SubscriptionTopics | 1 | `IdentificationService-IdentityUpdate` |
| CapabilityStatement | 1 | `IdentificationService` |
| ValueSets | 9 | One per closed-enum PIM type |
| CodeSystems | 9 | One per ValueSet (content=complete except EntityConcept=fragment) |
| NamingSystems | 2 | `IdentityInstance`, `PolicyDomain` |
| Examples | 10 | All carry `meta.profile[0]` → exampleCanonical populated |
| **TOTAL `definition.resource` entries** | **73** | |

### Global Profile Bindings (`global[]`)

Emitted one binding per non-extension profile whose `kind = resource` (10 bindings):

| Resource type | Canonical |
|---|---|
| Basic | `http://example.org/fhir/StructureDefinition/IdentificationService-EntityConcept` |
| Basic | `http://example.org/fhir/StructureDefinition/IdentificationService-EntityType` |
| Basic | `http://example.org/fhir/StructureDefinition/IdentificationService-EntityTypeAssignment` |
| Basic | `http://example.org/fhir/StructureDefinition/IdentificationService-ServiceMetadata` |
| Linkage | `http://example.org/fhir/StructureDefinition/IdentificationService-IdentityLink` |
| Organization | `http://example.org/fhir/StructureDefinition/IdentificationService-PolicyDomain` |
| Patient | `http://example.org/fhir/StructureDefinition/IdentificationService-IdentityInstance` |
| Person | `http://example.org/fhir/StructureDefinition/IdentificationService-RealWorldEntity` |
| Subscription | `http://example.org/fhir/StructureDefinition/IdentificationService-NotificationSubscription` |
| SubscriptionTopic | `http://example.org/fhir/StructureDefinition/IdentificationService-IdentityUpdateTopic` |

Note: having multiple `global[]` entries for the same resource type (Basic ×4) is permitted by FHIR R5 but means validators will attempt each profile against any Basic instance and report the best fit. Downstream consumers should rely on `meta.profile` to disambiguate.

### Package Dependencies (`dependsOn` / `package.json.dependencies`)

| Package | Version | Rationale |
|---|---|---|
| `hl7.fhir.r5.core` | `5.0.0` | Required — every definitional artifact constrains an R5 base resource |

`hl7.terminology.r5` was NOT added: no ValueSet `compose.include.system` targets `http://terminology.hl7.org/*`, `http://loinc.org`, or `http://snomed.info/sct`. All nine IG CodeSystems are locally authored under `http://example.org/fhir/CodeSystem/...`.

### Cross-Check Results

| Check | Result |
|---|---|
| Every non-example JSON in `FHIR/` (except `ImplementationGuide.json`, `package.json`, `ig.ini`) enumerated in `definition.resource` | **PASS** (63 definitional entries match 63 files) |
| Every `definition.resource.reference` resolves to an artifact file | **PASS** |
| Every `exampleCanonical` URL matches a StructureDefinition in the IG | **PASS** (10 / 10) |
| Every `global.profile` canonical URL matches an SD `url` | **PASS** (10 / 10) |
| TerminologyManifest closure — every CS referenced by a VS is in the IG | **PASS** (9 / 9) |
| TerminologyManifest closure — every declared VS/CS/NS has a JSON file | **PASS** (9 VS + 9 CS + 2 NS all present) |
| SubscriptionTopic event-code references resolve to a CS in the IG | **PASS** |
| `fhirVersion` = `"5.0.0"` in IG and `package.json.fhirVersions` | **PASS** |

### WARN Findings (non-blocking)

- **WARN-SB6-01:** `example-identityupdatetopic-1.json` carries the same canonical `url` as the referenced `IdentificationService-IdentityUpdate` SubscriptionTopic (`http://example.org/fhir/SubscriptionTopic/IdentificationService-IdentityUpdate`). The `id` values differ (`example-identityupdatetopic-1` vs `IdentificationService-IdentityUpdate`), so there is no `reference` collision in `definition.resource`, but examples should normally not reuse the SD's canonical URL on an instance. This is advisory — the IG Publisher will tolerate it but may emit a secondary warning. Deferred (not blocking publication).
- **WARN-SB6-02 (inherited):** The canonical URL base remains `http://example.org/fhir/...` (advisory from Phase 2 — deferred). SB6-IG preserved this base verbatim as instructed; no rewriting performed.

### SKIPPED Artifacts

None. Every JSON under `FHIR/` is enumerated in `definition.resource`.

### ERROR Findings

None. All cross-checks passed.

### Final SB6-IG status: **COMPLETE — IG PACKAGE READY FOR IG PUBLISHER**

To render the HTML IG:
```
java -jar tools/publisher.jar -ig output/ServiceFunctionalModel_IdentificationService/PSM/FHIR/ig.ini
```

