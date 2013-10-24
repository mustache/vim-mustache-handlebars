Vim for Mustache and Handlebars
===============================

mustache.vim is a simple plugin for working with mustache and handlebars
templates. It has:
 - syntax highlighting,
 - support for matchit and
 - mustache abbreviations support (optional)
 - support for section movement mappings `[[` and `]]`


### Install for pathogen

    cd ~/.vim/
    git submodule add git://github.com/juvenn/mustache.vim.git bundle/mustache
    vim bundle/mustache/example.mustache

### Manually Install

    cd ~/.local/src
    git clone git://github.com/juvenn/mustache.vim.git
    cp -R mustache.vim/syntax/* ~/.vim/syntax/
    cp -R mustache.vim/ftdetect/* ~/.vim/ftdetect/
    cp -R mustache.vim/ftplugin/* ~/.vim/ftplugin/
    vim mustache.vim/example.mustache

### Mustache Abbreviations

You can activate mustache abbreviations by putting this line in your `.vimrc`:
`let g:mustache_abbreviations = 1`

Now you get a set of convenient abbreviations. Underscore `_` indicates where
your cursor ends up after typing an abbreviation:
 - `{{` => `{{_}}`
 - `{{{` => `{{{_}}}`
 - `{{!` => `{{!_}}`
 - `{{>` => `{{>_}}`
 - `{{<` => `{{<_}}`
 - `{{#` produces

   ```
   {{# _}}
   {{/}}
   ```
 - `{{if` produces

   ```
   {{#if _}}
   {{/if}}
   ```
 - `{{ife` produces

   ```
   {{#if _}}
   {{else}}
   {{/if}}
   ```

### Section movement mappings

Following the vim convention of jumping from section to section, `[[` and `]]`
mappings are implemented for easier movement between mustache tags.

 - `]]` jumps to the first following tag
 - `[[` jumps to the first previous tag

Count with section movements is supported:

 - `2]]` jumps to the second next tag

## Authors

* [bruno-](https://github.com/bruno-)
* [juvenn](https://github.com/juvenn)

Thanks [5long](https://github.com/5long) for adding matchit support.

You're encouraged to propose ideas or have discussions via github
issues.
