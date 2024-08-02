--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12
-- Dumped by pg_dump version 14.12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: reference_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.reference_type AS ENUM (
    'to_other_games',
    'in_other_games',
    'in_later_games'
);


ALTER TYPE public.reference_type OWNER TO "user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: character; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public."character" (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    detail_url text NOT NULL,
    image_id integer NOT NULL
);


ALTER TABLE public."character" OWNER TO "user";

--
-- Name: character_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.character_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.character_id_seq OWNER TO "user";

--
-- Name: character_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.character_id_seq OWNED BY public."character".id;


--
-- Name: enemy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.enemy (
    id integer NOT NULL,
    points integer NOT NULL
);


ALTER TABLE public.enemy OWNER TO "user";

--
-- Name: enemy_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.enemy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enemy_id_seq OWNER TO "user";

--
-- Name: enemy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.enemy_id_seq OWNED BY public.enemy.id;


--
-- Name: form; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.form (
    id integer NOT NULL,
    name text NOT NULL,
    detail_url text NOT NULL,
    image_id integer NOT NULL,
    power_up_id integer NOT NULL,
    pc_id integer NOT NULL
);


ALTER TABLE public.form OWNER TO "user";

--
-- Name: form_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.form_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.form_id_seq OWNER TO "user";

--
-- Name: form_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.form_id_seq OWNED BY public.form.id;


--
-- Name: image; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.image (
    id integer NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL
);


ALTER TABLE public.image OWNER TO "user";

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_id_seq OWNER TO "user";

--
-- Name: image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;


--
-- Name: item; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.item (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    detail_url text NOT NULL,
    image_id integer NOT NULL
);


ALTER TABLE public.item OWNER TO "user";

--
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_id_seq OWNER TO "user";

--
-- Name: item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.item_id_seq OWNED BY public.item.id;


--
-- Name: level; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.level (
    id integer NOT NULL,
    name text NOT NULL,
    detail_url text NOT NULL,
    setting_id integer NOT NULL,
    image_id integer NOT NULL,
    course_map_image_id integer NOT NULL
);


ALTER TABLE public.level OWNER TO "user";

--
-- Name: level_enemy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.level_enemy (
    level_id integer NOT NULL,
    enemy_id integer NOT NULL,
    count integer NOT NULL
);


ALTER TABLE public.level_enemy OWNER TO "user";

--
-- Name: level_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.level_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.level_id_seq OWNER TO "user";

--
-- Name: level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.level_id_seq OWNED BY public.level.id;


--
-- Name: level_item; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.level_item (
    level_id integer NOT NULL,
    item_id integer NOT NULL,
    count integer NOT NULL
);


ALTER TABLE public.level_item OWNER TO "user";

--
-- Name: level_obstacle; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.level_obstacle (
    level_id integer NOT NULL,
    obstacle_id integer NOT NULL,
    count integer NOT NULL
);


ALTER TABLE public.level_obstacle OWNER TO "user";

--
-- Name: level_power_up; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.level_power_up (
    level_id integer NOT NULL,
    power_up_id integer NOT NULL,
    count integer NOT NULL
);


ALTER TABLE public.level_power_up OWNER TO "user";

--
-- Name: npc; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.npc (
    id integer NOT NULL
);


ALTER TABLE public.npc OWNER TO "user";

--
-- Name: npc_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.npc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.npc_id_seq OWNER TO "user";

--
-- Name: npc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.npc_id_seq OWNED BY public.npc.id;


--
-- Name: object; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.object (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    detail_url text NOT NULL,
    image_id integer NOT NULL
);


ALTER TABLE public.object OWNER TO "user";

--
-- Name: object_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.object_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.object_id_seq OWNER TO "user";

--
-- Name: object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.object_id_seq OWNED BY public.object.id;


--
-- Name: obstacle; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.obstacle (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    detail_url text NOT NULL,
    image_id integer NOT NULL
);


ALTER TABLE public.obstacle OWNER TO "user";

--
-- Name: obstacle_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.obstacle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.obstacle_id_seq OWNER TO "user";

--
-- Name: obstacle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.obstacle_id_seq OWNED BY public.obstacle.id;


--
-- Name: pc; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.pc (
    id integer NOT NULL
);


ALTER TABLE public.pc OWNER TO "user";

--
-- Name: pc_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.pc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pc_id_seq OWNER TO "user";

--
-- Name: pc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.pc_id_seq OWNED BY public.pc.id;


--
-- Name: power_up; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.power_up (
    id integer NOT NULL,
    name text,
    description text NOT NULL,
    detail_url text,
    image_id integer
);


ALTER TABLE public.power_up OWNER TO "user";

--
-- Name: power_up_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.power_up_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.power_up_id_seq OWNER TO "user";

--
-- Name: power_up_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.power_up_id_seq OWNED BY public.power_up.id;


--
-- Name: reference; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.reference (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    detail_url text NOT NULL,
    type public.reference_type NOT NULL
);


ALTER TABLE public.reference OWNER TO "user";

--
-- Name: reference_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.reference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reference_id_seq OWNER TO "user";

