import socket
import requests


class DiscoveryService:

    @staticmethod
    def scan_network(prefix="192.168.0"):

        active_hosts = []

        for i in range(1, 30):  # range curto para não travar
            ip = f"{prefix}.{i}"

            try:
                url = f"http://{ip}:8088/api/metrics"
                r = requests.get(url, timeout=0.3)

                if r.status_code == 200:
                    data = r.json()
                    active_hosts.append({
                        "host": data.get("host", ip),
                        "ip": ip
                    })

            except:
                continue

        return active_hosts
