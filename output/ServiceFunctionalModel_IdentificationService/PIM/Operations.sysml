package PIM_IS {

    package Operations {
        doc /* PIM-level Operations for the HL7 Identification Service (IS).
             * Contains all action definitions with preconditions, postconditions,
             * and use case to operation mapping. Each operation corresponds to a
             * CIM use case and satisfies one or more functional requirements.
             * All types referenced use qualified names from PIM_IS.DataModel. */

        /* ===================================================================
         * USE CASE -> OPERATION MAPPING
         * ===================================================================
         *
         * UC: registerIdentity                      -> OP: RegisterIdentity (1:1)
         * UC: createIdentity                        -> OP: CreateIdentity (1:1)
         * UC: updateIdentityProperties              -> OP: UpdateIdentityProperties (1:1)
         * UC: updateIdentityState                   -> OP: UpdateIdentityState (1:1)
         * UC: mergeIdentities                       -> OP: MergeIdentities (1:1)
         * UC: unmergeIdentities                     -> OP: UnmergeIdentities (1:1)
         * UC: linkIdentities                        -> OP: LinkIdentities (1:1)
         * UC: unlinkIdentity                        -> OP: UnlinkIdentity (1:1)
         * UC: removeIdentityInstance                -> OP: RemoveIdentityInstance (1:1)
         * UC: getAllInformationForIdentity           -> OP: GetAllInformation (1:1)
         * UC: findIdentitiesByProperty              -> OP: FindIdentitiesByProperty (1:1)
         * UC: listLinkedIdentities                  -> OP: ListLinkedIdentities (1:1)
         * UC: requestIdentityUpdateNotifications    -> OP: RequestIdentityUpdateNotifications (1:1)
         * UC: updateNotificationSubscription        -> OP: UpdateNotificationSubscription (1:1)
         * UC: notifyIdentityUpdates                 -> OP: NotifyIdentityUpdates (1:1)
         *
         * All 15 normative use cases map 1:1 to PIM operations.
         * Supporting internal behaviors (validateIdentifyingProperties,
         * detectPotentialMatches, validateMergeEligibility) are internal
         * service behaviors and are not exposed as PIM operations.
         * Business scenarios (Section 3, non-normative) compose these
         * operations in workflow patterns modeled in BehavioralFlows.
         * =================================================================== */

        /* ===================================================================
         * IDENTIFICATION MANAGEMENT OPERATIONS (Section 4.3)
         * =================================================================== */

        action def RegisterIdentity {
            doc /* Derived from CIM use case: registerIdentity
                 * Satisfies requirements: FR-001, FR-002, FR-003, FR-005
                 * Interface: IdentificationManagement [ST-026]
                 *
                 * Creates a new identity with a consumer-supplied identifier that
                 * must be unique within the PolicyDomain and EntityType scope.
                 * Properties are validated against the schema. Automated implicit
                 * linking may be triggered. [ST-082, ST-083, ST-084, ST-087] */

            in item request : PIM_IS::DataModel::RegisterIdentityRequest;
            out item response : PIM_IS::DataModel::RegisterIdentityResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::RegisterIdentityPreconditions) */
            doc /* PRE-1: The supplied identifier must not already exist within the
                 * service for the EntityType/PolicyDomain combination. [ST-085, ST-086]
                 * PRE-2: The PolicyDomain must be recognized by the service. [ST-087]
                 * PRE-3: The EntityType must be recognized by the service. [ST-087]
                 * PRE-4: Properties must validate against the schema for the
                 * EntityType/PolicyDomain combination. [ST-087, ST-074]
                 * PRE-5: The caller must be authenticated and authorized. [ST-171] */

            /* Postconditions */
            doc /* POST-1: A new IdentityInstance exists with the supplied identifier,
                 * in ACTIVE status. [ST-082]
                 * POST-2: Automated implicit linking has been evaluated. [ST-087, ST-128] */
        }

        action def CreateIdentity {
            doc /* Derived from CIM use case: createIdentity
                 * Satisfies requirements: FR-003, FR-004, FR-005
                 * Interface: IdentificationManagement [ST-026]
                 *
                 * Creates a new identity where the service generates and returns
                 * a unique identifier. Used when the consumer cannot supply its
                 * own local identifiers. [ST-088, ST-089, ST-090] */

            in item request : PIM_IS::DataModel::CreateIdentityRequest;
            out item response : PIM_IS::DataModel::CreateIdentityResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::CreateIdentityPreconditions) */
            doc /* PRE-1: The PolicyDomain must be recognized by the service. [ST-089]
                 * PRE-2: The EntityType must be recognized by the service. [ST-089]
                 * PRE-3: Properties must validate against the schema for the
                 * EntityType/PolicyDomain combination. [ST-090]
                 * PRE-4: The caller must be authenticated and authorized. [ST-171] */

            /* Postconditions */
            doc /* POST-1: A new IdentityInstance exists with a service-generated
                 * identifier, in ACTIVE status. [ST-088]
                 * POST-2: The generated identifier is unique within the PolicyDomain
                 * and EntityType scope. [ST-085]
                 * POST-3: Automated implicit linking has been evaluated. [ST-090, ST-128] */
        }

        action def UpdateIdentityProperties {
            doc /* Derived from CIM use case: updateIdentityProperties
                 * Satisfies requirements: FR-006, FR-007
                 * Interface: IdentificationManagement [ST-026]
                 *
                 * Updates the identifying property values of an existing identity
                 * according to the specified update mode (OVERWRITE, VALUED, or
                 * UNSPECIFIED). [ST-092, ST-093, ST-094, ST-095, ST-096] */

            in item request : PIM_IS::DataModel::UpdateIdentityPropertiesRequest;
            out item response : PIM_IS::DataModel::UpdateIdentityPropertiesResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::UpdatePropertyPrecondition) */
            doc /* PRE-1: The identity specified by the identifier must exist. [ST-093]
                 * PRE-2: The PolicyDomain must be recognized. [ST-094]
                 * PRE-3: The EntityType must be recognized. [ST-094]
                 * PRE-4: Properties must validate against the schema. [ST-095]
                 * PRE-5: The caller must be authenticated and authorized. [ST-171] */

            /* Postconditions (from CIM::BusinessRules::UpdateQualifierSemantics) */
            doc /* POST-1: If updateMode is OVERWRITE, all property values are replaced
                 * including nulls. [ST-096]
                 * POST-2: If updateMode is VALUED, only non-null submitted values
                 * replace existing values. [ST-096]
                 * POST-3: The identity version is incremented. [ST-177] */
        }

        action def UpdateIdentityState {
            doc /* Derived from CIM use case: updateIdentityState
                 * Satisfies requirements: FR-008, FR-009, FR-010, FR-011
                 * Interface: IdentificationManagement [ST-026]
                 *
                 * Changes the processing state of an identity while preserving
                 * all other identity information unchanged.
                 * [ST-097, ST-098, ST-099, ST-103] */

            in item request : PIM_IS::DataModel::UpdateIdentityStateRequest;
            out item response : PIM_IS::DataModel::UpdateIdentityStateResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::StateChangePrecondition) */
            doc /* PRE-1: The identity must exist. [ST-098]
                 * PRE-2: The identity must be in an appropriate previous state for
                 * the requested transition. [ST-099, ST-104]
                 * PRE-3: The PolicyDomain must be recognized. [ST-098]
                 * PRE-4: The EntityType must be recognized. [ST-098]
                 * PRE-5: The caller must be authenticated and authorized. [ST-171] */

            /* Postconditions (from CIM::BusinessRules::StateChangeInvariant) */
            doc /* POST-1: The identity status is changed to the requested state. [ST-097]
                 * POST-2: All identity information other than status is unchanged. [ST-103]
                 * POST-3: If set to INACTIVE, the identity no longer appears in
                 * clinical searches. [ST-061, ST-105] */
        }

        action def MergeIdentities {
            doc /* Derived from CIM use case: mergeIdentities
                 * Satisfies requirements: FR-012, FR-013, FR-014, FR-015
                 * Interface: IdentificationManagement [ST-026]
                 *
                 * Merges two identities within a single PolicyDomain. The target
                 * identifier survives; the source becomes deprecated.
                 * [ST-107, ST-108, ST-109, ST-110, ST-111, ST-112] */

            in item request : PIM_IS::DataModel::MergeIdentitiesRequest;
            out item response : PIM_IS::DataModel::MergeIdentitiesResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::MergePreconditions,
             * MergeWithinSingleDomainOnly, MergeSameEntityConceptRequired) */
            doc /* PRE-1: Both source and target identities must exist. [ST-112]
                 * PRE-2: Both identities must be in the same PolicyDomain. [ST-108]
                 * PRE-3: Both identities must be classified as EntityTypes that
                 * represent the same EntityConcept. [ST-109]
                 * PRE-4: Both identities must be in an allowable state for merge. [ST-112]
                 * PRE-5: The caller must be authenticated and authorized with
                 * identity resolution privileges. [ST-067, ST-171] */

            /* Postconditions (from CIM::BusinessRules::MergeAttributeResolution,
             * MergeIndicationRequired) */
            doc /* POST-1: Empty attributes in the target are filled from the source. [ST-110]
                 * POST-2: Existing target attributes are preserved unchanged. [ST-110]
                 * POST-3: The source identity is deprecated. [ST-107]
                 * POST-4: A merge indication is recorded. [ST-111] */
        }

        action def UnmergeIdentities {
            doc /* Derived from CIM use case: unmergeIdentities
                 * Satisfies requirements: FR-016, FR-017
                 * Interface: IdentificationManagement [ST-026]
                 *
                 * Reverses a previous merge by reinstating the deprecated identity
                 * and removing the merge association.
                 * [ST-115, ST-116, ST-117, ST-120] */

            in item request : PIM_IS::DataModel::UnmergeIdentitiesRequest;
            out item response : PIM_IS::DataModel::UnmergeIdentitiesResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::UnmergePrecondition) */
            doc /* PRE-1: The supplied identities must have been previously merged. [ST-117]
                 * PRE-2: Both identities must exist in the service. [ST-117]
                 * PRE-3: The PolicyDomain must be recognized. [ST-119]
                 * PRE-4: The EntityType must be recognized. [ST-119]
                 * PRE-5: The caller must be authenticated and authorized with
                 * identity resolution privileges. [ST-067, ST-171] */

            /* Postconditions (from CIM::BusinessRules::UnmergeBehavior,
             * UnmergeManualInterventionRequired) */
            doc /* POST-1: The previously deprecated identity is reinstated. [ST-116]
                 * POST-2: The merge association is reversed. [ST-116]
                 * POST-3: No attribute values are updated, only states. [ST-116]
                 * POST-4: The unmerged identities are flagged for manual review. [ST-120] */
        }

        action def LinkIdentities {
            doc /* Derived from CIM use case: linkIdentities
                 * Satisfies requirements: FR-018, FR-019, FR-020
                 * Interface: IdentificationManagement [ST-026]
                 *
                 * Establishes a link between two identities indicating they represent
                 * the same real-world entity. Linking can be within a single
                 * PolicyDomain or across two different domains.
                 * [ST-121, ST-122, ST-124, ST-126, ST-128] */

            in item request : PIM_IS::DataModel::LinkIdentitiesRequest;
            out item response : PIM_IS::DataModel::LinkIdentitiesResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::LinkPreconditions) */
            doc /* PRE-1: Both source and target identities must exist. [ST-122]
                 * PRE-2: The target identity must be in active state. [ST-122]
                 * PRE-3: The identities must not already be linked. [ST-125]
                 * PRE-4: PolicyDomains and EntityTypes must be recognized. [ST-125]
                 * PRE-5: The caller must be authenticated and authorized with
                 * identity resolution privileges. [ST-067, ST-171] */

            /* Postconditions (from CIM::BusinessRules::LinkSemanticsAndTransitivity) */
            doc /* POST-1: A link relationship exists between source and target. [ST-121]
                 * POST-2: Both identities remain active. [ST-121]
                 * POST-3: Transitive links are recognized. [ST-078] */
        }

        action def UnlinkIdentity {
            doc /* Derived from CIM use case: unlinkIdentity
                 * Satisfies requirements: FR-021
                 * Interface: IdentificationManagement [ST-026]
                 *
                 * Removes a previously established link between two identities.
                 * [ST-129, ST-130, ST-131, ST-132] */

            in item request : PIM_IS::DataModel::UnlinkIdentityRequest;
            out item response : PIM_IS::DataModel::UnlinkIdentityResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::UnlinkPreconditions) */
            doc /* PRE-1: Both identities must exist. [ST-130]
                 * PRE-2: The identities must be currently linked. [ST-130]
                 * PRE-3: PolicyDomains and EntityTypes must be recognized. [ST-132]
                 * PRE-4: The caller must be authenticated and authorized with
                 * identity resolution privileges. [ST-067, ST-171] */

            /* Postconditions */
            doc /* POST-1: The link between the two identities is removed. [ST-129]
                 * POST-2: Both identities continue to exist independently. [ST-129] */
        }

        action def RemoveIdentityInstance {
            doc /* Derived from CIM use case: removeIdentityInstance
                 * Satisfies requirements: FR-022, FR-023, FR-024
                 * Interface: IdentificationManagement [ST-026]
                 *
                 * Permanently removes an identity instance from the service.
                 * The identity must not be linked to other entities.
                 * [ST-133, ST-134, ST-135, ST-136, ST-137, ST-139] */

            in item request : PIM_IS::DataModel::RemoveIdentityInstanceRequest;
            out item response : PIM_IS::DataModel::RemoveIdentityInstanceResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::RemovePreconditions,
             * RemovalPrivilegeRestriction) */
            doc /* PRE-1: The identity instance must exist. [ST-134]
                 * PRE-2: The identity must be in an appropriate state for removal. [ST-134]
                 * PRE-3: The identity must not be linked to other entities. [ST-134]
                 * PRE-4: The PolicyDomain must be recognized. [ST-136]
                 * PRE-5: The EntityType must be recognized. [ST-136]
                 * PRE-6: The caller must be authenticated and authorized with
                 * removal privileges. [ST-139, ST-171] */

            /* Postconditions (from CIM::BusinessRules::IdentifierReusePolicy,
             * AuditRetentionAfterRemoval) */
            doc /* POST-1: The identity is no longer discoverable by any user. [ST-133]
                 * POST-2: The identifier should not be reused. [ST-137, ST-138]
                 * POST-3: The record may be retained for audit trail purposes. [ST-194] */
        }

        /* ===================================================================
         * QUERY OPERATIONS (Section 4.4)
         * =================================================================== */

        action def GetAllInformation {
            doc /* Derived from CIM use case: getAllInformationForIdentity
                 * Satisfies requirements: FR-025, FR-026
                 * Interface: Query [ST-027]
                 *
                 * Retrieves all information for a known identity. If the identity
                 * has been merged, a warning is returned with the surviving identifier.
                 * [ST-140, ST-141, ST-142, ST-143, ST-144] */

            in item request : PIM_IS::DataModel::GetAllInformationRequest;
            out item response : PIM_IS::DataModel::GetAllInformationResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::GetAllInfoExceptions) */
            doc /* PRE-1: The identifier must be recognized by the service. [ST-145]
                 * PRE-2: The PolicyDomain must be recognized. [ST-145]
                 * PRE-3: The EntityType must be recognized. [ST-145]
                 * PRE-4: The caller must be authenticated. [ST-171] */

            /* Postconditions (from CIM::BusinessRules::GetAllInfoInvariant,
             * MergedIdentityRedirect) */
            doc /* POST-1: The identity is unchanged after retrieval (read-only). [ST-144]
                 * POST-2: If the identity has been merged, the response includes
                 * a warning and the surviving identifier. [ST-141] */
        }

        action def FindIdentitiesByProperty {
            doc /* Derived from CIM use case: findIdentitiesByProperty
                 * Satisfies requirements: FR-027, FR-028
                 * Interface: Query [ST-027]
                 *
                 * Searches for matching identities given a partially populated
                 * semantic signifier and optional search qualifiers. Returns
                 * results with quality-of-match indicators.
                 * [ST-146, ST-147, ST-148, ST-149] */

            in item request : PIM_IS::DataModel::FindIdentitiesByPropertyRequest;
            out item response : PIM_IS::DataModel::FindIdentitiesByPropertyResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::FindByPropertyExceptions) */
            doc /* PRE-1: The PolicyDomain must be recognized. [ST-149]
                 * PRE-2: The EntityType must be recognized. [ST-149]
                 * PRE-3: Search qualifiers, if supplied, must be valid. [ST-149]
                 * PRE-4: Properties must validate against the schema. [ST-149]
                 * PRE-5: The caller must be authenticated. [ST-171] */

            /* Postconditions (from CIM::BusinessRules::TwoTieredMatchThreshold) */
            doc /* POST-1: Each result includes a quality-of-match indicator. [ST-148]
                 * POST-2: Results are categorized into definite and presumptive
                 * match tiers when applicable. [ST-172] */
        }

        action def ListLinkedIdentities {
            doc /* Derived from CIM use case: listLinkedIdentities
                 * Satisfies requirements: FR-029
                 * Interface: Query [ST-027]
                 *
                 * Lists all identities linked to a specified identity, optionally
                 * filtered by PolicyDomain scope.
                 * [ST-150, ST-151, ST-152, ST-153, ST-154] */

            in item request : PIM_IS::DataModel::ListLinkedIdentitiesRequest;
            out item response : PIM_IS::DataModel::ListLinkedIdentitiesResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::ListLinkedPrecondition,
             * ListLinkedExceptions) */
            doc /* PRE-1: The identity must exist in the specified PolicyDomain. [ST-151]
                 * PRE-2: The PolicyDomain must be recognized. [ST-154]
                 * PRE-3: The EntityType must be recognized. [ST-154]
                 * PRE-4: The caller must be authenticated. [ST-171] */

            /* Postconditions */
            doc /* POST-1: All linked identities are returned, including transitive
                 * links. [ST-150, ST-078]
                 * POST-2: If filter PolicyDomains are specified, only linked identities
                 * in those domains are returned. [ST-152] */
        }

        action def RequestIdentityUpdateNotifications {
            doc /* Derived from CIM use case: requestIdentityUpdateNotifications
                 * Satisfies requirements: FR-030
                 * Interface: Query [ST-027]
                 *
                 * Registers a standing request (subscription) to be notified when
                 * identity information matching specified criteria changes.
                 * [ST-155, ST-156, ST-157, ST-158, ST-159] */

            in item request : PIM_IS::DataModel::RequestNotificationsRequest;
            out item response : PIM_IS::DataModel::RequestNotificationsResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::NotificationSubscriptionExceptions) */
            doc /* PRE-1: If a PolicyDomain is specified, it must be recognized. [ST-158]
                 * PRE-2: If an EntityType is specified, it must be recognized. [ST-158]
                 * PRE-3: If an identity is specified, it must be recognized. [ST-158]
                 * PRE-4: Notification qualifiers must be valid. [ST-158]
                 * PRE-5: The caller must be authenticated. [ST-171] */

            /* Postconditions (from CIM::BusinessRules::NotificationSubscriptionPattern) */
            doc /* POST-1: A notification subscription is established with ACTIVE status. [ST-155]
                 * POST-2: The subscriber will receive notifications when matching
                 * changes occur. [ST-159] */
        }

        action def UpdateNotificationSubscription {
            doc /* Derived from CIM use case: updateNotificationSubscription
                 * Satisfies requirements: FR-031
                 * Interface: Query [ST-027]
                 *
                 * Modifies or cancels a previously submitted notification subscription.
                 * [ST-160, ST-161, ST-162, ST-163] */

            in item request : PIM_IS::DataModel::UpdateNotificationSubscriptionRequest;
            out item response : PIM_IS::DataModel::UpdateNotificationSubscriptionResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::UpdateNotificationExceptions) */
            doc /* PRE-1: The notification subscription must exist. [ST-163]
                 * PRE-2: If a PolicyDomain is specified, it must be recognized. [ST-163]
                 * PRE-3: If an EntityType is specified, it must be recognized. [ST-163]
                 * PRE-4: Notification qualifiers must be valid. [ST-163]
                 * PRE-5: The caller must be authenticated. [ST-171] */

            /* Postconditions */
            doc /* POST-1: The subscription criteria are updated as specified. [ST-160]
                 * POST-2: If cancellation is requested, the subscription status
                 * is set to INACTIVE. [ST-161] */
        }

        action def NotifyIdentityUpdates {
            doc /* Derived from CIM use case: notifyIdentityUpdates
                 * Satisfies requirements: FR-032
                 * Interface: Query [ST-027]
                 *
                 * Produces notifications to subscribed consumers when identity
                 * information changes match their subscription criteria.
                 * This is a publication operation triggered by identity changes.
                 * [ST-164, ST-165, ST-166, ST-167] */

            in item request : PIM_IS::DataModel::NotifyIdentityUpdatesRequest;
            out item response : PIM_IS::DataModel::NotifyIdentityUpdatesResponse;
            out item fault : PIM_IS::DataModel::ServiceFault;

            /* Preconditions (from CIM::BusinessRules::NotificationPublicationPrecondition) */
            doc /* PRE-1: The service has detected an update to identity information
                 * for a specific entity. [ST-165]
                 * PRE-2: A previous notification subscription matching the change
                 * criteria exists. [ST-165] */

            /* Postconditions (from CIM::BusinessRules::NotificationPublicationPattern) */
            doc /* POST-1: Notifications are delivered to all subscribers whose
                 * criteria match the change event. [ST-167]
                 * POST-2: The notification includes the identity of the affected
                 * entity and the nature of the change. [ST-164] */
        }
    }
}
