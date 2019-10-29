<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Custom module to configure health check and related AWS CloudWatch alarms.

## Usage

```hcl
module "route53_health_check" {
  source = "./route53-health-check"

  environment       = "${var.environment}"
  dns_name          = "${local.my_move_dns_name}"
  alarm_actions     = "${compact(local.r53_alarm_actions)}"
  health_check_path = "/health?database=false"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alarm\_actions | Actions to execute when this alarm transitions. | list | n/a | yes |
| dns\_name | Fully-qualified domain name (FQDN) to create. | string | n/a | yes |
| environment | Environment tag (e.g. prod). | string | n/a | yes |
| failure\_threshold | Failure Threshold (must be less than or equal to 10) | string | `"3"` | no |
| health\_check\_path | Resource Path to check | string | `""` | no |
| health\_check\_regions | AWS Regions for health check | list | `[ "us-east-1", "us-west-1", "us-west-2" ]` | no |
| request\_interval | Request Interval (must be 10 or 30) | string | `"30"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
