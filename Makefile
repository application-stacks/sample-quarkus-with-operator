build-image:
		docker build -f src/main/docker/Dockerfile.jvm -t quarkus/microprofile-health-jvm .
		echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
		docker push quarkus/microprofile-health-jvm