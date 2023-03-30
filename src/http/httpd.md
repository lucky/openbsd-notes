# httpd

OpenBSD's [`httpd`] \(not to be confused with Apache httpd) is a lightweight
and secure web server that is included by default. It is designed to be simple
to configure and maintain, with a focus on security and correctness.

It does not support gzip compression or reverse proxying, though it does
support FastCGI. If you need something more advanced than a simple webserver,
you might consider [`nginx`](nginx.md) instead.

The example config `/etc/examples/httpd.conf` is a good place to start.

Once you have your config in `/etc/httpd.conf`, you may enable and start the
daemon:

```shell
# rcctl enable httpd
# rcctl start httpd
```

*Note*: By default, the process is
[`chroot`ed](https://man.openbsd.org/chroot.2) to `/var/www`.

[`httpd`]: https://man.openbsd.org/httpd
