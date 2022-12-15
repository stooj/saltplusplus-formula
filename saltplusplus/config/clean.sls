# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import saltplusplus with context %}

saltplusplus-config-ssh-key-removed-from-fileserver:
  file.absent:
    - name: /srv/salt/ssh/files/deploy_key

saltplusplus-config-ssh-file-root-removed:
  file.absent:
    - name: /srv/salt/ssh/files

saltplusplus-config-ssh-pub-key-absent:
  file.absent:
    - name: /root/.ssh/id_rsa.pub

saltplusplus-config-ssh-key-absent:
  file.absent:
    - name: /root/.ssh/id_rsa

saltplusplus-config-ssf-git-script-absent:
  file.absent:
    - name: /srv/salt/ssf/files/fishers/git/git_30_create_PR.sh

saltplusplus-config-ssf-file-root-absent:
  file.absent:
    - name: /srv/salt/ssf/files/fishers/git
