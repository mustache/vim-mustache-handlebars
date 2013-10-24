mustache and handlebars mode for vim
====================================

A vim plugin for working with [mustache][mustache] and
[handlebars][handlebars] templates. It has:

 - syntax highlighting
 - matchit support
 - mustache abbreviations (optional)
 - section movement mappings `[[` and `]]`


### Install for pathogen

    cd ~/.vim/
    git submodule add git://github.com/mustache/vim-mode.git bundle/mustache
    vim bundle/mustache/example.mustache

Get [pathogen][pathogen].

### Manually Install

    cd ~/.local/src
    git clone git://github.com/mustache/vim-mode.git mustache.vim
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

## Maintainers

* [Bruno Michel](http://github.com/nono)
* [Bruno Sutic](http://github.com/bruno-)
* [Juvenn Woo](http://github.com/juvenn)

This is combined work from
[juvenn/mustache.vim](http://github.com/juvenn/mustache.vim) and
[nono/vim-handlebars](http://github.com/nono/vim-handlebars).

----

Thanks [@5long](http://github.com/5long) for adding matchit support.

You're encouraged to propose ideas or have discussions via github
issues.

[mustache]: http://mustache.github.io
[handlebars]: http://handlebarsjs.com
[pathogen]: https://github.com/tpope/vim-pathogen
