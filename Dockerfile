FROM hachque/opensuse

# Configure zypper
RUN zypper mr -e openSUSE_13.1_OSS
RUN zypper mr -e openSUSE_13.1_Updates
RUN zypper ref

# Remove existing systemd targets
RUN rm -R /usr/lib/systemd/system/* 2>/dev/null
RUN rm -R /usr/lib/systemd/system-generators/* 2>/dev/null
RUN rm -R /etc/systemd/system/* 2>/dev/null
RUN rm -R /etc/init.d/* 2>/dev/null

# Add new default target
ADD default.target /usr/lib/systemd/system/default.target
ADD basic.target /usr/lib/systemd/system/basic.target
ADD sysinit.target /usr/lib/systemd/system/sysinit.target
ADD sshd.service /usr/lib/systemd/system/sshd.service
ADD dbus.service /usr/lib/systemd/system/dbus.service
ADD dbus.socket /usr/lib/systemd/system/dbus.socket

# Allow logins without audit kernel module.
RUN sed -r -n -i '/session(\s+)required(\s+)pam_loginuid/{s|^|#|};p'  /etc/pam.d/login
RUN sed -r -n -i '/session(\s+)required(\s+)pam_loginuid/{s|^|#|};p'  /etc/pam.d/sshd

# Expose SSH.
EXPOSE 22

# Link services into the default target.
RUN mkdir /usr/lib/systemd/system/default.target.wants
RUN ln -s /usr/lib/systemd/system/sshd.service /usr/lib/systemd/system/default.target.wants/sshd.service
RUN ln -s /usr/lib/systemd/system/dbus.socket /usr/lib/systemd/system/default.target.wants/dbus.socket

# Force /var/run to be symlink'd to /run
RUN rm -Rf /var/run
RUN ln -s /run /var/run

# Link /init to systemd
RUN ln -s /bin/systemd /init

