{ pkgs ? import <nixpkgs> { } }:
with pkgs;

pkgs.mkShell rec {
  buildInputs = with pkgs; [
    stdenv.cc.cc.lib
    python312
    python312Packages.pip
    python312Packages.virtualenvwrapper
  ];

  shellHook = ''
    [ -z "OPENAI_API_KEY" ] && echo "Please set OPENAI_API_KEY"
    [ -z "OPENAI_API_BASE" ] && echo "Please set OPENAI_API_KEY"

    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath buildInputs}"
    export TMPDIR=/$HOME/aider  && export VENV=/$HOME/aider
    virtualenv $VENV
    source $VENV/bin/activate
    pip install pyside2

    function myAider() {
      aider \
      -- vim\
      --model-settings-file=$HOME/config.yaml \
      [ -z "AIDER_MODEL" ] && $1 || "--model $AIDER_MODEL" $1
    }

    alias aider=myAider
  '';
}