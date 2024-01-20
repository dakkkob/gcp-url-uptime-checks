variable "uptime_checks" {
  description = "List of uptime check configurations. Severity can be one of 'CRITICAL', 'ERROR', 'WARNING'."
  type = list(object({
    hostname         = string
    path             = string
    check_frequency  = number
    content_matching = string
    alert_duration   = number
    severity         = string
  }))
}

variable "notification_channel_id" {
  description = "ID of the pre-existing email notification channel"
  type        = string
}
