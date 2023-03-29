#!/bin/sh

set -ex

mdbook build
rsync -avz ./book/ hrpr.us:/var/www/htdocs/openbsd-notes/
