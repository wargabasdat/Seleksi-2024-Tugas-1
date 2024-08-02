import os
from dotenv import load_dotenv
import mysql.connector
import dash
from dash import dcc, html
import pandas as pd
import plotly.express as px

# Load environment variables from .env file
load_dotenv()

# Retrieve environment variables
db_host = os.getenv('DB_HOST')
db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')
db_name = os.getenv('DB_NAME')

# Create Dash app
app = dash.Dash(__name__)

# Establish database connection
def get_connection():
    return mysql.connector.connect(
        host=db_host,
        user=db_user,
        password=db_password,
        database=db_name
    )

# Initial data queries
def fetch_initial_data():
    connection = get_connection()
    queries = {
        'top_10_dramas': """
            SELECT drama_name, rating
            FROM Drama
            ORDER BY rating DESC
            LIMIT 10
        """,
        'top_5_screenwriters': """
            SELECT screenwriter_name, COUNT(drama_name) AS drama_count
            FROM Wrote
            GROUP BY screenwriter_name
            HAVING screenwriter_name != 'unknown'
            ORDER BY drama_count DESC
            LIMIT 5
        """,
        'top_5_genres': """
            SELECT genre_name, COUNT(drama_name) AS drama_count
            FROM Genre
            GROUP BY genre_name
            ORDER BY drama_count DESC
            LIMIT 5
        """,
        'top_5_directors': """
            SELECT director_name, COUNT(drama_name) AS drama_count
            FROM Directed
            GROUP BY director_name
            HAVING director_name != 'unknown'
            ORDER BY drama_count DESC
            LIMIT 5
        """,
        'all_genres': """
            SELECT DISTINCT genre_name
            FROM Genre
        """,
        'top_5_networks': """
            SELECT network_name, COUNT(drama_name) AS drama_count
            FROM Network
            GROUP BY network_name
            ORDER BY drama_count DESC
            LIMIT 5
        """
    }
    
    data = {}
    with connection.cursor(dictionary=True) as cursor:
        for key, query in queries.items():
            cursor.execute(query)
            data[key] = cursor.fetchall()
    
    connection.close()
    return data

# Fetch initial data
data = fetch_initial_data()
df_top_10_dramas = pd.DataFrame(data['top_10_dramas'])
df_top_5_screenwriters = pd.DataFrame(data['top_5_screenwriters'])
df_top_5_genres = pd.DataFrame(data['top_5_genres'])
df_top_5_directors = pd.DataFrame(data['top_5_directors'])
df_all_genres = pd.DataFrame(data['all_genres'])
df_top_5_networks = pd.DataFrame(data['top_5_networks'])

