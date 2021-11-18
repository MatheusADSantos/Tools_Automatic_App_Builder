#!/bin/bash

# Criei esse .sh apenas para testar as chamadas do script em python, para que ative o venv e chame o script
source ~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/Python/environmentAutomation/bin/activate

scriptPython=$1
scriptPython=$([[ $scriptPython == '' ]] && echo 'gerar icons' || echo $scriptPython)
echo "Script: -----> $scriptPython"

sleep 2

case $scriptPython in
'gerar icons')
  appName=$2
  appName=$([[ $appName == '' ]] && echo 'Notificação' || echo $appName)
  echo "App Name: -----> $appName"
  sleep 2
  python ~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/Python/generatorIcons.py "$appName"
  ;;

'gerar jsons')
  emailFirebase=$2
  emailFirebase=$([[ $emailFirebase == '' ]] && echo 'ftgestoradados@gmail.com' || echo $emailFirebase)
  echo "Email Firebase: -----> $emailFirebase"
  sleep 2
  python ~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/Python/generatorJsons.py $emailFirebase
  ;;

*)
  echo -n "unknown........"
  ;;
esac

deactivate
