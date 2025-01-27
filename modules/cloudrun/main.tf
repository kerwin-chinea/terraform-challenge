resource "google_service_account" "cloudrun_invoker" {
  account_id   = "cloudrun-invoker-${var.sensor_id}"
  display_name = "Cloud Run Invoker for ${var.sensor_id}"
}

resource "google_project_iam_member" "cloudrun_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.cloudrun_invoker.email}"
}

resource "google_cloud_run_service" "sensor" {
  name     = "${terraform.workspace}-${var.sensor_id}"
  location = var.region

  template {
    spec {
      containers {
        image = "${var.artifact_registry_url}/sensor:latest"
        env {
          name  = "TOPIC_PATH"
          value = var.topic_path
        }
        env {
          name  = "SENSOR_ID"
          value = var.sensor_id
        }
      }
      service_account_name = google_service_account.cloudrun_invoker.email
    }
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  service  = google_cloud_run_service.sensor.name
  location = google_cloud_run_service.sensor.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.cloudrun_invoker.email}"
}

resource "google_cloud_scheduler_job" "sensor_job" {
  name     = "trigger-${var.sensor_id}"
  schedule = "*/5 * * * *"
  region   = var.region

  http_target {
    http_method = "POST"
    uri         = "${google_cloud_run_service.sensor.status[0].url}/send_report"

    #TODO: ADD RETRIES, by default it implements exponential backoff
    
    oidc_token {
      service_account_email = google_service_account.cloudrun_invoker.email
      audience              = google_cloud_run_service.sensor.status[0].url
    }
  }
} 