# !/bin/bash -i

# {$print_red "DEU CERTO POHA"}
# $({$print_green "DEU CERTO POHA"})
# sleep 54

source ~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/Python/venvAutomation/bin/activate

# Customs do FMobile 5.0
# automationCustomFMobile6ANDROID.sh "velha" "alias" "nomeDaKeystore" "senha1" "senha2" "bundleAndroid" "bundleIOS"
# automationCustomFMobile6ANDROID.sh "velha" "invictuscontrol" "invictuscontrol" "invictuscontrol5977" "invictuscontrol5977" "br.com.invictuscontrol" "br.com.invictuscontrol"
# automationCustomFMobile6ANDROID.sh "velha" "lacerdarastreamento" "lacerdarastreamento" "lacerdarastreamento10478" "lacerdarastreamento10478" "br.com.lacerdarastreamento" "br.com.lacerdarastreamento"

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

customJaExistia=$1
alias=$2
nomeDaKeystore=$3
passwordDaKeystore1=$4
passwordDaKeystore2=$5

bundle=$6
bundleIOS=$7

# echo -e "\n\nEscolha o projeto $(pwd)"
# read projeto
# pathPorjeto="~/Documents/Products_Customs/Projetos/$projeto/BUILDS/"

# if [[ .gitignore == *$pathPorjeto* ]]; then
#   echo "EXISTE"
# else
#   printf "\n~/Documents/Products_Customs/Projetos/$projeto/BUILDS/" >>../../.gitignore
# fi
# sleep 20

