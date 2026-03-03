package CIM_IS {

    package CIM_Requirements {

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
}
