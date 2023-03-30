# acme-client

If you've installed [`httpd`] or [`nginx`]

## Step 0

Set up your DNS to point to your host. Each domain you wish to use for this
server must be set up before we use [`acme-client`], e.g. `example.com` _and_
`www.example.com`.

## Step 1

Install your webserver, and set up the `/.well-known/acme-challenge` path to
point at the `/var/www/acme` directory. This is a special directory that
[`acme-client`] uses to answer the challenge to confirm the domain for the
automatically issued certificate. 

### `nginx`

```
location /.well-known/acme-challenge/ {
    rewrite ^/.well-known/acme-challenge/(.*) /$1 break;
    root /var/www/acme;
}
```

### `httpd`

```
location "/.well-known/acme-challenge/*" {
        root "/acme"
        request strip 2
}
```

*Note*: Because [`httpd`] is [`chroot`ed](https://man.openbsd.org/chroot.2) to
`/var/www` by default, we only specify `/acme` as the root, which ultimately
maps to `/var/www/acme` just like in the [`nginx`] config.

## Step 2

Restart or reload your server, for example

```shell
# rcctl reload httpd
```

Now we're going to confirm the acme challenge path works as expected.

```shell
# echo "It worked!" > /var/www/acme/test.html
```

Now navigate to:

    http://YOUR_HOSTNAME/.well-known/acme-challenge/test.html

And confirm that you see the `It worked` page.

## Step 3

Configure [`acme-client`] by copying `/etc/examples/acme-client.conf` to
`/etc/acme-client.conf`, and replacing `example.com` and `secure.example.com`
to suit your domain and subdomains. You may omit the `alternative names` if
you do not have a second domain to use with the certificate.

## Step 4

Run [`acme-client`]:

```shell
# acme-client YOUR_DOMAIN
```

Where `YOUR_DOMAIN` is the domain used in the outer domain directive in the
configuration. This will request a certificate, and the challenge path we
configred above will be used to verify your domains.

## Step 5

Update your http config to enable TLS and use the certificate.

For [`nginx`] you should be able to uncomment the section below `HTTPS server`
and update `server_name`, `ssl_certificate`, and `ssl_certificate_key`.

For [`httpd`], modify `server`, `certficate`, and `key`.

Once reloaded, your server should be serving TLS!

## Optional Step 6

Create a crontab for the root user to update the certificate automatically,
for example:

```shell
acme-client example.com && rcctl reload nginx
```

*Note*: that you can pass `-v` to `acme-client` to have it tell you about its
decision whether to update.

    acme-client: /etc/ssl/example.com.fullchain.pem: certificate valid: 88 days left

[`httpd`]: httpd.md
[`nginx`]: nginx.md
[`acme-client`]: https://man.openbsd.org/acme-client
