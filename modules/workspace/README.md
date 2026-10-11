# Bitbucket Workspace Module

This module looks up a Bitbucket workspace by its slug and exposes the resolved workspace identifier.

## Contents

<!-- BEGIN TOC -->
- [Overview](#overview)
- [Usage](#usage)
- [Variables](#variables)
- [Outputs](#outputs)
<!-- END TOC -->

## Overview

The module uses the Bitbucket provider's workspace data source; it does not create or modify the workspace.

## Usage

```hcl
module "workspace" {
  source = "./modules/workspace"

  slug = "my-workspace"
}
# tftest modules=1 resources=1 inventory=authorized_resources.yaml
```
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [slug](variables.tf#L1) | The slug or UUID of the workspace. | <code>string</code> | ✓ |  |

## Outputs

| name | description | sensitive |
|---|---|:---:|
| [slug](outputs.tf#L1) | The workspace slug. |  |
| [workspace](outputs.tf#L6) | The workspace. |  |
<!-- END TFDOC -->
