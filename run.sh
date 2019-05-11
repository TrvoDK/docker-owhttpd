#!/bin/bash

CONFIG_TEMPLATE="/owfs.templ"
CONFIG_FILE="/etc/owfs.conf"

echo "=> Setting up config ..."
if [[ -z $OWSERVER ]]; then
 echo "Missing parameters! You must set either of OWSERVER as environment variables." 1>&2
 exit 1
fi

cp -f $CONFIG_TEMPLATE $CONFIG_FILE

# use FAKE devices
if [ -n "$OWSERVER" ]; then
    echo "Using OWSERVER address: ${OWSERVER}"
    # ! server: server=${OWSERVER}:4304
    sed -i -r -e "s|#\[\[OWSERVER\]\]|! server: server=${OWSERVER}:4304|" ${CONFIG_FILE}
fi

echo "=> Starting owhttpd ..."
exec owhttpd -c $CONFIG_FILE --foreground --error_level=1
