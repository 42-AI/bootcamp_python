# Put this at the top of your kata00.py file
kata = (19, 42, 21)


# def print_tuple(data: tuple, formatted=None):
#     if len(data) == 0:
#         return
#     # formatted += str(data[0])
#     # for i in range(1, len(data)):
#     #     formatted += ' ,' + str(data[i])
#     print(formatted)


def print_tuple(data: tuple, formatted=None):
    if len(data) == 0:
        return

    formatted += ', '.join([str(i) for i in data])
    print(formatted)


if __name__ == "__main__":
    print_tuple(kata, f'The {len(kata)} numbers are: ')
