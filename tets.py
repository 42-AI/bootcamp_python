import math
import os
import random
import re
import sys

# Complete the birthdayCakeCandles function below.
def birthdayCakeCandles(ar):
    count, max = 1, ar[0]
    for x in ar[1:]:
        count = count + 1 if max == x else count
        if max < x:
            count, max = 1, x


if __name__ == '__main__':
    ar = [3, 2, 1, 3]

    result = birthdayCakeCandles(ar)

    print(result)
