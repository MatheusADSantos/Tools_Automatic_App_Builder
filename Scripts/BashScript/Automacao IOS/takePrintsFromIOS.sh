# #!/bin/bash -i
# # https://developer.apple.com/library/archive/technotes/tn2339/_index.html

# # Como construir um projeto iOS com comando?
# # https://medium.com/@marksiu/how-to-build-ios-project-with-command-82f20fda5ec5

# # iOS simulator command line tricks
# # https://medium.com/@ankitkumargupta/ios-simulator-command-line-tricks-ee58054d30f4

# # simctl: Control iOS Simulators from Command Line
# # https://medium.com/xcblog/simctl-control-ios-simulators-from-command-line-78b9006a20dc

# # iOS Simulator from the Command Line
# # https://suelan.github.io/2020/02/05/iOS-Simulator-from-the-Command-Line/

# # scheme="FMobileRN"
# scheme="FMobile"

# pathBuildsProjectIOS=$1
# # pathBuildsProjectIOS=/Users/macbook-estagio/Documents/Fulltrack/FMobile6_IOS
# pathPrintsProjectIOS=$2
# bundle_id=$3
# # pathProject=/Users/macbook-estagio/Documents/Fulltrack/$scheme/ios/
# pathProject=/Users/macbook-estagio/Documents/Fulltrack/FMobile6_IOS
# cd $pathProject
# echo "All information from project: "
# xcodebuild -list -project $scheme.xcodeproj
# # sh /Users/macbook-estagio/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript/cleanXCode.sh

# echo $"*Path to Build: "$pathBuildsProjectIOS" \n*Path to Prints: $pathPrintsProjectIOS \n*Path from Project: $pathProject \n*Bundle: $bundle_id"

# sleep 5

# echo $"\nCleaning the Project..."
# xcodebuild clean -workspace $scheme.xcworkspace -scheme $scheme
# xcodebuild clean -project $project -scheme.xcodeproj $scheme

# # if you have a workspace
# xcodebuild -workspace $scheme.xcworkspace -scheme $scheme -configuration Debug -destination '9C525B66-F819-46EA-9A95-30BC51AF468D' -derivedDataPath build

# # echo $"\nBuildding the Project..."
# # xcodebuild build -workspace $scheme.xcworkspace -scheme $scheme

# # echo $"\nGetting o Archive..."
# # xcodebuild archive -workspace $scheme.xcworkspace -scheme $scheme -archivePath "$pathBuildsProjectIOS"/$scheme.xcarchive

# # echo $"\nBuilds the app into an archive..." # PROBLEMA AQUI ....
# # xcodebuild -project $scheme.xcodeproj -scheme $scheme -archivePath "$pathBuildsProjectIOS"/$scheme.xcarchive

# echo $"\nGetting a IPA - Exports the archive according to the export options specified by the plist..."
# # xcodebuild -exportArchive -archivePath /Path/To/Output/YourApp.xcarchive -exportPath /Path/To/ipa/Output/Folder -exportOptionsPlist /Path/To/ExportOptions.plist
# xcodebuild -exportArchive -archivePath "$pathBuildsProjectIOS"/$scheme.xcarchive -exportPath "$pathBuildsProjectIOS" -exportOptionsPlist $pathProject/$scheme/Resources/Info.plist

# # Escolhendo o device:
# # xcrun simctl list devices
# # instruments -s devices # To get UDID
# # echo $"\nDevice actived now: $(xcrun simctl list | egrep '(Booted)')"
# # echo $"-> Escolha o device que quer instalar(UDID): "
# # read device

# # Abrindo o simulador:
# # TO KNOW UDID FROM DEVICE BOOTED: xcrun simctl getenv booted SIMULATOR_UDID
# simulatorIPhone11ProMax="9C525B66-F819-46EA-9A95-30BC51AF468D"
# simulatorIPhone8Plus="3DC870B5-C7FD-4756-B85A-E9BB61A2E833"
# simulatorIPadPro_12_9_inch="9C424EA7-2BA9-4B39-A49C-D07C72E840F9"
# # xcrun simctl boot $device
# # xcrun simctl shutdown $simulatorIPhone11ProMax
# xcrun simctl boot $simulatorIPhone8Plus
# open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/

# # Instalando o app no device/simulador:
# # xcrun simctl install $device ~/Documents/Fulltrack/$scheme/ios/$scheme
# # xcrun simctl install booted ~/Documents/Fulltrack/$scheme/ios/$scheme
# xcrun simctl install booted  ~/Documents/Fulltrack/FMobile6_IOS/$scheme
# # xcrun simctl install booted "$pathBuildsProjectIOS"/$scheme

# afplay /System/Library/Sounds/Blow.aiff
# osascript -e 'display alert "ATENÇÃO!" message ">>>IPA finished!!!<<< \nClick in OK to launch your app in simulator"'

# # Abrir o app:
# xcrun simctl launch booted $bundle_id

