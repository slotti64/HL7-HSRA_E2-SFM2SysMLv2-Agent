package FHIR_R5_Base {

    doc /* Lightweight FHIR R5 base type stub for PSM SysML packages.
         Covers common base types and frequently needed healthcare resource types.
         Add domain-specific resource types (e.g. MedicationRequest, Observation)
         here when a new PSM service domain requires them — keep one canonical stub. */

    // ── Foundational types ──────────────────────────────────────────────────

    item def FHIRResource {
        attribute id : String;
        attribute resourceType : String;
        attribute meta : String;
    }

    item def FHIRElement;

    item def FHIRExtension {
        attribute url : String;
        attribute valueString : String;
        attribute valueCode : String;
        attribute valueBoolean : Boolean;
    }

    item def FHIRIdentifier {
        attribute system : String;
        attribute value : String;
        attribute use : String;
        attribute period : FHIRPeriod;
    }

    item def FHIRReference {
        attribute reference : String;
        attribute type : String;
        attribute display : String;
    }

    item def FHIRCodeableConcept {
        attribute coding : String;
        attribute text : String;
    }

    item def FHIRPeriod {
        attribute start : String;
        attribute end : String;
    }

    item def FHIRHumanName {
        attribute family : String;
        attribute given : String;
        attribute prefix : String;
        attribute suffix : String;
        attribute use : String;
        attribute period : FHIRPeriod;
    }

    item def FHIRAddress {
        attribute line : String;
        attribute city : String;
        attribute state : String;
        attribute postalCode : String;
        attribute country : String;
        attribute use : String;
        attribute period : FHIRPeriod;
    }

    item def FHIRContactPoint {
        attribute system : String;
        attribute value : String;
        attribute use : String;
        attribute rank : Integer;
    }

    // ── Infrastructure resources ─────────────────────────────────────────────

    item def Bundle :> FHIRResource {
        doc /* Used as response type for search results, batch operations, and workflow outputs */
        attribute type : String;
        attribute total : Integer;
        attribute timestamp : String;
    }

    item def Task :> FHIRResource {
        doc /* Used for Task-based workflow patterns for multi-step behavioral flows */
        attribute status : String;
        attribute intent : String;
        attribute code : FHIRCodeableConcept;
        attribute focus : FHIRReference;
        attribute for : FHIRReference;
        attribute authoredOn : String;
        attribute lastModified : String;
    }

    item def Parameters :> FHIRResource {
        doc /* Used as request/response type for $operations */
    }

    item def OperationOutcome :> FHIRResource {
        doc /* Used as fault/error response type across all interactions */
        attribute issue : String;
    }

    item def Subscription :> FHIRResource {
        doc /* Used for event-driven notification subscriptions */
        attribute status : String;
        attribute topic : String;
        attribute channel : String;
        attribute end : String;
    }

    item def SubscriptionTopic :> FHIRResource {
        doc /* Used for defining triggering criteria for Subscriptions (FHIR R5) */
        attribute url : String;
        attribute title : String;
        attribute status : String;
        attribute description : String;
        attribute resourceTrigger : String;
    }

    // ── Common healthcare domain resources ───────────────────────────────────

    item def Patient :> FHIRResource {
        doc /* Person-like entity that is the subject of healthcare services */
        attribute active : Boolean;
        attribute name : FHIRHumanName;
        attribute identifier[0..*] : FHIRIdentifier;
        attribute birthDate : String;
        attribute gender : String;
        attribute address : FHIRAddress;
        attribute telecom : FHIRContactPoint;
        attribute managingOrganization : FHIRReference;
        attribute link : FHIRReference;
    }

    item def Person :> FHIRResource {
        doc /* Cross-domain abstract individual — links Patient/Practitioner/RelatedPerson records */
        attribute active : Boolean;
        attribute name : FHIRHumanName;
        attribute identifier[0..*] : FHIRIdentifier;
        attribute birthDate : String;
        attribute gender : String;
        attribute address : FHIRAddress;
        attribute telecom : FHIRContactPoint;
        attribute link : FHIRReference;
    }

    item def Organization :> FHIRResource {
        doc /* Organizational boundary, domain authority, or institutional entity */
        attribute active : Boolean;
        attribute name : String;
        attribute identifier[0..*] : FHIRIdentifier;
        attribute type : FHIRCodeableConcept;
        attribute address : FHIRAddress;
        attribute telecom : FHIRContactPoint;
        attribute partOf : FHIRReference;
    }

    item def Linkage :> FHIRResource {
        doc /* Explicit linking relationship between resource instances across systems */
        attribute active : Boolean;
        attribute author : FHIRReference;
        // item[0..*]: each with type (source|alternate|historical) + resource FHIRReference
    }

    item def Basic :> FHIRResource {
        doc /* Catch-all for domain-specific concepts with no direct FHIR R5 resource match.
             Use with custom extensions and flag as CUSTOM in mapping quality report. */
        attribute code : FHIRCodeableConcept;
        attribute subject : FHIRReference;
        attribute author : FHIRReference;
        attribute created : String;
    }

}
