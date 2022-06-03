#!/bin/bash

print_red() {
	printf "\e[0;31m$1\e[0m"
}

print_red "\n\nKilling XCODE...\n"
killall Xcode
xcrun -k

print_red "\n\nCleanning...\n"
xcodebuild -alltargets clean
# rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang/ModuleCache"
# rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang.$(whoami)/ModuleCache"

print_red "\n\nTamanho dos DerivedData\n"
cd ~/Library/Developer/Xcode/DerivedData/
du -khd 1

print_red "\n\nDeletando os DerivedData...\n"
rm -rf ~/Library/Developer/Xcode/DerivedData/*

print_red "\n\nTamanho os ARCHIVES\n"
cd ~/Library/Developer/Xcode/Archives/
du -khd 1

print_red "\n\nDeletando os ARCHIVES...\n"
rm -rf ~/Library/Developer/Xcode/Archives/*

# rm -rf ~/Library/Caches/com.apple.dt.Xcode/*

# xcrun simctl help
print_red "\n\nTamanho dos SIMULADORES\n"
cd ~/Library/Developer/CoreSimulator/Devices
du -khd 1

print_red "\n\nLISTA - SIMULADORES\n"
xcrun simctl list

print_red "\n\nDeletando os Simuladores inutilizaveis ...\n"
xcrun simctl delete unavailable

print_red "\n\n>>> DEPOIS DA LIMPA ... <<< \nTamanho dos DerivedData\n"
cd ~/Library/Developer/Xcode/DerivedData/
du -khd 1
print_red "\n\nTamanho os ARCHIVES\n"
cd ~/Library/Developer/Xcode/Archives/
du -khd 1
print_red "\n\nTamanho dos SIMULADORES\n"
cd ~/Library/Developer/CoreSimulator/Devices
du -khd 1

if [[ $1 != "" ]]; then
    reiniciar=$1
else
    print_red "\n\nReload XCODE(y/n)???\n"
    read reiniciar
fi

if [[ $reiniciar == "yes" ]] || [[ $reiniciar == "y" ]]; then
    print_red "\n\nReiniciando XCode ...\n"
    open /Applications/Xcode.app
    print_red "\n\nCONCLUÍDO!!!\n"
else
    print_red "\n\nCONCLUÍDO!!!\n"
fi
