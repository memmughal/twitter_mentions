#!/bin/sh

if [[ "$*" = *"--help"* ]] || [[ "$*" = *"-h"* ]]; then
  echo "Runs bash in the docker container, this command has no defaults set"
  echo "All arguments are required and order is important <SCREEN_NAME> <CONSUMER_KEY> <CONSUMER_SECRET> <ACCESS_TOKEN> <ACCESS_TOKEN_SECRET>"
  echo
  echo "usage: $0 [<SCREEN_NAME> <CONSUMER_KEY> <CONSUMER_SECRET> <ACCESS_TOKEN> <ACCESS_TOKEN_SECRET>]"
  echo
  echo "  > $0 @josevalim xxxxx xxxxx xxxxx xxxxx"
  echo "  docker-compose run -e SCREEN_NAME=@josevalim -e CONSUMER_KEY=xxxxx -e CONSUMER_SECRET=xxxxx -e ACCESS_TOKEN=xxxxx -e ACCESS_TOKEN_SECRET=xxxxx --rm application init migrate bash"
  echo "  ..."

  exit 0
fi

echo "!docker-compose run -e SCREEN_NAME=$1 -e CONSUMER_KEY=$2 -e CONSUMER_SECRET=$3 -e ACCESS_TOKEN=$4 -e ACCESS_TOKEN_SECRET=$5 --rm application init migrate bash"
docker-compose run -e SCREEN_NAME=$1 -e CONSUMER_KEY=$2 -e CONSUMER_SECRET=$3 -e ACCESS_TOKEN=$4 -e ACCESS_TOKEN_SECRET=$5 --rm application init migrate bash
