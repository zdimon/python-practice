Установка и сборка nginx.
#########################

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: nginx
:category: Разное
:authors: zdimon77@gmail.con

Забираем ключик.

.. code-block:: bash

    mkdir nginx_source
    cd nginx_source
    wget http://nginx.org/keys/nginx_signing.key

Импортируем его в сисему.

.. code-block:: bash

    sudo apt-key add nginx_signing.key

Добавим репу.


.. code-block:: bash

    sudo nano /etc/apt/sources.list

В конец файла.

.. code-block:: bash

    deb http://nginx.org/packages/ubuntu/ trusty nginx
    deb-src http://nginx.org/packages/ubuntu/ trusty nginx

Получаем исходники.

.. code-block:: bash

    sudo apt-get update
    sudo apt-get source nginx_signing

Download rtmp module.

    git clone https://github.com/arut/nginx-rtmp-module.git


Install pcre3 and others.

    sudo apt-get install libpcre3 libpcre3-dev libssl-dev libxml2-dev libxslt-dev



Сompille.

.. code-block:: bash

    cd nginx-1.6.2
    sudo ./configure --with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_addition_module --with-http_dav_module --with-http_gzip_static_module --with-http_spdy_module --with-http_sub_module --with-http_xslt_module --with-mail --with-mail_ssl_module --add-module=../nginx-rtmp-module

    sudo make


Copy binary file to system folder

.. code-block:: python

    cp obj/nginx usr/sbin


    sudo nano /etc/nginx/sites-available/default


   upstream chatserver {
        server 127.0.0.1:9999;
    }


.. code-block:: python

    server {
            # Requires root access.
            listen       80;
            server_name socket.course.localhost;

            # WebSocket.
            location /echo/info {
                proxy_pass http://chatserver;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
            }

            location / {
                proxy_pass http://chatserver;
            }

          
        }

      sudo nano /etc/nginx/nginx.conf


    rtmp {

        server {

            listen 1935;

            chunk_size 4000;

            # TV mode: one publisher, many subscribers
            application mytv {

                # enable live streaming
                live on;

                # record first 1K of stream
                record all;
                record_path /tmp;


                # append current timestamp to each flv
                record_unique on;

        
            }
        }

    }







