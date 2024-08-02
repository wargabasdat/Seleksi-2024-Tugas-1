--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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
-- Name: award; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.award (
    award_id integer NOT NULL,
    name character varying(255) NOT NULL,
    organizer character varying(255)
);


ALTER TABLE public.award OWNER TO postgres;

--
-- Name: award_award_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.award ALTER COLUMN award_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.award_award_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract (
    contract_id integer NOT NULL,
    player_id integer NOT NULL,
    club character varying(100) NOT NULL,
    joined_date date NOT NULL,
    contract_expired date NOT NULL
);


ALTER TABLE public.contract OWNER TO postgres;

--
-- Name: contract_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contract_contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contract_contract_id_seq OWNER TO postgres;

--
-- Name: contract_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contract_contract_id_seq OWNED BY public.contract.contract_id;


--
-- Name: stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stats (
    stats_id integer NOT NULL,
    season character varying(50) NOT NULL,
    match_played integer NOT NULL,
    minutes_played integer NOT NULL,
    player_id integer NOT NULL,
    CONSTRAINT positive_stats_check CHECK (((match_played >= 0) AND (minutes_played >= 0)))
);


ALTER TABLE public.stats OWNER TO postgres;

--
-- Name: field_player_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.field_player_stats (
    goals integer NOT NULL,
    assists integer NOT NULL,
    CONSTRAINT positive_field_stats_check CHECK (((goals >= 0) AND (assists >= 0)))
)
INHERITS (public.stats);


ALTER TABLE public.field_player_stats OWNER TO postgres;

--
-- Name: goalkeeper_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goalkeeper_stats (
    goals_conceded integer NOT NULL,
    clean_sheets integer NOT NULL,
    CONSTRAINT positive_goalkeeper_stats_check CHECK (((goals_conceded >= 0) AND (clean_sheets >= 0)))
)
INHERITS (public.stats);


ALTER TABLE public.goalkeeper_stats OWNER TO postgres;

--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player (
    player_id integer NOT NULL,
    name character varying(255) NOT NULL,
    birth_date date NOT NULL,
    number integer NOT NULL,
    birth_place character varying(255) NOT NULL,
    height numeric(10,2) NOT NULL,
    nationality character varying(255) NOT NULL,
    "position" character varying(255) NOT NULL,
    preferred_foot character varying(255) NOT NULL,
    player_agent character varying(255),
    outfitter character varying(255),
    CONSTRAINT positive_height CHECK ((height > (0)::numeric)),
    CONSTRAINT positive_number CHECK ((number > 0))
);


ALTER TABLE public.player OWNER TO postgres;

--
-- Name: player_award; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_award (
    player_id integer NOT NULL,
    award_id integer NOT NULL,
    year integer NOT NULL,
    CONSTRAINT positive_number CHECK ((year > 0))
);


ALTER TABLE public.player_award OWNER TO postgres;

--
-- Name: player_player_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.player_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.player_player_id_seq OWNER TO postgres;

--
-- Name: player_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.player_player_id_seq OWNED BY public.player.player_id;


--
-- Name: player_value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_value (
    value_id integer NOT NULL,
    player_id integer NOT NULL,
    market_value numeric(10,2) NOT NULL,
    update_date date NOT NULL,
    CONSTRAINT positive_number CHECK ((market_value > (0)::numeric))
);


ALTER TABLE public.player_value OWNER TO postgres;

--
-- Name: stats_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.stats ALTER COLUMN stats_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.stats_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: transfer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transfer (
    transfer_id integer NOT NULL,
    transfer_date date NOT NULL,
    from_club character varying(255),
    to_club character varying(255),
    market_value numeric(10,2) NOT NULL,
    fee numeric(10,2) NOT NULL,
    is_loan boolean NOT NULL,
    player_id integer NOT NULL,
    CONSTRAINT positive_fee CHECK ((fee >= (0)::numeric)),
    CONSTRAINT positive_mv CHECK ((market_value >= (0)::numeric))
);


ALTER TABLE public.transfer OWNER TO postgres;

--
-- Name: transfer_transfer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.transfer ALTER COLUMN transfer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.transfer_transfer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contract contract_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract ALTER COLUMN contract_id SET DEFAULT nextval('public.contract_contract_id_seq'::regclass);


--
-- Name: player player_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player ALTER COLUMN player_id SET DEFAULT nextval('public.player_player_id_seq'::regclass);


--
-- Data for Name: award; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.award (award_id, name, organizer) FROM stdin;
1	UEFA Best Player in Europe	UEFA
2	Champions League winner	UEFA
3	FIFA Club World Cup winner	FIFA
4	English Champion	England
5	English FA Cup winner	The Football Association
6	German cup winner	Germany
7	Best young player	\N
8	German Bundesliga runner-up	Germany
9	Footballer of the Year	\N
10	Striker of the Year	\N
11	European Under-19 participant	UEFA
12	Under-20 World Cup participant	FIFA
13	Uefa Supercup winner	UEFA
14	Euro Under-17 participant	UEFA
15	Austrian champion	Austria
16	Austrian cup winner	Austria
17	Champions League participant	UEFA
18	Europa League participant	UEFA
19	Top goal scorer	\N
20	TM-Player of the season	\N
21	Player of the Year	\N
22	World Cup participant	FIFA
23	Euro participant	UEFA
24	English League Cup winner	England
25	English Super Cup winner	England
26	European Under-21 participant	UEFA
27	Under-17 World Cup participant	FIFA
28	Under-17 World Cup champion	FIFA
29	Euro runner-up	UEFA
30	Europa League runner-up	UEFA
31	European champion	UEFA
32	Winner UEFA Nations League	UEFA
33	Champions League runner-up	UEFA
34	Player of the Tournament	\N
35	European Under-19 champion	UEFA
36	Conference League winner	\N
37	Spanish cup winner	\N
38	World Cup winner	FIFA
39	Copa America winner	Copa America
40	South American Footballer of the Year	\N
41	Copa America participant	Copa America
42	CONMEBOL-UEFA Cup of Champions winner	UEFA
43	Copa Libertadores winner	Copa America
44	Top scorer	\N
45	Campeon Supercopa Argentina	Argentina
46	Argentinian champion	Argentina
47	Campeon Trofeo de Campeones	\N
48	Argentinian Cup Winner	Argentina
49	FIFA Club World Cup participant	FIFA
50	Olympics participant	Olympics
51	Olympic medalist	Olympics
52	Copa Sudamericana winner	Copa America
53	Brazilian cup winner	\N
54	U21 Premier League champion	EPL
55	English FA Youth Cup winner	The Football Association
56	English Youth League winner (U18)	England
57	European Under-21 champion	UEFA
58	Portuguese champion	Portugal
59	Portuguese Super Cup winner	Portugal
60	Defender of the Year	\N
61	World Cup runner-up	FIFA
62	World Cup third place	FIFA
63	Croatian champion	Croatia
64	Croatian Super Cup Winner	Croatia
65	Croatian cup winner	Croatia
66	Austrian Youth league U18 champion	Austria
67	German Under-19 Bundesliga champion	Germany
68	German Under-19 Bundesliga West champion	Germany
69	U20 Copa Libertadores winner	Copa America
70	Portuguese cup winner	Portugal
71	Colombian Champion	\N
72	Colombian Super Cup winner	\N
73	Colombian Cup winner	\N
74	Recopa Sudamericana winner	Copa America
75	Campeon Primera Nacional	\N
76	German cup runner-up	Germany
77	Second highest goal scorer	\N
78	Fritz Walter Silver medalist	\N
79	Fritz Walter Golden medalist	\N
80	German Under-17 Bundesliga champion	Germany
81	Torneio Internacional Algarve U17	\N
82	Uruguayan champion	\N
83	French champion	\N
84	Portuguese league cup winner	Portugal
85	Euro Under-21 runner-up	UEFA
86	Confederations Cup participant	\N
87	Copa America runner-up	Copa America
88	Copa Sao Paulo de Juniores winner	Copa America
89	French cup winner	\N
90	French league cup winner	\N
91	French Super Cup winner	\N
92	Danish champion	\N
93	World Cup Under-20 runner-up	FIFA
94	Brazilian champion	\N
95	Europa League winner	UEFA
96	Silver Boot	\N
97	Promotion to 1st league	\N
98	English 2nd tier champion	England
99	Italian cup winner	\N
100	Italian Super Cup winner	\N
101	Italian Youth champion (Primavera)	\N
102	Dutch Super Cup winner	\N
103	Dutch U17 Champion	\N
104	Dutch Cup winner	\N
105	Dutch champion	\N
106	African Footballer of the Year	\N
107	Africa Cup runner-up	\N
108	Swiss champion	\N
109	Africa Cup participant	\N
110	Under-20 Africa Cup participant	\N
111	FIFA Puskas Award	FIFA
112	Dutch Cup Runner Up	\N
113	English 3rd tier champion	England
114	Football League Trophy Winner	\N
115	Midfielder of the Year	\N
116	Under-20 South American Championship winner	\N
117	German Super Cup winner	Germany
118	Belgian cup winner	\N
119	Belgian champion	\N
120	Belgian Super Cup Winner	\N
121	Second place at the Olympic Games	Olympics
122	Africa Cup winner	\N
123	Asian Games Silver Medal	AFC
124	Asian Cup participant	AFC
125	AFC Champions League participant	UEFA
126	Japanese champion	\N
127	Japanese cup winner	\N
128	Japanese Super Cup winner	\N
129	J. League Best XI	\N
130	Asian Footballer of the Year	AFC
131	Asian Games Gold Medal	AFC
132	Asian Cup runner-up	AFC
133	Swiss cup winner	\N
134	Dutch U19 Champion	\N
135	Gold Cup participant	\N
136	European Under-17 champion	UEFA
137	UEFA Youth League Winner	UEFA
138	Under-20 World Cup champion	FIFA
139	Italian champion	\N
140	Italienischer Zweitligameister	\N
141	Dutch U19 Youth Cup winner	\N
142	Goalkeeper of the season	\N
143	Winner Supercopa do Brasil	Copa America
144	Gold Cup winner	\N
145	Mexican Champion Apertura	\N
146	Mexican Cup winner Clausura	\N
147	CONCACAF Champions League participant	UEFA
\.


--
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract (contract_id, player_id, club, joined_date, contract_expired) FROM stdin;
1	1	Manchester City	2022-07-01	2027-06-30
2	2	Manchester City	2017-07-01	2027-06-30
3	3	Arsenal FC	2019-07-01	2027-06-30
4	4	Manchester City	2019-07-04	2027-06-30
5	5	Arsenal FC	2023-07-15	2028-06-30
6	6	Arsenal FC	2021-08-20	2028-06-30
7	7	Manchester City	2022-01-31	2028-06-30
8	8	Newcastle United	2022-01-30	2028-06-30
9	9	Chelsea FC	2023-09-01	2030-06-30
10	10	Manchester City	2020-09-29	2027-06-30
11	11	Arsenal FC	2019-07-25	2027-06-30
12	12	Manchester City	2023-08-05	2028-06-30
13	13	Liverpool FC	2023-07-02	2028-06-30
14	14	Newcastle United	2022-08-26	2028-06-30
15	15	Chelsea FC	2023-08-14	2031-06-30
16	16	Liverpool FC	2022-01-30	2027-06-30
17	17	Chelsea FC	2023-01-31	2032-06-30
18	18	Liverpool FC	2023-07-01	2028-06-30
19	19	Arsenal FC	2023-07-01	2028-06-30
20	20	Tottenham Hotspur	2023-07-01	2028-06-30
21	21	Arsenal FC	2019-07-02	2027-06-30
22	22	Liverpool FC	2022-07-01	2028-06-30
23	23	Arsenal FC	2020-09-01	2027-06-30
24	24	Liverpool FC	2016-07-01	2025-06-30
25	25	Manchester City	2017-07-01	2026-06-30
26	26	Aston Villa	2020-09-09	2028-06-30
27	27	Tottenham Hotspur	2022-08-30	2027-06-30
28	28	West Ham United	2022-08-29	2027-06-30
29	29	Chelsea FC	2023-07-01	2029-06-30
30	30	Manchester City	2023-08-24	2028-06-30
31	31	Manchester United	2023-08-05	2028-06-30
32	32	Arsenal FC	2022-07-04	2027-06-30
33	33	Manchester United	2016-01-01	2028-06-30
34	34	Newcastle United	2023-01-29	2026-06-30
35	35	Manchester City	2021-08-05	2027-06-30
36	36	Arsenal FC	2021-07-30	2028-06-30
37	37	Tottenham Hotspur	2023-07-01	2028-06-30
38	38	Liverpool FC	2023-01-01	2028-06-30
39	39	Liverpool FC	2017-07-01	2025-06-30
40	40	Manchester United	2023-01-01	2027-06-30
41	41	Tottenham Hotspur	2023-08-08	2029-06-30
42	42	Wolverhampton Wanderers	2019-08-02	2027-06-30
43	43	Manchester United	2020-01-29	2026-06-30
44	44	Crystal Palace	2020-08-28	2027-06-30
45	45	Manchester United	2022-07-27	2027-06-30
46	46	Brighton & Hove Albion	2022-07-01	2029-06-30
47	47	Brentford FC	2020-09-01	2025-06-30
48	48	Chelsea FC	2022-07-01	2025-06-30
49	49	Manchester City	2023-09-01	2028-06-30
50	50	Aston Villa	2024-07-22	2029-06-30
51	51	West Ham United	2020-01-31	2030-06-30
52	52	Manchester City	2024-07-18	2029-06-30
53	53	Liverpool FC	2020-09-19	2027-06-30
54	54	Manchester United	2024-07-18	2029-06-30
55	55	West Ham United	2023-08-27	2028-06-30
56	56	Manchester City	2015-08-30	2025-06-30
57	57	Tottenham Hotspur	2023-09-01	2028-06-30
58	58	Aston Villa	2023-07-12	2028-06-30
59	59	Tottenham Hotspur	2021-08-27	2030-06-30
60	60	Wolverhampton Wanderers	2023-07-01	2027-06-30
61	61	Tottenham Hotspur	2023-07-01	2028-06-30
62	62	Brighton & Hove Albion	2021-08-10	2027-06-30
63	63	Manchester United	2022-07-01	2028-06-30
64	64	Tottenham Hotspur	2015-08-28	2025-06-30
65	65	Manchester City	2022-09-01	2027-06-30
66	66	Tottenham Hotspur	2022-08-16	2030-06-30
67	67	Brighton & Hove Albion	2023-07-01	2028-06-30
68	68	Liverpool FC	2021-07-01	2026-06-30
69	69	Newcastle United	2022-07-01	2027-06-30
70	70	Aston Villa	2021-08-04	2027-06-30
71	71	Everton FC	2020-01-13	2027-06-30
72	72	Chelsea FC	2023-08-04	2029-06-30
73	73	Newcastle United	2019-07-23	2028-06-30
74	74	Nottingham Forest	2022-08-19	2027-06-30
75	75	Manchester City	2020-08-05	2027-06-30
76	76	Aston Villa	2024-07-01	2030-06-30
77	77	Brentford FC	2019-08-05	2026-06-30
78	78	Chelsea FC	2019-07-01	2028-06-30
79	79	AFC Bournemouth	2019-01-04	2027-06-30
80	80	Newcastle United	2023-07-03	2028-06-30
81	81	Arsenal FC	2023-07-14	2028-06-30
82	82	Manchester City	2022-07-01	2028-06-30
83	83	Crystal Palace	2021-07-18	2026-06-30
84	84	Tottenham Hotspur	2022-07-01	2027-06-30
85	85	Aston Villa	2022-07-01	2027-06-30
86	86	Manchester City	2016-08-09	2026-06-30
87	87	Arsenal FC	2022-07-22	2026-06-30
88	88	Arsenal FC	2021-08-31	2026-06-30
89	89	Chelsea FC	2023-08-18	2030-06-30
90	90	Manchester City	2017-07-01	2026-06-30
91	91	Manchester United	2023-07-20	2028-06-30
92	92	Tottenham Hotspur	2022-07-01	2026-06-30
93	93	Tottenham Hotspur	2022-01-31	2026-06-30
94	94	Aston Villa	2019-07-11	2028-06-30
95	95	Liverpool FC	2021-07-01	2027-06-30
96	96	Manchester United	2023-07-05	2028-06-30
97	97	Wolverhampton Wanderers	2023-01-30	2028-06-30
98	98	West Ham United	2023-08-10	2028-06-30
99	99	Chelsea FC	2023-01-29	2030-06-30
100	100	Newcastle United	2023-08-08	2028-06-30
\.


