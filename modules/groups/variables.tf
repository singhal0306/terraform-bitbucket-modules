variable "auto_add" {
  description = "Whether to automatically add repositories."
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the Bitbucket project."
  type        = string
}

variable "permissions" {
  description = "A map where the key is the repository name and the value is another map of group slugs to permission levels."
  type        = string
  default     = null
}

variable "workspace" {
  description = "The slug or UUID of the workspace."
  type        = string
}
