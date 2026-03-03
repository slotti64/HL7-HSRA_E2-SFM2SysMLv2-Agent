# SA1 Classification Report: HL7 Identification Service (IS) SFM

**Service Code**: IS
**Service Name**: IdentificationService
**Source Document**: `input/IS_sfm.md` (1182 lines)
**Classification Date**: 2026-02-25
**Analyst**: SA1 Input Analyzer

---

## Artifact 1: Classification Table

| ID | Source Text (excerpt) | Category | Cross-Refs | Notes |
|--------|----------------------------------------------|------------------------|---------------------|-------------------------------|
| ST-001 | "Identification Service (IS), which provides a set of capabilities to manage and retrieve identifying information for various kinds of entities (people, organizations, devices, etc.)" | CAPABILITY | ST-002, ST-003, ST-004, ST-005, ST-006 | Top-level service capability |
| ST-002 | "Entity" -- any concept or thing that may be identifiable and for which there is a requirement to resolve identities, covering People, Devices, and roles (Patient, Provider, etc.) | DOMAIN_CONCEPT | ST-001, ST-003, ST-005, ST-072, ST-108 | Core domain concept |
| ST-003 | "Semantic Signifier" -- a constrained information model and associated validation instructions for IS properties; defines structure and how it should be validated | DOMAIN_CONCEPT | ST-001, ST-002, ST-004, ST-071, ST-108 | Key abstraction mechanism |
| ST-004 | IS provides standalone capabilities and is an important foundation component for healthcare interoperability scenarios within and across organizations | CAPABILITY | ST-001, ST-003, ST-006 | Standalone and composable |
| ST-005 | "Role" distinctions (Patient, Provider, etc.) are not significant for identification purposes but may be mandatory in a complete IS implementation | DOMAIN_CONCEPT | ST-002, ST-003, ST-006, ST-072 | Role vs. entity distinction |
| ST-006 | Role, role definition, and role types (structural role and functional role) should be considered in a Semantic Signifier specification, in accordance with organizational policy and/or jurisdictional law | RULE | ST-002, ST-005, ST-003, ST-109 | Policy-driven role handling |
| ST-007 | IS explicitly occupies the service space; independent but compatible with underlying structures including security, access control, data models, delivery mechanisms | RULE | ST-001, ST-004, ST-109 | Architectural constraint -- SOA separation |
| ST-008 | Separating and exposing service-layer aspects abstracts the interoperability problem away from underlying systems | RULE | ST-007, ST-004 | SOA design principle |
| ST-009 | The IS Functional Specification defines functional specifications of service interfaces to uniquely identify various kinds of entities within disparate systems within a single enterprise and/or across collaborating enterprises | CAPABILITY | ST-001, ST-002, ST-010, ST-011 | Scope: intra- and inter-enterprise |
| ST-010 | Allow resolution of demographics and other identifying characteristics (properties, traits) to a unique identifier | CAPABILITY | ST-009, ST-002, ST-014, ST-072 | Core resolution capability |
| ST-011 | Allow any clinical system to maintain a common description for each entity and to manage the entities via a standard interface | CAPABILITY | ST-009, ST-010, ST-014 | Standardized access |
| ST-012 | Each organization or department often assigns its own ID that uniquely identifies the patient for its own purposes, resulting in ID values meaningless outside that system | DOMAIN_CONCEPT | ST-010, ST-013, ST-068 | Problem statement: ID fragmentation |
| ST-013 | The Identification and Cross-Reference Service provides the common thread by which entity data can be indexed | CAPABILITY | ST-009, ST-010, ST-012 | Cross-referencing purpose |
| ST-014 | The unique identifier and standard way to search, retrieve and manage entity data will allow healthcare applications to find, exchange and reference entity data while maintaining context and associations | CAPABILITY | ST-010, ST-011, ST-013 | Value proposition |
| ST-015 | IS provides a robust and complete means for defining, updating and generally managing identities, along with an associated set of identifying information, which may be an arbitrarily simple or complex information structure | CAPABILITY | ST-001, ST-003, ST-009 | Flexibility of information structures |
| ST-016 | The semantic signifier effectively defines one representation of an Entity Type that is recognized and managed by an IS instance | DOMAIN_CONCEPT | ST-003, ST-071, ST-070 | EntityType-SemanticSignifier relationship |
| ST-017 | IS intended to allow lookup and management of a wide variety of Entity Types, including but not limited to patients, individual providers, institutional providers, and medical devices | CAPABILITY | ST-001, ST-002, ST-016 | Entity type examples enumeration |
| ST-018 | The service interface will explicitly allow identification of different types of entities that may be supported | REQUIREMENT_FUNCTIONAL | ST-017, ST-001 | Split from compound statement |
| ST-019 | The scope covers both support for multiple Policy Domains and multiple Entity Types | CAPABILITY | ST-017, ST-068, ST-070 | Multi-domain, multi-type scope |
| ST-020 | It is left to technical specifications to decide whether to define an implementation specific to one Entity Type and/or a single Policy Domain | RULE | ST-019, ST-068, ST-070 | Delegation to tech spec |
| ST-021 | Interface functionality for identifying different kinds of entities is the same; some IS instances will manage more than one type of entity | RULE | ST-017, ST-018, ST-019 | Uniform interface principle |
| ST-022 | The behavioural structure is invariant across the different contents that the service can manage, both in terms of logical structure and concrete representation | RULE | ST-003, ST-021 | Separation of concerns principle |
| ST-023 | The specification uses the term "entity" to imply either an entity or an "entity in a role" | DOMAIN_CONCEPT | ST-002, ST-005 | Terminological convention |
| ST-024 | Linking functionality could feasibly be used to link roles to the entity playing them, but this is not a primary use case | RULE | ST-023, ST-002, ST-091 | Secondary use case noted |
| ST-025 | Two interfaces identified: Identification Management and Query | DOMAIN_CONCEPT | ST-026, ST-027, ST-001 | Service structure |
| ST-026 | Identification Management provides capabilities for the manipulation of Identifiers and properties | CAPABILITY | ST-025, ST-078, ST-079, ST-081, ST-082, ST-084, ST-086, ST-088, ST-090, ST-093, ST-095 | Interface 1 |
| ST-027 | Query provides read-only capabilities for retrieving Entity information | CAPABILITY | ST-025, ST-097, ST-100, ST-103, ST-106, ST-111, ST-114 | Interface 2 |
| ST-028 | IS provides capabilities for managing identifiers for generic Entities, so there will be a need to specialize the information model for specific types of Entity such as Person, Patient, or Provider | RULE | ST-003, ST-017, ST-070 | Specialization requirement |
| ST-029 | This specification does not constrain whether the IS interface is provided to an authoritative source of information or not; IS interfaces may hide a master system or be used just for registry purposes | RULE | ST-001, ST-007 | Topology-neutral design |
| ST-030 | "Policy Domain" -- an identity space or sphere of use of entity identifiers; may be universal, a realm or nation, a state, an organization or even a department | DOMAIN_CONCEPT | ST-068, ST-019, ST-031, ST-032 | Key concept definition |
| ST-031 | The sphere of issue control could be legal, organizational, geographical, or system-specific | DOMAIN_CONCEPT | ST-030, ST-068 | Issue control taxonomy |
| ST-032 | The sphere of use is the set of organizations that wish to interoperate for a specific set of information | DOMAIN_CONCEPT | ST-030, ST-068 | Usage sphere definition |
| ST-033 | A Social Security Number may be issued by a central federal authority and used as an identifier for "patient" in one Policy Domain and for "employee" in another | DOMAIN_CONCEPT | ST-030, ST-032 | Example of cross-domain ID reuse |
| ST-034 | An individual IS instance could support multiple Policy Domains, but any individual interaction occurs with respect to one specific Policy Domain (other than explicit linking across Policy Domains) | RULE | ST-030, ST-019, ST-091 | Single-domain interaction constraint |
| ST-035 | IS (single domain) vs. XIS (multiple domains recognized and managed) | DOMAIN_CONCEPT | ST-030, ST-034, ST-036 | Enumeration: IS/XIS distinction |
| ST-036 | XIS must allow one or more Policy Domain-specific identifiers to be associated with an entity and provide access and management capabilities for those local Policy Domain identifiers | REQUIREMENT_FUNCTIONAL | ST-035, ST-030, ST-068 | XIS requirement |
| ST-037 | A local Domain Entity identifier is any identifier that has been allocated by an individual system or facility | DOMAIN_CONCEPT | ST-036, ST-012, ST-072 | Local identifier definition |
| ST-038 | Functionally, IS and XIS interfaces are similar; differences are that some metadata capabilities are specific to XIS and some XIS capabilities handle different Policy Domain values | RULE | ST-035, ST-036 | IS/XIS functional similarity |
| ST-039 | Technical specifications may apply constraints via profiles to provide a subset of functionality | RULE | ST-038, ST-020, ST-040 | Profile-based constraining |
| ST-040 | The use of profiles is key in providing real implementations of this service; for a "simple" IS (e.g., basic identity resolution for Patients only) profiles apply constraints | RULE | ST-039, ST-003, ST-070 | Implementation simplification |
| ST-041 | IS may be implemented and used in various topologies; accessed directly via web or other UI mechanisms by users, or system-to-system via applications such as Hospital Information Systems | RULE | ST-001, ST-029, ST-042 | Topology flexibility |
| ST-042 | Whether the implementation behind the IS interface is actually the source of record or just a separate indexing mechanism is an implementation choice | RULE | ST-029, ST-041 | Source-of-record neutrality |
| ST-043 | Recommended approach: use an internal ID (IS Id) to act as a master or mediating identifier to link associated identity records together | RULE | ST-072, ST-091, ST-113 | Internal ID recommendation |
| ST-044 | The internal identifier would not usually need to be surfaced, so it has not been included in the operation parameters for input or outputs | RULE | ST-043, ST-072 | IS Id not in interface |
| ST-045 | Hospital Information System (HIS) used as a generic term for various clinical systems including Patient Administration Systems | DOMAIN_CONCEPT | ST-046, ST-047 | Glossary term |
| ST-046 | Primary Actors: Adam Everyman (patient), Robert (Bob) Smith (patient), Eric Entry (registration clerk), Eve Everywoman (patient, maiden name Evelyn Smith), Evelyn Smith (patient), Carol Clerk (registration clerk), Clarence Barton (pre-op nurse), Nancy Nightingale (discharge nurse), Bill Beaker (laboratory clerk) | STAKEHOLDER | ST-047, ST-048 | Scenario actors |
| ST-047 | Hospital Moon uses a single Policy Domain to manage patient identities; HIS manages medical records and encounter information; IS manages patient identities across all hospital systems | WORKFLOW | ST-046, ST-048, ST-030 | Scenario context: single-domain |
| ST-048 | Create a new patient: Carol searches IS via HIS, patient not found, gathers demographics, creates new entity in IS | WORKFLOW | ST-046, ST-049, ST-050, ST-051, ST-079, ST-081 | Scenario: new patient registration |
| ST-049 | HIS -> IS: Find Identity By Property (Person, Name, Address) -- returns empty list | OPERATION | ST-048, ST-100 | Scenario step: search |
| ST-050 | HIS -> IS: Find Identity By Property (Person, Adam, Old Address) -- returns empty list | OPERATION | ST-048, ST-100 | Scenario step: broader search |
| ST-051 | HIS -> IS: Register Identity (Person, ID, Adam) -- returns acknowledgement | OPERATION | ST-048, ST-078 | Scenario step: register |
| ST-052 | Link (or Merge) entities scenario: Nancy finds two similar entries for Adam, requests linking; newer entity becomes alias for older record | WORKFLOW | ST-046, ST-053, ST-054, ST-055 | Scenario: link/merge |
| ST-053 | Depending on hospital policy, Nancy may instead request merge; merged record becomes deprecated, only surviving record used to identify entity in future | RULE | ST-052, ST-054, ST-084 | Policy-driven merge vs. link |
| ST-054 | HIS -> IS: Link Identities (Person, newerAdam, Person, olderAdam) -- returns acknowledgement | OPERATION | ST-052, ST-091 | Scenario step: link |
| ST-055 | HIS -> IS: Merge Identities (Person, newerAdam, Person, olderAdam) -- returns acknowledgement | OPERATION | ST-052, ST-084 | Scenario step: merge |
| ST-056 | Update demographics: Carol searches, finds near-match with confidence score, retrieves full record, updates address and phone number | WORKFLOW | ST-046, ST-057, ST-058, ST-082 | Scenario: update demographics |
| ST-057 | Each match has a quality attribute that guides the clerk to correctly identify the patient | DOMAIN_CONCEPT | ST-056, ST-100, ST-073 | Match quality concept |
| ST-058 | Carol updates Adam's address and phone number in demographics and submits change to IS | OPERATION | ST-056, ST-082 | Scenario step: update |
| ST-059 | Inactivate entity: Carol discovers record should be inactivated (death, relocation, change of health plan, removal of test data); changes state to Inactive | WORKFLOW | ST-046, ST-060, ST-088 | Scenario: inactivate |
| ST-060 | HIS -> IS: Update Identity Status (Person, EntityID, Status=Inactive) -- inactive entity not considered in searches for clinically active patients | OPERATION | ST-059, ST-088 | Scenario step: inactivate |
| ST-061 | This does not preclude administrators from finding the entry using administration tools of IS | RULE | ST-059, ST-060 | Inactive still findable by admin |
| ST-062 | Activate (inactive) entity: Carol realizes mistake, finds entry using IS search, changes state to Active | WORKFLOW | ST-046, ST-063, ST-088 | Scenario: reactivate |
| ST-063 | HIS -> IS: Update Identity Status (Person, EntityID, Status=Active) | OPERATION | ST-062, ST-088 | Scenario step: activate |
| ST-064 | Unlink/Unmerge entity: Carol discovers erroneous link between Eve Everywoman and Evelyn Smith, removes alias to create distinct entries | WORKFLOW | ST-046, ST-065, ST-066, ST-095, ST-086 | Scenario: unlink |
| ST-065 | HIS -> IS: List Linked Identities (Person, EntityID) -- returns alias list | OPERATION | ST-064, ST-103 | Scenario step: list links |
| ST-066 | HIS -> IS: Unlink Identity (Person, Smith, Person, Everywoman) -- acknowledges unlinking | OPERATION | ST-064, ST-095 | Scenario step: unlink |
| ST-067 | The organization's business processes and policies control the admission clerk authority on identity resolution functions; merge/link/unlink/unmerge may be escalated to a specialized identity resolution clerk | RULE | ST-064, ST-046, ST-117 | Authorization policy delegation |
| ST-068 | Policy Domain -- manages identity usage across departments, organizations, or national realms; PolicyDomain class with id, name, description, versionId, status, forCrossReference, languageSupported, defaultLanguageId | DATA_STRUCTURE | ST-030, ST-069, ST-070, ST-034 | Meta-model class |
| ST-069 | PolicyDomain attributes: id (unique identifier), name, description, versionId (version of the domain), status (whether PolicyDomain can be used), forCrossReference (optional, whether can be used in cross-references), languagesSupported (optional), defaultLanguage | DATA_STRUCTURE | ST-068 | Attribute details |
| ST-070 | EntityType class: id, name, description, status, versionId, schemaDefinition, validationRuleSet | DATA_STRUCTURE | ST-071, ST-016, ST-068 | Meta-model class |
| ST-071 | EntityType identifies a specific type of entity that an IS supports at the level of a specific information model or schema (Semantic Signifier); classifies one EntityConcept | DOMAIN_CONCEPT | ST-070, ST-003, ST-072, ST-016 | Concept-type relationship |
| ST-072 | EntityConcept class: id, name, description, versionId -- specifies a concept or category of information that may be supported in IS | DATA_STRUCTURE | ST-002, ST-071, ST-073 | Meta-model class |
| ST-073 | EntityConcept purpose: indicate semantic relationship between different representations (Entity Types) of the same underlying concept | DOMAIN_CONCEPT | ST-072, ST-071 | Semantic bridging purpose |
| ST-074 | EntityTypeAssignment class: id, status, versionId, constrainedSchemaDefinition (optional), constrainedValidationRuleSet (optional) | DATA_STRUCTURE | ST-070, ST-068, ST-075 | Meta-model class |
| ST-075 | EntityTypeAssignment allows definition rules for EntityTypes to be varied for different PolicyDomains; two different Domains can have different validation rules | DOMAIN_CONCEPT | ST-074, ST-068, ST-070 | Domain-specific customization |
| ST-076 | IdentityInstance class: id, versionId, status, populatedSchemaValue -- represents actual instance entries, always of a specific EntityType, scoped within a PolicyDomain | DATA_STRUCTURE | ST-074, ST-070, ST-068, ST-077 | Meta-model class |
| ST-077 | IdentityLink class: linkType (LinkTypeCode), linkMethod (LinkMethodCode, optional), reason (optional), provenanceInformation (optional) | DATA_STRUCTURE | ST-076, ST-078, ST-091 | Meta-model class |
| ST-078 | IdentityLink allows linking and merging of identities; link type indicates link or merge; link semantics state linked items represent the same real-world entity; links are transitive by definition | RULE | ST-077, ST-091, ST-084 | Link semantics and transitivity |
| ST-079 | linkType: indicates whether identities are linked as active peers or whether one is deprecated (merge) | DOMAIN_CONCEPT | ST-077, ST-078 | Enumeration: link vs. merge |
| ST-080 | provenanceInformation: placeholder for administrative info relating to linking/unlinking/merging/unmerging when applied manually | DOMAIN_CONCEPT | ST-077 | Provenance concept |
| ST-081 | linkMethod: coded value providing info on how the link was made | DOMAIN_CONCEPT | ST-077 | Link method concept |
| ST-082 | Register an Identity: allows creation of an identity with supplied property values; uses identifier supplied by service consumer, unique within Domain for EntityType | OPERATION | ST-026, ST-083, ST-051 | Management function |
| ST-083 | Register Identity Inputs: EntityType Id, EntityType VersionId (opt), PolicyDomain Id, PolicyDomain VersionId (opt), Identity Instance Id, Status, Properties (Populated Semantic Signifier) | DATA_STRUCTURE | ST-082, ST-068, ST-070, ST-076 | Operation inputs |
| ST-084 | Register Identity Outputs: Acknowledgement, Automated links applied notification, Warning if matching records found with list of potentially matching Identifiers | DATA_STRUCTURE | ST-082 | Operation outputs |
| ST-085 | Register Identity Postcondition: An Identity is Registered | RULE | ST-082 | Postcondition |
| ST-086 | Register Identity Exceptions: Identity already exists (Identifier must be unique for EntityType/PolicyDomain combination), Unrecognized PolicyDomain, Unrecognized EntityType, Validation of properties against schema failed | RULE | ST-082, ST-068, ST-070 | Exception conditions |
| ST-087 | Register Identity: IS implementations expected to provide some level of automated implicit linking capabilities; could be policy-driven or handled manually; triggered on entity creation or property update | RULE | ST-082, ST-078, ST-091 | Automated linking expectation |
| ST-088 | Create an Identity: allows creation of Identity Instance with property values; Identifier is generated and passed back to consumer; used where consumer cannot supply own local identifiers | OPERATION | ST-026, ST-089, ST-090 | Management function |
| ST-089 | Create Identity Inputs: EntityType Id, EntityType VersionId (opt), PolicyDomain Id, PolicyDomain VersionId (opt), Status, Properties (Populated Semantic Signifier) -- no Identity Instance Id supplied | DATA_STRUCTURE | ST-088, ST-068, ST-070 | Operation inputs (no client-supplied ID) |
| ST-090 | Create Identity Outputs: generated Identity Instance Identifier (external local identifier, not internal IS Id), Acknowledgement, Automated links notification, Warning if matching records found | DATA_STRUCTURE | ST-088 | Operation outputs |
| ST-091 | Create Identity: IS Id is an identifier for a Real-World Entity guaranteed unique across an IS instance (across all Policy Domains); may be generated by IS implementation, only used internally | DOMAIN_CONCEPT | ST-088, ST-043, ST-076 | IS Id concept |
| ST-092 | Create Identity Exceptions: Unrecognized PolicyDomain, Unrecognized EntityType, Validation of properties against schema failed | RULE | ST-088, ST-068, ST-070 | Exception conditions |
| ST-093 | Update Identity Property Values: allows addition and/or update of property values for an identity specified by a unique Identifier | OPERATION | ST-026, ST-094, ST-095, ST-058 | Management function |
| ST-094 | Update Identity Precondition: The Identity specified by the Identifier exists | RULE | ST-093 | Precondition |
| ST-095 | Update Identity Inputs: EntityType Id, EntityType VersionId (opt), PolicyDomain Id, PolicyDomain VersionId (opt), Identity Instance Id, Update Qualifier, Properties (Populated Semantic Signifier) | DATA_STRUCTURE | ST-093, ST-096 | Operation inputs |
| ST-096 | UpdateQualifier: updateMode (OVERWRITE - replace entire set; VALUED - replace only valued elements; UNSPECIFIED - implementation specific), updateSchemaDefinition (reference to external resource for extracting properties) | DATA_STRUCTURE | ST-095, ST-093 | Enumeration: update modes |
| ST-097 | Update Identity Outputs: Acknowledgement, Automated links applied, Warning if new potential match found, Warning if existing match now questionable | DATA_STRUCTURE | ST-093 | Operation outputs |
| ST-098 | Update Identity Exceptions: Identity does not exist, Unrecognized PolicyDomain, Unrecognized EntityType, Validation of properties failed | RULE | ST-093, ST-068, ST-070 | Exception conditions |
| ST-099 | Update Identity State: changes processing state of an identity (e.g., to inactive, active or other states defined in semantic profiles) | OPERATION | ST-026, ST-100, ST-060, ST-063 | Management function |
| ST-100 | Update Identity State Precondition: Identifier identifies an Entity in an appropriate previous state for the status change | RULE | ST-099 | Precondition: state compatibility |
| ST-101 | Update Identity State Inputs: EntityType Id, EntityType VersionId (opt), PolicyDomain Id, PolicyDomain VersionId (opt), Identity Instance Id, State, Reason | DATA_STRUCTURE | ST-099 | Operation inputs |
| ST-102 | Update Identity State Invariant: all identity information unchanged except for state change | RULE | ST-099 | Invariant |
| ST-103 | Update Identity State Postcondition: Identity state changed to input state | RULE | ST-099 | Postcondition |
| ST-104 | Update Identity State Exceptions: Identifier not recognized, Unrecognized PolicyDomain, Unrecognized EntityType, Previous state incompatible with requested state change | RULE | ST-099, ST-100 | Exception conditions |
| ST-105 | Simple state model of active/inactive defined as minimum set of states; inactive entities do not show up in normal searches; status set left to technical specification | RULE | ST-099, ST-076, ST-060 | Minimum state model |
| ST-106 | States are configurable and tailored to individual realms and organizations; may vary depending on Entity Type; additional curation states (pending, approved) may be used | RULE | ST-105, ST-099 | State model extensibility |
| ST-107 | Merge Identities: allows merging two identities; Target is the "winner"; deprecated Identity automatically set to pre-configured state | OPERATION | ST-026, ST-108, ST-055 | Management function |
| ST-108 | Merge restricted to within a single PolicyDomain only; Link capability should be used across Domains | RULE | ST-107, ST-121, ST-068 | Merge domain constraint |
| ST-109 | Merge: generally restricted to identities of same EntityType; implementations may apply to different EntityTypes representing same EntityConcept if semantic signifiers compatible | RULE | ST-107, ST-070, ST-072 | EntityType compatibility rule |
| ST-110 | Merge: identifying attributes in target that are empty are filled from source; existing attributes in target remain AS-IS | RULE | ST-107 | Merge attribute resolution |
| ST-111 | Merge: implementation must provide mechanism to indicate two identities have been merged (e.g., explicit link relationship or correlation set) | REQUIREMENT_FUNCTIONAL | ST-107, ST-077 | Merge indication requirement |
| ST-112 | Merge Preconditions: both identities must exist, must be in allowable state, must be in same PolicyDomain, must be classified as EntityTypes representing same EntityConcept | RULE | ST-107, ST-068, ST-072 | Preconditions |
| ST-113 | Merge Inputs: EntityType Id, EntityType VersionId (opt), PolicyDomain Id, PolicyDomain VersionId (opt), Target Identity Instance Id, Source Identity Instance Id (to be deprecated), Reason (opt), Link Method (opt), Source State (opt), Target State (opt) | DATA_STRUCTURE | ST-107 | Operation inputs |
| ST-114 | Merge Exceptions: Target/Source Identity does not exist, Unrecognized PolicyDomain/EntityType/Link Method, Source/Target state not permitted | RULE | ST-107 | Exception conditions |
| ST-115 | Unmerge Identities: allows unmerging two identities; reinstates previously deprecated identity; states of unmerged identities cannot be guaranteed valid; subsequent manual updates required | OPERATION | ST-026, ST-116, ST-107 | Management function |
| ST-116 | Unmerge: only states are updated, no attribute values updated; mechanism used to record merge association is reversed | RULE | ST-115 | Unmerge behavior |
| ST-117 | Unmerge Precondition: the identity resulted from a previous merge | RULE | ST-115, ST-107 | Precondition |
| ST-118 | Unmerge Inputs: EntityType Id, EntityType VersionId (opt), PolicyDomain Id, PolicyDomain VersionId (opt), Source Identity Instance Id, Target Identity Instance Id, Reason (opt), Source Identity State (opt), Target Identity State (opt) | DATA_STRUCTURE | ST-115 | Operation inputs |
| ST-119 | Unmerge Exceptions: Identifier not recognized, supplied identities not previously merged, Unrecognized PolicyDomain/EntityType, Source/Target state not permitted | RULE | ST-115, ST-117 | Exception conditions |
| ST-120 | Unmerge: from overall process perspective should require manual intervention afterwards; technical specification may enforce inactive status on unmerged entities until further update | RULE | ST-115 | Post-unmerge manual intervention |
| ST-121 | Link Identities: allows linking of two identities; can be carried out within a single domain or across two different domains | OPERATION | ST-026, ST-122, ST-054, ST-078 | Management function |
| ST-122 | Link Preconditions: both identities must exist; Target Identity must be in Active state | RULE | ST-121 | Preconditions |
| ST-123 | Link Inputs: Source EntityType Id/VersionId(opt), Source PolicyDomain Id/VersionId(opt), Source Identity Instance Id, Target EntityType Id/VersionId(opt), Target PolicyDomain Id/VersionId(opt), Target Identity Instance Id, Reason(opt), Link Method(opt) | DATA_STRUCTURE | ST-121 | Operation inputs (cross-domain capable) |
| ST-124 | Link Postcondition: both Entities updated with link information | RULE | ST-121 | Postcondition |
| ST-125 | Link Exceptions: Source/Target Entity does not exist, Unrecognized EntityTypes/PolicyDomains, Identities already linked, Unrecognized Link Method, Identity states incompatible | RULE | ST-121 | Exception conditions |
| ST-126 | Link permits linking of entities of different types; recommended they map to same EntityConcept (unlike merge, NOT an absolute requirement) | RULE | ST-121, ST-109, ST-072 | Cross-type linking allowed |
| ST-127 | For cross-domain linking, Technical Specifications may choose peer-to-peer or enforce link to/from a Master Policy Domain for XIS | RULE | ST-121, ST-035, ST-068 | Cross-domain linking topology |
| ST-128 | Link operation could be triggered by implicit logic as part of register, create or update actions | RULE | ST-121, ST-082, ST-088, ST-093, ST-087 | Implicit linking trigger |
| ST-129 | Unlink Identity: allows unlinking of two entities | OPERATION | ST-026, ST-130, ST-066 | Management function |
| ST-130 | Unlink Preconditions: both identities must exist and be linked to each other | RULE | ST-129 | Preconditions |
| ST-131 | Unlink Inputs: Source EntityType Id/VersionId(opt), Source PolicyDomain Id/VersionId(opt), Source Identity Instance Id, Target EntityType Id/VersionId(opt), Target PolicyDomain Id/VersionId(opt), Target Identity Instance Id, Reason | DATA_STRUCTURE | ST-129 | Operation inputs |
| ST-132 | Unlink Exceptions: Source/Target Entity does not exist, Unrecognized EntityTypes/PolicyDomains, Identities not linked, Identity states incompatible with unlink | RULE | ST-129 | Exception conditions |
| ST-133 | Remove an Identity Instance: allows complete removal of an Identity Instance from an IS service | OPERATION | ST-026, ST-134 | Management function |
| ST-134 | Remove Preconditions: Identity Instance should exist, be in appropriate State, should not be linked to other Entities | RULE | ST-133 | Preconditions |
| ST-135 | Remove Inputs: EntityType Id, EntityType VersionId (opt), PolicyDomain Id, PolicyDomain VersionId (opt), Identity Instance Id | DATA_STRUCTURE | ST-133 | Operation inputs |
| ST-136 | Remove Exceptions: Identifier not recognized, Identity not in allowable state for removal, Identity is linked to other Identities | RULE | ST-133, ST-134 | Exception conditions |
| ST-137 | Technical Specifications must define whether Identity Instance Identifier may be reused after removal, although this is strongly discouraged | RULE | ST-133 | Identifier reuse policy |
| ST-138 | This functional model assumes identity instance identifiers cannot be reused | RULE | ST-137, ST-133 | Default: no reuse |
| ST-139 | Remove capability should be restricted to users with specified privileges | RULE | ST-133, ST-067 | Privilege restriction |
| ST-140 | Get All Information for an Identity: retrieves all information for an Identity (properties, status, etc.); specific unique identifier is input qualified by PolicyDomain and EntityType | OPERATION | ST-027, ST-141 | Query function |
| ST-141 | Get All Info: if identity has been merged into another main identifier, then warning message returned with identifier of identity into which supplied identifier has been merged | RULE | ST-140, ST-107 | Merged identity redirect |
| ST-142 | Get All Info Inputs: EntityType Id, EntityType VersionId (opt), PolicyDomain Id, PolicyDomain VersionId (opt), Identity Instance Id, Return Statuses (opt) | DATA_STRUCTURE | ST-140 | Operation inputs |
| ST-143 | Get All Info Outputs: all property values of the Identity | DATA_STRUCTURE | ST-140 | Operation outputs |
| ST-144 | Get All Info Invariant: Identity is unchanged | RULE | ST-140 | Invariant (read-only) |
| ST-145 | Get All Info Exceptions: Identifier not recognized, Unrecognized EntityType/PolicyDomain, Unrecognized Identity states | RULE | ST-140 | Exception conditions |
| ST-146 | Find Identities by Property: given partially populated semantic signifier and other search filter criteria, search for matching Identities; outputs include quality of match | OPERATION | ST-027, ST-147, ST-049, ST-050 | Query function |
| ST-147 | Find by Property Inputs: EntityType Id, EntityType VersionId (opt), List of 0+ PolicyDomain Ids/VersionIds (default=all, latest), Search Properties (partially populated Semantic Signifier), Return Statuses (opt), Search qualifiers (all opt): Requested confidence of match, Maximum Result Set Size, Error If Size exceeded flag, Matching algorithm | DATA_STRUCTURE | ST-146 | Operation inputs |
| ST-148 | Find by Property Outputs: acknowledgement, list of (PolicyDomain Id/VersionId, EntityType Id/VersionId, Identity Instance Id, fully populated semantic signifier, quality_of_match) ordered by quality_of_match | DATA_STRUCTURE | ST-146, ST-057 | Operation outputs |
| ST-149 | Find by Property Exceptions: Unrecognized PolicyDomain/EntityType, Invalid status values, Invalid Search Qualifiers, Validation of properties against schema failed | RULE | ST-146 | Exception conditions |
| ST-150 | List Linked Identities: given an Identifier, list all other entities linked to the Identity, optionally constrained within one or more Policy Domains | OPERATION | ST-027, ST-151, ST-065 | Query function |
| ST-151 | List Linked Precondition: The Identity exists in the specified domain | RULE | ST-150 | Precondition |
| ST-152 | List Linked Inputs: EntityType Id, EntityType VersionId (opt), PolicyDomain Id, PolicyDomain VersionId (opt), Identity Instance Id, List of other PolicyDomain Ids (opt), Search Qualifiers (opt) | DATA_STRUCTURE | ST-150 | Operation inputs |
| ST-153 | List Linked Outputs: List of Identities (PolicyDomain Id, EntityType Id, Identity Instance Id, fully populated semantic signifier) that are linked to specified Identity | DATA_STRUCTURE | ST-150 | Operation outputs |
| ST-154 | List Linked Exceptions: PolicyDomain not known, EntityType not known, Identity not known, Search qualifiers not recognized | RULE | ST-150 | Exception conditions |
| ST-155 | Request Identity Update Notifications: consumer lodges request to be notified of changes to info for a specific Identity (properties, status, entity links) or identities of a specific type/domain combination | OPERATION | ST-027, ST-156, ST-157 | Query function (subscription) |
| ST-156 | Request Notifications Inputs: Subscriber identification/destination, one or more of: PolicyDomain Id/VersionId, EntityType Id/VersionId, Identity Instance Id, Notification Qualifier, Request Status | DATA_STRUCTURE | ST-155 | Operation inputs |
| ST-157 | Request Notifications Outputs: Notification Request Identifier | DATA_STRUCTURE | ST-155 | Operation outputs |
| ST-158 | Request Notifications Exceptions: PolicyDomain/EntityType/Request Id/Identity Id not known, Unrecognized/Invalid Notification Qualifier, Unrecognized status value | RULE | ST-155 | Exception conditions |
| ST-159 | Request Notifications: effectively a subscription operation; could be implemented using publish-and-subscribe capability | RULE | ST-155 | Implementation pattern |
| ST-160 | Update Identity Notification Request: consumer updates previously submitted notification request, including cancellation | OPERATION | ST-027, ST-161, ST-155 | Query function (subscription update) |
| ST-161 | Update Notification Inputs: Notification Request Id, Subscriber identification/destination, one or more of: PolicyDomain Id/VersionId, EntityType Id/VersionId, Identity Instance Id, Notification Qualifier | DATA_STRUCTURE | ST-160 | Operation inputs |
| ST-162 | Update Notification Outputs: Acknowledgement, potentially asynchronous update notifications | DATA_STRUCTURE | ST-160 | Operation outputs |
| ST-163 | Update Notification Exceptions: PolicyDomain/EntityType/Identity not known, Unrecognized/Invalid Notification Qualifier | RULE | ST-160 | Exception conditions |
| ST-164 | Notify Identity Updates: service produces notification of update made to information relating to a specific identity or identities within PolicyDomain and/or EntityType | OPERATION | ST-027, ST-155, ST-160 | Query function (publication) |
| ST-165 | Notify Updates Preconditions: IS has become aware of update to information; a previous Request Update Notifications request has been received | RULE | ST-164, ST-155 | Preconditions |
| ST-166 | Notify Updates Outputs: Identifier, status, and all property values of the Identity | DATA_STRUCTURE | ST-164 | Operation outputs |
| ST-167 | Notify Updates: effectively a publication operation resulting from earlier subscription; could be implemented using publish-and-subscribe | RULE | ST-164, ST-159 | Implementation pattern |
| ST-168 | Functions specified are only intended to use demographic data; NOT an enforced restriction since capabilities defined to consume/produce very generic information structure | RULE | ST-001, ST-003, ST-010 | Demographic focus vs. generic structure |
| ST-169 | The means for returning informational and exception messages is left to Technical Specifications | RULE | ST-082, ST-088, ST-093, ST-099, ST-107, ST-115, ST-121, ST-129, ST-133, ST-140, ST-146, ST-150, ST-155, ST-160, ST-164 | Delegation to tech spec |
| ST-170 | The Service assumes the client can provide and consume the semantic signifier; means for client to discover supported signifiers must be provided (reflection-style operation or Service Registry) | REQUIREMENT_FUNCTIONAL | ST-003, ST-027 | Discoverability requirement |
| ST-171 | Security is not explicitly referenced; assumed to be handled by separate infrastructure; assumed precondition on all operations that caller is appropriately authenticated and possibly authorized | RULE | ST-001, ST-067 | Security delegation |
| ST-172 | In matching, two-tiered match threshold criteria may be used: "definite match" (no human intervention) and "presumptive match" (requires further verification); response quality determines which thresholds met | RULE | ST-146, ST-057, ST-082, ST-088, ST-093 | Match threshold rule |
| ST-173 | Match quality values can be composite data structures, numerical, ontological, etc., and would be implementation-configurable | RULE | ST-172, ST-057 | Match quality flexibility |
| ST-174 | Data types on attributes in the model are only indicative; implementations should use ISO 21090 data types | REQUIREMENT_COMPLIANCE | ST-068, ST-070, ST-072, ST-074, ST-076, ST-077 | ISO 21090 reference |
| ST-175 | Identifiers included at all levels to allow unique identification as needed; may not be required on several classes for implementation | RULE | ST-068, ST-070, ST-072, ST-074, ST-076 | Identifier optionality |
| ST-176 | "Identifying information" is any set of attributes (partially populated semantic signifier) used singly or together to identify an entity; "Identifier" is a data item providing unique identification | DOMAIN_CONCEPT | ST-003, ST-037, ST-076 | Identifying info vs. identifier distinction |
| ST-177 | Explicit versionIds included in meta-model and function inputs/outputs for control classes; should be optional with "current" as default | RULE | ST-068, ST-070, ST-074, ST-076 | Versioning default behavior |
| ST-178 | PolicyDomain and EntityType Identifiers (id) can be considered optional at implementation level, conditional on IS scope; not directly indicated in operation descriptions | RULE | ST-068, ST-070, ST-034, ST-035 | Conditional optionality of metadata IDs |
| ST-179 | Interfaces defined on basis of XIS managing multiple Policy Domains and multiple Entity Types; relatively easy to subsequently constrain for simpler IS | RULE | ST-035, ST-025, ST-039 | XIS-first design approach |
| ST-180 | In several scenarios, Policy Domains and Entity Types must be supported by explicit definitions of issuing Authority Attributes (name, id, etc.) | RULE | ST-068, ST-070, ST-031 | Authority attribute requirement |
| ST-181 | Look up a patient (single entry found): Clarence searches HIS, finds Adam via IS, locates encounter | WORKFLOW | ST-046, ST-182, ST-146 | Scenario: single match lookup |
| ST-182 | HIS -> IS: Find Identity by Properties (Person, Adam) -- returns single Adam | OPERATION | ST-181, ST-146 | Scenario step: search |
| ST-183 | Look up a patient (multiple entries found): Carol searches, finds several matches with quality attribute, narrows down with additional criteria | WORKFLOW | ST-046, ST-184, ST-057 | Scenario: multi-match lookup |
| ST-184 | HIS -> IS: Find Identity by Properties (Person, Adam, Age, Address) -- returns shorter list | OPERATION | ST-183, ST-146 | Scenario step: refined search |
| ST-185 | Merged entries found for an Identifier: Bill uses merged identifier, IS returns indication of merge with main active identifier | WORKFLOW | ST-046, ST-186, ST-140, ST-141 | Scenario: merged identity redirect |
| ST-186 | HIS -> IS: Get All Information For Identity (Person, Adam Identifier) -- returns merged identifier | OPERATION | ST-185, ST-140 | Scenario step: get info on merged |
| ST-187 | Unattended encounter: referral system receives HL7 message, patient unknown, passes info to IS; four possible responses | WORKFLOW | ST-046, ST-188, ST-189, ST-190, ST-191 | Scenario: automated matching |
| ST-188 | IS Response #1: IS finds matching entry, returns identifier; referral system completes processing | WORKFLOW | ST-187, ST-146 | Scenario outcome: definite match |
| ST-189 | IS Response #2: IS finds multiple matches, none meeting criteria for complete match; returns list with quality attribute; user must determine correct identifier | WORKFLOW | ST-187, ST-146, ST-057 | Scenario outcome: presumptive matches |
| ST-190 | IS Response #3: IS finds no matches; referral system requests new identifier creation; IS creates and returns it | WORKFLOW | ST-187, ST-088 | Scenario outcome: auto-create |
| ST-191 | IS Response #4: IS finds no matches; referral system configured to await user instruction | WORKFLOW | ST-187 | Scenario outcome: manual fallback |
| ST-192 | Remove entity from system: Carol created pseudo-record for testing, finds and removes it, permanently purges record | WORKFLOW | ST-046, ST-193, ST-133 | Scenario: permanent removal |
| ST-193 | HIS -> IS: Remove Identity (Person, EntityID) -- record purged; kept for audit trail but not findable from IS | OPERATION | ST-192, ST-133 | Scenario step: remove |
| ST-194 | Though removed record may be kept for audit trail purposes, nobody can find it from IS | RULE | ST-192, ST-193, ST-133 | Audit retention after removal |
| ST-195 | Multiple Policy Domain Scenarios: Solar System Healthcare with 4 regions (East, West, North, South), hospitals Jupiter, Orion, Moon, Good Health; Solar System operates master national XIS | WORKFLOW | ST-046, ST-035, ST-068 | Scenario context: multi-domain |
| ST-196 | Look up patient across regional network: Adam admitted at Jupiter, not found locally; search passed to RHIO network; found at Good Health Hospital; identifier returned | WORKFLOW | ST-195, ST-197, ST-146 | Scenario: cross-domain search |
| ST-197 | IS_Orion -> XIS_RHIO -> IS_Various: Find Identity By Property (Person, Adam); returns Adam from Hospital Moon | OPERATION | ST-196, ST-146 | Scenario step: federated search |
| ST-198 | Look up patient specifying specific external organization: Eve admitted at Level Seven, known at Good Health; IS contacts RHIO specifically requesting search at Good Health IS | WORKFLOW | ST-195, ST-199, ST-146 | Scenario: directed cross-domain search |
| ST-199 | IS_Moon -> XIS_RHIO -> IS_Orion: Find Identity By Property (Person, Eve, Orion) -- directed at specific organization | OPERATION | ST-198, ST-146 | Scenario step: directed search |
| ST-200 | Link entities across regions: Adam found in East region via national XIS; new identifier created in North region; link created in master XIS to tie regional identifier to master | WORKFLOW | ST-195, ST-201, ST-121, ST-082 | Scenario: cross-domain link |
| ST-201 | IS_North: Register Identity then Link Identity via XIS_SolarSystem -- creates local ID and links to master | OPERATION | ST-200, ST-082, ST-121 | Scenario step: register and link |
| ST-202 | Scenarios are non-normative about conformance to the IS Standard; offered for explanatory purposes only | RULE | ST-048, ST-052, ST-056, ST-059, ST-062, ST-064, ST-181, ST-183, ST-185, ST-187, ST-192, ST-195, ST-196, ST-198, ST-200 | Non-normative status of Section 3 |
| ST-203 | Only the IS contract (Section 4, Detailed Functional Model) defines the limits of service usage | RULE | ST-202, ST-025, ST-026, ST-027 | Normative authority of Section 4 |
| ST-204 | Additional interfaces may be defined in technical specifications for system or administrative functionality such as Service Management and/or Metadata Management | RULE | ST-025, ST-026, ST-027 | Additional interfaces possible |
| ST-205 | Two-tiered match: "definite match" not requiring human intervention, "presumptive match" requiring further verification | DOMAIN_CONCEPT | ST-172, ST-057, ST-146 | Enumeration: match tiers |
| ST-206 | CIS -- Clinical Information Systems | DOMAIN_CONCEPT | ST-045 | Glossary term |
| ST-207 | MPI / EMPI -- (Enterprise) Master Patient Index; application system providing capabilities to find and cross-reference patients; likely most common system for providing IS interfaces | DOMAIN_CONCEPT | ST-001, ST-045 | Glossary term |
| ST-208 | Property (Trait) -- characteristic or attribute of an Entity used to identify Entities; no guarantee of uniqueness unless explicitly defined as Identifier | DOMAIN_CONCEPT | ST-003, ST-176 | Glossary term |
| ST-209 | Real World Entity (RWE) -- the actual thing itself; specification takes no position about physical reality; can be result of relationship or performative utterance; any identifiable object an IS can manage | DOMAIN_CONCEPT | ST-002, ST-076 | Glossary term |
| ST-210 | Source -- the originator of a request to IS, which may be a system or organization; may allocate its own local identifier for entities | STAKEHOLDER | ST-041, ST-037 | Inferred from operation descriptions |
| ST-211 | Service Metadata -- set of data items delineating scope and coverage of IS, including PolicyDomains, Class Definitions, and Semantic Signifiers supported | DOMAIN_CONCEPT | ST-068, ST-070, ST-003 | Glossary term |
| ST-212 | Registration Clerk -- hospital staff responsible for patient admission and identity management | STAKEHOLDER | ST-046, ST-067 | Inferred from ST-046 |
| ST-213 | Clinical User -- nurse, lab clerk, or other clinical staff using IS for patient lookup | STAKEHOLDER | ST-046, ST-181, ST-185 | Inferred from scenarios |
| ST-214 | Identity Resolution Clerk -- specialized role for merge/link/unlink/unmerge escalation | STAKEHOLDER | ST-067, ST-212 | Inferred from ST-067 |
| ST-215 | IS Administrator -- user with elevated privileges for removal and administration operations | STAKEHOLDER | ST-139, ST-061, ST-067 | Inferred from ST-139 and ST-061 |
| ST-216 | External System -- system outside the IS domain (e.g., referral system) that interacts with IS | STAKEHOLDER | ST-187, ST-210 | Inferred from scenarios |
| ST-217 | Future versions may allow additional layers providing hierarchical classification scheme for EntityConcept (recursive relationship) -- not included in this version | RULE | ST-072, ST-073 | Future extension note |
| ST-218 | Reasons may be codified; left to technical specification (applies to Merge, Unmerge, Link, Unlink, Update Identity State) | RULE | ST-107, ST-115, ST-121, ST-129, ST-099, ST-169 | Reason codification delegation |
| ST-219 | versionId representation: explicitly intended to be delegated to implementation-dependent version concept, with default flattening to string | RULE | ST-068, ST-177 | Versioning representation delegation |
| ST-220 | LinkTypeCode -- code indicating link type (link vs. merge) | DOMAIN_CONCEPT | ST-077, ST-079 | Enumeration type |
| ST-221 | LinkMethodCode -- code indicating method by which link was made | DOMAIN_CONCEPT | ST-077, ST-081 | Enumeration type |
| ST-222 | statusCode -- code for entity/metadata status values | DOMAIN_CONCEPT | ST-068, ST-070, ST-074, ST-076, ST-105 | Enumeration type |

