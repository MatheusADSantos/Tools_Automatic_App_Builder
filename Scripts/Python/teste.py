#!/Library/Frameworks/Python.framework/Versions/3.9/bin/python3

# Rode o comando which python OU which python3
# Com o endereço basta jogar o path na frente de #!
# Ex: #!/usr/bin/python -> Python2 default do Mac

import pyautogui as pa
import time as t
import pyperclip
import pandas as pd
from IPython.display import display

print("Automação teste ...")

pa.PAUSE = 5

screen_size = str(pa.size())
print(screen_size)
screen_size_x, screen_size_y = screen_size.split(",")
screen_size_x= screen_size_x.replace("Size(width=","")
screen_size_y = screen_size_y.replace("height=","")
screen_size_y = screen_size_y.replace(")","")
screen_size_y = screen_size_y.replace(" ","")
screen_size_x = int(screen_size_x)
screen_size_y = int(screen_size_y)
print(screen_size_x)
print(screen_size_y)

# pa.alert("Vai começar a automação ... Aperte Ok para iniciar!!!", "ATENÇÃO!")

pa.moveTo(1353, 870, 0.5)
pa.click()
pa.click(1353, 870, clicks=2)
t.sleep(5)
print(pa.position())

pa.hotkey('command', 'space')
# # open -a "Google Chrome" http://stackoverflow.com http://wikipedia.org

pesquisa = "Google Chrome"
pyperclip.copy(pesquisa)
pa.hotkey('command', 'v')
# pa.write('Google Chrome')
t.sleep(10)
pa.press('enter')
t.sleep(2)
pa.hotkey('command', 'shift', 'n')
link = "https://docs.google.com/spreadsheets/d/1M_HMPZjIqIEnEOqVcGSNpW4FqpxOI71RFEcgQxsUYXU/edit?pli=1#gid=0"
pyperclip.copy(link)
t.sleep(1)
pa.hotkey('command', 'v')
pa.press('enter')

t.sleep(5)


# dadosDoExcell = pd.read_excel(r'~/Downloads/CONTROLE - CUSTOM.xlsx')
# display(dadosDoExcell)