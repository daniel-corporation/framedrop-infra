resource "aws_sns_topic" "status_notification" {
  name         = var.topic_name
  display_name = "Notificação de Status de Processo"

  tags = var.tags
}
