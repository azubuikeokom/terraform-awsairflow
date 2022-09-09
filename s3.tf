resource "aws_s3_bucket" "mwaa-bucket" {
  bucket = "my-test-mwaa-bucket"
  tags = {
    Name        = "MWAA bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.mwaa-bucket.id
  key    = "dags/tutorial.py"
  source = "tutorial.py"
  etag   = filemd5("tutorial.py")
}
resource "aws_s3_bucket_public_access_block" "mwaa-access" {
  bucket = aws_s3_bucket.mwaa-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.mwaa-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}