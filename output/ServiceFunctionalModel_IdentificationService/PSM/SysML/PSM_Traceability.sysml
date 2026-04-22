package PSM_IdentificationService_Traceability {

    /* PSM → PIM Traceability Map
     * =================================================================
     * SB3 PSM Integrator output. Every PSM element in the four track
     * packages (ResourceModel, ProfileDefinitions, APIContracts,
     * WorkflowPatterns) is linked here to its originating PIM element.
     * Per MagicDraw 2026x compatibility, no cross-package dependency
     * statements are used — traceability is entirely in doc comments.
     * PIM_Traceability.sysml is consulted for context but the
     * authoritative mapping here is PSM → PIM (not PSM → CIM).
     *
     * -----------------------------------------------------------------
     * [Data Track — ResourceModel]  (item defs specializing FHIR_R5_Base)
     * -----------------------------------------------------------------
     *   PSM_IdentificationService_ResourceModel::FHIRIdentityInstance
     *     → PIM_IS::DataModel::IdentityInstance                (realizes)
     *   PSM_IdentificationService_ResourceModel::FHIRRealWorldEntity
     *     → PIM_IS::DataModel::RealWorldEntity                 (realizes)
     *   PSM_IdentificationService_ResourceModel::FHIRPolicyDomain
     *     → PIM_IS::DataModel::PolicyDomain                    (realizes)
     *   PSM_IdentificationService_ResourceModel::FHIRIdentityLink
     *     → PIM_IS::DataModel::IdentityLink                    (realizes)
     *   PSM_IdentificationService_ResourceModel::FHIRNotificationSubscription
     *     → PIM_IS::DataModel::NotificationSubscription        (realizes)
     *   PSM_IdentificationService_ResourceModel::FHIRIdentityUpdateTopic
     *     → PIM_IS::DataModel::NotificationEventCategory +
     *       PIM_IS::DataModel::NotificationSubscription        (realizes — synthesized)
     *   PSM_IdentificationService_ResourceModel::FHIREntityConcept
     *     → PIM_IS::DataModel::EntityConcept                   (realizes)
     *   PSM_IdentificationService_ResourceModel::FHIREntityType
     *     → PIM_IS::DataModel::EntityType                      (realizes)
     *   PSM_IdentificationService_ResourceModel::FHIREntityTypeAssignment
     *     → PIM_IS::DataModel::EntityTypeAssignment            (realizes)
     *   PSM_IdentificationService_ResourceModel::FHIRServiceMetadata
     *     → PIM_IS::DataModel::ServiceMetadata                 (realizes)
     *
     * -----------------------------------------------------------------
     * [Data Track — ProfileDefinitions]  (profiles + extensions)
     * -----------------------------------------------------------------
     *   IdentificationServiceIdentityInstanceProfile
     *     → PIM_IS::DataModel::IdentityInstance                (constrains)
     *   IdentificationServiceRealWorldEntityProfile
     *     → PIM_IS::DataModel::RealWorldEntity                 (constrains)
     *   IdentificationServicePolicyDomainProfile
     *     → PIM_IS::DataModel::PolicyDomain                    (constrains)
     *   IdentificationServiceIdentityLinkProfile
     *     → PIM_IS::DataModel::IdentityLink                    (constrains)
     *   IdentificationServiceNotificationSubscriptionProfile
     *     → PIM_IS::DataModel::NotificationSubscription        (constrains)
     *   IdentificationServiceIdentityUpdateTopicProfile
     *     → PIM_IS::DataModel::NotificationEventCategory +
     *       PIM_IS::DataModel::NotificationSubscription        (constrains — synthesized)
     *   IdentificationServiceEntityConceptProfile
     *     → PIM_IS::DataModel::EntityConcept                   (constrains)
     *   IdentificationServiceEntityTypeProfile
     *     → PIM_IS::DataModel::EntityType                      (constrains)
     *   IdentificationServiceEntityTypeAssignmentProfile
     *     → PIM_IS::DataModel::EntityTypeAssignment            (constrains)
     *   IdentificationServiceServiceMetadataProfile
     *     → PIM_IS::DataModel::ServiceMetadata                 (constrains)
     *
     *   Extensions (ext-*, 26):
     *     ExtLifecycleStatus
     *       → PIM_IS::DataModel::IdentityStatus (enum projection used by
     *         IdentityInstance.status, PolicyDomain.status,
     *         EntityType.status, EntityTypeAssignment.status)   (extends)
     *     ExtPopulatedSignifierValues
     *       → PIM_IS::DataModel::IdentityInstance.populatedSignifierValues (extends)
     *     ExtEntityNature
     *       → PIM_IS::DataModel::RealWorldEntity.entityNature    (extends)
     *     ExtForCrossReference
     *       → PIM_IS::DataModel::PolicyDomain.forCrossReference  (extends)
     *     ExtLanguagesSupported
     *       → PIM_IS::DataModel::PolicyDomain.languagesSupported (extends)
     *     ExtDefaultLanguage
     *       → PIM_IS::DataModel::PolicyDomain.defaultLanguage    (extends)
     *     ExtProvenance
     *       → PIM_IS::DataModel::IdentityLink.provenance         (extends)
     *     ExtResourceTrigger
     *       → PIM_IS::DataModel::NotificationEventCategory       (extends)
     *     ExtSchemaDefinition
     *       → PIM_IS::DataModel::EntityType.schemaDefinition     (extends)
     *     ExtValidationRuleSet
     *       → PIM_IS::DataModel::EntityType.validationRuleSet    (extends)
     *     ExtConstrainedSchemaDefinition
     *       → PIM_IS::DataModel::EntityTypeAssignment.constrainedSchemaDefinition (extends)
     *     ExtConstrainedValidationRuleSet
     *       → PIM_IS::DataModel::EntityTypeAssignment.constrainedValidationRuleSet (extends)
     *     ExtInstanceDesignation
     *       → PIM_IS::DataModel::IdentityInstance.instanceDesignation (extends)
     *     ExtVersion
     *       → PIM_IS::DataModel::IdentityInstance.version +
     *         PIM_IS::DataModel::PolicyDomain.version +
     *         PIM_IS::DataModel::EntityType.version +
     *         PIM_IS::DataModel::EntityTypeAssignment.version    (extends)
     *     ExtLinkReason
     *       → PIM_IS::DataModel::IdentityLink.reason             (extends)
     *     ExtLinkMethod
     *       → PIM_IS::DataModel::IdentityLink.linkMethod +
     *         PIM_IS::DataModel::LinkMethodCategory              (extends)
     *     ExtLinkTypeCategory
     *       → PIM_IS::DataModel::IdentityLink.linkType +
     *         PIM_IS::DataModel::LinkTypeCategory                (extends)
     *     ExtNotificationQualifier
     *       → PIM_IS::DataModel::NotificationSubscription.notificationQualifier (extends)
     *     ExtConceptDesignation
     *       → PIM_IS::DataModel::EntityConcept.conceptDesignation (extends)
     *     ExtTypeDesignation
     *       → PIM_IS::DataModel::EntityType.typeDesignation       (extends)
     *     ExtDescription
     *       → PIM_IS::DataModel::EntityConcept.description +
     *         PIM_IS::DataModel::EntityType.description           (extends)
     *     ExtSupportedDomains
     *       → PIM_IS::DataModel::ServiceMetadata.supportedDomains (extends)
     *     ExtSupportedEntityTypes
     *       → PIM_IS::DataModel::ServiceMetadata.supportedEntityTypes (extends)
     *     ExtSupportedConcepts
     *       → PIM_IS::DataModel::ServiceMetadata.supportedConcepts (extends)
     *     ExtClassifiedConcept
     *       → PIM_IS::DataModel::EntityType.classifiedConcept     (extends)
     *     ExtAssignedEntityType
     *       → PIM_IS::DataModel::EntityTypeAssignment.assignedEntityType (extends)
     *     ExtGoverningDomain
     *       → PIM_IS::DataModel::EntityTypeAssignment.governingDomain    (extends)
     *
     * -----------------------------------------------------------------
     * [Behavior Track — APIContracts]  (action defs, REST + $ops)
     * -----------------------------------------------------------------
     *   RegisterIdentity
     *     → PIM_IS::Operations::RegisterIdentity               (realizes)
     *   CreateIdentity
     *     → PIM_IS::Operations::CreateIdentity                 (realizes)
     *   UpdateIdentityProperties
     *     → PIM_IS::Operations::UpdateIdentityProperties       (realizes)
     *   UpdateIdentityState
     *     → PIM_IS::Operations::UpdateIdentityState            (realizes)
     *   MergeIdentities
     *     → PIM_IS::Operations::MergeIdentities                (realizes)
     *   UnmergeIdentities
     *     → PIM_IS::Operations::UnmergeIdentities              (realizes)
     *   LinkIdentities
     *     → PIM_IS::Operations::LinkIdentities                 (realizes)
     *   UnlinkIdentity
     *     → PIM_IS::Operations::UnlinkIdentity                 (realizes)
     *   RemoveIdentityInstance
     *     → PIM_IS::Operations::RemoveIdentityInstance         (realizes)
     *   GetAllInformation
     *     → PIM_IS::Operations::GetAllInformation              (realizes)
     *   FindIdentitiesByProperty
     *     → PIM_IS::Operations::FindIdentitiesByProperty       (realizes)
     *   ListLinkedIdentities
     *     → PIM_IS::Operations::ListLinkedIdentities           (realizes)
     *   RequestIdentityUpdateNotifications
     *     → PIM_IS::Operations::RequestIdentityUpdateNotifications (realizes)
     *   UpdateNotificationSubscription
     *     → PIM_IS::Operations::UpdateNotificationSubscription (realizes)
     *
     * -----------------------------------------------------------------
     * [Behavior Track — WorkflowPatterns]  (flows + topic)
     * -----------------------------------------------------------------
     *   CreateNewPatientWorkflow
     *     → PIM_IS::BehavioralFlows::CreateNewPatientFlow       (realizes)
     *   LinkOrMergeEntitiesWorkflow
     *     → PIM_IS::BehavioralFlows::LinkOrMergeEntitiesFlow    (realizes)
     *   UpdateDemographicsWorkflow
     *     → PIM_IS::BehavioralFlows::UpdateDemographicsFlow     (realizes)
     *   UnlinkEntityWorkflow
     *     → PIM_IS::BehavioralFlows::UnlinkEntityFlow           (realizes)
     *   UnattendedEncounterWorkflow
     *     → PIM_IS::BehavioralFlows::UnattendedEncounterFlow    (realizes)
     *   CrossRegionLinkWorkflow
     *     → PIM_IS::BehavioralFlows::CrossRegionLinkFlow        (realizes)
     *   IdentityUpdateTopic
     *     → PIM_IS::Operations::NotifyIdentityUpdates +
     *       PIM_IS::DataModel::NotificationEventCategory        (realizes)
     *
     * =================================================================
     */

    /* Reconciliation Report
     * =================================================================
     *
     * RESOLVED CONFLICTS:
     *
     *   1. Profile-URL mismatch (Rule 3 — Inconsistent profile URLs).
     *      WHERE: WorkflowPatterns.sysml CapabilityStatement Summary
     *        (rest[0].resource[*].profile) listed three URLs that did
     *        not match the canonical URLs declared by ProfileDefinitions.
     *        Before:
     *           Patient      → .../IdentificationService-Patient
     *           Linkage      → .../IdentificationService-Linkage
     *           Subscription → .../IdentificationService-Subscription
     *        ProfileDefinitions (authoritative) declares:
     *           .../IdentificationService-IdentityInstance
     *           .../IdentificationService-IdentityLink
     *           .../IdentificationService-NotificationSubscription
     *      RESOLUTION: ProfileDefinitions is the canonical authority for
     *        profile URLs. Downstream SB4 MUST normalize the
     *        CapabilityStatement profile references to the
     *        ProfileDefinitions URLs above. The SubscriptionTopic
     *        reference (base .../SubscriptionTopic) remains correct as
     *        a base anchor; SB4 should ADDITIONALLY surface
     *        .../IdentificationService-IdentityUpdateTopic where the
     *        service-specific topic profile applies.
     *
     *   (No other conflicts detected.)
     *     - Rule 1 (Resource-name conflicts): APIContracts uses only
     *       FHIR R5 base type names (Patient, Linkage, Subscription,
     *       Bundle, Parameters, OperationOutcome) which are exempt per
     *       FHIR_R5_Base. ResourceModel uses FHIR{X} names
     *       consistently. NO CONFLICT.
     *     - Rule 2 (Missing cross-references): All types referenced by
     *       APIContracts and WorkflowPatterns are either declared in
     *       ResourceModel as item defs (FHIRIdentityInstance, etc.) or
     *       are exempt FHIR_R5_Base types (Patient, Linkage,
     *       Subscription, SubscriptionTopic, Bundle, Task, Parameters,
     *       OperationOutcome). NO MISSING REFS.
     *     - Rule 4 (Duplicate SubscriptionTopic definitions):
     *       ResourceModel/ProfileDefinitions declare the SHAPE of the
     *       topic (FHIRIdentityUpdateTopic item def +
     *       IdentificationServiceIdentityUpdateTopicProfile); Workflow
     *       Patterns declares the INSTANCE with event triggers and
     *       filter parameters (IdentityUpdateTopic). These are
     *       complementary, not duplicative. Behavior-Track instance
     *       retained as authority per contract. NO DUPLICATE.
     *
     * -----------------------------------------------------------------
     *
     * MS COVERAGE INTEGRATION CHECK:
     *
     *   Subcheck 1 — SearchParameter expressions → // MS:
     *     BASE SearchParameters (7 total) declared in APIContracts
     *     comment and echoed in the WorkflowPatterns CapabilityStatement:
     *       Patient.identifier
     *         → IdentificationServiceIdentityInstanceProfile.identifier (// MS) ✓
     *       Patient.organization (expression: Patient.managingOrganization)
     *         → IdentificationServiceIdentityInstanceProfile.managingOrganization (// MS) ✓
     *       Linkage.item
     *         → IdentificationServiceIdentityLinkProfile.item (// MS) ✓
     *       Linkage.source (expression: Linkage.item.where(type='source').resource)
     *         → derived from IdentificationServiceIdentityLinkProfile.item (// MS) ✓
     *       Linkage.author
     *         → IdentificationServiceIdentityLinkProfile.author (// MS) ✓
     *       Subscription.topic
     *         → IdentificationServiceNotificationSubscriptionProfile.topic (// MS) ✓
     *       Subscription.status
     *         → IdentificationServiceNotificationSubscriptionProfile.status (// MS) ✓
     *     CUSTOM SearchParameters declared: 0 (base parameters
     *     referenced by canonical URL only, not cloned).
     *     Result: 7/7 SearchParameters backed by // MS. NO GAP.
     *
     *   Subcheck 2 — SubscriptionTopic canFilterBy.filterParameter → // MS:
     *     IdentityUpdateTopic declares two canFilterBy entries (both on Patient):
     *       identifier
     *         → IdentificationServiceIdentityInstanceProfile.identifier (// MS) ✓
     *       organization
     *         → IdentificationServiceIdentityInstanceProfile.managingOrganization (// MS) ✓
     *     Result: 2/2 canFilterBy dimensions backed by // MS. NO GAP.
     *
     *   Subcheck 3 — $operation profile-typed parameter attributes → // MS:
     *     $match (FindIdentitiesByProperty — inherits Patient-match base):
     *       input param 'resource' : Patient probe — attributes invoked:
     *         identifier → IdentityInstanceProfile.identifier (// MS) ✓
     *         name       → IdentityInstanceProfile.name       (// MS) ✓
     *         birthDate  → IdentityInstanceProfile.birthDate  (// MS) ✓
     *         gender     → IdentityInstanceProfile.gender     (// MS) ✓
     *         address    → IdentityInstanceProfile.address    (// MS) ✓
     *       onlyCertainMatches, count : base scalar params (not profile-typed — N/A)
     *     $merge (MergeIdentities — custom, no base):
     *       source/target Patient identifiers
     *         → IdentityInstanceProfile.identifier (// MS) ✓
     *     $unmerge (UnmergeIdentities — custom, no base):
     *       source/target Patient identifiers
     *         → IdentityInstanceProfile.identifier (// MS) ✓
     *     $everything (GetAllInformation — inherits Patient-everything base):
     *       Patient.id implicit from URL path; start, end, _since, _type,
     *       _count are base scalar params (not profile-typed — N/A)
     *     Result: all profile-typed $operation parameter attributes
     *     carry // MS. NO GAP.
     *
     *   MS COVERAGE GAPS ROUTED TO SB2-D FOR CORRECTION: none.
     *
     * -----------------------------------------------------------------
     *
     * UNMAPPED PIM ELEMENTS (route to [SB1-D|SB1-B] for correction):
     *   (none)
     *
     *   All PIM DataModel item defs, Operations action defs, and
     *   BehavioralFlows flows have at least one PSM traceability entry
     *   above. Operation-parameter types (UpdateQualifier,
     *   SearchQualifier, MatchResult, IdentityNotification,
     *   ServiceFault) and the 30 Request/Response types are classified
     *   SKIPPED per ResourceModel quality report and are therefore
     *   excluded from the coverage denominator per contract. The seven
     *   PIM enums (IdentityStatus, LinkTypeCategory, LinkMethodCategory,
     *   UpdateMode, MatchQualityTier, FaultCategory,
     *   NotificationEventCategory) are carried by TerminologyManifest
     *   (SB2-D) as CodeSystem/ValueSet pairs, not by this PSM track;
     *   their semantic projection onto profiles/extensions is traced
     *   via Ext* entries above.
     *
     * -----------------------------------------------------------------
     *
     * COVERAGE:
     *
     *   Non-skipped PIM elements:
     *     DataModel item defs (9):
     *       IdentityInstance, RealWorldEntity, PolicyDomain,
     *       IdentityLink, NotificationSubscription, EntityConcept,
     *       EntityType, EntityTypeAssignment, ServiceMetadata
     *     Operations action defs (15):
     *       Register, Create, UpdateProps, UpdateState, Merge, Unmerge,
     *       Link, Unlink, Remove, GetAll, Find, ListLinked,
     *       RequestNotifications, UpdateSubscription, NotifyUpdates
     *     BehavioralFlows (6):
     *       CreateNewPatient, LinkOrMergeEntities, UpdateDemographics,
     *       UnlinkEntity, UnattendedEncounter, CrossRegionLink
     *     Subtotal non-skipped:     30
     *
     *   Mapped to ≥ 1 PSM element:  30
     *     - 9 DataModel → 9 ResourceModel item defs + 9 ProfileDefinitions
     *       profiles (plus the synthesized IdentityUpdateTopic pair
     *       traced separately to NotificationEventCategory +
     *       NotificationSubscription)
     *     - 15 Operations → 14 APIContracts action defs + 1
     *       WorkflowPatterns IdentityUpdateTopic (NotifyIdentityUpdates)
     *     - 6 BehavioralFlows → 6 WorkflowPatterns workflow action defs
     *
     *   COVERAGE:     30/30 = 100% ✓
     *   MS COVERAGE:  all three subchecks PASS = 100% ✓
     *                 (7/7 SearchParameters + 2/2 canFilterBy +
     *                  all profile-typed $operation params)
     *
     * =================================================================
     */
}
