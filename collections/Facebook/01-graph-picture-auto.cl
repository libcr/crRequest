# Facebook Graph API: public Page profile picture metadata.
# Expected: 200 JSON response.
curl --request "GET" \
  --url "https://graph.facebook.com/facebook/picture?redirect=false" \
  --header "Accept: application/json"
