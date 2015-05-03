#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'zdimon77@gmail.com'
SITENAME = u'Python tutorial'
SITEURL = ''

PATH = 'content'

TIMEZONE = 'Europe/Paris'

DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = ()

# Social widget
SOCIAL = ()

DEFAULT_PAGINATION = 10
STATIC_PATHS = ['images']
# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

DISPLAY_PAGES_ON_MENU = False
INDEX_SAVE_AS = 'index.html'
DEFAULT_DATE = 'fs'

PLUGIN_PATHS = ['plugins']
PLUGINS = [ "plantuml" ]
THEME = "themes/bootstrap2"
