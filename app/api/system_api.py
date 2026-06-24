from flask import Blueprint, jsonify
from app.services.metrics_service import MetricsService

system_api = Blueprint("system_api", __name__)


@system_api.route("/api/metrics")
def metrics():

    return jsonify(MetricsService.snapshot())
