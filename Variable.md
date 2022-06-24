# Terraform Variables

##Type
* Simple Type
  * `string`
  * `number`
  * `bool`
* Collection Type
  * `List`: A sequence of values of the same type.
  * `Map`: A lookup table, matching keys to values, all of the same type.
  * `Set`: An unordered collection of unique values, all of the same type.
* Structural Type
  * `Tuple`: A fixed-length sequence of values of specified types.
  * `Object`: A lookup table, matching a fixed set of keys to values of specified types.

## Assign Values to variables
* Assign values when prompted 
  * (define variable without default value)
* Assign values with a `terraform.tfvars` file

##Interpolate variables in strings
${var.variable_name}-123
```shell
module "app_security_group" {
   source  = "terraform-aws-modules/security-group/aws//modules/web"
   version = "3.12.0"

-  name        = "web-sg-project-alpha-dev"
+  name        = "web-sg-${var.resource_tags["project"]}-${var.resource_tags["environment"]}"

   ## ...
 }

```

## Variable Validation
```shell
variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {
    project     = "my-project",
    environment = "dev"
  }

  validation {
    condition     = length(var.resource_tags["project"]) <= 16 && length(regexall("[^a-zA-Z0-9-]", var.resource_tags["project"])) == 0
    error_message = "The project tag must be no more than 16 characters, and only contain letters, numbers, and hyphens."
  }

  validation {
    condition     = length(var.resource_tags["environment"]) <= 8 && length(regexall("[^a-zA-Z0-9-]", var.resource_tags["environment"])) == 0
    error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."
  }
}

```