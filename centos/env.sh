#!/bin/bash
. ../config/env.sh
export SSO_DOCKER_IMAGE=${SSO_DOCKER_IMAGE:-miracl-sso-centos}
export SSO_DOCKER_CONTAINER=${SSO_DOCKER_CONTAINER:-miracl-sso-centos}
export SSO_DOCKER_REDIS=redis
export SSO_DOCKER_COMPOSE="docker-compose -f ../environment/docker-compose.yml"
export SSO_DOCKER_CONTEXT=$(pwd)
