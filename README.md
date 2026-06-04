# HL7 SFM to SysML V2 models transformation agents

The purpose of this agent chain is to transform HL7 Service Functional Models created by HL7-OSA (https://tinyurl.com/2ynpnep4) into SysML v2 models and also into Draft HL7 Implementation Guide (IG) specifications.

The agents chain is part of the Healthcare Services Reference Model (HSRA) Edition 2 project.

## Goals

The new edition takes into account the emerging LLM technology. Two aspects are relevant for our perspective:

 - When we talk about AI-assisted software engineering or specification-driven development, we are emphasizing that in an LLM world, structurally, architecture comes before code (spec→arch→code). It may seem obvious, but it has not been the case in the real world until now.
 - Despite the vibing hype: "The reliability of a prompt chain is highly dependent on the integrity of the data passed between steps. If the output of one prompt is ambiguous or poorly formatted, the subsequent prompt may fail due to faulty input. To mitigate this, specifying a structured output format ... this is crucial." (Antonio Gulli, Agentic Design Patterns, Springer, 2025).

The trivial *vibecoding* request-response pattern in a chat is not enough if we need to build a real system, not just get a simple answer for a simple application; so, structured languages are fundamental.

The basic idea behind HSRA E2 is that LLMs imply a fundamental reorientation in the way architectures can be built and standards can be used.

The used approach, even if designed independently, is consistent with the so-called Long-Running Agents (Addy Osmani).

## Project site

https://shorturl.at/QNbqs

## status

Alpha 1
