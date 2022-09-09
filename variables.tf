variable "env-name" {
  type = string
}
variable "vpc-cidr" {
  type = string
}
variable "az" {
  type = list(string)
}
variable "public-sub1-cidr" {
  type = string
}
variable "public-sub2-cidr" {
  type = string
}
variable "private-sub1-cidr" {
  type = string
}
variable "private-sub2-cidr" {
  type = string
}
variable "max-worker-nodes" {
  type = number
}
variable "dag-processing-logs" {
  type = string
}
variable "scheduler-logs-level" {
  type = string
}
variable "task-logs-level" {
  type = string
}
variable "worker-logs-level" {
  type = string
}
variable "webserver-logs-level" {
  type = string
}
variable "account_id" {
  type = string
}
variable "region" {
  type = string
}
variable "access_key" {
  type = string
}
variable "access_secret" {
  type = string
}