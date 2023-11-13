PWD=$(shell pwd)
USERID=$(shell id -u ${USER})
GROUPID=$(shell id -g ${USER})
BUILDIMAGE=dashboards-build-tools:local
DOCKERCMD=docker run -u ${USERID}:${GROUPID} -it -v ${PWD}:/app ${BUILDIMAGE}
DASHBOARD_OUT=files/dashboards

.PHONY: all clean init generate buildtools

generate: buildtools init
	mkdir -p files/dashboards
	@${DOCKERCMD} jsonnet -J vendor -m files/dashboards -e '(import "mixin.libsonnet").grafanaDashboards'

buildtools:
	docker build -t ${BUILDIMAGE} -f Dockerfile .

init: buildtools
	@${DOCKERCMD} jb install github.com/kubernetes-monitoring/kubernetes-mixin

clean:
	git clean -Xfd .
	docker rmi ${BUILDIMAGE}
