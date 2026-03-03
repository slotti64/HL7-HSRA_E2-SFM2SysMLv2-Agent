C:\Users\slotti\AppData\Local\Programs\Python\Python312\Lib\site-packages\pydub\utils.py:170: RuntimeWarning: Couldn't find ffmpeg or avconv - defaulting to ffmpeg, but may not work
  warn("Couldn't find ffmpeg or avconv - defaulting to ffmpeg, but may not work", RuntimeWarning)
Service Functional Model Specification Section

Identification Service (IS)

# Introduction

The purpose of an HL7 SFM is to identify and document the functional requirements of services important to healthcare. Accordingly, this SFM seeks to define the functional requirements of an Identification Service (IS), which provides a set of capabilities to manage and retrieve identifying information for various kinds of entities (people, organizations, devices, etc.).

IS provides an important foundation component for many healthcare interoperability scenarios, both within and across organizations. Although it can be used in many business scenarios alongside other services, it has been designed to provide standalone capabilities.

Note that the term "Entity" is used in this specification to refer to any "concept" or "thing" that may be identifiable and for which there is a requirement to resolve identities. This covers "things" such as People and Devices, as well as concepts such as "roles" (Patient, Provider, etc.). Since the purpose of the service is purely identification of the "thing", any distinctions as to the nature of the thing are not important, other than obviously the actual data items used for that identification.

However, these aspects are often mandatory in a complete IS service implementation. In these scenarios, elements such as role, role definition, and role types (i.e., structural role and functional role) should be frequently considered in a Semantic Signifier specification, in accordance with organizational policy and/or jurisdictional law relevant to the Policy Domains managed by the IS implementation7.

IS explicitly occupies the *service space* within an information processing environment. It is independent but compatible with underlying structures, including local security implementations, access control policy, data models, or delivery mechanisms. By separating and exposing those aspects that facilitate inter?organization workflows in a service layer, this specification abstracts the problem of interoperability away from underlying systems. This level of abstraction and reconfiguration enables interoperability and system durability while reducing burdensome technology integration.

As a consequence of its service-oriented approach, we can understand the relevance of the IS standard if we consider not only the specification in itself as a means to define the responsibility of an IS compliant system. We should consider the IS specification in a real enterprise service architecture where flexibility, adaptability, and governance are critical requirements.

# Service Overview and Business Case

## Service Description and Purpose

The Identification Service (IS) Functional Specification is charged with defining the functional specifications of a set of service interfaces to uniquely identify various kinds of entities (e.g., people, patients, providers, devices, and so on) within disparate systems within a single enterprise and/or across a set of collaborating enterprises.

This service is intended to allow for the resolution of demographics and other identifying characteristics (aka properties, aka traits) to a unique identifier. This allows any clinical system that uses the service to maintain a common description for each entity and to manage the entities. Having a standard interface for accessing and maintaining entity identification information allows systems and applications to have a consistent means of indexing data related to an entity.

The following paragraphs and sections discuss the usage of the service primarily with respect to patient identification, but similar functionality and scenarios are relevant to other entity types. The reason for concentrating on patients is both the familiarity and priority of the problem to a wide audience and also that initial profiles (defined in Section 5) will be defined that support patient related information.

A typical person undergoes in his/her lifetime a vast array of healthcare encounters. Increasingly the nature of the encounter involves understanding the past experience and treatment of the patient, particularly in the case of chronically ill patients and in dealing with the large number of specialists that a patient may encounter. An accurate lifetime health record is becoming increasingly important in the overall management of a patient's health. Also, throughout a person's lifetime he or she may have episodes of care provided by dozens or hundreds of healthcare providers, many of whom will assign and maintain patient IDs autonomously. In this arrangement, each organization or department often assigns its own ID that uniquely identifies the patient for its own purposes, resulting in ID values that are meaningless outside that system or organization. These autonomously managed IDs suit the purposes of recording and retrieval of service records for a single department or organization; however, there is no basis for efficient collection or correlation of health records among multiple venues or organizations.

The process of identification of a patient is well understood, so having a standard will improve the quality of care without compromising the role of innovation and discovery in healthcare. In addition to patients, providers and other entities or resources involved in patient care must also be uniquely and accurately identified.

To put it simply, the Identification and Cross-Reference Service provides the common thread by which entity data can be indexed. The unique identifier and standard way to search, retrieve and manage entity data will allow healthcare applications and healthcare enterprises to find, exchange and reference entity data while maintaining the data's context and associations.

## Scope of the Service

The Identification and Cross-Reference Service provides a robust and complete means for defining, updating and generally managing identities, along with an associated set of identifying information, which may be an arbitrarily simple or complex information structure. These sets may be anything from a single class with a set of attributes (or traits) up to a complex constrained information model with many classes. This information structure is referred to as a "semantic signifier". From a business perspective, this can be used to identify literally anything that someone wishes to manage identities for. There is no restriction from the perspective of the Service.

The semantic signifier effectively defines one representation of an Entity Type that is recognized and managed by an IS instance. The Identification and Cross-Reference Service is intended to allow the lookup and management of a wide variety of Entity Types, including, but not limited to, patients, individual providers, institutional providers, and medical devices. At the functional level, the service interface will explicitly allow identification of the different "types" of entities that may be supported. The scope of this functional specification covers both support for multiple Policy Domains (see Section 2.4.1) and multiple Entity Types. In both cases, it is left to the technical specifications to decide whether to define an implementation specific to one Entity Type and/or a single Policy Domain.

### Rationale

The main reason for defining this service at a more abstract entity level is that the interface functionality for identifying different kinds of entities is the same, and that some IS instances will be used to manage more than one type of entity. The information model varies in that different semantic signifiers (Entity Types) are used to search for the entities. The interfaces and capabilities defined in this specification are equally valid for patients, providers, devices and many other kinds of entities. From a technical or systems development perspective, this enables common frameworks and applications to be built and allows significant reuse. From a business perspective, this provides greater flexibility and allows the reclassification of entities and roles without changing the service interfaces.

It must be stressed that this characteristic of the IS service: by means of the Semantic Signifier mechanism, IS, as several HSSP services, promotes a clear separation of concerns between the behavioral aspect and information content. The behavioural structure is invariant across the different contents that the service can manage, both in terms of logical structure and concrete representation.

Theoretically, for example, with the semantic signifier mechanism, a single service implementation can "speak" at the same time in different concrete languages, and, more relevantly, can support the management of progressive information content evolution in a concrete architecture.

Furthermore, in many contexts, the distinction between "entities" (e.g., real things, such as people) and "entity playing a role" (entities that are contextually defined by relationships or performative utterance, such as patient, provider, wife, husband, member, customer, etc.) is significant11. However, with respect to identification, these distinctions are not significant in the context of service behavior.

The semantic signifier mechanism allows the specification and management of these aspects without affecting the behavioural structure of the identification services12.

The remainder of this specification will use the term entity to imply either an entity or an "entity in a role". A side effect of the abstract approach is that it would be feasible to use the "linking" functionality defined in this service as a means to link roles to the entity playing them. This, however, is not a primary use case or intention of the service.

The determination of the exact usage is dependent on the Semantic Profile (see Section 5) being used. From the point of view of the Service, there is no difference, i.e. the Service can be used to identify "people" or "patients" equally, depending upon which Semantic Profile is being used.

The scope of the service may also extend across multiple Policy Domains (see Section 2.4.1for further discussion).

## Structure of the Service

### Interfaces

This specification identifies two interfaces: Identification Management and Query.

* Identification Management provides capabilities for the manipulation of Identifiers and properties.
* Query provides read-only capabilities for retrieving Entity information.

Each of these interfaces and, where appropriate, their functional capabilities is described in Section 4 below.

This specification provides capabilities for managing identifiers for generic "Entities", so there will be a need to specialize the information model for specific types of Entity, such as "Person", "Patient", or "Provider".

## Assumptions and Dependencies

This specification does not constrain whether the IS interface is provided to an "authoritative" source of information or not. IS interfaces may hide such a master system, or they may be used just for registry purposes, while authoritative information is kept in other systems

### Use of Policy Domains and Identification and Cross-Reference Service vs. Cross Domain Identification and Cross-Reference Service

A key concept defined within this specification is the "Policy Domain"15. Within the context of this specification, this is defined as an "identity space" or "sphere of use" of entity identifiers. This may be universal, a realm or nation, a state or local authority, an individual organization or even a department within an organization.

