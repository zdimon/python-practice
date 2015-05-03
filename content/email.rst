Работа с почтой
###############

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: email
:category: tips
:authors: zdimon77@gmail.con




from django.core.mail import send_mail
send_mail("test subject", "test message", from_email="zdimon77@gmail.com", recipient_list=["zdimon77@gmail.com"])
