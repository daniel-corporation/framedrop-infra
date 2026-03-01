resource "aws_s3_bucket" "framedrop_upload" {
  bucket = "framedrop-upload"

  tags = {
    Environment = "dev"
    Project     = "framedrop"
  }
}