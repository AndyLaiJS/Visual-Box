vowel = ["a", "e", "i", "o", "u"]
inp = input()
count = 0
for i in inp:
    if i in vowel:
        count+=1

print(count)