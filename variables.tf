variable "sender_email" {
  description = "E-mail remetente para envio via SMTP (injetado via pipeline)"
  type        = string
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
