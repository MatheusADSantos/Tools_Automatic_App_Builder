#!/bin/bash -i

echo -e "\n\nScript pra gerar prints automáticos FMobile 6.0 IOS ... "

BUNDLE=$1
SCHEME=$2
PATH_PRINTS=$3
echo -e "\nBundle: $BUNDLE \nScheme: $SCHEME \nPath dos Prints: $PATH_PRINTS"
sleep 5

PROJECT="FMobile.xcodeproj"
PATH_PROJECT="/Users/macbook-estagio/Documents/Fulltrack/FMobile6_IOS/"

simulatorIPhone11ProMax="9C525B66-F819-46EA-9A95-30BC51AF468D"
simulatorIPhone8Plus="3DC870B5-C7FD-4756-B85A-E9BB61A2E833"
simulatorIPadPro_12_9_inch="9C424EA7-2BA9-4B39-A49C-D07C72E840F9"

# echo -e "\nDando um 'pod install' ... \n\n"
# cd $PATH_PROJECT
# pod install
# sleep 15

echo -e "\nAbrindo o simulador - iPhone 11 Pro Max (6.5'') ... "
xcrun simctl boot $simulatorIPhone11ProMax
open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/
sleep 5

# xcrun simctl boot $simulatorIPhone8Plus
# xcrun simctl boot $simulatorIPadPro_12_9_inch

# open -a Simulator --args -CurrentDeviceUDID $simulatorIPhone11ProMax
# open -a Simulator --args -CurrentDeviceUDID $simulatorIPhone8Plus
# open -a Simulator --args -CurrentDeviceUDID $simulatorIPadPro_12_9_inch


echo -e "\nInstalando o aplicativo no simulador ... "
# xcrun simctl install booted $PATH_PROJECT/$SCHEME

# xcrun simctl install $simulatorIPhone11ProMax $PATH_PROJECT
# xcrun simctl launch $simulatorIPhone11ProMax $BUNDLE

xcrun simctl install booted $PATH_PROJECT
xcrun simctl launch booted $BUNDLE
sleep 5



# echo $"\n --- ABRIR O APP ... ---\n"
# xcrun simctl launch booted $BUNDLE

# echo $"\n --- NAVEGANDO ENTRE AS TELAS E TIRAR OS PRINTS ... ---\n"
# xcrun simctl io booted screenshot "$pathPrintsProjectIOS"/home.png


# echo $"\n --- BUSCANDO OS PRINTS E TRANSFERINDO PRO DIRETÓRIO CORRETO ... ---\n"


# echo $"\n --- MATANDO O SIMULADOR ... ---\n"




