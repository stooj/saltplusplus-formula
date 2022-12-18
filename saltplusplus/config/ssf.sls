# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import saltplusplus with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

saltplusplus-config-ssf-file-root-managed:
  file.directory:
    - name: /srv/salt/ssf/files/fishers/git
    - user: root
    - group: root
    - mode: 700
    - makedirs: True

saltplusplus-config-ssf-git-script-managed:
  file.managed:
    - name: /srv/salt/ssf/files/fishers/git/git_30_create_PR.sh
    - source: {{ files_switch(['git_30_create_PR.sh'],
                              lookup='saltplusplus-config-ssf-git-script-managed'
          )
        }}
    - user: root
    - group: root
    - mode: 600
    - template: jinja
    - context:
        gh_api_key: {{ saltplusplus.ssf.api_keys.github }}
    - require:
      - saltplusplus-config-ssf-file-root-managed

{%- set repo_location = saltplusplus.ssf.repo_location %}
saltplusplus-config-ssf-repos-dir-managed:
  file.directory:
    - name: {{ repo_location }}
    - user: root
    - group: root
    - mode: 700
    - makedirs: True

{%- for name, data in saltplusplus.ssf.repos.items() %}
{%- set origin = data['origin'] %}
saltplusplus-config-ssf-repos-{{ name|replace('_', '-') }}-cloned:
  git.latest:
    - name: {{ origin }}
    - target: {{ repo_location }}/{{ name }}
    - user: root
    - require:
      - saltplusplus-config-ssf-repos-dir-managed

{%- for remote, url in data.items() %}
{%- if remote == 'origin' %}
{# Do nothing - already dealt with origin #}
{%- else %}
saltplusplus-config-ssf-repos-{{ name|replace('_', '-') }}-repo-{{ remote }}-added:
  cmd.run:
    - name: git remote add {{ remote }} {{ url }}
    - cwd: {{ repo_location }}/{{ name }}
    - runas: root
    - require:
      - saltplusplus-config-ssf-repos-{{ name|replace('_', '-') }}-cloned
    - unless:
      - grep 'remote "{{ remote }}"' {{ repo_location }}/{{ name }}/.git/config
{%- endif %}
{%- endfor %}

saltplusplus-config-ssf-repos-{{ name|replace('_', '-') }}-repo-remotes-fetched:
  cmd.run:
    - name: git fetch --all
    - cwd: {{ repo_location }}/{{ name }}
    - runas: root
    - require:
      - saltplusplus-config-ssf-repos-{{ name|replace('_', '-') }}-cloned
{%- endfor %}
