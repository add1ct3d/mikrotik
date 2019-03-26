:local name=email value="mail@mail.com";
:local name=hostname value="Monitor_host_name";
:local name=status value="DOWN";

:if ([/system resource get uptime] > 90s) do={
/tool e-mail send to=$email subject="Host $hostname is $status" body="IP: $host \nTime: $[/system clock get date] $[/system clock get time] \nStatus: $status\nChecked from: $[/system identity get name]";
}
