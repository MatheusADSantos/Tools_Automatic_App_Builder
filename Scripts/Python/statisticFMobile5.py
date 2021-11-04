#!/Users/macbook-estagio/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/Python/envAutomationWebScript/bin/python

import time
import requests
import pandas as pd # Tratar dados ...
from bs4 import BeautifulSoup # 
# from urllib.request import urlopen, Request
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

from webdriver_manager.chrome import ChromeDriverManager
# driver = webdriver.Chrome(executable_path='~/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/Python/envAutomationWebScript/bin')
driver = webdriver.Chrome(ChromeDriverManager().install())

import ssl
ssl._create_default_https_context = ssl._create_unverified_context

import json

# ------------------------------------------------------------------------------------------------------------------------

# Pegar o conteúdo em HTML a partir da URL
url = "http://www.google.com/"

option = Options()
option.headless = True
driver = webdriver.Chrome(options=option)
# driver = webdriver.Chrome() # Mostra a execução 

driver.get(url)
time.sleep(5)

driver.quit()




# driver.get('http://www.google.com/');
# time.sleep(5) # Let the user actually see something!
# search_box = driver.find_element_by_name('q')
# search_box.send_keys('ChromeDriver')
# search_box.submit()
# time.sleep(5) # Let the user actually see something!
# driver.quit()





# html = urlopen(url)
# bs = BeautifulSoup(html, 'html.parser')



# valueAtualization = bs.find_all('span', {'class': 'value _ngcontent-zfy-54'})
# # print(valueAtualization)

# ## Imprime todo texto contido em cada linha ##
# for i in valueAtualization:
#     print(i.text)

# ## Imprime o texto de cada uma das tags filhas ##
# # for i in linhas:
#     # filhas = i.findChildren("td")
#     # print(filhas[0])
#     # print(filhas[1])
#     # print(filhas[2])


# # file_object  = open("filename", "mode") 
# htmlEstatiscasFMobile_5 = open("htmlEstatiscasFMobile_5.txt", "w+")
# htmlEstatiscasFMobile_5.write(bs.prettify())