module "pubsub" {
  source = "./modules/pubsub"
  
  environment = var.environment
  publisher_members = [
    for key, sensor in var.sensors : 
    "serviceAccount:${module.cloudrun[key].service_account_email}"
  ]
}

module "artifact_registry" {
  source = "./modules/artifact-registry"
  
  region = var.region
  environment = var.environment
  cloudrun_service_account = module.cloudrun["sensor-1"].service_account_email
}

module "vpc" {
  source = "./modules/vpc"
  
  environment = var.environment
  region      = var.region
  subnet_cidr = "10.0.0.0/24"
}

locals {
  project_id = terraform.workspace == "prod" ? "prod-project-id" : "non-prod-project-id"
}

module "cloudrun" {
  source   = "./modules/cloudrun"
  for_each = var.sensors

  sensor_id            = each.key
  region               = each.value.region
  environment          = var.environment
  topic_path           = module.pubsub.topic_path
  artifact_registry_url = module.artifact_registry.repository_url
  project_id           = local.project_id
} 