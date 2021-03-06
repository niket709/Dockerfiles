#!/bin/bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-01-26 22:51:25 +0000 (Tue, 26 Jan 2016)
#
#  https://github.com/harisekhon/Dockerfiles/mesos
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/harisekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

if [ $# -gt 0 ]; then
    exec $@
else
    # This only runs a master
    #/usr/bin/mesos-local
    mesos master --work_dir=/var/lib/mesos --log_dir=/tmp/mesos-master-logs --cluster=myCluster &
    sleep 2
    mesos slave --master=127.0.0.1:5050 --log_dir=/tmp/mesos-slave-logs &
    sleep 1
    echo "================="
    cat /tmp/mesos-master-logs/*
    cat /tmp/mesos-slave-logs/*
    tail -f /tmp/mesos-master-logs/* /tmp/mesos-slave-logs/*
fi
