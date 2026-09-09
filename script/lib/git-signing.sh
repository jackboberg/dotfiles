#!/usr/bin/env bash

# script/lib/git-signing.sh: Git SSH signing setup helpers

KEY_PATH="$HOME/.ssh/id_ed25519_signing"
ALLOWED_SIGNERS="$HOME/.config/git/allowed_signers"

setup_git_signing () {
    msg_header "==> git signing"
    ensure_gh_authenticated
    ensure_signing_key
    write_allowed_signers
    upload_to_github
    msg_info "==> Done"
}

ensure_gh_authenticated () {
    # gh is installed by Brewfile; bootstrap_homebrew runs first in setup()
    if ! gh auth status &>/dev/null 2>&1; then
        msg_warn "==> GitHub CLI not authenticated"
        gh auth login
    fi
}

ensure_signing_key () {
    local email
    email=$(git config user.email)
    if [ -z "$email" ]; then
        msg_error "==> git user.email is not set"
        exit 1
    fi

    mkdir -p "$(dirname "$KEY_PATH")"

    if [ -f "$KEY_PATH" ] && [ ! -f "$KEY_PATH.pub" ]; then
        msg_info "==> Regenerating public key from private key"
        ssh-keygen -y -f "$KEY_PATH" > "$KEY_PATH.pub"
        return
    fi

    if [ -f "$KEY_PATH" ]; then return; fi

    msg_info "==> Generating SSH signing key for $email"
    ssh-keygen -t ed25519 -C "$email" -f "$KEY_PATH" -N ""
}

write_allowed_signers () {
    local email pubkey entry
    email=$(git config user.email)
    pubkey=$(cat "$KEY_PATH.pub")
    entry="$email $pubkey"

    mkdir -p "$(dirname "$ALLOWED_SIGNERS")"
    if [ -f "$ALLOWED_SIGNERS" ] && grep -qF "$entry" "$ALLOWED_SIGNERS"; then
        msg_info "==> allowed_signers already contains this key"
        return
    fi

    echo "$entry" >> "$ALLOWED_SIGNERS"
    msg_info "==> Updated $ALLOWED_SIGNERS"
}

upload_to_github () {
    local pubkey_data existing_keys title
    pubkey_data=$(awk '{print $2}' "$KEY_PATH.pub")

    existing_keys=$(gh api /user/ssh_signing_keys --jq '.[].key' 2>/dev/null || echo "")
    if echo "$existing_keys" | grep -q "$pubkey_data"; then
        msg_info "==> Signing key already on GitHub"
        return
    fi

    title="$(hostname) signing key"
    msg_info "==> Uploading to GitHub as '$title'"
    gh ssh-key add "$KEY_PATH.pub" --type signing --title "$title"
}
