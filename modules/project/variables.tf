variable "workspace" {
  description = "The slug or UUID Bitbucket workspace that owns the project."
  type        = string

  validation {
    condition     = trimspace(var.workspace) != ""
    error_message = "Workspace must not be empty."
  }
}

variable "key" {
  description = "Bitbucket project key."
  type        = string

  validation {
    condition = (
      trimspace(var.key) != "" &&
      length(var.key) <= 255
    )
    error_message = "Project key must be non-empty and no longer than 255 characters."
  }
}

variable "name" {
  description = "Bitbucket project name."
  type        = string

  validation {
    condition     = trimspace(var.name) != ""
    error_message = "Project name must not be empty."
  }
}

variable "description" {
  description = "Optional description for the Bitbucket project."
  type        = string
  default     = null
}

variable "is_private" {
  description = "Specifies whether the project is private."
  type        = bool
  default     = true
}

variable "link_avatar" {
  description = "Optional URL link for the Bitbucket project."
  type        = string
  default     = null
}

variable "repositories" {
  description = "Repositories to create within the project, complete with permissions and branch restrictions."
  type = map(object({
    description = optional(string)
    is_private  = optional(bool, true)
    branch_restrictions = optional(list(object({
      pattern = string
      kind    = string
      groups  = optional(list(string), [])
    })), [])
    group_permissions = optional(map(string), {})
    user_permissions  = optional(map(string), {})
  }))
  nullable = false
  default  = {}
}

variable "project_group_permissions" {
  description = "Permissions for groups at the project level, keyed by group slug (read, write, admin)."
  type        = map(string)
  default     = {}
}

variable "project_user_permissions" {
  description = "Permissions for users at the project level, keyed by user UUID or account ID (read, write, admin)."
  type        = map(string)
  default     = {}
}

variable "project_default_reviewers" {
  description = "List of user UUIDs or account IDs to configure as default reviewers for the project."
  type        = list(string)
  default     = []
}


# --

variable "branching_model" {
  description = "Bitbucket project branching model configuration."

  type = object({
    enabled = optional(bool, false)
    development = optional(object({
      name                = optional(string)
      use_mainbranch      = optional(bool)
    }))

    production = optional(object({
      name                = optional(string)
      use_mainbranch      = optional(bool)
    }))

    branch_types = optional(map(object({
      kind    = string
      prefix  = optional(string)
    })), {})
  })

  default = {}

  validation {
    condition = var.branching_model.development == null || (
      (
        try(var.branching_model.development.use_mainbranch, null) == true &&
        try(var.branching_model.development.name, null) == null
      )
      ||
      (
        try(var.branching_model.development.use_mainbranch, null) == false &&
        try(trimspace(var.branching_model.development.name), "") != ""
      )
      ||
      (
        try(var.branching_model.development.use_mainbranch, null) == null
      )
    )

    error_message = "For development, use_mainbranch=true requires name to be omitted; use_mainbranch=false requires a non-empty name."
  }

  validation {
    condition = var.branching_model.production == null || (
      (
        try(var.branching_model.production.use_mainbranch, null) == true &&
        try(var.branching_model.production.name, null) == null
      )
      ||
      (
        try(var.branching_model.production.use_mainbranch, null) == false &&
        try(trimspace(var.branching_model.production.name), "") != ""
      )
      ||
      (
        try(var.branching_model.production.use_mainbranch, null) == null
      )
    )

    error_message = "For production, use_mainbranch=true requires name to be omitted; use_mainbranch=false requires a non-empty name."
  }

  validation {
    condition = alltrue([
      for branch_type in values(var.branching_model.branch_types) :
      contains(["feature", "bugfix", "release", "hotfix"], branch_type.kind)
    ])

    error_message = "Branch type kind must be one of: feature, bugfix, release, hotfix."
  }

  validation {
    condition = alltrue([
      for branch_type in values(var.branching_model.branch_types) :
      !try(branch_type.enabled, true) || trimspace(try(branch_type.prefix, "")) != ""
    ])

    error_message = "An enabled branch type must have a non-empty prefix."
  }
}