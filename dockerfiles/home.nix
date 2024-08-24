{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  fonts.fontconfig.enable = true;

  home.username = "root";
  home.homeDirectory = "/root";
 
  home.stateVersion = "23.11";
 
  home.packages = with pkgs; [
    direnv
    devbox
    wget
    fd
    ccache
  ];
 
  home.file = {
    ".inputrc".text = ''
      set editing-mode vi
      set show-mode-in-prompt on
      set vi-cmd-mode-string [c]
      set vi-ins-mode-string [i]
      set emacs-mode-string [e]

      #vi mode
      $if mode=vi
      set keymap vi-command
      Control-l: clear-screen
      "#": insert-comment
      ".": "i !*\r"
      "|": "A | "
      "D":kill-line
      "C": "Da"
      "dw": kill-word
      "dd": kill-whole-line
      "db": backward-kill-word
      "cc": "ddi"
      "cw": "dwi"
      "cb": "dbi"
      "daw": "lbdW"
      "yaw": "lbyW"
      "caw": "lbcW"
      "diw": "lbdw"
      "yiw": "lbyw"
      "ciw": "lbcw"
      "da\"": "lF\"df\""
      "di\"": "lF\"lmtf\"d`t"
      "ci\"": "di\"i"
      "ca\"": "da\"i"
      "da'": "lF'df'"
      "di'": "lF'lmtf'd`t"
      "ci'": "di'i"
      "ca'": "da'i"
      "da`": "lF\`df\`"
      "di`": "lF\`lmtf\`d`t"
      "ci`": "di`i"
      "ca`": "da`i"
      "da(": "lF(df)"
      "di(": "lF(lmtf)d`t"
      "ci(": "di(i"
      "ca(": "da(i"
      "da)": "lF(df)"
      "di)": "lF(lmtf)d`t"
      "ci)": "di(i"
      "ca)": "da(i"
      "da{": "lF{df}"
      "di{": "lF{lmtf}d`t"
      "ci{": "di{i"
      "ca{": "da{i"
      "da}": "lF{df}"
      "di}": "lF{lmtf}d`t"
      "ci}": "di}i"
      "ca}": "da}i"
      "da[": "lF[df]"
      "di[": "lF[lmtf]d`t"
      "ci[": "di[i"
      "ca[": "da[i"
      "da]": "lF[df]"
      "di]": "lF[lmtf]d`t"
      "ci]": "di]i"
      "ca]": "da]i"
      "da<": "lF<df>"
      "di<": "lF<lmtf>d`t"
      "ci<": "di<i"
      "ca<": "da<i"
      "da>": "lF<df>"
      "di>": "lF<lmtf>d`t"
      "ci>": "di>i"
      "ca>": "da>i"
      "da/": "lF/df/"
      "di/": "lF/lmtf/d`t"
      "ci/": "di/i"
      "ca/": "da/i"
      "da:": "lF:df:"
      "di:": "lF:lmtf:d`t"
      "ci:": "di:i"
      "ca:": "da:i"
      "gg": beginning-of-history
      "G": end-of-history
      ?: reverse-search-history
      /: forward-search-history
      
      set keymap vi-insert
      Control-l: clear-screen
      $endif
    '';
  };
 
  home.sessionVariables = {
    CONAN_REVISIONS_ENABLED=1;
  };
 
  home.shellAliases = {
    switch = "home-manager switch";
    ls = "ls -lha --color=auto";
  };

  programs.home-manager.enable = true;

  programs.xplr = {
    enable = true;
  };

  programs.bash = {
    enable = true;
 
    historyControl = [
      "ignorespace"
      "ignoredups"
      "erasedups"
    ];

    shellOptions = [
        "-histappend"
        "histverify"
        "autocd"
        "checkjobs"
        "checkwinsize"
        "extglob"
        "globstar"
    ];
 
    initExtra = ''
      # setup prompt
 
      # https://bash-prompt-generator.org/
      # basic prompt
      #PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
 
      GIT_PROMPT_FILE_NIXOS="/run/current-system/sw/share/bash-completion/completions/git-prompt.sh"
      GIT_PROMPT_FILE_NIX="$HOME/.nix-profile/share/git/contrib/completion/git-prompt.sh"
 
      if [[ -f "$GIT_PROMPT_FILE_NIXOS" ]]; then
        source "$GIT_PROMPT_FILE_NIXOS"
      elif [[ -f "$GIT_PROMPT_FILE_NIX" ]]; then
        source "$GIT_PROMPT_FILE_NIX"
      fi
 
      update_prompt() {
        PS1='\[\e[92m\]\u\[\e[0m\]@\[\e[92m\]\H\[\e[0m\]:\[\e[38;5;37m\]\w\[\e[0m\]'
 
        if [[ $(command -v __git_ps1) ]]; then
          PS1_CMD1=$(__git_ps1 " (%s)")
          PS1+="\[\e[38;5;247m\]''${PS1_CMD1}\[\e[0m\]"
 
          if [ -n "$DIRENV_DIR" ]; then
            PS1+="% " # % for direnv directories
          else
            PS1+="\\$ " # $ for non-direnv directories
          fi
        fi
      }
 
      # manage history
      function merge_history() {
        history -n; history -w; history -c; history -r;
      }
      PROMPT_COMMAND='history -a;update_prompt'

      set -o vi +o emacs

      cheatsh() {
        curl cheat.sh/$1
      }
 
      # setup direnv
      eval "$(direnv hook bash)"
    '';
  };
 
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    defaultCommand = "fd --type f";
  };
 
  programs.git = {
    enable = true;
    userName = "Chris Samuelson";
    userEmail = "chris.sam55@gmail.com";
 
    aliases = {
      co = "checkout";
    };
 
    difftastic = {
      enable = true;
      background = "dark";
      color = "auto";
      display = "side-by-side";
    };
 
    ignores = [
    ];
 
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
 
  programs.vim = {
    enable = false;
    defaultEditor = true;
 
    settings = {
      expandtab = true;
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      mouse = "a";
      ignorecase = true;
      smartcase = true;
    };
 
    extraConfig = ''
      set nocompatible
      set scrolloff=8
    '';
  };
 
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    extraConfig = ''
      set nocompatible
      set mouse=a
      set expandtab
      set tabstop=2

      set number
      set relativenumber

      set scrolloff=8

      set ignorecase
      set smartcase
    '';

  };
}
 
