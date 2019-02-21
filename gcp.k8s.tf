resource "google_container_cluster" "kooby" {
  name               = "koobycluster"
  zone               = "us-east1-b"
  initial_node_count = "1"

  additional_zones = [
    "us-east1-c",
  ]

  master_auth {
    password = "password-mustbesixteen1"
    username = "username"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      this-is-for = "dev-cluster"
    }

    tags = ["dev", "work"]
  }
}
