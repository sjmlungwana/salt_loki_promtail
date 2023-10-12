download loki:
  cmd.run:
    - name: sudo curl -s https://api.github.com/repos/grafana/loki/releases/latest | grep browser_download_url |  cut -d '"' -f 4 | grep loki-linux-amd64.zip | wget -i -

install unzip:
  cmd.run:
    - name: sudo apt install unzip

unzip loki:
  cmd.run:
    - name: sudo unzip loki-linux-amd64.zip

move loki pkg:
  cmd.run:
    - name: sudo mv loki-linux-amd64 /usr/local/bin/loki

make data storage for loki:
  cmd.run:
    - name: sudo mkdir -p /data/loki

copy loki configuration file:
  file.managed:
    - name: /etc/loki-local-config.yaml
    - source: salt://promtail/loki-local-config.yaml

copy service file:
  file.managed:
    - name: /etc/systemd/system/loki.service
    - source: salt://promtail/loki.service

reload daemon:
  cmd.run:
    - name: sudo systemctl daemon-reload

start loki service:
  cmd.run:
    - name: sudo systemctl start loki.service
