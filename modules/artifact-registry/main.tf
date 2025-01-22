data "google_project" "current" {}

resource "google_artifact_registry_repository" "sensor_repo" {
  location      = var.region
  repository_id = "sensor-images"
  description   = "Docker repository for sensor images"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository_iam_member" "reader" {
  location   = google_artifact_registry_repository.sensor_repo.location
  repository = google_artifact_registry_repository.sensor_repo.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${var.cloudrun_service_account}"
} 