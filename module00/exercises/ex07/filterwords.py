import string
import sys

if __name__ == "__main__":
    argc = len(sys.argv)
    try:
        if argc != 3:
            raise Exception

        s = str(sys.argv[1])
        n = int(sys.argv[2])

        for p in string.punctuation:
            s = s.replace(p, " ")

        words = s.split()
        filterWords = [word for word in words if len(word) > n]

        print(filterWords)

    except Exception as e:
        print(e)
        print("ERROR")
