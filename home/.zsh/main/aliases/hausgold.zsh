# Aliases for starting work projects
HAUSGOLD_ENV="$HOME/Developer/hausgold/env"

# Kundenportal
alias start-kundenportal="make -C $HAUSGOLD_ENV start-identity-api start-jabber start-analytic-api start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C $HAUSGOLD_ENV/projects/verkaeuferportal-frontend start"

# Maklerportal
alias start-maklerportal="make -C $HAUSGOLD_ENV start-identity-api start-jabber start-analytic-api start-gateway start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C $HAUSGOLD_ENV/projects/maklerportal-frontend start"

# Maklerportal (next)
alias start-maklerportal-next="make -C $HAUSGOLD_ENV start-identity-api start-jabber start-analytic-api start-gateway start-asset-api start-property-api start-calendar-api start-preferences start-dossiers-proxy start-maklerportal-api start-verkaeuferportal-api && make -C $HAUSGOLD_ENV/projects/maklerportal-next-frontend start"
alias start-maklerportal-next-light="make -C $HAUSGOLD_ENV start-identity-api start-gateway start-asset-api start-property-api start-preferences start-maklerportal-api start-verkaeuferportal-api && make -C $HAUSGOLD_ENV/projects/maklerportal-next-frontend start"

# Lead Circle
alias start-leads-frontend="make -C $HAUSGOLD_ENV start-message-bus start-identity-api start-preferences start-leads-api start-payment-api start-gateway && make -C $HAUSGOLD_ENV/projects/leads-frontend start"

# Formwizard
alias start-formwizard="make -C $HAUSGOLD_ENV start-formwizard-api && make -C $HAUSGOLD_ENV/projects/formwizard-frontend start"

# Fix maklerportal-api/instrumentation
alias fix-maklerportal-api="cd $HAUSGOLD_ENV/projects/maklerportal-api && touch app/controllers/application_controller.rb"
