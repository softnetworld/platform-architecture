# BUCKET_NAME needs to be globally unique across the entire AWS region
export BUCKET_NAME="inkeystone-com-pachd"
# We recommend between 1 and 10 GB. This stores PFS metadata. For reference 1GB
# should work for 1000 commits on 1000 files.
export STORAGE_SIZE="100"
export AWS_REGION="us-east-2"

# If AWS_REGION is us-east-1.
# $ aws s3api create-bucket --bucket ${BUCKET_NAME} --region ${AWS_REGION}
# If AWS_REGION is outside of us-east-1.
# $ aws s3api create-bucket --bucket ${BUCKET_NAME} --region ${AWS_REGION} --create-bucket-configuration LocationConstraint=${AWS_REGION}
# aws s3api list-buckets --query 'Buckets[].Name'

pachctl deploy amazon ${BUCKET_NAME} ${AWS_REGION} ${STORAGE_SIZE} --dynamic-etcd-nodes=1 --iam-role arn:aws:iam::846597713655:role/nodes.labroots.inkeystone.com