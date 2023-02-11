import string
import sys


def text_analyzer(text=""):
    """
    This function counts the number of upper characters, lower characters,
    punctuation and spaces in a given text.
    """
    if len(text) == 0:
        text += input("What is the text to analyze?\n>> ")

    numOfLowerCases: int = 0
    numOfUpperCases: int = 0
    numOfPunctuation: int = 0
    numOfWhiteSpaces: int = 0
    for i in range(len(text)):
        ch = text[i]
        if (ch in string.ascii_uppercase) is True:
            numOfUpperCases += 1
        elif (ch in string.ascii_lowercase) is True:
            numOfLowerCases += 1
        elif (ch in string.punctuation) is True:
            numOfPunctuation += 1
        elif (ch in string.whitespace) is True:
            numOfWhiteSpaces += 1
        else:
            sys.tracebacklimit = 0
            assert False, 'argument is not a string'

    print('The text contains', len(text), 'character(s):')
    print('-', numOfUpperCases, 'upper letter(s)')
    print('-', numOfLowerCases, 'lower letter(s)')
    print('-', numOfPunctuation, 'punctuation mark(s)')
    print('-', numOfWhiteSpaces, 'spaces(s)')


if __name__ == "__main__":
    argc = len(sys.argv)

    if argc == 1:
        exit(1)

    sys.tracebacklimit = 0
    assert argc == 2, "more than one argument are provided"

    text_analyzer(sys.argv[1])
