# Put this at the top of your kata03.py file
kata = (0, 4, 132.42222, 10000, 12345.67)

if __name__ == "__main__":
    print(f'module_{kata[0]:02d}, ex_{kata[1]:02d} : {kata[2]:.2f}, {kata[3]:.2e}, {kata[4]:.2e}')
