variable "account_id" {
  type        = "string"
  description = "AWS account ID to create resources in."
}

variable "admin_username" {
  type        = "string"
  description = "AWS IAM user which will be granted AdministratorAccess."
}

variable "region" {
  type        = "string"
  description = "AWS region to create resources in."
}

variable "tags" {
  type        = "map"
  description = "AWS tags to apply to resources."
}
