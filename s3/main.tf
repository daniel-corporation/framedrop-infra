resource "aws_s3_bucket" "framedrop_upload" {
  bucket = "framedrop-upload-tst"

  tags = {
    Environment = "dev"
    Project     = "framedrop"
  }
}
