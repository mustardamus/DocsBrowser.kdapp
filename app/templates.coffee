class KDB.Templates
  contentDefault: """
    <p>
      This is the default template for the content. Located in
      templates.coffee and accessible via KDB.templates.contentDefault
    </p>
  """

  contentSetup: """
    <p>
      Looks like the documentation has not been generated yet.
    </p>
  """

  contentSetupLoad: """
    <p>
      loading...
    </p>
  """

  sidebarListItem: (options, category, entry) -> """
    <a href='##{options.docsPath}/#{category.slug}/#{entry.slug}#{options.extension}'>
      #{entry.title}
    </a>
  """