--
-- Name: reference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.reference_id_seq OWNED BY public.reference.id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.setting (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.setting OWNER TO "user";

--
-- Name: setting_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.setting_id_seq OWNER TO "user";

--
-- Name: setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.setting_id_seq OWNED BY public.setting.id;


--
-- Name: version; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.version (
    id integer NOT NULL,
    year integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.version OWNER TO "user";

--
-- Name: version_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.version_id_seq OWNER TO "user";

--
-- Name: version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.version_id_seq OWNED BY public.version.id;


--
-- Name: character id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."character" ALTER COLUMN id SET DEFAULT nextval('public.character_id_seq'::regclass);


--
-- Name: enemy id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.enemy ALTER COLUMN id SET DEFAULT nextval('public.enemy_id_seq'::regclass);


--
-- Name: form id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.form ALTER COLUMN id SET DEFAULT nextval('public.form_id_seq'::regclass);


--
-- Name: image id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);


--
-- Name: item id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.item ALTER COLUMN id SET DEFAULT nextval('public.item_id_seq'::regclass);


--
-- Name: level id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level ALTER COLUMN id SET DEFAULT nextval('public.level_id_seq'::regclass);


--
-- Name: npc id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.npc ALTER COLUMN id SET DEFAULT nextval('public.npc_id_seq'::regclass);


--
-- Name: object id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.object ALTER COLUMN id SET DEFAULT nextval('public.object_id_seq'::regclass);


--
-- Name: obstacle id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.obstacle ALTER COLUMN id SET DEFAULT nextval('public.obstacle_id_seq'::regclass);


--
-- Name: pc id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.pc ALTER COLUMN id SET DEFAULT nextval('public.pc_id_seq'::regclass);


--
-- Name: power_up id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.power_up ALTER COLUMN id SET DEFAULT nextval('public.power_up_id_seq'::regclass);


--
-- Name: reference id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.reference ALTER COLUMN id SET DEFAULT nextval('public.reference_id_seq'::regclass);


--
-- Name: setting id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.setting ALTER COLUMN id SET DEFAULT nextval('public.setting_id_seq'::regclass);


--
-- Name: version id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.version ALTER COLUMN id SET DEFAULT nextval('public.version_id_seq'::regclass);


--
-- Data for Name: character; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public."character" (id, name, description, detail_url, image_id) FROM stdin;
1	Mario	Mario serves as the main protagonist of the game. Luigi, Mario's brother, appears only as the second player and plays identically to Mario. While Luigi is differentiated by his colors, both Fiery Mario and Fiery Luigi have the same palette.	https://www.mariowiki.com/Mario	23
2	Luigi	Mario serves as the main protagonist of the game. Luigi, Mario's brother, appears only as the second player and plays identically to Mario. While Luigi is differentiated by his colors, both Fiery Mario and Fiery Luigi have the same palette.	https://www.mariowiki.com/Luigi	24
3	Princess Toadstool	The princess of the Mushroom Kingdom. Bowser kidnaps her to prevent her from reversing the magic the Koopa used on the Mushroom People. She appears in the final course, 8-4 where she thanks Mario[9] for rescusing her and offers a "new quest" for him.	https://www.mariowiki.com/Princess_Peach	25
4	Mushroom retainers	Seven Mushroom People that are servants of the princess and prisoners of the Koopa. They appear in every castle except for the final one. Mario can rescue a retainer by finishing a castle in World 1 to World 7. They'll say, "Thank you Mario/Luigi! But our princess is in another castle!"	https://www.mariowiki.com/Toad_(species)	26
5	Little Goomba	Mushroom creatures that walk back and forth. Little Goombas are the most common enemies and can be defeated with any attack.	https://www.mariowiki.com/Goomba	27
6	Koopa Troopa	Foot soldiers of the Turtle Empire. Stomping on Koopa Troopas make them recede into their shells, which can be kicked to hit defeat enemies. Like Little Goombas, green-shelled Koopa Troopas walk off ledges.	https://www.mariowiki.com/Koopa_Troopa	28
7	Koopa Paratroopa	Winged Koopa Troopas. The green ones bounce across the ground or fly back and forth in set paths.	https://www.mariowiki.com/Koopa_Paratroopa	29
8	Buzzy Beetle	Small Koopas that retract into their shells when stomped. Buzzy Beetles are immune to fireballs and replace Little Goombas in Hard Mode.	https://www.mariowiki.com/Buzzy_Beetle	30
9	Hammer Brother	Helmeted Koopas that toss hammers. Hammer Brothers periodically hop between rows of blocks. They always occur in pairs.	https://www.mariowiki.com/Hammer_Bro	31
10	Spiny	Squat, spiked Koopas. Stomping one damages Mario.	https://www.mariowiki.com/Spiny	32
11	Spiny's egg	The spiked eggs tossed by Lakitus. They hatch into Spinies when they make contact with the ground.	https://www.mariowiki.com/Spiny_Egg	33
12	Lakitu	Cloud-riding Koopas. Lakitus toss Spiny's eggs. They appear towards the top of the screen follow Mario's position.	https://www.mariowiki.com/Lakitu	34
13	Piranha plant	Carnivorous plants that sit in pipes. Piranha plants emerge and retract from pipes in set internals. If Mario stands directly next to or on these pipes, the plants do not emerge.	https://www.mariowiki.com/Piranha_Plant	35
14	Cheep-cheep	Pudgy pufferfish enemies that swim through water. In some ground-themed courses, red Cheep-cheeps leap over bridges in large numbers.	https://www.mariowiki.com/Cheep_Cheep	36
15	Bullet Bill	Missiles launched from Turtle Cannons. They fly in straight lines. Bullet Bills are unaffected by fireballs.	https://www.mariowiki.com/Bullet_Bill	37
16	Bloober	Underwater squid sentinels. They swim erratically to strike Mario.	https://www.mariowiki.com/Blooper	38
\.


--
-- Data for Name: enemy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.enemy (id, points) FROM stdin;
5	100
6	100
7	400
8	100
9	1000
10	200
11	200
12	200
13	200
14	200
15	200
16	200
\.


--
-- Data for Name: form; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.form (id, name, detail_url, image_id, power_up_id, pc_id) FROM stdin;
1	Regular Mario	https://www.mariowiki.com/Small_Mario	39	1	1
2	Regular Luigi	https://www.mariowiki.com/Small_Mario	40	1	2
3	Super Mario	https://www.mariowiki.com/Super_Mario	42	2	1
4	Super Luigi	https://www.mariowiki.com/Super_Mario	43	2	2
5	Fiery Mario	https://www.mariowiki.com/Fire_Mario	45	3	1
6	Fiery Luigi	https://www.mariowiki.com/Fire_Mario	46	3	2
7	Invincible Mario	https://www.mariowiki.com/Invincible_Mario	48	4	1
8	Invincible Luigi	https://www.mariowiki.com/Invincible_Mario	49	4	2
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.image (id, name, url, width, height) FROM stdin;
1	Sprite of a Fire Bar from Super Mario Bros.	https://mario.wiki.gallery/images/0/03/SMB_Sprite_Fire_Bar.png	40	39
2	Sprite of Bowser's Flame from Super Mario Bros.	https://mario.wiki.gallery/images/f/f1/SMB_Sprite_Bowser%27s_Flame.png	24	8
3	Sprite tile of lava from Super Mario Bros.	https://mario.wiki.gallery/images/c/cc/SMB_Sprite_Lava.png	16	16
4	Bill Blaster sprite.	https://mario.wiki.gallery/images/3/3a/Bill_Blaster_Sprite_SMB.png	16	32
5	SMB 1-up Mushroom Sprite.png	https://mario.wiki.gallery/images/0/02/SMB_1-up_Mushroom_Sprite.png	16	16
6	Sprite of a coin from Super Mario Bros.	https://mario.wiki.gallery/images/a/ab/SMB_Sprite_Coin.png	10	14
7	Green Shell	https://mario.wiki.gallery/images/0/06/SMB_Greenshell.png	16	14
8	A Buzzy Shell	https://mario.wiki.gallery/images/d/dd/SMB_Buzzy_Shell.png	16	15
9	An static ? Block from Super Mario Bros. (Overworld palette)	https://mario.wiki.gallery/images/d/dc/SMB_QuestionBlockOverworld.png	16	16
10	Sprite of a Brick Block from Super Mario Bros.	https://mario.wiki.gallery/images/7/7e/SMB_Brick_Block_Sprite.png	16	16
11	Sprite of Coral from Super Mario Bros.	https://mario.wiki.gallery/images/e/e5/SMB_Sprite_Coral.png	16	16
12	Sprite of a Cloud Block from Super Mario Bros.	https://mario.wiki.gallery/images/5/56/SMB_Sprite_Cloud_Block.png	16	16
13	Sprite of a Hard Block from Super Mario Bros.	https://mario.wiki.gallery/images/e/ec/SMB_Hard_Block_Sprite.png	16	16
14	Jumping board	https://mario.wiki.gallery/images/7/7c/SMB_Trampoline_Sprite.png	16	23
15	SMBPlatform.png	https://mario.wiki.gallery/images/5/55/SMBPlatform.png	48	8
16	Sprite of a Warp Pipe from Super Mario Bros.	https://mario.wiki.gallery/images/b/be/Warp_Pipe_SMB.png	32	32
17	A Mushroom Platform from Super Mario Bros.	https://mario.wiki.gallery/images/4/45/SMB_Mushroom_Platform.png	48	48
18	Sprite of an Axe from Super Mario Bros.	https://mario.wiki.gallery/images/7/7d/SMB_Sprite_Axe.png	16	16
19	A flagpole from Super Mario Bros.	https://mario.wiki.gallery/images/thumb/b/b2/SMB_Goal_Pole.png/11px-SMB_Goal_Pole.png	11	80
20	Beanstalk	https://mario.wiki.gallery/images/thumb/1/1a/VineTop.png/11px-VineTop.png	11	80
21	Sprite of a Firework from Super Mario Bros.	https://mario.wiki.gallery/images/a/ac/SMB_Sprite_Firework.gif	16	16
22	A horsehair plant from Super Mario Bros.	https://mario.wiki.gallery/images/4/44/SMB_Green_Horsetail_Tall.png	16	46
23	Super Mario's sprite from Super Mario Bros.	https://mario.wiki.gallery/images/c/cf/SMB_Super_Mario_Sprite.png	16	32
24	Sprite of Luigi from Super Mario Bros.	https://mario.wiki.gallery/images/b/b7/SMB_Super_Luigi_Sprite.png	16	32
25	Princess Peach in Super Mario Bros..	https://mario.wiki.gallery/images/c/c0/SMB_Princess_Toadstool_Sprite.png	16	24
26	A Mushroom Retainer from Super Mario Bros.	https://mario.wiki.gallery/images/e/e6/SMB_Mushroom_Retainer_Sprite.png	16	24
27	Sprite of a Goomba from Super Mario Bros.	https://mario.wiki.gallery/images/c/c6/Goomba_SMB.png	16	16
28	Sprite of a green Koopa Troopa from Super Mario Bros.	https://mario.wiki.gallery/images/6/6f/SMB_Green_Koopa_Troopa_Sprite.png	16	23
29	Sprite of a green Koopa Paratroopa from Super Mario Bros.	https://mario.wiki.gallery/images/2/2c/SMB_Sprite_Koopa_Paratroopa_%28Green%29.png	16	23
30	A Buzzy Beetle, from Super Mario Bros.	https://mario.wiki.gallery/images/4/48/Buzzy_Beetle_SMB.png	16	15
31	Sprite of Hammer Bro from Super Mario Bros.	https://mario.wiki.gallery/images/2/21/SMB_Hammer_Bro_Sprite.png	16	24
32	Sprite of a Spiny from Super Mario Bros.	https://mario.wiki.gallery/images/1/16/SMB_Sprite_Spiny.png	16	15
33	Sprite of a Spiny Egg from Super Mario Bros.	https://mario.wiki.gallery/images/1/18/SMB_Sprite_Spiny_Egg.png	14	16
34	Sprite of Lakitu from Super Mario Bros.	https://mario.wiki.gallery/images/b/b8/SMB_Lakitu_Sprite.png	16	24
35	Sprite of a Piranha Plant from Super Mario Bros.	https://mario.wiki.gallery/images/b/b4/SMB_Sprite_Piranha_Plant.png	16	23
36	Sprite of a red Cheep Cheep from Super Mario Bros.	https://mario.wiki.gallery/images/8/8c/SMB_Sprite_Cheep_Cheep_%28Red%29.png	16	16
37	Bullet Bill	https://mario.wiki.gallery/images/e/ec/Bullet_Bill_Super_Mario_Bros.png	16	14
38	Sprite of a Blooper from Super Mario Bros.	https://mario.wiki.gallery/images/b/b1/SMB_Sprite_Blooper.png	16	24
39	Small Mario sprite from Super Mario Bros.	https://mario.wiki.gallery/images/0/02/SMB_Smallmario.png	12	16
40	Luigi's death sprite in Super Mario Bros.	https://mario.wiki.gallery/images/5/57/SMB_Luigi_Death_Sprite.png	14	14
41	SMB Supermushroom.png	https://mario.wiki.gallery/images/6/66/SMB_Supermushroom.png	16	16
42	Super Mario jumping in Super Mario Bros.	https://mario.wiki.gallery/images/0/02/SMB_Super_Mario_Jumping.png	16	32
43	Sprite of Luigi from Super Mario Bros.	https://mario.wiki.gallery/images/b/b7/SMB_Super_Luigi_Sprite.png	16	32
44	Sprite of a Fire Flower from Super Mario Bros.	https://mario.wiki.gallery/images/7/7a/SMB_Sprite_Fire_Flower.png	16	16
45	SMB Fire Mario Sprite.png	https://mario.wiki.gallery/images/8/8d/SMB_Fire_Mario_Sprite.png	16	32
46	SMB Fire Mario Sprite.png	https://mario.wiki.gallery/images/8/8d/SMB_Fire_Mario_Sprite.png	16	32
47	Sprite of a Starman from Super Mario Bros.	https://mario.wiki.gallery/images/b/b6/SMB_Sprite_Super_Star.png	16	16
48	Invincible Mario in Super Mario Bros.	https://mario.wiki.gallery/images/6/62/Invincible_Mario.gif	16	32
49	Invincible Mario in Super Mario Bros.	https://mario.wiki.gallery/images/6/62/Invincible_Mario.gif	16	32
50	SMB Super Mushroom Screenshot.png	https://mario.wiki.gallery/images/2/24/SMB_Super_Mushroom_Screenshot.png	256	224
51	Map of World 1-1	https://mario.wiki.gallery/images/3/38/SMB_NES_World_1-1_Map.png	3584	240
52	SMB Super Mushroom Screenshot.png	https://mario.wiki.gallery/images/2/24/SMB_Super_Mushroom_Screenshot.png	256	224
53	Map of World 1-2	https://mario.wiki.gallery/images/d/d4/SMB_NES_World_1-2_Map.png	4096	240
54	SMB Super Mushroom Screenshot.png	https://mario.wiki.gallery/images/2/24/SMB_Super_Mushroom_Screenshot.png	256	224
55	Map of World 1-3	https://mario.wiki.gallery/images/e/e3/SMB_NES_World_1-3_Map.png	2624	240
56	SMB Super Mushroom Screenshot.png	https://mario.wiki.gallery/images/2/24/SMB_Super_Mushroom_Screenshot.png	256	224
57	Map of World 1-4	https://mario.wiki.gallery/images/2/21/SMB_NES_World_1-4_Map.png	2560	240
58	SMB NES World 2-3 Screenshot.png	https://mario.wiki.gallery/images/3/39/SMB_NES_World_2-3_Screenshot.png	256	224
59	Map of World 2-1	https://mario.wiki.gallery/images/f/fb/SMB_NES_World_2-1_Map.png	4944	240
60	SMB NES World 2-3 Screenshot.png	https://mario.wiki.gallery/images/3/39/SMB_NES_World_2-3_Screenshot.png	256	224
61	Map of World 2-2	https://mario.wiki.gallery/images/c/c6/SMB_NES_World_2-2_Map.png	3840	240
62	SMB NES World 2-3 Screenshot.png	https://mario.wiki.gallery/images/3/39/SMB_NES_World_2-3_Screenshot.png	256	224
63	Map of World 2-3	https://mario.wiki.gallery/images/7/77/SMB_NES_World_2-3_Map.png	3792	240
64	SMB NES World 2-3 Screenshot.png	https://mario.wiki.gallery/images/3/39/SMB_NES_World_2-3_Screenshot.png	256	224
65	Map of World 2-4	https://mario.wiki.gallery/images/3/30/SMB_NES_World_2-4_Map.png	2560	240
66	World 3-1	https://mario.wiki.gallery/images/1/17/SMB_NES_World_3-1_Screenshot.png	256	224
67	Map of World 3-1	https://mario.wiki.gallery/images/5/52/SMB_NES_World_3-1_Map.png	5120	240
68	World 3-1	https://mario.wiki.gallery/images/1/17/SMB_NES_World_3-1_Screenshot.png	256	224
69	Map of World 3-2	https://mario.wiki.gallery/images/b/b6/SMB_NES_World_3-2_Map.png	3504	240
70	World 3-1	https://mario.wiki.gallery/images/1/17/SMB_NES_World_3-1_Screenshot.png	256	224
71	Map of World 3-3	https://mario.wiki.gallery/images/0/06/SMB_NES_World_3-3_Map.png	2608	240
72	World 3-1	https://mario.wiki.gallery/images/1/17/SMB_NES_World_3-1_Screenshot.png	256	224
73	Map of World 3-4	https://mario.wiki.gallery/images/b/b1/SMB_NES_World_3-4_Map.png	2560	240
74	Lakitu throwing Spinies at Mario in World 4-1 of Super Mario Bros.	https://mario.wiki.gallery/images/2/25/Lakitu_throwing_Spiny_SMB1.png	256	240
75	Map of World 4-1	https://mario.wiki.gallery/images/4/48/SMB_NES_World_4-1_Map.png	4096	240
76	Lakitu throwing Spinies at Mario in World 4-1 of Super Mario Bros.	https://mario.wiki.gallery/images/2/25/Lakitu_throwing_Spiny_SMB1.png	256	240
77	Map of World 4-2	https://mario.wiki.gallery/images/7/79/SMB_NES_World_4-2_Map.png	5632	240
78	Lakitu throwing Spinies at Mario in World 4-1 of Super Mario Bros.	https://mario.wiki.gallery/images/2/25/Lakitu_throwing_Spiny_SMB1.png	256	240
79	Map of World 4-3	https://mario.wiki.gallery/images/e/e0/SMB_NES_World_4-3_Map.png	2544	240
80	Lakitu throwing Spinies at Mario in World 4-1 of Super Mario Bros.	https://mario.wiki.gallery/images/2/25/Lakitu_throwing_Spiny_SMB1.png	256	240
81	Map of World 4-4	https://mario.wiki.gallery/images/8/83/SMB_NES_World_4-4_Map.png	3072	240
82	Screenshot of World 5-1 in Super Mario Bros.	https://mario.wiki.gallery/images/6/6b/SMB_NES_World_5-1_Screenshot.png	256	224
83	Map of World 5-1	https://mario.wiki.gallery/images/1/1b/SMB_NES_World_5-1_Map.png	3584	240
84	Screenshot of World 5-1 in Super Mario Bros.	https://mario.wiki.gallery/images/6/6b/SMB_NES_World_5-1_Screenshot.png	256	224
85	Map of World 5-2	https://mario.wiki.gallery/images/a/af/SMB_NES_World_5-2_Map.png	5712	240
86	Screenshot of World 5-1 in Super Mario Bros.	https://mario.wiki.gallery/images/6/6b/SMB_NES_World_5-1_Screenshot.png	256	224
87	Map of World 5-3	https://mario.wiki.gallery/images/2/2d/SMB_NES_World_5-3_Map.png	2624	240
88	Screenshot of World 5-1 in Super Mario Bros.	https://mario.wiki.gallery/images/6/6b/SMB_NES_World_5-1_Screenshot.png	256	224
89	Map of World 5-4	https://mario.wiki.gallery/images/5/5e/SMB_NES_World_5-4_Map.png	2560	240
90	SMB NES World 6-3 Screenshot.png	https://mario.wiki.gallery/images/0/0f/SMB_NES_World_6-3_Screenshot.png	256	240
91	Map of World 6-1	https://mario.wiki.gallery/images/7/7b/SMB_NES_World_6-1_Map.png	3184	240
92	SMB NES World 6-3 Screenshot.png	https://mario.wiki.gallery/images/0/0f/SMB_NES_World_6-3_Screenshot.png	256	240
93	Map of World 6-2	https://mario.wiki.gallery/images/b/bf/SMB_NES_World_6-2_Map.png	6672	240
94	SMB NES World 6-3 Screenshot.png	https://mario.wiki.gallery/images/0/0f/SMB_NES_World_6-3_Screenshot.png	256	240
95	Map of World 6-3	https://mario.wiki.gallery/images/2/2d/SMB_NES_World_6-3_Map.png	2864	240
96	SMB NES World 6-3 Screenshot.png	https://mario.wiki.gallery/images/0/0f/SMB_NES_World_6-3_Screenshot.png	256	240
97	Map of World 6-4	https://mario.wiki.gallery/images/8/86/SMB_NES_World_6-4_Map.png	2560	240
98	World 7	https://mario.wiki.gallery/images/0/06/SMB_NES_World_7-1_Screenshot.png	256	240
99	Map of World 7-1	https://mario.wiki.gallery/images/3/36/SMB_NES_World_7-1_Map.png	3328	240
100	World 7	https://mario.wiki.gallery/images/0/06/SMB_NES_World_7-1_Screenshot.png	256	240
101	Map of World 7-2	https://mario.wiki.gallery/images/b/b3/SMB_NES_World_7-2_Map.png	3840	240
102	World 7	https://mario.wiki.gallery/images/0/06/SMB_NES_World_7-1_Screenshot.png	256	240
103	Map of World 7-3	https://mario.wiki.gallery/images/a/a8/SMB_NES_World_7-3_Map.png	3792	240
104	World 7	https://mario.wiki.gallery/images/0/06/SMB_NES_World_7-1_Screenshot.png	256	240
105	Map of World 7-4	https://mario.wiki.gallery/images/e/ed/SMB_NES_World_7-4_Map.png	3584	240
106	World 8-3	https://mario.wiki.gallery/images/5/59/SMB_World_8-3_Screenshot.png	256	240
107	Map of World 8-1	https://mario.wiki.gallery/images/f/fc/SMB_NES_World_8-1_Map.png	6480	240
108	World 8-3	https://mario.wiki.gallery/images/5/59/SMB_World_8-3_Screenshot.png	256	240
109	Map of World 8-2	https://mario.wiki.gallery/images/d/d3/SMB_NES_World_8-2_Map.png	3888	240
110	World 8-3	https://mario.wiki.gallery/images/5/59/SMB_World_8-3_Screenshot.png	256	240
111	Map of World 8-3	https://mario.wiki.gallery/images/b/bc/SMB_NES_World_8-3_Map.png	3664	240
112	World 8-3	https://mario.wiki.gallery/images/5/59/SMB_World_8-3_Screenshot.png	256	240
113	Map of World 8-4	https://mario.wiki.gallery/images/b/bc/SMB_NES_World_8-4_Map.png	6272	240
\.


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.item (id, name, description, detail_url, image_id) FROM stdin;
1	1 up Mushroom	Green mushrooms that give Mario an extra life when collected. 1 up mushrooms are within invisible blocks near pits. When one is struck, the mushroom travels across the ground in the opposite direction from Mario.	https://www.mariowiki.com/1-Up_Mushroom	5
2	Coin	Coins float in mid-air throughout levels and within blocks. Collecting one awards Mario 200 points. Collecting 100 awards him an extra life.	https://www.mariowiki.com/Coin	6
3	Koopa shell	Stomping on a Koopa Troopa makes it recede into its shell. Its sent sliding when touched, defeating enemies on contact. Doing so causes the "bulldozer attack", where each enemy defeated grants Mario more points than the last. Launched shells ricochet off collided walls and can damage Mario on contact.	https://www.mariowiki.com/Koopa_Shell	7
4	Buzzy shell	Stomping on a Buzzy Beetle yields a shell that works like the Koopa ones, but it cannot be cleared away with tossed fireballs.	https://www.mariowiki.com/Buzzy_Shell	8
\.


--
-- Data for Name: level; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.level (id, name, detail_url, setting_id, image_id, course_map_image_id) FROM stdin;
1	World 1-1	https://www.mariowiki.com/World_1-1_(Super_Mario_Bros.)	5	50	51
2	World 1-2	https://www.mariowiki.com/World_1-2_(Super_Mario_Bros.)	3	52	53
3	World 1-3	https://www.mariowiki.com/World_1-3_(Super_Mario_Bros.)	4	54	55
4	World 1-4	https://www.mariowiki.com/World_1-4_(Super_Mario_Bros.)	1	56	57
5	World 2-1	https://www.mariowiki.com/World_2-1_(Super_Mario_Bros.)	5	58	59
6	World 2-2	https://www.mariowiki.com/World_2-2_(Super_Mario_Bros.)	2	60	61
7	World 2-3	https://www.mariowiki.com/World_2-3_(Super_Mario_Bros.)	4	62	63
8	World 2-4	https://www.mariowiki.com/World_2-4_(Super_Mario_Bros.)	1	64	65
9	World 3-1	https://www.mariowiki.com/World_3-1_(Super_Mario_Bros.)	5	66	67
10	World 3-2	https://www.mariowiki.com/World_3-2_(Super_Mario_Bros.)	5	68	69
11	World 3-3	https://www.mariowiki.com/World_3-3_(Super_Mario_Bros.)	4	70	71
12	World 3-4	https://www.mariowiki.com/World_3-4_(Super_Mario_Bros.)	1	72	73
13	World 4-1	https://www.mariowiki.com/World_4-1_(Super_Mario_Bros.)	5	74	75
14	World 4-2	https://www.mariowiki.com/World_4-2_(Super_Mario_Bros.)	3	76	77
15	World 4-3	https://www.mariowiki.com/World_4-3_(Super_Mario_Bros.)	4	78	79
16	World 4-4	https://www.mariowiki.com/World_4-4_(Super_Mario_Bros.)	1	80	81
17	World 5-1	https://www.mariowiki.com/World_5-1_(Super_Mario_Bros.)	5	82	83
18	World 5-2	https://www.mariowiki.com/World_5-2_(Super_Mario_Bros.)	5	84	85
19	World 5-3	https://www.mariowiki.com/World_5-3_(Super_Mario_Bros.)	4	86	87
20	World 5-4	https://www.mariowiki.com/World_5-4_(Super_Mario_Bros.)	1	88	89
21	World 6-1	https://www.mariowiki.com/World_6-1_(Super_Mario_Bros.)	5	90	91
22	World 6-2	https://www.mariowiki.com/World_6-2_(Super_Mario_Bros.)	5	92	93
23	World 6-3	https://www.mariowiki.com/World_6-3_(Super_Mario_Bros.)	4	94	95
24	World 6-4	https://www.mariowiki.com/World_6-4_(Super_Mario_Bros.)	1	96	97
25	World 7-1	https://www.mariowiki.com/World_7-1_(Super_Mario_Bros.)	5	98	99
26	World 7-2	https://www.mariowiki.com/World_7-2_(Super_Mario_Bros.)	2	100	101
27	World 7-3	https://www.mariowiki.com/World_7-3_(Super_Mario_Bros.)	4	102	103
28	World 7-4	https://www.mariowiki.com/World_7-4_(Super_Mario_Bros.)	1	104	105
29	World 8-1	https://www.mariowiki.com/World_8-1_(Super_Mario_Bros.)	5	106	107
30	World 8-2	https://www.mariowiki.com/World_8-2_(Super_Mario_Bros.)	5	108	109
31	World 8-3	https://www.mariowiki.com/World_8-3_(Super_Mario_Bros.)	5	110	111
32	World 8-4	https://www.mariowiki.com/World_8-4_(Super_Mario_Bros.)	1	112	113
\.


--
-- Data for Name: level_enemy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.level_enemy (level_id, enemy_id, count) FROM stdin;
1	5	16
1	6	1
2	5	14
2	6	3
2	13	4
3	5	3
3	6	3
3	7	2
4	5	1
5	5	16
5	6	6
5	7	3
5	13	8
6	14	-1
6	16	6
6	13	1
7	14	-1
8	6	1
9	5	14
9	6	7
9	7	5
9	13	5
9	9	2
10	5	15
10	6	19
10	7	1
10	13	1
11	5	1
11	6	5
11	7	1
12	8	1
13	10	-1
13	13	4
13	12	-1
14	5	3
14	6	6
14	8	4
14	13	10
15	6	5
15	7	1
16	13	1
16	10	1
17	5	21
17	6	6
17	7	4
17	13	4
17	15	-1
18	5	4
18	6	1
18	7	5
18	8	3
18	13	3
18	15	-1
18	9	4
18	14	-1
18	16	3
19	5	3
19	6	3
19	7	2
19	15	-1
20	12	1
21	10	-1
21	13	1
21	12	-1
22	5	4
22	6	1
22	7	2
22	8	4
22	13	28
22	14	-1
22	16	3
23	15	-1
24	16	1
25	6	1
25	7	4
25	8	1
25	13	5
25	9	4
25	15	-1
26	14	-1
26	16	13
26	13	1
27	6	1
27	7	3
27	14	-1
28	9	1
29	5	26
29	6	17
29	7	3
29	8	4
29	13	12
30	5	2
30	7	12
30	10	-1
30	8	4
30	13	4
30	15	-1
30	12	-1
31	6	1
31	7	2
31	13	3
31	15	-1
31	9	8
32	5	3
32	7	4
32	8	2
32	13	16
32	9	1
32	14	-1
32	16	3
\.


--
-- Data for Name: level_item; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.level_item (level_id, item_id, count) FROM stdin;
1	2	39
1	1	1
2	2	68
2	1	1
3	2	23
4	2	6
5	2	89
5	1	1
6	2	28
7	2	35
8	2	6
9	2	80
9	1	1
10	2	17
11	2	22
12	2	5
13	2	62
13	1	1
14	2	81
15	2	27
17	2	20
17	1	1
18	2	87
19	2	23
20	2	6
21	2	31
21	1	1
22	2	122
23	2	24
24	2	6
25	2	33
25	1	1
26	2	28
27	2	35
29	2	53
29	1	1
30	2	34
30	1	1
31	2	10
32	2	1
\.


--
-- Data for Name: level_obstacle; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.level_obstacle (level_id, obstacle_id, count) FROM stdin;
4	1	7
8	1	6
12	1	9
16	1	5
17	4	3
18	4	2
20	1	11
24	1	11
25	4	13
28	1	1
30	4	10
31	4	3
32	1	5
\.


--
-- Data for Name: level_power_up; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.level_power_up (level_id, power_up_id, count) FROM stdin;
1	2	3
1	3	3
1	4	1
2	2	3
2	3	3
2	4	1
3	2	1
3	3	1
4	2	1
4	3	1
5	2	4
5	3	4
5	4	1
7	2	1
7	3	1
8	2	1
8	3	1
9	2	4
9	3	4
9	4	1
10	2	1
10	3	1
10	4	1
11	2	1
11	3	1
12	2	1
12	3	1
13	2	3
13	3	3
14	2	4
14	3	4
14	4	1
15	2	1
15	3	1
17	4	1
18	2	3
18	3	3
18	4	1
19	2	1
19	3	1
20	2	1
20	3	1
21	2	2
21	3	2
22	2	2
22	3	2
22	4	1
23	2	1
23	3	1
24	2	1
24	3	1
25	2	2
25	3	2
27	2	1
27	3	1
29	4	1
30	2	1
30	3	1
31	2	2
31	3	2
\.


--
-- Data for Name: npc; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.npc (id) FROM stdin;
3
4
\.


--
-- Data for Name: object; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.object (id, name, description, detail_url, image_id) FROM stdin;
1	? block	Floating blocks that contain items. One releases its contents when jumped underneath. Some ? blocks are ten-coin blocks that release up to 10 coins if struck in rapid succession. Others are invisible. A struck ? block becomes an empty block that can be used as platforms. These are the only type of strikable blocks that regular Mario can open.	https://www.mariowiki.com/%3F_Block	9
2	Brick	The most common blocks. Most bricks fall apart when struck, but some are secretly ? or ten-coin blocks. Regular Mario is incapable of directly breaking a brick block, but he can still use a shell if available.	https://www.mariowiki.com/Brick_Block	10
3	Coral	Coral form varyingly sized columns in underwater levels that obstruct Mario.	https://www.mariowiki.com/Coral	11
4	Small cloud	Cloud-like blocks make up the terrain in Bonus Stages high in the sky.	https://www.mariowiki.com/Cloud_Block	12
5	Stairblock	Unbreakable blocks that appear on the ground. Some are stacked or laid next to each other to form climbable staircases or incomplete bridges.	https://www.mariowiki.com/Hard_Block	13
6	Jumping board	Jumping boards bounce Mario into the air. Pressing  when the the spring is fully contracted makes a jumping board launch Mario much higher than it would otherwise.	https://www.mariowiki.com/Trampoline	14
7	Lift	Thin, moving platforms. They are most common in athletic levels, above bottomless pits. Lifts are of varying widths and movements. There is a paired type of Lifts called Balance Lifts that are a seesaw-like pulley system, where standing on one Lift makes it fall and the other rise. There are also types of Lifts that fall shortly after being stepped on.	https://www.mariowiki.com/Lift	15
8	Pipe	Most pipes are columnar platforms of varying height, some of which contain Piranha plants. A few of them are Warp Pipes that bring Mario to a secret underground area by pressing down on .	https://www.mariowiki.com/Warp_Pipe	16
9	Super mushroom	Giant mushrooms that occur in athletic levels, high above bottomless pits.	https://www.mariowiki.com/Mushroom_Platform	17
10	Ax	Touching an ax causes the bridge it is alongside to collapse. This defeats the boss that was on top of it and completes the level.	https://www.mariowiki.com/Axe	18
11	Flagpole	Flagpoles are the goals at the end of most levels. When one is touched, Mario slides to the base and completes the level. Touching one also rewards him bonus points. The higher he is on the flagpole, the greater the number of points. Grabbing the top rewards Mario 5000 points.	https://www.mariowiki.com/Goal_Pole	19
12	Beanstalk	Beanstalks rapidly grow from struck vine blocks, ascending skyward. Climbing one brings Mario to a hidden Bonus Stage in the sky.	https://www.mariowiki.com/Vine	20
13	Firework	Fireworks appear if Mario grabs a flagpole with 1, 3, or 6 as the last digit on the timer. The number of fireworks that go off correlates with this number, and each one rewards Mario 500 points.	https://www.mariowiki.com/Firework	21
14	Horsehair plant	Field horsehair plants appear in the background of ground-themed levels. According to the instruction booklet, Bowser transformed some of the Mushroom Kingdom's inhabitants into these plants.	https://www.mariowiki.com/Horsetail	22
\.


--
-- Data for Name: obstacle; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.obstacle (id, name, description, detail_url, image_id) FROM stdin;
1	Fire-Bar	Various fireballs stacked together moving either clockwise or counterclockwise. Their length may vary.	https://www.mariowiki.com/Fire_Bar	1
2	Koopa's fire	Flames spewed by Bowser and his imposters. The fire travels horizontally and transcends walls.	https://www.mariowiki.com/Fire_Breath	2
3	Lava	Pools of molten rock found within fortresses and castles. Direct contact makes Mario lose a life.	https://www.mariowiki.com/Lava	3
4	Turtle Cannon	Cannons that launch Bullet Bills. Like the pipes that contain Piranha plants, Turtle Cannons do not fire when Mario is next to or on them.	https://www.mariowiki.com/Bill_Blaster	4
\.


--
-- Data for Name: pc; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.pc (id) FROM stdin;
1
2
\.


--
-- Data for Name: power_up; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.power_up (id, name, description, detail_url, image_id) FROM stdin;
1	\N	Mario is in this small-sized form when the player starts a new game. Regular Mario is incapable of breaking bricks and loses a life when he makes contact with an enemy or obstacle. However, he can run across narrow passageways without having to crouch. Regardless of the form he was in before losing a life, Mario reappears in the level in his regular form.	\N	\N
2	Magic Mushroom	The red Magic Mushrooms are within visible blocks and slide across the ground, similar to 1 up mushrooms. They bounce back in the opposite direction when they hit an obstruction. Touching one transforms Mario into Super Mario, a form twice as tall as his regular form and capable of breaking bricks. Subsequent encounters with blocks intended to contain Magic Mushrooms instead release Fire Flowers when struck in this form. Receiving damaging in this form reverts Mario back into his regular-sized state. He retains this form across levels if he reaches flagpoles as Super Mario.	https://www.mariowiki.com/Super_Mushroom	\N
3	Fire Flower	Making contact with a Fire Flower transforms Mario into Fiery Mario. In this form, Mario can toss projectile fireballs with  that bounce along the ground. Most enemies are defeated when hit. Fiery Mario also has all the benefits of Super Mario, and similarly retains this form if he completes the level in it. Mario reverts to his regular size if hit as Fiery Mario.	https://www.mariowiki.com/Fire_Flower	\N
4	Starman	Starmen are rare power-ups often hidden in invisible blocks. When released, they bounce in the opposite direction from Mario. When grabbed, Mario is transformed into Invincible Mario for thirty seconds. In this state, Mario is largely indestructible and defeats enemies on contact. Contact with the Starman does not wholly replace the form Mario was already in (i.e., Mario remains small if one is touched while in his regular form, and he can still toss fireballs if he is in his Fiery form.) Invincible Mario cannot be carried over to subsequent levels.	https://www.mariowiki.com/Super_Star	\N
\.


--
-- Data for Name: reference; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.reference (id, name, description, detail_url, type) FROM stdin;
1	Donkey Kong	The design for lifts resembles the girders seen in 100m.	https://www.mariowiki.com/Donkey_Kong_(game)	to_other_games
2	Donkey Kong Jr.	Trampolines return with a similar design.	https://www.mariowiki.com/Donkey_Kong_Jr._(game)	to_other_games
3	Mario Bros.	Green pipes, coins and blocks, introduced to the Mario universe in this game, return. Koopa Troopas are derived from this game's Shellcreepers.	https://www.mariowiki.com/Mario_Bros._(game)	to_other_games
4	Donkey Kong	For the NES release of this game, Mario's jumping sprite from Super Mario Bros. is used on the box art.	https://www.mariowiki.com/Donkey_Kong_(game)	in_other_games
5	Mario Bros.	For the NES release of this game, Mario's jumping sprite from Super  is used on the box art.	https://www.mariowiki.com/Mario_Bros._(game)	in_other_games
6	Super Mario Bros. 2	The non-Japanese sequel to Super Mario Bros. Mushrooms, Stars, and Shells appear.	https://www.mariowiki.com/Super_Mario_Bros._2	in_later_games
7	Super Mario Bros. 3	Bowser returns along with the rest of the Koopa Troop, as well as elements from the original Super Mario Bros. When Princess Toadstool is saved, she says, "Thank you! But our Princess is in another castle!…Just kidding!" That is a reference to Toad's lines in Super Mario Bros.  The original Super Mario Bros. Ground Theme plays when the Music Box is used.	https://www.mariowiki.com/Super_Mario_Bros._3	in_later_games
8	Super Mario Land	Mario's sprites in this game is near identical to his sprites from Super Mario Bros. Gameplay is also near-identical.	https://www.mariowiki.com/Super_Mario_Land	in_later_games
9	Alleyway	Several sprites from Super Mario Bros. appear in bonus levels.	https://www.mariowiki.com/Alleyway	in_later_games
10	Super Mario World 2: Yoshi's Island	The course clear fanfare can be heard after Baby Mario and Baby Luigi return to their home.	https://www.mariowiki.com/Super_Mario_World_2:_Yoshi%27s_Island	in_later_games
11	Super Mario RPG: Legend of the Seven Stars	If the player goes behind a curtain in Booster Tower, Mario briefly turns into his 8-bit sprite from Super Mario Bros.	https://www.mariowiki.com/Super_Mario_RPG:_Legend_of_the_Seven_Stars	in_later_games
12	Super Mario 64	Outside the Warp Pipe that leads to the final boss, carved into pillars are what look like sprites of Mario and Bowser from Super Mario Bros.	https://www.mariowiki.com/Super_Mario_64	in_later_games
13	Paper Mario	The Thousand-Year Door, his allies will not become an 8-bit form. Goombario also references Super Mario Bros. in the Goomba's Tattle entry.	https://www.mariowiki.com/Paper_Mario	in_later_games
14	Super Smash Bros.	When Mario performs his taunt, he mimics his standing pose in Super Mario Bros. Also, Mario's and Luigi's victory fanfare is a version of the course clear theme. Mario and Luigi's helpless animations are based on the pose Mario and Luigi take upon defeat in Super Mario Bros. Many items from Super Mario Bros. are usable in this game. One of Luigi's alternate colors bears resemblance to his colors in Super Mario Bros.	https://www.mariowiki.com/Super_Smash_Bros.	in_later_games
15	Game & Watch Gallery 3	Playing Star Mode for the Modern version of Donkey Kong Jr. will have the Goomba enemies being replaced by Spinies, similar to the new quest mode in Super Mario Bros. replacing the Goombas with Buzzy Beetles.	https://www.mariowiki.com/Game_%26_Watch_Gallery_3	in_later_games
16	Luigi's Mansion	Although not distinctly noted as such, the idea of King Boo using a Bowser decoy (through the magic of his) may be loosely based on the seven fake Bowsers in Super Mario Bros.	https://www.mariowiki.com/Luigi%27s_Mansion	in_later_games
17	Super Smash Bros. Melee	Many enemies from Super Mario Bros. appear in this game's Adventure Mode.	https://www.mariowiki.com/Super_Smash_Bros._Melee	in_later_games
18	Super Mario Sunshine	A castle level is seen when Mario first met F.L.U.D.D. Various 8-bit patterns are seen in the background of the secret levels of Ricco Harbor and Sirena Beach.	https://www.mariowiki.com/Super_Mario_Sunshine	in_later_games
19	Super Mario Advance 4: Super Mario Bros. 3	Some of the available levels for World-e include reproductions of Super Mario Bros.'s Worlds 1-1, 1-2, 1-3, 1-4, and 2-2 in Super Mario Bros. 3's style. Only World 1-1 was originally made available outside Japan.	https://www.mariowiki.com/Super_Mario_Advance_4:_Super_Mario_Bros._3	in_later_games
20	Game & Watch Gallery 4	Like in Game & Watch Gallery 3 above, playing Star Mode for the Modern version of Donkey Kong Jr. will have the Goomba enemies being replaced by Spinies, similar to the new quest mode in Super Mario Bros. replacing the Goombas with Buzzy Beetles.	https://www.mariowiki.com/Game_%26_Watch_Gallery_4	in_later_games
21	Mario & Luigi: Superstar Saga	At the Border between the Mushroom Kingdom and the Beanbean Kingdom, there's a minigame called Border Jump that uses the level end of most levels in Super Mario Bros. (including the flagpole, fortress, and fireworks for success). Also, there is a 2D obstacle room before Roy's room which ends with Mario getting the ax and burning the Bowser decoy above a lava bridge. A type of Question Block from Super Mario Bros. can be seen among other types.	https://www.mariowiki.com/Mario_%26_Luigi:_Superstar_Saga	in_later_games
22	Paper Mario: The Thousand-Year Door	If the player jumps up into a vent and then comes down into the changing room in the X-Naut Fortress then Mario and all his allies will become 8-bit and similar in style to the Super Mario Bros. sprites.	https://www.mariowiki.com/Paper_Mario:_The_Thousand-Year_Door	in_later_games
23	Mario Superstar Baseball	The loading screen has Mario hitting a ? Block in graphics from Super Mario Bros.	https://www.mariowiki.com/Mario_Superstar_Baseball	in_later_games
24	Mario & Luigi: Partners in Time	Toadsworth the Younger states when Baby Peach flies away "You will save her, won't you? I assure you she's NOT in another castle.", referencing the mushroom retainers' famous line "Thank you, Mario! But our princess is in another castle!".	https://www.mariowiki.com/Mario_%26_Luigi:_Partners_in_Time	in_later_games
25	Tetris DS	The first two levels were World 1-1, 3 and 7 were underground based, 8 and 9 are up in heights, and 10 was a castle.	https://www.mariowiki.com/Tetris_DS	in_later_games
26	New Super Mario Bros.	Many things from Super Mario Bros. return here, such as flagpoles, Warp Zones (in the form of cannons), and the title screen's logo typeface. When connecting to a multiplayer game, Mario can be seen running what looks like World 1-2. Also, a close-up of Mario from Super Mario Bros. as well as a picture from said game are unlockable backgrounds. The sound effect that plays when Mario or Luigi slides down the Goal Pole is reused, albeit in reversed form. One of the multiplayer stages is a truncated looping version of World 1-1. The second level is a cave level with a secret path over the ceiling leading to a secret exit, similar to the secret path over this game's World 1-2. The main boss of World 1 is Bowser, who is defeated by breaking his bridge and dropping him into lava, and the first main boss of World 8 features Dry Bowser, who is defeated in the same way, and throws bones like how Bowser threw hammers in later levels of this game.	https://www.mariowiki.com/New_Super_Mario_Bros.	in_later_games
27	Mario Hoops 3-on-3	In Mario Stadium, one can see an 8-bit Mario chasing two Goombas. Also, the music for Bowser's Castle is a cover of the Castle Theme.	https://www.mariowiki.com/Mario_Hoops_3-on-3	in_later_games
28	Super Paper Mario	The sprites of Mario, Luigi, Peach, and Bowser appear around said character when they collect the Pal Pills. Also, when any character (including a Koopa Troopa) grabs a Mega Star, they turn into a huge version of their Super Mario Bros. sprites. (Mario and Luigi are their Small forms in both). Portions of Chapter 1-1, Chapter 3-1, and Chapter 5-3 are also identical to Worlds 1-1, 1-2, and 2-1, respectively.	https://www.mariowiki.com/Super_Paper_Mario	in_later_games
29	Super Mario Galaxy	In Toy Time Galaxy, there's a huge 8-bit Mario/Luigi. Also in Flipswitch Galaxy, the background contains an overworld scene and an underground scene from this game.	https://www.mariowiki.com/Super_Mario_Galaxy	in_later_games
30	Super Smash Bros. Brawl	The stage Mushroomy Kingdom is based on Worlds 1-1 and 1-2 of this game. Lakitu and Spinies and Hammer Bro appear as Assist Trophies. Lakitu and Spinies retain their original 8-bit look from Super Mario Bros. Also, many enemies from Super Mario Bros. appear in this game's Subspace Emissary Mode.	https://www.mariowiki.com/Super_Smash_Bros._Brawl	in_later_games
31	WarioWare: D.I.Y.	The Crayon Epic microgame features a monster spitting fireballs identical to Lava Bubble's sprite from this game.	https://www.mariowiki.com/WarioWare:_D.I.Y.	in_later_games
32	New Super Mario Bros. Wii	The second level of Coin Courses looks exactly like World 1-1 from Super Mario Bros.	https://www.mariowiki.com/New_Super_Mario_Bros._Wii	in_later_games
33	Super Mario Galaxy 2	In Twisty Trials Galaxy  and the second area of the Grandmaster Galaxy, there is a backdrop showing moving sprites of items and an 8-bit Mario and Luigi from this game. Mario Squared Galaxy takes place on an 8-bit Mario, as well as an 8-bit Luigi (during the mission "Luigi's Purple Coin Chaos"), Mario and Luigi's sprites from this game.	https://www.mariowiki.com/Super_Mario_Galaxy_2	in_later_games
34	Super Mario 3D Land	Mario's sprite from Super Mario Bros. is used as the marker of where Mario is in a world. Tail Bowsers are similar to Fake Bowsers, and the first one is a disguised Goomba. The second level has a ledge just out of view that allows the player to walk over the level, and ends in a secret Pipe.	https://www.mariowiki.com/Super_Mario_3D_Land	in_later_games
35	Mario Kart 7	Piranha Plant Slide is heavily based on the underground levels of Super Mario Bros. The cloud and bushes in the race course are the same model in different colors, referencing how the clouds and bushes in Super Mario Bros. are the same sprite in different colors.	https://www.mariowiki.com/Mario_Kart_7	in_later_games
36	New Super Mario Bros. 2	The first course in Coin Rush's Gold Classics Pack is based on Worlds 1-1 and 1-2. Also, the last course is based on World 1-4.	https://www.mariowiki.com/New_Super_Mario_Bros._2	in_later_games
37	New Super Mario Bros. U	Sprites from Super Mario Bros. are used in the game menus. The second level is an underground course with a secret path over the ceiling leading to a secret exit. The first phase of the final boss involves striking an ax to Bowser's bridge to drop him into lava.	https://www.mariowiki.com/New_Super_Mario_Bros._U	in_later_games
38	New Super Luigi U	Various sprites of Luigi are reused as hidden Luigis.	https://www.mariowiki.com/New_Super_Luigi_U	in_later_games
39	Super Mario 3D World	Mario's sprite from Super Mario Bros. is seen on the saving screen. His sprite can also be seen in a bonus area of Bob-ombs Below. Luigi's sprite can be spotted in some levels and on the button to enter the Luigi Bros. game.	https://www.mariowiki.com/Super_Mario_3D_World	in_later_games
40	NES Remix	Super Mario Bros. is a game remixed in this game.	https://www.mariowiki.com/NES_Remix	in_later_games
41	Mario Party: Island Tour	The theme heard in the minigames Xylophone Home and Goomba Tower Takedown is a remix of the Ground Theme.	https://www.mariowiki.com/Mario_Party:_Island_Tour	in_later_games
42	NES Remix 2	A port of the game titled Super Luigi Bros. appears, where the player controls Luigi, and all the levels are mirrored.	https://www.mariowiki.com/NES_Remix_2	in_later_games
43	Mario Kart 8	Various sprites of enemies and scenery can be seen on pots in Bone-Dry Dunes. Super Bell Subway has graffiti representing World 1-2. Also, Piranha Plant Slide, which is based heavily on the underground levels of Super Mario Bros., returns from Mario Kart 7.	https://www.mariowiki.com/Mario_Kart_8	in_later_games
44	Super Smash Bros. for Nintendo 3DS / Wii U	Fire Bars appear as an item in these games. In Super Smash Bros. for Nintendo 3DS, the Mushroomy Kingdom stage from Super Mario Bros., returns from Super Smash Bros. Brawl, though without World 1-2.	https://www.mariowiki.com/Super_Smash_Bros._for_Nintendo_3DS_/_Wii_U	in_later_games
45	Ultimate NES Remix	A port of the game titled Speed Mario Bros. appears in which the game runs twice as fast.	https://www.mariowiki.com/Ultimate_NES_Remix	in_later_games
46	Yoshi's Woolly World	The Shell Patch enemy greatly resembles a Red Shell's sprite in this game.	https://www.mariowiki.com/Yoshi%27s_Woolly_World	in_later_games
47	Super Mario Maker	The game is used as one of the graphical styles for these games.	https://www.mariowiki.com/Super_Mario_Maker	in_later_games
48	Mario & Sonic at the Rio 2016 Olympic Games (Nintendo 3DS)	A structure in the shape of a Castle from Super Mario Bros. made of Brick Blocks and character wall obstacles of Mario, Bowser, Lakitu, Spinies and Goombas using their sprites from Super Mario Bros. appear as obstacles in Golf Plus.	https://www.mariowiki.com/Mario_%26_Sonic_at_the_Rio_2016_Olympic_Games_(Nintendo_3DS)	in_later_games
49	Super Mario Odyssey	In some parts of the game, Mario can walk within walls from a 2D perspective that uses sprites and sound effects from Super Mario Bros., as well as altering the music to an 8-bit variation. A scene of Mario confronting Bowser in Super Mario Bros. can be seen when Mario captures Bowser in this game. A replica of World 1-1 can be played in a theater in New Donk City.	https://www.mariowiki.com/Super_Mario_Odyssey	in_later_games
50	Super Mario Party	Mario's, Goomba's, Spiny's, Cheep Cheep's, and Bowser's sprites appear in Puzzle Hustle. Dart Gallery's background features neon lights resembling Super Mario Bros.'s overworld levels.	https://www.mariowiki.com/Super_Mario_Party	in_later_games
51	Super Smash Bros. Ultimate	The Mushroom Kingdom stage from Super Smash Bros. returns in this game, along with Mushroomy Kingdom.	https://www.mariowiki.com/Super_Smash_Bros._Ultimate	in_later_games
52	Mario Kart Tour	The 8-Bit Jumping Mario, 8-Bit Jumping Luigi, 8-Bit Star, 8-Bit Bullet Bill, 8-Bit Fire Flower, 8-Bit Super Mushroom, 8-Bit Block Glider, and 8-Bit Goomba are re-creations of their sprites in Super Mario Bros. The Super 1 uses the Japanese logo of Super Mario Bros.	https://www.mariowiki.com/Mario_Kart_Tour	in_later_games
53	Mario & Sonic at the Olympic Games Tokyo 2020	The sprites for Mario, Luigi, Princess Toadstool, Bowser, Little Goombas, Koopa Troopas, Hammer Bros, Lakitus, and Mushroom Retainers are reused in the 2D Events. In these events differently colored Toads appear which have sprites that are based on the sprite for red Mushroom Retainers in Super Mario Bros.	https://www.mariowiki.com/Mario_%26_Sonic_at_the_Olympic_Games_Tokyo_2020	in_later_games
54	Mario + Rabbids Sparks of Hope	Whenever Rabbid Mario retrieves a Purified Darkmess Energy Crystal, he plays the Course Clear theme on his mandolin.	https://www.mariowiki.com/Mario_%2B_Rabbids_Sparks_of_Hope	in_later_games
55	Super Mario Bros. Wonder	Launch to Victory, during the Wonder Flower's effect, there is a block formation referencing the Fire Flower sprite.	https://www.mariowiki.com/Super_Mario_Bros._Wonder	in_later_games
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.setting (id, name) FROM stdin;
1	Castle
2	Underwater
3	Underground
4	Athletic
5	Overworld
\.


--
-- Data for Name: version; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.version (id, year, description) FROM stdin;
1	1985	Original Nintendo Entertainment System release (North America/Japan)
2	1986	Re-released on the Family Computer Disk System in Japan as one of the launch titles.
3	1986	Released for the arcade VS. System as VS. Super Mario Bros.
4	1986	A Game & Watch titled Super Mario Bros. is released, but it is a completely different game.
5	1986	Ported into the arcade machine Nintendo PlayChoice-10.
6	1986	Released on the Family Computer Disk System as All Night Nippon: Super Mario Bros. Most of the levels have been reused but the physics engine is from Super Mario Bros.: The Lost Levels.
7	1987	Original Nintendo Entertainment System release (Europe/Australia)
8	1988	Re-released on the NES in North America as part of the 2-in-1 Super Mario Bros./Duck Hunt compilation, packaged with the NES Action Set.
9	1989	A Nelsonic Game Watch titled Super Mario Bros. is released, but it is a completely different game.
10	1990	Re-released on the NES in North America as part of the 3-in-1 Super Mario Bros./Duck Hunt/World Class Track Meet compilation, packaged with the NES Power Set.
11	1990	Re-released on the NES as part of Nintendo World Championships 1990.
12	1992	Re-released on the NES in Europe as part of the 3-in-1 Super Mario Bros./Tetris/Nintendo World Cup compilation, sold alone or with the Top Loader.
13	1993	Remake available on the Super Nintendo Entertainment System as part of the Super Mario All-Stars compilation. Graphics and sound were updated, and many glitches were removed.
14	1994	Remake available on the SNES in North America as part of the Super Mario All-Stars + Super Mario World compilation, packaged with the SNES Mario Set.
15	1997	A special version is released as a Satellaview broadcast titled BS Super Mario Collection - Dai-1-Shuu, which is based on the Super Mario All-Stars version.
16	1999	Remake released on the Game Boy Color as Super Mario Bros. Deluxe. The game featured the original game's graphics but loads of additional content.
17	2001	The original game is available as an unlockable NES game in Doubutsu no Mori+. In Japan, it is obtainable only through the thirty Nintendo GameCube Memory Cards that were distributed as part of a sweepstakes in Famitsu magazine.[25] In the international release, it can only be unlocked by using a cheating device. It was likely going to be released as an e-Reader card (as were Ice Climber and Mario Bros.), but a Super Mario Bros. card was never released. In the Japan-only re-release, Doubutsu no Mori e+, the game is removed altogether.
18	2003	In celebrating 20 years of the Famicom in Japan, Nintendo ran a "Hot Mario Campaign" from November 7, 2003 to January 15, 2004, in which the prize was a special edition of Super Mario Bros. alongside a Famicom-themed Game Boy Advance.[26][27]
19	2004	The original game was re-released on the Game Boy Advance as part of the NES Classics / Famicom Mini collection, celebrating 20 years of the Famicom in Japan. It was also re-released on September 13, 2005, in Japan to celebrate 20 years of the original NES game.
20	2006	Available on the Wii as part of the Virtual Console. It requires 23 blocks (2.9 MB) to be installed.
21	2008	Available as a playable demo in Super Smash Bros. Brawl.
22	2010	SNES version re-released with Super Mario All-Stars Limited Edition.
23	2010	Virtual Console port titled 25th Anniversary SUPER MARIO BROS. with the question marks on the ? Blocks replaced with "25", exclusively bundled with a special, red Wii.
24	2011	Released on the 3DS as part of the Virtual Console. It is a free download for those who purchased a 3DS before the August 12th price drop. The full release version was released on January 5, 2012, in Japan, on February 16, 2012, in North America, and on March 1, 2012, in Europe and Australia.
25	2013	Released on the Wii U as part of the Virtual Console service via the Wii U eShop in Japan on June 5 and in Europe, Australia, and North America in September.  It requires 15 MB to be installed. The game was also featured in NES Remix.
26	2014	Re-released in NES Remix 2 as Super Luigi Bros. The game was also featured in Ultimate NES Remix along with the port of Super Mario Bros., Speed Mario Bros.
27	2014	Available as a playable demo in Super Smash Bros. for Wii U.
28	2015	Available as a "highlight" in amiibo tap: Nintendo's Greatest Bits.
29	2016	Released as one of the 30 games included in the NES Classic Edition and Nintendo Classic Mini: Family Computer.
30	2018	Available as one of the 20 NES titles at the Nintendo Switch Online subscription service's launch in September 2018, and for the first time can be played with other players online.[28]
31	2020	Released as Super Mario Bros. 35.
32	2020	Released as Game & Watch: Super Mario Bros.
\.


--
-- Name: character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.character_id_seq', 16, true);


--
-- Name: enemy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.enemy_id_seq', 1, false);


--
-- Name: form_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.form_id_seq', 8, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.image_id_seq', 113, true);


