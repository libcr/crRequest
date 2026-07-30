# Negative protocol test: the NGINX demo currently does not advertise HTTP/3.
# Expected: strict QUIC connection failure with no TCP fallback.
curl --http3-only \
  --request "GET" \
  --url "https://demo.nginx.com/api/9/" \
  --header "Accept: application/json"
