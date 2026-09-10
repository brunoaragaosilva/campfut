@echo off
echo === Compilando o Campfut para Web ===
call flutter build web --output docs --base-href "/campfut/"

echo === Garantindo o arquivo .nojekyll ===
if not exist docs\.nojekyll type nul > docs\.nojekyll

echo === Enviando alteracoes para o GitHub ===
git add -f docs
git commit -m "build: deploy automatico via script"
git push origin main

echo === Deploy concluido com sucesso! ===
pause