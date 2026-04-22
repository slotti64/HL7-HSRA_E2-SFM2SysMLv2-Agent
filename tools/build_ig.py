"""SB6-IG: ImplementationGuide packager for SFM2FHIR-PSM pipeline.

Reads FHIR R5 JSON artifacts under {OUT}/FHIR/ and emits:
  - ImplementationGuide.json
  - package.json
  - ig.ini

Run: python tools/build_ig.py
"""
import json
import os

# ---- Configuration ----
BASE = "output/ServiceFunctionalModel_IdentificationService/PSM/FHIR"
SERVICE_NAME = "IdentificationService"
IG_ID = "hl7.fhir.eu.identificationservice"
IG_VERSION = "0.1.0"
CANONICAL_BASE = "http://example.org/fhir"
IG_URL = f"{CANONICAL_BASE}/ImplementationGuide/{IG_ID}"
FHIR_VERSION = "5.0.0"
IG_DATE = "2026-04-22"


def read_json(p):
    with open(p, "r", encoding="utf-8") as f:
        return json.load(f)


def describe(doc, fallback_prefix):
    desc = doc.get("description")
    if desc:
        return desc.strip().split("\n")[0][:500]
    t = doc.get("title") or doc.get("name") or doc.get("id")
    return f"{fallback_prefix}{t}"


