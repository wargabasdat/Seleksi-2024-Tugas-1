import json
import mysql.connector

with open('Data Scraping/data/processed_billionaires.json') as file:
    data = json.load(file)

def generate_insert_query_company(table, data):
    values_list = []
    count = 1

    for row in data:
        company = row.get("company", "")
        if ("'" in company):
            company = company.replace("'", " ")

        net_worth = row.get("net_worth", 0.0)

        values = f"({count}, '{company}', {net_worth}, {count})"
        values_list.append(values)
        count+=1
    
    values_str = ", ".join(values_list)
    query = f'INSERT INTO {table} (company_id, company_name, net_worth, industry_id) VALUES {values_str};'
    return query

query_company = generate_insert_query_company("company", data)

def generate_insert_query_country(table, data):
    values_list = []
    count = 1

    for row in data:
        value = row["country"]
        if ("'" in value):
            value = value.replace("'", " ")
        values_list.append(f"({count}, '{value}')")
        count+=1
    
    values_str = ", ".join(values_list)
    query = f'INSERT INTO {table} (country_id, country_name) VALUES {values_str};'
    return query

query_country = generate_insert_query_country("country", data)

def generate_insert_query_executive_name(table, data):
    values_list = []
    count = 1

    for row in data:
        value = row["executive_name"]
        if ("'" in value):
            value = value.replace("'", " ")
        values_list.append(f"({count}, '{value}', 'CEO', {count})")
        count+=1
    
    values_str = ", ".join(values_list)
    query = f"INSERT INTO {table} (employee_id, employee_name, position, company_id) VALUES {values_str};"
    return query

query_employee = generate_insert_query_executive_name("employee", data)

def generate_insert_query_industry(table, data):
    values_list = []
    count = 1

    for row in data:
        values_list.append(f"({count})")
        count+=1
    
    values_str = ", ".join(values_list)
    query = f"INSERT INTO {table} (industry_id) VALUES {values_str};"
    return query

query_industry = generate_insert_query_industry("industry", data)

def generate_insert_query_company_country(table, data):
    values_list = []
    count = 1

    for row in data:
        values_list.append(f"({count}, {count})")
        count+=1
    
    values_str = ", ".join(values_list)
    query = f"INSERT INTO {table} (company_id, country_id) VALUES {values_str};"
    return query

query_company_industry = generate_insert_query_company_country("company_country", data)


conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345678",
    database="richest_people"
)
cursor = conn.cursor()

cursor.execute(query_industry)
conn.commit()
cursor.execute(query_company)
conn.commit()
cursor.execute(query_employee)
conn.commit()
cursor.execute(query_country)
conn.commit()
cursor.execute(query_company_industry)
conn.commit()


cursor.close()
conn.close()