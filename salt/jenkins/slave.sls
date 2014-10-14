include:
  - git
  - java

jenkins:
  user.present:
    - home: /home/jenkins
    - shell: /bin/sh
    - gid_from_name: True
    - require:
      - group: jenkins
  group:
    - present

{{ pillar['pubkeys']['jenkins_master']['key'] }}:
  ssh_auth.present:
    - user: jenkins
    - enc: {{ pillar['pubkeys']['jenkins_master']['enc'] }}
    - comment: {{ pillar['pubkeys']['jenkins_master']['comment'] }}
    - require:
      - user: jenkins

git.paas.hpcloud.net:
  ssh_known_hosts.present:
    - user: jenkins
    - fingerprint: 'de:8e:45:ae:08:f0:73:fb:b1:ff:23:c9:84:d7:f9:75'

build_env:
  pkg.installed:
    - pkgs:
      - {{ pillar['package']['java_sdk'] }}
      - maven
      - python-virtualenv
{% if grains['os_family'] == 'Debian' %}
      - build-essential
      - python-dev
{% elif grains['os_family'] == 'RedHat' %}
      - python-devel
      - gcc
      - gcc-c++
      - make
      - autoconf
      - pkgconfig
      - libtool
{% endif %}
