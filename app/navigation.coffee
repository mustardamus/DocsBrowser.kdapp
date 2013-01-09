class KDB.SidebarListItem extends KD.classes.KDListItemView
  constructor: (options, data) ->
    super

    options.cssClass = "class-item"

  partial: (data) ->
    "<a href=#> » #{data.name}</a>"

  click:->
    listView = @getDelegate()
    #listView.emit "showClassDetails", @getData().name
    console.log 'clicked', @getData().name

class KDB.SidebarList extends KD.classes.KDView
  constructor: ->
    @listCtrl = new KD.classes.KDListViewController   # creates a view as well if not defined
      viewOptions: { itemClass: KDB.SidebarListItem }

    @initializeEntries()

    return @listCtrl.getView() # view initialized in init.coffee

  initializeEntries: ->
    @listCtrl.addItem { name: 'uno' }