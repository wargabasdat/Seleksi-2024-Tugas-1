import json
import datetime
from dataProcessing import *
from scraper import scrape_player_data
from datastoring import *

def main():
    data = scrape_player_data()

    data = normalize_unicode(data)

    dropAllRows()

    player_data = process_player_info(data)
    insert_player(player_data)

    contract_data = process_current_contract(data)
    insert_player_club(contract_data)

    award_data, player_award_data = process_player_awards(data)
    insert_award(award_data)
    insert_player_award(player_award_data)

    value_data = process_player_value(data)
    insert_player_value(value_data)

    field_player_data, goalkeeper_data = process_player_stats(data)
    insert_field_stats(field_player_data)
    insert_goalkeeper_stats(goalkeeper_data)

    transfer_data = process_player_transfer(data)
    insert_transfer(transfer_data)


    # Write the batch logs
    file = open(r'updates.txt', 'a')
    file.write(f'{datetime.datetime.now()} - SCRAPE AND UPDATE COMPLETED\n')
    file.close()


if __name__ == "__main__":
    main()
