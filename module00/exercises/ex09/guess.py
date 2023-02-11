import random

if __name__ == "__main__":
    print("This is an interactive guessing game!",
          "You have to neter a number between 1 and 99 to find out the secret number",
          "Type 'exit' to end the game.",
          "Good luck!", sep="\n", end="\n\n")

    secretNumber = 42
    secretMessage = "The answer to the ultimate question of life, the universe and everything is 42."
    randomNumber = random.randint(1, 99)
    userNumber = 0
    attempts = 0
    while True:
        attempts += 1
        try:
            userInput = input("What's your guess between 1 and 99?\n"
                              ">> ").strip().lower()

            if userInput == "exit":
                print("Goodbye!")
                exit(0)

            if not userInput.isnumeric():
                raise Exception("That's not a number")

            userNumber = int(userInput)

            if attempts == 1 and userNumber == secretNumber:
                break

            if userNumber > randomNumber:
                print("Too high!")
            elif userNumber < randomNumber:
                print("Too low!")
            else:
                break

        except Exception as e:
            print(e)

    if attempts == 1 and userNumber == secretNumber:
        print(secretMessage,
              "Congratulations! you got it on your first try!", sep="\n")
    else:
        print("Congratulations, you've got it!",
              f"You won in {attempts} attempts!", sep="\n")
