# Preload the source tree

We're going to use `reposync` to create a local copy of AnonCVS to `/cvs`.

As root:

```shell
# Add your user to the `wsrc` group. Be sure to change `exampleuser` to your username.
user mod -G wsrc e
# Create the directory, and set the group to `wsrc`
mkdir /var/cvs /var/db/reposync
chgrp wsrc /var/cvs /var/db/reposync
chmod 775 /var/cvs /var/db/reposync
ln -s /var/cvs /cvs
# Install reposync
pkg_add reposync
reposync rsync://anoncvs@your.chosen.mirror:/cvs
```




## Avoiding root privileges

Run with `doas` or as root and replace `exampleuser` with your username:

```shell
cd /usr
mkdir -p   xenocara ports www
chgrp wsrc xenocara ports www
chmod 775  xenocara ports www
```

## Getting the source


First, [pick a mirror](https://www.openbsd.org/anoncvs.html#CVSROOT). Each mirror has its supported features. For this guide, make sure to pick one that supports ssh.

Install `reposync`:

```shell
$ doas pkg_add reposync
```