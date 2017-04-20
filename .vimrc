source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

if has('gui_running')
    set guifont=Consolas:h10:cANSI:qDRAFT
endif

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" Disable vi-compatibility nonsense
set nocompatible


" ==== Custom Key Bindings =====================================================

    " Set the leader key to space
    let mapleader=" "

    " Set tab-related bindings
    noremap <leader>n :tabn<CR>
    noremap <leader>p :tabp<CR>
    noremap <leader>1 1gt
    noremap <leader>2 2gt
    noremap <leader>3 3gt
    noremap <leader>4 4gt
    noremap <leader>5 5gt
    noremap <leader>6 6gt
    noremap <leader>7 7gt
    noremap <leader>8 8gt
    noremap <leader>9 9gt
    noremap <leader>0 :tablast<cr>

" ==============================================================================


" ==== Navigation ==============================================================

    " Maintain context around cursor by scrolling before the final line
    set scrolloff=1

    " Enable shell-like completion
    set wildmenu
    set wildmode=list:longest
    set wildignore=*.o,*.obj,*.pdf

    " Enable comprehensive %-movement between if-statements
    runtime macros/matchit.vim

" ==============================================================================


" ==== Search ==================================================================

    " Use smartcase searching (i.e. ignore case if all lowercase characters)
    set ignorecase
    set smartcase

    " Highlight search terms and highlight as each key is pressed
    set hlsearch
    set incsearch

" ==============================================================================




" ==== File-specific Styles ====================================================

    autocmd FileType make   setlocal noexpandtab
    autocmd FileType puppet setlocal shiftwidth=2 tabstop=2
    autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2

" ==============================================================================


" ==== Plugins =================================================================

    " Enable Pathogen and load plugins
    execute pathogen#infect()

    " vim-airline options
    " Use powerline fonts for the powerline icons
    let g:airline_powerline_fonts=1
    " Always display the status bar
    set laststatus=2

    " vim-airline-themes options
    " Set the airline theme to wombat
    let g:airline_theme='molokai'

" ==============================================================================
" ==== Style ===================================================================

    " Set the colorscheme to molokai
    " if has("gui_running")
        " :colorscheme molokai
    " endif
    colorscheme molokai

    " Set the colorscheme to solarized
    " colorscheme solarized
    " let g:solarized_termcolors=256
    " set background=dark

    " Enable the highlight on the cursor's current line
    set cursorline

    " Enable line numbers
    set number

    " Turn syntax highlighting on
    syntax on

    " Display rule at the bottom
    set ruler

    " Set the maximum line width to 128
    set textwidth=128

" ==============================================================================


" ==== Whitespace  =============================================================

    " Before writing to buffer (i.e. saving file), remove all trailing whitespace
    autocmd BufWritePre * %s/\s\+$//e

    " Indent according to previous line
    set autoindent

    " Enable indentation matching
    filetype plugin indent on

    " Use 4-spaces instead of tab
    set expandtab
    set shiftwidth=4

    " Set the tab's width to 4
    set tabstop=4
    set softtabstop=4

    " Do not replace/use 4-spaces over tab in Makefiles
    autocmd FileType make set noexpandtab

    " Display whitespace characters, specifically tab and trailing whitespace
    set list
    set listchars=tab:>-,trail:~

    " Enable expected backspace behavior
    set backspace=eol,indent,start

" ==============================================================================


" ==== Miscellaneous ===========================================================

    " Disable swap files and backup files
    set noswapfile
    set nobackup
    set nowritebackup

    " Re-read files when files are modified from outside of Vim
    set autoread

    " Enable lazyredraw to prevent unnecessary redraws
    set lazyredraw

" ==============================================================================
set guifont=UbuntuMono
let g:Powerline_symbols = 'fancy'
