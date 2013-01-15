class KDB.Content extends KD.classes.KDView
  constructor: ->
    @cmd         = new KDB.Cmd
    @contentView = new KDView
      cssClass: 'kdb-content-view'
      partial : KDB.templates.contentDefault

    @contentView.domElement.css 'overflow', 'auto'

    KDB.events.on 'setup show', =>
      runSetupBtn = new KD.classes.KDButtonView
        cssClass: 'clean-gray kdb-setup-btn'
        title   : 'Generate Documentation'
        callback: -> KDB.events.emit 'setup run'

      @contentView.updatePartial KDB.templates.contentSetup
      @contentView.addSubView runSetupBtn

    KDB.events.on 'setup load', =>
      @contentView.updatePartial KDB.templates.contentSetupLoad

    KDB.events.on 'setup done', =>
      @contentView.updatePartial KDB.templates.contentDefault
      new KD.classes.KDNotificationView
        title: 'Documentation generated successfully'

    KDB.events.on 'content load', (url) => @loadContent(url)

    return @contentView

  loadContent: (path) ->
    @cmd.execute "cat #{path}", 
      success: (res) =>
        @contentView.updatePartial res