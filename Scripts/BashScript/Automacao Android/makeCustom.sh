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

print_red "\n\n>>> Datas for custom <<<"
print_blue "\n\n- Nome do App: $appName \n- Bundle: $bundle \n- Cor: $cor \n- Alias: $alias 
\n- Password1: $passwordDaKeystore1 \n- Password2: $passwordDaKeystore2 \n- Nome da Keystore: $nomeDaKeystore "
print_red "\n\n\n                    >>>ATENÇÃO<<< \n... Aguardando 10 segundos pra conferir os dados ...\n\n"
sleep 10

pathScripts=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript
pathToRoot=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/
pathImagens=~/Documents/tools-automatic-app-customs/Imagens/
keystorePath=~/Documents/tools-automatic-app-customs/Keystores/
pathProject=~/Documents/Fulltrack/FMobile6_Android #pode excluir!!!!!!!

changeAppName() {
	print_red "\n\n_______ App Name "
	cd $pathProject/app/src/main/res/values/ # cd /Users/macbook-estagio/Documents/Fulltrack/FMobile6_Android/app/src/main/res/values
	awk -F '[<>]' '//{print}' strings.xml | awk -v varAppName="$appName" '{sub(/FMobile/,varAppName); print}' >>strings_2.xml
	rm strings.xml
	mv strings_2.xml strings.xml
}

updateDimensionLogo() {
	print_red "\n\n_______ Dimension Logo "
	# layout_width="android:layout_width="194dp""
	# layout_height="android:layout_height="83dp""
	cd $pathProject/app/src/main/res/layout/

	awk -F '[<>]' '//{print}' activity_verify_number.xml | awk '{sub(/91/,184); print}' >>activity_verify_number_2.xml
	rm activity_verify_number.xml
	mv activity_verify_number_2.xml activity_verify_number.xml

	slepp 5

	awk -F '[<>]' '//{print}' activity_verify_number.xml | awk '{sub(/53/,104); print}' >>activity_verify_number_2.xml
	rm activity_verify_number.xml
	mv activity_verify_number_2.xml activity_verify_number.xml
}

