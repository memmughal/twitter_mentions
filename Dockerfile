FROM bitwalker/alpine-elixir:1.7 as build

# Install hex, rebar
RUN mix local.hex --force && \
    mix local.rebar --force

ADD . /src
WORKDIR /src

ENTRYPOINT ["/src/docker-entrypoint.sh"]
CMD ["start"]
