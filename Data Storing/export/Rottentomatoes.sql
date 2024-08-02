--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Postgres.app)
-- Dumped by pg_dump version 16.3 (Postgres.app)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.actor (
    actor_id integer NOT NULL,
    actor_name character varying(50) NOT NULL,
    actor_bod date,
    highest_rating numeric(10,2),
    movie_highest_rating character varying(100),
    lowest_rating numeric(10,2),
    movie_lowest_rating character varying(100)
);


ALTER TABLE public.actor OWNER TO clementnathanael;

--
-- Name: director; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.director (
    director_id integer NOT NULL,
    director_name character varying(50) NOT NULL,
    director_bod date,
    highest_rating numeric(10,2),
    movie_highest_rating character varying(100),
    lowest_rating numeric(10,2),
    movie_lowest_rating character varying(100)
);


ALTER TABLE public.director OWNER TO clementnathanael;

--
-- Name: disney_dashboard_rating; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.disney_dashboard_rating (
    rank integer NOT NULL,
    movie_name character varying(100),
    year integer,
    score integer,
    artist character varying(50),
    director character varying(50)
);


ALTER TABLE public.disney_dashboard_rating OWNER TO clementnathanael;

--
-- Name: giving_rate; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.giving_rate (
    moviert_id integer NOT NULL,
    rating_id integer NOT NULL,
    email character varying(40) NOT NULL
);


ALTER TABLE public.giving_rate OWNER TO clementnathanael;

--
-- Name: movie_actor; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.movie_actor (
    moviert_id integer NOT NULL,
    actor_id integer NOT NULL
);


ALTER TABLE public.movie_actor OWNER TO clementnathanael;

--
-- Name: movie_dashboard; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.movie_dashboard (
    moviert_id integer NOT NULL,
    rank integer NOT NULL
);


ALTER TABLE public.movie_dashboard OWNER TO clementnathanael;

--
-- Name: movie_director; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.movie_director (
    moviert_id integer NOT NULL,
    director_id integer NOT NULL
);


ALTER TABLE public.movie_director OWNER TO clementnathanael;

--
-- Name: movies_disneyplus; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.movies_disneyplus (
    moviedp_id integer NOT NULL,
    moviedp_name character varying(100) NOT NULL,
    age_rating character varying(5),
    release_year integer,
    season integer,
    synopsis character varying(200),
    duration integer,
    moviert_id integer
);


ALTER TABLE public.movies_disneyplus OWNER TO clementnathanael;

--
-- Name: movies_rottentomatoes; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.movies_rottentomatoes (
    moviert_id integer NOT NULL,
    moviert_name character varying(100) NOT NULL,
    rating character varying(5),
    release_year integer,
    duration integer,
    synopsis character varying(200)
);


ALTER TABLE public.movies_rottentomatoes OWNER TO clementnathanael;

--
-- Name: moviesdp_genre; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.moviesdp_genre (
    moviedp_id integer NOT NULL,
    genre character varying(20)
);


ALTER TABLE public.moviesdp_genre OWNER TO clementnathanael;

--
-- Name: moviesdp_language; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.moviesdp_language (
    moviedp_id integer NOT NULL,
    language character varying(20)
);


ALTER TABLE public.moviesdp_language OWNER TO clementnathanael;

--
-- Name: moviesrt_genre; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.moviesrt_genre (
    moviert_id integer NOT NULL,
    genre character varying(20)
);


ALTER TABLE public.moviesrt_genre OWNER TO clementnathanael;

--
-- Name: rating; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.rating (
    rating_id integer NOT NULL,
    review character varying(400),
    score integer
);


ALTER TABLE public.rating OWNER TO clementnathanael;

--
-- Name: temp; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.temp (
    data jsonb
);


ALTER TABLE public.temp OWNER TO clementnathanael;

--
-- Name: temp2; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.temp2 (
    data jsonb
);


ALTER TABLE public.temp2 OWNER TO clementnathanael;

--
-- Name: user_audience; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.user_audience (
    email character varying(40) NOT NULL,
    audience_score integer,
    audience_give_review character varying(400)
);


ALTER TABLE public.user_audience OWNER TO clementnathanael;

--
-- Name: user_criticus; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.user_criticus (
    email character varying(40) NOT NULL,
    criticus_give_review character varying(400),
    tomato_score character varying(10)
);


ALTER TABLE public.user_criticus OWNER TO clementnathanael;

--
-- Name: users; Type: TABLE; Schema: public; Owner: clementnathanael
--

