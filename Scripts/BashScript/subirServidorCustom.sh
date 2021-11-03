#!/bin/bash

#Subindo Servidor da Página de Customização
echo "Subindo Servidor da Página de Customização"

echo "Digite a Senha 'dev', depois o Caminho: 'http-server /var/www/html/ftcustomizacao-app/build/' "
echo "Senha -------> dev"
echo "Path: -------> http-server /var/www/html/ftcustomizacao-app/build/"
ssh dev@172.17.0.55

#Subiu Servidor com Sucesso!!!
echo "Subiu Servidor com Sucesso!!!"