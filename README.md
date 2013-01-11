# Documentation Browser for the KDFramework.

## Docs Parser

- clone from https://github.com/farslan/koding-wiki.git
- go through all folders/files in framework/ (core/ tbd)
- convert the markdown to html
- save converted files in docs/[category]/[slug].html
- generate a index.json of all parsed files

## Docs Browser

- check if docs are parsed
- if not invoke the parser (coffee lib/parser.coffee)
- load index.json via ajax
- generate the sidebar navigation from the data
- on entry click load the .html docs file via ajax
- history navigation via hash (method in KDframework?)

## Todo

- fix inline links (browser side)
- loading partial when docs are generated