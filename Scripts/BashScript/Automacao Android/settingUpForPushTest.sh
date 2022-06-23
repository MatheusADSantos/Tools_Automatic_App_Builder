# !/bin/bash -i

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

# Selecionar o projeto
indice=$1
contato=$2
print_light_red "\n\n\n-> INDICE: $indice \n-> CONTATO: $contato\n"
sleep 5

# -------------------------------------------------------------------------------------------------------------------

getInformation() {
  # pathToRoot=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/
  # cd ~/Documents/tools-automatic-app-customs/Projetos
  # print_light_red "\n\n\n>>> PROJETOS EXISTENTES <<<\n"
  # print_green "$(ls) \n"
  # touch projetos.txt            #Criando projetos.txt
  # printf "$(ls)" >>projetos.txt #Inserindo o conteúdo no projetos.txt
  # resultadoDaBuscaDoProjeto=$(grep "$indice" projetos.txt)
  # projeto=$resultadoDaBuscaDoProjeto
  # rm projetos.txt

  pathToRoot=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/
  pathProjects=~/Documents/tools-automatic-app-customs/Projetos
  cd $pathProjects
  touch projetos.txt            #Criando projetos.txt
  printf "$(ls)" >>projetos.txt #Inserindo o conteúdo no projetos.txt
  projetos=$(awk '//{print}' projetos.txt | awk '{ gsub("customs_fmobile_6.0.txt",""); 
  gsub("todas_customs.txt",""); gsub("OLD",""); gsub("projetos.txt",""); print }' | awk 'BEGIN {RS=""}{gsub(/\n/,"\n",$0); print}')

  projeto=$(grep "$indice" projetos.txt | awk 'NR==1{print $1}')
  rm projetos.txt

  print_light_red "\n\n>>> PROJETOS EXISTENTES <<< \n"
  print_green "$projetos\n\n"
  sleep 2

  if [[ $projeto != '' ]]; then
    # print_light_red "\n\n>>>PORJETO EXISTE<<<\n"
    # print_green "Com o indice ($indice) temos o projeto: $projeto"

    print_light_red "\n-> Projeto selecionado com o indice ($indice): \n"
    print_green "$projeto\n\n"
    sleep 2

    cd ~/Documents/tools-automatic-app-customs/Projetos/"$projeto"/
    bundle=$(awk '/Bundle Android/{print $0}' info.txt | awk '{sub(/Bundle Android: /,""); print}')

    print_green "\n\n\n-> INDICE: $indice \n-> PROJETO: $projeto \n-> BUNDLE: $bundle\n\n"
  fi
}
getInformation

# -------------------------------------------------------------------------------------------------------------------

# # Buscado o device pra testar
# getDevice() {
#   touch devices.txt
#   printf "$(adb devices)" >>devices.txt
#   device=$(awk '/[[:digit:]]/ {print $ 1}' devices.txt)
#   echo -e "\nDevice(s) achado: $device"
#   rm devices.txt
# }

lookingDevicesAndIPAdress() {
  print_light_red "\n\n\n\n-----------------------      Looking Devices ...      ------------------------\n"

  if [[ $(adb devices | awk 'NR==3{print $1}') == '' && $(adb devices | awk 'NR==2{print $1}') == '' ]]; then
    $pathScripts/connectDeviceFromIPAdress.sh 'n'
  else
    if [[ $(adb devices | awk 'NR==3{print $1}') != '' ]]; then
      device=$(adb devices | awk 'NR==3{print $1}')
    else
      device=$(adb devices | awk 'NR==2{print $1}')
    fi
  fi

  print_green "\n\nDevice conectado!!!\nDevice: $device\n\n"
}
lookingDevicesAndIPAdress

# -------------------------------------------------------------------------------------------------------------------

confiCercaFmobile5() {
  sleep 2
  adb shell input tap 450 950 # Clicando em TEMPORARIO
  sleep 1
  adb shell input tap 950 950 # Clicando em IGNICAO LIGADA
  sleep 1
  adb shell input tap 200 1550 # Salvando configuração
  sleep 7
}

# -------------------------------------------------------------------------------------------------------------------

automateTestFmobile5() {
  adb shell pm clear $bundle # Limpando o CACHE do aplicativo ...
  adb shell am start -n $bundle/.MainActivity

  #Tela de autenticacao 1
  sleep 3
  adb shell input tap 500 1400
  adb shell input text $contato
  adb shell input keyevent 66

  # Tela de autenticacao 2
  # Pegando código do contato
  echo -e "http://fulltrack-tools.ftdata.com.br/smsMobile\n-> Qual o código gerado: "
  read codigo

  sleep 3
  adb shell input tap 80 1300
  adb shell input text $codigo
  adb shell input keyevent 66

  # Tela Menu Principal
  sleep 3
  adb shell input tap 50 150 # Clicando no menu
  sleep 2
  adb shell input tap 50 950 # Clicando em CERCA
  sleep 10

  adb shell input tap 50 600 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1200 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1800 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input swipe 100 2000 100 1000 350 # Swipe de baixo pra cima

  sleep 2

  adb shell input tap 50 600 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1200 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1800 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input swipe 100 2000 100 1000 350 # Swipe de baixo pra cima

  sleep 2

  adb shell input tap 50 600 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1200 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1800 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input swipe 100 2000 100 1000 350 # Swipe de baixo pra cima

  sleep 2

  adb shell input tap 50 600 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1200 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1800 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input swipe 100 2000 100 1000 350 # Swipe de baixo pra cima

  sleep 2

  adb shell input tap 50 600 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1200 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1800 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input swipe 100 2000 100 1000 350 # Swipe de baixo pra cima

  sleep 2

  adb shell input tap 50 600 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1200 # Selecionando RASTREADO

  confiCercaFmobile5

  adb shell input tap 50 1800 # Selecionando RASTREADO

  confiCercaFmobile5

  sleep 1

  adb shell input keyevent 4 #back

  sleep 2

  adb shell input tap 1000 150 # Clicando no REFRESH da grid principal

  sleep 5

  adb shell input keyevent 4 #back
  adb shell input keyevent 4 #back
  adb shell input keyevent 4 #back
}
automateTestFmobile5

