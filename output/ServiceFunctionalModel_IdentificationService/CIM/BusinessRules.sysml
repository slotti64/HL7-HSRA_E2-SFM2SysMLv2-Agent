package CIM_IS {

    package BusinessRules {
        doc /* CIM-level Business Rules for the HL7 Identification Service (IS).
             * Defines all business constraints, preconditions, postconditions,
             * invariants, and policies derived from the IS SFM Section 4 (normative)
             * and related policy statements. Rules are modeled as constraint
             * definitions with formalized Boolean expressions where possible.
             * [ST-203] */

        /* ===================================================================
         * IDENTITY UNIQUENESS AND SCOPE RULES
         * =================================================================== */

        constraint def IdentityUniquenessWithinDomain {
            doc /* An identity instance identifier must be unique within the scope
                 * of its PolicyDomain and EntityType combination. No two identity
                 * instances may share the same identifier for the same EntityType
                 * within the same PolicyDomain.
                 * [ST-085, ST-082] */
            constraint {
                identityInstance.instanceDesignation != otherInstance.instanceDesignation
                or identityInstance.governingAssignment != otherInstance.governingAssignment
            }
        }

        constraint def SingleDomainInteraction {
            doc /* Any individual interaction with the Identification Service occurs
                 * with respect to one specific PolicyDomain, other than explicit
                 * linking of entities across PolicyDomains. Management operations
                 * (register, create, update, merge, unmerge, remove) operate within
                 * a single PolicyDomain scope.
                 * [ST-034, ST-036] */
        }

        constraint def PolicyDomainOwnershipRequired {
            doc /* Each PolicyDomain must have an owner who can define the policy
                 * and the entity types supported within the PolicyDomain.
                 * [ST-030, ST-180] */
        }

        /* ===================================================================
         * ENTITY TYPE AND SEMANTIC SIGNIFIER RULES
         * =================================================================== */

        constraint def UniformInterfaceBehavior {
            doc /* The behavioral structure of the Identification Service is invariant
                 * across the different contents (EntityTypes/semantic signifiers) that
                 * the service can manage. The interface functionality for identifying
                 * different kinds of entities is the same.
                 * [ST-021, ST-022] */
        }

        constraint def EntityTypeSpecializationRequired {
            doc /* This specification provides capabilities for managing identifiers
                 * for generic entities. There will be a need to specialize the
                 * information model (semantic signifier) for specific types of
                 * entity, such as Person, Patient, or Provider.
                 * [ST-028] */
        }

        constraint def EntityTypeClassifiesOneConcept {
            doc /* Each EntityType classifies exactly one EntityConcept. This
                 * establishes the semantic relationship that allows different
                 * representations of the same underlying concept.
                 * [ST-071, ST-073, meta-model] */
            constraint {
                entityType.classifiedConcept->size() == 1
            }
        }

        constraint def AssignmentConstrainsEntityType {
            doc /* An EntityTypeAssignment may only further constrain the schema
                 * and validation rules defined for the EntityType. The constrained
                 * versions cannot introduce new unconstrained elements.
                 * [ST-074, ST-075] */
        }

        /* ===================================================================
         * REGISTER / CREATE IDENTITY RULES
         * =================================================================== */

        constraint def RegisterIdentityPreconditions {
            doc /* For registering an identity: the supplied identifier must not
                 * already exist within the service for the EntityType/PolicyDomain
                 * combination. The PolicyDomain and EntityType must be recognized.
                 * Properties must validate against the schema for the EntityType/
                 * PolicyDomain combination.
                 * [ST-085, ST-086, ST-087] */
        }

        constraint def CreateIdentityPreconditions {
            doc /* For creating an identity (service-generated identifier): the
                 * PolicyDomain and EntityType must be recognized. Properties must
                 * validate against the schema for the EntityType/PolicyDomain
                 * combination.
                 * [ST-088, ST-089, ST-090] */
        }

        constraint def AutomatedImplicitLinking {
            doc /* Service implementations are expected to provide some level of
                 * automated implicit linking capabilities. This can be triggered
                 * when a new entity is created or properties are updated. The
                 * triggered behavior should follow the Link Identities rules.
                 * Automated merging based on automated logic is not encouraged.
                 * [ST-087, ST-128] */
        }

        /* ===================================================================
         * UPDATE IDENTITY RULES
         * =================================================================== */

        constraint def UpdatePropertyPrecondition {
            doc /* The identity specified by the identifier must exist in the service
                 * before properties can be updated. The PolicyDomain and EntityType
                 * must be recognized. Properties must validate against the schema.
                 * [ST-093, ST-094, ST-095] */
            constraint {
                identityInstance.status != null
            }
        }

        constraint def UpdateQualifierSemantics {
            doc /* The update qualifier defines the update mode:
                 * OVERWRITE: replaces the entire set of data elements including nulls.
                 * VALUED: replaces only non-null submitted values; nulls in submitted
                 * data do not replace existing values.
                 * UNSPECIFIED: implementation-specific behavior.
                 * [ST-096] */
        }

        /* ===================================================================
         * STATE CHANGE RULES
         * =================================================================== */

        constraint def StateChangePrecondition {
            doc /* The identifier must identify an entity in an appropriate previous
                 * state for the requested status change. The previous state must
                 * be compatible with the requested new state.
                 * [ST-098, ST-099, ST-104] */
        }

        constraint def StateChangeInvariant {
            doc /* When changing the processing state of an identity, all identity
                 * information is unchanged except for the state itself.
                 * [ST-103] */
        }

        constraint def MinimumStateModel {
            doc /* The minimum state model defines the concepts of ACTIVE and INACTIVE
                 * states. Inactive identities do not appear in normal searches or
                 * allow linking or merging. However, the definition and meaning of
                 * states is configurable and may vary depending on organizational
                 * policy and EntityType.
                 * [ST-105, ST-106] */
        }

        constraint def InactiveIdentityVisibility {
            doc /* After an identity is set to inactive, it should not be considered
                 * in any search for clinically active entities. This does not preclude
                 * administrators from finding the entry using administrative tools.
                 * [ST-061] */
        }

        /* ===================================================================
         * MERGE RULES
         * =================================================================== */

        constraint def MergeWithinSingleDomainOnly {
            doc /* Merge capability is restricted to be within a single PolicyDomain
                 * only. The Link capability should be used for cross-domain
                 * association of identities.
                 * [ST-108] */
            constraint {
                sourceIdentity.governingAssignment.governingDomain
                == targetIdentity.governingAssignment.governingDomain
            }
        }

        constraint def MergeSameEntityConceptRequired {
            doc /* Merge should be restricted to identities of the same EntityType.
                 * Implementations may apply this to different EntityTypes that
                 * represent the same EntityConcept, provided that the semantic
                 * signifiers are compatible.
                 * [ST-109] */
            constraint {
                sourceIdentity.governingAssignment.assignedEntityType.classifiedConcept
                == targetIdentity.governingAssignment.assignedEntityType.classifiedConcept
            }
        }

        constraint def MergeAttributeResolution {
            doc /* During merge: identifying attributes in the target that are empty
                 * are filled from the source. Existing attributes in the target
                 * remain as they are. The source identity is deprecated.
                 * [ST-110] */
        }

        constraint def MergeIndicationRequired {
            doc /* The implementation must provide a mechanism to indicate that two
                 * identities have been merged (e.g., by use of an explicit link
                 * relationship or by using a correlation set).
                 * [ST-111] */
        }

        constraint def MergePreconditions {
            doc /* Both identities to be merged must exist in the system. Source
                 * and target identities must be in an allowable state for the
                 * merge capability. Both identities must be in the same PolicyDomain.
                 * Identities must be classified as EntityTypes that represent the
                 * same EntityConcept.
                 * [ST-112] */
        }

        constraint def MergeExceptions {
            doc /* Merge operation exception conditions: target identity does not
                 * exist, source identity does not exist, unrecognized PolicyDomain,
                 * unrecognized EntityType, unrecognized link method, source state
                 * not permitted, target state not permitted.
                 * [ST-114] */
        }

        /* ===================================================================
         * UNMERGE RULES
         * =================================================================== */

        constraint def UnmergePrecondition {
            doc /* The identity must have resulted from a previous merge. The supplied
                 * identities must have been previously merged.
                 * [ST-117] */
        }

        constraint def UnmergeBehavior {
            doc /* Unmerge reinstates a previously deprecated identity. The state of
                 * unmerged identities cannot be guaranteed to be valid. Whatever
                 * mechanism recorded the merge association is reversed. No attribute
                 * values are updated, only states.
                 * [ST-116] */
        }

        constraint def UnmergeManualInterventionRequired {
            doc /* From an overall process perspective, unmerge should require manual
                 * intervention afterwards. Implementations may enforce an inactive
                 * status on unmerged entities until a further update is carried out.
                 * [ST-120] */
        }

        constraint def UnmergeExceptions {
            doc /* Unmerge operation exception conditions: identifier not recognized,
                 * supplied identities were not previously merged, unrecognized
                 * PolicyDomain, unrecognized EntityType, source state not permitted,
                 * target state not permitted.
                 * [ST-119] */
        }

        /* ===================================================================
         * LINK RULES
         * =================================================================== */

        constraint def LinkPreconditions {
            doc /* Both identities to be linked must exist in the system. The target
                 * identity must be in active state. Link is permitted within a
                 * single domain or across two different domains.
                 * [ST-122] */
            constraint {
                targetIdentity.status == IdentityStatus::ACTIVE
            }
        }

        constraint def LinkSemanticsAndTransitivity {
            doc /* Linked items represent the same real-world entity. Links are
                 * transitive by definition: if A is linked to B and B is linked
                 * to C, then A is implicitly linked to C.
                 * [ST-078] */
        }

        constraint def CrossEntityTypeLinkingAllowed {
            doc /* Linking of entities of different EntityTypes is permitted.
                 * However, it is recommended that they map to the same EntityConcept.
                 * Unlike merge, same EntityConcept is NOT an absolute requirement
                 * for linking.
                 * [ST-126] */
        }

        constraint def CrossDomainLinkTopology {
            doc /* For cross-PolicyDomain linking, organizational policy may choose
                 * to allow peer-to-peer linking or enforce that links are to and
                 * from a designated master PolicyDomain for the cross-domain service
                 * instance.
                 * [ST-127] */
        }

        constraint def ImplicitLinkingTrigger {
            doc /* The link operation could be triggered by implicit logic as part
                 * of the register, create, or update actions when a new entity
                 * matches an existing entity above a configured threshold.
                 * [ST-128] */
        }

        constraint def LinkExceptions {
            doc /* Link operation exception conditions: source entity does not exist,
                 * target entity does not exist, unrecognized EntityTypes or
                 * PolicyDomains, identities already linked, unrecognized link method,
                 * identity states incompatible with link action.
                 * [ST-125] */
        }

        /* ===================================================================
         * UNLINK RULES
         * =================================================================== */

        constraint def UnlinkPreconditions {
            doc /* Both identities to be unlinked must exist in the system and must
                 * be currently linked to each other.
                 * [ST-130] */
        }

        constraint def UnlinkExceptions {
            doc /* Unlink operation exception conditions: source entity does not exist,
                 * target entity does not exist, unrecognized EntityTypes or
                 * PolicyDomains, identities not linked, identity states incompatible
                 * with unlink action.
                 * [ST-132] */
        }

        /* ===================================================================
         * REMOVE RULES
         * =================================================================== */

        constraint def RemovePreconditions {
            doc /* The identity instance must exist, must be in an appropriate state
                 * for removal, and must not be linked to other entities.
                 * [ST-134] */
        }

        constraint def RemoveExceptions {
            doc /* Remove operation exception conditions: identifier not recognized,
                 * identity not in an allowable state for removal, identity is linked
                 * to other identities.
                 * [ST-136] */
        }

        constraint def IdentifierReusePolicy {
            doc /* The functional model assumes that identity instance identifiers
                 * cannot be reused after removal. This must be precisely defined in
                 * organizational policies. Reuse is strongly discouraged.
                 * [ST-137, ST-138] */
        }

        constraint def RemovalPrivilegeRestriction {
            doc /* The remove capability should be restricted to users with specified
                 * privileges. This is a critical operation that permanently removes
                 * identity information from the service.
                 * [ST-139] */
        }

        constraint def AuditRetentionAfterRemoval {
            doc /* Though removed records are no longer findable from the service,
                 * they may be kept in a separate repository for audit trail purposes.
                 * No retention period or purge schedule is defined at this level.
                 * [ST-194] */
        }

        /* ===================================================================
         * QUERY RULES
         * =================================================================== */

        constraint def MergedIdentityRedirect {
            doc /* When retrieving information for an identity that has been merged
                 * into another, a warning should be returned with the identifier
                 * of the surviving identity into which the supplied identifier
                 * has been merged.
                 * [ST-141] */
        }

        constraint def GetAllInfoInvariant {
            doc /* The Get All Information operation is read-only: the identity is
                 * unchanged after retrieval.
                 * [ST-144] */
        }

        constraint def GetAllInfoExceptions {
            doc /* Get All Information exception conditions: identifier not recognized,
                 * unrecognized EntityType, unrecognized PolicyDomain, unrecognized
                 * identity states.
                 * [ST-145] */
        }

        constraint def FindByPropertyExceptions {
            doc /* Find Identities by Property exception conditions: unrecognized
                 * PolicyDomain, unrecognized EntityType, invalid status values,
                 * invalid or unrecognized search qualifiers, validation of properties
                 * against the schema failed.
                 * [ST-149] */
        }

        constraint def ListLinkedPrecondition {
            doc /* The identity must exist in the specified PolicyDomain before
                 * linked identities can be listed.
                 * [ST-151] */
        }

        constraint def ListLinkedExceptions {
            doc /* List Linked Identities exception conditions: PolicyDomain not known,
                 * EntityType not known, identity not known, search qualifiers not
                 * recognized.
                 * [ST-154] */
        }

        constraint def TwoTieredMatchThreshold {
            doc /* In functions involving matching, two-tiered match threshold criteria
                 * may be used: a definite match (not requiring human intervention) and
                 * a presumptive match (requiring further verification). Match quality
                 * values can be composite data structures, numerical, ontological,
                 * etc., and are in general configurable per organizational policy.
                 * [ST-172, ST-173] */
        }

        /* ===================================================================
         * NOTIFICATION RULES
         * =================================================================== */

        constraint def NotificationSubscriptionExceptions {
            doc /* Request Identity Update Notifications exception conditions:
                 * PolicyDomain not known, EntityType not known, notification request
                 * identifier not known, identity identifier not known, unrecognized
                 * or invalid notification qualifier, unrecognized status value.
                 * [ST-158] */
        }

        constraint def NotificationSubscriptionPattern {
            doc /* The notification request is effectively a subscription operation.
                 * This could be implemented using a publish-and-subscribe capability.
                 * The specific delivery mechanism is left to organizational policy.
                 * [ST-159] */
        }

        constraint def UpdateNotificationExceptions {
            doc /* Update Identity Notification Request exception conditions:
                 * PolicyDomain not known, EntityType not known, identity not known,
                 * unrecognized or invalid notification qualifier.
                 * [ST-163] */
        }

        constraint def NotificationPublicationPrecondition {
            doc /* The Notify Identity Updates operation requires that the service
                 * has become aware of an update to information relating to a
                 * specific entity, and that a previous notification subscription
                 * has been received.
                 * [ST-165] */
        }

        constraint def NotificationPublicationPattern {
            doc /* The notification publication is effectively a publication operation
                 * resulting from an earlier subscription. This could be implemented
                 * using a publish-and-subscribe capability.
                 * [ST-167] */
        }

        /* ===================================================================
         * CROSS-CUTTING POLICY RULES
         * =================================================================== */

        constraint def SecurityDelegation {
            doc /* Security is not explicitly defined in this specification. It is
                 * assumed to be handled by a separate infrastructure. There is an
                 * assumed precondition on all operations that the caller is
                 * appropriately authenticated and possibly authorized according
                 * to domain regulations.
                 * [ST-171] */
        }

        constraint def AuthorizationPolicy {
            doc /* The organization's business processes and policies control the
                 * authority of various roles on identity resolution functions.
                 * In many organizations, the functions of merge, link, unlink,
                 * and unmerge are escalated to a specialized identity resolution
                 * role.
                 * [ST-067] */
        }

        constraint def DemographicDataGuidance {
            doc /* The functions specified are primarily intended to use demographic
                 * data for identification purposes. However, this is NOT an enforced
                 * restriction; the capabilities are defined to consume and produce
                 * a very generic information structure via the semantic signifier
                 * mechanism.
                 * [ST-168] */
        }

        constraint def ScenariosNonNormative {
            doc /* All business scenarios in Section 3 are non-normative about
                 * conformance to the IS standard. They are offered for explanatory
                 * purposes only. Only the service contract in Section 4 defines
                 * the limits of service usage.
                 * [ST-202, ST-203] */
        }

        constraint def AdditionalInterfacesPossible {
            doc /* Additional interfaces may be defined by organizational policies
                 * for system or administrative functionality such as service
                 * management and/or metadata management.
                 * [ST-204] */
        }

        constraint def InternalMediatingIdentifier {
            doc /* The recommended approach for implementing identity linking is to
                 * use an internal mediating identifier to link associated identity
                 * records together. This internal identifier would not typically
                 * need to be surfaced in the service interface. Organizational
                 * policies may choose to expose it.
                 * [ST-043, ST-044] */
        }

        constraint def VersioningDefaultBehavior {
            doc /* Version designations have been included in the meta-model and
                 * operation definitions. These should be seen as optional in that
                 * typical operations will work with current versions as defaults.
                 * [ST-177] */
        }

        constraint def ProfileBasedConstraining {
            doc /* Organizational policies and profiles can apply constraints to
                 * provide a subset of the full specification's functionality.
                 * This enables simple implementations (e.g., basic identity
                 * resolution for patients only) through constrained profiles.
                 * [ST-039, ST-040] */
        }

        constraint def FutureHierarchicalExtension {
            doc /* Future versions of the specification may allow additional layers
                 * in EntityConcept, providing a hierarchical classification scheme.
                 * This is not included in the current version due to potential
                 * implementation complexities.
                 * [ST-217] */
        }

        constraint def RoleLinkingSecondaryUse {
            doc /* The linking functionality could be used as a secondary means to
                 * link roles to the entity playing them. However, this is not a
                 * primary use case or intention of the service.
                 * [ST-024] */
        }

        constraint def ExceptionMessagesDelegated {
            doc /* The means for returning informational and exception messages
                 * above and beyond any requested business content is left to
                 * organizational policies and downstream specifications.
                 * Reason codification is similarly delegated.
                 * [ST-169, ST-218] */
        }

        constraint def IdentifierConditionalOptionality {
            doc /* PolicyDomain and EntityType identifiers can be considered
                 * conditional at the implementation level, depending on whether
                 * the service supports multiple domains or entity types. For
                 * single-domain single-type implementations, these may be implicit.
                 * [ST-175, ST-178, ST-179] */
        }
    }
}
