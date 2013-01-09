class KDB.Search extends KD.classes.KDView
  constructor: ->
    @searchInput = new KD.classes.KDInputView
      cssClass: 'search-view'
      placeholder: 'Search'

    @searchInput.listenTo
      KDEventTypes: ['keyup']
      callback: (T, e) => @onKeyUp(e.keyCode)

    return @searchInput

  onKeyUp: (keyCode) ->
    console.log 'key pressed', keyCode, @searchInput.getValue()