variable "image_in" {
  type = map(any)
  default = {
    "nodered" : {
      "dev" : "nodered/node-red:latest-minimal",
      "prod" : "nodered/node-red:latest-minimal"
    },
    "influxdb" : {
      "dev" : "quay.io/influxdb/influxdb:v2.0.3"
      "prod" : "quay.io/influxdb/influxdb:v2.0.3"
    },
    "grafana" : {
      "dev" : "grafana/grafana:5.1.0",
      "prod" : "grafana/grafana:5.1.0"
    }
  }
}

variable "external_port" {

}