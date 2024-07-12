variable "uptime_checks" {
  description = "List of uptime check configurations. Severity can be one of 'CRITICAL', 'ERROR', 'WARNING'."
  type = list(object({
    hostname         = string
    path             = string
    check_frequency  = number
    content_matching = string
    alert_duration   = number    
  }))
}

variable "notification_channel_id" {
  description = "ID of the pre-existing email notification channel"
  type        = string
}

variable "alert_threshold" {
  description = "The alert will be triggered when website availability within the specified rolling window is less than this threshold. In percent. (0.30 = 30%)"
  type        = number
  default     = 0.30
}

variable "alert_severity" {
  description = "Severity level of the alert."
  type        = string
  default     = "WARNING"
}

variable "rolling_window_seconds" {
  description = "The length of time in seconds over which to measure the metric for triggering the alert. Commonly set to 3600 seconds (1 hour)."
  type        = number
  default     = 3600  # Default to one hour
}
