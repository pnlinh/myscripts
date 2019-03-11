#!/bin/bash
#
# @author: pnlinh1207@gmail.com
# 
# */30 0 1 */2 * root /bin/sh /root/renewssl.sh
# service crond restart
#
service nginx stop
./certbot-auto renew --force-renew && service nginx restart