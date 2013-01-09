class KDB.Setup
  constructor: ->
    @cmd       = new KDB.Cmd
    @rootDir   = '~/Applications/DocsBrowser.kdapp'
    @tmpDir    = "#{@rootDir}/tmp"
    @wikiDir   = "#{@tmpDir}/koding-wiki"
    @wikiUrl   = 'https://github.com/farslan/koding-wiki.git'
    @parserLib = "#{@rootDir}/lib/parser.coffee"

    @cmd.execute "ls #{@tmpDir}",
      error: -> KDB.events.emit 'setup show'

    KDB.events.on 'setup run', => @initSetup()

  initSetup: ->
    @cmd.execute "mkdir #{@tmpDir}",
      success: => @cloneRepo()
      error: -> console.log 'creating tmp/ failed'

  cloneRepo: ->
    @cmd.execute "cd #{@tmpDir} && git clone #{@wikiUrl}",
      success: =>
        @runParser()
        new KD.classes.KDNotificationView
          title: 'Documentation cloned successfully'
      error: -> console.log 'oww, cloning failed'

  runParser: ->
    @cmd.execute "coffee #{@parserLib}",
      success: (res) =>
        KDB.events.emit 'setup done'
      error: -> console.log 'ow, no parser found'