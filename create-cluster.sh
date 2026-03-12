CLUSTER_NAME="secure-gitops-lab"

# Supprimer l'ancien cluster s'il existe pour repartir de zéro
k3d cluster delete $CLUSTER_NAME 2>/dev/null

echo "Création du cluster $CLUSTER_NAME..."

# Création avec les bons paramètres
k3d cluster create $CLUSTER_NAME \
    --agents 2 \
    --port "8182:80@loadbalancer" \
    --port "8443:443@loadbalancer" \
    --api-port 6443 \
    --wait

echo "Cluster bien créé !"
echo "Vérification du contexte..."
kubectl config use-context k3d-$CLUSTER_NAME
kubectl get nodes