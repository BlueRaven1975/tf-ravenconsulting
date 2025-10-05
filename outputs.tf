# Organizations
output "organizations_organization_id" {
  description = "Organization ID"
  value       = aws_organizations_organization.this.id
}

output "ssoadmin_instances_arns" {
  description = "IAM Identity Center instance ARN"
  value       = local.sso_instance_arn
}

# IAM Identity Center (SSO)
output "ssoadmin_instances_identity_store_ids" {
  description = "IAM Identity Center Identity Store ID"
  value       = local.identity_store_id
}
