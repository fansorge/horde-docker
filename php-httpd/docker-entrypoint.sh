#!/bin/sh
#
# Docker entrypoint script to change UID/GID of Debian/Ubuntu Apache
#
set -eu

[ "${DEBUG:-}" = 'yes' ] && set -x

[ -n "${APACHE_GID:-}" ] && {
  groupmod --gid $APACHE_GID www-data
}

[ -n "${APACHE_UID:-}" ] && {
  usermod --uid $APACHE_UID www-data
}
exec "$@"

