local kubernetes = import "kubernetes-mixin/mixin.libsonnet";

kubernetes {
  _config+:: {
    grafanaK8s+:: {
      dashboardNamePrefix: 'Mixin / ',
      dashboardTags: ['kubernetes', 'infrastucture'],
    },
  },
}