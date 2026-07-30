# Facebook Graph API over strict QUIC/HTTP3.
# Expected: 200 JSON response; negotiated protocol should be h3.
curl --http3-only \
  --request "GET" \
  --url "https://graph.facebook.com/facebook/picture?redirect=false" \
  --header "Accept: application/json"
