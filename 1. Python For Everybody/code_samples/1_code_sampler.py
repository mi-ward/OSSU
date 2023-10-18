import urllib.request
import subprocess
from bs4 import BeautifulSoup

url = 'https://www.py4e.com/code3/'



# print(res.read().decode())

headers =   {
                'User-Agent': 
                    '''Mozilla/5.0 (Windows NT 10.0; Win64; x64) 
                        AppleWebKit/537.36 (KHTML, like Gecko) 
                        Chrome/83.0.4103.61 
                        Safari/537.36'''
            }
req = urllib.request.Request(url,headers=headers)

resp = urllib.request.urlopen(req)
html = resp.read().decode()

soup = BeautifulSoup(html, 'html.parser')

aaas = soup.find_all('a')

for i in range(5, len(aaas)):
    x = aaas[i].get('href')
    subprocess.run(['curl', url+x, '--output', x ])