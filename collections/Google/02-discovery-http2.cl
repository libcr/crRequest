# Google API Discovery Service over HTTP/2.
# Expected: 200 JSON response; negotiated protocol should be h2.
curl --http2 \
  --request "GET" \
  --url "https://discovery.googleapis.com/discovery/v1/apis" \
  --header "Accept: application/json"