---

## Artifact 2: Cross-Reference Map

```
ST-001 (CAPABILITY: Identification Service - manage and retrieve identifying info)
├── realizes ST-009 (CAPABILITY: uniquely identify entities within/across enterprises)
│   ├── realizes ST-010 (CAPABILITY: resolve demographics to unique identifier)
│   ├── realizes ST-011 (CAPABILITY: standard interface for clinical systems)
│   ├── realizes ST-013 (CAPABILITY: common thread for indexing entity data)
│   └── realizes ST-014 (CAPABILITY: search, retrieve, manage entity data)
├── realizes ST-015 (CAPABILITY: manage identities with arbitrary information structures)
├── realizes ST-017 (CAPABILITY: manage wide variety of Entity Types)
│   └── constrained by ST-018 (REQUIREMENT_FUNCTIONAL: explicitly allow identification of different entity types)
├── realizes ST-019 (CAPABILITY: multiple Policy Domains and Entity Types)
├── involves ST-002 (DOMAIN_CONCEPT: Entity)
│   ├── describes ST-023 (DOMAIN_CONCEPT: entity-or-entity-in-role convention)
│   ├── describes ST-005 (DOMAIN_CONCEPT: Role distinctions)
│   │   └── constrained by ST-006 (RULE: roles in Semantic Signifier per policy/law)
│   └── describes ST-209 (DOMAIN_CONCEPT: Real World Entity)
├── involves ST-003 (DOMAIN_CONCEPT: Semantic Signifier)
│   ├── describes ST-016 (DOMAIN_CONCEPT: EntityType-SemanticSignifier relationship)
│   ├── describes ST-176 (DOMAIN_CONCEPT: identifying info vs. identifier)
│   ├── describes ST-208 (DOMAIN_CONCEPT: Property/Trait)
│   └── constrained by ST-170 (REQUIREMENT_FUNCTIONAL: discoverability of signifiers)
├── involves ST-004 (CAPABILITY: standalone and composable foundation component)
├── constrained by ST-007 (RULE: service-space independence)
│   └── describes ST-008 (RULE: SOA abstraction principle)
├── constrained by ST-029 (RULE: source-of-record neutrality)
│   └── describes ST-042 (RULE: implementation choice)
├── constrained by ST-041 (RULE: topology flexibility)
├── constrained by ST-168 (RULE: demographic focus vs. generic structure)
├── constrained by ST-171 (RULE: security delegation)
└── constrained by ST-174 (REQUIREMENT_COMPLIANCE: ISO 21090 data types)

ST-025 (DOMAIN_CONCEPT: Two interfaces - Management and Query)
├── describes ST-026 (CAPABILITY: Identification Management)
│   ├── realizes ST-082 (OPERATION: Register an Identity)
│   │   ├── requires ST-083 (DATA_STRUCTURE: Register inputs)
│   │   ├── produces ST-084 (DATA_STRUCTURE: Register outputs)
│   │   ├── constrained by ST-085 (RULE: postcondition - identity registered)
│   │   ├── constrained by ST-086 (RULE: exception conditions)
│   │   └── constrained by ST-087 (RULE: automated implicit linking)
│   ├── realizes ST-088 (OPERATION: Create an Identity)
│   │   ├── requires ST-089 (DATA_STRUCTURE: Create inputs)
│   │   ├── produces ST-090 (DATA_STRUCTURE: Create outputs)
│   │   ├── involves ST-091 (DOMAIN_CONCEPT: IS Id)
│   │   └── constrained by ST-092 (RULE: exception conditions)
│   ├── realizes ST-093 (OPERATION: Update Identity Property Values)
│   │   ├── constrained by ST-094 (RULE: precondition - identity exists)
│   │   ├── requires ST-095 (DATA_STRUCTURE: Update inputs)
│   │   │   └── describes ST-096 (DATA_STRUCTURE: UpdateQualifier)
│   │   ├── produces ST-097 (DATA_STRUCTURE: Update outputs)
│   │   └── constrained by ST-098 (RULE: exception conditions)
│   ├── realizes ST-099 (OPERATION: Update Identity State)
│   │   ├── constrained by ST-100 (RULE: precondition - appropriate state)
│   │   ├── requires ST-101 (DATA_STRUCTURE: State inputs)
│   │   ├── constrained by ST-102 (RULE: invariant - only state changes)
│   │   ├── constrained by ST-103 (RULE: postcondition - state changed)
│   │   ├── constrained by ST-104 (RULE: exception conditions)
│   │   ├── constrained by ST-105 (RULE: minimum state model)
│   │   └── constrained by ST-106 (RULE: state model extensibility)
│   ├── realizes ST-107 (OPERATION: Merge Identities)
│   │   ├── constrained by ST-108 (RULE: single PolicyDomain only)
│   │   ├── constrained by ST-109 (RULE: same EntityType/EntityConcept)
│   │   ├── constrained by ST-110 (RULE: attribute resolution)
│   │   ├── requires ST-111 (REQUIREMENT_FUNCTIONAL: merge indication)
│   │   ├── constrained by ST-112 (RULE: preconditions)
│   │   ├── requires ST-113 (DATA_STRUCTURE: Merge inputs)
│   │   └── constrained by ST-114 (RULE: exception conditions)
│   ├── realizes ST-115 (OPERATION: Unmerge Identities)
│   │   ├── constrained by ST-116 (RULE: unmerge behavior)
│   │   ├── constrained by ST-117 (RULE: precondition - previous merge)
│   │   ├── requires ST-118 (DATA_STRUCTURE: Unmerge inputs)
│   │   ├── constrained by ST-119 (RULE: exception conditions)
│   │   └── constrained by ST-120 (RULE: post-unmerge manual intervention)
│   ├── realizes ST-121 (OPERATION: Link Identities)
│   │   ├── constrained by ST-122 (RULE: preconditions)
│   │   ├── requires ST-123 (DATA_STRUCTURE: Link inputs)
│   │   ├── constrained by ST-124 (RULE: postcondition)
│   │   ├── constrained by ST-125 (RULE: exception conditions)
│   │   ├── constrained by ST-126 (RULE: cross-type linking allowed)
│   │   ├── constrained by ST-127 (RULE: cross-domain topology)
│   │   └── constrained by ST-128 (RULE: implicit linking trigger)
│   ├── realizes ST-129 (OPERATION: Unlink Identity)
│   │   ├── constrained by ST-130 (RULE: preconditions)
│   │   ├── requires ST-131 (DATA_STRUCTURE: Unlink inputs)
│   │   └── constrained by ST-132 (RULE: exception conditions)
│   └── realizes ST-133 (OPERATION: Remove an Identity Instance)
│       ├── constrained by ST-134 (RULE: preconditions)
│       ├── requires ST-135 (DATA_STRUCTURE: Remove inputs)
│       ├── constrained by ST-136 (RULE: exception conditions)
│       ├── constrained by ST-137 (RULE: identifier reuse policy)
│       ├── constrained by ST-138 (RULE: default no reuse)
│       └── constrained by ST-139 (RULE: privilege restriction)
├── describes ST-027 (CAPABILITY: Query)
│   ├── realizes ST-140 (OPERATION: Get All Information for an Identity)
│   │   ├── constrained by ST-141 (RULE: merged identity redirect)
│   │   ├── requires ST-142 (DATA_STRUCTURE: Get All Info inputs)
│   │   ├── produces ST-143 (DATA_STRUCTURE: Get All Info outputs)
│   │   ├── constrained by ST-144 (RULE: invariant - identity unchanged)
│   │   └── constrained by ST-145 (RULE: exception conditions)
│   ├── realizes ST-146 (OPERATION: Find Identities by Property)
│   │   ├── requires ST-147 (DATA_STRUCTURE: Find inputs)
│   │   ├── produces ST-148 (DATA_STRUCTURE: Find outputs)
│   │   └── constrained by ST-149 (RULE: exception conditions)
│   ├── realizes ST-150 (OPERATION: List Linked Identities)
│   │   ├── constrained by ST-151 (RULE: precondition)
│   │   ├── requires ST-152 (DATA_STRUCTURE: List Linked inputs)
│   │   ├── produces ST-153 (DATA_STRUCTURE: List Linked outputs)
│   │   └── constrained by ST-154 (RULE: exception conditions)
│   ├── realizes ST-155 (OPERATION: Request Identity Update Notifications)
│   │   ├── requires ST-156 (DATA_STRUCTURE: Request Notifications inputs)
│   │   ├── produces ST-157 (DATA_STRUCTURE: Request Notifications outputs)
│   │   ├── constrained by ST-158 (RULE: exception conditions)
│   │   └── constrained by ST-159 (RULE: subscription pattern)
│   ├── realizes ST-160 (OPERATION: Update Identity Notification Request)
│   │   ├── requires ST-161 (DATA_STRUCTURE: Update Notification inputs)
│   │   ├── produces ST-162 (DATA_STRUCTURE: Update Notification outputs)
│   │   └── constrained by ST-163 (RULE: exception conditions)
│   └── realizes ST-164 (OPERATION: Notify Identity Updates)
│       ├── constrained by ST-165 (RULE: preconditions)
│       ├── produces ST-166 (DATA_STRUCTURE: Notify outputs)
│       └── constrained by ST-167 (RULE: publication pattern)
└── constrained by ST-204 (RULE: additional interfaces possible)

ST-030 (DOMAIN_CONCEPT: Policy Domain definition)
├── describes ST-031 (DOMAIN_CONCEPT: issue control taxonomy)
├── describes ST-032 (DOMAIN_CONCEPT: usage sphere)
├── describes ST-033 (DOMAIN_CONCEPT: cross-domain ID reuse example)
├── describes ST-035 (DOMAIN_CONCEPT: IS vs. XIS distinction)
├── constrained by ST-034 (RULE: single-domain interaction)
├── realizes ST-068 (DATA_STRUCTURE: PolicyDomain class)
│   └── describes ST-069 (DATA_STRUCTURE: PolicyDomain attributes)
└── constrained by ST-180 (RULE: authority attributes)

ST-070 (DATA_STRUCTURE: EntityType class)
├── describes ST-071 (DOMAIN_CONCEPT: EntityType concept)
│   └── involves ST-073 (DOMAIN_CONCEPT: semantic bridging)
├── constrained by ST-021 (RULE: uniform interface)
├── constrained by ST-022 (RULE: separation of concerns)
├── constrained by ST-028 (RULE: specialization requirement)
└── constrained by ST-020 (RULE: delegation to tech spec)

ST-072 (DATA_STRUCTURE: EntityConcept class)
├── describes ST-073 (DOMAIN_CONCEPT: semantic bridging)
└── constrained by ST-217 (RULE: future hierarchical extension)

ST-074 (DATA_STRUCTURE: EntityTypeAssignment class)
└── describes ST-075 (DOMAIN_CONCEPT: domain-specific customization)

ST-076 (DATA_STRUCTURE: IdentityInstance class)
├── involves ST-091 (DOMAIN_CONCEPT: IS Id)
│   └── constrained by ST-043 (RULE: internal ID recommendation)
│       └── constrained by ST-044 (RULE: IS Id not in interface)
└── involves ST-077 (DATA_STRUCTURE: IdentityLink class)
    ├── describes ST-079 (DOMAIN_CONCEPT: link vs. merge types)
    ├── describes ST-080 (DOMAIN_CONCEPT: provenance)
    ├── describes ST-081 (DOMAIN_CONCEPT: link method)
    ├── constrained by ST-078 (RULE: link semantics and transitivity)
    └── constrained by ST-024 (RULE: secondary use for role linking)

ST-046 (STAKEHOLDER: Primary Actors)
├── involves ST-212 (STAKEHOLDER: Registration Clerk)
├── involves ST-213 (STAKEHOLDER: Clinical User)
├── involves ST-214 (STAKEHOLDER: Identity Resolution Clerk)
├── involves ST-215 (STAKEHOLDER: IS Administrator)
├── involves ST-216 (STAKEHOLDER: External System)
└── involves ST-210 (STAKEHOLDER: Source)

ST-047 (WORKFLOW: Single-domain scenario context)
├── realizes ST-048 (WORKFLOW: Create a new patient)
│   ├── involves ST-049 (OPERATION: search - no result)
│   ├── involves ST-050 (OPERATION: broader search - no result)
│   └── involves ST-051 (OPERATION: register identity)
├── realizes ST-052 (WORKFLOW: Link or Merge entities)
│   ├── constrained by ST-053 (RULE: policy-driven merge vs. link)
│   ├── involves ST-054 (OPERATION: link identities)
│   └── involves ST-055 (OPERATION: merge identities)
├── realizes ST-056 (WORKFLOW: Update demographics)
│   ├── involves ST-057 (DOMAIN_CONCEPT: match quality)
│   └── involves ST-058 (OPERATION: update properties)
├── realizes ST-059 (WORKFLOW: Inactivate entity)
│   ├── involves ST-060 (OPERATION: update status inactive)
│   └── constrained by ST-061 (RULE: inactive still findable by admin)
├── realizes ST-062 (WORKFLOW: Activate entity)
│   └── involves ST-063 (OPERATION: update status active)
├── realizes ST-064 (WORKFLOW: Unlink/Unmerge entity)
│   ├── involves ST-065 (OPERATION: list linked identities)
│   ├── involves ST-066 (OPERATION: unlink identity)
│   └── constrained by ST-067 (RULE: authorization policy)
├── realizes ST-181 (WORKFLOW: Lookup - single entry)
│   └── involves ST-182 (OPERATION: search - single result)
├── realizes ST-183 (WORKFLOW: Lookup - multiple entries)
│   └── involves ST-184 (OPERATION: refined search)
├── realizes ST-185 (WORKFLOW: Merged entries found)
│   └── involves ST-186 (OPERATION: get info on merged)
├── realizes ST-187 (WORKFLOW: Unattended encounter)
│   ├── realizes ST-188 (WORKFLOW: Response #1 - definite match)
│   ├── realizes ST-189 (WORKFLOW: Response #2 - presumptive matches)
│   ├── realizes ST-190 (WORKFLOW: Response #3 - auto-create)
│   └── realizes ST-191 (WORKFLOW: Response #4 - manual fallback)
└── realizes ST-192 (WORKFLOW: Remove entity)
    └── involves ST-193 (OPERATION: remove identity)
        └── constrained by ST-194 (RULE: audit retention)

ST-195 (WORKFLOW: Multi-domain scenario context)
├── realizes ST-196 (WORKFLOW: Lookup across regional network)
│   └── involves ST-197 (OPERATION: federated search)
├── realizes ST-198 (WORKFLOW: Lookup at specific organization)
│   └── involves ST-199 (OPERATION: directed search)
└── realizes ST-200 (WORKFLOW: Link across regions)
    └── involves ST-201 (OPERATION: register and link)

ST-202 (RULE: Scenarios are non-normative)
└── constrained by ST-203 (RULE: Section 4 is normative)

ST-045 (DOMAIN_CONCEPT: HIS)
├── describes ST-206 (DOMAIN_CONCEPT: CIS)
└── describes ST-207 (DOMAIN_CONCEPT: MPI/EMPI)

ST-096 (DATA_STRUCTURE: UpdateQualifier)
[standalone enumeration of update modes: OVERWRITE, VALUED, UNSPECIFIED]

ST-105 (RULE: Minimum state model)
├── constrained by ST-106 (RULE: state extensibility)
└── involves ST-222 (DOMAIN_CONCEPT: statusCode)

ST-172 (RULE: Two-tiered match threshold)
├── describes ST-205 (DOMAIN_CONCEPT: match tiers)
└── constrained by ST-173 (RULE: match quality flexibility)

ST-169 (RULE: Exception/info messages delegated to tech spec)
└── involves ST-218 (RULE: reason codification delegated)
    └── involves ST-219 (RULE: versioning representation delegated)

ST-175 (RULE: Identifier optionality at implementation)
[standalone - meta-model design note]

ST-177 (RULE: Versioning default behavior)
[standalone - meta-model design note]

ST-178 (RULE: Conditional optionality of metadata IDs)
├── constrained by ST-179 (RULE: XIS-first design)
└── involves ST-038 (RULE: IS/XIS similarity)
    └── constrained by ST-039 (RULE: profile-based constraining)
        └── describes ST-040 (RULE: implementation simplification)

ST-211 (DOMAIN_CONCEPT: Service Metadata)
[standalone glossary concept]

ST-220 (DOMAIN_CONCEPT: LinkTypeCode)
[standalone enumeration type]

ST-221 (DOMAIN_CONCEPT: LinkMethodCode)
[standalone enumeration type]
```

