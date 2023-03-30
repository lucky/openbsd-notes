# Daemons

OpenBSD has a set of scripts that manage system services and daemons, starting
with [`rc(8)`]. Most of the time you'll be working with the control script
[`rcctl(8)`], for example:

```shell
# rcctl enable httpd
# rcctl start httpd
```

Creating a daemon is fairly simple. You create a
[`ksh`](/basics/ksh.md) script in `/etc/rc.d` that at the minimum
does three things:

 - Specifies the daemon 
 - Imports default routines from [`rc.subr(8)`]
 - Runs [`rc_cmd`]

For example:

```sh
#!/bin/ksh

daemon="/usr/local/bin/mydaemon"

. /etc/rc.d/rc.subr

rc_cmd $1
```

When placed in `/etc/rc.d/` and made executable (`chmod +x
/etc/rc.d/mydaemon`), this script will then allow you to run [`rcctl(8)`] to
start, stop, enable, disable, etc, this daemon. 

Other useful variables used by [`rc_cmd`] are:

 - `daemon_user` -- User to run the daemon as
 - `daemon flags` -- Arguments passed to the daemon
 - `pexp` -- A regex used to identify the running process

The [`rc.subr(8)`] manpage documents all available variables.


[`rc(8)`]: https://man.openbsd.org/rc
[`rc.d(8)`]: https://man.openbsd.org/rc.d.8
[`rcctl(8)`]: https://man.openbsd.org/rcctl.8
[`rc.subr(8)`]: https://man.openbsd.org/rc.subr.8
[`rc_cmd`]: https://man.openbsd.org/rc.subr.8#rc_cmd

