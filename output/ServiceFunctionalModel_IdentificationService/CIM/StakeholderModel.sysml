package CIM_IS {

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
}
