KDView = KD.classes.KDView

class KDB.Interface extends KDView
  constructor: (views) ->
    @views         = {}
    
    @views.sidebar = new KDView { cssClass: 'kdb-sidebar-view' }
    @views.search  = views.searchInputView
    @views.list    = views.sidebarListView

    @views.sidebar.addSubView @views.search
    @views.sidebar.addSubView @views.list

    @views.content = views.contentView

    mainView = new KD.classes.KDSplitView
      type     : 'vertical'
      resizeble: false
      sizes    : ['20%', '80%']
      views    : [@views.sidebar, @views.content]

    appView.addSubView mainView    # appView is globally and the main view provided by KDFramework

    return @views