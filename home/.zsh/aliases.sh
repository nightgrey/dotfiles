# Aliases for starting HAUSGOLD projects

# Kundenportal
alias start-kundenportal="make -C ~/Developer/env start-identity-api start-jabber start-analytic-api start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C ~/Developer/env/projects/verkaeuferportal-frontend start"

# Maklerportal
alias start-maklerportal="make -C ~/Developer/env start-identity-api start-jabber start-analytic-api start-gateway start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C ~/Developer/env/projects/maklerportal-frontend start"

# Maklerportal (next)
alias start-maklerportal-next="make -C ~/Developer/env start-identity-api start-jabber start-analytic-api start-gateway start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C ~/Developer/env/projects/maklerportal-next-frontend start"

# Lead Circle
alias start-leads-frontend="make -C ~/Developer/env start-message-bus start-identity-api start-preferences start-leads-api start-payment-api start-gateway && make -C ~/Developer/env/projects/leads-frontend start"

# Formwizard
alias start-formwizard="make -C ~/Developer/env start-formwizard-api && make -C ~/Developer/env/projects/formwizard-frontend start"

# Fix maklerportal-api/instrumentation
alias fix-maklerportal-api="cd ~/Developer/env/projects/maklerportal-api && touch app/controllers/application_controller.rb"

# Show `docker stats` total RAM usage
# Note: The command works when pasted into console, but not via alias, even with `"`. Why?
# alias docker-ram=docker stats --no-stream --format 'table {{.MemUsage}}' | sed 's/[A-Za-z]*//g' | awk '{sum += $1} END {print sum "MB"}'


# Quick commit
alias gqc="gaa && gc -m \"WIP [ci skip]\""
alias gqcp="gaa && gc -m \"WIP [ci skip]\" && gp"
alias gqcv="gaa && gc -m \"WIP [ci skip]\" --no-verify"

alias gac="gaa & git commit -m \"WIP\""
alias gacp="gaa && git commit -m \"WIP\" && gp"
