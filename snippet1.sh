docker pull "gcr.io/${PROJECT_ID}/${_IMAGE}:${SHORT_SHA}" || \
docker build  --build-arg VERSION=${COMMIT_SHA} \
  -t "gcr.io/${PROJECT_ID}/${_IMAGE}:${SHORT_SHA}" \
  -t "gcr.io/${PROJECT_ID}/${_IMAGE}:latest" \
  -f "${_APP}/Dockerfile" .