CREATE TABLE public.users (
    email character varying(40) NOT NULL,
    password character varying(40) NOT NULL,
    date_birth_user date,
    username character varying(40) NOT NULL,
    status character varying(20) NOT NULL
);


ALTER TABLE public.users OWNER TO clementnathanael;

--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.actor (actor_id, actor_name, actor_bod, highest_rating, movie_highest_rating, lowest_rating, movie_lowest_rating) FROM stdin;
10101	tom hanks	1956-09-07	100.00	toy story	10.00	my life in ruins
10102	ellen degeneres	1958-01-26	100.00	tig notaro: dawn	6.00	mr. wrong
\.


--
-- Data for Name: director; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.director (director_id, director_name, director_bod, highest_rating, movie_highest_rating, lowest_rating, movie_lowest_rating) FROM stdin;
210101	ben sharpsteen	1895-11-04	100.00	pinochio	84.00	alice in wonderland
\.


--
-- Data for Name: disney_dashboard_rating; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.disney_dashboard_rating (rank, movie_name, year, score, artist, director) FROM stdin;
1	toy story 2	1999	100	tom hanks	ash brannon
2	toy story	1995	100	tom hanks	john lasseter
3	pinocchio	1940	100	don brodie	ben sharpsteen
4	finding nemo	2003	99	albert brooks	andrew stanton
5	inside out	2015	98	amy poehler	pete docter
6	toy story 3	2010	98	tom hanks	lee unkrich
7	zootopia	2016	98	ginnifer goodwin	byron howard
8	hamilton	2020	98	lin-manuel miranda	thomas kail
9	big	1988	98	tom hanks	penny marshall
10	one hundred and one dalmatians	1961	98	rod taylor	wolfgang reitherman
11	toy story 4	2019	97	tom hanks	josh cooley
12	coco	2017	97	anthony gonzalez	lee unkrich
13	the incredibles	2004	97	craig t. nelson	brad bird
14	snow white and the seven dwarfs	1937	97	adriana caselotti	david hand
15	mary poppins	1964	97	julie andrews	robert stevenson
16	black panther	2018	96	chadwick boseman	ryan coogler
17	ratatouille	2007	96	patton oswalt	brad bird
18	monsters, inc.	2001	96	john goodman	pete docter
19	the princess bride	1987	96	cary elwes	rob reiner
20	who framed roger rabbit	1988	96	bob hoskins	robert zemeckis
21	miracle on 34th street	1947	96	maureen o'hara	george seaton
22	soul	2020	95	jamie foxx	pete docter
23	turning red	2022	95	rosalie chiang	domee shi
24	moana	2016	95	dwayne johnson	john musker
25	wall-e	2008	95	ben burtt	andrew stanton
26	the muppets	2011	95	jason segel	james bobin
27	star wars: episode v - the empire strikes back	1980	95	mark hamill	irvin kershner
28	the straight story	1999	95	richard farnsworth	david lynch
29	the nightmare before christmas	1993	95	danny elfman	henry selick
30	aladdin	1992	95	scott weinger	ron clements
31	fantasia	1940	95	deems taylor	james algar
32	dumbo	1941	95	herman bing	ben sharpsteen
33	avengers: endgame	2019	94	robert downey jr.	anthony russo
34	finding dory	2016	94	ellen degeneres	andrew stanton
35	iron man	2008	94	robert downey jr.	jon favreau
36	queen of katwe	2016	94	madina nalwanga	mira nair
37	the guardians of the galaxy holiday special	2022	94	chris pratt	james gunn
38	star wars: the force awakens	2015	93	harrison ford	j.j. abrams
39	thor: ragnarok	2017	93	chris hemsworth	taika waititi
40	hidden figures	2016	93	taraji p. henson	theodore melfi
41	raya and the last dragon	2021	93	kelly marie tran	don hall
42	fantastic mr. fox	2009	93	george clooney	wes anderson
43	star wars: episode iv - a new hope	1977	93	mark hamill	george lucas
44	beauty and the beast	1991	93	paige o'hara	gary trousdale
45	lady and the tramp	1955	93	peggy lee	clyde geronimi
46	spider-man: homecoming	2017	92	tom holland	jon watts
47	west side story	2021	92	ansel elgort	steven spielberg
48	guardians of the galaxy	2014	92	chris pratt	james gunn
49	the lion king	1994	92	matthew broderick	roger allers
50	a bug's life	1998	92	dave foley	john lasseter
51	star wars: the last jedi	2017	91	mark hamill	rian johnson
52	marvel's the avengers	2012	91	robert downey jr.	joss whedon
53	encanto	2021	91	stephanie beatriz	jared bush
54	the little mermaid	1989	91	jodi benson	ron clements
55	james and the giant peach	1996	91	paul terry	henry selick
56	ever after: a cinderella story	1998	91	drew barrymore	andy tennant
57	bambi	1942	91	hardie albright	david hand
58	captain america: civil war	2016	90	chris evans	anthony russo
59	isle of dogs	2018	90	bryan cranston	wes anderson
60	x-men: days of future past	2014	90	hugh jackman	bryan singer
61	captain america: the winter soldier	2014	90	chris evans	anthony russo
62	frozen	2013	90	kristen bell	chris buck
63	big hero 6	2014	90	ryan potter	don hall
64	bolt	2008	90	john travolta	chris williams
65	winnie the pooh	2011	90	jim cummings	stephen j. anderson
66	sleeping beauty	1959	90	mary costa	clyde geronimi
67	doctor strange	2016	89	benedict cumberbatch	scott derrickson
68	tangled	2010	89	mandy moore	nathan greno
69	werewolf by night	2022	89	gael garcía bernal	michael giacchino
70	tarzan	1999	89	tony goldwyn	chris buck
71	the muppet movie	1979	89	charles durning	james frawley
72	onward	2020	88	tom holland	dan scanlon
73	pete's dragon	2016	88	bryce dallas howard	david lowery
74	millions	2004	88	alex etel	danny boyle
75	freaky friday	2003	88	jamie lee curtis	mark waters
76	young woman and the sea	2024	88	daisy ridley	joachim rønning
77	the jungle book	1967	88	phil harris	wolfgang reitherman
78	the peanuts movie	2015	87	noah schnapp	steve martino
79	lilo & stitch	2002	87	daveigh chase	dean deblois
80	x-men: first class	2011	86	james mcavoy	matthew vaughn
81	the emperor's new groove	2000	86	david spade	mark dindal
82	mulan	1998	86	ming-na wen	barry cook
83	guardians of the galaxy vol. 2	2017	85	chris pratt	james gunn
84	deadpool	2016	85	ryan reynolds	tim miller
85	x2	2003	85	patrick stewart	bryan singer
86	the princess and the frog	2009	85	anika noni rose	ron clements
87	rogue one: a star wars story	2016	84	felicity jones	gareth edwards
88	deadpool 2	2018	84	ryan reynolds	david leitch
89	the rookie	2002	84	dennis quaid	john lee hancock
90	indiana jones and the last crusade	1989	84	harrison ford	steven spielberg
91	ant-man	2015	83	paul rudd	peyton reed
92	star wars: episode vi - return of the jedi	1983	82	mark hamill	richard marquand
93	drumline	2002	82	nick cannon	charles stone iii
94	hercules	1997	82	tate donovan	ron clements
95	avatar	2009	81	sam worthington	james cameron
96	miracle	2004	81	kurt russell	gavin o'connor
97	ron's gone wrong	2021	81	zach galifianakis	sarah smith
98	while you were sleeping	1995	81	sandra bullock	jon turteltaub
99	free guy	2021	80	ryan reynolds	shawn levy
100	pirates of the caribbean: the curse of the black pearl	2003	80	johnny depp	gore verbinski
\.


