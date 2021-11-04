# !/bin/bash -i

print_light_gray() {
  printf "\e[1;37m$1\e[0m"
}
print_red() {
  printf "\e[0;31m$1\e[0m"
}
print_light_red() {
  printf "\e[1;31m$1\e[0m"
}
print_blue() {
  printf "\e[0;34m$1\e[0m"
}
print_light_blue() {
  printf "\e[1;34m$1\e[0m"
}
print_green() {
  printf "\e[0;32m$1\e[0m"
}
print_light_green() {
  printf "\e[1;32m$1\e[0m"
}

indice=$1
projectFmobile=$2
device=$3
pathProjects=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/AABTolls/Projetos

dealWithPrints() {
  print_light_red "\n\nEntrando com os parametros: \n"
  print_blue "- Indice do Projeto: $indice \n- Versão do Projeto: $projectFmobile \n- Device: $device\n\n"

  getInformation

  if [[ $projectFmobile == '5' ]]; then
    gettingPrintsFromFmobile5
  else
    gettingPrintsFromFmobile6
  fi

  searchingAndRemovingDevicePrints
  
  # Removendo o cache do app
  adb -s $device shell pm clear $bundle
}

searchingAndRemovingDevicePrints() {
  # external_storage=$(adb shell 'echo -e EXTERNAL_STORAGE')
  external_storage=$(adb -s $device shell 'echo -e $EXTERNAL_STORAGE')
  pathScreenshotsInDevice=$external_storage/DCIM/Screenshots
  pathScreenshotsInProject="$pathProjects/$projeto/IMAGENS/prints/Android"
  # bundle=$bundleAndroid
  print_light_red "\n\n-external_storage: $external_storage \n-pathScreenshotsInDevice: $pathScreenshotsInDevice \n-pathScreenshotsInProject: $pathScreenshotsInProject \n-bundle: $bundle\n\n"

  # numberOfOccurrences=$(adb shell 'ls sdcard/DCIM/Screenshots' | awk "/$bundle/{print}" | grep -c "Screenshot")
  # print_light_red "\nNumber of Occurrences: $numberOfOccurrences\n\n\n"

  numberOfOccurrences=$(adb -s $device shell 'ls sdcard/DCIM/Screenshots' | awk "/$bundle/{print}" | grep -c "$bundle")
  numberOfOccurrences2=$numberOfOccurrences
  print_light_red "\nNumber of Occurrences: $numberOfOccurrences\n\n\n"

  while [[ $numberOfOccurrences > 0 ]]; do
    print=$(adb -s $device shell 'ls sdcard/DCIM/Screenshots' | awk "/$bundle/{print}" | awk "NR==$numberOfOccurrences{print}")
    print_light_red "\nBuscando os prints do celular para a pasta do projeto... \n$numberOfOccurrences - Print: "$print" \n\n\n"

    adb -s $device pull $pathScreenshotsInDevice/"$print" "$pathScreenshotsInProject"

    # Criando pasta de prints que vão pra loja (08 prints)
    case $print in
    "Autenticacao1_$bundle.png")
      print_green "Selecionando o print $print pra loja!"
      sleep 1
      adb -s $device pull $pathScreenshotsInDevice/"$print" "$pathScreenshotsInProject/Loja"
      ;;
    "GridPrincipal_$bundle.png")
      print_green "Selecionando o print $print pra loja!"
      sleep 1
      adb -s $device pull $pathScreenshotsInDevice/"$print" "$pathScreenshotsInProject/Loja"
      ;;
    "DetalhesDoRastreado_$bundle.png")
      print_green "Selecionando o print $print pra loja!"
      sleep 1
      adb -s $device pull $pathScreenshotsInDevice/"$print" "$pathScreenshotsInProject/Loja"
      ;;
    "CercaRapida_$bundle.png")
      print_green "Selecionando o print $print pra loja!"
      sleep 1
      adb -s $device pull $pathScreenshotsInDevice/"$print" "$pathScreenshotsInProject/Loja"
      ;;
    "PermanenciaEmPonto_$bundle.png")
      print_green "Selecionando o print $print pra loja!"
      sleep 1
      adb -s $device pull $pathScreenshotsInDevice/"$print" "$pathScreenshotsInProject/Loja"
      ;;
    "RastreadoNoMapa_$bundle.png")
      print_green "Selecionando o print $print pra loja!"
      sleep 1
      adb -s $device pull $pathScreenshotsInDevice/"$print" "$pathScreenshotsInProject/Loja"
      ;;
    "Mapa_$bundle.png")
      print_green "Selecionando o print $print pra loja!"
      sleep 1
      adb -s $device pull $pathScreenshotsInDevice/"$print" "$pathScreenshotsInProject/Loja"
      ;;
    "Notificacoes_$bundle.png")
      print_green "Selecionando o print $print pra loja!"
      sleep 1
      adb -s $device pull $pathScreenshotsInDevice/"$print" "$pathScreenshotsInProject/Loja"
      ;;
    esac

    sleep 1
    numberOfOccurrences=$((numberOfOccurrences - 1))
  done

  while [[ $numberOfOccurrences2 > 0 ]]; do
    # adb -s $device shell 'ls sdcard/DCIM/Screenshots' | awk "/$bundle/{print}" | grep -c "$bundle"
    print=$(adb -s $device shell 'ls sdcard/DCIM/Screenshots' | awk "/$bundle/{print}" | awk "NR==$numberOfOccurrences2{print}")
    print_light_red "\nRemovendo os prints do celular... \n$numberOfOccurrences2 - Print: "$print" \n\n\n"

    adb -s $device shell rm $pathScreenshotsInDevice/"$print"

    sleep 1
    numberOfOccurrences2=$((numberOfOccurrences2 - 1))
  done
}

