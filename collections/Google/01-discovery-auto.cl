# Google API Discovery Service using automatic protocol negotiation.
# Expected: 200 JSON response.
curl --request "GET" \
  --url "https://discovery.googleapis.com/discovery/v1/apis" \
  --header "Accept: application/json"
