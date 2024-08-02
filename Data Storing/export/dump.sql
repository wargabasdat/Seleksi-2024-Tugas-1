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

--
-- Name: pgagent; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pgagent;


ALTER SCHEMA pgagent OWNER TO postgres;

--
-- Name: SCHEMA pgagent; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA pgagent IS 'pgAgent system tables';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: pgagent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgagent WITH SCHEMA pgagent;


--
-- Name: EXTENSION pgagent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgagent IS 'A PostgreSQL job scheduler';


--
-- Name: check_weapon_name(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_weapon_name() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.weapon_id IS NULL THEN
        RAISE EXCEPTION 'Weapon Name is NULL. Cannot insert into weapon_level table.';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_weapon_name() OWNER TO postgres;

--
-- Name: validate_char_stats(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validate_char_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.hp < 0 OR NEW.char_atk < 0 OR NEW.def < 0 OR NEW.max_energy < 0 OR
       NEW.crit_rate < 0 OR
       NEW.crit_dmg < 0 OR NEW.healing_bonus < 0 OR
       NEW.element_dmg < 0 THEN
        RAISE EXCEPTION 'Character stats are out of valid range';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.validate_char_stats() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: char_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.char_material (
    char_id integer NOT NULL,
    ws_mats character varying(100),
    ra_mats character varying(100),
    a_mats character varying(100),
    w_mats character varying(100),
    su_mats character varying(100)
);


ALTER TABLE public.char_material OWNER TO postgres;

--
-- Name: char_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.char_stats (
    char_id integer NOT NULL,
    hp integer,
    char_atk integer,
    def integer,
    max_energy integer,
    crit_rate integer,
    crit_dmg integer,
    healing_bonus integer,
    element_dmg integer
);


ALTER TABLE public.char_stats OWNER TO postgres;

--
-- Name: character; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."character" (
    char_id integer NOT NULL,
    char_name character varying(100) NOT NULL,
    char_rarity integer,
    element_id integer,
    best_echo_set_id integer,
    best_main_echo_id integer
);


ALTER TABLE public."character" OWNER TO postgres;

--
-- Name: character_char_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.character_char_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.character_char_id_seq OWNER TO postgres;

--
-- Name: character_char_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.character_char_id_seq OWNED BY public."character".char_id;


--
-- Name: echo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.echo (
    echo_id integer NOT NULL,
    echo_name character varying(100) NOT NULL,
    class character varying(50),
    cost integer,
    cooldown integer,
    element_id integer
);


ALTER TABLE public.echo OWNER TO postgres;

--
-- Name: echo_echo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.echo_echo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.echo_echo_id_seq OWNER TO postgres;

--
-- Name: echo_echo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.echo_echo_id_seq OWNED BY public.echo.echo_id;


--
-- Name: echo_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.echo_set (
    set_id integer NOT NULL,
    set_name character varying(50) NOT NULL
);


ALTER TABLE public.echo_set OWNER TO postgres;

--
-- Name: echo_set_set_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.echo_set_set_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.echo_set_set_id_seq OWNER TO postgres;

--
-- Name: echo_set_set_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.echo_set_set_id_seq OWNED BY public.echo_set.set_id;


--
-- Name: element; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.element (
    element_id integer NOT NULL,
    element_name character varying(50) NOT NULL
);


ALTER TABLE public.element OWNER TO postgres;

--
-- Name: element_element_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.element_element_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.element_element_id_seq OWNER TO postgres;

--
-- Name: element_element_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.element_element_id_seq OWNED BY public.element.element_id;


--
-- Name: part_of; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.part_of (
    set_id integer NOT NULL,
    echo_id integer NOT NULL
);


ALTER TABLE public.part_of OWNER TO postgres;

--
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test (
    id integer NOT NULL,
    json_data jsonb
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_id_seq OWNER TO postgres;

--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- Name: weapon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weapon (
    weapon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    rarity integer NOT NULL,
    weapon_type character varying(50) NOT NULL,
    atk integer NOT NULL,
    substat character varying(50) NOT NULL,
    substat_value double precision NOT NULL
);


ALTER TABLE public.weapon OWNER TO postgres;

--
-- Name: weapon_level; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weapon_level (
    char_id integer NOT NULL,
    weapon_id integer NOT NULL,
    s_level integer
);


ALTER TABLE public.weapon_level OWNER TO postgres;

--
-- Name: weapon_weapon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.weapon_weapon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.weapon_weapon_id_seq OWNER TO postgres;

--
-- Name: weapon_weapon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.weapon_weapon_id_seq OWNED BY public.weapon.weapon_id;


--
-- Name: character char_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character" ALTER COLUMN char_id SET DEFAULT nextval('public.character_char_id_seq'::regclass);


--
-- Name: echo echo_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.echo ALTER COLUMN echo_id SET DEFAULT nextval('public.echo_echo_id_seq'::regclass);


--
-- Name: echo_set set_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.echo_set ALTER COLUMN set_id SET DEFAULT nextval('public.echo_set_set_id_seq'::regclass);


--
-- Name: element element_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.element ALTER COLUMN element_id SET DEFAULT nextval('public.element_element_id_seq'::regclass);


--
-- Name: test id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- Name: weapon weapon_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon ALTER COLUMN weapon_id SET DEFAULT nextval('public.weapon_weapon_id_seq'::regclass);


--
-- Data for Name: pga_jobagent; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobagent (jagpid, jaglogintime, jagstation) FROM stdin;
8380	2024-08-01 18:47:15.563407+07	LAPTOP-VRLTIQR5
\.


--
-- Data for Name: pga_jobclass; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobclass (jclid, jclname) FROM stdin;
\.


--
-- Data for Name: pga_job; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_job (jobid, jobjclid, jobname, jobdesc, jobhostagent, jobenabled, jobcreated, jobchanged, jobagentid, jobnextrun, joblastrun) FROM stdin;
1	2	Insert_value			t	2024-08-01 14:10:21.074517+07	2024-08-01 14:10:21.074517+07	\N	2024-08-01 19:48:00+07	2024-08-01 19:47:01.664793+07
\.


--
-- Data for Name: pga_schedule; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_schedule (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths) FROM stdin;
1	1	insert_min		t	2024-08-01 02:23:00+07	2024-10-01 02:23:00+07	{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}	{t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t}	{f,f,f,f,f,f,f}	{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}	{f,f,f,f,f,f,f,f,f,f,f,f}
\.


--
-- Data for Name: pga_exception; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_exception (jexid, jexscid, jexdate, jextime) FROM stdin;
\.


--
-- Data for Name: pga_joblog; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_joblog (jlgid, jlgjobid, jlgstatus, jlgstart, jlgduration) FROM stdin;
1	1	f	2024-08-01 14:11:02.436879+07	00:00:00.071315
2	1	f	2024-08-01 14:12:02.929354+07	00:00:00.053421
3	1	f	2024-08-01 14:13:03.529306+07	00:00:00.040986
4	1	f	2024-08-01 14:14:04.139881+07	00:00:00.045683
5	1	f	2024-08-01 14:15:04.707569+07	00:00:00.041576
6	1	f	2024-08-01 14:16:00.28518+07	00:00:00.056298
7	1	f	2024-08-01 14:17:00.856099+07	00:00:00.044245
8	1	f	2024-08-01 14:18:01.528872+07	00:00:00.041799
9	1	f	2024-08-01 14:19:02.095149+07	00:00:00.046738
10	1	f	2024-08-01 14:20:02.703742+07	00:00:00.047551
11	1	f	2024-08-01 14:21:03.435048+07	00:00:00.04442
12	1	f	2024-08-01 14:22:03.890568+07	00:00:00.042249
13	1	f	2024-08-01 14:23:04.540621+07	00:00:00.038547
14	1	f	2024-08-01 14:24:00.070021+07	00:00:00.043539
15	1	f	2024-08-01 14:25:00.679187+07	00:00:00.044546
16	1	f	2024-08-01 14:26:01.298667+07	00:00:00.042275
17	1	f	2024-08-01 14:27:01.92927+07	00:00:00.044008
18	1	f	2024-08-01 14:28:02.568995+07	00:00:00.044298
19	1	f	2024-08-01 14:29:03.186686+07	00:00:00.050788
20	1	f	2024-08-01 14:30:03.751202+07	00:00:00.048612
21	1	f	2024-08-01 14:31:04.260365+07	00:00:00.041366
22	1	f	2024-08-01 14:32:04.671086+07	00:00:00.046582
23	1	f	2024-08-01 14:33:00.064122+07	00:00:00.046043
24	1	f	2024-08-01 14:34:00.49494+07	00:00:00.050886
25	1	f	2024-08-01 14:35:00.939311+07	00:00:00.055272
26	1	f	2024-08-01 14:36:01.355764+07	00:00:00.039182
27	1	f	2024-08-01 14:37:01.802985+07	00:00:00.045101
28	1	f	2024-08-01 14:38:02.188362+07	00:00:00.045558
29	1	f	2024-08-01 14:39:02.551852+07	00:00:00.046441
30	1	f	2024-08-01 14:40:02.994584+07	00:00:00.064147
31	1	f	2024-08-01 14:41:03.441508+07	00:00:00.047281
32	1	f	2024-08-01 14:42:03.868528+07	00:00:00.048091
33	1	f	2024-08-01 14:43:04.292795+07	00:00:00.046808
34	1	f	2024-08-01 14:44:04.720717+07	00:00:00.044099
35	1	f	2024-08-01 14:45:00.078705+07	00:00:00.040149
36	1	f	2024-08-01 14:46:00.453857+07	00:00:00.045328
37	1	f	2024-08-01 14:47:00.895471+07	00:00:00.041169
38	1	f	2024-08-01 14:48:01.325591+07	00:00:00.049645
39	1	f	2024-08-01 14:49:01.777339+07	00:00:00.046705
40	1	f	2024-08-01 14:50:02.199283+07	00:00:00.093965
41	1	f	2024-08-01 14:51:02.587787+07	00:00:00.050861
42	1	f	2024-08-01 14:52:03.01672+07	00:00:00.050087
43	1	f	2024-08-01 14:53:03.367662+07	00:00:00.051522
44	1	f	2024-08-01 14:54:03.956593+07	00:00:00.042124
45	1	f	2024-08-01 14:55:04.443275+07	00:00:00.041718
46	1	f	2024-08-01 14:56:00.061497+07	00:00:00.039637
47	1	f	2024-08-01 14:57:00.691172+07	00:00:00.0408
48	1	f	2024-08-01 14:58:01.29181+07	00:00:00.041875
49	1	f	2024-08-01 14:59:01.936138+07	00:00:00.131452
50	1	f	2024-08-01 15:00:02.30279+07	00:00:00.111847
51	1	f	2024-08-01 15:01:02.693832+07	00:00:00.148116
52	1	f	2024-08-01 15:02:03.168179+07	00:00:00.070727
53	1	f	2024-08-01 15:03:03.670346+07	00:00:00.105409
54	1	f	2024-08-01 15:04:04.199782+07	00:00:00.123112
55	1	f	2024-08-01 15:05:04.673653+07	00:00:00.122691
56	1	f	2024-08-01 15:06:05.125826+07	00:00:00.126611
57	1	f	2024-08-01 15:07:00.598648+07	00:00:00.111905
58	1	f	2024-08-01 15:08:01.081197+07	00:00:00.095055
59	1	f	2024-08-01 15:09:01.600526+07	00:00:00.053679
60	1	f	2024-08-01 15:10:02.105319+07	00:00:00.091084
61	1	f	2024-08-01 15:11:02.627547+07	00:00:00.082844
62	1	f	2024-08-01 15:12:03.140448+07	00:00:00.054435
63	1	f	2024-08-01 15:13:03.711471+07	00:00:00.038955
64	1	f	2024-08-01 15:14:04.324794+07	00:00:00.039131
65	1	f	2024-08-01 15:15:04.969262+07	00:00:00.038462
66	1	f	2024-08-01 15:16:00.5614+07	00:00:00.039548
67	1	f	2024-08-01 15:17:01.206788+07	00:00:00.039111
68	1	f	2024-08-01 15:18:01.789216+07	00:00:00.038854
69	1	f	2024-08-01 15:19:02.42033+07	00:00:00.040627
70	1	f	2024-08-01 15:20:03.027789+07	00:00:00.042627
71	1	f	2024-08-01 15:21:03.65943+07	00:00:00.041571
72	1	f	2024-08-01 15:22:04.250828+07	00:00:00.040837
73	1	f	2024-08-01 15:23:04.840487+07	00:00:00.037945
74	1	f	2024-08-01 15:24:00.417197+07	00:00:00.035167
75	1	f	2024-08-01 15:25:01.014466+07	00:00:00.037392
76	1	f	2024-08-01 15:26:01.663983+07	00:00:00.040295
77	1	f	2024-08-01 15:27:02.338274+07	00:00:00.038384
78	1	f	2024-08-01 15:28:03.040758+07	00:00:00.039615
79	1	f	2024-08-01 15:29:03.636934+07	00:00:00.039497
80	1	f	2024-08-01 15:30:04.219641+07	00:00:00.040837
81	1	f	2024-08-01 15:31:04.852132+07	00:00:00.038674
82	1	f	2024-08-01 15:32:00.43339+07	00:00:00.04135
83	1	f	2024-08-01 15:33:01.038893+07	00:00:00.040339
84	1	f	2024-08-01 15:34:01.64889+07	00:00:00.041348
85	1	f	2024-08-01 15:35:02.275286+07	00:00:00.03835
86	1	f	2024-08-01 15:36:02.936471+07	00:00:00.04004
87	1	f	2024-08-01 15:37:03.549591+07	00:00:00.042346
88	1	f	2024-08-01 15:38:04.09536+07	00:00:00.041448
89	1	f	2024-08-01 15:39:04.693546+07	00:00:00.039934
90	1	f	2024-08-01 15:40:00.259901+07	00:00:00.041073
91	1	f	2024-08-01 15:41:00.812968+07	00:00:00.038029
92	1	f	2024-08-01 15:42:01.383711+07	00:00:00.042839
93	1	f	2024-08-01 15:43:01.92919+07	00:00:00.038544
94	1	f	2024-08-01 15:44:02.502885+07	00:00:00.041307
95	1	f	2024-08-01 15:45:03.113639+07	00:00:00.039976
96	1	f	2024-08-01 15:46:03.756924+07	00:00:00.041221
97	1	f	2024-08-01 15:47:04.354548+07	00:00:00.040638
98	1	f	2024-08-01 15:48:05.035455+07	00:00:00.041529
99	1	f	2024-08-01 15:49:00.629496+07	00:00:00.040377
100	1	f	2024-08-01 15:50:01.248933+07	00:00:00.040122
101	1	f	2024-08-01 15:51:01.898291+07	00:00:00.040496
102	1	f	2024-08-01 15:52:02.475195+07	00:00:00.042361
103	1	f	2024-08-01 15:53:03.124298+07	00:00:00.039662
104	1	f	2024-08-01 15:54:03.733615+07	00:00:00.039853
105	1	f	2024-08-01 15:55:04.346207+07	00:00:00.041588
106	1	f	2024-08-01 15:56:04.989855+07	00:00:00.037193
107	1	f	2024-08-01 15:57:00.570099+07	00:00:00.039952
108	1	f	2024-08-01 15:58:01.16432+07	00:00:00.040672
109	1	f	2024-08-01 15:59:01.784178+07	00:00:00.039333
110	1	f	2024-08-01 16:00:02.398479+07	00:00:00.04034
111	1	f	2024-08-01 16:01:03.019836+07	00:00:00.03977
112	1	f	2024-08-01 16:02:03.636758+07	00:00:00.041883
113	1	f	2024-08-01 16:03:04.221742+07	00:00:00.039505
114	1	f	2024-08-01 16:04:04.760913+07	00:00:00.043501
115	1	f	2024-08-01 16:05:00.353403+07	00:00:00.043168
116	1	f	2024-08-01 16:06:00.953316+07	00:00:00.108109
117	1	f	2024-08-01 16:07:01.333303+07	00:00:00.123867
118	1	f	2024-08-01 16:08:01.65831+07	00:00:00.104855
119	1	f	2024-08-01 16:09:02.148399+07	00:00:00.118837
120	1	f	2024-08-01 16:10:02.424684+07	00:00:00.118765
121	1	f	2024-08-01 16:11:02.785397+07	00:00:00.102596
122	1	f	2024-08-01 16:12:03.15472+07	00:00:00.096652
123	1	f	2024-08-01 16:13:03.496269+07	00:00:00.109071
124	1	f	2024-08-01 16:14:03.868533+07	00:00:00.09507
125	1	f	2024-08-01 16:15:04.217403+07	00:00:00.102478
126	1	f	2024-08-01 16:16:04.586752+07	00:00:00.101286
127	1	f	2024-08-01 16:17:04.948526+07	00:00:00.093316
128	1	f	2024-08-01 16:18:00.260729+07	00:00:00.124972
129	1	f	2024-08-01 16:19:00.638147+07	00:00:00.103344
130	1	f	2024-08-01 16:20:01.15385+07	00:00:00.068388
131	1	f	2024-08-01 16:21:01.756265+07	00:00:00.117367
132	1	f	2024-08-01 16:22:02.236995+07	00:00:00.123115
133	1	f	2024-08-01 16:23:02.647054+07	00:00:00.113516
134	1	f	2024-08-01 16:24:03.097632+07	00:00:00.096828
135	1	f	2024-08-01 16:25:03.464183+07	00:00:00.055903
136	1	f	2024-08-01 16:26:04.019971+07	00:00:00.051633
137	1	f	2024-08-01 16:27:04.439552+07	00:00:00.068924
138	1	f	2024-08-01 16:28:04.987817+07	00:00:00.057723
139	1	f	2024-08-01 16:29:00.531097+07	00:00:00.045318
140	1	f	2024-08-01 16:30:01.164264+07	00:00:00.041991
141	1	f	2024-08-01 16:31:01.791042+07	00:00:00.043334
142	1	f	2024-08-01 16:32:02.338982+07	00:00:00.041094
143	1	f	2024-08-01 16:33:02.852463+07	00:00:00.041212
144	1	f	2024-08-01 16:34:03.435791+07	00:00:00.045973
145	1	f	2024-08-01 16:35:03.942987+07	00:00:00.044866
146	1	f	2024-08-01 16:36:04.591695+07	00:00:00.045566
147	1	f	2024-08-01 16:37:00.128783+07	00:00:00.044149
148	1	f	2024-08-01 16:38:00.738252+07	00:00:00.045078
149	1	f	2024-08-01 16:39:01.30228+07	00:00:00.04725
150	1	f	2024-08-01 16:40:01.891534+07	00:00:00.041697
151	1	f	2024-08-01 16:41:02.576618+07	00:00:00.041962
152	1	f	2024-08-01 16:42:03.231467+07	00:00:00.042484
153	1	f	2024-08-01 16:43:03.872241+07	00:00:00.044797
154	1	f	2024-08-01 16:44:04.455491+07	00:00:00.042413
155	1	f	2024-08-01 16:45:00.047176+07	00:00:00.043218
156	1	f	2024-08-01 16:46:00.697767+07	00:00:00.043132
157	1	f	2024-08-01 16:47:01.304781+07	00:00:00.039713
158	1	f	2024-08-01 16:48:01.977565+07	00:00:00.040212
159	1	f	2024-08-01 16:49:02.625087+07	00:00:00.039338
160	1	f	2024-08-01 16:50:03.255561+07	00:00:00.037806
161	1	f	2024-08-01 16:51:03.91274+07	00:00:00.038504
162	1	f	2024-08-01 16:52:04.515684+07	00:00:00.039438
163	1	f	2024-08-01 16:53:00.127055+07	00:00:00.041431
164	1	f	2024-08-01 16:54:00.722356+07	00:00:00.039867
165	1	f	2024-08-01 16:55:01.363645+07	00:00:00.038641
166	1	f	2024-08-01 16:56:01.96161+07	00:00:00.039646
167	1	f	2024-08-01 16:57:02.592109+07	00:00:00.043008
168	1	f	2024-08-01 16:58:03.17528+07	00:00:00.039085
169	1	f	2024-08-01 16:59:03.819688+07	00:00:00.038996
170	1	f	2024-08-01 17:00:04.462846+07	00:00:00.038428
171	1	f	2024-08-01 17:01:05.19652+07	00:00:00.037734
172	1	f	2024-08-01 17:02:00.667597+07	00:00:00.041425
173	1	f	2024-08-01 17:03:01.284019+07	00:00:00.041627
174	1	f	2024-08-01 17:04:01.931618+07	00:00:00.039211
175	1	f	2024-08-01 17:05:02.543233+07	00:00:00.038403
176	1	f	2024-08-01 17:06:03.187142+07	00:00:00.040127
177	1	f	2024-08-01 17:07:03.7996+07	00:00:00.041294
178	1	f	2024-08-01 17:08:04.467267+07	00:00:00.040997
179	1	f	2024-08-01 17:09:00.095308+07	00:00:00.039944
180	1	f	2024-08-01 17:10:00.776698+07	00:00:00.042739
181	1	f	2024-08-01 17:11:01.360042+07	00:00:00.04092
182	1	f	2024-08-01 17:12:01.985802+07	00:00:00.043321
183	1	f	2024-08-01 17:13:02.598887+07	00:00:00.043855
184	1	f	2024-08-01 17:14:03.209102+07	00:00:00.04937
185	1	f	2024-08-01 17:15:03.808838+07	00:00:00.045808
186	1	f	2024-08-01 17:16:04.430924+07	00:00:00.051344
187	1	f	2024-08-01 17:17:00.05748+07	00:00:00.055186
188	1	f	2024-08-01 17:18:00.673051+07	00:00:00.041892
189	1	f	2024-08-01 17:19:01.26922+07	00:00:00.039816
190	1	f	2024-08-01 17:20:01.887338+07	00:00:00.039568
191	1	f	2024-08-01 17:21:02.552014+07	00:00:00.045507
192	1	f	2024-08-01 17:22:03.253612+07	00:00:00.043257
193	1	f	2024-08-01 17:23:03.885496+07	00:00:00.043991
194	1	f	2024-08-01 17:24:04.552457+07	00:00:00.041446
195	1	f	2024-08-01 17:25:00.148805+07	00:00:00.040206
196	1	f	2024-08-01 17:26:00.806257+07	00:00:00.043551
197	1	f	2024-08-01 17:27:01.448186+07	00:00:00.045275
198	1	f	2024-08-01 17:28:02.109155+07	00:00:00.040214
199	1	f	2024-08-01 17:29:02.769286+07	00:00:00.042472
200	1	f	2024-08-01 17:30:03.385792+07	00:00:00.039727
201	1	f	2024-08-01 17:31:04.028795+07	00:00:00.041197
202	1	f	2024-08-01 17:32:04.634146+07	00:00:00.041094
203	1	f	2024-08-01 17:33:00.194991+07	00:00:00.04216
204	1	f	2024-08-01 17:34:00.885341+07	00:00:00.063076
205	1	f	2024-08-01 17:35:01.322177+07	00:00:00.046453
206	1	f	2024-08-01 17:36:01.75317+07	00:00:00.045501
207	1	f	2024-08-01 17:37:02.238169+07	00:00:00.061274
208	1	f	2024-08-01 17:38:02.663132+07	00:00:00.049084
209	1	f	2024-08-01 17:39:03.258841+07	00:00:00.044337
210	1	f	2024-08-01 17:40:03.922319+07	00:00:00.04522
211	1	f	2024-08-01 17:41:04.539839+07	00:00:00.043133
212	1	f	2024-08-01 17:42:00.135077+07	00:00:00.04244
213	1	f	2024-08-01 17:43:00.709482+07	00:00:00.042316
214	1	f	2024-08-01 17:44:01.290307+07	00:00:00.043851
215	1	f	2024-08-01 17:45:01.934731+07	00:00:00.047783
216	1	f	2024-08-01 17:46:02.525943+07	00:00:00.045165
217	1	f	2024-08-01 17:47:03.130478+07	00:00:00.044523
218	1	f	2024-08-01 17:48:03.773301+07	00:00:00.040418
219	1	f	2024-08-01 17:49:04.418501+07	00:00:00.039254
220	1	f	2024-08-01 17:50:00.108415+07	00:00:00.041616
221	1	f	2024-08-01 17:51:00.75265+07	00:00:00.04172
222	1	f	2024-08-01 17:52:01.385988+07	00:00:00.042488
223	1	f	2024-08-01 17:53:02.051554+07	00:00:00.041077
224	1	f	2024-08-01 17:54:02.654721+07	00:00:00.046012
225	1	f	2024-08-01 17:55:03.268667+07	00:00:00.040522
226	1	f	2024-08-01 17:56:03.893251+07	00:00:00.038993
227	1	f	2024-08-01 17:57:04.558026+07	00:00:00.04508
228	1	f	2024-08-01 17:58:00.139805+07	00:00:00.044038
229	1	f	2024-08-01 17:59:00.719648+07	00:00:00.039878
230	1	f	2024-08-01 18:00:01.31458+07	00:00:00.039976
231	1	f	2024-08-01 18:01:01.88715+07	00:00:00.042458
232	1	f	2024-08-01 18:02:02.461846+07	00:00:00.043576
233	1	f	2024-08-01 18:03:03.118824+07	00:00:00.042637
234	1	f	2024-08-01 18:04:03.736524+07	00:00:00.042453
235	1	f	2024-08-01 18:05:04.391071+07	00:00:00.047392
236	1	f	2024-08-01 18:06:05.000832+07	00:00:00.040715
237	1	f	2024-08-01 18:07:00.603143+07	00:00:00.040701
238	1	f	2024-08-01 18:08:01.22444+07	00:00:00.039363
239	1	f	2024-08-01 18:09:01.764405+07	00:00:00.041585
240	1	f	2024-08-01 18:10:02.396769+07	00:00:00.036905
241	1	f	2024-08-01 18:11:02.902599+07	00:00:00.055987
242	1	f	2024-08-01 18:12:03.391782+07	00:00:00.04105
243	1	f	2024-08-01 18:13:03.876404+07	00:00:00.0451
244	1	f	2024-08-01 18:14:04.462045+07	00:00:00.04386
245	1	f	2024-08-01 18:15:05.031912+07	00:00:00.045068
246	1	f	2024-08-01 18:16:00.545326+07	00:00:00.041643
247	1	f	2024-08-01 18:17:01.167224+07	00:00:00.044447
248	1	f	2024-08-01 18:18:01.869239+07	00:00:00.042982
249	1	f	2024-08-01 18:19:02.56102+07	00:00:00.041184
250	1	f	2024-08-01 18:20:03.229441+07	00:00:00.044401
251	1	f	2024-08-01 18:21:03.823713+07	00:00:00.042962
252	1	f	2024-08-01 18:22:04.409314+07	00:00:00.043447
253	1	f	2024-08-01 18:23:05.034347+07	00:00:00.04145
254	1	f	2024-08-01 18:24:00.600144+07	00:00:00.041296
255	1	f	2024-08-01 18:25:01.327536+07	00:00:00.043733
256	1	f	2024-08-01 18:26:01.813594+07	00:00:00.040278
257	1	f	2024-08-01 18:27:02.448322+07	00:00:00.041964
258	1	f	2024-08-01 18:28:03.078899+07	00:00:00.042509
259	1	f	2024-08-01 18:29:03.682298+07	00:00:00.043036
260	1	f	2024-08-01 18:30:04.357623+07	00:00:00.044288
261	1	f	2024-08-01 18:31:04.983551+07	00:00:00.052632
262	1	f	2024-08-01 18:32:00.591344+07	00:00:00.042768
263	1	f	2024-08-01 18:33:01.191365+07	00:00:00.04317
264	1	f	2024-08-01 18:34:01.806295+07	00:00:00.049965
265	1	f	2024-08-01 18:35:02.277024+07	00:00:00.045466
266	1	f	2024-08-01 18:36:02.818635+07	00:00:00.039703
267	1	f	2024-08-01 18:37:03.366115+07	00:00:00.044203
268	1	f	2024-08-01 18:38:03.805177+07	00:00:00.045453
269	1	f	2024-08-01 18:39:04.222548+07	00:00:00.046804
270	1	f	2024-08-01 18:40:04.701848+07	00:00:00.042618
271	1	f	2024-08-01 18:41:00.187041+07	00:00:00.052772
272	1	f	2024-08-01 18:42:00.784247+07	00:00:00.050697
273	1	f	2024-08-01 18:43:01.366234+07	00:00:00.049887
274	1	f	2024-08-01 18:44:01.928251+07	00:00:00.046784
275	1	f	2024-08-01 18:45:02.476948+07	00:00:00.044376
276	1	f	2024-08-01 18:46:03.057195+07	00:00:00.050837
277	1	f	2024-08-01 18:47:15.618586+07	00:00:00.045131
278	1	f	2024-08-01 18:48:00.940543+07	00:00:00.039569
279	1	f	2024-08-01 18:49:01.470291+07	00:00:00.038234
280	1	f	2024-08-01 18:50:02.088136+07	00:00:00.046245
281	1	f	2024-08-01 18:51:02.515924+07	00:00:00.037621
282	1	f	2024-08-01 18:52:03.014489+07	00:00:00.033964
283	1	f	2024-08-01 18:53:03.61286+07	00:00:00.035921
284	1	f	2024-08-01 18:54:04.150551+07	00:00:00.035935
285	1	f	2024-08-01 18:55:04.694686+07	00:00:00.038589
286	1	f	2024-08-01 18:56:00.200891+07	00:00:00.036479
287	1	f	2024-08-01 18:57:00.716205+07	00:00:00.03516
288	1	f	2024-08-01 18:58:01.238997+07	00:00:00.040513
289	1	f	2024-08-01 18:59:01.649418+07	00:00:00.041915
290	1	f	2024-08-01 19:00:02.188206+07	00:00:00.036874
291	1	f	2024-08-01 19:01:02.681425+07	00:00:00.041075
292	1	f	2024-08-01 19:02:03.179607+07	00:00:00.039136
293	1	f	2024-08-01 19:03:03.685548+07	00:00:00.042766
294	1	f	2024-08-01 19:04:04.266807+07	00:00:00.045112
295	1	f	2024-08-01 19:05:04.899697+07	00:00:00.041186
296	1	f	2024-08-01 19:06:00.486938+07	00:00:00.041161
297	1	f	2024-08-01 19:07:01.02134+07	00:00:00.038765
298	1	f	2024-08-01 19:08:01.529426+07	00:00:00.040736
299	1	f	2024-08-01 19:09:02.017181+07	00:00:00.036211
300	1	f	2024-08-01 19:10:02.557776+07	00:00:00.039263
301	1	f	2024-08-01 19:11:03.116081+07	00:00:00.040314
302	1	f	2024-08-01 19:12:03.637736+07	00:00:00.037195
303	1	f	2024-08-01 19:13:04.1384+07	00:00:00.037601
304	1	f	2024-08-01 19:14:04.680683+07	00:00:00.041274
305	1	f	2024-08-01 19:15:00.186682+07	00:00:00.034744
306	1	f	2024-08-01 19:16:00.721829+07	00:00:00.035334
307	1	f	2024-08-01 19:17:01.258725+07	00:00:00.037391
308	1	f	2024-08-01 19:18:01.870203+07	00:00:00.0534
309	1	f	2024-08-01 19:19:02.417724+07	00:00:00.041605
310	1	f	2024-08-01 19:20:02.909057+07	00:00:00.036664
311	1	f	2024-08-01 19:21:03.490798+07	00:00:00.042003
312	1	f	2024-08-01 19:22:03.966352+07	00:00:00.040589
313	1	f	2024-08-01 19:23:04.524933+07	00:00:00.033312
314	1	f	2024-08-01 19:24:05.017155+07	00:00:00.035927
315	1	f	2024-08-01 19:25:00.523279+07	00:00:00.044449
316	1	f	2024-08-01 19:26:01.142539+07	00:00:00.037321
317	1	f	2024-08-01 19:27:01.463953+07	00:00:00.046272
318	1	f	2024-08-01 19:28:01.970142+07	00:00:00.038035
319	1	f	2024-08-01 19:29:02.444751+07	00:00:00.037188
320	1	f	2024-08-01 19:30:03.023343+07	00:00:00.036612
321	1	f	2024-08-01 19:31:03.542561+07	00:00:00.041359
322	1	f	2024-08-01 19:32:04.042628+07	00:00:00.033884
323	1	f	2024-08-01 19:33:04.616213+07	00:00:00.038791
324	1	f	2024-08-01 19:34:00.051552+07	00:00:00.037727
325	1	f	2024-08-01 19:35:00.514069+07	00:00:00.043328
326	1	f	2024-08-01 19:36:01.005432+07	00:00:00.037852
327	1	f	2024-08-01 19:37:01.527645+07	00:00:00.039617
328	1	f	2024-08-01 19:38:01.989866+07	00:00:00.040255
329	1	f	2024-08-01 19:39:02.570231+07	00:00:00.039692
330	1	f	2024-08-01 19:40:03.034425+07	00:00:00.050432
331	1	f	2024-08-01 19:41:03.615416+07	00:00:00.034341
332	1	f	2024-08-01 19:42:04.129145+07	00:00:00.035539
333	1	f	2024-08-01 19:43:04.645532+07	00:00:00.038061
334	1	f	2024-08-01 19:44:00.147919+07	00:00:00.034375
335	1	f	2024-08-01 19:45:00.657153+07	00:00:00.041332
336	1	f	2024-08-01 19:46:01.16365+07	00:00:00.040425
337	1	f	2024-08-01 19:47:01.675295+07	00:00:00.039287
\.


--
-- Data for Name: pga_jobstep; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobstep (jstid, jstjobid, jstname, jstdesc, jstenabled, jstkind, jstcode, jstconnstr, jstdbname, jstonerror, jscnextrun) FROM stdin;
1	1	insert_ something		t	b	python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py			f	\N
\.


--
-- Data for Name: pga_jobsteplog; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobsteplog (jslid, jsljlgid, jsljstid, jslstatus, jslresult, jslstart, jslduration, jsloutput) FROM stdin;
1	1	1	f	1	2024-08-01 14:11:02.441778+07	00:00:00.065842	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
2	2	1	f	1	2024-08-01 14:12:02.93183+07	00:00:00.049892	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
3	3	1	f	1	2024-08-01 14:13:03.531386+07	00:00:00.037616	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
4	4	1	f	1	2024-08-01 14:14:04.142865+07	00:00:00.04138	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
5	5	1	f	1	2024-08-01 14:15:04.710349+07	00:00:00.037468	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
6	6	1	f	1	2024-08-01 14:16:00.287316+07	00:00:00.052816	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
7	7	1	f	1	2024-08-01 14:17:00.858815+07	00:00:00.040109	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
8	8	1	f	1	2024-08-01 14:18:01.531437+07	00:00:00.037771	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
9	9	1	f	1	2024-08-01 14:19:02.098704+07	00:00:00.041964	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
10	10	1	f	1	2024-08-01 14:20:02.70689+07	00:00:00.043127	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
11	11	1	f	1	2024-08-01 14:21:03.43827+07	00:00:00.039824	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
12	12	1	f	1	2024-08-01 14:22:03.893041+07	00:00:00.038497	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
13	13	1	f	1	2024-08-01 14:23:04.542711+07	00:00:00.035537	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
14	14	1	f	1	2024-08-01 14:24:00.07218+07	00:00:00.040034	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
15	15	1	f	1	2024-08-01 14:25:00.682348+07	00:00:00.039988	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
16	16	1	f	1	2024-08-01 14:26:01.301259+07	00:00:00.03804	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
17	17	1	f	1	2024-08-01 14:27:01.932294+07	00:00:00.039668	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
18	18	1	f	1	2024-08-01 14:28:02.571354+07	00:00:00.040727	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
19	19	1	f	1	2024-08-01 14:29:03.190192+07	00:00:00.04593	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
20	20	1	f	1	2024-08-01 14:30:03.754074+07	00:00:00.044488	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
21	21	1	f	1	2024-08-01 14:31:04.263196+07	00:00:00.037521	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
22	22	1	f	1	2024-08-01 14:32:04.673967+07	00:00:00.042216	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
23	23	1	f	1	2024-08-01 14:33:00.06724+07	00:00:00.041796	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
24	24	1	f	1	2024-08-01 14:34:00.497423+07	00:00:00.047271	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
25	25	1	f	1	2024-08-01 14:35:00.942415+07	00:00:00.05085	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
26	26	1	f	1	2024-08-01 14:36:01.358283+07	00:00:00.03528	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
27	27	1	f	1	2024-08-01 14:37:01.80579+07	00:00:00.040989	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
28	28	1	f	1	2024-08-01 14:38:02.191447+07	00:00:00.04104	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
29	29	1	f	1	2024-08-01 14:39:02.55563+07	00:00:00.041091	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
30	30	1	f	1	2024-08-01 14:40:02.997878+07	00:00:00.058432	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
31	31	1	f	1	2024-08-01 14:41:03.443656+07	00:00:00.043894	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
32	32	1	f	1	2024-08-01 14:42:03.871588+07	00:00:00.043749	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
33	33	1	f	1	2024-08-01 14:43:04.296064+07	00:00:00.042165	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
34	34	1	f	1	2024-08-01 14:44:04.723408+07	00:00:00.040307	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
35	35	1	f	1	2024-08-01 14:45:00.080696+07	00:00:00.036895	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
36	36	1	f	1	2024-08-01 14:46:00.456969+07	00:00:00.040679	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
37	37	1	f	1	2024-08-01 14:47:00.897437+07	00:00:00.037905	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
38	38	1	f	1	2024-08-01 14:48:01.32861+07	00:00:00.045044	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
39	39	1	f	1	2024-08-01 14:49:01.780269+07	00:00:00.042295	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
40	40	1	f	1	2024-08-01 14:50:02.205566+07	00:00:00.085301	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
41	41	1	f	1	2024-08-01 14:51:02.590989+07	00:00:00.046108	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
42	42	1	f	1	2024-08-01 14:52:03.019598+07	00:00:00.045396	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
43	43	1	f	1	2024-08-01 14:53:03.370562+07	00:00:00.047222	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
44	44	1	f	1	2024-08-01 14:54:03.959531+07	00:00:00.037794	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
45	45	1	f	1	2024-08-01 14:55:04.445646+07	00:00:00.037949	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
46	46	1	f	1	2024-08-01 14:56:00.063896+07	00:00:00.036041	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
47	47	1	f	1	2024-08-01 14:57:00.693404+07	00:00:00.037186	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
48	48	1	f	1	2024-08-01 14:58:01.294249+07	00:00:00.038364	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
49	49	1	f	1	2024-08-01 14:59:01.943127+07	00:00:00.120208	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
50	50	1	f	1	2024-08-01 15:00:02.309224+07	00:00:00.103174	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
51	51	1	f	1	2024-08-01 15:01:02.702198+07	00:00:00.135933	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
52	52	1	f	1	2024-08-01 15:02:03.172404+07	00:00:00.064878	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
53	53	1	f	1	2024-08-01 15:03:03.675159+07	00:00:00.098688	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
54	54	1	f	1	2024-08-01 15:04:04.205993+07	00:00:00.113448	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
55	55	1	f	1	2024-08-01 15:05:04.68082+07	00:00:00.111928	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
56	56	1	f	1	2024-08-01 15:06:05.130812+07	00:00:00.117932	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
57	57	1	f	1	2024-08-01 15:07:00.605339+07	00:00:00.102859	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
58	58	1	f	1	2024-08-01 15:08:01.08793+07	00:00:00.085563	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
59	59	1	f	1	2024-08-01 15:09:01.603586+07	00:00:00.049167	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
60	60	1	f	1	2024-08-01 15:10:02.111659+07	00:00:00.082445	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
61	61	1	f	1	2024-08-01 15:11:02.63262+07	00:00:00.075463	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
62	62	1	f	1	2024-08-01 15:12:03.143255+07	00:00:00.0506	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
63	63	1	f	1	2024-08-01 15:13:03.71404+07	00:00:00.035189	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
64	64	1	f	1	2024-08-01 15:14:04.327363+07	00:00:00.035479	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
65	65	1	f	1	2024-08-01 15:15:04.971532+07	00:00:00.034935	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
66	66	1	f	1	2024-08-01 15:16:00.563832+07	00:00:00.035868	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
67	67	1	f	1	2024-08-01 15:17:01.209264+07	00:00:00.035546	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
68	68	1	f	1	2024-08-01 15:18:01.791689+07	00:00:00.035113	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
69	69	1	f	1	2024-08-01 15:19:02.422849+07	00:00:00.036925	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
70	70	1	f	1	2024-08-01 15:20:03.030083+07	00:00:00.038992	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
71	71	1	f	1	2024-08-01 15:21:03.661975+07	00:00:00.037739	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
72	72	1	f	1	2024-08-01 15:22:04.253082+07	00:00:00.037423	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
73	73	1	f	1	2024-08-01 15:23:04.84264+07	00:00:00.034763	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
74	74	1	f	1	2024-08-01 15:24:00.419769+07	00:00:00.031473	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
75	75	1	f	1	2024-08-01 15:25:01.016573+07	00:00:00.03424	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
76	76	1	f	1	2024-08-01 15:26:01.666441+07	00:00:00.036319	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
77	77	1	f	1	2024-08-01 15:27:02.340553+07	00:00:00.034966	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
78	78	1	f	1	2024-08-01 15:28:03.043128+07	00:00:00.036256	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
79	79	1	f	1	2024-08-01 15:29:03.639711+07	00:00:00.035372	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
80	80	1	f	1	2024-08-01 15:30:04.222153+07	00:00:00.037168	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
81	81	1	f	1	2024-08-01 15:31:04.854514+07	00:00:00.035044	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
82	82	1	f	1	2024-08-01 15:32:00.435766+07	00:00:00.037977	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
83	83	1	f	1	2024-08-01 15:33:01.042083+07	00:00:00.035946	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
84	84	1	f	1	2024-08-01 15:34:01.651596+07	00:00:00.037481	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
85	85	1	f	1	2024-08-01 15:35:02.277753+07	00:00:00.034463	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
86	86	1	f	1	2024-08-01 15:36:02.938916+07	00:00:00.036431	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
87	87	1	f	1	2024-08-01 15:37:03.552127+07	00:00:00.038485	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
88	88	1	f	1	2024-08-01 15:38:04.09796+07	00:00:00.03757	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
89	89	1	f	1	2024-08-01 15:39:04.696124+07	00:00:00.036349	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
90	90	1	f	1	2024-08-01 15:40:00.262239+07	00:00:00.037456	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
91	91	1	f	1	2024-08-01 15:41:00.815273+07	00:00:00.034333	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
92	92	1	f	1	2024-08-01 15:42:01.386755+07	00:00:00.038494	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
93	93	1	f	1	2024-08-01 15:43:01.931653+07	00:00:00.034959	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
94	94	1	f	1	2024-08-01 15:44:02.505575+07	00:00:00.037293	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
95	95	1	f	1	2024-08-01 15:45:03.115941+07	00:00:00.036589	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
96	96	1	f	1	2024-08-01 15:46:03.759278+07	00:00:00.037679	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
97	97	1	f	1	2024-08-01 15:47:04.357292+07	00:00:00.036609	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
98	98	1	f	1	2024-08-01 15:48:05.037772+07	00:00:00.037943	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
99	99	1	f	1	2024-08-01 15:49:00.632034+07	00:00:00.036434	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
100	100	1	f	1	2024-08-01 15:50:01.251599+07	00:00:00.036203	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
101	101	1	f	1	2024-08-01 15:51:01.90067+07	00:00:00.036815	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
102	102	1	f	1	2024-08-01 15:52:02.478281+07	00:00:00.037806	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
103	103	1	f	1	2024-08-01 15:53:03.126707+07	00:00:00.036185	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
104	104	1	f	1	2024-08-01 15:54:03.736142+07	00:00:00.03612	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
105	105	1	f	1	2024-08-01 15:55:04.348506+07	00:00:00.038194	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
106	106	1	f	1	2024-08-01 15:56:04.99233+07	00:00:00.033606	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
107	107	1	f	1	2024-08-01 15:57:00.572609+07	00:00:00.036251	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
108	108	1	f	1	2024-08-01 15:58:01.166982+07	00:00:00.036985	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
109	109	1	f	1	2024-08-01 15:59:01.787031+07	00:00:00.03518	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
110	110	1	f	1	2024-08-01 16:00:02.400847+07	00:00:00.036867	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
111	111	1	f	1	2024-08-01 16:01:03.022203+07	00:00:00.036152	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
112	112	1	f	1	2024-08-01 16:02:03.639311+07	00:00:00.038157	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
113	113	1	f	1	2024-08-01 16:03:04.224193+07	00:00:00.03596	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
114	114	1	f	1	2024-08-01 16:04:04.764023+07	00:00:00.038729	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
115	115	1	f	1	2024-08-01 16:05:00.356457+07	00:00:00.038783	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
116	116	1	f	1	2024-08-01 16:06:00.95873+07	00:00:00.099892	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
117	117	1	f	1	2024-08-01 16:07:01.339223+07	00:00:00.116354	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
118	118	1	f	1	2024-08-01 16:08:01.666363+07	00:00:00.093903	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
119	119	1	f	1	2024-08-01 16:09:02.157939+07	00:00:00.106315	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
120	120	1	f	1	2024-08-01 16:10:02.430482+07	00:00:00.110078	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
121	121	1	f	1	2024-08-01 16:11:02.791556+07	00:00:00.09342	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
122	122	1	f	1	2024-08-01 16:12:03.16051+07	00:00:00.087971	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
123	123	1	f	1	2024-08-01 16:13:03.502464+07	00:00:00.099259	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
124	124	1	f	1	2024-08-01 16:14:03.876502+07	00:00:00.084654	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
125	125	1	f	1	2024-08-01 16:15:04.224953+07	00:00:00.091352	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
126	126	1	f	1	2024-08-01 16:16:04.590771+07	00:00:00.094214	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
127	127	1	f	1	2024-08-01 16:17:04.952668+07	00:00:00.086634	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
128	128	1	f	1	2024-08-01 16:18:00.270519+07	00:00:00.112506	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
129	129	1	f	1	2024-08-01 16:19:00.643637+07	00:00:00.094444	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
130	130	1	f	1	2024-08-01 16:20:01.15699+07	00:00:00.06336	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
131	131	1	f	1	2024-08-01 16:21:01.763304+07	00:00:00.107147	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
132	132	1	f	1	2024-08-01 16:22:02.243486+07	00:00:00.113634	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
133	133	1	f	1	2024-08-01 16:23:02.653908+07	00:00:00.103977	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
134	134	1	f	1	2024-08-01 16:24:03.10459+07	00:00:00.087896	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
135	135	1	f	1	2024-08-01 16:25:03.468335+07	00:00:00.050087	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
136	136	1	f	1	2024-08-01 16:26:04.022884+07	00:00:00.047361	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
137	137	1	f	1	2024-08-01 16:27:04.443777+07	00:00:00.063037	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
138	138	1	f	1	2024-08-01 16:28:04.991829+07	00:00:00.052078	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
139	139	1	f	1	2024-08-01 16:29:00.534763+07	00:00:00.04043	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
140	140	1	f	1	2024-08-01 16:30:01.167177+07	00:00:00.037878	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
141	141	1	f	1	2024-08-01 16:31:01.794052+07	00:00:00.039166	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
142	142	1	f	1	2024-08-01 16:32:02.342127+07	00:00:00.036634	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
143	143	1	f	1	2024-08-01 16:33:02.855368+07	00:00:00.037079	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
144	144	1	f	1	2024-08-01 16:34:03.438782+07	00:00:00.041568	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
145	145	1	f	1	2024-08-01 16:35:03.946466+07	00:00:00.040032	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
146	146	1	f	1	2024-08-01 16:36:04.595643+07	00:00:00.040214	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
147	147	1	f	1	2024-08-01 16:37:00.131551+07	00:00:00.040184	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
148	148	1	f	1	2024-08-01 16:38:00.741171+07	00:00:00.041076	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
149	149	1	f	1	2024-08-01 16:39:01.305682+07	00:00:00.042452	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
150	150	1	f	1	2024-08-01 16:40:01.894343+07	00:00:00.03759	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
151	151	1	f	1	2024-08-01 16:41:02.579337+07	00:00:00.037973	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
152	152	1	f	1	2024-08-01 16:42:03.234175+07	00:00:00.038587	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
153	153	1	f	1	2024-08-01 16:43:03.875083+07	00:00:00.040537	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
154	154	1	f	1	2024-08-01 16:44:04.458171+07	00:00:00.038449	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
155	155	1	f	1	2024-08-01 16:45:00.050616+07	00:00:00.038445	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
156	156	1	f	1	2024-08-01 16:46:00.700524+07	00:00:00.038911	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
157	157	1	f	1	2024-08-01 16:47:01.307213+07	00:00:00.035854	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
158	158	1	f	1	2024-08-01 16:48:01.980307+07	00:00:00.036425	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
159	159	1	f	1	2024-08-01 16:49:02.628028+07	00:00:00.035351	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
160	160	1	f	1	2024-08-01 16:50:03.258136+07	00:00:00.03398	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
161	161	1	f	1	2024-08-01 16:51:03.915346+07	00:00:00.034922	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
162	162	1	f	1	2024-08-01 16:52:04.518462+07	00:00:00.035577	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
163	163	1	f	1	2024-08-01 16:53:00.130059+07	00:00:00.037283	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
164	164	1	f	1	2024-08-01 16:54:00.725154+07	00:00:00.035876	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
165	165	1	f	1	2024-08-01 16:55:01.366275+07	00:00:00.034725	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
166	166	1	f	1	2024-08-01 16:56:01.964317+07	00:00:00.035811	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
167	167	1	f	1	2024-08-01 16:57:02.594658+07	00:00:00.039259	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
168	168	1	f	1	2024-08-01 16:58:03.177936+07	00:00:00.035278	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
169	169	1	f	1	2024-08-01 16:59:03.821897+07	00:00:00.035361	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
170	170	1	f	1	2024-08-01 17:00:04.465015+07	00:00:00.034981	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
171	171	1	f	1	2024-08-01 17:01:05.199203+07	00:00:00.033762	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
172	172	1	f	1	2024-08-01 17:02:00.670525+07	00:00:00.03737	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
173	173	1	f	1	2024-08-01 17:03:01.286858+07	00:00:00.037593	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
174	174	1	f	1	2024-08-01 17:04:01.934685+07	00:00:00.035105	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
175	175	1	f	1	2024-08-01 17:05:02.546165+07	00:00:00.034478	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
176	176	1	f	1	2024-08-01 17:06:03.189817+07	00:00:00.036056	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
177	177	1	f	1	2024-08-01 17:07:03.802315+07	00:00:00.037436	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
178	178	1	f	1	2024-08-01 17:08:04.470325+07	00:00:00.036949	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
179	179	1	f	1	2024-08-01 17:09:00.098148+07	00:00:00.035847	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
180	180	1	f	1	2024-08-01 17:10:00.780002+07	00:00:00.03816	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
181	181	1	f	1	2024-08-01 17:11:01.363118+07	00:00:00.036738	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
182	182	1	f	1	2024-08-01 17:12:01.989032+07	00:00:00.038958	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
183	183	1	f	1	2024-08-01 17:13:02.602106+07	00:00:00.039235	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
184	184	1	f	1	2024-08-01 17:14:03.212803+07	00:00:00.044488	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
185	185	1	f	1	2024-08-01 17:15:03.813095+07	00:00:00.04029	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
186	186	1	f	1	2024-08-01 17:16:04.434637+07	00:00:00.046351	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
187	187	1	f	1	2024-08-01 17:17:00.061176+07	00:00:00.050383	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
188	188	1	f	1	2024-08-01 17:18:00.676245+07	00:00:00.037651	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
189	189	1	f	1	2024-08-01 17:19:01.271467+07	00:00:00.036561	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
190	190	1	f	1	2024-08-01 17:20:01.890066+07	00:00:00.035694	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
191	191	1	f	1	2024-08-01 17:21:02.555519+07	00:00:00.040681	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
192	192	1	f	1	2024-08-01 17:22:03.256409+07	00:00:00.039107	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
193	193	1	f	1	2024-08-01 17:23:03.888276+07	00:00:00.039827	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
194	194	1	f	1	2024-08-01 17:24:04.555728+07	00:00:00.036752	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
195	195	1	f	1	2024-08-01 17:25:00.151576+07	00:00:00.036237	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
196	196	1	f	1	2024-08-01 17:26:00.809253+07	00:00:00.03932	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
197	197	1	f	1	2024-08-01 17:27:01.452001+07	00:00:00.040285	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
198	198	1	f	1	2024-08-01 17:28:02.111974+07	00:00:00.036183	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
199	199	1	f	1	2024-08-01 17:29:02.772397+07	00:00:00.038106	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
200	200	1	f	1	2024-08-01 17:30:03.388512+07	00:00:00.035812	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
201	201	1	f	1	2024-08-01 17:31:04.032377+07	00:00:00.03599	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
202	202	1	f	1	2024-08-01 17:32:04.63693+07	00:00:00.03723	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
203	203	1	f	1	2024-08-01 17:33:00.198664+07	00:00:00.037284	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
204	204	1	f	1	2024-08-01 17:34:00.888756+07	00:00:00.058004	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
205	205	1	f	1	2024-08-01 17:35:01.325443+07	00:00:00.041713	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
206	206	1	f	1	2024-08-01 17:36:01.756007+07	00:00:00.041072	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
207	207	1	f	1	2024-08-01 17:37:02.241575+07	00:00:00.05655	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
208	208	1	f	1	2024-08-01 17:38:02.666806+07	00:00:00.044006	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
209	209	1	f	1	2024-08-01 17:39:03.262723+07	00:00:00.039152	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
210	210	1	f	1	2024-08-01 17:40:03.926177+07	00:00:00.039864	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
211	211	1	f	1	2024-08-01 17:41:04.543169+07	00:00:00.03866	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
212	212	1	f	1	2024-08-01 17:42:00.137914+07	00:00:00.038255	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
213	213	1	f	1	2024-08-01 17:43:00.713173+07	00:00:00.03734	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
214	214	1	f	1	2024-08-01 17:44:01.2933+07	00:00:00.039623	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
215	215	1	f	1	2024-08-01 17:45:01.937777+07	00:00:00.043428	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
216	216	1	f	1	2024-08-01 17:46:02.52889+07	00:00:00.040815	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
217	217	1	f	1	2024-08-01 17:47:03.134087+07	00:00:00.039631	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
218	218	1	f	1	2024-08-01 17:48:03.776168+07	00:00:00.036324	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
219	219	1	f	1	2024-08-01 17:49:04.421365+07	00:00:00.035398	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
220	220	1	f	1	2024-08-01 17:50:00.111528+07	00:00:00.037225	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
221	221	1	f	1	2024-08-01 17:51:00.75572+07	00:00:00.037439	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
222	222	1	f	1	2024-08-01 17:52:01.389251+07	00:00:00.037941	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
223	223	1	f	1	2024-08-01 17:53:02.05417+07	00:00:00.037098	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
224	224	1	f	1	2024-08-01 17:54:02.658041+07	00:00:00.041372	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
225	225	1	f	1	2024-08-01 17:55:03.271355+07	00:00:00.036691	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
226	226	1	f	1	2024-08-01 17:56:03.895831+07	00:00:00.034815	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
227	227	1	f	1	2024-08-01 17:57:04.561073+07	00:00:00.040768	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
228	228	1	f	1	2024-08-01 17:58:00.142748+07	00:00:00.039918	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
229	229	1	f	1	2024-08-01 17:59:00.722699+07	00:00:00.035773	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
230	230	1	f	1	2024-08-01 18:00:01.31673+07	00:00:00.036577	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
231	231	1	f	1	2024-08-01 18:01:01.890506+07	00:00:00.037821	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
232	232	1	f	1	2024-08-01 18:02:02.46459+07	00:00:00.039663	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
233	233	1	f	1	2024-08-01 18:03:03.121802+07	00:00:00.038404	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
234	234	1	f	1	2024-08-01 18:04:03.739068+07	00:00:00.03856	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
235	235	1	f	1	2024-08-01 18:05:04.39485+07	00:00:00.042444	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
236	236	1	f	1	2024-08-01 18:06:05.003732+07	00:00:00.036497	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
237	237	1	f	1	2024-08-01 18:07:00.605697+07	00:00:00.036979	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
238	238	1	f	1	2024-08-01 18:08:01.226588+07	00:00:00.036162	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
239	239	1	f	1	2024-08-01 18:09:01.767178+07	00:00:00.037498	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
240	240	1	f	1	2024-08-01 18:10:02.399722+07	00:00:00.032712	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
241	241	1	f	1	2024-08-01 18:11:02.906087+07	00:00:00.05154	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
242	242	1	f	1	2024-08-01 18:12:03.393783+07	00:00:00.037737	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
243	243	1	f	1	2024-08-01 18:13:03.879495+07	00:00:00.040924	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
244	244	1	f	1	2024-08-01 18:14:04.465795+07	00:00:00.03868	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
245	245	1	f	1	2024-08-01 18:15:05.034853+07	00:00:00.040826	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
246	246	1	f	1	2024-08-01 18:16:00.548677+07	00:00:00.037061	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
247	247	1	f	1	2024-08-01 18:17:01.170845+07	00:00:00.039604	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
248	248	1	f	1	2024-08-01 18:18:01.872397+07	00:00:00.038486	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
249	249	1	f	1	2024-08-01 18:19:02.564072+07	00:00:00.036588	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
250	250	1	f	1	2024-08-01 18:20:03.232136+07	00:00:00.040599	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
251	251	1	f	1	2024-08-01 18:21:03.826237+07	00:00:00.039078	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
252	252	1	f	1	2024-08-01 18:22:04.412344+07	00:00:00.039066	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
253	253	1	f	1	2024-08-01 18:23:05.037844+07	00:00:00.036811	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
254	254	1	f	1	2024-08-01 18:24:00.602999+07	00:00:00.037038	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
255	255	1	f	1	2024-08-01 18:25:01.330663+07	00:00:00.03922	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
256	256	1	f	1	2024-08-01 18:26:01.816194+07	00:00:00.036466	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
257	257	1	f	1	2024-08-01 18:27:02.451083+07	00:00:00.03781	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
258	258	1	f	1	2024-08-01 18:28:03.081598+07	00:00:00.038555	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
259	259	1	f	1	2024-08-01 18:29:03.68525+07	00:00:00.038863	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
260	260	1	f	1	2024-08-01 18:30:04.361161+07	00:00:00.039508	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
261	261	1	f	1	2024-08-01 18:31:04.987008+07	00:00:00.047971	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
262	262	1	f	1	2024-08-01 18:32:00.593741+07	00:00:00.039247	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
263	263	1	f	1	2024-08-01 18:33:01.194548+07	00:00:00.038752	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
264	264	1	f	1	2024-08-01 18:34:01.809448+07	00:00:00.045389	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
265	265	1	f	1	2024-08-01 18:35:02.279911+07	00:00:00.041262	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
266	266	1	f	1	2024-08-01 18:36:02.821557+07	00:00:00.035533	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
267	267	1	f	1	2024-08-01 18:37:03.369065+07	00:00:00.040081	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
268	268	1	f	1	2024-08-01 18:38:03.808179+07	00:00:00.041149	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
269	269	1	f	1	2024-08-01 18:39:04.22523+07	00:00:00.043102	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
270	270	1	f	1	2024-08-01 18:40:04.705068+07	00:00:00.038229	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
271	271	1	f	1	2024-08-01 18:41:00.19049+07	00:00:00.047875	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
272	272	1	f	1	2024-08-01 18:42:00.787474+07	00:00:00.046232	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
273	273	1	f	1	2024-08-01 18:43:01.36915+07	00:00:00.04554	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
274	274	1	f	1	2024-08-01 18:44:01.931619+07	00:00:00.042184	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
275	275	1	f	1	2024-08-01 18:45:02.479694+07	00:00:00.040385	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
276	276	1	f	1	2024-08-01 18:46:03.060362+07	00:00:00.045966	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
277	277	1	f	1	2024-08-01 18:47:15.624017+07	00:00:00.038739	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
278	278	1	f	1	2024-08-01 18:48:00.94284+07	00:00:00.036319	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
279	279	1	f	1	2024-08-01 18:49:01.472634+07	00:00:00.034927	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
280	280	1	f	1	2024-08-01 18:50:02.090255+07	00:00:00.043192	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
281	281	1	f	1	2024-08-01 18:51:02.517837+07	00:00:00.034765	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
282	282	1	f	1	2024-08-01 18:52:03.016669+07	00:00:00.030819	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
283	283	1	f	1	2024-08-01 18:53:03.615546+07	00:00:00.032107	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
284	284	1	f	1	2024-08-01 18:54:04.152367+07	00:00:00.033224	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
285	285	1	f	1	2024-08-01 18:55:04.697132+07	00:00:00.035159	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
286	286	1	f	1	2024-08-01 18:56:00.202657+07	00:00:00.033864	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
287	287	1	f	1	2024-08-01 18:57:00.7177+07	00:00:00.032853	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
288	288	1	f	1	2024-08-01 18:58:01.241539+07	00:00:00.037069	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
289	289	1	f	1	2024-08-01 18:59:01.652582+07	00:00:00.037636	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
290	290	1	f	1	2024-08-01 19:00:02.190207+07	00:00:00.034054	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
291	291	1	f	1	2024-08-01 19:01:02.684441+07	00:00:00.037099	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
292	292	1	f	1	2024-08-01 19:02:03.182615+07	00:00:00.035059	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
293	293	1	f	1	2024-08-01 19:03:03.69093+07	00:00:00.036352	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
294	294	1	f	1	2024-08-01 19:04:04.2706+07	00:00:00.04013	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
295	295	1	f	1	2024-08-01 19:05:04.902055+07	00:00:00.037751	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
296	296	1	f	1	2024-08-01 19:06:00.49004+07	00:00:00.03685	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
297	297	1	f	1	2024-08-01 19:07:01.025019+07	00:00:00.034002	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
298	298	1	f	1	2024-08-01 19:08:01.533005+07	00:00:00.036233	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
299	299	1	f	1	2024-08-01 19:09:02.019275+07	00:00:00.033059	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
300	300	1	f	1	2024-08-01 19:10:02.561069+07	00:00:00.034908	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
301	301	1	f	1	2024-08-01 19:11:03.118566+07	00:00:00.036694	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
302	302	1	f	1	2024-08-01 19:12:03.639911+07	00:00:00.034034	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
303	303	1	f	1	2024-08-01 19:13:04.140571+07	00:00:00.034291	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
304	304	1	f	1	2024-08-01 19:14:04.684133+07	00:00:00.036715	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
305	305	1	f	1	2024-08-01 19:15:00.188572+07	00:00:00.032013	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
306	306	1	f	1	2024-08-01 19:16:00.723516+07	00:00:00.032733	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
307	307	1	f	1	2024-08-01 19:17:01.261228+07	00:00:00.033968	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
308	308	1	f	1	2024-08-01 19:18:01.876187+07	00:00:00.046549	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
309	309	1	f	1	2024-08-01 19:19:02.420264+07	00:00:00.037663	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
310	310	1	f	1	2024-08-01 19:20:02.911373+07	00:00:00.03347	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
311	311	1	f	1	2024-08-01 19:21:03.492763+07	00:00:00.037611	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
312	312	1	f	1	2024-08-01 19:22:03.969343+07	00:00:00.03644	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
313	313	1	f	1	2024-08-01 19:23:04.527151+07	00:00:00.030122	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
314	314	1	f	1	2024-08-01 19:24:05.019952+07	00:00:00.032076	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
315	315	1	f	1	2024-08-01 19:25:00.525018+07	00:00:00.04185	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
316	316	1	f	1	2024-08-01 19:26:01.145282+07	00:00:00.033611	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
317	317	1	f	1	2024-08-01 19:27:01.468652+07	00:00:00.040791	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
318	318	1	f	1	2024-08-01 19:28:01.972983+07	00:00:00.033995	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
319	319	1	f	1	2024-08-01 19:29:02.446837+07	00:00:00.034024	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
320	320	1	f	1	2024-08-01 19:30:03.025479+07	00:00:00.033531	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
321	321	1	f	1	2024-08-01 19:31:03.545695+07	00:00:00.037108	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
322	322	1	f	1	2024-08-01 19:32:04.044236+07	00:00:00.031103	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
323	323	1	f	1	2024-08-01 19:33:04.619229+07	00:00:00.034539	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
324	324	1	f	1	2024-08-01 19:34:00.053518+07	00:00:00.034688	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
325	325	1	f	1	2024-08-01 19:35:00.516613+07	00:00:00.039917	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
326	326	1	f	1	2024-08-01 19:36:01.007614+07	00:00:00.034473	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
327	327	1	f	1	2024-08-01 19:37:01.530636+07	00:00:00.035689	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
328	328	1	f	1	2024-08-01 19:38:01.991881+07	00:00:00.037207	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
329	329	1	f	1	2024-08-01 19:39:02.573515+07	00:00:00.035109	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
330	330	1	f	1	2024-08-01 19:40:03.038971+07	00:00:00.04402	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
331	331	1	f	1	2024-08-01 19:41:03.616906+07	00:00:00.031946	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
332	332	1	f	1	2024-08-01 19:42:04.131101+07	00:00:00.032396	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
333	333	1	f	1	2024-08-01 19:43:04.647773+07	00:00:00.034777	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
334	334	1	f	1	2024-08-01 19:44:00.150698+07	00:00:00.030619	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
335	335	1	f	1	2024-08-01 19:45:00.660751+07	00:00:00.036747	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
336	336	1	f	1	2024-08-01 19:46:01.167601+07	00:00:00.035598	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
337	337	1	f	1	2024-08-01 19:47:01.678373+07	00:00:00.035287	\r\nC:\\Windows\\System32>python C:\\Users\\FAVIAN\\OneDrive - Institut Teknologi Bandung\\Favian\\S1\\4th Semester\\Data Scraping\\src\\scrape_ww.py \r\n'python' is not recognized as an internal or external command,\r\noperable program or batch file.\r\n
\.


--
-- Data for Name: char_material; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.char_material (char_id, ws_mats, ra_mats, a_mats, w_mats, su_mats) FROM stdin;
41	howler core	roaring rock fist	wintry bell	impure phlogiston	monument bell
42	howler core	sound-keeping tacet core	lanternberry	lento helix	monument bell
43	crude ring	thundering tacet core	iris	waveworn residue 210	monument bell
44	crude ring	rage tacet core	pavo plum	inert metallic drip	sentinel 's dagger
45	whisperin core	rage tacet core	belle poppy	impure phlogiston	monument bell
46	crude ring	strife tacet core	belle poppy	inert metallic drip	unwarranted feather
47	whisperin core	rage tacet core	pecok flower	lento helix	unending destruction
48	howler core	roaring rock fist	lanternberry	cadence seed	unending destruction
49	howler core	elegy tacet core	loong 's pearl	waveworn residue 210	sentinel 's dagger
50	howler core	roaring rock fist	pecok flower	waveworn residue 210	monument bell
51	whisperin core	sound-keeping tacet core	coriolus	cadence seed	unending destruction
52	whisperin core	rage tacet core	coriolus	impure phlogiston	monument bell
53	whisperin core	mysterious code	pecok flower	inert metallic drip	unwarranted feather
54	whisperin core	mysterious code	pecok flower	inert metallic drip	unending destruction
55	whisperin core	sound-keeping tacet core	wintry bell	inert metallic drip	unending destruction
58	NULL	NULL	NULL	NULL	NULL
56	howler core	gold-dissolving feather	iris	waveworn residue 210	unwarranted feather
57	howler core	elegy tacet core	belle poppy	lento helix	monument bell
59	crude ring	roaring rock fist	wintry bell	inert metallic drip	unending destruction
60	whisperin core	group abomination tacet core	coriolus	lento helix	unwarranted feather
61	crude ring	hidden thunder tacet core	? ? ?	cadence seed	unending destruction
62	NULL	NULL	NULL	NULL	NULL
\.


--
-- Data for Name: char_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.char_stats (char_id, hp, char_atk, def, max_energy, crit_rate, crit_dmg, healing_bonus, element_dmg) FROM stdin;
41	9850	263	1076	150	5	150	0	0
42	12813	213	1002	175	5	150	0	0
43	10500	438	1186	125	5	150	0	0
44	10388	463	1100	125	5	150	0	0
45	9088	300	953	150	5	150	0	0
46	9438	263	1149	100	5	150	0	0
47	10513	425	1247	125	5	150	0	0
48	14113	338	1124	150	5	150	0	0
49	10825	413	1259	125	5	150	0	0
50	10488	438	1186	125	5	150	0	0
51	10388	438	1210	125	5	150	0	0
52	10025	250	1137	125	5	150	0	0
53	10825	413	1259	125	5	150	0	0
54	11400	375	1369	125	5	150	0	0
55	10063	275	941	100	5	150	0	0
56	8950	225	1564	125	5	150	0	0
57	14238	338	1100	175	5	150	0	0
58	\N	\N	\N	\N	\N	\N	\N	\N
59	10200	250	1100	100	5	150	0	0
60	11000	400	1283	125	5	150	0	0
61	8525	225	1638	125	5	150	0	0
62	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: character; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."character" (char_id, char_name, char_rarity, element_id, best_echo_set_id, best_main_echo_id) FROM stdin;
41	aalto	4	51	607	301
42	baizhi	4	52	606	296
43	calcharo	5	53	857	306
44	changli	5	54	613	302
45	chixia	4	54	613	302
46	danjin	4	56	608	297
47	encore	5	54	613	302
48	jianxin	5	51	606	301
49	jinhsi	5	59	609	298
50	jiyan	5	51	611	300
51	lingyang	5	52	857	303
52	mortefi	4	54	607	301
53	rover ( havoc )	5	56	608	297
54	rover ( spectro )	5	59	609	301
55	sanhua	4	52	607	301
56	taoqi	4	56	606	296
57	verina	5	59	606	296
58	xiangli yao	5	68	\N	\N
59	yangyang	4	51	606	301
60	yinlin	5	53	617	301
61	yuanwu	4	53	606	301
62	zhezhi	5	68	\N	\N
\.


--
-- Data for Name: echo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.echo (echo_id, echo_name, class, cost, cooldown, element_id) FROM stdin;
296	bell-borne geochelone	calamity	4	20	52
297	dreamless	calamity	4	20	56
298	jué	calamity	4	20	59
299	crownless	overlord	4	20	56
300	feilian beringal	overlord	4	20	51
301	impermanence heron	overlord	4	20	56
302	inferno rider	overlord	4	20	54
303	lampylumen myriad	overlord	4	20	52
304	mech abomination	overlord	4	20	53
305	mourning aix	overlord	4	20	59
306	tempest mephis	overlord	4	20	53
307	thundering mephis	overlord	4	20	53
308	autopuppet scout	elite	3	15	52
309	chaserazor	elite	3	15	51
310	chasm guardian	elite	3	15	56
311	cyan-feathered heron	elite	3	15	51
312	flautist	elite	3	15	53
313	geohide saurian	elite	3	15	54
314	glacio dreadmane	elite	3	20	52
315	havoc dreadmane	elite	3	15	56
316	hoochief	elite	3	15	51
317	lightcrusher	elite	3	15	59
318	lumiscale construct	elite	3	15	52
319	rocksteady guardian	elite	3	15	59
320	roseshroom	elite	3	15	56
321	spearback	elite	3	15	\N
322	stonewall bracer	elite	3	15	\N
323	tambourinist	elite	3	15	56
324	violet-feathered heron	elite	3	15	53
325	aero predator	common	1	8	51
326	chirpuff	common	1	8	51
327	clang bang	common	1	8	52
328	cruisewing	common	1	8	\N
329	diamondclaw	common	1	8	\N
330	dwarf cassowary	common	1	8	\N
331	electro predator	common	1	8	53
332	excarat	common	1	2	\N
333	fission junrock	common	1	15	\N
334	fusion dreamane minor	common	1	8	54
335	fusion prism	common	1	8	54
336	fusion warrior	common	1	15	54
337	glacio predator	common	1	8	52
338	glacio prism	common	1	8	52
339	gulpuff	common	1	8	52
340	havoc prism	common	1	8	56
341	havoc warrior	common	1	15	56
342	hoartoise	common	1	2	\N
343	hooscamp	common	1	8	51
344	lava larva	common	1	8	54
345	sabyr boar	common	1	8	\N
346	snip snap	common	1	8	54
347	spectro prism	common	1	8	59
348	tick tack	common	1	15	56
349	traffic illuminator	common	1	15	\N
350	vanguard junrock	common	1	8	\N
351	whiff whaff	common	1	15	51
352	young geohide saurian	common	1	2	\N
353	young roseshroom	common	1	8	56
354	zig zag	common	1	15	59
\.


--
-- Data for Name: echo_set; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.echo_set (set_id, set_name) FROM stdin;
606	rejuvenating
607	moonlit
608	havoc
609	celestial
611	sierra
613	molten
614	freezing
615	endless
617	void
857	lingering
\.


--
-- Data for Name: element; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.element (element_id, element_name) FROM stdin;
51	aero
52	glacio
53	electro
54	fusion
56	havoc
59	spectro
68	unknown
\.


--
-- Data for Name: part_of; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.part_of (set_id, echo_id) FROM stdin;
606	296
607	296
608	297
609	298
608	299
611	300
607	301
613	302
614	303
615	304
609	305
617	306
617	307
614	308
609	308
611	309
607	309
606	310
615	310
611	311
609	311
617	312
615	312
613	313
607	313
614	314
607	314
613	315
608	315
611	316
606	316
609	317
614	318
617	318
609	319
606	319
614	320
608	320
607	321
615	321
606	322
607	322
614	323
608	323
613	324
617	324
617	325
611	325
611	326
608	326
614	327
609	327
609	328
606	328
607	328
607	329
615	329
611	330
606	330
613	331
617	331
614	332
608	332
617	333
606	333
607	333
613	334
606	334
614	335
613	335
615	335
613	336
617	336
611	336
614	337
609	337
614	338
608	338
607	338
614	339
609	339
617	340
609	340
608	340
609	341
608	341
614	342
609	342
611	343
615	343
613	344
615	344
614	345
611	345
607	345
613	346
606	346
615	346
613	347
617	347
609	347
608	348
606	348
615	348
613	349
617	349
611	349
617	350
606	350
615	350
611	351
606	351
607	351
613	352
617	352
615	352
611	353
608	353
609	354
607	354
615	354
857	304
857	310
857	312
857	321
857	329
857	335
857	343
857	344
857	346
857	348
857	350
857	352
857	354
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test (id, json_data) FROM stdin;
\.


--
-- Data for Name: weapon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weapon (weapon_id, name, rarity, weapon_type, atk, substat, substat_value) FROM stdin;
326	abyss surges	5	gauntlets	587	atk	36.4
327	ages of harvest	5	broadblade	587	crit rate	24.3
328	blazing brilliance	5	sword	587	crit dmg	48.6
329	cosmic ripples	5	rectifier	500	atk	54
330	emerald of genesis	5	sword	587	crit rate	24.3
331	lustrous razor	5	broadblade	587	atk	36.4
332	static mist	5	pistols	587	crit rate	24.3
333	stringmaster	5	rectifier	500	crit rate	36
334	verdant summit	5	broadblade	587	crit dmg	48.6
335	amity accord	4	gauntlets	337	def	61.5
336	augment	4	rectifier	412	crit rate	20.2
337	autumntrace	4	broadblade	412	crit rate	20.2
338	broadblade # 41	4	broadblade	412	energy regen	32.3
339	cadenza	4	pistols	337	energy regen	51.8
340	comet flare	4	rectifier	412	hp	30.3
341	commando of conviction	4	sword	412	atk	30.3
342	dauntless evernight	4	broadblade	337	def	61.5
343	discord	4	broadblade	337	energy regen	51.8
344	gauntlets # 21d	4	gauntlets	387	energy regen	38.8
345	helios cleaver	4	broadblade	412	atk	30.3
346	hollow mirage	4	gauntlets	412	atk	30.3
347	jinzhou keeper	4	rectifier	387	atk	36.4
348	lumingloss	4	sword	387	atk	36.4
349	lunar cutter	4	sword	412	atk	30.3
350	marcato	4	gauntlets	337	energy regen	51.8
351	novaburst	4	pistols	412	atk	30.3
352	pistols # 26	4	pistols	387	atk	36.4
353	rectifier # 25	4	rectifier	337	energy regen	51.8
354	scale : slasher	4	sword	337	energy regen	51.8
355	stonard	4	gauntlets	412	crit rate	20.2
356	sword # 18	4	sword	387	atk	36.4
357	thunderbolt	4	pistols	387	atk	36.4
358	undying flame	4	pistols	412	atk	30.3
359	variation	4	rectifier	337	energy regen	51.8
360	beguiling melody	3	broadblade	300	atk	30.4
361	broadblade of night	3	broadblade	325	atk	24.3
362	broadblade of voyager	3	broadblade	300	energy regen	32.3
363	gauntlets of night	3	gauntlets	325	atk	24.3
364	gauntlets of voyager	3	gauntlets	325	def	30.7
365	guardian broadblade	3	broadblade	325	atk	24.3
366	guardian gauntlets	3	gauntlets	300	def	38.4
367	guardian pistols	3	pistols	325	atk	24.3
368	guardian rectifier	3	rectifier	325	atk	24.3
369	guardian sword	3	sword	300	atk	30.3
370	originite : type i	3	broadblade	300	def	38.4
371	originite : type ii	3	sword	325	atk	24.3
372	originite : type iii	3	pistols	325	atk	24.3
373	originite : type iv	3	gauntlets	300	crit dmg	40.5
374	originite : type v	3	rectifier	300	atk	30.3
375	pistols of night	3	pistols	325	atk	24.3
376	pistols of voyager	3	pistols	300	atk	30.3
377	rectifier of night	3	rectifier	325	atk	24.3
378	rectifier of voyager	3	rectifier	300	energy regen	32.3
379	sword of night	3	sword	325	atk	24.3
380	sword of voyager	3	sword	300	energy regen	32.3
381	tyro broadblade	2	broadblade	275	atk	14.8
382	tyro gauntlets	2	gauntlets	275	atk	14.8
383	tyro pistols	2	pistols	275	atk	14.8
384	tyro rectifier	2	rectifier	275	atk	14.8
385	tyro sword	2	sword	275	atk	14.8
386	training broadblade	1	broadblade	250	atk	11.4
387	training gauntlets	1	gauntlets	250	atk	11.4
388	training pistols	1	pistols	250	atk	11.4
389	training rectifier	1	rectifier	250	atk	11.4
390	training sword	1	sword	250	atk	11.4
\.


--
-- Data for Name: weapon_level; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weapon_level (char_id, weapon_id, s_level) FROM stdin;
41	332	1
42	359	1
43	331	1
44	328	1
45	332	1
46	330	1
47	333	1
48	373	5
49	327	1
50	334	1
51	326	1
52	332	1
53	330	1
54	330	1
55	330	1
56	343	1
57	359	1
59	371	5
60	333	1
61	335	1
\.


--
-- Name: character_char_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.character_char_id_seq', 150, true);


--
-- Name: echo_echo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.echo_echo_id_seq', 590, true);


--
-- Name: echo_set_set_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.echo_set_set_id_seq', 1210, true);


--
-- Name: element_element_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.element_element_id_seq', 204, true);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_id_seq', 1, false);


--
-- Name: weapon_weapon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.weapon_weapon_id_seq', 780, true);


--
-- Name: char_material char_material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.char_material
    ADD CONSTRAINT char_material_pkey PRIMARY KEY (char_id);


--
-- Name: char_stats char_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.char_stats
    ADD CONSTRAINT char_stats_pkey PRIMARY KEY (char_id);


--
-- Name: character character_char_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_char_name_key UNIQUE (char_name);


--
-- Name: character character_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_pkey PRIMARY KEY (char_id);


--
-- Name: echo echo_echo_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.echo
    ADD CONSTRAINT echo_echo_name_key UNIQUE (echo_name);


--
-- Name: echo echo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.echo
    ADD CONSTRAINT echo_pkey PRIMARY KEY (echo_id);


--
-- Name: echo_set echo_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.echo_set
    ADD CONSTRAINT echo_set_pkey PRIMARY KEY (set_id);


--
-- Name: echo_set echo_set_set_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.echo_set
    ADD CONSTRAINT echo_set_set_name_key UNIQUE (set_name);


--
-- Name: element element_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.element
    ADD CONSTRAINT element_name_key UNIQUE (element_name);


--
-- Name: element element_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.element
    ADD CONSTRAINT element_pkey PRIMARY KEY (element_id);


--
-- Name: part_of part_of_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.part_of
    ADD CONSTRAINT part_of_pkey PRIMARY KEY (set_id, echo_id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- Name: weapon_level weapon_level_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon_level
    ADD CONSTRAINT weapon_level_pkey PRIMARY KEY (char_id, weapon_id);


--
-- Name: weapon weapon_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_name_key UNIQUE (name);


--
-- Name: weapon weapon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_pkey PRIMARY KEY (weapon_id);


--
-- Name: weapon_level trigger_check_weapon_name; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_check_weapon_name BEFORE INSERT ON public.weapon_level FOR EACH ROW EXECUTE FUNCTION public.check_weapon_name();


--
-- Name: char_stats trigger_validate_char_stats; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_validate_char_stats BEFORE INSERT OR UPDATE ON public.char_stats FOR EACH ROW EXECUTE FUNCTION public.validate_char_stats();


--
-- Name: char_material char_material_char_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.char_material
    ADD CONSTRAINT char_material_char_id_fkey FOREIGN KEY (char_id) REFERENCES public."character"(char_id) ON DELETE CASCADE;


--
-- Name: char_stats char_stats_char_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.char_stats
    ADD CONSTRAINT char_stats_char_id_fkey FOREIGN KEY (char_id) REFERENCES public."character"(char_id) ON DELETE CASCADE;


--
-- Name: character character_best_echo_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_best_echo_set_id_fkey FOREIGN KEY (best_echo_set_id) REFERENCES public.echo_set(set_id) ON DELETE SET NULL;


--
-- Name: character character_best_main_echo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_best_main_echo_id_fkey FOREIGN KEY (best_main_echo_id) REFERENCES public.echo(echo_id) ON DELETE SET NULL;


--
-- Name: character character_element_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_element_id_fkey FOREIGN KEY (element_id) REFERENCES public.element(element_id) ON DELETE SET NULL;


--
-- Name: echo echo_echo_element_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.echo
    ADD CONSTRAINT echo_echo_element_id_fkey FOREIGN KEY (element_id) REFERENCES public.element(element_id) ON DELETE SET NULL;


--
-- Name: part_of part_of_echo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.part_of
    ADD CONSTRAINT part_of_echo_id_fkey FOREIGN KEY (echo_id) REFERENCES public.echo(echo_id) ON DELETE CASCADE;


--
-- Name: part_of part_of_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.part_of
    ADD CONSTRAINT part_of_set_id_fkey FOREIGN KEY (set_id) REFERENCES public.echo_set(set_id) ON DELETE CASCADE;


--
-- Name: weapon_level weapon_level_char_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon_level
    ADD CONSTRAINT weapon_level_char_id_fkey FOREIGN KEY (char_id) REFERENCES public."character"(char_id) ON DELETE CASCADE;


--
-- Name: weapon_level weapon_level_weapon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapon_level
    ADD CONSTRAINT weapon_level_weapon_id_fkey FOREIGN KEY (weapon_id) REFERENCES public.weapon(weapon_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

