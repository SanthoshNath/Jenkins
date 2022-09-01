# [Jenkins on AWS](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS)

Deploy Jenkins in AWS EC2 instance.

1. Generate ssh key pairs
   ```bash
    ssh-keygen -t ed25519 -f key
   ```
2. Create EC2 instance and deploy Jenkins
   ```bash
     terraform apply -var aws_profile="default" aws_region="ap-south-1" path_to_public_key="key.pub"
   ```
