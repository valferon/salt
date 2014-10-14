include:
  - nginx

/etc/nginx/conf.d/jenkins.conf:
  file:
    - managed
    - template: jinja
    - source: salt://jenkins/files/jenkins.conf
    - user: www-data
    - group: www-data
    - mode: 440
    - require:
      - pkg: jenkins

extend:    
  nginx:
    service:
      - watch:
        - file: /etc/nginx/conf.d/jenkins.conf
