#!/bin/bash
set -e

main() {
  docker stop $(docker ps -q)
}


main "$@"

