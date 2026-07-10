#!/bin/sh
set -e

# Trust the mkcert root CA: system store for Node, NSS store for Chromium.
if [ -f /certs/rootCA.pem ]; then
    cp /certs/rootCA.pem /usr/local/share/ca-certificates/mkcert-root-ca.crt
    update-ca-certificates > /dev/null 2>&1

    mkdir -p "$HOME/.pki/nssdb"
    certutil -d sql:"$HOME/.pki/nssdb" -N --empty-password 2>/dev/null || true
    certutil -d sql:"$HOME/.pki/nssdb" -A -t "C,," -n mkcert-root-ca -i /certs/rootCA.pem
fi

exec "$@"
