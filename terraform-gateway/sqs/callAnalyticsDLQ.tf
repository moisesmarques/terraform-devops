######## CallAnalyticsDLQ Queue (name=callAnalyticsDLQ)

resource "aws_sqs_queue" "callAnalyticsDLQ" {
    name                       = "callAnalyticsDLQ"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 345600
    max_message_size           = 262144

    tags = {
        Name = "callAnalyticsDLQ"
        Environment = var.environment
    }

    lifecycle {
    prevent_destroy = true
    }    
}

######## SSM Parameters to be used 

resource "aws_ssm_parameter" "near-callAnalyticsDLQ-arn" {
  name        = "/files-service/sqs/callAnalyticsDLQ/arn"
  type        = "String"
  value       = aws_sqs_queue.callAnalyticsDLQ.arn
}