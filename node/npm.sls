# -*- coding: utf-8 -*-
# vim: ft=jinja
{% set npms = salt['pillar.get']('node:npms',default={}) -%}
{% for package in npms -%}
{{ package }}_pip_install:
  npm.installed:
    - name: {{ package }}
{% endfor -%}