--
-- Name: item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.item_id_seq', 4, true);


--
-- Name: level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.level_id_seq', 32, true);


--
-- Name: npc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.npc_id_seq', 1, false);


--
-- Name: object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.object_id_seq', 14, true);


--
-- Name: obstacle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.obstacle_id_seq', 4, true);


--
-- Name: pc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.pc_id_seq', 1, false);


--
-- Name: power_up_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.power_up_id_seq', 4, true);


--
-- Name: reference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.reference_id_seq', 55, true);


--
-- Name: setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.setting_id_seq', 5, true);


--
-- Name: version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.version_id_seq', 32, true);


--
-- Name: character character_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_name_key UNIQUE (name);


--
-- Name: character character_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_pkey PRIMARY KEY (id);


--
-- Name: enemy enemy_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.enemy
    ADD CONSTRAINT enemy_pkey PRIMARY KEY (id);


--
-- Name: form form_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.form
    ADD CONSTRAINT form_name_key UNIQUE (name);


--
-- Name: form form_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.form
    ADD CONSTRAINT form_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: item item_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_name_key UNIQUE (name);


--
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- Name: level level_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_name_key UNIQUE (name);


--
-- Name: level level_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_pkey PRIMARY KEY (id);


--
-- Name: npc npc_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.npc
    ADD CONSTRAINT npc_pkey PRIMARY KEY (id);


