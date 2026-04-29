a={"a":10,"b":5}
b={"b":20,"c":15}
merged=a.copy()
for key,value in b.items():
    if key in merged:
        merged[key]+=value
    
    else:
        merged[key]=value

print(merged)
