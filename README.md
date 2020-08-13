Custom module to configure health check and related AWS CloudWatch alarms.

## Usage

```hcl
module "route53_health_check" {
  source = "trussworks/route53-health-check/aws"
  version = "2.0.0"

  environment       = var.environment
  dns_name          = local.my_move_dns_name
  alarm_actions     = compact(local.r53_alarm_actions)
  health_check_path = "/health?database=false"
}
```

## Terraform Versions

Terraform 0.12. Pin module version to ~> 2.X. Submit pull-requests to master branch.

Terraform 0.11. Pin module version to ~> 1.0.2. Submit pull-requests to terraform011 branch.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.70 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.70 |
| aws.us-east-1 | ~> 2.70 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm\_actions | Actions to execute when this alarm transitions. | `list(string)` | n/a | yes |
| disable | Disable health checks | `bool` | `false` | no |
| dns\_name | Fully-qualified domain name (FQDN) to create. | `string` | n/a | yes |
| environment | Environment tag (e.g. prod). | `string` | n/a | yes |
| failure\_threshold | Failure Threshold (must be less than or equal to 10) | `string` | `"3"` | no |
| health\_check\_path | Resource Path to check | `string` | `""` | no |
| health\_check\_regions | AWS Regions for health check | `list(string)` | <pre>[<br>  "us-east-1",<br>  "us-west-1",<br>  "us-west-2"<br>]</pre> | no |
| request\_interval | Request Interval (must be 10 or 30) | `string` | `"30"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
