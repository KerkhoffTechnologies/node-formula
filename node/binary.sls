{% set node = pillar.get('node', {}) -%}
{% set version = node.get('version', '5.7.0') -%}
{% set checksum = node.get('checksum', '25b2d3b7dd57fe47a483539fea240a3c6bbbdab4d89a45a812134cf1380ecb94') -%}
{% set pkgname = 'node-v' ~ version ~ '-linux-x64' -%}

Get binary package:
  file.managed:
    - name: /usr/local/src/{{ pkgname }}.tar.gz
    - source: https://nodejs.org/dist/v{{ version }}/{{ pkgname }}.tar.gz
    - source_hash: sha256={{ checksum }}

Extract binary package:
  archive.extracted:
    - name: /usr/local/src/
    - source: /usr/local/src/{{ pkgname }}.tar.gz
    - archive_format: tar
    - if_missing: /usr/local/src/{{ pkgname }}

Copy lib:
  cmd.run:
    - cwd: /usr/local/src/{{ pkgname }}/
    - name: cp -r bin/ include/ lib/ share/ /usr/local/
    - unless: cmp /usr/local/bin/node /usr/local/src/{{ pkgname }}/bin/node
