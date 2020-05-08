build-image:
		docker build -f src/main/docker/Dockerfile.jvm -t applicationstacks/runtime-app-samples:quarkus-microprofile-health .
		echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
		docker push applicationstacks/runtime-app-samples:quarkus-microprofile-health