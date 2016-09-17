## BUILDING
##   (from project root directory)
##   $ docker build -t node-js-for-ivaramme-gulp-tasks-docker .
##
## RUNNING
##   $ docker run -p 3000:3000 node-js-for-ivaramme-gulp-tasks-docker
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:3000
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r9

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="i76alv1" \
    STACKSMITH_STACK_NAME="Node.js for ivaramme/gulp-tasks-docker" \
    STACKSMITH_STACK_PRIVATE="1"

RUN bitnami-pkg install node-6.6.0-0 --checksum 19f658d538e22a2129ff8044ff4c1e0b0dd01676820d66b508faef076bc6ea84

ENV PATH=/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH \
    NODE_PATH=/opt/bitnami/node/lib/node_modules

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

COPY rootfs/ /

# Node base template
COPY . /app
WORKDIR /app

EXPOSE 3000

RUN npm install -g gulp

ENTRYPOINT ["/app-entrypoint.sh"]
