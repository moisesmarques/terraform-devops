######## CallAnalytics Queue (name=callAnalytics)

resource "aws_sqs_queue" "callAnalytics" {
    name                       = "callAnalytics"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 345600
    max_message_size           = 262144

    tags = {
        Name = "callAnalytics"
        Environment = var.environment
    }

    lifecycle {
    prevent_destroy = true
    }
}

######## SSM Parameters to be used 

resource "aws_ssm_parameter" "near-callAnalytics-arn" {
  name        = "/files-service/sqs/callAnalytics/arn"
  type        = "String"
  value       = aws_sqs_queue.callAnalytics.arn
}