#!/bin/bash

source ~/.bash_profile
nvm list
nvm use 4.2.6
echo "Usando Node Versão -> 4.2.6"
nvm list


# pathAPK=~/Documents/Fulltrack/fdispatcherAPP/platforms/android/build/outputs/apk/
# pathAPK=~/Documents/Fulltrack/fdispatcherAPP/platforms/android/app/build/outputs/apk/release
pathAPK=/Users/macbook-estagio/Documents/Fulltrack/fdispatcherAPP/platforms/android/app/build/outputs/apk/release



echo ""
echo "..........Iniciando geração de APK Assinada!.........."
echo ""


#Gerando APK não Assinada...
echo "Gerando APK não Assinada..."


cd ~/Documents/Fulltrack/fdispatcherAPP/
cordova build --release android


echo "APK NÃO Assinada Gerada!!! e disponivel em: ---> $pathAPK"


echo "--------------------"
echo "--------------------"
echo "--------------------"



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
    echo "---> Nome da KeyStore: "
    echo "---> Senha da KeyStore: 7HejEkeY "
    read nome
    sudo mv $nome.keystore $pathAPK
else

# cd ~/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home
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
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $nome.keystore app-release-unsigned.apk $nome

echo "APK Assinada Gerada"



echo "--------------------"
echo "--------------------"
echo "--------------------"



#Executando a ferramenta de alinhamento zip para otimizar o APK...
echo "Executando a ferramenta de alinhamento zip para otimizar o APK..."

pathBuild=~/Library/Android/sdk/build-tools/29.0.2
# mv android-release-unsigned.apk $pathBuild
sudo mv app-release-unsigned.apk $pathBuild
cd $pathBuild
echo "---> Nome do APK: "
read nomeAPK
# ./zipalign -v 4 android-release-unsigned.apk $nomeAPK.apk
./zipalign -v 4 app-release-unsigned.apk $nomeAPK.apk
# rm android-release-unsigned.apk
rm app-release-unsigned.apk
mv $nomeAPK.apk $pathAPK


echo "APK Assinada e Otimizada Gerada com Sucesso!"
echo ""
echo "--------------------"
echo ""
echo "APK Gerada esta em: $pathAPK"