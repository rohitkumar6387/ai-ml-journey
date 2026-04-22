class Inputstring():
    def __init__(self):
        self.a=""

    def getstring(self):
        self.a=input()

    def printstring(self):
        print(self.a.upper())

s1=Inputstring()
s1.getstring()
s1.printstring()
