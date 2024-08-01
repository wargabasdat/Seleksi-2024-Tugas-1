import os
import json
import pandas as pd

def json_to_csv(json_file_name):
    # Define the paths
    src_dir = os.path.dirname(os.path.abspath(__file__))
    data_dir = os.path.join(os.path.dirname(src_dir), 'data')
    json_file_path = os.path.join(data_dir, json_file_name + '.json')
    csv_file_path = os.path.join(data_dir, json_file_name + '.csv')
    
    # Check if the JSON file exists
    if not os.path.exists(json_file_path):
        print(f"Error: The file {json_file_path} does not exist.")
        return

    # Read the JSON file
    with open(json_file_path, 'r') as json_file:
        data = json.load(json_file)

    # Normalize the JSON data
    try:
        df = pd.json_normalize(data)
    except Exception as e:
        print(f"Error while normalizing JSON data: {e}")
        return
    
    # Save the DataFrame to a CSV file
    df.to_csv(csv_file_path, index=False)
    print(f"Successfully converted {json_file_path} to {csv_file_path}")

def main():
    json_file_name = input("Enter the name of the JSON file (without the .json extension): ")
    json_to_csv(json_file_name)

if __name__ == "__main__":
    main()
