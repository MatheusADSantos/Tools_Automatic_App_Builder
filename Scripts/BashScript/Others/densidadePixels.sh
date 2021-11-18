# !/bin/bash -i

# VerificaDensidadeDePixels

echo -e "\n\n-> Entre com os argumentos..."

echo -e "\n1)Pixels em x: "
read x

echo -e "\n2)Pixels em y: "
read y

echo -e "\n3)Polegadas da tela: (Ex: 15.6) "
read polegadas

lado1=$(($x ** 2))
lado2=$(($y ** 2))
somaDosQuadrados=$(($lado1 + $lado2))

# echo $somaDosQuadrados
# echo "sqrt($somaDosQuadrados)" | bc

densidadePixels=$(echo "sqrt($somaDosQuadrados)/$polegadas" | bc)
echo -e "\n\n>>>  OBS: Densidade do Macbook Pro: 226 pixels/polegada  <<<"
porcentagemEmCimaDaDoMac=$(($densidadePixels/226))
$porcentagemEmCimaDaDoMac=($porcentagemEmCimaDaDoMac*100)
echo -e "\n\n>>>  Densidade: $densidadePixels pixels/polegada  <<< \n>>>  $porcentagemEmCimaDaDoMac% menor que o Mac ... \n\n"

# afplay /System/Library/Sounds/Blow.aiff
# osascript -e 'displ`ay alert "ATENÇÃO!" message "A densidade de pixel é $densidadePixels"'`
