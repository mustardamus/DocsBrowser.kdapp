class KDB.SidebarListItem extends KD.classes.KDListItemView
  constructor: (options, data) ->
    super

    options.cssClass = "kdb-sidebar-entry"
    @options         = data.options
    @category        = data.category
    @entry           = data.entry

  partial: -> 
    KDB.templates.sidebarListItem @options, @category, @entry

  click: (event) ->
    # hash should change to access pages of the docs
    path = "#{@options.rootPath}/#{@options.docsPath}/#{@category.slug}/#{@entry.slug}#{@options.extension}"
    
    KDB.events.emit 'content load', path

class KDB.SidebarList extends KD.classes.KDView
  defaults:
    rootPath : '~/Applications/DocsBrowser.kdapp'
    docsPath : "docs"
    indexFile: 'index.json'
    extension: '.html'
    # define how index.json is structured and how it should be parsed

  constructor: (options) ->
    @options  = $.extend(@defaults, options)
    @cmd      = new KDB.Cmd
    @listCtrl = new KD.classes.KDListViewController   # creates a view as well if not defined
      viewOptions:
        cssClass : 'kdb-sidebar-navigation'
        itemClass: KDB.SidebarListItem

    @initializeEntries()
    KDB.events.on 'setup done', => @initializeEntries()

    return {
      ctrl: @listCtrl
      view: @listCtrl.getView()
    }

  initializeEntries: ->
    @cmd.execute "cat #{@options.rootPath}/#{@options.docsPath}/#{@options.indexFile}",
      success: (res) => @parseEntries(JSON.parse(res))
      error: -> console.log 'oh noes, no index file found'

  parseEntries: (categories) ->
    # todo: list in list?
    for category in categories
      for entry in category.entries
        @listCtrl.addItem
          options : @options
          category: category
          entry   : entry