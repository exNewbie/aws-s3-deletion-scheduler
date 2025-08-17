variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "file_extensions" {
  description = "List of file extensions to delete"
  type        = list(string)
}

variable "days_old" {
  description = "Number of days after which MP4 files should be deleted"
  type        = number
  default     = 3
}
