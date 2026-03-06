# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Plugin Name: eza
# Description: Simple plugin to set up aliases for the `eza` command, a modern replacement for `ls`.
# Repository: https://github.com/johnstonskj/zsh-eza-plugin
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
