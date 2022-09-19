# gist

```
$ cat > sqs.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sqs:GetQueueAttributes",
            "Resource": "<ARN da fila>"
        }
    ]
}
EOF

$ aws iam create-policy --policy-name keda-sqs --policy-document file://sqs.json

$ kubectl create ns keda

$ eksctl create iamserviceaccount --name keda-operator \
  --namespace keda \
  --cluster <Cluster> \
  --attach-policy-arn <Policy ARN> \
  --region <Regiao> \
  --approve

$ helm repo add kedacore https://kedacore.github.io/charts

$ helm install keda kedacore/keda --namespace keda \
  --set serviceAccount.create=false \
  --set serviceAccount.name=keda-operator

$ kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: nginx-deployment
spec:
  replicas: 0
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
---
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: aws-sqs-queue-scaledobject
  namespace: default
spec:
  scaleTargetRef:
    name: nginx-deployment
  minReplicaCount: 0
  maxReplicaCount: 5
  pollingInterval: 5
  cooldownPeriod:  25
  triggers:
  - type: aws-sqs-queue
    metadata:
      queueURL: <URL da fila>
      queueLength: "10"
      awsRegion: "<Regiao>"
      identityOwner: operator
EOF

for i in `seq 50`; do 
  aws sqs send-message --queue-url '<URL da fila>' \
    --message-body "XXXX" \
    --region <Regiao> \
    --no-cli-pager \
    --output text
done
```