import sys
import time

def ft_progress(lst):
    start_time = time.time()
    width = 21
    wcounts = 0
    for current in lst:
        yield current
        elapsed_time = time.time() - start_time
        progress_ratio = (current + 1) / len(listy)
        eta_time = elapsed_time * (1 - progress_ratio) / progress_ratio
        sys.stdout.write(f"{'': <{wcounts}}\r")
        wbuffer = f"ETA: {eta_time:.2f}s " \
                  + f"[{progress_ratio * 100:.0f}%]" \
                  + f"[{'=' * int(progress_ratio * width) + '>':{width}}] " \
                  + f"{current + 1}/{len(listy)} | " \
                  + f"elapsed time {elapsed_time:.2f}s\r"
        wcounts = len(wbuffer)
        sys.stdout.write(f"{wbuffer}")


if __name__ == "__main__":
    listy = range(3333)
    ret = 0
    for elem in ft_progress(listy):
        ret += elem
        time.sleep(0.005)
    print()
    print(ret)
