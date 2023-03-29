# doas

Instead of `sudo`, OpenBSD defaults to using
[`doas`](https://man.openbsd.org/doas).

One caveat is that when [configured](https://man.openbsd.org/doas.conf.5) to
persist, i.e. not asking for a password again for a while, the timeout for
this is hard-coded to 5 minutes. Some users feel that it should behave more
like `sudo`, but the authors of `doas` have intentionally kept it small and
clean. If you want `sudo`'s functionality, use `sudo`.
