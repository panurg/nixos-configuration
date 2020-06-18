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
    enable = true;
    enableCtrlAltBackspace = true;
    # TODO: add Russian layout
    layout = "us";
    # dpi = 123;
    # imwheel.enable = true;
    # libinput.enable = true;
    # modules = [ pkgs.xf86_input_wacom ];
    # wacom.enable = true;
    # xautolock.enable = true;
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
    displayManager = {
      defaultSession = "home-manager";
      session = [
        {
          manage = "desktop";
          name = "home-manager";
          start = "";
        }
      ];
    };
  };
  # services.xserver.xkbOptions = "eurosign:e";
  # On 64-bit systems, if you want OpenGL for 32-bit programs such as in Wine, you should also set the following:
  # hardware.opengl.driSupport32Bit = true;

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Fix for Home Manager error
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

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
    home = {
      username = "panurg";
      language.base = "en_US.utf8";
      keyboard = {
        layout = "us,ru";
        # TODO: identify model
        model = "pc105";
        variant = "";
        options = [ "grp:caps_toggle" ];
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
      # TODO: check out autorandr or grobi, bat, broot, beets, browserpass or pass,
      # direnv or lorri, keychain, lsd, neovim, noti, ssh, zathura
      # TODO wayland: mako
      chromium.enable = true;
      command-not-found.enable = true;
      # dircolors.enable = true;
      feh.enable = true;
      fzf.enable = true;
      git.enable = true;
      lesspipe.enable = true; # ???
      mpv = {
        enable = true;
        scripts = [ pkgs.mpvScripts.mpris ];
      };
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
        };
        shellAliases = {
          mux = "tmuxinator";
        };
      };
    };
    services = {
      # TODO: check out flameshot, systemd getmail, hound (!!!), redshift, screen-locker
      # spotifyd, syncthing, udiskie, unclutter, XSuspender
      dunst = {
        enable = true;
        settings = {
          global = {
            font = "Noto Sans 20";
            allow_markup = true;
            format = "<b>%s</b>\n%b";
            sort = true;
            indicate_hidden = true;
            alignment = "left";
            bounce_freq = 0;
            show_age_threshold = 60;
            word_wrap = true;
            ignore_newline = false;
            geometry = "300x5-30+20";
            shrink = false;
            transparency = 0;
            idle_threshold = 120;
            monitor = 0;
            follow = "mouse";
            sticky_history = true;
            history_length = 20;
            show_indicators = true;
            line_height = 0;
            separator_height = 2;
            padding = 8;
            horizontal_padding = 8;
            separator_color = "frame";
            startup_notification = false;
            dmenu = "/usr/bin/dmenu -p dunst:";
            browser = "/usr/bin/firefox -new-tab";
            icon_position = "off";
          };
          frame = {
            width = 3;
            color = "#aaaaaa";
          };
          shortcuts = {
            close = "ctrl+space";
            close_all = "ctrl+shift+space";
            history = "ctrl+grave";
            context = "ctrl+shift+period";
          };
          urgency_low = {
            background = "#222222";
            foreground = "#888888";
            timeout = 10;
          };
          urgency_normal = {
            background = "#285577";
            foreground = "#ffffff";
            timeout = 10;
          };
          urgency_critical = {
            background = "#900000";
            foreground = "#ffffff";
            timeout = 0;
          };
        };
      };
      mpd.enable = true;
      mpdris2 = {
        enable = true;
        multimediaKeys = true;
        notifications = true;
      };
      picom = {
        # TODO: compare compton and picom configs, looks like they are different
        enable = true;
        backend = "glx";
        fade = true;
        fadeDelta = 2;
        fadeSteps = [ "0.01" "0.01" ];
      };
      polybar = {
        enable = true;
        config = {
          colors = {
            background = "#444444";
            background-alt = "#686868";
            foreground = "#dddddd";
            foreground-alt = "#919191";
            accent = "#f0544c";
          };
          "bar/root" = {
            fixed-center = false;
            height = 50;
            background = "\${colors.background}";
            foreground = "\${colors.foreground}";
            line-size = 4;
            module-margin-left = 2;
            font-0 = "Noto Sans:size=20;5";
            font-1 = "FontAwesome:size=20;5";
            font-2 = "IcoMoon\-Free:size=20;5";
            font-3 = "Noto Sans:size=24:weight=bold;5";
            font-4 = "icomoon:size=20;5";
            font-5 = "Noto Emoji:size=20:weight=bold;5";
            font-6 = "icomoon\-wifi:size=20;5";
            font-7 = "Noto Sans:size=17;5";
            modules-left = [ "i3" "mpd" ];
            modules-center = [ "xwindow" ];
            modules-right = [ "xkeyboard" "backlight" "volume" "wlan" "battery" "date" ];
            tray-position = "right";
            tray-padding = 0;
            tray-maxsize = 50;
            # wm-restack = i3
            # override-redirect = true
            scroll-up = "i3wm-wsnext";
            scroll-down = "i3wm-wsprev";
          };
          "module/xwindow" = {
            type = "internal/xwindow";
            label-maxlen = 120;
          };
          "module/xkeyboard" = {
            type = "internal/xkeyboard";
            format = "<label-layout>";
            label-layout-font = 4;
          };
          "module/i3" = {
            type = "internal/i3";
            index-sort = true;
            format = "<label-state>";
            wrapping-scroll = false;
            ws-icon-0 = "1;関";
            ws-icon-1 = "2;";
            ws-icon-2 = "3;";
            ws-icon-3 = "4;萾";
            ws-icon-4 = "5;";
            ws-icon-5 = "9;㻚";
            ws-icon-default = "";
            label-focused = "%icon%";
            label-focused-background = "\${colors.background-alt}";
            label-focused-underline = "\${colors.accent}";
            label-focused-underline-size = 8;
            label-focused-padding = 2;
            label-unfocused = "%icon%";
            label-unfocused-padding = 2;
            label-visible = "%icon%";
            label-visible-padding = 2;
            label-urgent = "%icon%";
            label-urgent-background = "\${colors.accent}";
            label-urgent-padding = 2;
          };
          "module/backlight" = {
            type = "internal/backlight";
            card = "intel_backlight";
            format = "<ramp>";
            ramp-0 = "🌕";
            ramp-1 = "🌔";
            ramp-2 = "🌓";
            ramp-3 = "🌒";
            ramp-4 = "🌑";
          };

          "module/wlan" = {
            type = "internal/network";
            interface = "wlp60s0";
            interval = "3.0";
            format-connected = "<label-connected> <ramp-signal>";
            label-connected = "";
            label-alt-connected = " %essid%  %downspeed%  %upspeed%";
            label-alt-connected-foreground = "\${colors.foreground-alt}";
            label-alt-connected-font = 8;
            label-disconnected = "";
            ramp-signal-0 = "煵";
            ramp-signal-1 = "䋻";
            ramp-signal-2 = "";
            ramp-signal-3 = "渏";
          };

          "module/date" = {
            label-margin-right = 1;
            type = "internal/date";
            interval = 1;
            date = "";
            date-alt = "%{T8}%{F#919191} %e %a w%V%{F-}%{T-}";
            time = "%R";
            time-alt = "\${self.time}";
            label = "%date% %{T4}%time%%{T-}";
          };

          "module/volume" = {
            type = "internal/volume";
            format-volume = "<ramp-volume>";
            speaker-mixer = "Speaker";
            headphone-mixer = "Headphone";
            headphone-id = 15;
            mapped = "true;";
            label-muted = "䔄";
            label-muted-foreground = "\${colors.accent}";
            ramp-volume-0 = "蒈";
            ramp-volume-1 = "惣";
            ramp-volume-2 = "葤";
            ramp-volume-3 = "烵";
            ramp-headphones-0 = "蒈 䚀";
            ramp-headphones-1 = "惣 䚀";
            ramp-headphones-2 = "葤 䚀";
            ramp-headphones-3 = "烵 䚀";
          };

          "module/battery" = {
            type = "internal/battery";
            battery = "BAT0";
            adapter = "AC";
            time-format = "%R";
            format-charging = "<label-charging> <animation-charging>";
            format-discharging = "<label-discharging> <ramp-capacity>";
            format-full = "䀹";
            label-charging = "";
            label-alt-charging = "䀝 %percentage%% 娫 %time%";
            label-alt-charging-foreground = "\${colors.foreground-alt}";
            label-alt-charging-font = 8;
            label-discharging = "";
            label-alt-discharging = "䀝 %percentage%% 娫 %time%";
            label-alt-discharging-foreground = "\${colors.foreground-alt}";
            label-alt-discharging-font = 8;
            ramp-capacity-0 = "";
            ramp-capacity-0-foreground = "\${colors.accent}";
            ramp-capacity-1 = "";
            ramp-capacity-2 = "";
            ramp-capacity-3 = "";
            ramp-capacity-4 = "";
            animation-charging-0 = "";
            animation-charging-1 = "";
            animation-charging-2 = "";
            animation-charging-3 = "";
            animation-charging-4 = "";
          };

          "module/mpd" = {
            type = "internal/mpd";
            host = "127.0.0.1";
            port = "6600";
            password = "\${env:MPD_PASSWORD:}";
            interval = 1;
            format-online = "";
            format-playing = "<label-song>";
            format-playing-foreground = "\${colors.foreground-alt}";
            label-song-font = 8;
          };
        };
        script = "polybar root &";
      };
    };
    systemd.user.sessionVariables = {
      EDITOR = "vim";
    };
    # TODO: check out wayland configuration: sway
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        desktop = "\$HOME/desktop";
        documents = "\$HOME/doc";
        download = "\$HOME/dl";
        music = "\$HOME/music";
        pictures = "\$HOME/img";
        publicShare = "\$HOME/share";
        templates = "\$HOME/templates";
        videos = "\$HOME/video";
      };
    };
    xresources.properties = {
      "*.foreground" = "#dedede";
      "*.background" = "#444444";
      "*.cursorColor" = "#dedede";

      # black
      "*.color0" = "#555555";
      "*.color8" = "#888888";

      # red
      "*.color1" = "#9c3528";
      "*.color9" = "#d64937";

      # green
      "*.color2" = "#61bc3b";
      "*.color10" = "#86df5d";

      # yellow
      "*.color3" = "#f3b43a";
      "*.color11" = "#fdd75a";

      # blue
      "*.color4" = "#0d68a8";
      "*.color12" = "#0f75bd";

      # magenta
      "*.color5" = "#744560";
      "*.color13" = "#9e5e83";

      # cyan
      "*.color6" = "#288e9c";
      "*.color14" = "#37c3d6";

      # white
      "*.color7" = "#a2a2a2";
      "*.color15" = "#f9f9f9";
    };
    xsession = {
      enable = true;
      numlock.enable = true;
      pointerCursor = {
        package = pkgs.numix-cursor-theme;
        name = "Numix-Cursor";
        size = 48;
      };
      # TODO: learn about Status Notifier Items (SNI) protocol
      windowManager.i3 = {
        enable = true;
      # TODO: fill i3 config (!!!)
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

