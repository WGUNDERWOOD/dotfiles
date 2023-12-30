{ pkgs ? import <nixpkgs> { } }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "todo-finder";
  version = "0.1.0";

  #src = fetchFromGitHub {
    #owner = "BurntSushi";
    #repo = pname;
    #rev = version;
    #hash = "sha256-+s5RBC3XSgb8omTbUNLywZnP6jSxZBKSS1BmXOjRF8M=";
  #};

  #cargoHash = "sha256-jtBw4ahSl88L0iuCXxQgZVm1EcboWRJMNtjxLVTtzts=";

  #meta = with lib; {
    #description = "A fast line-oriented regex search tool, similar to ag and ack";
    #homepage = "https://github.com/BurntSushi/ripgrep";
    #license = licenses.unlicense;
    #maintainers = [];
  #};

  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;
}


#{ lib, fetchFromGitHub, rustPlatform, ... }:

#rustPlatform.buildRustPackage rec {
  #pname = "ripgrep";
  #version = "12.1.1";

  #src = fetchFromGitHub {
    #owner = "BurntSushi";
    #repo = pname;
    #rev = version;
    #hash = "sha256-+s5RBC3XSgb8omTbUNLywZnP6jSxZBKSS1BmXOjRF8M=";
  #};

  #cargoHash = "sha256-jtBw4ahSl88L0iuCXxQgZVm1EcboWRJMNtjxLVTtzts=";

  #meta = with lib; {
    #description = "A fast line-oriented regex search tool, similar to ag and ack";
    #homepage = "https://github.com/BurntSushi/ripgrep";
    #license = licenses.unlicense;
    #maintainers = [];
  #};
#}