--
-- Data for Name: giving_rate; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.giving_rate (moviert_id, rating_id, email) FROM stdin;
\.


--
-- Data for Name: movie_actor; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.movie_actor (moviert_id, actor_id) FROM stdin;
\.


--
-- Data for Name: movie_dashboard; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.movie_dashboard (moviert_id, rank) FROM stdin;
\.


--
-- Data for Name: movie_director; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.movie_director (moviert_id, director_id) FROM stdin;
\.


--
-- Data for Name: movies_disneyplus; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.movies_disneyplus (moviedp_id, moviedp_name, age_rating, release_year, season, synopsis, duration, moviert_id) FROM stdin;
\.


--
-- Data for Name: movies_rottentomatoes; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.movies_rottentomatoes (moviert_id, moviert_name, rating, release_year, duration, synopsis) FROM stdin;
1	Toy Story 2	9	\N	92	\N
2	Toy Story	8	\N	81	\N
3	Pinocchio	10	\N	88	\N
4	Finding Nemo	9	\N	100	\N
5	Inside Out	9	\N	95	\N
\.


--
-- Data for Name: moviesdp_genre; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.moviesdp_genre (moviedp_id, genre) FROM stdin;
\.


--
-- Data for Name: moviesdp_language; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.moviesdp_language (moviedp_id, language) FROM stdin;
\.