Note that this is not necessarily the same as the actual sphere of "control" of the identifiers in terms of their issue. The sphere of issue control could be legal (e.g., government-issued identifiers), organizational (e.g., department, enterprise, cross-enterprise), geographical (e.g., regional, national, state) or even specific to one computer system.

The "sphere of use" is the set of organizations that wish to interoperate for a specific set of information. For example, a Social Security Number may be issued (and controlled) by a central federal authority. It can then be used as an identifier for "patient" in one Policy Domain, and used as an identifier of "employee" in another Policy Domain. In this case, the organization is "controlling the usage" of the identifier. The discussion in the remainder of this document focuses on the "usage" aspects only.

The Policy Domain manages identity usage across departments, organizations, or national realms. An individual IS instance could support multiple Policy Domains, but any individual interaction with an instance of IS always occurs with respect to one specific Policy Domain (other than explicit linking of entities across Policy Domains). Allowing a service instance to support multiple Policy Domains enables the right level of encapsulation or abstraction from organizational structure, software topology, and distribution. This seamless design characteristic is one of the primary benefits of a Service-Oriented Architecture.

However, it is quite feasible and reasonable to expect that some IS instances will only operate across one Policy Domain.

In addition to the IS capabilities of finding an entity based on identifying properties (a.k.a. semantic signifier) and the management of the entities and the properties, the XIS must also allow one or more Policy Domain-specific identifiers to be associated with an entity and provide the access and management capabilities for those local Policy Domain identifiers.

In this context, a local Domain Entity identifier is any identifier that has been allocated by an individual system or facility. Note that the facility or system itself would have issued its own unique identifier within the context of the XIS.

Where the distinction is relevant, the remainder of the document will use the terms as follows:

* IS – Identification Service that operates in a single domain only
* XIS – where multiple domains are recognized and managed.

In other sections, which refer to general capabilities of the specification or overall description, IS will be used.

## Implementation Considerations

Functionally, the interfaces for IS and XIS are similar; the only differences are that some metadata capabilities are specific to XIS instances and that some XIS capabilities can handle different Policy Domain values. It is a consideration for technical specifications and implementations of how to implement the Policy Domain concept for both XIS and single-domain IS instances. Since it defines the "super-set" of functionality, the inputs for all interfaces in this document are defined as if the implementation was a fully functioning XIS. Using profiles or otherwise, technical specifications may apply constraints to provide a subset of the functionality provided by more specific IS interfaces.

As well as considerations of Policy Domains, architects will need to consider the many approaches to providing the ability to resolve identifiers for different entity types, such as individual people, devices and facilities. For example, a priority requirement may be the need to provide a high-throughput interface that is specialized toward resolving entities that have a name and address. There may also be a need to make optimizations associated with population demographics. This could suggest special circumstances regarding nicknames, common roadway names, and geospatial issues that could benefit from special handling of the class of entities that contain people and facilities that may relocate of their own volition or change or abbreviate names.

The use of profiles is key in providing real implementations of this service. These are discussed in various sections within this document. It is important to note that for those wishing to implement a "simple" IS, e.g. basic identity resolution for Patients only, then this will be easy to do by applying constraints such as profiles.

As an interface specification, IS may be implemented and used in various topologies. It may be accessed directly via web or other User Interface (UI) mechanisms by users, or system-to-system via other applications such as Hospital Information Systems. This does not affect the interface or behavior specification.

Also, whether the implementation behind the IS interface is actually the source of record or just a separate indexing mechanism is again an implementation choice. However, it should be able to be trusted as an authoritative source, but again, this does not affect the interface or behavior.

One additional issue that needs to be addressed is the physical means for implementing and managing the linking of identities. The recommended approach is to use an internal ID (IS Id) to act as a "master" or "mediating" identifier to link associated identity records together18.. Usually, this internal identifier would not need to be surfaced, so it has not been included in the operation parameters for input or outputs, but technical specifications may choose to do so.

# Business Scenarios

All scenarios herein should be considered non-normative about conformance to the IS Standard. They are offered for explanatory purposes only.

However, the scenarios are useful for identifying and understanding the IS capabilities without imposing any limit on alternative business usage of the IS Service. Only the IS contract (see Section 4. Detailed Functional Model for each Interface) defines the limits of service usage. These scenarios are not intended to preclude different deployed instances, localization or extension.

Note that the term Hospital Information System (HIS) is used as a generic term for various different types of clinical systems, including Patient Administration Systems. The nature of the system acting as the IS client does not affect the service definition.

## Primary Actors

* Adam Everyman – a patient
* Robert (Bob) Smith – a patient
* Eric Entry – a hospital registration clerk
* Eve Everywoman - Patient (maiden name Evelyn Smith) Evelyn Smith – another patient who is not Eve Everywoman Carol Clerk – a hospital registration clerk
* Clarence Barton – a hospital pre-op nurse
* Nancy Nightingale – a discharge nurse
* Bill Beaker – a laboratory clerk

## Primary Scenarios

### Single Policy Domain Scenarios

The following scenarios describe a number of real-world activities around patient identity management in hospital Moon. The hospital uses a single Policy Domain to manage the patient identities. Medical records are administered by its Hospital Information System (HIS). The HIS actually manages the medical records and encounter information. An Identification Service (IS) manages and provides access to patient identities across all of the hospital's systems. (Note that the actual system providing the implementation of the service interface could be part of one of the clinical systems or a separate EMPI system). In the scenario descriptions, the term IS is used to represent both the service itself and the system that implements it. All other care information systems use the same Policy Domain to identify patients. Although the scenarios depict "patients" as the entity type, similar scenarios can be implied for other entity types, such as Providers or other resources. Although these have not necessarily been strung together to provide a single coherent storyline, it is fairly easy to see how some of them can be composed.

#### Create a new patient

@startuml

Actor Carol as Carol

Participant HIS as HIS

Participant IS as IS

Carol -> HIS: Search Adam

HIS -> IS : Find Identity By Property (Person, Name Address)

IS --> HIS : Return Empity List

HIS --> Carol: No Record Found

Carol -> HIS: Search Adam with Aditional Info

HIS -> IS : Find Identity By Property (Person, Adam, Old Address)

IS --> HIS : Return Empity List

HIS -> Carol: No Record Found

Carol -> HIS: Create New Patient

HIS -> IS: Register Identity (Person, ID, Adam)

IS --> HIS: Acnowledgement

HIS --> Carol: New Patient Registered

@enduml

Adam Everyman enters the hospital for outpatient surgery. When Adam arrives in admitting, Carol Clerk, a registration clerk, attempts to find Adam in the HIS using Adam's name and address. Adam is not found locally in the HIS, so the HIS uses the IS to try to locate Adam, but he is not found. Carol asks if Adam had ever been to the facility. Adam thinks he has, and Carol asks if he has moved. Adam gives Carol his old address, but Carol is still unable to locate Adam's information in the HIS or IS.

Carol Clerk treats Adam Everyman as a new patient in the facility and gathers all of Adam's demographic information. Adam's patient record has now been created in the HIS and appropriate identifying information is passed to the IS for the creation of a new entity. Adam has completed the admission process in the HIS, and an outpatient encounter has been created in the HIS.

#### Link (or Merge) entities

As Adam Everyman is checking out of the hospital, he once again provides his identity information to Nancy Nightingale, a discharged nurse. When she enters the information and searches for Adam in the HIS, she sees two entries that look very similar. Nancy asks Adam if he had ever lived at the address of the former record; when Adam responds positively, Nancy more carefully inspects the information and finds that it is actually another entry for Adam. Nancy selects both records and requests that the entries be linked. The HIS requests the IS to link the records, and the newer entity record becomes an alias for the older record.

Note: Depending on the hospital's patient information administration policy, Nancy Nightingale may instead request that the IS merge the two records and update some properties (e.g., the address) of the surviving record (which represents the resulting entity record of the merge capability). If the hospital chooses the merge capability to resolve duplicated entity records, the merged record becomes deprecated after the merge, and only the surviving record is used to identify the entity in the future.

##### Link Identities:

@startuml

Actor Nancy as Nancy

Participant HIS as HIS

Participant IS as IS

Nancy -> HIS: Search Adam

HIS -> IS : Find Identity By Property (Adam)

IS --> HIS : Return Person List incl. Two Adams

HIS --> Nancy: Return Person List incl. Two Adams

Nancy -> Nancy: Review List

Note left

Nancy decided that

two Bob entities are

probably of the

same person.

end note

Nancy -> HIS : Link newer Adam to older Adam

