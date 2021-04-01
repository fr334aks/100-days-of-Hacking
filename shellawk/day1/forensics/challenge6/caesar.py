#!/usr/bin/python3
def encoder(plain_text):
    cipher_text = ''
    shift = 4
    for i in range(0, len(plain_text)):
        ascii_num = ord(plain_text[i])
        if(ascii_num >=97 and ascii_num <= 122):
            cipher_char = ascii_num + shift
            if(cipher_char > 122):
                cipher_char -= 26
            elif(cipher_char < 97):
                cipher_char += 26
            else:
                pass;
            
            cipher_text += chr(cipher_char)
        else:
            cipher_text += ' '

    return cipher_text

print(encoder('i love shakespeare'))