---

## Artifact 3: Ambiguity and Gap Report

### Ambiguities

- **AMB-001** (ST-168): "Functions are only intended to use demographic data" contradicts the broader statement that "this is NOT an enforced restriction" and that capabilities are defined for a "very generic information structure." **Interpretation A**: Only demographic data should be used. **Interpretation B**: Any data structure can be used; demographic focus is merely the expected default. **Recommended resolution**: Classify as non-binding guidance (Interpretation B), as the Semantic Signifier mechanism explicitly supports arbitrary structures. The word "intended" is descriptive, not prescriptive.

- **AMB-002** (ST-078, ST-126): Link semantics state that "linked items represent the same real-world entity" and "links are transitive by definition." However, ST-126 states that linking of entities of different EntityTypes is permitted even when they do NOT map to the same EntityConcept (unlike merge). If two linked entities represent the same RWE, how can they meaningfully be of unrelated EntityTypes? **Recommended resolution**: Interpret "same RWE" broadly -- linking across different EntityTypes is a secondary use case for organizational cross-referencing, not strict identity equivalence. Flag for clarification in the technical specification.

- **AMB-003** (ST-043, ST-044): The IS Id is "recommended" as an internal mediating identifier, but "not included in operation parameters." It is unclear whether the IS Id is a formal requirement or merely a design suggestion. **Recommended resolution**: Treat as a design recommendation that technical specifications may choose to surface or not.

