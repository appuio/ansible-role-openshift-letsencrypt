#!/bin/bash

set -e

# Detect correct HTTP backend mapping expression as it varies over different OpenShift versions
http_backend=$(sed -n '0,/.*use_backend \(be_http.%\[\)base\(,[^]]\+\]\).*/ s//\1env(LETSENCRYPT_HOST)\2/p' $1)

if [ -z "${http_backend}" ]; then
  echo "Can't detect HTTP backend mapping and therefore can't configure Let's Encrypt integration!" >&2
  exit 1
fi

sed -e 's|redirect scheme https if secure_redirect|\
  acl path_letsencrypt path_beg /.well-known/acme-challenge/\
  acl path_letsencrypt path_beg /.well-known/letsencrypt\
\
  redirect scheme https if secure_redirect !path_letsencrypt\
\
  use_backend '${http_backend}' if path_letsencrypt\
\
|' <$1 >$1.tmp

if diff -q $1 $1.tmp >/dev/null; then
  echo "Failed to apply `basename $0 .sh`" >&2
  exit 1
else
  echo "Applied `basename $0 .sh`"
fi

mv $1.tmp $1
