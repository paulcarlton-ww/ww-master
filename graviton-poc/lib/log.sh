#!/usr/bin/env bash

# Colors
C_RST='\033[0m'
C_RED='\033[00;31m'
C_GRN='\033[00;32m'
C_YLW='\033[00;33m'
C_BLU='\033[00;34m'
#C_PPL='\033[00;35m'
C_CYN='\033[00;36m'
#C_GRY='\033[00;37m'

indent() {
    local -i indent_level=$1
    printf "%0.s  " $(seq 1 "${indent_level}")
}

err() {
    log -e "❌  ${C_RED}ERROR: $*${C_RST}"
}

warn() {
    log -e "⚠️  ${C_YLW}WARN: $*${C_RST}"
}

info() {
    log -e "${C_BLU}$*${C_RST}"
}

success() {
    log -e "✅  ${C_GRN}$*${C_RST}"
}

heading() {
    log -e "${C_CYN}$*${C_RST}"
}

log() {
    echo "$@" >&2
}

subheading() {
    indent 1
    info "$@"
}

success-step() {
    indent 2
    success "$@"
}

failed-step() {
    errors=$((errors + 1))
    indent 2
    err "$@"
}

warn_step() {
    warnings=$((warnings + 1))
    indent 2
    warn "$@"
}
