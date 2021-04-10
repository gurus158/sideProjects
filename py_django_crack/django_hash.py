import os
os.path.basename(os.path.dirname(os.path.realpath(__file__)))

import hashlib
import hmac
# for python3.x
from promise import Promise

import six
import operator
import struct
import binascii
import base64
import functools




def _bin_to_long(x):
    
    return int(binascii.hexlify(x), 16)


def _long_to_bin(x, hex_format_string):
    
    return binascii.unhexlify((hex_format_string % x).encode('ascii'))


def force_bytes(s, encoding='utf-8', strings_only=False, errors='strict'):
    
    if isinstance(s, bytes):
        if encoding == 'utf-8':
            return s
        else:
            return s.decode('utf-8', errors).encode(encoding, errors)
    if strings_only and (s is None or isinstance(s, int)):
        return s
    if isinstance(s, Promise):
        return six.text_type(s).encode(encoding, errors)
    if not isinstance(s, six.string_types):
        try:
            if six.PY3:
                return six.text_type(s).encode(encoding)
            else:
                return bytes(s)
        except UnicodeEncodeError:
            if isinstance(s, Exception):
               
                return b' '.join([force_bytes(arg, encoding, strings_only,
                        errors) for arg in s])
            return six.text_type(s).encode(encoding, errors)
    else:
        return s.encode(encoding, errors)


def pbkdf2(password, iterations, salt, dklen=0, digest=None):
    
    #print((iterations))
    assert int(iterations) > 0
    if not digest:
        digest = hashlib.sha256
    password = force_bytes(password)
    salt = force_bytes(salt)
    hlen = digest().digest_size
    if not dklen:
        dklen = hlen
    if dklen > (2 ** 32 - 1) * hlen:
        raise OverflowError('dklen too big')
    l = -(-dklen // hlen)
    r = dklen - (l - 1) * hlen

    hex_format_string = "%%0%ix" % (hlen * 2)

    inner, outer = digest(), digest()
    if len(password) > inner.block_size:
        password = digest(password).digest()
    password += b'\x00' * (inner.block_size - len(password))
    inner.update(password.translate(hmac.trans_36))
    outer.update(password.translate(hmac.trans_5C))

    def F(i):
        def U():
            u = salt + struct.pack(b'>I', i)
            for j in range(int(iterations)):
                dig1, dig2 = inner.copy(), outer.copy()
                dig1.update(u)
                dig2.update(dig1.digest())
                u = dig2.digest()
                yield _bin_to_long(u)
        return _long_to_bin(functools.reduce(operator.xor, U()), hex_format_string)

    T = [F(x) for x in range(1, l + 1)]
    return b''.join(T[:-1]) + T[-1][:r]




def get_base64_hashed(password, salt, iterations, dklen=0, digest=None):
    gotten = pbkdf2(password, salt, iterations, dklen=0, digest=None)
    gotten = base64.b64encode(gotten).decode('ascii').strip()
    return gotten


def give_back_hashed(base64string):
    '''
    '''
    return base64.b64decode(base64string)
