import os
mac = ""
m0 = 0
m1 = 0
m2 = 0
m3 = 0
m4 = 0
m5 = 0

while m2 != 256 :
    mac = ""
    m0 +=1
    if m0 == 256:
        m1 +=1
        m0 = 0
        if m1 == 256:
            m2 +=1
            m1 = 0
            if m2 == 256:
                m3 +=1
                m2 = 0
                if m3 == 256:
                    m4 +=1
                    m3 = 0
                    if m4 == 256:
                        m5 +=1
                        m4 = 0
    if m5 < 16:
        mac += '0' + str(hex(m5))[2:] + ':'
    else:
        mac += str(hex(m5))[2:] + ':'
    if m4 < 16:
        mac += '0' + str(hex(m4))[2:] + ':'
    else:
        mac += str(hex(m4))[2:] + ':'
    if m3 < 16:
        mac += '0' + str(hex(m3))[2:] + ':'
    else:
        mac += str(hex(m3))[2:] + ':'
    if m2 < 16:
        mac += '0' + str(hex(m2))[2:] + ':'
    else:
        mac += str(hex(m2))[2:] + ':'
    if m1 < 16:
        mac += '0' + str(hex(m1))[2:] + ':'
    else:
        mac += str(hex(m1))[2:] + ':'
    if m0 < 16:
        mac += '0' + str(hex(m0))[2:]
    else:
        mac += str(hex(m0))[2:]
    print(mac + "\n")
    os.system("l2ping "+mac)