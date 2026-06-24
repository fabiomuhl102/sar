from flask import Blueprint, render_template
from app.services.system_service import SystemService

dashboard_bp = Blueprint("dashboard", __name__)


@dashboard_bp.route("/")
def home():

    return render_template(
        "dashboard.html",
        data={
            "hostname": SystemService.hostname(),
            "uptime": SystemService.uptime(),
            "load": SystemService.load(),
            "memoria": SystemService.memoria(),
            "disco": SystemService.disco(),
            "docker": SystemService.docker(),
        }
    )
