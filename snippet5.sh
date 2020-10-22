apiVersion: skaffold/v2alpha1
kind: Config
metadata:
  name: queuereader-fishnet
build:
  tagPolicy:
    gitCommit: {}
  artifacts:
  - image: gcr.io/bitly-gcp-prod/fishnet/fishnet
    docker:
      dockerfile: fishnet/Dockerfile
deploy:
  kubectl:
    manifests:
    - conf/staging.yaml
profiles:
  - name: prod
    deploy:
      kubectl:
        manifests:
        - conf/production.yaml
