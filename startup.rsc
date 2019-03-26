##Startup script
##Version 2.0

#target e-mail for alerts & backups
:global name=email value="mail@mail.com";

#password for backups
:global name=BackupPass value="123qwerty321";

#update channel
:global updChannel "long-term";

delay 60;
/tool e-mail send to=$email subject="$[/system identity get name]" body="Router was rebooted."
