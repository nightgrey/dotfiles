# Aliases for starting work projects

# Kundenportal
alias start-kundenportal="make -C ~/Developer/env start-identity-api start-jabber start-analytic-api start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C ~/Developer/env/projects/verkaeuferportal-frontend start"

# Maklerportal
alias start-maklerportal="make -C ~/Developer/env start-identity-api start-jabber start-analytic-api start-gateway start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C ~/Developer/env/projects/maklerportal-frontend start"

# Maklerportal (next)
alias start-maklerportal-next="make -C ~/Developer/env start-identity-api start-jabber start-analytic-api start-gateway start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C ~/Developer/env/projects/maklerportal-next-frontend start"
alias start-maklerportal-next-light="make -C ~/Developer/env start-identity-api start-gateway start-asset-api start-property-api start-preferences start-maklerportal-api start-verkaeuferportal-api && make -C ~/Developer/env/projects/maklerportal-next-frontend start"

# Lead Circle
alias start-leads-frontend="make -C ~/Developer/env start-message-bus start-identity-api start-preferences start-leads-api start-payment-api start-gateway && make -C ~/Developer/env/projects/leads-frontend start"

# Formwizard
alias start-formwizard="make -C ~/Developer/env start-formwizard-api && make -C ~/Developer/env/projects/formwizard-frontend start"

# Fix maklerportal-api/instrumentation
alias fix-maklerportal-api="cd ~/Developer/env/projects/maklerportal-api && touch app/controllers/application_controller.rb"

# Show `docker stats` total RAM usage
# Note: The command works when pasted into console, but not via alias, even with `"`. Why?
# alias docker-ram=docker stats --no-stream --format 'table {{.MemUsage}}' | sed 's/[A-Za-z]*//g' | awk '{sum += $1} END {print sum "MB"}'

# Dolphin
alias open="dolphin"
alias here="dolphin ."

# Navigation
alias ..="cd .."
alias ...="cd ..."
alias ....="cd ...."
alias .....="cd ....."
alias ......="cd ......"
alias .......="cd ......."
alias ........="cd ........"
alias .........="cd ........."
alias ..........="cd .........."

# Quick commit
alias gqc="gaa && gc -m \"WIP [ci skip]\""
alias gqcp="gaa && gc -m \"WIP [ci skip]\" && gp"
alias gqcv="gaa && gc -m \"WIP [ci skip]\" --no-verify"

alias gac="gaa & git commit -m \"WIP\""
alias gacp="gaa && git commit -m \"WIP\" && gp"

# Reload
alias reload="source ~/.zshrc"

# Search
alias findFile="find ./ -type f -name"

# pacman
# https://wiki.archlinux.org/title/pacman/Tips_and_tricks

# List *all* installed packages by size
alias pacman-sizes-all="LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h"
# List installed packages (not in the meta package base nor package group base-devel)  by size
#alias pacman-sizes="expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <({ pacman -Qqg base-devel; expac -l '\n' '%E' base; } | sort -u)) | sort -n"

# Browse all installed packages with detailed info
alias pacman-browse="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

# Remove all orphans and their configuration files
alias pacman-clean="pacman -Qtdq | pacman -Rns -"
