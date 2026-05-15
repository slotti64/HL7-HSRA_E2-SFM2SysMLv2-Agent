"""Write a hand-crafted index.html landing page into the published IG output.

The HL7 IG Publisher generates per-resource detail pages (StructureDefinition-*.html,
CodeSystem-*.html, etc.) but does not produce a top-level index.html unless the
ImplementationGuide declares a definition.page tree. Adding such a tree triggers
the Jira XSLT post-processor in hl7.base.template to fail. This script bypasses
that path: after the publisher succeeds, we walk the staged resources and emit
a clean landing page that links to every rendered resource page.

The page reuses the publisher's own stylesheets (fhir.css + assets/css/*) so it
visually matches the rest of the IG.
"""
import json
import os
from collections import defaultdict

IG_BUILD = "output/ServiceFunctionalModel_IdentificationService/PSM/IG_BUILD"
RESOURCES_DIR = os.path.join(IG_BUILD, "input", "resources")
OUTPUT_DIR = os.path.join(IG_BUILD, "output")


def read_json(p):
    with open(p, "r", encoding="utf-8") as f:
        return json.load(f)


def main():
    profiles_by_base = defaultdict(list)
    extensions = []
    code_systems = []
    value_sets = []
    naming_systems = []
    operations = []
    subscription_topics = []
    capability_statements = []
    examples = []

    for fn in sorted(os.listdir(RESOURCES_DIR)):
        if not fn.endswith(".json"):
            continue
        d = read_json(os.path.join(RESOURCES_DIR, fn))
        rt = d.get("resourceType")
        rid = d.get("id")
        if not rt or not rid:
            continue
        title = d.get("title") or d.get("name") or rid
        desc = (d.get("description") or "").split("\n")[0].strip()[:240]
        page = f"{rt}-{rid}.html"

        # Skip files whose rendered HTML doesn't exist
        if not os.path.isfile(os.path.join(OUTPUT_DIR, page)):
            continue

        entry = {"id": rid, "title": title, "page": page, "desc": desc}

        if rt == "StructureDefinition":
            if d.get("type") == "Extension":
                extensions.append(entry)
            else:
                base = d.get("type") or "Other"
                profiles_by_base[base].append(entry)
        elif rt == "CodeSystem":
            code_systems.append(entry)
        elif rt == "ValueSet":
            value_sets.append(entry)
        elif rt == "NamingSystem":
            naming_systems.append(entry)
        elif rt == "OperationDefinition":
            operations.append(entry)
        elif rt == "SubscriptionTopic":
            subscription_topics.append(entry)
        elif rt == "CapabilityStatement":
            capability_statements.append(entry)
        else:
            examples.append({**entry, "type": rt})

    def section(title, items, anchor):
        if not items:
            return ""
        rows = "\n".join(
            f"      <tr><td><a href=\"{e['page']}\">{e['title']}</a></td>"
            f"<td>{e['desc'] or '&nbsp;'}</td></tr>"
            for e in items
        )
        return f"""
  <h3 id="{anchor}">{title} <small>({len(items)})</small></h3>
  <table class="grid">
    <thead><tr><th style="width:32%">Name</th><th>Description</th></tr></thead>
    <tbody>
{rows}
    </tbody>
  </table>
"""

    # Profiles section, grouped by FHIR base resource
    profiles_html_parts = []
    for base in sorted(profiles_by_base.keys()):
        rows = "\n".join(
            f"      <tr><td><a href=\"{e['page']}\">{e['title']}</a></td>"
            f"<td>{e['desc'] or '&nbsp;'}</td></tr>"
            for e in profiles_by_base[base]
        )
        profiles_html_parts.append(f"""
  <h4>Profiles on <code>{base}</code> <small>({len(profiles_by_base[base])})</small></h4>
  <table class="grid">
    <thead><tr><th style="width:32%">Name</th><th>Description</th></tr></thead>
    <tbody>
{rows}
    </tbody>
  </table>
""")

    profile_count = sum(len(v) for v in profiles_by_base.values())

    nav_links = []
    if capability_statements:
        nav_links.append('<a href="#capabilitystatements">CapabilityStatement</a>')
    if profile_count:
        nav_links.append(f'<a href="#profiles">Profiles ({profile_count})</a>')
    if extensions:
        nav_links.append(f'<a href="#extensions">Extensions ({len(extensions)})</a>')
    if operations:
        nav_links.append(f'<a href="#operations">Operations ({len(operations)})</a>')
    if subscription_topics:
        nav_links.append(f'<a href="#subscriptiontopics">SubscriptionTopics ({len(subscription_topics)})</a>')
    if value_sets:
        nav_links.append(f'<a href="#valuesets">ValueSets ({len(value_sets)})</a>')
    if code_systems:
        nav_links.append(f'<a href="#codesystems">CodeSystems ({len(code_systems)})</a>')
    if naming_systems:
        nav_links.append(f'<a href="#namingsystems">NamingSystems ({len(naming_systems)})</a>')
    if examples:
        nav_links.append(f'<a href="#examples">Examples ({len(examples)})</a>')
    nav_links.append('<a href="qa.html">QA Report</a>')

    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>HL7 Identification Service FHIR R5 Implementation Guide</title>
  <link rel="stylesheet" href="assets/css/bootstrap-fhir.css">
  <link rel="stylesheet" href="fhir.css">
  <style>
    body {{ padding: 1.5rem 2rem; max-width: 1200px; margin: 0 auto; }}
    h1 {{ border-bottom: 2px solid #d62728; padding-bottom: 0.4rem; }}
    .nav-pills {{ margin: 1rem 0 2rem 0; }}
    .nav-pills a {{
      display: inline-block; margin: 0 0.5rem 0.5rem 0;
      padding: 0.3rem 0.7rem; background: #f4f4f4;
      border-radius: 3px; text-decoration: none; color: #333;
      font-size: 0.9rem;
    }}
    .nav-pills a:hover {{ background: #d62728; color: white; }}
    table.grid {{ width: 100%; margin-bottom: 1.5rem; border-collapse: collapse; }}
    table.grid th {{ background: #f4f4f4; text-align: left; padding: 0.4rem 0.6rem; border-bottom: 2px solid #ccc; }}
    table.grid td {{ padding: 0.35rem 0.6rem; border-bottom: 1px solid #eee; vertical-align: top; }}
    h3 {{ margin-top: 2rem; color: #333; }}
    h4 {{ margin-top: 1.5rem; color: #555; font-weight: normal; }}
    code {{ background: #f4f4f4; padding: 0.1rem 0.3rem; border-radius: 2px; font-size: 0.9em; }}
    .lead {{ font-size: 1.05rem; color: #555; }}
    .meta {{ color: #888; font-size: 0.85rem; }}
  </style>
</head>
<body>
  <h1>HL7 Identification Service</h1>
  <p class="lead">FHIR R5 Implementation Guide — generated from the HSRA E2 Identification Service SFM via the SFM2FHIR-PSM pipeline.</p>
  <p class="meta">
    Package: <code>hl7.fhir.eu.identificationservice@0.1.0</code> &middot;
    Status: <code>draft</code> &middot;
    FHIR R5 (5.0.0)
  </p>

  <div class="nav-pills">
    {' '.join(nav_links)}
  </div>

  <p>This Implementation Guide is generated automatically by the <strong>SFM2FHIR-PSM</strong> pipeline
  from the HL7 HSRA E2 Identification Service Service Functional Model and its derived SysML v2 PIM.
  It declares the FHIR R5 resources, profiles, extensions, operations, subscription topics, value sets,
  code systems, naming systems, and a CapabilityStatement that together specify the Identification Service.</p>

  {section('CapabilityStatement', capability_statements, 'capabilitystatements')}

  <h3 id="profiles">Profiles <small>({profile_count})</small></h3>
  {''.join(profiles_html_parts)}

  {section('Extensions', extensions, 'extensions')}
  {section('Operations', operations, 'operations')}
  {section('SubscriptionTopics', subscription_topics, 'subscriptiontopics')}
  {section('ValueSets', value_sets, 'valuesets')}
  {section('CodeSystems', code_systems, 'codesystems')}
  {section('NamingSystems', naming_systems, 'namingsystems')}
  {section('Examples', examples, 'examples')}

  <hr>
  <p class="meta">Generated {os.path.basename(__file__)} — see <a href="qa.html">qa.html</a> for the publisher's validation report.</p>
</body>
</html>
"""

    out_path = os.path.join(OUTPUT_DIR, "index.html")
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(html)
    print(f"Wrote {out_path}")
    print(f"  CapabilityStatements: {len(capability_statements)}")
    print(f"  Profiles: {profile_count} (across {len(profiles_by_base)} base types)")
    print(f"  Extensions: {len(extensions)}")
    print(f"  Operations: {len(operations)}")
    print(f"  SubscriptionTopics: {len(subscription_topics)}")
    print(f"  ValueSets: {len(value_sets)}")
    print(f"  CodeSystems: {len(code_systems)}")
    print(f"  NamingSystems: {len(naming_systems)}")
    print(f"  Examples: {len(examples)}")


if __name__ == "__main__":
    main()