--
-- Name: object object_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.object
    ADD CONSTRAINT object_name_key UNIQUE (name);


--
-- Name: object object_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.object
    ADD CONSTRAINT object_pkey PRIMARY KEY (id);


--
-- Name: obstacle obstacle_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.obstacle
    ADD CONSTRAINT obstacle_name_key UNIQUE (name);


--
-- Name: obstacle obstacle_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.obstacle
    ADD CONSTRAINT obstacle_pkey PRIMARY KEY (id);


--
-- Name: pc pc_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.pc
    ADD CONSTRAINT pc_pkey PRIMARY KEY (id);


--
-- Name: power_up power_up_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.power_up
    ADD CONSTRAINT power_up_name_key UNIQUE (name);


--
-- Name: power_up power_up_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.power_up
    ADD CONSTRAINT power_up_pkey PRIMARY KEY (id);


--
-- Name: reference reference_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.reference
    ADD CONSTRAINT reference_pkey PRIMARY KEY (id);


--
-- Name: setting setting_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_name_key UNIQUE (name);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (id);


--
-- Name: version version_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_pkey PRIMARY KEY (id);


--
-- Name: character character_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- Name: enemy enemy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.enemy
    ADD CONSTRAINT enemy_id_fkey FOREIGN KEY (id) REFERENCES public."character"(id);


