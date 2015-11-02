#!/usr/bin/python

import json
import os
import subprocess


def get_zookeeper_servers():
    zk_relation = json.loads(subprocess.check_output(
        ["relation-ids", "--format=json", "zk"]))
    if not zk_relation:
        return ""
    else:
        zk_relation = zk_relation[0]
    zks = []
    units_data = subprocess.check_output(
        ['relation-list', '-r', zk_relation, '--format=json'])
    for unit in json.loads(units_data):
        data = json.loads(subprocess.check_output(
            ['relation-get', '-r', zk_relation, '--format=json', '-', unit]))
        if not 'port' in data:
            continue
        zks.append("%s:%s" % (data['private-address'], data['port']))
    zks.sort()
    return ",".join(zks)


def update_kafka_config(path, zks):
    with open(path) as fh:
        config = []
        for l in fh.readlines():
            if l.startswith('broker.id'):
                svc, seq = os.environ['JUJU_UNIT_NAME'].split('/', 1)
                config.append('broker.id=%s' % seq)
                continue
            elif l.startswith('zookeeper.connect'):
                # If no change just exit
                if l.split('=', 1) == zks:
                    return False
                config.append('zookeeper.connect=%s' % zks)
                continue
            config.append(l)
    with open(path, 'w') as fh:
        fh.write("\n".join(config))
    return True


def svc_is_running(name):
    output = subprocess.check_output(['service', name, 'status'])
    if 'running' in output:
        return True
    return False


def svc_stop(name):
    if svc_is_running(name):
        subprocess.check_output(['service', name, 'stop'])


if __name__ == '__main__':
    # make it easy to get zookeeper servers
    print(get_zookeeper_servers())