- **AMB-004** (ST-105, ST-106): The minimum state model is "active" and "inactive", but the specification also states that "the definition and meaning of states is configurable and may vary depending on EntityType." This creates ambiguity about what minimum conformance requires. **Recommended resolution**: Treat "active" and "inactive" as the mandatory minimum; all other states are optional extensions.

- **AMB-005** (ST-082, ST-088): Register an Identity vs. Create an Identity are very similar operations. The only difference is whether the client supplies the identifier (Register) or the service generates it (Create). Both produce similar outputs and have similar preconditions. It is unclear when a client should prefer one over the other. **Recommended resolution**: Document both as distinct operations; the choice depends on whether the calling system manages its own identifier namespace.

- **AMB-006** (ST-036, ST-034): ST-034 states "any individual interaction with IS occurs with respect to one specific Policy Domain" but the Link Identities operation (ST-121) explicitly supports cross-domain linking. The "other than explicit linking across Policy Domains" exception is mentioned but creates ambiguity about whether other operations (e.g., Find Identities by Property with multiple PolicyDomain Ids in ST-147) also operate across domains. **Recommended resolution**: Interpret ST-034 as applying to management operations other than Link; query operations (Find by Property) can span multiple domains per their explicit input definitions.

- **AMB-007** (ST-110): "Identifying attributes in the target that are empty are filled from the source, and existing attributes in the target remain AS-IS" -- it is unclear what happens to attributes in the source that exist but are different from the target. Are they preserved in the deprecated source record, lost, or merged? **Recommended resolution**: Assume attributes remain in the deprecated source record unchanged; only empty target attributes are filled. The surviving target record is the authoritative one.

