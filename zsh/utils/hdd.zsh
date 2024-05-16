# Mount HDD
alias mount-hdd="sudo mount -t ntfs3 -o defaults,nofail,noatime,prealloc,uid=1000,gid=1000 /dev/sda1 /mnt/hdd"
# Remove dirty flag on my HDD.
alias fix-hdd="sudo ntfsfix -d /dev/sda1"
