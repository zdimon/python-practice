Запуск торнадо сервера в режиме вебсокета.
##########################################

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: tornado
:category: Разное
:authors: zdimon77@gmail.con


Django with tornado as wsgi server.

tserver.py

.. code-block:: python

    #! /usr/bin/env python
    import os
    import tornado.httpserver
    import tornado.ioloop
    import tornado.wsgi
    import sys
    import django.core.handlers.wsgi
    from config.settings import BASE_DIR
    from tornado import web
    sys.path.append(BASE_DIR)
    def main():
            os.environ['DJANGO_SETTINGS_MODULE'] = 'config.settings'
            application = django.core.handlers.wsgi.WSGIHandler()
            container = tornado.wsgi.WSGIContainer(application)
            http_server = tornado.httpserver.HTTPServer(container)
            http_server.listen(8080)
            tornado.ioloop.IOLoop.instance().start()
    if __name__ == "__main__":
                    main()




Requirements.

.. code-block:: bash

    tornado==4.0.1
    sockjs-tornado==1.0.1
    -e git+https://github.com/peterbe/django-sockjs-tornado#egg=django-sockjs-tornado
    -e git+https://github.com/kmerenkov/brukva.git#egg=brukva

Create base tornado class in filr myapp/tornadoserver.py.

.. code-block:: python


        # -*- coding: utf-8 -*-
    """
        Simple sockjs-tornado chat application. By default will listen on port 5555.
    """
    import tornado.ioloop
    import tornado.web
    import time
    import sockjs.tornado
    import brukva
    import json
    import logging
    from django.core.exceptions import ObjectDoesNotExist
    c = brukva.Client()
    c.connect()
    logger = logging.getLogger(__name__)
    logger.setLevel('DEBUG')
    import os

    class ChatConnection(sockjs.tornado.SockJSConnection):
        """Chat connection implementation"""
        participants = set() # List of users online

        # Initialization
        def __init__(self,*args):
            super(ChatConnection, self).__init__(*args)
            self.client = brukva.Client()
            self.client.connect()
           

        # When connection need to be open
        def on_open(self, info):
            ''' function when someone made connection from javascript'''
            # Send that someone joined
            message = {"act" : "someone_joined", "content" : "Someone joined"}
            self.broadcast(self.participants, json.dumps(message))
            # Add client to the clients list
            self.participants.add(self)

        # When we recieve message from redis server we go here
        def redis_message(self, result):
            ''' recieving  message from redis server, 
                convertin it in json format 
                and sending it to the current chanel
            '''
            message = json.loads(result.body)
            self.send(json.dumps(message))

        # Subscribe user to channel
        def subscribe(self, room):
            self.client.subscribe(room) # Redis subscribe
            logger.debug('subscribing to room %s' % (room, )) # Debug
            self.client.listen(self.redis_message)

        # When we receive messages we go here
        def on_message(self, message): 
            ''' handler of message '''
            logger.debug(message) # Debug
            message = json.loads(message)
            # When we open connection
            if message['act'] == 'open_connect':
                logger.debug('Connection esteblished.')
            if message['act'] == 'ping':
                mes = { 'act': 'pong', 'message': message['message'] }  
                self.broadcast(self.participants, json.dumps(mes))
        # When current user tries to disconnect
        def on_close(self):
            self.participants.remove(self)
            logger.debug('User left')        

        
   

Add django_sockjs_tornado to INSTALL_APPS.

.. code-block:: python

    'django_sockjs_tornado',

Define  SOCKJS_CLASSES

.. code-block:: python

    SOCKJS_CLASSES = (
        'myapp.tornadoapp.ChatConnection',
    )



Get sockjs client script.

.. code-block:: bash

    cd project/myapp/style
    git clone https://github.com/sockjs/sockjs-client.git
    cd 


Create templates and views.

from co.settings import SOCKJS_SERVER

def index(request,id):
    return render_to_response('index.html', context, RequestContext(request))


def js_for_owner(request):
    context = {'server': SOCKJS_SERVER}
    return render_to_response('client.js', context, RequestContext(request))


Define SOCKJS_SERVER variable in settings.py.

.. code-block:: python

    SOCKJS_SERVER = 'localhost:9999'


index.html


.. code-block:: html

        <script src="{% static 'sockjs-client/dist/sockjs-0.3.4.min.js' %}"></script>
        <script src="{% url 'course_student_js' %}"></script>
        [...]
        <a href="#" data-message='ping' id="test_message"> Test </a>

client.js

.. code-block:: js

    var transports = ['websocket', 'xhr-streaming' ,'iframe-eventsource', 'iframe-htmlfile' , 'xhr-polling', 'iframe-xhr-polling', 'jsonp-polling'];
    var conn = new SockJS('http://{{ server }}/echo', transports);

    var current_user_id = parseInt('{{ user_id }}');


    conn.onmessage = function(e) {
        var obj = JSON.parse(e.data);
        

        if(obj.act == 'pong') {
            
            alert(obj.message)
        }  
     

    }
    conn.onclose = function() {
        console.log('Disconnected.');
        conn = null;
    }
    conn.onopen = function() {
        console.log('Connected.');
        mess = {"act" : "open_connect", "user_id" : "{{ user_id }}", "auth" : "true", "room_id" : "{{ room_id }}", "place" : "chat" };
        conn.send(JSON.stringify(mess));
    }



    //////////////////////////////////////
    //////////Initialization/////////////
    /////////////////////////////////////

        $(document).ready(function(){
             
                
                 //// Test message
                 $('#test_message').on('click', function(e) {
                    e.preventDefault();
                    var message = $(this).attr('data-message');
                    var mess = { "act" : "ping", "message" : message };
                    conn.send(JSON.stringify(mess));
                });   
                /////////////////////////////////// 

           
         });


Run socket server.

 

.. code-block:: bash

    ./manage.py socketserver