- **AMB-008** (ST-064, ST-115): The unlink and unmerge scenarios both involve separating previously connected identities. The specification describes unlink for linked entities and unmerge for merged entities, but the scenario in ST-064 mentions both "unlink" and "unmerge" in the heading. The narrative describes an unlink, not an unmerge. **Recommended resolution**: Treat the section heading as a combined reference; the actual scenario illustrates unlink only. Unmerge is a separate operation described in ST-115.

- **AMB-009** (ST-172, ST-173): Match quality values can be "composite data structures, numerical, ontological, etc." -- this is extremely open-ended. It is unclear how interoperability is achieved if match quality is implementation-configurable with no standard representation. **Recommended resolution**: Document as a known interoperability concern. Technical specifications must define a concrete representation.

### Gaps

- **GAP-001**: **No security model defined.** ST-171 explicitly delegates security to a "separate infrastructure." No authentication, authorization, role-based access control, or audit logging requirements are specified. The statement that there is "an assumed precondition on all operations that the caller is appropriately authenticated" provides no testable criterion. This is acknowledged by the specification as intentional but creates a significant gap for downstream modeling.

- **GAP-002**: **No quantified quality-of-service requirements.** No statements address response time, throughput, availability, scalability, or capacity. The specification mentions "high-throughput interface" only as an implementation consideration example (ST-041 context), not as a requirement. There are no REQUIREMENT_QUALITY entries in the classification.

