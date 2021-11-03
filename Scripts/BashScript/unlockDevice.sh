#!/bin/bash -i

# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

# makeCustom() {
# 	# A IMPLEMENTAR ...
# 	pathProject5=~/Documents/Fulltrack/FMobileRN/android
# 	pathProject6=~/Documents/Fulltrack/FMobile6_Android/

# 	cd $pathProject5

# 	status=$(git status | grep "nothing to commit, working tree clean")
# 	while [[ $status != 'nothing to commit, working tree clean' ]]; do
# 		echo $"Please, verify your tree from git ... then continue your custom ..."

# 		afplay /System/Library/Sounds/Blow.aiff
# 		osascript -e 'display alert "ATENÇÃO!" message "Verifique sua arvore na branch $(git branch)!"'

# 		status=$(git status | grep "nothing to commit, working tree clean")
# 	done

# 	echo $"-> Branch nova? (y/n) "
# 	read branchNova

# 	if [[branchNova == y ]]; then
# 		afplay /System/Library/Sounds/Blow.aiff
# 		osascript -e 'display alert "ATENÇÃO!" message "Verifique se está conectado na VPN"'
# 		git checkout master
# 		git pull
# 		sleep 2

# 		echo $"-> Nome da Branch? "
# 		read branch
# 		git checkout -b $branch
# 	else
# 		afplay /System/Library/Sounds/Blow.aiff
# 		osascript -e 'display alert "ATENÇÃO!" message "Verifique se está conectado na VPN"'
# 		git checkout master
# 		git pull
# 		sleep 2

# 		git branch
# 		echo $"\n-> Nome da Branch? "
# 		read branch
# 		git checkout $branch
# 	fi
# }
# makeCustom

# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

# pathScripts=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/BashScript
# sh $pathScripts/connectDeviceFromIPAdress.sh

# # if [[ ($(adb devices) == *"172.19.12.90:5555"*) || ($(adb devices) == *"192.168.86.3:5555"*) ]]; then
# if [[ $(adb devices) == *"$ipAdressFromMobile:5555"* ]]; then

# 	echo $"\n\n>>> Celular está conectado pelo WIFI <<<"

# 	mIsShowing=$(adb shell dumpsys window | grep mIsShowing | awk '{sub(/        mIsShowing=/,""); print}')
# 	if [[ $mIsShowing == true ]]; then
# 		echo $"*** O Celular esta ... >>>BLOQUEADO<<< ***\n\n"
# 		afplay /System/Library/Sounds/Blow.aiff
# 		# osascript -e 'display alert "ATENÇÃO!" message "Celular BLOQUEADO!"'

# 		# adb shell input keyevent 26 && adb shell input swipe 100 1450 100 500 100 && adb shell input text "ads4137" && adb shell input keyevent 66
# 		adb shell input keyevent 26 && adb shell input swipe 100 1450 100 500 100 && adb shell input text "ads4137" && adb shell input tap 972 2160
# 	else
# 		echo $"*** O Celular esta ... >>>DESBLOQUEADO<<< ***\n\n"
# 	fi

# else
# 	echo $"\n\n>>> Celular está conectado pelo CABO <<<"

# 	lock=$(adb shell dumpsys window | grep mDreamingLockscreen)
# 	mShowingDream="mShowingDream=false"
# 	mDreamingLockscreen="mDreamingLockscreen=true"
# 	mDreamingSleepToken="mDreamingSleepToken=null"

# 	if [[ "$lock" == *$mShowingDream* && "$lock" == *$mDreamingLockscreen* && "$lock" == *$mDreamingSleepToken* ]]; then
# 		echo $"*** O Celular esta ... >>>BLOQUEADO<<< ***\n\n"
# 		afplay /System/Library/Sounds/Blow.aiff
# 		# osascript -e 'display alert "ATENÇÃO!" message "Celular BLOQUEADO!"'

# 		# adb shell input keyevent 26 && adb shell input swipe 100 1450 100 500 100 && adb shell input text "ads4137" && adb shell input keyevent 66
# 		adb shell input keyevent 26 && adb shell input swipe 100 1450 100 500 100 && adb shell input text "ads4137" && adb shell input tap 972 2160
# 	else
# 		echo $"*** O Celular esta ... >>>DESBLOQUEADO<<< ***\n\n"
# 	fi
# fi

