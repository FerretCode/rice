"           ██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
"           ██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
"           ██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
"           ██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
"           ██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
"           ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
"

" install vim plugged if not already on the system
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
	" Plug 'benmills/vimux' " tmux integration
	Plug 'tpope/vim-repeat' " repeat plugins
	Plug 'tpope/vim-endwise' " adds end, endif automatically
	Plug 'tpope/vim-sleuth' " detect indent style (tabs vs. spaces)
	" Plug 'honza/vim-snippets' " Amazing autocompletion

	" Language Specific plugins
	Plug 'ap/vim-css-color' " preview colors while editing
	Plug 'MaxMEllon/vim-jsx-pretty' " JSX syntax highlighting 
	Plug 'chemzqm/vim-jsx-improve' " JSX language support
	Plug 'pangloss/vim-javascript' " JS syntax highlighting
	Plug 'jparise/vim-graphql' " GQL syntax highlighting
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown previewer
	Plug 'lervag/vimtex' " LaTeX previewer. you may need `latex-mk` from the AUR

	" Natural Language
	" Grammar check within vim using LanguageTool, supports
	" various different languages (English, French, German...)
	Plug 'rhysd/vim-grammarous' 

	" JsDoc generation
	Plug 'heavenshell/vim-jsdoc', { 
	\ 'for': ['javascript', 'javascript.jsx','typescript'], 
	\ 'do': 'make install'
	\}

	" Theming - for theme settings see local.vim
	Plug 'sainnhe/sonokai' 
	Plug 'AlessandroYorba/Alduin'
	Plug 'morhetz/gruvbox'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'mhinz/vim-startify' " A better start screen for vim
	
	" Appearance: {{{
		" For more info about any of these `:help set`
		
		" dark theme by default
		set bg=dark

		" relative line numbers on the side	
		set number

		" wrap lines (wrap/nowrap)
		"set wrap

		" Number of characters from the right window border where wrapping starts
		"set wrapmargin=8

		" show matching closing bracket (showmatch/noshowmatch)
		set showmatch

		" Makes tabbing smarter will realize you have 2 vs 4
		set smarttab

		" Good autoindent
		set autoindent

		" use spaces instead of tabs
		" set expandtab 
		set tabstop=4
		set softtabstop=4
		set shiftwidth=4
		set shiftround
		set encoding=utf8

		" set the max line length to 80 characters.
		" this doesn't break already existing lines.
		set textwidth=80

		"shows a column at character 80, where the text wraps
		" set cc=80

		" fix broken colors on certain colorschemes
		set termguicolors

		" set spell spell lang=en_US
		set complete+=kspell

		" tex and markdown files open with spellcheck
		autocmd BufRead,BufNewFile *.md,*.tex setlocal spell spelllang=en_us

		" add JSDoc syntax highlighting
		let g:javascript_plugin_jsdoc = 1
	" }}}
	
	" Mappings: {{{
		" leader key
		let mapleader = ","

		" remap <esc> to clear highlighting
		nnoremap <silent> <esc> :noh<return><esc>
		
		" in normal mode, Y copies to the end of the line
		nnoremap Y y$

		" write with ZW
		nnoremap ZW <esc>:w<return>

		" in normal mode, Q breaks up a long line of text
		nnoremap Q gq
		
		" in visual mode, <ctrl> + y copies to the system clipboard
		vnoremap <C-y> "+y

		" in visual mode, ",',(,{,[ wraps the selection in quotes
		vnoremap " c""<esc>Pgvll
		vnoremap ' c''<esc>Pgvll
		vnoremap ( c()<esc>Pgvll
		vnoremap { c{}<esc>Pgvll
		vnoremap [ c[]<esc>Pgvll

		" code folding settings
		set foldmethod=indent
		set foldlevelstart=99
		set foldnestmax=3 " deepest fold is 10 levels
		set nofoldenable " don't fold by default
		set foldlevel=1

		" keep visual selection when indenting/outdenting
		vmap < <gv
		vmap > >gv
	" }}}
	
	" Tabs: All prefixed by <Tab> {{{
		" rotate between tabs: previous and next
		nnoremap <Tab>n gt
		nnoremap <Tab>N gT

		" Tab + a to open a new tab
		nnoremap <silent> <Tab>a :tabnew<CR>

		" Tab + h/l to move a tab left/right
		nnoremap <silent> <Tab>h :tabmove -<CR>
		nnoremap <silent> <Tab>l :tabmove +<CR>

		" Tab + t to move the current window to a new tab
		" note that this can also be done with `ctrl+w T`
		nnoremap <silent> <Tab>t :tabedit %<CR>
	" }}}

	" FuzzyFind: Find files from anywhere {{{
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
		Plug 'junegunn/fzf.vim'

		" ctrl + p to fuzzy find git files
		nnoremap <silent> <leader>fg :GFiles<CR>
		" ctrl + shift + p to fuzzy find all files
		nnoremap <silent> <leader>ff :Files<CR>

		" command GGrep fuzzy finds input on all files in current dir 
		command! -bang -nargs=* GGrep
			\ call fzf#vim#grep(
			\   'git grep --line-number -- '.shellescape(<q-args>), 0,
			\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

		command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
			\   fzf#vim#with_preview(), <bang>0)

		" remap ctrl + f from moving forward 1 full screen to grepping files
		" much more useful
		nnoremap <silent> <leader>ftg <C-F> :GGrep<CR>

		nnoremap <silent> <leader>ftf :Rg<CR>

	" }}}
		
	" NERDTree: Side menu like vscode {{{
		Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
		Plug 'Xuyuanp/nerdtree-git-plugin'
		Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
		Plug 'ryanoasis/vim-devicons'

		" <Leader> + n toggles NERDTree
		nmap <silent><C-n> :NERDTreeToggle<CR> 

		" <Leader> + shift + n focuses NERDTree from any window
		" nmap <silent><C-> :NERDTreeFocus<CR> 

		" ignore node_modules
		let g:NERDTreeIgnore = ['^node_modules$']

		" Automaticaly close nvim if NERDTree is only thing left open
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

		" Sync open file with NERDTree {
			" Check if NERDTree is open or active
			function! IsNERDTreeOpen()        
				return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
			endfunction

			" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
			" file, and we're not in vimdiff
			function! SyncTree()
				" expand('<afile>')
				echo "updating NERDTree" 
				
				" echo "no diff" !&diff "nt open:" IsNERDTreeOpen() "nt not focused: " !exists("b:NERDTree")
				" if IsNERDTreeOpen() && !exists("b:NERDTree")
				if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
					NERDTreeFind
					wincmd p
				endif
			endfunction
			
			" Highlight currently open buffer in NERDTree
			" autocmd BufEnter * call SyncTree()
		" }
	" }}}

	" NERDCommenter: {{{
		Plug 'scrooloose/nerdcommenter' " Easy commenting in vim
		filetype plugin on " Changes comments based on filetype

		let g:NERDSpaceDelims			= 1 " Add a space before and after comments
		let g:NERDCompactSexyComs		= 1 " Use compact syntax for prettified multi-line comments
		let g:NERDCustomDelimiters		= { 
					\'c': { 'left': '/*','right': '*/' }, 
					\'ml': { 'left': '(*', 'right': '*)'}, 
					\'javascript': { 'left': '{/*', 'right': '*/}' }
		\}
		let g:NERDToggleCheckAllLines	= 1

		" Toggle Commenting - ctrl + /
		" Insert: 
		inoremap <silent> <C-/> <ESC>:call nerdcommenter#Comment(0, "toggle")<CR>li
		" Normal: 
		nnoremap <silent> <C-/> :call nerdcommenter#Comment(0, "toggle")<CR>
		" Visual: keeps you in visual mode
		vnoremap <silent> <C-/> :call nerdcommenter#Comment(0, "toggle")<CR>gv
	" }}}

	" ConquerOfCompletion: Autocomplete everything {{{
		Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocompletion

		let g:coc_global_extensions = [
			\ 'coc-snippets', 
			\ 'coc-pairs',
			\ 'coc-pyright',
			\ 'coc-tsserver', 
			\ 'coc-json',
			\ 'coc-go',
			\ 'coc-prettier',
			\ 'coc-rls',
			\ 'coc-solargraph',
			\ 'coc-clangd',
			\ 'coc-vimtex',
		\ ]

		set hidden " TextEdit might fail if hidden is not set.
		" Some servers have issues with backup files, see #649.
		" set nobackup
		" set nowritebackup
		
		" prettier command for coc
		command! -nargs=0 Prettier :CocCommand prettier.formatFile

		" formatting on save is now done inside of CocConfig. you can change
		" the files to autoformat on save by editing coc-settings.json using
		" :CocConfig and adding:
		"
		"		coc.preferences.formatOnSaveFiletypes: [<file list here>]
		
		" let g:prettier#autoformat = 1
		" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

		set cmdheight=2 " Give more space for displaying messages.
		set updatetime=300 " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
	
		" Remap <C-j> and <C-k> for scroll float windows/popups.
		if has('nvim-0.4.0') || has('patch-8.2.0750')
			nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
			nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
		endif

		" Use K to show documentation in preview window.
		nnoremap <silent> K :call <SID>show_documentation()<CR>

		" Display hover for an element that the LSP can recognize
		function! s:show_documentation()
			if (index(['vim','help'], &filetype) >= 0)
				execute 'h '.expand('<cword>')
			else
				call CocAction('doHover')
			endif
		endfunction

		function! s:check_back_space() abort
			let col = col('.') - 1
			return !col || getline('.')[col - 1]  =~ '\s'
		endfunction

		" Insert <tab> when previous text is space, refresh completion if not.
		inoremap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1):
			\ <SID>check_back_space() ? "\<Tab>" :
			\ coc#refresh()
		inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

		" Use <CR> to confirm completion
		inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

		" <Tab> - autocomplete to selected option
		" inoremap <silent><expr> <Tab>
		"	\ pumvisible() ? coc#refresh() : "\<Tab>"

		" Highlight the symbol and its references when holding the cursor.
		autocmd CursorHold * silent call CocActionAsync('highlight')
		
		" Rename all instances with F2
		nmap <F2> <Plug>(coc-rename)

		" <leader> + b - Beautify selected code.
		xmap <leader>b  <Plug>(coc-format-selected)
		nmap <leader>b  <Plug>(coc-format-selected)

		" comment highlighting in json	
		autocmd FileType json syntax match Comment +\/\/.\+$+

		let g:UltiSnipsSnippetDirectories=["snips"]
	" }}}
	
	" Git Gutter: Displays changes in git-tracked files {{{
		Plug 'airblade/vim-gitgutter' " add git to file to show diffs
	
		" update gutters faster
		set updatetime=100 

		" change gutter color
		highlight GitGutterAdd    guifg=#009900 ctermfg=2
		highlight GitGutterChange guifg=#bbbb00 ctermfg=3
		highlight GitGutterDelete guifg=#ff2222 ctermfg=1

		" make gutter column invisible
		highlight! link SignColumn LineNr

		" remap gutter keybinds
		" <leader> + g + n -> next change
		nmap <leader>gn <Plug>(GitGutterNextHunk)
		" <leader> + g + p -> prev change
		nmap <leader>gp <Plug>(GitGutterPrevHunk)
		" <leader> + g + z -> fold and leave only changes
		nmap <leader>gz :GitGutterFold<CR>

		" customize gutter symbols
		let g:gitgutter_sign_added = '+'
		let g:gitgutter_sign_modified = '~'
		let g:gitgutter_sign_removed = '_'
		let g:gitgutter_sign_removed_first_line = '⌃'
		let g:gitgutter_sign_modified_removed = '⌄'
	" }}}
	
	" Markdown Preview: {{{
		" auto start plugin when opening markdown file (default: 0)
		" see local.vim
		
		" <Leader> + m + p toggles markdown preview
		nmap <leader>mp <Plug>MarkdownPreviewToggle

		" auto close document when switching to another file (default: 1)
		let g:mkdp_auto_close = 0
	" }}}
	
	" VimTeX: {{{
		" PDF Viewer:
		" http://manpages.ubuntu.com/manpages/trusty/man5/zathurarc.5.html
		" let g:vimtex_view_method = 'zathura'
		" let g:vimtex_quickfix_mode=0

		" This enables Vim's and neovim's syntax-related features. Without this, some
		" VimTeX features will not work (see ":help vimtex-requirements" for more
		" info).
		syntax enable

		" Most VimTeX mappings rely on localleader and this can be changed with the
		" following line. The default is usually fine and is the symbol "\".
		let maplocalleader = "\\"

		" Ignore mappings
		" let g:vimtex_mappings_enabled = 0

		" Error Suppression:
		" https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt
		let g:vimtex_log_ignore = [
			\ 'Underfull',
			\ 'Overfull',
			\ 'specifier changed to',
			\ 'Token not allowed in a PDF string',
		\ ]
	" }}}
	 
call plug#end()

" the following file contains device-specific vim settings.
" it should be ignored by git so feel free to change any 
" parameters there
if filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/local.vim"'))
	source ~/.config/nvim/local.vim
endif

