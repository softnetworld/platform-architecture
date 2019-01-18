dcos security org service-accounts keypair ~/.ssh/labsp ~/.ssh/labsp.pub

# https://docs.mesosphere.com/services/kubernetes/2.1.0-1.12.3/operations/exposing-the-kubernetes-api/
# https://docs.mesosphere.com/services/kubernetes/2.1.0-1.12.3/operations/exposing-the-kubernetes-api/

openssl genrsa 2048 > ~/.ssh/haproxy-key.pem
openssl req -new -x509 -nodes -sha1 -days 3650 -key ~/.ssh/haproxy-key.pem \
  -subj "/C=US/ST=CA/L=SF/O=Mesosphere/OU=dcos-kubernetes/CN=*" > ~/.ssh/haproxy-crt.pem
cat ~/.ssh/haproxy-crt.pem ~/.ssh/haproxy-key.pem > ~/.ssh/haproxy.pem


dcos node ssh --master-proxy --mesos-id="186fba23-d711-4897-b93b-70650618fc57-S0" --user=centos
mkdir /opt/haproxy
scp                  \
  ~/.ssh/haproxy.pem \
  haproxy.conf \
  centos@172.12.4.95:/opt/haproxy


dcos marathon app add marathon.json

curl -k https://172.12.4.95:6443
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {

  },
  "status": "Failure",
  "message": "forbidden: User \"system:anonymous\" cannot get path \"/\"",
  "reason": "Forbidden",
  "details": {

  },
  "code": 403
}

# ----