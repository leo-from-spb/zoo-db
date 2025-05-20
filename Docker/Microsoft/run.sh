#!/bin/bash

ZOO_HOME=/opt/mssql-tools18/bin
SCRIPTS=/tmp/scripts
#SCRIPTS="$1"

# Check whether parameter has been passed on
if [ -z "$SCRIPTS" ]; then
   echo "$0: No SCRIPTS passed on, no scripts will be run"
   exit 1
fi

# Execute custom provided files (only if directory exists and has files in it)
if [ -d "$SCRIPTS" ] && [ -n "$(ls -A "$SCRIPTS")" ]; then

  echo ""
  echo "Executing user defined scripts"

  for f in "$SCRIPTS"/*; do
      case "$f" in
          *.sql)
              echo "$0: running $f"
              echo "exit" | "$ZOO_HOME/sqlcmd" -U SA -P $MSSQL_SA_PASSWORD -d master -N -C -i "$f"
              echo
              ;;
          *)
              echo "$0: ignoring $f"
              ;;
      esac
      echo ""
  done

  echo "DONE"
  echo ""

fi
