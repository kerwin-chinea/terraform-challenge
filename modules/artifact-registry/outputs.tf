output "repository_url" {
  value = "${var.region}-docker.pkg.dev/${data.google_project.current.project_id}/${google_artifact_registry_repository.sensor_repo.repository_id}"
} 