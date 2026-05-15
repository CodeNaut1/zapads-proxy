#!/bin/bash

# Write config from environment variables
cat > /root/.zapads-proxy/config.yaml <<EOF
listen: ":${PORT:-8081}"

zapads:
  provider_id: "zapads-proxy"
  api_key: "${ZAPADS_PROVIDER_KEY}"
  log_invocation_url: "https://cvzwwewiccoxklysudtd.functions.supabase.co/log-invocation"
  l402_root_secret: "${L402_ROOT_SECRET}"

lightning:
  backend: blink
  url: "https://api.blink.sv/graphql"
  api_key: "${BLINK_API_KEY}"

services:
  - name: "btc-tools-directory-v2"
    backend: "https://btc-tools-api.onrender.com"
    paths:
      - pattern: "/tools"
        price_sats: 10
        macaroon_cap: 100
        expiry_seconds: 3600
    use_hold_invoice: false
EOF

echo "Config written. Starting zapads-proxy on port ${PORT:-8081}..."
exec zapads-proxy --config /root/.zapads-proxy/config.yaml
