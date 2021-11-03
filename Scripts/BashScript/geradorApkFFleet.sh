#!/bin/bash

source ~/.bash_profile
# nvm use 4.2.6
nvm use 12.18.3
nvm list

echo "..........Iniciando geração de APK Assinada!.........."
echo "Gerando APK não Assinada..."

pathProject=~/Documents/Fulltrack/FFleet/
cd $pathProject/platforms/android
./gradlew clean

cd $pathProject
cordova build --release android

echo "APK não Assinada Gerada"

echo "--------------------"
echo "--------------------"
echo "--------------------"

echo "Gerando KeyStore..."

pathAPK=/Users/macbook-estagio/Documents/Fulltrack/FFleet/platforms/android/app/build/outputs/apk/release

echo "---> Já existe KeyStore em ~/Desktop/Keystores ? yes/no ... "
read existeKeyStore
if [ $existeKeyStore == "" ]; then
    echo "Você não disse se existe ..."
elif [[ $existeKeyStore == "yes" ]] || [[ $existeKeyStore == "y" ]]; then
    echo "Existe Keystore"
    echo "Mova Keystore para área de trabalho ..."
    pathKeystores="/Users/macbook-estagio/Desktop/Keystores"
    cd $pathKeystores
    pwd
    echo "---> Nome da KeyStore: "
    read nome

    sudo mv $nome.keystore $pathAPK
else

# cd ~/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home
# cd /Library/Java/JavaVirtualMachines/jdk-12.0.2.jdk/Contents/Home
cd /Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk/Contents/Home
echo "---> Nome do KeyStore: "
read nome
sudo keytool -genkey -v -keystore $nome.keystore -alias $nome -keyalg RSA -keysize 2048 -validity 10000
sudo mv $nome.keystore $pathAPK


echo "Keystore Gerada!!!!!"

fi

echo "--------------------"
echo "--------------------"
echo "--------------------"

#Assinando APK...
echo "Assinando APK..."

cd $pathAPK
#jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore android-release-unsigned.apk alias_name
# jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $nome.keystore android-release-unsigned.apk $nome
# jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $nome.keystore android-release-unsigned.apk $nome
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $nome.keystore app-release-unsigned.apk $nome


echo "APK Assinada Gerada"

sudo mv $nome.keystore $pathKeystores


echo "--------------------"
echo "--------------------"
echo "--------------------"


#Executando a ferramenta de alinhamento zip para otimizar o APK...
echo "Executando a ferramenta de alinhamento zip para otimizar o APK..."

pathBuild=~/Library/Android/sdk/build-tools/29.0.2
sudo mv app-release-unsigned.apk $pathBuild
cd $pathBuild

echo "---> Nome do APK: "
read nomeAPK

./zipalign -v 4 app-release-unsigned.apk $nomeAPK.apk
rm app-release-unsigned.apk
mv $nomeAPK.apk $pathAPK

# -------

# mv app-release-unsigned.apk $nomeAPK.apk $pathAPK

echo ""
echo ""
echo ""

echo ">>>>APK Assinada e Otimizada Gerada com Sucesso!<<<<"