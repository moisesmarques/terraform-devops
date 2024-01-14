######## CallLogFile Queue (name=callLogFile)

resource "aws_sqs_queue" "callLogFile" {
    name                       = "callLogFile"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 345600
    max_message_size           = 262144

    tags = {
        Name = "callLogFile"
        Environment = var.environment
    }
    lifecycle {
    prevent_destroy = true
    }    
}

######## SSM Parameters to be used 

resource "aws_ssm_parameter" "near-callLogFile-arn" {
  name        = "/files-service/sqs/callLogFile/arn"
  type        = "String"
  value       = aws_sqs_queue.callLogFile.arn
}