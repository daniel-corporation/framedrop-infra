resource "aws_ecr_repository" "ecr_framedrop_upload_app" {
  name                 = "framedrop-upload-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "ecr_framedrop_video_processing_app" {
  name                 = "framedrop-video-processing-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.ecr_framedrop_upload_app.repository_url
}

output "ecr_repository_url_video_processing_app" {
  value = aws_ecr_repository.ecr_framedrop_video_processing_app.repository_url
}