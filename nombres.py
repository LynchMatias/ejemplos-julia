#Codigo de Python para llamar en Julia con PyCall desde performancePython.jl

import string as str
import random

def random_string(size=5, chars=str.ascii_lowercase + str.digits):
    return ''.join(random.choice(chars) for _ in range(size))

def moda(List):
    return max(set(List), key = List.count)
