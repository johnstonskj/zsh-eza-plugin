# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# @name: eza
# @brief: Set aliases for the `eza` command, a modern replacement for `ls`.
# @repository: https://github.com/johnstonskj/zsh-eza-plugin
# @version: 0.1.1
# @license: MIT AND Apache-2.0
#

############################################################################
# @section Aliases
# @description Useful aliases for eza.
#

@zplugins_define_alias eza eza 'eza --color=auto'
@zplugins_define_alias eza ls 'eza'
@zplugins_define_alias eza l 'eza -lT -all --git --group-directories-first'
@zplugins_define_alias eza ll 'eza -l --all --git --group-directories-first'
@zplugins_define_alias eza lt 'eza -T --git --git-ignore --level=2 --group-directories-first'
@zplugins_define_alias eza llt 'eza -lT --git --git-ignore --level=2 --group-directories-first'
