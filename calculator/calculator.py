from operation import Operation

print("this is a simple calculator that adds 2 mumbers")

operation_set =['*','/','+','-']

while True:
	operation = input("what operation? (*,/,+,-): ")
	if operation in operation_set:
		break
	else:
		print("not a supported operation")
		continue
		
while True:
	first_number = input("input first number: ")
	try:
		first_number = int(first_number)
		break
	except ValueError:
		print("not a number! please try again")
		continue

while True:
	second_number = input("input second number: ")
	try:
		second_number = int(second_number)
		
	except ValueError:
		print("not a number! please try again")
		continue
	if second_number ==0 and operation == '/':
		print("thats illegal..")
	else:
		break
if operation== '+':
	Operation.addition(first_number,second_number)
	
elif operation== '-':
	Operation.subraction(first_number,second_number)
	
elif operation== '/':
	Operation.division(first_number,second_number)
	
elif operation== '*':
	Operation.multiplication(first_number,second_number)

else:
	print("surprise! Theres a flaw in the logic -_-")
	

