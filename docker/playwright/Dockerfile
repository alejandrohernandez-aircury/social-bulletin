# Pinned to the @playwright/test version in apps/web/package.json.
FROM mcr.microsoft.com/playwright:v1.61.1-noble

# ADR-0015: DSLR restores the database snapshot before each scenario;
# libnss3-tools (certutil) lets the entrypoint trust the mkcert root CA.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python3-pip \
        libnss3-tools \
    && pip3 install --break-system-packages --no-cache-dir psycopg2-binary DSLR \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/playwright-entrypoint.sh
RUN chmod +x /usr/local/bin/playwright-entrypoint.sh

WORKDIR /app/apps/web

ENTRYPOINT ["playwright-entrypoint.sh"]
CMD ["npx", "playwright", "test"]
