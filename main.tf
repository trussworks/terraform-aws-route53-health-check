/**
 * Custom module to configure health check and related AWS CloudWatch alarms.
 *
 * ## Usage
 *
 * ```hcl
 * module "route53_health_check" {
 *   source = "./route53-health-check"
 *
 *   environment       = "${var.environment}"
 *   dns_name          = "${local.my_move_dns_name}"
 *   alarm_actions     = "${compact(local.r53_alarm_actions)}"
 *   health_check_path = "/health?database=false"
 * }
 * ```
 */

resource "aws_route53_health_check" "http" {
  fqdn              = "${var.dns_name}"
  port              = 80
  type              = "HTTP"
  resource_path     = "${var.health_check_path}"
  failure_threshold = "${var.failure_threshold}"
  request_interval  = "${var.request_interval}"
  regions           = "${var.health_check_regions}"
  measure_latency   = true

  tags = {
    Name        = "${var.dns_name}-http"
    Environment = "${var.environment}"
    Automation  = "Terraform"
  }
}

resource "aws_route53_health_check" "https" {
  fqdn              = "${var.dns_name}"
  port              = 443
  type              = "HTTPS"
  resource_path     = "${var.health_check_path}"
  failure_threshold = "${var.failure_threshold}"
  request_interval  = "${var.request_interval}"
  regions           = "${var.health_check_regions}"
  measure_latency   = true

  tags = {
    Name        = "${var.dns_name}-https"
    Environment = "${var.environment}"
    Automation  = "Terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "http" {
  provider = "aws.us-east-1"

  alarm_name        = "${var.dns_name}-status-http"
  alarm_description = "Route53 health check status for ${var.dns_name}"

  namespace   = "AWS/Route53"
  metric_name = "HealthCheckStatus"

  dimensions {
    HealthCheckId = "${aws_route53_health_check.http.id}"
  }

  comparison_operator = "LessThanThreshold"
  statistic           = "Minimum"
  threshold           = "1"

  evaluation_periods = "1"
  period             = "60"

  alarm_actions             = ["${var.alarm_actions}"]
  ok_actions                = ["${var.alarm_actions}"]
  insufficient_data_actions = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "https" {
  provider = "aws.us-east-1"

  alarm_name        = "${var.dns_name}-status-https"
  alarm_description = "Route53 health check status for ${var.dns_name}"

  namespace   = "AWS/Route53"
  metric_name = "HealthCheckStatus"

  dimensions {
    HealthCheckId = "${aws_route53_health_check.https.id}"
  }

  comparison_operator = "LessThanThreshold"
  statistic           = "Minimum"
  threshold           = "1"

  evaluation_periods = "1"
  period             = "60"

  alarm_actions             = ["${var.alarm_actions}"]
  ok_actions                = ["${var.alarm_actions}"]
  insufficient_data_actions = ["${var.alarm_actions}"]
}