# afplay /System/Library/Sounds/Blow.aiff
# sleep 1
# afplay /System/Library/Sounds/Blow.aiff
# sleep 1
# afplay /System/Library/Sounds/Blow.aiff
# osascript -e 'display alert "ATENÇÃO!" message "Vai ser instalado o aplicativo! \nDe OK para continuar..."'

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# pathProject=~/Documents/Fulltrack/FMobile6_Android/

# echo "BUNDLE: "
# read bundle

# bundleWithoutDot=$(echo "$bundle" | awk 'gsub(/\./," ")')
# bundle1=$(echo "$bundleWithoutDot" | awk '{print $1;}')
# bundle2=$(echo "$bundleWithoutDot" | awk '{print $2;}')
# bundle3=$(echo "$bundleWithoutDot" | awk '{print $3;}')
# echo $"\n>>>Bundle Without Dot: $bundleWithoutDot \nBundle1: $bundle1 \nBundle2: $bundle2 \nBundle3: $bundle3"

# cd $pathProject/app/src/main/java/
# # Pegar o $bundle e separar os nomes pelos (.) Ex: br.com.teste -> cria pasta br, com e teste ...
# mkdir $bundle1
# cd ./$bundle1
# mkdir $bundle2
# cd ./$bundle2
# # mkdir $bundle3
# # cd ./$bundle3

# # Agora preciso migrar as pastas que estavam no path ...app/src/main/java/com/fulltrack.fmobile para o app/src/main/java/$bundle3
# # cd $pathProject/app/src/main/java/com/fulltrack/
# mv $pathProject/app/src/main/java/com/fulltrack/fmobile $pathProject/app/src/main/java/$bundle1/$bundle2/$bundle3
# # cd $pathProject/app/src/main/java/$bundle1/$bundle2/
# # mv fmobile $bundle3

# # rm bundleText.txt
# # rm text.txt

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# # Depois de conectado, vamos desbloquea-lo
# echo  $"IP do device a ser desbloqueado: \nWireless: $1 \nCabo: $2"

# if [[ $1 != '' ]]; then
# 	echo  $"\n\n>>> Celular está conectado pelo WIFI <<<"
# 	mIsShowing=$(adb shell dumpsys window | grep mIsShowing | awk '{sub(/        mIsShowing=/,""); print}')

# 	if [[ $mIsShowing == true ]]; then
# 		echo  $"*** O Celular esta ... >>>BLOQUEADO<<< ***\n\n"
# 		afplay /System/Library/Sounds/Blow.aiff

# 		# adb shell input keyevent 26 && adb shell input swipe 100 1450 100 500 100 && adb shell input text "ads4137" && adb shell input keyevent 66
# 		adb shell input keyevent 26 && adb shell input swipe 100 1450 100 500 100 && adb shell input text "ads4137" && adb shell input tap 972 2160
# 	else
# 		echo  $"*** O Celular esta ... >>> DESBLOQUEADO <<< ***\n\n"
# 	fi

# else
# 	echo  $"\n\n>>> Celular está conectado pelo CABO <<<"

# 	lock=$(adb shell dumpsys window | grep mDreamingLockscreen)
# 	mShowingDream="mShowingDream=false"
# 	mDreamingLockscreen="mDreamingLockscreen=true"
# 	mDreamingSleepToken="mDreamingSleepToken=null"

# 	if [[ "$lock" == *$mShowingDream* && "$lock" == *$mDreamingLockscreen* && "$lock" == *$mDreamingSleepToken* ]]; then
# 		echo  $"*** O Celular esta ... >>> BLOQUEADO <<< ***\n\n"
# 		afplay /System/Library/Sounds/Blow.aiff

# 		# adb shell input keyevent 26 && adb shell input swipe 100 1450 100 500 100 && adb shell input text "ads4137" && adb shell input keyevent 66
# 		adb shell input keyevent 26 && adb shell input swipe 100 1450 100 500 100 && adb shell input text "ads4137" && adb shell input tap 972 2160
# 	else
# 		echo  $"*** O Celular esta ... >>> DESBLOQUEADO <<< ***\n\n"
# 	fi
# fi

