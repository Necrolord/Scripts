#!/usr/bin/env python36

def func_1(arr_list,num_integer):
    print (functools.reduce(lambda x, y: x + y, arr_list))
    if num_integer > len(arr_list):
        return True
    else:
        return False
############################
# Author : Andrey Stepansky
# Comment: Home Work
# Date: 02.06.2018
# ex1
############################
import functools
arr=range(1,11)
num=5
func_1(arr,num)

############################
# Author : Andrey Stepansky
# Comment: Home Work
# Date: 02.06.2018
# ex 2
#  Note: have no idea how to get multiply by calling Add from Mul
############################

def Add (var1,var2):
    return var1+var2

def Mul (var1,var2):
    if (var1==0 or var2==0):
        return 0
    elif var1==1:
        return var2
    elif var2==1:
        return var1
    else:
       return (var1 + Mul(var1,var2 -1))


from random import *
x=randint(1, 100)
y=randint(1, 100)
print("Number one is : ",x,"Second number is : ",y)
print("Sum of the numbers is: ",Add(x,y))
print("Multiply is : ",Mul(x,y))

############################
# Author : Andrey Stepansky
# Comment: Home Work
# Date: 02.06.2018
# ex3
############################

var1 = "Hi"
var2 = "Hello"
var3 = "Shalom"
var4 = "Bye Bye"
print (var1,var2,var3,var4)

def func_2(x,y):
    if len(x) >= len(y):
        return x
    else:
        return y
map(func_2,var1,var2)
map(func_2,var3,var4)
print (var1,var2,var3,var4)