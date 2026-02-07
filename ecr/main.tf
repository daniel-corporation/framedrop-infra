resource "aws_ecr_repository" "ecr_framedrop_upload_app" {
  name                 = "framedrop-upload-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.ecr_framedrop_upload_app.repository_url
}