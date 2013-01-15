class KDB.Templates
  contentDefault: """
    <h1>KDFramework Documentation Browser</h1>
    <p>
      Welcome to the documentation browser for the KDFramework.
      (<a href="https://github.com/mustardamus/DocsBrowser.kdapp">Repo</a>).
    </p>
    <p>
      This is still under development. Please let me know any issues you encounter in the
      <a href="https://github.com/mustardamus/DocsBrowser.kdapp/issues">Github Issue Page</a>.
    </p>
    <p>
      The documentation is written by
      <a href="https://koding.com/arslan">@arslan</a>.
    </p>
  """

  contentSetup: """
    <h1>KDFramework Documentation Browser - Setup</h1>
    <p>
      You don't have generated the documentation yet. Please press the
      button below to proceed. It may take a minute. The setup only need
      to be run once. The following will happen:
    </p>
    <ul>
      <li>Install <a href="https://github.com/evilstreak/markdown-js">Markdown</a> Node Module</li>
      <li>Clone <a href="https://github.com/farslan/koding-wiki">koding-wiki</a></li>
      <li>Iterate over the markdown files and convert them to HTML</li>
      <li>Generate a index.json used by the documentation browser</li>
      <li>Load the sidebar navigation</li>
    </ul>
  """

  contentSetupLoad: """
    <h1>KDFramework Documentation Browser - Setup</h1>
    <p>
      Generating documentation. This may take a minute...
    </p>
  """

  sidebarListItem: (options, category, entry) -> """
    <a href='##{options.docsPath}/#{category.slug}/#{entry.slug}#{options.extension}'>
      #{entry.title}
    </a>
  """