HIS -> IS : Link Identities (Person, newerAdam , Person olderAdam)

IS --> HIS: Acnowledgement

HIS -> Nancy: Identity Linked

@enduml

##### Merge Identities

@startuml

Actor Nancy as Nancy

Participant HIS as HIS

Participant IS as IS

Nancy -> HIS: Search Adam

HIS -> IS : Find Identity By Property (Adam)

IS --> HIS : Return Person List incl. Two Adams

HIS --> Nancy: Return Person List incl. Two Adams

Nancy -> Nancy: Review List

Note left

Nancy decided that

two Bob entities are

actually of the

same person.

end note

Nancy -> HIS : Merge newer Adam to older Adam

HIS -> IS : Merge Identities (Person, newerAdam , Person olderAdam)

IS --> HIS: Acnowledgement

HIS -> Nancy: Identity Merged

@enduml

#### Update demographics

The next time Adam Everyman enters the hospital, Adam Everyman gives Carol Clerk his name and address, but Carol Clerk cannot find an exact match in the HIS with the information provided. After asking for Adam Everyman's date of birth, the set of near match records that were returned from the IS are examined and the entry with the top matching confidence score in the list appears to be a very close match for Adam Everyman, but the address does not match.

After retrieving the full record for this entry from the HIS and asking Adam Everyman some further qualifying questions, Carol Clerk realizes that Adam Everyman has moved since his last admission and discharge. Carol Clerk updates Adam Everyman's address and phone number in the demographics and submits the change to the IS.

@startuml

Actor Carol as Carol

Participant HIS as HIS

Participant IS as IS

Carol -> HIS: Search Adam

HIS -> IS : Find Identity By Property (Person, Adam)

IS --> HIS : Return Person List incl. Adam

HIS --> Carol: Return Person List incl. Adam

Carol -> Carol: Review List

Note left

Carol cannot find

exact matcd that Adam's record

probexists with some trait values

Value out of date.

end note

Carol -> HIS : Link newer Adam to older Adam

HIS -> IS : Link Identities (Person, newerAdam , Person olderAdam)

IS --> HIS: Acnowledgement

HIS -> Carol: Identity Linked

@enduml

#### Inactivate entity from general searches

According to company policies, Carol Clerk discovers that Adam Everyman's record should be inactivated. The circumstances for inactivation would be defined by organizational policies, but could include death, relocation, change of health plan, removal of test data from a production system etc. While Adam Everyman's records must remain accessible, his demographic information should not be considered when looking for active patients. Carol Clerk, an administrator, uses Adam Everyman's identifier in the hospital's local Policy Domain to locate his entity record in the IS, and changes its state to Inactive. After this change, Adam Everyman should not be considered in any search for clinically active patients. This does not preclude Carol Clerk or any other administrator from finding Adam Everyman's entry using administration tools of IS.

@startuml

Actor Carol as Carol

Participant HIS as HIS

Participant IS as IS

Carol -> HIS: Inactivate Adam's Record

HIS -> IS : Update Identity Status (Person, EntityID, Status=Inactive)

IS --> HIS : Acknowledgement

HIS --> Carol: Acknowledgement

@enduml

#### Activate (inactive) entity to general searches

Carol Clerk realized she had made a mistake in removing Adam Everyman's records from active searches. Whatever the circumstances that led Carol to inactivate the record were discovered to be incorrect. Carol, using her IS search capabilities, found Adam Everyman's entry, selected the entry and changed its state to Active in the IS, to allow Adam Everyman's records to be found by general clinical searches.

@startuml

Actor Carol as Carol

Participant HIS as HIS

Participant IS as IS

Carol -> HIS: Activate Adam's Record

HIS -> IS : Update Identity Status (Person, EntityID, Status=Active)

IS --> HIS : Acknowledgement

HIS --> Carol: Acknowledgement

@enduml

#### Unlink (unmerge) entity

Miss Evelyn Smith enters the hospital and gives Carol Clerk her information. Carol Clerk is able to find an Evelyn Smith in the HIS system, but not the correct Evelyn Smith. Miss Smith is adamant

that she has been in this particular hospital several times in the past. As Carol Clerk investigates, he finds that there are admission records corresponding to this Miss Evelyn Smith's hospital visits currently associated with Mrs. Eve Everywoman. Upon further investigation, Carol Clerk finds that Mrs. Eve Everywoman was recently married, and her maiden name was Smith.

Realizing that Mrs. Eve Everywoman's entry had become linked to Miss Evelyn Smith in error, Carol Clerk removes the alias from Miss Evelyn Smith's entry in IS so that there are now three distinct entries: Miss Evelyn Smith, Miss Evelyn Smith, and Mrs. Eve Everywoman. The clerk can now find and select the appropriate Evelyn Smith from the list and proceed with the admissions process.

The organization's business processes and policies control the "admission clerk" authority on identity resolution functions. In many organizations, the functions of "merge/link/unlink/unmerge" are escalated to a specialized "identity resolution clerk".

#### Unlink entity

@startuml

Actor Carol as Carol

Participant HIS as HIS

Participant IS as IS

Carol -> HIS: Search Miss Evelyn Smith

HIS -> IS : Find Identity by Properties (Person, Smith, Evelyn,F)

IS --> HIS : Return Person Lust Incl. Two Smiths

HIS --> Carol : Return Person Lust Incl. Two Smiths

Carol -> Carol : reviews Person List

Note left

Carol Decided Evelyn Smith

does not match Evelin Smith

but has historical records

matched to Eve Everywoman

enabled for Unlinking

end note

Carol -> HIS: Retrieve All Aliases of Eve Everywoman

HIS -> IS : List Linked Identities (Person, EntityID)

IS --> HIS : Return Alias List of Eve Everywoman

HIS --> Carol: Return Alias List of Eve Everywoman

Carol -> Carol : reviews Alias

Note left

Carol Decided one  Everywooman's

alias - Evelyn Smith, was mistakenly

linked to Everywoman before Everywoman

was married because her maiden name

was Smith.

end note

Carol -> HIS: Unlink Alias Smith from Everywoman

HIS -> IS : Unlink Identity (Person, Smith Person, Everywoman)

IS --> HIS : Acknowledge Unlinking

HIS --> Carol: Acknowledge

Carol -> HIS: Proceed Smith's Admission

ref over Carol, HIS : Admission

@enduml

#### Look up a patient

##### Single Entry found

After Adam Everyman has been admitted, he is taken to a pre-op waiting room. In the pre-op waiting room, Clarence Barton, a nurse, asks Adam Everyman for some identifying information and looks up Adam Everyman's records in the Hospital Information System (HIS). Since the IS is shared, Clarence Barton finds Adam Everyman's information to locate his encounter. Adam Everyman's vital signs and other clinical data are recorded in the HIS, under his encounter.

@startuml

Actor Clarence as Clarence

Participant HIS as HIS

Participant IS as IS

Clarence -> HIS: Search Adam

HIS -> IS : Find Identity by Properties (Person, Adam)

IS --> HIS : Return Adam

HIS --> Clarence : Return Adam

ref over Clarence, HIS : Locate Adam's Surgical Encounter

ref over Clarence, HIS : Enter Adam's Vital Signs

@enduml

##### Multiple Entries found

Adam Everyman enters the hospital for an outpatient appointment. Carol Clerk, the registration clerk, asks Adam for his name and performs a search on his name in the HIS. The HIS asks the IS to perform the search, and Carol Clerk finds several matches for some variation of Adam Everyman. Each match has a quality attribute that guides Carol Clerk to correctly identify Adamasking for his age and some address details. Carol Clerk decides that one of the records is the correct match for Adam, and the HIS can present the records for that identity. Carol Clerk creates a new outpatient encounter record in the HIS.

@startuml

Actor Carol as Carol

Participant HIS as HIS

Participant IS as IS

Carol -> HIS: Search Adam

HIS -> IS : Find Identity by Properties (Person, Adam)

IS --> HIS : Return Lis Incl. Adam

HIS --> Carol : Return All Entries for Adam

Carol -> HIS : Enter Additional Criteria

HIS -> IS : Find Identity by Properties (Person, Adam, Age, Address)

IS --> HIS : Shorter Person List, Incl. Adam

HIS --> Carol : Return Shorter List Incl. Adam

Carol -> Carol : Select Adam

Carol -> HIS : Crerate new Encounter for Adam

ref over Carol, HIS : Create Encounter

@enduml

##### Merged Entries found for an Identifier

