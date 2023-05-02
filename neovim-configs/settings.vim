colorscheme iceberg
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set background=light

lua require('dap-python').setup('/.virtualenvs/debugpy/bin/python')
nnoremap <leader>b :DapToggleBreakpoint<CR>
nnoremap <leader>n :DapContinue<CR>



"              ____        _   _                 
"             |  _ \ _   _| |_| |__   ___  _ __  
"             | |_) | | | | __| '_ \ / _ \| '_ \ 
"             |  __/| |_| | |_| | | | (_) | | | |
"             |_|    \__, |\__|_| |_|\___/|_| |_|
"                    |___/                       
"
" kw : Python, pythonfunctions

" jupyter new line:

function! Newjupyterline()
    norm o"\n",
    norm 0f"l
    call feedkeys('i')
endfunction
let @n =  "execute 'call Newjupyterline()'<CR>"
"command! Newline execute 'call Newjupyterline()



" Ipython :
"command! Ipy :terminal 

" ------------------------------------------
"Standard python imports
" ------------------------------------------
function! Print_bar()
	norm oprint('----------------------------------------')
endfunction
command! Bar execute 'call Print_bar()'


" ------------------------------------------
" Timing a python script:
" ------------------------------------------
function! T0()
	norm oT0 = time.time()
endfunction	

function! T1()
	norm oT1 = time.time()
	norm odiff = T1-T0 
	norm oprint(diff)
endfunction	

command! Time0 execute 'call T0()'
command! Time1 execute 'call T1()'

" if __name__=="__main__":
function! Ifname()
    norm iif __name__=="__main__":
    norm omain()
endfunction
command! Ifname execute 'call Ifname()'


"--------------------------------------------------------
" Function for aranging the arguments of a function
" vertically
"--------------------------------------------------------
function! ArrangeArguments()
        norm f(l
        let indentpos = col('.')
        norm Wi
endfunction
command! ArrangeArguments execute 'call ArrangeArguments()'



"---------------------------------------------------------------
" ctrl+s will add a printout statement for variable.shape
"---------------------------------------------------------------
function! Printout_shape()
	norm mcyiW}koprint() 
	norm hPa.shape
	norm `c
endfunction
map <c-s> :call Printout_shape()<c-j>




" ctrl+o makes new line with empty line between
"map <c-o> oa<Esc>dlo
" Make ctrl o add new empty line without insert mode
"noremap <c-o> o<Esc>d0


"----------------------------------------------
" make var to np.array(var)
"----------------------------------------------
function! Nparray()
	norm yiwoa
	norm pbdlyiw$a = np.array()
	norm P
endfunction
command! Ar execute 'call Nparray()'



"let g:tex_flavor = 'latex' 


"----------------------------------------------
" Standard python imports
"----------------------------------------------
" function! Standard_python_imports()
" 	norm iimport numpy as np
" 	norm oimport matplotlib.pyplot as plt
" 	norm oimport time
" 	norm oimport sys
" 	norm oimport os
" endfunction
" command! Imps execute 'call Standard_python_imports()'


"----------------------------------------------
" Snippets :
"----------------------------------------------
command! Imps execute ':r' . USEFHOME . '/snippets/imps.py'

command! Imp Imps

" IPython
command! Ipy execute ":normal ofrom IPython import embed; embed()"

" matplotlib:
command! Plt execute ":normal oimport matplotlib.pyplot as plt"
" numpy:
command! Np execute ":normal oimport numpy as np"


"command! Htmlboilerplate execute ':r $USEF_PATH/snippets/boilerplate.html'
command! Htmlboilerplate execute ':r' . USEFHOME . '/snippets/boilerplate.html'


function! PlaceName()
    " swicth out placeholder in snippets with given name
endfunction

command! ReactHook execute ':r $USEF_PATH/snippets/ReactHook.js'



"----------------------------------------------
"Inspecting arguments of function func:
"----------------------------------------------
function! Inspect()
	norm mcyiW}koimport inspect
	norm oargs = inspect.getfullargspec()
	norm P
	norm `c
endfunction
command! Insp execute 'call Inspect()'

