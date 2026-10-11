# Terraform Examples and Modules for Bitbucket Cloud

This repository provides end-to-end blueprints and a suite of Terraform modules for Bitbucket Cloud, which support different use cases:

- workspace-wide landing zone toolkit used to bootstrap real-world Bitbucket foundations and access governance
- a comprehensive source of lean modules that lend themselves well to changes

The whole repository is meant to be cloned as a single unit, and then forked into separate owned repositories to seed production usage, or used as-is and periodically updated as a complete toolkit for prototyping and team onboarding.

## Workspace Governance Toolkit

Setting up a production-ready Bitbucket Cloud workspace is often a time-consuming and error-prone process. The Workspace Governance Toolkit aims to speed up this process via two complementary goals:

1. **Standardized Architecture**: Providing an enterprise design for Bitbucket Cloud that includes the governance controls required by enterprise teams—standardized project hierarchies, declarative branching models, mandatory branch restrictions, and least-privilege permission sets.
2. **Reference Implementation**: Providing a production-ready, declarative reference implementation of this design using Terraform.

## Modules

The suite of modules in this repository is designed for rapid composition and reuse, and to be reasonably simple and readable so that they can be forked and customized where the use of third-party code and sources is restricted.

All modules share a similar interface adhering to Cloud Foundation Fabric patterns:

- **Provider-aligned**: Modules stay close to the underlying provider resources without introducing unnecessary layers of abstraction.
- **Integrated Access Control**: Access control (group and user permissions) is managed alongside resource creation rather than fragmented across disparate manifests.
- **Multi-resource composition**: Where appropriate, modules support configuring child resources (e.g., repositories, branch restrictions, and branching models within projects) in a single declaration.
- **Side-effect free**: Modules are pure Terraform and completely free of external scripts or local exec commands.

### Currently Available Modules

- **foundational & workspace** – `workspace` (workspace settings, permission boundaries, and baseline configuration)
- **governance & structure** – `project` (project lifecycle, project-level permissions, default reviewers, and project branching models)
- **identity & access** – `groups` (user access groups, admin groups, and member assignments)
- **source control & policies** – `project.repositories` (repository provisioning, repository group/user permissions, branch restrictions, and merge guardrails)

### Usage Blueprint

An end-to-end reference implementation demonstrating how to orchestrate the workspace, groups, projects, and repositories is available in the `usage` directory.

```hcl
module "project" {
  source = "./modules/project"

  workspace   = "my-workspace"
  key         = "CORE"
  name        = "Core Platform"
  description = "Core services and platform tooling"

  # ...
}
```

For detailed input specifications, attributes, and examples, see each module's respective `README.md`.
