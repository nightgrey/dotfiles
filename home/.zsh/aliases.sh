# Aliases for starting HAUSGOLD projects

# Kundenportal
alias env-vp1="make -C ~/Developer/env start-identity-api start-jabber"
alias env-vp2="make -C ~/Developer/env start-analytic-api start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C ~/Developer/env/projects/verkaeuferportal-frontend start"

# Maklerportal
alias env-mp1="make -C ~/Developer/env start-identity-api start-jabber"
alias env-mp2="make -C ~/Developer/env start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api && make -C ~/Developer/env/projects/maklerportal-frontend start"

# Formwizard
alias env-fw="make -C ~/Developer/env start-formwizard-api && make -C ~/Developer/env/projects/formwizard-frontend start"

# Fix maklerportal-api/instrumentation
alias fix-mpapi="cd ~/Developer/env/projects/maklerportal-api && touch app/controllers/application_controller.rb"
