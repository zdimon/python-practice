Использование AJAX запросов.
############################

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: ajax
:category: Разное
:authors: zdimon77@gmail.con

Wi will use `this <https://github.com/yceruto/django-ajax>`_ library.

Requirements.

.. code-block:: bash

    djangoajax==2.2.12

Add app in INSTALL_APPS.

.. code-block:: python

    INSTALLED_APPS = (
    [....]
        'django_ajax',
     
    )


Create test view for the ajax requests mymodule/ajax.py.


.. code-block:: python


    from django_ajax.decorators import ajax
  
    @ajax
    def test(request):

        data = {
                'inner-fragments': { 
                    '#apponent_cam': 'test ajax',                   
                 },   
               }
        
        return data      
        
   
Create url.

.. code-block:: python

    url(r'^ajax/test$', 'mymodule.ajax.test' , name="ajax-test"),


Add js library in the template.

.. code-block:: html

        <script type="text/javascript" src="{% static 'django_ajax/js/jquery.ajax.min.js' %}"></script>
        <script type="text/javascript" src="{% static 'django_ajax/js/jquery.ajax-plugin.min.js' %}"></script>


Call the func.

.. code-block:: js

     ajaxGet('{% url 'ajax-test' %}', {'var': var}, function(content){});

