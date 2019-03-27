FROM debian:stable-slim

# these don't work
RUN sed -i '/updates/d' /etc/apt/sources.list

RUN apt-get update && apt-get install -y ruby

RUN gem install octokit
RUN gem install tzinfo

COPY . /app/

ENTRYPOINT ["/app/entrypoint"]
