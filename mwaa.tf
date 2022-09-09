resource "aws_mwaa_environment" "example" {

  max_workers           = var.max-worker-nodes
  webserver_access_mode = "PUBLIC_ONLY"
  dag_s3_path           = "dags/"
  execution_role_arn    = aws_iam_role.MwaaExecutionRole.arn
  name                  = "my-${var.env-name}"

  network_configuration {
    security_group_ids = [aws_security_group.mwaa-sg.id]
    subnet_ids         = [aws_subnet.private-1.id, aws_subnet.private-2.id]
  }

  source_bucket_arn = aws_s3_bucket.mwaa-bucket.arn
  depends_on        = [aws_iam_policy.MwaaExecutionPolicy]
  logging_configuration {
    dag_processing_logs {
      enabled   = true
      log_level = var.dag-processing-logs
    }

    scheduler_logs {
      enabled   = true
      log_level = var.scheduler-logs-level
    }

    task_logs {
      enabled   = true
      log_level = var.task-logs-level
    }

    webserver_logs {
      enabled   = true
      log_level = var.webserver-logs-level
    }

    worker_logs {
      enabled   = true
      log_level = var.worker-logs-level
    }
  }
}