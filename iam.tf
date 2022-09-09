resource "aws_iam_role" "MwaaExecutionRole" {
  name               = "test-role1"
  depends_on         = [aws_s3_bucket.mwaa-bucket]
  path               = "/service-role/"
  assume_role_policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["airflow-env.amazonaws.com","airflow.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "MwaaExecutionPolicy" {
  name        = "test-policy2"
  description = "A test policy"

  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "airflow:PublishMetrics"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:airflow:${var.region}:${var.account_id}:environment/my-${var.env-name}"
    },
    {
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Deny",
      "Resource": ["${aws_s3_bucket.mwaa-bucket.arn}","${aws_s3_bucket.mwaa-bucket.arn}/*"]
    },
    {
      "Action": ["s3:GetObject*","s3:GetBucket*","s3:List*"],
      "Effect": "Allow",
      "Resource": ["${aws_s3_bucket.mwaa-bucket.arn}","${aws_s3_bucket.mwaa-bucket.arn}/*"]
    },
    {
      "Action": [
        "logs:DescribeLogGroups"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents",
              "logs:GetLogEvents",
              "logs:GetLogRecord",
              "logs:GetLogGroupFields",
              "logs:GetQueryResults",
              "logs:DescribeLogGroups"
      ],
      "Effect": "Allow",
      "Resource":  "arn:aws:logs:${var.region}:${var.account_id}:log-group:airflow-my-${var.env-name}"
    },
    {
      "Action": [
        "cloudwatch:PutMetricData"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:GenerateDataKey*",
          "kms:Encrypt"
      ],
      "NotResource": "arn:aws:kms:*:${var.account_id}:key/*",
      "Condition": {
          "StringLike": {
              "kms:ViaService": [
                  "sqs.${var.region}.amazonaws.com"
              ]
          }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.MwaaExecutionRole.name
  policy_arn = aws_iam_policy.MwaaExecutionPolicy.arn
}