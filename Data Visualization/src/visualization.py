import dash
from dash import dcc, html
from dash.dependencies import Input, Output
import plotly.graph_objs as go
import mysql.connector
import pandas as pd
from datetime import datetime

# connect mysql
conn = mysql.connector.connect(
    host='localhost',       
    user='root',  
    password='shzyt2929', 
    database='tennis_database'  
)

# inisialisasi app
app = dash.Dash(__name__)

# layout
app.layout = html.Div([
    html.H1("Tennis Player Analytics Dashboard"),
    dcc.Tabs(id="tabs", value='tab-1', children=[
        dcc.Tab(label='ATP Rank', value='tab-1'),
        dcc.Tab(label='WTA Rank', value='tab-2'),
        dcc.Tab(label='Win Rates', value='tab-3'),
        dcc.Tab(label='Player Ages', value='tab-4'),
        dcc.Tab(label='Player Points', value='tab-5'),
        dcc.Tab(label='Tournament Count', value='tab-6'),
        dcc.Tab(label='Historical ATP Rank', value='tab-7'),
        dcc.Tab(label='Historical WTA Rank', value='tab-8'),
    ]),
    html.Div(id='tabs-content')
])

@app.callback(Output('tabs-content', 'children'),
              Input('tabs', 'value'))
def render_content(tab):
    cursor = conn.cursor(dictionary=True)
    try:
        if tab == 'tab-1':
            query = """
            SELECT p.player_name, r.points AS atp_points
            FROM Player p
            JOIN Rank r ON p.player_id = r.player_id
            WHERE r.rank_type = 'ATP' AND r.date = (SELECT MAX(date) FROM Rank WHERE rank_type = 'ATP')
            ORDER BY r.points DESC
            LIMIT 10;
            """
            cursor.execute(query)
            result = cursor.fetchall()
            df = pd.DataFrame(result)
            fig = go.Figure(data=[
                go.Bar(x=df['player_name'], y=df['atp_points'], text=df['atp_points'], textposition='auto')
            ])
            fig.update_layout(title='Top 10 ATP Players by Points', xaxis_title='Player Name', yaxis_title='ATP Points')
            return dcc.Graph(figure=fig)
        elif tab == 'tab-2':
            query = """
            SELECT p.player_name, r.points AS wta_points
            FROM Player p
            JOIN Rank r ON p.player_id = r.player_id
            WHERE r.rank_type = 'WTA' AND r.date = (SELECT MAX(date) FROM Rank WHERE rank_type = 'WTA')
            ORDER BY r.points DESC
            LIMIT 10;
            """
            cursor.execute(query)
            result = cursor.fetchall()
            df = pd.DataFrame(result)
            fig = go.Figure(data=[
                go.Bar(x=df['player_name'], y=df['wta_points'], text=df['wta_points'], textposition='auto')
            ])
            fig.update_layout(title='Top 10 WTA Players by Points', xaxis_title='Player Name', yaxis_title='WTA Points')
            return dcc.Graph(figure=fig)
        elif tab == 'tab-3':
            query = """
            SELECT p.player_name,
                   cs.total_singles_wins,
                   cs.total_singles_losses,
                   (cs.total_singles_wins / (cs.total_singles_wins + cs.total_singles_losses)) AS win_rate
            FROM CareerStats cs
            JOIN Player p ON cs.player_id = p.player_id
            ORDER BY win_rate DESC
            LIMIT 10;
            """
            cursor.execute(query)
            result = cursor.fetchall()
            df = pd.DataFrame(result)
            df['win_rate'] = df['total_singles_wins'] / (df['total_singles_wins'] + df['total_singles_losses'])
            fig = go.Figure(data=[
                go.Bar(x=df['player_name'], y=df['win_rate'], text=df['win_rate'].round(2), textposition='auto')
            ])
            fig.update_layout(title='Top 10 Players by Win Rate', xaxis_title='Player Name', yaxis_title='Win Rate')
            return dcc.Graph(figure=fig)
        elif tab == 'tab-4':
            query = """
            SELECT player_name, birth_date FROM Player WHERE birth_date IS NOT NULL ORDER BY birth_date LIMIT 10;
            """
            cursor.execute(query)
            result = cursor.fetchall()
            df = pd.DataFrame(result)
            today = datetime.today()
            df['birth_date'] = pd.to_datetime(df['birth_date'])
            df['age'] = df['birth_date'].apply(lambda x: today.year - x.year - ((today.month, today.day) < (x.month, x.day)))
            fig = go.Figure(data=[
                go.Bar(x=df['player_name'], y=df['age'], text=df['age'], textposition='auto')
            ])
            fig.update_layout(title='Top 10 Oldest Players', xaxis_title='Player Name', yaxis_title='Age')
            return dcc.Graph(figure=fig)
        elif tab == 'tab-5':
            query = """
            SELECT p.player_name, MAX(r.points) as max_points
            FROM Player p
            JOIN Rank r ON p.player_id = r.player_id
            WHERE r.date = (SELECT MAX(date) FROM Rank)
            GROUP BY p.player_id, p.player_name
            ORDER BY max_points DESC
            LIMIT 10;
            """
            cursor.execute(query)
            result = cursor.fetchall()
            df = pd.DataFrame(result)
            fig = go.Figure(data=[
                go.Bar(x=df['player_name'], y=df['max_points'], text=df['max_points'], textposition='auto')
            ])
            fig.update_layout(title='Top 10 Players by Highest Points', xaxis_title='Player Name', yaxis_title='Points')
            return dcc.Graph(figure=fig)
        elif tab == 'tab-6':
            query = """
            SELECT p.player_name, COUNT(pt.tournament_id) as tournament_count
            FROM Player p
            JOIN PlayerTournament pt ON p.player_id = pt.player_id
            GROUP BY p.player_id, p.player_name
            ORDER BY tournament_count DESC
            LIMIT 10;
            """
            cursor.execute(query)
            result = cursor.fetchall()
            df = pd.DataFrame(result)
            fig = go.Figure(data=[
                go.Bar(x=df['player_name'], y=df['tournament_count'], text=df['tournament_count'], textposition='auto')
            ])
            fig.update_layout(title='Top 10 Players by Tournament Participation', xaxis_title='Player Name', yaxis_title='Tournament Count')
            return dcc.Graph(figure=fig)
        elif tab == 'tab-7':  # Handling the new tab for historical rank
            top_10_query = """
            SELECT r.player_id, p.player_name
            FROM Player p
            JOIN Rank r ON p.player_id = r.player_id
            WHERE r.rank_type = 'ATP' AND r.date = '2024-07-22'
            ORDER BY r.rank
            LIMIT 10;
            """
            cursor.execute(top_10_query)
            top_10_result = cursor.fetchall()
            top_10_ids = [row['player_id'] for row in top_10_result]
            top_10_names = {row['player_id']: row['player_name'] for row in top_10_result}

            historical_rank_query = f"""
            SELECT p.player_name, r.rank, r.date
            FROM Player p
            JOIN Rank r ON p.player_id = r.player_id
            WHERE r.rank_type = 'ATP' AND p.player_id IN ({','.join(map(str, top_10_ids))})
            ORDER BY p.player_name, r.date;
            """
            cursor.execute(historical_rank_query)
            historical_result = cursor.fetchall()
            df = pd.DataFrame(historical_result)
            fig = go.Figure()
            for player_id in top_10_ids:
                player_data = df[df['player_name'] == top_10_names[player_id]]
                fig.add_trace(go.Scatter(
                    x=player_data['date'],
                    y=player_data['rank'],
                    mode='lines+markers',
                    name=top_10_names[player_id]
                ))
            fig.update_layout(title='Historical Rank of Top 10 ATP Players (as of 2024-07-22)', xaxis_title='Date', yaxis_title='Rank', yaxis_autorange='reversed')
            return dcc.Graph(figure=fig)
        elif tab == 'tab-8':  # Handling the new tab for historical rank
            top_10_query = """
            SELECT r.player_id, p.player_name
            FROM Player p
            JOIN Rank r ON p.player_id = r.player_id
            WHERE r.rank_type = 'WTA' AND r.date = '2024-07-22'
            ORDER BY r.rank
            LIMIT 10;
            """
            cursor.execute(top_10_query)
            top_10_result = cursor.fetchall()
            top_10_ids = [row['player_id'] for row in top_10_result]
            top_10_names = {row['player_id']: row['player_name'] for row in top_10_result}

            historical_rank_query = f"""
            SELECT p.player_name, r.rank, r.date
            FROM Player p
            JOIN Rank r ON p.player_id = r.player_id
            WHERE r.rank_type = 'WTA' AND p.player_id IN ({','.join(map(str, top_10_ids))})
            ORDER BY p.player_name, r.date;
            """
            cursor.execute(historical_rank_query)
            historical_result = cursor.fetchall()
            df = pd.DataFrame(historical_result)
            fig = go.Figure()
            for player_id in top_10_ids:
                player_data = df[df['player_name'] == top_10_names[player_id]]
                fig.add_trace(go.Scatter(
                    x=player_data['date'],
                    y=player_data['rank'],
                    mode='lines+markers',
                    name=top_10_names[player_id]
                ))
            fig.update_layout(title='Historical Rank of Top 10 WTA Players (as of 2024-07-22)', xaxis_title='Date', yaxis_title='Rank', yaxis_autorange='reversed')
            return dcc.Graph(figure=fig)
    except mysql.connector.Error as err:
        return html.Div([html.H3(f"Error: {err}")])
    except Exception as e:
        return html.Div([html.H3(f"Error: {e}")])
    finally:
        cursor.close()

if __name__ == '__main__':
    app.run_server(debug=True)
