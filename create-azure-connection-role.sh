kubectl create serviceaccount azure-devops-svc
kubectl apply -f ./sa-secret.yaml
kubectl apply -f ./ClusterRole.yaml
kubectl apply -f ./create-service-account.yaml
kubectl create clusterrolebinding azure-devops-role-binding-svc --clusterrole=create-deployments --serviceaccount=default:azure-devops-svc
echo "Access create Namespace : " $(kubectl auth can-i create namespace --as=system:serviceaccount:default:azure-devops-svc)
echo "Access create Volume : " $(kubectl auth can-i create volume --as=system:serviceaccount:default:azure-devops-svc)
kubectl get secret $(kubectl get serviceAccounts azure-devops-svc -n default -o=jsonpath={.secrets[*].name}) -o json