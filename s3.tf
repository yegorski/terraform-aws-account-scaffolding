resource "aws_s3_bucket" "state" {
  bucket = "yegorski-terraform-state"

  acl    = "bucket-owner-full-control"
  region = "${var.region}"

  tags = "${ var.tags }"
}

data "aws_iam_policy_document" "state" {
  statement {
    sid = "DenyUploadWithoutBucketOwnerFullControlAcl"

    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = ["${ aws_s3_bucket.state.arn }/*"]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-acl"

      values = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "state" {
  bucket = "${ aws_s3_bucket.state.id }"
  policy = "${ data.aws_iam_policy_document.state.json }"
}
