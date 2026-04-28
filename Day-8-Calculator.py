while True:
    a=input("enter the first number or tpye'exit':")
    if a=="exit":
        print("calculatar is off")
        break
    try:
        a=int(a)
        sign=input("operator : ")
        b=int(input("enter the second number:"))

        if(sign=="+"):
            print("sum of these number=",a+b)

        elif(sign=="-"):
            print("substract of these number=",a-b)

        elif(sign=="*"):
            print("multiplication of these number=",a*b)

        elif(sign=="/"):
            if(b==0):
                raise ZeroDivisionError("a is not disivible by 0")
            print("division of these number=",a/b)
        else:
            raise ValueError("wrong operator")
        
    except ValueError as e:
        print("Error",e)

    except ZeroDivisionError as e:
        print("Error",e)

    print("----------")
