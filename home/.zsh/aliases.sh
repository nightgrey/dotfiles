# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."


# HAUSGOLD: `env`
alias start-verkaeuferportal="make -C ~/Dev/env start-analytic-api start-asset-api start-identity-api start-maklerportal-api start-verkaeuferportal-api start-property-api && make -C ~/Dev/env/projects/verkaeuferportal-frontend start"
alias start-maklerportal="make -C ~/Dev/env start-identity-api start-asset-api start-maklerportal-api start-property-api && make -C ~/Dev/env/projects/maklerportal-frontend start"
alias start-verkaeuferportal-maklerportal="make -C ~/Dev/env start-analytic-api start-identity-api start-asset-api start-maklerportal-api start-verkaeuferportal-api start-maklerportal-frontend start-property-api && make -C ~/Dev/env/projects/verkaeuferportal-frontend start"
alias formizward="make -C ~/Dev/env start-formwizard-api && make -C ~/Dev/env/projects/formwizard-frontend start"

# Unused / old
#alias formwizard="make -C ~/Dev/env start-message-bus start-notification-distributor-processor start-notification-distributor-connector-kafka start-crm"
#alias mpvp="make -C ~/Dev/env start-analytic-api start-identity-api start-asset-api start-maklerportal-api start-verkaeuferportal-api start-verkaeuferportal-frontend start-property-api && make -C ~/Dev/env/projects/maklerportal-frontend start"


# zsh
alias reload="source ~/.zshrc"