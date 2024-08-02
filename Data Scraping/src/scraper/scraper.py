import subprocess

def run_script(script_name):
    try:
        print(f"Running {script_name}")
        subprocess.run(['python', script_name], check=True)
        print(f"{script_name} completed.")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred in {script_name} --- {e}")

def main():
    scripts = [
        'Bosses.py',
        'Miracles.py',
        'Pyromancies.py',
        'Rings.py',
        'Shields.py',
        'Sorceries.py',
        'SoulItems.py',
        'Weapons.py'
    ]

    for script in scripts:
        run_script(script)

if __name__ == "__main__":
    main()
