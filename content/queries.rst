Queries.
########

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: queries
:category: Tips
:authors: zdimon77@gmail.con

How to make join

from django.db.models import Q
User.objects.filter(Q(income__gte=5000) | Q(income__isnull=True))


Like


User.objects.filter(Q(income__gte=5000) | Q(name__contains=True))

Raw

Person.objects.raw('SELECT * FROM myapp_person'):


Case insensitive

User.objects.filter(Q(income__gte=5000) | Q(name__icontains=True))


