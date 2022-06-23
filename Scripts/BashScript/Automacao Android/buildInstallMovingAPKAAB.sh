# !/bin/bash -i
source ~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/Python/venvAutomation/bin/activate

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

# # Paths importantes
pathProject=$1
PATH_APKSIGNER=~/Library/Android/sdk/build-tools/29.0.3/apksigner
pathScripts=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript
keystorePath=~/Documents/tools-automatic-app-customs/Keystores/
pathToRoot=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/
# Dados da keystore
nomeDaKeystore=$2
alias=$3
passwordDaKeystore1=$4
passwordDaKeystore2=$5
# Nomemclaturas dos builds
BUILD_APK_UNSIGNED=app-release-unsigned
BUILD_AAB_UNSIGNED=app-release
BUILD=app-release
BUILDS=apps

projeto=$6
buildName=$7
versionCode=$8

automatico=$9

print_light_green "\n\n\n1: $1 \n2: $2 \n3: $3 \n4: $4 \n5: $5 \n6: $6 \n7: $7 \n8: $8 \n9: $9"
# afplay /System/Library/Sounds/Blow.aiff
# afplay /System/Library/Sounds/Blow.aiff
# sleep 1
# afplay /System/Library/Sounds/Blow.aiff
# osascript -e 'display alert "ATENÇÃO!" message "Vai ser instalado o aplicativo! \nDe OK para continuar..."'

print_light_red "\n\nSCRIPT to build, install and Move (APK/AAB) to your respective folder ..."

print_red "\n\nInfo. CONSTANTES/KEYSTORES/PATHs ..."
print_green " \n-Path do Projeto: $pathProject \n-Path do APKSigner: $PATH_APKSIGNER 
              \n-Nome da keystore: $nomeDaKeystore\n-Alias: $alias\n-Password1: $passwordDaKeystore1\n-Password2: $passwordDaKeystore2 
              \n-Path Scripts: $pathScripts \n-Path Keystore: $keystorePath \n-Path diretório AAB: $pathToRoot "

print_blue "\n\n*** Processo ... $automatico\n\n\n"
sleep 10

# sh $pathScripts/Automação\ Android/buildInstallMovingAPKAAB.sh $pathProject $nomeDaKeystore $alias $passwordDaKeystore1 $passwordDaKeystore2 $projeto $buildName $versionCode 'automatico'
# buildInstallMovingAPKAAB.sh ~/Documents/Fulltrack/Gitlab_Projects/FMobile6_Android invictuscontrol invictuscontrol invictuscontrol5977 invictuscontrol5977 5977_Invictus_Control Invictus_Control 60008 'automatico'

