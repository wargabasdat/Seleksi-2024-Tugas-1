## Description

This project scrape Heroes and Items data from [Dotabuff](https://dotabuff.com), a popular Dota 2 statistics website and then store it in a mariadb database. I choose this topic because of personal interest in Dota 2 and to gain some insights.

## Author

| Name           | NIM      |
| -------------- | -------- |
| Rayhan Fadhlan | 13522095 |

## Setup

json data already provided, but if you want to scrape the data you can :

change directory to `Data Scraping/src`

```bash
python scrape.py
python cleanse.py
```

## JSON Structure

heroes and items structure

```json
[
    {
        "hero_name": "Axe",
        "hero_category": [
            "Melee",
            "Carry",
            "Disabler",
            "Durable",
            "Initiator"
        ],
        "hero_win_rate": "52.81",
        "hero_image": "https",
        "strength": "25",
        "agility": "20",
        "intelligence": "18",
        "movement_speed": "315",
        "sight_range": "1800",
        "armor": "2.8",
        "base_attack_time": "1.7",
        "damage": "55",
        "attack_point": "0.4",
        "facet1": "One Man Army",
        "facet2": "Call Out",
        
         "items": [
            {
                "name": "Blade Mail",
                "matches_played": "2795985",
                "win_rate": "53.85"
            },
         ],
         "counters": [
            {
                "hero": "Leshrac",
                "disadvantage": "3.80",
                "win_rate": "47.07",
                "match_played": "52107"
            },
         ],
         "talents" : [
            {
                "level": "25",
                "left": "x2x Battle Hunger Armor Multiplier",
                "right": "+100 Berserker's Call AoE"
            },
         ],
         "abilities": [
            {
                "name": "Berserker's Call",
                "image": "https:://",
                "description": "Axe taunts nearby enemy units, forcing them to attack him while he gains bonus armor during the duration.",
                "lore": "Mogul Khan's warcry taunts opponents into engaging in an unconquerable battle with the Axe."
            },
         ]
    }
]

[
    {
        "name": "Swift Blink",
        "price": "6800",
        "item_image": "https:",
        "lore": "A cunning blade able to anticipate and enable its bearer's movements.",
        "build": [
            "Blink Dagger",
            "Eaglesong",
        ]
    },
    
]

```

## ER Diagram and Relational Diagram
![ERD](./Data%20Storing/design/ERD.png)
![Relational](./Data%20Storing/design/Relational.png)

Database translation from ER Diagram to relational consists of creating new tables, such as category (from hero table), Hero_Item (many to many relationship), Hero_Versus (many to many relationship), and Item_Component (many to many relationship).

## Screenshots
<img src="./Data%20Storing/screenshot/query_2.png" alt="Query 2" width="400">
<img src="./Data%20Storing/screenshot/query_3.png" alt="Query 3" width="400">

## References
[dotabuff](https://dotabuff.com)