Bill Beaker is adding a lab test to the lab system and used an identifier that has been previously merged into another, which has been designated as the "main" identifier. The lab system does not recognize the identifier, so it checks with the IS, which returns an indication that the record has been merged, together with the main active identifier.

@startuml

Actor Bill as Bill

Participant HIS as HIS

Participant IS as IS

Bill -> HIS: Enter Lab Test (Adam Identifier)

HIS -> IS : Get All Information For Identity (Person, Adam Idntifier)

IS --> HIS : Merged Identifier

HIS --> Bill : Merged Identifier

Bill -> HIS : Update Lab Test with correct Identifier

ref over Bill, HIS : Update Lab Test

@enduml

#### Unattended encounter

The referral system receives an HL7 message from another institution describing a referral for a patient who is about to be admitted. The referral system does not recognize the patient, so it passes all the information it can find and asks the IS to identify the patient.

##### IS response #1

The IS finds an entry matching the patient details and returns the identifier. The referral system can complete processing the referral.

##### IS response #2

The IS finds more than one match meeting its criteria for unattended patient encounter matching, but none meeting its criteria for a complete match. It returns a list of possible patient identifiers with a quality attribute of the match. The referral system cannot completely processing the referral, and a user must look at the referral to determine the correct identifier with quality attribute support.

##### IS response #3

The IS finds no potential matches. The rules within the referral system are configured to request a new identifier to be created and then to send a request to the IS to do so. The IS creates the identifier and returns it to the referral system so that it can complete processing the referral.

##### IS response #4

