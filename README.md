# EKS Cluster setup with Application Deployment

### Steps needed to deploy EKS Cluster :

Prerequisites :
terraform v0.12.12 and
AWS account with us-east-1 region access (for other regions change the region in terraform.tfvars)

- Clone the repo
- Navigate to the cloned repo directory
- Generate .aws/credentials file or export ACCESS and SECRET keys by deleting shared_credentials_file line from main.tf.
- terraform init
- terraform plan
- terraform apply -auto-approve

### Steps for making code build through pipeline :

Prerequisties :
- Login to the EKS cluster and perform below steps to get access for code deploy
  - kubectl get cm aws-auth -n kube-system -o yaml > aws-auth-cm.yml
  - Get the code deploy IAM role arn printed from outputs
  - ROLE="    - rolearn: arn:aws:iam::${ACCOUNT_ID}:role/code_deploy_iam\n      username: build\n      groups:\n        - system:masters"]
  - kubectl get -n kube-system configmap/aws-auth -o yaml | awk "/mapRoles: \|/{print;print \"$ROLE\";next}1" > /tmp/aws-auth-patch.yml
  - kubectl patch configmap/aws-auth -n kube-system --patch "$(cat /tmp/aws-auth-patch.yml)"


### Pod or Service verification steps

- Connect to EKS cluster
- kubectl get po -l app=password-manager
- kubectl descrie svc password-manager
