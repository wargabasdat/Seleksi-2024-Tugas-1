from datetime import datetime
import re

match = re.search(r'(\d+)\s*TB', '1 TB RAM')

print(match.group(0)) if match else print("No match")