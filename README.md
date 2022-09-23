# [Jenkins on AWS](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS)

Deploy Jenkins to AWS EC2 instance.

## Getting Started

### Initial setup

1. Export environment variables

   ```bash
   export TF_CLOUD_ORGANIZATION=<Organisation name>
   export AWS_PROFILE=<AWS profile name>
   ```

   **Add above lines to `~/.bash_profile` or `~/.profile` to export environment variables in all terminal sessions**

2. Terraform

    ```bash
    terraform init
    ```

### Deploy

```bash
terraform apply -var aws_region=<AWS REGION> -var vpc_cidr_block=<VPC CIDR BLOCK>
```
