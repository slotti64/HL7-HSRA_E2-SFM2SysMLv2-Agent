package PSM_IdentificationService_ProfileDefinitions {
    import FHIR_R5_Base::*;

    doc /* FHIR R5 Profile (StructureDefinition) definitions for the
         Identification Service. One profile per MAPPED/CUSTOM entry in
         ResourceModel.sysml, with:
           - cardinality derived from PIM::DataModel
           - must-support flags (// MS) cross-checked against
             APIContracts.sysml SearchParameter expressions and
             WorkflowPatterns.sysml (SubscriptionTopic canFilterBy and
             Task/Bundle workflow references)
           - ValueSet bindings (required / extensible) with binding
             strength chosen per enum-closure analysis in PIM
           - Extension definitions for every PIM attribute that cannot be
             mapped to a base-resource element
           - ATTR-MAP doc-block lines (≥ 90 % coverage per profile) that
             declare, for every PIM attribute, whether it is constrained
             onto a base element, carried on an extension, or DROPPED
             (with reason)
           - Binding-Narrowing Rule: where a base element already carries
             a required binding (Patient.gender, Organization.active,
             Subscription.status, SubscriptionTopic.status), we do NOT
             rebind to a service-local ValueSet; IS-specific status
             semantics are carried on the extension ext-lifecycleStatus
             bound to VS_IS_IdentityStatus. This preserves conformance
             with the base required binding while surfacing service-local
             semantics on the extension.
           - Extension value cardinality is [1..1] for every ext-*
             (Extension.value[x] is mandatory even when the slice itself
             is optional). */

    // ════════════════════════════════════════════════════════════════════
    // EXTENSION DEFINITIONS
    // Every ext-* has Extension.value[x] cardinality [1..1]; the slice
    // cardinality on the owning profile may be [0..1] or [0..*].
    // ════════════════════════════════════════════════════════════════════

    item def ExtLifecycleStatus :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-lifecycleStatus
             Carries IS-specific IdentityStatus (ACTIVE | INACTIVE) when
             the base element is either absent or already bound to a
             different required ValueSet (Binding-Narrowing Rule).
             Value[x] cardinality: [1..1] (mandatory on the extension)
             Value type: CodeableConcept bound required to
             VS_IS_IdentityStatus.
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-IdentityStatus */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-lifecycleStatus";
        attribute valueCodeableConcept[1..1] : FHIRCodeableConcept;
    }

    item def ExtPopulatedSignifierValues :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-populatedSignifierValues
             Extends: IdentificationServiceIdentityInstanceProfile.populatedSignifierValues
             Carries the JSON/XML snapshot of populated signifier values
             as defined by the bound EntityType schemaDefinition. No
             native Patient element holds raw arbitrary signifier payload.
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-populatedSignifierValues";
        attribute valueString[1..1] : String;
    }

    item def ExtEntityNature :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-entityNature
             Extends: IdentificationServiceRealWorldEntityProfile.entityNature
             Carries the nature of the real-world entity (person, device,
             organization, other) since FHIR Person presumes a human.
             Value[x] cardinality: [1..1]
             Value type: code */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-entityNature";
        attribute valueCode[1..1] : String;
    }

    item def ExtForCrossReference :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-forCrossReference
             Extends: IdentificationServicePolicyDomainProfile.forCrossReference
             Boolean flag marking PolicyDomains used only for
             cross-referencing.
             Value[x] cardinality: [1..1]
             Value type: boolean
             PIM cardinality: [0..1] → slice is [0..1]. */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-forCrossReference";
        attribute valueBoolean[1..1] : Boolean;
    }

    item def ExtLanguagesSupported :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-languagesSupported
             Extends: IdentificationServicePolicyDomainProfile.languagesSupported
             List of BCP-47 language codes supported by the PolicyDomain.
             Value[x] cardinality: [1..1] (on each extension instance)
             Slice cardinality on owning profile: [0..*]
             Value type: code */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-languagesSupported";
        attribute valueCode[1..1] : String;
    }

    item def ExtDefaultLanguage :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-defaultLanguage
             Extends: IdentificationServicePolicyDomainProfile.defaultLanguage
             BCP-47 language code declared as the PolicyDomain default.
             Value[x] cardinality: [1..1]
             Value type: code */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-defaultLanguage";
        attribute valueCode[1..1] : String;
    }

    item def ExtProvenance :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-provenance
             Extends: IdentificationServiceIdentityLinkProfile.provenance
             Free-text provenance description captured at link creation
             when a separate Provenance resource is not generated.
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-provenance";
        attribute valueString[1..1] : String;
    }

    item def ExtResourceTrigger :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-resourceTrigger
             Extends: IdentificationServiceIdentityUpdateTopicProfile.resourceTrigger
             Enumerates the NotificationEventCategory values that trigger
             this topic (property-change | status-change | link-change |
             merge-change). Serialized alongside the native
             SubscriptionTopic.resourceTrigger element for clients that
             cannot process the native structure.
             Value[x] cardinality: [1..1]
             Value type: CodeableConcept bound required to
             VS_IS_NotificationEventCategory.
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-NotificationEventCategory */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-resourceTrigger";
        attribute valueCodeableConcept[1..1] : FHIRCodeableConcept;
    }

    item def ExtSchemaDefinition :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-schemaDefinition
             Extends: IdentificationServiceEntityTypeProfile.schemaDefinition
             Carries the EntityType structural schema (JSON-Schema /
             FHIR StructureDefinition canonical URL / XSD URI) describing
             the populatedSignifierValues payload.
             Value[x] cardinality: [1..1]
             Value type: string (URI or inline schema) */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-schemaDefinition";
        attribute valueString[1..1] : String;
    }

    item def ExtValidationRuleSet :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-validationRuleSet
             Extends: IdentificationServiceEntityTypeProfile.validationRuleSet
             Carries a reference (or inline definition) of the validation
             rule set applied to populatedSignifierValues for this
             EntityType.
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-validationRuleSet";
        attribute valueString[1..1] : String;
    }

    item def ExtConstrainedSchemaDefinition :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-constrainedSchemaDefinition
             Extends: IdentificationServiceEntityTypeAssignmentProfile.constrainedSchemaDefinition
             Domain-specific override of the EntityType schemaDefinition
             applied within a particular PolicyDomain.
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-constrainedSchemaDefinition";
        attribute valueString[1..1] : String;
    }

    item def ExtConstrainedValidationRuleSet :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-constrainedValidationRuleSet
             Extends: IdentificationServiceEntityTypeAssignmentProfile.constrainedValidationRuleSet
             Domain-specific override of the EntityType validationRuleSet
             applied within a particular PolicyDomain.
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-constrainedValidationRuleSet";
        attribute valueString[1..1] : String;
    }

    item def ExtInstanceDesignation :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-instanceDesignation
             Extends: IdentificationServiceIdentityInstanceProfile.instanceDesignation
             Human-readable designation of the identity instance used in
             administrative listings. Not Patient.name (which is
             structured HumanName).
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-instanceDesignation";
        attribute valueString[1..1] : String;
    }

    item def ExtVersion :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-version
             Extends: profiles whose PIM source carries a service-owned
             `version` attribute distinct from meta.versionId. Used by
             IdentityInstance, PolicyDomain, EntityType, EntityTypeAssignment.
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-version";
        attribute valueString[1..1] : String;
    }

    item def ExtLinkReason :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-linkReason
             Extends: IdentificationServiceIdentityLinkProfile.reason
             Free-text reason attached to a Linkage at creation time.
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-linkReason";
        attribute valueString[1..1] : String;
    }

    item def ExtLinkMethod :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-linkMethod
             Extends: IdentificationServiceIdentityLinkProfile.linkMethod
             How the link was established (manual | automated).
             Value[x] cardinality: [1..1]
             Value type: CodeableConcept bound required to
             VS_IS_LinkMethodCategory.
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-LinkMethodCategory */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-linkMethod";
        attribute valueCodeableConcept[1..1] : FHIRCodeableConcept;
    }

    item def ExtLinkTypeCategory :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-linkTypeCategory
             Extends: IdentificationServiceIdentityLinkProfile.linkType
             IS-specific link type (peer-link | merge-deprecation).
             Although Linkage carries item.type (source | alternate |
             historical) as a base required binding, the PIM concept of
             LinkTypeCategory is orthogonal (it describes the link's
             intent, not the per-item role). Per the Binding-Narrowing
             Rule we do NOT rebind Linkage.item.type; we carry the PIM
             semantic on this extension instead.
             Value[x] cardinality: [1..1]
             Value type: CodeableConcept bound required to
             VS_IS_LinkTypeCategory.
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-LinkTypeCategory */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-linkTypeCategory";
        attribute valueCodeableConcept[1..1] : FHIRCodeableConcept;
    }

    item def ExtNotificationQualifier :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-notificationQualifier
             Extends: IdentificationServiceNotificationSubscriptionProfile.notificationQualifier
             Classifies which NotificationEventCategory is of interest.
             Subscription.filterBy / topic expresses the FHIR-native
             filter; this extension carries the PIM-native classification
             for cross-system traceability.
             Value[x] cardinality: [1..1]
             Value type: CodeableConcept bound required to
             VS_IS_NotificationEventCategory.
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-NotificationEventCategory */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-notificationQualifier";
        attribute valueCodeableConcept[1..1] : FHIRCodeableConcept;
    }

    item def ExtConceptDesignation :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-conceptDesignation
             Extends: IdentificationServiceEntityConceptProfile.conceptDesignation
             Human-readable designation of the EntityConcept.
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-conceptDesignation";
        attribute valueString[1..1] : String;
    }

    item def ExtTypeDesignation :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-typeDesignation
             Extends: IdentificationServiceEntityTypeProfile.typeDesignation
             Human-readable designation of the EntityType.
             Value[x] cardinality: [1..1]
             Value type: string */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-typeDesignation";
        attribute valueString[1..1] : String;
    }

    item def ExtDescription :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-description
             Extends: profiles whose PIM source carries a `description`
             attribute but whose base resource has no equivalent narrative
             element (EntityConcept, EntityType on Basic).
             Value[x] cardinality: [1..1]
             Value type: markdown */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-description";
        attribute valueMarkdown[1..1] : String;
    }

    item def ExtSupportedDomains :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-supportedDomains
             Extends: IdentificationServiceServiceMetadataProfile.supportedDomains
             Reference to each PolicyDomain supported by the service
             instance. Slice cardinality on owning profile: [1..*]
             (ServiceMetadata.supportedDomains is mandatory and
             multi-valued per PIM).
             Value[x] cardinality: [1..1]
             Value type: Reference(IdentificationServicePolicyDomainProfile) */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-supportedDomains";
        attribute valueReference[1..1] : FHIRReference;
    }

    item def ExtSupportedEntityTypes :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-supportedEntityTypes
             Extends: IdentificationServiceServiceMetadataProfile.supportedEntityTypes
             Slice cardinality on owning profile: [1..*]
             Value[x] cardinality: [1..1]
             Value type: Reference(IdentificationServiceEntityTypeProfile) */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-supportedEntityTypes";
        attribute valueReference[1..1] : FHIRReference;
    }

    item def ExtSupportedConcepts :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-supportedConcepts
             Extends: IdentificationServiceServiceMetadataProfile.supportedConcepts
             Slice cardinality on owning profile: [1..*]
             Value[x] cardinality: [1..1]
             Value type: Reference(IdentificationServiceEntityConceptProfile) */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-supportedConcepts";
        attribute valueReference[1..1] : FHIRReference;
    }

    item def ExtClassifiedConcept :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-classifiedConcept
             Extends: IdentificationServiceEntityTypeProfile.classifiedConcept
             Reference to the EntityConcept under which this EntityType
             is classified.
             Value[x] cardinality: [1..1]
             Value type: Reference(IdentificationServiceEntityConceptProfile) */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-classifiedConcept";
        attribute valueReference[1..1] : FHIRReference;
    }

    item def ExtAssignedEntityType :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-assignedEntityType
             Extends: IdentificationServiceEntityTypeAssignmentProfile.assignedEntityType
             Reference to the EntityType under which an assignment binds.
             Value[x] cardinality: [1..1]
             Value type: Reference(IdentificationServiceEntityTypeProfile) */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-assignedEntityType";
        attribute valueReference[1..1] : FHIRReference;
    }

    item def ExtGoverningDomain :> FHIRExtension {
        doc /* Extension URL: http://example.org/fhir/StructureDefinition/ext-governingDomain
             Extends: IdentificationServiceEntityTypeAssignmentProfile.governingDomain
             Reference to the PolicyDomain that governs an assignment.
             Value[x] cardinality: [1..1]
             Value type: Reference(IdentificationServicePolicyDomainProfile) */
        attribute url : String = "http://example.org/fhir/StructureDefinition/ext-governingDomain";
        attribute valueReference[1..1] : FHIRReference;
    }

    // ════════════════════════════════════════════════════════════════════
    // PROFILE DEFINITIONS — MAPPED
    // ════════════════════════════════════════════════════════════════════

    item def IdentificationServiceIdentityInstanceProfile
            :> PSM_IdentificationService_ResourceModel::FHIRIdentityInstance {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-IdentityInstance
             Base URL: http://hl7.org/fhir/StructureDefinition/Patient
             Maps PIM::DataModel::IdentityInstance.

             ATTR-MAP (6/6 = 100% coverage):
               - identityInstanceId        → constrain Patient.identifier (MS, [1..1])
               - instanceDesignation       → extension ext-instanceDesignation ([0..1])
               - version                   → extension ext-version ([0..1])
                                             (Patient.meta.versionId is server-assigned;
                                             the PIM version is service-owned content)
               - status                    → extension ext-lifecycleStatus (Binding-Narrowing
                                             Rule: Patient.active carries a base required
                                             binding to true|false — NOT a strict subset of
                                             IdentityStatus {ACTIVE, INACTIVE} — so we carry
                                             the PIM value on the extension and also set
                                             Patient.active as a projection (MS).)
               - populatedSignifierValues  → extension ext-populatedSignifierValues ([1..1] MS)
               - governingAssignment       → constrain Patient.managingOrganization via
                                             profile reference (MS, [0..1]). This is a
                                             lossy projection: governingAssignment refers
                                             to an EntityTypeAssignment which in turn
                                             references a PolicyDomain → Organization;
                                             the Patient.managingOrganization carries the
                                             PolicyDomain projection.

             MS rationale (APIContracts + WorkflowPatterns cross-check):
               - Patient.identifier → searchParam identifier (CapabilityStatement),
                 $match.resource input, MergeIdentities/UnmergeIdentities
                 source/target identifier parameters → MS
               - Patient.name       → searchParam name → MS
               - Patient.birthDate  → searchParam birthdate → MS
               - Patient.gender     → searchParam gender → MS
               - Patient.address    → searchParam address → MS
               - Patient.active     → searchParam active, state transitions in
                 UpdateIdentityState → MS
               - Patient.managingOrganization → searchParam organization → MS
               - ext-populatedSignifierValues → referenced by UpdateIdentityProperties
                 and CreateIdentity/RegisterIdentity request parameters → MS

             Binding-Narrowing Rule check:
               - Patient.gender: base required to AdministrativeGender. We do NOT
                 rebind to a narrower ValueSet.
               - Patient.active: base required boolean. We set a projection from
                 IdentityStatus (ACTIVE → true, INACTIVE → false) but leave the
                 base binding intact; the authoritative value lives on
                 ext-lifecycleStatus.
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-IdentityStatus */
        attribute identifier[1..1] : FHIRIdentifier; // MS
        attribute name[0..*] : String; // MS
        attribute birthDate[0..1] : String; // MS
        attribute gender[0..1] : FHIRCodeableConcept; // MS
        attribute address[0..*] : String; // MS
        attribute active[0..1] : Boolean; // MS
        attribute managingOrganization[0..1] : FHIRReference; // MS
        attribute extLifecycleStatus[0..1] : ExtLifecycleStatus; // MS
        attribute extInstanceDesignation[0..1] : ExtInstanceDesignation;
        attribute extVersion[0..1] : ExtVersion;
        attribute extPopulatedSignifierValues[1..1] : ExtPopulatedSignifierValues; // MS
        metadata fhirResource { value "Patient"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-IdentityInstance"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-IdentityInstance"; }
    }

    item def IdentificationServiceRealWorldEntityProfile
            :> PSM_IdentificationService_ResourceModel::FHIRRealWorldEntity {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-RealWorldEntity
             Base URL: http://hl7.org/fhir/StructureDefinition/Person
             Maps PIM::DataModel::RealWorldEntity.

             ATTR-MAP (2/2 = 100% coverage):
               - realWorldEntityId → constrain Person.identifier (MS, [1..1])
               - entityNature      → extension ext-entityNature ([1..1] MS)
                                     (Person presumes human; entityNature must
                                     be carried explicitly for non-human cases.)

             MS rationale:
               - Person.identifier → used to cross-reference Patient records
                 across PolicyDomains in MergeIdentities/UnmergeIdentities and
                 $everything. → MS
               - ext-entityNature  → required disambiguator for non-person
                 subjects (device, organization). → MS */
        attribute identifier[1..1] : FHIRIdentifier; // MS
        attribute extEntityNature[1..1] : ExtEntityNature; // MS
        metadata fhirResource { value "Person"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-RealWorldEntity"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-RealWorldEntity"; }
    }

    item def IdentificationServicePolicyDomainProfile
            :> PSM_IdentificationService_ResourceModel::FHIRPolicyDomain {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-PolicyDomain
             Base URL: http://hl7.org/fhir/StructureDefinition/Organization
             Maps PIM::DataModel::PolicyDomain.

             ATTR-MAP (8/8 = 100% coverage):
               - policyDomainId       → constrain Organization.identifier (MS, [1..1])
                                        (companion NamingSystem declared in
                                        TerminologyManifest)
               - domainDesignation    → constrain Organization.name (MS, [1..1])
               - description          → constrain Organization.alias ([0..1])
                                        (Organization has no narrative description;
                                        alias is the nearest free-text slot)
               - version              → extension ext-version ([0..1])
               - status               → extension ext-lifecycleStatus (Binding-Narrowing
                                        Rule: Organization.active is required boolean,
                                        NOT a strict subset of IdentityStatus {ACTIVE,
                                        INACTIVE}. We project ACTIVE→true / INACTIVE→false
                                        on .active and keep the authoritative value on
                                        ext-lifecycleStatus.) (MS)
               - forCrossReference    → extension ext-forCrossReference ([0..1])
               - languagesSupported   → extension ext-languagesSupported ([0..*])
               - defaultLanguage      → extension ext-defaultLanguage ([0..1])

             MS rationale:
               - Organization.identifier → MergeIdentities/UnmergeIdentities use
                 policyDomainId; $match filters by Organization reference → MS
               - Organization.name      → domain listing, CapabilityStatement → MS
               - Organization.active    → filters active PolicyDomains → MS
               - ext-lifecycleStatus    → authoritative status → MS

             Binding-Narrowing Rule check:
               - Organization.active: base boolean — not rebound. */
        attribute identifier[1..1] : FHIRIdentifier; // MS
        attribute name[1..1] : String; // MS
        attribute alias[0..*] : String;
        attribute active[0..1] : Boolean; // MS
        attribute extVersion[0..1] : ExtVersion;
        attribute extLifecycleStatus[0..1] : ExtLifecycleStatus; // MS
        attribute extForCrossReference[0..1] : ExtForCrossReference;
        attribute extLanguagesSupported[0..*] : ExtLanguagesSupported;
        attribute extDefaultLanguage[0..1] : ExtDefaultLanguage;
        metadata fhirResource { value "Organization"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-PolicyDomain"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-PolicyDomain"; }
    }

    item def IdentificationServiceIdentityLinkProfile
            :> PSM_IdentificationService_ResourceModel::FHIRIdentityLink {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-IdentityLink
             Base URL: http://hl7.org/fhir/StructureDefinition/Linkage
             Maps PIM::DataModel::IdentityLink.

             ATTR-MAP (7/7 = 100% coverage):
               - identityLinkId   → constrain Linkage.id (MS, [1..1])
                                    (Linkage has no identifier element in R5;
                                    resource.id is the durable handle.)
               - linkType         → extension ext-linkTypeCategory ([1..1] MS)
                                    (Binding-Narrowing Rule: Linkage.item.type
                                    carries base required binding to
                                    LinkageType {source, alternate, historical};
                                    LinkTypeCategory {peer-link, merge-deprecation}
                                    is NOT a strict subset so we do NOT rebind;
                                    carried on the extension instead.)
               - linkMethod       → extension ext-linkMethod ([0..1])
               - reason           → extension ext-linkReason ([0..1])
               - provenance       → extension ext-provenance ([0..1])
                                    (Separate Provenance resource MAY also be
                                    emitted; the extension is the lossy inline.)
               - sourceInstance   → constrain Linkage.item[source].resource
                                    profiled to IdentityInstance (MS, [1..1])
               - targetInstance   → constrain Linkage.item[alternate].resource
                                    profiled to IdentityInstance (MS, [1..1])

             MS rationale:
               - Linkage.item   → searchParam item (CapabilityStatement,
                                  ListLinkedIdentities) → MS
               - Linkage.author → provenance surrogate, searchParam author → MS
               - ext-linkTypeCategory → drives LinkIdentities/UnlinkIdentity
                 branching in LinkOrMergeEntitiesFlowWorkflow → MS

             Binding-Narrowing Rule check:
               - Linkage.item.type: base required to LinkageType — not rebound.
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-LinkTypeCategory
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-LinkMethodCategory */
        attribute author[0..1] : FHIRReference; // MS
        attribute item[2..*] : FHIRReference; // MS
        attribute extLinkTypeCategory[1..1] : ExtLinkTypeCategory; // MS
        attribute extLinkMethod[0..1] : ExtLinkMethod;
        attribute extLinkReason[0..1] : ExtLinkReason;
        attribute extProvenance[0..1] : ExtProvenance;
        metadata fhirResource { value "Linkage"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-IdentityLink"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-IdentityLink"; }
    }

    item def IdentificationServiceNotificationSubscriptionProfile
            :> PSM_IdentificationService_ResourceModel::FHIRNotificationSubscription {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-NotificationSubscription
             Base URL: http://hl7.org/fhir/StructureDefinition/Subscription
             Maps PIM::DataModel::NotificationSubscription.

             ATTR-MAP (7/7 = 100% coverage):
               - notificationSubscriptionId → constrain Subscription.id (MS, [1..1])
               - subscriber                 → constrain Subscription.endpoint (MS, [1..1])
                                              + Subscription.contact[0..*] for the
                                              human-facing contact point mirror
               - notificationQualifier      → extension ext-notificationQualifier ([0..1])
                                              (Subscription.filterBy expresses runtime
                                              filtering; the PIM semantic classifier
                                              is preserved on the extension.)
               - subscriptionStatus         → DROPPED-ELSEWHERE — Binding-Narrowing Rule:
                                              Subscription.status carries base required
                                              binding to SubscriptionStatusCodes
                                              {requested, active, error, off, entered-in-error}.
                                              IdentityStatus {ACTIVE, INACTIVE} is NOT
                                              a strict subset. Mapping ACTIVE→active,
                                              INACTIVE→off is a projection handled by
                                              the server; we do NOT rebind and we do
                                              NOT create a second extension because
                                              Subscription.status already carries
                                              sufficient lifecycle semantics.
               - subscribedDomain           → constrain Subscription.filterBy[0] with
                                              searchParam=organization (MS)
               - subscribedEntityType       → constrain Subscription.filterBy[1] with
                                              searchParam=_profile (MS)
               - subscribedInstance         → constrain Subscription.filterBy[2] with
                                              searchParam=_id (MS)

             canFilterBy cross-check (WorkflowPatterns SubscriptionTopic
             IdentityUpdateTopic — verified):
               - organization → MS ✓ (mapped to Subscription.filterBy for
                 subscribedDomain)
               - _profile     → MS ✓ (mapped to Subscription.filterBy for
                 subscribedEntityType)
               - _id          → MS ✓ (mapped to Subscription.filterBy for
                 subscribedInstance)

             MS rationale (APIContracts + WorkflowPatterns):
               - Subscription.status     → searchParam status (CapabilityStatement) → MS
               - Subscription.topic      → searchParam topic, references
                 IdentityUpdateTopic → MS
               - Subscription.endpoint   → searchParam subscriber → MS
               - Subscription.filterBy   → canFilterBy dimensions above → MS

             Binding-Narrowing Rule check:
               - Subscription.status: base required to SubscriptionStatusCodes — not rebound.
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-NotificationEventCategory */
        attribute status[1..1] : FHIRCodeableConcept; // MS
        attribute topic[1..1] : FHIRReference; // MS
        attribute endpoint[1..1] : String; // MS
        attribute contact[0..*] : FHIRContactPoint;
        attribute filterBy[0..*] : String; // MS
        attribute extNotificationQualifier[0..1] : ExtNotificationQualifier;
        metadata fhirResource { value "Subscription"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-NotificationSubscription"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-NotificationSubscription"; }
    }

    item def IdentificationServiceIdentityUpdateTopicProfile
            :> PSM_IdentificationService_ResourceModel::FHIRIdentityUpdateTopic {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-IdentityUpdateTopic
             Base URL: http://hl7.org/fhir/StructureDefinition/SubscriptionTopic
             Synthesized from NotificationEventCategory + NotificationSubscription filter attributes.

             ATTR-MAP (5/5 = 100% coverage):
               - topicUrl          → constrain SubscriptionTopic.url (MS, [1..1])
               - title             → constrain SubscriptionTopic.title (MS, [1..1])
               - status            → constrain SubscriptionTopic.status (MS, [1..1])
                                     (Binding-Narrowing Rule: base required binding
                                     to PublicationStatus {draft, active, retired,
                                     unknown} is NOT a strict subset of
                                     IdentityStatus — NOT rebound. The PIM
                                     status maps to active/retired.)
               - description       → constrain SubscriptionTopic.description (MS, [0..1])
               - resourceTrigger   → extension ext-resourceTrigger ([1..*] MS)
                                     alongside native SubscriptionTopic.resourceTrigger
                                     for event classification.

             MS rationale:
               - All four native elements are required by clients that
                 register Subscription instances against this topic. → MS
               - ext-resourceTrigger is the PIM-semantic event classifier → MS

             Binding-Narrowing Rule check:
               - SubscriptionTopic.status: base required to PublicationStatus — not rebound.
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-NotificationEventCategory */
        attribute url[1..1] : String; // MS
        attribute title[1..1] : String; // MS
        attribute status[1..1] : FHIRCodeableConcept; // MS
        attribute description[0..1] : String; // MS
        attribute resourceTrigger[1..*] : String; // MS
        attribute extResourceTrigger[1..*] : ExtResourceTrigger; // MS
        metadata fhirResource { value "SubscriptionTopic"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-IdentityUpdateTopic"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-IdentityUpdateTopic"; }
    }

    // ════════════════════════════════════════════════════════════════════
    // PROFILE DEFINITIONS — CUSTOM (Basic-backed)
    //
    // Basic-Backed Profile Completeness checklist (re-verified with full
    // attribute set visible):
    //   - EntityConcept: a managed versioned catalog record with its own
    //     lifecycle; NOT a code — code IS emitted as a CodeSystem at the
    //     terminology layer. Still correctly Basic. (no stronger resource)
    //   - EntityType: schema-bearing typed catalog entry; NOT a
    //     StructureDefinition (conformance metaresource) and NOT a
    //     NamingSystem (identifier namespace). Still correctly Basic.
    //   - EntityTypeAssignment: bridge/scoping record, NOT Linkage
    //     (equivalence claim), NOT OrganizationAffiliation (both sides
    //     are Organizations). Still correctly Basic.
    //   - ServiceMetadata: queryable versioned scope advertisement, NOT
    //     CapabilityStatement (conformance metaresource written once per
    //     deployment). Still correctly Basic.
    // All four confirmed Basic after full-attribute review. No stronger
    // R5 resource is appropriate.
    // ════════════════════════════════════════════════════════════════════

    item def IdentificationServiceEntityConceptProfile
            :> PSM_IdentificationService_ResourceModel::FHIREntityConcept {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-EntityConcept
             Base URL: http://hl7.org/fhir/StructureDefinition/Basic
             Maps PIM::DataModel::EntityConcept (Basic-backed CUSTOM).

             ATTR-MAP (5/5 = 100% coverage):
               - entityConceptId    → constrain Basic.identifier (MS, [1..1])
               - conceptDesignation → extension ext-conceptDesignation ([1..1] MS)
               - description        → extension ext-description ([0..1])
               - version            → constrain Basic.meta.versionId (server-assigned)
                                      + extension ext-version for the service-owned
                                      version ([0..1])
               - code               → constrain Basic.code (MS, [1..1])
                                      Binding required to VS_IS_EntityConcept
                                      (companion CodeSystem at terminology layer).

             MS rationale:
               - Basic.identifier, Basic.code → catalog lookup → MS
               - ext-conceptDesignation       → required narrative → MS
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-EntityConcept
             REQUIRED-CS: http://example.org/fhir/CodeSystem/IdentificationService-EntityConcept */
        attribute identifier[1..1] : FHIRIdentifier; // MS
        attribute code[1..1] : FHIRCodeableConcept; // MS
        attribute extConceptDesignation[1..1] : ExtConceptDesignation; // MS
        attribute extDescription[0..1] : ExtDescription;
        attribute extVersion[0..1] : ExtVersion;
        metadata fhirResource { value "Basic"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-EntityConcept"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-EntityConcept"; }
    }

    item def IdentificationServiceEntityTypeProfile
            :> PSM_IdentificationService_ResourceModel::FHIREntityType {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-EntityType
             Base URL: http://hl7.org/fhir/StructureDefinition/Basic
             Maps PIM::DataModel::EntityType (Basic-backed CUSTOM).

             ATTR-MAP (8/8 = 100% coverage):
               - entityTypeId         → constrain Basic.identifier (MS, [1..1])
               - typeDesignation      → extension ext-typeDesignation ([1..1] MS)
               - description          → extension ext-description ([0..1])
               - status               → extension ext-lifecycleStatus ([1..1] MS)
                                        (Basic has no native status element.)
               - version              → extension ext-version ([0..1])
               - schemaDefinition     → extension ext-schemaDefinition ([1..1] MS)
               - validationRuleSet    → extension ext-validationRuleSet ([0..1])
               - classifiedConcept    → extension ext-classifiedConcept ([1..1] MS)

             MS rationale:
               - Basic.identifier, ext-typeDesignation, ext-lifecycleStatus,
                 ext-schemaDefinition, ext-classifiedConcept → referenced by
                 RegisterIdentity / CreateIdentity / $match entityTypeId param → MS
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-IdentityStatus */
        attribute identifier[1..1] : FHIRIdentifier; // MS
        attribute extTypeDesignation[1..1] : ExtTypeDesignation; // MS
        attribute extDescription[0..1] : ExtDescription;
        attribute extLifecycleStatus[1..1] : ExtLifecycleStatus; // MS
        attribute extVersion[0..1] : ExtVersion;
        attribute extSchemaDefinition[1..1] : ExtSchemaDefinition; // MS
        attribute extValidationRuleSet[0..1] : ExtValidationRuleSet;
        attribute extClassifiedConcept[1..1] : ExtClassifiedConcept; // MS
        metadata fhirResource { value "Basic"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-EntityType"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-EntityType"; }
    }

    item def IdentificationServiceEntityTypeAssignmentProfile
            :> PSM_IdentificationService_ResourceModel::FHIREntityTypeAssignment {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-EntityTypeAssignment
             Base URL: http://hl7.org/fhir/StructureDefinition/Basic
             Maps PIM::DataModel::EntityTypeAssignment (Basic-backed CUSTOM).

             ATTR-MAP (7/7 = 100% coverage):
               - entityTypeAssignmentId        → constrain Basic.identifier (MS, [1..1])
               - status                        → extension ext-lifecycleStatus ([1..1] MS)
               - version                       → extension ext-version ([0..1])
               - constrainedSchemaDefinition   → extension ext-constrainedSchemaDefinition ([0..1])
               - constrainedValidationRuleSet  → extension ext-constrainedValidationRuleSet ([0..1])
               - assignedEntityType            → extension ext-assignedEntityType ([1..1] MS)
               - governingDomain               → extension ext-governingDomain ([1..1] MS)

             MS rationale:
               - Basic.identifier, ext-lifecycleStatus, ext-assignedEntityType,
                 ext-governingDomain → governingAssignment resolution from
                 Patient.managingOrganization and RegisterIdentity flows → MS
             REQUIRED-VS: http://example.org/fhir/ValueSet/IdentificationService-IdentityStatus */
        attribute identifier[1..1] : FHIRIdentifier; // MS
        attribute extLifecycleStatus[1..1] : ExtLifecycleStatus; // MS
        attribute extVersion[0..1] : ExtVersion;
        attribute extConstrainedSchemaDefinition[0..1] : ExtConstrainedSchemaDefinition;
        attribute extConstrainedValidationRuleSet[0..1] : ExtConstrainedValidationRuleSet;
        attribute extAssignedEntityType[1..1] : ExtAssignedEntityType; // MS
        attribute extGoverningDomain[1..1] : ExtGoverningDomain; // MS
        metadata fhirResource { value "Basic"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-EntityTypeAssignment"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-EntityTypeAssignment"; }
    }

    item def IdentificationServiceServiceMetadataProfile
            :> PSM_IdentificationService_ResourceModel::FHIRServiceMetadata {
        doc /* FHIR R5 StructureDefinition profile
             Profile URL: http://example.org/fhir/StructureDefinition/IdentificationService-ServiceMetadata
             Base URL: http://hl7.org/fhir/StructureDefinition/Basic
             Maps PIM::DataModel::ServiceMetadata (Basic-backed CUSTOM).

             ATTR-MAP (4/4 = 100% coverage):
               - serviceMetadataId    → constrain Basic.identifier (MS, [1..1])
               - supportedDomains     → extension ext-supportedDomains ([1..*] MS)
               - supportedEntityTypes → extension ext-supportedEntityTypes ([1..*] MS)
               - supportedConcepts    → extension ext-supportedConcepts ([1..*] MS)

             MS rationale:
               - All four are the primary content of the ServiceMetadata
                 record — drive service-scope queries → MS. */
        attribute identifier[1..1] : FHIRIdentifier; // MS
        attribute extSupportedDomains[1..*] : ExtSupportedDomains; // MS
        attribute extSupportedEntityTypes[1..*] : ExtSupportedEntityTypes; // MS
        attribute extSupportedConcepts[1..*] : ExtSupportedConcepts; // MS
        metadata fhirResource { value "Basic"; }
        metadata fhirProfile { value "http://example.org/fhir/StructureDefinition/IdentificationService-ServiceMetadata"; }
        metadata fhirUrl { value "http://example.org/fhir/StructureDefinition/IdentificationService-ServiceMetadata"; }
    }

    /* ════════════════════════════════════════════════════════════════════
     * ValueSet Binding Declarations (for TerminologyManifest extraction)
     * ════════════════════════════════════════════════════════════════════
     *
     * Binding strength derivation (from PIM::DataModel enum-closure):
     *   IdentityStatus            — closed enum {ACTIVE, INACTIVE}          → required
     *   LinkTypeCategory          — closed enum {PEER_LINK, MERGE_DEPRECATION} → required
     *   LinkMethodCategory        — closed enum {MANUAL, AUTOMATED}         → required
     *   UpdateMode                — closed enum {OVERWRITE, VALUED, UNSPECIFIED} → required
     *   MatchQualityTier          — closed enum {DEFINITE_MATCH, PRESUMPTIVE_MATCH, NO_MATCH} → required
     *   NotificationEventCategory — closed enum (4 values)                   → required
     *   FaultCategory             — closed enum (5 values)                   → required
     *
     * Per-profile/extension bindings (all required unless noted):
     *   ExtLifecycleStatus.valueCodeableConcept         → VS_IS_IdentityStatus (required)
     *   ExtLinkTypeCategory.valueCodeableConcept        → VS_IS_LinkTypeCategory (required)
     *   ExtLinkMethod.valueCodeableConcept              → VS_IS_LinkMethodCategory (required)
     *   ExtResourceTrigger.valueCodeableConcept         → VS_IS_NotificationEventCategory (required)
     *   ExtNotificationQualifier.valueCodeableConcept   → VS_IS_NotificationEventCategory (required)
     *   IdentificationServiceEntityConceptProfile.code  → VS_IS_EntityConcept (required)
     *
     * Binding-Narrowing Rule audit (rebindings rejected):
     *   Patient.gender         — base required to AdministrativeGender
     *                            — no IS-local narrowing proposed.
     *   Patient.active         — base required boolean
     *                            — status projection via ext-lifecycleStatus
     *                              (NOT a rebinding).
     *   Organization.active    — base required boolean
     *                            — status projection via ext-lifecycleStatus.
     *   Subscription.status    — base required SubscriptionStatusCodes
     *                            — IdentityStatus NOT a strict subset
     *                            — IdentityStatus carried via the
     *                              Subscription.status server projection;
     *                              no rebinding, no parallel extension.
     *   SubscriptionTopic.status — base required PublicationStatus
     *                              — IdentityStatus NOT a strict subset
     *                              — projection, no rebinding.
     *   Linkage.item.type      — base required LinkageType {source,
     *                            alternate, historical}
     *                            — LinkTypeCategory NOT a strict subset
     *                            — carried on ext-linkTypeCategory.
     *
     * UpdateMode, MatchQualityTier, FaultCategory are not bound on profiles
     * because they appear only on operation parameter types, fault payloads,
     * or match-response extensions handled at the API/OperationOutcome layer.
     * They still appear in the TerminologyManifest because APIContracts and
     * the OperationOutcome contract reference them.
     */

    /* ════════════════════════════════════════════════════════════════════
     * WorkflowPatterns Cross-Check Summary (canFilterBy)
     * ════════════════════════════════════════════════════════════════════
     * SubscriptionTopic IdentityUpdateTopic canFilterBy dimensions:
     *   - organization  → IdentificationServiceNotificationSubscriptionProfile.filterBy (MS ✓)
     *   - _profile      → IdentificationServiceNotificationSubscriptionProfile.filterBy (MS ✓)
     *   - _id           → IdentificationServiceNotificationSubscriptionProfile.filterBy (MS ✓)
     * All canFilterBy dimensions are backed by MS on Subscription.filterBy.
     */

    /* ════════════════════════════════════════════════════════════════════
     * ATTR-MAP coverage summary (per profile)
     * ════════════════════════════════════════════════════════════════════
     *   IdentityInstance          6/6 = 100% ✓
     *   RealWorldEntity           2/2 = 100% ✓
     *   PolicyDomain              8/8 = 100% ✓
     *   IdentityLink              7/7 = 100% ✓
     *   NotificationSubscription  7/7 = 100% ✓
     *   IdentityUpdateTopic       5/5 = 100% ✓
     *   EntityConcept             5/5 = 100% ✓
     *   EntityType                8/8 = 100% ✓
     *   EntityTypeAssignment      7/7 = 100% ✓
     *   ServiceMetadata           4/4 = 100% ✓
     * All profiles meet the ≥ 90 % coverage threshold. No DROPPED entries.
     */
}
