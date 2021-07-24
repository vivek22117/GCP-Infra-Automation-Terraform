## GCP-Infra-Automation-Terraform
Creating GCP resources using Terraform


# Pre-requisites
* we will create and configure a Service Account with permissions at Organization-level and Project-level.
    ** Organization-level permissions are required to create resources at the Organization level, for example, Folders and Projects.
    ** Project-level permissions are required to create resources at the project level, for example, Google Storage Accounts or VM instances.
  
* A Service Account is a special kind of account used by an application (Terraform in this case) to make authorized API calls.
  It is identified by its email address, which is unique to the account.
  
* Two important differences between Service Accounts and User Accounts:
    ** Service Accounts don’t have passwords, and cannot log in via browsers.
    ** Service Accounts are associated with private/public RSA key-pairs that are used for authentication to Google.

