Часто возникающие ошибки
########################

:date: 2015-02-11 
:tags: python, tutorial, уроки, django
:slug: errors
:category: Ошибки
:authors: zdimon77@gmail.con


Error: That port is already in use.
-----------------------------------

**Причина**:
Какой то процесс уже слушает порт и не дает к нему подключиться.

**Лечение**:
Убиваем процесс по порту.

.. code-block:: Bash

    netstat -pl |grep 8000

Видим нечто такого.

.. code-block:: Bash

    tcp        0      0 localhost:8000          *:*                     LISTEN      14977/python    

Прибиваем по ID процесса

    kill -9 14977  


bash: ./ft.py: Permission denied
--------------------------------

**Причина**:
Файл не является исполняемым.

**Лечение**: изменение прав на файл командой chmod.

.. code-block:: Bash

    chmod +x ft.py

IndentationError: unexpected indent
-----------------------------------

**Причина**: Где то протупили с отступами либо всунули табуляцию в перемешку с пробелами.

**Лечение**: правки кода.



SyntaxError: Non-ASCII character '\xd0' in file
-----------------------------------------------


**Причина**: Где то присутствует кирилица.

**Лечение**: Перед любой кирилической строкой в коде поставить символ u (u'строка'). Вставить строку **# -*- coding: utf-8 -*-** в начале скрипта.


from: can't read /var/mail/selenium
-----------------------------------

**Лечение**:  Вставить строку **#!/usr/bin/python** в начало скрипта.

ImportError: No module named selenium
-------------------------------------

**Причина**: Питон не может найти библиотеку т.к. используется системный бинарник питона а не тот который стоит в виртуальном окружении.

**Лечение**: Отредактировать строку **#!../bin/python** в начале скрипта где указать путь к бинарнику относительно положения скрипта в каталоге виртуального окружения.


AttributeError: 'NoneType' object has no attribute 'endswith
------------------------------------------------------------


**Причина**: Не прописана переменная STATIC_ROOT = 'static' в settings.py

**Лечение**: Прописываем.

Python Image Library fails with message “decoder JPEG not available”
--------------------------------------------------------------------

**Лечение**:

sudo apt-get install libjpeg-dev

sudo ln -s /usr/lib/i386-linux-gnu/libjpeg.so /usr/lib/
sudo ln -s /usr/lib/i386-linux-gnu/libfreetype.so.6 /usr/lib/
sudo ln -s /usr/lib/i386-linux-gnu/libz.so /usr/lib/

pip install Pillow





