import psutil
import socket
from app.core.database import insert_metrics


class MetricsService:

    @staticmethod
    def hostname():
        return socket.gethostname()

    @staticmethod
    def snapshot():

        cpu = psutil.cpu_percent(interval=0.3)
        mem = psutil.virtual_memory().percent
        disk = psutil.disk_usage('/').percent
        host = MetricsService.hostname()

        insert_metrics(host, cpu, mem, disk)

        return {
            "host": host,
            "cpu": cpu,
            "mem": mem,
            "disk": disk
        }
