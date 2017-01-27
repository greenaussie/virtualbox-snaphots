# Virtual box snapshots cron

This is a fairly simply cron which will create snapshots for all running virtualbox guest VMS, for all user accounts on the system with home directories in ``/home``. It is not needed to back up stopped VMs because (a) they don't change and (b), normal file system backups of the images will result in consistent images which can be restarted.

## Usage

Assuming you need this because you are using Virtualbox, simply drop the script into /etc/cron.daily.
