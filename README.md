# FABRIC: AWS K8

## For Users:
1. Create a Project
2. Create a data-repo for the Project
3. Create analysis pipeline
4. Preview outputs
5. Consume output using:
  - Web Application
  - API
  - BI Tool  

## For Developers:
###Infrastrcture

<!-- <insert diagam of architecture show: from VPC setup to K8 apps + API consumption> -->

1. "AWS K8" infrastructure defined here is deployed on domain *inkeystone.com*
2. You will need access to private keys if you wish to update deployed state - first go to the master branch and follow that readme.
3. This deploys Kubernetes (k8) cluster (3 nodes: 1 master, 2 service) on top of a secure networking architecture
4. This Infrastructure is managed by Terraform scripts and the current state is stored in `s3://inkeystone-com-state`:
  - Networking: `/labroots.tfstate`
  - K8: `/labroots-kubernetes.tfstate`
  - Data: `/labroots.inkeystone.com/`
5. Access the Admin Dashbaord for the k8 cluster @ `api.labroots.inkeystone.com`

[View Infrastructure Diagram](https://github.com/28mm/blast-radius)

###Deployed Services (on the platform)
1. Pachyderm: Data Lake with Versioning & Language Agnostic Analysis Pipelines 
  - State is stored in `s3://inkeystone-com-pachd`
2. Kubeflow (Model Management)
3. Dremio (Data Virtualization)

[Dashboard UI](https://api.labroots.inkeystone.com/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/)
