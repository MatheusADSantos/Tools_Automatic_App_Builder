#!/bin/bash

# caminhoRaiz=$(pwd);
# pathKeystores=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/AABTolls/Keystores/

# echo -e $"\nCaminho de origem do gerador de keystore: /Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk/Contents/Home"
# # cd /Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home
# cd /Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk/Contents/Home
# echo -e $"Nome do Arquivo: "
# read nome
# sudo keytool -genkey -v -keystore $nome.keystore -alias $nome -keyalg RSA -keysize 2048 -validity 10000
# # sudo mv $nome.keystore /Users/macbook-estagio/Desktop
# sudo mv $nome.keystore $pathKeystores #/Users/macbook-estagio/Desktop
# echo -e $"Keystore Gerada!!! \nSua keystore estará em: $pathKeystores"

# sh $pathScripts/generatorKeystore.sh $nomeDaKeystore $alias
nomeDaKeystore=$1
alias=$2
password=$3
echo -e "\n\nChamou generatorKeystore.sh ... \n$nomeDaKeystore(Nome da Keystore) \n$alias(Alias) \n\n***Password: $password"

if [[ $nomeDaKeystore == '' || $alias == '' ]]; then
  echo -e "Você precisa passar os parametros pra gerar a keystore!!!"
  afplay /System/Library/Sounds/Blow.aiff
  osascript -e 'display alert "ATENÇÃO!" message "Você precisa passar os parametros pra gerar a keystore!!! \n\nParametro1: Nome da Keystore \nParametro2: Nome do Alias" '

  echo -e "\nNome da Keystore: "
  read nomeDaKeystore

  echo -e "\nNome da Alias: "
  read alias

  # sh $pathScripts/generatorKeystore.sh $nomeDaKeystore $alias
fi

keystorePath=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/AABTolls/Keystores/
# generatorPathOfKeystore=~/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk/Contents/Home
generatorPathOfKeystore=/Library/Java/JavaVirtualMachines/jdk-11.0.12.jdk

cd $generatorPathOfKeystore
sudo keytool -genkey -v -keystore $nomeDaKeystore.keystore -alias $alias -keyalg RSA -keysize 2048 -validity 10000
sudo mv $nomeDaKeystore.keystore $keystorePath
echo -e $"Keystore Gerada!!! \nSua keystore estará em: $pathKeystores"
