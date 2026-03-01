variable "bucket_name" {
    description = "The name of the SSM Parameter Store bucket."
    type        = string
}

variable "sqs_video_processing_queue_url" {
    description = "The URL of the SQS queue for video processing."
    type        = string
}

variable "upload_api_base_url" {
    description = "The base URL of the upload API."
    type        = string
}