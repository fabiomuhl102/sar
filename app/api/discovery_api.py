from flask import Blueprint, jsonify
from app.services.discovery_service import DiscoveryService

discovery_api = Blueprint("discovery_api", __name__)


@discovery_api.route("/api/discovery")
def discovery():

    hosts = DiscoveryService.scan_network()

    return jsonify(hosts)
