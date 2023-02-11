import sys

cookbook = {
    "sandwich": {
        "ingredients": ["ham", "bread", "cheese"],
        "meal": "lunch",
        "prep_time": 10,
    },
    "cake": {
        "ingredients": ["flour", "sugar", "eggs"],
        "meal": "dessert",
        "prep_time": 60,
    },
    "salad": {
        "ingredients": ["avocado", "arugula", "tomatoes", "spinach"],
        "meal": "lunch",
        "prep_time": 15,
    },
}


# Helper1
def print_cookbook(cookbook: dict):
    cooks = '\n'.join([cook for cook in cookbook])
    print(cooks)


# Helper2
def print_recipe(cookbook: dict):
    try:
        print("Please enter a recipe name to get its details")
        name = input(">> ").lower()
        recipe = cookbook[name]
        print(f'\nRecipe for {name}:',
              f'  Ingredients list: {recipe["ingredients"]}',
              f'  To be eaten for {recipe["meal"]}.',
              f'  Takes {recipe["prep_time"]} minutes of cooking.', sep='\n')
    except Exception as e:
        print("Sorry, this recipe does not exist.")


# Helper3
def delete_recipe(cookbook: dict):
    try:
        recipe = str(input(">>> Enter a name:"))
        cookbook.pop(recipe)
    except Exception as e:
        print("Sorry, this recipe does not exist.")


# recipe 중복 처리.
#
# Helper4
def add_recipe(cookbook:dict):
    try:
        recipe = input(">>> Enter a name:")
        if recipe in cookbook.keys():
            raise Exception

        print(">>> Enter ingredients:")
        ingredients = []
        while True:
            ingredient = input()
            if ingredient == "":
                break
            ingredients.append(ingredient)

        meal = str(input(">>> Enter a meal types:"))
        prep_time = int(input(">>> Enter a preparation time:"))
        cookbook[recipe] = {
            "ingredients": ingredients,
            "meal": meal,
            "prep_time": prep_time
        }

def quit_cookbook():
    print("Cookbook closed. Goodbye !")
    quit(0)


commands = (
    lambda cookbook: add_recipe(cookbook),
    lambda cookbook: delete_recipe(cookbook),
    lambda cookbook: print_recipe(cookbook),
    lambda cookbook: print_cookbook(cookbook),
    lambda cookbook: quit_cookbook(),
)


def print_options(msg: str = ""):
    print(msg,
          "List of available option:",
          "   1: Add a recipe",
          "   2: Delete a recipe",
          "   3: Print a recipe",
          "   4: Print the cookbook",
          "   5: Quit", sep='\n')


if __name__ == "__main__":
    print_options("Welcome to the Python Cookbook !")

    while True:
        try:
            option = int(input("\nPlease select an option:"
                               "\n>> "))

            if option in range(1, 6):
                commands[option - 1](cookbook)
            else:
                raise NotImplementedError()

        except Exception as e:
            print_options("Sorry, this option does not exist.")
