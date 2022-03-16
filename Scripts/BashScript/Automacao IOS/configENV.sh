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
print_green() {
  printf "\e[0;32m$1\e[0m"
}
print_light_green() {
  printf "\e[1;32m$1\e[0m"
}

project=$1
indice=$2
bundle=$3
appleID=$4
fastlanePassword=$5
appName=$6

print_red "\n\n-------------------  $(print_light_red "Configuration .env")  $(print_red "------------------")\n\n"

rootProjectAutomation=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder
pathScripts=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/
pathBashScripts=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript/
pathProject=~/Documents/Fulltrack/FMobile6_IOS/
pathCustomProject=~/Documents/Products_Customs/Projetos/$project



# Getting information to fill .env
echo "Indice:"
read indice

echo "App Name:"
read appName

echo "Bundle:"
read bundle

echo "Apple ID(Email de login):"
read appleID

echo "Password Account:"
read fastlanePassword


# mIsShowing=$(adb -s "$IPDeviceToUnlock" shell dumpsys window | grep mIsShowing | awk '{sub(/        mIsShowing=/,""); print}')

team_id=$(cd ~/Documents/Fulltrack/FMobile6_IOS/ && fastlane getTeamNames | grep TEAM_ID | awk '/TEAM_ID: /{if(NR==1) print $8}')
itc_team_id=$(cd ~/Documents/Fulltrack/FMobile6_IOS/ && fastlane getTeamNames | grep TEAM_ID | awk '/ITC_TEAM_ID: /{if(NR==2) print $8}')
echo -e "\n\nYour team_id is: $team_id \nYour itc_team_id is: $itc_team_id\n\n"
cd $rootProjectAutomation

echo "FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD: "
read specific_password

# Fill ~/.bash_profile
echo -e "\n\n\nComplete your bash_profile with this information: "
printf
"
### Indice: $indice - Team: $project - App: $appName
FASTLANE_PASSWORD_$indice="$fastlanePassword"
MATCH_PASSWORD_$indice="fastlaneAutomation"
MATCH_KEYCHAIN_PASSWORD_$indice="fastlaneAutomation"
FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD_$indice="$specific_password""

echo -e "\n\n\nWhich Edditor do you preffer? (nano or vim)"
read edditor
$($edditor ~/.bash_profile)



# Full datas in .env
"
# Bundle Identifier
APP_IDENTIFIER  = '$bundle'

# app store connect
APPLE_ID          = '$appleID'
# FASTLANE_PASSWORD = {$FASTLANE_PASSWORD_$indice}

# Authentication 2 Fatorys
SPACESHIP_2FA_SMS_DEFAULT_PHONE_NUMBER = '+55 (14) 99173-4172'


# Xcode
XCODE_WORKSPACE       = 'FMobile.xcworkspace'
XCODE_SCHEME          = 'FMobile'
XCODE_CONFIGURATION   = 'AdHoc'

# Provisioning Profiles
PROFILE_APP_STORE       = 'match AppStore $bundle'
PROFILE_AD_HOC          = 'match AdHoc $bundle'
PROFILE_DEVELOPMENT     = 'match Development $bundle'

# Developer Portal Team ID
TEAM_ID         = '$team_id'

# App Store Connect Team ID
ITC_TEAM_ID     = '$itc_team_id'

# Match: senha do git repo
MATCH_PASSWORD  = {$MATCH_PASSWORD_$indice}
MATCH_KEYCHAIN_PASSWORD  = {$MATCH_KEYCHAIN_PASSWORD_$indice}

# Transporter
# App Store Connect > Apps > App > Info > Apple ID.
APP_STORE_CONNECT_APPLE_ID = '1523701269'

# https://docs.fastlane.tools/best-practices/continuous-integration/
# https://appleid.apple.com > Generate a new App Specific Password
# FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD = {$FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD_$indice}
# FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD = 'blwb-xmrv-qkez-npcu'
FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD = 'yrkb-oejo-xyxy-gnmz'

# Firebase dist
FIREBASE_DIST_SERVICE_ACCOUNT_FILE = 'fastlane/service-account-firebase-app-distribution.json'
FIREBASE_APP_ID     = '1:615191210205:ios:1b0016505ed51087d01334'
FIREBASE_TEST_GROUP = 'testers'
FIREBASE_TESTERS    = '
FIREBASE_TOKEN = '4/1AX4XfWiD7CPf4IsP7vSIivCDk4jInbUMY3d5xdgABIS2CtROXwtPQTZGz8s'

"














if [[ $newProjectOrUpdate == 'n' || $newProjectOrUpdate == 'N' || $newProjectOrUpdate == 'new' ]]; then

  cd $pathCustomProjects/
  # print_blue "\n\n-> Verificando se já existe o projeto com o indice: ($indice) ..."
  touch projects.txt                       #Criando projetos.txt
  printf "$(ls)" >>projects.txt            #Inserindo o conteúdo no projetos.txt
  projetos=$(awk '//{print}' projects.txt) #Buscando todo o conteúdo do projetos.txt
  resultadoDaBuscaDoProjeto=$(grep "$indice" projects.txt)
  projeto=$resultadoDaBuscaDoProjeto
  rm projetos.txt

  indice=$(awk '/Indice: /{print $0}' info.txt | awk '{sub(/Indice: /,""); print}')
  appName=$(awk '/Nome do App:/{print $0}' info.txt | awk '{sub(/Nome do App: /,""); print}')
  color=$(awk '/Cor1/{print $0}' info.txt | awk '{sub(/Cor1: /,""); print}')
  email=$(awk '/Email conta IOS: /{print $0}' info.txt | awk '{sub(/Email conta IOS: /,""); print}')
  password=$(awk '/Senha conta IOS: /{print $0}' info.txt | awk '{sub(/Senha conta IOS: /,""); print}')

fi
