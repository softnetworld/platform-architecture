# Dashboard
# kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

# Go here to login
# api.labroots.inkeystone.com/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

echo $(kubectl describe secret $(kubectl -n kube-system get secret | awk '/^cluster-admin-dashboard-sa-token-/{print $1}') | awk '$1=="token:"{print $2}')
