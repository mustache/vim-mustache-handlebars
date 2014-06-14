if has("autocmd")
  au  BufNewFile,BufRead *.mustache,*.handlebars,*.hbs,*.hdbs,*.hogan,*.hulk,*.hjs set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
