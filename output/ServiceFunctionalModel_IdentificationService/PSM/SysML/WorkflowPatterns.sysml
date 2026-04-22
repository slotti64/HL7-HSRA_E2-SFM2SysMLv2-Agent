package PSM_IdentificationService_WorkflowPatterns {
    import FHIR_R5_Base::*;

    doc /* FHIR R5 workflow patterns for the IdentificationService PSM.
         *
         * This package emits:
         *   1) A SubscriptionTopic item def for the notification-delivery trigger
         *      NotifyIdentityUpdates (PIM_IS::Operations::NotifyIdentityUpdates).
         *      One single topic is emitted carrying four eventTrigger entries
         *      (one per NotificationEventCategory enum value: PROPERTY_CHANGE,
         *      STATUS_CHANGE, LINK_CHANGE, MERGE_CHANGE) plus two resourceTrigger
         *      entries (on Patient and Linkage) so that SB5 PC-03 is satisfied:
         *      every NotificationEventCategory enum value is covered by at least
         *      one resourceTrigger or eventTrigger.
         *
         *   2) Task-based workflow action defs for every multi-step behavioral
         *      flow explicitly described in PIM_IS::BehavioralFlows. Each
         *      workflow is classified by its structural PIM pattern:
         *        - CreateNewPatientFlow        -> sequential        (Task-based)
         *        - LinkOrMergeEntitiesFlow     -> decide/merge      (Task + conditional input)
         *        - UpdateDemographicsFlow      -> sequential        (Task-based)
         *        - UnlinkEntityFlow            -> sequential        (Task-based)
         *        - UnattendedEncounterFlow     -> decide/merge      (Task + conditional input)
         *        - CrossRegionLinkFlow         -> sequential        (Task-based)
         *
         *   3) CapabilityStatement summary aggregating all interactions from
         *      PSM_IdentificationService_APIContracts grouped by fhirResource,
         *      with SearchParameters tagged origin=BASE|CUSTOM and $operations
         *      tagged with their canonical definitions. */

    /* ===================================================================
     * SECTION 1: SubscriptionTopic
     * ===================================================================
     * Covers PIM_IS::Operations::NotifyIdentityUpdates (the sole entry in
     * NOTIFICATION_DELIVERY_TRIGGERS from APIContracts.sysml).
     *
     * PIM enum NotificationEventCategory has four values that must all be
     * covered by a resourceTrigger or eventTrigger entry (SB5 PC-03):
     *   - PROPERTY_CHANGE  -> eventTrigger "property-change"
     *   - STATUS_CHANGE    -> eventTrigger "status-change"
     *   - LINK_CHANGE      -> eventTrigger "link-change"
     *   - MERGE_CHANGE     -> eventTrigger "merge-change"
     *
     * The custom event CodeSystem used in the eventTrigger codings is:
     *   http://example.org/fhir/CodeSystem/IdentificationService-EventCode
     *
     * All four codes below are declared for SB2-D (TerminologyManifest)
     * via the REQUIRED-CS comment contract. */

    // REQUIRED-CS: system=http://example.org/fhir/CodeSystem/IdentificationService-EventCode codes=property-change,status-change,link-change,merge-change
    item def IdentityUpdateTopic :> FHIR_R5_Base::SubscriptionTopic {
        doc /* R5 SubscriptionTopic for identity-update notifications.
             *
             * Triggers on:
             *   - Any change to a Patient resource (create, update, delete) that
             *     affects demographic properties, status/lifecycle, link state,
             *     or merge state.
             *   - Any change to a Linkage resource whose item.resource references
             *     a Patient in this service.
             *
             * Maps PIM event: PIM_IS::Operations::NotifyIdentityUpdates
             * Covers PIM NotificationEventCategory enum values:
             *   PROPERTY_CHANGE, STATUS_CHANGE, LINK_CHANGE, MERGE_CHANGE */

        attribute url : String =
            "http://example.org/fhir/SubscriptionTopic/IdentificationService-IdentityUpdate";
        attribute title : String = "Identity Update Notifications";
        attribute status : String = "active";
        attribute description : String =
            "Notifies subscribers of changes to Patient demographics, status, link state, or merge state.";

        /* resourceTrigger[0]: Patient resource changes
         * Covers PROPERTY_CHANGE, STATUS_CHANGE when Patient is directly mutated.
         * resource referenced by full canonical URL per hardened contract. */
        attribute resourceTriggerPatient_resource : String =
            "http://hl7.org/fhir/StructureDefinition/Patient";
        attribute resourceTriggerPatient_supportedInteraction : String =
            "create,update,delete";

        /* resourceTrigger[1]: Linkage resource changes
         * Covers LINK_CHANGE (link creation/deletion) and contributes to
         * MERGE_CHANGE (when merges are realized via Linkage mutations).
         * resource referenced by full canonical URL per hardened contract. */
        attribute resourceTriggerLinkage_resource : String =
            "http://hl7.org/fhir/StructureDefinition/Linkage";
        attribute resourceTriggerLinkage_supportedInteraction : String =
            "create,update,delete";

        /* eventTrigger[0]: PROPERTY_CHANGE event
         * Fires when Patient demographic properties are updated via
         * UpdateIdentityProperties. */
        attribute eventTriggerPropertyChange_description : String =
            "Demographic properties of a Patient were updated";
        attribute eventTriggerPropertyChange_event_system : String =
            "http://example.org/fhir/CodeSystem/IdentificationService-EventCode";
        attribute eventTriggerPropertyChange_event_code : String = "property-change";
        attribute eventTriggerPropertyChange_resource : String =
            "http://hl7.org/fhir/StructureDefinition/Patient";

        /* eventTrigger[1]: STATUS_CHANGE event
         * Fires when Patient lifecycle status is transitioned via
         * UpdateIdentityState (ACTIVE/INACTIVE/DEPRECATED). */
        attribute eventTriggerStatusChange_description : String =
            "Patient lifecycle status was transitioned";
        attribute eventTriggerStatusChange_event_system : String =
            "http://example.org/fhir/CodeSystem/IdentificationService-EventCode";
        attribute eventTriggerStatusChange_event_code : String = "status-change";
        attribute eventTriggerStatusChange_resource : String =
            "http://hl7.org/fhir/StructureDefinition/Patient";

        /* eventTrigger[2]: LINK_CHANGE event
         * Fires when Patients are linked or unlinked via LinkIdentities /
         * UnlinkIdentity (realized as Linkage create/delete). */
        attribute eventTriggerLinkChange_description : String =
            "Patients were linked or unlinked";
        attribute eventTriggerLinkChange_event_system : String =
            "http://example.org/fhir/CodeSystem/IdentificationService-EventCode";
        attribute eventTriggerLinkChange_event_code : String = "link-change";
        attribute eventTriggerLinkChange_resource : String =
            "http://hl7.org/fhir/StructureDefinition/Linkage";

        /* eventTrigger[3]: MERGE_CHANGE event
         * Fires when identities are merged or unmerged via the custom
         * $merge / $unmerge operations on Patient. */
        attribute eventTriggerMergeChange_description : String =
            "Patient identities were merged or unmerged";
        attribute eventTriggerMergeChange_event_system : String =
            "http://example.org/fhir/CodeSystem/IdentificationService-EventCode";
        attribute eventTriggerMergeChange_event_code : String = "merge-change";
        attribute eventTriggerMergeChange_resource : String =
            "http://hl7.org/fhir/StructureDefinition/Patient";

        /* canFilterBy[0]: filter by Patient identifier
         * Enables subscribers to scope notifications to a PolicyDomain
         * (via identifier.system) or specific identity (identifier.value). */
        attribute canFilterByIdentifier_resource : String =
            "http://hl7.org/fhir/StructureDefinition/Patient";
        attribute canFilterByIdentifier_filterParameter : String = "identifier";
        attribute canFilterByIdentifier_comparator : String = "eq";

        /* canFilterBy[1]: filter by Patient.organization (managing organization)
         * Enables subscribers to scope notifications by EntityType /
         * organizational ownership. */
        attribute canFilterByOrganization_resource : String =
            "http://hl7.org/fhir/StructureDefinition/Patient";
        attribute canFilterByOrganization_filterParameter : String = "organization";
        attribute canFilterByOrganization_comparator : String = "eq";

        metadata fhirResource { value "SubscriptionTopic"; }
    }

    /* ===================================================================
     * SECTION 2: Workflow action defs
     * ===================================================================
     * Each action def maps 1:1 to a PIM behavioral flow in
     * PIM_IS::BehavioralFlows. Sub-actions reference action defs in
     * PSM_IdentificationService_APIContracts via qualified names. */

    /* -------------------------------------------------------------------
     * Workflow 1: CreateNewPatientFlow
     * PIM pattern: sequential (ref first ... then ...)
     * FHIR pattern: Task-based workflow (parent Task with three ordered
     * child Tasks, chained via Task.partOf). */
    action def CreateNewPatientWorkflow {
        doc /* Maps PIM::BehavioralFlows::CreateNewPatientFlow
             * FHIR Pattern: Task-based workflow.
             * Parent Task coordinates three sequential child Tasks:
             *   initialSearch -> broaderSearch -> register.
             * Traces to CIM: createNewPatient [ST-048]. */
        in item trigger : Parameters;
        out item result : Bundle;

        action step_initialSearch : PSM_IdentificationService_APIContracts::FindIdentitiesByProperty;
        action step_broaderSearch : PSM_IdentificationService_APIContracts::FindIdentitiesByProperty;
        action step_register      : PSM_IdentificationService_APIContracts::RegisterIdentity;

        ref first step_initialSearch then step_broaderSearch;
        ref first step_broaderSearch then step_register;
    }

    /* -------------------------------------------------------------------
     * Workflow 2: LinkOrMergeEntitiesFlow
     * PIM pattern: decide/merge (branch on organizational policy)
     * FHIR pattern: Task-based workflow with conditional input.
     * Parent Task carries Task.input parameters that select the branch. */
    action def LinkOrMergeEntitiesWorkflow {
        doc /* Maps PIM::BehavioralFlows::LinkOrMergeEntitiesFlow
             * FHIR Pattern: Task-based workflow with conditional input.
             * Parent Task carries a Task.input parameter 'policy' whose value
             * (link | merge) selects whether the LinkIdentities or
             * MergeIdentities child Task executes.
             * Traces to CIM: linkOrMergeEntities [ST-052]. */
        in item trigger : Parameters;
        out item result : Bundle;

        action step_searchForDuplicates : PSM_IdentificationService_APIContracts::FindIdentitiesByProperty;
        action step_linkIdentities      : PSM_IdentificationService_APIContracts::LinkIdentities;
        action step_mergeIdentities     : PSM_IdentificationService_APIContracts::MergeIdentities;

        /* searchForDuplicates precedes the conditional branch;
         * step_linkIdentities and step_mergeIdentities are mutually exclusive,
         * selected by parent Task.input 'policy'. */
        ref first step_searchForDuplicates then step_linkIdentities;
        ref first step_searchForDuplicates then step_mergeIdentities;
    }

    /* -------------------------------------------------------------------
     * Workflow 3: UpdateDemographicsFlow
     * PIM pattern: sequential
     * FHIR pattern: Task-based workflow (three ordered child Tasks). */
    action def UpdateDemographicsWorkflow {
        doc /* Maps PIM::BehavioralFlows::UpdateDemographicsFlow
             * FHIR Pattern: Task-based workflow.
             * Sequence: searchNearMatches -> retrieveFullRecord -> updateProperties.
             * Traces to CIM: updateDemographics [ST-056]. */
        in item trigger : Parameters;
        out item result : Bundle;

        action step_searchNearMatches  : PSM_IdentificationService_APIContracts::FindIdentitiesByProperty;
        action step_retrieveFullRecord : PSM_IdentificationService_APIContracts::GetAllInformation;
        action step_updateProperties   : PSM_IdentificationService_APIContracts::UpdateIdentityProperties;

        ref first step_searchNearMatches  then step_retrieveFullRecord;
        ref first step_retrieveFullRecord then step_updateProperties;
    }

    /* -------------------------------------------------------------------
     * Workflow 4: UnlinkEntityFlow
     * PIM pattern: sequential
     * FHIR pattern: Task-based workflow. */
    action def UnlinkEntityWorkflow {
        doc /* Maps PIM::BehavioralFlows::UnlinkEntityFlow
             * FHIR Pattern: Task-based workflow.
             * Sequence: searchAndDiscover -> retrieveLinkedIdentities -> performUnlink.
             * Traces to CIM: unlinkEntity [ST-064]. */
        in item trigger : Parameters;
        out item result : Bundle;

        action step_searchAndDiscover         : PSM_IdentificationService_APIContracts::FindIdentitiesByProperty;
        action step_retrieveLinkedIdentities  : PSM_IdentificationService_APIContracts::ListLinkedIdentities;
        action step_performUnlink             : PSM_IdentificationService_APIContracts::UnlinkIdentity;

        ref first step_searchAndDiscover        then step_retrieveLinkedIdentities;
        ref first step_retrieveLinkedIdentities then step_performUnlink;
    }

    /* -------------------------------------------------------------------
     * Workflow 5: UnattendedEncounterFlow
     * PIM pattern: decide/merge (four outcomes; only outcome #3 invokes a
     *              further PIM operation - CreateIdentity)
     * FHIR pattern: Task-based workflow with conditional input.
     * The parent Task carries an input 'outcome' whose value
     * (definite-match | auto-create | await-user) selects the terminal path.
     * Outcomes #1, #2, #4 terminate without a further FHIR interaction. */
    action def UnattendedEncounterWorkflow {
        doc /* Maps PIM::BehavioralFlows::UnattendedEncounterFlow
             * FHIR Pattern: Task-based workflow with conditional input.
             * Step 1 (attemptIdentityResolution) always executes; a decision
             * then selects one of four outcomes. Only the auto-create branch
             * invokes a further FHIR interaction (CreateIdentity).
             * Traces to CIM: unattendedEncounter [ST-187]. */
        in item trigger : Parameters;
        out item result : Bundle;

        action step_attemptIdentityResolution : PSM_IdentificationService_APIContracts::FindIdentitiesByProperty;
        action step_autoCreateIdentity        : PSM_IdentificationService_APIContracts::CreateIdentity;

        /* step_autoCreateIdentity is taken only when parent Task.input 'outcome'
         * is 'auto-create'; other outcomes terminate after step_attemptIdentityResolution. */
        ref first step_attemptIdentityResolution then step_autoCreateIdentity;
    }

    /* -------------------------------------------------------------------
     * Workflow 6: CrossRegionLinkFlow
     * PIM pattern: sequential
     * FHIR pattern: Task-based workflow. */
    action def CrossRegionLinkWorkflow {
        doc /* Maps PIM::BehavioralFlows::CrossRegionLinkFlow
             * FHIR Pattern: Task-based workflow.
             * Sequence: searchAcrossRegions -> registerLocalIdentity -> linkToMaster.
             * Traces to CIM: linkEntitiesAcrossRegions [ST-200]. */
        in item trigger : Parameters;
        out item result : Bundle;

        action step_searchAcrossRegions    : PSM_IdentificationService_APIContracts::FindIdentitiesByProperty;
        action step_registerLocalIdentity  : PSM_IdentificationService_APIContracts::RegisterIdentity;
        action step_linkToMaster           : PSM_IdentificationService_APIContracts::LinkIdentities;

        ref first step_searchAcrossRegions   then step_registerLocalIdentity;
        ref first step_registerLocalIdentity then step_linkToMaster;
    }

    /* ===================================================================
     * SECTION 3: CapabilityStatement Summary
     * ===================================================================
     * Aggregates all interactions from PSM_IdentificationService_APIContracts
     * grouped by fhirResource. SearchParameter entries are tagged with
     * origin=BASE (baseUrl=...) or origin=CUSTOM so SB4 can skip JSON emission
     * for base references. Operation entries carry their canonical definition
     * URL (standard base for Patient-match and Patient-everything; service-
     * defined canonical URL for the custom $merge and $unmerge).
     * =================================================================== */

    /* CapabilityStatement Summary
       resourceType: CapabilityStatement
       url: http://example.org/fhir/CapabilityStatement/IdentificationService
       name: IdentificationServiceCapabilityStatement
       title: HL7 Identification Service CapabilityStatement
       status: draft
       kind: instance
       fhirVersion: 5.0.0
       format: [application/fhir+json, application/fhir+xml]

       rest[0].mode: server
       rest[0].documentation:
         "HL7 Identification Service FHIR R5 facade. Exposes Patient, Linkage,
          Subscription, and SubscriptionTopic resources, plus custom $merge and
          $unmerge operations on Patient, and inherits the standard Patient-match
          and Patient-everything operations."

       rest[0].resource:

         - type: Patient
           profile: http://example.org/fhir/StructureDefinition/IdentificationService-Patient
           interaction:
             - create    (RegisterIdentity, CreateIdentity)
             - update    (UpdateIdentityProperties, UpdateIdentityState)
             - delete    (RemoveIdentityInstance)
           searchParam:
             - name: identifier
               type: token
               origin: BASE
               baseUrl: http://hl7.org/fhir/SearchParameter/Patient-identifier
             - name: organization
               type: reference
               origin: BASE
               baseUrl: http://hl7.org/fhir/SearchParameter/Patient-organization
           operation:
             - name: merge
               definition: http://example.org/fhir/OperationDefinition/IdentificationService-Patient-merge
               origin: CUSTOM
             - name: unmerge
               definition: http://example.org/fhir/OperationDefinition/IdentificationService-Patient-unmerge
               origin: CUSTOM
             - name: match
               definition: http://hl7.org/fhir/OperationDefinition/Patient-match
               origin: BASE
             - name: everything
               definition: http://hl7.org/fhir/OperationDefinition/Patient-everything
               origin: BASE

         - type: Linkage
           profile: http://example.org/fhir/StructureDefinition/IdentificationService-Linkage
           interaction:
             - create       (LinkIdentities)
             - delete       (UnlinkIdentity)
             - search-type  (ListLinkedIdentities)
           searchParam:
             - name: item
               type: reference
               origin: BASE
               baseUrl: http://hl7.org/fhir/SearchParameter/Linkage-item
             - name: source
               type: reference
               origin: BASE
               baseUrl: http://hl7.org/fhir/SearchParameter/Linkage-source
             - name: author
               type: reference
               origin: BASE
               baseUrl: http://hl7.org/fhir/SearchParameter/Linkage-author
           operation: []

         - type: Subscription
           profile: http://example.org/fhir/StructureDefinition/IdentificationService-Subscription
           interaction:
             - create    (RequestIdentityUpdateNotifications)
             - update    (UpdateNotificationSubscription)
           searchParam:
             - name: topic
               type: reference
               origin: BASE
               baseUrl: http://hl7.org/fhir/SearchParameter/Subscription-topic
             - name: status
               type: token
               origin: BASE
               baseUrl: http://hl7.org/fhir/SearchParameter/Subscription-status
           operation: []

         - type: SubscriptionTopic
           profile: http://hl7.org/fhir/StructureDefinition/SubscriptionTopic
           interaction:
             - read       (implicit - server publishes the IdentityUpdateTopic)
             - search-type (implicit - subscribers may discover available topics)
           searchParam: []
           operation: []

       SearchParameter origin breakdown:
         BASE   : 7  (Patient.identifier, Patient.organization,
                      Linkage.item, Linkage.source, Linkage.author,
                      Subscription.topic, Subscription.status)
         CUSTOM : 0

       Operation summary:
         CUSTOM : 2  ($merge, $unmerge on Patient)
         BASE   : 2  ($match, $everything on Patient - inherit standard R5 base)
    */
}