--
-- Data for Name: moviesrt_genre; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.moviesrt_genre (moviert_id, genre) FROM stdin;
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.rating (rating_id, review, score) FROM stdin;
\.


--
-- Data for Name: temp; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.temp (data) FROM stdin;
{"rank": "1", "year": "1999", "score": "100", "artist": "tom hanks", "director": "ash brannon", "movie_name": "toy story 2"}
{"rank": "2", "year": "1995", "score": "100", "artist": "tom hanks", "director": "john lasseter", "movie_name": "toy story"}
{"rank": "3", "year": "1940", "score": "100", "artist": "don brodie", "director": "ben sharpsteen", "movie_name": "pinocchio"}
{"rank": "4", "year": "2003", "score": "99", "artist": "albert brooks", "director": "andrew stanton", "movie_name": "finding nemo"}
{"rank": "5", "year": "2015", "score": "98", "artist": "amy poehler", "director": "pete docter", "movie_name": "inside out"}
{"rank": "6", "year": "2010", "score": "98", "artist": "tom hanks", "director": "lee unkrich", "movie_name": "toy story 3"}
{"rank": "7", "year": "2016", "score": "98", "artist": "ginnifer goodwin", "director": "byron howard", "movie_name": "zootopia"}
{"rank": "8", "year": "2020", "score": "98", "artist": "lin-manuel miranda", "director": "thomas kail", "movie_name": "hamilton"}
{"rank": "9", "year": "1988", "score": "98", "artist": "tom hanks", "director": "penny marshall", "movie_name": "big"}
{"rank": "10", "year": "1961", "score": "98", "artist": "rod taylor", "director": "wolfgang reitherman", "movie_name": "one hundred and one dalmatians"}
{"rank": "11", "year": "2019", "score": "97", "artist": "tom hanks", "director": "josh cooley", "movie_name": "toy story 4"}
{"rank": "12", "year": "2017", "score": "97", "artist": "anthony gonzalez", "director": "lee unkrich", "movie_name": "coco"}
{"rank": "13", "year": "2004", "score": "97", "artist": "craig t. nelson", "director": "brad bird", "movie_name": "the incredibles"}
{"rank": "14", "year": "1937", "score": "97", "artist": "adriana caselotti", "director": "david hand", "movie_name": "snow white and the seven dwarfs"}
{"rank": "15", "year": "1964", "score": "97", "artist": "julie andrews", "director": "robert stevenson", "movie_name": "mary poppins"}
{"rank": "16", "year": "2018", "score": "96", "artist": "chadwick boseman", "director": "ryan coogler", "movie_name": "black panther"}
{"rank": "17", "year": "2007", "score": "96", "artist": "patton oswalt", "director": "brad bird", "movie_name": "ratatouille"}
{"rank": "18", "year": "2001", "score": "96", "artist": "john goodman", "director": "pete docter", "movie_name": "monsters, inc."}
{"rank": "19", "year": "1987", "score": "96", "artist": "cary elwes", "director": "rob reiner", "movie_name": "the princess bride"}
{"rank": "20", "year": "1988", "score": "96", "artist": "bob hoskins", "director": "robert zemeckis", "movie_name": "who framed roger rabbit"}
{"rank": "21", "year": "1947", "score": "96", "artist": "maureen o'hara", "director": "george seaton", "movie_name": "miracle on 34th street"}
{"rank": "22", "year": "2020", "score": "95", "artist": "jamie foxx", "director": "pete docter", "movie_name": "soul"}
{"rank": "23", "year": "2022", "score": "95", "artist": "rosalie chiang", "director": "domee shi", "movie_name": "turning red"}
{"rank": "24", "year": "2016", "score": "95", "artist": "dwayne johnson", "director": "john musker", "movie_name": "moana"}
{"rank": "25", "year": "2008", "score": "95", "artist": "ben burtt", "director": "andrew stanton", "movie_name": "wall-e"}
{"rank": "26", "year": "2011", "score": "95", "artist": "jason segel", "director": "james bobin", "movie_name": "the muppets"}
{"rank": "27", "year": "1980", "score": "95", "artist": "mark hamill", "director": "irvin kershner", "movie_name": "star wars: episode v - the empire strikes back"}
{"rank": "28", "year": "1999", "score": "95", "artist": "richard farnsworth", "director": "david lynch", "movie_name": "the straight story"}
{"rank": "29", "year": "1993", "score": "95", "artist": "danny elfman", "director": "henry selick", "movie_name": "the nightmare before christmas"}
{"rank": "30", "year": "1992", "score": "95", "artist": "scott weinger", "director": "ron clements", "movie_name": "aladdin"}
{"rank": "31", "year": "1940", "score": "95", "artist": "deems taylor", "director": "james algar", "movie_name": "fantasia"}
{"rank": "32", "year": "1941", "score": "95", "artist": "herman bing", "director": "ben sharpsteen", "movie_name": "dumbo"}
{"rank": "33", "year": "2019", "score": "94", "artist": "robert downey jr.", "director": "anthony russo", "movie_name": "avengers: endgame"}
{"rank": "34", "year": "2016", "score": "94", "artist": "ellen degeneres", "director": "andrew stanton", "movie_name": "finding dory"}
{"rank": "35", "year": "2008", "score": "94", "artist": "robert downey jr.", "director": "jon favreau", "movie_name": "iron man"}
{"rank": "36", "year": "2016", "score": "94", "artist": "madina nalwanga", "director": "mira nair", "movie_name": "queen of katwe"}
{"rank": "37", "year": "2022", "score": "94", "artist": "chris pratt", "director": "james gunn", "movie_name": "the guardians of the galaxy holiday special"}
{"rank": "38", "year": "2015", "score": "93", "artist": "harrison ford", "director": "j.j. abrams", "movie_name": "star wars: the force awakens"}
{"rank": "39", "year": "2017", "score": "93", "artist": "chris hemsworth", "director": "taika waititi", "movie_name": "thor: ragnarok"}
{"rank": "40", "year": "2016", "score": "93", "artist": "taraji p. henson", "director": "theodore melfi", "movie_name": "hidden figures"}
{"rank": "41", "year": "2021", "score": "93", "artist": "kelly marie tran", "director": "don hall", "movie_name": "raya and the last dragon"}
{"rank": "42", "year": "2009", "score": "93", "artist": "george clooney", "director": "wes anderson", "movie_name": "fantastic mr. fox"}
{"rank": "43", "year": "1977", "score": "93", "artist": "mark hamill", "director": "george lucas", "movie_name": "star wars: episode iv - a new hope"}
{"rank": "44", "year": "1991", "score": "93", "artist": "paige o'hara", "director": "gary trousdale", "movie_name": "beauty and the beast"}
{"rank": "45", "year": "1955", "score": "93", "artist": "peggy lee", "director": "clyde geronimi", "movie_name": "lady and the tramp"}
{"rank": "46", "year": "2017", "score": "92", "artist": "tom holland", "director": "jon watts", "movie_name": "spider-man: homecoming"}
{"rank": "47", "year": "2021", "score": "92", "artist": "ansel elgort", "director": "steven spielberg", "movie_name": "west side story"}
{"rank": "48", "year": "2014", "score": "92", "artist": "chris pratt", "director": "james gunn", "movie_name": "guardians of the galaxy"}
{"rank": "49", "year": "1994", "score": "92", "artist": "matthew broderick", "director": "roger allers", "movie_name": "the lion king"}
{"rank": "50", "year": "1998", "score": "92", "artist": "dave foley", "director": "john lasseter", "movie_name": "a bug's life"}
{"rank": "51", "year": "2017", "score": "91", "artist": "mark hamill", "director": "rian johnson", "movie_name": "star wars: the last jedi"}
{"rank": "52", "year": "2012", "score": "91", "artist": "robert downey jr.", "director": "joss whedon", "movie_name": "marvel's the avengers"}
{"rank": "53", "year": "2021", "score": "91", "artist": "stephanie beatriz", "director": "jared bush", "movie_name": "encanto"}
{"rank": "54", "year": "1989", "score": "91", "artist": "jodi benson", "director": "ron clements", "movie_name": "the little mermaid"}
{"rank": "55", "year": "1996", "score": "91", "artist": "paul terry", "director": "henry selick", "movie_name": "james and the giant peach"}
{"rank": "56", "year": "1998", "score": "91", "artist": "drew barrymore", "director": "andy tennant", "movie_name": "ever after: a cinderella story"}
{"rank": "57", "year": "1942", "score": "91", "artist": "hardie albright", "director": "david hand", "movie_name": "bambi"}
{"rank": "58", "year": "2016", "score": "90", "artist": "chris evans", "director": "anthony russo", "movie_name": "captain america: civil war"}
{"rank": "59", "year": "2018", "score": "90", "artist": "bryan cranston", "director": "wes anderson", "movie_name": "isle of dogs"}
{"rank": "60", "year": "2014", "score": "90", "artist": "hugh jackman", "director": "bryan singer", "movie_name": "x-men: days of future past"}
{"rank": "61", "year": "2014", "score": "90", "artist": "chris evans", "director": "anthony russo", "movie_name": "captain america: the winter soldier"}
{"rank": "62", "year": "2013", "score": "90", "artist": "kristen bell", "director": "chris buck", "movie_name": "frozen"}
{"rank": "63", "year": "2014", "score": "90", "artist": "ryan potter", "director": "don hall", "movie_name": "big hero 6"}
{"rank": "64", "year": "2008", "score": "90", "artist": "john travolta", "director": "chris williams", "movie_name": "bolt"}
{"rank": "65", "year": "2011", "score": "90", "artist": "jim cummings", "director": "stephen j. anderson", "movie_name": "winnie the pooh"}
{"rank": "66", "year": "1959", "score": "90", "artist": "mary costa", "director": "clyde geronimi", "movie_name": "sleeping beauty"}
{"rank": "67", "year": "2016", "score": "89", "artist": "benedict cumberbatch", "director": "scott derrickson", "movie_name": "doctor strange"}
{"rank": "68", "year": "2010", "score": "89", "artist": "mandy moore", "director": "nathan greno", "movie_name": "tangled"}
{"rank": "69", "year": "2022", "score": "89", "artist": "gael garcía bernal", "director": "michael giacchino", "movie_name": "werewolf by night"}
{"rank": "70", "year": "1999", "score": "89", "artist": "tony goldwyn", "director": "chris buck", "movie_name": "tarzan"}
{"rank": "71", "year": "1979", "score": "89", "artist": "charles durning", "director": "james frawley", "movie_name": "the muppet movie"}
{"rank": "72", "year": "2020", "score": "88", "artist": "tom holland", "director": "dan scanlon", "movie_name": "onward"}
{"rank": "73", "year": "2016", "score": "88", "artist": "bryce dallas howard", "director": "david lowery", "movie_name": "pete's dragon"}
{"rank": "74", "year": "2004", "score": "88", "artist": "alex etel", "director": "danny boyle", "movie_name": "millions"}
{"rank": "75", "year": "2003", "score": "88", "artist": "jamie lee curtis", "director": "mark waters", "movie_name": "freaky friday"}
{"rank": "76", "year": "2024", "score": "88", "artist": "daisy ridley", "director": "joachim rønning", "movie_name": "young woman and the sea"}
{"rank": "77", "year": "1967", "score": "88", "artist": "phil harris", "director": "wolfgang reitherman", "movie_name": "the jungle book"}
{"rank": "78", "year": "2015", "score": "87", "artist": "noah schnapp", "director": "steve martino", "movie_name": "the peanuts movie"}
{"rank": "79", "year": "2002", "score": "87", "artist": "daveigh chase", "director": "dean deblois", "movie_name": "lilo & stitch"}
{"rank": "80", "year": "2011", "score": "86", "artist": "james mcavoy", "director": "matthew vaughn", "movie_name": "x-men: first class"}
{"rank": "81", "year": "2000", "score": "86", "artist": "david spade", "director": "mark dindal", "movie_name": "the emperor's new groove"}
{"rank": "82", "year": "1998", "score": "86", "artist": "ming-na wen", "director": "barry cook", "movie_name": "mulan"}
{"rank": "83", "year": "2017", "score": "85", "artist": "chris pratt", "director": "james gunn", "movie_name": "guardians of the galaxy vol. 2"}
{"rank": "84", "year": "2016", "score": "85", "artist": "ryan reynolds", "director": "tim miller", "movie_name": "deadpool"}
{"rank": "85", "year": "2003", "score": "85", "artist": "patrick stewart", "director": "bryan singer", "movie_name": "x2"}
{"rank": "86", "year": "2009", "score": "85", "artist": "anika noni rose", "director": "ron clements", "movie_name": "the princess and the frog"}
{"rank": "87", "year": "2016", "score": "84", "artist": "felicity jones", "director": "gareth edwards", "movie_name": "rogue one: a star wars story"}
{"rank": "88", "year": "2018", "score": "84", "artist": "ryan reynolds", "director": "david leitch", "movie_name": "deadpool 2"}
{"rank": "89", "year": "2002", "score": "84", "artist": "dennis quaid", "director": "john lee hancock", "movie_name": "the rookie"}
{"rank": "90", "year": "1989", "score": "84", "artist": "harrison ford", "director": "steven spielberg", "movie_name": "indiana jones and the last crusade"}
{"rank": "91", "year": "2015", "score": "83", "artist": "paul rudd", "director": "peyton reed", "movie_name": "ant-man"}
{"rank": "92", "year": "1983", "score": "82", "artist": "mark hamill", "director": "richard marquand", "movie_name": "star wars: episode vi - return of the jedi"}
{"rank": "93", "year": "2002", "score": "82", "artist": "nick cannon", "director": "charles stone iii", "movie_name": "drumline"}
{"rank": "94", "year": "1997", "score": "82", "artist": "tate donovan", "director": "ron clements", "movie_name": "hercules"}
{"rank": "95", "year": "2009", "score": "81", "artist": "sam worthington", "director": "james cameron", "movie_name": "avatar"}
{"rank": "96", "year": "2004", "score": "81", "artist": "kurt russell", "director": "gavin o'connor", "movie_name": "miracle"}
{"rank": "97", "year": "2021", "score": "81", "artist": "zach galifianakis", "director": "sarah smith", "movie_name": "ron's gone wrong"}
{"rank": "98", "year": "1995", "score": "81", "artist": "sandra bullock", "director": "jon turteltaub", "movie_name": "while you were sleeping"}
{"rank": "99", "year": "2021", "score": "80", "artist": "ryan reynolds", "director": "shawn levy", "movie_name": "free guy"}
{"rank": "100", "year": "2003", "score": "80", "artist": "johnny depp", "director": "gore verbinski", "movie_name": "pirates of the caribbean: the curse of the black pearl"}
{"rating": 9, "duration": 92, "moviedp_id": 1, "moviedp_name": "Toy Story 2"}
{"rating": 8, "duration": 81, "moviedp_id": 2, "moviedp_name": "Toy Story"}
{"rating": 10, "duration": 88, "moviedp_id": 3, "moviedp_name": "Pinocchio"}
{"rating": 9, "duration": 100, "moviedp_id": 4, "moviedp_name": "Finding Nemo"}
{"rating": 9, "duration": 95, "moviedp_id": 5, "moviedp_name": "Inside Out"}
\.


