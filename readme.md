# Lite ALZ - Terraform

This repository contains the Terraform code for the Lite ALZ (Azure Landing Zone). This repository is a starting point for building a basic infrastructure on Azure using Terraform. Each module can be modified to meet the specific needs of each project.

## Folder Structure

The repository is structured as follows:
```
Root Directory:
     ├── environment
     ├── modules
     │   ├── mgmntgroup
     │   ├── monitoring
     │   ├── networking
     │   ├── policies
     │   ├── storage
     │   └── resourcegroups
     ├── main.tf
     ├── provider.tf
     ├── readme.md
     ├── terraform.tfvars
     └── variables.tf
```

 - `modules`: This directory contains the reusable Terraform modules for the different infrastructure components, such as networking, monitoring, policies, etc.
 - `main.tf`: This file contains the main Terraform code to be deployed.
 - `provider.tf`: This file contains the provider configuration for Terraform.
 - `readme.md`: This file contains the detailed documentation on how to use the Terraform code.
 - `terraform.tfvars`: This file contains the values for the Terraform variables used in the code.
 - `variables.tf`: This file contains the declarations of the Terraform variables used in the code.



## Usage

To use this Terraform code, follow these steps:

1. Clone the repository.
2. Navigate to the `deploy` directory.
3. Edit the `terraform.tfvars` file with the required values.
4. Run `terraform init` to initialize the provider and modules.
5. Run `terraform plan` to preview the infrastructure changes to be made.
6. Run `terraform apply` to deploy the infrastructure.

For more information on how to use Terraform, please refer to the official [Terraform documentation](https://www.terraform.io/docs/index.html). 