- **GAP-003**: **No error handling protocol.** ST-169 states that "the means for returning informational and exception messages is left to Technical Specifications." While exception conditions are listed for each operation, no error format, error code scheme, or error recovery procedure is defined.

- **GAP-004**: **No state machine defined.** ST-105 and ST-106 describe a minimum state model (active/inactive) but no formal state machine with transitions, guards, and actions. The specification explicitly states that status code sets are "undefined in this specification" and "left to the technical specification."

- **GAP-005**: **No batch/bulk operation support.** All operations are defined for single identity instances. No operations exist for batch registration, batch update, batch search, or bulk merge/link operations, which would be essential for large-scale migration or data loading scenarios.

- **GAP-006**: **No concurrency model.** No statements address concurrent access, locking, optimistic concurrency, or conflict resolution when multiple clients attempt to modify the same identity simultaneously.

- **GAP-007**: **No data retention or purge policy.** ST-194 mentions that removed records "may be kept for audit trail purposes" but no retention period, purge schedule, or archival requirements are defined.

- **GAP-008**: **No metadata lifecycle operations.** While PolicyDomain and EntityType are defined in the meta-model (ST-068, ST-070), no CRUD operations are defined for creating, updating, or deleting PolicyDomains or EntityTypes. ST-204 notes that "additional interfaces may be defined in technical specifications for Metadata Management" but these are not part of this specification.

