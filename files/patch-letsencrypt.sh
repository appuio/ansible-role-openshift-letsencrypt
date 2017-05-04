#!/bin/bash

set -e

sed -e 's|redirect scheme https if secure_redirect|\
  acl path_letsencrypt path_beg /.well-known/acme-challenge/\
  acl path_letsencrypt path_beg /.well-known/letsencrypt\
\
  redirect scheme https if secure_redirect !path_letsencrypt\
\
  use_backend be_http_%[env(LETSENCRYPT_HOST),map_beg(/var/lib/haproxy/conf/os_http_be.map)] if path_letsencrypt\
\
|' <$1 >$1.tmp

if diff -q $1 $1.tmp >/dev/null; then
  echo "Failed to apply `basename $0 .sh`" >&2
  exit 1
else
  echo "Applied `basename $0 .sh`"
fi

mv $1.tmp $1