# --------------------------------------------------------------

# --------------------------------------------------------------

#!/bin/bash

# # Como construir um projeto iOS com comando?
# # https://medium.com/@marksiu/how-to-build-ios-project-with-command-82f20fda5ec5

# sh /Users/macbook-estagio/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript/cleanXCode.sh

pathBuildsProjectIOS=$1
pathPrintsProjectIOS=$2
bundle_id=$3
scheme=$4
pathProject=/Users/macbook-estagio/Documents/Fulltrack/FMobile6_IOS
# pathBuildsProjectIOS=$pathProject
# simulatorIPhone11ProMax="F17KKBEAFH1C"
simulatorIPhone11ProMax="9C525B66-F819-46EA-9A95-30BC51AF468D"
simulatorIPhone8Plus="3DC870B5-C7FD-4756-B85A-E9BB61A2E833"
simulatorIPadPro_12_9_inch="9C424EA7-2BA9-4B39-A49C-D07C72E840F9"

echo $"Botting Simulator...\n"
# TO KNOW UDID FROM DEVICE BOOTED: <xcrun simctl getenv booted SIMULATOR_UDID>
# xcrun simctl boot $device
# xcrun simctl shutdown $simulatorIPhone11ProMax
# xcrun simctl boot $simulatorIPhone11ProMax
# open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/

cd $pathProject

# printf """post_install do |installer|
#  installer.pods_project.targets.each do |target|
#   target.build_configurations.each do |config|
#    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
#   end
#  end
# end""" >>./Pods/Podfile

# pod install

echo $"\nCleaning the Project...\n"
# xcodebuild clean -workspace $scheme.xcworkspace -scheme $scheme
# xcodebuild clean -project $project -scheme.xcodeproj $scheme

echo $"\nRomove the build...\n"
# rm -rf ./build

# if you have a workspace
# xcodebuild -workspace $scheme.xcworkspace -scheme $scheme -configuration Debug -destination '9C525B66-F819-46EA-9A95-30BC51AF468D' -derivedDataPath build
# xcodebuild -workspace FMobile.xcworkspace -scheme FMobile -configuration Debug -destination '9C525B66-F819-46EA-9A95-30BC51AF468D' -derivedDataPath build

echo $"\nBuildding the Project...\n"
# xcodebuild build -workspace $scheme.xcworkspace -scheme $scheme

echo $"\nGetting o Archive...\n"
# xcodebuild archive -workspace FMobileRN.xcworkspace -scheme FMobile -archivePath ~/Downloads/FMobile.xcarchive
# xcodebuild archive -workspace FMobileRN.xcworkspace -scheme FMobileRN -archivePath ~/Downloads/FMobileRN_NSTrack.xcarchive
# xcodebuild archive -workspace $scheme.xcworkspace -scheme $scheme -archivePath "$pathBuildsProjectIOS"/$scheme.xcarchive

echo $"\nBuilds IPA...\n" # PROBLEMA AQUI ....
xcodebuild -exportArchive -archivePath ~/Downloads/FMobileRN_NSTrack.xcarchive -exportPath ~/Downloads/ -exportOptionsPlist ~/Documents/Fulltrack/FMobileRN/ios/FMobileRN/Info.plist
# xcodebuild -exportArchive -archivePath "$pathBuildsProjectIOS"/$scheme.xcarchive -exportPath "$pathBuildsProjectIOS" -exportOptionsPlist $pathProject/$scheme/Resources/Info.plist
# mv "$pathBuildsProjectIOS"/$scheme.xcarchive/Products/Applications/$scheme.app "$pathBuildsProjectIOS"/$scheme.app # mv /YourXCArchiveLocation/archive.xcarchive/Products/Applications/AppName.app /YourDesiredLocation/AppName.app

echo $"\nInstalling the app in the Simulator...\n"
# /Users/macbook-estagio/Library/Developer/Xcode/DerivedData/FMobile-hfglaqjtwzslazebfxtllucugncr/Build/Products/Debug-iphonesimulator/FMobile.app
# xcrun simctl install $simulatorIPhone11ProMax $pathBuildsProjectIOS/$scheme
xcrun simctl install booted "$pathBuildsProjectIOS"/$scheme.app 

# xcrun simctl install $simulatorIPhone11ProMax ./build/Build/Products/Debug-iphonesimulator/$scheme.app
# xcrun simctl install booted ~/Documents/Fulltrack/FMobile6_IOS/$scheme
# xcrun simctl install booted "$pathBuildsProjectIOS"/$scheme


# xcrun simctl install booted /Users/macbook-estagio/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/AABTolls/Projetos/8030_Sekron SAT/BUILDS/IOS/old3/FMobile.xcarchive/Products/Applications/FMobile

sleep 5

echo $"\nLaunching the app after installation...\n"
xcrun simctl launch $simulatorIPhone11ProMax $bundle_id
