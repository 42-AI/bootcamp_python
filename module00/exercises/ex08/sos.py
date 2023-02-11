import sys

morseCodes = {"A": ".-",
              "B": "-...",
              "C": "-.-.",
              "D": "-..",
              "E": ".",
              "F": "..-.",
              "G": "--.",
              "H": "....",
              "I": "..",
              "J": ".---",
              "K": "-.-",
              "L": ".-..",
              "M": "--",
              "N": "-.",
              "O": "---",
              "P": ".--.",
              "Q": "--.-",
              "R": ".-.",
              "S": "...",
              "T": "-",
              "U": "..-",
              "V": "...-",
              "W": ".--",
              "X": "-..-",
              "Y": "-.--",
              "Z": "--..",
              "0": "-----",
              "1": ".----",
              "2": "..---",
              "3": "...--",
              "4": "....-",
              "5": ".....",
              "6": "-....",
              "7": "--...",
              "8": "---..",
              "9": "----.",
              " ": " / "}

if __name__ == "__main__":
    mergedMsg = " ".join([sys.argv[i].upper() for i in range(1, len(sys.argv))])

    try:
        encodedMsg = ""
        for ch in mergedMsg:
            encodedMsg += morseCodes[ch]

        print(encodedMsg)

    except Exception as e:
        print(e)
        print("ERROR")
