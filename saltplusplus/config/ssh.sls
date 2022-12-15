# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import saltplusplus with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- set keytype = salt['pillar.get']('saltplusplus:ssh:keytype') %}

saltplusplus-config-ssh-key-managed:
  file.managed:
    - name: /root/.ssh/id_{{ keytype }}
    - contents_pillar: saltplusplus:ssh:key
    - makedirs: True
    - user: root
    - group: root
    - mode: 600

saltplusplus-config-ssh-pub-key-managed:
  file.managed:
    - name: /root/.ssh/id_{{ keytype }}.pub
    - contents_pillar: saltplusplus:ssh:pubkey
    - makedirs: True
    - user: root
    - group: root
    - mode: 600

saltplusplus-config-ssh-file-root-managed:
  file.directory:
    - name: /srv/salt/ssh/files
    - user: root
    - group: root
    - mode: 700
    - makedirs: True

saltplusplus-config-ssh-key-available-in-fileserver:
  file.symlink:
    - name: /srv/salt/ssh/files/deploy_key
    - target: /root/.ssh/id_{{ keytype }}
    - user: root
    - group: root
    - mode: 600
    - require:
      - saltplusplus-config-ssh-key-managed
      - saltplusplus-config-ssh-file-root-managed
