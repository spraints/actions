FROM ruby:latest

RUN gem install octokit
RUN gem install tzinfo

COPY entrypoint /entrpoint

ENTRYPOINT ["/entrypoint"]
