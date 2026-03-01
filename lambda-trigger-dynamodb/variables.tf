variable "function_name" {
  description = "Nome da função Lambda"
  type        = string
  default     = "statusprocess-trigger"
}

variable "dynamodb_stream_arn" {
  description = "ARN do DynamoDB Stream"
  type        = string
}

variable "sender_email" {
  description = "E-mail remetente verificado no SES"
  type        = string
  default     = "noreply@framedrop.com"
}

variable "tags" {
  description = "Tags aplicadas aos recursos Lambda"
  type        = map(string)
  default = {
    Owner       = "dev"
    Environment = "dev"
  }
}
