" Mustache & Handlebars syntax
" Language:	Mustache, Handlebars
" Maintainer:	Juvenn Woo <machese@gmail.com>
" Screenshot:   http://imgur.com/6F408
" Version:	3
" Last Change:  26 Nov 2018
" Remarks: based on eruby indent plugin by tpope
" References:
"   [Mustache](http://github.com/defunkt/mustache)
"   [Handlebars](https://github.com/wycats/handlebars.js)
"   [ctemplate](http://code.google.com/p/google-ctemplate/)
"   [ctemplate doc](http://google-ctemplate.googlecode.com/svn/trunk/doc/howto.html)
"   [et](http://www.ivan.fomichev.name/2008/05/erlang-template-engine-prototype.html)

if exists("b:did_indent_hbs")
  finish
endif

unlet! b:did_indent
setlocal indentexpr=

" keep track of whether or not we are in a block expression for indenting
unlet! s:in_block_expr

runtime! indent/html.vim
unlet! b:did_indent

" Force HTML indent to not keep state.
let b:html_indent_usestate = 0

if &l:indentexpr == ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
  endif
endif
let b:handlebars_subtype_indentexpr = &l:indentexpr

let b:did_indent = 1
let b:did_indent_hbs = 1

setlocal indentexpr=GetHandlebarsIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when

" Only define the function once.
if exists("*GetHandlebarsIndent")
  finish
endif

function! GetHandlebarsIndent(...)
  " The value of a single shift-width
  if exists('*shiftwidth')
    let sw = shiftwidth()
  else
    let sw = &sw
  endif

  if a:0 && a:1 == '.'
    let v:lnum = line('.')
  elseif a:0 && a:1 =~ '^\d'
    let v:lnum = a:1
  endif
  let vcol = col('.')
  call cursor(v:lnum,1)
  call cursor(v:lnum,vcol)
  exe "let ind = ".b:handlebars_subtype_indentexpr

  " Workaround for Andy Wokula's HTML indent. This should be removed after
  " some time, since the newest version is fixed in a different way.
  if b:handlebars_subtype_indentexpr =~# '^HtmlIndent('
  \ && exists('b:indent')
  \ && type(b:indent) == type({})
  \ && has_key(b:indent, 'lnum')
    " Force HTML indent to not keep state
    let b:indent.lnum = -1
  endif
  let lnum = prevnonblank(v:lnum-1)
  let prevLine = getline(lnum)
  let currentLine = getline(v:lnum)

  " all indent rules only apply if the block opening/closing
  " tag is on a separate line

  " " check for a hanging attribute
  let lastLnumCol = col([lnum, '$']) - 1
  if synIDattr(synID(lnum, lastLnumCol, 1), "name") =~ '^mustache'
        \ && prevLine !~# '}}\s*$'
    let hangingAttributePattern = '{{\#\=\%(\k\|[/-]\)\+\s\+\zs\k\+='
    let standaloneComponentPattern = '^\s*{{\%(\k\|[/-]\)\+\s*$'

    if prevLine =~ hangingAttributePattern
      " {{component attribute=value
      "             other=value}}
      let [line, col] = searchpos(hangingAttributePattern, 'Wbn', lnum)
      if line == lnum
        return col - 1
      endif
    elseif prevLine =~ standaloneComponentPattern
      " {{component
      "   attribute=value}}
      return indent(lnum) + sw
    endif
  endif

  " check for a closing }}, indent according to the opening one
  let saved_pos = getpos('.')
  if prevLine =~# '}}$' && prevLine !~# '^\s*{{' && search('}}$', 'Wb')
    let [line, col] = searchpairpos('{{', '', '}}', 'Wb')
    if line > 0
      if strpart(getline(line), col - 1, 3) == '{{#'
        " then it's a block component, indent a shiftwidth more
        return indent(line) + sw
      else
        return indent(line)
      endif
    else
      call setpos('.', saved_pos)
    endif
  endif

  " indent after block {{#block
  if prevLine =~# '\v\s*\{\{\#.*\s*' &&
        \ prevLine !~# '{{#\(.\{}\)\s.\{}}}.*{{\/\1}}'
    let s:in_block_expr = 1
    let ind = ind + sw
  endif
  " but not if the block ends on the same line
  if prevLine =~# '\v\s*\{\{\#(.+)(\s+|\}\}).*\{\{\/\1'
    let s:in_block_expr = 0
    let ind = ind - sw
  endif
  " unindent after block close {{/block}}
  if currentLine =~# '\v^\s*\{\{\/\S*\}\}\s*'
    let s:in_block_expr = 0
    let ind = ind - sw
  endif
  " indent after component block {{a-component
  if prevLine =~# '\v\s*\{\{\w'
    let s:in_block_expr = 0
    let ind = ind + sw
  endif
  " but not if the component block ends on the same line
  if prevLine =~# '\v\s*\{\{\w(.+)\}\}'
    let ind = ind - sw
  endif
  " unindent }} lines, and following lines if not inside a block expression
  if currentLine =~# '\v^\s*\}\}\s*$' || (currentLine !~# '\v^\s*\{\{\/' && prevLine =~# '\v^\s*[^\{\} \t]+\}\}\s*$')
    if !s:in_block_expr
      let ind = ind - sw
    endif
  endif
  " unindent {{else}}
  if currentLine =~# '\v^\s*\{\{else.*\}\}\s*$'
    let ind = ind - sw
  endif
  " indent again after {{else}}
  if prevLine =~# '\v^\s*\{\{else.*\}\}\s*$'
    let ind = ind + sw
  endif

  return ind
endfunction
