module.exports =
  config:
    useGTM:
      title: "Use GTM"
      description: "Use the GTM Engine to track project time?"
      type: "boolean"
      default: false
    GTMLocation:
      title: "Location of the GTM executable"
      description: "Configure the location of your GTM executable. Being on the PATH is not enough."
      type: "string"
      default: "/usr/local/bin"
