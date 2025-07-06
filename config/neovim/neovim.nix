{pkgs, ...}: rec {
  home.file.".config/nvim/snippets/mail.snippets" = {
    source = ./snippets/mail.snippets;
  };
  home.file.".config/nvim/snippets/org.snippets" = {
    source = ./snippets/org.snippets;
  };
  home.file.".config/nvim/snippets/sh.snippets" = {
    source = ./snippets/sh.snippets;
  };
  home.file.".config/nvim/snippets/tex.snippets" = {
    source = ./snippets/tex.snippets;
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.neovim.plugins = let
    vim-searchindex = pkgs.vimUtils.buildVimPlugin {
      name = "vim-searchindex";
      src = pkgs.fetchFromGitHub {
        owner = "google";
        repo = "vim-searchindex";
        rev = "b0788c8213210b3bd23b62847dd5a9ebbe4ad648";
        sha256 = "sha256-gDbzUF6KqBloY4dIzZrjiSq5sMGs09awH+SKTOscMKk=";
      };
    };
    vim-yankstack = pkgs.vimUtils.buildVimPlugin {
      name = "vim-yankstack";
      src = pkgs.fetchFromGitHub {
        owner = "maxbrunsfeld";
        repo = "vim-yankstack";
        rev = "157a659c1b101c899935d961774fb5c8f0775370";
        sha256 = "sha256-lBMfOxUF6vykuVPmqZ3rsy6ryyprui8+dHpuKepXXp8=";
      };
    };
  in [
    pkgs.vimPlugins.cmp-omni
    pkgs.vimPlugins.cmp-rg
    pkgs.vimPlugins.cmp_luasnip
    pkgs.vimPlugins.catppuccin-nvim
    pkgs.vimPlugins.fzf-lua
    pkgs.vimPlugins.lean-nvim
    pkgs.vimPlugins.leap-nvim
    pkgs.vimPlugins.lualine-nvim
    pkgs.vimPlugins.luasnip
    pkgs.vimPlugins.neomake
    pkgs.vimPlugins.nvim-autopairs
    pkgs.vimPlugins.nvim-cmp
    pkgs.vimPlugins.nvim-colorizer-lua
    pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    pkgs.vimPlugins.orgmode
    pkgs.vimPlugins.vim-gitgutter
    pkgs.vimPlugins.vim-just
    pkgs.vimPlugins.vim-lastplace
    pkgs.vimPlugins.vim-repeat
    pkgs.vimPlugins.vim-startify
    pkgs.vimPlugins.vimtex
    pkgs.vimPlugins.yuck-vim
    vim-searchindex
    vim-yankstack
  ];

  programs.neovim.extraConfig = "luafile ${./neovim.lua}";
}
