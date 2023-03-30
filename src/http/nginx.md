# nginx

Installing `nginx` is as simple as installing the right package:

```shell
# pkg_add nginx
```

Then enable and start the daemon:

```shell
# rcctl enable nginx
# rcctl start nginx
```

Note that the default config has some [different
defaults](https://github.com/openbsd/ports/blob/master/www/nginx/patches/patch-conf_nginx_conf)
than `nginx` ships with.
