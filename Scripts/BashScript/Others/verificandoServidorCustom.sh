#!/bin/bash

echo "Subindo Servidor da Página de Customização"

ssh dev@172.17.0.55
echo "Digite a Senha 'dev', depois o Caminho: 'http-server /var/www/html/ftcustomizacao-app/build/' "
echo "Senha -------> dev"
echo "Path: -------> http-server /var/www/html/ftcustomizacao-app/build/"
# ssh dev@172.17.0.55

codigo_http=$(curl --write-out %{http_code} --silent --output /dev/null http://172.17.0.55:8080/)
echo $codigo_http

if [ $codigo_http -ne 200 ]; then

  echo "Houve um problema com o servidor, tentando reiniciá-lo  $(date +%F\ %T)" >>/logs/servidor.log

  systemctl restart httpd

fi
