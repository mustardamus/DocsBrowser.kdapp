class KDB.Cmd
  constructor: ->
    @kiteCtrl = KD.getSingleton 'kiteController'

  execute: (command, callbacks = {}) ->
    @kiteCtrl.run command, (err, res) ->
      unless err
        callbacks.success.call @, res if callbacks.success
      else
        callbacks.error.call @, err if callbacks.error