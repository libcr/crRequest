# Facebook Graph API error-response test without an access token.
# Expected: 400 JSON OAuth error over HTTP/2.
curl --http2 \
  --request "GET" \
  --url "https://graph.facebook.com/" \
  --header "Accept: application/json"
