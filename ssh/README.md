# SSH Configuration Guide

This folder contains a generic SSH server configuration template
(`sshd_config.template`). It is designed to improve security and can be
customized based on your environment.

## Using the Configuration

1. **Copy the Configuration:**
   Look through the provided template file and add/edit the desired
   configuration options to your SSH server configuration file
   (`/etc/ssh/sshd_config`).

2. **Restart the SSH Service:**
   Restart the SSH service to apply the new configuration:

   ```bash
   sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
   sudo launchctl load /System/Library/LaunchDaemons/ssh.plist
   ```

   You can see if RemoteLogin is enabled by running:

   ```bash
   sudo systemsetup -getremotelogin
   ```

3. **Verify the Configuration**:
   Try to connect to the server using SSH to ensure the configuration works as
   expected.

   Generate an SSH key pair if you haven't already: `ssh-keygen -t ed25519`
   Add keys to ssh-agent: `ssh-add ~/.ssh/id_ed25519`

   ```bash
   ssh user@server_ip
   ```

4. **Modify as Needed**:
   - **Port**: Change the SSH port to a non-standard port.
   - **PermitRootLogin**: Disable root login or limit it to specific users.
   - **PasswordAuthentication**: Disable password authentication and use SSH
     keys.
   - **AllowUsers**: Limit SSH access to specific users.
   - etc.

Feel free to modify the configuration to suit your needs and/or suggest
improvements.