"--------------------------------------------------------
" fig, ax = subplots()
"--------------------------------------------------------
function! Subplots()
	norm ofig, ax = plt.subplots(nrows=1, ncols=1, sharex=False,  sharey=False, figsize=[8.3, 11.7]
        norm ^
endfunction
command! Subplots execute 'call Subplots()'
command! Subp Subplots
command! Figax Subplots



"--------------------------------------------------------
" np.random.randint
"--------------------------------------------------------
function! Randint()
    norm draws = np.random.randint(low=0, high=None size=1)
    norm ^
endfunction
command! Randint execute 'call Randint()'




"--------------------------------------------------------
" Function that transforms func(a, b, c) to
"   func(a,
"        b,
"        c)
"--------------------------------------------------------
" doesnt work if there is a space in any of the arguments
" (like if arg=ting[i, j], as B will stop at j)
function! Verticalize()

    "----------------------------------------------------
    " go to beginning of function, mark positions of 
    " function definition brackets
    "----------------------------------------------------
    " go to beginning:
    norm ^
    " go to closing bracket:
    norm %
    let right_bracket_pos = col('.')

    " go to opening bracket
    norm % 
    let left_bracket_pos = col('.')

    "----------------------------------------------------
    " mark the pos on the left bracket
    "----------------------------------------------------
    norm mc


    "----------------------------------------------------
    " Get end pos of first argument. 
    "----------------------------------------------------
    norm w

    
    "----------------------------------------------------
    " mark for when loop is done:
    "----------------------------------------------------
    let stopsign = col('.') 


    "----------------------------------------------------
    " go to end of the function, go 
    " backwards from there
    "----------------------------------------------------
    " call cursor(beginning_pos_y, right_bracket_pos)
    norm ^
    norm %


    "----------------------------------------------------
    " the indentation size:
    "----------------------------------------------------
    let n_spaces = left_bracket_pos - 1

    "----------------------------------------------------
    " loop where we iterate backwards: 
    "----------------------------------------------------

    " using 0 as false:
    let done = 0
    while done == 0
        
       norm $B

       if col('.') <= stopsign
           let done += 1

       else

           norm "jd$o
           norm "jp0

           execute 'normal!' . n_spaces . 'i '

           norm `c

       endif
    endwhile
    norm ^%%

endfunction
command! Verticalize execute 'call Verticalize()'
command! Vrt Verticalize
" let @v =  Verticalize()
map @v :call Verticalize()<c-j>








"   
"    __     ___                      _   _   _                 
"    \ \   / (_)_ __ ___    ___  ___| |_| |_(_)_ __   __ _ ___ 
"     \ \ / /| | '_ ` _ \  / __|/ _ \ __| __| | '_ \ / _` / __|
"      \ V / | | | | | | | \__ \  __/ |_| |_| | | | | (_| \__ \
"       \_/  |_|_| |_| |_| |___/\___|\__|\__|_|_| |_|\__, |___/
"                                                    |___/     
" kw : settings, tools

" command for checking what type of code it is in the current line
" Seems to work better with Python than e.g. C++
command! CheckLineType :echo synIDattr(synIDtrans(synID(line("."), col("$")-1, 1)), "name")



"=======================Netrw===========================
" kw : netrw, file explorer 
" Set relative line numbers:
" let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

"let g:netrw_list_hide= '.*\swp$'
" let g:netrw_list_hide= '*/__pycache__*'
"========================END============================
"set shell=/bin/sh
" Use zsh instead of bash in the vim terminal:
" set shell=/usr/bin/zsh


" Syntax highlighting for snakemake:
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.rules set syntax=snakemake
au BufNewFile,BufRead *.snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake



" Disable diagnostics:
lua vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
" " I think this disables the error sign on the left side:
lua vim.diagnostic.config({signs = false})


" Autoread on filechange:
" trigger `autoread` when files changes on disk
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif


" FILETYPE specifics:
" Use python syntax highlighting for Snakefile (Snakemake):
autocmd BufEnter * if expand('%:t') == 'Snakefile' | set ft=python | endif
" Set vim highlighting for .nvim endings:
autocmd BufEnter * if expand('%:e') == 'nvim' | set ft=vim | endif

" notification after file change
" autocmd FileChangedShellPost *
"   \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None



" for live substitution with :%s/original/new command
set inccommand=nosplit


" let &shell = has('win32') ? 'powershell' : 'pwsh'

let g:BASH_Ctrl_j = 'off'
let g:BASH_Ctrl_k = 'off'

nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
vnoremap <C-j> <C-d>
vnoremap <C-k> <C-u>






" set shorter hotkey to the switch plugin
command! Sw Switch



" ic=ignorecase, i.e. case insensivive by default
set ic

" use // to comment out in C++ instead of /*
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s


"set wrapmargin=5

" Provide python environment for nvim:

" let g:python3_host_prog = '$HOME/anaconda3/bin/python3'

if has('nvim') && !empty($CONDA_PREFIX)
  let g:python3_host_prog = $CONDA_PREFIX . '/bin/python3'
  " let g:loaded_node_provider = 0
  " echo 'horehore'
" elseif has("unix") 
"     let g:python3_host_prog = '$HOME/anaconda3/bin/python3'

else 
    "let g:python3_host_prog = '~/Anaconda3/bin/libLIEF.dll'
    "let g:python3_host_prog = '~/Anaconda3/python'
    "let g:python3_host_prog = '~/Anaconda3/python39'
endif

"set undofile                            " keep undo when closing
au BufLeave * silent! wall              " save whenever a buffer is left?
set noea                                " prevent resize when closing a e

" Theme/Scheme:
" colorscheme everforest
" colorscheme gruvbox 
" colorscheme melange 
colorscheme iceberg
" set background=dark                     " dark version
set background=light                     " dark version

" Change the color of the filename in the statusline to white:
" hi Status1 guifg=#008080 guibg=#fabd2f
" set statusline=%#Status1#%F




" colorscheme neon
" colorscheme nightfox
" colorscheme material

" colorscheme sherbet
" vim.cmd("colorscheme sherbet")

" colorscheme minimal " for minimal
" colorscheme minimal-base16 " for minimal-base16

" colorscheme blue-moon
" let g:lightline = { 'colorscheme': 'blue-moon' }

" set background=light

" Line number coloring:
" hi LineNr guifg=grey ctermfg=grey

" comment color:
" hi Comment  guifg=#80a0ff ctermfg=175
" hi Comment  ctermfg=246


" transparency:
" hi Normal guibg=NONE ctermbg=NONE
" set termguicolors " For transparency where the line numbers are

function! ToggleLight()
    if &background == 'light'
        set background=dark
    elseif &background == 'dark'
        set background=light
    endif
endfunction
command! Togglelight :call ToggleLight() 
command! LightToggle :call ToggleLight() 




set softtabstop=4

set autoread		

" set ts=2 
" set sw=2

set expandtab                           " tabs = spaces

" set shiftwidth=4                        " indentation 
" set autoindent

set guioptions-=r guioptions-=L
"set guioptions+=k                       " avoid resize when opening new vsplit
set number                              " line numbers on 
set relativenumber                      " relative line numbers 
set conceallevel=0
" Making vsplits open to the right
set splitright
" set splitbelow


"------------------------------------------------------------
" indent sizes / indentation sizes:
"------------------------------------------------------------
" Needs restarting vim, I think
autocmd FileType * setlocal shiftwidth=4 tabstop=2
" indentation size for javascript/htm::
au FileType yaml,javascript,javascriptreact,html,tex,markdown setlocal shiftwidth=2 tabstop=2
" autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
" set shiftwidth=2
set autoindent
set smartindent

"
" Trying to remove the splitbar etc:
hi LineNr guibg=bg
set foldcolumn=2

hi foldcolumn guibg=bg
" hi VertSplit guibg=bg guifg=bg
hi VertSplit guibg=bg 
"hi VertSplit guifg=#95c4ce 
hi VertSplit guifg=bg



" FOR CLIPBOARD IN WSL
" also put win32yank.exe in .local/bin
" Fuck, this ruins the ability to yank paste columns..
" Should fix by making a function Cpcol() or something
" set clipboard=unnamedplus
" let g:clipboard = {
"           \   'name': 'win32yank-wsl',
"           \   'copy': {
"           \      '+': 'win32yank.exe -i --crlf',
"           \      '*': 'win32yank.exe -i --crlf',
"           \    },
"           \   'paste': {
"           \      '+': 'win32yank.exe -o --lf',
"           \      '*': 'win32yank.exe -o --lf',
"           \   },
"           \   'cache_enabled': 0,
"           \ }








if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif



" only filename as tab label: (doesn't work)
"set guitablabel=%t
"set guitablabel=\[%N\]\ %t\ %M 

" move tabs to the end for new, single buffers (exclude splits) (works with
" NERDtree)
" the star lets it applies to all filetypes
" autocmd BufNew * execute ":tabmove $"
"autocmd BufNew * if winnr('$') == 1 | tabmove99 | endif



"=======================NerdTree===========================
" au BufLeave * :call NERDTree.Close()<CR>gt <C-l> 
"let g:NERDTreeQuitOnOpen = 1
let g:terminal_ansi_colors = 1
" This should make C in nerdtree change neovims root dir, I think
let g:NERDTreeChDirMode = 2
nnoremap <leader>w :NERDTreeToggle<CR>
"ignore certain files:
" let NERDTreeIgnore = ['\.png$','\.jpg$', '\Zone.Identifier$']
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Folders/files to be ignored by NERDTree:
let NERDTreeIgnore=['__pycache__$']



"" Close NERDTree when switching tab:
" nnoremap gt :call NERDTree.Close()<CR>gt <C-l>
" nnoremap gT :call NERDTree.Close()<CR>gT   <C-l>
" nnoremap 1gt :call NERDTree.Close()<CR>1gt <C-l>
" nnoremap 2gt :call NERDTree.Close()<CR>2gt <C-l>
" nnoremap 3gt :call NERDTree.Close()<CR>3gt <C-l>
" nnoremap 4gt :call NERDTree.Close()<CR>4gt <C-l>
" nnoremap 5gt :call NERDTree.Close()<CR>5gt <C-l>
" nnoremap 6gt :call NERDTree.Close()<CR>6gt <C-l>
" nnoremap 7gt :call NERDTree.Close()<CR>7gt <C-l>
" nnoremap 8gt :call NERDTree.Close()<CR>8gt <C-l>
" nnoremap 9gt :call NERDTree.Close()<CR>9gt <C-l>
" close NERDTree when opening new tab:
"let NERDTreeQuitOnOpen=1
"==========================END=============================




let g:highlightedyank_highlight_duration = 175  " ms


"" vim-airline:
"let g:airline#extensions#tabline#enabled = 1
""let g:airline#extensions#tabline#buffer_nr_show = 1

""let g:airline#extensions#tabline#buffer_idx_mode = 1
"nmap <leader>1 <Plug>AirlineSelectTab1
"nmap <leader>2 <Plug>AirlineSelectTab2
"nmap <leader>3 <Plug>AirlineSelectTab3
"nmap <leader>4 <Plug>AirlineSelectTab4
"nmap <leader>5 <Plug>AirlineSelectTab5
"nmap <leader>6 <Plug>AirlineSelectTab6
"nmap <leader>7 <Plug>AirlineSelectTab7
"nmap <leader>8 <Plug>AirlineSelectTab8
"nmap <leader>9 <Plug>AirlineSelectTab9
"nmap <leader>0 <Plug>AirlineSelectTab0
"nmap <leader>- <Plug>AirlineSelectPrevTab
"nmap <leader>+ <Plug>AirlineSelectNextTab



" nmap 1<Tab> :1bn<CR> 
" nmap 2<Tab> :2bn<CR> 
" nmap 3<Tab> :3bn<CR> 
" nmap 4<Tab> :4bn<CR> 
" nmap 5<Tab> :5bn<CR> 
" nmap 6<Tab> :6bn<CR> 
" nmap 7<Tab> :7bn<CR> 
" nmap 8<Tab> :8bn<CR> 
" nmap 9<Tab> :9bn<CR> 

" nmap 1<S-Tab> :1bp<CR>
" nmap 2<S-Tab> :2bp<CR>
" nmap 3<S-Tab> :3bp<CR>
" nmap 4<S-Tab> :4bp<CR>
" nmap 5<S-Tab> :5bp<CR>
" nmap 6<S-Tab> :6bp<CR>
" nmap 7<S-Tab> :7bp<CR>
" nmap 8<S-Tab> :8bp<CR>
" nmap 9<S-Tab> :9bp<CR>

" keep undo history when switching buffers:
set hidden






"       
"         ____            _                                           
"        | __ )  __ _ ___(_) ___   _ __ ___ _ __ ___   __ _ _ __  ___ 
"        |  _ \ / _` / __| |/ __| | '__/ _ \ '_ ` _ \ / _` | '_ \/ __|
"        | |_) | (_| \__ \ | (__  | | |  __/ | | | | | (_| | |_) \__ \
"        |____/ \__,_|___/_|\___| |_|  \___|_| |_| |_|\__,_| .__/|___/
"                                                          |_|        
" kw : basic remaps


command! Mksess execute 'mksession! sess.session'

" " set gb and gB to cycle buffers
nmap gn :bn<CR>
nmap gp :bp<CR>


" closing braces with indent when {<CR> in insert mode:
inoremap {<CR> {<CR>}<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko


" Set ctrl + h and l to jump longer
noremap <c-h> 10h
vnoremap <c-h> 10h
noremap <c-l> 10l
vnoremap <c-l> 10l

"change ^d and ^u
noremap <c-u> 15<c-y>
vnoremap <c-u> 15<c-y>
noremap <c-d> 15<c-e>
vnoremap <c-d> 15<c-e>


" change shift m to <c-n> i.e. go to middle of window
noremap <c-n> <S-m> 
vnoremap <c-n> <S-m> 


" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Go to end of the line while in insert mode with ctrl+e:
imap <c-e> <Esc>$a


" quick open here:
command! Edot :e . 
command! Ed Edot


"---------------------------------------
" macros 
"---------------------------------------
" paste from clipboard with @p:
let @p = '"+p'
let @c = '"+y'
let @l = '"+yy'
let @L = '"+Y'





"    __     ___            
"    \ \   / (_)_ __ ___   
"     \ \ / /| | '_ ` _ \  
"      \ V / | | | | | | | 
"       \_/  |_|_| |_| |_| 
"     __                  _   _                   _ _ _         
"    / _|_   _ _ __   ___| |_(_) ___  _ __   __ _| (_) |_ _   _ 
"   | |_| | | | '_ \ / __| __| |/ _ \| '_ \ / _` | | | __| | | |
"   |  _| |_| | | | | (__| |_| | (_) | | | | (_| | | | |_| |_| |
"   |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|\__,_|_|_|\__|\__, |
"                                                          |___/ 
"
" kw : vim functionality

"-----------------------------------------------------------------------------
" Toggle copilot:
"-----------------------------------------------------------------------------
" " disable copilot inline suggestions:
" let g:copilot_filetypes = {
"       \ '*': v:false,
"       \ 'python': v:false,
"       \ 'cpp': v:false,
"       \ }

" autocmd VimEnter * execute "Copilot disable"
if !exists('g:copilot_on') 
    let g:copilot_on = 1
endif
" let g:copilot_on = 0
function ToggleCopilot()

    " let copilotstatus = execute("Copilot status")
    " echo copilotstatus
    if g:copilot_on==0
        execute("Copilot enable")
        let g:copilot_on=1

    elseif g:copilot_on==1
        
        execute("Copilot disable")
        let g:copilot_on=0
    endif

endfunction
command! TC call ToggleCopilot()







"-----------------------------------------------------------------------------
"" headline.vim
""-----------------------------------------------------------------------------
"" ASCII art with python:
"" https://pypi.org/project/art/

"" import art
"" text = art.text2art("Hello World")

"" Run from commandline:
"" python3 -m art text eksempel

"" HOW TO:
"" 1. Enter insert mode
"" 2. press <c-r>= to enter expression mode
"" 3. Run: system('python3 -m art text "input text"')

" Big thanks to ChatGPT

function! RunArtCommand(input_text)
  " Execute the Python command and capture the output
  let output = systemlist('python3 -m art text "' . a:input_text . '"', getline('.'))

  " Insert the output into the current buffer
  call append(line('.') + 1, output)
endfunction
command! -nargs=1 Headline call RunArtCommand(expand(<q-args>))
command! -nargs=1 Hl call RunArtCommand(expand(<q-args>))
                     

        


" Close buffer but keep window:
map <C-W>o <C-W>n<C-W><C-W><C-W>c

"-----------------------------------------------------------------------------
" Add snippet :
"-----------------------------------------------------------------------------
function! CreateSnippet()
    " takes marked text and adds it to a file in $USEF_PATH/snippets/
    " prompts filename/filetype
endfunction



"-----------------------------------------------------------------------------
" Opening urls with gx                                                       :
"-----------------------------------------------------------------------------

function! InsertFln()
    " let fln = @%
    let fln = expand("%:p")
    let y = line('.')
    norm o
    execute append(y, fln)
    call cursor(y,0)
endfunction
command! InsertFln :call InsertFln()



" function! InsertFlnFull()
"     let fln = expand("%:p")
"     let y = line('.')
"     norm o
"     execute append(y, fln)
"     call cursor(y,0)
" endfunction
" command! InsertFlnFull :call InsertFlnFull()


" function! OpenURL()
"     let url = expand('<cWORD>')

"     " run python script that checks the workspace for existing firefox etc:
"     "call feedkeys(':!python3  $USEF_PATH/tools/openURL.py ' . url . ' &' . "\<CR>\<ESC>" )
    
"     " \<CR> doesnt seem to have the effect of pressing enter any more..
"     call feedkeys(':!python3 $USEF_PATH/tools/openURL.py egg.no' )
" endfunction
" nnoremap gx :call OpenURL()<CR>

function! GetWiki()
    let url = 'https://en.wikipedia.org/norway'
    call feedkeys(':!python3  $USEF_PATH/tools/GetWiki.py ' . url . ' &' . "\<CR>\<ESC>" )
    " call feedkeys(':!curl -X GET ' . url . ' > /tmp/wiki-temp.html') "\<CR>\<ESC>')
endfunction



" " Opening localhost 3000
" command! Localhost :call 
"         \ feedkeys(':!python3  $USEF_PATH/tools/openURL.py localhost:3000 &' . "\<CR>\<ESC>" )



" Function for capitalizing all instances of a variable:
function! CapitalizeAll()

    " Recursive macro:
    let @C="#Nviw~N@C"
    norm @C
    
    " Then go back to beginning 
    norm *
endfunction
command! CapitalizeAll execute 'call CapitalizeAll()'



function! CopyCol()
endfunction
command! CopyCol execute 'call CopyCol()'


" open current vim-terminal folder in vim in a non-terminal e
" Looks like the built in :Open already does this!
function! Openinvim()
    if &buftype == 'terminal'
        " first store whatever is currently registered in a, so we don't override
        let savereg = @a

        " now paste path to a variable 
        if &shell == 'powershell.exe'
            norm G0fC"ayt>
        else
            norm G0f~"ayt$
        endif

        let input = @a

        " restore original register in a
        let @a = l:savereg
        
        :wincmd t 
        call feedkeys(':e ' . input . "\<CR>\<ESC>" )
    else
        echo 'not in a terminal'
    endif
endfunction
command! Openinvim execute 'call Openinvim()'
command! Oiv Openinvim



"--------------------------------------------------------
" Goyo hotkey
" sets ctrl+a to toggle Goyo
"--------------------------------------------------------
" keywords : goyo, fullscreen, distraction free
"--------------------------------------------------------
let g:goyocount=0
if !exists('g:goyostate') 
    let g:goyostate='off'
endif
function! GoyoToggle()

    "----------------------
    " tracking if goyo is active:
    if g:goyostate=='off'

        execute 'Goyo 140x80'
        ""execute 'Goyo'
        let g:goyostate='on'

    elseif g:goyostate=='on'
        execute 'Goyo'
        let g:goyostate='off'
    endif
    norm hh

    set relativenumber
    
    let g:goyocount+=1
endfunction
nnoremap <c-a> :call GoyoToggle()<CR> :Src<CR> <C-l>
"nnoremap <c-a> :call GoyoToggle()<CR> 


"--------------------------------------------------------
" function for testing vim stuff: 
"--------------------------------------------------------
" template for Vim functions:
" insert the above template via command:
function! Writetester()
    norm ofunction! Tester()
    norm oendfunction
    norm ocommand! Tester execute 'call Tester()'
endfunction
command! Writetester execute 'call Writetester()'
command! Tester execute 'call Tester()'


"---------------------------------------------------
" add colon to end of line:
"---------------------------------------------------
" this is probably not important enough to hold 
" ctrl+a 
"imap <c-a> <Esc>g_a:<Esc>o
"nmap <c-a> g_a:<Esc>o



"----------------------------------------------
" terminal in vim:
"----------------------------------------------
" move to bottom and open terminal with e:
" also checks if the terminal is already open
function! Term()
        "let winid = :win_getid()
        "echo winid
        
        if &buftype == 'terminal'
            " if in terminal go up to top

            ":call feedkeys("<C-\><C-n>")
            ":q
            ":wincmd t
        

        else
            if &buftype == ''
                " if in NERDtree, go right first
                " :wincmd l
            endif

            if &buftype != ''
                :w
            endif

            :wincmd b   " go to bottom

            " if there is already a terminal at the bottom:
            if &buftype == 'terminal'
                norm a


            " if not, then we open one:
            else
                :below new
                :resize 14
                if bufname('term') == ''
                    execute 'term'
                    :wincmd J " force to bottom
                    :resize 14
                else
                    :b term

                endif
                norm a
            endif

        endif
endfunction
command! Term execute 'call Term()'

command! Trm :terminal
nnoremap <c-t> :call Term()<CR>


"<CR> to press enter and actually run the vim command
" remap so <esc> exits terminal mode
" go back from the terminal:
"tnoremap <c-t> <c-\><c-n><c-w>t
tnoremap <c-t> <c-\><c-n>:q<CR><c-w>t


" close nvim terminal: 
tnoremap <c-\>c <c-\><c-n>:bd!<CR>

" go to normal mode in nvim terminal:
tnoremap <c-q> <C-\><C-n>
"tnoremap <c-\><Esc> <C-\><C-n>

" new terminal:
nnoremap <c-\>nt :terminal<CR>
nnoremap \nt :terminal<CR>

" New terminal in vertical split
command! Vterm execute 'vsplit' | execute 'terminal' 





"     __  __       _ _   _   _                                          
"    |  \/  |_   _| | |_(_) | | __ _ _ __   __ _ _   _  __ _  __ _  ___ 
"    | |\/| | | | | | __| | | |/ _` | '_ \ / _` | | | |/ _` |/ _` |/ _ \
"    | |  | | |_| | | |_| | | | (_| | | | | (_| | |_| | (_| | (_| |  __/
"    |_|  |_|\__,_|_|\__|_| |_|\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___|
"                                          |___/             |___/      
"      __                  _   _                 
"     / _|_   _ _ __   ___| |_(_) ___  _ __  ___ 
"    | |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
"    |  _| |_| | | | | (__| |_| | (_) | | | \__ \
"    |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
"                                                
" Multilanguage functions


" Add for loop:
function! Forloop()
    if &filetype == "cpp"
        norm ofor (int i=0; i<n; i++) {}
        norm lx
        norm o}
        call feedkeys('O')
    
    elseif &filetype == "javascript"
        norm ofor (let i=0; i<n; i++) {
        norm lx
        norm o}
        call feedkeys('O')
    endif
endfunction
command! Forloop execute 'call Forloop()'
command! Forl Forloop
command! Frl Forloop


" Double for loop:
function! Forloop2()
    norm ofor (int i=0; i<n; i++)
    norm o{}
    norm x
    norm o}
    norm Ofor (int j=0; j<n; j++)
    norm o{}
    norm x
    norm o}
    call feedkeys('O')
endfunction
command! Forloop2 execute 'call Forloop2()'
command! Forl2 Forloop2
command! Frl2 Forloop2


" ---------------------------------------------------------------
" ctrl+p will add a printout statement for variable depending
" on the filetypes .py and .cpp
"---------------------------------------------------------------
" keywords : mark, marker
" looks like there is a problem if on the very last line
"
"

" switch out \ with / in a line:
function! ChangeSlash()
    norm $
    let endpos = col('.')
    norm ^

    " using 0 as false:
    let prevpos = 0
    let done = 0
    while done == 0

       norm f\\
       let newpos = col('.')
       if newpos == prevpos
           let done = 1
       else
           norm r/
           let prevpos = newpos
       endif
    endwhile
endfunction
command! ChangeSlash :call ChangeSlash()
command! CS ChangeSlash


function! PrintType()
        "norm j
        let line = getline('.')
        
        " not sure what \s does and why * is there, but this works
        if line =~ '^\s*$'
            let checkifempty = 0        " empty
        else
            let checkifempty = 1        " nonempty
        endif


        " Add new line if at bottom of document:
        if line(".") == line("$")
            norm mc
            norm o
            norm `c
        endif


        if checkifempty == 1
            " first go up again since we first took a step down
            "norm k
            if &filetype == "python"    " mc to set marker so we go back to original point
                norm mcyiw}koprint(type()) 
                norm hhP`c
            endif
            " if &filetype == "javascript"
            "     norm mcyiw}koconsole.log()
            "     norm P`c
            " endif
            " if &filetype == "cpp"
            "     norm mcyiw}kostd::cout << 
            "     norm pa << std::endl;
            "     norm `c 
            "     norm h
            " endif
            " if &filetype == "vim"
            "     norm mcyiwoecho 
            "     norm p
            "     norm `c
            " endif

        " if the line is empty, we just want the print statement and end
        " in insert mode:
        else
            if &filetype == "python"    " mc to set marker 
                norm iprint(type())
                call feedkeys('i')
            endif
            " if &filetype == "javascript"    " mc to set marker 
            "     let temp = @"
            "     norm Sconsole.log()

            "     let @" = l:temp
                
            "     call feedkeys('i')
            " endif
            " if &filetype == "cpp"
            "     norm istd::cout <<  << std::endl;
            "     norm 2Bh
            "     call feedkeys('i')
            " endif
            " if &filetype == "vim"
            "     norm oecho
            "     call feedkeys('a ')
            " endif
        endif
endfunction
command! PrintType :call PrintType()
command! Pt PrintType
command! Type PrintType

function! PrintLen()
        "norm j
        let line = getline('.')
        
        " not sure what \s does and why * is there, but this works
        if line =~ '^\s*$'
            let checkifempty = 0        " empty
        else
            let checkifempty = 1        " nonempty
        endif


        " Add new line if at bottom of document:
        if line(".") == line("$")
            norm mc
            norm o
            norm `c
        endif


        if checkifempty == 1
            " first go up again since we first took a step down
            "norm k
            if &filetype == "python"    " mc to set marker so we go back to original point
                norm mcyiw}koprint(len()) 
                norm hhP`c
            endif
            " if &filetype == "javascript"
            "     norm mcyiw}koconsole.log()
            "     norm P`c
            " endif
            " if &filetype == "cpp"
            "     norm mcyiw}kostd::cout << 
            "     norm pa << std::endl;
            "     norm `c 
            "     norm h
            " endif
            " if &filetype == "vim"
            "     norm mcyiwoecho 
            "     norm p
            "     norm `c
            " endif

        " if the line is empty, we just want the print statement and end
        " in insert mode:
        else
            if &filetype == "python"    " mc to set marker 
                norm iprint(len())
                call feedkeys('i')
            endif
            " if &filetype == "javascript"    " mc to set marker 
            "     let temp = @"
            "     norm Sconsole.log()

            "     let @" = l:temp
                
            "     call feedkeys('i')
            " endif
            " if &filetype == "cpp"
            "     norm istd::cout <<  << std::endl;
            "     norm 2Bh
            "     call feedkeys('i')
            " endif
            " if &filetype == "vim"
            "     call feedkeys('a ')
            " endif
        endif
endfunction
command! PrintLen :call PrintLen()
command! Pl PrintLen
command! Len PrintLen




function! Printout()
        "norm j
        let line = getline('.')
        
        " not sure what \s does and why * is there, but this works
        if line =~ '^\s*$'
            let checkifempty = 0        " empty
        else
            let checkifempty = 1        " nonempty
        endif


        " Add new line if at bottom of document:
        if line(".") == line("$")
            norm mc
            norm o
            norm `c
        endif


        if checkifempty == 1
            " first go up again since we first took a step down
            "norm k
            if &ft == "python" || &ft == "snakemake" || &ft == "lua" || &ft == "r" 
                norm mcyiw}koprint() 
                norm hP`c
            endif
            if &ft == "javascript" || &ft == "typescript" || &ft == "javascriptreact" 
                norm mcyiw}koconsole.log()
                norm PEa;
                norm `c
            endif
            if &ft == "cpp" || &ft == "cc"
                norm mcyiw}kostd::cout << 
                norm pa << std::endl;
                norm `c 
                norm h
            endif
            if &ft == "vim" || &ft == "sh"
                norm mcyiwoecho 
                norm p
                norm `c
            endif

        " if the line is empty, we just want the print statement and end
        " in insert mode:
        else
            if &ft == "python" || &ft == "snakemake" || &ft == "lua" || &ft == "r" 
                norm iprint()
                call feedkeys('i')
            endif
            if &ft == "javascript" || &ft == "typescript" || &ft == "javascriptreact" 
                let temp = @"
                norm Sconsole.log();

                let @" = l:temp
                norm h
                
                call feedkeys('i')
            endif
            if &ft == "cpp" || &ft == "cc"
                norm istd::cout <<  << std::endl;
                norm 2Bh
                call feedkeys('i')
            endif
            if &ft == "vim"
                norm oecho
                call feedkeys('a ')
            endif
        endif
endfunction
map <c-p> :call Printout()<c-j>


function! RemoveFuncCallLeaveArg()
    "
        " not sure what \s does and why * is there, but this works
        " if line =~ '^\s*$'
        "     let checkifempty = 0        " empty
        " else
        "     let checkifempty = 1        " nonempty
        " endif

        " Add new line if at bottom of document:
        if line(".") == line("$")
            norm mc
            norm o
            norm `c
        endif

        if &ft == "python" || &ft == "snakemake" || &ft == "lua" || &ft == "r" 
            norm Bf(w"cye
            norm diW
            norm "cp
        endif
        if &ft == "javascript" || &ft == "typescript" || &ft == "javascriptreact" 
        endif
        if &ft == "cpp" || &ft == "cc"
            echo  "not implemented"
        endif
        if &ft == "vim" || &ft == "sh"
            echo  "not implemented"
        endif

endfunction
command! Rmfunc :call RemoveFuncCallLeaveArg()<c-j>


"---------------------------------------------------------------
" ctrl+x will add an exit command below with insert mode
"---------------------------------------------------------------
function! Addexit()
    if &ft == "python" || &ft == "snakemake" 

        norm ^
        let posx_start = col('.')


        norm }ko
        norm o
        norm ifrom pathlib import Path as pathforfaen
        norm oexit(', {}'.format(pathforfaen(__file__).absolute()))
        norm k^

        let posx = col('.')
        let done = 0
        if posx >= posx_start
            let done = 1
        endif

        let count = 0

        while done == 0 
            norm 2>>w
            let posx = col('.')

            if posx >= posx_start
                let done = 1
            endif

            let count = count + 1

            if count == 20
                let done = 1
            endif
        endwhile


        norm j0f'
        call feedkeys('a') 


    endif
    if &ft == "cpp"
        norm }oexit(0);
        norm O
        call Printout()
        norm h
        norm i ""
        call feedkeys('')
    endif
endfunction
command! Addexit execute 'call Addexit()'
map <c-x> :Addexit<CR>







"        
"          _         _____   __  __
"         | |    __ |_   _|__\ \/ /
"         | |   / _` || |/ _ \\  / 
"         | |__| (_| || |  __//  \ 
"         |_____\__,_||_|\___/_/\_\
"                                  
" kw : Latex, tex, latex

" Equation :
function! EqFunc()
	norm o\begin{equation}
	norm o\end{equation}
endfunction
command! Eq execute 'call EqFunc()'


" Itemize :
function! ItemizeFunc()
	norm o\begin{itemize}
	norm o\end{itemize}
endfunction
command! Itemize execute 'call ItemizeFunc()'


" Enumerate :
function! EnumerateFunc()
	norm o\begin{enumerate}
	norm o\end{enumerate}
endfunction
command! Enumerate execute 'call EnumerateFunc()'


" Figure :
function! FigFunc()
	norm o\begin{figure}
	norm o\end{figure}
        norm O\centering
        norm o\includegraphics[scale=0.6]{example.pdf}
        norm o\caption{}
        norm o\label{}
endfunction
command! Fig execute 'call FigFunc()'


" table :
function! TableFunc()
	norm o\begin{table}
	norm o\end{table}

        norm O\centering

        norm o\begin{tabular}{l | l | r}
        norm o\end{tabular}

        norm Oa & b & c\\
        norm o\hline
        norm od & e & f\\
endfunction
command! Table execute 'call TableFunc()'


" opening nvimconfig in e " DEPRECATED
"command! Nvimconfig execute 'e ~/.config/nvim/init.vim'
"command! Nvimconfigv execute 'vsplit ~/.config/nvim/init.vim'


"bash first line
function! Binsh()
	norm i#!/bin/sh
endfunction
command! Binsh execute 'call Binsh()'

"Inserting function comment string thing: 
function! DocumentationString()
	norm o''''''
	norm 2hi
endfunction
command! DocString execute 'call DocumentationString()'





"--------------------------------------------------------
" insert current filename
"--------------------------------------------------------
" Doesnt work yet
command! Filename execute "normal! i" . $USEF_PATH
command! Fn Filename


"--------------------------------------------------------
" Function that unindents and reindents
"--------------------------------------------------------
function! Reindent()
        norm <<>>
endfunction
command! Reindent execute 'call Reindent()'


                                          
"--------------------------------------------------------
" insert spaces above equal to the current line x value 
"--------------------------------------------------------
" y = row = line number
" x = col
                                          
"--------------------------------------------------------
" Function for inserting empty spaces in an empty line 
" above or below current, to move vertically into empty
" land
"--------------------------------------------------------

function! Moveup()
        "---------------------------------
        " fetch current coordinates:
        "---------------------------------
        let start_pos_x = col('.')
                                          
        "---------------------------------
        " Go one line up: 
        "---------------------------------
        norm k

        "---------------------------------
        " get new position in line above
        "---------------------------------
        let new_x = col('.')            

        "---------------------------------
        " if the above line is too short, 
        " we must add spaces to make up
        " the difference (and add 1):
        "---------------------------------
        let n_spaces = start_pos_x - new_x + 1    
                                           
        "---------------------------------
        " finally we add the spaces:
        "---------------------------------
        execute 'normal! ' . n_spaces . 'i '
endfunction
command! Moveup execute 'call Moveup()'

function! Movedown()
        "---------------------------------
        " fetch current coordinates:
        "---------------------------------
        let start_pos_x = col('.')
                                          
        "---------------------------------
        " Go one line up: 
        "---------------------------------
        norm j

        "---------------------------------
        " get new position in line above
        "---------------------------------
        let new_x = col('.')            

        "---------------------------------
        " if the above line is too short, 
        " we must add spaces to make up
        " the difference (and add 1):
        "---------------------------------
        let n_spaces = start_pos_x - new_x + 1    
                                           
        "---------------------------------
        " finally we add the spaces:
        "---------------------------------
        execute 'normal! ' . n_spaces . 'i '
endfunction
command! Movedown execute 'call Movedown()'


"--------------------------------------------------------
" Function for inserting dashes in an empty line above or 
" below current, in an amount that equals the current 
" marker position 
"--------------------------------------------------------
function! Dashes(where)
        "---------------------------------
        " fetch current coordinates:
        "---------------------------------
        let start_pos_x = col('.')

        "---------------------------------
        " this is the amount of dashes we
        " need
        "---------------------------------
        let n_dashes = start_pos_x 
                                          
        "---------------------------------
        " Make a new line above or below
        "---------------------------------
        

        "if where=="above"
        "    norm O
        "endif
        "if where=="below"
        "    norm o 
        "endif

        ""---------------------------------
        "" finally we add the dashes:
        ""---------------------------------
        "execute 'normal! ' . n_dashes . 'a-'
endfunction
command! Dashesabove execute "call Dashes('above')"
command! Dashesbelow execute "call Dashes('below')"

"command! Vimtest execute "Src Dashesabove"
" Hmm how to run two commands?




" Insert > /dev/null 2>&1
function! Devnull()
	norm i> /dev/null 2>&1
endfunction	
command! Devnull execute 'call Devnull()'


" function for opening e in current folder, relative
" to location of current focused text document
function! NewRelative()
    " function for opening new document relative to current
    let currentPath = @%
    echo currentPath
endfunction
