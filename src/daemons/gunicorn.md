# Gunicorn

Running a [Gunicorn](https://gunicorn.org/) daemon on OpenBSD is easy. Make
sure to have Gunicorn and
[setproctitle](https://pypi.org/project/setproctitle/)[^setproctitle]
installed:

```shell
# pkg_add py3-gunicorn py3-setproctitle
```

Choose a place to deploy your app. The app in this example is called `myapp`
so we're going to place it in `/var/www/myapp`. It will also need to be
readable by the `daemon_user`, in this case `www`.

Now we set up the [`rc.d`](https://man.openbsd.org/rc.d) daemon control
script. This was adapted from a mailing list entry by [Daniel
Winters](https://www.mail-archive.com/misc@openbsd.org/msg172629.html).


As root (via [`doas`](/basics/doas.md)), create the file `/etc/rc.d/myapp`:

```sh
#!/bin/ksh

daemon="/usr/local/bin/gunicorn -D"
daemon_user="www"
daemon_flags="--bind 127.0.0.1:8000 --chdir /var/www/myapp --name webapp
myapp:app"

. /etc/rc.d/rc.subr

pexp=".*gunicorn: master \[myapp\].*"

rc_cmd $1
```

Now you should be able to enable and start your daemon:

```shell
# rcctl enable myapp
# rcctl start myapp
```

If you run into trouble, check out [debugging `rcctl`](debugging_rcctl.md)

---

[^setproctitle]: This is necessary for Gunicorn's `--name` flag to work. If
  this is not available, the `pexp` will be incorrect.
