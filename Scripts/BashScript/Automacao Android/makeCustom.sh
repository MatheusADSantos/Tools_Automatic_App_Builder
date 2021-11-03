#!/bin/bash -i

print_light_gray() {
	printf "\e[0;37m$1\e[0m"
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

# sh $pathScripts/makeCustom.sh "$nome" "$bundle" "#$cor1" "$alias" "$passwordDaKeystore1" "$passwordDaKeystore2" "$nomeDaKeystore"
# makeCustom.sh "teste" "br.com.teste" "#000" "teste" "teste123" "teste123" "testekeystore"

appName=$1
bundle=$2
cor=$3
alias=$4
passwordDaKeystore1=$5
passwordDaKeystore2=$6
nomeDaKeystore=$7

print_red "\n\n>>> DADOS PARA CUSTOMIZAR <<<"
print_blue "\n\n- Nome do App: $appName \n- Bundle: $bundle \n- Cor: $cor \n- Alias: $alias 
\n- Password1: $passwordDaKeystore1 \n- Password2: $passwordDaKeystore2 \n- Nome da Keystore: $nomeDaKeystore "
print_red "\n\n\n                    >>>ATENÇÃO<<< \n... Aguardando 10 segundos pra conferir os dados ...\n\n"
sleep 10

pathScripts=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/BashScript
pathToAAB=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls/
pathImagens=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls/Imagens
keystorePath=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls/Keystores
pathProject=~/Documents/Fulltrack/FMobile6_Android #pode excluir!!!!!!!

changeAppName() {
	print_red "\n\n\n---------------------------------- App Name ----------------------------------"
	cd $pathProject/app/src/main/res/values/ # cd /Users/macbook-estagio/Documents/Fulltrack/FMobile6_Android/app/src/main/res/values
	awk -F '[<>]' '//{print}' strings.xml | awk -v varAppName="$appName" '{sub(/FMobile/,varAppName); print}' >>strings_2.xml
	rm strings.xml
	mv strings_2.xml strings.xml
}

structuringFoldersAndReplaceAllOccurrencesFromBundle() {
	print_red "\n\n\n----------------- Structuring folders according to the BUNDLE ----------------- \n -------------------AND Replacing all occurrences of the BUNDLE -------------------\n\n"

	# Criando a estrutura de pastas de acordo com o bundle e Migrar os arquivos dentro da hierarquia de pastas ...
	bundleWithoutDot=$(echo "$bundle" | awk 'gsub(/\./," ")') # Pegar o $bundle e separar os nomes pelos (.) Ex: br.com.teste -> cria pasta br, com e teste ...
	bundle1=$(echo "$bundleWithoutDot" | awk '{print $1;}')
	bundle2=$(echo "$bundleWithoutDot" | awk '{print $2;}')
	bundle3=$(echo "$bundleWithoutDot" | awk '{print $3;}')
	bundle4=$(echo "$bundleWithoutDot" | awk '{print $4;}')
	bundle5=$(echo "$bundleWithoutDot" | awk '{print $5;}')
	print_green "\n\n>>>Bundle Without Dot: $bundleWithoutDot \nBundle1: $bundle1 \nBundle2: $bundle2 \nBundle3: $bundle3 \nBundle4: $bundle4 \nBundle5: $bundle5\n\n"

	cd $pathProject/app/src/main/java/
	mkdir $bundle1
	cd $bundle1
	mkdir $bundle2
	cd $bundle2
	mkdir $bundle3

	# $([[ $bundle4 != '' ]] && cd $bundle3 || echo 'Só vai até o bundle3 ....')

	if [[ $bundle4 != '' ]]; then
		cd $bundle3
		mkdir $bundle4
		print_green "Agora preciso migrar as pastas que estavam em $pathProject/app/src/main/java/com/fulltrack/fmobile pra "
		print_light_green "\n$pathProject/app/src/main/java/$bundle1/$bundle2/$bundle3/$bundle4/"
		mv $pathProject/app/src/main/java/com/fulltrack/fmobile/* $pathProject/app/src/main/java/$bundle1/$bundle2/$bundle3/$bundle4/
		# mv ~/Documents/Fulltrack/FMobile6_Android/app/src/main/java/com/fulltrack/fmobile/* ~/Documents/Fulltrack/FMobile6_Android/app/src/main/java/br/com/teste
	else
		print_green "Agora preciso migrar as pastas que estavam em $pathProject/app/src/main/java/com/fulltrack/fmobile pra "
		print_light_green "\n$pathProject/app/src/main/java/$bundle1/$bundle2/$bundle3/"
		mv $pathProject/app/src/main/java/com/fulltrack/fmobile/* $pathProject/app/src/main/java/$bundle1/$bundle2/$bundle3/
	fi

	cd $pathProject/app/src/main/java
	rm -rf ./com
}

verifyIfExistKeystore() {
	print_blue "\n\nVerificando se já existe a keystore: ($nomeDaKeystore)"
	cd $keystorePath
	touch keystores.txt            #Criando projetos.txt
	printf "$(ls)" >>keystores.txt #Inserindo o conteúdo no projetos.txt
	# keystores=$(awk '//{print}' keystores.txt)
	keystore=$(grep "$nomeDaKeystore" keystores.txt)
	rm keystores.txt

	# if [[ $keystore != '' ]]; then
	if [[ $keystore == "$nomeDaKeystore.keystore" ]]; then
		print_blue "\n\nKeystore já existe!!! \nKeystore: $keystore"
	else
		print_light_red "\n\nKeystore não existe, gerando uma ..."
		sh $pathScripts/generatorKeystore.sh $nomeDaKeystore $alias $passwordDaKeystore1
		print_green "\n\nKeystore gerada!!! \nEm: $(pwd) -> $keystore \n\nTemos: \n$(ls)"
	fi

	cp $nomeDaKeystore.keystore $pathProject/$nomeDaKeystore.keystore
	# cp $nomeDaKeystore.keystore $pathToAAB/
}

makeKeystoreAndReplaceInProject() {
	print_red "\n\n\n--------------------------- Create/Replace Keystore ---------------------------\n"

	verifyIfExistKeystore

	# # # SUBSTITUINDO TODAS AS OCORRENCIAS DO BUNDLE ...
	# $(find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/com.fulltrack.fmobile/$bundle/g;")
}

updateColors() {
	#  <color name="colorAccent">#CF1C26</color>
	print_red "\n\n\n------------------------------ Update the Colors ------------------------------\n\n"
	cd $pathProject/app/src/main/res/values/
	awk -F '[<>]' '//{print}' colors.xml | awk -v varColor="$cor" '{sub(/#CF1C26/,varColor); print}' >>colors_2.xml
	rm colors.xml
	mv colors_2.xml colors.xml
}

updateImages() {
	print_red "\n\n\n------------------------------- Update Images -------------------------------\n\n"
	afplay /System/Library/Sounds/Blow.aiff
	osascript -e 'display alert "ATENÇÃO!" message "Verifique se já está com TODAS as imagens em ~/Downloads 
	\niconApp/iconStore/banner/splash \nPastas:res/ic_launcher/ic_launcher_round/ic_launcher_foreground" '

	print_light_red "\n\nVerifique se já está com TODAS as imagens/pastas em ~/Downloads/ ...\n"
	echo -e "IMAGENS: \n- icon \n- iconStore \n- ic_logo_autenticacao \n- banner 
	\nPASTAS: \n- res \n- ic_launcher \n- ic_launcher_round \n- ic_launcher_foreground"

	# Movendo as imagensf
	cp ~/Downloads/splash.png ~/Downloads/ic_logo_autenticacao.png
	cp ~/Downloads/ic_logo_autenticacao.png $pathImagens
	cp ~/Downloads/iconApp.png $pathImagens
	cp ~/Downloads/iconStore.png $pathImagens
	cp ~/Downloads/banner.png $pathImagens
	cp -R ~/Downloads/res/ $pathImagens/
	sleep 10

	# print_light_blue "\n\n-> Deletando a pasta <mimap-anydpi-v26> \nObs: Se o icone não estiver em xml\n"
	# # cd $pathProject/app/src/main/res/mimap-anydpi-v26
	# cd $pathProject/app/src/main/res/
	# rm -rf ./mipmap-anydpi-v26

	print_light_blue "\n\n-> Substituindo a pasta <mimap-anydpi-v26>"
	cd $pathProject/app/src/main/res/
	rm -rf ./mipmap-anydpi-v26
	cp -R $pathImagens/mipmap-anydpi-v26 $pathProject/app/src/main/res/

	print_light_blue "\n\n-> Trocando a logo de autenticação ..."
	rm $pathProject/app/src/main/res/drawable-mdpi/ic_logo_autenticacao.xml
	cp $pathImagens/ic_logo_autenticacao.png $pathProject/app/src/main/res/drawable-mdpi/

	# print_light_blue "\n\n-> Trocando o Splash ..."
	# cp $pathImagens/splash_logo.png $pathProject/app/src/main/res/drawable/

	# print_light_blue "\n\n-> Movendo os icones do app - ic_launcher"
	# cp $pathImagens/mipmap-hdpi/ic_launcher.png $pathProject/app/src/main/res/mipmap-hdpi/
	# cp $pathImagens/mipmap-mdpi/ic_launcher.png $pathProject/app/src/main/res/mipmap-mdpi/
	# cp $pathImagens/mipmap-xhdpi/ic_launcher.png $pathProject/app/src/main/res/mipmap-xhdpi/
	# cp $pathImagens/mipmap-xxhdpi/ic_launcher.png $pathProject/app/src/main/res/mipmap-xxhdpi/
	# cp $pathImagens/mipmap-xxxhdpi/ic_launcher.png $pathProject/app/src/main/res/mipmap-xxxhdpi/

	# print_light_blue "\n\n-> Movendo os icones do app - ic_launcher_round"
	# cp $pathImagens/mipmap-hdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-hdpi/
	# cp $pathImagens/mipmap-mdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-mdpi/
	# cp $pathImagens/mipmap-xhdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-xhdpi/
	# cp $pathImagens/mipmap-xxhdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-xxhdpi/
	# cp $pathImagens/mipmap-xxxhdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-xxxhdpi/

	# print_light_blue "\n\n-> Movendo os icones do app - ic_launcher_foreground"
	# cp $pathImagens/mipmap-hdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-hdpi/
	# cp $pathImagens/mipmap-mdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-mdpi/
	# cp $pathImagens/mipmap-xhdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-xhdpi/
	# cp $pathImagens/mipmap-xxhdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-xxhdpi/
	# cp $pathImagens/mipmap-xxxhdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-xxxhdpi/

	# print_light_blue "\n\n-> Movendo os icones de push"
	# cp $pathImagens/drawable-hdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-hdpi/
	# cp $pathImagens/drawable-mdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-mdpi/
	# cp $pathImagens/drawable-xhdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-xhdpi/
	# cp $pathImagens/drawable-xxhdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-xxhdpi/
	# cp $pathImagens/drawable-xxxhdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-xxxhdpi/

	# ----------------------------------------------------------------------------------------------------------------------------------------

	print_light_blue "\n\n-> Movendo os icones de push"
	cp $pathImagens/drawable-hdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-hdpi/
	cp $pathImagens/drawable-mdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-mdpi/
	cp $pathImagens/drawable-xhdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-xhdpi/
	cp $pathImagens/drawable-xxhdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-xxhdpi/
	cp $pathImagens/drawable-xxxhdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-xxxhdpi/

	print_light_blue "\n\n-> Movendo TODOS icones do app - \nic_launcher/ic_launcher_round/ic_launcher_foreground\nE seus: adaptive_fore e adaptive_back"
	cp $pathImagens/mipmap-hdpi/* $pathProject/app/src/main/res/mipmap-hdpi/
	cp $pathImagens/mipmap-mdpi/* $pathProject/app/src/main/res/mipmap-mdpi/
	cp $pathImagens/mipmap-xhdpi/* $pathProject/app/src/main/res/mipmap-xhdpi/
	cp $pathImagens/mipmap-xxhdpi/* $pathProject/app/src/main/res/mipmap-xxhdpi/
	cp $pathImagens/mipmap-xxxhdpi/* $pathProject/app/src/main/res/mipmap-xxxhdpi/

	# print_light_blue "\n\n-> Movendo os icones do app - ic_launcher_round"
	# cp $pathImagens/mipmap-hdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-hdpi/
	# cp $pathImagens/mipmap-mdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-mdpi/
	# cp $pathImagens/mipmap-xhdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-xhdpi/
	# cp $pathImagens/mipmap-xxhdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-xxhdpi/
	# cp $pathImagens/mipmap-xxxhdpi/ic_launcher_round.png $pathProject/app/src/main/res/mipmap-xxxhdpi/

	# print_light_blue "\n\n-> Movendo os icones do app - ic_launcher_foreground"
	# cp $pathImagens/mipmap-hdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-hdpi/
	# cp $pathImagens/mipmap-mdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-mdpi/
	# cp $pathImagens/mipmap-xhdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-xhdpi/
	# cp $pathImagens/mipmap-xxhdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-xxhdpi/
	# cp $pathImagens/mipmap-xxxhdpi/ic_launcher_foreground.png $pathProject/app/src/main/res/mipmap-xxxhdpi/
}

replaceAllOccurenceBundleAndRemoveIDEAandGRADLE() {
	cd $pathProject

	print_red "\n\nSUBSTITUINDO TODAS AS OCORRENCIAS DO BUNDLE ... \nE removendo o workspace.xml\n\n"

	# cd .idea/
	# rm workspace.xml

	$(find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/com.fulltrack.fmobile/$bundle/g;") # SUBSTITUINDO TODAS AS OCORRENCIAS DO BUNDLE ...

	rm -rf .idea
	rm -rf .gradle

	# cd .idea/
	# $(find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/com.fulltrack.fmobile/$bundle/g;")
	# $(find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/com\/fulltrack\/fmobile/$bundle1\/$bundle2\/$bundle3/g;")
	# $(find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/C:\Users\\danie\\AndroidStudioProjects\\FMobileAndroid\/~\/Documents\/Fulltrack\/FMobile6_Android\/g;") - PRECISA ARRUMAR SE FOR USAR
	# C:\Users\danie\AndroidStudioProjects\FMobileAndroid
	# cd ..

	# print_red "\n\nABRINDO O ANDROID STUDIO"
	# open -a Android\ Studio
	# sleep 20
}

uploadFileGoogleService() {
	print_red "\n\n\n---------------------- Upload File google-services.json ----------------------\n"
	cp ~/Downloads/google-services.json $pathProject/app/
	cp ~/Downloads/google-services.json $pathToAAB
	echo -e "\n\n\n"
}

openAndroidStudio() {
	print_light_red "\n\nABRINDO O ANDROID STUDIO..."
	open -a Android\ Studio $pathProject
	sleep 20
	afplay /System/Library/Sounds/Blow.aiff
	print_light_gray "\nJá sincronizou o projeto??? \nSe SIM de um 'return' pra continuar ..."
	read sincronizou
}

makeCustom() {

	changeAppName

	structuringFoldersAndReplaceAllOccurrencesFromBundle

	makeKeystoreAndReplaceInProject

	updateColors

	updateImages

	uploadFileGoogleService

	replaceAllOccurenceBundleAndRemoveIDEAandGRADLE

	openAndroidStudio

}

makeCustom
