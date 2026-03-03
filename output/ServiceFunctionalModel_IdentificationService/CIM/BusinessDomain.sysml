package CIM_IS {

    package BusinessDomain {
        doc /* CIM-level Business Domain Ontology for the HL7 Identification Service (IS).
             * Defines the core domain concepts, value types, enumerations, associations,
             * and a conceptual domain model that constitutes the identity management
             * problem space. All elements are derived from the IS SFM meta-model
             * (Section 4.2) and glossary (Section 5). */

        /* ===================================================================
         * SECTION 1: ENUMERATIONS
         * =================================================================== */

        enum def IdentityStatus {
            doc /* The lifecycle states an identity instance or metadata element may occupy.
                 * The minimum mandatory set is ACTIVE and INACTIVE; additional states may be
                 * defined per organizational policy. [ST-105, ST-106, ST-222] */
            enum ACTIVE;
            enum INACTIVE;
        }

        enum def LinkTypeCategory {
            doc /* Indicates whether linked identities are active peers or whether one
                 * is deprecated as in a merge. Value set is intentionally extensible
                 * per organizational policy. [ST-220, ST-079] */
            enum PEER_LINK;
            enum MERGE_DEPRECATION;
        }

        enum def LinkMethodCategory {
            doc /* A coded value providing information on how a link between identities
                 * was established. Value set is intentionally extensible per organizational
                 * policy. [ST-221, ST-081] */
            enum MANUAL;
            enum AUTOMATED;
        }

        enum def UpdateMode {
            doc /* Indicates the mode to be utilized during an identity property update
                 * process. [ST-096] */
            enum OVERWRITE;
            enum VALUED;
            enum UNSPECIFIED;
        }

        enum def MatchQualityTier {
            doc /* Indicates the confidence tier of a match result. A two-tiered threshold
                 * distinguishes definite matches not requiring human intervention from
                 * presumptive matches requiring further verification. [ST-172, ST-205] */
            enum DEFINITE_MATCH;
            enum PRESUMPTIVE_MATCH;
            enum NO_MATCH;
        }

        /* ===================================================================
         * SECTION 2: ATTRIBUTE DEFINITIONS (Value Types)
         * =================================================================== */

        attribute def DomainDesignation {
            doc /* A human-readable name assigned to a domain concept such as a PolicyDomain,
                 * EntityConcept, or EntityType. [ST-069, ST-072, ST-070] */
        }

        attribute def DomainDescription {
            doc /* A textual description providing context and purpose for a domain concept.
                 * [ST-069, ST-072, ST-070] */
        }

        attribute def VersionDesignation {
            doc /* An identifier representing the version of a domain concept. Supports
                 * maintaining history and evolution of metadata and identity instances.
                 * Representation is intentionally abstract to accommodate diverse
                 * versioning schemes. [ST-177] */
        }

        attribute def LanguageDesignation {
            doc /* A designation identifying a human language, used for language support
                 * within a PolicyDomain. [ST-069] */
        }

        attribute def IdentityDesignation {
            doc /* A value within a PolicyDomain that is associated with an identity instance
                 * and uniquely identifies it within the scope of that PolicyDomain and
                 * EntityType combination. [ST-091, Glossary: Identifier] */
        }

        attribute def SemanticSignifierContent {
            doc /* Represents the actual populated information structure (semantic signifier)
                 * for a specific identity instance. This is the set of identifying properties
                 * or traits used to characterize an entity. [ST-003, ST-071, Glossary] */
        }

        attribute def SchemaSpecification {
            doc /* Contains the definition of the data items in the information structure
                 * for an EntityType. Represents the semantic signifier structure definition.
                 * [ST-070, ST-003] */
        }

        attribute def ValidationRuleSpecification {
            doc /* Defines declarative rules for validating the information structure
                 * defined by the schema specification. [ST-070, ST-074] */
        }

        attribute def ProvenanceDescription {
            doc /* A placeholder structure for administrative information relating to
                 * linking, unlinking, merging, or unmerging when applied manually.
                 * [ST-080] */
        }

        attribute def ReasonDescription {
            doc /* A coded and/or free-form text description identifying the reason
                 * for a management action such as linking, merging, state change,
                 * or removal. [ST-077, ST-101, ST-014] */
        }

        attribute def MatchConfidence {
            doc /* Represents the quality of a match result when searching for identities
                 * by property. May be a composite data structure, numerical, or ontological
                 * value. [ST-172, ST-057] */
        }

        attribute def SubscriberDesignation {
            doc /* Identifies a service consumer that has lodged a notification request,
                 * including subscriber identification and/or destination information.
                 * [ST-155, ST-156] */
        }

        attribute def NotificationQualifier {
            doc /* Identifies a specific type of event of interest for notification
                 * purposes, such as property changes, status changes, or link changes.
                 * [ST-156, ST-159] */
        }

        /* ===================================================================
         * SECTION 3: ITEM DEFINITIONS (Domain Entities)
         * Relationships removed — modeled as explicit connections in Section 4.
         * =================================================================== */

        item def PolicyDomain {
            doc /* An identity space or sphere of use of entity identifiers. May be
                 * organizational, geographical, and/or jurisdictional. Each PolicyDomain
                 * defines the scope within which entity identifiers must be unique.
                 * Manages identity usage across departments, organizations, or national
                 * realms. [ST-030, ST-031, ST-032, ST-068, ST-069] */

            attribute domainDesignation : DomainDesignation {
                doc /* The name of the PolicyDomain. [ST-069] */
            }
            attribute description : DomainDescription {
                doc /* A description of the PolicyDomain. [ST-069] */
            }
            attribute version : VersionDesignation {
                doc /* The version of the PolicyDomain. PolicyDomains can be merged,
                     * split, etc. [ST-069] */
            }
            attribute status : IdentityStatus {
                doc /* Indicates whether the PolicyDomain can be used. [ST-069] */
            }
            attribute forCrossReference [0..1] {
                doc /* Indicates whether this PolicyDomain can be used in cross-references
                     * of entities across other domains. True/false indicator. [ST-069] */
            }
            attribute languagesSupported : LanguageDesignation [0..*] {
                doc /* Identifies the languages that are supported in the domain. [ST-069] */
            }
            attribute defaultLanguage : LanguageDesignation {
                doc /* The default language supported in the domain. [ST-069] */
            }
        }

        item def EntityConcept {
            doc /* A semantic concept or category of information that may be supported
                 * in an Identification Service. Provides the capability to specify a
                 * semantic relationship between different representations (EntityTypes)
                 * of the same basic underlying concept. For example, a Person concept
                 * can be classified by EntityTypes for RIM Person and OpenEHR Person
                 * archetypes. [ST-002, ST-072, ST-073, Glossary] */

            attribute conceptDesignation : DomainDesignation {
                doc /* The name of the EntityConcept. [ST-072] */
            }
            attribute description : DomainDescription {
                doc /* A description of the EntityConcept. [ST-072] */
            }
            attribute version : VersionDesignation {
                doc /* The version of the EntityConcept. [ST-072] */
            }
        }

        item def EntityType {
            doc /* A specific type of entity that an Identification Service supports at
                 * the level of a specific information model (semantic signifier). An
                 * EntityType classifies exactly one EntityConcept and defines the schema
                 * and validation rules for identifying information of that type.
                 * Examples: RIM Person, RIM Living Subject, OpenEHR Person archetype.
                 * [ST-071, ST-070, ST-003] */

            attribute typeDesignation : DomainDesignation {
                doc /* The name of the EntityType. [ST-070] */
            }
            attribute description : DomainDescription {
                doc /* A description of the EntityType. [ST-070] */
            }
            attribute status : IdentityStatus {
                doc /* Indicates whether the EntityType can be used, e.g., whether new
                     * entities of the type can be created. [ST-070] */
            }
            attribute version : VersionDesignation {
                doc /* Allows for maintaining a history of the EntityType. [ST-070] */
            }
            attribute schemaDefinition : SchemaSpecification {
                doc /* Contains the actual definition of the data items in the
                     * information structure (semantic signifier). [ST-070] */
            }
            attribute validationRuleSet : ValidationRuleSpecification {
                doc /* Defines declarative rules for validating the defined schema.
                     * [ST-070] */
            }
        }

        item def EntityTypeAssignment {
            doc /* Bridges an EntityType and a PolicyDomain, allowing the definition rules
                 * for EntityTypes (semantic signifiers) to be varied for different
                 * PolicyDomains. This enables domain-specific customization of validation
                 * and schema constraints. [ST-074, ST-075] */

            attribute status : IdentityStatus {
                doc /* Indicates whether the assignment is currently in use for the
                     * EntityType within the PolicyDomain. [ST-074] */
            }
            attribute version : VersionDesignation {
                doc /* The version of the assignment. [ST-074] */
            }
            attribute constrainedSchemaDefinition : SchemaSpecification [0..1] {
                doc /* Optional constrained version of the schema definition. May only
                     * further constrain those defined for the EntityType. [ST-074] */
            }
            attribute constrainedValidationRuleSet : ValidationRuleSpecification [0..1] {
                doc /* Optional declarative rules for validating the schema for use
                     * in specific PolicyDomains, where different from the default
                     * for the EntityType. [ST-074] */
            }
        }

        item def IdentityInstance {
            doc /* Represents the actual instance entry in the Identification Service.
                 * Each IdentityInstance is always of a specific EntityType and is scoped
                 * within a specific PolicyDomain (via EntityTypeAssignment). It holds
                 * the populated identifying information (semantic signifier values)
                 * for a real-world entity. [ST-076, ST-091, Glossary] */

            attribute instanceDesignation : IdentityDesignation {
                doc /* Unique identifier of the identity instance within the scope
                     * of its PolicyDomain and EntityType combination. [ST-076, ST-091] */
            }
            attribute version : VersionDesignation {
                doc /* Identifies the version of the IdentityInstance. [ST-076] */
            }
            attribute status : IdentityStatus {
                doc /* Status of the identity instance (e.g., active, inactive).
                     * [ST-076, ST-105] */
            }
            attribute populatedSignifierValues : SemanticSignifierContent {
                doc /* The actual populated information structure. This is the
                     * populated EntityType (semantic signifier) values for the
                     * specific IdentityInstance. [ST-076] */
            }
        }

        item def IdentityLink {
            doc /* Represents a directed relationship between two identity instances,
                 * used for linking (active peers) or merging (one deprecated).
                 * Link semantics state that linked items represent the same
                 * real-world entity, and links are transitive by definition.
                 * [ST-077, ST-078, ST-079] */

            attribute linkType : LinkTypeCategory {
                doc /* Indicates whether the identities are linked as active peers
                     * or whether one is deprecated as in a merge. [ST-079] */
            }
            attribute linkMethod : LinkMethodCategory [0..1] {
                doc /* A coded value providing information on how the link was made
                     * (manual or automated). [ST-081] */
            }
            attribute reason : ReasonDescription [0..1] {
                doc /* A coded and/or free-form text description identifying the
                     * reason for making the link. [ST-077] */
            }
            attribute provenance : ProvenanceDescription [0..1] {
                doc /* Administrative information relating to the linking/unlinking/
                     * merging/unmerging action. [ST-080] */
            }
        }

        item def RealWorldEntity {
            doc /* Represents an actual thing itself -- a person, device, organization,
                 * or any identifiable object that an Identification Service instance
                 * can manage. The specification takes no position about the physical
                 * reality of an RWE; it can be a result of a relationship, a model,
                 * or a consequence of a performative utterance.
                 * [ST-002, ST-005, Glossary: RWE] */

            attribute entityNature : DomainDescription {
                doc /* A description of the kind of real-world thing being identified
                     * (e.g., person, device, organization, role). [ST-002, ST-005] */
            }
        }

        item def UpdateQualifier {
            doc /* Specifies the mode and optional transformation instructions to be
                 * utilized during an identity property update process. [ST-096] */

            attribute updateMode : UpdateMode {
                doc /* Indicates the mode for the update: OVERWRITE replaces all values,
                     * VALUED replaces only non-null submitted values, UNSPECIFIED is
                     * implementation-specific. [ST-096] */
            }
            attribute updateSchemaReference : SchemaSpecification [0..1] {
                doc /* A reference to an external resource that can be utilized to
                     * extract properties from the supplied semantic signifier
                     * during updates. [ST-096] */
            }
        }

        item def SearchQualifier {
            doc /* Specifies optional parameters that direct search behavior when
                 * finding identities by property. These are not business data content
                 * filter criteria but control how the search is performed. [ST-146, ST-147] */

            attribute requestedConfidence : MatchConfidence [0..1] {
                doc /* The requested confidence threshold for match results. [ST-147] */
            }
            attribute maximumResultSetSize [0..1] {
                doc /* The maximum number of results to return. [ST-147] */
            }
            attribute errorIfSizeExceeded [0..1] {
                doc /* Flag indicating whether to return an error if the result set
                     * exceeds the maximum size. [ST-147] */
            }
            attribute matchingAlgorithmDesignation [0..1] {
                doc /* Designation of the matching algorithm to be used. The specific
                     * algorithms available are left to organizational policy. [ST-147] */
            }
        }

        item def NotificationSubscription {
            doc /* Represents a standing request by a service consumer to be notified
                 * when changes occur to identity information matching specified criteria.
                 * This is effectively a subscription for identity update events.
                 * [ST-155, ST-159, ST-167] */

            attribute subscriber : SubscriberDesignation {
                doc /* Identifies the service consumer and/or notification destination.
                     * [ST-156] */
            }
            attribute notificationQualifier : NotificationQualifier [0..1] {
                doc /* Identifies the specific type of event of interest (property changes,
                     * status changes, link changes). [ST-156, ST-159] */
            }
            attribute subscriptionStatus : IdentityStatus {
                doc /* Whether this subscription is currently active or inactive.
                     * [ST-156] */
            }
        }

        item def ServiceMetadata {
            doc /* The set of data items that delineates the scope and coverage of an
                 * Identification Service instance. This includes identifying the
                 * PolicyDomains, EntityConcepts, EntityTypes, and EntityTypeAssignments
                 * that the service supports. [ST-211, Glossary] */
        }

        item def HospitalInformationSystem {
            doc /* A generic term for various types of clinical systems, including
                 * Patient Administration Systems. The nature of the clinical system
                 * acting as a service consumer does not affect the service definition.
                 * Used in business scenarios to represent the intermediary between
                 * human actors and the Identification Service. [ST-045, ST-206] */
        }

        item def MasterPatientIndex {
            doc /* An application system that provides capabilities to find and
                 * cross-reference patients. Master Patient Index systems are the most
                 * common systems for providing Identification Service interfaces.
                 * [ST-207, Glossary: MPI/EMPI] */
        }

        /* ===================================================================
         * SECTION 4: CONNECTION DEFINITIONS (Domain Associations)
         * Each connection def models a named relationship from the SFM
         * meta-model (Section 4.2). Cardinalities reflect the specification.
         * =================================================================== */

        /* --- Core Meta-Model Associations --- */

        connection def Classifies {
            doc /* An EntityType classifies exactly one EntityConcept.
                 * Multiple EntityTypes may classify the same concept.
                 * [ST-073, meta-model Section 4.2] */
            end entityType : EntityType [0..*];
            end concept : EntityConcept [1];
        }

        connection def DefinesAssignment {
            doc /* An EntityType may have zero or more EntityTypeAssignments,
                 * each customizing it for a specific PolicyDomain.
                 * [ST-074, meta-model Section 4.2] */
            end entityType : EntityType [1];
            end assignment : EntityTypeAssignment [0..*];
        }

        connection def IsAppliedTo {
            doc /* An EntityTypeAssignment applies within exactly one PolicyDomain.
                 * A PolicyDomain may have multiple assignments.
                 * [ST-074, meta-model Section 4.2] */
            end assignment : EntityTypeAssignment [0..*];
            end domain : PolicyDomain [1];
        }

        connection def ProvidesRuleFor {
            doc /* An IdentityInstance is governed by exactly one EntityTypeAssignment,
                 * which determines its EntityType and PolicyDomain scope.
                 * [ST-076, meta-model Section 4.2] */
            end instance : IdentityInstance [0..*];
            end assignment : EntityTypeAssignment [1];
        }

        connection def LinkSource {
            doc /* The source identity instance in a link relationship.
                 * In a merge, this is the deprecated identity.
                 * [ST-077, meta-model Section 4.2] */
            end link : IdentityLink [0..*];
            end source : IdentityInstance [1];
        }

        connection def LinkTarget {
            doc /* The target identity instance in a link relationship.
                 * In a merge, this is the surviving identity.
                 * [ST-077, meta-model Section 4.2] */
            end link : IdentityLink [0..*];
            end target : IdentityInstance [1];
        }

        /* --- Subscription Filter Associations --- */

        connection def SubscriptionDomainFilter {
            doc /* Optional PolicyDomain filter for a notification subscription.
                 * [ST-156] */
            end subscription : NotificationSubscription [0..*];
            end domain : PolicyDomain [0..1];
        }

        connection def SubscriptionTypeFilter {
            doc /* Optional EntityType filter for a notification subscription.
                 * [ST-156] */
            end subscription : NotificationSubscription [0..*];
            end entityType : EntityType [0..1];
        }

        connection def SubscriptionInstanceFilter {
            doc /* Optional specific IdentityInstance filter for a notification subscription.
                 * [ST-156] */
            end subscription : NotificationSubscription [0..*];
            end instance : IdentityInstance [0..1];
        }

        /* --- Service Metadata Support Associations --- */

        connection def SupportsDomain {
            doc /* Identifies the PolicyDomains managed by a service instance.
                 * [ST-211] */
            end svcMetadata : ServiceMetadata [0..*];
            end domain : PolicyDomain [1..*];
        }

        connection def SupportsEntityType {
            doc /* Identifies the EntityTypes recognized by a service instance.
                 * [ST-211] */
            end svcMetadata : ServiceMetadata [0..*];
            end entityType : EntityType [1..*];
        }

        connection def SupportsConcept {
            doc /* Identifies the EntityConcepts recognized by a service instance.
                 * [ST-211] */
            end svcMetadata : ServiceMetadata [0..*];
            end concept : EntityConcept [1..*];
        }

        /* ===================================================================
         * SECTION 5: DOMAIN MODEL (Item Usages + Connection Usages)
         * Instantiates the meta-model as a diagrammable conceptual model.
         * =================================================================== */

        part domainModel {
            doc /* Conceptual domain model of the HL7 Identification Service.
                 * Contains item usages for each domain entity and connection
                 * usages for each meta-model relationship. This part can be
                 * rendered as an interconnection diagram in MagicDraw. */

            /* --- Item Usages (domain entity instances) --- */

            item policyDomains : PolicyDomain [1..*] {
                doc /* The identity domains managed by the service. */
            }
            item entityConcepts : EntityConcept [1..*] {
                doc /* The semantic concepts supported by the service. */
            }
            item entityTypes : EntityType [1..*] {
                doc /* The specific entity types supported. */
            }
            item entityTypeAssignments : EntityTypeAssignment [0..*] {
                doc /* Bridges between entity types and policy domains. */
            }
            item identityInstances : IdentityInstance [0..*] {
                doc /* The actual identity entries managed by the service. */
            }
            item identityLinks : IdentityLink [0..*] {
                doc /* Directed relationships between identity instances. */
            }
            item realWorldEntities : RealWorldEntity [0..*] {
                doc /* The real-world things being identified. */
            }
            item updateQualifiers : UpdateQualifier [0..*] {
                doc /* Update mode qualifiers for identity property changes. */
            }
            item searchQualifiers : SearchQualifier [0..*] {
                doc /* Search behavior qualifiers for find-by-property. */
            }
            item subscriptions : NotificationSubscription [0..*] {
                doc /* Standing notification subscription requests. */
            }
            item serviceMetadata : ServiceMetadata [1] {
                doc /* The metadata delineating service scope and coverage. */
            }
            item clinicalSystems : HospitalInformationSystem [0..*] {
                doc /* Clinical systems acting as service consumers. */
            }
            item mpiSystems : MasterPatientIndex [0..*] {
                doc /* Master Patient Index systems providing IS interfaces. */
            }

            /* --- Connection Usages (meta-model relationships) --- */

            connection classifies : Classifies
                connect entityTypes to entityConcepts;

            connection definesAssignment : DefinesAssignment
                connect entityTypes to entityTypeAssignments;

            connection isAppliedTo : IsAppliedTo
                connect entityTypeAssignments to policyDomains;

            connection providesRuleFor : ProvidesRuleFor
                connect identityInstances to entityTypeAssignments;

            connection linkSource : LinkSource
                connect identityLinks to identityInstances;

            connection linkTarget : LinkTarget
                connect identityLinks to identityInstances;

            connection subDomainFilter : SubscriptionDomainFilter
                connect subscriptions to policyDomains;

            connection subTypeFilter : SubscriptionTypeFilter
                connect subscriptions to entityTypes;

            connection subInstanceFilter : SubscriptionInstanceFilter
                connect subscriptions to identityInstances;

            connection supportsDomain : SupportsDomain
                connect serviceMetadata to policyDomains;

            connection supportsEntityType : SupportsEntityType
                connect serviceMetadata to entityTypes;

            connection supportsConcept : SupportsConcept
                connect serviceMetadata to entityConcepts;
        }
    }
}
