#!/bin/sh
set -e

if [ -f /app/apps/web/package.json ] && [ ! -d /app/apps/web/node_modules ]; then
    echo "Installing web npm dependencies..."
    npm install --prefix /app/apps/web
fi

if [ -f /app/apps/web/package.json ] && [ ! -f /app/apps/web/dist/index.html ]; then
    echo "Building web frontend..."
    npm run build --prefix /app/apps/web
fi

exec "$@"
