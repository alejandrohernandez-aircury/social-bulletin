#!/bin/sh
set -e

# Serialise installs/builds across containers sharing the bind mount: the
# node service and `make build` may run this entrypoint concurrently.
(
    flock 9

    if [ -f /app/apps/web/package.json ] && [ ! -d /app/apps/web/node_modules ]; then
        echo "Installing web npm dependencies..."
        npm install --prefix /app/apps/web
    fi

    if [ -f /app/apps/web/package.json ] && [ ! -f /app/apps/web/dist/index.html ]; then
        echo "Building web frontend..."
        npm run build --prefix /app/apps/web
    fi
) 9>/app/apps/web/.install.lock

exec "$@"
