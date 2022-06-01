set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'dense-analysis/ale'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" HashBang, to automatically add shebangs to files with the corresponding
" extension

function! Hashbang(portable, permission, RemExt)
let shells = {
        \    'awk': "awk",
        \     'sh': "bash",
        \     'hs': "runhaskell",
        \     'jl': "julia",
        \    'lua': "lua",
        \    'mak': "make",
        \     'js': "node",
        \      'm': "octave",
        \     'pl': "perl",
        \    'php': "php",
        \     'py': "python",
        \      'r': "Rscript",
        \     'rb': "ruby",
        \  'scala': "scala",
        \    'tcl': "tclsh",
        \     'tk': "wish"
        \    }

let extension = expand("%:e")

if has_key(shells,extension)
	let fileshell = shells[extension]

	if a:portable
		let line =  "#!/usr/bin/env " . fileshell
	else
		let line = "#! " . system("which " . fileshell)
	endif

	0put = line

	if a:permission
		:autocmd BufWritePost * :autocmd VimLeave * :!chmod u+x %
	endif


	if a:RemExt
		:autocmd BufWritePost * :autocmd VimLeave * :!mv % "%:p:r"
	endif

endif

endfunction

:autocmd BufNewFile *.* :call Hashbang(1,1,1)

