### Set Up

The source code for the application can be found at https://github.com/quarkusio/quarkus-quickstarts/tree/master/microprofile-health-quickstart. 

* Running the command `mvn -N io.takari:maven:wrapper` will generate the mvn folder.

### Dockerfile

You can choose to build the dockerfile in JVM mode or native mode depending on your needs. 

To run the dockerfile in JVM mode you will need to:

* First run the command `mvn package`
* Build the image by running `docker build -f src/main/docker/Dockerfile.jvm -t quarkus/microprofile-health-jvm .`
* Start the container by running `docker run -i --rm -p 8080:8080 quarkus/microprofile-health-jvm`

To run the dockerfile in native mode you will need to:

* First run the command `mvn package -Pnative -Dquarkus.native.container-build=true`
* Build the image by running `docker build -f src/main/docker/Dockerfile.native -t quarkus/microprofile-health .`
* Start the container by running `docker run -i --rm -p 8080:8080 quarkus/microprofile-health`

### Deployment

This application can be deployed by running the command `kubectl apply -f app-deploy.yaml` with the below yaml file and replacing the `RUNTIME_PROJECT_NAME`, `RUNTIME_DOCKER_IMAGE`, `RUNTIME_PORT`.

```
apiVersion: app.stacks/v1beta1
kind: RuntimeComponent
metadata:
  name: RUNTIME_PROJECT_NAME
spec:
  # Add fields here
  version: 1.0.0
  applicationImage: RUNTIME_DOCKER_IMAGE
  service:
    type: NodePort
    port: RUNTIME_PORT
    annotations:
      prometheus.io/scrape: 'true'
  readinessProbe:
    failureThreshold: 12
    httpGet:
      path: /health/ready
      port: RUNTIME_PORT
    initialDelaySeconds: 5
    periodSeconds: 2
    timeoutSeconds: 1
  livenessProbe:
    failureThreshold: 12
    httpGet:
      path: /health/live
      port: RUNTIME_PORT
    initialDelaySeconds: 5
    periodSeconds: 2
  expose: true
```

This application is taken from the repo: https://github.com/quarkusio/quarkus-quickstarts  
Details about the requirements and other quickstart applications can be found at the above link.  
A guide for a step-by-step walk through of the application can be found at the below link.  
Quarkus guide: https://quarkus.io/guides/microprofile-health
