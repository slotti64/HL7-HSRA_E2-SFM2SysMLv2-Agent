package PIM_IS {

    package BehavioralFlows {
        doc /* PIM-level Behavioral Flows for the HL7 Identification Service (IS).
             * Models multi-step workflow orchestrations derived from CIM business
             * scenarios (SFM Section 3, non-normative) that compose normative PIM
             * operations from PIM_IS.Operations.
             *
             * CONSERVATISM NOTE: Only workflows explicitly described as multi-step
             * sequences in the SFM are modeled here. Single-operation scenarios
             * (Inactivate, Activate, Remove, single-result Lookup, merged-entry
             * redirect) are NOT given flows because they map 1:1 to individual
             * PIM operations and have no orchestration to model.
             *
             * Workflow derivation sources:
             *   ST-048 -> CreateNewPatientFlow (search, broader search, register)
             *   ST-052 -> LinkOrMergeEntitiesFlow (search, decide, link or merge)
             *   ST-056 -> UpdateDemographicsFlow (search, retrieve, update)
             *   ST-064 -> UnlinkEntityFlow (search, list links, unlink)
             *   ST-187 -> UnattendedEncounterFlow (search, decide on 4 outcomes)
             *   ST-200 -> CrossRegionLinkFlow (search cross-region, register local, link)
             */

        /* ===================================================================
         * FLOW 1: CREATE NEW PATIENT
         * Derived from CIM scenario: createNewPatient [ST-048]
         * SFM Section 3.2.1 sequence diagram
         *
         * Sequence: Carol searches IS via HIS (not found), searches with
         * additional info (not found), then registers a new identity.
         * =================================================================== */

        action def CreateNewPatientFlow {
            doc /* Orchestrates the new patient registration workflow.
                 * Derived from CIM scenario createNewPatient [ST-048].
                 * Composes: FindIdentitiesByProperty, FindIdentitiesByProperty,
                 * RegisterIdentity.
                 *
                 * Traces to CIM: BusinessCapabilities::singleDomainScenarios::createNewPatient */

            in item initialSearchRequest : DataModel::FindIdentitiesByPropertyRequest;
            in item broaderSearchRequest : DataModel::FindIdentitiesByPropertyRequest;
            in item registrationRequest : DataModel::RegisterIdentityRequest;
            out item registrationResponse : DataModel::RegisterIdentityResponse;

            action initialSearch : Operations::FindIdentitiesByProperty {
                doc /* Step 1: Search by name and address. [ST-049] */
                in item request = CreateNewPatientFlow::initialSearchRequest;
            }

            action broaderSearch : Operations::FindIdentitiesByProperty {
                doc /* Step 2: Search with additional identifying information. [ST-050] */
                in item request = CreateNewPatientFlow::broaderSearchRequest;
            }

            action register : Operations::RegisterIdentity {
                doc /* Step 3: Register new identity after searches return empty. [ST-051] */
                in item request = CreateNewPatientFlow::registrationRequest;
            }

            /* Sequential succession: search -> broader search -> register */
            ref first start then initialSearch;
            ref first initialSearch then broaderSearch;
            ref first broaderSearch then register;
            ref first register then done;
        }

        /* ===================================================================
         * FLOW 2: LINK OR MERGE ENTITIES
         * Derived from CIM scenario: linkOrMergeEntities [ST-052]
         * SFM Section 3.2.2 sequence diagrams (two variants)
         *
         * Sequence: Nancy searches and finds two similar entries, then
         * depending on hospital policy either links or merges them.
         * =================================================================== */

        action def LinkOrMergeEntitiesFlow {
            doc /* Orchestrates the duplicate identity resolution workflow.
                 * Derived from CIM scenario linkOrMergeEntities [ST-052, ST-053].
                 * Composes: FindIdentitiesByProperty, then conditionally
                 * LinkIdentities OR MergeIdentities based on organizational policy.
                 *
                 * Traces to CIM: BusinessCapabilities::singleDomainScenarios::linkOrMergeEntities */

            in item searchRequest : DataModel::FindIdentitiesByPropertyRequest;
            in item linkRequest : DataModel::LinkIdentitiesRequest;
            in item mergeRequest : DataModel::MergeIdentitiesRequest;
            out item linkResponse : DataModel::LinkIdentitiesResponse;
            out item mergeResponse : DataModel::MergeIdentitiesResponse;

            action searchForDuplicates : Operations::FindIdentitiesByProperty {
                doc /* Step 1: Search for the patient, returning multiple candidates. [ST-054] */
                in item request = LinkOrMergeEntitiesFlow::searchRequest;
            }

            /* Decision: link vs. merge based on organizational policy [ST-053] */
            decide policyDecision;

            action linkIdentities : Operations::LinkIdentities {
                doc /* Step 2a: Link the records as active peers. [ST-054] */
                in item request = LinkOrMergeEntitiesFlow::linkRequest;
            }

            action mergeIdentities : Operations::MergeIdentities {
                doc /* Step 2b: Merge the records, deprecating the source. [ST-055] */
                in item request = LinkOrMergeEntitiesFlow::mergeRequest;
            }

            merge resolutionComplete;

            /* Succession: search -> decide -> (link | merge) -> done */
            ref first start then searchForDuplicates;
            ref first searchForDuplicates then policyDecision;
            first policyDecision if "organizational policy dictates linking" then linkIdentities;
            first policyDecision if "organizational policy dictates merging" then mergeIdentities;
            ref first linkIdentities then resolutionComplete;
            ref first mergeIdentities then resolutionComplete;
            ref first resolutionComplete then done;
        }

        /* ===================================================================
         * FLOW 3: UPDATE DEMOGRAPHICS
         * Derived from CIM scenario: updateDemographics [ST-056]
         * SFM Section 3.2.3 sequence diagram
         *
         * Sequence: Carol searches, finds near-match with confidence score,
         * retrieves full record, verifies identity, then updates properties.
         * =================================================================== */

        action def UpdateDemographicsFlow {
            doc /* Orchestrates the demographic update workflow.
                 * Derived from CIM scenario updateDemographics [ST-056, ST-057, ST-058].
                 * Composes: FindIdentitiesByProperty, GetAllInformation,
                 * UpdateIdentityProperties.
                 *
                 * Traces to CIM: BusinessCapabilities::singleDomainScenarios::updateDemographics */

            in item searchRequest : DataModel::FindIdentitiesByPropertyRequest;
            in item retrievalRequest : DataModel::GetAllInformationRequest;
            in item updateRequest : DataModel::UpdateIdentityPropertiesRequest;
            out item updateResponse : DataModel::UpdateIdentityPropertiesResponse;

            action searchNearMatches : Operations::FindIdentitiesByProperty {
                doc /* Step 1: Search for the patient, returning near-matches with
                     * quality-of-match indicators. [ST-057] */
                in item request = UpdateDemographicsFlow::searchRequest;
            }

            action retrieveFullRecord : Operations::GetAllInformation {
                doc /* Step 2: Retrieve the full record for the top-matching candidate
                     * to verify identity. [ST-056] */
                in item request = UpdateDemographicsFlow::retrievalRequest;
            }

            action updateProperties : Operations::UpdateIdentityProperties {
                doc /* Step 3: Update the patient's demographic properties (e.g.,
                     * address, phone number). [ST-058] */
                in item request = UpdateDemographicsFlow::updateRequest;
            }

            /* Sequential succession: search -> retrieve -> update */
            ref first start then searchNearMatches;
            ref first searchNearMatches then retrieveFullRecord;
            ref first retrieveFullRecord then updateProperties;
            ref first updateProperties then done;
        }

        /* ===================================================================
         * FLOW 4: UNLINK ENTITY
         * Derived from CIM scenario: unlinkEntity [ST-064]
         * SFM Section 3.2.6 sequence diagram
         *
         * Sequence: Carol searches and discovers erroneous link, retrieves
         * alias list via ListLinkedIdentities, reviews and requests unlink.
         * =================================================================== */

        action def UnlinkEntityFlow {
            doc /* Orchestrates the erroneous link removal workflow.
                 * Derived from CIM scenario unlinkEntity [ST-064, ST-065, ST-066].
                 * Composes: FindIdentitiesByProperty, ListLinkedIdentities,
                 * UnlinkIdentity.
                 *
                 * Traces to CIM: BusinessCapabilities::singleDomainScenarios::unlinkEntity */

            in item searchRequest : DataModel::FindIdentitiesByPropertyRequest;
            in item listLinkedRequest : DataModel::ListLinkedIdentitiesRequest;
            in item unlinkRequest : DataModel::UnlinkIdentityRequest;
            out item unlinkResponse : DataModel::UnlinkIdentityResponse;

            action searchAndDiscover : Operations::FindIdentitiesByProperty {
                doc /* Step 1: Search for the patient, discovering the erroneous
                     * link situation. [ST-064] */
                in item request = UnlinkEntityFlow::searchRequest;
            }

            action retrieveLinkedIdentities : Operations::ListLinkedIdentities {
                doc /* Step 2: Retrieve all identities linked to the subject to
                     * identify the erroneous link. [ST-065] */
                in item request = UnlinkEntityFlow::listLinkedRequest;
            }

            action performUnlink : Operations::UnlinkIdentity {
                doc /* Step 3: Remove the erroneous link between the two
                     * identity instances. [ST-066] */
                in item request = UnlinkEntityFlow::unlinkRequest;
            }

            /* Sequential succession: search -> list links -> unlink */
            ref first start then searchAndDiscover;
            ref first searchAndDiscover then retrieveLinkedIdentities;
            ref first retrieveLinkedIdentities then performUnlink;
            ref first performUnlink then done;
        }

        /* ===================================================================
         * FLOW 5: UNATTENDED ENCOUNTER
         * Derived from CIM scenario: unattendedEncounter [ST-187]
         * SFM Section 3.2.8 sequence diagram
         *
         * Sequence: Referral system receives HL7 message, searches IS for
         * patient identity. Four possible outcomes based on search result:
         *   1. Definite match found -> complete processing [ST-188]
         *   2. Presumptive matches -> await user determination [ST-189]
         *   3. No match -> auto-create identity [ST-190]
         *   4. No match -> await user instruction [ST-191]
         * =================================================================== */

        action def UnattendedEncounterFlow {
            doc /* Orchestrates the unattended patient identity resolution workflow.
                 * Derived from CIM scenario unattendedEncounter
                 * [ST-187, ST-188, ST-189, ST-190, ST-191].
                 * Composes: FindIdentitiesByProperty, then conditionally
                 * CreateIdentity (for auto-create outcome).
                 *
                 * Traces to CIM: BusinessCapabilities::singleDomainScenarios::unattendedEncounter */

            in item searchRequest : DataModel::FindIdentitiesByPropertyRequest;
            in item createRequest : DataModel::CreateIdentityRequest;
            out item searchResponse : DataModel::FindIdentitiesByPropertyResponse;
            out item createResponse : DataModel::CreateIdentityResponse;

            action attemptIdentityResolution : Operations::FindIdentitiesByProperty {
                doc /* Step 1: Search for the patient using referral information. [ST-187] */
                in item request = UnattendedEncounterFlow::searchRequest;
            }

            /* Decision: outcome depends on search results [ST-188, ST-189, ST-190, ST-191] */
            decide resolutionOutcome;

            action autoCreateIdentity : Operations::CreateIdentity {
                doc /* Step 2 (outcome #3): No match found and referral system rules
                     * dictate automatic creation of a new identity. [ST-190] */
                in item request = UnattendedEncounterFlow::createRequest;
            }

            /* Outcomes #1, #2, #4 do not invoke additional PIM operations:
             * #1 (definite match): processing completes with search result [ST-188]
             * #2 (presumptive matches): awaits user determination [ST-189]
             * #4 (no match, manual): awaits user instruction [ST-191]
             * These are modeled as terminal paths without further PIM operations. */
            action completeWithMatch {
                doc /* Outcome #1: Definite match found, referral processing completes. [ST-188] */
            }

            action awaitUserDetermination {
                doc /* Outcome #2: Presumptive matches returned, awaiting human review. [ST-189]
                     * Outcome #4: No match found, awaiting user instruction. [ST-191] */
            }

            merge encounterResolved;

            /* Succession: search -> decide -> (auto-create | complete | await) -> done */
            ref first start then attemptIdentityResolution;
            ref first attemptIdentityResolution then resolutionOutcome;
            first resolutionOutcome if "definite match found" then completeWithMatch;
            first resolutionOutcome if "no match and auto-create rules configured" then autoCreateIdentity;
            first resolutionOutcome if "presumptive matches or manual fallback" then awaitUserDetermination;
            ref first completeWithMatch then encounterResolved;
            ref first autoCreateIdentity then encounterResolved;
            ref first awaitUserDetermination then encounterResolved;
            ref first encounterResolved then done;
        }

        /* ===================================================================
         * FLOW 6: CROSS-REGION LINK
         * Derived from CIM scenario: linkEntitiesAcrossRegions [ST-200]
         * SFM Section 3.3.3 sequence diagram
         *
         * Sequence: Eric searches locally (not found), searches across
         * Solar System via XIS (found in East), registers new local identity
         * in North region, then links local to master in XIS.
         * =================================================================== */

        action def CrossRegionLinkFlow {
            doc /* Orchestrates the cross-regional identity linking workflow.
                 * Derived from CIM scenario linkEntitiesAcrossRegions [ST-200, ST-201].
                 * Composes: FindIdentitiesByProperty (cross-region search),
                 * RegisterIdentity (local registration), LinkIdentities (cross-domain link).
                 *
                 * Traces to CIM: BusinessCapabilities::multiDomainScenarios::linkEntitiesAcrossRegions */

            in item crossRegionSearchRequest : DataModel::FindIdentitiesByPropertyRequest;
            in item localRegistrationRequest : DataModel::RegisterIdentityRequest;
            in item crossDomainLinkRequest : DataModel::LinkIdentitiesRequest;
            out item linkResponse : DataModel::LinkIdentitiesResponse;

            action searchAcrossRegions : Operations::FindIdentitiesByProperty {
                doc /* Step 1: Search across the regional network via XIS to find
                     * the patient's identity in another region. [ST-200] */
                in item request = CrossRegionLinkFlow::crossRegionSearchRequest;
            }

            action registerLocalIdentity : Operations::RegisterIdentity {
                doc /* Step 2: Register a new local identity in the current region
                     * so the local HIS can process the patient. [ST-201] */
                in item request = CrossRegionLinkFlow::localRegistrationRequest;
            }

            action linkToMaster : Operations::LinkIdentities {
                doc /* Step 3: Create a cross-domain link in the master XIS to tie
                     * the new regional identifier to the master identifier. [ST-201] */
                in item request = CrossRegionLinkFlow::crossDomainLinkRequest;
            }

            /* Sequential succession: search -> register -> link */
            ref first start then searchAcrossRegions;
            ref first searchAcrossRegions then registerLocalIdentity;
            ref first registerLocalIdentity then linkToMaster;
            ref first linkToMaster then done;
        }

        /* ===================================================================
         * WORKFLOWS NOT MODELED (conservatism justification)
         * ===================================================================
         *
         * The following SA1 WORKFLOW entries are NOT given behavioral flow
         * definitions because they consist of a single PIM operation invocation
         * with no multi-step orchestration to model:
         *
         * ST-059 Inactivate Entity: single UpdateIdentityState call
         * ST-062 Activate Entity: single UpdateIdentityState call
         * ST-181 Lookup Single Entry: single FindIdentitiesByProperty call
         * ST-183 Lookup Multiple Entries: repeated FindIdentitiesByProperty calls
         *         (same operation iterated, not a multi-operation composition)
         * ST-185 Merged Entries Found: single GetAllInformation call
         * ST-192 Remove Entity: single RemoveIdentityInstance call
         * ST-196 Lookup Across Regional Network: single FindIdentitiesByProperty
         *         (federated routing is an infrastructure concern, not PIM orchestration)
         * ST-198 Lookup at Specific Organization: single FindIdentitiesByProperty
         *         (directed routing is an infrastructure concern, not PIM orchestration)
         * =================================================================== */
    }
}
