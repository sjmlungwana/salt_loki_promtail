downloading promatil:
  cmd.run:
    - name: sudo curl -s https://api.github.com/repos/grafana/loki/releases/latest | grep browser_download_url |  cut -d '"' -f 4 | grep promtail-linux-amd64.zip | wget -i -

unzip promtail:
  cmd.run:
    - name: unzip promtail-linux-amd64.zip && sudo mv promtail-linux-amd64 /usr/local/bin/promtail

send promtail across:
  file.managed:
    - makedirs: True
    - template: jinja
    - name: /etc/promtail-local-config.yaml
    - source: salt://promtail/promtail-local-config.yaml

create a service:
  file.managed:
    - makedirs: True
    - name: /etc/systemd/system/promtail.service
    - source: salt://promtail/promtail.service

reload daemon:
  cmd.run:
    - name: sudo systemctl daemon-reload

start promtail:
  cmd.run:
    - name: sudo systemctl start promtail.service
