#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-install}"

LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
TEMPLATES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/launchagents"

# Detect Homebrew prefix and nvim path
detect_paths() {
  local brew_prefix
  if brew_prefix=$(command -v brew >/dev/null 2>&1 && brew --prefix 2>/dev/null); then
    :
  else
    # Fallback by arch
    if [[ "$(uname -m)" == "arm64" ]]; then
      brew_prefix="/opt/homebrew"
    else
      brew_prefix="/usr/local"
    fi
  fi

  local nvim_bin
  if nvim_bin=$(command -v nvim 2>/dev/null); then
    :
  else
    nvim_bin="${brew_prefix}/bin/nvim"
  fi

  echo "${brew_prefix}" "${nvim_bin}"
}

install_agents() {
  mkdir -p "${LAUNCH_AGENTS_DIR}"

  read -r BREW_PREFIX NVIM_BIN < <(detect_paths)

  # Compose PATH value; include both common Homebrew prefixes for robustness
  local PATH_VALUE
  PATH_VALUE="${BREW_PREFIX}/bin:/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"

  # Render templates
  sed \
    -e "s|___LABEL___|com.user.env.path|g" \
    -e "s|___PROGRAM___|/bin/launchctl|g" \
    -e "s|___ARG3___|PATH|g" \
    -e "s|___ARG4___|${PATH_VALUE}|g" \
    "${TEMPLATES_DIR}/template.setenv.plist" \
    >"${LAUNCH_AGENTS_DIR}/com.user.env.path.plist"

  sed \
    -e "s|___LABEL___|com.user.env.nvim|g" \
    -e "s|___PROGRAM___|/bin/launchctl|g" \
    -e "s|___ARG3___|NEOVIM_BIN|g" \
    -e "s|___ARG4___|${NVIM_BIN}|g" \
    "${TEMPLATES_DIR}/template.setenv.plist" \
    >"${LAUNCH_AGENTS_DIR}/com.user.env.nvim.plist"

  # Load (reload if already present)
  launchctl unload "${LAUNCH_AGENTS_DIR}/com.user.env.path.plist" 2>/dev/null || true
  launchctl unload "${LAUNCH_AGENTS_DIR}/com.user.env.nvim.plist" 2>/dev/null || true
  launchctl load -w "${LAUNCH_AGENTS_DIR}/com.user.env.path.plist"
  launchctl load -w "${LAUNCH_AGENTS_DIR}/com.user.env.nvim.plist"

  echo "Installed and loaded LaunchAgents:"
  echo "  - ${LAUNCH_AGENTS_DIR}/com.user.env.path.plist"
  echo "  - ${LAUNCH_AGENTS_DIR}/com.user.env.nvim.plist"
  echo
  echo "Verify:"
  echo "  launchctl getenv PATH"
  echo "  launchctl getenv NEOVIM_BIN"
}

uninstall_agents() {
  local files=(
    "${LAUNCH_AGENTS_DIR}/com.user.env.path.plist"
    "${LAUNCH_AGENTS_DIR}/com.user.env.nvim.plist"
  )
  for f in "${files[@]}"; do
    launchctl unload "${f}" 2>/dev/null || true
    rm -f "${f}"
  done
  echo "Uninstalled LaunchAgents (unloaded and removed)."
}

case "${ACTION}" in
  install)
    install_agents
    ;;
  uninstall|remove)
    uninstall_agents
    ;;
  *)
    echo "Usage: $0 [install|uninstall]" >&2
    exit 1
    ;;
esac

