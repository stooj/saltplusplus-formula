# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import saltplusplus with context %}

include:
  - {{ sls_config_file }}

saltplusplus-service-running-service-running:
  service.running:
    - name: {{ saltplusplus.service.name }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
