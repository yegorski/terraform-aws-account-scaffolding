variable "aws_account_id" {
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

variable "vpc_number_of_azs" {
  type        = "string"
  description = "Number of availability zones to place the VPC in."
}
