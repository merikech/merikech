Namespaces:

kubectl create namespace namespace-namespaces

cat <<EOF > namespace.yml

apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    name: production
EOF	

kubectl delete namespace "namespace-name"

kubectl get namespaces

kubectl get namespaces --show-labels

Setting the namespace preference:

kubectl config set-context --current --namespace=

kubectl config view --minify | grep namespace:

kubectl api-resources --namespaced=true

kubectl api-resources --namespaced=false

Configure Memory and CPU Quotas for a Namespace:

apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    type: Container
	


Pods:

kubectl run nginx --image=nginx --port=80 --replicas=3
kubectl run nginx --image=nginx -n mynamespace     
kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml

cat <<EOF > nginx.yml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  labels:
    type: frontend
spec:
  containers:
  - name: nginx
    image: nginx:1.23
	ports:
	- containerPort: 80
EOF

Replicaset:

cat <<EOF > replicaset.yml
apiVersion: apps/v1
kind: Replicaset
metadata:
  name: myreplicaset
  lables:
   tier: front
   type: frontend
spec:
  replicas: 3
  selector:
  matchLabels:
    type: frontend
  template:
    metadata:
	  labels:
	    type: frontend
    spec:
	  containers:
	  - name: nginx
	    image: nginx:1.23
		ports:
		- containerPorts: 80
EOF


kubectl get rs
kubecet describe rs replicaset-name
kubectl delete replicaset replicaset-name



Deployment:

kubectl create deployment nginx --image=nginx --replicas=3
kubectl expose deployment nginx --port 80
kubectl edit deploy nginx
kubectl scale deploy nginx --replicas=5
kubectl set image deploy nginx nginx=nginx:1.23


kubectl delete deploy nginx

cat <<EOF> deploy.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mydeployment
spec:
  replicas: 4
  selector:
    matchLabels:
	  type: frontend
  template:
    metadata:
	  lables:
	    type: frontend
	spec:
	  containers:
	  - name: nginx
	    image: nginx:1.23
	  ports:
	  - containerPort: 80
	  resources:
	   limits:
	     cpu: "400m"
		 memory: "512Mi"
	   request:
	     cpu: "200m"
		 memory: "256Mi"
EOF

