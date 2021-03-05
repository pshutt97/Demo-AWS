terraform = 
	cd /launch-ec2-instance ;\
	terraform init ;\
	terraform plan ;\
	terraform apply -auto-approve ;\