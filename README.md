Nama: Yusuf Ardian Sandi

NIM: 13522015

## Deskripsi Singkat

Data yang saya pilih untuk dilakukan scraping ialah data spesifikasi mobile phone yang berada di GSmarena. Data yang diambil ialah mobile phone yang telah rilis setelah tahun 2020. Topik ini awalnya saya pilih karena penasaran dengan perbandingan perbandingan data mobile phone dari tahun ke tahun maupun perbandingan antar brand nya.

## Cara Menggunakan Scrapper

Pada folder "Data Scraping/data" terdapat file brand_links1.txt dan brand_links2.txt. Namun, kemungkinan terdapat suatu bug pada web sehingga satu link pada brand_links2.txt tidak dapat di scrap. Sehingga anda perlu memastikan bahwa file txt yang dibaca pada file main.py adalah brand_links1.txt. 

Setelah itu, anda bisa langsung menjalankan file main.py.

```
py main.py
```

Output dari main.py adalah phones_data.json, dimensions.json, dan resolutions.json. Ketiga file json itu mewakili satu tabel pada rancangan skema yang dibuat sesuai namanya.

## Penjelasan Struktur File JSON

Pada file phones_data.json
name: Nama mobile phone
brand: Nama merk
battery: daya battery dalam mAh
storage: penyimpanan phone dalam GB
ram: RAM phone dalam GB
weight: berat phone dalam gram
release: tanggal rilis
os: OS phone
nfc: kemampuan NFC phone (yes or no)
display_size: ukuran phone dalam inch
price: harga

Pada file dimensions.json
height: panjang phone dalam mm
width: lebar phone dalam mm
depth: ketebalan phone dalam mm

Pada file resolutions.json
width: resolusi lebar pixel
height: resolusi panjang pixel

## Struktur ERD dan diagram RM




## Penjelasan mengenai proses translasi ERD

hubungan have dimension ialah one to many sehingga name pada dimension akan merujuk ke name di tabel phones. hubungan have resolution ialah one to many sehingga name pada tabel resolutions juga akan merujuk ke name di tabel phones. Namun, hubungan own ini memiliki relasi many to many sehingga perlu dibuat tabel perantara yang saling berhubungan sedemikian rupa pada gambar.


## Referensi
- https://www.gsmarena.com/
- lib BeautifulSoup4
- lib requests
- lib traceback