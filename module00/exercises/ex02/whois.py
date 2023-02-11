import sys

argc = len(sys.argv)
if argc == 1:
    print("usage: python3", sys.argv[0], "[integer]")
    quit(1)

sys.tracebacklimit = 0
assert argc == 2, "more than one argument are provided"
assert sys.argv[1].isnumeric() is True, "argument is not an integer"

number = int(sys.argv[1])
result = "I'm"
if number == 0:
    result = "Zero"
elif number % 2 == 1:
    result = "Odd"
else:
    result = "Even"

print("I'm ", result, ".", sep="")
