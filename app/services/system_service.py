from app.core.system import executar


class SystemService:

    @staticmethod
    def hostname():

        return executar("hostname")


    @staticmethod
    def uptime():

        return executar("uptime -p")


    @staticmethod
    def load():

        return executar("cat /proc/loadavg | awk '{print $1,$2,$3}'")


    @staticmethod
    def memoria():

        return executar(
            "free -h | awk '/Mem:/ {print $3\" / \"$2}'"
        )


    @staticmethod
    def disco():

        return executar(
            "df -h / | awk 'NR==2 {print $3\" / \"$2\" (\"$5\")\"}'"
        )


    @staticmethod
    def docker():

        return executar(
            "docker ps -q | wc -l"
        )
