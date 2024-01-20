# GCP Uptime Checks and Alert Policies with Terraform

This repository contains Terraform code to set up uptime checks and alert policies for multiple websites in Google Cloud Platform (GCP).

## Files

- `uptime_checks_alert_policies.tf`: Contains the Terraform code to create uptime check configurations and corresponding alert policies in GCP.
- `variables.tf`: Defines the input variables required by the Terraform code.
- `terraform.tfvars.example`: An example of variable definitions. Rename to `terraform.tfvars` and update with your values before running Terraform.

## Usage

1. **Clone the Repository:**

git clone https://github.com/dakkkob/gcp-url-uptime-checks
cd gcp-url-uptime-checks

2. **Configure Your Variables:**
- Rename `terraform.tfvars.example` to `terraform.tfvars`.
- Update the values in `terraform.tfvars` with your specific configuration details.

3. **Initialize Terraform:**

terraform init

4. **Apply the Terraform Configuration:**

terraform apply

## Requirements

- A Google Cloud Platform account.
- A configured GCP project with necessary APIs enabled.
- An existing notification channel and its ID
- Terraform installed on your machine or use of Google Cloud Shell.

