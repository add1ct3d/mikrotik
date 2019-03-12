:global email;
:global updChannel;

:put message=">>>>> Check for update..."
/system package update
set channel=$updChannel
check-for-updates
:put message=">>>>> Wait on slow connections..."
:delay 15s;
:if ([get installed-version] != [get latest-version]) do={
   :put message=">>>>> New version of RouterOS available, let's upgrade"
   /tool e-mail send to="$email" subject="Upgrading RouterOS on router $[/system identity get name]" body="Upgrading RouterOS on router $[/system identity get name] from $[/system package update get installed-version] to $[/system package update get latest-version] (channel:$[/system package update get channel])"
   :put message=">>>>> Wait for mail to be send & upgrade..."
   :delay 15s;
   :put message=">>>>> Backup configuration to email first..."
   /system script run backup;
   :put message=">>>>> Backuping complete"
   :put message=">>>>> Start install"
   install
} else={
   :put message=">>>>> RouterOS latest, let's check for updated firmware"
   :put message=">>>>> No RouterOS upgrade found, checking for FW upgrade..."
   /system routerboard
   :if ( [get current-firmware] != [get upgrade-firmware]) do={
      :put message=">>>>> New version of firmware available, let's upgrade"
      /tool e-mail send to="$email" subject="Upgrading firmware on router $[/system identity get name]" body="Upgrading firmware on router $[/system identity get name] from $[/system routerboard get current-firmware] to $[/system routerboard get upgrade-firmware]"
      :put message=">>>>> Wait for mail to be send & upgrade..."
      :delay 15s;
      upgrade
      :put message=">>>>> Wait for upgrade, then reboot..."
      :delay 180s;
      /system reboot
   } else={
   :put message=">>>>> No Router FW upgrade found"
   }
}
