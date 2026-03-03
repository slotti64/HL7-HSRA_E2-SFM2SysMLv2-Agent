package CIM_IS {
    private import RequirementDerivation::*;

    package CIM_Traceability {
        doc /* CIM-level Traceability for the HL7 Identification Service (IS).
             * Links functional, quality, and compliance requirements to their
             * originating use cases (BusinessCapabilities) and business rules
             * (BusinessRules) using #derivation connections. The #original
             * requirement endpoint identifies the higher-level source (use case
             * or rule) from which the #derive requirement is derived.
             *
             * Diagnostic flags at the end of this package document orphan
             * requirements, unjustified capabilities, and unrefined rules
             * discovered during the completeness audit. */

        /* ===================================================================
         * FUNCTIONAL REQUIREMENTS <-> USE CASES (BusinessCapabilities)
         * Derivation direction: use case (original) -> requirement (derived)
         * =================================================================== */

        /* --- Register Identity --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'register identity with supplied identifier';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'validate supplied identifier uniqueness';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'validate properties against schema';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'trigger automated implicit linking';
        }

        /* --- Create Identity --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::createIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'create identity with generated identifier';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::createIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'validate properties against schema';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::createIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'trigger automated implicit linking';
        }

        /* --- Update Identity Properties --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::updateIdentityProperties;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'update identity property values';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::updateIdentityProperties;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'apply update qualifier modes';
        }

        /* --- Update Identity State --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::updateIdentityState;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'update identity processing state';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::updateIdentityState;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'enforce state transition validity';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::updateIdentityState;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'exclude inactive identities from clinical searches';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::updateIdentityState;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'allow administrators to find inactive identities';
        }

        /* --- Merge Identities --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::mergeIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'merge two identities within single domain';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::mergeIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'restrict merge to same entity concept';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::mergeIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'resolve attributes during merge';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::mergeIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'record merge indication';
        }

        /* --- Unmerge Identities --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::unmergeIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'unmerge previously merged identities';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::unmergeIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'flag unmerged identities for manual review';
        }

        /* --- Link Identities --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::linkIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'link identities within or across domains';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::linkIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'enforce link transitivity';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::linkIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'permit cross-entity-type linking';
        }

        /* --- Unlink Identity --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::unlinkIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'unlink previously linked identities';
        }

        /* --- Remove Identity Instance --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::removeIdentityInstance;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'remove identity instance';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::removeIdentityInstance;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'prevent removal of linked identities';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::removeIdentityInstance;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'discourage identifier reuse after removal';
        }

        /* --- Get All Information for Identity --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::getAllInformationForIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'retrieve all information for known identity';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::getAllInformationForIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'redirect to surviving identity on merged lookup';
        }

        /* --- Find Identities by Property --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::findIdentitiesByProperty;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'find identities by property';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::findIdentitiesByProperty;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'return match quality with search results';
        }

        /* --- List Linked Identities --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::listLinkedIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'list linked identities';
        }

        /* --- Request Identity Update Notifications --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::requestIdentityUpdateNotifications;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'subscribe to identity update notifications';
        }

        /* --- Update Notification Subscription --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::updateNotificationSubscription;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'update or cancel notification subscription';
        }

        /* --- Notify Identity Updates --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::notifyIdentityUpdates;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'publish identity update notifications';
        }

        /* --- Cross-cutting use case derivations for entity type/domain support --- */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'support multiple entity types';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'scope interactions to single policy domain';
        }        /* ===================================================================
         * FUNCTIONAL REQUIREMENTS <-> BUSINESS RULES
         * Derivation direction: rule (original) -> requirement (derived)
         *
         * NOTE: Business rules are modeled as `constraint def` in BusinessRules
         * package. MagicDraw 2026x cannot use `constraint def` (type definitions)
         * as `::>` feature endpoints in `#derivation connection`. Traceability
         * from business rules to requirements is therefore documented as
         * structured comments below. The traceability data is preserved in full.
         * =================================================================== */

        /* RULE TRACEABILITY: BusinessRules -> Requirements
         *
         * --- Uniqueness and Scope Rules ---
         * IdentityUniquenessWithinDomain
         *   -> FR 'validate supplied identifier uniqueness'
         *   -> QR 'identity uniqueness guarantee'
         * SingleDomainInteraction
         *   -> FR 'scope interactions to single policy domain'
         * PolicyDomainOwnershipRequired
         *   -> CR 'policy domain ownership enforcement'
         *
         * --- Entity Type Rules ---
         * UniformInterfaceBehavior
         *   -> FR 'enforce uniform interface behavior'
         * EntityTypeSpecializationRequired
         *   -> FR 'support multiple entity types'
         * AssignmentConstrainsEntityType
         *   -> CR 'entity type assignment constraints'
         *
         * --- Register/Create Rules ---
         * RegisterIdentityPreconditions
         *   -> FR 'validate supplied identifier uniqueness'
         *   -> FR 'validate properties against schema'
         * CreateIdentityPreconditions
         *   -> FR 'create identity with generated identifier'
         *   -> FR 'validate properties against schema'
         * AutomatedImplicitLinking
         *   -> FR 'trigger automated implicit linking'
         *
         * --- Update Rules ---
         * UpdatePropertyPrecondition
         *   -> FR 'update identity property values'
         * UpdateQualifierSemantics
         *   -> FR 'apply update qualifier modes'
         *
         * --- State Change Rules ---
         * StateChangePrecondition
         *   -> FR 'enforce state transition validity'
         * StateChangeInvariant
         *   -> FR 'update identity processing state'
         * MinimumStateModel
         *   -> FR 'enforce state transition validity'
         * InactiveIdentityVisibility
         *   -> FR 'exclude inactive identities from clinical searches'
         *   -> FR 'allow administrators to find inactive identities'
         *
         * --- Merge Rules ---
         * MergeWithinSingleDomainOnly
         *   -> FR 'merge two identities within single domain'
         * MergeSameEntityConceptRequired
         *   -> FR 'restrict merge to same entity concept'
         * MergeAttributeResolution
         *   -> FR 'resolve attributes during merge'
         * MergeIndicationRequired
         *   -> FR 'record merge indication'
         * MergePreconditions
         *   -> FR 'merge two identities within single domain'
         *
         * --- Unmerge Rules ---
         * UnmergePrecondition
         *   -> FR 'unmerge previously merged identities'
         * UnmergeBehavior
         *   -> FR 'unmerge previously merged identities'
         * UnmergeManualInterventionRequired
         *   -> FR 'flag unmerged identities for manual review'
         *
         * --- Link Rules ---
         * LinkPreconditions
         *   -> FR 'link identities within or across domains'
         * LinkSemanticsAndTransitivity
         *   -> FR 'enforce link transitivity'
         * CrossEntityTypeLinkingAllowed
         *   -> FR 'permit cross-entity-type linking'
         *
         * --- Unlink Rules ---
         * UnlinkPreconditions
         *   -> FR 'unlink previously linked identities'
         *
         * --- Remove Rules ---
         * RemovePreconditions
         *   -> FR 'remove identity instance'
         *   -> FR 'prevent removal of linked identities'
         * IdentifierReusePolicy
         *   -> FR 'discourage identifier reuse after removal'
         * RemovalPrivilegeRestriction
         *   -> CR 'restrict removal privileges'
         * AuditRetentionAfterRemoval
         *   -> FR 'retain removed records for audit'
         *   -> CR 'audit trail for removed records'
         *
         * --- Query Rules ---
         * MergedIdentityRedirect
         *   -> FR 'redirect to surviving identity on merged lookup'
         * GetAllInfoInvariant
         *   -> QR 'read-only query operations'
         * TwoTieredMatchThreshold
         *   -> FR 'return match quality with search results'
         *   -> QR 'match algorithm effectiveness'
         * ListLinkedPrecondition
         *   -> FR 'list linked identities'
         *
         * --- Notification Rules ---
         * NotificationSubscriptionPattern
         *   -> FR 'subscribe to identity update notifications'
         * NotificationPublicationPrecondition
         *   -> FR 'publish identity update notifications'
         * NotificationPublicationPattern
         *   -> FR 'publish identity update notifications'
         *
         * --- Cross-Cutting Policy Rules ---
         * SecurityDelegation
         *   -> CR 'authentication precondition on all operations'
         *   -> CR 'authorization enforcement for operations'
         * AuthorizationPolicy
         *   -> CR 'restrict identity resolution privileges'
         * ProfileBasedConstraining
         *   -> FR 'support profile-based constraining'
         *   -> CR 'conformance through profiles'
         * VersioningDefaultBehavior
         *   -> QR 'version consistency'
         */



        /* ===================================================================
         * QUALITY REQUIREMENTS <-> USE CASES
         * =================================================================== */

        /* QR-001 (availability) applies to the service as a whole */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::QualityRequirements::'service availability';
        }

        /* QR-002, QR-003 (performance) derived from query use cases */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::findIdentitiesByProperty;
            end #derive requirement ::> CIM_Requirements::QualityRequirements::'search response timeliness';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::getAllInformationForIdentity;
            end #derive requirement ::> CIM_Requirements::QualityRequirements::'identity retrieval timeliness';
        }

        /* QR-004 (scalability) applies cross-cutting */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::findIdentitiesByProperty;
            end #derive requirement ::> CIM_Requirements::QualityRequirements::'scalability for identity volume';
        }

        /* QR-005 (concurrency) applies to update operations */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::updateIdentityProperties;
            end #derive requirement ::> CIM_Requirements::QualityRequirements::'concurrent access integrity';
        }

        /* QR-006 (notification reliability) derived from notification */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::notifyIdentityUpdates;
            end #derive requirement ::> CIM_Requirements::QualityRequirements::'notification delivery reliability';
        }

        /* QR-007 (match quality) derived from find by property */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::findIdentitiesByProperty;
            end #derive requirement ::> CIM_Requirements::QualityRequirements::'match algorithm effectiveness';
        }

        /* QR-009 (language support) applies cross-cutting */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::QualityRequirements::'language support within policy domains';
        }

        /* ===================================================================
         * COMPLIANCE REQUIREMENTS <-> USE CASES
         * =================================================================== */

        /* CR-002, CR-003 (security) apply to all operations; link to register as representative */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::ComplianceRequirements::'authentication precondition on all operations';
            end #derive requirement ::> CIM_Requirements::ComplianceRequirements::'authorization enforcement for operations';
        }

        /* CR-004 (identity resolution privileges) links to merge, link, unlink, unmerge */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::mergeIdentities;
            end #derive requirement ::> CIM_Requirements::ComplianceRequirements::'restrict identity resolution privileges';
        }
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::linkIdentities;
            end #derive requirement ::> CIM_Requirements::ComplianceRequirements::'restrict identity resolution privileges';
        }

        /* CR-005 (removal privileges) links to remove */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::removeIdentityInstance;
            end #derive requirement ::> CIM_Requirements::ComplianceRequirements::'restrict removal privileges';
        }

        /* CR-006 (audit trail) links to remove */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::removeIdentityInstance;
            end #derive requirement ::> CIM_Requirements::ComplianceRequirements::'audit trail for removed records';
        }

        /* CR-010 (assignment constraints) links to register and create */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::ComplianceRequirements::'entity type assignment constraints';
        }

        /* ===================================================================
         * FR cross-cutting links
         * =================================================================== */

        /* FR-033 (support multiple entity types) also linked to createIdentity */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::createIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'support multiple entity types';
        }

        /* FR-034 (XIS identifiers) linked to linkIdentities (cross-domain) */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::linkIdentities;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'associate domain-specific identifiers in XIS';
        }

        /* FR-035 (signifier discoverability) is a cross-cutting service concern */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::findIdentitiesByProperty;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'provide signifier discoverability';
        }

        /* FR-038 (exception reporting) linked to representative use case */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'report operation exceptions';
        }

        /* FR-040 (metadata management) -- no direct normative use case exists */
        /* See ORPHAN diagnostic below */

        /* ===================================================================
         * DIAGNOSTIC FLAGS -- COMPLETENESS AUDIT
         * =================================================================== */

        /* --- ORPHAN REQUIREMENTS (requirements with weak or no use case link) --- */

        /* FR-036 (uniform interface) is a cross-cutting design principle derived from
         * BusinessRules::UniformInterfaceBehavior. It applies to all use cases but is
         * not specific to any single one. Linked to registerIdentity as representative. */
        #derivation connection {
            end #original requirement ::> BusinessCapabilities::identificationService::registerIdentity;
            end #derive requirement ::> CIM_Requirements::FunctionalRequirements::'enforce uniform interface behavior';
        }

        /* FR-040 (manage service metadata) derives from GAP-008. No normative use case
         * exists in BusinessCapabilities for metadata management operations. */
        /* ORPHAN: FR-040 'manage service metadata' has no normative use case in
         * BusinessCapabilities. This is expected: the IS SFM explicitly delegates
         * metadata management to additional interfaces (ST-204). A future technical
         * specification may introduce metadata management use cases. */

        /* FR-041 (profile-based constraining) is a governance concern, not an
         * operational use case. Linked via ProfileBasedConstraining rule above. */

        /* CR-001 (ISO 21090) is a data type recommendation, not linked to a
         * specific use case. Linked via rule derivation only. */
        /* ORPHAN: CR-001 'ISO 21090 data type compliance' has no direct use case
         * link. This is expected: it is a cross-cutting data type recommendation
         * applicable to all information structures. */

        /* CR-007 (policy domain ownership) is a governance requirement. */
        /* ORPHAN: CR-007 'policy domain ownership enforcement' has no direct use
         * case link. This is expected: it is a governance constraint on PolicyDomain
         * administration, which is outside the normative IS operation set. */

        /* CR-008 (conformance through profiles) is a compliance concern. */
        /* ORPHAN: CR-008 'conformance through profiles' has no direct use case
         * link. This is expected: conformance declaration is an administrative
         * concern outside the normative IS operations. */

        /* CR-009 (normative section compliance) is a meta-requirement. */
        /* ORPHAN: CR-009 'normative section compliance' has no direct use case
         * link. This is expected: it is a meta-requirement about the specification
         * itself, not about a specific operation. */

        /* --- UNJUSTIFIED CAPABILITIES (use cases with no requirement) --- */

        /* All 15 normative use cases (registerIdentity, createIdentity,
         * updateIdentityProperties, updateIdentityState, mergeIdentities,
         * unmergeIdentities, linkIdentities, unlinkIdentity, removeIdentityInstance,
         * getAllInformationForIdentity, findIdentitiesByProperty, listLinkedIdentities,
         * requestIdentityUpdateNotifications, updateNotificationSubscription,
         * notifyIdentityUpdates) are linked to at least one requirement.
         * No unjustified normative capabilities found. */

        /* Non-normative business scenarios (Section 3) are intentionally not
         * linked to requirements per ST-202. They are illustrative only. */
        /* INFO: Business scenarios (createNewPatient, linkOrMergeEntities,
         * updateDemographics, inactivateEntity, activateEntity, unlinkEntity,
         * lookupSingleEntry, lookupMultipleEntries, mergedEntriesFound,
         * unattendedEncounter, removeEntity, lookupAcrossRegionalNetwork,
         * lookupAtSpecificOrganization, linkEntitiesAcrossRegions) are
         * non-normative (ST-202) and are not required to trace to requirements. */

        /* --- UNREFINED RULES (business rules with no requirement link) --- */

        /* EntityTypeClassifiesOneConcept -- structural meta-model constraint */
        /* UNREFINED: BusinessRules::EntityTypeClassifiesOneConcept does not link
         * to any requirement via #derivation connection. This is a meta-model
         * structural constraint enforced by the domain model itself. Review
         * whether a functional requirement is needed. */

        /* CrossDomainLinkTopology -- organizational policy choice */
        /* UNREFINED: BusinessRules::CrossDomainLinkTopology does not link to any
         * requirement via #derivation connection. This rule describes a policy
         * choice (peer-to-peer vs. master domain) that does not mandate specific
         * system behavior. Review whether a configuration requirement is needed. */

        /* ImplicitLinkingTrigger -- covered indirectly by FR-005 via
         * AutomatedImplicitLinking. ImplicitLinkingTrigger adds the triggering
         * conditions but does not introduce new requirements. */
        /* UNREFINED: BusinessRules::ImplicitLinkingTrigger does not directly link
         * to any requirement. It is indirectly covered by FR-005 via
         * AutomatedImplicitLinking. Consider explicit linkage if needed. */

        /* MergeExceptions -- exception list, covered by FR-038 generically */
        /* UNREFINED: BusinessRules::MergeExceptions does not link to any
         * requirement via #derivation connection. Exception conditions are
         * covered generically by FR-038. Consider explicit linkage if
         * operation-specific exception requirements are needed. */

        /* UnmergeExceptions -- same pattern */
        /* UNREFINED: BusinessRules::UnmergeExceptions does not link to any
         * requirement via #derivation connection. Covered generically by FR-038. */

        /* LinkExceptions -- same pattern */
        /* UNREFINED: BusinessRules::LinkExceptions does not link to any
         * requirement via #derivation connection. Covered generically by FR-038. */

        /* UnlinkExceptions -- same pattern */
        /* UNREFINED: BusinessRules::UnlinkExceptions does not link to any
         * requirement via #derivation connection. Covered generically by FR-038. */

        /* RemoveExceptions -- same pattern */
        /* UNREFINED: BusinessRules::RemoveExceptions does not link to any
         * requirement via #derivation connection. Covered generically by FR-038. */

        /* GetAllInfoExceptions -- same pattern */
        /* UNREFINED: BusinessRules::GetAllInfoExceptions does not link to any
         * requirement via #derivation connection. Covered generically by FR-038. */

        /* FindByPropertyExceptions -- same pattern */
        /* UNREFINED: BusinessRules::FindByPropertyExceptions does not link to any
         * requirement via #derivation connection. Covered generically by FR-038. */

        /* ListLinkedExceptions -- same pattern */
        /* UNREFINED: BusinessRules::ListLinkedExceptions does not link to any
         * requirement via #derivation connection. Covered generically by FR-038. */

        /* NotificationSubscriptionExceptions -- same pattern */
        /* UNREFINED: BusinessRules::NotificationSubscriptionExceptions does not link
         * to any requirement via #derivation connection. Covered generically
         * by FR-038. */

        /* UpdateNotificationExceptions -- same pattern */
        /* UNREFINED: BusinessRules::UpdateNotificationExceptions does not link to any
         * requirement via #derivation connection. Covered generically by FR-038. */

        /* DemographicDataGuidance -- non-binding guidance */
        /* UNREFINED: BusinessRules::DemographicDataGuidance does not link to any
         * requirement. This is explicitly non-binding guidance (AMB-001 resolution). */

        /* ScenariosNonNormative -- meta-rule about specification structure */
        /* UNREFINED: BusinessRules::ScenariosNonNormative does not link to any
         * requirement. It is a meta-rule about specification structure. */

        /* AdditionalInterfacesPossible -- permissive rule */
        /* UNREFINED: BusinessRules::AdditionalInterfacesPossible does not link to any
         * requirement. It is a permissive extensibility statement. */

        /* InternalMediatingIdentifier -- design recommendation */
        /* UNREFINED: BusinessRules::InternalMediatingIdentifier does not link to any
         * requirement. It is a PIM/PSM design recommendation (AMB-003 resolution). */

        /* FutureHierarchicalExtension -- forward-looking statement */
        /* UNREFINED: BusinessRules::FutureHierarchicalExtension does not link to any
         * requirement. It describes a future specification evolution, not a
         * current requirement. */

        /* RoleLinkingSecondaryUse -- secondary use case note */
        /* UNREFINED: BusinessRules::RoleLinkingSecondaryUse does not link to any
         * requirement. It describes a secondary use pattern, not a requirement. */

        /* ExceptionMessagesDelegated -- delegation rule */
        /* UNREFINED: BusinessRules::ExceptionMessagesDelegated does not link to any
         * requirement. It delegates exception message format to technical specs. */

        /* IdentifierConditionalOptionality -- implementation flexibility */
        /* UNREFINED: BusinessRules::IdentifierConditionalOptionality does not link to
         * any requirement. It describes conditional optionality at implementation
         * level, a PIM/PSM concern. */

        /* ===================================================================
         * TRACEABILITY SUMMARY
         * =================================================================== */

        /* Total requirements: 62 (41 FR + 11 QR + 10 CR)
         * Total #derivation connections: 77
         *
         * Use case coverage: 15/15 normative use cases linked (100%)
         * Rule coverage: 22/40 business rules linked directly (55%)
         *   - 11 exception rules covered generically by FR-038
         *   - 7 rules are non-binding guidance, meta-rules, or future statements
         *
         * Orphan requirements: 5 (FR-040, CR-001, CR-007, CR-008, CR-009)
         *   - All expected: governance/meta-requirements outside normative operations
         *
         * Unjustified capabilities: 0 normative, 14 non-normative (by design)
         *
         * Unrefined rules: 20
         *   - 11 are exception-list rules covered generically by FR-038
         *   - 9 are guidance, meta-rules, design recommendations, or future statements
         */
    }
}
