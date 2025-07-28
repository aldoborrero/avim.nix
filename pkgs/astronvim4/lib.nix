# Common wrapper script builder for AstroNvim
{
  lib,
  neovim,
  buildEnv,
  writeShellScriptBin,
}: {
  mkAstronvimWrapper = {
    name,
    config,
    nvim-appname,
    postInit ? "", # Hook for version-specific logic (like telescope-fzf-native)
  }:
    writeShellScriptBin name ''
      set -efu

      # Remove VIMINIT variable
      unset VIMINIT

      # Configuration
      SCRIPT_NAME="${name}"
      DEFAULT_APPNAME="${nvim-appname}"
      CONFIG_PATH="${config}"
      LSP_PATH="${buildEnv {
        name = "lsp-servers";
        paths = config.lspToolingPkgs;
      }}/bin"

      # Define XDG paths once
      setup_xdg_vars() {
        export XDG_CONFIG_HOME=''${XDG_CONFIG_HOME:-$HOME/.config}
        export XDG_DATA_HOME=''${XDG_DATA_HOME:-$HOME/.local/share}
        export XDG_CACHE_HOME=''${XDG_CACHE_HOME:-$HOME/.cache}
      }

      # Setup neovim paths
      setup_nvim_vars() {
        export NVIM_CONFIG="$XDG_CONFIG_HOME/$NVIM_APPNAME"
        export NVIM_DATA="$XDG_DATA_HOME/$NVIM_APPNAME"
        export NVIM_CACHE="$XDG_CACHE_HOME/$NVIM_APPNAME"
      }

      # Parse command line arguments
      NVIM_APPNAME="$DEFAULT_APPNAME"
      NO_LINK=0
      VERBOSE=0
      ARGS=()

      while [[ $# -gt 0 ]]; do
        case $1 in
          --app-name)
            NVIM_APPNAME="$2"
            shift 2
            ;;
          --no-link)
            NO_LINK=1
            shift
            ;;
          --verbose)
            VERBOSE=1
            shift
            ;;
          --reset)
            echo "Resetting $NVIM_APPNAME installation..."
            setup_xdg_vars
            rm -rf "$XDG_CONFIG_HOME/$NVIM_APPNAME" "$XDG_DATA_HOME/$NVIM_APPNAME" "$XDG_CACHE_HOME/$NVIM_APPNAME"
            echo "Reset complete."
            exit 0
            ;;
          --plugin-status)
            setup_xdg_vars
            export NVIM_APPNAME
            export PATH="$LSP_PATH:$PATH"
            ln -sfT "$CONFIG_PATH" "$XDG_CONFIG_HOME/$NVIM_APPNAME" 2>/dev/null || true
            ${lib.getExe neovim} --headless -c "Lazy" -c "qa"
            exit 0
            ;;
          --help)
            cat <<EOF
      Usage: $SCRIPT_NAME [OPTIONS] [NEOVIM_ARGS]

      Options:
        --app-name NAME     Set NVIM_APPNAME (default: $DEFAULT_APPNAME)
        --no-link          Copy config instead of symlinking (allows editing)
        --reset            Remove all AstroNvim data and cache
        --plugin-status    Show plugin installation status
        --verbose          Show verbose output during startup
        --help             Show this help message

      All other arguments are passed to Neovim.
      EOF
            exit 0
            ;;
          *)
            ARGS+=("$1")
            shift
            ;;
        esac
      done

      # Export environment
      export PATH="$LSP_PATH:$PATH"
      export NVIM_APPNAME

      # Setup directories
      setup_xdg_vars
      mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME"

      setup_nvim_vars
      mkdir -p "$NVIM_CACHE"

      [[ $VERBOSE -eq 1 ]] && {
        echo "Using config: $NVIM_CONFIG"
        echo "Using data: $NVIM_DATA"
        echo "Using cache: $NVIM_CACHE"
      }

      # Link or copy configuration
      if [ $NO_LINK -eq 1 ]; then
        rm -rf "$NVIM_CONFIG"
        cp -R -L "$CONFIG_PATH" "$NVIM_CONFIG"
        chown -R $(id -u):$(id -g) "$NVIM_CONFIG"
        chmod -R u=rwX,go=rX "$NVIM_CONFIG"
      else
        ln -sfT "$CONFIG_PATH" "$NVIM_CONFIG"
      fi

      # Validate setup
      if [[ ! -d "$NVIM_CONFIG" ]]; then
        echo "Error: Failed to setup config at $NVIM_CONFIG" >&2
        exit 1
      fi

      # Initialize plugins
      [[ $VERBOSE -eq 1 ]] && echo "Initializing AstroNvim plugins..."
      if ! ${lib.getExe neovim} --headless -c 'quitall' 2>/dev/null; then
        echo "Warning: Initial plugin setup failed" >&2
      fi

      # Run version-specific post-init hooks
      ${postInit}

      # Launch Neovim
      [[ $VERBOSE -eq 1 ]] && echo "Starting Neovim..."
      exec ${lib.getExe neovim} "''${ARGS[@]}"
    '';
}
