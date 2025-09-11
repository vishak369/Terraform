resource "aws_ecr_public_repository" "public-repo"{
  repository_name = var.repository_name

  tags = {
    Name        = var.repository_name
    Environment = var.environment
  }
  catalog_data {
    description = "Public ECR Repository"
    architecture = ["ARM64", "X86_64"]
    operating_system = ["Linux"]
    usage_text = "This is a public ECR repository"
  }
}