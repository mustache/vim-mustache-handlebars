if has("autocmd")
  au BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=html.mustache syntax=mustache | runtime! indent/handlebars.vim
  au BufNewFile,BufRead *.handlebars,*.hdbs,*.hbs,*.hb set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
