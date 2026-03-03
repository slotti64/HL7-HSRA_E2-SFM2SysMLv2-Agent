package PIM_IS {

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
}
