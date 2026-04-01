# GCP Uptime Checks and Alert Policies with Terraform

Terraform code to set up HTTPS uptime checks and a single alert policy for multiple websites in Google Cloud Platform (GCP). Checks run from 3 regions (Europe, US Virginia, Asia Pacific) and verify both availability and page content.

## Files

- `uptime_checks_alert_policies.tf`: Terraform resources for uptime checks and the aggregated alert policy.
- `variables.tf`: Input variable definitions.
- `terraform.tfvars.example`: Example configuration — copy to `terraform.tfvars` and fill in your values.
- `backend.tf`: GCS remote backend configuration for storing Terraform state.

## Requirements

- A GCP project with the **Cloud Monitoring API** enabled (`monitoring.googleapis.com`).
- The `gcloud` CLI installed and authenticated.
- An existing **email notification channel** in GCP. Create one at: GCP Console → Monitoring → Alerting → Notification Channels. Copy the full resource ID (format: `projects/PROJECT_ID/notificationChannels/CHANNEL_ID`).
- Terraform >= 1.0.

> **Free tier note:** GCP includes 3 uptime checks at no cost. Each additional check costs ~$0.75/month. The single alert policy and email notifications are free.

## One-time setup

### 1. Authenticate
```
gcloud auth application-default login
gcloud config set project YOUR_PROJECT_ID
```

### 2. Create the state bucket
Create a **private** GCS bucket to store Terraform state (do this once via GCP Console or gsutil):
```
gsutil mb gs://sitesmonitoring-tfstate
```
If you change the bucket name, update `backend.tf` to match.

### 3. Configure your variables
```
cp terraform.tfvars.example terraform.tfvars
```
Edit `terraform.tfvars` with your project ID, notification channel ID, and sites to monitor.

## Deployment

```
terraform init     # downloads provider, connects to GCS backend
terraform plan     # preview changes
terraform apply    # deploy
```

On first `terraform init`, if you have an existing local `terraform.tfstate`, Terraform will offer to migrate it to GCS automatically — answer yes.
