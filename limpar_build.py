import os
import shutil
import subprocess
from pathlib import Path
def restaurar_ambiente():
print("[1/4] Identificando pasta home real do usuario...")
home = Path.home()
cache_gradle = home / ".gradle" / "caches"
if cache_gradle.exists():
print(f"-> Localizado cache global em: {cache_gradle}")
try:
shutil.rmtree(cache_gradle)
print("-> Cache corrompido removido com sucesso!")
except Exception as e:
print(f"-> Erro ao apagar automaticamente: {e}")
print("-> Feche o VS Code se houver arquivos travados e tente
novamente.")
else:
print("-> Pasta de cache global não encontrada no diretório home padrão.")
print("
[2/4] Executando limpeza local do Flutter...")
subprocess.run("flutter clean", shell=True)
print("
[3/4] Atualizando dependencias do projeto...")

1

subprocess.run("flutter pub get", shell=True)
print("
[4/4] Iniciando nova compilacao limpa...")
subprocess.run("flutter build apk --release", shell=True)
if __name__ == '__main__':
restaurar_ambiente()