variables {
  workspace           = "test-workspace"
  project_key         = "TEST"
  project_name        = "Test Project"
  project_description = "Unit test project description"
  repositories = {
    "repo-one" = {
      description = "Test repository 1"
      is_private  = true
      branch_restrictions = [
        {
          kind    = "push"
          pattern = "main"
          groups  = ["devs"]
        }
      ]
      group_permissions = {
        "developers" = "write"
      }
      user_permissions = {}
    }
  }
  project_group_permissions = {
    "dev-leads" = "admin"
  }
  project_user_permissions = {
    "{user-uuid-1}" = "write"
  }
  project_default_reviewers = ["{user-uuid-1}"]
}

run "plan_validation" {
  command = plan

  assert {
    condition     = bitbucket_project.this.name == "Test Project"
    error_message = "Project name does not match expected variable."
  }

  assert {
    condition     = bitbucket_project.this.key == "TEST"
    error_message = "Project key does not match expected variable."
  }

  assert {
    condition     = length(bitbucket_repository.this) == 1
    error_message = "Expected exactly one repository to be planned."
  }

  assert {
    condition     = bitbucket_branch_restriction.this["repo-one/0"].pattern == "main"
    error_message = "Branch restriction pattern was not set correctly."
  }

  assert {
    condition     = bitbucket_project_group_permission.this["dev-leads"].permission == "admin"
    error_message = "Project group permission does not match expected value."
  }

  assert {
    condition     = contains(bitbucket_project_default_reviewers.this[0].reviewers, "{user-uuid-1}")
    error_message = "Project default reviewer was not planned correctly."
  }

  assert {
    condition     = bitbucket_repository_group_permission.this["repo-one/developers"].permission == "write"
    error_message = "Repository group permission does not match expected value."
  }
}