getInformation() {
  pathProjects=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/AABTolls/Projetos
  cd $pathProjects
  touch projetos.txt            #Criando projetos.txt
  printf "$(ls)" >>projetos.txt #Inserindo o conteúdo no projetos.txt

  # projetos=$( awk '//{print}' projetos.txt  | awk '{ gsub("customs_fmobile_6.0.txt","");
  # gsub("todas_customs.txt",""); gsub("OLD",""); gsub("projetos.txt",""); print }' )

  projetos=$(awk '//{print}' projetos.txt | awk '{ gsub("customs_fmobile_6.0.txt",""); 
  gsub("todas_customs.txt",""); gsub("OLD",""); gsub("projetos.txt",""); print }' | awk 'BEGIN {RS=""}{gsub(/\n/,"\n",$0); print}')

  projeto=$(grep "$indice" projetos.txt | awk 'NR==1{print $1}')
  rm projetos.txt

  print_light_red "\n\n>>> PROJETOS EXISTENTES <<< \n"
  print_green "$projetos\n\n"
  sleep 2

  if [[ $projeto != '' ]]; then
    print_light_red "\n-> Projeto selecionado com o indice ($indice): \n"
    print_green "$projeto\n\n"
    sleep 2

    cd $pathProjects/"$projeto"/
    bundle=$(awk '/Bundle Android/{print $0}' info.txt | awk '{sub(/Bundle Android: /,""); print}')

    print_light_red "\n-> INDICE: $indice \n-> PROJETO: $projeto \n-> BUNDLE: $bundle\n\n\n"
    sleep 2

    sh ~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript/unlockDevice.sh
  else
    print_light_red "\n-> Não temos nenhum projeto com o indice ($indice)..........\n\n"
  fi
}



gettingPrintsFromFmobile6() {
  pathToScreenshots=sdcard/DCIM/Screenshots
  # https://developer.android.com/studio/command-line/adb -s $device#IntentSpec
  adb -s $device shell pm clear $bundle
  adb -s $device shell am start -n $bundle/.ui.activity.authentication.SplashScreenActivity

  # adb -s 192.168.86.4:5555 shell pm clear br.com.gcrastreador
  # adb -s 192.168.86.4:5555  shell am start -n br.com.gcrastreador/.ui.activity.authentication.SplashScreenActivity

  #Tela de autenticacao 1
  sleep 7
  adb -s $device shell screencap $pathToScreenshots/Autenticacao1_"$bundle".png
  sleep 4
  # adb -s $device shell input tap 500 1050
  adb -s $device  shell input tap 500 1013
  adb -s $device shell input text "14123456789"
  adb -s $device shell input keyevent 66

  # Tela de autenticacao 2
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/Autenticacao2_"$bundle".png
  adb -s $device shell input tap 80 700
  adb -s $device shell input text "54321"
  adb -s $device shell input keyevent 66

  # Tela grip principal com os rastreados
  sleep 7
  adb -s $device shell screencap $pathToScreenshots/GridPrincipal_"$bundle".png

  # Tela MAPA
  adb -s $device shell input tap 300 2250
  sleep 9
  adb -s $device shell screencap $pathToScreenshots/Mapa_"$bundle".png

  # Tela Notificação
  adb -s $device shell input tap 600 2250
  sleep 7
  adb -s $device shell screencap $pathToScreenshots/Notificacoes_"$bundle".png

  # Tela MAIS
  adb -s $device shell input tap 900 2250
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/Mais_"$bundle".png

  # Tela Detalhes do Rastreado
  adb -s $device shell input tap 150 2250
  sleep 2
  adb -s $device shell input tap 1040 800
  sleep 4
  adb -s $device shell screencap $pathToScreenshots/DetalhesDoRastreado_"$bundle".png

  # Tela Rastreado no mapa
  adb -s $device shell input tap 540 1150
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/RastreadoNoMapa_"$bundle".png

  # Tela Cerca Rápida
  adb -s $device shell input keyevent 4 #back
  adb -s $device shell input tap 540 1450
  sleep 6
  adb -s $device shell screencap $pathToScreenshots/CercaRapida_"$bundle".png

  # Tela Histórico de Posições
  adb -s $device shell input keyevent 4 #back
  sleep 4
  adb -s $device shell input tap 540 1400
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/HistoricoDePosicoes_"$bundle".png

  # Tela Permanencia em Ponto
  adb -s $device shell input keyevent 4 #back
  sleep 4
  adb -s $device shell input tap 540 1600
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/PermanenciaEmPonto_"$bundle".png

  # Tela Dados Consolidados
  adb -s $device shell input keyevent 4 #back
  sleep 4
  adb -s $device shell input tap 540 1700
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/DadosConsolidados_"$bundle".png

  # Tela Criar Ponto de Referência
  adb -s $device shell input keyevent 4 #back
  sleep 4
  adb -s $device shell input tap 540 1800
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/CriarPontoDeReferencia_"$bundle".png

  # Tela Consumo de Combustível
  adb -s $device shell input keyevent 4 #back
  sleep 4
  adb -s $device shell input tap 540 1900
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/ConsumoDeCombustivel_"$bundle".png

  # Tela de Sensores
  adb -s $device shell input keyevent 4 #back
  sleep 4
  adb -s $device shell input tap 540 2050
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/Sensores_"$bundle".png

  # Tela de Manutenções Programadas
  adb -s $device shell input keyevent 4 #back
  sleep 4
  adb -s $device shell input tap 540 2150
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/ManutencoesProgramadas_"$bundle".png

  # Tela de Bloquear Veiculos
  adb -s $device shell input keyevent 4 #back
  sleep 4
  adb -s $device shell input swipe 100 1450 100 500 100
  sleep 3
  adb -s $device shell input tap 540 2150
  sleep 5
  adb -s $device shell screencap $pathToScreenshots/BloquearVeiculos_"$bundle".png

  adb -s $device shell input keyevent 4 #back
  adb -s $device shell input keyevent 4 #back
  adb -s $device shell input keyevent 4 #back
}


