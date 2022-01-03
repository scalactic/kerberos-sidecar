#!/usr/bin/env bash

echo "Kerberos sidecar container is started at $(date)."

cp /krb5.conf "$VOLUME"

while true; do
  echo "*** Trying to kinit at $(date). ***"
  kinit -kt "$SECRETS/$KEYTAB" "$PRINCIPAL"

  result=$?
  if [ "$result" -eq 0]; then
    echo "kinit is successfull. Sleeping for $REKINIT_PERIOD seconds."
  else
    echo "kinit is exited with error. result code: $result"
    exit 1
  fi

  sleep "$REKINIT_PERIOD"
done
