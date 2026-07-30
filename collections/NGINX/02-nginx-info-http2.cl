# Official NGINX Plus live demo instance information over HTTP/2.
# Expected: 200 JSON containing version and build.
curl --http2 \
  --request "GET" \
  --url "https://demo.nginx.com/api/9/nginx?fields=version,build" \
  --header "Accept: application/json"
