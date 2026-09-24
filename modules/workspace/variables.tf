variable "workspace_slug" {
  description = "The slug or UUID of the workspace."
  type        = string
}

variable "workspace_name" {
  description = "The name of the workspace."
  type        = string
}

variable "workspace_type" {
  description = "The type of workspace (team, personal)."
  type        = string
  default     = "team"

  validation {
    condition     = contains(["team", "personal"], var.workspace_type)
    error_message = "The workspace_type variable must be either 'team' or 'personal'."
  }
}
