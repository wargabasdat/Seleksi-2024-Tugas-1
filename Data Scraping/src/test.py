import mysql.connector
config = {
    'user': 'root',
    'password': 'password',
    'host': 'localhost',
    'database': 'airline'
    }

def init_database():
    '''
    Query to create database if not exists
    '''
    try:
        connection = mysql.connector.connect(
            host=config['host'],
            user=config['user'],
            password=config['password']
        )
        cursor = connection.cursor()

        # Check if database exists
        cursor.execute(f"SHOW DATABASES LIKE '{config['database']}';")
        result = cursor.fetchone()

        if result:
            print(f"Database '{config['database']}' already exists. Skipping schema creation.")
        else:
            # Create the database
            cursor.execute(f"CREATE DATABASE {config['database']};")
            connection.database = config['database']
            print(f"Database '{config['database']}' created successfully.")
            create_schema()
        
        cursor.close()
        connection.close()
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        exit(1)


def create_schema():
    '''
    Query to create database table if not exist yet
    '''
    try:
        connection = mysql.connector.connect(**config)
        cursor = connection.cursor()

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS Airline (
                airline_id INT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255) NOT NULL,
                star INT
            );
        ''')

        connection.commit()
        cursor.close()
        connection.close()
        print("\nSchema created successfully.\n")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
# init_database()
a = None
value = None
try:
    a = value.get_text()
except:
    pass
print(a)