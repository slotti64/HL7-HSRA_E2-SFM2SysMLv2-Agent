package PIM_IS {

    package DataModel {
        doc /* PIM-level Data Model for the HL7 Identification Service (IS).
             * Contains all platform-independent item definitions, enumeration types,
             * Request/Response pairs for every operation, and standard error semantics.
             * All types are derived from CIM::BusinessDomain entities with technical
             * identifiers and typed attributes added at PIM level. */

        /* ===================================================================
         * STANDARD ERROR SEMANTICS
         * =================================================================== */

        enum def FaultCategory {
            doc /* Standard fault categories for classifying service errors.
                 * Derived from CIM::BusinessRules::ExceptionMessagesDelegated [ST-169, ST-218]. */
            enum VALIDATION;
            enum AUTHORIZATION;
            enum NOT_FOUND;
            enum BUSINESS_RULE_VIOLATION;
            enum INTERNAL;
        }

        item def ServiceFault {
            doc /* Standard error type returned by all service operations when an
                 * exception condition is encountered.
                 * Derived from CIM::BusinessRules::ExceptionMessagesDelegated [ST-169, ST-218]
                 * and FR-038 (report operation exceptions). */
            attribute faultCode : String;
            attribute faultMessage : String;
            attribute faultCategory : FaultCategory;
        }

        /* ===================================================================
         * ENUMERATIONS (derived from CIM::BusinessDomain enumerations)
         * =================================================================== */

        enum def IdentityStatus {
            doc /* Derived from CIM::BusinessDomain::IdentityStatus.
                 * Lifecycle states an identity instance or metadata element may occupy.
                 * Minimum mandatory set is ACTIVE and INACTIVE. [ST-105, ST-106, ST-222] */
            enum ACTIVE;
            enum INACTIVE;
        }

        enum def LinkTypeCategory {
            doc /* Derived from CIM::BusinessDomain::LinkTypeCategory.
                 * Indicates whether linked identities are active peers or whether one
                 * is deprecated as in a merge. [ST-220, ST-079] */
            enum PEER_LINK;
            enum MERGE_DEPRECATION;
        }

        enum def LinkMethodCategory {
            doc /* Derived from CIM::BusinessDomain::LinkMethodCategory.
                 * Coded value for how a link between identities was established.
                 * [ST-221, ST-081] */
            enum MANUAL;
            enum AUTOMATED;
        }

        enum def UpdateMode {
            doc /* Derived from CIM::BusinessDomain::UpdateMode.
                 * Indicates the mode for an identity property update process.
                 * [ST-096] */
            enum OVERWRITE;
            enum VALUED;
            enum UNSPECIFIED;
        }

        enum def MatchQualityTier {
            doc /* Derived from CIM::BusinessDomain::MatchQualityTier.
                 * Confidence tier of a match result using two-tiered threshold.
                 * [ST-172, ST-205] */
            enum DEFINITE_MATCH;
            enum PRESUMPTIVE_MATCH;
            enum NO_MATCH;
        }

        enum def NotificationEventCategory {
            doc /* PIM-derived enumeration for classifying notification event types.
                 * Derived from CIM::BusinessDomain::NotificationQualifier narrative
                 * descriptions of event types. [ST-156, ST-159] */
            enum PROPERTY_CHANGE;
            enum STATUS_CHANGE;
            enum LINK_CHANGE;
            enum MERGE_CHANGE;
        }

        /* ===================================================================
         * DOMAIN ENTITY TYPES (derived from CIM::BusinessDomain item defs)
         * =================================================================== */

        item def PolicyDomain {
            doc /* Derived from CIM::BusinessDomain::PolicyDomain.
                 * An identity space or sphere of use of entity identifiers.
                 * May be organizational, geographical, or jurisdictional.
                 * [ST-030, ST-031, ST-032, ST-068, ST-069] */
            attribute policyDomainId : String;
            attribute domainDesignation : String;
            attribute description : String;
            attribute version : String;
            attribute status : IdentityStatus;
            attribute forCrossReference : Boolean [0..1];
            attribute languagesSupported : String [0..*];
            attribute defaultLanguage : String;
        }

        item def EntityConcept {
            doc /* Derived from CIM::BusinessDomain::EntityConcept.
                 * A semantic concept or category of information that may be supported
                 * in an Identification Service. Provides the capability to specify a
                 * semantic relationship between different EntityType representations.
                 * [ST-002, ST-072, ST-073] */
            attribute entityConceptId : String;
            attribute conceptDesignation : String;
            attribute description : String;
            attribute version : String;
        }

        item def EntityType {
            doc /* Derived from CIM::BusinessDomain::EntityType.
                 * A specific type of entity that an Identification Service supports
                 * at the level of a specific information model (semantic signifier).
                 * [ST-071, ST-070, ST-003] */
            attribute entityTypeId : String;
            attribute typeDesignation : String;
            attribute description : String;
            attribute status : IdentityStatus;
            attribute version : String;
            attribute schemaDefinition : String;
            attribute validationRuleSet : String;
            ref classifiedConcept : EntityConcept;
        }

        item def EntityTypeAssignment {
            doc /* Derived from CIM::BusinessDomain::EntityTypeAssignment.
                 * Bridges an EntityType and a PolicyDomain, allowing domain-specific
                 * customization of validation and schema constraints.
                 * [ST-074, ST-075] */
            attribute entityTypeAssignmentId : String;
            attribute status : IdentityStatus;
            attribute version : String;
            attribute constrainedSchemaDefinition : String [0..1];
            attribute constrainedValidationRuleSet : String [0..1];
            ref assignedEntityType : EntityType;
            ref governingDomain : PolicyDomain;
        }

        item def IdentityInstance {
            doc /* Derived from CIM::BusinessDomain::IdentityInstance.
                 * Represents the actual instance entry in the Identification Service.
                 * Holds populated identifying information for a real-world entity.
                 * [ST-076, ST-091] */
            attribute identityInstanceId : String;
            attribute instanceDesignation : String;
            attribute version : String;
            attribute status : IdentityStatus;
            attribute populatedSignifierValues : String;
            ref governingAssignment : EntityTypeAssignment;
        }

        item def IdentityLink {
            doc /* Derived from CIM::BusinessDomain::IdentityLink.
                 * A directed relationship between two identity instances, used for
                 * linking (active peers) or merging (one deprecated). Links are
                 * transitive by definition.
                 * [ST-077, ST-078, ST-079] */
            attribute identityLinkId : String;
            attribute linkType : LinkTypeCategory;
            attribute linkMethod : LinkMethodCategory [0..1];
            attribute reason : String [0..1];
            attribute provenance : String [0..1];
            ref sourceInstance : IdentityInstance;
            ref targetInstance : IdentityInstance;
        }

        item def RealWorldEntity {
            doc /* Derived from CIM::BusinessDomain::RealWorldEntity.
                 * Represents an actual thing -- a person, device, organization, or
                 * any identifiable object that the service manages.
                 * [ST-002, ST-005] */
            attribute realWorldEntityId : String;
            attribute entityNature : String;
        }

        item def UpdateQualifier {
            doc /* Derived from CIM::BusinessDomain::UpdateQualifier.
                 * Specifies the mode and optional transformation instructions for
                 * identity property update operations.
                 * [ST-096] */
            attribute updateQualifierId : String;
            attribute updateMode : UpdateMode;
            attribute updateSchemaReference : String [0..1];
        }

        item def SearchQualifier {
            doc /* Derived from CIM::BusinessDomain::SearchQualifier.
                 * Optional parameters that direct search behavior when finding
                 * identities by property.
                 * [ST-146, ST-147] */
            attribute searchQualifierId : String;
            attribute requestedConfidence : String [0..1];
            attribute maximumResultSetSize : Integer [0..1];
            attribute errorIfSizeExceeded : Boolean [0..1];
            attribute matchingAlgorithmDesignation : String [0..1];
        }

        item def NotificationSubscription {
            doc /* Derived from CIM::BusinessDomain::NotificationSubscription.
                 * A standing request by a service consumer to be notified when
                 * changes occur to identity information matching specified criteria.
                 * [ST-155, ST-159, ST-167] */
            attribute notificationSubscriptionId : String;
            attribute subscriber : String;
            attribute notificationQualifier : NotificationEventCategory [0..1];
            attribute subscriptionStatus : IdentityStatus;
            ref subscribedDomain : PolicyDomain [0..1];
            ref subscribedEntityType : EntityType [0..1];
            ref subscribedInstance : IdentityInstance [0..1];
        }

        item def ServiceMetadata {
            doc /* Derived from CIM::BusinessDomain::ServiceMetadata.
                 * The set of data items that delineates the scope and coverage of
                 * an Identification Service instance.
                 * [ST-211] */
            attribute serviceMetadataId : String;
            ref supportedDomains : PolicyDomain [1..*];
            ref supportedEntityTypes : EntityType [1..*];
            ref supportedConcepts : EntityConcept [1..*];
        }

        item def MatchResult {
            doc /* PIM-derived type representing a single match result from a search
                 * operation. Wraps an identity instance with match quality metadata.
                 * Derived from CIM use case findIdentitiesByProperty [ST-146, ST-148]
                 * and CIM::BusinessDomain::MatchConfidence. */
            attribute matchResultId : String;
            attribute matchConfidence : String;
            attribute matchTier : MatchQualityTier;
            ref matchedIdentity : IdentityInstance;
        }

        item def IdentityNotification {
            doc /* PIM-derived type representing a notification payload delivered
                 * to a subscriber when identity information changes.
                 * Derived from CIM use case notifyIdentityUpdates [ST-164, ST-165, ST-167]. */
            attribute identityNotificationId : String;
            attribute eventCategory : NotificationEventCategory;
            attribute eventTimestamp : String;
            attribute eventDescription : String;
            ref affectedIdentity : IdentityInstance;
            ref triggeringSubscription : NotificationSubscription;
        }

        /* ===================================================================
         * REQUEST / RESPONSE PAIRS
         * One pair per operation defined in PIM_IS.Operations.
         * =================================================================== */

        /* --- Register Identity --- */

        item def RegisterIdentityRequest {
            doc /* Request payload for RegisterIdentity operation.
                 * Derived from CIM use case registerIdentity inputs [ST-082, ST-083, ST-084]. */
            attribute suppliedIdentifier : String;
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute populatedSignifierValues : String;
        }

        item def RegisterIdentityResponse {
            doc /* Response payload for RegisterIdentity operation.
                 * Derived from CIM use case registerIdentity outputs [ST-082]. */
            attribute registeredIdentityId : String;
            attribute status : IdentityStatus;
        }

        /* --- Create Identity --- */

        item def CreateIdentityRequest {
            doc /* Request payload for CreateIdentity operation.
                 * Derived from CIM use case createIdentity inputs [ST-088, ST-089, ST-090]. */
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute populatedSignifierValues : String;
        }

        item def CreateIdentityResponse {
            doc /* Response payload for CreateIdentity operation.
                 * Derived from CIM use case createIdentity outputs [ST-088]. */
            attribute generatedIdentifier : String;
            attribute createdIdentityId : String;
            attribute status : IdentityStatus;
        }

        /* --- Update Identity Properties --- */

        item def UpdateIdentityPropertiesRequest {
            doc /* Request payload for UpdateIdentityProperties operation.
                 * Derived from CIM use case updateIdentityProperties inputs
                 * [ST-092, ST-093, ST-094, ST-095, ST-096]. */
            attribute identityInstanceId : String;
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute updatedSignifierValues : String;
            attribute updateMode : UpdateMode;
            attribute updateSchemaReference : String [0..1];
        }

        item def UpdateIdentityPropertiesResponse {
            doc /* Response payload for UpdateIdentityProperties operation.
                 * Derived from CIM use case updateIdentityProperties outputs [ST-092]. */
            attribute identityInstanceId : String;
            attribute version : String;
            attribute status : IdentityStatus;
        }

        /* --- Update Identity State --- */

        item def UpdateIdentityStateRequest {
            doc /* Request payload for UpdateIdentityState operation.
                 * Derived from CIM use case updateIdentityState inputs
                 * [ST-097, ST-098, ST-099]. */
            attribute identityInstanceId : String;
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute requestedStatus : IdentityStatus;
            attribute reason : String [0..1];
        }

        item def UpdateIdentityStateResponse {
            doc /* Response payload for UpdateIdentityState operation.
                 * Derived from CIM use case updateIdentityState outputs [ST-097]. */
            attribute identityInstanceId : String;
            attribute previousStatus : IdentityStatus;
            attribute currentStatus : IdentityStatus;
        }

        /* --- Merge Identities --- */

        item def MergeIdentitiesRequest {
            doc /* Request payload for MergeIdentities operation.
                 * Derived from CIM use case mergeIdentities inputs
                 * [ST-107, ST-108, ST-112]. */
            attribute sourceIdentityId : String;
            attribute targetIdentityId : String;
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute linkMethod : LinkMethodCategory [0..1];
            attribute reason : String [0..1];
        }

        item def MergeIdentitiesResponse {
            doc /* Response payload for MergeIdentities operation.
                 * Derived from CIM use case mergeIdentities outputs [ST-107]. */
            attribute survivingIdentityId : String;
            attribute deprecatedIdentityId : String;
            attribute survivingVersion : String;
        }

        /* --- Unmerge Identities --- */

        item def UnmergeIdentitiesRequest {
            doc /* Request payload for UnmergeIdentities operation.
                 * Derived from CIM use case unmergeIdentities inputs
                 * [ST-115, ST-116, ST-117]. */
            attribute sourceIdentityId : String;
            attribute targetIdentityId : String;
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute reason : String [0..1];
        }

        item def UnmergeIdentitiesResponse {
            doc /* Response payload for UnmergeIdentities operation.
                 * Derived from CIM use case unmergeIdentities outputs [ST-115]. */
            attribute reinstatedIdentityId : String;
            attribute reinstatedStatus : IdentityStatus;
            attribute requiresManualReview : Boolean;
        }

        /* --- Link Identities --- */

        item def LinkIdentitiesRequest {
            doc /* Request payload for LinkIdentities operation.
                 * Derived from CIM use case linkIdentities inputs
                 * [ST-121, ST-122, ST-124]. */
            attribute sourceIdentityId : String;
            attribute sourcePolicyDomainId : String;
            attribute sourceEntityTypeId : String;
            attribute targetIdentityId : String;
            attribute targetPolicyDomainId : String;
            attribute targetEntityTypeId : String;
            attribute linkMethod : LinkMethodCategory [0..1];
            attribute reason : String [0..1];
        }

        item def LinkIdentitiesResponse {
            doc /* Response payload for LinkIdentities operation.
                 * Derived from CIM use case linkIdentities outputs [ST-121]. */
            attribute identityLinkId : String;
            attribute linkType : LinkTypeCategory;
        }

        /* --- Unlink Identity --- */

        item def UnlinkIdentityRequest {
            doc /* Request payload for UnlinkIdentity operation.
                 * Derived from CIM use case unlinkIdentity inputs
                 * [ST-129, ST-130]. */
            attribute sourceIdentityId : String;
            attribute sourcePolicyDomainId : String;
            attribute sourceEntityTypeId : String;
            attribute targetIdentityId : String;
            attribute targetPolicyDomainId : String;
            attribute targetEntityTypeId : String;
            attribute reason : String [0..1];
        }

        item def UnlinkIdentityResponse {
            doc /* Response payload for UnlinkIdentity operation.
                 * Derived from CIM use case unlinkIdentity outputs [ST-129]. */
            attribute unlinkConfirmed : Boolean;
        }

        /* --- Remove Identity Instance --- */

        item def RemoveIdentityInstanceRequest {
            doc /* Request payload for RemoveIdentityInstance operation.
                 * Derived from CIM use case removeIdentityInstance inputs
                 * [ST-133, ST-134]. */
            attribute identityInstanceId : String;
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute reason : String [0..1];
        }

        item def RemoveIdentityInstanceResponse {
            doc /* Response payload for RemoveIdentityInstance operation.
                 * Derived from CIM use case removeIdentityInstance outputs [ST-133]. */
            attribute removalConfirmed : Boolean;
            attribute auditRetained : Boolean;
        }

        /* --- Get All Information For Identity --- */

        item def GetAllInformationRequest {
            doc /* Request payload for GetAllInformation operation.
                 * Derived from CIM use case getAllInformationForIdentity inputs
                 * [ST-140, ST-142, ST-143]. */
            attribute identityInstanceId : String;
            attribute policyDomainId : String;
            attribute entityTypeId : String;
        }

        item def GetAllInformationResponse {
            doc /* Response payload for GetAllInformation operation.
                 * Derived from CIM use case getAllInformationForIdentity outputs
                 * [ST-140, ST-141]. */
            attribute identityInstanceId : String;
            attribute instanceDesignation : String;
            attribute version : String;
            attribute status : IdentityStatus;
            attribute populatedSignifierValues : String;
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute mergedIntoIdentityId : String [0..1];
            attribute mergeWarning : Boolean;
        }

        /* --- Find Identities By Property --- */

        item def FindIdentitiesByPropertyRequest {
            doc /* Request payload for FindIdentitiesByProperty operation.
                 * Derived from CIM use case findIdentitiesByProperty inputs
                 * [ST-146, ST-147]. */
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute searchSignifierValues : String;
            attribute requestedStatuses : IdentityStatus [0..*];
            attribute requestedConfidence : String [0..1];
            attribute maximumResultSetSize : Integer [0..1];
            attribute errorIfSizeExceeded : Boolean [0..1];
            attribute matchingAlgorithmDesignation : String [0..1];
        }

        item def FindIdentitiesByPropertyResponse {
            doc /* Response payload for FindIdentitiesByProperty operation.
                 * Derived from CIM use case findIdentitiesByProperty outputs
                 * [ST-146, ST-148]. */
            attribute resultCount : Integer;
            ref matchResults : MatchResult [0..*];
        }

        /* --- List Linked Identities --- */

        item def ListLinkedIdentitiesRequest {
            doc /* Request payload for ListLinkedIdentities operation.
                 * Derived from CIM use case listLinkedIdentities inputs
                 * [ST-150, ST-151, ST-152]. */
            attribute identityInstanceId : String;
            attribute policyDomainId : String;
            attribute entityTypeId : String;
            attribute filterPolicyDomainIds : String [0..*];
        }

        item def ListLinkedIdentitiesResponse {
            doc /* Response payload for ListLinkedIdentities operation.
                 * Derived from CIM use case listLinkedIdentities outputs
                 * [ST-150, ST-153]. */
            attribute linkedCount : Integer;
            ref linkedIdentities : IdentityLink [0..*];
        }

        /* --- Request Identity Update Notifications --- */

        item def RequestNotificationsRequest {
            doc /* Request payload for RequestIdentityUpdateNotifications operation.
                 * Derived from CIM use case requestIdentityUpdateNotifications inputs
                 * [ST-155, ST-156]. */
            attribute subscriber : String;
            attribute policyDomainId : String [0..1];
            attribute entityTypeId : String [0..1];
            attribute identityInstanceId : String [0..1];
            attribute notificationQualifier : NotificationEventCategory [0..1];
        }

        item def RequestNotificationsResponse {
            doc /* Response payload for RequestIdentityUpdateNotifications operation.
                 * Derived from CIM use case requestIdentityUpdateNotifications outputs
                 * [ST-155]. */
            attribute notificationSubscriptionId : String;
            attribute subscriptionStatus : IdentityStatus;
        }

        /* --- Update Notification Subscription --- */

        item def UpdateNotificationSubscriptionRequest {
            doc /* Request payload for UpdateNotificationSubscription operation.
                 * Derived from CIM use case updateNotificationSubscription inputs
                 * [ST-160, ST-161, ST-162]. */
            attribute notificationSubscriptionId : String;
            attribute subscriber : String [0..1];
            attribute policyDomainId : String [0..1];
            attribute entityTypeId : String [0..1];
            attribute identityInstanceId : String [0..1];
            attribute notificationQualifier : NotificationEventCategory [0..1];
            attribute cancelSubscription : Boolean [0..1];
        }

        item def UpdateNotificationSubscriptionResponse {
            doc /* Response payload for UpdateNotificationSubscription operation.
                 * Derived from CIM use case updateNotificationSubscription outputs
                 * [ST-160]. */
            attribute notificationSubscriptionId : String;
            attribute subscriptionStatus : IdentityStatus;
            attribute updateConfirmed : Boolean;
        }

        /* --- Notify Identity Updates --- */

        item def NotifyIdentityUpdatesRequest {
            doc /* Request payload (trigger) for NotifyIdentityUpdates operation.
                 * This represents the internal trigger when the service detects
                 * a relevant change matching a subscription.
                 * Derived from CIM use case notifyIdentityUpdates inputs
                 * [ST-164, ST-165]. */
            attribute affectedIdentityId : String;
            attribute eventCategory : NotificationEventCategory;
            attribute eventDescription : String;
        }

        item def NotifyIdentityUpdatesResponse {
            doc /* Response payload for NotifyIdentityUpdates operation.
                 * Represents the notification delivered to subscribed consumers.
                 * Derived from CIM use case notifyIdentityUpdates outputs
                 * [ST-164, ST-167]. */
            attribute notificationsDeliveredCount : Integer;
            ref deliveredNotifications : IdentityNotification [0..*];
        }
    }
}
