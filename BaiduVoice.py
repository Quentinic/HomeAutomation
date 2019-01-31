#!/usr/bin/python
import os
import sys
import requests

text = str(sys.argv[1])

headers = {
  'User-Agent': 'Mozilla/5.0 (Windows NT; Win64; x64) AppleWebkit'
                '/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari'
                'i/537.36'
}

url = 'http://tts.baidu.com/text2audio?idx=1&tex={0}&cuid=baidu_speech_demo&cod=2&lan=zh&ctp=1&pdt=1&spd=4&per=4&vol=5&pit=5'.format(text)
res = requests.get(url, headers=headers)

dirname, filename = os.path.split(os.path.realpath(__file__))
mp3path = os.path.join(dirname, 'voice0.mp3')

with open(mp3path, 'wb') as f:
	f.write(res.content)

os.system('mplayer %s' % mp3path)
