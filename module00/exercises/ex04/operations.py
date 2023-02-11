import sys


def handle_operations(num1: int, num2: int):
    """
    This function takes two integers and prints the result of the elementary
    operations.
    """
    results = ""
    results += '{operation:12} {result}\n'.format(operation="Sum:",
                                                  result=num1 + num2)
    results += '{operation:12} {result}\n'.format(operation="Difference:",
                                                  result=num1 - num2)
    results += '{operation:12} {result}\n'.format(operation="Product:",
                                                  result=num1 * num2)
    try:
        results += '{operation:12} {result}\n'.format(operation="Quotient:",
                                                      result=num1 / num2)
        results += '{operation:12} {result}'.format(operation="Remainder:",
                                                    result=num1 % num2)
    except ZeroDivisionError:
        results += '{operation:12} {error}\n'.format(operation="Quotient:",
                                                     error='ERROR (division by zero)')
        results += '{operation:12} {error}'.format(operation="Remainder:",
                                                   error='ERROR (modulo by zero)')
    print(results)


if __name__ == '__main__':
    sys.tracebacklimit = 0

    argc = len(sys.argv)
    if argc >= 3:
        pass
    else:
        assert argc == 1, "required two arguments"

        print(f'Usage: python {sys.argv[0]} <number1> <number2>\n'
              f'Example:\n\tpython {sys.argv[0]} 10 3')
        exit(1)

    assert len(sys.argv) == 3, 'too many arguments'

    number1 = sys.argv[1]
    number2 = sys.argv[2]
    assert number1.isnumeric() and number2.isnumeric(), "only integers"

    handle_operations(int(number1), int(number2))
