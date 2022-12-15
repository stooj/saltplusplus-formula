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
