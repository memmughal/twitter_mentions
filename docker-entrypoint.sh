#!/bin/bash

set -e

for var in "${@}"
do
    case "${var}" in
        start|init|migrate|test|bash)
            ;;
        *)
            printf "Unknown option: %s\n" "${var}" >&2
            exit 1
            ;;
    esac
done

for var in "$@"
do
    case "$var" in

        "start")
            echo "Starting"
            ;;

        "init")
            echo "Initializing"
            mix deps.get
            mix do ecto.drop
            mix do ecto.create
            ;;

        "migrate")
            echo "Migrating database"
            mix ecto.migrate
            ;;

        "test")
            echo "Running tests"
            mix test
            ;;

        "bash")
            echo "Running shell"
            bash
            ;;
    esac

done

exit $?