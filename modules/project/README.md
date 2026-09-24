# Bitbucket Project Module

This module manages a Bitbucket project, its associated repositories, and branch restrictions following Cloud Foundation Fabric patterns.

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

  workspace           = "my-workspace"
  project_key         = "PRJ"
  project_name        = "Core Platform"
  project_description = "Core platform repositories"

  repositories = {
    "service-a" = {
      description = "Service A repo"
      is_private  = true
    }
  }

  branch_restrictions = {
    "service-a" = [
      {
        kind    = "push"
        pattern = "main"
        groups  = ["administrators"]
      }
    ]
  }

  project_group_permissions = {
    "dev-leads" = "admin"
  }

  project_user_permissions = {
    "{user-uuid-here}" = "write"
  }

  project_default_reviewers = ["{user-uuid-here}"]

  repository_group_permissions = {
    "service-a" = {
      "developers" = "write"
    }
  }

  repository_user_permissions = {}
}
```

## Requirements

| Name      | Version  |
| --------- | -------- |
| terraform | >= 1.5.0 |
| bitbucket | >= 1.2.0 |

## Inputs

| Name                         | Description                                          | Type               | Default | Required |
| ---------------------------- | ---------------------------------------------------- | ------------------ | ------- | :------: |
| workspace                    | The slug or UUID of the workspace.                   | `string`           | n/a     |   yes    |
| project_key                  | The key for the Bitbucket project.                   | `string`           | n/a     |   yes    |
| project_name                 | The name of the Bitbucket project.                   | `string`           | n/a     |   yes    |
| project_description          | Optional description for the project.                | `string`           | `null`  |    no    |
| repositories                 | Map of repositories to create within the project.    | `map(...)`         | `{}`    |    no    |
| branch_restrictions          | Map of repository branch restriction configurations. | `map(list(...))`   | `{}`    |    no    |
| project_group_permissions    | Permissions for groups at project level.             | `map(string)`      | `{}`    |    no    |
| project_user_permissions     | Permissions for users at project level.              | `map(string)`      | `{}`    |    no    |
| project_default_reviewers    | List of user UUIDs as project default reviewers      | `list(string)`     | `[]`    |    no    |
| repository_group_permissions | Repo-level group permissions map.                    | `map(map(string))` | `{}`    |    no    |
| repository_user_permissions  | Repo-level user permissions map.                     | `map(map(string))` | `{}`    |    no    |

## Outputs

| Name                         | Description                                               |
| ---------------------------- | --------------------------------------------------------- |
| id                           | The ID of the Bitbucket project.                          |
| project                      | The created Bitbucket project resource.                   |
| repositories                 | A map of the created repository resources, keyed by name. |
| repository_names             | A map of repository names created in this project.        |
| project_group_permissions    | The project group permissions created.                    |
| project_user_permissions     | The project user permissions created.                     |
| project_default_reviewers    | The project default reviewers created.                    |
| repository_group_permissions | The repository group permissions created.                 |
| repository_user_permissions  | The repository user permissions created.                  |
