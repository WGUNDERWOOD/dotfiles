{pkgs, ...}: {

  programs.bash = {
    enable = true;
    shellAliases = {
      g = "git";
    };
  };

}
