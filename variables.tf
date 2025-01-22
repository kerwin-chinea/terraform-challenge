variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
}

variable "environment" {
  description = "Environment (prod or non-prod)"
  type        = string
}

variable "sensors" {
  description = "Sensor configurations"
  type = map(object({
    region = string
  }))
  default = {
    "sensor-1" = {
      region = "europe-west3"
    }
    "sensor-2" = {
      region = "europe-west1"
    }
  }
} 