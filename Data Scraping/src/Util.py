def splitAndComma(string: str):
    stringChange = string.replace(" and "," ")
    stringChange = stringChange.split(", ")
    return stringChange

def splitJustAnd(string: str):
    liste = []
    if string.find(" and ") == -1 and string.find(", ") == -1:
        liste.append(string)
        return liste
    if (string.find(", ") != -1):
        string = string.replace(",and ",", ")
        return splitAndComma(string)
    string = string.replace(" and ","#")
    string = string.split("#")
    return string

def fixList (liste: list, divider: int, episode_tracker: int):
    liste_new = []
    tracker = []
    for i in range(int((len(liste))/(divider-1))):
        tracker.append(episode_tracker)
        episode_tracker += 1
        for j in range(divider-1):
            if (j == 0):
                liste[i*(divider-1)+j] = int(liste[i*(divider-1)+j])
            if (j == 3):
                liste[i*(divider-1)+j] = splitAndComma(liste[i*(divider-1)+j])
            elif (j == 4):
                liste[i*(divider-1)+j] = splitJustAnd(liste[i*(divider-1)+j])
            if (j == 5):
                stringer = liste[i*(divider-1)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '('):
                        stringer = stringer[:k-1]
                        break
                stringer = stringer.replace("\xa0"," ")
                liste[i*(divider-1)+j] = stringer
            if (j == divider-2):
                stringer = liste[i*(divider-1)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '['):
                        stringer = stringer[:k]
                        break
                liste[i*(divider-1)+j] = stringer
            tracker.append(liste[i*(divider-1)+j])
        liste_new.append(tracker)
        tracker = []
    return liste_new, episode_tracker

def fixListHoled (liste: list, divider: int, episode_tracker: int):
    liste_new = []
    tracker = []
    for i in range(int((len(liste))/(divider-1))):
        tracker.append(episode_tracker)
        episode_tracker += 1
        for j in range(divider-1):
            if (j < 2):
                tracker.append(liste[i*(divider-1)+j])
                continue
            if (j == 2):
                tracker.append("N/A")
                continue
            if (j == 3):
                liste[i*(divider-1)+j-1] = splitAndComma(liste[i*(divider-1)+j-1])
            elif (j == 4):
                liste[i*(divider-1)+j-1] = splitJustAnd(liste[i*(divider-1)+j-1])
            if (j == 5):
                stringer = liste[i*(divider-1)+j-1]
                for k in range(len(stringer)):
                    if (stringer[k] == '('):
                        stringer = stringer[:k-1]
                        break
                stringer = stringer.replace("\xa0"," ")
                liste[i*(divider-1)+j-1] = stringer
            if (j == divider-2):
                stringer = liste[i*(divider-1)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '['):
                        stringer = stringer[:k]
                        break
                liste[i*(divider-1)+j] = stringer
            if (j < 6):
                tracker.append(liste[i*(divider-1)+j-1])
            else:
                tracker.append(liste[i*(divider-1)+j])
        liste_new.append(tracker)
        tracker = []
    return liste_new, episode_tracker

