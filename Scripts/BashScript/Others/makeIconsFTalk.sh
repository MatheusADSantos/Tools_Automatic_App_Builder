#!/bin/bash -i

# changeAppName() {
# 	print_red "\n\n_______ App Name "
# 	cd $pathProject/app/src/main/res/values/ # cd /Users/macbook-estagio/Documents/Fulltrack/FMobile6_Android/app/src/main/res/values
# 	awk -F '[<>]' '//{print}' strings.xml | awk -v varAppName="$appName" '{sub(/FMobile/,varAppName); print}' >>strings_2.xml
# 	rm strings.xml
# 	mv strings_2.xml strings.xml
# }

updateImages() {
	echo -e "\n\n\nCOMEÇANDO O SCRIPT DE GERAÇÃO DE ICONES - FTALK"

	afplay /System/Library/Sounds/Hero.aiff
	echo -e "\n\nVerifique se o nome do icone está como: 'iconApp.png'? (y/n)"
	read iconRight

	if [[ $iconRight == 'y' ]]; then

		pathProject=~/Documents/Fulltrack/FTalk_Android/
		pathImagens=~/Downloads/res/

		cp ~/Downloads/iconApp.png ~/Downloads/logo_reduzido.png
		cp ~/Downloads/iconApp.png ~/Downloads/ic_stat_onesignal_default.png
		cp ~/Downloads/splash.png ~/Downloads/logo_splash.png

		echo -e "\n\nAtivando o venv do Python e chamando seu script pra gerar os icones ..."
		sh ~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript/Automacao\ Android/callScriptsPython.sh

		echo -e "\n\nReplacing the folder(mimap-anydpi-v26)..."
		cd $pathProject/app/src/main/res/
		rm -rf ./mipmap-anydpi-v26
		cp -R $pathImagens/mipmap-anydpi-v26 $pathProject/app/src/main/res/

		echo -e "\n\n-> Replacing push icons..."
		cp $pathImagens/drawable-hdpi/ic_push_notification_default.png $pathImagens/drawable-hdpi/ic_stat_onesignal_default.png
		cp $pathImagens/drawable-mdpi/ic_push_notification_default.png $pathImagens/drawable-hdpi/ic_stat_onesignal_default.png 
		cp $pathImagens/drawable-xhdpi/ic_push_notification_default.png $pathImagens/drawable-hdpi/ic_stat_onesignal_default.png 
		cp $pathImagens/drawable-xxhdpi/ic_push_notification_default.png $pathImagens/drawable-hdpi/ic_stat_onesignal_default.png 
		cp $pathImagens/drawable-xxxhdpi/ic_push_notification_default.png $pathImagens/drawable-hdpi/ic_stat_onesignal_default.png 

		cp $pathImagens/drawable-hdpi/ic_stat_onesignal_default.png $pathProject/app/src/main/res/drawable-hdpi/
		cp $pathImagens/drawable-mdpi/ic_stat_onesignal_default.png $pathProject/app/src/main/res/drawable-mdpi/
		cp $pathImagens/drawable-xhdpi/ic_stat_onesignal_default.png $pathProject/app/src/main/res/drawable-xhdpi/
		cp $pathImagens/drawable-xxhdpi/ic_stat_onesignal_default.png $pathProject/app/src/main/res/drawable-xxhdpi/
		cp $pathImagens/drawable-xxxhdpi/ic_stat_onesignal_default.png $pathProject/app/src/main/res/drawable-xxxhdpi/

		cp $pathImagens/mipmap-hdpi/* $pathProject/app/src/main/res/mipmap-hdpi/
		cp $pathImagens/mipmap-mdpi/* $pathProject/app/src/main/res/mipmap-mdpi/
		cp $pathImagens/mipmap-xhdpi/* $pathProject/app/src/main/res/mipmap-xhdpi/
		cp $pathImagens/mipmap-xxhdpi/* $pathProject/app/src/main/res/mipmap-xxhdpi/
		cp $pathImagens/mipmap-xxxhdpi/* $pathProject/app/src/main/res/mipmap-xxxhdpi/

		afplay /System/Library/Sounds/Hero.aiff
		echo -e "\n\nReplacing the authentication logo..."
		echo -e "\nVerifique se a logo_reduzido está com dimensão de 300x300 \nE a logo_splash está com dimensão de 528x528 \n(y/n)???"
		read logoRight

		if [[ $logoRight == 'y' ]]; then
			mv ~/Downloads/logo_reduzido.png $pathProject/app/src/main/res/drawable/
			mv ~/Downloads/logo_splash.png $pathProject/app/src/main/res/drawable/
		fi
	fi
}

openAndroidStudio() {
	print_light_red "\n\n_______ Opening the ANDROID STUDIO..."
	open -a Android\ Studio $pathProject

	# ./gradlew check

	sleep 20
	afplay /System/Library/Sounds/Blow.aiff
	print_light_gray "\nAlready synchronized the project??? \nIf YES, then take a return to continue..."
	read sincronizou
}

makeIconsFTalk() {

	# changeAppName

	updateImages

	openAndroidStudio

}

makeIconsFTalk
