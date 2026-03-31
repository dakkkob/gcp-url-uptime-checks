# GCP Uptime Checks and Alert Policies with Terraform

Terraform code to set up HTTPS uptime checks and a single alert policy for multiple websites in Google Cloud Platform (GCP). Checks run from 3 regions (Europe, US Virginia, Asia Pacific) and verify both availability and page content.

## Files

- `uptime_checks_alert_policies.tf`: Terraform resources for uptime checks and the aggregated alert policy.
- `variables.tf`: Input variable definitions.
- `terraform.tfvars.example`: Example configuration — copy to `terraform.tfvars` and fill in your values.

## Requirements

- A GCP project with the **Cloud Monitoring API** enabled (`monitoring.googleapis.com`).
- Authenticated `gcloud` CLI (`gcloud auth application-default login`).
- An existing **email notification channel** in GCP. Create one at: GCP Console → Monitoring → Alerting → Notification Channels. Copy the full resource ID (format: `projects/PROJECT_ID/notificationChannels/CHANNEL_ID`).
- Terraform >= 1.0.

> **Free tier note:** GCP includes 3 uptime checks at no cost. Each additional check costs ~$0.75/month. The single alert policy and email notifications are free.

## Usage

1. **Clone the repository:**
   ```
   git clone https://github.com/dakkkob/gcp-url-uptime-checks
   cd gcp-url-uptime-checks
   ```

2. **Configure your variables:**
   ```
   cp terraform.tfvars.example terraform.tfvars
   ```
   Edit `terraform.tfvars` with your project ID, notification channel ID, and the list of sites to monitor.

3. **Initialize Terraform:**
   ```
   terraform init
   ```

4. **Preview and apply:**
   ```
   terraform plan
   terraform apply
   ```
