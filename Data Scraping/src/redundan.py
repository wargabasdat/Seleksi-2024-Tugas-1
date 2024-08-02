import json

def interrFile():
    # Membaca file JSON untuk data_a
    path_disk = r"C:\Users\Jihan Aurelia\Documents\LabBasdat\Scrapping\Data Scraping\data\diskon_prod.json"
    with open(path_disk, 'r') as file:
        data_a = json.load(file)

    # Membaca file JSON untuk data_b
    path_prod = r"C:\Users\Jihan Aurelia\Documents\LabBasdat\Scrapping\Data Scraping\data\produk.json"
    with open(path_prod, 'r') as file:
        data_b = json.load(file)

    # Membuat set untuk menyimpan id dari data_a
    ids_a = set(item.get('ID_prod') for item in data_a)

    # Memfilter data_b untuk menghapus item yang memiliki id yang sama dengan data_a
    filtered_data_b = [item for item in data_b if item.get('ID_prod') not in ids_a]

    # Menulis data b yang telah difilter ke file JSON baru
    output_path = r"C:\Users\Jihan Aurelia\Documents\LabBasdat\Scrapping\Data Scraping\data\b_filtered.json"
    with open(output_path, 'w') as file:
        json.dump(filtered_data_b, file, indent=4)

    print("Data dengan id yang sama telah dihapus dari file b. Hasil disimpan ke 'prod.json'.")


def IntraFile():
    # Membaca file JSON untuk data_a
    path_disk = r"C:\Users\Jihan Aurelia\Documents\LabBasdat\Scrapping\Data Scraping\data\normal_prod.json"
    with open(path_disk, 'r') as file:
        data_a = json.load(file)

    # Menyimpan item yang unik dan duplikat
    unique_items = set()
    filtered_data = []

    for item in data_a:
        item_key = json.dumps(item, sort_keys=True)  # Mengubah dict menjadi string untuk perbandingan
        if item_key not in unique_items:
            unique_items.add(item_key)
            filtered_data.append(item)

    # Menulis kembali data yang telah difilter ke file JSON
    with open('data_filtered.json', 'w') as file:
        json.dump(filtered_data, file, indent=4)

    print("Duplikat telah dihapus. Data yang telah difilter disimpan ke 'data_filtered.json'.")
