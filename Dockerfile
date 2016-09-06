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

ENV STACKSMITH_STACK_ID="xnxu1n9" \
    STACKSMITH_STACK_NAME="Node.js for ivaramme/gulp-tasks-docker" \
    STACKSMITH_STACK_PRIVATE="1"

RUN bitnami-pkg install node-6.5.0-0 --checksum 52cb7f26dff5661fadb0d3ca50ff4e267b746604a935b3299c3a9383104d0055

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
