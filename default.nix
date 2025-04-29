{ pkgs ? import <nixpkgs> { } }:
with pkgs;

pkgs.mkShell rec {
  buildInputs = with pkgs; [
    aider-chat-with-playwright
  ];

  shellHook = ''
    source $HOME/aider/.env
    [ -z "OPENAI_API_KEY" ] && echo "Please set OPENAI_API_KEY"
    [ -z "OPENAI_API_BASE" ] && echo "Please set OPENAI_API_BASE"

    function myAider() {
      aider \
      --vim \
      --model-settings-file=$HOME/config.yaml \
      --model $AIDER_MODEL
    }

    alias aider=myAider
  '';
}