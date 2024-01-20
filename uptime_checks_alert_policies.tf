provider "google" {
  // Your provider configuration here
}

resource "google_monitoring_uptime_check_config" "uptime_check" {
  for_each = { for idx, check in var.uptime_checks : idx => check }

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
      host = each.value.hostname
    }
  }
}

resource "google_monitoring_alert_policy" "alert_policy" {
  for_each = { for idx, check in var.uptime_checks : idx => check }

  display_name = "${each.value.hostname}${each.value.path}"
  combiner     = "OR"
  conditions {
    display_name = "Uptime Check Condition"
    condition_threshold {
      filter = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.label.check_id=\"${google_monitoring_uptime_check_config.uptime_check[each.key].uptime_check_id}\" AND resource.type=\"uptime_url\""
      duration   = "3600s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period     = "1200s"
        per_series_aligner   = "ALIGN_NEXT_OLDER"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.label.*"]
      }
      threshold_value = 1.0
      trigger {
        count = 1
      }
    }
  }

				 

  notification_channels = [
    var.notification_channel_id
  ]

  documentation {
    content   = "Uptime check failed for ${each.value.hostname}${each.value.path}"
    mime_type = "text/markdown"
  }

  severity = each.value.severity
}

output "uptime_check_ids" {
  value = { for idx, check in google_monitoring_uptime_check_config.uptime_check : idx => check.id }
}

output "alert_policy_ids" {
  value = { for idx, check in google_monitoring_alert_policy.alert_policy : idx => check.id }
}

