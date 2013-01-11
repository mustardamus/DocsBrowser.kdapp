fs   = require 'fs'
path = require 'path'
md   = require 'markdown'
exec = require('child_process').exec

class KDParser
  constructor: ->
    @rootDir   = path.resolve(__dirname, '..')
    @tmpDir    = "#{@rootDir}/tmp"
    @wikiUrl   = 'https://github.com/farslan/koding-wiki.git'
    @wikiDir   = "#{@tmpDir}/koding-wiki"
    @docsDir   = "#{@rootDir}/docs"
    @indexFile = "#{@docsDir}/index.json"

    @cloneRepo ->
      mdFiles = @recursiveDir
        path   : "#{@wikiDir}/framework"
        exclude: ['index.md', 'first_app']
      
      htmlFiles = @parseFiles(mdFiles)
      @generateIndex htmlFiles

      console.log 'Done.'

  cloneRepo: (callback) ->
    cmd = ''

    fs.mkdirSync(@tmpDir) unless fs.existsSync(@tmpDir)

    if fs.existsSync(@wikiDir)
      cmd = "cd #{@wikiDir} && git pull"
      console.log "Updating repo..."
    else
      cmd = "cd #{@tmpDir} && git clone #{@wikiUrl}"
      console.log "Cloning repo..."

    exec cmd, (err, stdout, stderr) => callback.call @

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
    retArr = []

    fs.mkdirSync(@docsDir) unless fs.existsSync(@docsDir)

    for folder in folderArr
      srcFolder  = folder.folderName
      destFolder = "#{@docsDir}/#{srcFolder}"

      fs.mkdirSync(destFolder) unless fs.existsSync(destFolder)

      retArr.push
        slug   : srcFolder
        title  : srcFolder.charAt(0).toUpperCase() + srcFolder.substr(1, srcFolder.length)
        entries: []

      for file in folder.files
        fileName = file.fileName

        if fileName.substr(fileName.length - 3, 3) is '.md'  #only markdown files for now
          fileName    = fileName.substr(0, fileName.length - 3)
          mdContent   = fs.readFileSync(file.filePath, 'utf-8')
          htmlContent = md.markdown.toHTML(mdContent)

          fs.writeFile "#{destFolder}/#{fileName}.html", htmlContent, 'utf-8'
          console.log "Parsed #{fileName}"

          retArr[retArr.length - 1].entries.push
            slug : fileName
            title: fileName

    retArr

  generateIndex: (filesIndex) ->
    # todo: strip out logic of parseFiles
    fs.writeFile @indexFile, JSON.stringify(filesIndex), 'utf-8'
    console.log 'Generated index.json'


new KDParser