import json
import subprocess

def load_db_config(config_file='dbconfig.json'):
    with open(config_file) as file:
        return json.load(file)

def run_script(curr, config):
    try:
        print(f"Running {curr}")
        subprocess.run(['python', curr, json.dumps(config)], check=True)
        print(f"{curr} completed.")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred in {curr} --- {e}")

def main():
    config = load_db_config()

    # Load has to be in this order
    scripts = [
        'BossesConvert.py',
        'LocationsConvert.py',
        'BossLocationConvert.py',
        'SoulItemsConvert.py',
        'WeaponsConvert.py',
        'RingsConvert.py',
        'RingsLocationConvert.py',
        'VendorsConvert.py',
        'MagicConvert.py',
        'MiraclesConvert.py',
        'PyromanciesConvert.py',
        'SorceriesConvert.py',
        'VendorMagicConvert.py',
        'VendorRingsConvert.py'
    ]

    for script in scripts:
        run_script(script, config)

if __name__ == "__main__":
    main()
