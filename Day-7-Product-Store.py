class Product:
    count=0
    def __init__(self,name,price):
        self.name=name
        self.price=price
        Product.count+=1

    def get_info(self):
        print(f"the price of {self.name} is Rs.{self.price}")

    @classmethod
    def get_count(cls):
        print(f"total product is {cls.count}")

    @staticmethod
    def get_disc(price,disc_per):
        print(f"total price is {price-(price*disc_per/100)}")

p1=Product("cake",2000)
p2=Product("laptop",60000)
p3=Product("shoose",2000)
p4=Product("mobilephone",20000)
p1.get_info()
p2.get_info()
p3.get_info()
p4.get_info()
Product.get_count()
Product.get_disc(84000,20)
