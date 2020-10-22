set -e
gcloud container clusters get-credentials --region "$$CLOUDSDK_COMPUTE_REGION" "$$CLOUDSDK_CONTAINER_CLUSTER"
for SERVICE in queuereader_fishnet; do
  sed "s/gcr.io\/$${PROJECT_ID}\/$${IMAGE/\//\\\/}/gcr.io\/${PROJECT_ID}\/$${IMAGE/\//\\\/}:${SHORT_SHA}/g" \
  $${APP}/conf/deployment_$${SERVICE}_$${CLOUDSDK_CONTAINER_CLUSTER}.yaml \
  | kubectl apply -f -
  # Get the latest revision (avoid always watching '0' the latest revision which will pick up new deployments)
  REVISION=$$(kubectl -n $${APP} rollout history deployment $${SERVICE//_/-} \
  -o 'jsonpath={.metadata.annotations.deployment\.kubernetes\.io/revision}')
  kubectl -n $${APP} rollout status deployment $${SERVICE//_/-} --revision=$${REVISION} --watch=true --timeout=5m
done
