variable "topic_name" {
  description = "Nome do tópico SNS"
  type        = string
  default     = "status-process-notification"
}

variable "tags" {
  description = "Tags aplicadas ao tópico SNS"
  type        = map(string)
  default = {
    Owner       = "dev"
    Environment = "dev"
  }
}
