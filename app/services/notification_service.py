import requests
from app.core.notify_config import (
    TELEGRAM_ENABLED,
    TELEGRAM_BOT_TOKEN,
    TELEGRAM_CHAT_ID,
    WEBHOOK_ENABLED,
    WEBHOOK_URL
)


class NotificationService:

    @staticmethod
    def send_telegram(message):

        if not TELEGRAM_ENABLED:
            return

        try:
            url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"

            payload = {
                "chat_id": TELEGRAM_CHAT_ID,
                "text": message
            }

            requests.post(url, data=payload, timeout=3)

        except Exception as e:
            print("Telegram error:", e)

    @staticmethod
    def send_webhook(data):

        if not WEBHOOK_ENABLED:
            return

        try:
            requests.post(WEBHOOK_URL, json=data, timeout=3)

        except Exception as e:
            print("Webhook error:", e)

    @staticmethod
    def notify(alert):

        message = (
            f"🚨 ALERTA {alert['severity'].upper()}\n"
            f"Host: {alert['host']}\n"
            f"Tipo: {alert['type']}\n"
            f"Valor: {alert['value']}%\n"
            f"Hora: {alert['time']}"
        )

        # Telegram
        NotificationService.send_telegram(message)

        # Webhook
        NotificationService.send_webhook(alert)
