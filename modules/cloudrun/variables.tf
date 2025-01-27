variable "sensor_id" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "topic_path" {
  type = string
}

variable "artifact_registry_url" {
  type = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
} 