--
-- Data for Name: field_player_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.field_player_stats (stats_id, season, match_played, minutes_played, player_id, goals, assists) FROM stdin;
1	23/24	31	2558	1	27	5
2	22/23	35	2777	1	36	8
3	23/24	35	2871	2	19	8
4	22/23	32	1842	2	11	5
5	21/22	28	2134	2	9	5
6	20/21	28	1614	2	9	5
7	19/20	23	893	2	5	2
8	18/19	13	329	2	1	0
9	17/18	5	44	2	0	1
10	23/24	35	2936	3	16	9
11	22/23	38	3194	3	14	11
12	21/22	38	2994	3	11	7
13	20/21	32	2561	3	5	3
14	19/20	26	1753	3	1	5
15	18/19	1	7	3	0	0
16	23/24	34	2938	4	8	9
17	22/23	36	2921	4	2	6
18	21/22	33	2888	4	7	2
19	20/21	34	2748	4	2	2
20	19/20	35	2486	4	3	2
21	23/24	38	3231	5	7	9
22	22/23	37	3272	5	4	2
23	21/22	36	3178	5	1	4
24	20/21	32	2880	5	2	1
25	19/20	38	3420	5	1	3
26	18/19	34	3004	5	2	0
27	17/18	26	1424	5	0	0
28	16/17	1	1	5	0	0
29	23/24	35	3104	6	8	10
30	22/23	37	3150	6	15	7
31	21/22	36	2793	6	7	4
32	20/21	14	866	6	1	2
33	23/24	36	2659	7	11	9
34	22/23	31	1454	7	9	1
35	23/24	37	3269	8	7	8
36	22/23	32	2734	8	4	5
37	21/22	17	1034	8	5	1
38	23/24	33	2618	9	22	11
39	23/24	1	10	9	0	0
40	22/23	14	358	9	0	1
41	21/22	4	122	9	0	0
42	20/21	0	0	9	0	0
43	19/20	0	0	9	0	0
44	23/24	30	2557	10	0	0
45	22/23	26	1998	10	0	0
46	21/22	29	2403	10	2	4
47	20/21	32	2845	10	1	0
48	23/24	38	3420	11	2	1
49	22/23	27	2416	11	2	1
50	23/24	28	2329	12	4	2
51	23/24	33	2111	13	3	2
52	23/24	30	2266	14	21	2
53	22/23	22	1526	14	10	2
54	23/24	35	2874	15	1	3
55	22/23	37	3141	15	1	1
56	21/22	8	664	15	1	1
57	20/21	0	0	15	0	0
58	23/24	37	2646	16	8	5
59	22/23	17	997	16	4	2
60	21/22	13	963	16	4	3
61	23/24	28	2215	17	3	2
62	22/23	18	1551	17	0	2
63	23/24	33	2612	18	5	5
64	22/23	35	2886	18	10	2
65	21/22	33	2115	18	5	2
66	20/21	21	1115	18	1	1
67	19/20	9	352	18	0	0
68	23/24	37	2640	19	13	7
69	22/23	35	2579	19	7	1
70	21/22	29	1811	19	8	3
71	20/21	27	1520	19	4	3
72	23/24	28	2154	20	4	9
73	22/23	30	2486	20	10	9
74	21/22	35	2467	20	12	8
75	20/21	31	2105	20	8	5
76	19/20	31	2629	20	6	3
77	18/19	36	2849	20	7	7
78	23/24	35	2029	21	6	4
79	22/23	36	2805	21	15	5
80	21/22	29	1867	21	6	6
81	20/21	14	586	21	2	1
82	19/20	14	656	21	3	0
83	23/24	36	2045	22	11	8
84	22/23	29	1698	22	9	3
85	23/24	36	3044	23	4	0
86	22/23	38	3411	23	3	0
87	21/22	35	3067	23	5	0
88	20/21	23	1997	23	2	0
89	23/24	28	2163	24	3	4
90	22/23	37	2931	24	2	9
91	21/22	32	2854	24	2	12
92	20/21	36	3033	24	2	7
93	19/20	38	3176	24	4	13
94	18/19	29	2467	24	1	12
95	17/18	19	1576	24	1	1
96	16/17	7	165	24	0	0
97	23/24	33	2582	25	6	9
98	22/23	34	2202	25	4	6
99	21/22	35	2860	25	8	4
100	20/21	26	2070	25	2	6
101	19/20	34	2029	25	6	7
102	18/19	36	2853	25	7	7
103	17/18	35	1520	25	6	4
104	23/24	37	3226	26	19	13
105	22/23	37	3136	26	15	6
106	21/22	35	2955	26	11	2
107	20/21	37	3329	26	14	5
108	23/24	33	2792	27	5	0
109	22/23	27	2365	27	0	1
110	21/22	22	1846	27	1	0
111	23/24	31	2639	28	4	6
112	22/23	28	2172	28	4	3
113	23/24	11	439	29	3	0
114	23/24	29	1594	30	3	9
115	23/24	30	2171	31	10	2
116	23/24	27	1483	32	4	5
117	22/23	26	2075	32	11	6
118	21/22	28	1878	32	8	9
119	20/21	29	2059	32	9	4
120	19/20	34	2027	32	14	8
121	18/19	29	1021	32	7	3
122	17/18	29	1672	32	13	3
123	16/17	10	651	32	7	4
124	23/24	33	2278	33	7	2
125	22/23	35	2891	33	17	5
126	21/22	25	1233	33	4	2
127	20/21	37	2924	33	11	9
128	19/20	31	2655	33	17	7
129	18/19	33	2344	33	10	6
130	17/18	35	1807	33	7	5
131	16/17	32	1703	33	5	2
132	15/16	11	861	33	5	2
133	23/24	35	2906	34	11	10
134	22/23	16	481	34	1	0
135	22/23	16	1097	34	3	0
136	21/22	35	2286	34	4	2
137	20/21	3	88	34	0	0
138	19/20	11	440	34	0	1
139	23/24	20	1001	35	3	1
140	22/23	28	2063	35	5	7
141	21/22	26	1916	35	3	3
142	20/21	26	2185	35	6	10
143	19/20	36	3234	35	8	6
144	15/16	16	832	35	1	0
145	14/15	17	816	35	0	1
146	13/14	1	2	35	0	0
147	11/12	0	0	35	0	0
148	23/24	37	2995	36	4	4
149	22/23	38	3067	36	2	5
150	21/22	32	2880	36	0	0
151	20/21	36	3196	36	0	0
152	18/19	0	0	36	0	0
153	23/24	36	2766	37	8	3
154	22/23	30	2079	37	2	7
155	21/22	18	1267	37	5	8
156	23/24	35	1646	38	8	5
157	22/23	21	1465	38	7	3
158	23/24	32	2536	39	18	10
159	22/23	38	3297	39	19	12
160	21/22	35	2762	39	23	13
161	20/21	37	3082	39	22	5
162	19/20	34	2888	39	19	10
163	18/19	38	3261	39	22	8
164	17/18	36	2920	39	32	10
165	14/15	3	30	39	0	0
166	13/14	10	500	39	2	1
167	11/12	15	1318	39	7	3
168	10/11	20	1257	39	4	1
169	09/10	3	46	39	0	0
170	23/24	24	1940	40	3	1
171	22/23	1	10	40	0	0
172	23/24	27	2343	41	3	0
173	23/24	20	1519	42	2	9
174	22/23	18	970	42	0	1
175	21/22	13	464	42	1	1
176	20/21	31	2560	42	5	6
177	19/20	29	927	42	3	3
178	23/24	35	3120	43	10	8
179	22/23	37	3320	43	8	8
180	21/22	36	3118	43	10	6
181	20/21	37	3109	43	18	11
182	19/20	14	1193	43	8	7
183	23/24	27	2066	44	11	4
184	22/23	38	2645	44	10	4
185	21/22	13	602	44	1	1
186	20/21	34	2563	44	4	6
187	23/24	11	648	45	0	1
188	22/23	27	2117	45	1	0
189	23/24	27	1365	46	6	0
190	22/23	19	950	46	6	2
191	21/22	1	22	46	0	0
192	23/24	17	1449	47	4	2
193	22/23	33	2955	47	20	4
194	21/22	33	2908	47	12	5
195	15/16	2	10	47	0	0
196	23/24	37	3136	48	5	7
197	22/23	35	1616	48	3	1
198	21/22	34	2851	48	8	3
199	20/21	30	2532	48	2	2
200	23/24	17	654	49	0	2
201	23/24	2	180	49	0	0
202	22/23	34	2478	49	1	1
203	23/24	30	2090	50	2	0
204	22/23	33	2496	50	1	2
205	23/24	34	3022	51	16	6
206	22/23	38	3237	51	6	6
207	21/22	36	2993	51	12	10
208	20/21	38	2577	51	8	5
209	19/20	13	921	51	1	4
210	16/17	7	179	51	0	0
211	23/24	21	1151	53	10	3
212	22/23	22	1133	53	7	4
213	21/22	35	2374	53	15	4
214	20/21	19	1113	53	9	0
215	20/21	0	0	53	0	0
216	19/20	34	2298	53	7	1
217	18/19	33	2369	53	9	5
218	23/24	33	2489	55	8	6
219	23/24	18	1228	56	4	10
220	22/23	32	2425	56	7	18
221	21/22	30	2206	56	15	8
222	20/21	25	2001	56	6	12
223	19/20	35	2800	56	13	20
224	18/19	19	974	56	2	2
225	17/18	37	3085	56	8	16
226	16/17	36	2884	56	6	18
227	15/16	25	2003	56	7	9
228	13/14	3	132	56	0	1
229	23/24	32	2093	57	5	10
230	23/24	3	240	57	0	0
231	22/23	38	2941	57	8	3
232	23/24	29	2463	58	2	0
233	23/24	34	2085	59	3	3
234	22/23	11	213	59	0	1
235	23/24	32	2454	60	12	7
236	22/23	17	972	60	2	0
237	23/24	35	3093	61	3	7
238	22/23	15	1136	61	3	3
239	23/24	19	1488	62	3	4
240	22/23	33	2318	62	7	6
241	23/24	36	2576	63	7	4
242	22/23	19	561	63	3	2
243	21/22	2	12	63	0	0
244	23/24	35	2948	64	17	10
245	22/23	36	2899	64	10	6
246	21/22	35	3022	64	23	7
247	20/21	37	3126	64	17	10
248	19/20	30	2488	64	11	10
249	18/19	31	2048	64	12	6
250	17/18	37	2311	64	12	6
251	16/17	34	2070	64	14	6
252	15/16	28	1105	64	4	1
253	23/24	30	2514	65	2	0
254	22/23	29	2286	65	0	1
255	23/24	28	2398	66	2	3
256	23/24	31	2047	67	9	3
257	21/22	28	1638	67	3	1
258	19/20	3	22	67	0	0
259	23/24	22	1573	68	0	0
260	22/23	18	1551	68	0	0
261	21/22	11	990	68	0	0
262	23/24	17	1378	69	2	2
263	22/23	36	3129	69	0	0
264	23/24	35	2076	70	10	9
265	22/23	33	1984	70	4	4
266	21/22	18	755	70	1	2
267	23/24	35	3117	71	3	0
268	21/22	6	388	71	1	0
269	20/21	0	0	71	0	0
270	19/20	4	299	71	0	0
271	23/24	31	2581	72	2	0
272	23/24	20	1282	73	2	1
273	22/23	32	2663	73	6	2
274	21/22	35	2559	73	4	1
275	20/21	31	1988	73	4	2
276	19/20	38	2698	73	2	2
277	23/24	37	3162	74	5	10
278	22/23	35	2979	74	5	8
279	22/23	2	180	74	0	0
280	21/22	2	7	74	0	0
281	20/21	11	410	74	1	0
282	19/20	7	126	74	0	0
283	18/19	26	650	74	0	1
284	23/24	29	2044	75	2	2
285	22/23	26	1877	75	1	0
286	21/22	14	920	75	2	0
287	20/21	10	797	75	1	0
288	19/20	29	2505	75	2	2
289	18/19	38	3412	75	4	0
290	17/18	38	3353	75	2	3
291	16/17	2	98	75	0	1
292	16/17	10	733	75	3	0
293	15/16	24	1875	75	1	0
294	14/15	1	17	75	0	0
295	13/14	1	11	75	0	0
296	12/13	3	92	75	0	0
297	23/24	12	201	76	0	0
298	23/24	25	1961	77	9	6
299	22/23	38	2928	77	9	8
300	21/22	35	2916	77	4	7
301	23/24	10	421	78	0	2
302	22/23	16	1244	78	1	1
303	21/22	26	1865	78	5	9
304	20/21	32	2367	78	1	2
305	19/20	24	1513	78	0	2
306	23/24	38	3333	79	19	3
307	22/23	33	2873	79	6	7
308	19/20	32	1644	79	3	1
309	18/19	10	341	79	0	1
310	17/18	21	582	79	1	1
311	16/17	0	0	79	0	0
312	14/15	0	0	79	0	0
313	23/24	8	440	80	1	0
314	23/24	2	71	81	0	0
315	23/24	16	807	82	2	0
316	22/23	14	903	82	0	0
317	23/24	25	2023	83	0	1
318	22/23	37	3330	83	1	0
319	21/22	36	3223	83	2	1
320	19/20	0	0	83	0	0
321	18/19	0	0	83	0	0
322	23/24	28	1492	84	11	4
323	22/23	27	1006	84	1	4
324	21/22	30	2528	84	10	5
325	20/21	34	2872	84	7	3
326	19/20	36	3080	84	13	3
327	18/19	35	2679	84	13	1
328	17/18	38	2827	84	5	4
329	23/24	20	1661	85	0	1
330	22/23	24	1781	85	0	1
331	23/24	16	1064	86	1	0
332	22/23	23	1848	86	2	2
333	21/22	14	1118	86	1	0
334	20/21	22	1934	86	4	0
335	19/20	16	1118	86	0	0
336	18/19	24	1763	86	0	0
337	17/18	18	1306	86	0	0
338	16/17	27	2013	86	0	0
339	15/16	33	2779	86	0	0
340	14/15	23	2044	86	1	0
341	13/14	21	1369	86	0	0
342	12/13	0	0	86	0	0
343	23/24	27	1725	87	1	2
344	22/23	27	2136	87	1	2
345	21/22	15	1044	87	0	4
346	20/21	20	1474	87	0	0
347	19/20	19	1273	87	0	0
348	18/19	14	1153	87	0	3
349	17/18	8	533	87	0	0
350	23/24	22	1143	88	2	1
351	22/23	21	653	88	0	1
352	21/22	21	1684	88	0	1
353	23/24	1	32	89	0	0
354	22/23	29	2231	89	1	0
355	21/22	0	0	89	0	0
364	23/24	28	2083	92	0	0
365	22/23	23	1004	92	0	0
366	21/22	26	2116	92	1	2
367	20/21	36	3114	92	1	0
368	19/20	22	1262	92	1	0
369	18/19	28	1769	92	0	0
370	23/24	23	1007	93	1	1
371	22/23	18	1506	93	5	2
372	21/22	17	1365	93	0	4
373	23/24	35	3074	94	1	0
374	22/23	38	3323	94	0	0
375	21/22	29	2481	94	2	0
376	20/21	36	3195	94	2	0
377	19/20	25	2042	94	1	2
378	23/24	34	1335	95	3	6
379	22/23	32	1611	95	1	2
380	21/22	6	345	95	0	0
381	19/20	2	7	95	0	0
382	18/19	2	18	95	0	0
383	23/24	14	514	96	1	0
384	22/23	24	1655	96	3	2
385	21/22	32	2364	96	11	10
386	20/21	36	2894	96	6	6
387	19/20	37	2875	96	7	5
388	23/24	34	2659	97	2	1
389	22/23	11	651	97	1	0
390	23/24	31	2383	98	1	1
391	23/24	27	1756	99	0	6
392	23/24	26	1306	100	1	0
393	22/23	2	26	100	0	0
394	21/22	28	2203	100	1	1
395	20/21	0	0	100	0	0
\.


