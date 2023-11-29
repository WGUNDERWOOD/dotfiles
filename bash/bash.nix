{pkgs, ...}: {
  home.file.".bash_config.conf".source = ./.bash_config.conf;
  home.file.".bash_aliases.conf".source = ./.bash_aliases.conf;
  programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
          "g" = "git";
      };
      initExtra = ''
          source $HOME/.bash_config.conf
          source $HOME/.bash_aliases.conf
      '';
  };
}
