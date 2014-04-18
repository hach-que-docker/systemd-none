FROM hachque/opensuse
MAINTAINER James Rhodes

# Configure zypper
RUN zypper mr -e openSUSE_13.1_OSS
RUN zypper mr -e openSUSE_13.1_Updates
RUN zypper ref

# Remove systemd targets
RUN rm -R /usr/lib/systemd/system/* 2>/dev/null
RUN rm -R /usr/lib/systemd/system-generators/* 2>/dev/null
RUN rm -R /etc/systemd/system/* 2>/dev/null
RUN rm -R /etc/init.d/* 2>/dev/null

# Add the SSH boot script
ADD 00-ssh /etc/init.d/00-ssh

# Allow logins without audit kernel module.
RUN sed -r -n -i '/session(\s+)required(\s+)pam_loginuid/{s|^|#|};p'  /etc/pam.d/login
RUN sed -r -n -i '/session(\s+)required(\s+)pam_loginuid/{s|^|#|};p'  /etc/pam.d/sshd

# Expose SSH.
EXPOSE 22

# Add the init script
ADD init /init

# Set /init as the default
CMD ["/init"]
