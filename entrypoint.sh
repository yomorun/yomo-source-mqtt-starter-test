#!/usr/bin/env sh

CMD=$1

case "$CMD" in
  "broker-flow" )
    npm install
    export NODE_ENV=development
    exec npm run dev
    ;;

  
esac