--
-- Data for Name: goalkeeper_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goalkeeper_stats (stats_id, season, match_played, minutes_played, player_id, goals_conceded, clean_sheets) FROM stdin;
356	23/24	33	2788	90	27	13
357	22/23	35	3150	90	32	11
358	21/22	37	3330	90	26	20
359	20/21	36	3240	90	28	19
360	19/20	35	3072	90	28	17
361	18/19	38	3420	90	23	20
362	17/18	36	3195	90	26	17
363	23/24	38	3420	91	58	9
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player (player_id, name, birth_date, number, birth_place, height, nationality, "position", preferred_foot, player_agent, outfitter) FROM stdin;
1	Erling Haaland	2000-07-21	9	Leeds	1.95	Norway	Attack - Centre-Forward	left	Rafaela Pimenta	Nike
2	Phil Foden	2000-05-28	47	Stockport	1.71	England	Attack - Right Winger	left	\N	Nike
3	Bukayo Saka	2001-09-05	7	London	1.78	England	Attack - Right Winger	left	Elite Project Group	New Balance
4	Rodri	1996-06-22	16	Madrid	1.91	Spain	Midfield - Defensive Midfield	right	Pablo Barquero	Nike
5	Declan Rice	1999-01-14	41	London	1.88	England	Midfield - Defensive Midfield	right	Relatives	adidas
6	Martin Odegaard	1998-12-17	8	Drammen	1.78	Norway	Midfield - Attacking Midfield	left	Nordic Sky	Nike
7	Julian Alvarez	2000-01-31	19	Calchin	1.70	Argentina	Attack - Centre-Forward	right	Fernando Hidalgo	adidas
8	Bruno Guimaraes	1997-11-16	39	Rio de Janeiro	1.82	Brazil	Midfield - Defensive Midfield	right	Bertolucci Sports	adidas
9	Cole Palmer	2002-05-06	20	Manchester	1.89	England	Midfield - Attacking Midfield	left	CAA Base Ltd	Nike
10	Ruben Dias	1997-05-14	3	Amadora	1.87	Portugal	Defender - Centre-Back	right	Gestifute	Nike
11	William Saliba	2001-03-24	2	Bondy	1.92	France	Defender - Centre-Back	right	ND SPORTS MANAGEMENT	\N
12	Josko Gvardiol	2002-01-23	24	Zagreb	1.85	Croatia	Defender - Left-Back	left	Marjan Sisic	\N
13	Dominik Szoboszlai	2000-10-25	8	Szekesfehervar	1.87	Hungary	Midfield - Central Midfield	right	EM Sports Consulting	\N
14	Alexander Isak	1999-09-21	14	Solna	1.92	Sweden	Attack - Centre-Forward	right	Universal Twenty Two	adidas
15	Moises Caicedo	2001-11-02	25	Santo Domingo	1.78	Ecuador	Midfield - Defensive Midfield	right	FOOTBALL DIVISION	\N
16	Luis Diaz	1997-01-13	7	Barrancas	1.80	Colombia	Attack - Left Winger	right	Nomi Sports	\N
17	Enzo Fernandez	2001-01-17	8	San Martin	1.78	Argentina	Midfield - Central Midfield	right	DE 9 FUTBOL	\N
18	Alexis Mac Allister	1998-12-24	10	Santa Rosa	1.76	Argentina	Midfield - Central Midfield	right	\N	adidas
19	Kai Havertz	1999-06-11	29	Aachen	1.93	Germany	Midfield - Attacking Midfield	left	ROOF	Puma
20	James Maddison	1996-11-23	10	Coventry	1.75	England	Midfield - Attacking Midfield	right	CAA Base Ltd	Puma
21	Gabriel Martinelli	2001-06-18	11	Guarulhos	1.78	Brazil	Attack - Left Winger	right	Roc Nation Sports	adidas
22	Darwin Nunez	1999-06-24	9	Artigas	1.87	Uruguay	Attack - Centre-Forward	right	Gestifute	\N
23	Gabriel Magalhaes	1997-12-19	6	Sao Paulo	1.90	Brazil	Defender - Centre-Back	left	Bertolucci Sports	\N
24	Trent Alexander-Arnold	1998-10-07	66	Liverpool	1.80	England	Defender - Right-Back	right	PLG	adidas
25	Bernardo Silva	1994-08-10	20	Lisboa	1.73	Portugal	Midfield - Attacking Midfield	left	Gestifute	adidas
26	Ollie Watkins	1995-12-30	11	Torquay	1.80	England	Attack - Centre-Forward	right	Two Touch Agency	Under Armour
27	Cristian Romero	1998-04-27	17	Cordoba	1.85	Argentina	Defender - Centre-Back	right	Ciro Palermo	\N
28	Lucas Paqueta	1997-08-27	10	Paqueta	1.80	Brazil	Midfield - Attacking Midfield	left	Roc Nation Sports	Nike
29	Christopher Nkunku	1997-11-14	18	Lagny-sur-Marne	1.77	Congo	Midfield - Attacking Midfield	right	Gol International	adidas
30	Jeremy Doku	2002-05-27	11	Borgerhout	1.73	Belgium	Attack - Left Winger	right	Elevate	Nike
31	Rasmus Hojlund	2003-02-04	9	Kobenhavn	1.91	Denmark	Attack - Centre-Forward	left	SEG	\N
32	Gabriel Jesus	1997-04-03	9	Sao Paulo	1.75	Brazil	Attack - Centre-Forward	right	Energy Sports	adidas
33	Marcus Rashford	1997-10-31	10	Manchester	1.85	Nevis	Attack - Left Winger	right	Relatives	Nike
34	Anthony Gordon	2001-02-24	10	Liverpool	1.82	England	Attack - Left Winger	right	Unique Sports Group	adidas
35	Jack Grealish	1995-09-10	10	Birmingham	1.80	England	Attack - Left Winger	right	CAA Stellar	Puma
36	Ben White	1997-10-08	4	Poole	1.86	England	Defender - Right-Back	right	\N	adidas
37	Dejan Kulusevski	2000-04-25	21	Stockholm	1.86	Macedonia	Attack - Right Winger	left	World Soccer Agency	\N
38	Cody Gakpo	1999-05-07	18	Eindhoven	1.93	Netherlands	Attack - Left Winger	right	SEG	Puma
39	Mohamed Salah	1992-06-15	11	Nagrig, Basyoun	1.75	Egypt	Attack - Right Winger	left	\N	adidas
40	Kobbie Mainoo	2005-04-19	37	Stockport	1.80	England	Midfield - Central Midfield	right	CAA Stellar	\N
41	Micky van de Ven	2001-04-19	37	Wormer	1.93	Netherlands	Defender - Centre-Back	left	Team Raiola	\N
42	Pedro Neto	2000-03-09	7	Viana do Castelo	1.72	Portugal	Attack - Right Winger	left	Gestifute	\N
43	Bruno Fernandes	1994-09-08	8	Maia	1.79	Portugal	Midfield - Attacking Midfield	right	MRP.POSITIONUMBER	Nike
44	Eberechi Eze	1998-06-29	10	London	1.78	England	Midfield - Attacking Midfield	right	CAA Base Ltd	New Balance
45	Lisandro Martinez	1998-01-18	6	Gualeguay	1.75	Argentina	Defender - Centre-Back	left	Score Futbol	\N
46	Evan Ferguson	2004-10-19	28	Bettystown, Meath	1.88	Ireland	Attack - Centre-Forward	right	YMU Management Ltd.	\N
47	Ivan Toney	1996-03-16	17	Northampton	1.85	England	Attack - Centre-Forward	right	CAA Stellar	\N
48	Conor Gallagher	2000-02-06	23	Epsom	1.82	England	Midfield - Central Midfield	right	Elite Management	\N
49	Matheus Nunes	1998-08-27	27	Rio de Janeiro	1.83	Portugal	Midfield - Central Midfield	right	Gestifute	\N
50	Amadou Onana	2001-08-16	24	Dakar	1.95	Belgium	Midfield - Defensive Midfield	right	BTFM	\N
51	Jarrod Bowen	1996-12-20	20	Leominster	1.76	England	Attack - Right Winger	left	PLG	adidas
52	Savinho	2004-04-10	26	Sao Mateus	1.76	Brazil	Attack - Right Winger	left	Promanager	Nike
53	Diogo Jota	1996-12-04	20	Porto	1.78	Portugal	Attack - Left Winger	right	Gestifute	adidas
54	Leny Yoro	2005-11-13	15	Saint-Maurice	1.90	Ivoire	Defender - Centre-Back	right	Gestifute	\N
55	Mohammed Kudus	2000-08-02	14	Accra	1.77	Ghana	Midfield - Attacking Midfield	left	Relatives	Sketchers
56	Kevin De Bruyne	1991-06-28	17	Drongen	1.81	Belgium	Midfield - Attacking Midfield	right	Roc Nation Sports	Nike
57	Brennan Johnson	2001-05-23	22	Nottingham	1.86	Wales	Attack - Right Winger	right	Unique Sports Group	\N
58	Pau Torres	1997-01-16	14	Villarreal	1.92	Spain	Defender - Centre-Back	left	InterStarDeporte	\N
59	Pape Matar Sarr	2002-09-14	29	Thiaroye	1.84	Senegal	Midfield - Central Midfield	right	CAA Base Ltd	\N
60	Matheus Cunha	1999-05-27	12	Joao Pessoa	1.83	Brazil	Attack - Centre-Forward	right	Bertolucci Sports	Nike
61	Pedro Porro	1999-09-13	23	Don Benito	1.73	Spain	Defender - Right-Back	right	CAA Base Ltd	Under Armour
62	Kaoru Mitoma	1997-05-20	22	Kawasaki, Kanagawa	1.78	Japan	Attack - Left Winger	right	\N	Puma
63	Alejandro Garnacho	2004-07-01	17	Madrid	1.80	Argentina	Attack - Left Winger	right	#LEADERS	Nike
64	Heung-min Son	1992-07-08	7	Chuncheon, Gangwon	1.84	South	Attack - Left Winger	both	CAA Base Ltd	adidas
65	Manuel Akanji	1995-07-19	25	Wiesendangen	1.88	Switzerland	Defender - Centre-Back	right	IFM	Puma
66	Destiny Udogie	2002-11-28	13	Verona	1.88	Italy	Defender - Left-Back	left	Football Service	Puma
67	Joao Pedro	2001-09-26	9	Ribeirao Preto	1.88	Brazil	Attack - Centre-Forward	right	Promanager	\N
68	Ibrahima Konate	1999-05-25	5	Paris	1.94	France	Defender - Centre-Back	right	CAA Stellar	Nike
69	Sven Botman	2000-01-12	4	Badhoevedorp	1.95	Netherlands	Defender - Centre-Back	left	Muy Manero	adidas
70	Leon Bailey	1997-08-09	31	Kingston	1.78	Jamaica	Attack - Right Winger	left	Phoenix Sports	Nike
71	Jarrad Branthwaite	2002-06-27	32	Carlisle	1.95	England	Defender - Centre-Back	left	\N	\N
72	Axel Disasi	1998-03-11	2	Gonesse	1.90	Congo	Defender - Centre-Back	right	Relatives	\N
73	Joelinton	1996-08-14	7	Alianca	1.86	Brazil	Midfield - Central Midfield	right	ROGON	\N
74	Morgan Gibbs-White	2000-01-27	10	Stafford	1.71	England	Midfield - Attacking Midfield	right	CAA Stellar	\N
75	Nathan Ake	1995-02-18	6	Den Haag	1.80	Ivoire	Defender - Centre-Back	left	Wasserman	Nike
76	Ian Maatsen	2002-03-10	22	Vlaardingen	1.78	Netherlands	Defender - Left-Back	left	Epic Sports	\N
77	Bryan Mbeumo	1999-08-07	19	Avallon	1.71	Cameroon	Attack - Right Winger	left	ESN	\N
78	Reece James	1999-12-08	24	London	1.80	England	Defender - Right-Back	right	Unique Sports Group	Nike
79	Dominic Solanke	1997-09-14	9	Basingstoke	1.86	England	Attack - Centre-Forward	right	Relatives	adidas
80	Sandro Tonali	2000-05-08	8	Lodi	1.81	Italy	Midfield - Defensive Midfield	right	GR Sports	Nike
81	Jurrien Timber	2001-06-17	12	Utrecht	1.79	Netherlands	Defender - Centre-Back	right	Forza Sports Group	adidas
82	Rico Lewis	2004-11-21	82	Bury	1.69	England	Defender - Right-Back	right	CAA Base Ltd	\N
83	Marc Guehi	2000-07-13	6	Abidjan	1.82	Ivoire	Defender - Centre-Back	right	Unique Sports Group	\N
84	Richarlison	1997-05-10	9	Nova Venecia	1.84	Brazil	Attack - Centre-Forward	right	\N	Nike
85	Boubacar Kamara	1999-11-23	44	Marseille	1.84	France	Midfield - Defensive Midfield	right	Sport Avenir	Nike
86	John Stones	1994-05-28	5	Barnsley	1.88	England	Defender - Centre-Back	right	Wasserman	Nike
87	Oleksandr Zinchenko	1996-12-15	35	Radomyshl, Zhytomyr Oblast	1.75	Ukraine	Defender - Left-Back	left	UniqueFA	Sketchers
88	Takehiro Tomiyasu	1998-11-05	18	Fukuoka, Fukuoka	1.88	Japan	Defender - Right-Back	right	UDN SPORTS	\N
89	Romeo Lavia	2004-01-06	45	Brussels	1.81	Belgium	Midfield - Defensive Midfield	right	Elite Project Group	adidas
90	Ederson	1993-08-17	31	Osasco (SP)	1.88	Brazil	Goalkeeper	left	Gestifute	Puma
91	Andre Onana	1996-04-02	24	Nkol Ngok	1.90	Cameroon	Goalkeeper	right	Goal Management	adidas
92	Yves Bissouma	1996-08-30	8	Issia	1.82	Ivoire	Midfield - Defensive Midfield	right	AMS CONSULTING	Nike
93	Rodrigo Bentancur	1997-06-25	30	Nueva Helvecia	1.87	Uruguay	Midfield - Central Midfield	right	Back Sports S.A.	adidas
94	Ezri Konsa	1997-10-23	4	London	1.83	Congo	Defender - Centre-Back	right	CAA Stellar	\N
95	Harvey Elliott	2003-04-04	19	London	1.70	England	Midfield - Central Midfield	left	ROOF	New Balance
96	Mason Mount	1999-01-10	7	Portsmouth	1.81	England	Midfield - Attacking Midfield	right	Relatives	Nike
97	Joao Gomes	2001-02-12	8	Rio de Janeiro	1.76	Brazil	Midfield - Central Midfield	right	Carlos Leite	Nike
98	Edson Alvarez	1997-10-24	19	Tlalnepantla	1.90	Mexico	Midfield - Defensive Midfield	right	PROMOFUT	adidas
99	Malo Gusto	2003-05-19	27	Decines-Charpieu	1.78	France	Defender - Right-Back	right	E CASTAGNINO	\N
100	Tino Livramento	2002-11-12	21	London	1.82	England	Defender - Right-Back	right	Wasserman	adidas
\.


