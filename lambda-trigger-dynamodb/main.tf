# Buscar a role LabRole existente
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

# Criar arquivo ZIP da função Lambda
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/statusprocess_trigger.py"
  output_path = "${path.module}/statusprocess_trigger.zip"
}

# Função Lambda
resource "aws_lambda_function" "statusprocess_trigger" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.function_name
  role            = data.aws_iam_role.lab_role.arn
  handler         = "statusprocess_trigger.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime         = "python3.11"
  timeout         = 60

  environment {
    variables = {
      SENDER_EMAIL  = var.sender_email
      SMTP_HOST      = var.smtp_host
      SMTP_PORT      = tostring(var.smtp_port)
      SMTP_APP_TOKEN = var.smtp_app_token
    }
  }

  tags = var.tags
}

# Event Source Mapping - Liga DynamoDB Stream à Lambda
resource "aws_lambda_event_source_mapping" "dynamodb_trigger" {
  event_source_arn  = var.dynamodb_stream_arn
  function_name     = aws_lambda_function.statusprocess_trigger.arn
  starting_position = "LATEST"
  
  # Filtrar apenas eventos que alteram statusProcess
  filter_criteria {
    filter {
      pattern = jsonencode({
        eventName = ["INSERT", "MODIFY"]
      })
    }
  }

  batch_size                         = 10
  maximum_batching_window_in_seconds = 1
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 7

  tags = var.tags
}
