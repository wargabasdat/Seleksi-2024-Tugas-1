from database import create_database, create_tables
from player import scrape_ranking_data
from rank import scrape_rank_data
from stats import scrape_main_link
from tournament import scrape_list
from jsonfile import save_to_json

# run database.py
create_database()
create_tables()
print("Database created")

# run player.py
player_atp = scrape_ranking_data("https://www.espn.com/tennis/rankings")
player_wta = scrape_ranking_data("https://www.espn.com/tennis/rankings/_/type/wta")

save_to_json(player_atp + player_wta, 'players.json')
print("Player scraped")

# run rank.py
rank_atp = scrape_rank_data("https://www.espn.com/tennis/rankings", "ATP")
rank_wta = scrape_rank_data("https://www.espn.com/tennis/rankings/_/type/wta", "WTA")

save_to_json(rank_atp + rank_wta, 'ranks.json')
print("Rank scraped")

# run stats.py
stats_atp = scrape_main_link("https://www.espn.com/tennis/rankings")
stats_wta = scrape_main_link("https://www.espn.com/tennis/rankings/_/type/wta")

save_to_json(stats_atp + stats_wta, 'stats.json')
print("Stats scraped")

# run tournament.py
tournament_atp = scrape_list("https://www.espn.com/tennis/rankings")
tournament_wta = scrape_list("https://www.espn.com/tennis/rankings/_/type/wta")

save_to_json(tournament_atp + tournament_wta, 'tournament.json')
print("Tournament scraped")