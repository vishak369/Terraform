
resource "aws_iam_user" "user" {
  name = "vk"
}

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user.name
}
