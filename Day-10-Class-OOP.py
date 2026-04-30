class Employee:
    def get_designation(self):
        print("designation=Employee")

class Teacher():
    def get_designation(self):
        print("designation=Teacher")

t1=Teacher()
t1.get_designation()

e1=Employee()
e1.get_designation()
