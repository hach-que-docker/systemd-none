To run this image:

```
docker run 
  -d \
  --privileged \
  -P \
  -v /sys/fs/cgroup:/sys/fs/cgroup \
  <image>
```

```
-d = detach from tty
--privileged = allow capabilities, dbus requires this to lower permissions
-P = map exposed ports over NAT
-v = map cgroups, systemd requires this to function
<image> = the name of the image
/init = start systemd
```