--
-- Data for Name: player_award; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_award (player_id, award_id, year) FROM stdin;
1	1	2023
1	2	2023
1	3	2024
1	4	2024
1	4	2023
1	5	2023
1	6	2021
1	7	2020
1	7	2018
1	8	2020
1	9	2023
1	9	2022
1	9	2021
1	9	2020
1	9	2019
1	10	2022
1	10	2021
1	11	2018
1	12	2019
1	13	2024
1	14	2017
1	15	2019
1	16	2019
1	17	2022
1	17	2021
1	17	2020
1	18	2019
1	19	2024
1	19	2023
1	19	2021
1	19	2019
1	20	2023
1	20	2020
1	21	2023
2	2	2023
2	3	2024
2	22	2022
2	23	2021
2	4	2024
2	4	2023
2	4	2022
2	4	2021
2	4	2019
2	4	2018
2	5	2023
2	5	2019
2	24	2021
2	24	2020
2	24	2019
2	24	2018
2	25	2020
2	25	2019
2	26	2019
2	27	2017
2	13	2024
2	14	2017
2	28	2017
2	17	2023
2	17	2022
2	17	2021
2	17	2020
2	17	2019
2	17	2018
2	17	2017
2	20	2024
3	22	2022
3	23	2021
3	5	2020
3	25	2024
3	25	2021
3	29	2021
3	14	2018
3	18	2023
3	18	2021
3	18	2020
3	18	2019
3	30	2019
4	31	2024
4	2	2023
4	3	2024
4	23	2021
4	22	2022
4	4	2024
4	4	2023
4	4	2022
4	4	2021
4	5	2023
4	24	2021
4	24	2020
4	25	2020
4	32	2023
4	33	2021
4	34	2024
4	34	2023
4	26	2017
4	13	2024
4	13	2019
4	35	2015
4	21	2023
5	36	2023
5	22	2022
5	23	2021
5	25	2024
5	29	2021
5	21	2023
6	25	2024
6	7	2014
6	9	2019
6	13	2017
6	37	2020
6	17	2021
6	18	2023
6	18	2021
7	38	2022
7	39	2024
7	39	2021
7	40	2021
7	2	2023
7	3	2024
7	22	2022
7	41	2021
7	4	2024
7	4	2023
7	5	2023
7	42	2022
7	43	2018
7	12	2019
7	13	2024
7	44	2024
7	45	2020
7	46	2021
7	47	2021
7	48	2019
7	49	2019
7	19	2024
7	19	2021
7	20	2021
8	22	2022
8	50	2021
8	51	2021
8	52	2018
8	53	2019
8	17	2020
8	18	2022
9	2	2023
9	4	2024
9	4	2023
9	4	2022
9	5	2023
9	24	2021
9	54	2022
9	54	2021
9	13	2024
9	14	2019
9	55	2020
9	56	2020
9	57	2023
9	17	2022
9	17	2021
9	17	2020
10	2	2023
10	3	2024
10	22	2022
10	22	2018
10	23	2021
10	4	2024
10	4	2023
10	4	2022
10	4	2021
10	58	2019
10	5	2023
10	24	2021
10	32	2019
10	59	2020
10	9	2021
10	60	2021
10	11	2016
10	12	2017
10	13	2024
10	14	2014
10	17	2023
10	17	2022
10	17	2021
10	17	2020
10	17	2019
10	17	2018
10	17	2016
10	18	2020
10	18	2019
10	21	2021
11	22	2022
11	25	2024
11	25	2021
11	7	2022
11	61	2022
11	18	2023
11	18	2022
11	18	2020
12	3	2024
12	22	2022
12	23	2021
12	4	2024
12	6	2023
12	6	2022
12	26	2021
12	62	2022
12	13	2024
12	63	2021
12	63	2020
12	64	2019
12	65	2021
12	17	2023
12	17	2022
12	18	2022
12	18	2021
13	23	2024
13	6	2023
13	6	2022
13	24	2024
13	9	2022
13	14	2017
13	15	2021
13	15	2020
13	15	2019
13	15	2018
13	16	2021
13	16	2020
13	16	2019
13	66	2017
13	17	2023
13	17	2022
13	17	2021
13	17	2020
13	18	2022
13	18	2020
13	18	2019
13	21	2020
14	23	2021
14	6	2017
14	7	2016
14	67	2017
14	68	2017
14	37	2020
14	17	2018
14	18	2022
14	18	2021
14	18	2018
14	19	2020
15	22	2022
15	41	2021
15	69	2020
15	52	2019
16	41	2021
16	41	2019
16	58	2022
16	58	2020
16	5	2022
16	24	2024
16	24	2022
16	25	2023
16	70	2022
16	70	2020
16	59	2021
16	71	2019
16	71	2018
16	72	2019
16	73	2017
16	17	2023
16	17	2022
16	17	2021
16	18	2020
16	19	2021
17	38	2022
17	39	2024
17	22	2022
17	58	2023
17	7	2022
17	52	2020
17	74	2021
17	46	2021
17	47	2021
17	17	2023
18	38	2022
18	39	2024
18	22	2022
18	50	2021
18	24	2024
18	42	2022
18	46	2020
18	75	2017
19	2	2021
19	3	2022
19	22	2022
19	23	2021
19	25	2024
19	76	2020
19	77	2016
19	78	2016
19	79	2018
19	13	2022
19	14	2016
19	80	2016
19	81	2016
19	17	2023
19	17	2022
19	17	2020
19	17	2017
19	18	2020
19	18	2019
19	20	2019
20	22	2022
20	5	2021
20	25	2022
20	26	2019
20	18	2022
20	18	2021
21	22	2022
21	50	2021
21	5	2020
21	25	2024
21	51	2021
21	18	2023
21	18	2021
21	18	2020
22	22	2022
22	24	2024
22	25	2023
22	10	2022
22	12	2019
22	82	2018
22	82	2017
22	19	2022
22	21	2022
22	20	2022
23	25	2024
23	63	2018
23	17	2020
23	18	2023
23	18	2021
24	2	2019
24	3	2020
24	22	2022
24	22	2018
24	4	2020
24	5	2022
24	24	2024
24	24	2022
24	25	2023
24	33	2018
24	27	2015
24	13	2020
24	14	2015
24	17	2023
24	17	2022
24	17	2021
24	17	2020
24	17	2019
24	17	2018
24	49	2020
25	2	2023
25	3	2024
25	22	2022
25	22	2018
25	23	2021
25	4	2024
25	4	2023
25	4	2022
25	4	2021
25	4	2019
25	4	2018
25	83	2017
25	58	2014
25	5	2023
25	5	2019
25	24	2021
25	24	2020
25	24	2019
25	24	2018
25	84	2014
25	25	2020
25	25	2019
25	32	2019
25	85	2015
25	70	2014
25	9	2019
25	86	2017
25	34	2019
25	11	2014
25	26	2015
25	17	2023
25	17	2022
25	17	2021
25	17	2020
25	17	2019
25	17	2018
25	17	2017
25	17	2015
25	18	2016
26	21	2020
27	38	2022
27	39	2024
27	39	2021
27	41	2021
27	22	2022
27	42	2022
27	60	2021
27	17	2023
27	17	2021
28	39	2019
28	36	2023
28	41	2021
28	41	2019
28	22	2022
28	87	2021
28	88	2016
28	18	2022
29	83	2019
29	83	2018
29	83	2016
29	89	2018
29	89	2017
29	6	2023
29	6	2022
29	90	2018
29	90	2017
29	91	2019
29	91	2018
29	91	2017
29	76	2021
29	9	2022
29	12	2017
29	17	2023
29	17	2022
29	17	2021
29	17	2020
29	17	2019
29	17	2017
29	17	2016
29	18	2022
29	19	2023
29	20	2022
30	3	2024
30	22	2022
30	23	2021
30	4	2024
30	14	2019
30	14	2018
30	17	2021
30	18	2023
31	5	2024
31	92	2022
31	16	2023
32	39	2019
32	41	2021
32	41	2019
32	22	2022
32	22	2018
32	50	2016
32	4	2022
32	4	2021
32	4	2019
32	4	2018
32	5	2019
32	24	2021
32	24	2020
32	24	2019
32	24	2018
32	25	2020
32	25	2019
32	51	2016
32	7	2015
32	93	2015
32	9	2016
32	12	2015
32	94	2016
32	53	2015
32	17	2022
32	17	2021
32	17	2020
32	17	2019
32	17	2018
32	18	2023
33	95	2017
33	23	2021
33	23	2016
33	22	2022
33	22	2018
33	5	2024
33	5	2016
33	24	2023
33	24	2017
33	25	2017
33	29	2021
33	54	2016
33	96	2019
33	18	2020
33	19	2023
33	21	2023
33	21	2020
34	54	2019
34	57	2023
34	18	2018
35	2	2023
35	3	2024
35	22	2022
35	23	2021
35	4	2024
35	4	2023
35	4	2022
35	5	2023
35	29	2021
35	97	2019
35	26	2017
35	13	2024
35	17	2023
35	17	2022
36	22	2022
36	23	2021
36	25	2024
36	98	2020
36	18	2023
37	23	2021
37	99	2021
37	100	2021
37	7	2020
37	101	2019
37	17	2023
37	17	2022
37	17	2021
38	22	2022
38	23	2021
38	24	2024
38	102	2023
38	102	2022
38	103	2016
38	26	2021
38	104	2022
38	105	2018
38	17	2019
38	18	2023
38	18	2022
38	18	2021
38	18	2020
38	19	2024
39	106	2018
39	106	2017
39	2	2019
39	3	2020
39	50	2012
39	22	2018
39	4	2020
39	5	2022
39	24	2024
39	24	2022
39	24	2015
39	25	2023
39	107	2022
39	107	2017
39	108	2014
39	108	2013
39	9	2022
39	9	2018
39	34	2019
39	109	2022
39	109	2019
39	109	2017
39	12	2011
39	13	2020
39	110	2011
39	17	2023
39	17	2022
39	17	2021
39	17	2020
39	17	2019
39	17	2018
39	17	2016
39	17	2015
39	17	2014
39	18	2017
39	18	2015
39	18	2013
39	49	2020
39	111	2018
39	19	2022
39	19	2019
39	19	2018
39	19	2017
39	21	2018
39	21	2013
39	20	2018
40	5	2024
40	24	2023
40	55	2022
40	18	2023
41	17	2022
42	99	2019
42	12	2019
42	81	2017
42	18	2020
43	22	2022
43	22	2018
43	23	2021
43	50	2016
43	5	2024
43	84	2019
43	84	2018
43	24	2023
43	32	2019
43	70	2019
43	9	2019
43	9	2018
43	26	2017
43	17	2022
43	17	2021
43	17	2018
43	18	2023
43	18	2021
43	18	2020
43	18	2019
43	18	2018
43	19	2020
43	19	2019
43	21	2020
43	20	2019
44	26	2021
45	38	2022
45	39	2024
45	39	2021
45	22	2022
45	41	2021
45	5	2024
45	24	2023
45	42	2022
45	102	2020
45	12	2017
45	104	2021
45	105	2022
45	105	2021
45	112	2022
45	17	2022
45	17	2021
45	17	2020
45	18	2023
45	18	2021
45	18	2020
45	21	2022
47	113	2018
47	114	2016
47	19	2021
47	19	2020
47	21	2020
48	95	2019
48	22	2022
48	11	2018
48	26	2021
48	27	2017
48	55	2018
48	55	2017
48	56	2018
48	56	2017
48	28	2017
48	17	2023
48	18	2019
49	3	2024
49	22	2022
49	58	2021
49	4	2024
49	84	2022
49	84	2021
49	59	2022
49	115	2022
49	17	2022
50	22	2022
50	14	2018
50	17	2022
51	36	2023
51	18	2022
52	102	2023
52	116	2023
52	94	2021
52	53	2021
52	104	2023
52	18	2023
53	23	2021
53	5	2022
53	24	2024
53	24	2022
53	32	2019
53	98	2018
53	26	2017
53	17	2023
53	17	2022
53	17	2021
53	17	2017
53	18	2020
55	22	2022
55	27	2017
55	104	2021
55	105	2022
55	105	2021
55	112	2022
55	17	2023
55	17	2022
55	17	2021
55	18	2021
56	2	2023
56	3	2024
56	22	2022
56	22	2018
56	22	2014
56	23	2021
56	23	2016
56	4	2024
56	4	2023
56	4	2022
56	4	2021
56	4	2019
56	4	2018
56	5	2023
56	5	2019
56	6	2015
56	24	2021
56	24	2020
56	24	2019
56	24	2018
56	24	2016
56	25	2020
56	25	2019
56	117	2016
56	118	2009
56	9	2021
56	9	2020
56	9	2015
56	62	2018
56	13	2023
56	119	2011
56	120	2012
56	20	2022
56	20	2020
56	21	2022
56	21	2020
56	19	2016
57	22	2022
58	95	2021
58	23	2021
58	50	2021
58	22	2022
58	121	2021
58	17	2022
58	18	2021
58	18	2018
59	122	2022
59	22	2022
59	109	2022
59	27	2019
59	17	2023
60	50	2021
60	51	2021
60	76	2019
60	17	2023
60	17	2022
60	17	2020
60	18	2019
60	19	2020
61	58	2021
61	84	2022
61	84	2021
61	60	2022
61	60	2021
61	17	2023
61	17	2022
62	22	2022
62	50	2021
62	123	2019
62	9	2022
62	9	2020
62	124	2023
62	125	2021
62	126	2020
62	127	2020
62	128	2021
62	129	2020
63	39	2024
63	5	2024
63	24	2023
63	19	2022
64	130	2017
64	130	2015
64	130	2014
64	22	2022
64	22	2018
64	22	2014
64	50	2016
64	131	2019
64	33	2019
64	132	2015
64	9	2022
64	9	2021
64	9	2020
64	9	2019
64	9	2017
64	9	2014
64	9	2013
64	124	2023
64	124	2019
64	124	2015
64	124	2011
64	27	2010
64	27	2009
64	17	2023
64	17	2020
64	17	2019
64	17	2018
64	17	2017
64	17	2015
64	17	2014
64	18	2021
64	18	2017
64	18	2016
64	111	2020
64	21	2020
64	21	2019
64	19	2022
64	19	2017
65	2	2023
65	3	2024
65	22	2022
65	22	2018
65	23	2021
65	4	2024
65	4	2023
65	5	2023
65	6	2021
65	117	2020
65	8	2020
65	8	2019
65	133	2017
65	108	2017
65	108	2016
65	13	2024
65	17	2023
65	17	2022
65	17	2021
65	17	2020
65	17	2019
65	17	2018
65	18	2022
65	18	2016
66	11	2020
66	27	2019
66	14	2019
68	22	2022
68	5	2022
68	24	2024
68	24	2022
68	25	2023
68	76	2021
68	76	2019
68	61	2022
68	26	2021
68	26	2019
68	17	2023
68	17	2022
68	17	2021
68	17	2020
68	17	2018
68	18	2019
68	18	2018
69	83	2021
69	91	2022
69	103	2017
69	134	2017
69	26	2021
69	17	2022
69	18	2021
70	76	2020
70	7	2016
70	135	2021
70	135	2019
70	17	2020
70	17	2017
70	18	2021
70	18	2020
70	18	2019
70	18	2017
71	104	2023
71	57	2023
71	18	2023
72	22	2022
72	61	2022
72	26	2021
72	18	2023
72	18	2022
73	17	2019
73	18	2017
73	21	2022
74	98	2018
74	26	2019
74	27	2017
74	57	2023
74	28	2017
74	18	2020
75	2	2023
75	3	2024
75	95	2013
75	22	2022
75	23	2021
75	4	2024
75	4	2023
75	4	2022
75	4	2021
75	4	2017
75	4	2015
75	5	2023
75	24	2021
75	24	2015
75	54	2014
75	103	2011
75	27	2011
75	13	2024
75	14	2012
75	14	2011
75	55	2012
75	136	2012
75	136	2011
75	17	2023
75	17	2022
75	17	2021
75	17	2015
75	17	2014
75	18	2013
76	98	2023
76	103	2018
76	27	2019
76	14	2019
76	136	2019
76	81	2019
76	17	2020
77	22	2022
78	2	2021
78	23	2021
78	29	2021
78	11	2017
78	13	2022
78	55	2018
78	55	2017
78	56	2018
78	56	2017
78	35	2017
78	17	2023
78	17	2022
78	17	2021
78	17	2020
79	4	2017
79	33	2018
79	137	2015
79	54	2014
79	34	2017
79	11	2016
79	26	2019
79	12	2017
79	14	2014
79	55	2015
79	55	2014
79	136	2014
79	138	2017
79	17	2018
79	17	2015
79	19	2015
79	19	2014
80	139	2022
80	97	2019
80	11	2018
80	26	2021
80	26	2019
80	140	2019
80	17	2023
80	17	2022
80	18	2021
80	21	2019
80	21	2018
81	22	2022
81	23	2021
81	25	2024
81	7	2022
81	9	2022
81	103	2017
81	134	2019
81	141	2019
81	14	2018
81	104	2021
81	105	2022
81	105	2021
81	112	2022
81	136	2018
81	17	2023
81	17	2022
81	17	2021
81	17	2020
81	18	2021
81	18	2020
82	2	2023
82	3	2024
82	4	2024
82	4	2023
82	5	2023
82	54	2023
82	54	2022
82	13	2024
82	56	2022
82	56	2021
82	17	2023
83	26	2021
83	27	2017
83	14	2017
83	55	2018
83	55	2017
83	56	2018
83	56	2017
83	28	2017
83	17	2020
84	39	2019
84	41	2021
84	41	2019
84	22	2022
84	50	2021
84	51	2021
84	87	2021
84	17	2023
84	19	2021
85	11	2018
85	26	2021
85	12	2019
85	14	2016
85	17	2021
85	18	2022
85	18	2019
85	18	2018
85	30	2018
86	2	2023
86	3	2024
86	23	2021
86	23	2016
86	22	2022
86	22	2018
86	4	2024
86	4	2023
86	4	2022
86	4	2021
86	4	2019
86	4	2018
86	5	2023
86	5	2019
86	24	2021
86	24	2020
86	24	2019
86	24	2018
86	25	2020
86	25	2019
86	29	2021
86	26	2015
86	12	2013
86	13	2024
86	17	2023
86	17	2022
86	17	2021
86	17	2020
86	17	2019
86	17	2018
86	17	2017
86	18	2015
87	23	2021
87	23	2016
87	4	2022
87	4	2021
87	4	2019
87	4	2018
87	5	2019
87	24	2021
87	24	2020
87	24	2019
87	24	2018
87	25	2020
87	25	2019
87	9	2019
87	11	2015
87	14	2013
87	17	2022
87	17	2021
87	17	2020
87	17	2019
87	17	2018
87	17	2017
87	18	2023
88	41	2019
88	22	2022
88	50	2021
88	25	2024
88	124	2023
88	124	2019
88	12	2017
88	18	2023
89	54	2022
89	54	2021
89	56	2021
89	17	2022
90	39	2019
90	2	2023
90	3	2024
90	41	2021
90	41	2019
90	22	2022
90	22	2018
90	4	2024
90	4	2023
90	4	2022
90	4	2021
90	4	2019
90	4	2018
90	58	2017
90	58	2016
90	5	2023
90	5	2019
90	24	2021
90	24	2020
90	24	2019
90	24	2018
90	84	2016
90	25	2020
90	25	2019
90	70	2017
90	59	2017
90	142	2017
90	13	2024
90	87	2021
90	17	2023
90	17	2022
90	17	2021
90	17	2020
90	17	2019
90	17	2018
90	17	2017
90	17	2016
90	18	2015
91	22	2022
91	99	2023
91	5	2024
91	100	2023
91	33	2023
91	102	2020
91	86	2017
91	109	2022
91	109	2019
91	104	2021
91	104	2019
91	105	2022
91	105	2021
91	105	2019
91	112	2022
91	17	2022
91	17	2021
91	17	2020
91	17	2019
91	18	2016
91	30	2017
92	109	2022
92	109	2017
92	17	2023
93	22	2022
93	22	2018
93	41	2021
93	41	2019
93	139	2020
93	139	2019
93	139	2018
93	99	2021
93	99	2018
93	100	2021
93	100	2019
93	12	2017
93	116	2017
93	46	2017
93	46	2015
93	48	2015
93	17	2023
93	17	2022
93	17	2021
93	17	2020
93	17	2019
93	17	2018
94	26	2019
94	12	2017
94	138	2017
95	3	2020
95	4	2020
95	5	2022
95	24	2024
95	24	2022
95	25	2023
95	13	2020
95	57	2023
95	17	2023
95	17	2022
95	49	2020
96	2	2021
96	3	2022
96	22	2022
96	23	2021
96	5	2024
96	29	2021
96	137	2016
96	34	2017
96	26	2019
96	13	2022
96	14	2016
96	55	2017
96	55	2016
96	56	2017
96	35	2017
96	17	2023
96	17	2022
96	17	2020
96	18	2018
97	43	2022
97	94	2020
97	143	2021
97	53	2022
98	144	2023
98	144	2019
98	22	2022
98	22	2018
98	135	2021
98	135	2019
98	135	2017
98	12	2017
98	145	2019
98	146	2019
98	104	2021
98	105	2022
98	105	2021
98	112	2022
98	17	2023
98	17	2022
98	17	2021
98	17	2020
98	49	2017
98	147	2018
99	18	2022
\.


