{...}: {
  home.file.".config/bash/bash_config.sh".source = ./bash_config.sh;
  home.file.".config/bash/bash_aliases.sh".source = ./bash_aliases.sh;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      source $HOME/.config/bash/bash_config.sh
      source $HOME/.config/bash/bash_aliases.sh
    '';
  };
}
