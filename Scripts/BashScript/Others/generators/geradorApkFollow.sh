#!/bin/bash

source ~/.bash_profile
nvm list
nvm use 4.2.6

echo "..........Iniciando geração de APK Assinada!.........."

#Gerando APK não Assinada...
echo "Gerando APK não Assinada..."


cd ~/Documents/Fulltrack/Follow/
cordova build --release android


echo "APK não Assinada Gerada"



echo "--------------------"
echo "--------------------"
echo "--------------------"

pathAPK=~/Documents/Fulltrack/Follow/platforms/android/build/outputs/apk/

#Gerando KeyStore...
echo "Gerando KeyStore..."

echo "---> Já existe KeyStore? yes/no ... "
read existeKeyStore
if [ $existeKeyStore == "" ]; then
    echo "Você não disse se existe ..."
elif [[ $existeKeyStore == "yes" ]] || [[ $existeKeyStore == "y" ]]; then
    echo "Existe Keystore"
    echo "Mova Keystore para área de trabalho ..."
    cd ~/Desktop/
    echo "---> Nome do KeyStore: "
    read nome
    sudo mv $nome.keystore $pathAPK
else

cd ~/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home
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
#mv android-release-unsigned.apk $caminhoDoGeradorKeyStore
#cd $caminhoDoGeradorKeyStore
#jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore android-release-unsigned.apk alias_name
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $nome.keystore android-release-unsigned.apk $nome

echo "APK Assinada Gerada"



echo "--------------------"
echo "--------------------"
echo "--------------------"



#Executando a ferramenta de alinhamento zip para otimizar o APK...
echo "Executando a ferramenta de alinhamento zip para otimizar o APK..."

pathBuild=~/Library/Android/sdk/build-tools/29.0.2
mv android-release-unsigned.apk $pathBuild
cd $pathBuild
echo "---> Nome do APK: "
read nomeAPK
./zipalign -v 4 android-release-unsigned.apk $nomeAPK.apk
rm android-release-unsigned.apk
mv $nomeAPK.apk $pathAPK


echo "APK Assinada e Otimizada Gerada com Sucesso!"