def fixListUK4 (liste: list, divider: int, episode_tracker: int):
    liste_new = []
    tracker = []
    for i in range(int((len(liste))/(divider-1))):
        tracker.append(episode_tracker)
        episode_tracker += 1
        if i != 20:
            for j in range(divider-1):
                if (j == 3):
                    liste[i*(divider-1)+j] = splitAndComma(liste[i*(divider-1)+j])
                elif (j == 4):
                    liste[i*(divider-1)+j] = splitJustAnd(liste[i*(divider-1)+j])
                if (j == 5):
                    stringer = liste[i*(divider-1)+j]
                    for k in range(len(stringer)):
                        if (stringer[k] == '('):
                            stringer = stringer[:k-1]
                            break
                    stringer = stringer.replace("\xa0"," ")
                    liste[i*(divider-1)+j] = stringer
                if (j == 6):
                    continue
                if (j == divider-2):
                    stringer = liste[i*(divider-1)+j]
                    for k in range(len(stringer)):
                        if (stringer[k] == '['):
                            stringer = stringer[:k]
                            break
                    liste[i*(divider-1)+j] = stringer
                tracker.append(liste[i*(divider-1)+j])
        else:
            tracker.append(21)
            tracker.append(liste[(i-1)*(divider-1)+1])
            tracker.append(liste[(i-1)*(divider-1)+2])
            tracker.append(splitJustAnd(liste[i*(divider-1)+1]))
            tracker.append(liste[(i-1)*(divider-1)+4])
            tracker.append(liste[(i-1)*(divider-1)+5])
            tracker.append(liste[(i)*(divider-1)+2])
            tracker.append(liste[(i-1)*(divider-1)+8])
            liste_new.append(tracker)
            tracker = []
            episode_tracker += 1
            tracker.append(episode_tracker)
            tracker.append(22)
            tracker.append(liste[(i)*(divider-1)+4])
            tracker.append(liste[(i)*(divider-1)+5])
            tracker.append(splitJustAnd(liste[i*(divider-1)+6]))
            tracker.append(liste[(i)*(divider-1)+7])
            tracker.append(liste[(i)*(divider-1)+9])
            tracker.append(liste[(i)*(divider-1)+10])
            tracker.append(liste[(i-1)*(divider-1)+8])
            liste.remove("21")
            liste.remove(liste[i*(divider-1)+1])
            liste.remove(liste[i*(divider-1)+2])
        liste_new.append(tracker)
        tracker = []
    return liste_new, episode_tracker

def fixListUK (liste: list, divider: int, episode_tracker: int):
    liste_new = []
    tracker = []
    for i in range(int((len(liste))/(divider-1))):
        tracker.append(episode_tracker)
        episode_tracker += 1
        for j in range(divider-1):
            if (j == 3):
                liste[i*(divider-1)+j] = splitAndComma(liste[i*(divider-1)+j])
            elif (j == 4):
                liste[i*(divider-1)+j] = splitJustAnd(liste[i*(divider-1)+j])
            if (j == 5):
                stringer = liste[i*(divider-1)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '('):
                        stringer = stringer[:k-1]
                        break
                stringer = stringer.replace("\xa0"," ")
                liste[i*(divider-1)+j] = stringer
            if (j == 6):
                continue
            if (j == divider-2):
                stringer = liste[i*(divider-1)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '['):
                        stringer = stringer[:k]
                        break
                liste[i*(divider-1)+j] = stringer
            tracker.append(liste[i*(divider-1)+j])
        liste_new.append(tracker)
        tracker = []
    return liste_new, episode_tracker

def fixPrologue (liste: list):
    liste_new = []
    liste_new.append(0)
    liste_new.append(0)
    stringer = liste[0][1:]
    for i in range(len(stringer)):
        if (stringer[i] == '"'):
            stringer = stringer[:i]
            break
    liste[0] = stringer
    liste_new.append(liste[0])
    liste_new.append("N/A")
    liste_new.append(liste[1])
    liste_new.append(liste[2])
    stringer = liste[3]
    for i in range(len(stringer)):
        if (stringer[i] == '('):
            stringer = stringer[:i-1]
            break
    stringer = stringer.replace("\xa0"," ")
    liste[3] = stringer
    liste_new.append(liste[3])
    liste_new.append("N/A")
    liste_new.append("N/A")
    return liste_new

def fixDarwinSpecial (liste: list, divider: int, episode_tracker: int):
    liste_new = []
    tracker = []
    for i in range(int((len(liste))/(divider-1))):
        tracker.append(episode_tracker)
        tracker.append(i+1)
        episode_tracker += 1
        for j in range(divider-1):
            if (j == 2):
                stringer = liste[i*(divider-1)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '['):
                        stringer = stringer[:k]
                        break
                liste[i*(divider-1)+j] = stringer
            if (j == divider-2):
                stringer = liste[i*(divider-1)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '['):
                        stringer = stringer[:k]
                        break
                liste[i*(divider-1)+j] = stringer
            if (j != 1):
                tracker.append(liste[i*(divider-1)+j])
            if (j == 0):
                tracker.append("N/A")
                tracker.append("N/A")
                tracker.append("N/A")
        liste_new.append(tracker)
        tracker = []
    return liste_new, episode_tracker

