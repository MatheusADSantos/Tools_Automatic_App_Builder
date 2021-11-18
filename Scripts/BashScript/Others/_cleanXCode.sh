#!/bin/bash
echo 'Killing XCODE...'
killall Xcode
xcrun -k
echo 'Cleanning...'
xcodebuild -alltargets clean
# rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang/ModuleCache"
# rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang.$(whoami)/ModuleCache"


echo ''
echo ''
echo ''
echo 'Tamanho dos DerivedData'
cd ~/Library/Developer/Xcode/DerivedData/
sudo du -khd 1
echo 'Deletando os DerivedData...'
rm -rf ~/Library/Developer/Xcode/DerivedData/*


echo ''
echo ''
echo ''
echo 'Tamanho os ARCHIVES'
cd ~/Library/Developer/Xcode/Archives/
sudo du -khd 1
echo 'Deletando os ARCHIVES...'
rm -rf ~/Library/Developer/Xcode/Archives/*


# rm -rf ~/Library/Caches/com.apple.dt.Xcode/*


echo ''
echo ''
echo ''
# xcrun simctl help
echo 'Tamanho dos SIMULADORES'
cd ~/Library/Developer/CoreSimulator/Devices
sudo du -khd 1
echo 'LISTA - SIMULADORES'
xcrun simctl list
echo 'Deletando os Simuladores inutilizaveis ...'
xcrun simctl delete unavailable




echo ''
echo ''
echo ''
echo '>>> DEPOIS DA LIMPA ... <<<'
echo 'Tamanho dos DerivedData'
cd ~/Library/Developer/Xcode/DerivedData/
sudo du -khd 1
echo 'Tamanho os ARCHIVES'
cd ~/Library/Developer/Xcode/Archives/
sudo du -khd 1
echo 'Tamanho dos SIMULADORES'
cd ~/Library/Developer/CoreSimulator/Devices
sudo du -khd 1


echo ''
echo ''
echo ''
echo 'Reload XCODE(y/n)???'
read reiniciar
if [[ $reiniciar == "yes" ]] || [[ $reiniciar == "y" ]]; then
    echo "Reiniciando XCode ..."
    open /Applications/Xcode.app
    echo 'CONCLUÍDO!!!'
        else
            echo 'CONCLUÍDO!!!'
fi