gettingPrintsFromFmobile5() {
  pathToScreenshots=sdcard/DCIM/Screenshots
  # https://developer.android.com/studio/command-line/adb -s $device#IntentSpec
  adb -s $device shell pm clear $bundle # Limpando o CACHE do aplicativo ...
  adb -s $device shell am start -n $bundle/.MainActivity

  #Tela de autenticacao 1
  sleep 3
  adb -s $device shell screencap $pathToScreenshots/Autenticacao1_"$bundle".png
  sleep 1
  adb -s $device shell input tap 500 1400
  adb -s $device shell input text "14123456789"
  adb -s $device shell input keyevent 66

  # Tela de autenticacao 2
  sleep 3
  adb -s $device shell screencap $pathToScreenshots/Autenticacao2_"$bundle".png
  adb -s $device shell input tap 80 1300
  adb -s $device shell input text "54321"
  adb -s $device shell input keyevent 66

  # Tela grip principal com os rastreados
  sleep 3
  adb -s $device shell screencap $pathToScreenshots/GridPrincipal_"$bundle".png

  # Tela MAPA
  adb -s $device shell input swipe 500 1400 100 1400 100 # Swipe da direita pra esquerda
  sleep 3
  adb -s $device shell input keyevent 4
  sleep 6
  adb -s $device shell screencap $pathToScreenshots/Mapa_"$bundle".png

  # Tela Menu Principal
  sleep 1
  adb -s $device shell input swipe 100 1400 500 1400 100 # Swipe da esquerda pra direita
  sleep 1
  adb -s $device shell input swipe 100 2000 100 1000 100 # Swipe de baixo pra cima
  sleep 1
  adb -s $device shell input tap 50 150
  sleep 2
  adb -s $device shell screencap $pathToScreenshots/MenuPrincipal"$bundle".png

  # Tela Mapa do Rastreado
  adb -s $device shell input keyevent 4
  sleep 1
  # adb -s $device shell input tap 540 1000
  adb -s $device shell input tap 540 1600
  sleep 1
  adb -s $device shell input tap 540 1500
  sleep 1
  adb -s $device shell screencap $pathToScreenshots/MapaDoRastreado_"$bundle".png

  # Tela de Menu do Rastreado
  adb -s $device shell input tap 1000 2200
  sleep 1
  adb -s $device shell screencap $pathToScreenshots/MenuDoRastreado"$bundle".png

  # Tela de Eventos do Rastreado
  adb -s $device shell input tap 800 500
  sleep 2
  adb -s $device shell input tap 500 500
  sleep 2
  adb -s $device shell input tap 500 1300
  sleep 6
  adb -s $device shell screencap $pathToScreenshots/EventosDoRastreado"$bundle".png

  # Tela de Rotas do Evento
  adb -s $device shell input swipe 500 1400 100 1400 100 # Swipe da direita pra esquerda
  sleep 2
  adb -s $device shell input tap 540 1500
  # adb -s $device shell input keyevent 4
  sleep 18
  adb -s $device shell screencap $pathToScreenshots/RotasDoRastreado"$bundle".png

  adb -s $device shell input keyevent 4 #back
  adb -s $device shell input keyevent 4 #back
  adb -s $device shell input keyevent 4 #back
}



dealWithPrints