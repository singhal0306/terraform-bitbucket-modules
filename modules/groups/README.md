# Bitbucket Groups Module

This module manages a Bitbucket workspace group and its repository access settings.

## Contents

<!-- BEGIN TOC -->
- [Overview](#overview)
- [Usage](#usage)
- [Variables](#variables)
<!-- END TOC -->

## Overview

The module creates a group in the specified workspace. Repository assignment is controlled by `auto_add` and `permissions`.

## Usage

```hcl
module "group" {
  source = "./modules/groups"

  workspace  = "my-workspace"
  name       = "developers"
  auto_add   = false
  permissions = null
}
# tftest modules=1 resources=1 inventory=authorized_resources.yaml
```
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [name](variables.tf#L23) | The name of the Bitbucket project. | <code>string</code> | ✓ |  |
| [workspace](variables.tf#L34) | The slug or UUID of the workspace. | <code>string</code> | ✓ |  |
| [auto_add](variables.tf#L17) | Whether to automatically add repositories. | <code>bool</code> |  | <code>false</code> |
| [permissions](variables.tf#L28) | A map where the key is the repository name and the value is another map of group slugs to permission levels. | <code>string</code> |  | <code>null</code> |
<!-- END TFDOC -->
