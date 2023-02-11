# Put this at the top of your kata01.py file
kata = {
    'Python': 'Guido van Rossum',
    'Ruby': 'Yukihiro Matsumoto',
    'PHP': 'Rasmus Lerdorf',
}


def print_dict(data: dict, formatted=None):
    """
    This function displays the dict-variable content.
        format: f'{key} was created by {value}'
    """
    for key, value in data.items():
        print(f'{key} was created by {value}')


if __name__ == "__main__":
    print_dict(kata)