structuringFoldersAndReplaceAllOccurrencesFromBundle() {
	print_red "\n\n_______ Structuring folders according to the BUNDLE and Replace all occurrences of bundle..."

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

	if [[ $bundle4 != '' ]]; then
		cd $bundle3
		mkdir $bundle4
		print_green "Now I need to migrate the folders that were in $pathProject/app/src/main/java/com/fulltrack/fmobile to "
		print_light_green "\n$pathProject/app/src/main/java/$bundle1/$bundle2/$bundle3/$bundle4/"
		mv $pathProject/app/src/main/java/com/fulltrack/fmobile/* $pathProject/app/src/main/java/$bundle1/$bundle2/$bundle3/$bundle4/
	else
		print_green "Now I need to migrate the folders that were in $pathProject/app/src/main/java/com/fulltrack/fmobile to "
		print_light_green "\n$pathProject/app/src/main/java/$bundle1/$bundle2/$bundle3/"
		mv $pathProject/app/src/main/java/com/fulltrack/fmobile/* $pathProject/app/src/main/java/$bundle1/$bundle2/$bundle3/
	fi

	cd $pathProject/app/src/main/java
	rm -rf ./com
}

verifyKeystoreAndMakeIt() {
	print_red "\n\n_______ Create/Replace Keystore "
	print_blue "\n\nChecking if a keystore($nomeDaKeystore) already exists..."
	cd $keystorePath
	touch keystores.txt            #Criando projetos.txt
	printf "$(ls)" >>keystores.txt #Inserindo o conteúdo no projetos.txt
	keystore=$(grep "$nomeDaKeystore" keystores.txt)
	rm keystores.txt

	if [[ $keystore == "$nomeDaKeystore.keystore" ]]; then
		print_blue "\n\nKeystore already exists!!! \nKeystore: $keystore"
	else
		print_light_red "\n\nKeystore doesn't exixst, generate one..."
		sh $pathScripts/Utils/generatorKeystore.sh $nomeDaKeystore $alias $passwordDaKeystore1
		print_green "\n\nKeystore generated!!! \nIn: $(pwd) -> $keystore \n\nWe have: \n$(ls)"
	fi

	cp $nomeDaKeystore.keystore $pathProject/$nomeDaKeystore.keystore
}

updateColors() {
	#  <color name="colorAccent">#CF1C26</color>
	print_red "\n\n_______ Update the Colors "
	cd $pathProject/app/src/main/res/values/
	awk -F '[<>]' '//{print}' colors.xml | awk -v varColor="$cor" '{sub(/#CF1C26/,varColor); print}' >>colors_2.xml
	rm colors.xml
	mv colors_2.xml colors.xml
}

updateImages() {
	print_red "\n\n_______ Update Images"
	afplay /System/Library/Sounds/Blow.aiff
	osascript -e 'display alert "Atention!" message "Make sure you have ALL images in: ~/Downloads like: 
	\niconApp/iconStore/banner/splash \nFolders:res/ic_launcher/ic_launcher_round/ic_launcher_foreground" '

	print_light_red "\n\nMake sure you have ALL the images in: ~/Downloads/ ...\n"
	echo -e "IMAGENS: \n- iconApp \n- iconStore \n- ic_logo_autenticacao \n- banner 
	\nPASTAS: \n- res \n- ic_launcher \n- ic_launcher_round \n- ic_launcher_foreground"

	print_light_blue "\n\n-> Moving images..."
	cp ~/Downloads/splash.png ~/Downloads/ic_logo_autenticacao.png
	cp ~/Downloads/ic_logo_autenticacao.png $pathImagens

	cp ~/Downloads/splash.png ~/Downloads/ic_push_notification_default.png
	cp ~/Downloads/ic_push_notification_default.png $pathImagens

	cp ~/Downloads/iconApp.png $pathImagens
	cp ~/Downloads/iconApp.svg $pathImagens
	cp ~/Downloads/iconStore.png $pathImagens
	cp ~/Downloads/banner.png $pathImagens
	cp -R ~/Downloads/res/ $pathImagens/
	sleep 10

	print_light_blue "\n\n-> Replacing the folder(mimap-anydpi-v26)..."
	cd $pathProject/app/src/main/res/
	rm -rf ./mipmap-anydpi-v26
	cp -R $pathImagens/mipmap-anydpi-v26 $pathProject/app/src/main/res/

	print_light_blue "\n\n-> Replacing the authentication logo..."
	rm $pathProject/app/src/main/res/drawable-mdpi/ic_logo_autenticacao.xml
	cp $pathImagens/ic_logo_autenticacao.png $pathProject/app/src/main/res/drawable-mdpi/

	print_light_blue "\n\n-> Replacing push icons..."
	cp $pathImagens/drawable-hdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-hdpi/
	cp $pathImagens/drawable-mdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-mdpi/
	cp $pathImagens/drawable-xhdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-xhdpi/
	cp $pathImagens/drawable-xxhdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-xxhdpi/
	cp $pathImagens/drawable-xxxhdpi/ic_push_notification_default.png $pathProject/app/src/main/res/drawable-xxxhdpi/

	print_light_blue "\n\n-> Moving all app icons - \nic_launcher/ic_launcher_round/ic_launcher_foreground\nAnd yours: adaptive_fore e adaptive_back"
	cp $pathImagens/mipmap-hdpi/* $pathProject/app/src/main/res/mipmap-hdpi/
	cp $pathImagens/mipmap-mdpi/* $pathProject/app/src/main/res/mipmap-mdpi/
	cp $pathImagens/mipmap-xhdpi/* $pathProject/app/src/main/res/mipmap-xhdpi/
	cp $pathImagens/mipmap-xxhdpi/* $pathProject/app/src/main/res/mipmap-xxhdpi/
	cp $pathImagens/mipmap-xxxhdpi/* $pathProject/app/src/main/res/mipmap-xxxhdpi/
}

replaceAllOccurenceBundleAndRemoveIDEAandGRADLE() {
	cd $pathProject
	print_red "\n\n_______ REPLACING ALL BUNDLE OCCURRENCES... \n_______ And removing the workspace.xml\n\n"

	$(find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/com.fulltrack.fmobile/$bundle/g;") # SUBSTITUINDO TODAS AS OCORRENCIAS DO BUNDLE ...
	# $(find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/com.fulltrack.fmobile/br.com.velox.mobile/g;")

	rm -rf .idea
	rm -rf .gradle
}

uploadFileGoogleService() {
	print_red "\n\n_______ Upload File google-services.json "
	cp ~/Downloads/google-services.json $pathProject/app/
	cp ~/Downloads/google-services.json $pathToRoot
	echo -e "\n\n\n"
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

makeCustom() {

	changeAppName

	updateDimensionLogo

	structuringFoldersAndReplaceAllOccurrencesFromBundle

	verifyKeystoreAndMakeIt

	updateColors

	updateImages

	uploadFileGoogleService

	replaceAllOccurenceBundleAndRemoveIDEAandGRADLE

	openAndroidStudio

}

makeCustom
