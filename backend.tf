terraform {
  backend "gcs" {
    bucket = "sitesmonitoring-tfstate"
    prefix = "uptime-checks"
  }
}
