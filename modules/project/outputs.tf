output "id" {
  description = "The ID of the Bitbucket project."
  value       = bitbucket_project.this.id
}

output "project" {
  description = "The created Bitbucket project resource."
  value       = bitbucket_project.this
}

output "project_default_reviewers" {
  description = "The project default reviewers created."
  value       = one(bitbucket_project_default_reviewers.this)
}

output "project_group_permissions" {
  description = "The project group permissions created."
  value       = bitbucket_project_group_permission.this
}

output "project_user_permissions" {
  description = "The project user permissions created."
  value       = bitbucket_project_user_permission.this
}

output "repositories" {
  description = "A map of the created repository resources, keyed by name."
  value       = bitbucket_repository.this
}

output "repository_group_permissions" {
  description = "The repository group permissions created."
  value       = bitbucket_repository_group_permission.this
}

output "repository_names" {
  description = "A map of repository names created in this project."
  value       = { for k, v in bitbucket_repository.this : k => v.name }
}

output "repository_user_permissions" {
  description = "The repository user permissions created."
  value       = bitbucket_repository_user_permission.this
}

# output "branching_model" {
#   description = "The project branching model resource created."
#   value       = one(bitbucket_project_branching_model.this)
# }
