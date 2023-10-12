base:
  'roles:Probe':
    - match: grain
    - splitpoint.promtail

  'roles:Server':
    - match: grain
    - splitpoint.loki
