resource "bitbucket_group" "this" {
  workspace  = var.workspace
  name       = var.name
  auto_add   = var.auto_add
  permission = var.permissions
}
