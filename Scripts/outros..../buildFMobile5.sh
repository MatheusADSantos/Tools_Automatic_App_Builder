# !/bin/bash -i

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

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

# FMOBILE 5.0
pathScripts=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/BashScript
keystorePath=~/Documents/tools-automatic-app-customs/Keystores/
# pathToRoot=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls #Path de onde está o script.ssh e o bundletool
pathToRoot=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts
pathProject=~/Documents/Fulltrack/FMobileRN/android #$(pwd)
# PATH_APKSIGNER=~/Library/Android/sdk/build-tools/29.0.3/apksigner
BUILD_TOOLS=~/Library/Android/sdk/build-tools/29.0.3/

BUILD_APK_UNSIGNED=app-release
BUILD_AAB_UNSIGNED=app
BUILD=app-release
BUILDS=apps

echo "Nome da Keystore: "
read nomeDaKeystore

echo "Alias"
read alias

echo "Senha da keystore 1"
read passwordDaKeystore1

echo "Senha da keystore 2"
read passwordDaKeystore2

builddingApkAndAAB() {

  cd $pathProject/
  cp $keystorePath/$nomeDaKeystore.keystore $pathToRoot/

  print_blue "\n\n-> Rodando ./gradlew clean \nRemove ./build\n\n"
  ./gradlew clean

  # print_blue "\n\n-> Rodando ./gradlew cleanBuildCache ... \n\n"
  # ./gradlew cleanBuildCache

  # print_blue "\n\n-> Rodando ./gradlew cleanBuild \nRemove ./app/build\n\n"
  # ./gradlew cleanBuild

  print_blue "\n\n-> Rodando ./gradlew build"
  ./gradlew build

  # ---------------------------------------------------------------------------------------------------------
  # Gera app-release-unsigned.apk em ./app/build/outputs/apk/release/app-release-unsigned.apk
  print_blue "\n\n-> GERANDO .apk \nBuild estará em: ./app/build/outputs/apk/release/$BUILD_APK_UNSIGNED.apk\n"
  rm ./app/build/outputs/apk/release/$BUILD_APK_UNSIGNED.apk
  ./gradlew assembleRelease

  print_blue "\n\n-> Assinando e Optimizando o .apk ($BUILD_APK_UNSIGNED.apk) \nApós assinado estára em: ./app/build/outputs/apk/release/$BUILD.apk\n\n"
  mv $pathProject/app/build/outputs/apk/release/$BUILD_APK_UNSIGNED.apk ~/Library/Android/sdk/build-tools/29.0.3/app-release-unsigned.apk
  cp $keystorePath/$nomeDaKeystore.keystore ~/Library/Android/sdk/build-tools/29.0.3/
  cd ~/Library/Android/sdk/build-tools/29.0.3/

  print_blue "\n\n-> Otimizando o .apk com o zipalign\n"
  ./zipalign -v -p 4 ./app-release-unsigned.apk $BUILD.apk

  ./apksigner sign --ks $nomeDaKeystore.keystore --ks-key-alias $alias --ks-pass pass:$passwordDaKeystore1 --key-pass pass:$passwordDaKeystore2 $BUILD.apk
  rm ./app-release-unsigned.apk

  print_red "\n\nVerificando se o APK foi assinado ...\n\n"
  ./apksigner verify ./$BUILD.apk
  # mv ./app-release-unsigned.apk ./$BUILD.apk
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
  mv $pathProject/app/build/outputs/bundle/release/$BUILD_AAB_UNSIGNED.aab $pathToRoot

  cd $pathToRoot
  print_blue "\n\n-> Assinando o .aab ($BUILD_AAB_UNSIGNED.aab) \nApós assinado estára em: $pathToRoot/$BUILD.aab\n\n"
  # java -jar bundletool-all-1.7.0.jar build-apks --bundle=$BUILD_AAB_UNSIGNED.aab --output=$BUILDS.apks --ks=$keystorePath/$nomeDaKeystore.keystore --ks-pass=pass:$passwordDaKeystore1 --ks-key-alias=$alias --key-pass=pass:$passwordDaKeystore2
  # java -jar bundletool-all-1.7.0.jar build-apks --bundle=$BUILD_AAB_UNSIGNED.aab --output=$BUILDS.apks --ks=$nomeDaKeystore.keystore --ks-pass=pass:$passwordDaKeystore1 --ks-key-alias=$alias --key-pass=pass:$passwordDaKeystore2

  java -jar bundletool-all-1.7.0.jar build-apks --bundle=$BUILD_AAB_UNSIGNED.aab --output=$BUILDS.apks --ks=$nomeDaKeystore.keystore --ks-pass=pass:$passwordDaKeystore1 --ks-key-alias=$alias --key-pass=pass:$passwordDaKeystore2
  # jarsigner -keystore $keystorePath/$nomeDaKeystore.keystore -storepass $passwordDaKeystore1 -keypass $passwordDaKeystore2 $BUILD.aab $alias

  mv ./$BUILD_AAB_UNSIGNED.aab ./$BUILD.aab
}
builddingApkAndAAB