--
-- Data for Name: player_value; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_value (value_id, player_id, market_value, update_date) FROM stdin;
1	1	180.00	2024-05-27
2	2	150.00	2024-05-27
3	3	140.00	2024-05-27
4	4	130.00	2024-07-18
5	5	120.00	2024-05-27
6	6	110.00	2024-05-27
7	7	90.00	2024-05-27
8	8	85.00	2024-05-27
9	9	80.00	2024-05-27
10	10	80.00	2024-05-27
11	11	80.00	2024-05-27
12	12	75.00	2024-05-27
13	13	75.00	2024-05-27
14	14	75.00	2024-05-27
15	15	75.00	2024-05-27
16	16	75.00	2024-05-27
17	17	75.00	2024-05-27
18	18	75.00	2024-05-27
19	19	70.00	2024-05-27
20	20	70.00	2024-05-27
21	21	70.00	2024-05-27
22	22	70.00	2024-05-27
23	23	70.00	2024-05-27
24	24	70.00	2024-05-27
25	25	70.00	2024-05-27
26	26	65.00	2024-05-27
27	27	65.00	2024-07-19
28	28	65.00	2024-05-27
29	29	65.00	2024-05-27
30	30	65.00	2024-05-27
31	31	65.00	2024-05-27
32	32	65.00	2024-05-27
33	33	60.00	2024-05-27
34	34	60.00	2024-05-27
35	35	60.00	2024-05-27
36	36	55.00	2024-05-27
37	37	55.00	2024-05-27
38	38	55.00	2024-07-18
39	39	55.00	2024-05-27
40	40	55.00	2024-07-18
41	41	55.00	2024-05-27
42	42	55.00	2024-05-27
43	43	70.00	2024-05-27
44	44	55.00	2024-05-27
45	45	50.00	2024-07-19
46	46	50.00	2024-05-27
47	47	50.00	2024-05-27
48	48	50.00	2024-05-27
49	49	50.00	2024-05-27
50	50	50.00	2024-05-27
51	51	50.00	2024-05-27
52	52	50.00	2024-06-07
53	53	50.00	2024-05-27
54	54	50.00	2024-06-03
55	55	50.00	2024-05-27
56	56	50.00	2024-05-27
57	57	48.00	2024-05-27
58	58	45.00	2024-05-27
59	59	45.00	2024-05-27
60	60	45.00	2024-05-27
61	61	45.00	2024-05-27
62	62	45.00	2024-05-27
63	63	45.00	2024-05-27
64	64	45.00	2024-05-27
65	65	45.00	2024-05-27
66	66	45.00	2024-05-27
67	67	45.00	2024-05-27
68	68	45.00	2024-05-27
69	69	45.00	2024-05-27
70	70	42.00	2024-05-27
71	71	42.00	2024-05-27
72	72	40.00	2024-05-27
73	73	40.00	2024-05-27
74	74	40.00	2024-05-27
75	75	40.00	2024-05-27
76	76	40.00	2024-05-29
77	77	40.00	2024-05-27
78	78	40.00	2024-05-27
79	79	40.00	2024-05-27
80	80	38.00	2024-05-27
81	81	38.00	2024-05-27
82	82	38.00	2024-05-27
83	83	38.00	2024-05-27
84	84	38.00	2024-05-27
85	85	38.00	2024-05-27
86	86	38.00	2024-05-27
87	87	38.00	2024-05-27
88	88	35.00	2024-05-27
89	89	35.00	2024-05-27
90	90	35.00	2024-05-27
91	91	35.00	2024-05-27
92	92	35.00	2024-05-27
93	93	35.00	2024-05-27
94	94	35.00	2024-05-27
95	95	35.00	2024-05-27
96	96	35.00	2024-05-27
97	97	35.00	2024-05-27
98	98	35.00	2024-05-27
99	99	35.00	2024-05-27
100	100	35.00	2024-05-27
\.


--
-- Data for Name: stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stats (stats_id, season, match_played, minutes_played, player_id) FROM stdin;
\.


