#!/bin/bash -i

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

print_blue "\n\n-------------------  $(print_light_blue "AUTOMAÇÃO DE CUSTOMIZAÇÃO FMOBILE 6.0 iOS")  $(print_blue "------------------")"

# # Case in custom already exist
# fmobile5=$1
# bundle=$2
# Some paths important
pathScripts=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/
pathBashScripts=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript/
pathRootFMobile=~/Documents/Fulltrack/FMobile6_IOS/
pathCustomProjects=~/Documents/tools-automatic-app-customs/Projetos/

print_blue "\n\n-> New project or Update? (N/U)\n"
read newProjectOrUpdate

print_blue "\n\n-> Custom from FMobile5.0? (Y/N)\n"
read fmobile5

print_blue "\n\n-> Indice from porject?\n"
read indice

if [[ $fmobile5 == 'y' || $fmobile5 == 'Y' || $fmobile5 == 'yes' ]]; then
  print_blue "\n\n-> Bundle?\n"
  read bundle
fi

if [[ $newProjectOrUpdate == 'n' || $newProjectOrUpdate == 'N' || $newProjectOrUpdate == 'new' ]]; then

  cd $pathCustomProjects/
  touch customsFMobile6.txt
  printf "$(ls)" >>customsFMobile6.txt
  projetos=$(awk '//{print}' customsFMobile6.txt)
  resultadoDaBuscaDoProjeto=$(grep "$indice" customsFMobile6.txt)
  projeto=$resultadoDaBuscaDoProjeto
  rm customsFMobile6.txt

  cd $pathCustomProjects/$projeto

  indice=$(awk '/Indice: /{print $0}' info.txt | awk '{sub(/Indice: /,""); print}')
  appName=$(awk '/Nome do App:/{print $0}' info.txt | awk '{sub(/Nome do App: /,""); print}')
  color=$(awk '/Cor1/{print $0}' info.txt | awk '{sub(/Cor1: /,""); print}')
  email=$(awk '/Email conta IOS: /{print $0}' info.txt | awk '{sub(/Email conta IOS: /,""); print}')
  password=$(awk '/Senha conta IOS: /{print $0}' info.txt | awk '{sub(/Senha conta IOS: /,""); print}')

  appName=$(echo "$appName" | awk '{ gsub(/ /,""); print }')
  branch=$(echo "custom $appName" | awk '{ gsub(/ /,""); print }')

  print_light_green "\n\nProject: $projeto \nApp Name: $appName \nColor: $color \nBundle: $bundle \nBranch: $branch"

  sh $pathBashScripts/Utils/gitCheck.sh $newProjectOrUpdate $pathRootFMobile $bundle $branch 'iOS'

  print_light_red "SETTING IMAGES"
  cd $pathCustomProjects/$projeto/IMAGENS/ImagensDoProjeto/
  cp ./iconApp.png ./fmobile_authentication_logo.png
  cp ./iconApp.png ./splash_screen_logo.png

  cp ./fmobile_authentication_logo.png $pathRootFMobile/FMobile/Resources/
  cp ./splash_screen_logo.png $pathRootFMobile/FMobile/Resources/

  # echo -e "\n\n_______ Opening the Icon Set Creator ..."
  open -a Icon\ Set\ Creator $pathCustomProjects/$projeto/IMAGENS/ImagensDoProjeto/iconApp.png

  afplay /System/Library/Sounds/Blow.aiff
  print_light_gray "\nClick OK and tap 'return' to continue process..."
  read clicked

  # rm $pathRootFMobile/FMobile/Resources/Assets.xcassets/
  cp ~/Downloads/iOS/AppIcon.appiconset $pathRootFMobile/FMobile/Resources/Assets.xcassets/

  print_light_red "SETTING NAME AND COLORS"
  cd $pathRootFMobile/FMobile/Resources/Colors.swift
  

fi
