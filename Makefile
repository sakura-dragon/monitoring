PWD=$(shell pwd)
USERID=$(shell id -u ${USER})
GROUPID=$(shell id -g ${USER})
BUILDIMAGE=dashboards-build-tools:local
DOCKERCMD=docker run -u ${USERID}:${GROUPID} -it -v ${PWD}:/app ${BUILDIMAGE}
DASHBOARD_OUT=manifests/dashboards/generated

.PHONY: all clean init generate buildtools

generate: buildtools init
	mkdir -p ${DASHBOARD_OUT}
	@${DOCKERCMD} jsonnet -J vendor -m ${DASHBOARD_OUT} -e '(import "mixin.libsonnet").grafanaDashboards'
	@./hacks/generate-dashboard-kustomize.sh	

buildtools:
	docker build -t ${BUILDIMAGE} -f Dockerfile .

init: buildtools
	@${DOCKERCMD} jb install github.com/kubernetes-monitoring/kubernetes-mixin

clean:
	git clean -Xfd .
	docker rmi ${BUILDIMAGE}
	rm -R ${DASHBOARD_OUT} manifests/dashboards/kustomization.yaml
