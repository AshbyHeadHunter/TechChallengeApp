#!/bin/sh

if [ ! -z "${DBHOST}" ]; then
    sed -i -e "s/^\"DbHost\".*/\"DbHost\" = \"${DBHOST}\"/" conf.toml
fi

if [ ! -z "${DBPORT}" ]; then
    sed -i -e "s/^\"DbPort\".*/\"DbPort\" = \"${DBPORT}\"/" conf.toml
fi

if [ ! -z "${DBNAME}" ]; then
    sed -i -e "s/^\"DbName\".*/\"DbName\" = \"${DBNAME}\"/" conf.toml
fi

if [ ! -z "${DBPASSWORD}" ]; then
    sed -i -e "s/^\"DbPassword\".*/\"DbPassword\" = \"${DBPASSWORD}\"/" conf.toml
fi

if [ ! -z "${DBUSER}" ]; then
    sed -i -e "s/^\"DbUser\".*/\"DbUser\" = \"${DBUSER}\"/" conf.toml
fi

cat config.toml

nc ${DBHOST} 5432 -vz

exec ./TechChallengeApp $@