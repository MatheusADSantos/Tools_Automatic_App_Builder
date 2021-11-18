#!/bin/bash -i

echo -e "Verfique se você: 
\n-Se o devide está conectado via USB 
\n-Se está reconhecendo o dispositivo (adb devices) 
\n-Está conectado no mesmo WIFI\n\n"

getDevice() {
	touch devices.txt
	printf "$(adb devices)" >>devices.txt
	device=$(awk '/[[:digit:]]/ {print$1}' devices.txt)
	rm devices.txt
}

getIDAdressFromDevice() {
	touch configID.txt
	printf "$(adb shell ip addr show wlan0)" >>configID.txt
	# awk '{ gsub ("/24", "", $0); print}' -> Redmi Note 9S ((E)) awk '{ gsub ("/16", "", $0); print}' -> Samsung Galaxy A01  |  Estudar como buscar somente até a barra(/)
	ipAdressFromMobile=$(awk '/inet /{print$2}' ./configID.txt | awk '{ gsub ("/24", "", $0); print}' | awk '{ gsub ("/16", "", $0); print}')
	rm configID.txt
	echo -e "\n-> Endereço IP mobile: \n$ipAdressFromMobile\n"
}

connectDevice() {
	echo "Qual device você está querendo conectar Redmi Note 9S ou Samsung Galaxy A01? (R/S)"
	read deviceToConnect
	adb kill-server

	if [[ $deviceToConnect == 'R' || $deviceToConnect == 'r' ]]; then
		echo -e "\nVocê está tentando conectar-se ao Redmi Note 9S"
		adb tcpip 5555
		sleep 5
		adb connect $ipAdressFromMobile:5555
		IPDeviceToUnlock=$ipAdressFromMobile:5555
		nameDeviceToUnlock="Redmi Note 9S"
	else
		echo -e "\nVocê está tentando conectar-se ao Samsung Galaxy A01"
		adb tcpip 5556
		sleep 5
		adb connect $ipAdressFromMobile:5556
		IPDeviceToUnlock=$ipAdressFromMobile:5556
		nameDeviceToUnlock="Samsung Galaxy A01"
	fi
}

dealWithToConnectDevice() {
	getDevice
	echo -e "-> Device(s) achado(s): \n$device \n"

	if [[ $device == "" ]]; then
		afplay /System/Library/Sounds/Blow.aiff
		osascript -e 'display alert "ATENÇÃO!" message "Conecte seu celular a um cabo USB/TipoC no computador..."'

		echo -e "Conecte seu celular a um cabo USB/TipoC no computador... \nConectou?(y/n)"
		read connected
		sleep 2

		if [[ $connected == 'y' ]]; then
			getDevice
			getIDAdressFromDevice
			connectDevice
		fi

	else
		if [[ $1 == '' ]]; then
			echo -e "-> Já existe ao menos 1 device conectado! \n-> Deseja conectarse a outro ou de outra forma(Wireless)?(y/n)"
			read connectToOther
		else
			connectToOther=$1
		fi
		if [[ $connectToOther == 'y' ]]; then
			getIDAdressFromDevice
			connectDevice
		else
			getIDAdressFromDevice
		fi
	fi
}
dealWithToConnectDevice

# pathScripts=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript
# sh $pathScripts/unlockDevice.sh "$IPDeviceToUnlock" "$nameDeviceToUnlock"
