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