def main():
    sd_dir = os.path.join(BASE, "StructureDefinitions")

    profile_entries = []
    extension_entries = []
    for fn in sorted(os.listdir(sd_dir)):
        if not fn.endswith(".json"):
            continue
        d = read_json(os.path.join(sd_dir, fn))
        rt = d.get("resourceType")
        rid = d.get("id")
        name = d.get("title") or d.get("name") or rid
        if d.get("type") == "Extension":
            extension_entries.append({
                "reference": {"reference": f"{rt}/{rid}"},
                "name": name,
                "description": describe(d, "Extension: "),
                "exampleBoolean": False,
            })
        else:
            base_type = d.get("type")
            profile_entries.append({
                "reference": {"reference": f"{rt}/{rid}"},
                "name": name,
                "description": describe(d, f"Profile on FHIR R5 {base_type}: "),
                "exampleBoolean": False,
            })

    operation_entries = []
    od_dir = os.path.join(BASE, "OperationDefinitions")
    for fn in sorted(os.listdir(od_dir)):
        if not fn.endswith(".json"):
            continue
        d = read_json(os.path.join(od_dir, fn))
        rt = d.get("resourceType")
        rid = d.get("id")
        name = d.get("title") or d.get("name") or rid
        code = d.get("code") or ""
        resource_list = d.get("resource") or []
        scope = ",".join(resource_list) if resource_list else "system"
        operation_entries.append({
            "reference": {"reference": f"{rt}/{rid}"},
            "name": name,
            "description": describe(d, f"Operation ${code} on {scope}: "),
            "exampleBoolean": False,
        })

    st_entries = []
    st_dir = os.path.join(BASE, "SubscriptionTopics")
    for fn in sorted(os.listdir(st_dir)):
        if not fn.endswith(".json"):
            continue
        d = read_json(os.path.join(st_dir, fn))
        rt = d.get("resourceType")
        rid = d.get("id")
        name = d.get("title") or d.get("name") or rid
        st_entries.append({
            "reference": {"reference": f"{rt}/{rid}"},
            "name": name,
            "description": describe(d, "SubscriptionTopic: "),
            "exampleBoolean": False,
        })

    cs_entries = []
    cs_path = os.path.join(BASE, "CapabilityStatement.json")
    if os.path.exists(cs_path):
        d = read_json(cs_path)
        rt = d.get("resourceType")
        rid = d.get("id")
        name = d.get("title") or d.get("name") or rid
        cs_entries.append({
            "reference": {"reference": f"{rt}/{rid}"},
            "name": name,
            "description": describe(d, "CapabilityStatement: "),
            "exampleBoolean": False,
        })

    vs_entries = []
    for fn in sorted(os.listdir(os.path.join(BASE, "ValueSets"))):
        if not fn.endswith(".json"):
            continue
        d = read_json(os.path.join(BASE, "ValueSets", fn))
        rt = d.get("resourceType")
        rid = d.get("id")
        name = d.get("title") or d.get("name") or rid
        vs_entries.append({
            "reference": {"reference": f"{rt}/{rid}"},
            "name": name,
            "description": describe(d, "ValueSet: "),
            "exampleBoolean": False,
        })

    codes_entries = []
    for fn in sorted(os.listdir(os.path.join(BASE, "CodeSystems"))):
        if not fn.endswith(".json"):
            continue
        d = read_json(os.path.join(BASE, "CodeSystems", fn))
        rt = d.get("resourceType")
        rid = d.get("id")
        name = d.get("title") or d.get("name") or rid
        codes_entries.append({
            "reference": {"reference": f"{rt}/{rid}"},
            "name": name,
            "description": describe(d, "CodeSystem: "),
            "exampleBoolean": False,
        })

    ns_entries = []
    for fn in sorted(os.listdir(os.path.join(BASE, "NamingSystems"))):
        if not fn.endswith(".json"):
            continue
        d = read_json(os.path.join(BASE, "NamingSystems", fn))
        rt = d.get("resourceType")
        rid = d.get("id")
        name = d.get("title") or d.get("name") or rid
        ns_entries.append({
            "reference": {"reference": f"{rt}/{rid}"},
            "name": name,
            "description": describe(d, "NamingSystem: "),
            "exampleBoolean": False,
        })

    # Profile title map for example descriptions
    profile_title_by_url = {}
    profile_base_by_url = {}
    for fn in os.listdir(sd_dir):
        d = read_json(os.path.join(sd_dir, fn))
        profile_title_by_url[d.get("url")] = d.get("title") or d.get("name") or d.get("id")
        if d.get("type") != "Extension" and d.get("kind") == "resource":
            profile_base_by_url[d.get("url")] = d.get("type")

    example_entries = []
    skipped = []
    for fn in sorted(os.listdir(os.path.join(BASE, "Examples"))):
        if not fn.endswith(".json"):
            continue
        d = read_json(os.path.join(BASE, "Examples", fn))
        rt = d.get("resourceType")
        rid = d.get("id")
        prof = (d.get("meta") or {}).get("profile") or []
        if not prof:
            skipped.append((fn, "missing meta.profile"))
            continue
        canonical = prof[0]
        ptitle = profile_title_by_url.get(canonical, canonical)
        example_entries.append({
            "reference": {"reference": f"{rt}/{rid}"},
            "name": rid,
            "description": f"Example instance of {ptitle}",
            "exampleCanonical": canonical,
        })

    definition_resources = (
        profile_entries
        + extension_entries
        + operation_entries
        + st_entries
        + cs_entries
        + vs_entries
        + codes_entries
        + ns_entries
        + example_entries
    )

    # Global bindings: one per profile whose base type is a resource
    global_list = []
    for canonical, base_type in sorted(profile_base_by_url.items(), key=lambda x: (x[1], x[0])):
        global_list.append({"type": base_type, "profile": canonical})

    # DependsOn
    depends_on = [{
        "uri": "http://hl7.org/fhir/ImplementationGuide/hl7.fhir.core",
        "packageId": "hl7.fhir.r5.core",
        "version": "5.0.0",
    }]
    need_hl7_term = False
    for vs_fn in os.listdir(os.path.join(BASE, "ValueSets")):
        d = read_json(os.path.join(BASE, "ValueSets", vs_fn))
        for inc in (d.get("compose") or {}).get("include", []):
            system = inc.get("system", "")
            if (system.startswith("http://terminology.hl7.org/")
                    or system.startswith("http://loinc.org")
                    or system.startswith("http://snomed.info/sct")):
                need_hl7_term = True
                break
        if need_hl7_term:
            break
    if need_hl7_term:
        depends_on.append({
            "uri": "http://hl7.org/fhir/ImplementationGuide/hl7.terminology.r5",
            "packageId": "hl7.terminology.r5",
            "version": "6.0.0",
        })

    ig = {
        "resourceType": "ImplementationGuide",
        "id": IG_ID,
        "url": IG_URL,
        "version": IG_VERSION,
        "name": f"{SERVICE_NAME}ImplementationGuide",
        "title": "HL7 Identification Service FHIR R5 Implementation Guide",
        "status": "draft",
        "experimental": True,
        "date": IG_DATE,
        "publisher": "HL7 International",
        "contact": [
            {
                "name": "HL7 HSRA -- SFM2FHIR-PSM pipeline",
                "telecom": [
                    {"system": "email", "value": "noreply@example.org"}
                ],
            }
        ],
        "description": (
            "FHIR R5 Implementation Guide for the HL7 Identification Service (IS), "
            "mapping the HSRA E2 IS SFM to FHIR resources including Patient, Person, "
            "Organization, Linkage, SubscriptionTopic, Subscription, and Basic-derived "
            "resources. Declares REST interactions, custom $merge/$unmerge operations, "
            "and standard Patient-$match / Patient-$everything operations. Generated by "
            "the SFM2FHIR-PSM pipeline from the IdentificationService SysML v2 PIM."
        ),
        "packageId": IG_ID,
        "license": "CC0-1.0",
        "fhirVersion": [FHIR_VERSION],
        "dependsOn": depends_on,
        "global": global_list,
        "definition": {"resource": definition_resources},
    }

    with open(os.path.join(BASE, "ImplementationGuide.json"), "w", encoding="utf-8") as f:
        json.dump(ig, f, indent=2, ensure_ascii=False)
        f.write("\n")

    pkg = {
        "name": IG_ID,
        "version": IG_VERSION,
        "description": "HL7 Identification Service FHIR R5 IG -- generated by SFM2FHIR-PSM",
        "type": "fhir.ig",
        "canonical": IG_URL,
        "fhirVersions": [FHIR_VERSION],
        "dependencies": {"hl7.fhir.r5.core": "5.0.0"},
        "license": "CC0-1.0",
        "author": "HL7 HSRA -- SFM2FHIR-PSM pipeline",
        "maintainers": [{"name": "HL7 International", "email": "noreply@example.org"}],
    }
    if need_hl7_term:
        pkg["dependencies"]["hl7.terminology.r5"] = "6.0.0"

    with open(os.path.join(BASE, "package.json"), "w", encoding="utf-8") as f:
        json.dump(pkg, f, indent=2, ensure_ascii=False)
        f.write("\n")

    with open(os.path.join(BASE, "ig.ini"), "w", encoding="utf-8", newline="\n") as f:
        f.write("[IG]\n")
        f.write("ig = ImplementationGuide.json\n")
        f.write("template = hl7.fhir.template#current\n")

    print("Counts per type:")
    print(f"  Profiles: {len(profile_entries)}")
    print(f"  Extensions: {len(extension_entries)}")
    print(f"  Operations: {len(operation_entries)}")
    print(f"  SubscriptionTopics: {len(st_entries)}")
    print(f"  CapabilityStatement: {len(cs_entries)}")
    print(f"  ValueSets: {len(vs_entries)}")
    print(f"  CodeSystems: {len(codes_entries)}")
    print(f"  NamingSystems: {len(ns_entries)}")
    print(f"  Examples: {len(example_entries)}")
    print(f"  TOTAL definition.resource entries: {len(definition_resources)}")
    print(f"  Global bindings: {len(global_list)}")
    print(f"  DependsOn packages: {len(depends_on)}")
    if skipped:
        print("SKIPPED:")
        for fn, reason in skipped:
            print(f"  {fn}: {reason}")
    print("hl7.terminology.r5 dependency needed:", need_hl7_term)


if __name__ == "__main__":
    main()