- **GAP-009**: **No notification delivery mechanism.** ST-155 through ST-167 define a subscription/notification pattern but provide no details on delivery mechanism (push vs. pull), guaranteed delivery, ordering, retry, or failure handling. ST-159 and ST-167 note it "could be implemented using publish-and-subscribe" but this is not specified.

- **GAP-010**: **No data validation rules specified.** While EntityType includes a "validationRuleSet" attribute (ST-070) and EntityTypeAssignment allows "constrainedValidationRuleSet" (ST-074), no actual validation rules are specified. The semantics of validation (when it occurs, what happens on failure beyond exception) are left entirely to technical specifications.

- **GAP-011**: **No explicit conformance criteria.** The specification does not define conformance levels, mandatory vs. optional operations, or minimum implementation requirements beyond the IS/XIS distinction. The statement about profiles (ST-039, ST-040) is the only mechanism mentioned for constraining the specification.

- **GAP-012**: **LinkTypeCode and LinkMethodCode value sets undefined.** ST-220 and ST-221 reference code types but no enumerated values are provided in the specification. These are implicitly delegated to technical specifications or profiles.

- **GAP-013**: **No explicit stakeholder responsibilities table.** While actors are identified in scenarios (ST-046) and roles are implied (ST-067, ST-139, ST-212-ST-216), no formal RACI or responsibility matrix exists defining which stakeholders may perform which operations.