builddingApkAndAAB() {
  # # Removendo Google-Service pra não dar conflito
  # rm $pathProject/app/google-services.json

  cd $pathProject/
  cp $keystorePath/$nomeDaKeystore.keystore $pathToRoot/

  echo "Para ver uma lista de todas as tarefas de compilação disponíveis para seu projeto, execute $(print_green "./gradlew tasks") \n"
  # print_green "$(./gradlew tasks)\n\n"

  print_blue "\n\n-> Rodando ./gradlew clean \nRemove ./build\n\n"
  ./gradlew clean

  # print_blue "\n\n-> Rodando ./gradlew cleanBuildCache ... \n\n"
  # ./gradlew cleanBuildCache

  print_blue "\n\n-> Rodando ./gradlew cleanBuild \nRemove ./app/build\n\n"
  ./gradlew cleanBuild

  print_blue "\n\n-> Rodando ./gradlew build"
  ./gradlew build

  # ---------------------------------------------------------------------------------------------------------
  # Gera app-release-unsigned.apk em ./app/build/outputs/apk/release/app-release-unsigned.apk
  print_blue "\n\n-> GERANDO .apk \nBuild estará em: ./app/build/outputs/apk/release/$BUILD_APK_UNSIGNED.apk\n"
  rm ./app/build/outputs/apk/release/$BUILD_APK_UNSIGNED.apk
  ./gradlew assembleRelease

  print_blue "\n\n-> Assinando e Optimizando o .apk ($BUILD_APK_UNSIGNED.apk) \nApós assinado estára em: ./app/build/outputs/apk/release/$BUILD.apk\n\n"
  mv $pathProject/app/build/outputs/apk/release/$BUILD_APK_UNSIGNED.apk ~/Library/Android/sdk/build-tools/29.0.3/
  cp $keystorePath/$nomeDaKeystore.keystore ~/Library/Android/sdk/build-tools/29.0.3/
  cd ~/Library/Android/sdk/build-tools/29.0.3/

  print_blue "\n\n-> Otimizando o .apk com o zipalign\n"
  ./zipalign -v -p 4 ./$BUILD_APK_UNSIGNED.apk $BUILD.apk

  # afplay /System/Library/Sounds/Blow.aiff
  # print_light_red "\n\n\nVERIFIQUE"
  # read verificou

  ./apksigner sign --ks $nomeDaKeystore.keystore --ks-key-alias $alias --ks-pass pass:$passwordDaKeystore1 --key-pass pass:$passwordDaKeystore2 $BUILD.apk
  rm ./$BUILD_APK_UNSIGNED.apk

  print_red "\n\nVerificando se o APK foi assinado ...\n\n"
  ./apksigner verify ./$BUILD.apk
  # mv ./$BUILD_APK_UNSIGNED.apk ./$BUILD.apk
  mv ./$BUILD.apk $pathProject/app/build/outputs/apk/release/
  rm ./$nomeDaKeystore.keystore
  # ~/Library/Android/sdk/build-tools/29.0.3/apksigner sign --ks ~/Documents/tools-automatic-app-customs/Keystores//invictuscontrol.keystore --ks-key-alias invictus --ks-pass pass:invictuscontrol5977 --key-pass pass:invictuscontrol5977 ./app-release.apk

  cd $pathProject/app/build/outputs/apk/release/
  print_blue "\n\n-> Movendo de: \n$pathProject/app/build/outputs/apk/release/$BUILD.apk para: \n$pathToRoot\n"
  mv ./$BUILD.apk $pathToRoot # Movendo o APK para o path do Scripts/AABTolls

  cd $pathProject/app/build/outputs/apk/debug
  print_blue "\n\n-> Movendo de: \n$pathProject/app/build/outputs/apk/debug/app-debug.apk para: \n$pathToRoot\n"
  mv ./app-debug.apk $pathToRoot

  # ---------------------------------------------------------------------------------------------------------
  cd $pathProject
  print_blue "\n\n-> GERANDO .aab \nBuild estará em: ./app/build/outputs/bundle/release/$BUILD_AAB_UNSIGNED.aab\n"
  ./gradlew bundleRelease

  print_blue "\n\n-> Movendo de: \n$pathProject/app/build/outputs/bundle/release/$BUILD.aab para: \n$pathToRoot\n"
  mv $pathProject/app/build/outputs/bundle/release/$BUILD_AAB_UNSIGNED.aab $pathToRoot/$BUILD.aab

  cd $pathToRoot
  print_blue "\n\n-> Assinando o .aab ($BUILD_AAB_UNSIGNED.aab) \n\n"
  afplay /System/Library/Sounds/Blow.aiff
  # print_light_red "Insira a chave(Keystore)"
  # jarsigner -keystore $keystorePath/$nomeDaKeystore.keystore $BUILD.aab $alias
  jarsigner -keystore $keystorePath/$nomeDaKeystore.keystore -storepass $passwordDaKeystore1 -keypass $passwordDaKeystore2 $BUILD.aab $alias
  # https://stackoverflow.com/questions/41975364/how-to-pass-jarsigner-exe-passphrase-via-commandline

  # cp ~/Downloads/google-services.json $pathProject/app/
}
builddingApkAndAAB

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

installAppInDevice() {
  print_blue "\n\n-> Desbloqueando Celular...\n"
  sh $pathScripts/unlockDevice.sh 'instalar aplicativo'

  # print_blue "\n\n-> Desinstalando app($BUILD.apk) do device($device). \nMantendo os dados...  \n"
  # adb -s $device uninstall -k $bundle # Mantendo os dados

  print_blue "\n\n-> Limpando os dados e Desinstalando app($BUILD.apk) do device($device) \n"
  adb -s $device shell pm clear $bundle
  adb -s $device uninstall $bundle

  # print_blue "\n\n-> Instalando o .apk assinado no device: \n$device\n\n\n"
  # # java -jar bundletool-all-1.7.0.jar install-apks --apks=$BUILDS.apks --device-id=$device
  # java -jar bundletool.jar install-apks --apks=$BUILDS.apks --device-id=$device
  # print_light_green "\n\n\n$nome.apk instalado no device: $device\n"

  print_blue "\n\n-> Instalando o .apk assinado no device: \n$device\n\n\n"
  adb -s $device install $BUILD.apk
  print_light_green "\n\n\n$nome.apk instalado no device: $device\n"
}

movingBuildsToProject() {
  cd $pathToRoot
  print_light_red "\n\n\n---------      Movendo os BUILDS(.apk(release/debug), .aab)      ---------\n\n"
  sleep 5
  mv ./$BUILD.aab ~/Documents/tools-automatic-app-customs/Projetos/"$projeto"/"BUILDS"/Android/"$buildName"_"$versionCode".aab
  mv ./$BUILD.apk ~/Documents/tools-automatic-app-customs/Projetos/"$projeto"/"BUILDS"/Android/"$buildName"_"$versionCode".apk
  mv ./app-debug.apk ~/Documents/tools-automatic-app-customs/Projetos/"$projeto"/"BUILDS"/Android/
  rm $nomeDaKeystore.keystore
  rm $BUILDS.apks #arquivo pesado, necessário somente na hora de instalar ...
}

dealWith() {
  if [[ $automatico == 'automatico' ]]; then
    print_green "Build chamado pelo script 'automationCustomFMobile6ANDROID.sh' ..."
    lookingDevicesAndIPAdress
    installAppInDevice
    movingBuildsToProject
  else
    print_green "Build chamado pelo terminal ..."
  fi
}
dealWith
