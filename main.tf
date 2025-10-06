# Organizations
resource "aws_organizations_organization" "this" {

  aws_service_access_principals = [
    "sso.amazonaws.com"
  ]

  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "production" {
  name      = "Production"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "non_production" {
  name      = "Non-Production"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "sandbox" {
  name      = "Sandbox"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "shared_services" {
  name      = "Shared Services"
  parent_id = aws_organizations_organization.this.roots[0].id
}

# IAM Identity Center (SSO)
data "aws_ssoadmin_instances" "this" {}

locals {
  sso_instance_arn  = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

resource "aws_identitystore_group" "developers" {
  identity_store_id = local.identity_store_id
  display_name      = "Developers"
}

resource "aws_identitystore_group" "platform_engineers" {
  identity_store_id = local.identity_store_id
  display_name      = "Platform Engineers"
}

resource "aws_identitystore_user" "romano_romano" {
  identity_store_id = local.identity_store_id

  display_name = "Romano Romano"
  user_name    = "romano.romano"

  name {
    family_name = "Romano"
    given_name  = "Romano"
  }

  emails {
    value = "romano.romano@gmail.com"
  }
}

resource "aws_identitystore_group_membership" "romano_romano_developers" {
  identity_store_id = local.identity_store_id
  group_id          = aws_identitystore_group.developers.group_id
  member_id         = aws_identitystore_user.romano_romano.user_id
}

resource "aws_identitystore_group_membership" "romano_romano_platform_engineers" {
  identity_store_id = local.identity_store_id
  group_id          = aws_identitystore_group.platform_engineers.group_id
  member_id         = aws_identitystore_user.romano_romano.user_id
}
