os = require 'os'
fs = require 'fs'
path = require 'path'
process = require 'process'

class Locator
  exe: 'gtm'
  envPath: process.env.PATH
  defaultPath: "/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin/"

  constructor: ->
    if os.platform() == 'win32'
      console.log("Detected Windows. Adjusting logic...")
      pf = process.env.ProgramFiles + '\\gtm\\bin'
      pfx86 = process.env['ProgramFiles(x86)'] + '\\gtm\\bin'
      @defaultPath = pf + path.delimiter + pfx86
      @exe += ".exe"

  findGTM: ->
    pathsStr = @envPath + path.delimiter + @defaultPath
    paths = pathsStr.split(path.delimiter)
    console.log("Searching for " + @exe + " on path:" + pathsStr)
    fullPath = ''

    for sPath in paths
      try
        fullPath = sPath + path.sep + @exe
        console.log("Trying " + fullPath)
        if fs.statSync(fullPath).isFile()
          console.log("Found GTM: " + fullPath)
          return sPath
      catch error
        console.log("Not found at " + fullPath)

    console.log("GTM not found.")
    return ""

module.exports = Locator
