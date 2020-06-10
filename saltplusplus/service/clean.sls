# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import saltplusplus with context %}

saltplusplus-service-clean-service-dead:
  service.dead:
    - name: {{ saltplusplus.service.name }}
    - enable: False
