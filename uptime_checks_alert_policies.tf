provider "google" {
  project = var.project_id
}

resource "google_monitoring_uptime_check_config" "uptime_check" {
  for_each = { for check in var.uptime_checks : check.hostname => check }

  display_name = each.value.hostname
  timeout      = "10s"
  period       = "${each.value.check_frequency}s"

  http_check {
    port           = 443
    use_ssl        = true
    validate_ssl   = true
    path           = each.value.path
    request_method = "GET"
  }

  content_matchers {
    content = each.value.content_matching
  }

  selected_regions = [
    "EUROPE",
    "USA_VIRGINIA",
    "ASIA_PACIFIC"
  ]

  monitored_resource {
    type = "uptime_url"
    labels = {
      host       = each.value.hostname
      project_id = var.project_id
    }
  }
}

resource "google_monitoring_alert_policy" "alert_policy" {

  display_name = "Aggregated Policy For URL Uptime Checks"
  combiner     = "OR"
  conditions {
    display_name = "Aggregated Condition For URL Uptime Checks"
    condition_threshold {
      filter     = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.type=\"uptime_url\""
      duration   = "${var.alert_duration_seconds}s"
      comparison = "COMPARISON_LT"
      aggregations {
        alignment_period   = "${var.rolling_window_seconds}s"
        per_series_aligner = "ALIGN_FRACTION_TRUE"
      }
      trigger {
        count = 1
      }
      threshold_value = var.alert_threshold
    }
  }

  notification_channels = [
    var.notification_channel_id
  ]

  documentation {
    content = <<-EOT
      Alert triggered: $${condition.display_name}.
      This condition triggers if less than ${var.alert_threshold * 100}% of uptime checks pass over a rolling window of ${var.rolling_window_seconds} seconds.
      Affected Host: $${metric.label.host}.
      Check ID: $${metric.label.check_id}.
      Resource Project: $${resource.project}.
    EOT
    mime_type = "text/markdown"
  }

  severity = var.alert_severity
}

output "uptime_check_ids" {
  description = "Map of hostname to GCP uptime check resource ID."
  value       = { for hostname, check in google_monitoring_uptime_check_config.uptime_check : hostname => check.id }
}

output "alert_policy_id" {
  description = "GCP resource ID of the aggregated alert policy."
  value       = google_monitoring_alert_policy.alert_policy.id
}
