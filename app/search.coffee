class KDB.Search extends KD.classes.KDView
  constructor: (ctrl) ->
    @listCtrl    = ctrl.sidebarListCtrl
    @searchInput = new KD.classes.KDInputView
      cssClass: 'search-view'
      placeholder: 'Search'

    @searchInput.listenTo
      KDEventTypes: ['keyup']
      callback: (T, e) => @onKeyUp(e.keyCode)

    return @searchInput

  onKeyUp: (keyCode) ->
    val = @searchInput.getValue()

    if val.length is 0 or keyCode is 27 #ESC
      @showAllEntries()
      @searchInput.setValue ''
    else
      @findEntries val

  showAllEntries: ->
    for entry in @listCtrl.itemsOrdered
      entry.domElement.show()

  findEntries: (term) ->
    term = term.toLowerCase()

    for entry in @listCtrl.itemsOrdered
      slug = entry.data.entry.slug.toLowerCase()

      unless slug.indexOf(term) is -1
        entry.domElement.show()
      else
        entry.domElement.hide()