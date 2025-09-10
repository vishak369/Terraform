
resource "aws_ecr_repository" "platform_repo" {
  name = "platform-repo"
  image_tag_mutability = "MUTABLE"
   image_scanning_configuration {
    scan_on_push = true
   }

  tags = {
    Environment = "dev"
  }  
}

resource "aws_ecr_lifecycle_policy" "platform_lifecycle_1" {
  repository = aws_ecr_repository.platform_repo.name
  policy = <<EOF
{       
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire untagged images older than 30 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 30
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}

EOF
}