enteringTheDatas() {
  print_light_red "\n\n\n\n\n--------------------      Entrando com os dados ...      --------------------"
  # Paths Uteis ...
  pathScripts=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/BashScript
  keystorePath=~/Documents/Products_Customs/Keystores/
  pathToRoot=~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/ #Path de onde está o script.ssh e o bundletool
  pathProject=~/Documents/Fulltrack/FMobile6_Android/                                        #$(pwd)
  PATH_APKSIGNER=~/Library/Android/sdk/build-tools/29.0.3/apksigner

  BUILD_APK_UNSIGNED=app-release-unsigned
  BUILD_AAB_UNSIGNED=app-release
  BUILD=app-release
  BUILDS=apps

  print_blue "\n\n-> PROJETO NOVO OU ATUALIZAÇÃO? (N/A)\n"
  read newProjectOrUpdate
  # sh $pathScripts/gitCheck.sh $newProjectOrUpdate $pathProject $bundle

  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' || $newProjectOrUpdate == 'N' ]]; then
    # CHAMAR SCRIPT(Python) PARA VERIFICAR SE ESTÁ COM TODOS OS DADOS/ARQUIVOS EM ~/Download

    # Buscando os dados do info.txt
    cd ~/Downloads
    indice=$(awk '/Indice: /{print $0}' info.txt | awk '{sub(/Indice: /,""); print}')
    nome=$(awk '/Nome do App:/{print $0}' info.txt | awk '{sub(/Nome do App: /,""); print}')
    appName=$nome
    cor1=$(awk '/Cor1/{print $0}' info.txt | awk '{sub(/Cor1: /,""); print}')
    empresa=$(awk '/Empresa: /{print $0}' info.txt | awk '{sub(/Empresa: /,""); print}')
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

    if [[ $customJaExistia == 'velha' ]]; then
      print_light_red "\n\nDados da Keystore e Bundles do projeto antigo: "
      echo -e "\n-$alias \n-$nomeDaKeystore \n-$passwordDaKeystore1 \n-$passwordDaKeystore2 \n-$bundle \n-$bundleIOS"
      sleep 10
    else

      for i in $(echo "$nome" | awk '{print tolower()}' | awk '{ gsub(/ó/,"o"); print }'); do
        alias+=$i
      done

      nomeDaKeystore=$alias
      passwordDaKeystore1=$alias$indice
      passwordDaKeystore2=$alias$indice

      bundle="br.com.$alias"
      bundleAndroid=$bundle
    fi

    print_light_red "\n                    >>> Observações <<< \nDados oriundos do setor COMERCIAL \nBuscando informações em ~/Downloads/info.txt ...\n"
    print_blue "\nIndice: $indice \nNome do App: $nome \nCores: \nCor1:$cor1
    \nEmpresa: $empresa \nCliente: $cliente \nEmail: $email \nSite: $site \nTelefone: $telefone \nCopyright: $copyright 
    \nEmail Android: $emailAndroid \nSenha Android: $senhaAndroid \n\nEmail IOS: $emailIOS \nSenha IOS: $senhaIOS 
    \nKEYSTORE \nAlias: $alias \nNome da KeyStore: $nomeDaKeystore \nPasswords da Keystore(1/2): $passwordDaKeystore1//$passwordDaKeystore2
    \nBUNDLE: $bundle"
    print_light_red "\n\n\n                    >>> ATENÇÃO <<< \nConferira os dados... \nDê return(enter) pra continuar!\n\n"
    read conferido

    cd $pathProject/app
    versao=$(awk '/versionName/{print}' build.gradle | awk '{sub(/versionName /,""); print}' | awk '{sub(/"/,""); print}' | awk '{sub(/"/,""); print}' | awk '{ gsub (" ", "", $0); print}')
    versionCode=$(awk '/versionCode/{print}' build.gradle | awk '{sub(/versionCode /,""); print}' | awk '{print($0+0)}' | awk 'NR==1{print $1}')
    echo -e "\n-> Versão: \n$versao \n\nversionCode: \n$versionCode"

    projeto="$indice"_"$nome"
    projeto=$(echo "$projeto" | awk '{ gsub(/ /,"_"); print }') #Tive que tratar esse caso do nome do projeto ter espaço (indice_nome composto), Agora será (indice_nome_composto)

    data=$(date +%F)
    hora=$(date +%T)
    data=$(date +%F\ %T)

    cd $pathToRoot

    # Garantindo que o info.txt estará vazio
    rm $pathToRoot/info.txt
    rm $pathToRoot/info_"$projeto".html

    APP_NAME_STORE=$(echo "$nome" | awk '{ gsub(/ /,"-"); print }')
    print_red "Você sabe o APP_STORE_CONNECT_APPLE_ID do Aplicativo?\n"
    print_green "Se o app for novo, crie o app na App Store depois irá acha-lo em: Estará em: App Store Connect > Apps > App > Info > ID Apple\n"
    read APP_STORE_CONNECT_APPLE_ID
    # APP_STORE_CONNECT_APPLE_ID="1523701269" # App Store Connect > Apps > App > Info > ID Apple

    printf "
>>> Data de Criação: $data às $hora <<<

Indice: $indice
Nome do App: $nome
Cor1: $cor1

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
Loja IOS: https://apps.apple.com/br/app/$APP_NAME_STORE/id$APP_STORE_CONNECT_APPLE_ID#?platform=iphone

Contato Teste: $contatoTeste

AliasDaKeyStore: $alias
PasswordDaKeyStore1: $passwordDaKeystore1
PasswordDaKeyStore2: $passwordDaKeystore2
NomeDaKeyStore: $nomeDaKeystore

Bundle Android: $bundle
Bundle IOS: $bundleIOS

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
					<a href='https://apps.apple.com/us/app/$APP_NAME_STORE/id$APP_STORE_CONNECT_APPLE_ID#?platform=iphone' target='_blank' class='list-group-item'>
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
						<p class='list-group-item-text'><strong>Cor: </strong>#$cor1 </p>
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

nomeDoApp=$(echo "$nome" | awk '{ gsub(/ /,""); print }')
branch=$(echo "custom $nomeDoApp" | awk '{ gsub(/ /,""); print }')
echo -e "\n\nChamando gitCheck.sh com a branch: $(print_light_red "$branch")"
sleep 3

sh $pathScripts/Utils/gitCheck.sh $newProjectOrUpdate $pathProject $bundle $branch 'Android'

# SE O PROJETO FOR DO 0, OU SEJA, NOVO, CHAMA-SE OS SCRIPTS EM PYTHON PARA PEGAR NO CASO AS IMAGENS E OS .JSON
if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' || $newProjectOrUpdate == 'N' ]]; then
  # CRIANDO OS ARQUIVOS JSON
  afplay /System/Library/Sounds/Blow.aiff
  osascript -e 'display alert "ATENÇÃO!" message "Gerou os .json?" '
  # sh $pathScripts/callScriptsPython.sh 'gerar jsons' $email

  # CADASTRANDO A CUSTOM
  afplay /System/Library/Sounds/Blow.aiff
  osascript -e 'display alert "ATENÇÃO!" message "Clique em http://fulltrack-tools.ftdata.com.br/CustomizacaoMobile para cadastrar a custom" '

  # GERANDO OS ICONES
  # python $pathScripts/Python/generatorIcons.py $nome # Chamando direto pelo Python
  sh $pathScripts/Automacao\ Android/callScriptsPython.sh 'gerar icons' "$nome"

  # CUSTOMIZANDO
  print_light_red "\n\n\n--------------------------      Customizando ...      --------------------------"
  sh $pathScripts/Automacao\ Android/makeCustom.sh "$nome" "$bundle" "$cor1" "$alias" "$passwordDaKeystore1" "$passwordDaKeystore2" "$nomeDaKeystore"
fi

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

# MOSTRAR RELÁTÓRIO FINAL COM TODOS OS DADOS NECESSÁRIOS PARA INICIAR O BUILD

# CRIAR PROJETO(DIRETÓRIO) E MOVENDO OS DADOS QUE ATÉ ENTÃO JÁ TEMOS ...
CreateDirectoryToNewProject() {
  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' || $newProjectOrUpdate == 'N' ]]; then
    cd $pathToRoot
    print_light_red "\n\n\n------------------------       PROJETO NOVO!!!       -------------------------"
    echo -e "\nCriando pasta do projeto e movendo os arquivos(keystore, info.txt, info_Projeto.html, imagens ...\n\n"

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
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/Android/Loja
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/IOS
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/IOS/iPhone_5.5
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/IOS/iPhone_6.5
    mkdir ~/Documents/Products_Customs/Projetos/"$projeto"/IMAGENS/prints/IOS/iPad_12.9

    echo -e "\n\n>>> MOVENDO... \nEm: $(pwd)\n"
    mv ~/Documents/Products_Customs/Imagens/* ~/Documents/Products_Customs/Projetos/"$projeto"/"IMAGENS"/"ImagensDoProjeto"
    # mv ./google-services.json ~/Documents/Products_Customs/Projetos/"$projeto"/
    cp ~/Downloads/google-services.json ~/Documents/Products_Customs/Projetos/"$projeto"/

    print_green "\nInserindo nova custom 6.0\n"
    printf "\n\n\n$projeto \n- Versão: $versao \n- versionCode: $versionCode \n- Data: $data" >>~/Documents/Products_Customs/Projetos/customs_fmobile_6.0.txt

    cp $keystorePath/$nomeDaKeystore.keystore ~/Documents/Products_Customs/Projetos/"$projeto"/"KEYSTORE"
    mv $pathToRoot/info.txt ~/Documents/Products_Customs/Projetos/"$projeto"
    mv $pathToRoot/info_"$projeto".html ~/Documents/Products_Customs/Projetos/"$projeto"

    printf "\n~/Documents/Products_Customs/Projetos/$projeto/BUILDS/" >>../../.gitignore
  fi
}
CreateDirectoryToNewProject

# addingToGitignore() {
#   print_light_red "\n\n\nAdicionando no .gitignore os BUILDS do projeto ...\n"
#   $(git rm --cache -r ~/Documents/Products_Customs/Projetos/$projeto/BUILDS/)
#   sleep 2
#   printf "\n~/Documents/Products_Customs/Projetos/$projeto/BUILDS/" >> .gitignore
#   $(git status -s)
#   sleep 10
# }
# addingToGitignore

# CHAMANDO O SCRIPT PRA BUILDAR, INSTALAR E MOVER PRO SEU RESPECTIVO DIRETÓRIO
buildName=$(echo "$nome" | awk '{ gsub(" ", "_"); print }')
sh $pathScripts/Automacao\ Android/buildInstallMovingAPKAAB.sh $pathProject $nomeDaKeystore $alias $passwordDaKeystore1 $passwordDaKeystore2 $projeto $buildName $versionCode 'automatico'

takingPrints() {
  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' ]]; then
    print_light_red "\n\n\n------------------------      Tirando Prints ...      ------------------------"
    sh $pathScripts/Automacao\ Android/takePrintsFromAndroid.sh $indice '6' $device $contatoTeste
  else
    afplay /System/Library/Sounds/Blow.aiff
    osascript -e 'display alert "ATENÇÃO!" message "Responda no terminal se quer tirar novos prints ..."'

    print_blue "\n-> Quer tirar os prints novamente? (y/n)\n"
    read takePrintsFromAndroid

    if [[ $takePrintsFromAndroid == 'y' ]]; then
      print_light_red "\n\n\n--------------------      Tirando Prints NOVAMENTE ...      --------------------"
      sh $pathScripts/Automacao\ Android/takePrintsFromAndroid.sh $indice '6' $device $contatoTeste
    fi
  fi
}
takingPrints

settingUpFences() {
  print_light_red "\n\n\n---------------      Configurando Cercas pra testar os PUSH ...      ---------------\n"
  afplay /System/Library/Sounds/Blow.aiff
  osascript -e 'display alert "ATENÇÃO!" message "Responda no terminal se quer configurar o teste de push ..."'

  # DEPOIS QUE AVISAR, DEIRECIONAR A TELA PRO TERMINAL EM QUESTÃO ...

  print_blue "\n-> Quer fazer os test de push? (y/n)\n"
  read testPush

  if [[ $testPush == 'y' ]]; then
    echo -e "\n\n\n-> Configurando os testes de push ..."
    sh $pathScripts/Automacao\ Android/settingUpForPushTest.sh $indice $contatoTeste
  fi
}
settingUpFences

uploadProjectToSeverFileSystem() {
  afplay /System/Library/Sounds/Blow.aiff
  osascript -e 'display alert "ATENÇÃO!" message "SUBINDO OS ARQUIVOS PRO SERVIDOR ....."'

  # To Know more: https://learn.akamai.com/en-us/webhelp/netstorage/netstorage-user-guide/GUID-F9717DFA-6391-409B-8C47-8B0F9520854E.html
  print_light_red "\n\n\n--------------      Subindo Projeto "$projeto" pro FileSystem ...      --------------"
  open smb://192.168.1.14/mobile/FMobile/FMobile_6/Customs

  if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' ]]; then
    print_blue "\n\n-> Subindo o projeto TODO!"
    echo -e "\n-> SENHA para acessar o servidor: $(print_green "yTYa@V@QJrtP")\n"
    scp -r ~/Documents/Products_Customs/Projetos/"$projeto"/ matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs
  else
    print_blue "\n\n-> Subindo apenas os BUILDS"
    echo -e "\n-> SENHA para acessar o servidor: $(print_green "yTYa@V@QJrtP")\n"

    pathToBuildsAndroid=~/Documents/Products_Customs/Projetos/"$projeto"/BUILDS/Android
    scp $pathToBuildsAndroid/"$buildName"_"$versionCode".aab matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs/"$projeto"/BUILDS/Android/
    scp $pathToBuildsAndroid/"$buildName"_"$versionCode".apk matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs/"$projeto"/BUILDS/Android/
    scp $pathToBuildsAndroid/app-debug.apk matheussantos@192.168.1.14:/backups/Arquivos/Mobile/FMobile/FMobile_6/Customs/"$projeto"/BUILDS/Android/
  fi

  print_light_red "\n\nQUER REMOVER OS BUILDS???(y/n) "
  read remove

  if [[ $remove == 'y' ]]; then
    print_blue "-> Removendo os builds(.aab e .apk) ...\n\n\n"
    rm -rf $pathToBuildsAndroid/"$buildName"_"$versionCode".aab
    rm -rf $pathToBuildsAndroid/"$buildName"_"$versionCode".apk
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
# # cd ~/Documents/Products_Customs/Projetos/
# # ls
# # echo -e "Which project: "
# # read project
# pathBuildsProjectIOS=~/Documents/Products_Customs/Projetos/$project/BUILDS/IOS
# pathPrintsProjectIOS=~/Documents/Products_Customs/Projetos/$project/IMAGENS/prints/IOS
# pathScripts=Scripts/BashScript

# sh $pathScripts/takePrintsFromIOS.sh "$pathBuildsProjectIOS" "$pathPrintsProjectIOS" $bundle $scheme
