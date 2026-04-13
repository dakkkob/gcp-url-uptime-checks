variable "project_id" {
  description = "The GCP project ID to deploy resources into."
  type        = string
}

variable "uptime_checks" {
  description = "List of uptime check configurations."
  type = list(object({
    hostname         = string
    path             = string
    check_frequency  = number
    content_matching = string
  }))
}

variable "notification_channel_id" {
  description = "ID of the pre-existing email notification channel"
  type        = string
}

variable "alert_threshold" {
  description = "Alert triggers when the fraction of passing checks within the rolling window drops below this value. (0.90 = alert if less than 90% of checks pass)"
  type        = number
  default     = 0.90
}

variable "alert_severity" {
  description = "Severity level of the alert. One of: CRITICAL, ERROR, WARNING."
  type        = string
  default     = "WARNING"
}

variable "rolling_window_seconds" {
  description = "The length of time in seconds over which to measure the metric for triggering the alert. Commonly set to 3600 seconds (1 hour)."
  type        = number
  default     = 3600
}

variable "alert_duration_seconds" {
  description = "How long the condition must be continuously violated before the alert fires. Use 0 for immediate, or e.g. 600 for a 10-minute grace period to avoid flapping on transient failures."
  type        = number
  default     = 600
}
