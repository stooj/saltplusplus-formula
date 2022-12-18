# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import saltplusplus with context %}

{%- set keytype = salt['pillar.get']('saltplusplus:ssh:keytype') %}

saltplusplus-config-ssh-key-removed-from-fileserver:
  file.absent:
    - name: /srv/salt/ssh/files/deploy_key

saltplusplus-config-ssh-file-root-removed:
  file.absent:
    - name: /srv/salt/ssh/files

saltplusplus-config-ssh-pub-key-absent:
  file.absent:
    - name: /root/.ssh/id_{{ keytype }}.pub

saltplusplus-config-ssh-key-absent:
  file.absent:
    - name: /root/.ssh/id_{{ keytype }}

saltplusplus-config-ssf-git-script-absent:
  file.absent:
    - name: /srv/salt/ssf/files/fishers/git/git_30_create_PR.sh

saltplusplus-config-ssf-file-root-absent:
  file.absent:
    - name: /srv/salt/ssf/files/fishers/git

{%- set repo_location = saltplusplus.ssf.repo_location %}
{%- for name, data in saltplusplus.ssf.repos.items() %}
{%- set origin = data['origin'] %}
saltplusplus-config-ssf-repos-{{ name|replace('_', '-') }}-absent:
  file.absent:
    - name: {{ repo_location }}/{{ name }}
{%- endfor %}

saltplusplus-config-ssf-repos-dir-absent:
  file.absent:
    - name: {{ repo_location }}
