#!/bin/bash
echo "Starting MySQL"
/entrypoint.sh mysqld &
until mysqladmin -hlocalhost -P3306 -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" processlist &> /dev/null; do
	echo "MySQL still not ready, sleeping"
	sleep 5
done

echo "Starting platform"
cd mattermost
ls -al 

if [ -f "config/config_docker.json" ]; then
  echo "No config found, install default config ..."
  cp default/config_docker.json config/config_docker.json
fi

exec ./bin/platform --config=config/config_docker.json