import os

files = os.listdir(".")

for f in files:
    # print(f"- family: {f[:-4]}\nfonts:\n- asset: fonts/{f}")
    print(f"{f[:-4]},".replace("-", "_"))

