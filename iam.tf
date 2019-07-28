# resource "aws_iam_role" "admin" {
#   name               = "Admin"
#   description        = "Role with AdministratorAccess policy attached."
#   assume_role_policy = "${ data.aws_iam_policy_document.mfa.json }"

#   max_session_duration = 3600

#   tags = "${ merge(
#     map( "Name", "Admin" ),
#     var.tags ) }"
# }

# data "aws_iam_user_policy" "mfa" {
#   statement {
#     sid = "RequireMfa"

#     principals {
#       type        = "AWS"
#       identifiers = ["${ var.account_id }"]
#     }

#     actions = ["sts:AssumeRole"]

#     condition {
#       test     = "Bool"
#       variable = "aws:SecureTransport"
#       values   = ["true"]
#     }

#     condition {
#       test     = "Bool"
#       variable = "aws:MultiFactorAuthPresent"
#       values   = ["true"]
#     }
#   }
# }

# resource "aws_iam_role_policy_attachment" "administrator_access" {
#   role       = "${ aws_iam_role.admin.name }"
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }

resource "aws_iam_user" "admin" {
  name = "${var.admin_username}"

  tags = "${ merge(
    map( "Name", "Admin" ),
    var.tags ) }"
}

resource "aws_iam_user_policy_attachment" "admin" {
  user       = "${aws_iam_user.admin.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "access_key" {
  user = "${aws_iam_user.admin.name}"
}
