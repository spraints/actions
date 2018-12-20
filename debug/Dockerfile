FROM debian:buster-slim

COPY . /my-stuff
RUN find /my-stuff -ls

ENTRYPOINT ["/my-stuff/entrypoint.sh"]