--
-- Data for Name: temp2; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.temp2 (data) FROM stdin;
{"rating": 9, "duration": 92, "moviert_id": 1, "moviert_name": "Toy Story 2"}
{"rating": 8, "duration": 81, "moviert_id": 2, "moviert_name": "Toy Story"}
{"rating": 10, "duration": 88, "moviert_id": 3, "moviert_name": "Pinocchio"}
{"rating": 9, "duration": 100, "moviert_id": 4, "moviert_name": "Finding Nemo"}
{"rating": 9, "duration": 95, "moviert_id": 5, "moviert_name": "Inside Out"}
{"rating": 9, "duration": 92, "moviedp_id": 1, "moviedp_name": "Toy Story 2"}
{"rating": 8, "duration": 81, "moviedp_id": 2, "moviedp_name": "Toy Story"}
{"rating": 10, "duration": 88, "moviedp_id": 3, "moviedp_name": "Pinocchio"}
{"rating": 9, "duration": 100, "moviedp_id": 4, "moviedp_name": "Finding Nemo"}
{"rating": 9, "duration": 95, "moviedp_id": 5, "moviedp_name": "Inside Out"}
{"rating": 9, "duration": 92, "moviedp_id": 1, "moviert_id": 1, "moviedp_name": "Toy Story 2"}
{"rating": 8, "duration": 81, "moviedp_id": 2, "moviert_id": 2, "moviedp_name": "Toy Story"}
{"rating": 10, "duration": 88, "moviedp_id": 3, "moviert_id": 3, "moviedp_name": "Pinocchio"}
{"rating": 9, "duration": 100, "moviedp_id": 4, "moviert_id": 4, "moviedp_name": "Finding Nemo"}
{"rating": 9, "duration": 95, "moviedp_id": 5, "moviert_id": 5, "moviedp_name": "Inside Out"}
\.


