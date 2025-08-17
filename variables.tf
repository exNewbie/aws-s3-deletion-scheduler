variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-southeast-2"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile"
  default     = "personal"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "file_extensions" {
  description = "List of file extensions to delete"
  type        = list(string)
  default     = ["mp4"]
}

variable "days_old" {
  description = "Number of days after which MP4 files should be deleted"
  type        = number
  default     = 3
}
