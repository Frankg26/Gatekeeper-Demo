# Gatekeeper-Demo
This repository houses Open Policy Agent (OPA) policies designed for educational purposes, intended for installation in a Google Kubernetes Engine (GKE) cluster on the Google Cloud Platform (GCP) and specifically configured with Gatekeeper.

https://open-policy-agent.github.io/gatekeeper/website/docs/

## Required Tools
* `opa` - A CLI tool that executes OPA unit tests and enables the functionality of the "opa run" executable. https://www.openpolicyagent.org/docs/latest/
* `konstraint` - CLI tool for generating Constraint and ConstraintTemplate. https://github.com/plexsystems/konstraint
* `gator` - CLI tool for running the Gator test suite. https://open-policy-agent.github.io/gatekeeper/website/docs/gator/

## Repository Explanation
* `opa` - Rego code is organized with one folder per policy, which includes both the code and unit tests
* `resources ` - Sample files used by Gator
* `suite` - Gator test suite files
* `yaml` - Constraints and ConstraintTemplates

Note: Folders under `opa/` are named with a "-" separating key words. The `konstraint` tool utilizes the folder name to generate a `ConstraintTemplate` and a `Constraint`. For instance, a folder named `pod-naming` will result in the generation of the `ConstraintTemplate` `template_PodNaming.yaml` and `Constraint` `constraint_PodNaming.yaml`.

## Policy Explanation
Every policy includes the following resources:
* Rego Code - The code that defines the policy is contained in a file named `src.rego`.
* Rego Unit Tests - A set of tests that validate the Rego Code is contained in a file named `src_test.rego`.
* Constraint - A YAML file following the `Constraint` schema. This file defines the type of Kubernetes resources to which the policy applies and outlines the valid input parameters for the associated `ConstraintTemplate`.
* ConstraintTemplate - A YAML file following the `ConstraintTemplate` schema. This file defines new kubernetes kinds that will be referenced in the associated `Constraint`.
* Gator Test File - Performs Gator testing by executing manifests on the `ConstraintTemplate` and `Constraint`.