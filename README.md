# [Jenkins on AWS](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS)

Deploy Jenkins to AWS EC2 instance.

## Getting Started

1. Generate ssh key pairs
   ```bash
    ssh-keygen -t ed25519 -f key
   ```
2. Create EC2 instance and deploy Jenkins
   ```bash
     terraform apply -var aws_profile=<AWS PROFILE> -var aws_region=<AWS REGION> -var path_to_public_key=<PATH TO PUBLIC KEY>
   ```
