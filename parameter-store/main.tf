resource "aws_ssm_parameter" "bucket_name" {
  name  = "/framedrop/infra/bucket_name"
  type  = "String"
  value = var.bucket_name

}


resource "aws_ssm_parameter" "sqs_video_processing_queue_url" {
  name  = "/framedrop/infra/sqs_video_processing_queue_url"
  type  = "String"
  value = var.sqs_video_processing_queue_url
  
}

resource "aws_ssm_parameter" "upload_api_base_url" {
  name  = "/framedrop/infra/upload_api_base_url"
  type  = "String"
  value = var.upload_api_base_url
  
}