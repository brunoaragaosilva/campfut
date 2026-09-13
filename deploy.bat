@echo off
echo === Limpando build anterior ===
call flutter clean

echo === Obtendo dependencias ===
call flutter pub get

echo === Compilando o Campfut para Web na pasta docs ===
call flutter build web --output docs --base-href "/campfut/"

echo === Garantindo o arquivo .nojekyll ===
if not exist docs\.nojekyll type nul > docs\.nojekyll

echo === Enviando alteracoes para o GitHub ===
git add docs
git commit -m "fix: atualiza build web completo com tela de login e Firebase"
git push origin main

echo === Deploy concluido com sucesso! ===
pause