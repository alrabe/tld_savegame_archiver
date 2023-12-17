# The Long Dark Savegame Archiver for Linux
## TL;DR
* Save the scripts to a user folder and make them executable:
```console
foo@bar:~$ chmod +x ~/.local/bin/tld_archive*
```

* Create a backup of your save games folder:
```console
foo@bar:~$ tld_archive_all.sh
```
* Remove outdated backups:
 ```console
foo@bar:~$ tld_archive_clean.sh
```

* Automate everything:
```console
foo@bar:~$ crontab -e
```
```console
*/3 * * * * ~/.local/bin/tld_archive_all.sh
*/30 * * * * ~/.local/bin/tld_archive_clean.sh 
```

* Look for backups inside of Backup folder:
```console
foo@bar:~$ ls -lt ~/.local/share/Hinterland/Backup
```

## How it works
The **archive_all** script searches the savegame folder for files that were changed in the last 5 minutes. If something was changed, a new backup of the entire folder content is created. If this backup is identical to the previous one, then the previous will be removed.

If you want to execute the script only manually on demand (without cron), than you have to remove this part from the script: "_-mmin -$check_time_", else changes that happened more than 5 minutes ago will not trigger a new backup. 

The **archive_clean** script removes all older backups but keeps the last 50. You can change this number inside the script.

**Cron** will ensure, that this scripts will be executed periodically.

Other **Settings** can be found in the scripts. Some important points:
* Do not put the backups into the save game folder itself. This will conflict with Steams save game synchronization. 
* When changing the archive name, do not use any underscore characters. The resulting archives must have exactly one single _ character in their name that will be autogenerated.
* Make the scripts executable:
```console
foo@bar:~$ chmod +x tld_archive_*
```
