provider "google" {
  credentials = "gke-key.json"
  project     = "gke-fofo"
  region      = "us-east4"
}

resource "google_project_iam_member" "sa" {
  project = "gke-fofo"
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:service-gke@gke-fofo.iam.gserviceaccount.com"
}

resource "google_service_account" "default" {
  account_id   = "gke-fofo"
  display_name = "Service Account"
}

resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "us-east4"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "gke-node-pool"
  location   = "us-east4"
  cluster    = google_container_cluster.primary.name
  node_count = 1


  node_config {
    preemptible  = true
    machine_type = "e2-standard-4"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
