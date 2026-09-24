variable "workspace" {
  description = "The slug or UUID of the workspace."
  type        = string
}

# variable "groups" {
#   description = "A map of groups to manage in the workspace."
#   type = map(object({
#     slug        = string
#     description = optional(string)
#   }))
#   default = {}
# }

variable "name" {
  description = "The name of the Bitbucket project."
  type        = string
}

variable "permissions" {
  description = "A map where the key is the repository name and the value is another map of group slugs to permission levels."
  type        = string
  default     = null
}

# variable "auto_add" {
#   description = "A map of repository names to their resource references."
#   type        = optional(bool, false)
# }

variable "auto_add" {
  description = "Whether to automatically add repositories."
  type        = bool
  default     = false
}