--
-- Name: form form_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.form
    ADD CONSTRAINT form_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- Name: form form_pc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.form
    ADD CONSTRAINT form_pc_id_fkey FOREIGN KEY (pc_id) REFERENCES public.pc(id);


--
-- Name: form form_power_up_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.form
    ADD CONSTRAINT form_power_up_id_fkey FOREIGN KEY (power_up_id) REFERENCES public.power_up(id);


--
-- Name: item item_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- Name: level level_course_map_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_course_map_image_id_fkey FOREIGN KEY (course_map_image_id) REFERENCES public.image(id);


--
-- Name: level_enemy level_enemy_enemy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level_enemy
    ADD CONSTRAINT level_enemy_enemy_id_fkey FOREIGN KEY (enemy_id) REFERENCES public.enemy(id);


--
-- Name: level_enemy level_enemy_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level_enemy
    ADD CONSTRAINT level_enemy_level_id_fkey FOREIGN KEY (level_id) REFERENCES public.level(id);


--
-- Name: level level_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- Name: level_item level_item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level_item
    ADD CONSTRAINT level_item_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(id);


--
-- Name: level_item level_item_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level_item
    ADD CONSTRAINT level_item_level_id_fkey FOREIGN KEY (level_id) REFERENCES public.level(id);


--
-- Name: level_obstacle level_obstacle_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level_obstacle
    ADD CONSTRAINT level_obstacle_level_id_fkey FOREIGN KEY (level_id) REFERENCES public.level(id);


