locals {
  branch_restrictions = merge([
    for repo_name, repo in var.repositories : {
      for i, restriction in repo.branch_restrictions :
      "${repo_name}/${i}" => merge(restriction, { repo_name = repo_name })
    }
  ]...)

  repository_group_permissions = merge([
    for repo_name, repo in var.repositories : {
      for group_slug, permission in repo.group_permissions :
      "${repo_name}/${group_slug}" => {
        repo_name  = repo_name
        group_slug = group_slug
        permission = permission
      }
    }
  ]...)

  repository_user_permissions = merge([
    for repo_name, repo in var.repositories : {
      for user_id, permission in repo.user_permissions :
      "${repo_name}/${user_id}" => {
        repo_name  = repo_name
        user_id    = user_id
        permission = permission
      }
    }
  ]...)
}

resource "bitbucket_project" "this" {
  name        = var.name
  key         = var.key
  owner       = var.workspace
  description = var.description
  is_private  = var.is_private
  dynamic "link" {
    for_each = var.link_avatar != null ? [""] : []
    content {
      avatar {
        href = var.link_avatar
      }
    }
  }
}

resource "bitbucket_project_branching_model" "this" {
  count = var.branching_model != null ? 1 : 0

  workspace = var.workspace
  project   = bitbucket_project.this.key

  dynamic "development" {
    for_each = var.branching_model.development == null ? [] : [var.branching_model.development]

    content {
      name           = development.value.name
      use_mainbranch = development.value.use_mainbranch
    }
  }

  dynamic "production" {
    for_each = var.branching_model.production == null ? [] : [var.branching_model.production]

    content {
      enabled        = true
      name           = try(production.value.name, null)
      use_mainbranch = try(production.value.use_mainbranch, null)
    }
  }

  dynamic "branch_type" {
    for_each = var.branching_model.branch_types

    content {
      enabled = true
      kind    = branch_type.value.kind
      prefix  = try(branch_type.value.prefix, null)
    }
  }
}

resource "bitbucket_project_group_permission" "this" {
  for_each = var.project_group_permissions

  workspace   = var.workspace
  project_key = bitbucket_project.this.key
  group_slug  = each.key
  permission  = each.value
}

resource "bitbucket_project_user_permission" "this" {
  for_each = var.project_user_permissions

  workspace   = var.workspace
  project_key = bitbucket_project.this.key
  user_id     = each.key
  permission  = each.value
}

resource "bitbucket_project_default_reviewers" "this" {
  count = length(var.project_default_reviewers) > 0 ? 1 : 0

  workspace = var.workspace
  project   = bitbucket_project.this.key
  reviewers = var.project_default_reviewers
}

resource "bitbucket_repository" "this" {
  for_each = var.repositories

  owner       = var.workspace
  project_key = bitbucket_project.this.key
  name        = each.key
  description = each.value.description
  is_private  = each.value.is_private
}

resource "bitbucket_branch_restriction" "this" {
  for_each = local.branch_restrictions

  owner      = var.workspace
  repository = try(bitbucket_repository.this[each.value.repo_name].name, each.value.repo_name)
  kind       = each.value.kind
  pattern    = each.value.pattern
  value      = 1

  dynamic "groups" {
    for_each = each.value.groups != null ? each.value.groups : []
    content {
      owner = var.workspace
      slug  = groups.value
    }
  }
}

resource "bitbucket_repository_group_permission" "this" {
  for_each = local.repository_group_permissions

  workspace  = var.workspace
  repo_slug  = try(bitbucket_repository.this[each.value.repo_name].name, each.value.repo_name)
  group_slug = each.value.group_slug
  permission = each.value.permission
}

resource "bitbucket_repository_user_permission" "this" {
  for_each = local.repository_user_permissions

  workspace  = var.workspace
  repo_slug  = try(bitbucket_repository.this[each.value.repo_name].name, each.value.repo_name)
  user_id    = each.value.user_id
  permission = each.value.permission
}
