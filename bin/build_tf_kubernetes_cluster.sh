
kops create cluster \
    --zones="$(terraform output main_network_availability_zones_csv | tr -d '\n')" \
    --vpc="$(terraform output main_network_id | tr -d '\n')" \
    --network-cidr="$(terraform output main_network_cidr_block | tr -d '\n')" \
    --networking="kubenet" \
    --ssh-public-key='keys/kubernetes-admin.pub' \
    --target="terraform" \
    --name="$(bin/get_fabric_fqdn.py)" \
    --out="./kubernetes/" \
    --state="s3://$(bin/get_state_store_name.py)" \

kops edit cluster \
    --name="labroots.inkeystone.com" \
    --state="s3://$(bin/get_state_store_name.py)"

    --out="./kubernetes/" \
    --master-size="c4.large" \
    --node-size="c4.medium"


# Upgrade to more nodes
# export BASTION_MACHINE_TYPE="t2.medium"
export MASTER_MACHINE_TYPE="t2.large"
export NODE_MACHINE_TYPE="t2.large"
export NODE_MAX_SIZE="3"
export NODE_MIN_SIZE="3"


# Upgrading the kube cluster
# https://github.com/kubernetes/kops/blob/master/docs/upgrade.md
# Step 1:
kops update cluster \
    --target="terraform" \
    --state="s3://$(bin/get_state_store_name.py)" \
    --out="./kubernetes/"
    # --node-count=2 \

# Changes may require instances to restart: kops rolling-update cluster
# State Store: Required value: Please set the --state flag or export KOPS_STATE_STORE.
# See details: https://github.com/kubernetes/kops/blob/master/docs/cli/kops_rolling-update.md

export KOPS_STATE_STORE="s3://inkeystone-com-state/"
# Preview a rolling-update.
kops rolling-update cluster

# Roll the currently selected kops cluster with defaults.
# Nodes will be drained and the cluster will be validated between node replacement.
kops rolling-update cluster --yes

 # Roll the k8s-cluster.example.com kops cluster,
# do not fail if the cluster does not validate,
# wait 8 min to create new node, and wait at least
# 8 min to validate the cluster.
kops rolling-update cluster k8s-cluster.example.com --yes \
--fail-on-validate-error="false" \
--master-interval=8m \
--node-interval=8m

# Roll the k8s-cluster.example.com kops cluster,
# do not validate the cluster because of the cloudonly flag.
# Force the entire cluster to roll, even if rolling update
# reports that the cluster does not need to be rolled.
kops rolling-update cluster labroots.inkeystone.com --yes \
--cloudonly \
--force

# Roll the k8s-cluster.example.com kops cluster,
# only roll the node instancegroup,
# use the new drain and validate functionality.
kops rolling-update cluster labroots.inkeystone.com --yes \
--fail-on-validate-error="false" \
--node-interval 8m \
--instance-group nodes


