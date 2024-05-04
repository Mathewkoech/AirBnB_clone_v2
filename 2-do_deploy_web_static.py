#!/usr/bin/python3
"""distributes an archive to your web servers, using the function do_deploy"""
from os.path import exists
from fabric.api import put, run, env
env.hosts = ['34.224.6.165', '100.27.10.187']

def do_deploy(archive_path):
    if exists(archive_path) is False:
        return False
    try:
        files = archive_path.split("/")[-1]
        no_extn = files.split(".")[0]
        path = "/data/web_static/releases/"
        put(archive_path, '/tmp/')
        run('mkdir -p {}{}/'.format(path, no_extn))
        run('tar -xzf /tmp/{} -C {}{}/'.format(files, path, no_extn))
        run('rm /tmp/{}'.format(files))
        run('mv {0}{1}/web_static/* {0}{1}/'.format(path, no_extn))
        run('rm -rf {}{}/web_static'.format(path, no_extn))
        run('rm -rf /data/web_static/current')
        run('ln -s {}{}/ /data/web_static/current'.format(path, no_extn))
        return True
    except:
        return False
