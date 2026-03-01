output "topic_arn" {
  description = "ARN do tópico SNS"
  value       = aws_sns_topic.status_notification.arn
}

output "topic_name" {
  description = "Nome do tópico SNS"
  value       = aws_sns_topic.status_notification.name
}
