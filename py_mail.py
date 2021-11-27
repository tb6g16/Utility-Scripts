# This file will contain the function definition to send an email using python
# from a gmail account.

import smtplib
import ssl

def send_main(message, receiver):
    port = 465 # for ssl
    smtp_server = "smtp.gmail.com"
    sender = "tombot420lol@gmail.com"
    password = "anJ41F7bMkla"

    context = ssl.create_default_context()
    with smtplib.SMTP_SSL(smtp_server, port, context=context) as server:
	server.login(sender, password)
	server.sendmail(sender, receiver, message)

