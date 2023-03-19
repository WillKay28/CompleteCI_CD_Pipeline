# CompleteCI_CD_Pipeline
In this project, I create EC2, Security Groups, and S3 infrastructure in AWS using Terraform (IaC) and use them to build a CI/CD pipeline for a java web app in Jenkins. The S3 remote storage stores the backend file for the state or statefile of the Terraform infrastructure so team members have synchronized servers. I deploy the artifact from the pipeline on a tomcat server.

Note: server_key & server_key.pub -> These were SSH keys I generated using ssh-keygen to serve as keypairs for my servers.
