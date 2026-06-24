from flask import Flask, jsonify, Response
import subprocess
import time

app = Flask(__name__)

history_cpu = []
history_mem = []
history_load = []
history_disk = []
history_time = []

# -----------------------------
# EXEC COMANDO
# -----------------------------
def cmd(c):
    return subprocess.getoutput(c)

# -----------------------------
# MÉTRICAS
# -----------------------------
def get_cpu():
    return float(cmd("grep 'cpu ' /proc/stat | awk '{u=($2+$4)*100/($2+$4+$5)} END {print u}'").replace(",", "."))

def get_mem():
    return float(cmd("awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {print (t-a)*100/t}' /proc/meminfo").replace(",", "."))

def get_load():
    return float(cmd("cat /proc/loadavg | awk '{print $1}'").replace(",", "."))

def get_disk():
    return float(cmd("df / | awk 'NR==2 {gsub(\"%\",\"\",$5); print $5}'"))

# -----------------------------
# STATUS ALERTA
# -----------------------------
def status(v, warn, crit):
    if v >= crit:
        return "CRITICO"
    elif v >= warn:
        return "ALERTA"
    return "OK"

# -----------------------------
# API JSON
# -----------------------------
@app.route("/api/metrics")
def api_metrics():

    cpu = get_cpu()
    mem = get_mem()
    load = get_load()
    disk = get_disk()

    now = time.strftime("%H:%M:%S")

    history_cpu.append(cpu)
    history_mem.append(mem)
    history_load.append(load)
    history_disk.append(disk)
    history_time.append(now)

    history_cpu[:] = history_cpu[-30:]
    history_mem[:] = history_mem[-30:]
    history_load[:] = history_load[-30:]
    history_disk[:] = history_disk[-30:]
    history_time[:] = history_time[-30:]

    return jsonify({
        "labels": history_time,
        "cpu": history_cpu,
        "mem": history_mem,
        "load": history_load,
        "disk": history_disk,
        "status": {
            "cpu": status(cpu, 70, 85),
            "mem": status(mem, 75, 90),
            "disk": status(disk, 80, 90)
        }
    })

# -----------------------------
# FRONTEND
# -----------------------------
@app.route("/")
def home():
    return Response("""
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>SAR DASHBOARD PRO</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body {
    background:#0b0f14;
    color:#fff;
    font-family:Arial;
    padding:20px;
}

.grid {
    display:grid;
    grid-template-columns: 1fr 1fr;
    gap:20px;
}

.card {
    background:#161b22;
    padding:15px;
    border-radius:10px;
}

h2 { color:#00ff99; }

.status {
    margin:10px 0;
    font-size:14px;
}
</style>
</head>

<body>

<h1>🚀 SAR Dashboard PRO</h1>

<div class="status">
CPU: <span id="cpuStatus">-</span> |
MEM: <span id="memStatus">-</span> |
DISK: <span id="diskStatus">-</span>
</div>

<div class="grid">

<div class="card">
<h2>CPU %</h2>
<canvas id="cpu"></canvas>
</div>

<div class="card">
<h2>Memória %</h2>
<canvas id="mem"></canvas>
</div>

<div class="card">
<h2>Load</h2>
<canvas id="load"></canvas>
</div>

<div class="card">
<h2>Disco %</h2>
<canvas id="disk"></canvas>
</div>

</div>

<script>

let charts = {}

async function load() {
    const r = await fetch('/api/metrics');
    return await r.json();
}

function createOrUpdate(id, label, data, color) {

    if (!charts[id]) {
        charts[id] = new Chart(document.getElementById(id), {
            type: 'line',
            data: {
                labels: [],
                datasets: [{
                    label: label,
                    data: [],
                    borderColor: color,
                    tension: 0.3
                }]
            }
        });
    }

    charts[id].data.labels = data.labels;
    charts[id].data.datasets[0].data = data[id];
    charts[id].update();
}

async function render() {

    const d = await load();

    createOrUpdate("cpu", "CPU %", d, "#00ff99");
    createOrUpdate("mem", "Memória %", d, "#00b3ff");
    createOrUpdate("load", "Load", d, "#ffcc00");
    createOrUpdate("disk", "Disco %", d, "#ff4d4d");

    document.getElementById("cpuStatus").innerText = d.status.cpu;
    document.getElementById("memStatus").innerText = d.status.mem;
    document.getElementById("diskStatus").innerText = d.status.disk;
}

render();
setInterval(render, 5000);

</script>

</body>
</html>
""", mimetype="text/html")

# -----------------------------
# START
# -----------------------------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8088)
