from flask import Flask

from app.core.database import init_db

# Routes
from app.routes.dashboard import dashboard_bp

# API
from app.api.system_api import system_api

from app.api.history_api import history_api

from app.api.discovery_api import discovery_api

from app.api.cluster_api import cluster_api

from app.api.alerts_api import alerts_api

from app.api.metrics_api import metrics_api

from app.api.metrics_history_api import metrics_history_api

def create_app():
    
    app = Flask(
        __name__,
        template_folder="templates",
        static_folder="static"
    )

    # =========================
    # INIT SISTEMA (DB primeiro)
    # =========================

    init_db()

    # =========================
    # BLUEPRINTS
    # =========================

    app.register_blueprint(dashboard_bp)
    app.register_blueprint(system_api)
    app.register_blueprint(history_api)
    app.register_blueprint(discovery_api)
    app.register_blueprint(cluster_api)
    app.register_blueprint(alerts_api)
    app.register_blueprint(metrics_api)
    app.register_blueprint(metrics_history_api) 


    # =========================
    # HEALTHCHECK
    # =========================

    @app.route("/health")
    def health():
        return {"status": "ok"}

    return app


if __name__ == "__main__":

    app = create_app()

    app.run(
        host="0.0.0.0",
        port=8088,
        debug=False
    )
