""""""""""""""""""""""""""""Vim General Configure"""""""""""""""""""""""
" 定义快捷键的前缀，即<Leader>
let mapleader=";"
" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu
" Vundle env
filetype off
" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
" 高亮显示搜索结果
set hlsearch
" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T
" 禁止折行
set nowrap
" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on
" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
set t_Co=256
" 显示空白字符
set list
set listchars=tab:>-,trail:-
" configure theme
colorscheme molokai
" colorscheme solarized
set background=dark
" 记住上次关闭文件时光标的位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

""""""""""""""""""""""""""""Plugin Install And Configure"""""""""""""""""""""""
" Manual install vundle in advance, https://github.com/VundleVim/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Vim theme, 作用与手动下载无差别，需要将*.vim文件移动到.vim/colors/目录下
" 再通过colorscheme配置
Plugin 'altercation/vim-colors-solarized'

" 打开vim时，下方的状态栏，需要安装powerline字体https://github.com/powerline/fonts，以显示箭头
Plugin 'vim-airline/vim-airline'
let g:airline_powerline_fonts=1

" 展示目录树，浏览工程时十分方便
Plugin 'preservim/nerdtree'
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
nmap <Leader>ff :NERDTreeFind<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

" 代码自动补齐神器，工程中需要同步配置.ycm_extra_conf.py文件中的include头文件地址
Plugin 'Valloric/YouCompleteMe'
" YCM 补全菜单配色
" 菜单
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags
set tags+=/data/misc/software/misc./vim/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 关闭语法检查
let g:ycm_show_diagnostics_ui = 0

" 查看并跳转代码中的宏、全局变量、方法定义
Plugin 'preservim/tagbar'
" 显示TagBar, 速记：首字母缩写
nmap <Leader>tb :TagbarToggle<CR>
" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
" 设置标签子窗口的宽度 
let tagbar_width=32 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

" 字符串查找神器，可以方便的查看变量或方法被调用处
Plugin 'rking/ag.vim'
let g:ag_prg = "ag --vimgrep"
" 搜索范围向上递归到包含.git、.svn等具备版本管理工具明显特征的隐藏目录
let g:ag_working_path_mode = "r"
" 快捷键查询光标所在的单词
nnoremap <leader>ag :Ag!<CR>

" 文本快速定位神器，单文件内搜索、跳转非常方便
Plugin 'easymotion/vim-easymotion'
" configure esaymotion
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1

" 快速打开文件神器，功能与sublime的ctrl-p快捷键相同
Plugin 'kien/ctrlp.vim'
" Set Ctrp-P mapping and command
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'build\|out\|buildtools\|third_party\tools\prebuilt\'
let g:ctrlp_max_depth=40
let g:ctrlp_follow_symlinks=1
let g:ctrlp_max_files = ''
" Set Ctrl-P mapping path mode
let g:ctrlp_working_path_mode = 'ra'

" git插件
Plugin 'tpope/vim-fugitive'

" Markdown 预览插件
" 需要在vim中执行：
" ：source %
" :PluginInstall
" :call mkdp#util#install()
Plugin 'iamcco/markdown-preview.nvim'
let g:mkdp_brower = 'chromium'
autocmd Filetype markdown noremap <Leader>mp :MarkdownPreview<CR>
autocmd Filetype markdown noremap <Leader>ms :MarkdownPreviewStop<CR>
autocmd Filetype markdown noremap <Leader>mt :MarkdownPreviewToggle<CR>

call vundle#end()

"""""""""""""""""""""""""""""General Key Shortcut"""""""""""""""""""""""""
" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $

" 定义快捷键退出当前窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>

" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至左方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗kkj口
nnoremap <Leader>jw <C-W>j
" 设置跳转和返回快捷键
nmap <Leader>e g<C-]>
nmap <Leader>d <C-o>

" insert模式下 双击j键进入normal模式
inoremap jj <ESC>

" 切换tab窗口
nnoremap <Leader>1 :tabn 1<CR>
nnoremap <Leader>2 :tabn 2<CR>
nnoremap <Leader>3 :tabn 3<CR>
nnoremap <Leader>4 :tabn 4<CR>
nnoremap <Leader>5 :tabn 5<CR>

