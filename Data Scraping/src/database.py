import mysql.connector

def create_database():
    conn = mysql.connector.connect(
        host='localhost', # ganti sesuai dengan host, user, dan password mariadb masing-masing
        user='root',
        password='shzyt2929'
    )
    cursor = conn.cursor()
    # membuat database jika belum tersedia
    cursor.execute("CREATE DATABASE IF NOT EXISTS tennis_database")
    conn.close()

def connect_database():
    # connect ke database
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='shzyt2929',
        database='tennis_database'
    )
    return conn

def create_tables():
    conn = connect_database()
    cursor = conn.cursor()
    # membuat table Player yang berisi biodata dari pemain tenis
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Player (
            `player_id` INTEGER PRIMARY KEY NOT NULL,
            `player_name` VARCHAR(255) NOT NULL,
            `country` VARCHAR(255),
            `playing_hand` enum('Right','Left'),
            `year_turned_pro` INT,
            `birth_date` DATE,
            `height` INTEGER,
            `weight` INTEGER,
            `hometown` VARCHAR(255)
    )''')
    # membuat table Coach yang berisi biodata pelatih tenis
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Coach (
            `coach_id` INTEGER PRIMARY KEY NOT NULL,
            `coach_name` VARCHAR(255),
            `birth_date` DATE,
            `nationality` VARCHAR(255),
            `specialization` VARCHAR(255)
    )''')
    # membuat table PlayerCoach (penghubung player dan coach)
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS PlayerCoach (
            `player_id` INTEGER NOT NULL,
            `coach_id` INTEGER NOT NULL,
            `start_date` DATE NOT NULL,
            `end_date` DATE,
            PRIMARY KEY(`player_id`, `coach_id`, `start_date`),
            CONSTRAINT `pc_fk_1` FOREIGN KEY(coach_id) REFERENCES Coach(coach_id)
                ON DELETE CASCADE
                ON UPDATE CASCADE,
            CONSTRAINT `pc_fk_2` FOREIGN KEY(player_id) REFERENCES Player(player_id)
                ON DELETE CASCADE
                ON UPDATE CASCADE
    )''')
    # membuat table Injury yang berisi data cidera pemain tenis
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Injury (
            `player_id` INTEGER NOT NULL,
            `injury_id` VARCHAR(255) NOT NULL,
            `date_of_injury` DATE,
            `recovery_date` DATE,
            `type_of_injury` VARCHAR(255),
            `severity` VARCHAR(255),
            PRIMARY KEY(`player_id`, `injury_id`),
            CONSTRAINT `i_fk_1` FOREIGN KEY(player_id) REFERENCES Player(player_id)
                ON DELETE CASCADE
                ON UPDATE CASCADE
    )''')
    # membuat table Tournament yang berisi data tournament
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Tournament (
            `tournament_id` INTEGER NOT NULL,
            `event` VARCHAR(255) NOT NULL,
            `tournament_name` VARCHAR(255) NOT NULL,
            `location` VARCHAR(255),
            `start_date` DATE,
            `end_date` DATE,
            PRIMARY KEY(`tournament_id`, `event`)
    )''')
    # membuat table PlayerTournament yang menyatakan partisipasi pemain dalam turnamen
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS PlayerTournament (
            `tournament_id` INTEGER NOT NULL,
            `event` VARCHAR(255) NOT NULL,
            `player_id` INTEGER NOT NULL,
            `player_result` VARCHAR(255),
            PRIMARY KEY(`tournament_id`, `event`, `player_id`),
            CONSTRAINT `pt_fk_1` FOREIGN KEY (tournament_id, event) REFERENCES Tournament(tournament_id, event)
                ON DELETE CASCADE
                ON UPDATE CASCADE,
            CONSTRAINT `pt_fk_2` FOREIGN KEY (player_id) REFERENCES Player(player_id)
                ON DELETE CASCADE
                ON UPDATE CASCADE
    )''')
    # membuat table matches yang berisi data match yang ada
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Matches (
            `match_id` INTEGER NOT NULL,
            `tournament_id` INTEGER NOT NULL,
            `event` VARCHAR(255) NOT NULL,
            `round` VARCHAR(255),
            `score` VARCHAR(255),
            PRIMARY KEY(`match_id`, `tournament_id`, `event`),
            CONSTRAINT `ma_fk_1` FOREIGN KEY (tournament_id, event) REFERENCES Tournament(tournament_id, event)
                ON DELETE CASCADE
                ON UPDATE CASCADE
    )''')

    # membuat table PlayerMatch yang berisi data setiap match yang dimainkan player
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS PlayerMatch (
            match_id INTEGER NOT NULL,
            tournament_id INTEGER NOT NULL,
            event VARCHAR(255) NOT NULL,
            player_id INTEGER NOT NULL,
            `role` ENUM('winner', 'loser'),
            PRIMARY KEY (match_id, tournament_id, event, player_id),
            CONSTRAINT pm_match_fk FOREIGN KEY (match_id, tournament_id, event) REFERENCES Matches(match_id, tournament_id, event)
                ON DELETE CASCADE
                ON UPDATE CASCADE,
            CONSTRAINT pm_player_fk FOREIGN KEY (player_id) REFERENCES Player(player_id),
            CONSTRAINT pm_role_chk CHECK (`role` IN ('winner', 'loser'))
    )''')
    # membuat table Rank yang berisi informasi rank
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Rank (
            `rank` INTEGER NOT NULL,
            `date` DATE NOT NULL,
            `rank_type` enum('WTA','ATP'),
            `player_id` INTEGER NOT NULL,
            `points` INTEGER NOT NULL,
            `change_in_rank` INTEGER NOT NULL,
            PRIMARY KEY(`rank`, `date`, `rank_type`),
            CONSTRAINT `r_fk_1` FOREIGN KEY(player_id) REFERENCES Player(player_id)
    )''')
    # membuat table PlayerStats yang berisi stat pemain untuk masing-masing tahun
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS PlayerStats (
            `player_id` INTEGER NOT NULL,
            `year` INTEGER NOT NULL,
            `singles_title` INTEGER NOT NULL,
            `doubles_title` INTEGER NOT NULL,
            `singles_win` INTEGER NOT NULL,
            `singles_lose` INTEGER NOT NULL,
            `prize_money` REAL NOT NULL,
            PRIMARY KEY(`player_id`, `year`),
            CONSTRAINT `ps_fk_1` FOREIGN KEY(player_id) REFERENCES Player(player_id)
                ON DELETE CASCADE
                ON UPDATE CASCADE
    )''')
    # membuat table statistic keseluruhan pemain selama berkarir
    cursor.execute("""
        -- Create an empty table with the structure you want
        CREATE TABLE IF NOT EXISTS CareerStats (
            player_id INT PRIMARY KEY,
            total_singles_titles INT,
            total_doubles_titles INT,
            total_singles_wins INT,
            total_singles_losses INT,
            total_prize_money FLOAT
        );
    """)
    # mengisi table CareerStats
    cursor.execute("""
        -- Insert aggregated data into the table
        INSERT INTO CareerStats (player_id, total_singles_titles, total_doubles_titles, total_singles_wins, total_singles_losses, total_prize_money)
        SELECT
            p.player_id,
            COALESCE(SUM(ps.singles_title), 0),
            COALESCE(SUM(ps.doubles_title), 0),
            COALESCE(SUM(ps.singles_win), 0),
            COALESCE(SUM(ps.singles_lose), 0),
            COALESCE(SUM(ps.prize_money), 0)
        FROM
            Player p
        LEFT JOIN
            PlayerStats ps ON p.player_id = ps.player_id
        GROUP BY
            p.player_id
        ON DUPLICATE KEY UPDATE
            total_singles_titles = VALUES(total_singles_titles),
            total_doubles_titles = VALUES(total_doubles_titles),
            total_singles_wins = VALUES(total_singles_wins),
            total_singles_losses = VALUES(total_singles_losses),
            total_prize_money = VALUES(total_prize_money);
    """)
    # menambahkan data CareerStats ketika dilakukan insert pada PlayerStats
    cursor.execute('''
        CREATE TRIGGER IF NOT EXISTS UpdateCareerStatsAfterInsert
        AFTER INSERT ON PlayerStats
        FOR EACH ROW
        BEGIN
            INSERT INTO CareerStats (player_id, total_singles_titles, total_doubles_titles, total_singles_wins, total_singles_losses, total_prize_money)
            VALUES (NEW.player_id, NEW.singles_title, NEW.doubles_title, NEW.singles_win, NEW.singles_lose, NEW.prize_money)
            ON DUPLICATE KEY UPDATE
                total_singles_titles = total_singles_titles + NEW.singles_title,
                total_doubles_titles = total_doubles_titles + NEW.doubles_title,
                total_singles_wins = total_singles_wins + NEW.singles_win,
                total_singles_losses = total_singles_losses + NEW.singles_lose,
                total_prize_money = total_prize_money + NEW.prize_money;
        END;
    ''')
    # menambahkan data CareerStats ketika dilakukan insert pada Player
    cursor.execute("""
        CREATE TRIGGER IF NOT EXISTS AddNewPlayerToCareerStats AFTER INSERT ON Player
        FOR EACH ROW
        BEGIN
            INSERT INTO CareerStats (player_id, total_singles_titles, total_doubles_titles, total_singles_wins, total_singles_losses, total_prize_money)
            VALUES (NEW.player_id, 0, 0, 0, 0, 0.0);
        END;
    """)
    # mengupdate data CareerStats ketika dilakukan update pada PlayerStats
    cursor.execute("""
        CREATE TRIGGER IF NOT EXISTS UpdateCareerStatsAfterUpdate
        AFTER UPDATE ON PlayerStats
        FOR EACH ROW
        BEGIN
            UPDATE CareerStats
            SET
                total_singles_titles = total_singles_titles + NEW.singles_title - OLD.singles_title,
                total_doubles_titles = total_doubles_titles + NEW.doubles_title - OLD.doubles_title,
                total_singles_wins = total_singles_wins + NEW.singles_win - OLD.singles_win,
                total_singles_losses = total_singles_losses + NEW.singles_lose - OLD.singles_lose,
                total_prize_money = total_prize_money + NEW.prize_money - OLD.prize_money
            WHERE player_id = NEW.player_id;
        END;
    """)
       
    conn.commit()
    conn.close()