(alternative to #3) The IS finds no potential matches. The rules within the referral system are configured to take no further action and await further user instruction.

@startuml

Participant ExternalSystem as ExternalSystem

Participant Referrals as Referrals

Participant IS as IS

ExternalSystem -> Referrals: HL7 referral messag

Referrals -> IS : Find Patient Identifier

alt

IS --> Referrals : Marching patient identifier

else

IS --> Referrals : Multiple identifiers

else

IS --> Referrals : No matching patient identifier

Referrals -> IS : Create Identity (Person, Properties)

end

IS --> Referrals : Patient Identifier

@enduml

#### Remove entity from the system

While testing a new function in a system that uses MPI in production, Carol Clerk created a pseudo-record for a fictitious patient. After Carol had completed all testing, Carol found the record, selected the record, and removed the record from IS. Once Carol confirms the entity removal request, she permanently purges the record.

Note: Though this record may be kept in some repository for audit trail purposes, nobody, neither clinical user nor administrator, can find it from IS.

@startuml

Actor Carol as Carol

Participant HIS as HIS

Participant IS as IS

Carol -> HIS: Remove Bob's Record

HIS -> IS : Remove Identity (Person, EntityID)

IS --> HIS : Acknowledgement

HIS --> Carol: Acknowledgement

@enduml

### Multiple Policy Domain Scenarios

The following scenarios introduce cross-policy domain processing. In addition to the hospital Moon introduced above, these scenarios consider a separate multi-layer organization, Solar System Healthcare, with 4 Regions, East, West, North, and South, each of which manages its own identifiers in its own IS instances. Hospitals Jupiter, Orion, Moon, and Good Health are assumed to be in different regions within the organization. Solar System operates a "master" national XIS with its own national identifiers, against which the regional identifiers are cross-referenced.

#### Look up a patient across a regional network

Adam Everyman, who normally receives his healthcare at Good Health Hospital, is admitted to Jupiter Hospital while on vacation due to chest pain. Carol Clerk does not find a record of Adam Everyman in their IS system. He asks Adam Everyman for some identifying information and requests their IS system to pass the search to their RHIO network to see if Adam Everyman can be found anywhere in the network. Good Health Hospital is also connected to the RHIO network, and its IS finds a match with the details supplied and returns its identifier for Adam Everyman. This identifier is then used to retrieve Adam Everyman's medical record from Good Health Hospital, either by use of an RLUS19 or by Fax or other mechanism.

@startuml

Actor Carol as Carol

participant IS\_Orion as IS\_Orion

Participant XIS\_RHIO as XIS\_RHIO

Participant IS\_Various as IS\_Various

Carol -> IS\_Orion : Search Adam

IS\_Orion -> XIS\_RHIO : Find Identity By Property (Person, Adam)

XIS\_RHIO -> IS\_Various : Find Identity By Property (Person, Adam)

IS\_Various --> XIS\_RHIO: Return Adam (from Hospital Moon)

XIS\_RHIO --> IS\_Orion : Return Adam

IS\_Orion --> Carol: Return Adam

@enduml

#### Look up a patient specifying a specific external organization

Eve Everywoman is admitted to Level Seven Healthcare suffering from an ankle injury. She informs Carol Clerk that she has never had treatment from Level Seven Healthcare, but that she is a patient at Good Health Hospital. Carol Clerk enters a request to IS to locate Eve Everywoman entering her name and address, and indicates that she is a Good Health Hospital patient. The IS contacts the RHIO network, specifically requesting a search in Good Health Hospital's IS. Good Health Hospital's system locates her record and returns her identity. This is then used to retrieve her medical record from Good Health Hospital, either by use of an RLUS20 or by Fax or other mechanism.

@startuml

Actor Carol as Carol

participant IS\_Moon as IS\_Moon

participant XIS\_RHIO as XIS\_RHIO

participant IS\_Orion as IS\_Orion

Carol -> IS\_Moon : Search Eve (Orion)

IS\_Moon -> XIS\_RHIO : Find Identity By Property (Person, Eve, Orion)

XIS\_RHIO -> IS\_Orion : Find Identity By Property (Person, Eve)

IS\_Orion --> XIS\_RHIO: Return Eve

XIS\_RHIO --> IS\_Moon : Return Eve

IS\_Moon --> Carol: Return Eve

@enduml

#### Link entities across regions within an organization

Adam Everyman is admitted to Jupiter Hospital, which is in the North region of Solar System Healthcare. Eric Entry checks for Adam Everyman on their HIS system, but he is not found. Adam Everyman then informs him that he is a Solar System patient in another area of the country, so Eric Entry requests the XIS to search for the whole of Solar System Healthcare. Adam Everyman's details from the East region are found by the National XIS and his details are returned. A new identifier is created for Adam Everyman in the North region so that the HIS can process his record, and a link is created in the Solar System's master XIS to tie Adam Everyman's new regional identifier to the master identifier for Solar System. Note – the Master XIS could hold a duplicate of all regions' entity properties or pass the request to retrieve them to the East region IS, this is an implementation choice.

@startuml

Actor Eric as Eric

participant HIS\_Jupiter as HIS\_Jupiter

participant IS\_North as IS\_North

participant XIS\_SolarSystem as XIS\_SolarSystem

Eric -> HIS\_Jupiter : Search Adam

HIS\_Jupiter-> IS\_North : Find Identity By Property (Patient, Adam)

IS\_North --> HIS\_Jupiter : No match found

HIS\_Jupiter --> Eric : No match found

Eric -> HIS\_Jupiter: Search Adam (Adam, SolarSystem)

HIS\_Jupiter -> IS\_North : Find Identity By Property (Patient, Adam, SolarSystem)

IS\_North -> XIS\_SolarSystem : Find Identity By Property (Patient, Adam)

XIS\_SolarSystem --> IS\_North : Return Adam

IS\_North -> IS\_North : Register Identity

IS\_North -> XIS\_SolarSystem : Link Identity

XIS\_SolarSystem --> IS\_North : Acknowledgement

IS\_North --> HIS\_Jupiter : Return Adam

HIS\_Jupiter --> Eric : Return Adam

@enduml

# Detailed Functional Model for each Interface

## General Notes

This section gives the functional description of the interfaces for this service.

• Identification Management Functions: Provides capabilities for manipulation of Entity Identifiers and properties.

• Query Functions: Provides query capabilities for discovering entity identifiers and properties and metadata discovery.

Additional interfaces may be defined in technical specifications for system or administrative functionality such as Service Management and/or Metadata Management.

The following general notes should be borne in mind when reviewing the capability definitions:

• The functions specified in this document are only intended to use demographic data, as these functions are meant to find the identity of the entity we are looking for. Data about the entity itself is entered in the individual systems, which collaborate with an Entity Information system supported by the regional Enterprise. However, this is NOT an enforced restriction in that the capabilities are defined to consume and produce a very generic information structure. The efficacy of using very complex information structures for the purpose of identification is left to Technical Specifications and Implementations.

• The means for returning informational and exception messages (above and beyond any requested business content) is left to Technical Specifications.

• The Service assumes that the client can provide and consume the semantic signifier. A means needs to be provided by which a potential client can discover the signifiers that an instance supports. This could either be provided by a reflection-style interface operation or by registration in a separate Service Registry.

• Security is not explicitly referenced in this specification. It is assumed to be handled by a separate infrastructure. There is an assumed precondition on all operations that the caller is appropriately authenticated (and possibly authorized according to domain regulations. Security approaches are not specific to any domain service; they are really orthogonal.

• In any functions that involves matching, two-tiered match threshold criteria may be used, which identify a "definite match" not requiring human intervention, and a "presumptive match", requiring further verification. Response quality could be used to determine which thresholds were met. Note that these values can be composite data structures, numerical, ontological, etc., and would, in general, be implementation-configurable.

## Identification and Cross-Reference Service Meta-model

This specification uses a number of concepts to achieve a balance between flexibility and usability. A logical meta-model is given below (this logical metamodel is generic; in some implementation contexts, e.g., patient or person, other meta-attributes may be relevant, e.g., an authority attribute for Policy Domains).

### Model Description

@startuml IS-MetaModel

title Class Diagram [ IS Metamodel ]

class EntityConcept {

    -id : String

    -name : String

    -description : String

    -versionId : String

}

class PolicyDomain {

    -id : String

    -name : String

    -description : String

    -versionId : String

    -status : statusCode

    -forCrossReference : Boolean [0..1]

    -languageSupported : languageCode [0..\*]

    -defaultLanguageId : languageCode

}

class EntityType {

    -id : String

    -name : String

    -description : String

    -status : statusCode

    -versionId : String

    -schemaDefinition : String

    -validationRuleSet : String

}

class EntityTypeAssignment {

    -id : String

    -status : statusCode

    -versionId : String

    -constrainedSchemaDefinition : String [0..1]

    -constrainedValidationRuleSet : String [0..1]

}

class IdentityLink {

    -linkType : LinkTypeCode

    -linkMethod : LinkMethodCode [0..1]

    -reason : String [0..1]

    -provenanceInformation : String [0..1]

}

class IdentityInstance {

    -id : String

    -versionId : String

    -status : statusCode

    -populatedSchemaValue : String

}

' Relationships

EntityType  "0..\*" --  "1" EntityConcept : classifies >

EntityTypeAssignment "0..\*" -- "1"  PolicyDomain : isAppliedTo >

EntityType "1" -- "0..\*" EntityTypeAssignment

IdentityInstance "0..\*" -- "1" EntityTypeAssignment : provideRuleFor >

IdentityLink -- "source 1" IdentityInstance

IdentityLink -- "target 1" IdentityInstance

@enduml

### PolicyDomain

This is similar to the concept of security domains and identifies the scope of usage of an Entity identifier. Policy Domains may be organizational, geographical and/or jurisdictional (See Glossary for *Policy Domain* definition). Each Policy Domain must have an owner who can define the policy and the entity types supported within the Policy Domain.

Attribute descriptions:

• **id** – unique identifier of the Policy Domain
• **name** – the name of the PolicyDomain
• **description** – a description of the PolicyDomain
• **versionId** – the version of the domain (Policy Domains can be merged, spitted, etc. This is represented as a String datatype in the diagram, but the representation of a versioning scheme is explicitly intended to be delegated to an implementation-dependent version concept as opposed to a simple character string - with a default "flattening" to a string to support simple implementation.
• **status** – the status of the PolicyDomain. Indicates whether the PolicyDomain can be used.

• **forCrossReference** (optional) – indicates whether this PolicyDomain can be used in cross-references of Entities across other Domains

• **languagesSupported**(optional)– identifies the languages that are supported in the domain

• **defaultLanguage** – the default language supported in the domain

### EntityConcept

This specifies a concept or "category of information" that may be supported in an IS. This can be defined at various levels and even customized for a specific organization (subject to interoperability concerns). The purpose is to be able to indicate a semantic relationship between different representations (Entity Types) of the same basic underlying concept. So an Entity Concept can be classified by different Entity Types.For example, an EntityType of RIM Person can be semantically related to an EntityType defined by an OpenEHR Archetype or Template representing a Person.

Attribute descriptions:

• **id** – unique identifier of an Entity Concept
• **name** – the name of the Entity Concept
• **description** – a description of the Entity Concept

• **versionId** – the version of the Entity Concept

Future versions of this specification may allow additional layers, providing a hierarchical classification scheme. From a meta-model perspective, this would simply mean adding a recursive relationship, but due to the potential implementation complexities, this is not included in this version.

### EntityType

This identifies a specific "type" of entity that an IS supports at the level of a specific information model or schema (aka Semantic Signifier), e.g. RIM Person, RIM Living Subject etc. An EntityType classifies one EntityConcept.

Attribute descriptions:

• **id** – unique identifier of the Entity Type
• **name** – the name of the Entity Type

• **description**– a description of the Entity Type

• **status** – the status of the Entity Type. Indicates whether the Entity Type can be used, e.g. whether new entities of the type can be created.

• **versionId** – allows for maintaining a history

• **schemaDefinition** – contains the actual definition of the data items in the structure

• **validationRuleSet** – defines declarative rules for validating the defined schema.

### EntityTypeAssignment

This allows the definition rules for EntityTypes (Semantic Signifiers) to be varied for different PolicyDomains.

Attribute descriptions:

• **id** – unique identifier of the assignment
• **status** – the status of the Assignment. Indicates whether it is currently in use for the EntityType.

• **versionId** – identifier of the version of the assignment
• **constrainedSchemaDefinition** (optional) – optional constrained version of the definition of the data items in the structure (May only further constrain those defined for the SemanticSignifier)

• **constrainedValidationRuleSet** (optional) – optional declarative rules for validating the defined schema for use in specific Policy Domains, where different from the default for the SemanticSignifier (26As an example, two different Policy Domains can have different validation rules about patient identification: e.g. one can accept id from a driver licence without a provided social security number and another Domain can reject validation without a valid SSN id. In another example, from a devices scenario, one Domain can accept a device registration only if all the properties of Entity Type are compiled while another Domain can accept some properties as optional)

### IdentityInstance

Represents the actual instance entries in IS. These are always of a specific EntityType, and are scoped within a specific PolicyDomain.

Attribute descriptions:

• **id** – unique identifier of the Identity (see note in Section4.3 below)

• **versionId** – identifies the Version of the IdentityInstance

• **status** – status of the Identity.

• **populatedSchemaValues** – the actual populated information schema. It's the populated Entity Type (Semantic Signifier) for the specific IdentityInstance.

### IdentityLink

Allows for linking and merging of identities. The link type would indicate a link or merge. Note that the link semantics state that the linked items represent the same real-world entity, and hence, links are transitive by definition.

Attribute descriptions:

• **linkType** – indicates whether the identities are linked as active "peers" or whether one is deprecated as in a merge.

• **provenanceInformation** (optional) – a placeholder structure for administrative information relating to linking/unlinking/merging/unmerging when applied manually

• **linkMethod** (optional) – a coded value providing information on how the link was made.

• **Reason** (optional) – a coded and/or free-form text field identifying the reason for making the link.

## Model Notes

The above model offers significant implementation flexibility. It is recognized that some implementations may find such flexibility a burden rather than a benefit. There are a number of notes that should be borne in mind when considering the use of this model, which are discussed below:

### General Notes

• Data types on attributes in the model itself are only indicative and are not intended as a constraint on technical specifications. Implementations of data types in metadata should use ISO 21090 data types.

• Identifiers have been included at all levels to allow for unique identification as needed by the technical specification, but these may not be required on several of the classes for implementation

• Note also that in this specification, "identifying information" is any set of attributes (partially populated semantic signifier) that can be used singly or together to identify an entity (even approximately). An "identifier" is a data item or structure used to provide a unique identification.

• Explicit "versionIds" have been included in the meta-model. They have also been included in the function inputs and outputs for the control classes (PolicyDomain and EntityType). These should be seen as "optional" in the sense that the typical implementable operations will work with "current" versions in most cases and allow these as default settings (i.e. not explicitly input).

• Status code set for Identities is undefined in this specification. It is explicitly stated below that these are left to the technical specification. The values need to be determined by the requirements for maintaining metadata. The primary reason is that this Service is designed to cater for identification of many different kinds of entities, and these may have different state models. The basic "default" minimum assumption is that the concepts of "active" and "inactive" states are covered, so inactive identities would not appear in normal searches or allow linking or merging. However, these restrictions are seen as realm or organization-specific configuration settings. However, explicit status code values for IS metadata are defined and defaulted, explicitly using "active" and "inactive". However, the ability to accommodate locally mandated status sets and rules is assumed.

In both cases, individual deployments may also use an additional separate curation state (e.g. pending, approved etc.). This is not explicitly covered in this specification since this would be organization specific and often handled by separate workflow tools.

### Entity Types and Policy Domains

Each individual technical specification will need to take a specific stance with respect to both multiple Entity Types and Policy Domains. For those where these capabilities are not supported, the specific operations relating to them would not apply, and recognition of separate Policy Domain and Entity Type Identifiers would be unnecessary in many entity-level and query operations. In XIS implementations, support for multiple Policy Domains is necessary, although this could still

be restricted to support of one "owning" Policy Domain.This effectively means that the PolicyDomain and EntityType Identifiers (id) can be considered as optional at the implementation level (or at least conditional on the scope of the IS). **Note that this is not directly indicated in the operation descriptions below**.

For the sake of understandability and completeness, the interfaces in this specification are defined on the basis of an XIS that manages multiple Policy Domains and multiple Entity Types (Semantic Signifiers). It is relatively easy to subsequently constrain these interfaces as appropriate to an XIS with one owning Policy Domain or to an IS that deals with only one entity type (e.g. by removing or restricting the relevant operations and inputs).

Moreover, in several scenarios (which are typical in IS implementation at the regional and national levels), Policy Domains and Entity Types must be supported by explicit definitions of the issuing Authority Attributes (such as name, id, etc.). In these cases, the Semantic Signifier specification must properly support these attributes.

Also, it should be remembered that this is a functional specification. The capability "inputs" identified are the information that an IS instance needs to know to carry out its task. In most cases, the technical specification will include these items as specific input parameters to operation calls.

## Management Functions

### Register an Identity

|  |  |
| --- | --- |
| Description | Allows for creation of an identity with a supplied set of property values. Uses an identifier supplied by the service consumer which is unique within the Domain for the EntityType. |
| Precondition |  |
| Inputs | • Entity Type Identifier  • Entity Type Version Id (optional)  • PolicyDomain Identifier  • PolicyDomain Version Id (optional)  • Identity Instance Identifier  • Status  • Properties (Populated Semantic Signifier) |
| Outputs | Notifications:  • (Information) Acknowledgement that Identity has been successfully Registered  • (Information) Automated links have been applied (matches found that exceeded the threshold for acceptance as "definite match")  • (Warning) One or more existing Identity records were found that match the input Identifier (based on matching of supplied non-identifier attributes) – return with a list of potentially matching Identifiers. |
| Postconditions | An Identity is Registered |
| Exception Conditions | • Identity already exists within IS (Identifier must be unique for the Entity Type/PolicyDomain combination)  • Unrecognized PolicyDomain  • Unrecognized Entity Type  • Validation of properties against the schema for the Entity Type/PolicyDomain failed |
| Miscellaneous  notes/aspects  left to Technical Specification | Although it does not directly affect the interface or parameters, other than the potential output message, IS implementations are expected to provide some level of automated implicit linking capabilities. This could be policy-driven or handled manually using the explicit linking operations described in this specification. This would be triggered when a new entity is created or the properties of an entity updated. The triggered behavior should be as described for the Link Identities operation. Actually, "merging" entities based on automated logic is not encouraged. Note that the actual policies are handled through "out of band" agreements. |

### Create an Identity

|  |  |
| --- | --- |
| Description | Allows for creation of an Identity Instance with a list of property values, where the Identifier is generated and passed back to the service consumer. Would only be used where the consumer cannot generate and supply its own "local identifiers", although this is an implementation and technical specification choice. This identifier is different from IS Id.  IS Id is an identifier for a Real-World Entity that is guaranteed to be unique across an instance of an IS (i.e. across all Policy Domains covered by the instance). This may be generated by the IS implementation and is only used internally by the Service, although this is an implementation and technical specification choice |
| Precondition |  |
| Inputs | • Entity Type Identifier  • Entity Type Version Id(optional)  • PolicyDomain Identifier  • PolicyDomain Version Id (optional)  • Status  • Properties (Populated Semantic Signifier) |
| Outputs | Return generated Identity Instance Identifier (this is an external "local identifier", not the internal IS Id if and where the latter is implemented).  Notifications:  • (Information) Acknowledgement that Identity has been successfully created  • (Information) Automated links have been applied (matches found that exceeded threshold for acceptance as "definite match")  • (Warning) One or more existing Identity records were found that match the input Identifier (based on matching of supplied non-identifier attributes) – return with list of potentially matching Identifiers. |
| Postconditions | An Identity Instance is created |
| Exception Conditions | •Unrecognized PolicyDomain  •Unrecognized Entity Type  •Validation of properties against the schema for the Entity Type / PolicyDomain failed |
| Miscellaneous  notes / aspects left to Technical  Specification | As for Register Identity |

### Update Identity Property Values

|  |  |
| --- | --- |
| Description | Allows for addition and/or update of a set of property values for an identity specified by a unique Identifier. |
| Precondition | The Identity specified by the Identifier exists. |
| Inputs | • Entity Type Identifier  • Entity Type Version Id(optional)  • PolicyDomain Identifier  • policyDomain Version Id (optional)  • Identity Instance Identifier  • Update Qualifier  • Properties (Populated Semantic Signifier) |
| Outputs | Notifications:  • (Information) Acknowledgement that property values have been successfully added and/or updated  • (Information) Automated links have been applied (matches found that exceeded the threshold for acceptance as "definite match")  • (Warning) New potential identity match found (based on matching of supplied non-identifier attributes.)  • (Warning) Existing match now questionable |
| Postconditions | Identity updated with property values |
| Exception Conditions | • Identity does not exist in the system  • Unrecognized PolicyDomain  • Unrecognized Entity Type  • Validation of properties against the schema for the Entity Type / PolicyDomain failed |
| Miscellaneous  notes/aspects  left to Technical Specification | Note on automated linking as for Register Identity:  The UpdateQualifier input consists of the following elements:  • **updateMode**:  Indicates the mode to be utilized during the update process.  Values include:  o **OVERWRITE** - Replaces the entire set of data elements with the entire supplied set. Null values in the submitted data will replace existing non-null values.  o **VALUED** - Replaces only those data elements that are valued in the input data. Null values in the submitted data will not replace existing non-null values.  o **UNSPECIFIED** - Implementation specific. ·  • **updateSchemaDefinition**:  a reference to an external resource (e.g. XSL) that can be utilized to extract properties from the supplied Semantic Signifier |

### Update Identity State

|  |  |
| --- | --- |
| Description | Changes the processing "state" of an identity (e.g. to "inactive", "active" or other states to be defined in appropriate semantic profiles). |
| Precondition | The Identifier identifies an Entity that is an appropriate previous state for the status change. |
| Inputs | • Entity Type Identifier  • Entity Type Version Id(optional)  • PolicyDomain Identifier  • PolicyDomain Version Id (optional)  • Identity Instance Identifier  • State  • Reason |
| Outputs | Confirmation that the Identity identified by the Instance Identifier has changed its recorded state. |
| Invariants | All identity information is unchanged except for state change |
| Postconditions | Identity state changed to input state |
| Exception Conditions | • Identifier is not recognized as identifying an Entity •Unrecognized PolicyDomain  • Unrecognized Entity Type  • Previous state incompatible with requested state change |
| Miscellaneous  notes/aspects  left to Technical Specification | Reasons may be codified. This is left to the technical specification.  The simple state model of active and inactive as defined for the HL7 RIM "Entity" is defined as a minimum set of states, whereby "inactive" entities do not show up in normal searches.  However, the definition and meaning of states is seen as something that should be configurable and tailored to individual realms and even for organizations internal use. It also may vary depending on the different Entity Type that is being identified. |

### Merge Identities

|  |  |
| --- | --- |
| Description | Allows merging two identities. The Target Identifier is the "winner" in the merging capability. The deprecated Identity should be automatically set to a pre-configured state (e.g. inactive, but the actual value is semantic profile specific – implementations can default where a more static solution is desired).  Merge capability is restricted to be within a single PolicyDomain only. The Link capability should be used across Domains.  In general, it should also be restricted to identities of the same Entity Type, however implementations may apply this to different Entity Types that represent the same EntityConcept, providing that the semantic signifiers used are compatible.  Identifying attributes in the target that are empty are filled from the source, and existing attributes in the target remain AS-IS.  The implementation must provide a mechanism to indicate that the two identities have been merged (e.g. by use of an explicit link relationship or by using a Correlation set). |
| Precondition | Both Identities to be merged should exist in the system.  Source and Target Identities must be in an allowable state for the merge capability.  Both Identities must be in the same PolicyDomain.  Identities must be classified as EntityTypes that represent the same EntityConcept |
| Inputs | • Entity Type Identifier  • Entity Type Version Id(optional)  • PolicyDomain Identifier  • PolicyDomain Version Id (optional)  • Target Identity Instance Identifier  • Source Identity Instance Identifier (to be deprecated)  • Reason (optional)  • Link Method (optional)  • Source State (optional)  • Target State (optional - the state in which the target merged identity should be left after the operation) |
| Outputs | An acknowledgement that the Identities have been merged. |
| Postconditions | Deprecated Identity set to configured state. Target Identity set to requested state, if entered. |
| Exception Conditions | • Target Identity does not exist  • Source Identity does not exist  • Unrecognized PolicyDomain  • Unrecognized Entity Type  • Unrecognized Link Method  • Source state not permitted  • Target state not permitted |
| Miscellaneous  notes/aspects  left to Technical Specification | The mechanism for relating the two identities is left to the technical specification. A link relationship class was identified in the conceptual mode above. Another alternative is to define a "correlation" set, i.e. a separate "master Id" which collects together related identities.  Reasons may be codified. This is left to the technical specification.  If automated implicit linking capabilities are provided, the rules for handling such links must be specified in the implementation.  A default should be used for the target state, so input is optional. |

### Unmerge Identities

|  |  |
| --- | --- |
| Description | Allows unmerging two Identities. This would reinstate a previously deprecated Identity. Note that the state of the unmerged Identities cannot be guaranteed to be valid, and that subsequent manual updates will be required to correct both entries.  Whatever mechanism was used to record the "merge" association between the two identities will be reversed. No other attribute values are updated, merely the states. |
| Precondition | The Identity resulted from a previous merge. |
| Inputs | • Entity Type Identifier  • Entity Type Version Id(optional)  • PolicyDomain Identifier  • PolicyDomain Version Id (optional)  • SourceIdentity Instance Identifier  • Target Identity Instance Identifier  • Reason (optional)  • Source Identity State (optional)  • Target Identity State (optional) |
| Outputs | An acknowledgement that the Identities have been unmerged |
| Postconditions |  |
| Exception Conditions | • Identifier is not recognized as identifying an entity  • Supplied identities were not previously merged  • Unrecognized PolicyDomain  • Unrecognized Entity Type  • Source state not permitted  • Target state not permitted |
| Miscellaneous  notes/aspects left to Technical  Specification | From an overall process perspective, the "unmerge" should require manual intervention afterwards. The Technical Specification may enforce an inactive status on unmerged entities until a further update is carried out. This may also be driven by the optional input state parameters.  Reasons may be codified. This is left to the technical specification. |

### Link Identities

|  |  |
| --- | --- |
| Description | Allows linking of two identities. Linking capability can be carried out within a single domain or across two different domains. |
| Precondition | Both identities to be linked should exist in the system. Target Identity must be in Active state. |
| Inputs | • Source Entity Type Identifier  • Source Entity Type Version Id(optional)  • Source Policy Domain Identifier  • Source Policy Domain Version Id (optional)  • Source Identity Instance Identifier  • Target Entity Type Identifier  • Target Entity Type Version (optional)  • Target Policy Domain Identifier  • Target Policy Domain Version (optional)  • Target Identity Instance Identifier  • Reason (optional)  • Link Method (optional) |
| Outputs | An acknowledgement that the Entities have been linked. |
| Postconditions | Both Entities updated with link information. |
| Exception Conditions | • Source Entity does not exist  • Target Entity does not exist  • Unrecognized Entity Types / Policy Domains  • Identities already linked  • Unrecognized Link Method  • Identity states incompatible with link action |
| Miscellaneous  notes/aspects left to Technical  Specification | For cross-Entity-Domain linking, Technical Specifications may choose to allow "peer to peer" linking or enforce that the link is to and from a "Master" Policy Domain for the XIS instance. Note that this does not affect the interface's structure but is an important behavioral aspect.  This capability permits linking of entities of different types; however it is recommended that they map to the same EntityConcept (unlike merge, this is NOT an absolute requirement).  Reasons may be codified. This is left to the technical specification.  Note: this operation could be triggered by implicit logic as part of the register, create or update actions. |

### Unlink Indentity

|  |  |
| --- | --- |
| Description | Allows for the unlinking of two entities. |
| Precondition | Both Identities to be unlinked should exist in the system and be linked to each other. |
| Inputs | • Source Entity Type Identifier  • Source Entity Type Version Id(optional)  • Source Policy Domain Identifier  • Source Policy Domain Version Id (optional)  • Source Identity Instance Identifier  • Target Entity Type Identifier  • Target Entity Type Version (optional)  • Target Policy Domain Identifier  • Target Policy Domain Version Id(optional)  • Target Identity Instance Identifier  • Reason |
| Outputs | An acknowledgement that the Identities have been unlinked. |
| Postconditions |  |
| Exception Conditions | • Source Entity does not exist  • Target Entity does not exist  • Unrecognized Entity Types / Policy Domains  • Identities not linked  • Identity states incompatible with unlink action |
| Miscellaneous  notes/aspects left to Technical  Specification | Reasons may be codified. This is left to the technical specification. |

### Remove an Identity Instance

|  |  |
| --- | --- |
| Description | Allows for the "complete" removal of an Identity Instance from an IS service. |
| Precondition | The Identity Instance should exist and should be in an appropriate State The Identity Instance should not be linked to other Entities |
| Inputs | • Entity Type Identifier  • Entity Type Version Id(optional)  • Policy Domain Identifier  • Policy Domain Version Id(optional)  • Identity Instance Identifier |
| Outputs | An acknowledgement that the Identity Instance has been removed |
| Postconditions |  |
| Exception Conditions | • Identifier is not recognized as identifying an Identity Instance  • Identifier identifies an Identity Instance that is not in an allowable state for removal  • The Identity Instance is linked to other Identities |
| Miscellaneous notes/aspects left to  Technical Specification | Technical Specifications must define whether the Identity Instance Identifier may be reused after this operation, although this is strongly discouraged.  The concept of "removal" implies that identity information is persistently stored within the service's implementation. This may be achieved in many different ways, but this is outside the scope of the interface definition. This functional model assumes that identity instance identifiers cannot be reused, but this must be precisely defined in the technical specifications.  This capability should obviously be used with care and, in general, be restricted to users with specified privileges. |

## Query Functions

### Get All Information for an Identity

|  |  |
| --- | --- |
| Description | Retrieves all information for an Identity known by the IS (properties, status, etc.).  A specific unique identifier is input (qualified by PolicyDomain and EntityType). An error is returned if the identifier is not found.  The optional "Return Statuses" parameter may be used to restrict the return only to a specific status. (Implementations may then restrict which user roles may see certain statuses).  If the identity has been merged into another "main" identifier, then a warning message should be returned with the identifier of the identity into which the supplied identifier has been merged. |
| Precondition |  |
| Inputs | • Entity Type Identifier  • Entity Type Version Id(optional)  • Policy Domain Identifier  • Policy Domain Version Id (optional)  • Identity Instance Identifier  • Return Statuses (optional) |
| Outputs | All property values of the Identity |
| Invariants | Identity is unchanged. |
| Postconditions | N/A |
| Exception Conditions | • Identifier is not recognized as identifying an identity  • Unrecognized Entity Type  • Unrecognized Policy Domain  • Unrecognized Identity states |
| Miscellaneous  notes/aspects left to Technical  Specification |  |

### Find Identities by Property

|  |  |
| --- | --- |
| Description | Given a partially populated semantic signifier and other search filter criteria, this allows for a search of matching Identities.  Search qualifiers enable directing the search behavior, but are not explicitly business data content filter criteria  Outputs include a quality of match. |
| Precondition |  |
| Inputs | • Entity Type Identifier  • Entity Type Version Id (optional)  • List of 0 or more Policy Domain Ids / Versions Ids (default is "all" and latest versions)  • Search Properties (partially populated Semantic Signifier)  • Return Statuses (optional)  • Search qualifiers (all optional):  - Requested confidence of match  - Maximum Result Set Size  - Error If Size exceeded (flag)  - Matching algorithm |
| Outputs | •An acknowledgement that a list of Entities for the search predicate has been found or no matches.  •A list of:  - Policy Domain Identifier / Version Id  - Entity Type Identifier / Version Id  - Identity Instance Identifier  - fully populated semantic signifier (Properties).  - quality\_of\_match  matching the search predicate, in order of the quality\_of\_match |
| Postconditions | None |
| Exception Conditions | • Unrecognized Policy Domain  • Unrecognized Entity Type  • Invalid status values  • Invalid/unrecognized Search Qualifiers  • Validation of properties against the schema for the Entity Type / Policy Domain failed |
| Miscellaneous  notes/aspects  left to Technical Specification | It is left to Technical Specifications whether to define specific queries for specific entity types and property sets, and/or algorithms, etc. For XIS instances, may also be useful to return a list of Policy Domains that were covered and/or not covered by the search.  Consideration can also be given to accepting "ranges" in some of the semantic signifier (Entity Types) fields, e.g. Date of Birth between x and y, but this is not required by the specification. |

### List Linked Identities

|  |  |
| --- | --- |
| Description | Given an Identifier, list all other entities that are linked to the Identity (optionally constrained within one or more Policy Domains) |
| Precondition | The Identity exists in the specified domain. |
| Inputs | • Entity Type Identifier  • Entity Type Version Id(optional)  • Policy Domain Identifier  • Policy Domain Version Id(optional)  • Identity Instance Identifier  • List of other PolicyDomain Identifiers (optional)  • Search Qualifiers (optional) |
| Outputs | List of Identities (Policy Domain Identifier, Entity Type Identifier, Identity Instance Identifier, fully populated semantic signifier) that are linked to the specified Identity |
| Postconditions | None |
| Exception Conditions | • Policy Domain not known to the system •Entity Type not known to the system  • Identity not known to the system  • Search qualifiers not recognized |
| Miscellaneous  notes/aspects left to Technical  Specification | The content of search qualifiers. One example could be enabling filtering based on particular kinds of automated linking. |

### Request Identity Update Notifications

|  |  |
| --- | --- |
| Description | The service consumer lodges a request to be notified if the IS becomes aware of any changes to information for a specific Identity (properties, status or entity links) or identities of a specific type and/or domain combination.  The input information is validated, and if valid a request identifier is generated and returned. |
| Precondition | Where entered, Policy Domain and Entity Types are supported. |
| Inputs | Subscriber identification and/or destination  One or more of:  • Policy Domain Identifier / Version Id  • Entity Type Identifier / Version Id  • Identity Instance Identifier  • Notification Qualifier (identifies specific type of event of interest)  • Request Status |
| Outputs | Notification Request Identifier |
| Postconditions |  |
| Exception Conditions | • Policy Domain not known to the system  • Entity Type not known to the system  • Request Identifier not known to the system  • Identity Identifier not known to the system  • Unrecognized / Invalid Notification Qualifier  • Unrecognized status value |
| Miscellaneous  notes/aspects  left to Technical Specification | This is effectively a subscription operation. This could be implemented using a publish-and-subscribe capability. |

### Update Identity Notification Request

|  |  |
| --- | --- |
| Description | The service consumer provides an update to a previously submitted request to be notified if the IS becomes aware of any changes to information for a specific Identity (properties, status or entity links) or identities of a specific type and/or domain combination. This includes cancellation of the request |
| Precondition | Where specified, the Identity exists in the specified domain. Where entered, Policy Domain and Entity Types are supported. |
| Inputs | Notification Request Identifier  Subscriber identification and/or destination  One or more of:  • Policy Domain Identifier / Version Id  • Entity Type Identifier / Version Id  • Identity Instance Identifier  • Notification Qualifier (identifies a specific type of event of interest) |
| Outputs | Acknowledgement of request.  (Potentially a series of asynchronous update notifications) |
| Postconditions | Update applied as requested |
| Exception Conditions | • Policy Domain not known to the system  • Entity Type not known to the system  • Identity not known to the system  • Unrecognized / Invalid Notification Qualifier |
| Miscellaneous  notes/aspects left to Technical  Specification | This is an update operation on an existing subscription. |

### Notify Identity Updates

|  |  |
| --- | --- |
| Description | The service produces a notification of an update that has been made to any information relating to a specific identity or identities within a Policy Domain and/or Entity Type (previously notified via a "Request Update Notifications" request). |
| Precondition | The IS has become aware of an update to information relating to a specific Entity.  A previous "Request Update Notifications" request has been received. |
| Inputs | None |
| Outputs | Identifier, status, and all property values of the Identity |
| Postconditions | None |
| Exception Conditions |  |
| Miscellaneous  notes/aspects left to Technical  Specification | This is effectively a publication operation resulting from an earlier subscription operation. This could be implemented using a publish-and-subscribe capability. |

# Glossary

Citation of terms specific to this functional specification

|  |  |
| --- | --- |
| **Term** | **Definition** |
| CIS | Clinical Information Systems |
| HIS | Hospital Information Systems |
| IS (as an instance) | Identification and Cross-Reference Service that operates in a single domain  only. |
| IS ID | This is an identifier for a Real-World Entity that is guaranteed to be unique across an instance of an IS (i.e. across all Policy Domains covered by the instance). This may be generated by the IS implementation and is only used internally by the Service. |
| Entity | The software representation of a Real-World Entity (RWE). An Entity registered in a IS Instance must have an identifier, so it's frequently referred as an Identity Instance or Identity in this standard |
| Entity Concept | This specifies a semantic concept or "category of information" that may be supported in an IS. This can be defined at various levels and even customized for a specific organization (subject to interoperability concerns). The purpose of the Entity Concept in IS is to have the capability to specify a semantic relationship between different representations (Entity Types) of the same basic underlying concept. So an Entity Concept can be classified by different Entity Types. |
| Entity Type | This identifies a specific "type" of entity that an IS supports at the level of a specific information model or schema (aka Semantic Signifier), e.g. RIM Person, RIM Living Subject etc. |
| Identifier (Id) | A value within a Domain that is associated with an object – an Entity, a Source, etc. - and uniquely identifies it within the scope of a Policy Domain. |
| Identity Instance | Represents the actual instance of an Entity in an IS instance. These are always of a specific EntityType and are scoped within a specific PolicyDomain. |
| Policy Domain | A ‘Policy Domain' is a set of legal, organizational, ethical, social, psychological, and technical impacts on a system. In our context can be, as an example, a Jurisdictional Domain (e.g. a Local Health Authority)  Within this specification, this identifies a sphere of control of entity identifiers. This could be legal (e.g., government-issued identifiers), organizational (e.g., department, enterprise, cross-enterprise), geographical (e.g., regional, national, state), or even specific to one computer system. This describes the PolicyDomain from a "usage" perspective rather than an "assigning authority" perspective, as is typically used in HL7 for Jurisdictional Domains.  Identities must be unique within a PolicyDomain. |
| MPI / EMPI | (Enterprise) Master Patient Index. An application system that provides capabilities to find and cross-reference patients. MPIs will likely be the most common system for providing IS interfaces. |
| Property | Aka Trait. This is a characteristic or attribute of an Entity that an IS may use individually or in groups to identify Entities. An example would be "name" for a person. There is no guarantee of uniqueness for individual properties unless they are explicitly defined as the "Identifier". |
| Real World  Entity (RWE) | Represents an actual thing itself, e.g., the actual Person, the actual Device, etc. Must be noted that this specification takes no position about the physical "reality" of an RWE. So, an RWE can be a result of a relationship or a consequence of a performative utterance, a model, and so on. An RWE can be any identifiable object that an IS instance can manage |
| RIS | Radiology Information System |
| Semantic  Signifier | This represents a constrained information model (and potentially an associated set of validation instructions) for the IS properties. It defines the structure and how that structure should be validated. Semantic  Signifier can be a Resource in a REST-based specification, such as HL7 FHIR |
| Service Metadata | This set of data items delineates the scope and coverage of IS. This includes identifying the PolicyDomains, Class Definitions, and Semantic Signifiers that an IS supports. |
| Source | The originator of a request to IS, which may be a system or organization. The Source may allocate its own "local" identifier for entities. |
| Trait | See "Property" |
| XIS (as an instance) | An IS where multiple Policy domains are recognized and managed |
