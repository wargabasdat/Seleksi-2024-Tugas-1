import os
import psycopg2
from psycopg2 import sql
from dotenv import load_dotenv

db_params = {
    'dbname': os.getenv("DB_NAME"),
    'user': os.getenv("DB_USER"),
    'password': os.getenv("DB_PW"),
    'host': os.getenv("DB_HOST"),
    'port': os.getenv("DB_PORT")
}

def insertData(query, data):
    conn = psycopg2.connect(**db_params)
    cursor = conn.cursor()
    try:
        cursor.executemany(query, data)
        conn.commit()
        print("Batch insert completed successfully.")
    except Exception as e:
        conn.rollback()
        print(f"Error during batch insert: {e}")
    finally:
        cursor.close()
        conn.close()


def insert_player(player_data):
    player_query = """
        INSERT INTO player (player_id, name, birth_date, number, birth_place, height, nationality, position, preferred_foot, player_agent, outfitter)
        OVERRIDING SYSTEM VALUE
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    insert_data = [(player['player_id'], player['name'], player['birth_date'], player['player_number'], player['birth_place'], player['height'], player['nationality'], player['position'], player['preffered_foot'], player['player_agent'], player['outfitter']) for player in player_data]

    insertData(player_query, insert_data)


def insert_player_club(contract_data):
    player_club_query = """
        INSERT INTO contract (contract_id, player_id, club, joined_date, contract_expired)
        OVERRIDING SYSTEM VALUE
        VALUES (%s, %s, %s, %s, %s)
    """

    insert_data = [(contract['contract_id'], contract['player_id'], contract['current_club'], contract['date_joined'], contract['contract_expired']) for contract in contract_data]

    insertData(player_club_query, insert_data)


def insert_transfer(transfer_data):
    transfer_query = """
        INSERT INTO transfer (transfer_id, transfer_date, from_club, to_club, market_value, fee, is_loan, player_id)
        OVERRIDING SYSTEM VALUE
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """

    insert_data = [(transfer['transfer_id'], transfer['transfer_date'], transfer['club_left'], transfer['club_joined'], transfer['market_value'], transfer['fee'], transfer['is_loan'], transfer['player_id']) for transfer in transfer_data]

    insertData(transfer_query, insert_data)


def insert_award(award_data):
    award_query = """
        INSERT INTO award (award_id, name, organizer)
        OVERRIDING SYSTEM VALUE
        VALUES (%s, %s, %s)
    """

    insert_data = [(award['award_id'], award['name'], award['organizer']) for award in award_data]

    insertData(award_query, insert_data)


def insert_player_award(player_award_data):
    player_award_query = """
        INSERT INTO player_award (player_id, award_id, year)
        OVERRIDING SYSTEM VALUE
        VALUES (%s, %s, %s)
    """

    insert_data = [(player_award['player_id'], player_award['award_id'], player_award['year']) for player_award in player_award_data]

    insertData(player_award_query, insert_data)


def insert_field_stats(fieldplayer_stats_data):
    field_player_query = """
        INSERT INTO field_player_stats (stats_id, season, match_played, minutes_played, player_id, goals, assists)
        OVERRIDING SYSTEM VALUE
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """

    insert_data = [(fps['stats_id'], fps['season'], fps['match_played'], fps['minutes_played'], fps['player_id'], fps['goals'], fps['assists']) 
                for fps in fieldplayer_stats_data]
    
    insertData(field_player_query, insert_data)


def insert_goalkeeper_stats(goalkeeper_stats_data):
    goalkeeper_query = """
        INSERT INTO goalkeeper_stats (stats_id, season, match_played, minutes_played, player_id, goals_conceded, clean_sheets)
        OVERRIDING SYSTEM VALUE
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """

    insert_data = [(gks['stats_id'], gks['season'], gks['match_played'], gks['minutes_played'], gks['player_id'], gks['goals_conceded'], gks['clean_sheets']) 
                for gks in goalkeeper_stats_data]
    
    insertData(goalkeeper_query, insert_data)


def insert_player_value(playervalue_data):
    playervalue_query = """
        INSERT INTO player_value (value_id, player_id, market_value, update_date)
        OVERRIDING SYSTEM VALUE
        VALUES (%s, %s, %s, %s)
    """

    insert_data = [(pv['value_id'], pv['player_id'], pv['market_value'], pv['update_date']) 
                for pv in playervalue_data]
    
    insertData(playervalue_query, insert_data)


def insert_club(club_data):
    club_query = """
        INSERT INTO club (club_id, name, stadium_id, value)
        OVERRIDING SYSTEM VALUE
        VALUES (%s, %s, %s, %s)
    """
    insert_data = [(club['club_id'], club['club_name'], club['stadium_id'], club['club_value']) for club in club_data]

    insertData(club_query, insert_data)


def dropAllRows():
    conn = psycopg2.connect(**db_params)
    cursor = conn.cursor()

    tables = ['award', 'contract', 'transfer', 'stats', 'field_player_stats', 'goalkeeper_stats', 'player_award', 'player_value', 'player']

    try:
        for table_name in tables:
            query = sql.SQL("DELETE FROM {} CASCADE").format(sql.Identifier(table_name))
            cursor.execute(query)
        conn.commit()
        print("Batch delete completed successfully.")
    except Exception as e:
        conn.rollback()
        print(f"Error during batch insert: {e}")
    finally:
        cursor.close()
        conn.close()