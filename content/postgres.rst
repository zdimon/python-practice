Postgres.
#########

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: postgres
:category: Tips
:authors: zdimon77@gmail.con

sudo apt-get install postgresql


В боевой системе, где БД будет располагаться на отдельном сервере, требуется указать, на каком интерфейсе принимать соединения (по умолчанию, Postgres слушает только 127.0.0.1).
Для этого, в файле /etc/postgresql/9.1/main/postgresql.conf добавить строку:
listen_addresses = '*'

Также можно оптимизировать настройки производительности (в этом же файле), но, надо иметь в виду, что это потребуется от системы соответствующих объёмов ОЗУ:
# 512MB would be nice, but Ubuntu 12.04 LTS
# does not support shared_buffers > 16MB

shared_buffers = 16MB
work_mem = 4MB
maintenance_work_mem = 128MB

В файле /etc/postgresql/9.1/main/pg_hba.conf добавить строку:
host	all         	all         	10.10.100.0/24      	md5
Перезагрузить Postgres:
sudo service postgresql restart

Как в боевой, так и в тестовой системе, требуется задать пароль для юзера postgres:
sudo -u postgres psql postgres
затем:
\password postgres

Также, требуется настроить роль для юзера django, под которым будет работать серверный софт, и задать её пароль:
CREATE ROLE django WITH LOGIN;
\password django


Создать основную БД в postgresql с помощью pgadmin, либо из консоли:
sudo -u postgres createdb <имя-базы>




Бэкапирование и восстановление БД PostgerSQL, а также перенос её на другой сервер
---------------------------------------------------------------------------------


Бэкап БД создаётся штатными средствами PostgreSQL:

sudo -u postgres pg_dump -F custom pressa > backup-filename.dump

Восстановление бэкапа:
----------------------

sudo -u postgres dropdb pressa
sudo -u postgres createdb pressa
sudo -u postgres pg_restore -d pressa backup-filename.dump


Установка

apt-get install libpq-dev

sudo pip install psycopg2

apt-get install build-essential postgresql postgresql-contrib

creating cluster
pg_createcluster 9.3 main --start


sudo nano /etc/postgresql/9.3/main/pg_hba.conf


host all all 0.0.0.0/0 trust


sudo nano /etc/postgresql/9.3/main/postgresql.conf
listen_addresses = '*'

Change password to postgres user
passwd postgres
sudo -s -u postgres
psql
\password postgres


Restart server
service postgresql restart

