{ config, pkgs, ... }:

{
  users.users.panurg = rec {
    description = "Alexander Abrosimov";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "dialout" ];
    # TODO: prepare system of mutableUsers set to false and  hashedPassword (or smth)
    initialPassword = "test";
    # TODO: should be some common solution
    openssh.authorizedKeys.keyFiles = [ "${config.users.users.panurg.home}/cert/panurg_hal9000.pub" ];
    shell = pkgs.zsh;
  };

  home-manager.users.panurg = { pkgs, config, lib, ... }: {
    home = {
      username = "panurg";
      language.base = "en_US.utf8";
      sessionVariables = {
      # FOO = "Hello";
      # BAR = "${config.home.sessionVariables.FOO} World!";
      };
      stateVersion = "20.03";
    };
    home.packages = with pkgs; [
      ag
      lm_sensors
      p7zip
      unrar
      file
      fd
      nodejs
    ];
    programs = {
      # TODO: check out autorandr or grobi, broot, beets, browserpass or pass,
      # lorri, keychain, lsd, neovim, noti, ssh, zathura
      # TODO wayland: mako
      bat = {
        enable = true;
        config = {
          theme = "gruvbox";
          italic-text = "always";
        };
        themes = {
          gruvbox = builtins.readFile (pkgs.fetchFromGitHub {
            owner = "Briles";
            repo = "gruvbox";
            rev = "e69df8f31e3dfd1546d53d19a2fd6ec873bd75f1";
            sha256 = "08h24nn8nw1jgqfrp1gv1ax8rs0zqnrz882whgh1n6khzf67hdpi";
          } + "/gruvbox (Dark) (Soft).tmTheme");
        };
      };
      direnv = {
        enable = true;
        enableNixDirenvIntegration = true;
      };
      command-not-found.enable = true;
      # dircolors.enable = true;
      fzf.enable = true;
      git = {
        enable = true;
        # TODO: use common config section instead for user setup
        userEmail = "alexander.n.abrosimov@gmail.com";
        userName = "Alexander Abrosimov";
        extraConfig = {
          stash.showPatch = true;
          color.ui = "auto";
          core.untrackedCache = true;
          pull.rebase = true;
        };
      };
      tmux = {
        enable = true;
        baseIndex = 1;
        clock24 = true;
        customPaneNavigationAndResize = true;
        escapeTime = 300;
        extraConfig = ''
          set-option -g prefix `
          unbind-key C-b
          bind-key ` send-prefix
          bind-key R source-file ~/.tmux.conf
          set-option -g mouse on
          set-option -g allow-rename off
          set-option -g status on
          set-option -g status-interval 0
          set-option -g status-justify left
          set-option -g status-position bottom
          set-option -g status-style bg=black,fg=white
          set-option -g status-left " #[bold]#S#[default]  #{pane_current_command} #[bg=black,fg=brightblack]"
          set-option -g status-left-style bg=brightblack,fg=brightwhite
          set-option -g status-left-length 30
          set-option -g status-right "#[bg=black,fg=brightblack]#[default] #h "
          set-option -g status-right-style bg=brightblack,fg=brightwhite
          set-option -g window-status-current-format " #I#F #W #[bg=black,fg=yellow]"
          set-option -g window-status-current-style bg=yellow,fg=black
          set-option -g window-status-format " #I#F #W "
          set-option -g window-status-separator ""
          set-option -g pane-active-border-style fg=yellow
        '';
        historyLimit = 50000;
        keyMode = "vi";
        newSession = true;
        terminal = "xterm-256color";
        # TODO check tmux plugins
        tmuxinator.enable = true;
      };
      vim = {
        enable = true;
        # TODO: look how add szw/vim-ctrlspace
        plugins = with pkgs.vimPlugins; [
          tcomment_vim
          gruvbox
          vim-fugitive
          vim-airline
          vim-indent-guides
          vim-exchange
          vim-highlightedyank
          vim-gitgutter
          coc-nvim
        ];
        settings = {
          history = 1000;

          background = "dark";

          hidden = true;

          ignorecase = true;
          smartcase = true;

          mouse = "a";
          mousehide = true;
          mousemodel = "extend";

          number = true;
          relativenumber = true;

          expandtab = true;
          shiftwidth = 4;
          tabstop = 4;
        };
        extraConfig = ''
          " locale
          language en_US.UTF-8
          set encoding=UTF-8
          set fileencodings=utf-8,cp1251,koi8-r,latin1
          set fileformats=unix,dos,mac

          " GUI options
          if has('gui_running')
            set guioptions=aAPi
            set guifont=PragmataPro\ Mono\ 12
          else
            set t_Co=256
          endif

          " colors
          let g:gruvbox_contrast_dark='soft'
          let g:gruvbox_invert_selection=0
          let g:gruvbox_italic=1
          let g:gruvbox_italicize_strings=1
          colorscheme gruvbox

          " search options
          set incsearch
          set hlsearch

          " substitute options
          set gdefault

          " current cursor position in lower right corner
          set ruler

          " lines numbers
          set numberwidth=1

          " scroll offset
          set scrolloff=0
          set scrolljump=-25

          " tabs
          set softtabstop=4

          " Invisible symbols
          set list
          set listchars=tab:\¦\ ,trail:·,extends:→,precedes:←,nbsp:×

          " Separators and character to fill
          set fillchars+=vert:│

          " command in bottom right portion of the screen
          set showcmd

          " indent options
          set autoindent
          set smartindent

          " code folding
          set foldenable
          set foldmethod=syntax
          set foldcolumn=0
          set foldlevelstart=99

          " nice command-line completions
          set wildmenu
          set wildmode=list,longest,full
          set wcm=<Tab>

          " text margins and wrapping
          set wrap
          set linebreak
          set showbreak=↪\
          set textwidth=99
          set colorcolumn=+1

          " highlight current line
          set cursorline

          " always show tabs line
          set showtabline=2

          " reread file if it have been changed somewhere else
          set autoread

          " ask to overwrite file
          set confirm

          " backspace settings
          set backspace=indent,eol,start

          " autocompletion settings
          set pumheight=10
          set completeopt=menu,menuone,longest,preview
          set previewheight=5

          " when switching between buffers, jump to the first open window that contains
          " specified buffer considering all tabs
          set switchbuf=usetab

          " Mappings
          " fix for annoying typo
          command! W :w
          command! Bd :bd

          " clear highlight after search
          noremap <silent><Leader>/ :nohls<CR>

          " remove trailing spaces
          noremap <silent><Leader><Space> :%s/\ \+$//c<CR>

          " open a Quickfix window for the last search.
          nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

          " open file in the same directory as the current file
          cnoremap %% <C-R>=expand('%:h').'/'<cr>

          " move around splits with <c-hjkl>
          nnoremap <c-j> <c-w>j
          nnoremap <c-k> <c-w>k
          nnoremap <c-h> <c-w>h
          nnoremap <c-l> <c-w>l

          " don't make any backups, use git instead
          set nobackup
          set nowritebackup

          " keep all buffers in memory
          set noswapfile

          " spell checking
          set spelllang=en_us,ru_ru
          set spell
          set spellsuggest=best,10

          " use xmllint for pretty formating
          au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

          " jump to the last known cursor position
          " don't do it when the position is invalid or when inside an event handler
          autocmd BufReadPost *
                      \ if line("'\"") > 1 && line("'\"") <= line("$") |
                      \   exe "normal! g`\"" |
                      \ endif

          " clipboard
          set clipboard=unnamed,autoselect,autoselectplus
          if has('unnamedplus')
            set clipboard+=unnamedplus
          endif

          " Airline
          " Always show airline
          set laststatus=2
          " Don't display current mode
          set noshowmode
          " Prepare dictionary for custom symbols
          if !exists('g:airline_symbols')
            let g:airline_symbols = {}
          endif
          " Shorten spell detection indicator
          let g:airline_symbols.spell = 'Ꞩ'
          " Do not show spell lang
          let g:airline_detect_spelllang=0
          " Use fancy powerline symbols
          let g:airline_powerline_fonts=1
          " Disable use of %(%) grouping items in the statusline, fixes bleeding color
          " artifact for whitespace section, sometimes causes problem if GVim window is
          " resized
          let airline#extensions#default#section_use_groupitems = 0
          " Truncate long branch names to a fixed length
          let g:airline#extensions#branch#displayed_head_limit=15
          " Truncate all path sections but the last one, e.g. foo/bar/baz => f/b/baz
          let g:airline#extensions#branch#format = 2
          " Display tabs and buffers for CtrlSpace
          let g:airline#extensions#tabline#enabled = 1
          " Uniquify buffers names with similar filename, suppressing common parts of
          " paths
          let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
          " Do not show parent directories for unique filename
          let g:airline#extensions#tabline#fnamemod=':t'
          " Quickly select tab
          nmap <leader>1 <Plug>AirlineSelectTab1
          nmap <leader>2 <Plug>AirlineSelectTab2
          nmap <leader>3 <Plug>AirlineSelectTab3
          nmap <leader>4 <Plug>AirlineSelectTab4
          nmap <leader>5 <Plug>AirlineSelectTab5
          nmap <leader>6 <Plug>AirlineSelectTab6
          nmap <leader>7 <Plug>AirlineSelectTab7
          nmap <leader>8 <Plug>AirlineSelectTab8
          nmap <leader>9 <Plug>AirlineSelectTab9
          nmap <leader>- <Plug>AirlineSelectPrevTab
          nmap <leader>+ <Plug>AirlineSelectNextTab

          " ctrlspace
          " let g:ctrlspace_ignored_files='\v\.(exe|obj|mak|r45|res|s45|ewp|eww|ewd|resc|lng|xcl|xls)$'
          " let g:ctrlspace_ignored_files='\v^(.*hs)@!'
          let g:ctrlspace_ignored_files='\v^(.*\.(hs|cpp|c|h|py|sh|html|js|json)$)@!'
          " Integration with airline
          " TODO: check if it is necessary!!!
          let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"
          " Save the active workspace on switching to another or clearing the current one
          let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
          " Loads the last active workspace on startup
          let g:CtrlSpaceLoadLastWorkspaceOnStart = 1

          " highlightedyank
          " TODO: probably will not work in nix
          map y <Plug>(highlightedyank)

          " diff options
          set diffopt=filler,vertical,iwhite

          " gitgutter
          set updatetime=100

          " coc-nvim
          " don't pass messages to |ins-completion-menu|
          set shortmess+=c
          " use tab for trigger completion with characters ahead and navigate
          inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
          inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
          function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
          endfunction
          " use <c-space> to trigger completion
          inoremap <silent><expr> <c-@> coc#refresh()
          " use <cr> to confirm completion, `<C-g>u` means break undo chain at
          " current position
          inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
          " highlight the symbol and its references when holding the curso.
          autocmd CursorHold * silent call CocActionAsync('highlight')
          " use `[g` and `]g` to navigate diagnostics
          nmap <silent> [g <Plug>(coc-diagnostic-prev)
          nmap <silent> ]g <Plug>(coc-diagnostic-next)
          " GoTo code navigation.
          nmap <silent> gd <Plug>(coc-definition)
          nmap <silent> gy <Plug>(coc-type-definition)
          nmap <silent> gi <Plug>(coc-implementation)
          nmap <silent> gr <Plug>(coc-references)
        '';
      };
      zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "tmux"
            "tmuxinator"
            "z"
            "vi-mode"
            # "safe-paste"
            "fd"
          ];
          theme = "";
        };
        localVariables = {
          DISABLE_AUTO_TITLE = true;
          COMPLETION_WAITING_DOTS = true;
        };
        sessionVariables = {
        };
        shellAliases = {
          diff = "diff -u --color";
        };
        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
          {
            name = "powerlevel10k-config";
            src = lib.cleanSource ./p10k-config;
            file = "p10k.zsh";
          }
        ];
      };
    };
  };
}
