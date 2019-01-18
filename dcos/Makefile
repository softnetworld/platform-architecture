
root:
	source ./.env

plan:
	terraform get --update=true
	terraform plan --var-file cluster.tfvars -out=cluster.plan

apply:
	terraform apply cluster.plan
