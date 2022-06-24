#Terraform

##Terraform Command Lines
Setup tab auto-completion
```shell
terraform -install-autocomplete
terraform fmt
terraform validate
terraform validate -backend=false
terraform init
terraform apply --auto-approve
terraform destroy --auto-approve
terraform plan -out plan.out
terraform apply plan.out
terraform plan -destroy
terraform refresh
terraform providers
```

## String, List and Map Variables
```hcl
#String Variable
variable "instance_type" {
  type = string
  default = "t2.micro"
 }
#List Variables
variable "instance_type" {
  type = list(string)
  default = ["t2.micro", "t2.small"]
 }
#Map of variables
variable "instance_type" {
  type = map(string)
  default = {
    "dev" : "t2.micro", 
    "prod" : "t2.small"
 }
 }
 #Usage
 instance_type = var.instance_type #String
 instance_type = var.instance_type[0] #List
 instance_type = var.instance_type["dev"] #Map
```

## Meta-Argument
```hcl
depends_on #To declare explicit dependency on terraform resource which terraform can not infer.
count
    # To create multiple resources with same configuration
    count.index #Inedx number corresponding to count
for_each
    # accepts a map or set of string
    each.key
    each.value
provider
    # Used when using multiple provider example, multi-region resources using alias
    # resource use provider.alias (provider = aws.canada)
    eg. provider "aws" {
          region = "us-east-1"
        }
        provider "aws" {
          region = "ca-central-1"
          alias = canada
        }
        resource "aws_instance" "example" {
          provider = aws.canada
        }   
lifecycle
    # nested block under resource used to customize the behaviour
    create_before_destroy: (Type: Bool)
        # First create the updated resource and then delete existing
    prevent_destroy: (Type: Bool)
        # eg. prevent database instance from deletion
    ignore_changes: (Type: List(Attribute Names))
      # eg. To ignore resource update if TAG change is detected
```
##Simplify Terraform config with Locals
```hcl
locals {
  name_suffix = "${var.resource_tags["project"]}-${var.resource_tags["environment"]}"
}

module "vpc" {
  name = "vpc-${local.name_suffix}"
  ## ...
 }
}
```

##Protect Sensitive input variables (SENSITIVE)
```hcl
variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

Set Value with .tfvar file (db_password = xxx > secret.tfvars)
$ terraform apply -var-file="secret.tfvars"

Set value with environment variable TF_VAR_<VARIABLE_NAME>
$ export TF_VAR_db_username=admin TF_VAR_db_password=adifferentpassword

To output the Sensitive value set sensitive attribute = true
    output "db_connect_string" {
      description = "MySQL database connection string"
      value       = "Server=${aws_db_instance.database.address}; Database=ExampleDB; Uid=${var.db_username}; Pwd=${var.db_password}"
    +  sensitive   = true
    }
Note: terraform.tfstate file store the state in plain text format including variable values even if you have flagged them as sensitive. Since Terraform state can contain sensitive values, you must keep your state file secure to avoid exposing this data.
```



