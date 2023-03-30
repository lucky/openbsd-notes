# HTTP and TLS

It's easy to get started with a web server that supports TLS, though there are
a few steps involved.

1. Choose and install your webserver. [`httpd`](httpd.md) or
[`nginx`](nginx.md) are great options. 
2. Install a certificate via [`acme-client`].


This guide does not cover others such as Apache or lighttpd, but I'm sure they
work great alongside [`acme-client`].

[`acme-client`]: acme-client.md
