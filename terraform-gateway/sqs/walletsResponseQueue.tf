######## WalletsResponseQueue Queue (name=walletsResponseQueue)

resource "aws_sqs_queue" "walletsResponseQueue" {
    name                       = "walletsResponseQueue"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 345600
    max_message_size           = 262144

    tags = {
        Name = "walletsResponseQueue"
        Environment = var.environment
    }
    lifecycle {
    prevent_destroy = true
    }    
}

######## SSM Parameters to be used 

resource "aws_ssm_parameter" "near-walletsResponseQueue-arn" {
  name        = "/wallets-service/sqs/walletsResponseQueue/arn"
  type        = "String"
  value       = aws_sqs_queue.walletsResponseQueue.arn
}