Messages.
#########

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: messages
:category: Tips
:authors: zdimon77@gmail.con


'django.contrib.messages' is in INSTALLED_APPS.

.. code-block:: bash

                from django.contrib import messages
                messages.add_message(request, messages.INFO, 'Hello world.')



                            {% for message in messages %}
                            <div class="alert alert-{{ message.tags }}">
                                    {{ message }}
                            </div>
                            {% endfor %}


.. code-block:: css

     .infIn {
      -webkit-animation: infAnim 0.5s linear both;
      -moz-animation: infAnim 0.5s linear both;
      animation: infAnim 0.5s linear both;
    }

    @-webkit-keyframes infAnim {
      from { opacity: 0; -webkit-transform: translateY(-50px); }
      to { opacity: 1; -webkit-transform: translateY(0px); }
    }
    @-moz-keyframes infAnim {
      from { opacity: 0; -moz-transform: translateY(-50px); }
      to { opacity: 1; -moz-transform: translateY(0px); }
    }
    @keyframes infAnim {
      from { opacity: 0; transform: translateY(-50px); }
      to { opacity: 1; transform: translateY(0px); }
    }

    .infOut {
      -webkit-animation: infAnimOut 0.5s linear both;
      -moz-animation: infAnimOut 0.5s linear both;
      animation: infAnimOut 0.5s linear both;
    }

    @-webkit-keyframes infAnimOut {
      0% { opacity: 1; -webkit-transform: translateX(0);}
      100% { opacity: 0; -webkit-transform: translateX(100px);}
    }

    @-moz-keyframes infAnimOut {
      0% { opacity: 1; -moz-transform: translateX(0);}
      100% { opacity: 0; -moz-transform: translateX(100px);}
    }

    @keyframes infAnimOut {
      0% { opacity: 1; transform: translateX(0);}
      100% { opacity: 0; transform: translateX(100px);}
    }

    #informWindows {
      position: fixed;
      top: 70px;
      right: 20px;
      max-width: 170px;
      border: 2px solid #73B036;
      background: #47A447;
      padding: 10px 15px;
      border-radius: 4px;
      box-shadow: inset 0 0 2px rgba(0,0,0,0.3);
      font: 13px/16px SegoeUI SemiLight;
      color: #D9EDC5;
      text-align: center;
      cursor: pointer;
      -webkit-user-select: none;
      -moz-user-select: none;
      user-select: none;
    }


.. code-block:: js

    function infWin(txt) {
        var timer;
        if ($('.informWindows').length) {
            $('.informWindows').addClass('infOut');
            $('.informWindows').stop().fadeOut(400, function() {
                $('.informWindows').first().remove();
            });
        }
        var itm = $('<div>').addClass('informWindows infIn').attr('id', 'informWindows').html('<p>' + txt + '</p>');
        itm.appendTo('body');
        $(document).on('click', '.informWindows', function(event) {
            itm.addClass('infOut');
            itm.fadeOut(400, function() {
                itm.remove();
            });
        });

        clearTimeout(timer);
        timer = setTimeout(function() {
            itm.addClass('infOut');
            itm.fadeOut(400, function() {
                itm.remove();
            });
        }, 30000);
    }



