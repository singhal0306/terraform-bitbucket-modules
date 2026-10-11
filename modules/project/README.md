# Bitbucket Project Module

This module manages a Bitbucket project, its associated repositories, and branch restrictions following Cloud Foundation Fabric patterns.

## Contents

<!-- BEGIN TOC -->
- [Features](#features)
- [Usage](#usage)
  - [Repository controls](#repository-controls)
- [Requirements](#requirements)
- [Variables](#variables)
- [Outputs](#outputs)
<!-- END TOC -->

## Features

- Creates and manages a Bitbucket project.
- Creates repositories mapped under the project.
- Configures branch restrictions across specified repositories.
- Configures project-level group and user permissions.
- Configures project default reviewers.
- Configures repository-level group and user permissions.

## Usage

```hcl
module "project" {
  source = "./modules/project"

  workspace = "my-workspace"
  key       = "PRJ"
  name      = "Core Platform"
}
# tftest modules=1 resources=1 inventory=authorized_resources.yaml
```

### Repository controls

```hcl
module "project" {
  source    = "./modules/project"
  workspace = "my-workspace"
  key       = "CORE"
  name      = "Core Platform"

  branching_model = {
    development = {
      use_mainbranch = true
    }
    production = {
      name = "main"
    }
    branch_types = {
      feature = {
        kind   = "feature"
        prefix = "feature/"
      }
    }
  }

  repositories = {
    "service-a" = {
      description = "Core service repository."
      branch_restrictions = [
        {
          kind    = "push"
          pattern = "main"
          groups  = ["developers"]
        }
      ]
      group_permissions = {
        developers = "write"
      }
    }
  }

  project_group_permissions = {
    developers = "write"
  }
  project_user_permissions = {
    "{user-uuid}" = "read"
  }
  project_default_reviewers = ["{user-uuid}"]
}
# tftest modules=1 resources=8 inventory=repository_controls.yaml
```

## Requirements

| Name      | Version  |
| --------- | -------- |
| terraform | >= 1.5.0 |
| bitbucket | >= 1.2.0 |
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [key](variables.tf#L90) | Bitbucket project key. | <code>string</code> | ✓ |  |
| [name](variables.tf#L109) | Bitbucket project name. | <code>string</code> | ✓ |  |
| [workspace](variables.tf#L154) | The slug or UUID Bitbucket workspace that owns the project. | <code>string</code> | ✓ |  |
| [branching_model](variables.tf#L1) | Bitbucket project branching model configuration. | <code>object&#40;&#123;&#8230;&#125;&#41;</code> |  | <code>null</code> |
| [description](variables.tf#L78) | Optional description for the Bitbucket project. | <code>string</code> |  | <code>null</code> |
| [is_private](variables.tf#L84) | Specifies whether the project is private. | <code>bool</code> |  | <code>true</code> |
| [link_avatar](variables.tf#L103) | Optional URL link for the Bitbucket project. | <code>string</code> |  | <code>null</code> |
| [project_default_reviewers](variables.tf#L119) | List of user UUIDs or account IDs to configure as default reviewers for the project. | <code>list&#40;string&#41;</code> |  | <code>&#91;&#93;</code> |
| [project_group_permissions](variables.tf#L125) | Permissions for groups at the project level, keyed by group slug (read, write, admin). | <code>map&#40;string&#41;</code> |  | <code>&#123;&#125;</code> |
| [project_user_permissions](variables.tf#L131) | Permissions for users at the project level, keyed by user UUID or account ID (read, write, admin). | <code>map&#40;string&#41;</code> |  | <code>&#123;&#125;</code> |
| [repositories](variables.tf#L137) | Repositories to create within the project, complete with permissions and branch restrictions. | <code>map&#40;object&#40;&#123;&#8230;&#125;&#41;&#41;</code> |  | <code>&#123;&#125;</code> |

## Outputs

| name | description | sensitive |
|---|---|:---:|
| [id](outputs.tf#L1) | The ID of the Bitbucket project. |  |
| [project](outputs.tf#L6) | The created Bitbucket project resource. |  |
| [project_default_reviewers](outputs.tf#L11) | The project default reviewers created. |  |
| [project_group_permissions](outputs.tf#L16) | The project group permissions created. |  |
| [project_user_permissions](outputs.tf#L21) | The project user permissions created. |  |
| [repositories](outputs.tf#L26) | A map of the created repository resources, keyed by name. |  |
| [repository_group_permissions](outputs.tf#L31) | The repository group permissions created. |  |
| [repository_names](outputs.tf#L36) | A map of repository names created in this project. |  |
| [repository_user_permissions](outputs.tf#L41) | The repository user permissions created. |  |
<!-- END TFDOC -->
