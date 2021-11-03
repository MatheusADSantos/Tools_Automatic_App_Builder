#!/bin/bash -i

echo ""
echo ""
cd ~/Desktop/matheus/trabalho/EXECUTAVEIS/AABTolls/

cat devices.txt
printf "$(adb devices)" >>devices.txt

resultado=$(awk '/[[:digit:]]/ {print $ 1}' devices.txt)
echo ""
echo ""
echo -e "Device(s): \n$resultado"
echo ""
echo ""

rm devices.txt