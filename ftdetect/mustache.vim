if has("autocmd")
  au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=mustache
  au  BufNewFile,BufRead *.handlebars,*.hdbs,*.hbs,*.hb set filetype=mustache
endif
