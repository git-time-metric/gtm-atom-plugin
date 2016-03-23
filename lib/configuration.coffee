module.exports =
  config:
    useInfluxtime:
      title: "Use Influxtime"
      description: "Use the Influxtime Engine to track project time? You can use both GTM and Influxtime at the same time."
      type: "boolean"
      default: false
    useGTM:
      title: "Use GTM"
      description: "Use the GTM Engine to track project time? You can use both GTM and Influxtime at the same time."
      type: "boolean"
      default: false
    InfluxtimeLocation:
      title: "Location of the influxtime executable"
      description: "Configure the location of your influxtime executable. Being on the PATH is not enough."
      type: "string"
      default: "/usr/local/bin"
    GTMLocation:
      title: "Location of the GTM executable"
      description: "Configure the location of your GTM executable. Being on the PATH is not enough."
      type: "string"
      default: "/usr/local/bin"
