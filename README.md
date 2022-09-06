# [Jenkins on AWS](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS)

Deploy Jenkins to AWS EC2 instance.

## Getting Started

### Initial setup

1. Generate ssh key pairs

   ```bash
   ssh-keygen -t ed25519 -f <PATH>
   ```

2. Create EC2 instance and deploy Jenkins
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
terraform apply -var aws_region=<AWS REGION> -var path_to_public_key=<PATH TO PUBLIC KEY>
```
