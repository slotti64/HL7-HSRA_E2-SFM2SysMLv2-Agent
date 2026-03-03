# HL7 SFM to SysML V2 model transformation agent
## HL7-HSRA_E2-SFM2SysMLv2-Agent

The purpose of this agent is to transform HL7 Service Functional Models created by HL7-OSA (https://tinyurl.com/2ynpnep4) into SysML v2 models.

The agent is part of the Healthcare Services Reference Model (HSRA) Edition 2 project.

## Goals

The new Edition take in account the emerging LLM tecnology. Two aspect are relevat for our perspective:

- When we talk about AI-assisted software engineering or specification-driven development, we are emphasizing that in an LLM world, structurally, architecture comes before code (spec→arch→code). It may seem obvious, but it has not been the case in the real world until now.
- Despite the vibing hype: "The reliability of a prompt chain is highly dependent on the integrity of the data passed between steps. If the output of one prompt is ambiguous or poorly formatted, the subsequent prompt may fail due to faulty input. To mitigate this, specifying a structured output format ... this is crucial." (Antonio Gulli, Agentic Design Patterns, Springer, 2025).
The rivial vibecoding request-response pattern in a chat is not enough if we need to build a real system, not just get a simple answer for a simple application; structured languages are fundamental.

So, the basic idea behind HSRA E2 is that LLMs imply a fundamental reorientation in the way architectures can be built and standards can be used

## Project site

https://tinyurl.com/28kcwm7e


## status

Alpha 1