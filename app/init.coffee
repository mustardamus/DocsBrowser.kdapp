KDB.templates = new KDB.Templates
KDB.events    = new KD.classes.KDView # global event handler

dbSidebarList = new KDB.SidebarList
dbSearchInput = new KDB.Search
  sidebarListCtrl: dbSidebarList.ctrl
dbContent     = new KDB.Content
dbInterface   = new KDB.Interface
  sidebarListView: dbSidebarList.view
  searchInputView: dbSearchInput
  contentView    : dbContent
  
dbSetup       = new KDB.Setup