--
-- Data for Name: transfer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transfer (transfer_id, transfer_date, from_club, to_club, market_value, fee, is_loan, player_id) FROM stdin;
1	2022-07-01	Bor. Dortmund	Man City	150.00	60.00	f	1
2	2020-01-01	RB Salzburg	Bor. Dortmund	45.00	20.00	f	1
3	2019-01-01	Molde FK	RB Salzburg	5.00	8.00	f	1
4	2017-02-01	Bryne	Molde FK	0.20	0.10	f	1
5	2015-09-08	Bryne FK Yth.	Bryne	0.00	0.00	f	1
6	2017-07-01	Man City U18	Man City	0.00	0.00	f	2
7	2016-07-01	Man City Youth	Man City U18	0.00	0.00	f	2
8	2019-07-01	Arsenal U23	Arsenal	0.00	0.00	f	3
9	2018-07-01	Arsenal U18	Arsenal U23	0.00	0.00	f	3
10	2017-07-01	Arsenal Youth	Arsenal U18	0.00	0.00	f	3
11	2021-08-20	Real Madrid	Arsenal	40.00	35.00	f	6
12	2021-06-30	Arsenal	Real Madrid	40.00	0.00	t	6
13	2021-01-27	Real Madrid	Arsenal	40.00	2.00	t	6
14	2020-07-20	Real Sociedad	Real Madrid	45.00	0.00	t	6
15	2019-07-05	Real Madrid	Real Sociedad	15.00	2.00	t	6
16	2019-06-30	Vitesse	Real Madrid	15.00	0.00	t	6
17	2018-08-21	Real Madrid	Vitesse	4.00	0.00	t	6
18	2018-06-30	Heerenveen	Real Madrid	4.00	0.00	t	6
19	2017-01-09	Real Madrid	Heerenveen	2.00	0.00	t	6
20	2017-01-08	RM Castilla	Real Madrid	2.00	0.00	f	6
21	2015-01-22	Stromsgodset	RM Castilla	4.00	2.80	f	6
22	2014-05-05	Stromsgodset II	Stromsgodset	1.00	0.00	f	6
23	2014-01-01	Godset Yth.	Stromsgodset II	0.00	0.00	f	6
24	2022-01-30	Olympique Lyon	Newcastle	30.00	42.10	f	8
25	2020-01-30	Athletico-PR	Olympique Lyon	20.00	20.00	f	8
26	2017-05-11	GO Audax	Atletico-PR	0.00	0.00	f	8
27	2020-09-29	Benfica	Man City	35.00	71.60	f	10
28	2017-07-01	Benfica B	Benfica	1.00	0.00	f	10
29	2015-07-01	Benfica U19	Benfica B	0.00	0.00	f	10
30	2014-07-01	Benfica U17	Benfica U19	0.00	0.00	f	10
31	2012-07-01	Benfica U15	Benfica U17	0.00	0.00	f	10
32	2010-07-01	Benfica Yth	Benfica U15	0.00	0.00	f	10
33	2008-07-01	Estrela A. F	Benfica Yth	0.00	0.00	f	10
34	2023-08-05	RB Leipzig	Man City	75.00	90.00	f	12
35	2021-07-01	Dinamo Zagreb	RB Leipzig	19.00	36.80	f	12
36	2019-07-01	Din. Zagreb U19	Dinamo Zagreb	0.00	0.00	f	12
37	2019-01-26	Din. Zagreb U17	Din. Zagreb U19	0.00	0.00	f	12
38	2017-07-01	D. Zagreb Yth.	Din. Zagreb U17	0.00	0.00	f	12
39	2010-09-03	NK Tresnjevka	D. Zagreb Yth.	0.00	0.00	f	12
40	2023-07-02	RB Leipzig	Liverpool	50.00	70.00	f	13
41	2021-01-01	RB Salzburg	RB Leipzig	25.00	36.00	f	13
42	2018-01-16	FC Liefering	RB Salzburg	0.50	0.00	f	13
43	2017-07-01	AKA Salzb. U18	FC Liefering	0.00	0.00	f	13
44	2017-03-29	Fonix U19	AKA Salzb. U18	0.00	0.50	f	13
45	2016-07-29	MTK U17	Fonix U19	0.00	0.00	f	13
46	2015-08-31	Fonix Jgd	MTK U17	0.00	0.00	f	13
47	2007-11-30	Videoton Jgd.	Fonix Jgd	0.00	0.00	f	13
48	2022-08-26	Real Sociedad	Newcastle	30.00	70.00	f	14
49	2019-07-01	Bor. Dortmund	Real Sociedad	8.00	15.00	f	14
50	2019-06-30	Willem II	Bor. Dortmund	8.00	0.00	t	14
51	2019-01-25	Bor. Dortmund	Willem II	3.00	0.00	t	14
52	2017-01-23	AIK	Bor. Dortmund	1.75	8.60	f	14
53	2016-05-03	AIK U19	AIK	0.00	0.00	f	14
54	2015-08-01	AIK U17	AIK U19	0.00	0.00	f	14
55	2023-01-31	Benfica	Chelsea	55.00	121.00	f	17
56	2022-07-14	River Plate	Benfica	15.00	44.25	f	17
57	2021-07-01	River Plate II	River Plate	5.00	0.00	f	17
58	2021-06-30	Defensa	River Plate II	5.00	0.00	t	17
59	2020-08-22	River Plate II	Defensa	0.00	0.00	t	17
60	2018-07-01	River Plate U20	River Plate II	0.00	0.00	f	17
61	2023-07-01	Brighton	Liverpool	65.00	42.00	f	18
62	2020-01-31	Boca Juniors	Brighton	12.50	0.00	t	18
63	2019-07-01	Brighton	Boca Juniors	5.00	0.00	t	18
64	2019-06-30	Argentinos Jrs.	Brighton	5.00	0.00	t	18
65	2019-01-25	Brighton	Argentinos Jrs.	5.00	0.00	t	18
66	2019-01-24	Argentinos Jrs.	Brighton	5.00	8.00	f	18
67	2017-07-01	Argentinos II	Argentinos Jrs.	0.00	0.00	f	18
68	2015-07-01	Argentinos U20	Argentinos II	0.00	0.00	f	18
69	2023-07-01	Chelsea	Arsenal	55.00	75.00	f	19
70	2020-09-04	B. Leverkusen	Chelsea	81.00	80.00	f	19
71	2016-07-01	Leverkusen U17	B. Leverkusen	0.10	0.00	f	19
72	2014-07-01	Leverkusen Yth.	Leverkusen U17	0.00	0.00	f	19
73	2010-07-01	Aachen Yth.	Leverkusen Yth.	0.00	0.00	f	19
74	2009-07-01	Mariadorf Yth.	Aachen Yth.	0.00	0.00	f	19
75	2023-07-01	Leicester	Tottenham	60.00	46.30	f	20
76	2018-07-01	Norwich	Leicester	10.00	25.00	f	20
77	2017-01-02	Aberdeen FC	Norwich	1.50	0.00	t	20
78	2016-08-31	Norwich	Aberdeen FC	1.50	0.00	t	20
79	2016-05-31	Coventry	Norwich	1.50	0.00	t	20
80	2016-02-02	Norwich	Coventry	0.50	0.00	t	20
81	2016-02-01	Coventry	Norwich	0.50	2.65	f	20
82	2014-07-01	Coventry U18	Coventry	0.00	0.00	f	20
83	2019-07-02	Ituano	Arsenal	0.00	7.10	f	21
84	2018-01-01	Ituano U20	Ituano	0.00	0.00	f	21
85	2022-07-01	Benfica	Liverpool	55.00	85.00	f	22
86	2020-09-04	UD Almeria	Benfica	10.00	34.00	f	22
87	2019-08-29	Penarol	UD Almeria	0.75	12.00	f	22
88	2017-07-01	CA Penarol U19	Penarol	0.00	0.00	f	22
89	2015-07-01	Penarol Yth.	CA Penarol U19	0.00	0.00	f	22
90	2016-07-01	Liverpool U18	Liverpool	0.00	0.00	f	24
91	2015-07-01	Liverpool Youth	Liverpool U18	0.00	0.00	f	24
92	2017-07-01	Monaco	Man City	40.00	50.00	f	25
93	2015-01-20	Benfica	Monaco	3.50	15.75	f	25
94	2015-01-19	Monaco	Benfica	3.50	0.00	t	25
95	2014-08-07	Benfica	Monaco	2.50	0.00	t	25
96	2014-07-01	Benfica B	Benfica	2.50	0.00	f	25
97	2013-07-01	Benfica U19	Benfica B	0.00	0.00	f	25
98	2011-07-01	Benfica U17	Benfica U19	0.00	0.00	f	25
99	2009-07-01	Benfica U15	Benfica U17	0.00	0.00	f	25
100	2007-07-01	Benfica Yth	Benfica U15	0.00	0.00	f	25
101	2022-08-30	Atalanta BC	Tottenham	48.00	52.00	f	27
102	2022-08-29	Tottenham	Atalanta BC	48.00	0.00	t	27
103	2021-08-06	Atalanta BC	Tottenham	35.00	0.00	t	27
104	2021-08-05	Juventus	Atalanta BC	35.00	17.00	f	27
105	2021-08-04	Atalanta BC	Juventus	35.00	0.00	t	27
106	2020-09-05	Juventus	Atalanta BC	14.00	2.32	t	27
107	2020-08-31	Genoa	Juventus	14.00	0.00	t	27
108	2019-07-13	Juventus	Genoa	15.00	0.00	t	27
109	2019-07-12	Genoa	Juventus	15.00	31.50	f	27
110	2018-07-01	Belgrano	Genoa	0.75	4.25	f	27
111	2016-07-01	Belgrano II	Belgrano	0.15	0.00	f	27
112	2015-07-01	Belgrano U20	Belgrano II	0.00	0.00	f	27
113	2022-08-29	Olympique Lyon	West Ham	35.00	42.95	f	28
114	2020-09-30	AC Milan	Olympique Lyon	20.00	23.00	f	28
115	2019-01-03	Flamengo	AC Milan	15.00	38.40	f	28
116	2016-03-02	Flamengo U20	Flamengo	0.00	0.00	f	28
117	2023-07-01	RB Leipzig	Chelsea	80.00	60.00	f	29
118	2019-07-18	Paris SG	RB Leipzig	12.00	19.50	f	29
119	2015-12-23	Paris SG B	Paris SG	0.00	0.00	f	29
120	2015-07-01	Paris SG U19	Paris SG B	0.00	0.00	f	29
121	2014-07-01	Paris SG U17	Paris SG U19	0.00	0.00	f	29
122	2011-07-01	PSG Youth	Paris SG U17	0.00	0.00	f	29
123	2023-08-24	Stade Rennais	Man City	28.00	60.00	f	30
124	2020-10-05	RSC Anderlecht	Stade Rennais	9.00	26.00	f	30
125	2019-07-01	Anderlecht U21	RSC Anderlecht	2.00	0.00	f	30
126	2018-07-01	Anderlecht U17	Anderlecht U21	0.00	0.00	f	30
127	2017-07-01	Anderlecht Yth.	Anderlecht U17	0.00	0.00	f	30
128	2012-07-01	Beerschot Yth	Anderlecht Yth.	0.00	0.00	f	30
129	2023-08-05	Atalanta BC	Man Utd	45.00	73.90	f	31
130	2022-08-27	Sturm Graz	Atalanta BC	4.50	20.00	f	31
131	2022-01-28	FC Copenhagen	Sturm Graz	1.00	1.95	f	31
132	2021-07-01	Copenhagen U19	FC Copenhagen	0.20	0.00	f	31
133	2020-08-01	FCK Youth	Copenhagen U19	0.00	0.00	f	31
134	2017-07-01	Brondby Youth	FCK Youth	0.00	0.00	f	31
135	2012-07-01	Horsholm U IK	Brondby Youth	0.00	0.00	f	31
136	2022-07-04	Man City	Arsenal	50.00	52.20	f	32
137	2017-01-01	Palmeiras	Man City	16.00	32.00	f	32
138	2015-01-01	Palmeiras U17	Palmeiras	0.00	0.00	f	32
139	2016-01-01	Man Utd U18	Man Utd	0.00	0.00	f	33
140	2023-01-29	Everton	Newcastle	40.00	45.60	f	34
141	2021-05-31	Preston	Everton	5.00	0.00	t	34
142	2021-02-01	Everton	Preston	5.00	0.00	t	34
143	2020-01-01	Everton U23	Everton	1.50	0.00	f	34
144	2018-07-01	Everton U18	Everton U23	0.00	0.00	f	34
145	2017-07-01	Everton Youth	Everton U18	0.00	0.00	f	34
146	2012-07-01	Liverpool Youth	Everton Youth	0.00	0.00	f	34
147	2021-08-05	Aston Villa	Man City	65.00	117.50	f	35
148	2014-05-04	Notts County	Aston Villa	0.25	0.00	t	35
149	2013-09-13	Aston Villa	Notts County	0.15	0.00	t	35
150	2013-07-01	Aston Villa U21	Aston Villa	0.00	0.00	f	35
151	2012-07-01	Aston Villa U18	Aston Villa U21	0.00	0.00	f	35
152	2010-07-01	A. Villa Yth.	Aston Villa U18	0.00	0.00	f	35
153	2021-07-30	Brighton	Arsenal	28.00	58.50	f	36
154	2020-07-31	Leeds	Brighton	5.50	0.00	t	36
155	2019-07-01	Brighton	Leeds	0.00	0.00	t	36
156	2019-05-31	Peterborough	Brighton	0.00	0.00	t	36
157	2019-01-03	Brighton	Peterborough	0.00	0.00	t	36
158	2018-07-01	Brighton U23	Brighton	0.00	0.00	f	36
159	2018-05-31	Newport County	Brighton U23	0.00	0.00	t	36
160	2017-08-01	Brighton U23	Newport County	0.00	0.00	t	36
161	2015-01-01	Brighton U18	Brighton U21	0.00	0.00	f	36
162	2014-07-01	Southampton Aca	Brighton U18	0.00	0.00	f	36
163	2023-07-01	Juventus	Tottenham	50.00	30.00	f	37
164	2023-06-30	Tottenham	Juventus	50.00	0.00	t	37
165	2022-01-31	Juventus	Tottenham	30.00	10.00	t	37
166	2020-08-31	Parma	Juventus	40.00	0.00	t	37
167	2020-01-03	Juventus	Parma	25.00	0.00	t	37
168	2020-01-02	Atalanta BC	Juventus	25.00	39.00	f	37
169	2020-01-01	Parma	Atalanta BC	25.00	0.00	t	37
170	2019-07-18	Atalanta BC	Parma	1.00	0.00	t	37
171	2019-01-01	Atalanta U19	Atalanta BC	0.00	0.00	f	37
172	2017-07-01	Atalanta U17	Atalanta U19	0.00	0.00	f	37
173	2016-07-07	IF Bromma U17	Atalanta U17	0.00	3.50	f	37
174	2023-01-01	PSV Eindhoven	Liverpool	60.00	42.00	f	38
175	2018-07-01	PSV U19	PSV Eindhoven	0.40	0.00	f	38
176	2016-07-01	PSV U17	PSV U19	0.00	0.00	f	38
177	2015-07-01	PSV Youth	PSV U17	0.00	0.00	f	38
178	2017-07-01	AS Roma	Liverpool	35.00	42.00	f	39
179	2016-07-01	Chelsea	AS Roma	23.00	15.00	f	39
180	2016-06-30	AS Roma	Chelsea	23.00	0.00	t	39
181	2015-08-06	Chelsea	AS Roma	18.00	5.00	t	39
182	2015-06-30	Fiorentina	Chelsea	12.00	0.00	t	39
183	2015-02-02	Chelsea	Fiorentina	13.00	0.00	t	39
184	2014-01-26	FC Basel	Chelsea	8.50	16.50	f	39
185	2012-07-01	El Mokawloon	FC Basel	1.50	2.50	f	39
186	2010-05-01	Mokawloon U23	El Mokawloon	0.00	0.00	f	39
187	2023-08-08	VfL Wolfsburg	Tottenham	30.00	40.00	f	41
188	2021-08-31	FC Volendam	VfL Wolfsburg	1.30	8.50	f	41
189	2019-07-01	Volendam U19	FC Volendam	0.00	0.00	f	41
190	2018-07-01	Volendam U17	Volendam U19	0.00	0.00	f	41
191	2016-07-01	Volendam Youth	Volendam U17	0.00	0.00	f	41
192	2013-07-01	WSV '30 Yth.	Volendam Youth	0.00	0.00	f	41
193	2019-08-02	Lazio	Wolves	2.50	17.90	f	42
194	2019-07-01	SC Braga	Lazio	2.50	11.00	f	42
195	2019-06-30	Lazio	SC Braga	2.50	0.00	t	42
196	2017-08-31	SC Braga	Lazio	0.25	7.50	t	42
197	2017-07-01	Braga U17	SC Braga	0.00	0.00	f	42
198	2016-06-30	Palmeiras U17	Braga U17	0.00	0.00	t	42
199	2015-08-01	Braga U15	Palmeiras U17	0.00	0.00	t	42
200	2013-07-01	PEJ - AD	Braga U15	0.00	0.00	f	42
201	2010-07-01	Vianense For.	PEJ - AD	0.00	0.00	f	42
202	2020-08-28	QPR	Crystal Palace	9.00	17.80	f	44
203	2018-01-02	Wycombe	QPR	0.00	0.00	t	44
204	2017-08-30	QPR	Wycombe	0.00	0.00	t	44
205	2017-07-01	QPR U21	QPR	0.00	0.00	f	44
206	2016-08-03	Millwall U18	QPR U21	0.00	0.00	f	44
207	2022-07-27	Ajax	Man Utd	32.00	57.37	f	45
208	2019-07-01	Defensa	Ajax	6.00	7.00	f	45
209	2018-07-01	Newell's II	Defensa	2.00	0.73	f	45
210	2018-06-30	Defensa	Newell's II	2.00	0.00	t	45
211	2017-08-11	Newell's II	Defensa	0.00	0.00	t	45
212	2015-07-01	Newell's U20	Newell's II	0.00	0.00	f	45
213	2022-07-01	Brighton U21	Brighton	0.60	0.00	f	46
214	2021-01-09	Bohemians	Brighton U23	0.00	0.00	f	46
215	2019-09-20	Bohs U19	Bohemians	0.00	0.00	f	46
216	2019-01-01	St. Kevins Boys	Bohs U19	0.00	0.00	f	46
217	2020-09-01	Peterborough	Brentford	0.40	5.60	f	47
218	2018-08-09	Newcastle	Peterborough	0.50	0.39	f	47
219	2018-05-31	Scunthorpe Utd.	Newcastle	0.50	0.00	t	47
220	2018-01-11	Newcastle	Scunthorpe Utd.	0.50	0.00	t	47
221	2018-01-10	Wigan	Newcastle	0.50	0.00	t	47
222	2017-08-02	Newcastle	Wigan	0.50	0.00	t	47
223	2017-05-31	Scunthorpe Utd.	Newcastle	0.50	0.00	t	47
224	2017-01-12	Newcastle	Scunthorpe Utd.	0.50	0.00	t	47
225	2017-01-05	Shrewsbury	Newcastle	0.50	0.00	t	47
226	2016-08-08	Newcastle	Shrewsbury	0.50	0.00	t	47
227	2016-05-31	Barnsley FC	Newcastle	0.50	0.00	t	47
228	2016-03-24	Newcastle	Barnsley FC	0.50	0.00	t	47
229	2015-12-23	Barnsley FC	Newcastle	0.50	0.00	t	47
230	2015-11-09	Newcastle	Barnsley FC	0.50	0.00	t	47
231	2015-08-06	Northampton	Newcastle	0.15	0.36	f	47
232	2013-07-01	Northampton U18	Northampton	0.00	0.00	f	47
233	2022-07-01	Chelsea U21	Chelsea	25.00	0.00	f	48
234	2022-05-31	Crystal Palace	Chelsea U23	25.00	0.00	t	48
235	2021-07-30	Chelsea U23	Crystal Palace	15.00	0.00	t	48
236	2021-05-31	West Brom	Chelsea U23	12.00	0.00	t	48
237	2020-09-17	Chelsea U23	West Brom	5.40	0.00	t	48
238	2020-07-31	Swansea	Chelsea U23	5.40	0.00	t	48
239	2020-01-15	Chelsea U23	Swansea	2.00	0.00	t	48
240	2020-01-14	Charlton	Chelsea U23	2.00	0.00	t	48
241	2019-08-02	Chelsea U23	Charlton	0.00	0.00	t	48
242	2018-07-01	Chelsea U18	Chelsea U23	0.00	0.00	f	48
243	2016-07-01	Chelsea Youth	Chelsea U18	0.00	0.00	f	48
244	2023-09-01	Wolves	Man City	45.00	62.00	f	49
245	2022-08-18	Sporting CP	Wolves	35.00	45.00	f	49
246	2020-05-01	Sporting CP U23	Sporting CP	0.00	0.00	f	49
247	2019-01-31	Estoril Praia	Sporting CP U23	0.00	0.95	f	49
248	2018-07-01	Ericeirense	Estoril Praia	0.00	0.00	f	49
249	2024-07-22	Everton	Aston Villa	50.00	59.35	f	50
250	2022-08-09	LOSC Lille	Everton	10.00	39.87	f	50
251	2021-08-05	Hamburger SV	LOSC Lille	3.00	13.57	f	50
252	2020-07-01	Hoffenheim U19	Hamburger SV	0.00	0.00	f	50
253	2018-07-01	Hoffenheim U17	Hoffenheim U19	0.00	0.00	f	50
254	2017-07-01	Zulte W. Youth	Hoffenheim U17	0.00	0.00	f	50
255	2020-01-31	Hull City	West Ham	10.00	21.30	f	51
256	2016-07-01	Hull U21	Hull City	0.00	0.00	f	51
257	2014-07-08	Hereford Utd.	Hull U21	0.00	0.00	f	51
258	2014-03-21	Hereford U19	Hereford Utd.	0.00	0.00	f	51
259	2024-07-18	Troyes	Man City	50.00	25.00	f	52
260	2024-06-30	Girona	Troyes	50.00	0.00	t	52
261	2023-07-13	Troyes	Girona	5.00	0.00	t	52
262	2023-06-30	PSV Eindhoven	Troyes	5.00	0.00	t	52
263	2022-07-22	Troyes	PSV Eindhoven	6.00	0.00	t	52
264	2022-07-06	Atletico-MG	Troyes	6.00	6.50	f	52
265	2020-08-03	Atletico-MG U20	Atletico-MG	0.00	0.00	f	52
266	2020-09-19	Wolves	Liverpool	28.00	44.70	f	53
267	2018-07-01	Atletico Madrid	Wolves	12.00	14.00	f	53
268	2018-06-30	Wolves	Atletico Madrid	12.00	0.00	t	53
269	2017-07-25	Atletico Madrid	Wolves	8.00	0.00	t	53
270	2017-06-30	FC Porto	Atletico Madrid	8.00	0.00	t	53
271	2016-08-26	Atletico Madrid	FC Porto	7.00	0.00	t	53
272	2016-07-06	Pacos Ferreira	Atletico Madrid	3.00	7.00	f	53
273	2015-01-10	Pacos F. U19	Pacos Ferreira	0.10	0.00	f	53
274	2013-07-01	Gondomar U19	Pacos F. U19	0.00	0.00	f	53
275	2012-07-01	Gondomar Sub-17	Gondomar U19	0.00	0.00	f	53
276	2011-07-01	Gondomar Sub-15	Gondomar Sub-17	0.00	0.00	f	53
277	2009-07-01	Gondomar SC CJ	Gondomar Sub-15	0.00	0.00	f	53
278	2024-07-18	LOSC Lille	Man Utd	50.00	62.00	f	54
279	2022-07-01	LOSC Lille B	LOSC Lille	0.15	0.00	f	54
280	2022-01-01	LOSC Lille U19	LOSC Lille B	0.00	0.00	f	54
281	2021-07-01	LOSC Lille Yth.	LOSC Lille U19	0.00	0.00	f	54
282	2023-08-27	Ajax	West Ham	40.00	43.00	f	55
283	2020-07-31	Nordsjaelland	Ajax	9.00	9.00	f	55
284	2018-08-02	Right to Dream	Nordsjaelland	0.00	0.00	f	55
285	2015-08-30	VfL Wolfsburg	Man City	45.00	76.00	f	56
286	2014-01-18	Chelsea	VfL Wolfsburg	15.00	22.00	f	56
287	2013-06-30	Werder Bremen	Chelsea	10.00	0.00	t	56
288	2012-08-02	Chelsea	Werder Bremen	9.00	0.45	t	56
289	2012-06-30	KRC Genk	Chelsea	9.00	0.00	t	56
290	2012-02-01	Chelsea	KRC Genk	9.00	0.00	t	56
291	2012-01-31	KRC Genk	Chelsea	9.00	8.00	f	56
292	2008-07-01	KRC Genk U19	KRC Genk	0.00	0.00	f	56
293	2007-07-01	KRC Genk U17	KRC Genk U19	0.00	0.00	f	56
294	2006-07-01	KRC Genk Youth	KRC Genk U17	0.00	0.00	f	56
295	2005-07-01	KAA Gent Youth	KRC Genk Youth	0.00	0.00	f	56
296	2023-09-01	Nottm Forest	Tottenham	38.00	55.00	f	57
297	2021-05-31	Lincoln City	Nottm Forest	0.00	0.00	t	57
298	2020-09-25	Nottm Forest	Lincoln City	0.00	0.00	t	57
299	2019-07-01	Nottingham U18	Nottm Forest	0.00	0.00	f	57
300	2023-07-12	Villarreal	Aston Villa	45.00	33.00	f	58
301	2019-06-30	Malaga CF	Villarreal	4.00	0.00	t	58
302	2018-08-06	Villarreal	Malaga CF	0.50	0.00	t	58
303	2018-07-01	Villarreal CF B	Villarreal	0.50	0.00	f	58
304	2016-07-01	Villarreal U19	Villarreal CF B	0.00	0.00	f	58
305	2015-07-01	Roda U19	Villarreal U19	0.00	0.00	f	58
306	2014-07-01	Villarreal Yth.	Roda U19	0.00	0.00	f	58
307	2023-07-01	Atletico Madrid	Wolves	25.00	50.00	f	60
308	2023-06-30	Wolves	Atletico Madrid	25.00	0.00	t	60
309	2023-01-01	Atletico Madrid	Wolves	20.00	0.00	t	60
310	2021-08-25	Hertha BSC	Atletico Madrid	30.00	35.00	f	60
311	2020-01-31	RB Leipzig	Hertha BSC	13.00	18.00	f	60
312	2018-07-01	FC Sion	RB Leipzig	1.50	15.00	f	60
313	2017-07-01	Coritiba U20	FC Sion	0.00	0.00	f	60
314	2023-07-01	Sporting CP	Tottenham	40.00	40.00	f	61
315	2023-06-30	Tottenham	Sporting CP	40.00	0.00	t	61
316	2023-01-31	Sporting CP	Tottenham	25.00	5.00	t	61
317	2022-07-01	Man City	Sporting CP	25.00	8.77	f	61
318	2022-06-30	Sporting CP	Man City	25.00	0.00	t	61
319	2020-08-15	Man City	Sporting CP	9.00	0.00	t	61
320	2020-07-20	Real Valladolid	Man City	9.00	0.00	t	61
321	2019-08-12	Man City	Real Valladolid	10.00	0.00	t	61
322	2019-08-08	Girona	Man City	10.00	12.00	f	61
323	2018-08-01	CF Peralada	Girona	1.00	0.00	f	61
324	2017-12-01	Girona U19	CF Peralada	0.00	0.00	f	61
325	2017-07-01	Rayo U19	Girona U19	0.00	0.10	f	61
326	2022-06-30	Union SG	Brighton	2.50	0.00	t	62
327	2021-08-11	Brighton	Union SG	1.80	0.00	t	62
328	2021-08-10	Kawasaki Front.	Brighton	1.80	3.00	f	62
329	2020-02-01	Tsukuba Univ.	Kawasaki Front.	0.05	0.00	f	62
330	2020-01-31	Kawasaki Front.	Tsukuba Univ.	0.05	0.00	t	62
331	2019-04-19	Tsukuba Univ.	Kawasaki Front.	0.05	0.00	t	62
332	2019-01-31	Kawasaki Front.	Tsukuba Univ.	0.05	0.00	t	62
333	2018-08-10	Tsukuba Univ.	Kawasaki Front.	0.00	0.00	t	62
334	2018-01-31	Kawasaki Front.	Tsukuba Univ.	0.00	0.00	t	62
335	2017-09-15	Tsukuba Univ.	Kawasaki Front.	0.00	0.00	t	62
336	2016-04-01	Frontale U18	Tsukuba Univ.	0.00	0.00	f	62
337	2022-07-01	Man Utd U21	Man Utd	2.00	0.00	f	63
338	2021-07-01	Man Utd U18	Man Utd U23	0.00	0.00	f	63
339	2020-10-02	Atleti Youth	Man Utd U18	0.00	0.47	f	63
340	2015-08-28	B. Leverkusen	Tottenham	16.00	30.00	f	64
341	2013-07-01	Hamburger SV	B. Leverkusen	14.00	12.50	f	64
342	2010-07-01	Hamburger SV II	Hamburger SV	0.00	0.00	f	64
343	2010-04-01	Hamburg U19	Hamburger SV II	0.00	0.00	f	64
344	2009-07-01	Hamburg U17	Hamburg U19	0.00	0.00	f	64
345	2008-08-01	\N	Hamburg U17	0.00	0.00	f	64
346	2008-05-01	FC Seoul U18	\N	0.00	0.00	f	64
347	2008-01-01	Dongbuk MS	FC Seoul U18	0.00	0.00	f	64
348	2007-07-01	Yukminkwan MS	Dongbuk MS	0.00	0.00	f	64
349	2007-01-01	Hupyeong MS	Yukminkwan MS	0.00	0.00	f	64
350	2005-01-01	C. Buan ES	Hupyeong MS	0.00	0.00	f	64
351	2022-09-01	Bor. Dortmund	Man City	30.00	20.00	f	65
352	2018-01-15	FC Basel	Bor. Dortmund	5.00	21.50	f	65
353	2015-07-01	FC Winterthur	FC Basel	0.25	0.70	f	65
354	2014-07-01	Winterthur U21	FC Winterthur	0.00	0.00	f	65
355	2013-07-01	Winterthur U18	Winterthur U21	0.00	0.00	f	65
356	2023-07-01	Watford	Brighton	32.00	34.20	f	67
357	2020-01-01	Fluminense	Watford	20.00	11.50	f	67
358	2019-01-01	Fluminense U17	Fluminense	0.00	0.00	f	67
359	2021-07-01	RB Leipzig	Liverpool	35.00	40.00	f	68
360	2017-07-01	FC Sochaux	RB Leipzig	0.30	0.00	f	68
361	2017-01-01	FC Sochaux B	FC Sochaux	0.00	0.00	f	68
362	2016-07-01	FC Sochaux U19	FC Sochaux B	0.00	0.00	f	68
363	2014-07-01	Paris FC Yth.	FC Sochaux U19	0.00	0.00	f	68
364	2022-07-01	LOSC Lille	Newcastle	30.00	37.00	f	69
365	2020-07-31	Ajax U21	LOSC Lille	1.30	8.00	f	69
366	2020-06-30	Heerenveen	Ajax U21	1.30	0.00	t	69
367	2019-07-27	Ajax U21	Heerenveen	0.30	0.00	t	69
368	2018-07-01	Ajax U19	Ajax U21	0.00	0.00	f	69
369	2017-07-01	Ajax U17	Ajax U19	0.00	0.00	f	69
370	2015-07-01	Ajax Youth	Ajax U17	0.00	0.00	f	69
371	2009-07-01	Pancratius Yth.	Ajax Youth	0.00	0.00	f	69
372	2021-08-04	B. Leverkusen	Aston Villa	35.00	32.00	f	70
373	2017-01-31	KRC Genk	B. Leverkusen	12.50	16.70	f	70
374	2015-08-12	AS Trencin U19	KRC Genk	0.00	1.40	f	70
375	2013-07-01	USK Anif Youth	AS Trencin U19	0.00	0.00	f	70
376	2011-07-01	Phoenix Acad.	USK Anif Youth	0.00	0.00	f	70
377	2023-06-30	PSV Eindhoven	Everton	10.00	0.00	t	71
378	2022-07-17	Everton	PSV Eindhoven	3.00	0.00	t	71
379	2021-05-31	Blackburn	Everton	3.00	0.00	t	71
380	2021-01-14	Everton	Blackburn	2.00	0.00	t	71
381	2020-01-13	Carlisle United	Everton	0.00	1.10	f	71
382	2019-02-26	Carlisle U18	Carlisle United	0.00	0.00	f	71
383	2023-08-04	Monaco	Chelsea	30.00	45.00	f	72
384	2020-08-07	Stade Reims	Monaco	13.50	13.00	f	72
385	2017-07-01	Stade Reims B	Stade Reims	0.10	0.00	f	72
386	2016-07-02	Paris FC B	Stade Reims B	0.10	0.00	f	72
387	2015-07-01	Paris FC U19	Paris FC B	0.00	0.00	f	72
388	2019-07-23	TSG Hoffenheim	Newcastle	35.00	43.50	f	73
389	2018-06-30	Rapid Vienna	TSG Hoffenheim	1.25	0.00	t	73
390	2016-07-01	TSG Hoffenheim	Rapid Vienna	1.25	0.60	t	73
391	2015-07-01	Sport Recife	TSG Hoffenheim	1.25	2.20	f	73
392	2015-01-01	Sport U20	Sport Recife	0.00	0.00	f	73
393	2014-01-01	Recife U17	Sport U20	0.00	0.00	f	73
394	2020-08-05	Bournemouth	Man City	28.00	45.30	f	75
395	2017-07-01	Chelsea	Bournemouth	8.00	22.80	f	75
396	2017-01-08	Bournemouth	Chelsea	5.00	0.00	t	75
397	2016-07-01	Chelsea	Bournemouth	4.50	0.00	t	75
398	2016-05-31	Watford	Chelsea	4.50	0.00	t	75
399	2015-08-14	Chelsea	Watford	2.00	0.00	t	75
400	2015-04-22	Reading	Chelsea	1.50	0.00	t	75
401	2015-03-25	Chelsea	Reading	1.50	0.00	t	75
402	2013-01-01	Chelsea U18	Chelsea	0.00	0.00	f	75
403	2011-07-01	Feyenoord U17	Chelsea U18	0.00	0.80	f	75
404	2010-07-01	Feyenoord Youth	Feyenoord U17	0.00	0.00	f	75
405	2007-07-01	ADO Youth	Feyenoord Youth	0.00	0.00	f	75
406	2024-07-01	Chelsea	Aston Villa	40.00	44.50	f	76
407	2024-06-30	Bor. Dortmund	Chelsea	40.00	0.00	t	76
408	2024-01-12	Chelsea	Bor. Dortmund	20.00	2.30	t	76
409	2023-07-01	Chelsea U21	Chelsea	12.00	0.00	f	76
410	2023-05-31	Burnley	Chelsea U21	9.00	0.00	t	76
411	2022-07-15	Chelsea U21	Burnley	5.00	0.00	t	76
412	2022-05-31	Coventry	Chelsea U23	5.00	0.00	t	76
413	2021-07-30	Chelsea U23	Coventry	0.00	0.00	t	76
414	2021-05-31	Charlton	Chelsea U23	0.00	0.00	t	76
415	2020-10-13	Chelsea U23	Charlton	0.00	0.00	t	76
416	2019-07-01	Chelsea U18	Chelsea U23	0.00	0.00	f	76
417	2018-07-01	PSV Youth	Chelsea U18	0.00	0.11	f	76
418	2015-07-01	Sparta Youth	PSV Youth	0.00	0.03	f	76
419	2013-07-01	Feyenoord Youth	Sparta Youth	0.00	0.00	f	76
420	2019-08-05	Troyes	Brentford	3.50	6.50	f	77
421	2018-07-01	ESTAC Troyes B	Troyes	0.30	0.00	f	77
422	2016-07-01	Troyes U19	ESTAC Troyes B	0.00	0.00	f	77
423	2019-07-01	Chelsea U23	Chelsea	7.00	0.00	f	78
424	2019-05-31	Wigan	Chelsea U23	1.00	0.00	t	78
425	2018-07-01	Chelsea U23	Wigan	0.00	0.00	t	78
426	2017-07-01	Chelsea U18	Chelsea U23	0.00	0.00	f	78
427	2016-07-01	Chelsea Youth	Chelsea U18	0.00	0.00	f	78
428	2019-01-04	Liverpool	Bournemouth	10.00	21.20	f	79
429	2017-07-10	Chelsea U23	Liverpool	2.00	0.00	f	79
430	2016-06-30	Vitesse	Chelsea U21	2.00	0.00	t	79
431	2015-08-04	Chelsea U21	Vitesse	0.25	0.00	t	79
432	2015-07-01	Chelsea U18	Chelsea U21	0.25	0.00	f	79
433	2014-07-01	Chelsea Youth	Chelsea U18	0.00	0.00	f	79
434	2023-07-03	AC Milan	Newcastle	50.00	64.00	f	80
435	2021-07-08	Brescia	AC Milan	27.00	15.75	f	80
436	2021-06-30	AC Milan	Brescia	27.00	0.00	t	80
437	2020-09-09	Brescia	AC Milan	32.00	5.00	t	80
438	2018-01-01	Brescia U19	Brescia	0.00	0.00	f	80
439	2017-07-01	Brescia U17	Brescia U19	0.00	0.00	f	80
440	2015-07-01	Brescia Youth	Brescia U17	0.00	0.00	f	80
441	2012-07-01	Piacenza Youth	Brescia Youth	0.00	0.00	f	80
442	2023-07-14	Ajax	Arsenal	42.00	40.00	f	81
443	2020-09-18	Ajax U21	Ajax	2.00	0.00	f	81
444	2019-01-01	Ajax U19	Ajax U21	0.00	0.00	f	81
445	2018-07-01	Ajax U17	Ajax U19	0.00	0.00	f	81
446	2016-07-01	Ajax Youth	Ajax U17	0.00	0.00	f	81
447	2014-07-01	Feyenoord Youth	Ajax Youth	0.00	0.00	f	81
448	2022-07-01	Man City U18	Man City	0.00	0.00	f	82
449	2021-07-01	Man City Youth	Man City U18	0.00	0.00	f	82
450	2021-07-18	Chelsea	Crystal Palace	10.00	23.34	f	83
451	2021-05-31	Swansea	Chelsea	6.00	0.00	t	83
452	2020-08-26	Chelsea	Swansea	2.70	0.00	t	83
453	2020-07-31	Swansea	Chelsea	2.70	0.00	t	83
454	2020-01-10	Chelsea	Swansea	1.50	0.00	t	83
455	2020-01-01	Chelsea U23	Chelsea	1.50	0.00	f	83
456	2018-07-01	Chelsea U18	Chelsea U23	0.00	0.00	f	83
457	2016-07-01	Chelsea Youth	Chelsea U18	0.00	0.00	f	83
458	2022-07-01	Everton	Tottenham	48.00	58.00	f	84
459	2018-07-24	Watford	Everton	25.00	39.20	f	84
460	2017-08-08	Fluminense	Watford	2.00	12.40	f	84
461	2016-01-01	America-MG	Fluminense	0.70	2.38	f	84
462	2015-05-01	America-MG U20	America-MG	0.00	0.00	f	84
463	2022-07-01	Marseille	Aston Villa	25.00	0.00	f	85
464	2017-07-01	Marseille B	Marseille	0.00	0.00	f	85
465	2016-07-01	Marseille U19	Marseille B	0.00	0.00	f	85
466	2015-07-01	Marseille Yth	Marseille U19	0.00	0.00	f	85
467	2016-08-09	Everton	Man City	28.00	55.60	f	86
468	2013-01-31	Barnsley FC	Everton	0.10	3.50	f	86
469	2012-07-01	Barnsley U18	Barnsley FC	0.05	0.00	f	86
470	2010-07-01	Barnsley Jgd.	Barnsley U18	0.00	0.00	f	86
471	2022-07-22	Man City	Arsenal	25.00	35.00	f	87
472	2017-06-30	PSV Eindhoven	Man City	4.50	0.00	t	87
473	2016-08-26	Man City	PSV Eindhoven	4.00	0.00	t	87
474	2016-07-04	Ufa	Man City	4.00	2.25	f	87
475	2015-02-13	\N	Ufa	0.00	0.00	f	87
476	2014-07-01	Shakhtar U19	\N	0.00	0.00	f	87
477	2012-07-01	Shakhtar U17	Shakhtar U19	0.00	0.00	f	87
478	2010-01-01	Monolit	Shakhtar U17	0.00	0.00	f	87
479	2021-08-31	Bologna	Arsenal	20.00	18.60	f	88
480	2019-07-09	Sint-Truiden	Bologna	9.00	7.00	f	88
481	2018-01-16	Avispa Fukuoka	Sint-Truiden	0.35	0.80	f	88
482	2016-02-01	Avispa U18	Avispa Fukuoka	0.00	0.00	f	88
483	2017-07-01	Benfica	Man City	22.00	40.00	f	90
484	2015-07-01	Rio Ave	Benfica	1.20	0.50	f	90
485	2012-07-01	GD Ribeirao	Rio Ave	0.00	0.00	f	90
486	2011-07-01	Benfica U19	GD Ribeirao	0.00	0.00	f	90
487	2010-07-01	Benfica U17	Benfica U19	0.00	0.00	f	90
488	2010-01-01	Sao Paulo U17	Benfica U17	0.00	0.00	f	90
489	2023-07-20	Inter	Man Utd	35.00	50.20	f	91
490	2022-07-01	Ajax	Inter	12.00	0.00	f	91
491	2016-07-01	Ajax U21	Ajax	0.80	0.00	f	91
492	2015-01-14	Barca U19	Ajax U21	0.00	0.15	f	91
493	2014-06-30	UDV Alegre	Barca U19	0.00	0.00	t	91
494	2013-07-01	Barca U18	Barca U19	0.00	0.00	f	91
495	2013-07-01	Barca U19	UDV Alegre	0.00	0.00	t	91
496	2013-06-30	Cornella U19	Barca U18	0.00	0.00	t	91
497	2012-07-01	Barca U16	Barca U18	0.00	0.00	f	91
498	2012-07-01	Barca U18	Cornella U19	0.00	0.00	t	91
499	2011-07-01	Barca Youth	Barca U16	0.00	0.00	f	91
500	2010-07-01	Eto'o Academy	Barca Youth	0.00	0.00	f	91
501	2022-07-01	Brighton	Tottenham	35.00	29.20	f	92
502	2018-07-17	LOSC Lille	Brighton	8.00	16.80	f	92
503	2016-03-01	AS Real Bamako	LOSC Lille	0.00	0.00	f	92
504	2015-07-01	JMG Bamako	AS Real Bamako	0.00	0.00	f	92
505	2022-01-31	Juventus	Tottenham	25.00	19.00	f	93
506	2017-07-01	Boca Juniors	Juventus	6.00	21.70	f	93
507	2015-01-03	CABJ U20	Boca Juniors	0.00	0.00	f	93
508	2019-07-11	Brentford	Aston Villa	3.50	13.30	f	94
509	2018-07-01	Charlton	Brentford	0.50	2.85	f	94
510	2016-07-01	Charlton U18	Charlton	0.00	0.00	f	94
511	2021-07-01	Liverpool U23	Liverpool	15.00	0.00	f	95
512	2021-05-31	Blackburn	Liverpool U23	15.00	0.00	t	95
513	2020-10-16	Liverpool U23	Blackburn	4.00	0.00	t	95
514	2019-07-28	Fulham U18	Liverpool U23	0.00	1.70	f	95
515	2018-07-01	Fulham Youth	Fulham U18	0.00	0.00	f	95
516	2023-07-05	Chelsea	Man Utd	60.00	64.20	f	96
517	2019-07-01	Chelsea U23	Chelsea	12.00	0.00	f	96
518	2019-05-31	Derby	Chelsea U23	10.00	0.00	t	96
519	2018-07-17	Chelsea U23	Derby	4.00	0.00	t	96
520	2018-06-30	Vitesse	Chelsea U23	4.00	0.00	t	96
521	2017-07-24	Chelsea U23	Vitesse	0.40	0.00	t	96
522	2016-07-01	Chelsea U18	Chelsea U23	0.00	0.00	f	96
523	2015-07-01	Chelsea Youth	Chelsea U18	0.00	0.00	f	96
524	2023-01-30	Flamengo	Wolves	15.00	18.70	f	97
525	2021-07-05	Flamengo U20	Flamengo	3.50	0.00	f	97
526	2023-08-10	Ajax	West Ham	35.00	38.00	f	98
527	2019-07-22	America	Ajax	7.50	15.00	f	98
528	2017-01-01	CF America U19	America	0.50	0.00	f	98
529	2015-07-01	America Premier	CF America U19	0.00	0.00	f	98
530	2015-01-01	CF America U17	America Coapa	0.00	0.00	f	98
531	2023-06-30	Olympique Lyon	Chelsea	25.00	0.00	t	99
532	2023-01-30	Chelsea	Olympique Lyon	15.00	0.00	t	99
533	2023-01-29	Olympique Lyon	Chelsea	15.00	30.00	f	99
534	2021-07-01	Olymp. Lyon B	Olympique Lyon	0.50	0.00	f	99
535	2020-07-01	Olymp. Lyon U19	Olymp. Lyon B	0.00	0.00	f	99
536	2019-07-01	Ol. Lyon Yth.	Olymp. Lyon U19	0.00	0.00	f	99
537	2023-08-08	Southampton	Newcastle	25.00	37.20	f	100
538	2021-08-02	Chelsea U23	Southampton	0.00	26.20	f	100
539	2020-07-01	Chelsea U18	Chelsea U23	0.00	0.00	f	100
540	2019-07-01	Chelsea Youth	Chelsea U18	0.00	0.00	f	100
\.


