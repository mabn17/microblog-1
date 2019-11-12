password="<password>"

# Create user
useradd mabn
mkdir /home/mabn
mkdir /home/mabn/.ssh
chmod 700 /home/mabn/.ssh

usermod -s /bin/bash mabn # Set default terminal for user

# Set user mabn password
echo "mabn:$password" | chpasswd
usermod -aG sudo mabn # add to sudo group

# Copies ssh keys added during creation
cp /home/admin/.ssh/authorized_keys /home/mabn/.ssh/
chown mabn:mabn /home/mabn -R 
chmod 400 /home/mabn/.ssh/authorized_keys

# Edit ssh config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
echo "AllowUsers mabn" >> /etc/ssh/sshd_config
service ssh restart

# Set no need for sudo password, comment this out if you want more security. It might make some of the later scripts behave weird or stop working.
echo "mabn ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
