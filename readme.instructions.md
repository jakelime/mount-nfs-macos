Setting up NFS on macOS is a two-part process: first, preparing your Synology NAS to "export" the folder, and second, telling your Mac how to "mount" it.

Since you are on a modern version of macOS, we will focus on the most reliable method that avoids the common "Permission Denied" errors.

### Step 1: Configure Your Synology NAS

1. **Enable NFS Service:**

- Log into DSM and go to **Control Panel > File Services > NFS**.
- Tick **Enable NFS service**.
- Set **Maximum NFS protocol** to **NFSv4.1** (or NFSv3 if you have an older NAS).

2. **Set Shared Folder Permissions:**

- Go to **Control Panel > Shared Folder**.
- Select the folder you want to mount and click **Edit**.
- Go to the **NFS Permissions** tab and click **Create**.
- **Hostname or IP:** Enter your Mac’s IP address (or `*` to allow all devices on your network).
- **Privilege:** Read/Write.
- **Squash:** Select **Map all users to admin** (This is the most "hassle-free" setting for home users to avoid file ownership issues).
- **Security:** AUTH_SYS.
- **Important:** Tick **Allow connections from non-privileged ports** (Macs often connect via ports higher than 1024).
- **Important:** Tick **Allow users to access mounted subfolders**.

3. **Copy the Mount Path:** \* Look at the bottom left of that same window. It will say something like `/volume1/YourFolderName`. **Write this down.**

---

### Step 2: Mount on macOS

There are two ways to do this. Finder is easiest, but Terminal is more "permanent" for NFS.

#### Method A: Using Finder (Quickest)

1. Open **Finder** and press `Command (⌘) + K`.
2. Enter the address using this syntax:
   `nfs://[NAS-IP-Address]/[Mount-Path]`

- _Example:_ `nfs://192.168.1.10/volume1/Photos`

3. Click **Connect**.

#### Method B: Using Terminal (Most Reliable)

If Finder gives you a "Folder can't be found" error, it's usually because macOS needs specific mount options.

1. Open **Terminal**.
2. Create a mount point: `mkdir ~/Desktop/NAS_NFS`
3. Run the mount command:

```bash
sudo mount -t nfs -o resvport,rw [NAS-IP-Address]:/[Mount-Path] ~/Desktop/NAS_NFS

```

_(The `resvport` flag tells macOS to use a "reserved" port, which fixes 90% of connection failures.)_

---

### Troubleshooting "Stale File Handle"

If you ever see a "Stale File Handle" error on your Mac, it usually means the NAS restarted or the network dropped. The quickest fix is to "force unmount" and reconnect:
`diskutil unmount force ~/Desktop/NAS_NFS`

Would you like me to create a small AppleScript for you that automatically runs this mount command every time you log in to your Mac?

---

[VM Storage over NFS: How to on Synology NAS](https://www.youtube.com/watch?v=iwcpO9LfyC4)
This video provides a deep dive into the Synology side of NFS configuration, specifically how to handle permissions and exports correctly to ensure your client can connect without errors.
