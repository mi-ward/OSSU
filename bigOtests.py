import mat

def dumb():
    x = 2
    i = 0
    y= 2
    z = 3
    a = 3
    b = 3

    while i < 100:
        
        yield i
        i += 1
        # print(x)
        # x += math.log(x)
        
        
        # y += 1
        # print(y)
        
        yield z
        z = (z * math.log(z))
        

        yield a
        a = a ** 2
        yield b
        b = 2 ** b
        


dumb = dumb()
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())
print(dumb.__next__())



