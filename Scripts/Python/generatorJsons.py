#!/Users/macbook-estagio/Desktop/matheus/trabalho/EXECUTAVEIS/Scripts/Python/envAutomationWebScript/bin/python

import time
import pyttsx3
import pyautogui as pa
import sys
import os
import glob
import zipfile
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from pynput.mouse import Button, Controller
from selenium.webdriver.support.select import Select
from webdriver_manager.chrome import ChromeDriverManager
mouse = Controller()
print("\n\nEmail:", sys.argv[1])


pa.PAUSE = 2

def sleep(segundos):
  return time.sleep(segundos)

def click_download():
  sleep(2)
  element_button_download = browser.find_element_by_xpath('//*[@id="download-zip-button"]')
  element_button_download.click()
  sleep(3)

engine = pyttsx3.init()
engine.say("Script Automático pra gerar JSON começou ...")
engine.runAndWait()

# ---------------------------------------------------------------------------------------------
  
print('Enter the gmailid and password')
gmailId, passWord = map(str, input().split())
try:
    driver = webdriver.Chrome(ChromeDriverManager().install())
    driver.get(r'https://accounts.google.com/signin/v2/identifier?continue='+\
    'https%3A%2F%2Fmail.google.com%2Fmail%2F&service=mail&sacu=1&rip=1'+\
    '&flowName=GlifWebSignIn&flowEntry = ServiceLogin')
    driver.implicitly_wait(15)
  
    loginBox = driver.find_element_by_xpath('//*[@id ="identifierId"]')
    loginBox.send_keys(gmailId)
  
    nextButton = driver.find_elements_by_xpath('//*[@id ="identifierNext"]')
    nextButton[0].click()
  
    passWordBox = driver.find_element_by_xpath(
        '//*[@id ="password"]/div[1]/div / div[1]/input')
    passWordBox.send_keys(passWord)
  
    nextButton = driver.find_elements_by_xpath('//*[@id ="passwordNext"]')
    nextButton[0].click()
  
    print('Login Successful...!!')
except:
    print('Login Failed')



# -----------------------------------------------------------------------------------

# option = Options()
# option.headless = False # True
# browser = webdriver.Chrome(options=option)
# url="https://firebase.google.com/"
# browser.get(url)

# # Ir para o console
# browser.find_element_by_xpath('/html/body/section/devsite-header/div/div[1]/div/div/a').click()
# sleep(1.2)

# # Usar outra conta
# browser.find_element_by_xpath('//*[@id="identifierId"]').click()
# sleep(1.2)

# # Entrando com o email
# browser.find_element_by_xpath('//*[@id="identifierId"]').send_keys(sys.argv[1]).send_keys(Keys.ENTER)
# sleep(1.2)

# # Próxima
# browser.find_element_by_xpath('//*[@id="identifierNext"]/div/button/div[1]"]').click()
# sleep(1.2)

# # Próxima
# browser.find_element_by_xpath('//*[@id="identifierNext"]/div/button/div[1]"]').click()
# sleep(1.2)


# engine.say("PRONTOO!")
# engine.runAndWait()
# os.system('deactivate')