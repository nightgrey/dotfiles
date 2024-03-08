# Force `npm-check` to use npm
# The reason is that it often chooses to use `yarn`, for whatever reason.
# See https://github.com/dylang/npm-check/issues/515
#
# Hopefully this won't bite me in the future after I forgot I set this.
NPM_CHECK_INSTALLER=npm
