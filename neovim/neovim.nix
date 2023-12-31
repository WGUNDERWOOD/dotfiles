{pkgs, ...}: rec {

    home.file.".config/nvim/snippets/mail.snippets".source = ./snippets/mail.snippets;
    home.file.".config/nvim/snippets/org.snippets".source = ./snippets/org.snippets;
    home.file.".config/nvim/snippets/sh.snippets".source = ./snippets/sh.snippets;
    home.file.".config/nvim/snippets/tex.snippets".source = ./snippets/tex.snippets;

    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;

    programs.neovim.plugins =
        let vim-yankstack = pkgs.vimUtils.buildVimPlugin {
            name = "vim-yankstack";
            src = pkgs.fetchFromGitHub {
                owner = "maxbrunsfeld";
                repo = "vim-yankstack";
                rev = "157a659c1b101c899935d961774fb5c8f0775370";
                sha256 = "sha256-lBMfOxUF6vykuVPmqZ3rsy6ryyprui8+dHpuKepXXp8=";
            };
        };

    in [
        pkgs.vimPlugins.vim-startify
        pkgs.vimPlugins.dracula-nvim
        pkgs.vimPlugins.leap-nvim
        pkgs.vimPlugins.vim-repeat
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
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
        pkgs.vimPlugins.yuck-vim
        vim-yankstack
        ];

    programs.neovim.extraConfig = "luafile ${./neovim.lua}";
}
