import pandas as pd
import plotly.express as px
from dash import Dash, dcc, html
from dash.dependencies import Input, Output
import os

# Directory to save the JSON file
json_save_directory = r'C:\Users\USER\OneDrive\Documents\GitHub\Seleksi-2024-Tugas-1\Data Scraping\data'
json_file_name = 'top100mlbprospects.json'

# Full path for the JSON file
json_file_path = os.path.join(json_save_directory, json_file_name)

# Load the data
data = pd.read_json(json_file_path).T

# Initialize the Dash app
app = Dash(__name__)
server = app.server

# Set custom CSS styles for the UI
app.css.append_css({
    'external_url': 'https://codepen.io/chriddyp/pen/bWLwgP.css'
})

app.layout = html.Div([
    html.H1("Top 100 MLB Prospects Dashboard", style={'textAlign': 'center', 'fontFamily': 'Arial, sans-serif', 'color': '#002D72'}),

    html.Div([
        html.Label("Select Position:", style={'fontFamily': 'Arial, sans-serif', 'color': '#002D72'}),
        dcc.Dropdown(
            id='position-dropdown',
            options=[{'label': 'All', 'value': 'All'}] +
                    [{'label': pos, 'value': pos} for pos in data['Position'].unique()],
            value='All'
        )
    ], style={'width': '50%', 'margin': 'auto'}),

    dcc.Graph(id='age-distribution'),
    dcc.Graph(id='height-weight-scatter'),
    dcc.Graph(id='team-distribution'),
    dcc.Graph(id='level-distribution-pie'),
])

@app.callback(
    [Output('age-distribution', 'figure'),
     Output('height-weight-scatter', 'figure'),
     Output('team-distribution', 'figure'),
     Output('level-distribution-pie', 'figure')],
    [Input('position-dropdown', 'value')]
)
def update_graphs(selected_position):
    if selected_position == 'All':
        filtered_data = data
    else:
        filtered_data = data[data['Position'] == selected_position]

    # Age distribution histogram with sorted x-axis
    age_fig = px.histogram(filtered_data, x='Age', title='Age Distribution',
                           category_orders={'Age': sorted(filtered_data['Age'].unique())},
                           color_discrete_sequence=['#002D72'])

    # Height vs Weight scatter plot
    height_weight_fig = px.scatter(filtered_data, x='Height (cm)', y='Weight (kg)',
                                    hover_data=['Player'], title='Height vs Weight',
                                    color_discrete_sequence=['#002D72'])

    # Team distribution bar chart
    team_counts = filtered_data['Team'].value_counts().reset_index()
    team_counts.columns = ['Team', 'Count']  # Renaming columns for clarity
    team_fig = px.bar(team_counts, x='Team', y='Count', title='Team Distribution',
                      color_discrete_sequence=['#002D72'])

    # Level distribution pie chart
    level_counts = filtered_data['Level'].value_counts().reset_index()
    level_counts.columns = ['Level', 'Count']  # Renaming columns for clarity
    level_pie_fig = px.pie(level_counts, names='Level', values='Count', title='Level Distribution',
                           color_discrete_sequence=['#002D72'])

    return age_fig, height_weight_fig, team_fig, level_pie_fig

if __name__ == '__main__':
    app.run_server(debug=True)