# -------------------------------------------------------------------------------------------------------------------

takePrintFMobile6() {
  pathToScreenshots=sdcard/DCIM/Screenshots
  # https://developer.android.com/studio/command-line/adb#IntentSpec
  adb shell pm clear $bundle
  adb shell am start -n $bundle/.ui.activity.authentication.SplashScreenActivity

  #Tela de autenticacao 1
  sleep 5
  adb shell screencap $pathToScreenshots/Autenticacao1_"$bundle".png
  sleep 1
  adb shell input tap 500 1000
  adb shell input text "14123456789"
  adb shell input keyevent 66

  # Tela de autenticacao 2
  sleep 1
  adb shell screencap $pathToScreenshots/Autenticacao2_"$bundle".png
  adb shell input tap 80 700
  adb shell input text "54321"
  adb shell input keyevent 66

  # Tela grip principal com os rastreados
  sleep 5
  adb shell screencap $pathToScreenshots/GridPrincipal_"$bundle".png

  # Tela MAPA
  adb shell input tap 300 2250
  sleep 2
  adb shell screencap $pathToScreenshots/Mapa_"$bundle".png

  # Tela Notificação
  adb shell input tap 600 2250
  sleep 4
  adb shell screencap $pathToScreenshots/Notificacoes_"$bundle".png

  # Tela MAIS
  adb shell input tap 900 2250
  sleep 2
  adb shell screencap $pathToScreenshots/Mais_"$bundle".png

  # Tela Detalhes do Rastreado
  adb shell input tap 150 2250
  sleep 1
  adb shell input tap 1040 800
  sleep 2
  adb shell screencap $pathToScreenshots/DetalhesDoRastreado_"$bundle".png

  # Tela Rastreado no mapa
  adb shell input tap 540 1150
  sleep 2
  adb shell screencap $pathToScreenshots/RastreadoNoMapa_"$bundle".png

  # Tela Cerca Rápida
  adb shell input tap 540 1250
  sleep 2
  adb shell screencap $pathToScreenshots/CercaRapida_"$bundle".png

  # Tela Histórico de Posições
  adb shell input keyevent 4 #back
  sleep 1
  adb shell input tap 540 1400
  sleep 2
  adb shell screencap $pathToScreenshots/HistoricoDePosicoes_"$bundle".png

  # Tela Permanencia em Ponto
  adb shell input keyevent 4 #back
  sleep 1
  adb shell input tap 540 1600
  sleep 2
  adb shell screencap $pathToScreenshots/PermanenciaEmPonto_"$bundle".png

  # Tela Dados Consolidados
  adb shell input keyevent 4 #back
  sleep 1
  adb shell input tap 540 1700
  sleep 2
  adb shell screencap $pathToScreenshots/DadosConsolidados_"$bundle".png

  # Tela Criar Ponto de Referência
  adb shell input keyevent 4 #back
  sleep 1
  adb shell input tap 540 1800
  sleep 2
  adb shell screencap $pathToScreenshots/CriarPontoDeReferencia_"$bundle".png

  # Tela Consumo de Combustível
  adb shell input keyevent 4 #back
  sleep 1
  adb shell input tap 540 1900
  sleep 2
  adb shell screencap $pathToScreenshots/ConsumoDeCombustivel_"$bundle".png

  # Tela de Sensores
  adb shell input keyevent 4 #back
  sleep 1
  adb shell input tap 540 2050
  sleep 2
  adb shell screencap $pathToScreenshots/Sensores_"$bundle".png

  # Tela de Manutenções Programadas
  adb shell input keyevent 4 #back
  sleep 1
  adb shell input tap 540 2150
  sleep 2
  adb shell screencap $pathToScreenshots/ManutencoesProgramadas_"$bundle".png

  # Tela de Bloquear Veiculos
  adb shell input keyevent 4 #back
  sleep 1
  adb shell input swipe 100 1450 100 500 100
  sleep 1
  adb shell input tap 540 2150
  sleep 2
  adb shell screencap $pathToScreenshots/BloquearVeiculos_"$bundle".png

  adb shell input keyevent 4 #back
  adb shell input keyevent 4 #back
  adb shell input keyevent 4 #back

}
# takePrintFmobile6
