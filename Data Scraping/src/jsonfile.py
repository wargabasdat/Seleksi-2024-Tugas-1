import json
import os

def save_to_json(data, filename):
    directory = '/Users/shazyataufik/Documents/Seleksi/Basdat/Stage2/Seleksi-2024-Tugas-1/Data Scraping/data' # ubah ke dir yang sesuai
    if not os.path.exists(directory):  
        os.makedirs(directory)  
    file_path = os.path.join(directory, filename)  
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)