--
-- Data for Name: user_audience; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.user_audience (email, audience_score, audience_give_review) FROM stdin;
\.


--
-- Data for Name: user_criticus; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.user_criticus (email, criticus_give_review, tomato_score) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: clementnathanael
--

COPY public.users (email, password, date_birth_user, username, status) FROM stdin;
\.


--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


--
-- Name: director director_pkey; Type: CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_pkey PRIMARY KEY (director_id);


--
-- Name: disney_dashboard_rating disney_dashboard_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.disney_dashboard_rating
    ADD CONSTRAINT disney_dashboard_rating_pkey PRIMARY KEY (rank);


--
-- Name: movies_disneyplus movies_disneyplus_pkey; Type: CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.movies_disneyplus
    ADD CONSTRAINT movies_disneyplus_pkey PRIMARY KEY (moviedp_id);


--
-- Name: movies_rottentomatoes movies_rottentomatoes_pkey; Type: CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.movies_rottentomatoes
    ADD CONSTRAINT movies_rottentomatoes_pkey PRIMARY KEY (moviert_id);


--
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (rating_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


--
-- Name: giving_rate giving_rate_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.giving_rate
    ADD CONSTRAINT giving_rate_email_fkey FOREIGN KEY (email) REFERENCES public.users(email);


--
-- Name: giving_rate giving_rate_moviert_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.giving_rate
    ADD CONSTRAINT giving_rate_moviert_id_fkey FOREIGN KEY (moviert_id) REFERENCES public.movies_rottentomatoes(moviert_id);


--
-- Name: giving_rate giving_rate_rating_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.giving_rate
    ADD CONSTRAINT giving_rate_rating_id_fkey FOREIGN KEY (rating_id) REFERENCES public.rating(rating_id);


--
-- Name: movie_actor movie_actor_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT movie_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actor(actor_id);


--
-- Name: movie_actor movie_actor_moviert_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT movie_actor_moviert_id_fkey FOREIGN KEY (moviert_id) REFERENCES public.movies_rottentomatoes(moviert_id);


--
-- Name: movie_dashboard movie_dashboard_moviert_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.movie_dashboard
    ADD CONSTRAINT movie_dashboard_moviert_id_fkey FOREIGN KEY (moviert_id) REFERENCES public.movies_rottentomatoes(moviert_id);


--
-- Name: movie_dashboard movie_dashboard_rank_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.movie_dashboard
    ADD CONSTRAINT movie_dashboard_rank_fkey FOREIGN KEY (rank) REFERENCES public.disney_dashboard_rating(rank);


--
-- Name: movie_director movie_director_director_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.movie_director
    ADD CONSTRAINT movie_director_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.director(director_id);


--
-- Name: movie_director movie_director_moviert_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.movie_director
    ADD CONSTRAINT movie_director_moviert_id_fkey FOREIGN KEY (moviert_id) REFERENCES public.movies_rottentomatoes(moviert_id);


--
-- Name: movies_disneyplus movies_disneyplus_moviert_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.movies_disneyplus
    ADD CONSTRAINT movies_disneyplus_moviert_id_fkey FOREIGN KEY (moviert_id) REFERENCES public.movies_rottentomatoes(moviert_id);


--
-- Name: moviesdp_genre moviesdp_genre_moviedp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.moviesdp_genre
    ADD CONSTRAINT moviesdp_genre_moviedp_id_fkey FOREIGN KEY (moviedp_id) REFERENCES public.movies_disneyplus(moviedp_id);


--
-- Name: moviesdp_language moviesdp_language_moviedp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.moviesdp_language
    ADD CONSTRAINT moviesdp_language_moviedp_id_fkey FOREIGN KEY (moviedp_id) REFERENCES public.movies_disneyplus(moviedp_id);


--
-- Name: moviesrt_genre moviesrt_genre_moviert_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.moviesrt_genre
    ADD CONSTRAINT moviesrt_genre_moviert_id_fkey FOREIGN KEY (moviert_id) REFERENCES public.movies_rottentomatoes(moviert_id);


--
-- Name: user_audience user_audience_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.user_audience
    ADD CONSTRAINT user_audience_email_fkey FOREIGN KEY (email) REFERENCES public.users(email);


--
-- Name: user_criticus user_criticus_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clementnathanael
--

ALTER TABLE ONLY public.user_criticus
    ADD CONSTRAINT user_criticus_email_fkey FOREIGN KEY (email) REFERENCES public.users(email);


--
-- PostgreSQL database dump complete
--

