import pyttsx3
import sys

engine = pyttsx3.init()
case=sys.argv[1]
print("PArametro 1: ", sys.argv[0],"\nPArametro 2:", case)

def before_all():
    engine.say("Atualizando o 'BAMDOU' e Setando as Váriaveis ...")
    engine.runAndWait()

def build():
    engine.say("Buildando ...")
    engine.runAndWait()

def default():
    engine.say("Pronto! Subiu o 'BIUDI' pro Testflight!!!")
    engine.runAndWait()

def switch(case):
    if case == "before_all":
        return before_all
    elif case == "build":
        return build
    else:
        return default

if __name__ == "__main__":
    function = switch(case=case)
    function()