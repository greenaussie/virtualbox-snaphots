#!/bin/bash

set -x

# Take snapshots of all running virtualbox vms for all users - a daily cron

# For each user, determined by a list of home directories and assuming a username to home directory name mapping
for u in $(find /home -mindepth 1 -maxdepth 1 -type d | xargs -i basename {}) ; do

  # Determine which guest vms are running for user
  for runningvm in $( sudo -u $u vboxmanage list runningvms | sed -r 's/.*(\{.*\})/\1/' ); do 

    # For each running guest vm, delete all but the last two snapshots (takes a while to delete them!)
    # because we should be backing up the volume of the host, we only need a couple of these because we can
    # easily restore from the host volume to go back in time
    for snapid in $( sudo -u $u vboxmanage snapshot $runningvm list | head -n -2 | sed -r 's/.*UUID: (.*)\)/\1/'); do
      sudo -u $u vboxmanage snapshot $runningvm delete $snapid
    done

    # foreach running vm create a new snapshot
    sudo -u $u vboxmanage snapshot $runningvm take "Snapshop - $runningvm $(date)"
  done
done

set +x
