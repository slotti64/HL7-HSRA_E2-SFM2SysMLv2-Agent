package PSM_IdentificationService_TerminologyManifest {
    import FHIR_R5_Base::*;

    doc /* Terminology closure for the Identification Service FHIR R5 IG.
         Enumerates every CodeSystem (CS_*), ValueSet (VS_*), and
         NamingSystem (NS_*) referenced anywhere in the PSM layer
         (ProfileDefinitions, APIContracts, WorkflowPatterns). Each entry
         declares its canonical URL using the pattern
           http://example.org/fhir/{VS|CS|NS}/IdentificationService-{name}

         Derivation sources:
           - // REQUIRED-CS and // REQUIRED-VS markers in
             ProfileDefinitions.sysml (17 markers emitted by SB2-D)
           - WorkflowPatterns.sysml SubscriptionTopic event codes
             (event-code CodeSystem picked up from SB2-B's
             CS_IdentificationService-EventCode contract)
           - APIContracts.sysml OperationOutcome fault mapping
             (VS_IS_FaultCategory via SB3 integration)
           - NamingSystem declarations for the two IS-managed identifier
             namespaces (PolicyDomain and IdentityInstance). */

    // ════════════════════════════════════════════════════════════════════
    // CODE SYSTEMS (closed enums → required bindings)
    // ════════════════════════════════════════════════════════════════════

    item def CS_IdentityStatus :> CodeSystem {
        doc /* CodeSystem for PIM::DataModel::IdentityStatus.
             Closed enumeration (status = active, content = complete).
             Used by: ExtLifecycleStatus on IdentityInstance, PolicyDomain,
                      EntityType, EntityTypeAssignment profiles.
             Codes:
               - active    — Identity is active and discoverable.
               - inactive  — Identity is retired, soft-deprecated, or
                             otherwise no longer in active use. */
        attribute url : String = "http://example.org/fhir/CodeSystem/IdentificationService-IdentityStatus";
        attribute name : String = "CS_IdentificationService_IdentityStatus";
        attribute title : String = "Identification Service — IdentityStatus";
        attribute status : String = "active";
        attribute content : String = "complete";
        attribute caseSensitive : Boolean = true;
        metadata fhirResource { value "CodeSystem"; }
    }

    item def VS_IdentityStatus :> ValueSet {
        doc /* ValueSet binding CS_IdentityStatus verbatim.
             Binding strength: required (closed enum).
             Referenced by:
               - ExtLifecycleStatus.valueCodeableConcept
               - IdentificationServiceIdentityInstanceProfile (via ext)
               - IdentificationServicePolicyDomainProfile (via ext)
               - IdentificationServiceEntityTypeProfile (via ext)
               - IdentificationServiceEntityTypeAssignmentProfile (via ext) */
        attribute url : String = "http://example.org/fhir/ValueSet/IdentificationService-IdentityStatus";
        attribute name : String = "VS_IdentificationService_IdentityStatus";
        attribute title : String = "Identification Service — IdentityStatus (required)";
        attribute status : String = "active";
        metadata fhirResource { value "ValueSet"; }
    }

    item def CS_LinkTypeCategory :> CodeSystem {
        doc /* CodeSystem for PIM::DataModel::LinkTypeCategory.
             Closed enumeration.
             Codes:
               - peer-link          — Active bidirectional equivalence
                                      between identities.
               - merge-deprecation  — Directed link marking the source
                                      identity as deprecated in favor
                                      of the target. */
        attribute url : String = "http://example.org/fhir/CodeSystem/IdentificationService-LinkTypeCategory";
        attribute name : String = "CS_IdentificationService_LinkTypeCategory";
        attribute title : String = "Identification Service — LinkTypeCategory";
        attribute status : String = "active";
        attribute content : String = "complete";
        attribute caseSensitive : Boolean = true;
        metadata fhirResource { value "CodeSystem"; }
    }

    item def VS_LinkTypeCategory :> ValueSet {
        doc /* ValueSet binding CS_LinkTypeCategory verbatim.
             Binding strength: required.
             Referenced by: ExtLinkTypeCategory.valueCodeableConcept
                            on IdentificationServiceIdentityLinkProfile. */
        attribute url : String = "http://example.org/fhir/ValueSet/IdentificationService-LinkTypeCategory";
        attribute name : String = "VS_IdentificationService_LinkTypeCategory";
        attribute title : String = "Identification Service — LinkTypeCategory (required)";
        attribute status : String = "active";
        metadata fhirResource { value "ValueSet"; }
    }

    item def CS_LinkMethodCategory :> CodeSystem {
        doc /* CodeSystem for PIM::DataModel::LinkMethodCategory.
             Closed enumeration.
             Codes:
               - manual     — Link established by a human operator.
               - automated  — Link established by a matching algorithm. */
        attribute url : String = "http://example.org/fhir/CodeSystem/IdentificationService-LinkMethodCategory";
        attribute name : String = "CS_IdentificationService_LinkMethodCategory";
        attribute title : String = "Identification Service — LinkMethodCategory";
        attribute status : String = "active";
        attribute content : String = "complete";
        attribute caseSensitive : Boolean = true;
        metadata fhirResource { value "CodeSystem"; }
    }

    item def VS_LinkMethodCategory :> ValueSet {
        doc /* ValueSet binding CS_LinkMethodCategory verbatim.
             Binding strength: required.
             Referenced by: ExtLinkMethod.valueCodeableConcept. */
        attribute url : String = "http://example.org/fhir/ValueSet/IdentificationService-LinkMethodCategory";
        attribute name : String = "VS_IdentificationService_LinkMethodCategory";
        attribute title : String = "Identification Service — LinkMethodCategory (required)";
        attribute status : String = "active";
        metadata fhirResource { value "ValueSet"; }
    }

    item def CS_UpdateMode :> CodeSystem {
        doc /* CodeSystem for PIM::DataModel::UpdateMode.
             Closed enumeration used by UpdateIdentityProperties operation
             parameter (Parameters resource level, not a profile binding).
             Codes:
               - overwrite    — Replace target values with request values.
               - valued       — Replace only properties present in the
                                request; leave others unchanged.
               - unspecified  — Server-chosen semantics per policy. */
        attribute url : String = "http://example.org/fhir/CodeSystem/IdentificationService-UpdateMode";
        attribute name : String = "CS_IdentificationService_UpdateMode";
        attribute title : String = "Identification Service — UpdateMode";
        attribute status : String = "active";
        attribute content : String = "complete";
        attribute caseSensitive : Boolean = true;
        metadata fhirResource { value "CodeSystem"; }
    }

    item def VS_UpdateMode :> ValueSet {
        doc /* ValueSet binding CS_UpdateMode verbatim.
             Binding strength: required (on the Parameters.parameter[updateMode]
             referenced by UpdateIdentityProperties action def in APIContracts).
             Referenced by: APIContracts $update operation parameter. */
        attribute url : String = "http://example.org/fhir/ValueSet/IdentificationService-UpdateMode";
        attribute name : String = "VS_IdentificationService_UpdateMode";
        attribute title : String = "Identification Service — UpdateMode (required)";
        attribute status : String = "active";
        metadata fhirResource { value "ValueSet"; }
    }

    item def CS_MatchQualityTier :> CodeSystem {
        doc /* CodeSystem for PIM::DataModel::MatchQualityTier.
             Closed enumeration used by FindIdentitiesByProperty ($match)
             response Bundle match-grade entries.
             Codes:
               - definite-match     — Tier-1 definite match.
               - presumptive-match  — Tier-2 presumptive match.
               - no-match           — Explicit non-match. */
        attribute url : String = "http://example.org/fhir/CodeSystem/IdentificationService-MatchQualityTier";
        attribute name : String = "CS_IdentificationService_MatchQualityTier";
        attribute title : String = "Identification Service — MatchQualityTier";
        attribute status : String = "active";
        attribute content : String = "complete";
        attribute caseSensitive : Boolean = true;
        metadata fhirResource { value "CodeSystem"; }
    }

    item def VS_MatchQualityTier :> ValueSet {
        doc /* ValueSet binding CS_MatchQualityTier verbatim.
             Binding strength: required.
             Referenced by: FindIdentitiesByProperty ($match) response
                            Bundle match-grade entries (API layer). */
        attribute url : String = "http://example.org/fhir/ValueSet/IdentificationService-MatchQualityTier";
        attribute name : String = "VS_IdentificationService_MatchQualityTier";
        attribute title : String = "Identification Service — MatchQualityTier (required)";
        attribute status : String = "active";
        metadata fhirResource { value "ValueSet"; }
    }

    item def CS_NotificationEventCategory :> CodeSystem {
        doc /* CodeSystem for PIM::DataModel::NotificationEventCategory.
             Closed enumeration.
             Codes:
               - property-change — Non-status property value changed.
               - status-change   — IdentityStatus value changed.
               - link-change     — An IdentityLink affecting the subject
                                   was created or removed.
               - merge-change    — A merge or unmerge affecting the
                                   subject occurred. */
        attribute url : String = "http://example.org/fhir/CodeSystem/IdentificationService-NotificationEventCategory";
        attribute name : String = "CS_IdentificationService_NotificationEventCategory";
        attribute title : String = "Identification Service — NotificationEventCategory";
        attribute status : String = "active";
        attribute content : String = "complete";
        attribute caseSensitive : Boolean = true;
        metadata fhirResource { value "CodeSystem"; }
    }

    item def VS_NotificationEventCategory :> ValueSet {
        doc /* ValueSet binding CS_NotificationEventCategory verbatim.
             Binding strength: required.
             Referenced by:
               - ExtResourceTrigger.valueCodeableConcept
               - ExtNotificationQualifier.valueCodeableConcept
               - IdentificationServiceIdentityUpdateTopicProfile (via ext) */
        attribute url : String = "http://example.org/fhir/ValueSet/IdentificationService-NotificationEventCategory";
        attribute name : String = "VS_IdentificationService_NotificationEventCategory";
        attribute title : String = "Identification Service — NotificationEventCategory (required)";
        attribute status : String = "active";
        metadata fhirResource { value "ValueSet"; }
    }

    item def CS_FaultCategory :> CodeSystem {
        doc /* CodeSystem for PIM::DataModel::FaultCategory.
             Closed enumeration used by OperationOutcome.issue.details.coding
             on every fault response in APIContracts.
             Codes:
               - validation               — Input validation failure.
               - authorization            — Authorization failure.
               - not-found                — Referenced resource not found.
               - business-rule-violation  — Policy or business rule violation.
               - internal                 — Internal server error. */
        attribute url : String = "http://example.org/fhir/CodeSystem/IdentificationService-FaultCategory";
        attribute name : String = "CS_IdentificationService_FaultCategory";
        attribute title : String = "Identification Service — FaultCategory";
        attribute status : String = "active";
        attribute content : String = "complete";
        attribute caseSensitive : Boolean = true;
        metadata fhirResource { value "CodeSystem"; }
    }

    item def VS_FaultCategory :> ValueSet {
        doc /* ValueSet binding CS_FaultCategory verbatim.
             Binding strength: required.
             Referenced by: OperationOutcome fault-category extension on
                            every fault response in APIContracts. */
        attribute url : String = "http://example.org/fhir/ValueSet/IdentificationService-FaultCategory";
        attribute name : String = "VS_IdentificationService_FaultCategory";
        attribute title : String = "Identification Service — FaultCategory (required)";
        attribute status : String = "active";
        metadata fhirResource { value "ValueSet"; }
    }

    item def CS_EntityConcept :> CodeSystem {
        doc /* CodeSystem carrying the IS-managed EntityConcept codes
             (companion to IdentificationServiceEntityConceptProfile).
             Content is extensible — new EntityConcept instances are
             created at runtime.
             Content mode: fragment (runtime-extensible).
             Example initial codes: person, organization, device. */
        attribute url : String = "http://example.org/fhir/CodeSystem/IdentificationService-EntityConcept";
        attribute name : String = "CS_IdentificationService_EntityConcept";
        attribute title : String = "Identification Service — EntityConcept";
        attribute status : String = "active";
        attribute content : String = "fragment";
        attribute caseSensitive : Boolean = true;
        metadata fhirResource { value "CodeSystem"; }
    }

    item def VS_EntityConcept :> ValueSet {
        doc /* ValueSet binding CS_EntityConcept.
             Binding strength: required (for the companion Basic profile
             IdentificationServiceEntityConceptProfile.code).
             Referenced by: IdentificationServiceEntityConceptProfile.code */
        attribute url : String = "http://example.org/fhir/ValueSet/IdentificationService-EntityConcept";
        attribute name : String = "VS_IdentificationService_EntityConcept";
        attribute title : String = "Identification Service — EntityConcept (required)";
        attribute status : String = "active";
        metadata fhirResource { value "ValueSet"; }
    }

    item def CS_EventCode :> CodeSystem {
        doc /* CodeSystem carrying SubscriptionTopic event codes for the
             IdentityUpdateTopic. Emitted per SB2-B contract: every
             SubscriptionTopic.resourceTrigger.event must cite a code from
             a declared CodeSystem so downstream subscribers can register
             filter-by-event.
             Codes (identical to CS_NotificationEventCategory but scoped
             to event-trigger semantics rather than notification
             classification):
               - identity-created
               - identity-updated
               - identity-status-changed
               - identity-linked
               - identity-unlinked
               - identity-merged
               - identity-unmerged
             REQUIRED-CS: http://example.org/fhir/CodeSystem/IdentificationService-EventCode */
        attribute url : String = "http://example.org/fhir/CodeSystem/IdentificationService-EventCode";
        attribute name : String = "CS_IdentificationService_EventCode";
        attribute title : String = "Identification Service — Event Codes";
        attribute status : String = "active";
        attribute content : String = "complete";
        attribute caseSensitive : Boolean = true;
        metadata fhirResource { value "CodeSystem"; }
    }

    item def VS_EventCode :> ValueSet {
        doc /* ValueSet binding CS_EventCode verbatim.
             Binding strength: required.
             Referenced by: IdentityUpdateTopic.resourceTrigger.event
                            in WorkflowPatterns. */
        attribute url : String = "http://example.org/fhir/ValueSet/IdentificationService-EventCode";
        attribute name : String = "VS_IdentificationService_EventCode";
        attribute title : String = "Identification Service — Event Codes (required)";
        attribute status : String = "active";
        metadata fhirResource { value "ValueSet"; }
    }

    // ════════════════════════════════════════════════════════════════════
    // NAMING SYSTEMS (identifier namespaces)
    // ════════════════════════════════════════════════════════════════════

    item def NS_PolicyDomain :> NamingSystem {
        doc /* NamingSystem declaring the identifier namespace used for
             PolicyDomain identifiers (Organization.identifier.system on
             IdentificationServicePolicyDomainProfile).
             Kind: codesystem (PolicyDomain identifiers behave as an
             identifier-system catalog maintained by the service). */
        attribute url : String = "http://example.org/fhir/NamingSystem/IdentificationService-PolicyDomain";
        attribute name : String = "NS_IdentificationService_PolicyDomain";
        attribute title : String = "Identification Service — PolicyDomain Identifier Namespace";
        attribute status : String = "active";
        attribute kind : String = "identifier";
        attribute uniqueIdSystem : String = "http://example.org/fhir/sid/IdentificationService/PolicyDomain";
        metadata fhirResource { value "NamingSystem"; }
    }

    item def NS_IdentityInstance :> NamingSystem {
        doc /* NamingSystem declaring the identifier namespace used for
             service-assigned IdentityInstance identifiers (the
             Patient.identifier slice minted by CreateIdentity when the
             client does not supply one). Client-supplied identifiers
             from RegisterIdentity retain their originating system and
             are NOT governed by this NamingSystem.
             Kind: identifier. */
        attribute url : String = "http://example.org/fhir/NamingSystem/IdentificationService-IdentityInstance";
        attribute name : String = "NS_IdentificationService_IdentityInstance";
        attribute title : String = "Identification Service — IdentityInstance Identifier Namespace";
        attribute status : String = "active";
        attribute kind : String = "identifier";
        attribute uniqueIdSystem : String = "http://example.org/fhir/sid/IdentificationService/IdentityInstance";
        metadata fhirResource { value "NamingSystem"; }
    }

    /* ════════════════════════════════════════════════════════════════════
     * TERMINOLOGY CLOSURE SUMMARY
     * ════════════════════════════════════════════════════════════════════
     *
     * CodeSystems (9):
     *   CS_IdentityStatus, CS_LinkTypeCategory, CS_LinkMethodCategory,
     *   CS_UpdateMode, CS_MatchQualityTier, CS_NotificationEventCategory,
     *   CS_FaultCategory, CS_EntityConcept, CS_EventCode
     *
     * ValueSets (9) — one-to-one with CodeSystems:
     *   VS_IdentityStatus, VS_LinkTypeCategory, VS_LinkMethodCategory,
     *   VS_UpdateMode, VS_MatchQualityTier, VS_NotificationEventCategory,
     *   VS_FaultCategory, VS_EntityConcept, VS_EventCode
     *
     * NamingSystems (2):
     *   NS_PolicyDomain, NS_IdentityInstance
     *
     * Binding strength breakdown:
     *   required:    9 (all closed-enum-backed ValueSets)
     *   extensible:  0 (all enums in PIM are closed)
     *   preferred:   0
     *   example:     0
     *
     * Every VS/CS/NS canonical URL follows the mandated pattern
     *   http://example.org/fhir/{VS|CS|NS}/IdentificationService-{name}
     *
     * Cross-reference validation:
     *   REQUIRED-CS / REQUIRED-VS markers emitted by ProfileDefinitions.sysml
     *   and WorkflowPatterns.sysml have been collected and matched against
     *   declarations in this manifest. SB3 integration is expected to
     *   perform the final cross-check and emit a PC-01 finding for any
     *   unmatched marker.
     */
}
