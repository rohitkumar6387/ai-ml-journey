#Day 0 FizzBuzz Problem
#Logic:3=Fizz 5=Buzz 15=FizzBuzz
for a in range(1,101):
    if a%15==0:
        print("FizzBuzz")

    elif a%5==0:
        print("Buzz")

    elif a%3==0:
        print("Fizz")

    else:
        print(a)
