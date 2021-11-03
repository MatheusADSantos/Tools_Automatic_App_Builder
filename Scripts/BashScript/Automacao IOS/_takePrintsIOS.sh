#!/bin/bash -i

echo $"--- Script to get prints from devices's Apple! ---\n"

project="FMobileRN.xcodeproj"
simulatorIPhone11ProMax="9C525B66-F819-46EA-9A95-30BC51AF468D"
simulatorIPhone8Plus="3DC870B5-C7FD-4756-B85A-E9BB61A2E833"
simulatorIPadPro_12_9_inch="9C424EA7-2BA9-4B39-A49C-D07C72E840F9"
scheme="FMobileRN"
bundle_id=$2
pathPrintsProjectIOS=$1

cd /Users/macbook-estagio/Documents/Fulltrack/$scheme/ios/

echo $"\n --- RODANDO O SIMULADOR... no iPhone 11 Pro Max (6.5'')--- \n"
xcrun simctl boot $simulatorIPhone11ProMax
open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/
sleep 5

# xcrun simctl boot $simulatorIPhone8Plus
# xcrun simctl boot $simulatorIPadPro_12_9_inch

# open -a Simulator --args -CurrentDeviceUDID $simulatorIPhone11ProMax
# open -a Simulator --args -CurrentDeviceUDID $simulatorIPhone8Plus
# open -a Simulator --args -CurrentDeviceUDID $simulatorIPadPro_12_9_inch


echo $"\n --- INSTALANDO O APP ... ---\n"
# xcrun simctl install $iPhone11ProMax $bundle_id
# xcrun simctl install booted $bundle_id
# xcrun simctl install $iPhone11ProMax $project

# xcodebuild clean -workspace $scheme.xcworkspace -scheme $scheme
# xcodebuild clean -project $project -scheme $scheme
# # xcodebuild build -workspace $scheme.xcworkspace -scheme $scheme
# xcodebuild -workspace $scheme.xcworkspace -scheme $scheme 
# xcodebuild -workspace $scheme.xcworkspace -scheme $scheme -destination "platform=iOS"

# xcrun simctl list | grep "$device"
# xcrun simctl list # get the UDID
# xcrun simctl list | egrep '(Booted)' # To get which device is actived

# instruments -s devices # To get UDID
# echo $"\nDevice actived now: $(xcrun simctl list | egrep '(Booted)')"
# echo $"-> Escolha o device que quer instalar(UDID): "
# read device

# buscaDevice=$(xcrun simctl list | grep "$device" | awk '{ gsub ("iPhone 12 Pro Max ", "", $0); print}' | awk '{ gsub ("Phone: ", "", $0); print}' | awk 'NR==2{print $0}' | awk '{ gsub ("(Shutdown)", "", $0); print}' | awk '{ gsub ("(    )", "", $0); print}' |   awk '{sub(/()/,""); print$1}' | awk '{sub(/\)/,""); print$1}' | awk '{sub(/()/,""); print$1}' | awk '{sub(/\(/,""); print$1}')
# echo $"Device: ??? $buscaDevice"

# xcrun simctl install <device> <path>
# xcrun simctl install $simulatorIPhone11ProMax ./$scheme

# xcrun simctl install $device ./$scheme
# xcrun simctl install booted <app path>
xcrun simctl install booted ./$scheme

sleep 5



# echo $"\n --- ABRIR O APP ... ---\n"
# xcrun simctl launch booted $bundle_id

# echo $"\n --- NAVEGANDO ENTRE AS TELAS E TIRAR OS PRINTS ... ---\n"
# xcrun simctl io booted screenshot "$pathPrintsProjectIOS"/home.png


# echo $"\n --- BUSCANDO OS PRINTS E TRANSFERINDO PRO DIRETÓRIO CORRETO ... ---\n"


# echo $"\n --- MATANDO O SIMULADOR ... ---\n"




