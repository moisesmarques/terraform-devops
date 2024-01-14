######## CallPostTransaction Queue (name=callPostTransaction)

resource "aws_sqs_queue" "callPostTransaction" {
    name                       = "callPostTransaction"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 345600
    max_message_size           = 262144

    tags = {
        Name = "callPostTransaction"
        Environment = var.environment
    }
    lifecycle {
    prevent_destroy = true
    }    
}

######## SSM Parameters to be used 

resource "aws_ssm_parameter" "near-callPostTransaction-arn" {
  name        = "/files-service/sqs/callPostTransaction/arn"
  type        = "String"
  value       = aws_sqs_queue.callPostTransaction.arn
}