# afplay /System/Library/Sounds/Blow.aiff
# sleep 1
# afplay /System/Library/Sounds/Blow.aiff
# sleep 1
# afplay /System/Library/Sounds/Blow.aiff
# osascript -e 'display alert "ATENÇÃO!" message "Vai ser instalado o aplicativo! \nDe OK para continuar..."'

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# VERIFICAR SE É A CABO OU NÃO (Pra ser pelo WIFI, ou vem como parametro pelo connectionDeviceFromIPAdress, ou ao dar o commando 'adb device', tenha o inicio do IP: 192.168.86)
# DESCOBRIR QUAL DISPOSITIVO ESTOU TENTANDO DESBLOQUEAR
# VERIFICAR SE ESTA CONECTADO PELO WIFI OU CABO
# DEPENDENDO DO DEVICE DESBLOQUEAR...

# IPDeviceToUnlock=$1
# nameDeviceToUnlock=$2

checkingWhichDeviceIsConnectedAndIfItIsOnWifi() {
	if [[ $(adb devices | awk '/[[:digit:]]/ {print$1}' | awk '/\./ {print}') != '' ]]; then
		IPDeviceToUnlock=$(adb devices | awk '/[[:digit:]]/ {print$1}' | awk '/\./ {print}')
		connectedByWIFI=true
		if [[ $IPDeviceToUnlock == *'5555'* ]]; then
			nameDeviceToUnlock='Redmi Note 9S'
		else
			nameDeviceToUnlock='Samsung Galaxy A01'
		fi
	else
		connectedByWIFI=false
		IPDeviceToUnlock=$(adb devices | awk '/[[:digit:]]/ {print$1}' | awk 'NR==1{print $1}')
	fi
}
checkingWhichDeviceIsConnectedAndIfItIsOnWifi

dealWithUnlockDevice() {
	echo -e $"-> Conectado pelo WIFI? \n-> $connectedByWIFI"
	if [[ $connectedByWIFI == true ]]; then
		echo -e $"\n>>> Você está conectado pelo WIFI \nNo dispositivo: "$nameDeviceToUnlock" \nDe IP(s): $IPDeviceToUnlock \n"

		mIsShowing=$(adb -s "$IPDeviceToUnlock" shell dumpsys window | grep mIsShowing | awk '{sub(/        mIsShowing=/,""); print}')
		if [[ $mIsShowing == true ]]; then
			echo -e "*** O Celular esta ... >>>BLOQUEADO<<< ***\n\n"
			if [[ $nameDeviceToUnlock == 'Redmi Note 9S' ]]; then
				afplay /System/Library/Sounds/Blow.aiff
				adb -s "$IPDeviceToUnlock" shell input keyevent 26 && adb -s "$IPDeviceToUnlock" shell input swipe 100 1450 100 500 100 && adb -s "$IPDeviceToUnlock" shell input text "ads4137" && adb -s "$IPDeviceToUnlock" shell input tap 972 2160
			else
				afplay /System/Library/Sounds/Blow.aiff
				adb -s "$IPDeviceToUnlock" shell input keyevent 26 && adb -s "$IPDeviceToUnlock" shell input swipe 360 1520 360 500 100
			fi
		else
			echo -e "*** O Celular esta ... >>> DESBLOQUEADO <<< ***\n\n"
		fi
	else
		echo -e $"\n>>> Você está conectado pelo CABO USB \nNo dispositivo: "$nameDeviceToUnlock" \nDe IP(s): $IPDeviceToUnlock \n"

		lock=$(adb -s "$IPDeviceToUnlock" shell dumpsys window | grep mDreamingLockscreen)
		mShowingDream="mShowingDream=false"
		mDreamingLockscreen="mDreamingLockscreen=true"
		# mDreamingSleepToken="mDreamingSleepToken=null"

		if [[ "$lock" == *$mShowingDream* && "$lock" == *$mDreamingLockscreen* ]]; then #"$lock" == *$mDreamingSleepToken* ]]; then
			echo -e "*** O Celular esta ... >>> BLOQUEADO <<< ***\n\n"
			afplay /System/Library/Sounds/Blow.aiff
			adb -s "$IPDeviceToUnlock" shell input keyevent 26 && adb -s "$IPDeviceToUnlock" shell input swipe 360 1520 360 500 100
		else
			echo -e "*** O Celular esta ... >>> DESBLOQUEADO <<< ***\n\n"
		fi
	fi
}
dealWithUnlockDevice

if [[ $1 == 'instalar aplicativo' ]]; then
	afplay /System/Library/Sounds/Blow.aiff
	afplay /System/Library/Sounds/Blow.aiff
	sleep 1
	afplay /System/Library/Sounds/Blow.aiff
	osascript -e 'display alert "ATENÇÃO!" message "Vai ser instalado o aplicativo! \nDe OK para continuar..."'
fi
