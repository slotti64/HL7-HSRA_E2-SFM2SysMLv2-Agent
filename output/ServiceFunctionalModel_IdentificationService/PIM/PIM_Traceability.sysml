package PIM_IS {

    package PIM_Traceability {
        doc /* PIM-level Traceability for the HL7 Identification Service (IS).
             * Maps every PIM element back to its CIM antecedent(s) to ensure
             * complete vertical traceability from platform-independent design
             * back to business-level models.
             *
             * Traceability link types:
             *   - PIM Operations -> CIM Use Cases (realizes)
             *   - PIM Data Types -> CIM Domain Concepts (derives from)
             *   - PIM Flows -> CIM Business Scenarios (orchestrates)
             *   - PIM Ports/Interfaces -> CIM Capability Groups + Actors (exposes to)
             *   - PIM Composition Parts -> CIM Stakeholders (serves)
             *   - PIM State Model -> CIM Business Rules + Domain Concepts (implements)
             *
             * Cross-model traceability (PIM->CIM) uses structured doc comments.
             * Intra-PIM dependencies use formal dependency statements. */

        /* ===================================================================
         * SECTION 1: PIM OPERATIONS -> CIM USE CASES
         * Each PIM operation realizes exactly one CIM normative use case.
         * =================================================================== */

        /* --- Identity Management Operations --- */

        dependency from Operations::RegisterIdentity to Operations::RegisterIdentity {
            doc /* PIM Operations::RegisterIdentity realizes
                 * CIM BusinessCapabilities::identificationService::registerIdentity.
                 * [ST-082] FR-001, FR-002, FR-003, FR-005 */
        }

        dependency from Operations::CreateIdentity to Operations::CreateIdentity {
            doc /* PIM Operations::CreateIdentity realizes
                 * CIM BusinessCapabilities::identificationService::createIdentity.
                 * [ST-088] FR-003, FR-004, FR-005 */
        }

        dependency from Operations::UpdateIdentityProperties to Operations::UpdateIdentityProperties {
            doc /* PIM Operations::UpdateIdentityProperties realizes
                 * CIM BusinessCapabilities::identificationService::updateIdentityProperties.
                 * [ST-092] FR-006, FR-007 */
        }

        dependency from Operations::UpdateIdentityState to Operations::UpdateIdentityState {
            doc /* PIM Operations::UpdateIdentityState realizes
                 * CIM BusinessCapabilities::identificationService::updateIdentityState.
                 * [ST-097] FR-008, FR-009, FR-010, FR-011 */
        }

        dependency from Operations::MergeIdentities to Operations::MergeIdentities {
            doc /* PIM Operations::MergeIdentities realizes
                 * CIM BusinessCapabilities::identificationService::mergeIdentities.
                 * [ST-107] FR-012, FR-013, FR-014, FR-015 */
        }

        dependency from Operations::UnmergeIdentities to Operations::UnmergeIdentities {
            doc /* PIM Operations::UnmergeIdentities realizes
                 * CIM BusinessCapabilities::identificationService::unmergeIdentities.
                 * [ST-115] FR-016, FR-017 */
        }

        dependency from Operations::LinkIdentities to Operations::LinkIdentities {
            doc /* PIM Operations::LinkIdentities realizes
                 * CIM BusinessCapabilities::identificationService::linkIdentities.
                 * [ST-121] FR-018, FR-019, FR-020 */
        }

        dependency from Operations::UnlinkIdentity to Operations::UnlinkIdentity {
            doc /* PIM Operations::UnlinkIdentity realizes
                 * CIM BusinessCapabilities::identificationService::unlinkIdentity.
                 * [ST-129] FR-021 */
        }

        dependency from Operations::RemoveIdentityInstance to Operations::RemoveIdentityInstance {
            doc /* PIM Operations::RemoveIdentityInstance realizes
                 * CIM BusinessCapabilities::identificationService::removeIdentityInstance.
                 * [ST-133] FR-022, FR-023, FR-024 */
        }

        /* --- Query Operations --- */

        dependency from Operations::GetAllInformation to Operations::GetAllInformation {
            doc /* PIM Operations::GetAllInformation realizes
                 * CIM BusinessCapabilities::identificationService::getAllInformationForIdentity.
                 * [ST-140] FR-025, FR-026 */
        }

        dependency from Operations::FindIdentitiesByProperty to Operations::FindIdentitiesByProperty {
            doc /* PIM Operations::FindIdentitiesByProperty realizes
                 * CIM BusinessCapabilities::identificationService::findIdentitiesByProperty.
                 * [ST-146] FR-027, FR-028 */
        }

        dependency from Operations::ListLinkedIdentities to Operations::ListLinkedIdentities {
            doc /* PIM Operations::ListLinkedIdentities realizes
                 * CIM BusinessCapabilities::identificationService::listLinkedIdentities.
                 * [ST-150] FR-029 */
        }

        dependency from Operations::RequestIdentityUpdateNotifications to Operations::RequestIdentityUpdateNotifications {
            doc /* PIM Operations::RequestIdentityUpdateNotifications realizes
                 * CIM BusinessCapabilities::identificationService::requestIdentityUpdateNotifications.
                 * [ST-155] FR-030 */
        }

        dependency from Operations::UpdateNotificationSubscription to Operations::UpdateNotificationSubscription {
            doc /* PIM Operations::UpdateNotificationSubscription realizes
                 * CIM BusinessCapabilities::identificationService::updateNotificationSubscription.
                 * [ST-160] FR-031 */
        }

        dependency from Operations::NotifyIdentityUpdates to Operations::NotifyIdentityUpdates {
            doc /* PIM Operations::NotifyIdentityUpdates realizes
                 * CIM BusinessCapabilities::identificationService::notifyIdentityUpdates.
                 * [ST-164] FR-032 */
        }

        /* ===================================================================
         * SECTION 2: PIM DOMAIN DATA TYPES -> CIM BUSINESS DOMAIN CONCEPTS
         * Each PIM domain entity derives from its CIM counterpart.
         * =================================================================== */

        dependency from DataModel::PolicyDomain to DataModel::PolicyDomain {
            doc /* PIM DataModel::PolicyDomain derives from
                 * CIM BusinessDomain::PolicyDomain.
                 * [ST-030, ST-068, ST-069] */
        }

        dependency from DataModel::EntityConcept to DataModel::EntityConcept {
            doc /* PIM DataModel::EntityConcept derives from
                 * CIM BusinessDomain::EntityConcept.
                 * [ST-002, ST-072, ST-073] */
        }

        dependency from DataModel::EntityType to DataModel::EntityType {
            doc /* PIM DataModel::EntityType derives from
                 * CIM BusinessDomain::EntityType.
                 * [ST-071, ST-070, ST-003] */
        }

        dependency from DataModel::EntityTypeAssignment to DataModel::EntityTypeAssignment {
            doc /* PIM DataModel::EntityTypeAssignment derives from
                 * CIM BusinessDomain::EntityTypeAssignment.
                 * [ST-074, ST-075] */
        }

        dependency from DataModel::IdentityInstance to DataModel::IdentityInstance {
            doc /* PIM DataModel::IdentityInstance derives from
                 * CIM BusinessDomain::IdentityInstance.
                 * [ST-076, ST-091] */
        }

        dependency from DataModel::IdentityLink to DataModel::IdentityLink {
            doc /* PIM DataModel::IdentityLink derives from
                 * CIM BusinessDomain::IdentityLink.
                 * [ST-077, ST-078, ST-079] */
        }

        dependency from DataModel::RealWorldEntity to DataModel::RealWorldEntity {
            doc /* PIM DataModel::RealWorldEntity derives from
                 * CIM BusinessDomain::RealWorldEntity.
                 * [ST-002, ST-005] */
        }

        dependency from DataModel::UpdateQualifier to DataModel::UpdateQualifier {
            doc /* PIM DataModel::UpdateQualifier derives from
                 * CIM BusinessDomain::UpdateQualifier.
                 * [ST-096] */
        }

        dependency from DataModel::SearchQualifier to DataModel::SearchQualifier {
            doc /* PIM DataModel::SearchQualifier derives from
                 * CIM BusinessDomain::SearchQualifier.
                 * [ST-146, ST-147] */
        }

        dependency from DataModel::NotificationSubscription to DataModel::NotificationSubscription {
            doc /* PIM DataModel::NotificationSubscription derives from
                 * CIM BusinessDomain::NotificationSubscription.
                 * [ST-155, ST-159, ST-167] */
        }

        dependency from DataModel::ServiceMetadata to DataModel::ServiceMetadata {
            doc /* PIM DataModel::ServiceMetadata derives from
                 * CIM BusinessDomain::ServiceMetadata.
                 * [ST-211] */
        }

        /* ===================================================================
         * SECTION 3: PIM-DERIVED DATA TYPES -> CIM SUPPORTING CONCEPTS
         * Types created at PIM level that derive from CIM use case semantics.
         * =================================================================== */

        dependency from DataModel::MatchResult to DataModel::MatchResult {
            doc /* PIM DataModel::MatchResult derives from
                 * CIM BusinessCapabilities::identificationService::findIdentitiesByProperty
                 * output semantics and CIM BusinessDomain::MatchConfidence.
                 * [ST-146, ST-148, ST-172] */
        }

        dependency from DataModel::IdentityNotification to DataModel::IdentityNotification {
            doc /* PIM DataModel::IdentityNotification derives from
                 * CIM BusinessCapabilities::identificationService::notifyIdentityUpdates
                 * output semantics.
                 * [ST-164, ST-165, ST-167] */
        }

        dependency from DataModel::ServiceFault to DataModel::ServiceFault {
            doc /* PIM DataModel::ServiceFault derives from
                 * CIM BusinessRules::ExceptionMessagesDelegated.
                 * [ST-169, ST-218] */
        }

        /* ===================================================================
         * SECTION 4: PIM ENUMERATIONS -> CIM DOMAIN ENUMERATIONS
         * =================================================================== */

        dependency from DataModel::IdentityStatus to DataModel::IdentityStatus {
            doc /* PIM DataModel::IdentityStatus derives from
                 * CIM BusinessDomain::IdentityStatus.
                 * [ST-105, ST-106, ST-222] */
        }

        dependency from DataModel::LinkTypeCategory to DataModel::LinkTypeCategory {
            doc /* PIM DataModel::LinkTypeCategory derives from
                 * CIM BusinessDomain::LinkTypeCategory.
                 * [ST-220, ST-079] */
        }

        dependency from DataModel::LinkMethodCategory to DataModel::LinkMethodCategory {
            doc /* PIM DataModel::LinkMethodCategory derives from
                 * CIM BusinessDomain::LinkMethodCategory.
                 * [ST-221, ST-081] */
        }

        dependency from DataModel::UpdateMode to DataModel::UpdateMode {
            doc /* PIM DataModel::UpdateMode derives from
                 * CIM BusinessDomain::UpdateMode.
                 * [ST-096] */
        }

        dependency from DataModel::MatchQualityTier to DataModel::MatchQualityTier {
            doc /* PIM DataModel::MatchQualityTier derives from
                 * CIM BusinessDomain::MatchQualityTier.
                 * [ST-172, ST-205] */
        }

        dependency from DataModel::FaultCategory to DataModel::FaultCategory {
            doc /* PIM DataModel::FaultCategory derives from
                 * CIM BusinessRules::ExceptionMessagesDelegated error classification.
                 * [ST-169, ST-218] */
        }

        dependency from DataModel::NotificationEventCategory to DataModel::NotificationEventCategory {
            doc /* PIM DataModel::NotificationEventCategory derives from
                 * CIM BusinessDomain::NotificationQualifier narrative descriptions.
                 * [ST-156, ST-159] */
        }

        /* ===================================================================
         * SECTION 5: PIM REQUEST/RESPONSE TYPES -> CIM USE CASE I/O
         * Each request/response pair derives from the corresponding CIM use
         * case input/output semantics.
         * =================================================================== */

        /* --- Register Identity --- */
        dependency from DataModel::RegisterIdentityRequest to DataModel::RegisterIdentityRequest {
            doc /* Derives from CIM use case registerIdentity inputs.
                 * [ST-082, ST-083, ST-084] */
        }
        dependency from DataModel::RegisterIdentityResponse to DataModel::RegisterIdentityResponse {
            doc /* Derives from CIM use case registerIdentity outputs.
                 * [ST-082] */
        }

        /* --- Create Identity --- */
        dependency from DataModel::CreateIdentityRequest to DataModel::CreateIdentityRequest {
            doc /* Derives from CIM use case createIdentity inputs.
                 * [ST-088, ST-089, ST-090] */
        }
        dependency from DataModel::CreateIdentityResponse to DataModel::CreateIdentityResponse {
            doc /* Derives from CIM use case createIdentity outputs.
                 * [ST-088] */
        }

        /* --- Update Identity Properties --- */
        dependency from DataModel::UpdateIdentityPropertiesRequest to DataModel::UpdateIdentityPropertiesRequest {
            doc /* Derives from CIM use case updateIdentityProperties inputs.
                 * [ST-092, ST-093, ST-094, ST-095, ST-096] */
        }
        dependency from DataModel::UpdateIdentityPropertiesResponse to DataModel::UpdateIdentityPropertiesResponse {
            doc /* Derives from CIM use case updateIdentityProperties outputs.
                 * [ST-092] */
        }

        /* --- Update Identity State --- */
        dependency from DataModel::UpdateIdentityStateRequest to DataModel::UpdateIdentityStateRequest {
            doc /* Derives from CIM use case updateIdentityState inputs.
                 * [ST-097, ST-098, ST-099] */
        }
        dependency from DataModel::UpdateIdentityStateResponse to DataModel::UpdateIdentityStateResponse {
            doc /* Derives from CIM use case updateIdentityState outputs.
                 * [ST-097] */
        }

        /* --- Merge Identities --- */
        dependency from DataModel::MergeIdentitiesRequest to DataModel::MergeIdentitiesRequest {
            doc /* Derives from CIM use case mergeIdentities inputs.
                 * [ST-107, ST-108, ST-112] */
        }
        dependency from DataModel::MergeIdentitiesResponse to DataModel::MergeIdentitiesResponse {
            doc /* Derives from CIM use case mergeIdentities outputs.
                 * [ST-107] */
        }

        /* --- Unmerge Identities --- */
        dependency from DataModel::UnmergeIdentitiesRequest to DataModel::UnmergeIdentitiesRequest {
            doc /* Derives from CIM use case unmergeIdentities inputs.
                 * [ST-115, ST-116, ST-117] */
        }
        dependency from DataModel::UnmergeIdentitiesResponse to DataModel::UnmergeIdentitiesResponse {
            doc /* Derives from CIM use case unmergeIdentities outputs.
                 * [ST-115] */
        }

        /* --- Link Identities --- */
        dependency from DataModel::LinkIdentitiesRequest to DataModel::LinkIdentitiesRequest {
            doc /* Derives from CIM use case linkIdentities inputs.
                 * [ST-121, ST-122, ST-124] */
        }
        dependency from DataModel::LinkIdentitiesResponse to DataModel::LinkIdentitiesResponse {
            doc /* Derives from CIM use case linkIdentities outputs.
                 * [ST-121] */
        }

        /* --- Unlink Identity --- */
        dependency from DataModel::UnlinkIdentityRequest to DataModel::UnlinkIdentityRequest {
            doc /* Derives from CIM use case unlinkIdentity inputs.
                 * [ST-129, ST-130] */
        }
        dependency from DataModel::UnlinkIdentityResponse to DataModel::UnlinkIdentityResponse {
            doc /* Derives from CIM use case unlinkIdentity outputs.
                 * [ST-129] */
        }

        /* --- Remove Identity Instance --- */
        dependency from DataModel::RemoveIdentityInstanceRequest to DataModel::RemoveIdentityInstanceRequest {
            doc /* Derives from CIM use case removeIdentityInstance inputs.
                 * [ST-133, ST-134] */
        }
        dependency from DataModel::RemoveIdentityInstanceResponse to DataModel::RemoveIdentityInstanceResponse {
            doc /* Derives from CIM use case removeIdentityInstance outputs.
                 * [ST-133] */
        }

        /* --- Get All Information --- */
        dependency from DataModel::GetAllInformationRequest to DataModel::GetAllInformationRequest {
            doc /* Derives from CIM use case getAllInformationForIdentity inputs.
                 * [ST-140, ST-142, ST-143] */
        }
        dependency from DataModel::GetAllInformationResponse to DataModel::GetAllInformationResponse {
            doc /* Derives from CIM use case getAllInformationForIdentity outputs.
                 * [ST-140, ST-141] */
        }

        /* --- Find Identities By Property --- */
        dependency from DataModel::FindIdentitiesByPropertyRequest to DataModel::FindIdentitiesByPropertyRequest {
            doc /* Derives from CIM use case findIdentitiesByProperty inputs.
                 * [ST-146, ST-147] */
        }
        dependency from DataModel::FindIdentitiesByPropertyResponse to DataModel::FindIdentitiesByPropertyResponse {
            doc /* Derives from CIM use case findIdentitiesByProperty outputs.
                 * [ST-146, ST-148] */
        }

        /* --- List Linked Identities --- */
        dependency from DataModel::ListLinkedIdentitiesRequest to DataModel::ListLinkedIdentitiesRequest {
            doc /* Derives from CIM use case listLinkedIdentities inputs.
                 * [ST-150, ST-151, ST-152] */
        }
        dependency from DataModel::ListLinkedIdentitiesResponse to DataModel::ListLinkedIdentitiesResponse {
            doc /* Derives from CIM use case listLinkedIdentities outputs.
                 * [ST-150, ST-153] */
        }

        /* --- Request Notifications --- */
        dependency from DataModel::RequestNotificationsRequest to DataModel::RequestNotificationsRequest {
            doc /* Derives from CIM use case requestIdentityUpdateNotifications inputs.
                 * [ST-155, ST-156] */
        }
        dependency from DataModel::RequestNotificationsResponse to DataModel::RequestNotificationsResponse {
            doc /* Derives from CIM use case requestIdentityUpdateNotifications outputs.
                 * [ST-155] */
        }

        /* --- Update Notification Subscription --- */
        dependency from DataModel::UpdateNotificationSubscriptionRequest to DataModel::UpdateNotificationSubscriptionRequest {
            doc /* Derives from CIM use case updateNotificationSubscription inputs.
                 * [ST-160, ST-161, ST-162] */
        }
        dependency from DataModel::UpdateNotificationSubscriptionResponse to DataModel::UpdateNotificationSubscriptionResponse {
            doc /* Derives from CIM use case updateNotificationSubscription outputs.
                 * [ST-160] */
        }

        /* --- Notify Identity Updates --- */
        dependency from DataModel::NotifyIdentityUpdatesRequest to DataModel::NotifyIdentityUpdatesRequest {
            doc /* Derives from CIM use case notifyIdentityUpdates inputs.
                 * [ST-164, ST-165] */
        }
        dependency from DataModel::NotifyIdentityUpdatesResponse to DataModel::NotifyIdentityUpdatesResponse {
            doc /* Derives from CIM use case notifyIdentityUpdates outputs.
                 * [ST-164, ST-167] */
        }

        /* ===================================================================
         * SECTION 6: PIM SERVICE CONTRACTS -> CIM CAPABILITY GROUPS + ACTORS
         * =================================================================== */

        dependency from ServiceContracts::IdentificationManagementPort
            to ServiceContracts::IdentificationManagementPort {
            doc /* PIM IdentificationManagementPort exposes interface for
                 * CIM Identity Management capability group [ST-026].
                 * Consumed by CIM actors: RegistrationClerk, IdentityResolutionClerk,
                 * ServiceAdministrator, ExternalSystem [ST-212, ST-214, ST-215, ST-216]. */
        }

        dependency from ServiceContracts::QueryPort
            to ServiceContracts::QueryPort {
            doc /* PIM QueryPort exposes interface for
                 * CIM Query capability group [ST-027].
                 * Consumed by CIM actors: RegistrationClerk, ClinicalUser,
                 * LaboratoryClerk, ExternalSystem [ST-212, ST-213, ST-216]. */
        }

        dependency from ServiceContracts::IdentificationManagementAPI
            to ServiceContracts::IdentificationManagementAPI {
            doc /* PIM IdentificationManagementAPI defines the contract for
                 * CIM Identity Management interface [ST-025, ST-026].
                 * Connects service consumers to management operations. */
        }

        dependency from ServiceContracts::QueryAPI
            to ServiceContracts::QueryAPI {
            doc /* PIM QueryAPI defines the contract for
                 * CIM Query interface [ST-025, ST-027].
                 * Connects service consumers to query and notification operations. */
        }

        /* ===================================================================
         * SECTION 7: PIM BEHAVIORAL FLOWS -> CIM BUSINESS SCENARIOS
         * Each PIM flow orchestrates a CIM business scenario.
         * =================================================================== */

        dependency from BehavioralFlows::CreateNewPatientFlow
            to BehavioralFlows::CreateNewPatientFlow {
            doc /* PIM CreateNewPatientFlow orchestrates
                 * CIM BusinessCapabilities::singleDomainScenarios::createNewPatient.
                 * Composes: FindIdentitiesByProperty, RegisterIdentity.
                 * [ST-048, ST-049, ST-050, ST-051] */
        }

        dependency from BehavioralFlows::LinkOrMergeEntitiesFlow
            to BehavioralFlows::LinkOrMergeEntitiesFlow {
            doc /* PIM LinkOrMergeEntitiesFlow orchestrates
                 * CIM BusinessCapabilities::singleDomainScenarios::linkOrMergeEntities.
                 * Composes: FindIdentitiesByProperty, LinkIdentities or MergeIdentities.
                 * [ST-052, ST-053, ST-054, ST-055] */
        }

        dependency from BehavioralFlows::UpdateDemographicsFlow
            to BehavioralFlows::UpdateDemographicsFlow {
            doc /* PIM UpdateDemographicsFlow orchestrates
                 * CIM BusinessCapabilities::singleDomainScenarios::updateDemographics.
                 * Composes: FindIdentitiesByProperty, GetAllInformation,
                 * UpdateIdentityProperties.
                 * [ST-056, ST-057, ST-058] */
        }

        dependency from BehavioralFlows::UnlinkEntityFlow
            to BehavioralFlows::UnlinkEntityFlow {
            doc /* PIM UnlinkEntityFlow orchestrates
                 * CIM BusinessCapabilities::singleDomainScenarios::unlinkEntity.
                 * Composes: FindIdentitiesByProperty, ListLinkedIdentities,
                 * UnlinkIdentity.
                 * [ST-064, ST-065, ST-066] */
        }

        dependency from BehavioralFlows::UnattendedEncounterFlow
            to BehavioralFlows::UnattendedEncounterFlow {
            doc /* PIM UnattendedEncounterFlow orchestrates
                 * CIM BusinessCapabilities::singleDomainScenarios::unattendedEncounter.
                 * Composes: FindIdentitiesByProperty, conditionally CreateIdentity.
                 * [ST-187, ST-188, ST-189, ST-190, ST-191] */
        }

        dependency from BehavioralFlows::CrossRegionLinkFlow
            to BehavioralFlows::CrossRegionLinkFlow {
            doc /* PIM CrossRegionLinkFlow orchestrates
                 * CIM BusinessCapabilities::multiDomainScenarios::linkEntitiesAcrossRegions.
                 * Composes: FindIdentitiesByProperty, RegisterIdentity, LinkIdentities.
                 * [ST-200, ST-201] */
        }

        /* ===================================================================
         * SECTION 8: PIM COMPOSITION PARTS -> CIM STAKEHOLDERS
         * =================================================================== */

        dependency from Composition::IdentificationServiceProvider
            to Composition::IdentificationServiceProvider {
            doc /* PIM IdentificationServiceProvider serves
                 * CIM BusinessCapabilities::identificationService [ST-001, ST-004].
                 * Exposes all 15 normative operations via two interface endpoints. */
        }

        dependency from Composition::ClinicalSystemConsumer
            to Composition::ClinicalSystemConsumer {
            doc /* PIM ClinicalSystemConsumer serves
                 * CIM StakeholderModel::RegistrationClerk [ST-212],
                 * CIM StakeholderModel::ClinicalUser [ST-213],
                 * CIM StakeholderModel::LaboratoryClerk [ST-046],
                 * CIM StakeholderModel::ServiceAdministrator [ST-215],
                 * via CIM BusinessDomain::HospitalInformationSystem [ST-045, ST-206]. */
        }

        dependency from Composition::ReferralSystemConsumer
            to Composition::ReferralSystemConsumer {
            doc /* PIM ReferralSystemConsumer serves
                 * CIM StakeholderModel::ExternalSystem [ST-216],
                 * CIM StakeholderModel::ReferralSystem [ST-187]. */
        }

        dependency from Composition::FederatedISConsumer
            to Composition::FederatedISConsumer {
            doc /* PIM FederatedISConsumer serves
                 * CIM StakeholderModel::RegionalHealthNetwork [ST-195, ST-035].
                 * Enables cross-domain identity resolution and linking. */
        }

        dependency from Composition::IdentificationServiceSystem
            to Composition::IdentificationServiceSystem {
            doc /* PIM IdentificationServiceSystem realizes the top-level
                 * CIM BusinessCapabilities::identificationService system [ST-001].
                 * Composes provider and all consumer categories with typed connections. */
        }

        /* ===================================================================
         * SECTION 9: PIM STATE MODEL -> CIM BUSINESS RULES + DOMAIN CONCEPTS
         * =================================================================== */

        dependency from Composition::IdentityLifecycleState
            to Composition::IdentityLifecycleState {
            doc /* PIM IdentityLifecycleState implements
                 * CIM BusinessDomain::IdentityStatus [ST-105, ST-106, ST-222],
                 * CIM BusinessRules::StateChangePrecondition [ST-104],
                 * CIM BusinessRules::MergePreconditions [ST-107].
                 * Models: active, inactive, deprecated states and transitions. */
        }

        /* ===================================================================
         * COMPLETENESS SELF-CHECK
         * ===================================================================
         *
         * PIM Elements from DataModel (SA4):
         *   [x] FaultCategory -> CIM BusinessRules::ExceptionMessagesDelegated
         *   [x] ServiceFault -> CIM BusinessRules::ExceptionMessagesDelegated
         *   [x] IdentityStatus -> CIM BusinessDomain::IdentityStatus
         *   [x] LinkTypeCategory -> CIM BusinessDomain::LinkTypeCategory
         *   [x] LinkMethodCategory -> CIM BusinessDomain::LinkMethodCategory
         *   [x] UpdateMode -> CIM BusinessDomain::UpdateMode
         *   [x] MatchQualityTier -> CIM BusinessDomain::MatchQualityTier
         *   [x] NotificationEventCategory -> CIM BusinessDomain::NotificationQualifier
         *   [x] PolicyDomain -> CIM BusinessDomain::PolicyDomain
         *   [x] EntityConcept -> CIM BusinessDomain::EntityConcept
         *   [x] EntityType -> CIM BusinessDomain::EntityType
         *   [x] EntityTypeAssignment -> CIM BusinessDomain::EntityTypeAssignment
         *   [x] IdentityInstance -> CIM BusinessDomain::IdentityInstance
         *   [x] IdentityLink -> CIM BusinessDomain::IdentityLink
         *   [x] RealWorldEntity -> CIM BusinessDomain::RealWorldEntity
         *   [x] UpdateQualifier -> CIM BusinessDomain::UpdateQualifier
         *   [x] SearchQualifier -> CIM BusinessDomain::SearchQualifier
         *   [x] NotificationSubscription -> CIM BusinessDomain::NotificationSubscription
         *   [x] ServiceMetadata -> CIM BusinessDomain::ServiceMetadata
         *   [x] MatchResult -> CIM findIdentitiesByProperty + MatchConfidence
         *   [x] IdentityNotification -> CIM notifyIdentityUpdates
         *   [x] All 30 Request/Response types -> CIM use case I/O
         *
         * PIM Elements from Operations (SA4):
         *   [x] All 15 operations -> CIM use cases (1:1)
         *
         * PIM Elements from ServiceContracts (SA4):
         *   [x] IdentificationManagementPort -> CIM capability group [ST-026]
         *   [x] QueryPort -> CIM capability group [ST-027]
         *   [x] IdentificationManagementAPI -> CIM management interface [ST-025]
         *   [x] QueryAPI -> CIM query interface [ST-025]
         *
         * PIM Elements from BehavioralFlows (SA5):
         *   [x] CreateNewPatientFlow -> CIM createNewPatient [ST-048]
         *   [x] LinkOrMergeEntitiesFlow -> CIM linkOrMergeEntities [ST-052]
         *   [x] UpdateDemographicsFlow -> CIM updateDemographics [ST-056]
         *   [x] UnlinkEntityFlow -> CIM unlinkEntity [ST-064]
         *   [x] UnattendedEncounterFlow -> CIM unattendedEncounter [ST-187]
         *   [x] CrossRegionLinkFlow -> CIM linkEntitiesAcrossRegions [ST-200]
         *
         * PIM Elements from Composition (SA5):
         *   [x] IdentificationServiceProvider -> CIM identificationService
         *   [x] ClinicalSystemConsumer -> CIM RegistrationClerk, ClinicalUser, etc.
         *   [x] ReferralSystemConsumer -> CIM ExternalSystem, ReferralSystem
         *   [x] FederatedISConsumer -> CIM RegionalHealthNetwork
         *   [x] IdentificationServiceSystem -> CIM identificationService top-level
         *   [x] IdentityLifecycleState -> CIM IdentityStatus + BusinessRules
         *
         * RESULT: All PIM elements have at least one CIM traceability link.
         * No orphaned elements detected.
         * =================================================================== */
    }
}