# Define app layout
app.layout = html.Div([
    html.H1("K-Drama Dashboard", style={'textAlign': 'center', 'color': '#1f77b4', 'fontFamily': 'Arial'}),

    html.Div([
        dcc.Graph(
            id='top-10-dramas',
            figure=px.bar(df_top_10_dramas, x='drama_name', y='rating',
                          title='Top 10 Highest Rated K-Dramas',
                          color='rating',
                          color_continuous_scale='Magenta', 
                          labels={'drama_name': 'Drama Name', 'rating': 'Rating'})
        ),
    ], style={'margin': '20px', 'padding': '10px', 'border': '1px solid #ddd', 'borderRadius': '5px', 'width': '100%'}),

    html.Div([
        dcc.Graph(
            id='top-5-screenwriters',
            figure=px.bar(df_top_5_screenwriters, x='screenwriter_name', y='drama_count',
                          title='Top 5 Screenwriters by Number of Dramas',
                          color='drama_count',
                          color_continuous_scale='Blues', 
                          labels={'screenwriter_name': 'Screenwriter Name', 'drama_count': 'Drama Count'})
        ),
    ], style={'margin': '20px', 'padding': '10px', 'border': '1px solid #ddd', 'borderRadius': '5px', 'width': '100%'}),

    html.Div([
        dcc.Graph(
            id='top-5-genres',
            figure=px.bar(df_top_5_genres, x='genre_name', y='drama_count',
                          title='Top 5 Genres by Number of Dramas',
                          color='drama_count',
                          color_continuous_scale='Reds',  
                          labels={'genre_name': 'Genre Name', 'drama_count': 'Drama Count'})
        ),
    ], style={'margin': '20px', 'padding': '10px', 'border': '1px solid #ddd', 'borderRadius': '5px', 'width': '100%'}),

    html.Div([
        dcc.Graph(
            id='top-5-directors',
            figure=px.bar(df_top_5_directors, x='director_name', y='drama_count',
                          title='Top 5 Directors by Number of Dramas',
                          color='drama_count',
                          color_continuous_scale='Burg',  
                          labels={'director_name': 'Director Name', 'drama_count': 'Drama Count'})
        ),
    ], style={'margin': '20px', 'padding': '10px', 'border': '1px solid #ddd', 'borderRadius': '5px', 'width': '100%'}),

    html.Div([
        dcc.Graph(
            id='top-5-networks',
            figure=px.bar(df_top_5_networks, x='network_name', y='drama_count',
                          title='Top 5 Networks by Number of Dramas',
                          color='drama_count',
                          color_continuous_scale='Blugrn',  
                          labels={'network_name': 'Network Name', 'drama_count': 'Drama Count'})
        ),
    ], style={'margin': '20px', 'padding': '10px', 'border': '1px solid #ddd', 'borderRadius': '5px', 'width': '100%'}),

    html.Div([
        html.H2("Choose your preferred genre", style={'textAlign': 'center', 'color': '#1f77b4', 'fontFamily': 'Arial'}),
        dcc.Dropdown(
            id='genre-dropdown',
            options=[{'label': genre, 'value': genre} for genre in df_all_genres['genre_name']],
            value=df_all_genres['genre_name'][0] if not df_all_genres.empty else None,  # Set default value if available
            clearable=False,
            multi=False,
            style={'width': '100%', 'margin': '0px', 'padding': '10px'}
        ),
    ], style={'display': 'flex', 'flex-direction': 'column', 'align-items': 'center', 'justify-content': 'center', 'margin': '20px', 'padding': '10px', 'text-align': 'center', 'width': '100%'}),
    
    html.Div([
        dcc.Graph(
            id='top-5-rated-dramas-by-genre'
        )
    ], style={'margin': '20px', 'padding': '10px', 'border': '1px solid #ddd', 'borderRadius': '5px', 'width': '100%'})
], style={'display': 'flex', 'flex-direction': 'column', 'align-items': 'center', 'justify-items': 'center', 'padding': '20px', 'margin': '10px'})

@app.callback(
    dash.Output('top-5-rated-dramas-by-genre', 'figure'),
    [dash.Input('genre-dropdown', 'value')]
)
def update_top_5_rated_dramas_by_genre(selected_genre):
    connection = get_connection()
    
    if not selected_genre:
        connection.close()
        return px.bar(pd.DataFrame(), x='drama_name', y='rating', title='Top 5 Rated K-Dramas by Genre')

    query_top_5_dramas_by_genre = """
    SELECT d.drama_name, d.rating
    FROM Drama d
    JOIN Genre g ON d.drama_name = g.drama_name
    WHERE g.genre_name = %s
    ORDER BY d.rating DESC
    LIMIT 5
    """
    
    with connection.cursor(dictionary=True) as cursor:
        cursor.execute(query_top_5_dramas_by_genre, (selected_genre,))
        top_5_dramas_by_genre = cursor.fetchall()
    
    connection.close()

    df_top_5_dramas_by_genre = pd.DataFrame(top_5_dramas_by_genre)
    
    if df_top_5_dramas_by_genre.empty:
        return px.bar(df_top_5_dramas_by_genre, x='drama_name', y='rating', title='Top 5 Rated K-Dramas by Genre - No Data')

    return px.bar(df_top_5_dramas_by_genre, x='drama_name', y='rating',
                  title='Top 5 Rated K-Dramas by Genre',
                  color='rating',
                  color_continuous_scale='Redor') 

if __name__ == '__main__':
    app.run_server(debug=True)
