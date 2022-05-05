︠6a13f954-0995-476d-a384-8161a3d8d2e5s︠
# vypocet Moorovho ohranicenia pre uvazovanu klietku
def calculateMooreBound(k,g):
    M = 0;
    if g % 2 == 1:
        exp = (g - 3) / 2;
        for i in range(Integer(exp) + 1):
            M = M + (k * ((k - 1) ^ i));
        M = M + 1;
    else:
        exp = (g - 2)/2;
        for i in range(Integer(exp) + 1):
            M = M + ((k - 1) ^ i);
        M = 2 * M;
    return M;

print("M(3,5) = {}".format(calculateMooreBound(3,5)));
print("M(3,6) = {}".format(calculateMooreBound(3,6)));
print("M(3,7) = {}".format(calculateMooreBound(3,7)));
print("M(3,8) = {}".format(calculateMooreBound(3,8)));
print("M(3,10) = {}".format(calculateMooreBound(3,10)));
print("M(3,11) = {}".format(calculateMooreBound(3,11)));
print("M(3,14) = {}".format(calculateMooreBound(3,14)));
print("M(3,16) = {}".format(calculateMooreBound(3,16)));
print("M(3,17) = {}".format(calculateMooreBound(3,17)));
print("M(3,18) = {}".format(calculateMooreBound(3,18)));
print("M(3,20) = {}".format(calculateMooreBound(3,20)));
print("M(3,23) = {}".format(calculateMooreBound(3,23)));
print("M(3,25) = {}".format(calculateMooreBound(3,25)));
print("M(4,5) = {}".format(calculateMooreBound(4,5)));
print("M(4,7) = {}".format(calculateMooreBound(4,7)));
print("M(4,9) = {}".format(calculateMooreBound(4,9)));
print("M(4,10) = {}".format(calculateMooreBound(4,10)));
print("M(5,10) = {}".format(calculateMooreBound(5,10)));
print("M(6,4) = {}".format(calculateMooreBound(6,4)));
print("M(7,5) = {}".format(calculateMooreBound(7,5)));
print("M(7,7) = {}".format(calculateMooreBound(7,7)));
print("M(7,8) = {}".format(calculateMooreBound(7,8)));
print("M(10,5) = {}".format(calculateMooreBound(10,5)));
print("M(11,5) = {}".format(calculateMooreBound(11,5)));
print("M(12,5) = {}".format(calculateMooreBound(12,5)));
print("M(13,5) = {}".format(calculateMooreBound(13,5)));
︡94e00367-011c-4958-bb7e-ef90d8680676︡{"stdout":"M(3,5) = 10\n"}︡{"stdout":"M(3,6) = 14\n"}︡{"stdout":"M(3,7) = 22\n"}︡{"stdout":"M(3,8) = 30\n"}︡{"stdout":"M(3,10) = 62\n"}︡{"stdout":"M(3,11) = 94\n"}︡{"stdout":"M(3,14) = 254\n"}︡{"stdout":"M(3,16) = 510\n"}︡{"stdout":"M(3,17) = 766\n"}︡{"stdout":"M(3,18) = 1022\n"}︡{"stdout":"M(3,20) = 2046\n"}︡{"stdout":"M(3,23) = 6142\n"}︡{"stdout":"M(3,25) = 12286\n"}︡{"stdout":"M(4,5) = 17\n"}︡{"stdout":"M(4,7) = 53\n"}︡{"stdout":"M(4,9) = 161\n"}︡{"stdout":"M(4,10) = 242\n"}︡{"stdout":"M(5,10) = 682\n"}︡{"stdout":"M(6,4) = 12\n"}︡{"stdout":"M(7,5) = 50\n"}︡{"stdout":"M(7,7) = 302\n"}︡{"stdout":"M(7,8) = 518\n"}︡{"stdout":"M(10,5) = 101\n"}︡{"stdout":"M(11,5) = 122\n"}︡{"stdout":"M(12,5) = 145\n"}︡{"stdout":"M(13,5) = 170\n"}︡{"done":true}









