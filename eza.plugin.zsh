# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# @name: eza
# @brief: Set aliases for the `eza` command, a modern replacement for `ls`.
# @repository: https://github.com/johnstonskj/zsh-eza-plugin
# @version: 0.1.1
# @license: MIT AND Apache-2.0
#
# Public variables:
#
# * `EZA`; plugin-defined global associative array with the following keys:
#   * \`_PLUGIN_DIR\`; the directory the plugin is sourced from.
#   * \`_FUNCTIONS\`; a list of all functions defined by the plugin.
#

############################################################################
# Standard Setup Behavior
############################################################################

# See https://wiki.zshell.dev/community/zsh_plugin_standard#zero-handling
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# See https://wiki.zshell.dev/community/zsh_plugin_standard#standard-plugins-hash
declare -gA EZA
EZA[_PLUGIN_DIR]="${0:h}"
EZA[_ALIASES]=""
EZA[_FUNCTIONS]=""

############################################################################
# Internal Support Functions
############################################################################

#
# This function will add to the `EZA[_FUNCTIONS]` list which is
# used at unload time to `unfunction` plugin-defined functions.
#
# See https://wiki.zshell.dev/community/zsh_plugin_standard#unload-function
# See https://wiki.zshell.dev/community/zsh_plugin_standard#the-proposed-function-name-prefixes
#
.eza_remember_fn() {
    builtin emulate -L zsh

    local fn_name="${1}"
    if [[ -z "${EZA[_FUNCTIONS]}" ]]; then
        EZA[_FUNCTIONS]="${fn_name}"
    elif [[ ",${EZA[_FUNCTIONS]}," != *",${fn_name},"* ]]; then
        EZA[_FUNCTIONS]="${EZA[_FUNCTIONS]},${fn_name}"
    fi
}
.eza_remember_fn .eza_remember_fn

.eza_define_alias() {
    local alias_name="${1}"
    local alias_value="${2}"

    alias ${alias_name}=${alias_value}

    if [[ -z "${EZA[_ALIASES]}" ]]; then
        EZA[_ALIASES]="${alias_name}"
    elif [[ ",${EZA[_ALIASES]}," != *",${alias_name},"* ]]; then
        EZA[_ALIASES]="${EZA[_ALIASES]},${alias_name}"
    fi
}
.eza_remember_fn .eza_remember_alias

############################################################################
# Plugin Unload Function
############################################################################

# See https://wiki.zshell.dev/community/zsh_plugin_standard#unload-function
eza_plugin_unload() {
    builtin emulate -L zsh

    # Remove all remembered functions.
    local plugin_fns
    IFS=',' read -r -A plugin_fns <<< "${EZA[_FUNCTIONS]}"
    local fn
    for fn in ${plugin_fns[@]}; do
        whence -w "${fn}" &> /dev/null && unfunction "${fn}"
    done
    
    # Remove all remembered aliases.
    local aliases
    IFS=',' read -r -A aliases <<< "${EZA[_ALIASES]}"
    local alias
    for alias in ${aliases[@]}; do
        unalias "${alias}"
    done

    # Remove the global data variable.
    unset EZA

    # Remove this function.
    unfunction eza_plugin_unload
}

############################################################################
# Plugin-defined Aliases
############################################################################

.eza_define_alias eza 'eza --color=auto'
.eza_define_alias ls 'eza'
.eza_define_alias l 'eza -lT -all --git --group-directories-first'
.eza_define_alias ll 'eza -l --all --git --group-directories-first'
.eza_define_alias lt 'eza -T --git --git-ignore --level=2 --group-directories-first'
.eza_define_alias llt 'eza -lT --git --git-ignore --level=2 --group-directories-first'

############################################################################
# Initialize Plugin
############################################################################

true
