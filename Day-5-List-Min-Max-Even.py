a=[]
for i in range(5):
    n=int(input("enter 5 number one by one  : "))
    a.append(n)
a.sort()
print("minimum number is : ",a[0])

a.sort(reverse=True)
print("maximum number is : ",a[0])

print("sum=",sum(a))
print("average=",sum(a)/5)

for b in range(0,len(a)):
    if a[b]%2!=0:
       print(a[b],end=",")
