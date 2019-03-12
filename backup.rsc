#get global parameters
:global email;
:global BackupPass;

:put message=">>>> Start backuping..."

#set script parameters
:local name=BData value=([:pick [/system clock get date] 4 6]."-".[:pick [/system clock get date] 0 3]."-".[:pick [/system clock get date] 7 11]."_".[:pick [/system clock get time] 0 2]."-".[:pick [/system clock get time] 3 5]);
:local name=sysname value=[/system identity get name];
:local name=sysver value=[/system package get system version];
:local name=FullBackup value=($sysname."-".$sysver."-".[$BData].".backup");
:local name=CompactScript value=($sysname."-".$sysver."-".[$BData].".rsc");

#create backups
/system backup save password=$BackupPass name=$FullBackup;
/export compact hide-sensitive terse file=$CompactScript;
:put message=">>>> Backups were created successfully"
delay 7;

#send backups
/tool e-mail send to=$email subject="Backup from $sysname" file="$FullBackup,$CompactScript"
:put message=">>>> Backups were sent to e-mail successfully"
delay 7;

#remove backups
/file remove $FullBackup;
/file remove $CompactScript;
:put message=">>>> Backups were removed from internal storage successfully"
:log warning "Backup was sent successfully to the e-mail";
