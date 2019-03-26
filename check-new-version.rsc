:local updChannel "long-term"
:global email;

:put message=">>>>> Check for update..."
/system package update
set channel=$updChannel
check-for-updates
:put message=">>>>> Wait on slow connections..."
:delay 10s;
:if ([get installed-version] != [get latest-version]) do={
   :put message=">>>>> New version of RouterOS available, let's send notify!"
   /tool e-mail send to=$email subject="$[/system identity get name]" body="New version of RouterOS $[/system package update get latest-version] (channel: $[/system package update get channel]) is available."
   :put message=">>>>> Wait for mail to be send..."
   :delay 10s;
} else={
   :put message=">>>>> RouterOS is latest version."
   :put message=">>>>> RouterOS update not found."
}
