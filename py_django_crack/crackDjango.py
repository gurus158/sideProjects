import hashlib,sys
from django_hash import give_back_hashed
from django_hash import get_base64_hashed
#hash="pbkdf2_sha256$150000$Nsq493MomueM$KLHLpVthdeCQGsvsmM6HyjQCB5H4b/1+yU3rMYDVxPE="
#hash="pbkdf2_sha256$180000$r1F7TAWRokNn$VhgNiByizKlGmDLla5J5DA4YKRZc4s5ZHjmr8dhASDw="
hash=sys.argv[1]
sh=hash.split("$")
iter=sh[1]
salt=sh[2]
sec=sh[3]
#f=open('/usr/share/wordlists/fasttrack.txt','r')
f=open('dict.txt','r')
for p in f:
  print('trying password : ',p.replace('\n',''))
  sys.stdout.write("\033[F")
  sys.stdout.write("\033[K")
  p=p.replace('\n','')
  b=get_base64_hashed(p, iter, salt, hashlib.sha256)
  if give_back_hashed(b)==give_back_hashed(sec):
    print("password found",p)
    exit()

