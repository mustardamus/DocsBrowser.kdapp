fs   = require 'fs'
path = require 'path'

class KDParser
  constructor: ->
    @rootDir = path.resolve(__dirname, '..')
    @tmpDir  = "#{@rootDir}/tmp"
    @wikiDir = "#{@tmpDir}/koding-wiki"

    unless fs.existsSync(@wikiDir)
      console.log "#{@wikiDir} does not exist."
      return

    filez = @recursiveDir
      path   : "#{@wikiDir}/framework"
      exclude: ['index.md', 'first_app']
    
    console.log filez

  recursiveDir: (options) ->
    exclude   = options.exclude
    resultArr = []
    folders   = fs.readdirSync options.path

    for folder in folders
      continue unless exclude.indexOf(folder) is -1

      fullPath = "#{options.path}/#{folder}"
      fileStat = fs.statSync(fullPath)

      if fileStat and fileStat.isDirectory()
        files    = fs.readdirSync fullPath
        filesArr = []

        for file in files
          continue unless exclude.indexOf(file) is -1

          filesArr.push
            filePath: "#{fullPath}/#{folder}/#{file}"
            fileName: file

        resultArr.push
          folderPath: "#{fullPath}"
          folderName: folder
          files     : filesArr

    resultArr


new KDParser