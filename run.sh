#!/bin/bash

CONFIG_TEMPLATE="/owfs.templ"
CONFIG_FILE="/etc/owfs.conf"

echo "=> Setting up config ..."
if [[ -z $OWSERVER ]]; then
 echo "Missing parameters! You must set either of OWSERVER as environment variables." 1>&2
 exit 1
fi

cp -f $CONFIG_TEMPLATE $CONFIG_FILE

# use OWSERVER devices
if [ -n "$OWSERVER" ]; then
    echo "HTTPD: Using OWSERVER address: ${OWSERVER}"
    # http: server=${OWSERVER}:4304
    sed -i -r -e "s|#\[\[OWSERVER\]\]|http: server=${OWSERVER}:4304|" ${CONFIG_FILE}
fi

echo "Using ${CONFIG_FILE}"
cat ${CONFIG_FILE}
echo ""

echo "=> Starting owhttpd ..."
exec owhttpd -c $CONFIG_FILE --foreground --error_level=3
