variable "aws_access_key_id" {
  description = "Terraform Cloud AWS Access Key ID"
  sensitive   = true
  type        = string
}

variable "aws_default_tags" {
  default = {
    github_repository = "https://github.com/BlueRaven1975/tf-ravenconsulting"
    tfe_workspace     = "tf-ravenconsulting"
  }
  description = "Tags to be applied to all the resources created by the code"
  type        = map(string)
}

variable "aws_secret_access_key" {
  description = "Terraform Cloud AWS Secret Access Key"
  sensitive   = true
  type        = string
}

variable "aws_region" {
  default     = "eu-central-1"
  description = "AWS region in which the resources are to be deployed"
  type        = string
}
