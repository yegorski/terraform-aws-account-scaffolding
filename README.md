# Terraform AWS Account Scaffolding

Bootstrap your AWS account to start managing it with Terraform.

Given that this repo focuses on new AWS accounts that do not yet use Terraform, this repo is meant to be forkable / copy-pastable instead of being invoked as a module.

This repo uses Terraform version `0.11.14`.

## Overview

Terraform creates the following AWS resources:

1. IAM:
   1. A user with `AdministratorAccess` policy
1. DynamoDB:
   1. A table for tracking Terraform usage. This is a Terraform feature that ensure that no more than one `plan` or `apply` operations are running at the same time.
1. S3:
   1. A bucket for storing Terraform state.
   1. In order to avoid potential permission issues when writing a different AWS account, the `bucket-owner-full-control` ACL is applied to the bucket.
1. VPC
   1. Uses the [AWS VPC Terraform module][], with most of the defaults.
   1. One of the reasons to create a new VPC is to have control over the CIDR range, e.g. when designating all traffic as internal based on destination CIDR `10.x.x.x/8`.

## Usage

1. Fork this repo.
1. In AWS Console, create the S3 bucket where Terraform will its state. Terraform will need this bucket created beforehand, otherwise it will throw an `AccessDenied` error.
1. Export your AWS root user's key id and secret into `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, respectively.
1. Run `terraform init`.
1. Import the state bucket into Terraform `terraform import aws_s3_bucket.bucket bucket-name`
1. Create a `terraform.tfvars` file with the following variables:

   ```terraform
   account_id = "YOUR_AWS_ACCOUNT_ID"

   admin_user = "YOUR_USERNAME"

   region = "YOUR_AWS_REGION"

   tags = {
       Owner       = "YOUR_USERNAME"
       Environment = "production"
       # more tags as desired
   }
   ```

1. Run `terraform apply`.

## AWS Account Usage

After running `terraform apply` ti create the resources using the AWS root user, do not use the root account anymore. Store the root user key id and secret in a safe location and use it in case IAM access fails.

Use the new IAM admin user created in this Terraform script to all future Terraform uses.

In my case I export that user's key and secret into `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you can, it is recommended that you use the [aws-vault][] project to store your role information to access your AWS account without exposing your user's key and secret. In this project, I still export key id and secret because I work in AWS accounts that use the [aws-okta][] project, and its config conflicts with `aws-vault`.

## Notes

If you're using a different version of Terraform Switch between Terraform versions using [tfswitch][].

When using AWS roles instead of AWS users (recommended), create `aws_iam_role` and `aws_iam_role_policy_attachment`, instead of `aws_iam_user` and `aws_iam_user_policy_attachment`.

[aws-okta]: https://github.com/segmentio/aws-okta
[aws-vault]: https://github.com/99designs/aws-vault
[aws vpc terraform module]: https://github.com/terraform-aws-modules/terraform-aws-vpc
[tfswitch]: https://warrensbox.github.io/terraform-switcher
