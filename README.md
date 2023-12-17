# The Long Dark Savegame Archiver for Linux
## TLDR
* Create a backup of your save games folder:
```console
foo@bar:~$ tld_archive_all.sh
```
* Remove outdated backups:
 ```console
foo@bar:~$ tld_archive_clean.sh
```
* Automate everythig:
```console
foo@bar:~$ crontab -e
```
```
*/3 * * * * ~/.local/bin/tld_archive_all.sh
*/30 * * * * ~/.local/bin/tld_archive_clean.sh 
```
## How it works
The **archive_all** script searches the savegame folder for files that were changed in the last 5 minutes. If something has changed, a new backup archive of the entire folder is created. If this archive is identical to the previous archive, then the previous one will be removed.

If you want to execute the script only manually without cron, you can remove this part from the script: "_-mmin -$check_time_", else changes that happend more than 5 minutes ago will not trigger the backup process. 

The **archive_clean** script removes all older archives but keeps the last 50. You can change this number inside the script.

**Cron** will ensure, that this scripts will be executed periodically.

Other **Settings** can be found in the scripts itself. Ther are imoirtent points:
* Do not put the backups into the save game folder itself. This will conflict with Steams savegame synchronization. 
* When changing setting like the archive name, do not a underscore characters to it and check if the resulting archives contain exactly one single _ character.

