# Put this at the top of your kata02.py  file
kata = (2019, 9, 25, 3, 30)
keys = ('year', 'month', 'day', 'hour', 'minute')

if __name__ == '__main__':
    date = dict(zip(keys, kata))
    print(f'{date["month"]:02d}/{date["day"]:02d}/{date["year"]:04d} '
          f'{date["hour"]:02d}:{date["minute"]:02d}')