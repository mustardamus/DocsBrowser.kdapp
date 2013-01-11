fs   = require 'fs'
path = require 'path'
md   = require 'markdown'

class KDParser
  constructor: ->
    @rootDir = path.resolve(__dirname, '..')
    @tmpDir  = "#{@rootDir}/tmp"
    @wikiDir = "#{@tmpDir}/koding-wiki"
    @docsDir = "#{@rootDir}/docs"

    unless fs.existsSync(@wikiDir)
      console.log "#{@wikiDir} does not exist."
      return

    components = @recursiveDir
      path   : "#{@wikiDir}/framework"
      exclude: ['index.md', 'first_app']
    
    @parseFiles components

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
            filePath: "#{fullPath}/#{file}"
            fileName: file

        resultArr.push
          folderPath: "#{fullPath}"
          folderName: folder
          files     : filesArr

    resultArr

  parseFiles: (folderArr) ->
    fs.mkdirSync(@docsDir) unless fs.existsSync(@docsDir)

    for folder in folderArr
      destFolder = "#{@docsDir}/#{folder.folderName}"

      fs.mkdirSync(destFolder) unless fs.existsSync(destFolder)

      for file in folder.files
        fileName = file.fileName

        if fileName.substr(fileName.length - 3, 3) is '.md'  #only markdown files for now
          fileName    = fileName.substr(0, fileName.length - 3)
          mdContent   = fs.readFileSync(file.filePath, 'utf-8')
          htmlContent = md.markdown.toHTML(mdContent)

          fs.writeFile "#{destFolder}/#{fileName}.html", htmlContent, 'utf-8'
          console.log "Parsed #{fileName}"


new KDParser