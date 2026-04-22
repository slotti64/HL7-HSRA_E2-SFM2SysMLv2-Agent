package PSM_IdentificationService_APIContracts {
    import FHIR_R5_Base::*;

    doc /* FHIR R5 REST interactions and $operations mapped from the PIM_IS Operations
         * action definitions. Each action def below corresponds to one PIM operation
         * and carries fhirInteraction, fhirResource, fhirMethod, and fhirAffectsState
         * metadata. When a mapping inherits a standard HL7 R5 OperationDefinition,
         * the canonical base URL is declared via fhirOperationBase so SB4 can emit a
         * conformant OperationDefinition that inherits from the core base.
         *
         * Port assignment:
         *   IdentificationManagementPort -> mutation operations (create/update/delete/$merge/$unmerge/$link/$unlink)
         *   QueryPort                    -> read/search/$match/$everything/subscription lifecycle
         *
         * NotifyIdentityUpdates is intentionally NOT mapped as a REST interaction
         * here; it is a notification-delivery trigger realized by a SubscriptionTopic
         * in WorkflowPatterns.sysml (SB2-B). See NOTIFICATION_DELIVERY_TRIGGERS below. */

    /* ===================================================================
     * IDENTIFICATION MANAGEMENT OPERATIONS (mutation)
     * =================================================================== */

    action def RegisterIdentity {
        doc /* Maps PIM::Operations::RegisterIdentity
             FHIR Interaction: create on Patient (client-supplied identifier)
             Endpoint: POST /Patient
             Request Parameters MUST include the client-supplied Patient.identifier. */
        in item request : Parameters;
        out item response : Patient;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "create"; }
        metadata fhirResource { value "Patient"; }
        metadata fhirMethod { value "POST"; }
        metadata fhirAffectsState { value "true"; }
    }

    action def CreateIdentity {
        doc /* Maps PIM::Operations::CreateIdentity
             FHIR Interaction: create on Patient (server-assigned identifier)
             Endpoint: POST /Patient */
        in item request : Parameters;
        out item response : Patient;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "create"; }
        metadata fhirResource { value "Patient"; }
        metadata fhirMethod { value "POST"; }
        metadata fhirAffectsState { value "true"; }
    }

    action def UpdateIdentityProperties {
        doc /* Maps PIM::Operations::UpdateIdentityProperties
             FHIR Interaction: update on Patient (full-resource replacement)
             Endpoint: PUT /Patient/{id}
             Implements PIM updateMode semantics (OVERWRITE/VALUED/UNSPECIFIED) as
             a client-side projection onto the full representation sent by PUT. */
        in item request : Parameters;
        out item response : Patient;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "update"; }
        metadata fhirResource { value "Patient"; }
        metadata fhirMethod { value "PUT"; }
        metadata fhirAffectsState { value "true"; }
    }

    action def UpdateIdentityState {
        doc /* Maps PIM::Operations::UpdateIdentityState
             FHIR Interaction: update on Patient (status/lifecycle transition)
             Endpoint: PUT /Patient/{id}
             Represents status transitions (ACTIVE/INACTIVE/DEPRECATED) by updating
             Patient.active and Patient.extension lifecycleStatus. */
        in item request : Parameters;
        out item response : Patient;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "update"; }
        metadata fhirResource { value "Patient"; }
        metadata fhirMethod { value "PUT"; }
        metadata fhirAffectsState { value "true"; }
    }

    action def MergeIdentities {
        doc /* Maps PIM::Operations::MergeIdentities
             FHIR Operation: $merge on Patient (CUSTOM - no standard R5 base)
             Endpoint: POST /Patient/$merge
             R5 does not define a standard Patient-merge OperationDefinition, so this
             is a service-defined custom $operation. fhirOperationBase is intentionally
             omitted. */
        in item parameters : Parameters;
        out item result : Bundle;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "$merge"; }
        metadata fhirResource { value "Patient"; }
        metadata fhirMethod { value "POST"; }
        metadata fhirAffectsState { value "true"; }
    }

    action def UnmergeIdentities {
        doc /* Maps PIM::Operations::UnmergeIdentities
             FHIR Operation: $unmerge on Patient (CUSTOM - no standard R5 base)
             Endpoint: POST /Patient/$unmerge
             R5 does not define a standard Patient-unmerge OperationDefinition; this
             is a service-defined custom $operation. fhirOperationBase is omitted. */
        in item parameters : Parameters;
        out item result : Bundle;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "$unmerge"; }
        metadata fhirResource { value "Patient"; }
        metadata fhirMethod { value "POST"; }
        metadata fhirAffectsState { value "true"; }
    }

    action def LinkIdentities {
        doc /* Maps PIM::Operations::LinkIdentities
             FHIR Interaction: create on Linkage (cross-resource linking)
             Endpoint: POST /Linkage
             Creates a Linkage resource referencing both source and target Patients
             and expressing the PIM link semantics. */
        in item request : Parameters;
        out item response : Linkage;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "create"; }
        metadata fhirResource { value "Linkage"; }
        metadata fhirMethod { value "POST"; }
        metadata fhirAffectsState { value "true"; }
    }

    action def UnlinkIdentity {
        doc /* Maps PIM::Operations::UnlinkIdentity
             FHIR Interaction: delete on Linkage (cross-resource unlinking)
             Endpoint: DELETE /Linkage/{id} */
        in item request : Parameters;
        out item response : OperationOutcome;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "delete"; }
        metadata fhirResource { value "Linkage"; }
        metadata fhirMethod { value "DELETE"; }
        metadata fhirAffectsState { value "true"; }
    }

    action def RemoveIdentityInstance {
        doc /* Maps PIM::Operations::RemoveIdentityInstance
             FHIR Interaction: delete on Patient (hard removal)
             Endpoint: DELETE /Patient/{id}
             The service may retain an audit record (POST-3); the visible Patient is
             permanently no longer discoverable. */
        in item request : Parameters;
        out item response : OperationOutcome;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "delete"; }
        metadata fhirResource { value "Patient"; }
        metadata fhirMethod { value "DELETE"; }
        metadata fhirAffectsState { value "true"; }
    }

    /* ===================================================================
     * QUERY OPERATIONS (read/search/notifications)
     * =================================================================== */

    action def GetAllInformation {
        doc /* Maps PIM::Operations::GetAllInformation
             FHIR Operation: $everything on Patient (inherits standard R5 base)
             Endpoint: POST /Patient/{id}/$everything
             fhirOperationBase: http://hl7.org/fhir/OperationDefinition/Patient-everything
             Returns a Bundle with the Patient and all related records. If the
             Patient has been merged, the Bundle includes a warning OperationOutcome
             entry and the surviving Patient reference. */
        in item parameters : Parameters;
        out item result : Bundle;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "$everything"; }
        metadata fhirResource { value "Patient"; }
        metadata fhirMethod { value "POST"; }
        metadata fhirAffectsState { value "false"; }
        metadata fhirOperationBase { value "http://hl7.org/fhir/OperationDefinition/Patient-everything"; }
    }

    action def FindIdentitiesByProperty {
        doc /* Maps PIM::Operations::FindIdentitiesByProperty
             FHIR Operation: $match on Patient (inherits standard R5 base)
             Endpoint: POST /Patient/$match
             fhirOperationBase: http://hl7.org/fhir/OperationDefinition/Patient-match
             Inherits standard parameter names from the base definition:
               - resource           : Patient (in; probe resource with partial identifiers)
               - onlyCertainMatches : boolean (in; restrict to definite-match tier)
               - count              : integer (in; maximum results)
             Returns a Bundle of match entries, each including a
             MatchGrade code (certain | probable | possible | certainly-not) that
             realizes the PIM quality-of-match and two-tier (definite/presumptive)
             classification. */
        in item parameters : Parameters;
        out item result : Bundle;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "$match"; }
        metadata fhirResource { value "Patient"; }
        metadata fhirMethod { value "POST"; }
        metadata fhirAffectsState { value "false"; }
        metadata fhirOperationBase { value "http://hl7.org/fhir/OperationDefinition/Patient-match"; }
    }

    action def ListLinkedIdentities {
        doc /* Maps PIM::Operations::ListLinkedIdentities
             FHIR Interaction: search-type on Linkage
             Endpoint: GET /Linkage?item={Patient/{id}}[&source={boolean}]
             Uses base Linkage SearchParameters (item, source, author) rather than
             custom parameters; no SearchParameter resource cloning required. */
        in item request : Parameters;
        out item response : Bundle;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "search-type"; }
        metadata fhirResource { value "Linkage"; }
        metadata fhirMethod { value "GET"; }
        metadata fhirAffectsState { value "false"; }
    }

    action def RequestIdentityUpdateNotifications {
        doc /* Maps PIM::Operations::RequestIdentityUpdateNotifications
             FHIR Interaction: create on Subscription (R5 topic-based)
             Endpoint: POST /Subscription
             Subscription.topic references the IdentityUpdate SubscriptionTopic
             produced in WorkflowPatterns.sysml. Filter criteria (PolicyDomain,
             EntityType, identity) are expressed via Subscription.filterBy. */
        in item request : Parameters;
        out item response : Subscription;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "create"; }
        metadata fhirResource { value "Subscription"; }
        metadata fhirMethod { value "POST"; }
        metadata fhirAffectsState { value "true"; }
    }

    action def UpdateNotificationSubscription {
        doc /* Maps PIM::Operations::UpdateNotificationSubscription
             FHIR Interaction: update on Subscription (full replacement)
             Endpoint: PUT /Subscription/{id}
             Cancellation is modeled by setting Subscription.status = off. */
        in item request : Parameters;
        out item response : Subscription;
        out item fault : OperationOutcome;
        metadata fhirInteraction { value "update"; }
        metadata fhirResource { value "Subscription"; }
        metadata fhirMethod { value "PUT"; }
        metadata fhirAffectsState { value "true"; }
    }

    /* ===================================================================
     * SEARCH PARAMETERS
     * ===================================================================
     *
     * Only search-type interactions require SearchParameter declarations.
     * ListLinkedIdentities is served by BASE Linkage SearchParameters defined
     * by the FHIR R5 core specification and referenced by canonical URL from
     * the CapabilityStatement (not cloned as custom SearchParameter resources).
     *
     *   item       on Linkage: type=reference,
     *              expression=Linkage.item.resource,
     *              base URL=http://hl7.org/fhir/SearchParameter/Linkage-item
     *   source     on Linkage: type=reference,
     *              expression=Linkage.item.where(type='source').resource,
     *              base URL=http://hl7.org/fhir/SearchParameter/Linkage-source
     *   author     on Linkage: type=reference,
     *              expression=Linkage.author,
     *              base URL=http://hl7.org/fhir/SearchParameter/Linkage-author
     *
     * $match parameters are declared by the standard Patient-match
     * OperationDefinition (inherited via fhirOperationBase) and must preserve
     * the standard names:
     *   resource           : Patient (in)
     *   onlyCertainMatches : boolean (in)
     *   count              : integer (in)
     *
     * $everything parameters are declared by the standard Patient-everything
     * OperationDefinition (inherited via fhirOperationBase):
     *   start  : date (in)
     *   end    : date (in)
     *   _since : instant (in)
     *   _type  : code (in)
     *   _count : integer (in)
     */

    /* ===================================================================
     * OPERATION COVERAGE
     * ===================================================================
     *
     * Total PIM action defs                              : 15
     * Mapped as FHIR REST interaction                    : 10
     *   create       : 4  (RegisterIdentity, CreateIdentity, LinkIdentities,
     *                      RequestIdentityUpdateNotifications)
     *   read         : 0
     *   update       : 3  (UpdateIdentityProperties, UpdateIdentityState,
     *                      UpdateNotificationSubscription)
     *   patch        : 0
     *   delete       : 2  (UnlinkIdentity, RemoveIdentityInstance)
     *   search-type  : 1  (ListLinkedIdentities)
     * Mapped as $operation                               : 4
     *   $merge       (custom, no R5 base)    : MergeIdentities
     *   $unmerge     (custom, no R5 base)    : UnmergeIdentities
     *   $everything  (inherits R5 base)      : GetAllInformation
     *   $match       (inherits R5 base)      : FindIdentitiesByProperty
     * Skipped (notification delivery -- handled by WorkflowPatterns) : 1
     *
     * Operations inheriting a standard R5 OperationDefinition base:
     *   GetAllInformation          -> http://hl7.org/fhir/OperationDefinition/Patient-everything
     *   FindIdentitiesByProperty   -> http://hl7.org/fhir/OperationDefinition/Patient-match
     *
     * NOTIFICATION_DELIVERY_TRIGGERS (skipped action def names, for SB2-B cross-check):
     *   - NotifyIdentityUpdates
     */
}
