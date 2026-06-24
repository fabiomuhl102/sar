"""
Configurações do Banco de Dados
"""

from app.config.settings import DB_PATH


def get_database_path():
    """
    Retorna o caminho do banco de dados.
    """
    return DB_PATH
