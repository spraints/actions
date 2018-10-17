FROM alpine

LABEL "name"="Download and Verify a file"
LABEL "maintainer"="Matt Burke <spraints@gmail.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Download and verify a file"
LABEL "com.github.actions.description"="Downloads a file and verifies its sha256 checksum."
LABEL "com.github.actions.icon"="download"
LABEL "com.github.actions.color"="green"

RUN apk add curl
RUN apk add bash
COPY . dl
ENTRYPOINT ["/dl/start"]
