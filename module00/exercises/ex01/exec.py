# Rev Alpha
import sys

# Make a program that takes a string as argument, reverses it, swaps its letters case
# and print the result.
#   • If more than one argument are provided, merge them into a single string with each
#     argument separated by a space character.
#   • If no argument are provided, do nothing or print an usage.

argc = len(sys.argv)

if argc < 2:
  print("usage: python3", sys.argv[0], "[string ...]")
  quit(1)

result = ""
for i in reversed(range(1, argc)):
  result += sys.argv[i].swapcase()[::-1]

print(result)