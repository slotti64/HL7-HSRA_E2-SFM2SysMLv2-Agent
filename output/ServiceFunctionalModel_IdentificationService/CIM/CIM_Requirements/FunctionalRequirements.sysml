package CIM_IS {

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
    }
}
