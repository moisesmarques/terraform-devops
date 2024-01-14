######## NFTsResponseQueue Queue (name=nftsResponseQueue)

resource "aws_sqs_queue" "nftsResponseQueue" {
    name                       = "nftsResponseQueue"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 345600
    max_message_size           = 262144

    tags = {
        Name = "nftsResponseQueue"
        Environment = var.environment
    }
    lifecycle {
    prevent_destroy = true
    }    
}

######## SSM Parameters to be used 

resource "aws_ssm_parameter" "near-nftsResponseQueue-arn" {
  name        = "/nfts-service/sqs/nftsResponseQueue/arn"
  type        = "String"
  value       = aws_sqs_queue.nftsResponseQueue.arn
}