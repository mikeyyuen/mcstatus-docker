#!/bin/bash

SERVER=${1}
if [[ -z ${SERVER} ]]
then
  echo "Usage: ./status-loop.sh <server>"
  echo
  echo " e.g. ./status-loop.sh test.com:1234"
  echo "or    ./status-loop.sh test.com"

  exit 1
fi


TMPDIR="${TMPDIR:-/tmp}"
STATUS_FILE="$(mktemp ${TMPDIR}/mcstatus_out.XXXXX)"
STATUS_LAST=

while true
do
  DATE="$(date)"
  STATUS_NEXT="server down"
  if docker run -t --rm mikeyyuen/mcstatus ${SERVER} status > ${STATUS_FILE} 
  then
    STATUS_NEXT="$(grep "^players:" ${STATUS_FILE})"
  fi

  if [[ "${STATUS_NEXT}" != "${STATUS_LAST}" ]]
  then
    echo "${DATE} - ${STATUS_NEXT}"
    STATUS_LAST="${STATUS_NEXT}"
  fi

  sleep 60
done
