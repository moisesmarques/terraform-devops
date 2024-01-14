######## FilesResponseQueue Queue (name=filesResponseQueue)

resource "aws_sqs_queue" "filesResponseQueue" {
    name                       = "filesResponseQueue"
    visibility_timeout_seconds = 30
    message_retention_seconds  = 345600
    max_message_size           = 262144

    tags = {
        Name = "filesResponseQueue"
        Environment = var.environment
    }
    lifecycle {
    prevent_destroy = true
    }    
}

######## SSM Parameters to be used 

resource "aws_ssm_parameter" "near-filesResponseQueue-arn" {
  name        = "/files-service/sqs/filesResponseQueue/arn"
  type        = "String"
  value       = aws_sqs_queue.filesResponseQueue.arn
}