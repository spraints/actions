FROM debian:stable-slim

RUN apt-get update && apt-get install -y ruby

RUN gem install octokit
RUN gem install tzinfo

COPY . /app/

ENTRYPOINT ["/app/entrypoint"]
