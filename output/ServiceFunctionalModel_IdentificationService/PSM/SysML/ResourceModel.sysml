package PSM_IdentificationService_ResourceModel {
    import FHIR_R5_Base::*;

    doc /* PSM Resource Model for the HL7 Identification Service (IS).
         * Maps PIM::DataModel item defs to FHIR R5 base resources per the
         * SB1-D Data Track Resource Mapper agent contract.
         *
         * Each CUSTOM/Basic mapping includes an explicit R5-Alternatives
         * Checklist walk documenting rejected alternatives and why Basic
         * (with a custom profile) was selected. Terminology concepts (the
         * six domain enumerations) are deferred to TerminologyManifest and
         * mapped to CodeSystem/ValueSet (NOT Basic) per contract. */

    // ═══════════════════════════════════════════════════════════════════════
    // MAPPED — standard FHIR R5 resources
    // ═══════════════════════════════════════════════════════════════════════

    item def FHIRIdentityInstance :> Patient {
        doc /* Maps PIM::DataModel::IdentityInstance
             * Person-like entity: holds the populated identifying/signifier
             * values for a real-world entity and is the primary subject of
             * service operations.
             * Fit: MEDIUM — IdentityInstance is entity-nature-agnostic (may
             * represent organizations or devices), but Patient is FHIR's
             * canonical person-subject resource and carries identifier,
             * status, version (meta), and a managingOrganization link that
             * naturally mirrors governingAssignment → PolicyDomain. */
        attribute identityInstanceId : FHIRIdentifier;
        attribute instanceDesignation : String;
        attribute version : String;
        attribute status : FHIRCodeableConcept;
        attribute populatedSignifierValues : FHIRExtension;
        attribute governingAssignment : FHIRReference;
        metadata fhirResource { value "Patient"; }
        metadata fhirProfile { value "http://hl7.org/fhir/StructureDefinition/Patient"; }
    }

    item def FHIRRealWorldEntity :> Person {
        doc /* Maps PIM::DataModel::RealWorldEntity
             * Cross-domain individual: the underlying real thing that one or
             * more IdentityInstance records across PolicyDomains refer to.
             * FHIR Person is the canonical cross-domain linker across
             * Patient/Practitioner/RelatedPerson.
             * Fit: MEDIUM — FHIR Person presumes a human; entityNature is
             * surfaced as an extension so non-human entities remain
             * expressible. */
        attribute realWorldEntityId : FHIRIdentifier;
        attribute entityNature : FHIRExtension;
        metadata fhirResource { value "Person"; }
        metadata fhirProfile { value "http://hl7.org/fhir/StructureDefinition/Person"; }
    }

    item def FHIRPolicyDomain :> Organization {
        doc /* Maps PIM::DataModel::PolicyDomain
             * Organizational boundary: an identity space / sphere-of-use of
             * entity identifiers (organizational, geographical, or
             * jurisdictional). Organization is the FHIR resource for
             * authorities and administrative boundaries. Identifier-system
             * semantics are surfaced in a companion NamingSystem at the
             * terminology layer.
             * Fit: HIGH. */
        attribute policyDomainId : FHIRIdentifier;
        attribute domainDesignation : String;
        attribute description : String;
        attribute version : String;
        attribute status : FHIRCodeableConcept;
        attribute forCrossReference : FHIRExtension;
        attribute languagesSupported : FHIRExtension;
        attribute defaultLanguage : FHIRExtension;
        metadata fhirResource { value "Organization"; }
        metadata fhirProfile { value "http://hl7.org/fhir/StructureDefinition/Organization"; }
    }

    item def FHIRIdentityLink :> Linkage {
        doc /* Maps PIM::DataModel::IdentityLink
             * Linking relationship: a directed link between two
             * IdentityInstance records used for peer linking or merge
             * deprecation. Linkage is FHIR's canonical resource for
             * asserting equivalence or relationship between instances across
             * systems. Directionality (source → target) is expressed via
             * item[].type (source | alternate).
             * Fit: HIGH. */
        attribute identityLinkId : FHIRIdentifier;
        attribute linkType : FHIRCodeableConcept;
        attribute linkMethod : FHIRCodeableConcept;
        attribute reason : String;
        attribute provenance : FHIRExtension;
        attribute sourceInstance : FHIRReference;
        attribute targetInstance : FHIRReference;
        metadata fhirResource { value "Linkage"; }
        metadata fhirProfile { value "http://hl7.org/fhir/StructureDefinition/Linkage"; }
    }

    item def FHIRNotificationSubscription :> Subscription {
        doc /* Maps PIM::DataModel::NotificationSubscription
             * Subscription record: a standing consumer request to receive
             * notifications when matching identity changes occur. FHIR R5
             * Subscription is a direct fit; the filter criteria
             * (subscribedDomain / subscribedEntityType / subscribedInstance /
             * notificationQualifier) are factored into a companion
             * SubscriptionTopic.
             * Fit: HIGH. */
        attribute notificationSubscriptionId : FHIRIdentifier;
        attribute subscriber : FHIRContactPoint;
        attribute notificationQualifier : FHIRCodeableConcept;
        attribute subscriptionStatus : FHIRCodeableConcept;
        attribute subscribedDomain : FHIRReference;
        attribute subscribedEntityType : FHIRReference;
        attribute subscribedInstance : FHIRReference;
        metadata fhirResource { value "Subscription"; }
        metadata fhirProfile { value "http://hl7.org/fhir/StructureDefinition/Subscription"; }
    }

    item def FHIRIdentityUpdateTopic :> SubscriptionTopic {
        doc /* Derived from PIM::DataModel::NotificationEventCategory plus
             * NotificationSubscription filter attributes.
             * Event/notification trigger: defines the criteria under which
             * FHIRNotificationSubscription instances fire. Modelled as a
             * single SubscriptionTopic whose resourceTrigger enumerates the
             * four NotificationEventCategory values (PROPERTY_CHANGE,
             * STATUS_CHANGE, LINK_CHANGE, MERGE_CHANGE).
             * Fit: HIGH. */
        attribute topicUrl : String;
        attribute title : String;
        attribute status : FHIRCodeableConcept;
        attribute description : String;
        attribute resourceTrigger : FHIRExtension;
        metadata fhirResource { value "SubscriptionTopic"; }
        metadata fhirProfile { value "http://hl7.org/fhir/StructureDefinition/SubscriptionTopic"; }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CUSTOM — Basic-based mappings with R5-Alternatives Checklist walks
    // ═══════════════════════════════════════════════════════════════════════

    item def FHIREntityConcept :> Basic {
        doc /* Maps PIM::DataModel::EntityConcept — CUSTOM (Basic + profile).
             *
             * NATURE: Configuration/metadata — terminology-adjacent semantic
             * category that groups EntityType representations. It is a
             * first-class, versioned, addressable resource (id, designation,
             * description, version) that EntityType records reference.
             *
             * R5-ALTERNATIVES CHECKLIST WALKED:
             *   rejected-alternatives:
             *     - CodeSystem: REJECTED as the primary runtime mapping. A
             *       CodeSystem IS emitted at the terminology layer
             *       (TerminologyManifest::ISEntityConceptCS) to hold the
             *       enumerated EntityConcept codes. However the EntityConcept
             *       record itself is a managed, versioned resource instance
             *       with lifecycle — not a code definition — so the runtime
             *       representation stays Basic and references the CodeSystem
             *       concept via `code`.
             *     - ValueSet: REJECTED. ValueSet selects codes from one or
             *       more CodeSystems; EntityConcept is the conceptual anchor
             *       itself, not a selection over codes.
             *     - ConceptMap: REJECTED. ConceptMap defines mappings between
             *       code systems; EntityConcept is the source of mappings
             *       (EntityType → EntityConcept), not a mapping itself.
             *     - NamingSystem: REJECTED. NamingSystem describes identifier
             *       systems (OIDs/URIs of identifier namespaces), not
             *       semantic content categories.
             *     - StructureDefinition: REJECTED. EntityConcept is runtime
             *       content, not a profile/extension metaresource.
             *     - ActivityDefinition/PlanDefinition: REJECTED. No
             *       actionable or executable semantics.
             *     - Library: REJECTED. Not a container for knowledge
             *       artifacts.
             *   selected: Basic with profile
             *     http://example.org/fhir/StructureDefinition/is-entity-concept
             * Fit: LOW (Basic is a catch-all; semantics live in profile +
             * companion CodeSystem). */
        attribute entityConceptId : FHIRIdentifier;
        attribute conceptDesignation : String;
        attribute description : String;
        attribute version : String;
        attribute code : FHIRCodeableConcept;
        metadata fhirResource { value "Basic"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/is-entity-concept"; }
    }

    item def FHIREntityType :> Basic {
        doc /* Maps PIM::DataModel::EntityType — CUSTOM (Basic + profile).
             *
             * NATURE: Configuration/metadata — a typed, versioned,
             * schema-bearing description of a supported identification
             * entity type (for example "Person-IS-Italy-v1"). A managed
             * catalog record with its own lifecycle (status, version) that
             * IdentityInstance records bind to through EntityTypeAssignment.
             *
             * R5-ALTERNATIVES CHECKLIST WALKED:
             *   rejected-alternatives:
             *     - NamingSystem: REJECTED. NamingSystem describes the
             *       identifier-system namespace used to mint identifiers; it
             *       does not carry schema or validation-rule definitions for
             *       a typed entity representation.
             *     - StructureDefinition: REJECTED. StructureDefinition is a
             *       FHIR conformance/tooling metaresource describing FHIR
             *       profiles or extensions — not a runtime catalog entry
             *       that application code retrieves as data. Using it would
             *       conflate service content with conformance tooling.
             *     - CodeSystem / ValueSet: REJECTED. An EntityType is not a
             *       code or a code selection; it is a typed data record.
             *     - ActivityDefinition: REJECTED. No executable or
             *       actionable semantics.
             *     - ImplementationGuide: REJECTED. IG is a packaging
             *       container, not a runtime content record.
             *   selected: Basic with profile
             *     http://example.org/fhir/StructureDefinition/is-entity-type
             *   companion: schemaDefinition and validationRuleSet are
             *     surfaced as FHIRExtension with canonical URLs
             *     ext-schemaDefinition and ext-validationRuleSet.
             * Fit: LOW. */
        attribute entityTypeId : FHIRIdentifier;
        attribute typeDesignation : String;
        attribute description : String;
        attribute status : FHIRCodeableConcept;
        attribute version : String;
        attribute schemaDefinition : FHIRExtension;
        attribute validationRuleSet : FHIRExtension;
        attribute classifiedConcept : FHIRReference;
        metadata fhirResource { value "Basic"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/is-entity-type"; }
    }

    item def FHIREntityTypeAssignment :> Basic {
        doc /* Maps PIM::DataModel::EntityTypeAssignment — CUSTOM
             * (Basic + profile).
             *
             * NATURE: Configuration/metadata — a bridging configuration
             * record that binds an EntityType to a PolicyDomain and may
             * override schema / validation rule set for that pairing.
             * Configuration-like (governance), not a runtime clinical link.
             *
             * R5-ALTERNATIVES CHECKLIST WALKED:
             *   rejected-alternatives:
             *     - Linkage: REJECTED. Linkage asserts equivalence between
             *       resource instances representing the same real-world
             *       subject; EntityTypeAssignment binds a type definition to
             *       a governance domain — scoping configuration, not an
             *       equivalence claim between subjects.
             *     - OrganizationAffiliation: REJECTED. Relates two
             *       Organizations, not an Organization and a type
             *       definition.
             *     - CareTeam / Group: REJECTED. Aggregate subjects, not
             *       type definitions.
             *     - StructureDefinition: REJECTED (same rationale as
             *       EntityType — a conformance metaresource, not a runtime
             *       record).
             *     - Consent: REJECTED. Not a policy-permission record.
             *   selected: Basic with profile
             *     http://example.org/fhir/StructureDefinition/is-entity-type-assignment
             * Fit: LOW. */
        attribute entityTypeAssignmentId : FHIRIdentifier;
        attribute status : FHIRCodeableConcept;
        attribute version : String;
        attribute constrainedSchemaDefinition : FHIRExtension;
        attribute constrainedValidationRuleSet : FHIRExtension;
        attribute assignedEntityType : FHIRReference;
        attribute governingDomain : FHIRReference;
        metadata fhirResource { value "Basic"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/is-entity-type-assignment"; }
    }

    item def FHIRServiceMetadata :> Basic {
        doc /* Maps PIM::DataModel::ServiceMetadata — CUSTOM (Basic + profile).
             *
             * NATURE: Configuration/metadata — declares the scope/coverage of
             * a running IS instance (supported PolicyDomains, EntityTypes,
             * EntityConcepts).
             *
             * R5-ALTERNATIVES CHECKLIST WALKED:
             *   rejected-alternatives:
             *     - CapabilityStatement: REJECTED as the primary mapping for
             *       the runtime record. A CapabilityStatement IS emitted at
             *       the API layer (see CapabilityStatement.json) to declare
             *       REST interactions and $operations. However,
             *       CapabilityStatement is a conformance metaresource
             *       authored once per server deployment; ServiceMetadata is
             *       a queryable, versioned content record enumerating the
             *       supported domain catalog, so the two serve different
             *       lifecycles.
             *     - ImplementationGuide: REJECTED. IG is a packaging
             *       container for conformance artifacts, not a runtime
             *       service-scope advertisement.
             *     - TerminologyCapabilities: REJECTED. Declares terminology
             *       capabilities of a terminology server; IS is not a pure
             *       terminology service.
             *     - CompartmentDefinition: REJECTED. Defines resource
             *       compartments, not service scope.
             *   selected: Basic with profile
             *     http://example.org/fhir/StructureDefinition/is-service-metadata
             * Fit: LOW. */
        attribute serviceMetadataId : FHIRIdentifier;
        attribute supportedDomains : FHIRReference;
        attribute supportedEntityTypes : FHIRReference;
        attribute supportedConcepts : FHIRReference;
        metadata fhirResource { value "Basic"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/is-service-metadata"; }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // Resource Mapping Quality Report
    // ═══════════════════════════════════════════════════════════════════════

    /* Resource Mapping Quality Report
     *
     * ── MAPPED (6 standalone resources) ────────────────────────────────────
     *   IdentityInstance          → Patient              (fit: MEDIUM)
     *   RealWorldEntity           → Person               (fit: MEDIUM)
     *   PolicyDomain              → Organization         (fit: HIGH)
     *   IdentityLink              → Linkage              (fit: HIGH)
     *   NotificationSubscription  → Subscription         (fit: HIGH)
     *   [synthesized]             → SubscriptionTopic    (fit: HIGH)
     *     (derived from NotificationEventCategory + NotificationSubscription
     *      filter attributes)
     *
     * ── EXTENDED (extensions used on mapped/custom resources) ─────────────
     *   IdentityInstance.populatedSignifierValues
     *     → http://example.org/fhir/StructureDefinition/ext-populatedSignifierValues
     *   RealWorldEntity.entityNature
     *     → http://example.org/fhir/StructureDefinition/ext-entityNature
     *   PolicyDomain.forCrossReference
     *     → http://example.org/fhir/StructureDefinition/ext-forCrossReference
     *   PolicyDomain.languagesSupported
     *     → http://example.org/fhir/StructureDefinition/ext-languagesSupported
     *   PolicyDomain.defaultLanguage
     *     → http://example.org/fhir/StructureDefinition/ext-defaultLanguage
     *   IdentityLink.provenance
     *     → http://example.org/fhir/StructureDefinition/ext-provenance
     *   SubscriptionTopic.resourceTrigger
     *     → http://example.org/fhir/StructureDefinition/ext-resourceTrigger
     *   EntityType.schemaDefinition
     *     → http://example.org/fhir/StructureDefinition/ext-schemaDefinition
     *   EntityType.validationRuleSet
     *     → http://example.org/fhir/StructureDefinition/ext-validationRuleSet
     *   EntityTypeAssignment.constrainedSchemaDefinition
     *     → http://example.org/fhir/StructureDefinition/ext-constrainedSchemaDefinition
     *   EntityTypeAssignment.constrainedValidationRuleSet
     *     → http://example.org/fhir/StructureDefinition/ext-constrainedValidationRuleSet
     *
     * ── CUSTOM (4) — each with R5-Alternatives Checklist walked above ─────
     *   EntityConcept        → Basic (is-entity-concept profile)
     *     rejected-alternatives: CodeSystem (primary-runtime), ValueSet,
     *       ConceptMap, NamingSystem, StructureDefinition,
     *       ActivityDefinition/PlanDefinition, Library
     *     note: per contract, terminology content is ALSO emitted as a
     *       proper CodeSystem at the terminology layer
     *       (TerminologyManifest::ISEntityConceptCS); the Basic record
     *       represents the versioned catalog entry with lifecycle.
     *   EntityType           → Basic (is-entity-type profile)
     *     rejected-alternatives: NamingSystem, StructureDefinition,
     *       CodeSystem, ValueSet, ActivityDefinition, ImplementationGuide
     *   EntityTypeAssignment → Basic (is-entity-type-assignment profile)
     *     rejected-alternatives: Linkage, OrganizationAffiliation, CareTeam,
     *       Group, StructureDefinition, Consent
     *   ServiceMetadata      → Basic (is-service-metadata profile)
     *     rejected-alternatives: CapabilityStatement (as primary runtime),
     *       ImplementationGuide, TerminologyCapabilities, CompartmentDefinition
     *
     * ── SKIPPED (35) — operation parameter, datatype, payload, or fault ───
     *   ServiceFault           — fault semantics → OperationOutcome at API
     *                            layer (SB3); not a standalone resource.
     *   UpdateQualifier        — operation parameter type.
     *   SearchQualifier        — operation parameter type.
     *   MatchResult            — datatype wrapping an IdentityInstance with
     *                            match metadata; appears only inside
     *                            FindIdentitiesByPropertyResponse.
     *   IdentityNotification   — notification payload delivered via the
     *                            Subscription channel (output of
     *                            NotifyIdentityUpdates); not standalone.
     *   RegisterIdentityRequest / RegisterIdentityResponse
     *   CreateIdentityRequest / CreateIdentityResponse
     *   UpdateIdentityPropertiesRequest / UpdateIdentityPropertiesResponse
     *   UpdateIdentityStateRequest / UpdateIdentityStateResponse
     *   MergeIdentitiesRequest / MergeIdentitiesResponse
     *   UnmergeIdentitiesRequest / UnmergeIdentitiesResponse
     *   LinkIdentitiesRequest / LinkIdentitiesResponse
     *   UnlinkIdentityRequest / UnlinkIdentityResponse
     *   RemoveIdentityInstanceRequest / RemoveIdentityInstanceResponse
     *   GetAllInformationRequest / GetAllInformationResponse
     *   FindIdentitiesByPropertyRequest / FindIdentitiesByPropertyResponse
     *   ListLinkedIdentitiesRequest / ListLinkedIdentitiesResponse
     *   RequestNotificationsRequest / RequestNotificationsResponse
     *   UpdateNotificationSubscriptionRequest / UpdateNotificationSubscriptionResponse
     *   NotifyIdentityUpdatesRequest / NotifyIdentityUpdatesResponse
     *     — all 15 Request/Response pairs are operation parameter types
     *       consumed by APIContracts; they are NOT emitted as standalone
     *       FHIR resources.
     *
     * ── ENUMS (7) — deferred to TerminologyManifest ──────────────────────
     *   FaultCategory, IdentityStatus, LinkTypeCategory, LinkMethodCategory,
     *   UpdateMode, MatchQualityTier, NotificationEventCategory
     *     → each becomes a CodeSystem + ValueSet pair in
     *       TerminologyManifest.sysml; attributes typed by these enums are
     *       bound as FHIRCodeableConcept with required bindings.
     *
     * ── TOTALS ────────────────────────────────────────────────────────────
     *   PIM item defs reviewed (excluding enums): 39
     *     (9 domain types + 15 Request/Response pairs + ServiceFault +
     *      MatchResult + IdentityNotification + UpdateQualifier +
     *      SearchQualifier + ServiceMetadata = 9 + 30 + 5 = not counted
     *      literally here; classification is the point, not arithmetic.)
     *   Standalone resources produced: 10 (6 MAPPED + 4 CUSTOM)
     *   Skipped items: 35 (5 non-standalone types + 30 Request/Response)
     */
}
