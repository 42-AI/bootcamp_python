# Exercise 02 - The vector.

|                         |                     |
| -----------------------:| ------------------- |
|   Turn-in directory :   |  ex02               |
|   Files to turn in :    |  vector.py<br>test.py |
|   Forbidden functions : |  None              |
|   Remarks :             |  n/a               |

You will provide a testing file to prove that your class works as expected.  
You will have to create a helpful class, with more options and providing enhanced ease of use for the user.

The goal is to have vectors and be able to perform mathematical operations with them.

```py
>> v1 = Vector([0.0, 1.0, 2.0, 3.0])
>> v2 = v1 * 5
>> print(v2)
(Vector [0.0, 5.0, 10.0, 15.0])
```

It has 2 attributes:  
* `values` : list of float
* `size` : size of the vector -> `Vector([0.0, 1.0, 2.0, 3.0]).size == 4`

You should be able to initialize the object with:
* a list of floats: `Vector([0.0, 1.0, 2.0, 3.0])`  
* a size `Vector(3)` -> the vector will have `values = [0.0, 1.0, 2.0]`
* a range or `Vector((10,15))` -> the vector will have `values = [10.0, 11.0, 12.0, 13.0, 14.0]`

You will implement all the following built-in functions (called 'magic methods') for your Vector class:

```py
    __add__
    __radd__
    # add : scalars and vectors, can have errors with vectors.
    __sub__
    __rsub__
    # sub : scalars and vectors, can have errors with vectors.
    __truediv__
    __rtruediv__
    # div : only scalars.
    __mul__
    __rmul__
    # mul : scalars and vectors, can have errors with vectors, 
    # return a scalar if we perform Vector * Vector (dot product)
    __str__
    __repr__
```

Don't forget to handle all kind of errors properly!