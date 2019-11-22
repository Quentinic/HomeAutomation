mport miio

#wifi plug
#ip='192.168.xxx.yyy'
#token='000000000000000000000000' # device token

#ir remote
#ip='192.168.xxx.zzz'
#token='ffffffffffffffffffffff'

#ac partner
ip='192.168.xxx.zzz'
token='00000000000fffffffffffff'

s = miio.device.Device(ip=ip, token=token)
print(s.info())
