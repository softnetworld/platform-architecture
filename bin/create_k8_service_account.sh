# Deploy k8 dashboard
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

# Create service account
kubectl create serviceaccount cluster-admin-dashboard-sa

# Bind ClusterAdmin role to the service account
kubectl create clusterrolebinding cluster-admin-dashboard-sa \
  --clusterrole=cluster-admin \
  --serviceaccount=default:cluster-admin-dashboard-sa


# Go here to login
#  api.labroots.inkeystone.com/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

# Parse the token; use this to login as cluster-admin-dashboard-sa
TOKEN=$(kubectl describe secret $(kubectl -n kube-system get secret | awk '/^cluster-admin-dashboard-sa-token-/{print $1}') | awk '$1=="token:"{print $2}')