import os
import json
import pandas as pd
import datetime

def json_to_sql(json_folder_path):
    ordered_files = [
        'ingredients.json', 'users.json', 'recipes.json',
        'made_of.json', 'reviews.json', 'tweaks_and_questions.json'
    ]

    sqls = []
    for json_file in ordered_files:
        file_path = os.path.join(json_folder_path, json_file)
        
        if not os.path.isfile(file_path):
            print(f"{json_file} not found")
            continue
        
        try:
            with open(file_path, 'r') as f:
                data = json.load(f)
                
            if isinstance(data, list):
                df = pd.DataFrame(data)
            else:
                df = pd.DataFrame([data])
            
            for _, row in df.iterrows():
                values = []
                for value in row:
                    if pd.isna(value) or value == '' or value is None:
                        values.append('NULL')
                    else:
                        escaped_value = str(value).replace("'", "''")
                        values.append(f"'{escaped_value}'")
                
                table_name = os.path.splitext(json_file)[0]
                sql = f"INSERT INTO {table_name} ({', '.join(df.columns)}) VALUES ({', '.join(values)});"
                sqls.append(sql)
        
        except ValueError as ve:
            print(f"Error reading {json_file}: {ve}")
        except Exception as e:
            print(f"Error processing {json_file}: {e}")
    
    return sqls

def merge_table_and_data(filename):
    create_table_file = 'Data Storing/export/template_create_table.sql'
    insert_data_file = 'Data Storing/export/' + filename
    merged_file = f'Data Storing/export/food_{generate_timestamp()}.sql'

    with open(create_table_file, 'r') as file:
        create_table_sql = file.read()

    with open(insert_data_file, 'r') as file:
        insert_data_sql = file.read()

    with open(merged_file, 'w') as file:
        file.write(create_table_sql)
        file.write('\n\n') 
        file.write(insert_data_sql)

def generate_timestamp():
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%Hh%Mm%Ss") 
    return timestamp

def extract_timestamp(filename):
    filename_arr = filename.split('_')
    timestamp_str = filename_arr[2] + "_" + filename_arr[3].replace('.sql', '')
    timestamp = datetime.datetime.strptime(timestamp_str, '%Y-%m-%d_%Hh%Mm%Ss')
    print(timestamp)
    return timestamp

def find_latest_insert_data_file():
    files = [file for file in os.listdir("Data Storing/export") if file.endswith('.sql') and file.startswith("insert_data_")] 
    for file in files:
        file = extract_timestamp(file)
    return max(files)

def run_all():
    json_folder_path = 'Data Scraping/data'
    filename = f'insert_data_{generate_timestamp()}.sql'
    sqls = json_to_sql(json_folder_path)
    with open('Data Storing/export/' + filename, 'w') as sqlfile:
        sqlfile.write('\n'.join(sqls))
    merge_table_and_data(filename)

if __name__ == "__main__":
    run_all()