#!/bin/bash
set -e
# Start server
/opt/mssql/bin/sqlservr &

MSSQL_PID=$!

SQLCMD_PATH_NEW=/opt/mssql-tools18/bin/sqlcmd
SQLCMD_PATH_OLD=/opt/mssql-tools/bin/sqlcmd

echo "Detecting SQL Server version..."

if [ -f "$SQLCMD_PATH_NEW" ]; then
    MAJOR_VERSION=$($SQLCMD_PATH_NEW -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -h -1 -C -Q "SET NOCOUNT ON; SELECT SERVERPROPERTY('ProductMajorVersion');" 2>/dev/null | tr -d '\r\n[:space:]' | sed 's/[^0-9]*//g' || echo "")
fi

if [ -z "$MAJOR_VERSION" ] && [ -f "$SQLCMD_PATH_OLD" ]; then
    MAJOR_VERSION=$($SQLCMD_PATH_OLD -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -h -1 -Q "SET NOCOUNT ON; SELECT SERVERPROPERTY('ProductMajorVersion');" 2>/dev/null | tr -d '\r\n[:space:]' | sed 's/[^0-9]*//g' || echo "")
fi

echo "SQL Server major version: $MAJOR_VERSION"

# Wait until server starts
echo "Waiting for SQL Server to start..."

if [[ "$MAJOR_VERSION" -ge 15 ]]; then
    SQLCMD_PATH=$SQLCMD_PATH_NEW
    CERT_PARAM="-C"
elif [[ "$MAJOR_VERSION" -le 14 ]]; then
    SQLCMD_PATH=$SQLCMD_PATH_OLD
    CERT_PARAM=""
else
    echo "Cannot detect the SQL Server path"
fi

until $SQLCMD_PATH -S localhost -U sa -P "$MSSQL_SA_PASSWORD" $CERT_PARAM -Q "SELECT 1;" &> /dev/null
do
  echo "SQL Server is starting up... "
  sleep 5
done
echo "SQL Server started successfully"

# Running SQL-scripts
echo "Start script create-All-$MAJOR_VERSION.sql"
if [ -f "/scripts/create-All-$MAJOR_VERSION.sql" ]; then
     $SQLCMD_PATH -S localhost -U sa -P "$MSSQL_SA_PASSWORD" $CERT_PARAM -i "/scripts/create-All-$MAJOR_VERSION.sql"
   else
     echo "Warning: Script /scripts/create-All-$MAJOR_VERSION.sql not found"
fi

check_table_exists() {
    echo "Checking table Zoo.Basic_01_Table in database Menagerie..."

    if $SQLCMD_PATH -S localhost -U sa -P "$MSSQL_SA_PASSWORD" $CERT_PARAM -d Menagerie -Q "SELECT COUNT(*) FROM Zoo.Basic_01_Table;" &> /dev/null; then
            echo "✓ Table Zoo.Basic_01_Table exists"
            return 0
    else
        echo "✗ Table Zoo.Basic_01_Table does not exist"
        return 1
    fi
}

if check_table_exists; then
    echo "Table verification passed"
else
    echo "Warning: Table verification failed"
fi

check_user() {
    echo "Checking Curator user..."
    if $SQLCMD_PATH -S localhost -U sa -P "$MSSQL_SA_PASSWORD" $CERT_PARAM -Q "SELECT name FROM sys.server_principals WHERE name = 'Curator';" | grep -i "curator" > /dev/null; then
        echo "✓ User 'Curator' exists"
        return 0
    else
        echo "✗ User 'Curator' does not exist"
        return 1
    fi
}

if check_user; then
    echo "Curator user verification passed"
else
    echo "Warning: Curator user verification failed"
fi

# Waiting for the main process
wait $MSSQL_PID
