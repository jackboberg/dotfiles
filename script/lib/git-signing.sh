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
    if ! command -v gh &>/dev/null; then
        msg_error "==> GitHub CLI (gh) is not installed"
        msg_error "==> Run bootstrap first or install gh manually"
        exit 1
    fi

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

    if [ -f "$KEY_PATH.pub" ] && [ ! -f "$KEY_PATH" ]; then
        msg_error "==> Public key exists but private key is missing: $KEY_PATH"
        msg_error "==> Remove $KEY_PATH.pub or restore the private key, then rerun."
        exit 1
    fi

    if [ -f "$KEY_PATH" ]; then
        local derived_pubkey existing_pubkey
        derived_pubkey=$(ssh-keygen -y -f "$KEY_PATH" 2>/dev/null | awk '{print $2}')

        if [ -f "$KEY_PATH.pub" ]; then
            existing_pubkey=$(awk '{print $2}' "$KEY_PATH.pub")
        else
            existing_pubkey=""
        fi

        if [ -z "$existing_pubkey" ] || [ "$derived_pubkey" != "$existing_pubkey" ]; then
            msg_info "==> Public key missing or mismatched; regenerating"
            ssh-keygen -y -f "$KEY_PATH" > "${KEY_PATH}.pub.tmp"
            mv "${KEY_PATH}.pub.tmp" "$KEY_PATH.pub"
        fi
        return
    fi

    msg_info "==> Generating SSH signing key for $email"
    ssh-keygen -t ed25519 -C "$email" -f "$KEY_PATH"
}

write_allowed_signers () {
    local email pubkey entry
    email=$(git config user.email)
    pubkey=$(cat "$KEY_PATH.pub")
    entry="$email $pubkey"

    mkdir -p "$(dirname "$ALLOWED_SIGNERS")"
    if [ -f "$ALLOWED_SIGNERS" ] && grep -qxF "$entry" "$ALLOWED_SIGNERS"; then
        msg_info "==> allowed_signers already contains this key"
        return
    fi

    echo "$entry" >> "$ALLOWED_SIGNERS"
    msg_info "==> Updated $ALLOWED_SIGNERS"
}

upload_to_github () {
    local pubkey_data existing_key_data title
    pubkey_data=$(awk '{print $2}' "$KEY_PATH.pub")

    existing_key_data=$(gh api /user/ssh_signing_keys --paginate --jq '.[].key | split(" ")[1]' 2>/dev/null || true)
    if echo "$existing_key_data" | grep -qxF "$pubkey_data"; then
        msg_info "==> Signing key already on GitHub"
        return
    fi

    title="$(hostname) signing key"
    msg_info "==> Uploading to GitHub as '$title'"
    gh ssh-key add "$KEY_PATH.pub" --type signing --title "$title"
}
