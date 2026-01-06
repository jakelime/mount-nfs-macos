# Mount Synology Drives using NFS

NFS mount is far more efficient because
it operates on the Kernel level.

It is not that hard once you have these
instructions :)

## Quickstart

1. Logon to DSM -> Control Panel -> File Serviecs -> NFS -> Enable -> Maximum NFS Protocol (NFSv4.1)
1. Control Panel -> Shared folder

   - NFS permissions -> Create
   - RW
   - `Squash`: Map all users to admin
   - `AUTH_SYS`
   - Allow conn from non-privileged ports (macOS connect via ports > 1024)
   - Allow users to access mounted subfolders
   - Note down mount path `/volume1/homes/`

1. Termminal

   1. `sudo mount -t nfs -o resvport,rw [NAS-IP-Address]:/[Mount-Path] ~/Desktop/NAS_NFS`

## Troubleshooting

### Stale File Handle

If you ever see a "Stale File Handle" error on your Mac, it usually means the NAS restarted or the network dropped. The quickest fix is to "force unmount" and reconnect: `diskutil unmount force ~/Desktop/NAS_NFS`
