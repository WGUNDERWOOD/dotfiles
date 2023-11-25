{pkgs, ...}: {

  programs.neovim.enable = true;

  programs.neovim.plugins = [
    pkgs.vimPlugins.vim-startify
    pkgs.vimPlugins.dracula-nvim
    pkgs.vimPlugins.leap-nvim
    pkgs.vimPlugins.vim-repeat
    pkgs.vimPlugins.nvim-treesitter
    pkgs.vimPlugins.orgmode
    pkgs.vimPlugins.fzf-lua
    pkgs.vimPlugins.YankRing-vim
    pkgs.vimPlugins.nvim-autopairs
    pkgs.vimPlugins.nvim-colorizer-lua
    pkgs.vimPlugins.vimtex
    pkgs.vimPlugins.lualine-nvim
    pkgs.vimPlugins.neomake
    pkgs.vimPlugins.luasnip
    pkgs.vimPlugins.nvim-cmp
    pkgs.vimPlugins.cmp_luasnip
    pkgs.vimPlugins.cmp-rg
    pkgs.vimPlugins.vim-gitgutter
    pkgs.vimPlugins.vim-lastplace
    pkgs.vimPlugins.cmp-omni
  ];

  programs.neovim.extraConfig = "luafile ${./neovim.lua}";
}
