# !/bin/bash -i

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

print_light_gray() {
  printf "\e[1;37m$1\e[0m"
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

print_light_red "\n\n*********************************\nComeçando às $(date +%F\ %T)\n*********************************"

print_green "\n\n--------------------------------------------------------------------------------------"
print_green "\n\n-------------------  $(print_light_green "AUTOMAÇÃO DE CUSTOMIZAÇÃO FMOBILE 6.0 ANDROID")  $(print_green "------------------")"
print_green "\n\n--------------------------------------------------------------------------------------"

gitCheck() {
  print_light_red "\n\n\n------------------------- Checking Status from GIT -------------------------\n\n"
  newProjectOrUpdate=$1
  cd $pathProject
  status=$(git status | grep "nothing to commit, working tree clean")

  while [[ $status != 'nothing to commit, working tree clean' ]]; do
    echo -e "\nPlease, verify your tree from git ... then continue your custom ..."

    afplay /System/Library/Sounds/Blow.aiff
    osascript -e 'display alert "ATENÇÃO!" message "Verifique sua arvore na branch $(git branch)!"'

    status=$(git status | grep "nothing to commit, working tree clean")
  done

  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' ]]; then
    afplay /System/Library/Sounds/Blow.aiff
    osascript -e 'display alert "ATENÇÃO!" message "Verifique se está conectado na VPN"'
    git checkout master
    git pull
    sleep 5

    print_blue "\n-> Defina um nome para a nova branch! \nExemplo (customNovaBranch)? \n"
    read branch

    # if [[ *$(git branch)* == "$branch" ]]; then
    #   afplay /System/Library/Sounds/Blow.aiff
    #   osascript -e 'display alert "ATENÇÃO!" message "Já existe uma branch com esse mesmo nome! \n\nClique em OK para dar um checkout nela."'
    #   read resposta
    #   echo "------> $resposta"
    # fi

    git checkout -b $branch
    git checkout $branch
  else
    afplay /System/Library/Sounds/Blow.aiff
    osascript -e 'display alert "ATENÇÃO!" message "Verifique se está conectado na VPN"'
    git checkout master
    git pull
    sleep 5

    print_blue "\n>>> BRANCHS EXISTENTES <<< \n$(print_green "$(git branch)") \n\n$(print_blue "-> Escolha a branch pra dar <checkout> ...")\n"
    read branch
    git checkout $branch
  fi
}

enteringTheDatas() {
  print_light_red "\n\n\n\n\n--------------------      Entrando com os dados ...      --------------------"
  # Paths Uteis ...
  # pathScripts=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/BashScript
  # keystorePath=~/Documents/Products_Customs/Keystores/
  # pathToRoot=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls #Path de onde está o script.ssh e o bundletool
  # pathProject=~/Documents/Fulltrack/FMobile6_Android/               #$(pwd)
  # PATH_APKSIGNER=~/Library/Android/sdk/build-tools/29.0.3/apksigner

  # BUILD_APK_UNSIGNED=app-release-unsigned
  # BUILD_AAB_UNSIGNED=app-release
  # # builds=apps
  # BUILD=app-release
  # BUILDS=apps

  # FMOBILE 5.0
  pathScripts=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/BashScript
  keystorePath=~/Documents/Products_Customs/Keystores/
  # pathToRoot=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls #Path de onde está o script.ssh e o bundletool
  pathToRoot=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts
  pathProject=~/Documents/Fulltrack/FMobileRN/android               #$(pwd)
  PATH_APKSIGNER=~/Library/Android/sdk/build-tools/29.0.3/apksigner

  BUILD_APK_UNSIGNED=app-release
  BUILD_AAB_UNSIGNED=app
  # builds=apps
  BUILD=app-release
  BUILDS=apps

  print_blue "\n\n-> NOVO(n) - Novo Projeto? OU \n-> ATUALIZAÇÃO(a) - Versão nova? \nObs: Entre com 'a' para atualizar ou 'n' para criar novo projeto\n"
  read newProjectOrUpdate

  # gitCheck $newProjectOrUpdate

  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' ]]; then
    # Buscando os dados do infotxt
    cd ~/Downloads
    indice=$(awk '/Indice: /{print $0}' info.txt | awk '{sub(/Indice: /,""); print}')
    nome=$(awk '/Nome do App:/{print $0}' info.txt | awk '{sub(/Nome do App: /,""); print}')
    appName=$nome
    cor1=$(awk '/Cor1/{print $0}' info.txt | awk '{sub(/Cor1: /,""); print}')
    cor2=$(awk '/Cor2/{print $0}' info.txt | awk '{sub(/Cor2: /,""); print}')
    empresa=$(awk '/Empresa: /{print $0}' info.txt | awk '{sub(/Empresa:  /,""); print}')
    cliente=$(awk '/Cliente: /{print $0}' info.txt | awk '{sub(/Cliente: /,""); print}')
    email=$(awk '/Email: /{print $0}' info.txt | awk '{sub(/Email: /,""); print}')
    site=$(awk '/Site:/{print $0}' info.txt | awk '{sub(/Site: /,""); print}')
    telefone=$(awk '/Telefone: /{print $0}' info.txt | awk '{sub(/Telefone: /,""); print}')
    copyright=$(awk '/Copyright: /{print $0}' info.txt | awk '{sub(/Copyright: /,""); print}')
    emailAndroid=$(awk '/Email conta Android: /{print $0}' info.txt | awk '{sub(/Email conta Android: /,""); print}')
    senhaAndroid=$(awk '/Senha conta Android: /{print $0}' info.txt | awk '{sub(/Senha conta Android: /,""); print}')
    emailIOS=$(awk '/Email conta IOS: /{print $0}' info.txt | awk '{sub(/Email conta IOS: /,""); print}')
    senhaIOS=$(awk '/Senha conta IOS: /{print $0}' info.txt | awk '{sub(/Senha conta IOS: /,""); print}')
    contatoTeste=$(awk '/Contato Teste: /{print $0}' info.txt | awk '{sub(/Contato Teste: /,""); print}')

    # # alias=$("$nome" | awk '{print tolower($0)}' | awk '{sub(/ /,""); print}')
    # alias=$(echo "$nome" | awk '{print tolower($0)}' | awk '{sub(/ /,""); print}')
    # nomeDaKeystore=$alias
    # passwordDaKeystore1=$alias$indice
    # passwordDaKeystore2=$alias$indice

    echo "Nome do Alias: "
    read alias
    nomeDaKeystore=$alias

    echo "Nome do password1: "
    read passwordDaKeystore1

    echo "Nome do password2: "
    read passwordDaKeystore1

    echo "Nome do bundle: "
    read bundle
    bundleAndroid=$bundle

    # bundle="br.com.$alias"
    # bundleAndroid=$bundle

    print_light_red "\n                    >>> Observações <<< \nDados oriundos do setor COMERCIAL \nBuscando informações em ~/Downloads/info.txt ...\n"
    print_blue "\nIndice: $indice \nNome do App: $nome \nCores: \nCor1:$cor1 e Cor2:$cor2 
    \nEmpresa: $empresa \nCliente: $cliente \nEmail: $email \nSite: $site \nTelefone: $telefone \nCopyright: $copyright 
    \nEmail Android: $emailAndroid \nSenha Android: $senhaAndroid \n\nEmail IOS: $emailIOS \nSenha IOS: $senhaIOS 
    \nKEYSTORE \nAlias: $alias \nNome da KeyStore: $nomeDaKeystore \nPasswords da Keystore(1/2): $passwordDaKeystore1//$passwordDaKeystore2
    \nBUNDLE: $bundle"
    print_light_red "\n\n\n                    >>> ATENÇÃO <<< \n... Aguardando 10 segundos pra conferir os dados ...\n\n"
    sleep 10

    cd $pathProject/app
    # Pegando onde ocorre versionName; Substituindo 'versionName ' por ''; Depois substitui os " por ''; por fim tirei os espaços
    versao=$(awk '/versionName/{print}' build.gradle | awk '{sub(/versionName /,""); print}' | awk '{sub(/"/,""); print}' | awk '{sub(/"/,""); print}' | awk '{ gsub (" ", "", $0); print}')
    # Pegando somente onde ocorre o versionCode; Substituindo 'versionCode ' por ''; Pegando somente os números; Pegando somente a primeira linha do resultado total
    versionCode=$(awk '/versionCode/{print}' build.gradle | awk '{sub(/versionCode /,""); print}' | awk '{print($0+0)}' | awk 'NR==1{print $1}')
    echo -e "\n-> Versão: \n$versao \n\nversionCode: \n$versionCode"

    projeto="$indice"_"$nome"
    projeto=$(echo "$projeto" | awk '{sub(/ /,"_"); print}') #Tive que tratar esse caso do nome do projeto ter espaço (indice_nome composto), Agora será (indice_nome_composto)

    data=$(date +%F)
    hora=$(date +%T)
    data=$(date +%F\ %T)

    cd $pathToRoot

    printf "
>>> Data de Criação: $data às $hora <<<

Indice: $indice
Nome do App: $nome
Cor1: $cor1
Cor2: $cor2

Empresa: $empresa
Cliente: $cliente
Email: $email
Site: $site
Telefone: +55 $telefone
Copyright: $copyright

Email conta Android: $emailAndroid
Senha conta Android: $senhaAndroid

Email conta IOS: $emailIOS
Senha conta IOS: $senhaIOS


------------------------ DESENVOLVIMENTO ------------------------ 

Loja Android: https://play.google.com/store/apps/details?id=$bundle
Loja IOS: https://apps.apple.com/us/app/$appName/id$id#?platform=iphone

Contato Teste: $contatoTeste

AliasDaKeyStore: $alias
PasswordDaKeyStore1: $passwordDaKeystore1
PasswordDaKeyStore2: $passwordDaKeystore1
NomeDaKeyStore: $nomeDaKeystore

Bundle Android: $bundle
Bundle IOS: 

AppIDOnesignal: $appIDOnesignal

Politica: http://fulltrack-tools.ftdata.com.br/PrivacyPolicy/$indice

Versão: $versao na data $data
VersionCode: $versionCode na data $data
  " >>info.txt

    echo -e "\n\n>>>Criando documento(HTML)"
    touch info_"$projeto".html
    printf "
		<!DOCTYPE html>
		<html lang='pt-br'>

		<head>
			<meta charset='utf-8'>
			<link rel='stylesheet' href='../bootstrap/css/bootstrap.css'>
			<meta name='viewport' content='width=device-width, initial-scale=1'>
			<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'>
			<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>
			<script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'></script>

			<title>"$indice" - $nome</title>
			<h1 class='text-danger' style='text-align:center'>$nome - $indice</h1>
		</head>
		<br>
		<br>

		<body>
			<div class='container'>
				<h3>INFORMAÇÕES NECESSÁRIAS</h3>
				<div class='list-group'>
					<a class='list-group-item'>
						<!-- active'> -->
						<h4 class='list-group-item-heading'>Indice</h4>
						<p class='list-group-item-text'> $indice </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Nome do app</h4>
						<p class='list-group-item-text'> $nome </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Empresa</h4>
						<p class='list-group-item-text'> $empresa </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Cliente</h4>
						<p class='list-group-item-text'> $cliente </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Email</h4>
						<p class='list-group-item-text'> $email </p>
					</a>
					<a href='$site' target='_blank' class='list-group-item'>
						<h4 class='list-group-item-heading'>Site</h4>
						<p class='list-group-item-text'> $site </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Telefone</h4>
						<p class='list-group-item-text'> $telefone </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Copyright</h4>
						<p class='list-group-item-text'> $copyright </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Contato de teste push</h4>
						<p class='list-group-item-text'> $contatoTeste </p>
					</a>
				</div>
			</div>
			<hr>
			<div class='container'>
				<h3>LOJAS</h3>
				<div class='list-group'>
					<a href='https://play.google.com/store/apps/details?id=$bundle' target='_blank' class='list-group-item'>
						<h4 class='list-group-item-heading'>Android</h4>
						<p class='list-group-item-text'>Google Play</p>
					</a>
					<a href='https://apps.apple.com/br/app/$appName/$idAppName' target='_blank' class='list-group-item'>
						<h4 class='list-group-item-heading'>IOS</h4>
						<p class='list-group-item-text'>iTunes</p>
					</a>
				</div>
			</div>
			<hr>
			<div class='container'>
				<h3>CONTAS</h3>
				<div class='list-group'>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Android - Google Play</h4>
						<p class='list-group-item-text'><strong>Email: </strong> $emailAndroid </p>
						<p class='list-group-item-text'><strong>Senha: </strong> $senhaAndroid </p>
						<p class='list-group-item-text'><strong>Nome do device:</strong> $nomeDoDeviceAndroid </p>
						<p class='list-group-item-text'><strong>Final do número do device:</strong> $numeroDoDeviceAndroid </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>IOS - iTunes</h4>
						<p class='list-group-item-text'><strong>Email:</strong> $emailIOS </p>
						<p class='list-group-item-text'><strong>Senha:</strong> $senhaIOS </p>
						<p class='list-group-item-text'><strong>Nome do device:</strong> $nomeDoDeviceIOS </p>
						<p class='list-group-item-text'><strong>Final do número do device:</strong> $numeroDoDeviceIOS </p>
					</a>
				</div>
			</div>
			<hr>
			<div class='container'>
				<h3>INFORMAÇÕES DO PROJETO</h3>
				<div class='list-group'>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>CORES</h4>
						<p class='list-group-item-text'><strong>Cor1: </strong>#$cor1 </p>
						<p class='list-group-item-text'><strong>Cor2: </strong>#$cor2 </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Keystore</h4>
						<p class='list-group-item-text'><strong>Nome:</strong> $nomeDaKeystore </p>
						<p class='list-group-item-text'><strong>Alias:</strong> $alias </p>
						<p class='list-group-item-text'><strong>Senha1:</strong> $passwordDaKeystore1 </p>
						<p class='list-group-item-text'><strong>Senha2:</strong> $passwordDaKeystore2 </p>
					</a>
					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Bundles</h4>
						<p class='list-group-item-text'><strong>Android:</strong> $bundleAndroid </p>
						<p class='list-group-item-text'><strong>IOS:</strong> $bundleIOS </p>
					</a>
					 	<a class='list-group-item' href='http://fulltrack-tools.ftdata.com.br/PrivacyPolicy/$indice' target='_blank'>
						<h4 class='list-group-item-heading'>Politica de Privacidade</h4>
					</a>

					<a class='list-group-item'>
						<h4 class='list-group-item-heading'>Outras Informações...</h4>
						<p class='list-group-item-text'><strong>APP_ID_ONE_SIGNAL<br>(Obs: Somente no FMobile5 - React-Native):</strong> $appIDOnesignal </p><br>
						<p class='list-group-item-text'><strong>Outras:</strong><br>
								<br><p>
									 $outrasInfo
								<br></p></p>
					</a>
				</div>
			</div>
			<p class='list-group-item-text' style='text-align: right; color:black'><strong style=color:red>Ultima modificação: </strong> $data às $hora </p>

		</html>
		" >>info_"$projeto".html
    mv ./info_"$projeto".html $pathToRoot

  else
    cd ~/Documents/Products_Customs/Projetos
    print_blue "\n\n>>> PROJETOS EXISTENTES <<<\n$(print_green "$(ls)") \n\n$(print_blue "-> Indice do Projeto:")\n"
    read indice

    print_blue "\n\n-> Verificando se já existe o projeto com o indice: ($indice) ..."
    touch projetos.txt                       #Criando projetos.txt
    printf "$(ls)" >>projetos.txt            #Inserindo o conteúdo no projetos.txt
    projetos=$(awk '//{print}' projetos.txt) #Buscando todo o conteúdo do projetos.txt
    resultadoDaBuscaDoProjeto=$(grep "$indice" projetos.txt)
    projeto=$resultadoDaBuscaDoProjeto
    rm projetos.txt

    if [[ $projeto != '' ]]; then
      print_light_red "\n\n\n>>> PORJETO EXISTE <<<"
      echo -e "\nCom o indice ($indice) temos o projeto "$projeto" \nBuscando informações do projeto: "$projeto" ...\n"

      cd $pathProject/app
      versao=$(awk '/versionName/{print}' build.gradle | awk '{sub(/versionName /,""); print}' | awk '{sub(/"/,""); print}' | awk '{sub(/"/,""); print}' | awk '{ gsub (" ", "", $0); print}')
      versionCode=$(awk '/versionCode/{print}' build.gradle | awk '{sub(/versionCode /,""); print}' | awk '{print($0+0)}' | awk 'NR==1{print $1}')

      cd ~/Documents/Products_Customs/Projetos/"$projeto"/
      nome=$(awk '/Nome do App:/{print $0}' info.txt | awk '{sub(/Nome do App: /,""); print}')
      alias=$(awk '/AliasDaKeyStore/{print $0}' info.txt | awk '{sub(/AliasDaKeyStore: /,""); print}')
      nomeDaKeystore=$(awk '/NomeDaKeyStore/{print $0}' info.txt | awk '{sub(/NomeDaKeyStore: /,""); print}')
      passwordDaKeystore1=$(awk '/PasswordDaKeyStore1/{print $0}' info.txt | awk '{sub(/PasswordDaKeyStore1: /,""); print}')
      passwordDaKeystore2=$(awk '/PasswordDaKeyStore2/{print $0}' info.txt | awk '{sub(/PasswordDaKeyStore2: /,""); print}')
      bundle=$(awk '/Bundle Android/{print $0}' info.txt | awk '{sub(/Bundle Android: /,""); print}')
      bundleAndroid=$bundle
      # Contato Teste: 18118218318
      contatoTeste=$(awk '/Contato Teste:/{print $0}' info.txt | awk '{sub(/Contato Teste: /,""); print}')
      cor1=$(awk '/Cor1/{print $0}' info.txt | awk '{sub(/Cor1: /,""); print}')
    else
      afplay /System/Library/Sounds/Blow.aiff
      osascript -e 'display alert "ATENÇÃO!" message ">>>PORJETO NÃO EXISTE<<< \nClique no OK para matar a aplicação..."'

      print_light_red "\n\n>>>PORJETO NÃO EXISTE<<< \nProjeto com o indice: ($indice) NÃO EXISTE! \nTENTE DE NOVO... \n\nMatando aplicação ...\n\n"
      # pid=$(ps -ef | grep utilitarioGeradorBuilds_Android_2.sh)
      pid=$(ps -ef | grep automacaoCustomAndroid.sh)
      echo -e ">>> $pid"
      kill -9 $pid
    fi
  fi

  # projeto="$indice"_"$nome"
  print_light_red "\n\n-> Seu projeto estará em:\n"
  echo -e "~/Documents/Products_Customs/Projetos/"$projeto" "

  print_blue "\n\n-> INDICE: $indice\n"
  print_blue "-> Nome do App: $nome\n"
  print_blue "-> Versão: $versao - versionCode: $versionCode\n"
  print_blue "-> Alias (keystore): $alias\n"
  print_blue "-> Keystore - Nome: $nomeDaKeystore\n"
  print_blue "-> Keystore - Password1: $passwordDaKeystore1\n"
  print_blue "-> keystore - Password2: $passwordDaKeystore2\n"
  print_blue "-> Bundle Android: $bundleAndroid\n"
  print_blue "-> Contato teste: $contatoTeste\n"
  print_blue "-> Cor: $cor1\n"

  print_light_red "\n\n                    >>> ATENÇÃO <<< \n... Aguardando 10 segundos pra conferir os dados ..."
  sleep 10
}
enteringTheDatas

ifNewGetDatasAndMakeCustom() {
  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' ]]; then
    print_red "\n\n\n----------------------------      Custom NOVA      ---------------------------- 
    \n--------------------      Buscando arquivos da net ...      --------------------\n\n"
    afplay /System/Library/Sounds/Blow.aiff
    osascript -e 'display alert "ATENÇÃO!" message "Va no FIrebase e crie o .google-service baixe e adicione-o no projeto"'

    afplay /System/Library/Sounds/Blow.aiff
    osascript -e 'display alert "ATENÇÃO!" message "Clique em http://fulltrack-tools.ftdata.com.br/CustomizacaoMobile para cadastrar a custom" '
    # python $pathScripts/Python/gettingResourcesToAutomationcCustomFMobile.py

    print_light_red "\n\n\n--------------------------      Customizando ...      --------------------------"
    sh $pathScripts/makeCustom.sh "$nome" "$bundle" "$cor1" "$alias" "$passwordDaKeystore1" "$passwordDaKeystore2" "$nomeDaKeystore"
    # makeCustom.sh teste br.com.teste teste teste123 teste123 testekeystore
  fi
}
ifNewGetDatasAndMakeCustom

lookingDevicesAndIPAdress() {
  print_light_red "\n\n\n\n-----------------------      Looking Devices ...      ------------------------\n"

  if [[ $(adb devices | awk 'NR==3{print $1}') == '' && $(adb devices | awk 'NR==2{print $1}') == '' ]]; then
    $pathScripts/connectDeviceFromIPAdress.sh 'n'
  else
    if [[ $(adb devices | awk 'NR==3{print $1}') != '' ]]; then
      device=$(adb devices | awk 'NR==3{print $1}')
    else
      device=$(adb devices | awk 'NR==2{print $1}')
    fi
  fi

  print_green "\n\nDevice conectado!!!\nDevice: $device\n\n"
}
lookingDevicesAndIPAdress

# print_red "\n\nABRINDO O ANDROID STUDIO"
# open -a Android\ Studio $pathProject # open -a Android\ Studio "Your Project Path"
# sleep 180

builddingApkAndAAB() {
  print_red "\n\n\nDOCUMENTAÇÕES: "
  print_green "
  \nCriar seu app na linha de comando:
  \n- https://developer.android.com/studio/build/building-cmdline#DebugMode
  \n- https://blog.usejournal.com/how-to-quickly-build-and-run-android-apks-using-an-automated-script-eb0e4a997d68
  \n- ...
  \n\nBundletoll:
  \n- https://developer.android.com/studio/command-line/bundletool
  \n\nZipalign: 
  \n- https://android-developers.googleblog.com/2009/09/zipalign-easy-optimization.html?m=1
  \n- https://developer.android.com/studio/command-line/zipalign
  \n\nApksigner: 
  \n- https://developer.android.com/studio/command-line/apksigner
  \n\nGradle:
  \n- https://docs.gradle.org/current/userguide/userguide.html\n"
  sleep 5

  print_light_red "\n\n\n------------------------     Iniciando o BUILD ...      ------------------------ \n\n"
  sleep 2

  cd $pathProject/
  cp $keystorePath/$nomeDaKeystore.keystore $pathToRoot/

  afplay /System/Library/Sounds/Blow.aiff
  # osascript -e 'display alert "ATENÇÃO!" message "ATUALIZOU O PROJETO?"'
  # osascript -e 'display alert "ATENÇÃO!" message "ATUALIZOU O PROJETO?"'

  print_light_red "Atualizou o projeto com o plugin GRADLE para a versão 7.0.0 (y/n)? "
  read atualizouGRADLE
  while [[ $atualizouGRADLE != 'y' ]]; do
    afplay /System/Library/Sounds/Blow.aiff
    osascript -e 'display alert "ATENÇÃO!" message "Atualize seu projeto com o plugin GRADLE para versão 7.0.0"'
    atualizouGRADLE='y'
  done
  print_green "Project build files are up-to-date for Android Gradle Plugin version 7.0.0"

  print_light_red "\n\n\nPara ver uma lista de todas as tarefas de compilação disponíveis para seu projeto, execute ./gradlew tasks "
  print_green "$(./gradlew tasks)\n\n"
  sleep 3

  print_blue "\n\n-> Rodando ./gradlew clean \nRemove ./build\n\n"
  ./gradlew clean

  # print_blue "\n\n-> Rodando ./gradlew cleanBuildCache ... \n\n"
  # ./gradlew cleanBuildCache

  print_blue "\n\n-> Rodando ./gradlew cleanBuild \nRemove ./app/build\n\n"
  ./gradlew cleanBuild

  # print_blue "\n\n-> Rodando ./gradlew build"
  # ./gradlew build

  # ---------------------------------------------------------------------------------------------------------
  # Gera app-release-unsigned.apk em ./app/build/outputs/apk/release/app-release-unsigned.apk
  print_blue "\n\n-> GERANDO .apk \nBuild estará em: ./app/build/outputs/apk/release/$BUILD_APK_UNSIGNED.apk\n"
  rm ./app/build/outputs/apk/release/$BUILD_APK_UNSIGNED.apk
  ./gradlew assembleRelease

  print_blue "\n\n-> Assinando e Optimizando o .apk ($BUILD_APK_UNSIGNED.apk) \nApós assinado estára em: ./app/build/outputs/apk/release/$BUILD.apk\n\n"
  mv $pathProject/app/build/outputs/apk/release/$BUILD_APK_UNSIGNED.apk ~/Library/Android/sdk/build-tools/29.0.3/app-release-unsigned.apk
  cp $keystorePath/$nomeDaKeystore.keystore ~/Library/Android/sdk/build-tools/29.0.3/
  cd ~/Library/Android/sdk/build-tools/29.0.3/

  print_blue "\n\n-> Otimizando o .apk com o zipalign\n"
  ./zipalign -v -p 4 ./app-release-unsigned.apk $BUILD.apk

  # afplay /System/Library/Sounds/Blow.aiff
  # print_light_red "\n\n\nVERIFIQUE"
  # read verificou

  ./apksigner sign --ks $nomeDaKeystore.keystore --ks-key-alias $alias --ks-pass pass:$passwordDaKeystore1 --key-pass pass:$passwordDaKeystore2 $BUILD.apk
  rm ./app-release-unsigned.apk

  print_red "\n\nVerificando se o APK foi assinado ...\n\n"
  ./apksigner verify ./$BUILD.apk
  # mv ./app-release-unsigned.apk ./$BUILD.apk
  mv ./$BUILD.apk $pathProject/app/build/outputs/apk/release/
  rm ./$nomeDaKeystore.keystore
  # ~/Library/Android/sdk/build-tools/29.0.3/apksigner sign --ks ~/Documents/Products_Customs/Keystores//invictuscontrol.keystore --ks-key-alias invictus --ks-pass pass:invictuscontrol5977 --key-pass pass:invictuscontrol5977 ./app-release.apk

  cd $pathProject/app/build/outputs/apk/release/
  print_blue "\n\n-> Movendo de: \n$pathProject/app/build/outputs/apk/release/$BUILD.apk para: \n$pathToRoot\n"
  mv ./$BUILD.apk $pathToRoot # Movendo o APK para o path do Scripts/AABTolls

  cd $pathProject/app/build/outputs/apk/debug
  print_blue "\n\n-> Movendo de: \n$pathProject/app/build/outputs/apk/debug/app-debug.apk para: \n$pathToRoot\n"
  mv ./app-debug.apk $pathToRoot

  # ---------------------------------------------------------------------------------------------------------
  cd $pathProject
  print_blue "\n\n-> GERANDO .aab \nBuild estará em: ./app/build/outputs/bundle/release/$BUILD_AAB_UNSIGNED.aab\n"
  ./gradlew bundleRelease

  print_blue "\n\n-> Movendo de: \n$pathProject/app/build/outputs/bundle/release/$BUILD.aab para: \n$pathToRoot\n"
  mv $pathProject/app/build/outputs/bundle/release/$BUILD_AAB_UNSIGNED.aab $pathToRoot

  cd $pathToRoot
  print_blue "\n\n-> Assinando o .aab ($BUILD_AAB_UNSIGNED.aab) \nApós assinado estára em: $pathToRoot/$BUILD.aab\n\n"
  # java -jar bundletool-all-1.7.0.jar build-apks --bundle=$BUILD_AAB_UNSIGNED.aab --output=$BUILDS.apks --ks=$keystorePath/$nomeDaKeystore.keystore --ks-pass=pass:$passwordDaKeystore1 --ks-key-alias=$alias --key-pass=pass:$passwordDaKeystore2
  # java -jar bundletool-all-1.7.0.jar build-apks --bundle=$BUILD_AAB_UNSIGNED.aab --output=$BUILDS.apks --ks=$nomeDaKeystore.keystore --ks-pass=pass:$passwordDaKeystore1 --ks-key-alias=$alias --key-pass=pass:$passwordDaKeystore2
  
  java -jar bundletool-all-1.7.0.jar build-apks --bundle=$BUILD_AAB_UNSIGNED.aab --output=$BUILDS.apks --ks=$nomeDaKeystore.keystore --ks-pass=pass:$passwordDaKeystore1 --ks-key-alias=$alias --key-pass=pass:$passwordDaKeystore2
  # jarsigner -keystore $keystorePath/$nomeDaKeystore.keystore -storepass $passwordDaKeystore1 -keypass $passwordDaKeystore2 $BUILD.aab $alias

  mv ./$BUILD_AAB_UNSIGNED.aab ./$BUILD.aab
}
builddingApkAndAAB

installAppInDevice() {
  print_blue "\n\n-> Desinstalando app($BUILD.apk) do device($device).... \n"
  adb -s $device uninstall $bundle

  print_blue "\n\n-> Desbloqueando Celular...\n"
  sh $pathScripts/unlockDevice.sh 'instalar aplicativo'

  # print_blue "\n\n-> Instalando o .apk assinado no device: \n$device \n\nEm: $(pwd) Temos: \n$(ls) \n\n\n"
  print_blue "\n\n-> Instalando o .apk assinado no device: \n$device\n\n\n"
  java -jar bundletool.jar install-apks --apks=$BUILDS.apks --device-id=$device
  print_light_green "\n\n\n$nome.apk instalado no device: $device\n"

  # print_blue "\n\n-> Instalando o .apk assinado no device: \n$device\n\n\n"
  # adb -s $device install $BUILD.apk
  # print_light_green "\n\n\n$nome.apk instalado no device: $device\n"
}
installAppInDevice

movingProject() {
  cd $pathToRoot
  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' ]]; then
    print_light_red "\n\n\n------------------------       PROJETO NOVO!!!       -------------------------"
    echo -e "\nCriando pasta do projeto e movendo os arquivos(.aab/.apk/.keystore/.txt(com as info))...\n\n"

    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/KEYSTORE
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/OUTROS
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/BUILDS
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/BUILDS/Android
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/BUILDS/IOS
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/ImagensDoProjeto
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/Android
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/IOS
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/IOS/iPhone_5.5
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/IOS/iPhone_6.5
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/IOS/iPad_12.9

    echo -e "\n\n>>> MOVENDO... \nEm: $(pwd)\n"
    mv ~/Documents/Products_Customs/Imagens/* ~/Documents/Products_Customs/Projetos/"$projeto"/"IMAGENS"/"ImagensDoProjeto"
    mv ./google-services.json ~/Documents/Products_Customs/Projetos/"$projeto"/
    printf "\n\n\n$projeto \n- Versão: $versao \n- versionCode: $versionCode \n- Data: $data" >>~/Documents/Products_Customs/Projetos/customs_fmobile_6.0.txt

    mv ./$nomeDaKeystore.keystore ~/Documents/Products_Customs/Projetos/"$projeto"/"KEYSTORE"
    mv ./info.txt ~/Documents/Products_Customs/Projetos/"$projeto"
    mv ./info_"$projeto".html ~/Documents/Products_Customs/Projetos/"$projeto"

    mv ./$BUILD.aab ~/Documents/Products_Customs/Projetos/"$projeto"/"BUILDS"/Android/"$nome"_"$versionCode".aab
    mv ./$BUILD.apk ~/Documents/Products_Customs/Projetos/"$projeto"/"BUILDS"/Android/"$nome"_"$versionCode".apk
    mv ./app-debug.apk ~/Documents/Products_Customs/Projetos/"$projeto"/"BUILDS"/Android/
    rm $BUILDS.apks #arquivo pesado, necessário somente na hora de instalar ...
  else
    print_light_red "\n\n\n---------      Movendo apenas os BUILDS(.apk(release/debug), .aab)      ---------\n\n"
    sleep 5
    mv ./$BUILD.aab ~/Documents/Products_Customs/Projetos/"$projeto"/"BUILDS"/Android/"$nome"_"$versionCode".aab
    mv ./$BUILD.apk ~/Documents/Products_Customs/Projetos/"$projeto"/"BUILDS"/Android/"$nome"_"$versionCode".apk
    mv ./app-debug.apk ~/Documents/Products_Customs/Projetos/"$projeto"/"BUILDS"/Android/
    rm $nomeDaKeystore.keystore
    rm $BUILDS.apks #arquivo pesado, necessário somente na hora de instalar ...
  fi
}
movingProject

takingPrints() {
  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' ]]; then
    print_light_red "\n\n\n------------------------      Tirando Prints ...      ------------------------"
    # sh $pathScripts/takePrintsFromAndroid.sh $indice $versionFmobile
    sh $pathScripts/takePrintsFromAndroid.sh $indice '6' $device
  else
    afplay /System/Library/Sounds/Blow.aiff
    osascript -e 'display alert "ATENÇÃO!" message "Responda no terminal se quer tirar novos prints ..."'

    print_blue "\n-> Quer tirar os prints novamente? (y/n)\n"
    read takePrintsFromAndroid

    if [[ $takePrintsFromAndroid == 'y' ]]; then
      print_light_red "\n\n\n--------------------      Tirando Prints NOVAMENTE ...      --------------------"
      # sh $pathScripts/takePrintsFromAndroid.sh $indice $versionFmobile
      sh $pathScripts/takePrintsFromAndroid.sh $indice '6' $device
    fi
  fi
}
# takingPrints

settingUpFences() {
  print_light_red "\n\n\n---------------      Configurando Cercas pra testar os PUSH ...      ---------------"
  afplay /System/Library/Sounds/Blow.aiff
  osascript -e 'display alert "ATENÇÃO!" message "Responda no terminal se quer configurar o teste de push ..."'

  # DEPOIS QUE AVISAR, DEIRECIONAR A TELA PRO TERMINAL EM QUESTÃO ...

  print_blue "\n-> Quer fazer os test de push? (y/n)\n"
  read testPush

  if [[ $testPush == 'y' ]]; then
    echo -e "\n\n\n-> Configurando os testes de push ..."
    sh $pathScripts/settingUpForPushTest.sh $indice $contatoTeste
  fi
}
# settingUpFences

uploadProjectToSeverFileSystem() {
  afplay /System/Library/Sounds/Blow.aiff
  osascript -e 'display alert "ATENÇÃO!" message "SUBINDO OS ARQUIVOS PRO SERVIDOR ....."'

  # To Know more: https://learn.akamai.com/en-us/webhelp/netstorage/netstorage-user-guide/GUID-F9717DFA-6391-409B-8C47-8B0F9520854E.html
  # print_light_red "\n\n\n--------------      Subindo Projeto "$nome"_"$versao" pro FileSystem ...      --------------"
  print_light_red "\n\n\n--------------      Subindo Projeto "$projeto" pro FileSystem ...      --------------"
  print_blue "\n\n-> Abrindo o local onde ficam as custom no servidor (FileSystem) ..."
  open smb://192.168.1.14/mobile/FMobile/FMobile_6/Customs

  # pathToBuildsAndroid=~/Documents/Products_Customs/Projetos/"$projeto"/BUILDS/Android # Path Correto: /Users/macbook-estagio/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls/Projetos/5977_Invictus\ Control/BUILDS/Android
  # print_red "\n\n\npathToBuildsAndroid (ERRADO): $pathToBuildsAndroid"
  # pathToBuildsAndroid=$(echo "$pathToBuildsAndroid" | awk '{sub(/ /,"\\ "); print}') # Aqui estou inserindo a barra invertida(\) pra aceitar o espaço e pegar o path corretamente
  # print_blue "\npathToBuildsAndroid (CORRETO): $pathToBuildsAndroid"
  # echo -e "/Users/macbook-estagio/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls/Projetos/5977_Invictus Control/BUILDS/Android" | awk '{sub(/ /,"\\ "); print}'

  pathToBuildsAndroid=~/Documents/Products_Customs/Projetos/"$projeto"/BUILDS/Android

  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' ]]; then
    print_blue "\n\n-> Subindo o projeto TODO!"
    echo -e "\n-> SENHA para acessar o servidor: $(print_green "yTYa@V@QJrtP")\n"
    scp -r ~/Documents/Products_Customs/Projetos/"$projeto"/ matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs
  else
    print_blue "\n\n-> Subindo apenas os BUILDS"
    echo -e "\n-> SENHA para acessar o servidor: $(print_green "yTYa@V@QJrtP")\n"

    # scp /Users/macbook-estagio/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls/Projetos/5977_Invictus\ Control/BUILDS/Android/app-release.aab matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs/5977_Invictus_Control/BUILDS/Android/
    print_red "\n\n\nCOMANDO SCP: scp $pathToBuildsAndroid/$BUILD.aab matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs/"$projeto"/BUILDS/Android/ \n\n\n"
    scp $pathToBuildsAndroid/"$nome"_"$versionCode".aab matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs/"$projeto"/BUILDS/Android/
    scp $pathToBuildsAndroid/"$nome"_"$versionCode".apk matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs/"$projeto"/BUILDS/Android/
    scp $pathToBuildsAndroid/app-debug.apk matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs/"$projeto"/BUILDS/Android/
  fi

  print_light_red "\n\nQUER REMOVER OS BUILDS???(y/n) "
  read remove

  if [[ $remove == 'y' ]]; then
    print_blue "-> Removendo os builds(.aab e .apk) ...\n\n\n"
    rm -rf $pathToBuildsAndroid/"$nome"_"$versionCode".aab
    rm -rf $pathToBuildsAndroid/"$nome"_"$versionCode".apk
    rm -rf $pathToBuildsAndroid/app-debug.apk
  else
    print_blue "-> Não foram removidos os builds(.aab e .apk) ...\n\n\n"
  fi
}
uploadProjectToSeverFileSystem

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><> IOS <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
# echo -e "\n\n<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><> IOS <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>\n\n"
# # bundle="br.com.invictuscontrol" # bundle=$bundle
# # scheme="FMobile" # scheme=$nome
# # project="8030_Sekron SAT" # project=$projeto
# # ------------------------------------------------
# bundle="br.com.mytracker" # bundle=$bundle
# scheme="My Tracker" # scheme=$nome
# project="900000_My Tracker" # project=$projeto
# # cd ~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls/Projetos
# # ls
# # echo -e "Which project: "
# # read project
# pathBuildsProjectIOS=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls/Projetos/$project/BUILDS/IOS
# pathPrintsProjectIOS=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/AABTolls/Projetos/$project/IMAGENS/prints/IOS
# pathScripts=~/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/BashScript

# sh $pathScripts/takePrintsFromIOS.sh "$pathBuildsProjectIOS" "$pathPrintsProjectIOS" $bundle $scheme
