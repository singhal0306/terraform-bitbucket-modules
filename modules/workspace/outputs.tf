output "slug" {
  description = "The workspace slug."
  value       = data.bitbucket_workspace.this.slug
}

output "workspace" {
  description = "The workspace."
  value       = data.bitbucket_workspace.this
}