--
-- Name: award_award_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.award_award_id_seq', 148, false);


--
-- Name: contract_contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contract_contract_id_seq', 1, false);


--
-- Name: player_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.player_player_id_seq', 101, true);


--
-- Name: stats_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stats_stats_id_seq', 396, false);


--
-- Name: transfer_transfer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transfer_transfer_id_seq', 541, false);


--
-- Name: award award_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award
    ADD CONSTRAINT award_pkey PRIMARY KEY (award_id);


--
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (contract_id);


--
-- Name: player_award player_award_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_award
    ADD CONSTRAINT player_award_pkey PRIMARY KEY (player_id, award_id, year);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (player_id);


--
-- Name: player_value player_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_value
    ADD CONSTRAINT player_value_pkey PRIMARY KEY (value_id);


--
-- Name: stats stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stats
    ADD CONSTRAINT stats_pkey PRIMARY KEY (stats_id);


--
-- Name: transfer transfer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfer
    ADD CONSTRAINT transfer_pkey PRIMARY KEY (transfer_id);


--
-- Name: idx_award_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_award_name ON public.award USING btree (name);


--
-- Name: idx_player_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_player_name ON public.player USING btree (name);


--
-- Name: contract contract_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id);


--
-- Name: transfer fk_transfer_player; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfer
    ADD CONSTRAINT fk_transfer_player FOREIGN KEY (player_id) REFERENCES public.player(player_id);


--
-- Name: player_award player_award_award_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_award
    ADD CONSTRAINT player_award_award_id_fkey FOREIGN KEY (award_id) REFERENCES public.award(award_id) ON DELETE CASCADE;


--
-- Name: player_award player_award_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_award
    ADD CONSTRAINT player_award_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON DELETE CASCADE;


--
-- Name: player_value player_value_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_value
    ADD CONSTRAINT player_value_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id);


--
-- Name: stats stats_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stats
    ADD CONSTRAINT stats_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(player_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

