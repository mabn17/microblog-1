#!/bin/sh
source /home/microblog/venv/bin/activate
while true; do
    flask db upgrade
    if [[ "$?" == "0" ]]; then
        break
    fi
    echo Upgrade command failed, retrying in 5 secs...
    sleep 5
done
flask translate compile
#exec gunicorn -b :5000 --access-logfile - --error-logfile - microblog:app
exec gunicorn --statsd-host=localhost:9125 --statsd-prefix=helloworld --bind 127.0.0.1::5000 microblog:app