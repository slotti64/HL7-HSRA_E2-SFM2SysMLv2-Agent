package PIM_IS {

    package ServiceContracts {
        doc /* PIM-level Service Contracts for the HL7 Identification Service (IS).
             * Defines logical service boundaries as interface and port definitions.
             * Two interfaces are defined per SFM Section 2.3.1:
             *   1. IdentificationManagement -- mutation operations (9 ops)
             *   2. Query -- read-only and notification operations (6 ops)
             * All types referenced use qualified names from PIM_IS.DataModel. */

        /* ===================================================================
         * SERVICE BOUNDARY GROUPING RATIONALE
         * ===================================================================
         *
         * The SFM Section 2.3.1 explicitly identifies two interfaces:
         *
         * 1. IdentificationManagement: "provides capabilities for the
         *    manipulation of Identifiers and properties" [ST-025, ST-026]
         *    Groups: registerIdentity, createIdentity, updateIdentityProperties,
         *    updateIdentityState, mergeIdentities, unmergeIdentities,
         *    linkIdentities, unlinkIdentity, removeIdentityInstance
         *
         * 2. Query: "provides read-only capabilities for retrieving Entity
         *    information" [ST-025, ST-027]
         *    Groups: getAllInformationForIdentity, findIdentitiesByProperty,
         *    listLinkedIdentities, requestIdentityUpdateNotifications,
         *    updateNotificationSubscription, notifyIdentityUpdates
         *
         * Notifications are grouped under Query per the SFM classification
         * because they are part of the information retrieval and awareness
         * capability, not identity mutation.
         * =================================================================== */

        /* ===================================================================
         * PORT DEFINITIONS
         * =================================================================== */

        port def IdentificationManagementPort {
            doc /* Port definition for the IdentificationManagement service boundary.
                 * Groups mutation use cases: registerIdentity, createIdentity,
                 * updateIdentityProperties, updateIdentityState, mergeIdentities,
                 * unmergeIdentities, linkIdentities, unlinkIdentity,
                 * removeIdentityInstance.
                 * [ST-025, ST-026] */

            /* Register Identity */
            out item registerIdentityRequest : PIM_IS::DataModel::RegisterIdentityRequest;
            in item registerIdentityResponse : PIM_IS::DataModel::RegisterIdentityResponse;

            /* Create Identity */
            out item createIdentityRequest : PIM_IS::DataModel::CreateIdentityRequest;
            in item createIdentityResponse : PIM_IS::DataModel::CreateIdentityResponse;

            /* Update Identity Properties */
            out item updateIdentityPropertiesRequest : PIM_IS::DataModel::UpdateIdentityPropertiesRequest;
            in item updateIdentityPropertiesResponse : PIM_IS::DataModel::UpdateIdentityPropertiesResponse;

            /* Update Identity State */
            out item updateIdentityStateRequest : PIM_IS::DataModel::UpdateIdentityStateRequest;
            in item updateIdentityStateResponse : PIM_IS::DataModel::UpdateIdentityStateResponse;

            /* Merge Identities */
            out item mergeIdentitiesRequest : PIM_IS::DataModel::MergeIdentitiesRequest;
            in item mergeIdentitiesResponse : PIM_IS::DataModel::MergeIdentitiesResponse;

            /* Unmerge Identities */
            out item unmergeIdentitiesRequest : PIM_IS::DataModel::UnmergeIdentitiesRequest;
            in item unmergeIdentitiesResponse : PIM_IS::DataModel::UnmergeIdentitiesResponse;

            /* Link Identities */
            out item linkIdentitiesRequest : PIM_IS::DataModel::LinkIdentitiesRequest;
            in item linkIdentitiesResponse : PIM_IS::DataModel::LinkIdentitiesResponse;

            /* Unlink Identity */
            out item unlinkIdentityRequest : PIM_IS::DataModel::UnlinkIdentityRequest;
            in item unlinkIdentityResponse : PIM_IS::DataModel::UnlinkIdentityResponse;

            /* Remove Identity Instance */
            out item removeIdentityInstanceRequest : PIM_IS::DataModel::RemoveIdentityInstanceRequest;
            in item removeIdentityInstanceResponse : PIM_IS::DataModel::RemoveIdentityInstanceResponse;

            /* Fault */
            in item fault : PIM_IS::DataModel::ServiceFault;
        }

        port def QueryPort {
            doc /* Port definition for the Query service boundary.
                 * Groups read-only and notification use cases:
                 * getAllInformationForIdentity, findIdentitiesByProperty,
                 * listLinkedIdentities, requestIdentityUpdateNotifications,
                 * updateNotificationSubscription, notifyIdentityUpdates.
                 * [ST-025, ST-027] */

            /* Get All Information */
            out item getAllInformationRequest : PIM_IS::DataModel::GetAllInformationRequest;
            in item getAllInformationResponse : PIM_IS::DataModel::GetAllInformationResponse;

            /* Find Identities By Property */
            out item findIdentitiesByPropertyRequest : PIM_IS::DataModel::FindIdentitiesByPropertyRequest;
            in item findIdentitiesByPropertyResponse : PIM_IS::DataModel::FindIdentitiesByPropertyResponse;

            /* List Linked Identities */
            out item listLinkedIdentitiesRequest : PIM_IS::DataModel::ListLinkedIdentitiesRequest;
            in item listLinkedIdentitiesResponse : PIM_IS::DataModel::ListLinkedIdentitiesResponse;

            /* Request Notifications */
            out item requestNotificationsRequest : PIM_IS::DataModel::RequestNotificationsRequest;
            in item requestNotificationsResponse : PIM_IS::DataModel::RequestNotificationsResponse;

            /* Update Notification Subscription */
            out item updateNotificationSubscriptionRequest : PIM_IS::DataModel::UpdateNotificationSubscriptionRequest;
            in item updateNotificationSubscriptionResponse : PIM_IS::DataModel::UpdateNotificationSubscriptionResponse;

            /* Notify Identity Updates */
            out item notifyIdentityUpdatesRequest : PIM_IS::DataModel::NotifyIdentityUpdatesRequest;
            in item notifyIdentityUpdatesResponse : PIM_IS::DataModel::NotifyIdentityUpdatesResponse;

            /* Fault */
            in item fault : PIM_IS::DataModel::ServiceFault;
        }

        /* ===================================================================
         * INTERFACE DEFINITIONS
         * =================================================================== */

        interface def IdentificationManagementAPI {
            doc /* Identification Management interface providing mutation capabilities
                 * for the manipulation of identifiers and properties.
                 * Groups use cases: registerIdentity, createIdentity,
                 * updateIdentityProperties, updateIdentityState, mergeIdentities,
                 * unmergeIdentities, linkIdentities, unlinkIdentity,
                 * removeIdentityInstance.
                 * Rationale: All operations that create, modify, or remove identity
                 * data are grouped into a single cohesive mutation interface, as
                 * specified by SFM Section 2.3.1 and Section 4.3.
                 * [ST-025, ST-026] */

            end requester : ~IdentificationManagementPort;
            end provider : IdentificationManagementPort;

            /* Register Identity flows */
            ref flow registerIdentityRequestFlow
                of PIM_IS::DataModel::RegisterIdentityRequest
                from requester.registerIdentityRequest
                to provider.registerIdentityRequest;
            ref flow registerIdentityResponseFlow
                of PIM_IS::DataModel::RegisterIdentityResponse
                from provider.registerIdentityResponse
                to requester.registerIdentityResponse;

            /* Create Identity flows */
            ref flow createIdentityRequestFlow
                of PIM_IS::DataModel::CreateIdentityRequest
                from requester.createIdentityRequest
                to provider.createIdentityRequest;
            ref flow createIdentityResponseFlow
                of PIM_IS::DataModel::CreateIdentityResponse
                from provider.createIdentityResponse
                to requester.createIdentityResponse;

            /* Update Identity Properties flows */
            ref flow updateIdentityPropertiesRequestFlow
                of PIM_IS::DataModel::UpdateIdentityPropertiesRequest
                from requester.updateIdentityPropertiesRequest
                to provider.updateIdentityPropertiesRequest;
            ref flow updateIdentityPropertiesResponseFlow
                of PIM_IS::DataModel::UpdateIdentityPropertiesResponse
                from provider.updateIdentityPropertiesResponse
                to requester.updateIdentityPropertiesResponse;

            /* Update Identity State flows */
            ref flow updateIdentityStateRequestFlow
                of PIM_IS::DataModel::UpdateIdentityStateRequest
                from requester.updateIdentityStateRequest
                to provider.updateIdentityStateRequest;
            ref flow updateIdentityStateResponseFlow
                of PIM_IS::DataModel::UpdateIdentityStateResponse
                from provider.updateIdentityStateResponse
                to requester.updateIdentityStateResponse;

            /* Merge Identities flows */
            ref flow mergeIdentitiesRequestFlow
                of PIM_IS::DataModel::MergeIdentitiesRequest
                from requester.mergeIdentitiesRequest
                to provider.mergeIdentitiesRequest;
            ref flow mergeIdentitiesResponseFlow
                of PIM_IS::DataModel::MergeIdentitiesResponse
                from provider.mergeIdentitiesResponse
                to requester.mergeIdentitiesResponse;

            /* Unmerge Identities flows */
            ref flow unmergeIdentitiesRequestFlow
                of PIM_IS::DataModel::UnmergeIdentitiesRequest
                from requester.unmergeIdentitiesRequest
                to provider.unmergeIdentitiesRequest;
            ref flow unmergeIdentitiesResponseFlow
                of PIM_IS::DataModel::UnmergeIdentitiesResponse
                from provider.unmergeIdentitiesResponse
                to requester.unmergeIdentitiesResponse;

            /* Link Identities flows */
            ref flow linkIdentitiesRequestFlow
                of PIM_IS::DataModel::LinkIdentitiesRequest
                from requester.linkIdentitiesRequest
                to provider.linkIdentitiesRequest;
            ref flow linkIdentitiesResponseFlow
                of PIM_IS::DataModel::LinkIdentitiesResponse
                from provider.linkIdentitiesResponse
                to requester.linkIdentitiesResponse;

            /* Unlink Identity flows */
            ref flow unlinkIdentityRequestFlow
                of PIM_IS::DataModel::UnlinkIdentityRequest
                from requester.unlinkIdentityRequest
                to provider.unlinkIdentityRequest;
            ref flow unlinkIdentityResponseFlow
                of PIM_IS::DataModel::UnlinkIdentityResponse
                from provider.unlinkIdentityResponse
                to requester.unlinkIdentityResponse;

            /* Remove Identity Instance flows */
            ref flow removeIdentityInstanceRequestFlow
                of PIM_IS::DataModel::RemoveIdentityInstanceRequest
                from requester.removeIdentityInstanceRequest
                to provider.removeIdentityInstanceRequest;
            ref flow removeIdentityInstanceResponseFlow
                of PIM_IS::DataModel::RemoveIdentityInstanceResponse
                from provider.removeIdentityInstanceResponse
                to requester.removeIdentityInstanceResponse;

            /* Fault flow -- mandatory */
            ref flow managementFaultFlow
                of PIM_IS::DataModel::ServiceFault
                from provider.fault
                to requester.fault;
        }

        interface def QueryAPI {
            doc /* Query interface providing read-only capabilities for retrieving
                 * entity information and notification management.
                 * Groups use cases: getAllInformationForIdentity,
                 * findIdentitiesByProperty, listLinkedIdentities,
                 * requestIdentityUpdateNotifications,
                 * updateNotificationSubscription, notifyIdentityUpdates.
                 * Rationale: All read-only retrieval operations and the notification
                 * subscription/publication lifecycle are grouped together, as
                 * specified by SFM Section 2.3.1 and Section 4.4.
                 * [ST-025, ST-027] */

            end requester : ~QueryPort;
            end provider : QueryPort;

            /* Get All Information flows */
            ref flow getAllInformationRequestFlow
                of PIM_IS::DataModel::GetAllInformationRequest
                from requester.getAllInformationRequest
                to provider.getAllInformationRequest;
            ref flow getAllInformationResponseFlow
                of PIM_IS::DataModel::GetAllInformationResponse
                from provider.getAllInformationResponse
                to requester.getAllInformationResponse;

            /* Find Identities By Property flows */
            ref flow findIdentitiesByPropertyRequestFlow
                of PIM_IS::DataModel::FindIdentitiesByPropertyRequest
                from requester.findIdentitiesByPropertyRequest
                to provider.findIdentitiesByPropertyRequest;
            ref flow findIdentitiesByPropertyResponseFlow
                of PIM_IS::DataModel::FindIdentitiesByPropertyResponse
                from provider.findIdentitiesByPropertyResponse
                to requester.findIdentitiesByPropertyResponse;

            /* List Linked Identities flows */
            ref flow listLinkedIdentitiesRequestFlow
                of PIM_IS::DataModel::ListLinkedIdentitiesRequest
                from requester.listLinkedIdentitiesRequest
                to provider.listLinkedIdentitiesRequest;
            ref flow listLinkedIdentitiesResponseFlow
                of PIM_IS::DataModel::ListLinkedIdentitiesResponse
                from provider.listLinkedIdentitiesResponse
                to requester.listLinkedIdentitiesResponse;

            /* Request Notifications flows */
            ref flow requestNotificationsRequestFlow
                of PIM_IS::DataModel::RequestNotificationsRequest
                from requester.requestNotificationsRequest
                to provider.requestNotificationsRequest;
            ref flow requestNotificationsResponseFlow
                of PIM_IS::DataModel::RequestNotificationsResponse
                from provider.requestNotificationsResponse
                to requester.requestNotificationsResponse;

            /* Update Notification Subscription flows */
            ref flow updateNotificationSubscriptionRequestFlow
                of PIM_IS::DataModel::UpdateNotificationSubscriptionRequest
                from requester.updateNotificationSubscriptionRequest
                to provider.updateNotificationSubscriptionRequest;
            ref flow updateNotificationSubscriptionResponseFlow
                of PIM_IS::DataModel::UpdateNotificationSubscriptionResponse
                from provider.updateNotificationSubscriptionResponse
                to requester.updateNotificationSubscriptionResponse;

            /* Notify Identity Updates flows */
            ref flow notifyIdentityUpdatesRequestFlow
                of PIM_IS::DataModel::NotifyIdentityUpdatesRequest
                from requester.notifyIdentityUpdatesRequest
                to provider.notifyIdentityUpdatesRequest;
            ref flow notifyIdentityUpdatesResponseFlow
                of PIM_IS::DataModel::NotifyIdentityUpdatesResponse
                from provider.notifyIdentityUpdatesResponse
                to requester.notifyIdentityUpdatesResponse;

            /* Fault flow -- mandatory */
            ref flow queryFaultFlow
                of PIM_IS::DataModel::ServiceFault
                from provider.fault
                to requester.fault;
        }
    }
}
