# Official NGINX Plus live demo HTTP request metrics over HTTP/2.
# Expected: 200 JSON request counters.
curl --http2 \
  --request "GET" \
  --url "https://demo.nginx.com/api/9/http/requests" \
  --header "Accept: application/json"
