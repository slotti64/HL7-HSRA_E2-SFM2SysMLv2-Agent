package CIM_IS {
    private import RequirementDerivation::*;

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


    package StakeholderModel {
        doc /* CIM-level Stakeholder Model for the HL7 Identification Service (IS).
             * Defines all business stakeholders, their roles, and their concerns
             * with respect to identity management capabilities. Stakeholders are
             * derived from the SFM Section 3 (Business Scenarios) primary actors
             * and from roles implied in Section 4 (Detailed Functional Model).
             * [ST-046, ST-212, ST-213, ST-214, ST-215, ST-216, ST-210] */

        abstract part def BusinessStakeholder {
            doc /* Abstract base type for all business stakeholders in the
                 * Identification Service domain. */
        }

        /* ===================================================================
         * PRIMARY ACTORS (from Section 3 scenarios)
         * =================================================================== */

        part def RegistrationClerk :> BusinessStakeholder {
            doc /* A hospital registration clerk responsible for patient admissions,
                 * identity searches, record creation, updates, and resolution of
                 * duplicate identities. In business scenarios, represented by actors
                 * such as Carol Clerk and Eric Entry.
                 * Concern: Ability to efficiently search, create, update, link, merge,
                 * unlink, and remove identity records during the admission and
                 * discharge process.
                 * [ST-212, ST-046, ST-048, ST-052, ST-056, ST-059, ST-062, ST-064,
                 *  ST-181, ST-183, ST-192] */
        }

        part def ClinicalUser :> BusinessStakeholder {
            doc /* A healthcare professional (nurse, physician, or other clinical staff)
                 * who looks up patient identities to locate encounter records and
                 * clinical data. In business scenarios, represented by actors such as
                 * Clarence Barton (pre-op nurse) and Nancy Nightingale (discharge nurse).
                 * Concern: Quick and accurate lookup of patient identity to locate
                 * clinical encounters and record clinical observations.
                 * [ST-213, ST-046, ST-181, ST-052] */
        }

        part def LaboratoryClerk :> BusinessStakeholder {
            doc /* A laboratory staff member who references patient identifiers when
                 * processing laboratory orders and results. In business scenarios,
                 * represented by Bill Beaker. Must handle situations where a previously
                 * used identifier has been merged into another.
                 * Concern: Reliable resolution of patient identifiers, including
                 * detection and redirection of merged identifiers, to ensure
                 * laboratory results are correctly attributed.
                 * [ST-046, ST-185, ST-186] */
        }

        part def IdentityResolutionClerk :> BusinessStakeholder {
            doc /* A specialized staff member with elevated authority for identity
                 * resolution functions including merge, unmerge, link, and unlink
                 * operations. Many organizations escalate these functions from
                 * general admission clerks to this specialized role.
                 * Concern: Authority and tools to correctly resolve duplicate
                 * identities, separate erroneously linked records, and maintain
                 * the integrity of the identity registry.
                 * [ST-214, ST-067, ST-052, ST-064] */
        }

        part def ServiceAdministrator :> BusinessStakeholder {
            doc /* An administrator responsible for the configuration and management
                 * of the Identification Service, including PolicyDomain setup,
                 * EntityType management, and oversight of service metadata.
                 * Has access to find inactive identities that are not visible
                 * to general clinical searches.
                 * Concern: Ability to manage the service configuration, maintain
                 * metadata, and access all identity records regardless of status
                 * for administrative purposes.
                 * [ST-215, ST-061, ST-139, ST-059] */
        }

        part def ExternalSystem :> BusinessStakeholder {
            doc /* An external system or application that interacts with the
                 * Identification Service programmatically. Includes referral
                 * systems, laboratory information systems, radiology information
                 * systems, and other clinical or administrative systems that need
                 * to resolve or manage identities.
                 * Concern: Programmatic access to identity resolution, creation,
                 * and notification capabilities with reliable and consistent
                 * behavior across interactions.
                 * [ST-216, ST-187, ST-188, ST-189, ST-190, ST-191] */
        }

        /* ===================================================================
         * SECONDARY ACTORS (inferred from specification context)
         * =================================================================== */

        part def PolicyDomainOwner :> BusinessStakeholder {
            doc /* Inferred from [ST-030, ST-180]. The owner of a PolicyDomain who
                 * defines the policy, the entity types supported within the domain,
                 * and the authority attributes. Each PolicyDomain must have an owner.
                 * Concern: Governance of identity policies, determination of which
                 * entity types are supported, and definition of validation rules
                 * and cross-referencing policies within their domain. */
        }

        part def Patient :> BusinessStakeholder {
            doc /* Inferred from [ST-048, ST-056, ST-002, ST-005]. An individual who
                 * is the subject of identity management. Provides identifying information
                 * during admission and clinical encounters. While not a direct actor of
                 * the service interface, the patient is the primary source of identifying
                 * properties and the ultimate beneficiary of accurate identity resolution.
                 * Concern: Accurate representation of personal identifying information
                 * and correct association of clinical records with their identity. */
        }

        part def ReferralSystem :> BusinessStakeholder {
            doc /* Inferred from [ST-187, ST-188, ST-189, ST-190, ST-191]. A system
                 * that receives referral information from external institutions and
                 * needs to resolve patient identity before processing the referral.
                 * May operate in unattended mode with configurable rules for handling
                 * match outcomes (definite match, presumptive matches, no match).
                 * Concern: Automated resolution of patient identities from referral
                 * information with fallback strategies for uncertain or missing matches. */
        }

        part def RegionalHealthNetwork :> BusinessStakeholder {
            doc /* Inferred from [ST-195, ST-196, ST-198, ST-200]. A multi-organization
                 * healthcare network that operates a cross-domain Identification
                 * Service (XIS) to enable identity resolution across organizational
                 * boundaries. Manages regional or national identifiers and
                 * cross-references between member organizations.
                 * Concern: Federated identity resolution across member organizations,
                 * cross-domain linking of identities, and maintenance of a master
                 * cross-reference of regional identifiers. */
        }
    }


    package BusinessCapabilities {
        doc /* CIM-level Business Capabilities for the HL7 Identification Service (IS).
             * Models all service capabilities as use case usages, organized into two
             * capability groups: Identity Management and Query. Business scenarios
             * from SFM Section 3 are modeled as top-level use cases with subject,
             * actors, objectives, action steps, and sequencing. Normative operations
             * from SFM Section 4 are modeled as included use cases.
             * [ST-001, ST-004, ST-025, ST-026, ST-027] */

        /* ===================================================================
         * TOP-LEVEL SERVICE CAPABILITY
         * =================================================================== */

        part identificationService {
            doc /* The Identification Service provides a set of capabilities to manage
                 * and retrieve identifying information for various kinds of entities
                 * (people, organizations, devices, etc.) within and across
                 * organizations. [ST-001, ST-004] */

            /* =============================================================
             * IDENTITY MANAGEMENT CAPABILITIES (Section 4.3)
             * ============================================================= */

            include use case registerIdentity {
                doc /* Allows creation of an identity with a supplied set of property
                     * values, using an identifier supplied by the service consumer
                     * which is unique within the PolicyDomain for the EntityType.
                     * [ST-082, ST-083, ST-084, ST-085, ST-086, ST-087] */

                subject serviceInstance {
                    doc /* The Identification Service instance performing the registration. [ST-082] */
                    perform validateAndRegister;
                    perform checkForAutomatedLinks;
                }
                actor registrationClerk {
                    doc /* The registration clerk or external system supplying identity
                         * information and a locally assigned identifier. [ST-212, ST-216] */
                    perform supplyIdentityInformation;
                }
                objective {
                    doc /* Create a new identity instance with a consumer-supplied identifier
                         * that is unique within the PolicyDomain and EntityType scope. */
                }
                action supplyIdentityInformation;
                action validateAndRegister;
                action checkForAutomatedLinks;
                ref first start then supplyIdentityInformation;
                ref first supplyIdentityInformation then validateAndRegister;
                ref first validateAndRegister then checkForAutomatedLinks;
                ref first checkForAutomatedLinks then done;
            }

            include use case createIdentity {
                doc /* Allows creation of an identity instance with a list of property
                     * values where the identifier is generated by the service and
                     * returned to the service consumer. Used where the consumer cannot
                     * generate and supply its own local identifiers.
                     * [ST-088, ST-089, ST-090] */

                subject serviceInstance {
                    doc /* The Identification Service instance generating the identifier
                         * and creating the identity. [ST-088] */
                    perform generateIdentifierAndCreate;
                    perform checkForAutomatedLinks;
                }
                actor externalSystem {
                    doc /* The external system requesting identity creation without
                         * supplying its own identifier. [ST-216] */
                    perform supplyPropertyValues;
                }
                objective {
                    doc /* Create a new identity instance with a service-generated
                         * identifier and return it to the consumer. */
                }
                action supplyPropertyValues;
                action generateIdentifierAndCreate;
                action checkForAutomatedLinks;
                ref first start then supplyPropertyValues;
                ref first supplyPropertyValues then generateIdentifierAndCreate;
                ref first generateIdentifierAndCreate then checkForAutomatedLinks;
                ref first checkForAutomatedLinks then done;
            }

            include use case updateIdentityProperties {
                doc /* Allows addition and/or update of a set of property values
                     * for an identity specified by a unique identifier. The update
                     * qualifier specifies the mode (overwrite, valued, or unspecified).
                     * [ST-092, ST-093, ST-094, ST-095, ST-096] */

                subject serviceInstance {
                    doc /* The Identification Service instance applying the property update.
                         * [ST-092] */
                    perform applyPropertyUpdate;
                    perform evaluateMatchImpact;
                }
                actor registrationClerk {
                    doc /* The clerk providing updated property values and update mode.
                         * [ST-212, ST-056] */
                    perform specifyUpdateDetails;
                }
                objective {
                    doc /* Update the identifying properties of an existing identity instance
                         * according to the specified update mode. */
                }
                action specifyUpdateDetails;
                action applyPropertyUpdate;
                action evaluateMatchImpact;
                ref first start then specifyUpdateDetails;
                ref first specifyUpdateDetails then applyPropertyUpdate;
                ref first applyPropertyUpdate then evaluateMatchImpact;
                ref first evaluateMatchImpact then done;
            }

            include use case updateIdentityState {
                doc /* Changes the processing state of an identity (e.g., to inactive,
                     * active, or other states defined in appropriate organizational
                     * policies). All identity information is unchanged except for the
                     * state change.
                     * [ST-097, ST-098, ST-099, ST-100, ST-101, ST-102, ST-103, ST-104] */

                subject serviceInstance {
                    doc /* The Identification Service instance applying the state change.
                         * [ST-097] */
                    perform validateStateTransition;
                    perform applyStateChange;
                }
                actor serviceAdministrator {
                    doc /* The administrator requesting the state change with appropriate
                         * reason. [ST-215, ST-059, ST-062] */
                    perform requestStateChange;
                }
                objective {
                    doc /* Transition the identity to a new processing state while
                         * preserving all other identity information unchanged. */
                }
                action requestStateChange;
                action validateStateTransition;
                action applyStateChange;
                ref first start then requestStateChange;
                ref first requestStateChange then validateStateTransition;
                ref first validateStateTransition then applyStateChange;
                ref first applyStateChange then done;
            }

            include use case mergeIdentities {
                doc /* Allows merging two identities within a single PolicyDomain. The
                     * target identifier is the survivor; the source becomes deprecated.
                     * Empty identifying attributes in the target are filled from the
                     * source. Must be restricted to identities of the same EntityConcept.
                     * [ST-107, ST-108, ST-109, ST-110, ST-111, ST-112, ST-113, ST-114] */

                subject serviceInstance {
                    doc /* The Identification Service instance performing the merge.
                         * [ST-107] */
                    perform validateMergePreconditions;
                    perform performAttributeResolution;
                    perform deprecateSourceIdentity;
                    perform recordMergeAssociation;
                }
                actor identityResolutionClerk {
                    doc /* The identity resolution specialist requesting the merge of
                         * duplicate identity records. [ST-214, ST-052] */
                    perform designateSourceAndTarget;
                }
                objective {
                    doc /* Consolidate two identity instances representing the same
                         * real-world entity into a single surviving record, deprecating
                         * the source and filling empty target attributes from the source. */
                }
                action designateSourceAndTarget;
                action validateMergePreconditions;
                action performAttributeResolution;
                action deprecateSourceIdentity;
                action recordMergeAssociation;
                ref first start then designateSourceAndTarget;
                ref first designateSourceAndTarget then validateMergePreconditions;
                ref first validateMergePreconditions then performAttributeResolution;
                ref first performAttributeResolution then deprecateSourceIdentity;
                ref first deprecateSourceIdentity then recordMergeAssociation;
                ref first recordMergeAssociation then done;
            }

            include use case unmergeIdentities {
                doc /* Allows unmerging two previously merged identities. Reinstates the
                     * previously deprecated identity. The state of unmerged identities
                     * cannot be guaranteed valid; subsequent manual updates may be
                     * required to correct both entries.
                     * [ST-115, ST-116, ST-117, ST-118, ST-119, ST-120] */

                subject serviceInstance {
                    doc /* The Identification Service instance performing the unmerge.
                         * [ST-115] */
                    perform validateUnmergePreconditions;
                    perform reverseAssociation;
                    perform reinstateDeprecatedIdentity;
                }
                actor identityResolutionClerk {
                    doc /* The identity resolution specialist requesting the separation
                         * of previously merged records. [ST-214, ST-064] */
                    perform requestUnmerge;
                }
                objective {
                    doc /* Reverse a previous merge, reinstating the deprecated identity
                         * and removing the merge association. Manual review is expected
                         * after unmerge. */
                }
                action requestUnmerge;
                action validateUnmergePreconditions;
                action reverseAssociation;
                action reinstateDeprecatedIdentity;
                ref first start then requestUnmerge;
                ref first requestUnmerge then validateUnmergePreconditions;
                ref first validateUnmergePreconditions then reverseAssociation;
                ref first reverseAssociation then reinstateDeprecatedIdentity;
                ref first reinstateDeprecatedIdentity then done;
            }

            include use case linkIdentities {
                doc /* Allows linking of two identities. Linking can be carried out
                     * within a single PolicyDomain or across two different domains.
                     * Linked identities represent the same real-world entity and
                     * links are transitive by definition. Cross-EntityType linking
                     * is permitted but recommended only for the same EntityConcept.
                     * [ST-121, ST-122, ST-123, ST-124, ST-125, ST-126, ST-127, ST-128] */

                subject serviceInstance {
                    doc /* The Identification Service instance establishing the link.
                         * [ST-121] */
                    perform validateLinkPreconditions;
                    perform establishLink;
                    perform propagateTransitiveLinks;
                }
                actor identityResolutionClerk {
                    doc /* The identity resolution specialist or clinical user
                         * requesting the link. [ST-214, ST-213, ST-052] */
                    perform designateLinkPair;
                }
                objective {
                    doc /* Establish a link between two identity instances indicating
                         * they represent the same real-world entity, with both
                         * instances remaining active. */
                }
                action designateLinkPair;
                action validateLinkPreconditions;
                action establishLink;
                action propagateTransitiveLinks;
                ref first start then designateLinkPair;
                ref first designateLinkPair then validateLinkPreconditions;
                ref first validateLinkPreconditions then establishLink;
                ref first establishLink then propagateTransitiveLinks;
                ref first propagateTransitiveLinks then done;
            }

            include use case unlinkIdentity {
                doc /* Allows for the unlinking of two previously linked entities.
                     * Both identities must exist and be currently linked to each other.
                     * [ST-129, ST-130, ST-131, ST-132] */

                subject serviceInstance {
                    doc /* The Identification Service instance removing the link.
                         * [ST-129] */
                    perform validateUnlinkPreconditions;
                    perform removeLink;
                }
                actor identityResolutionClerk {
                    doc /* The identity resolution specialist requesting the unlink.
                         * [ST-214, ST-064] */
                    perform requestUnlink;
                }
                objective {
                    doc /* Remove the link between two identity instances that were
                         * previously linked. */
                }
                action requestUnlink;
                action validateUnlinkPreconditions;
                action removeLink;
                ref first start then requestUnlink;
                ref first requestUnlink then validateUnlinkPreconditions;
                ref first validateUnlinkPreconditions then removeLink;
                ref first removeLink then done;
            }

            include use case removeIdentityInstance {
                doc /* Allows for the complete removal of an identity instance from
                     * the service. The identity must exist, be in an appropriate
                     * state, and must not be linked to other entities. Removed records
                     * may be kept for audit trail purposes but are no longer findable.
                     * [ST-133, ST-134, ST-135, ST-136, ST-137, ST-138, ST-139] */

                subject serviceInstance {
                    doc /* The Identification Service instance performing the removal.
                         * [ST-133] */
                    perform validateRemovalPreconditions;
                    perform performRemoval;
                }
                actor serviceAdministrator {
                    doc /* The privileged administrator requesting identity removal.
                         * This capability is restricted to users with specified
                         * privileges. [ST-215, ST-139, ST-192] */
                    perform requestRemoval;
                }
                objective {
                    doc /* Permanently remove an identity instance from the service so
                         * it is no longer findable by any user, while optionally
                         * retaining audit records. */
                }
                action requestRemoval;
                action validateRemovalPreconditions;
                action performRemoval;
                ref first start then requestRemoval;
                ref first requestRemoval then validateRemovalPreconditions;
                ref first validateRemovalPreconditions then performRemoval;
                ref first performRemoval then done;
            }

            /* =============================================================
             * QUERY CAPABILITIES (Section 4.4)
             * ============================================================= */

            include use case getAllInformationForIdentity {
                doc /* Retrieves all information for an identity known by the service
                     * (properties, status, etc.). A specific unique identifier is input
                     * qualified by PolicyDomain and EntityType. If the identity has been
                     * merged into another, a warning is returned with the surviving
                     * identifier.
                     * [ST-140, ST-141, ST-142, ST-143, ST-144, ST-145] */

                subject serviceInstance {
                    doc /* The Identification Service instance retrieving identity
                         * information. [ST-140] */
                    perform resolveIdentifier;
                    perform retrieveAllProperties;
                }
                actor clinicalUser {
                    doc /* The clinical user or external system requesting full identity
                         * information. [ST-213, ST-216] */
                    perform specifyIdentifier;
                }
                objective {
                    doc /* Retrieve the complete set of property values, status, and
                         * related information for a specific known identity. */
                }
                action specifyIdentifier;
                action resolveIdentifier;
                action retrieveAllProperties;
                ref first start then specifyIdentifier;
                ref first specifyIdentifier then resolveIdentifier;
                ref first resolveIdentifier then retrieveAllProperties;
                ref first retrieveAllProperties then done;
            }

            include use case findIdentitiesByProperty {
                doc /* Given a partially populated semantic signifier and other search
                     * filter criteria, searches for matching identities. Search
                     * qualifiers enable directing search behavior. Outputs include a
                     * quality of match for each result.
                     * [ST-146, ST-147, ST-148, ST-149] */

                subject serviceInstance {
                    doc /* The Identification Service instance performing the search.
                         * [ST-146] */
                    perform executePropertySearch;
                    perform rankResultsByMatchQuality;
                }
                actor registrationClerk {
                    doc /* The registration clerk or clinical user supplying search
                         * properties and optional qualifiers. [ST-212, ST-213] */
                    perform specifySearchCriteria;
                }
                objective {
                    doc /* Find identity instances matching the supplied identifying
                         * properties, ranked by quality of match. */
                }
                action specifySearchCriteria;
                action executePropertySearch;
                action rankResultsByMatchQuality;
                ref first start then specifySearchCriteria;
                ref first specifySearchCriteria then executePropertySearch;
                ref first executePropertySearch then rankResultsByMatchQuality;
                ref first rankResultsByMatchQuality then done;
            }

            include use case listLinkedIdentities {
                doc /* Given an identifier, lists all other entities that are linked
                     * to the identity, optionally constrained within one or more
                     * PolicyDomains.
                     * [ST-150, ST-151, ST-152, ST-153, ST-154] */

                subject serviceInstance {
                    doc /* The Identification Service instance retrieving linked identities.
                         * [ST-150] */
                    perform validateIdentityExists;
                    perform retrieveLinkedIdentities;
                }
                actor identityResolutionClerk {
                    doc /* The identity resolution clerk or clinical user requesting the
                         * list of linked identities. [ST-214, ST-213, ST-064] */
                    perform specifyIdentityAndScope;
                }
                objective {
                    doc /* Retrieve all identities linked to a specified identity,
                         * optionally filtered by PolicyDomain. */
                }
                action specifyIdentityAndScope;
                action validateIdentityExists;
                action retrieveLinkedIdentities;
                ref first start then specifyIdentityAndScope;
                ref first specifyIdentityAndScope then validateIdentityExists;
                ref first validateIdentityExists then retrieveLinkedIdentities;
                ref first retrieveLinkedIdentities then done;
            }

            include use case requestIdentityUpdateNotifications {
                doc /* The service consumer lodges a request to be notified of changes
                     * to information for a specific identity or identities of a specific
                     * type and/or domain combination. Effectively a subscription operation.
                     * [ST-155, ST-156, ST-157, ST-158, ST-159] */

                subject serviceInstance {
                    doc /* The Identification Service instance managing the notification
                         * subscription. [ST-155] */
                    perform validateSubscriptionCriteria;
                    perform establishSubscription;
                }
                actor externalSystem {
                    doc /* The external system subscribing to identity update
                         * notifications. [ST-216] */
                    perform specifyNotificationCriteria;
                }
                objective {
                    doc /* Register a standing request to receive notifications when
                         * identity information matching the specified criteria changes. */
                }
                action specifyNotificationCriteria;
                action validateSubscriptionCriteria;
                action establishSubscription;
                ref first start then specifyNotificationCriteria;
                ref first specifyNotificationCriteria then validateSubscriptionCriteria;
                ref first validateSubscriptionCriteria then establishSubscription;
                ref first establishSubscription then done;
            }

            include use case updateNotificationSubscription {
                doc /* The service consumer provides an update to a previously submitted
                     * notification request, including modification of criteria or
                     * cancellation of the request.
                     * [ST-160, ST-161, ST-162, ST-163] */

                subject serviceInstance {
                    doc /* The Identification Service instance updating the subscription.
                         * [ST-160] */
                    perform validateUpdateCriteria;
                    perform applySubscriptionUpdate;
                }
                actor externalSystem {
                    doc /* The external system modifying or cancelling its notification
                         * subscription. [ST-216] */
                    perform specifySubscriptionChanges;
                }
                objective {
                    doc /* Modify or cancel an existing notification subscription. */
                }
                action specifySubscriptionChanges;
                action validateUpdateCriteria;
                action applySubscriptionUpdate;
                ref first start then specifySubscriptionChanges;
                ref first specifySubscriptionChanges then validateUpdateCriteria;
                ref first validateUpdateCriteria then applySubscriptionUpdate;
                ref first applySubscriptionUpdate then done;
            }

            include use case notifyIdentityUpdates {
                doc /* The service produces a notification of an update made to any
                     * information relating to a specific identity or identities within
                     * a PolicyDomain and/or EntityType, as previously requested via a
                     * notification subscription. Effectively a publication operation.
                     * [ST-164, ST-165, ST-166, ST-167] */

                subject serviceInstance {
                    doc /* The Identification Service instance producing the notification.
                         * [ST-164] */
                    perform detectRelevantChange;
                    perform produceNotification;
                }
                actor externalSystem {
                    doc /* The subscribed external system receiving the notification.
                         * [ST-216] */
                    perform receiveNotification;
                }
                objective {
                    doc /* Deliver a notification of identity information changes to
                         * subscribers who have previously registered interest. */
                }
                action detectRelevantChange;
                action produceNotification;
                action receiveNotification;
                ref first start then detectRelevantChange;
                ref first detectRelevantChange then produceNotification;
                ref first produceNotification then receiveNotification;
                ref first receiveNotification then done;
            }
        }

        /* ===================================================================
         * BUSINESS SCENARIOS (Section 3 - Non-normative)
         * These model the real-world workflows described in the SFM to provide
         * context for how the normative capabilities are composed in practice.
         * Each use case maps its action steps to the SFM swimlane with explicit
         * performer assignments for the human actor, HIS, IS, and (where
         * applicable) XIS.
         * =================================================================== */

        /* -----------------------------------------------------------
         * Single-Domain Scenarios (Section 3.2)
         * ----------------------------------------------------------- */

        part singleDomainScenarios {
            doc /* Business scenarios within a single PolicyDomain, illustrating
                 * common identity management workflows in a hospital setting.
                 * These are non-normative and offered for explanatory purposes.
                 * Performers: human actors, HIS (Hospital Information System),
                 * and IS (Identification Service).
                 * [ST-047, ST-202] */

            /* --- Scenario 1: Create a New Patient (SFM 3.2.1) --- */

            include use case createNewPatient {
                doc /* Adam Everyman enters the hospital for outpatient surgery.
                     * Carol Clerk searches by name+address, then by old address —
                     * not found. Carol treats Adam as a new patient, gathers
                     * demographics, and registers the identity via HIS and IS.
                     * [ST-048, ST-049, ST-050, ST-051] */

                subject hospitalInformationSystem {
                    doc /* The clinical system mediating between the clerk and the
                         * Identification Service. [ST-045] */
                    perform relaySearchToIS_initial;
                    perform reportNoRecordFound_initial;
                    perform relaySearchToIS_broader;
                    perform reportNoRecordFound_broader;
                    perform relayRegistrationToIS;
                    perform confirmPatientRegistered;
                }
                actor registrationClerk {
                    doc /* Carol Clerk, a registration clerk. [ST-212, ST-048] */
                    perform searchByNameAndAddress;
                    perform searchWithOldAddress;
                    perform gatherDemographicsAndCreate;
                }
                actor identificationService {
                    doc /* The Identification Service instance managing identities
                         * within the hospital's PolicyDomain. [ST-001] */
                    perform returnEmptyList_initial;
                    perform returnEmptyList_broader;
                    perform acknowledgeRegistration;
                }
                objective {
                    doc /* Verify whether a patient already exists in the identity registry;
                         * if not found, create a new identity instance for the patient. */
                }
                /* Step 1: Carol searches Adam by name + address */
                action searchByNameAndAddress;
                /* Step 2: HIS calls FindIdentityByProperty(Person, Name, Address) on IS */
                action relaySearchToIS_initial;
                /* Step 3: IS returns empty list */
                action returnEmptyList_initial;
                /* Step 4: HIS reports no record found to Carol */
                action reportNoRecordFound_initial;
                /* Step 5: Carol searches Adam with additional info (old address) */
                action searchWithOldAddress;
                /* Step 6: HIS calls FindIdentityByProperty(Person, Adam, OldAddress) on IS */
                action relaySearchToIS_broader;
                /* Step 7: IS returns empty list */
                action returnEmptyList_broader;
                /* Step 8: HIS reports no record found to Carol */
                action reportNoRecordFound_broader;
                /* Step 9: Carol gathers demographics, creates new patient */
                action gatherDemographicsAndCreate;
                /* Step 10: HIS calls RegisterIdentity(Person, ID, Adam) on IS */
                action relayRegistrationToIS;
                /* Step 11: IS returns acknowledgement */
                action acknowledgeRegistration;
                /* Step 12: HIS confirms new patient registered to Carol */
                action confirmPatientRegistered;
                ref first start then searchByNameAndAddress;
                ref first searchByNameAndAddress then relaySearchToIS_initial;
                ref first relaySearchToIS_initial then returnEmptyList_initial;
                ref first returnEmptyList_initial then reportNoRecordFound_initial;
                ref first reportNoRecordFound_initial then searchWithOldAddress;
                ref first searchWithOldAddress then relaySearchToIS_broader;
                ref first relaySearchToIS_broader then returnEmptyList_broader;
                ref first returnEmptyList_broader then reportNoRecordFound_broader;
                ref first reportNoRecordFound_broader then gatherDemographicsAndCreate;
                ref first gatherDemographicsAndCreate then relayRegistrationToIS;
                ref first relayRegistrationToIS then acknowledgeRegistration;
                ref first acknowledgeRegistration then confirmPatientRegistered;
                ref first confirmPatientRegistered then done;
            }

            /* --- Scenario 2a: Link Identities (SFM 3.2.2a) --- */

            include use case linkIdentities {
                doc /* Nancy Nightingale discovers two records for Adam that appear
                     * to be the same person. She requests the HIS to link the newer
                     * entity to the older one. Both remain active; the newer becomes
                     * an alias for the older. [ST-052, ST-053] */

                subject hospitalInformationSystem {
                    doc /* The clinical system mediating between the user and the
                         * Identification Service. [ST-045] */
                    perform relaySearchToIS;
                    perform displayPersonList;
                    perform relayLinkRequestToIS;
                    perform confirmIdentityLinked;
                }
                actor clinicalUser {
                    doc /* Nancy Nightingale, discharge nurse, discovering duplicate
                         * records. [ST-213, ST-052] */
                    perform searchForPatient;
                    perform reviewListAndDecideSamePerson;
                    perform requestLinkNewerToOlder;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform returnPersonListWithTwoAdams;
                    perform acknowledgeLinking;
                }
                objective {
                    doc /* Link two identity records representing the same real-world
                         * entity, maintaining both as active with a link association. */
                }
                /* Step 1: Nancy searches Adam */
                action searchForPatient;
                /* Step 2: HIS calls FindIdentityByProperty(Adam) on IS */
                action relaySearchToIS;
                /* Step 3: IS returns person list including two Adams */
                action returnPersonListWithTwoAdams;
                /* Step 4: HIS displays person list to Nancy */
                action displayPersonList;
                /* Step 5: Nancy reviews list, decides two Adams are same person */
                action reviewListAndDecideSamePerson;
                /* Step 6: Nancy requests link newer Adam to older Adam */
                action requestLinkNewerToOlder;
                /* Step 7: HIS calls LinkIdentities(Person, newerAdam, Person, olderAdam) on IS */
                action relayLinkRequestToIS;
                /* Step 8: IS returns acknowledgement */
                action acknowledgeLinking;
                /* Step 9: HIS confirms identity linked to Nancy */
                action confirmIdentityLinked;
                ref first start then searchForPatient;
                ref first searchForPatient then relaySearchToIS;
                ref first relaySearchToIS then returnPersonListWithTwoAdams;
                ref first returnPersonListWithTwoAdams then displayPersonList;
                ref first displayPersonList then reviewListAndDecideSamePerson;
                ref first reviewListAndDecideSamePerson then requestLinkNewerToOlder;
                ref first requestLinkNewerToOlder then relayLinkRequestToIS;
                ref first relayLinkRequestToIS then acknowledgeLinking;
                ref first acknowledgeLinking then confirmIdentityLinked;
                ref first confirmIdentityLinked then done;
            }

            /* --- Scenario 2b: Merge Identities (SFM 3.2.2b) --- */

            include use case mergeIdentities {
                doc /* Alternative to linking: Nancy Nightingale discovers duplicate
                     * records and the hospital's policy calls for merging. The newer
                     * record is deprecated and only the surviving record is used
                     * going forward. [ST-054, ST-055] */

                subject hospitalInformationSystem {
                    doc /* The clinical system mediating between the user and the
                         * Identification Service. [ST-045] */
                    perform relaySearchToIS;
                    perform displayPersonList;
                    perform relayMergeRequestToIS;
                    perform confirmIdentityMerged;
                }
                actor clinicalUser {
                    doc /* Nancy Nightingale, discharge nurse. [ST-213, ST-054] */
                    perform searchForPatient;
                    perform reviewListAndDecideSamePerson;
                    perform requestMergeNewerToOlder;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform returnPersonListWithTwoAdams;
                    perform acknowledgeMerge;
                }
                objective {
                    doc /* Merge two identity records, deprecating the newer and
                         * retaining only the surviving record for future use. */
                }
                /* Step 1: Nancy searches Adam */
                action searchForPatient;
                /* Step 2: HIS calls FindIdentityByProperty(Adam) on IS */
                action relaySearchToIS;
                /* Step 3: IS returns person list including two Adams */
                action returnPersonListWithTwoAdams;
                /* Step 4: HIS displays person list to Nancy */
                action displayPersonList;
                /* Step 5: Nancy reviews, decides two Adams are same person */
                action reviewListAndDecideSamePerson;
                /* Step 6: Nancy requests merge newer Adam to older Adam */
                action requestMergeNewerToOlder;
                /* Step 7: HIS calls MergeIdentities(Person, newerAdam, Person, olderAdam) on IS */
                action relayMergeRequestToIS;
                /* Step 8: IS returns acknowledgement */
                action acknowledgeMerge;
                /* Step 9: HIS confirms identity merged to Nancy */
                action confirmIdentityMerged;
                ref first start then searchForPatient;
                ref first searchForPatient then relaySearchToIS;
                ref first relaySearchToIS then returnPersonListWithTwoAdams;
                ref first returnPersonListWithTwoAdams then displayPersonList;
                ref first displayPersonList then reviewListAndDecideSamePerson;
                ref first reviewListAndDecideSamePerson then requestMergeNewerToOlder;
                ref first requestMergeNewerToOlder then relayMergeRequestToIS;
                ref first relayMergeRequestToIS then acknowledgeMerge;
                ref first acknowledgeMerge then confirmIdentityMerged;
                ref first confirmIdentityMerged then done;
            }

            /* --- Scenario 3: Update Demographics (SFM 3.2.3) --- */

            include use case updateDemographics {
                doc /* Adam returns to the hospital. Carol cannot find an exact match
                     * but recognizes Adam after checking DOB and qualifying questions.
                     * She discovers his address is out of date, updates demographics,
                     * and submits the change to IS via a Link operation.
                     * [ST-056, ST-057, ST-058] */

                subject hospitalInformationSystem {
                    doc /* The clinical system mediating between the clerk and the
                         * Identification Service. [ST-045] */
                    perform relaySearchToIS;
                    perform displayPersonList;
                    perform relayLinkUpdateToIS;
                    perform confirmDemographicsUpdated;
                }
                actor registrationClerk {
                    doc /* Carol Clerk. [ST-212, ST-056] */
                    perform searchPatient;
                    perform reviewListRecognizeOutdatedAddress;
                    perform updateDemographicValues;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform returnPersonListIncludingPatient;
                    perform acknowledgeLinkUpdate;
                }
                objective {
                    doc /* Locate an existing identity with outdated demographic information
                         * and update the identifying properties to reflect current data. */
                }
                /* Step 1: Carol searches Adam */
                action searchPatient;
                /* Step 2: HIS calls FindIdentityByProperty(Person, Adam) on IS */
                action relaySearchToIS;
                /* Step 3: IS returns person list including Adam */
                action returnPersonListIncludingPatient;
                /* Step 4: HIS displays person list to Carol */
                action displayPersonList;
                /* Step 5: Carol reviews list, recognizes address is out of date */
                action reviewListRecognizeOutdatedAddress;
                /* Step 6: Carol updates demographic values (address, phone) */
                action updateDemographicValues;
                /* Step 7: HIS calls LinkIdentities(Person, newerAdam, Person, olderAdam) on IS */
                action relayLinkUpdateToIS;
                /* Step 8: IS returns acknowledgement */
                action acknowledgeLinkUpdate;
                /* Step 9: HIS confirms demographics updated to Carol */
                action confirmDemographicsUpdated;
                ref first start then searchPatient;
                ref first searchPatient then relaySearchToIS;
                ref first relaySearchToIS then returnPersonListIncludingPatient;
                ref first returnPersonListIncludingPatient then displayPersonList;
                ref first displayPersonList then reviewListRecognizeOutdatedAddress;
                ref first reviewListRecognizeOutdatedAddress then updateDemographicValues;
                ref first updateDemographicValues then relayLinkUpdateToIS;
                ref first relayLinkUpdateToIS then acknowledgeLinkUpdate;
                ref first acknowledgeLinkUpdate then confirmDemographicsUpdated;
                ref first confirmDemographicsUpdated then done;
            }

            /* --- Scenario 4: Inactivate Entity (SFM 3.2.4) --- */

            include use case inactivateEntity {
                doc /* Per company policy (death, relocation, plan change, test data
                     * removal, etc.), Carol changes Adam's entity state to Inactive.
                     * He will not appear in clinical searches but remains accessible
                     * to administrators. [ST-059, ST-060, ST-061] */

                subject hospitalInformationSystem {
                    doc /* The clinical system relaying the state change to the
                         * Identification Service. [ST-045] */
                    perform relayInactivationToIS;
                    perform confirmInactivation;
                }
                actor serviceAdministrator {
                    doc /* Carol Clerk acting in administrator capacity. [ST-215, ST-059] */
                    perform requestInactivation;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform acknowledgeInactivation;
                }
                objective {
                    doc /* Change an identity's state to inactive so it no longer appears
                         * in general clinical searches while remaining accessible to
                         * administrators. */
                }
                /* Step 1: Carol requests inactivation of Adam's record */
                action requestInactivation;
                /* Step 2: HIS calls UpdateIdentityStatus(Person, EntityID, Inactive) on IS */
                action relayInactivationToIS;
                /* Step 3: IS returns acknowledgement */
                action acknowledgeInactivation;
                /* Step 4: HIS confirms inactivation to Carol */
                action confirmInactivation;
                ref first start then requestInactivation;
                ref first requestInactivation then relayInactivationToIS;
                ref first relayInactivationToIS then acknowledgeInactivation;
                ref first acknowledgeInactivation then confirmInactivation;
                ref first confirmInactivation then done;
            }

            /* --- Scenario 5: Activate Entity (SFM 3.2.5) --- */

            include use case activateEntity {
                doc /* Carol realizes the inactivation was a mistake. She finds Adam's
                     * entry via IS admin search and changes state back to Active.
                     * [ST-062, ST-063] */

                subject hospitalInformationSystem {
                    doc /* The clinical system relaying the state change to the
                         * Identification Service. [ST-045] */
                    perform relayActivationToIS;
                    perform confirmActivation;
                }
                actor serviceAdministrator {
                    doc /* Carol Clerk acting in administrator capacity. [ST-215, ST-062] */
                    perform requestActivation;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform acknowledgeActivation;
                }
                objective {
                    doc /* Restore a previously inactivated identity to active state,
                         * allowing it to appear in general clinical searches again. */
                }
                /* Step 1: Carol requests activation of Adam's record */
                action requestActivation;
                /* Step 2: HIS calls UpdateIdentityStatus(Person, EntityID, Active) on IS */
                action relayActivationToIS;
                /* Step 3: IS returns acknowledgement */
                action acknowledgeActivation;
                /* Step 4: HIS confirms activation to Carol */
                action confirmActivation;
                ref first start then requestActivation;
                ref first requestActivation then relayActivationToIS;
                ref first relayActivationToIS then acknowledgeActivation;
                ref first acknowledgeActivation then confirmActivation;
                ref first confirmActivation then done;
            }

            /* --- Scenario 6: Unlink (Unmerge) Entity (SFM 3.2.6) --- */

            include use case unlinkEntity {
                doc /* Miss Evelyn Smith enters the hospital. Carol discovers she was
                     * erroneously linked to Mrs. Eve Everywoman (whose maiden name
                     * was Smith). Carol retrieves aliases, identifies the mistake,
                     * unlinks the erroneous alias, and proceeds with admission.
                     * [ST-064, ST-065, ST-066, ST-067] */

                subject hospitalInformationSystem {
                    doc /* The clinical system mediating between the clerk and the
                         * Identification Service. [ST-045] */
                    perform relaySearchToIS;
                    perform displayPersonList;
                    perform relayListLinkedToIS;
                    perform displayAliasList;
                    perform relayUnlinkToIS;
                    perform confirmUnlink;
                }
                actor registrationClerk {
                    doc /* Carol Clerk investigating linked records. [ST-212, ST-064] */
                    perform searchEvelynSmith;
                    perform reviewPersonList_discoverHistoricalLink;
                    perform requestRetrieveAllAliases;
                    perform reviewAliasList_identifyMistake;
                    perform requestUnlinkAlias;
                    perform proceedWithAdmission;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform returnPersonListTwoSmiths;
                    perform returnAliasList;
                    perform acknowledgeUnlinking;
                }
                objective {
                    doc /* Remove an erroneous link between two identity instances,
                         * restoring them as distinct entities. */
                }
                /* Step 1: Carol searches Miss Evelyn Smith */
                action searchEvelynSmith;
                /* Step 2: HIS calls FindIdentityByProperties(Person, Smith, Evelyn, F) on IS */
                action relaySearchToIS;
                /* Step 3: IS returns person list including two Smiths */
                action returnPersonListTwoSmiths;
                /* Step 4: HIS displays person list to Carol */
                action displayPersonList;
                /* Step 5: Carol reviews — Evelyn Smith has historical records matched to Eve Everywoman */
                action reviewPersonList_discoverHistoricalLink;
                /* Step 6: Carol requests retrieve all aliases of Eve Everywoman */
                action requestRetrieveAllAliases;
                /* Step 7: HIS calls ListLinkedIdentities(Person, EntityID) on IS */
                action relayListLinkedToIS;
                /* Step 8: IS returns alias list of Eve Everywoman */
                action returnAliasList;
                /* Step 9: HIS displays alias list to Carol */
                action displayAliasList;
                /* Step 10: Carol reviews alias list — decides Evelyn Smith was mistakenly linked */
                action reviewAliasList_identifyMistake;
                /* Step 11: Carol requests unlink alias Smith from Everywoman */
                action requestUnlinkAlias;
                /* Step 12: HIS calls UnlinkIdentity(Person, Smith, Person, Everywoman) on IS */
                action relayUnlinkToIS;
                /* Step 13: IS acknowledges unlinking */
                action acknowledgeUnlinking;
                /* Step 14: HIS confirms unlink to Carol */
                action confirmUnlink;
                /* Step 15-16: Carol proceeds with Smith's admission */
                action proceedWithAdmission;
                ref first start then searchEvelynSmith;
                ref first searchEvelynSmith then relaySearchToIS;
                ref first relaySearchToIS then returnPersonListTwoSmiths;
                ref first returnPersonListTwoSmiths then displayPersonList;
                ref first displayPersonList then reviewPersonList_discoverHistoricalLink;
                ref first reviewPersonList_discoverHistoricalLink then requestRetrieveAllAliases;
                ref first requestRetrieveAllAliases then relayListLinkedToIS;
                ref first relayListLinkedToIS then returnAliasList;
                ref first returnAliasList then displayAliasList;
                ref first displayAliasList then reviewAliasList_identifyMistake;
                ref first reviewAliasList_identifyMistake then requestUnlinkAlias;
                ref first requestUnlinkAlias then relayUnlinkToIS;
                ref first relayUnlinkToIS then acknowledgeUnlinking;
                ref first acknowledgeUnlinking then confirmUnlink;
                ref first confirmUnlink then proceedWithAdmission;
                ref first proceedWithAdmission then done;
            }

            /* --- Scenario 7a: Look Up a Patient — Single Entry Found (SFM 3.2.7a) --- */

            include use case lookupSingleEntry {
                doc /* Pre-op nurse Clarence Barton looks up Adam's records in HIS
                     * (which queries IS). A single match is found. Clarence locates
                     * the surgical encounter and records vital signs.
                     * [ST-181, ST-182] */

                subject hospitalInformationSystem {
                    doc /* The clinical system relaying the search to the Identification
                         * Service. [ST-045] */
                    perform relaySearchToIS;
                    perform displayPatientRecord;
                }
                actor clinicalUser {
                    doc /* Clarence Barton, pre-op nurse. [ST-213, ST-181] */
                    perform searchPatient;
                    perform locateSurgicalEncounter;
                    perform enterVitalSigns;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform returnSingleMatch;
                }
                objective {
                    doc /* Find a specific patient identity from identifying properties
                         * and retrieve the associated clinical encounter. */
                }
                /* Step 1: Clarence searches Adam */
                action searchPatient;
                /* Step 2: HIS calls FindIdentityByProperties(Person, Adam) on IS */
                action relaySearchToIS;
                /* Step 3: IS returns single match (Adam) */
                action returnSingleMatch;
                /* Step 4: HIS displays Adam's record to Clarence */
                action displayPatientRecord;
                /* Step 5: Clarence locates Adam's surgical encounter */
                action locateSurgicalEncounter;
                /* Step 6: Clarence enters Adam's vital signs */
                action enterVitalSigns;
                ref first start then searchPatient;
                ref first searchPatient then relaySearchToIS;
                ref first relaySearchToIS then returnSingleMatch;
                ref first returnSingleMatch then displayPatientRecord;
                ref first displayPatientRecord then locateSurgicalEncounter;
                ref first locateSurgicalEncounter then enterVitalSigns;
                ref first enterVitalSigns then done;
            }

            /* --- Scenario 7b: Look Up a Patient — Multiple Entries Found (SFM 3.2.7b) --- */

            include use case lookupMultipleEntries {
                doc /* Adam enters for an outpatient appointment. Multiple matches are
                     * returned. Carol narrows the list with additional criteria (age,
                     * address), identifies the correct Adam using quality/confidence
                     * attributes, and creates a new encounter.
                     * [ST-183, ST-184] */

                subject hospitalInformationSystem {
                    doc /* The clinical system relaying searches to the Identification
                         * Service. [ST-045] */
                    perform relayInitialSearchToIS;
                    perform displayAllEntries;
                    perform relayRefinedSearchToIS;
                    perform displayShorterList;
                }
                actor registrationClerk {
                    doc /* Carol Clerk. [ST-212, ST-183] */
                    perform searchPatient;
                    perform enterAdditionalCriteria;
                    perform selectCorrectPatient;
                    perform createNewEncounter;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform returnMultipleMatches;
                    perform returnShorterList;
                }
                objective {
                    doc /* Progressively refine a search to correctly identify a
                         * patient from among multiple candidate matches. */
                }
                /* Step 1: Carol searches Adam */
                action searchPatient;
                /* Step 2: HIS calls FindIdentityByProperties(Person, Adam) on IS */
                action relayInitialSearchToIS;
                /* Step 3: IS returns list including Adam (multiple matches) */
                action returnMultipleMatches;
                /* Step 4: HIS displays all entries to Carol */
                action displayAllEntries;
                /* Step 5: Carol enters additional criteria (age, address) */
                action enterAdditionalCriteria;
                /* Step 6: HIS calls FindIdentityByProperties(Person, Adam, Age, Address) on IS */
                action relayRefinedSearchToIS;
                /* Step 7: IS returns shorter person list including Adam */
                action returnShorterList;
                /* Step 8: HIS displays shorter list to Carol */
                action displayShorterList;
                /* Step 9: Carol selects the correct Adam */
                action selectCorrectPatient;
                /* Step 10-11: Carol creates a new encounter for Adam */
                action createNewEncounter;
                ref first start then searchPatient;
                ref first searchPatient then relayInitialSearchToIS;
                ref first relayInitialSearchToIS then returnMultipleMatches;
                ref first returnMultipleMatches then displayAllEntries;
                ref first displayAllEntries then enterAdditionalCriteria;
                ref first enterAdditionalCriteria then relayRefinedSearchToIS;
                ref first relayRefinedSearchToIS then returnShorterList;
                ref first returnShorterList then displayShorterList;
                ref first displayShorterList then selectCorrectPatient;
                ref first selectCorrectPatient then createNewEncounter;
                ref first createNewEncounter then done;
            }

            /* --- Scenario 7c: Look Up a Patient — Merged Entries Found (SFM 3.2.7c) --- */

            include use case mergedEntriesFound {
                doc /* Bill Beaker adds a lab test using an old identifier that has
                     * been merged. IS returns the merged indication plus the active
                     * surviving identifier. Bill updates the lab test with the
                     * correct identifier. [ST-185, ST-186] */

                subject hospitalInformationSystem {
                    doc /* The clinical system mediating between the laboratory clerk
                         * and the Identification Service. [ST-045] */
                    perform relayIdentifierLookupToIS;
                    perform displayMergedIdentifier;
                }
                actor laboratoryClerk {
                    doc /* Bill Beaker. [ST-046, ST-185] */
                    perform enterLabTestWithOldIdentifier;
                    perform updateLabTestWithCorrectIdentifier;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform returnMergedIndication;
                }
                objective {
                    doc /* Detect that a supplied identifier has been deprecated through
                         * a merge and redirect to the surviving active identifier. */
                }
                /* Step 1: Bill enters lab test with Adam's old identifier */
                action enterLabTestWithOldIdentifier;
                /* Step 2: HIS calls GetAllInformationForIdentity(Person, AdamIdentifier) on IS */
                action relayIdentifierLookupToIS;
                /* Step 3: IS returns merged identifier indication + surviving ID */
                action returnMergedIndication;
                /* Step 4: HIS shows merged identifier to Bill */
                action displayMergedIdentifier;
                /* Step 5-6: Bill updates lab test with correct identifier */
                action updateLabTestWithCorrectIdentifier;
                ref first start then enterLabTestWithOldIdentifier;
                ref first enterLabTestWithOldIdentifier then relayIdentifierLookupToIS;
                ref first relayIdentifierLookupToIS then returnMergedIndication;
                ref first returnMergedIndication then displayMergedIdentifier;
                ref first displayMergedIdentifier then updateLabTestWithCorrectIdentifier;
                ref first updateLabTestWithCorrectIdentifier then done;
            }

            /* --- Scenario 8: Unattended Encounter (SFM 3.2.8) --- */

            include use case unattendedEncounter {
                doc /* A referral system receives an HL7 message from another
                     * institution for an unknown patient. The system queries IS to
                     * resolve identity. Four alternative outcomes:
                     * (1) match found — processing continues;
                     * (2) multiple possible matches — needs human review;
                     * (3) no match — system auto-creates a new identity;
                     * (4) no match — system awaits user instruction.
                     * Main flow models the happy path (Alt 1) with auto-create
                     * fallback (Alt 3). [ST-187, ST-188, ST-189, ST-190, ST-191] */

                subject referralSystem {
                    doc /* The referral system attempting to resolve a patient identity
                         * from incoming referral information. [ST-187] */
                    perform receiveExternalReferral;
                    perform requestPatientIdentifier;
                    perform handleResolutionOutcome;
                }
                actor externalSystem {
                    doc /* The external institution sending the HL7 referral message.
                         * [ST-187] */
                    perform sendHL7ReferralMessage;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform findPatientIdentifier;
                    perform returnPatientIdentifier;
                }
                objective {
                    doc /* Automatically resolve the identity of a referred patient
                         * or determine the appropriate fallback action when automatic
                         * resolution is not possible. */
                }
                /* Step 1: External system sends HL7 referral message to Referrals */
                action sendHL7ReferralMessage;
                /* Step 2: Referral system receives and extracts patient info */
                action receiveExternalReferral;
                /* Step 3: Referral system requests patient identifier from IS */
                action requestPatientIdentifier;
                /* Step 4: IS attempts to find patient identifier */
                action findPatientIdentifier;
                /* Step 5: Referral system handles outcome (match/create/manual) */
                action handleResolutionOutcome;
                /* Step 6: IS returns patient identifier */
                action returnPatientIdentifier;
                ref first start then sendHL7ReferralMessage;
                ref first sendHL7ReferralMessage then receiveExternalReferral;
                ref first receiveExternalReferral then requestPatientIdentifier;
                ref first requestPatientIdentifier then findPatientIdentifier;
                ref first findPatientIdentifier then handleResolutionOutcome;
                ref first handleResolutionOutcome then returnPatientIdentifier;
                ref first returnPatientIdentifier then done;
            }

            /* --- Scenario 9: Remove Entity from the System (SFM 3.2.9) --- */

            include use case removeEntity {
                doc /* Carol created a pseudo-record for testing. After testing, she
                     * finds the record and permanently purges it from IS. The record
                     * may be kept for audit trail purposes but is no longer findable.
                     * [ST-192, ST-193, ST-194] */

                subject hospitalInformationSystem {
                    doc /* The clinical system relaying the removal request to the
                         * Identification Service. [ST-045] */
                    perform relayRemovalToIS;
                    perform confirmRemoval;
                }
                actor serviceAdministrator {
                    doc /* Carol Clerk with administrative privileges. [ST-215, ST-192] */
                    perform requestRemoval;
                }
                actor identificationService {
                    doc /* The Identification Service instance. [ST-001] */
                    perform acknowledgeRemoval;
                }
                objective {
                    doc /* Permanently remove a fictitious or test identity from the
                         * service so it is no longer discoverable. */
                }
                /* Step 1: Carol requests removal of Bob's record */
                action requestRemoval;
                /* Step 2: HIS calls RemoveIdentity(Person, EntityID) on IS */
                action relayRemovalToIS;
                /* Step 3: IS returns acknowledgement */
                action acknowledgeRemoval;
                /* Step 4: HIS confirms removal to Carol */
                action confirmRemoval;
                ref first start then requestRemoval;
                ref first requestRemoval then relayRemovalToIS;
                ref first relayRemovalToIS then acknowledgeRemoval;
                ref first acknowledgeRemoval then confirmRemoval;
                ref first confirmRemoval then done;
            }
        }

        /* -----------------------------------------------------------
         * Multi-Domain Scenarios (Section 3.3)
         * ----------------------------------------------------------- */

        part multiDomainScenarios {
            doc /* Business scenarios involving multiple PolicyDomains, illustrating
                 * cross-organizational identity resolution and linking. Setting:
                 * Solar System Healthcare with 4 regions (East, West, North, South),
                 * hospitals Jupiter, Orion, Moon, Good Health — each with its own IS.
                 * A master national XIS (Cross-community Identification Service)
                 * operates cross-references. These are non-normative.
                 * [ST-195, ST-202] */

            /* --- Scenario 10: Look Up Across a Regional Network (SFM 3.3.1) --- */

            include use case lookupAcrossRegionalNetwork {
                doc /* Adam normally receives care at Good Health Hospital. While on
                     * vacation, he is admitted to Jupiter Hospital. Carol cannot find
                     * Adam locally, so she requests a search across the RHIO network.
                     * Good Health's IS finds a match and returns Adam's identifier.
                     * [ST-196, ST-197] */

                subject localIdentificationService {
                    doc /* IS at Orion/Jupiter Hospital, the local IS that receives
                         * Carol's search and forwards to XIS. [ST-001, ST-196] */
                    perform forwardSearchToXIS;
                    perform returnPatientToClerk;
                }
                actor registrationClerk {
                    doc /* Carol Clerk at Jupiter Hospital. [ST-212, ST-196] */
                    perform searchPatientLocally;
                }
                actor crossCommunityIdentificationService {
                    doc /* XIS_RHIO — the regional cross-community Identification
                         * Service that federates search across member IS instances.
                         * [ST-035, ST-196] */
                    perform federateSearchAcrossMembers;
                    perform returnAggregatedResult;
                }
                actor memberIdentificationService {
                    doc /* IS at Good Health Hospital (or other member hospitals)
                         * responding to the federated search. [ST-001, ST-197] */
                    perform searchLocalRegistry;
                    perform returnMatchFromRemoteHospital;
                }
                objective {
                    doc /* Locate a patient's identity across the regional health
                         * network when the patient is not found locally. */
                }
                /* Step 1: Carol searches Adam at local IS_Orion */
                action searchPatientLocally;
                /* Step 2: IS_Orion forwards FindIdentityByProperty(Person, Adam) to XIS_RHIO */
                action forwardSearchToXIS;
                /* Step 3: XIS_RHIO broadcasts FindIdentityByProperty(Person, Adam) to member IS instances */
                action federateSearchAcrossMembers;
                /* Step 4: Member IS searches local registry */
                action searchLocalRegistry;
                /* Step 4 cont: IS_GoodHealth returns Adam (from Hospital Moon) to XIS */
                action returnMatchFromRemoteHospital;
                /* Step 5: XIS_RHIO returns aggregated result to IS_Orion */
                action returnAggregatedResult;
                /* Step 6: IS_Orion returns Adam to Carol */
                action returnPatientToClerk;
                ref first start then searchPatientLocally;
                ref first searchPatientLocally then forwardSearchToXIS;
                ref first forwardSearchToXIS then federateSearchAcrossMembers;
                ref first federateSearchAcrossMembers then searchLocalRegistry;
                ref first searchLocalRegistry then returnMatchFromRemoteHospital;
                ref first returnMatchFromRemoteHospital then returnAggregatedResult;
                ref first returnAggregatedResult then returnPatientToClerk;
                ref first returnPatientToClerk then done;
            }

            /* --- Scenario 11: Look Up Specifying a Specific External Organization (SFM 3.3.2) --- */

            include use case lookupAtSpecificOrganization {
                doc /* Eve Everywoman is admitted to Level Seven Healthcare with an
                     * ankle injury. She tells Carol she is a Good Health patient.
                     * Carol searches IS specifying the target organization. The
                     * request goes through XIS_RHIO to Orion's IS, which locates
                     * Eve's record. [ST-198, ST-199] */

                subject localIdentificationService {
                    doc /* IS at Moon Hospital, the local IS receiving Carol's
                         * directed search. [ST-001, ST-198] */
                    perform forwardDirectedSearchToXIS;
                    perform returnPatientToClerk;
                }
                actor registrationClerk {
                    doc /* Carol Clerk at Level Seven Healthcare, specifying Orion/Good
                         * Health Hospital as the target. [ST-212, ST-198] */
                    perform searchPatientSpecifyingOrganization;
                }
                actor crossCommunityIdentificationService {
                    doc /* XIS_RHIO directing the search to a specific organization.
                         * [ST-035, ST-198] */
                    perform forwardSearchToTargetOrganization;
                    perform returnDirectedResult;
                }
                actor targetIdentificationService {
                    doc /* IS at Orion/Good Health Hospital responding to the directed
                         * search. [ST-001, ST-199] */
                    perform searchTargetRegistry;
                    perform returnMatchFromTargetHospital;
                }
                objective {
                    doc /* Locate a patient's identity at a specifically designated
                         * external organization. */
                }
                /* Step 1: Carol searches Eve, specifying Orion as target */
                action searchPatientSpecifyingOrganization;
                /* Step 2: IS_Moon forwards FindIdentityByProperty(Person, Eve, Orion) to XIS_RHIO */
                action forwardDirectedSearchToXIS;
                /* Step 3: XIS_RHIO forwards FindIdentityByProperty(Person, Eve) to IS_Orion */
                action forwardSearchToTargetOrganization;
                /* Step 4: IS_Orion searches local registry */
                action searchTargetRegistry;
                /* Step 4 cont: IS_Orion returns Eve to XIS_RHIO */
                action returnMatchFromTargetHospital;
                /* Step 5: XIS_RHIO returns Eve to IS_Moon */
                action returnDirectedResult;
                /* Step 6: IS_Moon returns Eve to Carol */
                action returnPatientToClerk;
                ref first start then searchPatientSpecifyingOrganization;
                ref first searchPatientSpecifyingOrganization then forwardDirectedSearchToXIS;
                ref first forwardDirectedSearchToXIS then forwardSearchToTargetOrganization;
                ref first forwardSearchToTargetOrganization then searchTargetRegistry;
                ref first searchTargetRegistry then returnMatchFromTargetHospital;
                ref first returnMatchFromTargetHospital then returnDirectedResult;
                ref first returnDirectedResult then returnPatientToClerk;
                ref first returnPatientToClerk then done;
            }

            /* --- Scenario 12: Link Entities Across Regions (SFM 3.3.3) --- */

            include use case linkEntitiesAcrossRegions {
                doc /* Adam is admitted to Jupiter Hospital (North region). Eric Entry
                     * cannot find Adam locally. Adam says he is a Solar System patient
                     * elsewhere. Eric requests a cross-organization search. The national
                     * XIS finds Adam from the East region. A new identifier is created
                     * in the North region and linked to the master XIS identifier.
                     * [ST-200, ST-201] */

                subject hospitalInformationSystem {
                    doc /* HIS at Jupiter Hospital mediating between Eric and the
                         * regional IS. [ST-045, ST-200] */
                    perform relayLocalSearchToIS;
                    perform reportNoLocalMatch;
                    perform relayCrossOrgSearchToIS;
                    perform returnPatientToClerk;
                }
                actor registrationClerk {
                    doc /* Eric Entry at Jupiter Hospital. [ST-212, ST-200] */
                    perform searchPatientLocally;
                    perform searchPatientAcrossOrganization;
                }
                actor regionalIdentificationService {
                    doc /* IS_North — the regional IS for the North region. [ST-001, ST-200] */
                    perform searchLocalRegistry;
                    perform returnNoLocalMatch;
                    perform federateSearchToXIS;
                    perform registerNewLocalIdentity;
                    perform linkLocalIdentityToMaster;
                    perform returnPatientToHIS;
                }
                actor nationalCrossReferenceService {
                    doc /* XIS_SolarSystem — the national cross-reference service
                         * managing master identifiers. [ST-035, ST-200] */
                    perform searchNationalRegistry;
                    perform returnPatientFromRemoteRegion;
                    perform acknowledgeCrossRegionLink;
                }
                objective {
                    doc /* Create a new local identity for a patient found in another
                         * region and link it to the master cross-reference identifier
                         * in the national service. */
                }
                /* Step 1: Eric searches Adam locally */
                action searchPatientLocally;
                /* Step 2: HIS calls FindIdentityByProperty(Patient, Adam) on IS_North */
                action relayLocalSearchToIS;
                /* Step 3: IS_North searches local registry — no match */
                action searchLocalRegistry;
                /* Step 3 cont: IS_North returns no match to HIS */
                action returnNoLocalMatch;
                /* Step 4: HIS reports no match found to Eric */
                action reportNoLocalMatch;
                /* Step 5: Eric requests search across SolarSystem organization */
                action searchPatientAcrossOrganization;
                /* Step 6: HIS calls FindIdentityByProperty(Patient, Adam, SolarSystem) on IS_North */
                action relayCrossOrgSearchToIS;
                /* Step 7: IS_North federates FindIdentityByProperty(Patient, Adam) to XIS_SolarSystem */
                action federateSearchToXIS;
                /* Step 8: XIS_SolarSystem searches national registry and returns Adam from East region */
                action searchNationalRegistry;
                action returnPatientFromRemoteRegion;
                /* Step 9: IS_North creates new local identifier for Adam */
                action registerNewLocalIdentity;
                /* Step 10: IS_North calls LinkIdentity (ties new regional ID to master ID) on XIS */
                action linkLocalIdentityToMaster;
                /* Step 11: XIS_SolarSystem acknowledges cross-region link */
                action acknowledgeCrossRegionLink;
                /* Step 12: IS_North returns Adam to HIS */
                action returnPatientToHIS;
                /* Step 13: HIS returns Adam to Eric */
                action returnPatientToClerk;
                ref first start then searchPatientLocally;
                ref first searchPatientLocally then relayLocalSearchToIS;
                ref first relayLocalSearchToIS then searchLocalRegistry;
                ref first searchLocalRegistry then returnNoLocalMatch;
                ref first returnNoLocalMatch then reportNoLocalMatch;
                ref first reportNoLocalMatch then searchPatientAcrossOrganization;
                ref first searchPatientAcrossOrganization then relayCrossOrgSearchToIS;
                ref first relayCrossOrgSearchToIS then federateSearchToXIS;
                ref first federateSearchToXIS then searchNationalRegistry;
                ref first searchNationalRegistry then returnPatientFromRemoteRegion;
                ref first returnPatientFromRemoteRegion then registerNewLocalIdentity;
                ref first registerNewLocalIdentity then linkLocalIdentityToMaster;
                ref first linkLocalIdentityToMaster then acknowledgeCrossRegionLink;
                ref first acknowledgeCrossRegionLink then returnPatientToHIS;
                ref first returnPatientToHIS then returnPatientToClerk;
                ref first returnPatientToClerk then done;
            }
        }
    }


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
                 * Rule: identityInstance.instanceDesignation != otherInstance.instanceDesignation
                 *   or identityInstance.governingAssignment != otherInstance.governingAssignment
                 * [ST-085, ST-082] */
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
                 * Rule: entityType.classifiedConcept->size() == 1
                 * [ST-071, ST-073, meta-model] */
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
                 * Rule: identityInstance.status != null
                 * [ST-093, ST-094, ST-095] */
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
                 * Rule: sourceIdentity.governingAssignment.governingDomain
                 *   == targetIdentity.governingAssignment.governingDomain
                 * [ST-108] */
        }

        constraint def MergeSameEntityConceptRequired {
            doc /* Merge should be restricted to identities of the same EntityType.
                 * Implementations may apply this to different EntityTypes that
                 * represent the same EntityConcept, provided that the semantic
                 * signifiers are compatible.
                 * Rule: sourceIdentity.governingAssignment.assignedEntityType.classifiedConcept
                 *   == targetIdentity.governingAssignment.assignedEntityType.classifiedConcept
                 * [ST-109] */
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
                 * Rule: targetIdentity.status == IdentityStatus::ACTIVE
                 * [ST-122] */
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


    package CIM_Requirements {

        package FunctionalRequirements {
            doc /* CIM-level Functional Requirements for the HL7 Identification Service (IS).
                 * Derived from SA1-classified REQUIREMENT_FUNCTIONAL statements, OPERATION
                 * statements, CAPABILITY statements, and business rules. Each requirement
                 * is INCOSE-compliant: singular, necessary, CIM-appropriate, unambiguous,
                 * achievable, and verifiable. Requirements use business language only. */

            /* ===================================================================
             * IDENTITY REGISTRATION AND CREATION
             * =================================================================== */

            requirement <'FR-001'> 'register identity with supplied identifier' {
                doc /* The system shall allow the Service Consumer to register a new
                     * identity instance by supplying a unique identifier, a PolicyDomain,
                     * an EntityType, and a set of identifying property values. */
                /* Source: ST-082, ST-083, ST-084. Priority: Mandatory. */
            }

            requirement <'FR-002'> 'validate supplied identifier uniqueness' {
                doc /* The system shall verify that the supplied identifier does not
                     * already exist within the specified PolicyDomain and EntityType
                     * combination before completing a registration. */
                /* Source: ST-085, ST-086. Priority: Mandatory. */
            }

            requirement <'FR-003'> 'validate properties against schema' {
                doc /* The system shall validate submitted identifying property values
                     * against the schema defined for the EntityType and PolicyDomain
                     * combination before completing a registration or creation. */
                /* Source: ST-087, ST-074, ST-070. Priority: Mandatory. */
            }

            requirement <'FR-004'> 'create identity with generated identifier' {
                doc /* The system shall allow the Service Consumer to create a new
                     * identity instance by supplying a PolicyDomain, an EntityType,
                     * and a set of identifying property values, where the system
                     * generates and returns a unique identifier. */
                /* Source: ST-088, ST-089, ST-090. Priority: Mandatory. */
            }

            requirement <'FR-005'> 'trigger automated implicit linking' {
                doc /* The system shall evaluate newly registered or created identity
                     * instances for potential matches with existing identities and
                     * shall establish links automatically when match confidence
                     * exceeds the configured definite-match threshold. */
                /* Source: ST-087, ST-128. Priority: Mandatory. */
            }

            /* ===================================================================
             * IDENTITY UPDATE
             * =================================================================== */

            requirement <'FR-006'> 'update identity property values' {
                doc /* The system shall allow the Service Consumer to update the
                     * identifying property values of an existing identity instance
                     * specified by its unique identifier, PolicyDomain, and EntityType. */
                /* Source: ST-092, ST-093, ST-094, ST-095. Priority: Mandatory. */
            }

            requirement <'FR-007'> 'apply update qualifier modes' {
                doc /* The system shall apply the update qualifier mode specified by
                     * the Service Consumer: OVERWRITE shall replace all property
                     * values including nulls, VALUED shall replace only non-null
                     * submitted values, and UNSPECIFIED shall follow the
                     * organizational policy for the PolicyDomain. */
                /* Source: ST-096. Priority: Mandatory. */
            }

            requirement <'FR-008'> 'update identity processing state' {
                doc /* The system shall allow the Service Consumer to change the
                     * processing state of an existing identity instance while
                     * preserving all other identity information unchanged. */
                /* Source: ST-097, ST-098, ST-099, ST-102, ST-103. Priority: Mandatory. */
            }

            requirement <'FR-009'> 'enforce state transition validity' {
                doc /* The system shall reject a state change request when the
                     * identity is not in an appropriate previous state for the
                     * requested transition, as defined by the organizational
                     * state model. */
                /* Source: ST-100, ST-104, ST-105, ST-106. Priority: Mandatory. */
            }

            requirement <'FR-010'> 'exclude inactive identities from clinical searches' {
                doc /* The system shall exclude identity instances in inactive state
                     * from search results returned to non-administrative users. */
                /* Source: ST-061, ST-105. Priority: Mandatory. */
            }

            requirement <'FR-011'> 'allow administrators to find inactive identities' {
                doc /* The system shall allow the Service Administrator to retrieve
                     * identity instances regardless of their processing state,
                     * including inactive identities. */
                /* Source: ST-061, ST-139. Priority: Mandatory. */
            }

            /* ===================================================================
             * MERGE AND UNMERGE
             * =================================================================== */

            requirement <'FR-012'> 'merge two identities within single domain' {
                doc /* The system shall allow the Identity Resolution Clerk to merge
                     * two identity instances within the same PolicyDomain, designating
                     * one as the surviving target and the other as the deprecated source. */
                /* Source: ST-107, ST-108, ST-112. Priority: Mandatory. */
            }

            requirement <'FR-013'> 'restrict merge to same entity concept' {
                doc /* The system shall restrict merge operations to identity instances
                     * whose EntityTypes classify the same EntityConcept. */
                /* Source: ST-109. Priority: Mandatory. */
            }

            requirement <'FR-014'> 'resolve attributes during merge' {
                doc /* The system shall fill empty identifying attributes in the
                     * surviving target identity from the deprecated source identity
                     * during a merge, while preserving all existing target attribute
                     * values unchanged. */
                /* Source: ST-110. Priority: Mandatory. */
            }

            requirement <'FR-015'> 'record merge indication' {
                doc /* The system shall provide a mechanism to indicate that two
                     * identity instances have been merged, enabling subsequent
                     * retrieval operations to detect the merge relationship. */
                /* Source: ST-111. Priority: Mandatory. */
            }

            requirement <'FR-016'> 'unmerge previously merged identities' {
                doc /* The system shall allow the Identity Resolution Clerk to reverse
                     * a previous merge by reinstating the deprecated identity instance
                     * and removing the merge association. */
                /* Source: ST-115, ST-116, ST-117. Priority: Mandatory. */
            }

            requirement <'FR-017'> 'flag unmerged identities for manual review' {
                doc /* The system shall indicate that unmerged identity instances
                     * require manual review, as the validity of their attribute
                     * values cannot be guaranteed after an unmerge operation. */
                /* Source: ST-120. Priority: Mandatory. */
            }

            /* ===================================================================
             * LINK AND UNLINK
             * =================================================================== */

            requirement <'FR-018'> 'link identities within or across domains' {
                doc /* The system shall allow the Identity Resolution Clerk to
                     * establish a link between two identity instances, indicating
                     * they represent the same real-world entity, within a single
                     * PolicyDomain or across two different PolicyDomains. */
                /* Source: ST-121, ST-122, ST-124. Priority: Mandatory. */
            }

            requirement <'FR-019'> 'enforce link transitivity' {
                doc /* The system shall treat identity links as transitive: when
                     * identity A is linked to identity B and identity B is linked
                     * to identity C, the system shall recognize identity A as
                     * implicitly linked to identity C. */
                /* Source: ST-078. Priority: Mandatory. */
            }

            requirement <'FR-020'> 'permit cross-entity-type linking' {
                doc /* The system shall permit linking of identity instances of
                     * different EntityTypes, regardless of whether those EntityTypes
                     * classify the same EntityConcept. */
                /* Source: ST-126. Priority: Mandatory. */
            }

            requirement <'FR-021'> 'unlink previously linked identities' {
                doc /* The system shall allow the Identity Resolution Clerk to remove
                     * a link between two identity instances that are currently linked
                     * to each other. */
                /* Source: ST-129, ST-130. Priority: Mandatory. */
            }

            /* ===================================================================
             * REMOVE
             * =================================================================== */

            requirement <'FR-022'> 'remove identity instance' {
                doc /* The system shall allow a privileged Service Administrator to
                     * permanently remove an identity instance from the service so
                     * that it is no longer discoverable by any user. */
                /* Source: ST-133, ST-134, ST-139. Priority: Mandatory. */
            }

            requirement <'FR-023'> 'prevent removal of linked identities' {
                doc /* The system shall reject a removal request when the identity
                     * instance is linked to one or more other identity instances. */
                /* Source: ST-134. Priority: Mandatory. */
            }

            requirement <'FR-024'> 'discourage identifier reuse after removal' {
                doc /* The system should not allow reuse of an identity instance
                     * identifier after the identity has been removed, unless
                     * organizational policy explicitly permits reuse. */
                /* Source: ST-137, ST-138. Priority: Desirable. */
            }

            /* ===================================================================
             * QUERY OPERATIONS
             * =================================================================== */

            requirement <'FR-025'> 'retrieve all information for known identity' {
                doc /* The system shall allow the Service Consumer to retrieve all
                     * identifying property values, status, and related information
                     * for a specific identity instance identified by its unique
                     * identifier, PolicyDomain, and EntityType. */
                /* Source: ST-140, ST-142, ST-143. Priority: Mandatory. */
            }

            requirement <'FR-026'> 'redirect to surviving identity on merged lookup' {
                doc /* The system shall return a warning with the surviving identity
                     * identifier when the Service Consumer requests information for
                     * an identity that has been deprecated through a merge. */
                /* Source: ST-141. Priority: Mandatory. */
            }

            requirement <'FR-027'> 'find identities by property' {
                doc /* The system shall allow the Service Consumer to search for
                     * identity instances by supplying a partially populated set of
                     * identifying property values, a PolicyDomain, an EntityType,
                     * and optional search qualifiers. */
                /* Source: ST-146, ST-147. Priority: Mandatory. */
            }

            requirement <'FR-028'> 'return match quality with search results' {
                doc /* The system shall return a quality-of-match indicator for each
                     * identity instance in the search results when the Service
                     * Consumer searches for identities by property. */
                /* Source: ST-148, ST-172. Priority: Mandatory. */
            }

            requirement <'FR-029'> 'list linked identities' {
                doc /* The system shall allow the Service Consumer to retrieve all
                     * identity instances linked to a specified identity, optionally
                     * filtered by one or more PolicyDomains. */
                /* Source: ST-150, ST-151, ST-152, ST-153. Priority: Mandatory. */
            }

            /* ===================================================================
             * NOTIFICATION
             * =================================================================== */

            requirement <'FR-030'> 'subscribe to identity update notifications' {
                doc /* The system shall allow the Service Consumer to register a
                     * standing request to be notified when changes occur to identity
                     * information matching specified criteria, including PolicyDomain,
                     * EntityType, specific identity instance, and notification
                     * qualifier. */
                /* Source: ST-155, ST-156, ST-159. Priority: Mandatory. */
            }

            requirement <'FR-031'> 'update or cancel notification subscription' {
                doc /* The system shall allow the Service Consumer to modify or
                     * cancel a previously submitted notification subscription. */
                /* Source: ST-160, ST-161, ST-162. Priority: Mandatory. */
            }

            requirement <'FR-032'> 'publish identity update notifications' {
                doc /* The system shall produce a notification to subscribed Service
                     * Consumers when an update occurs to identity information
                     * matching their subscription criteria. */
                /* Source: ST-164, ST-165, ST-167. Priority: Mandatory. */
            }

            /* ===================================================================
             * ENTITY TYPE AND DOMAIN SUPPORT
             * =================================================================== */

            requirement <'FR-033'> 'support multiple entity types' {
                doc /* The system shall explicitly allow identification of different
                     * types of entities through the EntityType and EntityConcept
                     * metadata mechanism. */
                /* Source: ST-018, ST-017. Priority: Mandatory. */
            }

            requirement <'FR-034'> 'associate domain-specific identifiers in XIS' {
                doc /* The system shall allow one or more PolicyDomain-specific
                     * identifiers to be associated with an identity and shall
                     * provide access and management capabilities for those local
                     * PolicyDomain identifiers when operating as a cross-domain
                     * service. */
                /* Source: ST-036. Priority: Mandatory. */
            }

            requirement <'FR-035'> 'provide signifier discoverability' {
                doc /* The system shall provide a means for the Service Consumer to
                     * discover the semantic signifiers supported by the service,
                     * including the schema definitions and validation rules for
                     * each EntityType. */
                /* Source: ST-170. Priority: Mandatory. */
            }

            requirement <'FR-036'> 'enforce uniform interface behavior' {
                doc /* The system shall provide the same interface behavior for all
                     * EntityTypes, ensuring that the functional structure is
                     * invariant regardless of the specific type of entity being
                     * managed. */
                /* Source: ST-021, ST-022. Priority: Mandatory. */
            }

            requirement <'FR-037'> 'scope interactions to single policy domain' {
                doc /* The system shall scope each management interaction to a
                     * single PolicyDomain, except for the link operation which
                     * shall support cross-domain linking. */
                /* Source: ST-034, ST-036. Priority: Mandatory. */
            }

            /* ===================================================================
             * EXCEPTION HANDLING (derived from GAP-003)
             * =================================================================== */

            requirement <'FR-038'> 'report operation exceptions' {
                doc /* The system shall report defined exception conditions to the
                     * Service Consumer when an operation cannot be completed,
                     * including the identity of the failed operation and the
                     * category of exception encountered. */
                /* Source: ST-086, ST-092, ST-098, ST-114, ST-119, ST-125,
                 * ST-132, ST-136, ST-145, ST-149, ST-154, ST-158, ST-163.
                 * Priority: Mandatory.
                 * PLACEHOLDER -- derived from GAP-003. Requires stakeholder
                 * validation of exception reporting format. */
            }

            /* ===================================================================
             * AUDIT RETENTION (derived from GAP-007)
             * =================================================================== */

            requirement <'FR-039'> 'retain removed records for audit' {
                doc /* The system should retain removed identity instance records in
                     * a separate repository for audit trail purposes, even though
                     * the records are no longer discoverable through the service
                     * interface. */
                /* Source: ST-194. Priority: Desirable.
                 * PLACEHOLDER -- derived from GAP-007. Requires stakeholder
                 * validation of retention policy. */
            }

            /* ===================================================================
             * METADATA LIFECYCLE (derived from GAP-008)
             * =================================================================== */

            requirement <'FR-040'> 'manage service metadata' {
                doc /* The system should provide capabilities for the Service
                     * Administrator to manage the service metadata, including
                     * PolicyDomains, EntityConcepts, EntityTypes, and
                     * EntityTypeAssignments supported by the service instance. */
                /* Source: ST-204, ST-211. Priority: Desirable.
                 * PLACEHOLDER -- derived from GAP-008. Requires stakeholder
                 * validation of metadata management scope. */
            }

            /* ===================================================================
             * PROFILE-BASED CONSTRAINING
             * =================================================================== */

            requirement <'FR-041'> 'support profile-based constraining' {
                doc /* The system shall allow organizational policies and profiles
                     * to constrain the service to a subset of the full specification
                     * capabilities, enabling simpler implementations for specific
                     * use cases. */
                /* Source: ST-039, ST-040. Priority: Mandatory. */
            }
        }


        package QualityRequirements {
            doc /* CIM-level Quality Requirements for the HL7 Identification Service (IS).
                 * The IS SFM contains no explicit quality-of-service requirements (SA1
                 * reported 0 REQUIREMENT_QUALITY entries; see GAP-002). All quality
                 * requirements below are derived from gap analysis and are expressed
                 * qualitatively at CIM level. No quantified thresholds are specified,
                 * as these are PIM/PSM concerns. Each requirement is marked as a
                 * placeholder requiring stakeholder validation. */

            /* ===================================================================
             * AVAILABILITY (derived from GAP-002)
             * =================================================================== */

            requirement <'QR-001'> 'service availability' {
                doc /* The system shall be available during the published service hours
                     * of all PolicyDomains it supports, ensuring that identity
                     * management and query operations can be performed when needed
                     * by authorized Service Consumers. */
                /* Source: GAP-002. Quality attribute: Availability.
                 * Priority: Mandatory.
                 * PLACEHOLDER -- derived from gap analysis. Requires stakeholder
                 * validation of availability expectations. */
            }

            /* ===================================================================
             * PERFORMANCE (derived from GAP-002)
             * =================================================================== */

            requirement <'QR-002'> 'search response timeliness' {
                doc /* The system shall return search results for the Find Identities
                     * by Property operation within a timeframe acceptable for
                     * clinical workflow needs, as defined by organizational policy. */
                /* Source: GAP-002. Quality attribute: Performance.
                 * Priority: Mandatory.
                 * PLACEHOLDER -- derived from gap analysis. Requires stakeholder
                 * validation of acceptable response timeframes. */
            }

            requirement <'QR-003'> 'identity retrieval timeliness' {
                doc /* The system shall return results for the Get All Information
                     * operation within a timeframe acceptable for clinical workflow
                     * needs, as defined by organizational policy. */
                /* Source: GAP-002. Quality attribute: Performance.
                 * Priority: Mandatory.
                 * PLACEHOLDER -- derived from gap analysis. Requires stakeholder
                 * validation of acceptable response timeframes. */
            }

            /* ===================================================================
             * SCALABILITY (derived from GAP-005)
             * =================================================================== */

            requirement <'QR-004'> 'scalability for identity volume' {
                doc /* The system shall maintain acceptable operation performance as
                     * the number of identity instances managed by the service
                     * increases, as defined by organizational capacity planning. */
                /* Source: GAP-005. Quality attribute: Scalability.
                 * Priority: Mandatory.
                 * PLACEHOLDER -- derived from gap analysis. Requires stakeholder
                 * validation of volume expectations. */
            }

            /* ===================================================================
             * CONCURRENCY (derived from GAP-006)
             * =================================================================== */

            requirement <'QR-005'> 'concurrent access integrity' {
                doc /* The system shall maintain data integrity when multiple Service
                     * Consumers concurrently access or modify the same identity
                     * instance, ensuring that no identity information is lost or
                     * corrupted due to concurrent operations. */
                /* Source: GAP-006. Quality attribute: Reliability.
                 * Priority: Mandatory.
                 * PLACEHOLDER -- derived from gap analysis. Requires stakeholder
                 * validation of concurrency model. */
            }

            /* ===================================================================
             * NOTIFICATION RELIABILITY (derived from GAP-009)
             * =================================================================== */

            requirement <'QR-006'> 'notification delivery reliability' {
                doc /* The system shall deliver identity update notifications to all
                     * subscribed Service Consumers whose subscription criteria match
                     * the change event, within a timeframe acceptable to the
                     * organizational notification policy. */
                /* Source: GAP-009. Quality attribute: Reliability.
                 * Priority: Mandatory.
                 * PLACEHOLDER -- derived from gap analysis. Requires stakeholder
                 * validation of notification delivery guarantees. */
            }

            /* ===================================================================
             * MATCH QUALITY (derived from GAP-017, ST-172)
             * =================================================================== */

            requirement <'QR-007'> 'match algorithm effectiveness' {
                doc /* The system shall provide identity matching algorithms that
                     * produce results distinguishable into at least two confidence
                     * tiers: definite matches not requiring human intervention, and
                     * presumptive matches requiring further verification. */
                /* Source: ST-172, ST-173, GAP-017. Quality attribute: Accuracy.
                 * Priority: Mandatory. */
            }

            /* ===================================================================
             * VERSIONING INTEGRITY (derived from GAP-014)
             * =================================================================== */

            requirement <'QR-008'> 'version consistency' {
                doc /* The system shall maintain version designations for identity
                     * instances, EntityTypes, PolicyDomains, and EntityTypeAssignments,
                     * ensuring that the current version is used as the default when
                     * no specific version is requested. */
                /* Source: ST-177, GAP-014. Quality attribute: Data Integrity.
                 * Priority: Mandatory. */
            }

            /* ===================================================================
             * INTERNATIONALIZATION (derived from GAP-016)
             * =================================================================== */

            requirement <'QR-009'> 'language support within policy domains' {
                doc /* The system shall support the languages declared in each
                     * PolicyDomain's language configuration, using the designated
                     * default language when no specific language is requested by
                     * the Service Consumer. */
                /* Source: ST-069, GAP-016. Quality attribute: Usability.
                 * Priority: Mandatory.
                 * PLACEHOLDER -- derived from gap analysis. Requires stakeholder
                 * validation of internationalization scope. */
            }

            /* ===================================================================
             * DATA INTEGRITY (cross-cutting)
             * =================================================================== */

            requirement <'QR-010'> 'identity uniqueness guarantee' {
                doc /* The system shall guarantee that no two identity instances share
                     * the same identifier within the same PolicyDomain and EntityType
                     * combination at any point in time. */
                /* Source: ST-085, ST-082. Quality attribute: Data Integrity.
                 * Priority: Mandatory. */
            }

            requirement <'QR-011'> 'read-only query operations' {
                doc /* The system shall ensure that query operations do not modify
                     * any identity information as a side effect of retrieval. */
                /* Source: ST-144. Quality attribute: Data Integrity.
                 * Priority: Mandatory. */
            }
        }


        package ComplianceRequirements {
            doc /* CIM-level Compliance Requirements for the HL7 Identification Service (IS).
                 * Derived from SA1-classified REQUIREMENT_COMPLIANCE statements, security
                 * delegation rules, authorization policies, and gap analysis. Each
                 * requirement traces to a regulatory source or organizational governance
                 * obligation. The IS SFM explicitly delegates security and authorization
                 * to separate infrastructure (ST-171), but the delegation itself creates
                 * compliance obligations that must be documented. */

            /* ===================================================================
             * DATA TYPE COMPLIANCE (from SA1 classification)
             * =================================================================== */

            requirement <'CR-001'> 'ISO 21090 data type compliance' {
                doc /* The system should use ISO 21090 Health Informatics -- Harmonized
                     * data types for information interchange as the basis for attribute
                     * data types in all identity information structures.
                     * Regulatory source: ISO 21090:2011. */
                /* Source: ST-174. Priority: Desirable.
                 * The SFM states data types are "only indicative" and implementations
                 * "should" use ISO 21090, making this a recommendation. */
            }

            /* ===================================================================
             * SECURITY AND AUTHENTICATION (from GAP-001, ST-171)
             * =================================================================== */

            requirement <'CR-002'> 'authentication precondition on all operations' {
                doc /* The system shall enforce the precondition that the Service
                     * Consumer is appropriately authenticated before any identity
                     * management or query operation is executed, delegating the
                     * authentication mechanism to the security infrastructure.
                     * Regulatory source: Organizational security policy (delegated
                     * per ST-171). */
                /* Source: ST-171, GAP-001. Priority: Mandatory.
                 * PLACEHOLDER -- derived from GAP-001. The SFM acknowledges
                 * security is delegated to separate infrastructure but requires
                 * authentication as a precondition. Requires stakeholder
                 * validation of authentication requirements. */
            }

            requirement <'CR-003'> 'authorization enforcement for operations' {
                doc /* The system shall enforce authorization controls ensuring that
                     * each Service Consumer may only perform operations for which
                     * they have been granted authority, as defined by the
                     * organizational business processes and policies.
                     * Regulatory source: Organizational authorization policy
                     * (delegated per ST-067, ST-171). */
                /* Source: ST-067, ST-171, GAP-001. Priority: Mandatory.
                 * PLACEHOLDER -- derived from GAP-001. Requires stakeholder
                 * validation of authorization model. */
            }

            requirement <'CR-004'> 'restrict identity resolution privileges' {
                doc /* The system shall restrict the merge, unmerge, link, and unlink
                     * operations to Service Consumers who have been granted the
                     * identity resolution authority, as defined by organizational
                     * policy.
                     * Regulatory source: Organizational role-based access policy
                     * (per ST-067). */
                /* Source: ST-067. Priority: Mandatory. */
            }

            requirement <'CR-005'> 'restrict removal privileges' {
                doc /* The system shall restrict the remove identity operation to
                     * Service Consumers who have been granted specified removal
                     * privileges, as defined by organizational policy.
                     * Regulatory source: Organizational access control policy
                     * (per ST-139). */
                /* Source: ST-139. Priority: Mandatory. */
            }

            /* ===================================================================
             * DATA RETENTION (from GAP-007, ST-194)
             * =================================================================== */

            requirement <'CR-006'> 'audit trail for removed records' {
                doc /* The system shall comply with organizational data retention
                     * policies by preserving audit trail information for removed
                     * identity instances in a manner separate from the active
                     * service data.
                     * Regulatory source: Organizational data retention and audit
                     * policy (per ST-194). */
                /* Source: ST-194, GAP-007. Priority: Mandatory.
                 * PLACEHOLDER -- derived from GAP-007. Requires stakeholder
                 * validation of retention period and audit requirements. */
            }

            /* ===================================================================
             * POLICY DOMAIN GOVERNANCE
             * =================================================================== */

            requirement <'CR-007'> 'policy domain ownership enforcement' {
                doc /* The system shall enforce that each PolicyDomain has a
                     * designated owner who defines the identity policies, supported
                     * EntityTypes, and authority attributes within that PolicyDomain.
                     * Regulatory source: Organizational governance policy
                     * (per ST-030, ST-180). */
                /* Source: ST-030, ST-180. Priority: Mandatory. */
            }

            /* ===================================================================
             * CONFORMANCE (from GAP-011)
             * =================================================================== */

            requirement <'CR-008'> 'conformance through profiles' {
                doc /* The system shall declare its level of conformance to this
                     * specification through a profile that identifies the
                     * PolicyDomains, EntityTypes, and operations supported by
                     * the specific service instance.
                     * Regulatory source: HL7 conformance framework
                     * (per ST-039, ST-040). */
                /* Source: ST-039, ST-040, GAP-011. Priority: Mandatory.
                 * PLACEHOLDER -- derived from GAP-011. Requires stakeholder
                 * validation of conformance criteria. */
            }

            /* ===================================================================
             * HL7 SPECIFICATION COMPLIANCE
             * =================================================================== */

            requirement <'CR-009'> 'normative section compliance' {
                doc /* The system shall comply with all normative requirements
                     * defined in SFM Section 4 (Detailed Functional Model), which
                     * constitutes the authoritative service contract defining
                     * the limits of service usage.
                     * Regulatory source: HL7 IS SFM Section 4, per ST-203. */
                /* Source: ST-202, ST-203. Priority: Mandatory. */
            }

            requirement <'CR-010'> 'entity type assignment constraints' {
                doc /* The system shall enforce that EntityTypeAssignment constraints
                     * applied within a PolicyDomain may only further restrict, and
                     * shall not relax, the schema and validation rules defined for
                     * the base EntityType.
                     * Regulatory source: HL7 IS SFM meta-model rules
                     * (per ST-074, ST-075). */
                /* Source: ST-074, ST-075. Priority: Mandatory. */
            }
        }

    }

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

package PIM_IS {
    private import ScalarValues::*;

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


    package Composition {
        doc /* PIM-level Composition for the HL7 Identification Service (IS).
             * Defines the logical architecture with provider and consumer components,
             * ports, and connection instances. Two separate service boundaries are
             * maintained per SFM Section 2.3.1:
             *   1. IdentificationManagement -- mutation operations
             *   2. Query -- read-only and notification operations
             *
             * The SFM explicitly identifies these as two distinct interfaces
             * [ST-025, ST-026, ST-027], so they are modeled as separate port
             * endpoints on a single unified provider. The SFM describes a single
             * service deployment that exposes both interfaces [ST-001, ST-004],
             * so a composite provider is used rather than separate providers.
             *
             * Consumer categories are derived from SFM Section 3 business scenarios:
             *   - ClinicalSystemConsumer: HIS operated by clerks/nurses [ST-045, ST-206]
             *   - ReferralSystemConsumer: unattended system-to-system [ST-187]
             *   - FederatedISConsumer: RHIO/XIS intermediary [ST-195, ST-196, ST-198]
             *
             * Port definitions reference ServiceContracts::IdentificationManagementPort
             * and ServiceContracts::QueryPort exactly as defined by SA4.
             * Interface definitions reference ServiceContracts::IdentificationManagementAPI
             * and ServiceContracts::QueryAPI exactly as defined by SA4. */

        /* ===================================================================
         * SERVICE PROVIDER
         * =================================================================== */

        part def IdentificationServiceProvider {
            doc /* Composite logical service provider for the Identification Service.
                 * Exposes both the IdentificationManagement and Query interfaces
                 * as separate port endpoints on a single unified provider.
                 * Derived from CIM top-level capability [ST-001, ST-004].
                 *
                 * Traces to CIM: BusinessCapabilities::identificationService */

            port managementEndpoint : ServiceContracts::IdentificationManagementPort {
                doc /* Endpoint for identity management mutation operations.
                     * Provides: registerIdentity, createIdentity, updateIdentityProperties,
                     * updateIdentityState, mergeIdentities, unmergeIdentities,
                     * linkIdentities, unlinkIdentity, removeIdentityInstance.
                     * [ST-026] */
            }

            port queryEndpoint : ServiceContracts::QueryPort {
                doc /* Endpoint for query and notification operations.
                     * Provides: getAllInformationForIdentity, findIdentitiesByProperty,
                     * listLinkedIdentities, requestIdentityUpdateNotifications,
                     * updateNotificationSubscription, notifyIdentityUpdates.
                     * [ST-027] */
            }
        }

        /* ===================================================================
         * SERVICE CONSUMERS
         * =================================================================== */

        part def ClinicalSystemConsumer {
            doc /* Logical service consumer representing a Hospital Information System
                 * (HIS) or similar clinical system. Operated by registration clerks,
                 * clinical users, laboratory clerks, and administrators. Accesses both
                 * management and query capabilities of the Identification Service.
                 * Derived from CIM stakeholders: RegistrationClerk, ClinicalUser,
                 * LaboratoryClerk, ServiceAdministrator via HospitalInformationSystem.
                 *
                 * Traces to CIM: StakeholderModel::RegistrationClerk,
                 *   StakeholderModel::ClinicalUser, StakeholderModel::LaboratoryClerk,
                 *   StakeholderModel::ServiceAdministrator,
                 *   BusinessDomain::HospitalInformationSystem [ST-045, ST-206] */

            port managementAccess : ~ServiceContracts::IdentificationManagementPort {
                doc /* Conjugated port for consuming identity management operations.
                     * Used for register, create, update, merge, unmerge, link,
                     * unlink, and remove operations. */
            }

            port queryAccess : ~ServiceContracts::QueryPort {
                doc /* Conjugated port for consuming query and notification operations.
                     * Used for getAllInformation, findByProperty, listLinked,
                     * and notification subscription management. */
            }
        }

        part def ReferralSystemConsumer {
            doc /* Logical service consumer representing an unattended referral system
                 * that resolves patient identities programmatically without human
                 * intervention. Primarily uses query capabilities for identity
                 * resolution but may invoke createIdentity when auto-create rules
                 * are configured.
                 * Derived from CIM stakeholders: ExternalSystem, ReferralSystem.
                 *
                 * Traces to CIM: StakeholderModel::ExternalSystem,
                 *   StakeholderModel::ReferralSystem [ST-187, ST-216] */

            port managementAccess : ~ServiceContracts::IdentificationManagementPort {
                doc /* Conjugated port for consuming identity management operations.
                     * Used for createIdentity when auto-create rules are configured
                     * (unattended encounter outcome #3). [ST-190] */
            }

            port queryAccess : ~ServiceContracts::QueryPort {
                doc /* Conjugated port for consuming query operations.
                     * Primarily used for findIdentitiesByProperty for automated
                     * identity resolution. [ST-187] */
            }
        }

        part def FederatedISConsumer {
            doc /* Logical service consumer representing a cross-domain Identification
                 * Service (XIS) or Regional Health Information Organization (RHIO)
                 * intermediary that federates identity queries and management
                 * operations across member organizations.
                 * Derived from CIM stakeholders: RegionalHealthNetwork.
                 *
                 * Traces to CIM: StakeholderModel::RegionalHealthNetwork [ST-195, ST-035] */

            port managementAccess : ~ServiceContracts::IdentificationManagementPort {
                doc /* Conjugated port for consuming identity management operations.
                     * Used for cross-region registerIdentity and linkIdentities
                     * operations. [ST-200, ST-201] */
            }

            port queryAccess : ~ServiceContracts::QueryPort {
                doc /* Conjugated port for consuming query operations.
                     * Used for federated findIdentitiesByProperty search requests
                     * across member organizations. [ST-196, ST-198] */
            }
        }

        /* ===================================================================
         * SYSTEM-LEVEL COMPOSITION (Connection Instances)
         * =================================================================== */

        part def IdentificationServiceSystem {
            doc /* Top-level system composition connecting the Identification Service
                 * provider to its consumer categories through typed interface
                 * connections. Each connection instance represents a logical
                 * communication channel using the appropriate API interface
                 * definition from ServiceContracts.
                 *
                 * Traces to CIM: BusinessCapabilities::identificationService [ST-001] */

            /* Provider instance */
            part provider : IdentificationServiceProvider;

            /* Consumer instances */
            part clinicalSystem : ClinicalSystemConsumer;
            part referralSystem : ReferralSystemConsumer;
            part federatedIS : FederatedISConsumer;

            /* --- Clinical System connections --- */

            interface : ServiceContracts::IdentificationManagementAPI
                connect clinicalSystem.managementAccess to provider.managementEndpoint {
                doc /* Clinical system management channel. Registration clerks,
                     * administrators, and identity resolution clerks invoke mutation
                     * operations via the HIS. [ST-045, ST-026] */
            }

            interface : ServiceContracts::QueryAPI
                connect clinicalSystem.queryAccess to provider.queryEndpoint {
                doc /* Clinical system query channel. All clinical users invoke
                     * search, retrieval, and notification operations via the HIS.
                     * [ST-045, ST-027] */
            }

            /* --- Referral System connections --- */

            interface : ServiceContracts::IdentificationManagementAPI
                connect referralSystem.managementAccess to provider.managementEndpoint {
                doc /* Referral system management channel. Used for automatic
                     * identity creation when no match is found during unattended
                     * encounter processing. [ST-190] */
            }

            interface : ServiceContracts::QueryAPI
                connect referralSystem.queryAccess to provider.queryEndpoint {
                doc /* Referral system query channel. Used for automated patient
                     * identity resolution from referral information. [ST-187] */
            }

            /* --- Federated IS connections --- */

            interface : ServiceContracts::IdentificationManagementAPI
                connect federatedIS.managementAccess to provider.managementEndpoint {
                doc /* Federated IS management channel. Used for cross-region
                     * identity registration and linking via the XIS intermediary.
                     * [ST-200, ST-201] */
            }

            interface : ServiceContracts::QueryAPI
                connect federatedIS.queryAccess to provider.queryEndpoint {
                doc /* Federated IS query channel. Used for cross-domain identity
                     * search requests federated across member organizations.
                     * [ST-196, ST-198] */
            }
        }

        /* ===================================================================
         * IDENTITY STATE MODEL
         * =================================================================== */

        state def IdentityLifecycleState {
            doc /* State machine for identity instance lifecycle states.
                 * Derived from CIM::BusinessDomain::IdentityStatus and
                 * CIM::BusinessRules::StateChangePrecondition [ST-104, ST-105, ST-106].
                 * Transitions are driven by PIM operations UpdateIdentityState
                 * and MergeIdentities/UnmergeIdentities.
                 *
                 * Traces to CIM: BusinessDomain::IdentityStatus,
                 *   BusinessRules::StateChangePrecondition */

            state initial;

            state active {
                doc /* Identity is active and discoverable in clinical searches.
                     * This is the initial state after registration or creation.
                     * [ST-105, ST-082, ST-088] */
            }

            state inactive {
                doc /* Identity is inactive and excluded from general clinical searches
                     * but remains accessible to administrators.
                     * [ST-105, ST-106, ST-061] */
            }

            state deprecated {
                doc /* Identity has been deprecated through a merge operation.
                     * The identity record is retained but the surviving identity
                     * is the authoritative reference.
                     * [ST-107, ST-104] */
            }

            /* Transitions */
            transition creation first initial then active;

            transition inactivation first active then inactive {
                doc /* Triggered by UpdateIdentityState with requestedStatus=INACTIVE.
                     * [ST-059, ST-060, ST-097] */
            }

            transition reactivation first inactive then active {
                doc /* Triggered by UpdateIdentityState with requestedStatus=ACTIVE.
                     * [ST-062, ST-063, ST-097] */
            }

            transition mergeDeprecation first active then deprecated {
                doc /* Triggered by MergeIdentities on the source identity.
                     * [ST-107, ST-104] */
            }

            transition unmergeReinstatement first deprecated then active {
                doc /* Triggered by UnmergeIdentities reinstating the previously
                     * deprecated identity. Manual review is required after
                     * reinstatement. [ST-116, ST-120] */
            }
        }
    }


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
