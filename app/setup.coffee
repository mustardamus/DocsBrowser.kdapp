class KDB.Setup
  constructor: ->
    @cmd       = new KDB.Cmd
    @rootDir   = '~/Applications/DocsBrowser.kdapp'
    @parserLib = "#{@rootDir}/lib/parser.coffee"

    @cmd.execute "ls #{@rootDir}/docs",
      error: -> KDB.events.emit 'setup show'

    KDB.events.on 'setup run', => @runParser()

  runParser: ->
    @cmd.execute "coffee #{@parserLib}",
      success: (res) => KDB.events.emit 'setup done'
      error: -> console.log 'ow, no parser found'