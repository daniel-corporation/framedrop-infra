output "lambda_function_arn" {
  description = "ARN da função Lambda"
  value       = aws_lambda_function.statusprocess_trigger.arn
}

output "lambda_function_name" {
  description = "Nome da função Lambda"
  value       = aws_lambda_function.statusprocess_trigger.function_name
}

output "lambda_role_arn" {
  description = "ARN da role IAM da Lambda"
  value       = data.aws_iam_role.lab_role.arn
}
