alias la="ls -la"

# Back-cd's
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Starting things via the `env` project
alias start-verkaeuferportal="make -C ~/Dev/env/.macos start && make -C ~/Dev/env start-analytic-api start-asset-api start-identity-api start-maklerportal-api start-verkaeuferportal-api start-property-api && make -C ~/Dev/env/projects/verkaeuferportal-frontend start"
alias start-maklerportal="make -C ~/Dev/env/.macos start && make -C ~/Dev/env start-identity-api start-asset-api start-maklerportal-api start-property-api && make -C ~/Dev/env/projects/maklerportal-frontend start"
alias start-verkaeuferportal-maklerportal="make -C ~/Dev/env/.macos start && make -C ~/Dev/env start-analytic-api start-identity-api start-asset-api start-maklerportal-api start-verkaeuferportal-api start-maklerportal-frontend start-property-api && make -C ~/Dev/env/projects/verkaeuferportal-frontend start"
#alias mpvp="make -C ~/Dev/env start-analytic-api start-identity-api start-asset-api start-maklerportal-api start-verkaeuferportal-api start-verkaeuferportal-frontend start-property-api && make -C ~/Dev/env/projects/maklerportal-frontend start"
#alias formwizard="make -C ~/Dev/env start-message-bus start-notification-distributor-processor start-notification-distributor-connector-kafka start-crm && make -C ~/Dev/env/projects/formwizard start"