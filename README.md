mustache and handlebars mode for vim
====================================

A vim plugin for working with [mustache][mustache] and
[handlebars][handlebars] templates. It has:

 - syntax highlighting
 - matchit support
 - mustache abbreviations (optional)
 - section movement mappings `[[` and `]]`
 - text objects `ie` (inside element) and `ae` (around element)

**Note**: for compatibility reason #7, we've renamed the repo name from
`vim-mode` to `vim-mustache-handlebars`.

### Install for pathogen

    cd ~/.vim/
    git submodule add git://github.com/mustache/vim-mustache-handlebars.git bundle/mustache
    vim bundle/mustache/example.mustache

Get [pathogen][pathogen].

### Install for vundle

Add `Bundle 'mustache/vim-mustache-handlebars'` to your `.vimrc` and do a `:BundleInstall`.

### Manually Install

    cd ~/.local/src
    git clone git://github.com/mustache/vim-mustache-handlebars.git mustache.vim
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

### Text objects

Vim has a very powerful concept of "text objects". If you aren't using text objects,
you can get familiar with it on [this vim help
link](http://vimdoc.sourceforge.net/htmldoc/motion.html#text-objects). Learning
text objects really speeds up the vim workflow.

In that spirit, this plugin defines 2 text objects:
 - `ie` a mnemonic for `inside element`, selects all the text inside the
   mustache tag.
   For example, when used with `vie` it will visually select the
   bold text in the following snippets: {{**some_variable**}},
   {{{**different_variable**}}}.
 - `ae` a mnemonic for `around element`, selects the whole mustache tag,
   including the curly braces.
   Example, `vae` visually selects the bold text in the following
   snippets: **{{some_variable}}** or **{{{another_variable}}}**.

Here are other usage examples:
 - `dae` - deletes the whole mustache tag, including the curly braces
 - `die` - deletes **inside* the mustache tag, leaving only curly braces
 - `yae` - "yanks" the whole mustache tag - with curly braces
 - `cie` - deletes **inside** the mustache tag and goes in insert mode


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
