"""Stage the SFM2FHIR-PSM FHIR/ artifacts into a directory layout
acceptable to the HL7 IG Publisher.

Layout produced:

    {PSM_OUT}/IG_BUILD/
    ├── ig.ini
    ├── ImplementationGuide.json
    └── input/
        ├── pagecontent/
        │   └── index.md
        └── resources/
            └── <ResourceType>-<id>.json   (one per artifact)

The source layout (under {PSM_OUT}/FHIR/) is left untouched.
"""
import json
import os
import shutil
import sys

SRC = "output/ServiceFunctionalModel_IdentificationService/PSM/FHIR"
DST = "output/ServiceFunctionalModel_IdentificationService/PSM/IG_BUILD"

SOURCE_DIRS = [
    "StructureDefinitions",
    "OperationDefinitions",
    "SubscriptionTopics",
    "ValueSets",
    "CodeSystems",
    "NamingSystems",
    "Examples",
]

ROOT_FILES = [
    "CapabilityStatement.json",
]


def read_json(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def write_json(path, doc):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(doc, f, indent=2, ensure_ascii=False)
        f.write("\n")


def stage_resource(doc, dst_resources_dir):
    rt = doc.get("resourceType")
    rid = doc.get("id")
    if not rt or not rid:
        return None
    out = os.path.join(dst_resources_dir, f"{rt}-{rid}.json")
    write_json(out, doc)
    return out


def main():
    # Clean only the directories we own; leave publisher's temp/ and output/ alone
    # because they may be locked by lingering JVM/Jekyll handles.
    for sub in ("input",):
        p = os.path.join(DST, sub)
        if os.path.isdir(p):
            shutil.rmtree(p)
    for f in ("ig.ini", "ImplementationGuide.json"):
        p = os.path.join(DST, f)
        if os.path.isfile(p):
            os.remove(p)
    os.makedirs(DST, exist_ok=True)

    resources_dir = os.path.join(DST, "input", "resources")
    pagecontent_dir = os.path.join(DST, "input", "pagecontent")
    includes_dir = os.path.join(DST, "input", "includes")
    os.makedirs(resources_dir, exist_ok=True)
    os.makedirs(pagecontent_dir, exist_ok=True)
    os.makedirs(includes_dir, exist_ok=True)

    staged = []

    # 1. Per-folder source artifacts
    for sub in SOURCE_DIRS:
        src_dir = os.path.join(SRC, sub)
        if not os.path.isdir(src_dir):
            continue
        for fn in sorted(os.listdir(src_dir)):
            if not fn.endswith(".json"):
                continue
            doc = read_json(os.path.join(src_dir, fn))
            out = stage_resource(doc, resources_dir)
            if out:
                staged.append((sub, fn, os.path.basename(out)))

    # 2. Root-level resources (CapabilityStatement.json)
    for fn in ROOT_FILES:
        src_file = os.path.join(SRC, fn)
        if not os.path.isfile(src_file):
            continue
        doc = read_json(src_file)
        out = stage_resource(doc, resources_dir)
        if out:
            staged.append(("(root)", fn, os.path.basename(out)))

    # 3. ImplementationGuide.json — copy to IG_BUILD root, but inject a placeholder
    # "url" contact telecom that satisfies hl7.base.template's onGenerate.jira.xslt
    # rule (first url contact telecom must start with the HL7 committee namespace).
    # Our IG isn't actually under any HL7 working group; this URL is purely a
    # template marker to allow the publisher to render the IG.
    ig_src = os.path.join(SRC, "ImplementationGuide.json")
    ig_dst = os.path.join(DST, "ImplementationGuide.json")
    if not os.path.isfile(ig_src):
        sys.exit(f"ERROR: {ig_src} not found")
    ig_doc = read_json(ig_src)
    contacts = ig_doc.get("contact") or []
    if not contacts:
        contacts = [{"name": "HL7 HSRA -- SFM2FHIR-PSM pipeline", "telecom": []}]
    telecoms = contacts[0].setdefault("telecom", [])
    has_committee_url = any(
        t.get("system") == "url"
        and (t.get("value") or "").startswith("http://www.hl7.org/Special/committees/")
        for t in telecoms
    )
    if not has_committee_url:
        # Prepend so it is the FIRST telecom (the XSLT rule checks the first url telecom)
        telecoms.insert(0, {
            "system": "url",
            "value": "http://www.hl7.org/Special/committees/fhir-i",
        })
    ig_doc["contact"] = contacts
    write_json(ig_dst, ig_doc)

    # 4. ig.ini at IG_BUILD root
    with open(os.path.join(DST, "ig.ini"), "w", encoding="utf-8", newline="\n") as f:
        f.write("[IG]\n")
        f.write("ig = ImplementationGuide.json\n")
        f.write("template = hl7.base.template#current\n")

    # 5. Minimal narrative landing page
    idx = os.path.join(pagecontent_dir, "index.md")
    with open(idx, "w", encoding="utf-8", newline="\n") as f:
        f.write("# HL7 Identification Service FHIR R5 Implementation Guide\n\n")
        f.write(
            "This Implementation Guide is generated automatically by the "
            "**SFM2FHIR-PSM** pipeline from the HSRA E2 Identification Service "
            "Service Functional Model and its derived SysML v2 PIM.\n\n"
        )
        f.write(
            "It declares the FHIR R5 resources, profiles, extensions, "
            "operations, subscription topics, value sets, code systems, naming "
            "systems, and a CapabilityStatement that together specify the "
            "Identification Service.\n\n"
        )
        f.write("## Contents\n\n")
        f.write("- **Profiles** — FHIR R5 StructureDefinitions for each PIM data class\n")
        f.write("- **Extensions** — Custom extensions for attributes not covered by base resources\n")
        f.write("- **Operations** — Patient `$merge`, `$unmerge`, `$everything`, `$match`\n")
        f.write("- **SubscriptionTopics** — Identity update notification topic\n")
        f.write("- **Terminology** — ValueSets, CodeSystems, NamingSystems\n")
        f.write("- **CapabilityStatement** — Service capability declaration\n")
        f.write("- **Examples** — Reference instances for each profile\n")

    # 5b. Provide a minimal menu.xml so Jekyll templates that {% include menu.xml %}
    # work even when no menu auto-generator is supplied by the template.
    menu_path = os.path.join(includes_dir, "menu.xml")
    with open(menu_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(
            '<ul xmlns="http://www.w3.org/1999/xhtml" class="navbar-nav">\n'
            '  <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>\n'
            '  <li class="nav-item"><a class="nav-link" href="artifacts.html">Artifacts</a></li>\n'
            '  <li class="nav-item"><a class="nav-link" href="capabilitystatement-IdentificationService.html">CapabilityStatement</a></li>\n'
            '</ul>\n'
        )

    # 6. Report
    print(f"Staged {len(staged)} resource files into {resources_dir}")
    by_subdir = {}
    for sub, _src, dst_name in staged:
        by_subdir.setdefault(sub, []).append(dst_name)
    for sub in sorted(by_subdir):
        print(f"  {sub}: {len(by_subdir[sub])}")
    print()
    print(f"IG root: {DST}")
    print(f"  ig.ini")
    print(f"  ImplementationGuide.json")
    print(f"  input/resources/         ({len(staged)} files)")
    print(f"  input/pagecontent/index.md")


if __name__ == "__main__":
    main()
