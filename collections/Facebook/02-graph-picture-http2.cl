# Facebook Graph API over HTTP/2.
# Expected: 200 JSON response; negotiated protocol should be h2.
curl --http2 \
  --request "GET" \
  --url "https://graph.facebook.com/facebook/picture?redirect=false" \
  --header "Accept: application/json"
