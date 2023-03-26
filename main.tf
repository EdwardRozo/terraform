resource "aws_s3_bucket" "bucket-01" {
  bucket = "efro9640-bucket-202303"

  tags = {
    Name        = "efro9640-bucket-202303"
    Environment = "qa"
  }
}

resource "aws_s3_bucket_acl" "bucket-01-acl" {
  bucket = aws_s3_bucket.bucket-01.id
  acl    = "private"
}

#Bucket WEB
resource "aws_s3_bucket" "bucket-02" {
  bucket = "s3-website-efro9640-bucket-202303.hashicorp.com"
  acl    = "public-read"
  #policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}