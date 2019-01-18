
ssh-add ~/.ssh/labsp

dcos auth login

dcos package install kubernetes --package-version=2.1.0-1.12.3

# --options=kube.json

dcos kubernetes cluster create --options=kube.json

dcos kubernetes cluster list

dcos kubernetes cluster debug plan status deploy --cluster-name="kubernetes-kube"

# dcos package install kubernetes --options=kube.json

dcos kubernetes plan status deploy

# apiserver.kubernetes.l4lb.thisdcos.directory:6443

# exposing public end-points

dcos package install marathon-lb