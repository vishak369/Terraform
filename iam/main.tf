
resource "aws_iam_user" "user" {
  name = "vk"
}

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_policy" "s3_read_only" {
  name        = "S3ReadOnlyPolicy"
  description = "Provides read-only access to S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::test-bucket",
          "arn:aws:s3:::test-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_s3_read" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}
