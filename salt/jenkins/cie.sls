include:
  - jenkins.slave

/home/jenkins/.ssh/id_rsa:
  file.managed:
    - user: jenkins
    - group: jenkins
    - mode: 0600
    - require:
      - user: jenkins
    - contents: |
{{ pillar['jenkins_cie_private_key']|indent(8, true) }}

/home/jenkins/.ssh/id_rsa.pub:
  file.managed:
    - user: jenkins
    - group: jenkins
    - mode: 0644
    - require:
      - user: jenkins
    - contents: |
{{ pillar['jenkins_cie_public_key']|indent(8, true) }}

/etc/sudoers.d/20-jenkins:
  file.managed:
    - user: root
    - group: root
    - mode: 0440
    - source: salt://jenkins/files/sudoers
