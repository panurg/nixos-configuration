# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    ];

  # Use GRUB
  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };

  networking.hostName = "nixos-playground"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  networking.networkmanager.enable = true;
  # TODO: check its options
  # Prevent nm to manage container interfaces
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = false;
    # TODO: add Russian layout
    layout = "us";
    windowManager.i3.enable = true;
    # videoDrivers = [ "intel" ]
    # Auto login in case of disk encryption
    # displayManager = {
    #   defaultSession = "none+i3";
    #   lightdm = {
    #     enable = true;
    #     autoLogin.enable = true;
    #     autoLogin.user = "alice";
    #   };
    # };
  };
  # services.xserver.xkbOptions = "eurosign:e";
  # On 64-bit systems, if you want OpenGL for 32-bit programs such as in Wine, you should also set the following:
  # hardware.opengl.driSupport32Bit = true;

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Home Manager settings
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.panurg = {
    description = "Alexander Abrosimov";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    # TODO: prepare system of mutableUsers set to false and  hashedPassword (or smth)
    initialPassword = "test";
    # TODO: openssh.authorizedKeys.keys
  };
  home-manager.users.panurg = { pkgs, config, ... }: {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.numix-gtk-theme;
        name = "Numix";
      };
      iconTheme = {
        package = pkgs.numix-icon-theme-circle;
        name = "Numix Circle";
      };
      # TODO: add cursor theme:
      # gtk-cursor-theme-name = "Vanilla-DMZ-AA"
      # gtk-cursor-theme-size = 48
      gtk2.extraConfig = ''
        style "vimfix" {
          bg[NORMAL] = "#282828"
        }
        widget "vim-main-window.*GtkForm" style "vimfix"
      '';
    };
    keyboard = {
      layout = "us,ru";
      # TODO: identify model
      model = "pc105";
      variant = "";
      options = [ "grp:caps_toggle" ];
    };
    home = {
      username = "panurg";
      language = {
        base = "ru_RU.utf8";
        messages = "en_US.utf8";
        collate = "en_US.utf8";
      };
      sessionVariables = {
      # FOO = "Hello";
      # BAR = "${config.home.sessionVariables.FOO} World!";
      };
      stateVersion = "20.03";
    };
    home.packages = with pkgs; [
    ];
    programs = {
      # TODO: check autorandr, bat, broot, beets, browserpass or pass,
      # direnv, keychain, lsd, neovim, noti, ssh, zathura
      # TODO wayland: mako
      chromium.enable = true;
      command-not-found.enable = true;
      dircolors.enable = true;
      feh.enable = true;
      fzf.enable = true;
      git.enable = true;
      lesspipe.enable = true; # ???
      mpv.enable = true;
      rofi = {
        enable = true;
        theme = "gruvbox-dark-soft";
      };
      tmux.enable = true;
      urxvt = {
        enable = true;
        fonts = [
          "xft:PragmataPro:size=12"
        ];
        scroll.bar.enable = false;
      };
      vim = {
        enable = true;
        # TODO: look how add szw/vim-ctrlspace
        plugins = with pkgs.vimPlugins; [
          tcomment_vim
          gruvbox
          YouCompleteMe
          vim-fugitive
          vim-airline
          vim-indent-guides
          vim-exchange
          vim-highlightedyank
          vim-gitgutter
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
            set guioptions=aAP
            set guifont=PragmataPro\ Mono\ 12
          else
            set t_Co=256
          endif

          " colors
          let g:gruvbox_contrast_dark='soft'
          let g:gruvbox_invert_selection=0
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
          set foldcolumn=2
          set foldlevelstart=99

          " nice command-line completions
          set wildmenu
          set wildmode=list,longest,full
          set wcm=<Tab>

          " text margins and wrapping
          set wrap
          set linebreak
          set showbreak=↪\
          set textwidth=80
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

          " YouCompleteMe
          let g:ycm_add_preview_to_completeopt=1
          " let g:ycm_autoclose_preview_window_after_insertion=1
          map <silent> <Leader>yg :YcmCompleter GoTo<CR>

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
        '';
      };
      zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "npm" "tmux" "tmuxinator" "autojump" "vi-mode" ];
          theme = "kolo";
        };
        localVariables = {
          DISABLE_AUTO_TITLE = true;
          ENABLE_CORRECTION = true;
          COMPLETION_WAITING_DOTS = true;
        };
        sessionVariables = {
          EDITOR = "vim";
        };
        shellAliases = {
          mux = "tmuxinator";
        };
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  # Auto upgrade options
  system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  nix.gc.automatic = true;

  security.hideProcessInformation = true;
}

