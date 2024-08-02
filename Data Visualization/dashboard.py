import pymysql
import dash
from dash import dcc, html, Input, Output, State
import pandas as pd
import plotly.express as px

db_host = 'your_host'
db_user = 'your_username'
db_password = 'your_password'
db_name = 'your_database'

app = dash.Dash(__name__)

config = {
    'host': db_host,
    'user': db_user,
    'password': db_password,
    'database': db_name,
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}

def fetch_restaurants_by_country(keyword, config):
    connection = pymysql.connect(**config)
    cursor = connection.cursor()

    query = """
    SELECT Nama, Alamat
    FROM Restaurant
    WHERE Alamat LIKE %s
    """
    
    try:
        cursor.execute(query, ('%' + keyword + '%',))
        results = cursor.fetchall()
        df = pd.DataFrame(results)
        return df
    
    except Exception as e:
        print("An error occurred:", e)
        return None
    
    finally:
        cursor.close()
        connection.close()

app.layout = html.Div([
    html.H1("Restaurant Dashboard", style={'textAlign': 'center'}),

    html.Div([
        html.Label("Search Country:"),
        dcc.Input(id='country-input', type='text', placeholder='Enter country name', style={'width': '50%'}),
        html.Button('Search', id='search-button', n_clicks=0, style={'marginLeft': '10px'})
    ], style={'padding': '20px', 'textAlign': 'center'}),

    dcc.Graph(id='restaurant-graph')
])

@app.callback(
    Output('restaurant-graph', 'figure'),
    [Input('search-button', 'n_clicks')],
    [State('country-input', 'value')]
)
def update_graph(n_clicks, country_name):
    if n_clicks > 0 and country_name:
        df = fetch_restaurants_by_country(country_name, config)
        if df.empty:
            return px.bar(title=f"No restaurants found in {country_name}")
        
        fig = px.bar(df, x='Nama', y='Alamat', title=f"Restaurants in {country_name}",
                     labels={'Nama': 'Restaurant Name', 'Alamat': 'Full Address'})
        return fig
    return px.bar(title="Enter a country name and click search")

if __name__ == '__main__':
    app.run_server(debug=True)
