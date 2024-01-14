resource "aws_s3_bucket" "s3_frontend_nft_maker_v2" {
  bucket = "s3-frontend-nft-maker-v2"

}

resource "aws_s3_bucket_policy" "s3_frontend_nft_maker_v2_policy" {
  bucket = aws_s3_bucket.s3_frontend_nft_maker_v2.id
  policy = data.aws_iam_policy_document.s3_frontend_nft_maker_v2_policy_document.json
}

data "aws_iam_policy_document" "s3_frontend_nft_maker_v2_policy_document" {
  statement {

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
   
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.s3_frontend_nft_maker_v2.arn,
      "${aws_s3_bucket.s3_frontend_nft_maker_v2.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_cors_configuration" "s3_frontend_nft_maker_v2_cors_config" {
  bucket = aws_s3_bucket.s3_frontend_nft_maker_v2.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_website_configuration" "s3_frontend_nft_maker_v2_website_config" {
  bucket = aws_s3_bucket.s3_frontend_nft_maker_v2.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.s3_frontend_nft_maker_v2.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.s3_frontend_nft_maker_v2.id

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false
  #   bucket          = "mylogs.s3.amazonaws.com"
  #   prefix          = "myprefix"
  # }
  
  # aliases = []

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3_frontend_nft_maker_v2.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.s3_frontend_nft_maker_v2.id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3_frontend_nft_maker_v2.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      # locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}