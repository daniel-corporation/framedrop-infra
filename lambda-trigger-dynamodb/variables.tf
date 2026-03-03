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
  description = "E-mail remetente para envio via SMTP (injetado via pipeline)"
  type        = string
}

variable "smtp_host" {
  description = "Host do servidor SMTP"
  type        = string
  default     = "smtp.gmail.com"
}

variable "smtp_port" {
  description = "Porta do servidor SMTP (465 para SSL/TLS, injetada via pipeline)"
  type        = number
}

variable "smtp_app_token" {
  description = "Token de aplicativo para autenticação SMTP (injetado via pipeline)"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags aplicadas aos recursos Lambda"
  type        = map(string)
  default = {
    Owner       = "dev"
    Environment = "dev"
  }
}
