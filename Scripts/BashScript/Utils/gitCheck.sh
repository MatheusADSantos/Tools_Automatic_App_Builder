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

newProjectOrUpdate=$1
pathProject=$2
bundle=$3
branch=$4

removingAllReferencesFromCache() {
  print_light_red "Removing all references from cache(.idea/.gradle) and Replace all reference from bundle ...\n\n"
  $(find . \( ! -regex '.*/\..*' \) -type f | xargs perl -pi -e "s/com.fulltrack.fmobile/$bundle/g;") # SUBSTITUINDO TODAS AS OCORRENCIAS DO BUNDLE ...
  rm -rf .idea
  rm -rf .gradle
  # rm -rf $pathProject/app/build
}

checkingStatus() {
  while [[ $(git status | grep "nothing to commit, working tree clean") != 'nothing to commit, working tree clean' ]]; do
    if [[ $1 == 'rebase' ]]; then
      removingAllReferencesFromCache

      afplay /System/Library/Sounds/Blow.aiff
      print_light_red "Resolva os conflitos ...\n"
      print_light_gray "Only Conflicts: \n\n"
      print_red "$(git status | grep both | grep modified)"

      echo "\nResolveu? ... (y/n)"
      read resolveu
      echo "\n"

      if [[ $resolveu == 'y' ]]; then
        # removingAllReferencesFromCache

        print_light_green "\n\nContinuando o rebase 'git rebase --continue' ...\n"
        git add .
        sleep 3
        git rebase --continue
        # if [[ $(git status | grep "*.DS_Store" | grep ".project" | grep "app/.project") != '' ]]; then
        #   print_light_red "DS_Store - Cache ..."
        #   $(git add . | git add *.DS_Store | git )
        # fi
      fi

    else
      afplay /System/Library/Sounds/Blow.aiff
      osascript -e 'display alert "ATENÇÃO!" message "Verifique sua arvore na branch $(git branch)!"'

      echo -e "\nPlease, verify your tree from git ... then continue your custom ..."
      status=$(git status | grep "nothing to commit, working tree clean")
      print_light_green "\n$status"
      sleep 2
    fi
    sleep 1
  done
}

print_light_red "\n\n\n- Configurando GIT!!!\n"
print_light_gray "Branch em questão: $(print_green $branch)"

[ $newProjectOrUpdate == 'n' ] && porjetoNovoOuAtualizacao='NOVO' || porjetoNovoOuAtualizacao='ATUALIZAÇÃO'
print_light_gray "\nProjeto $(print_green $porjetoNovoOuAtualizacao) \nPath do Projeto: $(print_green $pathProject) \n\n"
sleep 5

print_light_red "\n\n\n------------------------- Checking Status from GIT -------------------------\n\n"
cd $pathProject
checkingStatus

if [[ $newProjectOrUpdate == 'novo' || $newProjectOrUpdate == 'n' || $newProjectOrUpdate == 'N' ]]; then
  afplay /System/Library/Sounds/Blow.aiff
  osascript -e 'display alert "ATENÇÃO!" message "Verifique se está conectado na VPN"'
  git checkout master
  git pull
  sleep 2

  # print_blue "\n-> Define a name(customNewBranch) to your new branch.\n"
  # read branch

  print_blue "\n-> The branch's name is $branch\n"
  sleep 3

  touch branchs.txt
  printf "$(git branch)" >>branchs.txt
  lookForBranch=$(awk '//{print}' branchs.txt | grep "$branch")
  while [[ $lookForBranch != '' ]]; do
    # afplay /System/Library/Sounds/Funk.aiff
    afplay /System/Library/Sounds/Hero.aiff
    print_light_red "\nAlready exist a branch with this name: $branch...\n"

    print_light_blue "\n-> Define a name(customNewBranch) to your new branch.\n"
    read branch

    lookForBranch=$(awk '//{print}' branchs.txt | grep "$branch")
  done
  rm branchs.txt

  git checkout -b $branch

else

  afplay /System/Library/Sounds/Blow.aiff
  print_blue "\n\nWhat do you wanna ...\n"
  echo "Just Build (B) or Update(REBASE)(R)?"
  read updateOrRebase
  if [[ $updateOrRebase == 'R' || $updateOrRebase == 'r' ]]; then
    afplay /System/Library/Sounds/Blow.aiff
    osascript -e 'display alert "ATENÇÃO!" message "Verifique se está conectado na VPN"'

    git checkout master
    git pull
    git status
    sleep 5

    # afplay /System/Library/Sounds/Blow.aiff
    # print_blue "\n>>> BRANCHS EXISTENTES <<< \n$(print_green "$(git branch)") \n\n$(print_blue "-> Escolha a branch pra dar <checkout> ...")\n"
    # read branch
    # git checkout $branch

    afplay /System/Library/Sounds/Blow.aiff
    print_blue "\n>>> BRANCHS EXISTENTES <<< \n$(print_green "$(git branch)") \n\n$(print_blue "-> A branch selecionada é $branch")\n"
    git checkout $branch
    print_green "$(git branch)"
    sleep 3

    print_blue "\nGetting a REBASE on master\n"
    git rebase master
    checkingStatus 'rebase'
    # git status
    print_light_gray "Only Conflicts: \n\n"
    print_red "$(git status | grep both | grep modified)"
    sleep 5

    print_light_red "\n\nABRINDO O ANDROID STUDIO..."
    open -a Android\ Studio $pathProject

    # ./gradlew check

    sleep 20
    afplay /System/Library/Sounds/Blow.aiff
    print_light_gray "\nJá sincronizou o projeto??? \nSe SIM de um 'return' pra continuar ..."
    read sincronizou
  else
    # afplay /System/Library/Sounds/Blow.aiff
    # print_blue "\n>>> BRANCHS EXISTENTES <<< \n$(print_green "$(git branch)") \n\n$(print_blue "-> Escolha a branch pra dar <checkout> ...")\n"
    # read branch
    # git checkout $branch

    afplay /System/Library/Sounds/Blow.aiff
    print_blue "\n>>> BRANCHS EXISTENTES <<< \n$(print_green "$(git branch)") \n\n$(print_blue "-> A branch selecionada é $branch")\n"
    git checkout $branch
    $(git branch)
    sleep 3
  fi
fi
