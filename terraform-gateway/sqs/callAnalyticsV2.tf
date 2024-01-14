######## CallAnalyticsV2 Queue (name=callAnalyticsV2)

resource "aws_sqs_queue" "callAnalyticsV2" {
    name                       = "callAnalyticsV2"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 345600
    max_message_size           = 262144

    tags = {
        Name = "callAnalyticsV2"
        Environment = var.environment
    }
    lifecycle {
    prevent_destroy = true
    }    
}

######## SSM Parameters to be used 

resource "aws_ssm_parameter" "near-callAnalyticsV2-arn" {
  name        = "/files-service/sqs/callAnalyticsV2/arn"
  type        = "String"
  value       = aws_sqs_queue.callAnalyticsV2.arn
}