# Official NGINX Plus live demo API root.
# Expected: 200 JSON list of available API root points.
curl --request "GET" \
  --url "https://demo.nginx.com/api/9/" \
  --header "Accept: application/json"
