#!/bin/bas"h

IMAGE="danieldent/docker-postgres-replication"
PGPASSWORD="admin123"

MASTER="postgres"
SLAVE="postgres-replicas"

KUBECMD="kubectl run pclient --image="$IMAGE" -i -t --rm --restart=Never --env="PGPASSWORD=$PGPASSWORD" --"
PSQL="psql -U postgres"

_header() {
    echo "\033[1;31m$@\033[0m"
}

echo
_header "INFO: you can run psql by using once off container through kubectl as well."
_header "For master:"
echo "$KUBECMD $PSQL -h $MASTER"
_header "For replicas (read-only):"
echo "$KUBECMD $PSQL -h $SLAVE"
echo
echo

_header "TEST: Is Master up?"
$KUBECMD $PSQL -h $MASTER -c "SELECT inet_server_addr();"

_header "TEST: Is Slave(s) up? The replicas should be randomly selected."
$KUBECMD $PSQL -h $SLAVE -c "SELECT inet_server_addr();"
$KUBECMD $PSQL -h $SLAVE -c "SELECT inet_server_addr();"
$KUBECMD $PSQL -h $SLAVE -c "SELECT inet_server_addr();"


_header "CREATING DATABASE TO TEST"
echo "Checking testdb exists"
if $KUBECMD $PSQL -h $MASTER -lqt | cut -d '|' -f 1 | grep -qw testdb; then
    echo "testdb exists, delete it first"
    $KUBECMD $PSQL -h $MASTER -c "DROP DATABASE testdb;"
fi
echo "Making testdb, mytable and adding some values"
$KUBECMD $PSQL -h $MASTER -c "CREATE DATABASE testdb;"
$KUBECMD $PSQL -h $MASTER testdb -c "CREATE TABLE mytable (id INT);"
$KUBECMD $PSQL -h $MASTER testdb -c "INSERT INTO mytable(id) VALUES(1);"
$KUBECMD $PSQL -h $MASTER testdb -c "INSERT INTO mytable(id) VALUES(2);"
$KUBECMD $PSQL -h $MASTER testdb -c "INSERT INTO mytable(id) VALUES(3);"


echo
_header "TEST: Ask replicas to return mytable data."

$KUBECMD $PSQL -h $SLAVE testdb -c "SELECT * FROM mytable;"
