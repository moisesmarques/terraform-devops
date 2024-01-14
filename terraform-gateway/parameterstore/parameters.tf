######## SSM Parameters to be used 
resource "aws_ssm_parameter" "near-secret-key" {
  name  = "SECRET_KEY"
  type  = "String"
  value = "MyAwesomeKey"
}

resource "aws_ssm_parameter" "near-refresh-secret-key" {
  name  = "REFRESH_SECRET_KEY"
  type  = "String"
  value = "MyUltraSecretKey"
}

resource "aws_ssm_parameter" "near-from-email-address" {
  name  = "FROM_EMAIL_ADDRESS"
  type  = "String"
  value = "account@nearlogin.io"
}

