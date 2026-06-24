import subprocess


def executar(comando: str) -> str:
    """
    Executa um comando Linux e retorna sua saída.
    Nunca lança exceção para o Flask.
    """

    try:

        resultado = subprocess.run(
            comando,
            shell=True,
            capture_output=True,
            text=True,
        )

        return resultado.stdout.strip()

    except Exception:

        return ""
