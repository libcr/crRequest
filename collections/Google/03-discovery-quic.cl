# Google API Discovery Service over strict QUIC/HTTP3.
# Expected: 200 JSON response; negotiated protocol should be h3.
curl --http3-only \
  --request "GET" \
  --url "https://discovery.googleapis.com/discovery/v1/apis" \
  --header "Accept: application/json"
