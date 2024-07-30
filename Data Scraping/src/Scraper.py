from bs4 import BeautifulSoup
from urllib.request import urlopen
import Util
import json
url = "https://en.wikipedia.org/wiki/List_of_The_Amazing_World_of_Gumball_episodes"
page = urlopen(url)
html = page.read().decode("utf-8")
soup = BeautifulSoup(html, "html.parser")
tables = soup.find_all("table")
headers_prologue = [" " for i in range(9)]
headers_prologue[0] = "EpisodeNumberOverall"
headers_prologue[1] = "EpisodeNumberInSeason"
headers_prologue[2] = "Title"
headers_prologue[3] = "Director"
headers_prologue[4] = "Writers"
headers_prologue[5] = "Storyboarders"
headers_prologue[6] = "OriginalAirDate"
headers_prologue[7] = "ProductionCode"
headers_prologue[8] = "USViewersInMillions"
episode_tracker = 1
liste_tracker = []
temp_liste = []
complete_liste = []
season_tracker = []
for i in range(len(tables)):
    episodes = tables[i].find_all("td")
    for j in range(len(episodes)):
        liste_tracker.append(episodes[j].get_text())
    temp_liste.append(liste_tracker)
    liste_tracker = []
prologue = Util.fixPrologue(temp_liste[1])
complete_liste.append([prologue])
for i in range(2,5):
    season_tracker,episode_tracker = Util.fixList(temp_liste[i],len(headers_prologue),episode_tracker)
    complete_liste.append(season_tracker)
season_tracker,episode_tracker = Util.fixListUK4(temp_liste[5],len(headers_prologue)+1,episode_tracker)
complete_liste.append(season_tracker)
season_tracker,episode_tracker = Util.fixListUK(temp_liste[6],len(headers_prologue)+1,episode_tracker)
complete_liste.append(season_tracker)
season_tracker,episode_tracker = Util.fixListHoled(temp_liste[7],len(headers_prologue),episode_tracker)
complete_liste.append(season_tracker)
darwin_special,episode_tracker = Util.fixDarwinSpecial(temp_liste[8],6,episode_tracker)
gumball_chronicles, episode_tracker = Util.fixGumballChronicles(temp_liste[9],8,episode_tracker)
prologue_season = temp_liste[0][0]
rest_season = temp_liste[0][1:]
season_overview = Util.fixSeasonOverview(rest_season,prologue_season,3)
complete_liste.append(darwin_special)
complete_liste.append(gumball_chronicles)
seasons = Util.createSeasons(season_overview,complete_liste,headers_prologue)
show = Util.createShow(seasons)
json_object = json.dumps(show,indent=4,ensure_ascii=False)

with open("../data/gumball.json", "w") as outfile:
    outfile.write(json_object)