# Google Service Usage discovery document over HTTP/2.
# Expected: 200 JSON discovery document.
curl --http2 \
  --request "GET" \
  --url "https://serviceusage.googleapis.com/$discovery/rest?version=v1" \
  --header "Accept: application/json"
