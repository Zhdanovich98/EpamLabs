### Task 10: Amazon Web Services (AWS) ###
#### In this task, completed: ####
-   created free tier account
-   created custom VPC, LB, Autoscaling Group with Terraform
-   created instance, created a “Hello World” page (used Nginx web server) with Terraform
---
#### Start task: ####
1.   clone this project from git:
```sh
git clone https://github.com/Zhdanovich98/EpamLabs.git
```
2.   go to this project directory
```sh
cd ./EpamLabs
```
3.    go to this "task10" branch
```sh
git checkout task10
```
4.    configure [environment variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

5.   create ssh key
```sh
ssh-keygen -t rsa -f terraform-keys2 -q -P ""
```
6. run init && run check
```sh
terraform init && terraform validate
```
7. run task
```sh
terraform apply
```
---
#### Check task: ####
1.   After start project find "dns_name" value in the logs.
2.   Run curl command with "dns_name" value
---
#### Destroy task: ####
```sh
terraform destroy
```
