# postgresql.sh

function createdb-if-needed {
    for dbname in $@; do
        $(psql -l | grep -q "$dbname") || createdb "$dbname"
    done
}

function dropdb-if-needed {
    for dbname in $@; do
        $(psql -l | grep -q "$dbname") && dropdb "$dbname"
    done
}

if [ ! -e ~/.setup/postgresql ]; then
    apt-get install postgresql-9.5 postgresql-contrib-9.5 \
        postgresql-doc-9.5 postgresql-server-dev-9.5

    su - postgres createuser --superuser $USER &> /dev/null
    su - postgres createdb $USER &> /dev/null

    touch ~/.setup/postgresql
fi

