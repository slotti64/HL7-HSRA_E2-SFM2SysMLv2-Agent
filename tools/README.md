# tools/ — External Tooling Drop-Zone

This directory is the conventional location for external binaries required by the
PSM pipeline. It is referenced by `.claude/agents/psm_orchestrator.md` and
`.claude/agents/sb5_conformance_validator.md` via the `{FHIR_VALIDATOR_JAR}`
variable (default: `tools/validator_cli.jar`).

Nothing in this directory is required for the SFM→SysML (SA1–SA7) pipeline.
Only the PSM pipeline (SB1-D..SB6-IG) and its conformance gate use these tools.

## Required — HL7 FHIR Validator

`SB5` phase=FHIR invokes the official HL7 FHIR Validator (`validator_cli.jar`)
as its FV-02 check. Without this JAR, the pipeline cannot certify any PSM as
FHIR R5-conformant and will block with `FV-02-MISSING-TOOLING`.

### Install

```
curl -L -o tools/validator_cli.jar \
    https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar
```

Pin to a specific R5 revision instead of `latest` if your PSM targets a pinned
R5 package (recommended for reproducible builds). Release list:
https://github.com/hapifhir/org.hl7.fhir.core/releases

### Run (invoked automatically by SB5 phase=FHIR)

```
java -jar tools/validator_cli.jar \
     -version 5.0.0 \
     -ig {PSM_OUT}/FHIR \
     -output {PSM_OUT}/validator_report.json \
     -recurse
```

### Prerequisites

- JDK 17+ on `PATH` (`java -version` must report ≥ 17).
- Internet access the first time the validator runs, to populate
  `~/.fhir/packages/` with the R5 core package. Subsequent runs work offline.

### Overriding the default path

Set the `FHIR_VALIDATOR_JAR` environment variable before invoking the
`psm_orchestrator`. The orchestrator resolves it at pre-flight:

```
export FHIR_VALIDATOR_JAR=/opt/hl7/validator_cli.jar
```

## Optional — HL7 IG Publisher

`SB6-IG` produces the inputs for the HL7 IG Publisher (`ImplementationGuide.json`,
`package.json`, `ig.ini`). It does NOT run the publisher itself — that is a
downstream manual step for producing browsable HTML documentation.

If you want to publish the generated IG:

```
curl -L -o tools/publisher.jar \
    https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar

java -jar tools/publisher.jar -ig {PSM_OUT}/FHIR/ig.ini
```

The generated HTML IG lands in `{PSM_OUT}/FHIR/output/`.

## .gitignore guidance

The JAR files in this directory are large (~50-100 MB) and version-tagged.
They should be excluded from version control. A `.gitignore` entry covering
`tools/*.jar` is recommended at the repository root. Keep this `README.md`
and any small scripts under version control.