--
-- Name: level_obstacle level_obstacle_obstacle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level_obstacle
    ADD CONSTRAINT level_obstacle_obstacle_id_fkey FOREIGN KEY (obstacle_id) REFERENCES public.obstacle(id);


--
-- Name: level_power_up level_power_up_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level_power_up
    ADD CONSTRAINT level_power_up_level_id_fkey FOREIGN KEY (level_id) REFERENCES public.level(id);


--
-- Name: level_power_up level_power_up_power_up_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level_power_up
    ADD CONSTRAINT level_power_up_power_up_id_fkey FOREIGN KEY (power_up_id) REFERENCES public.power_up(id);


--
-- Name: level level_setting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_setting_id_fkey FOREIGN KEY (setting_id) REFERENCES public.setting(id);


--
-- Name: npc npc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.npc
    ADD CONSTRAINT npc_id_fkey FOREIGN KEY (id) REFERENCES public."character"(id);


--
-- Name: object object_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.object
    ADD CONSTRAINT object_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- Name: obstacle obstacle_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.obstacle
    ADD CONSTRAINT obstacle_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- Name: pc pc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.pc
    ADD CONSTRAINT pc_id_fkey FOREIGN KEY (id) REFERENCES public."character"(id);


--
-- Name: power_up power_up_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.power_up
    ADD CONSTRAINT power_up_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- PostgreSQL database dump complete
--

