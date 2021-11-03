#!/Users/macbook-estagio/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/Python/envAutomationWebScript/bin/python

# Cria-se uma pasta para criar seus scripts em python
# Depois cria-se um virtual enviroment 
# # Pra poder instalar suas dependencias isolado do env global sem dar conflito de versões por exemplo ...
# Assim que criado o venv, basta ativa-lá 
# # source .path/do/projeto//virtualEnv/bin/activate
# Assim que for ativado, você pode instalar as libs especificas para o projeto, Ex: pip install pyttsx3 ou até mesmo rodar o script ...

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import pyttsx3

engine = pyttsx3.init()

engine.say("Olá, vai começar a automação, por favor não mexa no computador até eu avisar que pode!")
engine.runAndWait()

time.sleep(2)

browser = webdriver.Chrome()

browser.get("https://www.linkedin.com/login")

input_email = browser.find_element_by_id("username")
# input_email.send_keys('***SEU EMAIL AQUI***')
input_email.send_keys('matheusdevmobile2020@gmail.com')

input_senha = browser.find_element_by_id("password")
# input_senha.send_keys('***SUA SENHA AQUI***')
input_senha.send_keys('adssuehtam4137')

# engine.say("PRONTO! Finalizado a Automação!!!")
# engine.runAndWait()

btn_login = browser.find_element_by_xpath("//button[@type='submit']")
btn_login.click()

time.sleep(2)

busca = browser.find_element_by_xpath("//input[@placeholder='Pesquisar']")
busca.send_keys("Python")
busca.send_keys(Keys.RETURN)

time.sleep(3)

filtro_vagas = browser.find_element_by_xpath("//button[@aria-label='Vagas']")
filtro_vagas.click()

# input('')

engine.say("PRONTO! Finalizado a Automação!!!")
engine.runAndWait()