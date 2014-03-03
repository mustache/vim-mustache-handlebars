if has("autocmd")
  au  BufNewFile,BufRead *.mustache,*.handlebars,*.hbs,*.hogan,*.hulk,*.hjs,*.hbt set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