- **GAP-014**: **No versioning conflict resolution.** ST-177 notes that versionIds are included in the meta-model and operations, but no strategy is defined for handling version conflicts (e.g., what happens when a client supplies an outdated versionId).

- **GAP-015**: **Unmerge postconditions empty.** ST-115 has empty postconditions, meaning the specification does not formally state what system state results from an unmerge beyond the behavioral description in ST-116. Similarly, Unlink (ST-129) and Remove (ST-133) have empty postconditions.

- **GAP-016**: **No internationalization requirements beyond language attributes.** PolicyDomain includes languageSupported and defaultLanguageId (ST-069), but no requirements for character encoding, locale-specific matching, transliteration, or name normalization are specified.

- **GAP-017**: **Search algorithm not specified.** ST-147 includes "Matching algorithm" as an optional search qualifier, but no standard matching algorithms are defined or even enumerated. The effectiveness of the core identity resolution function depends entirely on implementation choices.

---

## Summary Statistics

| Category | Count |
|---|---|
| DOMAIN_CONCEPT | 42 |
| RULE | 74 |
| CAPABILITY | 15 |
| OPERATION | 30 |
| DATA_STRUCTURE | 30 |
| WORKFLOW | 21 |
| REQUIREMENT_FUNCTIONAL | 4 |
| REQUIREMENT_COMPLIANCE | 1 |
| STAKEHOLDER | 6 |
| REQUIREMENT_QUALITY | 0 |
| UNCLEAR | 0 |
| **Total Statements** | **222** |
| **Ambiguities** | **9** |
| **Gaps** | **17** |

### Key Observations

1. **Heavy delegation pattern**: The IS SFM systematically delegates security (GAP-001), error handling (GAP-003), state models (GAP-004), data types (ST-174), matching algorithms (GAP-017), and metadata management (GAP-008) to "Technical Specifications." This is by design in the HL7 HSSP framework and should NOT be treated as a specification defect, but must be documented for downstream agents.

2. **No quality requirements**: The complete absence of REQUIREMENT_QUALITY entries (GAP-002) is notable. This is typical of HL7 SFMs which focus on functional behavior at the CIM level.

3. **Rule-heavy specification**: 74 of 222 statements (33%) are rules -- preconditions, postconditions, exception conditions, invariants, and business constraints. This is characteristic of a well-defined service contract.

4. **Normative vs. non-normative**: Section 3 (Business Scenarios) is explicitly non-normative (ST-202). Section 4 (Detailed Functional Model) is the normative core (ST-203). Downstream agents should prioritize Section 4 material.

5. **Meta-model provides structural foundation**: The six meta-model classes (PolicyDomain, EntityConcept, EntityType, EntityTypeAssignment, IdentityInstance, IdentityLink) and their relationships define the complete domain ontology. The operations are behaviors over this model.

6. **IS vs. XIS duality**: The specification is written from the XIS (cross-domain) perspective as a superset. Single-domain IS implementations constrain via profiles. This creates a pervasive conditional optionality pattern for PolicyDomain-related parameters.
