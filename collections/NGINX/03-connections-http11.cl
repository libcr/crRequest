# Official NGINX Plus live demo connection metrics over HTTP/1.1.
# Expected: 200 JSON connection counters.
curl --http1.1 \
  --request "GET" \
  --url "https://demo.nginx.com/api/9/connections" \
  --header "Accept: application/json"
