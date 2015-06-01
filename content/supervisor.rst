Supervisor.
###########

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: supervisor
:category: Tips
:authors: zdimon77@gmail.con


sudo apt-get install supervisor




sudo nano /etc/supervisor/conf.d/webserver.conf


[program:courses_webserver]
command=/home/zdimon/co_ve/co/manage.py runserver 0.0.0.0:8888
directory=/home/zdimon/co_ve/co
environment=PATH="/home/zdimon/co_ve/bin"
user=zdimon
autostart=true
autorestart=true

sudo nano /etc/supervisor/conf.d/celeryd.conf


[program:courses_celeryd]
command=/home/zdimon/co_ve/co/manage.py celeryd
directory=/home/zdimon/co_ve/co
environment=PATH="/home/zdimon/co_ve/bin"
user=zdimon
autostart=true
autorestart=true


sudo nano /etc/supervisor/conf.d/socketserver.conf

[program:courses_socketserver]
command=/home/zdimon/co_ve/co/manage.py socketserver
directory=/home/zdimon/co_ve/co
environment=PATH="/home/zdimon/co_ve/bin"
user=zdimon
autostart=true
autorestart=true


To see process

supervisorctl avail - показать список все процессов, контролируемых supervisord, и их состояние (активен, остановлен, ошибка)




