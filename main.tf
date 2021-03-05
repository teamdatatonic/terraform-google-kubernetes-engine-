module "network" {
  source  = "teamdatatonic/network/gcp"
  version = "1.2.6"

  project_id         = var.project_id
  network_name       = var.gke_network_name
  routing_mode       = var.routing_mode
  region             = var.region
  subnets            = var.secure_subnet
  environment_prefix = var.environment_prefix

}

module "secure_private_gke_v2" {
  source = "./modules/secure_gke"

  project_id   = var.project_id
  region       = var.region
  gke_config   = var.gke_config
  network_name = module.network.network_self_link
  subnet_name  = module.network.subnets_names[0]
}