def fixGumballChronicles (liste: list, divider: int, episode_tracker: int):
    liste_new = []
    tracker = []
    for i in range(int((len(liste))/(divider-1))):
        tracker.append(episode_tracker)
        tracker.append(i+1)
        episode_tracker += 1
        for j in range(divider-1):
            if (j == 1 or j == 2):
                liste[i*(divider-1)+j] = splitJustAnd(liste[i*(divider-1)+j])
            if (j == 3):
                stringer = liste[i*(divider-1)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '('):
                        stringer = stringer[:k-1]
                        break
                stringer = stringer.replace("\xa0"," ")
                liste[i*(divider-1)+j] = stringer
            if (j == divider-2 or j == 5):
                stringer = liste[i*(divider-1)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '['):
                        stringer = stringer[:k]
                        break
                liste[i*(divider-1)+j] = stringer
            if (j != 4):
                tracker.append(liste[i*(divider-1)+j])
            if (j == 0):
                tracker.append("N/A")
        liste_new.append(tracker)
        tracker = []
    return liste_new, episode_tracker

def fixSeasonOverview (liste: list, extra_data: str, divider: int):
    liste_new = []
    tracker = []
    tracker.append("Pilot")
    tracker.append(1)
    stringer = extra_data
    for k in range(len(stringer)):
        if (stringer[k] == '('):
            stringer = stringer[:k-1]
            break
    stringer = stringer.replace("\xa0"," ")
    extra_data = stringer
    for i in range(2):
        tracker.append(extra_data)
    liste_new.append(tracker)
    tracker = []
    for i in range(int(len(liste)/divider)):
        if (i < 6):
            tracker.append(i+1)
        elif (i == 6):
            tracker.append("Darwin's Yearbook")
        else:
            tracker.append("Gumball's Chronicle")
        for j in range(divider):
            if (j >= 1):
                stringer = liste[i*(divider)+j]
                for k in range(len(stringer)):
                    if (stringer[k] == '('):
                        stringer = stringer[:k-1]
                        break
                stringer = stringer.replace("\xa0"," ")
                liste[i*(divider)+j] = stringer
            tracker.append(liste[i*(divider)+j])
        liste_new.append(tracker)
        tracker = []
    return liste_new

def createEpisode (liste: list, headers: list):
    liste[2] = liste[2].replace('"','')
    episode = {
        headers[0]: liste[0],
        headers[1]: liste[1],
        headers[2]: liste[2],
        headers[3]: liste[3],
        headers[4]: liste[4],
        headers[5]: liste[5],
        headers[6]: liste[6],
        headers[7]: liste[7],
        headers[8]: liste[8]
    }
    return episode

def createEpisodes (liste: list, headers: list):
    episode_liste = []
    for i in range(len(liste)):
        episode_liste.append(createEpisode(liste[i],headers))
    return episode_liste

def createSeason (episode_liste: list, season_credential: list, headers: list):
    season = {
        "SeasonName": season_credential[0],
        "EpisodeAmount": season_credential[1],
        "StartDate": season_credential[2],
        "EndDate": season_credential[3],
        "Episodes": createEpisodes(episode_liste, headers)
    }
    return season

def createSeasons (liste: list, episode_liste: list,headers: list):
    season_liste = []
    for i in range(len(liste)):
        season_liste.append(createSeason(episode_liste[i],liste[i],headers))
    return season_liste

def createShow (season_liste: list):
    show = {
        "Name": "The Amazing World of Gumball",
        "Seasons": season_liste
    }
    return show