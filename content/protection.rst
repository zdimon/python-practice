Protection.
###########

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: protection
:category: Tips
:authors: zdimon77@gmail.con



def hello(name): 
    print('Hello {0}'.format(name))


cython hello.py -o hello.c
gcc -shared -pthread -fPIC -fwrapv -O2 -Wall -fno-strict-aliasing -I/usr/include/python2.7 -o hello.so hello.c 
