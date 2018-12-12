kops create cluster \
    --zones="$(terraform output main_network_availability_zones_csv | tr -d '\n')" \
    --vpc="$(terraform output main_network_id | tr -d '\n')" \
    --network-cidr="$(terraform output main_network_cidr_block | tr -d '\n')" \
    --networking="kubenet" \
    --ssh-public-key='keys/kubernetes-admin.pub' \
    --target="terraform" \
    --name="$(bin/get_fabric_fqdn.py)" \
    --state="s3://$(bin/get_state_store_name.py)" \
    --out=kubernetes \
    # --node-count=2 \
    # --master-size=t2.nano \
    # --node-size=t2.nano

# Dashboard
# kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml