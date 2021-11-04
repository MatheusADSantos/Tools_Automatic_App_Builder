#!/Users/macbook-estagio/Desktop/matheus/trabalho/Gitlab_Projects/tools-automatic-app-builder/Scripts/Python/enviromentAutomation/bin/python

import time
import pyttsx3
import pyautogui as pa
import sys
import os
import zipfile
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.select import Select
from pynput.mouse import Button, Controller
mouse = Controller()

print("PArametro 1: ", sys.argv[0],"\nPArametro 2:", sys.argv[1])


pa.PAUSE = 3

def sleep(segundos):
  return time.sleep(segundos)

def click_download():
  # sleep(2)
  element_button_download = browser.find_element_by_xpath('//*[@id="download-zip-button"]')
  element_button_download.click()
  sleep(4)

def config_icons(nome_icon, option_value):
  element_input_text = browser.find_element_by_xpath('//*[@id="inputs-form"]/div[7]/div/input')
  element_input_text.clear()
  element_input_text.send_keys(nome_icon)
  element_input_text.send_keys(Keys.ENTER)

  element_button_shape = browser.find_element_by_xpath('/html/body/div/div[1]/div/div[5]/div/div/select')
  element_button_shape.send_keys(option_value)
  print("Form element_button_shape(Value) -----> ", element_button_shape.get_attribute('value'))
  sleep(5)

  click_download()

def unzip_icons():
  my_dir = r"/Users/macbook-estagio/Downloads/"
  my_zip_ic_launcher = r"/Users/macbook-estagio/Downloads/ic_launcher.zip"
  my_zip_ic_launcher_foreground = r"/Users/macbook-estagio/Downloads/ic_launcher_foreground.zip"
  my_zip_ic_launcher_round = r"/Users/macbook-estagio/Downloads/ic_launcher_round.zip"
  my_zip_ic_push = r"/Users/macbook-estagio/Downloads/ic_push_notification_default.zip"

  list_zip = [ my_zip_ic_launcher, my_zip_ic_launcher_foreground, my_zip_ic_launcher_round, my_zip_ic_push ]
  for my_zip in list_zip:
    with zipfile.ZipFile(my_zip) as Zip:
      for Zip_info in Zip.infolist():
        # print(Zip_info.filename)
        if Zip_info.filename[0] == ('r'):
          print("\n", "*" * 20)
          print(Zip_info.filename, "\n", Zip_info)
          Zip.extract(Zip_info, my_dir)

  os.system("rm ~/Downloads/*.zip")



engine = pyttsx3.init()
engine.say("Script Automático pra gerar icones começou ...")
engine.runAndWait()

# icon = Image.open('/Users/macbook-estagio/Downloads/icon.png')
# average_color = compute_average_image_color(img)
# print(average_color)
# sleep(10)

option = Options()
option.headless = False
# option.headless = True
browser = webdriver.Chrome(options=option)
# url="https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html#foreground.type=image&foreground.space.trim=1&foreground.space.pad=0&foreColor=rgba(96%2C%20125%2C%20139%2C%200)&backColor=rgb(255%2C%20255%2C%20255)&crop=0&backgroundShape=square&effects=none&name=ic_launcher"
url="https://romannurik.github.io/AndroidAssetStudio/index.html"
browser.get(url)

# Selecionando a página 'Laucher Icon Generator'
browser.find_element_by_xpath('/html/body/div[2]/div/a[1]').click()

# Subindo icon.png 
element_upload_image = browser.find_element_by_xpath('/html/body/div/div[1]/div/div[1]/div/div[1]/input[4]')
element_upload_image.send_keys('/Users/macbook-estagio/Downloads/iconApp.png')

# Zerando o Padding
element_padding = browser.find_element_by_xpath('/html/body/div/div[1]/div/div[1]/div/div[4]/div[2]/div/div/input')
element_padding.send_keys(Keys.LEFT * 5)

# Mudando o Background Color
element_background_color = browser.find_element_by_xpath('//*[@id="_frm-iconform-backColor"]/button/div') 
print(element_background_color.get_attribute('style'))
# browser.execute_script(" document.getElementsByClassName('form-field-color-widget-swatch')[0].style.cssText = 'color: rgb(255, 255, 255);' ")
browser.execute_script(" document.getElementsByClassName('form-field-color-widget-swatch')[1].style.cssText = 'color: rgb(255, 255, 255);' ")
# browser.execute_script(" document.getElementsByClassName('flexbox-fix')[2].style = 'margin: 0px -10px; padding: 10px 0px 0px 10px; border-top: 1px solid rgb(255, 255, 255); display: flex; flex-wrap: wrap; position: relative;' ")
browser.find_element_by_xpath('//*[@id="_frm-iconform-backColor"]/button').click()
browser.find_element_by_xpath('/html/body/div/div[1]/div/div[3]/div/div/div/div/div[2]/div[4]/div[19]').click()
browser.find_element_by_xpath('//*[@id="_frm-iconform-backColor"]/button').send_keys(Keys.ESCAPE)
print(element_background_color.get_attribute('style'))
sleep(5)


# GERANDO OS ic_launcher 
config_icons('ic_launcher', 'square')


# GERANDO OS ic_launcher_foreground 
config_icons('ic_launcher_foreground', 'square')


# GERANDO OS ic_launcher_round
config_icons('ic_launcher_round', 'circle')


# GERANDO OS drawble(Icones do Push Notification)
url_notification="https://romannurik.github.io/AndroidAssetStudio/icons-notification#source.type=image&source.space.trim=0&source.space.pad=0&name=ic_push_notification_default"
browser.get(url_notification)
sleep(5)

# Selecionando o Source Text
element_button_text = browser.find_element_by_xpath('//*[@id="_frm-iconform-source"]/label[3]')
element_button_text.click()
sleep(5)

# Digitando o nome do icone
element_input_text = browser.find_element_by_xpath('//*[@id="inputs-form"]/div[1]/div/div[3]/div[1]/div/input')
element_input_text.clear()
text_push_notification = sys.argv[1]
element_input_text.send_keys(text_push_notification)
element_input_text.send_keys(Keys.ENTER)
sleep(3)
click_download()

engine.say("Gerou os icones ...!")
engine.runAndWait()

browser.quit()
sleep(2)

engine.say("Agora Desconpactando(ZIP) ...!")
engine.runAndWait()

unzip_icons()
sleep(2)

engine.say("PRONTOO!")
engine.runAndWait()
os.system('deactivate')