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
-- Name: match_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.match_stats (
    home character varying(50) NOT NULL,
    away character varying(50) NOT NULL,
    home_score integer,
    away_score integer,
    date date,
    venue character varying(50)
);


ALTER TABLE public.match_stats OWNER TO postgres;

--
-- Name: official; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.official (
    name character varying(50) NOT NULL,
    roles character varying(44),
    email character varying(30),
    team_name character varying(28) NOT NULL
);


ALTER TABLE public.official OWNER TO postgres;

--
-- Name: official_phone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.official_phone (
    name character varying(42) NOT NULL,
    phone_number character varying(50) NOT NULL
);


ALTER TABLE public.official_phone OWNER TO postgres;

--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player (
    name character varying(50) NOT NULL,
    height integer,
    shirt_number integer,
    "position" character varying(50),
    team_name character varying(50)
);


ALTER TABLE public.player OWNER TO postgres;

--
-- Name: player_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_stats (
    player character varying(50) NOT NULL,
    team character varying(50) NOT NULL,
    gp integer NOT NULL,
    mpg character varying(6) NOT NULL,
    "FG%" numeric(5,1) NOT NULL,
    "3P%" numeric(5,1) NOT NULL,
    "2P%" numeric(5,1) NOT NULL,
    "FT%" integer NOT NULL,
    rpg numeric(5,2) NOT NULL,
    apg numeric(4,2) NOT NULL,
    bpg numeric(4,2) NOT NULL,
    spg numeric(4,2) NOT NULL,
    ppg numeric(5,2) NOT NULL
);


ALTER TABLE public.player_stats OWNER TO postgres;

--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    team character varying(28) NOT NULL,
    born_date character varying(16) NOT NULL,
    city character varying(15) NOT NULL
);


ALTER TABLE public.team OWNER TO postgres;

--
-- Name: team_standings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_standings (
    team character varying(50) NOT NULL,
    game integer,
    win integer,
    lose integer,
    points integer,
    rank integer
);


ALTER TABLE public.team_standings OWNER TO postgres;

--
-- Name: venue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venue (
    venue character varying(50) NOT NULL,
    team character varying(50) NOT NULL,
    address character varying(150) NOT NULL
);


ALTER TABLE public.venue OWNER TO postgres;

--
-- Data for Name: match_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.match_stats (home, away, home_score, away_score, date, venue) FROM stdin;
Bali United Basketball	Amartha Hangtuah	84	72	2024-01-13	GOR Purna Krida
Pacific Caesar Surabaya	Rajawali Medan	79	85	2024-01-13	GOR Pacific Caesar
Satria Muda Pertamina	Borneo Hornbills	94	72	2024-01-13	Tennis Indoor Senayan
Prawira Harum Bandung	Pelita Jaya Jakarta	66	76	2024-01-13	C-Tra Prawira Arena
Bali United Basketball	Bima Perkasa Jogja	80	50	2024-01-14	GOR Purna Krida
Pacific Caesar Surabaya	Tangerang Hawks	67	81	2024-01-14	GOR Pacific Caesar
Satria Muda Pertamina	Dewa United Banten	92	101	2024-01-14	Tennis Indoor Senayan
Prawira Harum Bandung	Kesatria Bengawan Solo	64	62	2024-01-14	C-Tra Prawira Arena
Satya Wacana Saints Salatiga	Rajawali Medan	66	78	2024-01-19	GOR Knight Stadium
Pelita Jaya Jakarta	Tangerang Hawks	99	89	2024-01-19	Tennis Indoor Senayan
Bima Perkasa Jogja	Dewa United Banten	39	86	2024-01-20	Among Rogo Sports Hall
RANS Simba Bogor	Bali United Basketball	92	68	2024-01-20	Gymnasium Sekolah Vokasi IPB
Borneo Hornbills	Tangerang Hawks	74	79	2024-01-20	GOR Laga Tangkas
Pelita Jaya Jakarta	Satria Muda Pertamina	77	100	2024-01-20	Tennis Indoor Senayan
Satya Wacana Saints Salatiga	Amartha Hangtuah	61	70	2024-01-21	GOR Knight Stadium
RANS Simba Bogor	Satria Muda Pertamina	86	81	2024-01-21	Gymnasium Sekolah Vokasi IPB
Borneo Hornbills	Bali United Basketball	64	79	2024-01-21	GOR Laga Tangkas
Bima Perkasa Jogja	Rajawali Medan	52	76	2024-01-21	Among Rogo Sports Hall
Dewa United Banten	Tangerang Hawks	101	83	2024-01-26	Dewa United Arena
Amartha Hangtuah	Pacific Caesar Surabaya	80	65	2024-01-26	GOR Universitas Negeri Jakarta (UNJ)
Kesatria Bengawan Solo	Rajawali Medan	78	45	2024-01-27	Sritex Arena
Satya Wacana Saints Salatiga	Pelita Jaya Jakarta	63	82	2024-01-27	GOR Knight Stadium
Borneo Hornbills	RANS Simba Bogor	60	80	2024-01-27	GOR Laga Tangkas
Amartha Hangtuah	Prawira Harum Bandung	66	73	2024-01-27	GOR Universitas Negeri Jakarta (UNJ)
Pacific Caesar Surabaya	Bima Perkasa Jogja	90	93	2024-01-28	GOR Pacific Caesar
Kesatria Bengawan Solo	Satya Wacana Saints Salatiga	64	55	2024-01-28	Sritex Arena
Tangerang Hawks	RANS Simba Bogor	82	83	2024-01-28	Indoor Stadium Sport Center
Dewa United Banten	Prawira Harum Bandung	84	81	2024-01-28	Dewa United Arena
Pelita Jaya Jakarta	Pacific Caesar Surabaya	107	89	2024-01-31	Tennis Indoor Senayan
Rajawali Medan	Amartha Hangtuah	81	77	2024-02-02	GOR Universitas Medan
Borneo Hornbills	Pacific Caesar Surabaya	86	92	2024-02-02	GOR Laga Tangkas
Bali United Basketball	Prawira Harum Bandung	77	66	2024-02-03	GOR Purna Krida
Bima Perkasa Jogja	Satria Muda Pertamina	80	85	2024-02-03	Among Rogo Sports Hall
Kesatria Bengawan Solo	RANS Simba Bogor	78	72	2024-02-04	Sritex Arena
Rajawali Medan	Dewa United Banten	71	86	2024-02-04	GOR Universitas Medan
Satya Wacana Saints Salatiga	Borneo Hornbills	66	64	2024-02-04	GOR Knight Stadium
Satya Wacana Saints Salatiga	Tangerang Hawks	52	70	2024-03-01	GOR Knight Stadium
Satria Muda Pertamina	Bima Perkasa Jogja	86	57	2024-03-01	The BritAma Arena
Prawira Harum Bandung	Borneo Hornbills	82	78	2024-03-02	C-Tra Prawira Arena
Rajawali Medan	Pelita Jaya Jakarta	75	94	2024-03-02	GOR Universitas Medan
Satya Wacana Saints Salatiga	Kesatria Bengawan Solo	78	93	2024-03-02	GOR Knight Stadium
Amartha Hangtuah	Bima Perkasa Jogja	77	61	2024-03-02	GOR Universitas Negeri Jakarta (UNJ)
Prawira Harum Bandung	Pacific Caesar Surabaya	79	63	2024-03-03	C-Tra Prawira Arena
Rajawali Medan	RANS Simba Bogor	80	78	2024-03-03	GOR Universitas Medan
Satria Muda Pertamina	Bali United Basketball	101	88	2024-03-03	The BritAma Arena
Amartha Hangtuah	Dewa United Banten	78	86	2024-03-03	GOR Universitas Negeri Jakarta (UNJ)
Dewa United Banten	Pacific Caesar Surabaya	130	95	2024-03-06	Dewa United Arena
Tangerang Hawks	Bali United Basketball	70	76	2024-03-06	Indoor Stadium Sport Center
Pelita Jaya Jakarta	Satya Wacana Saints Salatiga	89	59	2024-03-08	GOR Universitas Negeri Jakarta (UNJ)
Tangerang Hawks	Pacific Caesar Surabaya	102	71	2024-03-08	Indoor Stadium Sport Center
Satria Muda Pertamina	Rajawali Medan	104	79	2024-03-09	The BritAma Arena
Bima Perkasa Jogja	Kesatria Bengawan Solo	66	91	2024-03-09	Among Rogo Sports Hall
RANS Simba Bogor	Amartha Hangtuah	91	84	2024-03-09	Gymnasium Sekolah Vokasi IPB
Pelita Jaya Jakarta	Bali United Basketball	92	54	2024-03-09	GOR Universitas Negeri Jakarta (UNJ)
Satria Muda Pertamina	Prawira Harum Bandung	68	76	2024-03-10	The BritAma Arena
Bima Perkasa Jogja	Borneo Hornbills	76	86	2024-03-10	Among Rogo Sports Hall
Dewa United Banten	Satya Wacana Saints Salatiga	126	85	2024-03-10	Dewa United Arena
RANS Simba Bogor	Rajawali Medan	68	84	2024-03-10	Gymnasium Sekolah Vokasi IPB
Kesatria Bengawan Solo	Borneo Hornbills	90	86	2024-03-15	Sritex Arena
Pacific Caesar Surabaya	Satria Muda Pertamina	87	107	2024-03-15	GOR Pacific Caesar
Bali United Basketball	Satya Wacana Saints Salatiga	69	67	2024-03-16	GOR Purna Krida
Kesatria Bengawan Solo	Bima Perkasa Jogja	94	66	2024-03-16	Sritex Arena
Bali United Basketball	Satria Muda Pertamina	75	85	2024-03-17	GOR Purna Krida
Pacific Caesar Surabaya	Borneo Hornbills	70	82	2024-03-17	GOR Pacific Caesar
RANS Simba Bogor	Bima Perkasa Jogja	92	80	2024-03-22	Gymnasium Sekolah Vokasi IPB
Rajawali Medan	Bali United Basketball	66	82	2024-03-22	GOR Universitas Medan
Tangerang Hawks	Amartha Hangtuah	75	85	2024-03-23	Indoor Stadium Sport Center
RANS Simba Bogor	Pelita Jaya Jakarta	67	85	2024-03-23	Gymnasium Sekolah Vokasi IPB
Rajawali Medan	Satya Wacana Saints Salatiga	56	65	2024-03-24	GOR Universitas Medan
Tangerang Hawks	Borneo Hornbills	80	89	2024-03-24	Indoor Stadium Sport Center
Bima Perkasa Jogja	Tangerang Hawks	78	75	2024-04-17	Among Rogo Sports Hall
Borneo Hornbills	Rajawali Medan	100	86	2024-04-17	GOR Laga Tangkas
Bima Perkasa Jogja	Pelita Jaya Jakarta	67	101	2024-04-19	Among Rogo Sports Hall
Prawira Harum Bandung	Bali United Basketball	91	70	2024-04-19	C-Tra Prawira Arena
Amartha Hangtuah	Kesatria Bengawan Solo	84	91	2024-04-20	GOR Universitas Negeri Jakarta (UNJ)
Dewa United Banten	Rajawali Medan	98	73	2024-04-20	Dewa United Arena
Satria Muda Pertamina	Satya Wacana Saints Salatiga	68	84	2024-04-20	The BritAma Arena
Prawira Harum Bandung	RANS Simba Bogor	79	82	2024-04-20	C-Tra Prawira Arena
Borneo Hornbills	Pelita Jaya Jakarta	80	98	2024-04-21	GOR Laga Tangkas
Dewa United Banten	Bali United Basketball	113	81	2024-04-21	Dewa United Arena
Amartha Hangtuah	Satya Wacana Saints Salatiga	90	81	2024-04-21	GOR Universitas Negeri Jakarta (UNJ)
Satria Muda Pertamina	Kesatria Bengawan Solo	66	69	2024-04-21	The BritAma Arena
Pacific Caesar Surabaya	Dewa United Banten	75	95	2024-05-01	GOR Pacific Caesar
Pelita Jaya Jakarta	Rajawali Medan	82	57	2024-05-01	GOR Universitas Negeri Jakarta (UNJ)
Kesatria Bengawan Solo	Amartha Hangtuah	77	74	2024-05-03	Sritex Arena
Pelita Jaya Jakarta	Borneo Hornbills	79	72	2024-05-03	GOR Universitas Negeri Jakarta (UNJ)
Satya Wacana Saints Salatiga	Dewa United Banten	57	92	2024-05-04	GOR Knight Stadium
Tangerang Hawks	Rajawali Medan	75	85	2024-05-04	Indoor Stadium Sport Center
Kesatria Bengawan Solo	Bali United Basketball	88	79	2024-05-04	Sritex Arena
RANS Simba Bogor	Prawira Harum Bandung	74	95	2024-05-04	Gymnasium Sekolah Vokasi IPB
Satya Wacana Saints Salatiga	Bima Perkasa Jogja	78	57	2024-05-05	GOR Knight Stadium
Tangerang Hawks	Satria Muda Pertamina	84	95	2024-05-05	Indoor Stadium Sport Center
Pacific Caesar Surabaya	Amartha Hangtuah	76	78	2024-05-05	GOR Pacific Caesar
RANS Simba Bogor	Borneo Hornbills	88	95	2024-05-05	Gymnasium Sekolah Vokasi IPB
Rajawali Medan	Satria Muda Pertamina	89	88	2024-05-10	GOR Universitas Medan
Amartha Hangtuah	RANS Simba Bogor	75	83	2024-05-10	GOR Universitas Negeri Jakarta (UNJ)
Prawira Harum Bandung	Tangerang Hawks	76	71	2024-05-11	C-Tra Prawira Arena
Bali United Basketball	Borneo Hornbills	83	87	2024-05-11	GOR Purna Krida
Dewa United Banten	Pelita Jaya Jakarta	98	103	2024-05-11	Dewa United Arena
Rajawali Medan	Kesatria Bengawan Solo	73	92	2024-05-11	GOR Universitas Medan
Prawira Harum Bandung	Bima Perkasa Jogja	85	58	2024-05-12	C-Tra Prawira Arena
Bali United Basketball	Pacific Caesar Surabaya	86	73	2024-05-12	GOR Purna Krida
Amartha Hangtuah	Pelita Jaya Jakarta	83	90	2024-05-12	GOR Universitas Negeri Jakarta (UNJ)
Dewa United Banten	RANS Simba Bogor	100	91	2024-05-12	Dewa United Arena
Borneo Hornbills	Satya Wacana Saints Salatiga	89	93	2024-05-15	GOR Laga Tangkas
Bima Perkasa Jogja	Pacific Caesar Surabaya	83	78	2024-05-15	Among Rogo Sports Hall
Borneo Hornbills	Dewa United Banten	93	101	2024-05-17	GOR Laga Tangkas
Bima Perkasa Jogja	Prawira Harum Bandung	64	85	2024-05-17	Among Rogo Sports Hall
Kesatria Bengawan Solo	Satria Muda Pertamina	94	83	2024-05-18	Sritex Arena
Pelita Jaya Jakarta	Amartha Hangtuah	93	84	2024-05-18	Tennis Indoor Senayan
Bali United Basketball	Tangerang Hawks	78	74	2024-05-18	GOR Purna Krida
RANS Simba Bogor	Satya Wacana Saints Salatiga	97	81	2024-05-18	Gymnasium Sekolah Vokasi IPB
Kesatria Bengawan Solo	Pacific Caesar Surabaya	90	81	2024-05-19	Sritex Arena
Pelita Jaya Jakarta	Prawira Harum Bandung	74	77	2024-05-19	Tennis Indoor Senayan
Bali United Basketball	Rajawali Medan	93	76	2024-05-19	GOR Purna Krida
RANS Simba Bogor	Dewa United Banten	88	101	2024-05-19	Gymnasium Sekolah Vokasi IPB
Pacific Caesar Surabaya	Kesatria Bengawan Solo	74	82	2024-05-24	GOR Pacific Caesar
Satria Muda Pertamina	Amartha Hangtuah	89	73	2024-05-24	The BritAma Arena
Rajawali Medan	Prawira Harum Bandung	65	95	2024-05-25	GOR Universitas Medan
Dewa United Banten	Borneo Hornbills	93	70	2024-05-25	Dewa United Arena
Tangerang Hawks	Pelita Jaya Jakarta	68	72	2024-05-25	Indoor Stadium Sport Center
Satria Muda Pertamina	RANS Simba Bogor	96	67	2024-05-25	The BritAma Arena
Rajawali Medan	Bima Perkasa Jogja	105	92	2024-05-26	GOR Universitas Medan
Dewa United Banten	Amartha Hangtuah	129	91	2024-05-26	Dewa United Arena
Pacific Caesar Surabaya	Bali United Basketball	83	95	2024-05-26	GOR Pacific Caesar
Tangerang Hawks	Satya Wacana Saints Salatiga	83	74	2024-05-26	Indoor Stadium Sport Center
Bali United Basketball	Kesatria Bengawan Solo	88	90	2024-05-29	GOR Purna Krida
Satya Wacana Saints Salatiga	RANS Simba Bogor	51	75	2024-05-29	GOR Knight Stadium
Amartha Hangtuah	Satria Muda Pertamina	86	107	2024-05-31	GOR Universitas Negeri Jakarta (UNJ)
Satya Wacana Saints Salatiga	Pacific Caesar Surabaya	67	77	2024-05-31	GOR Knight Stadium
Bali United Basketball	RANS Simba Bogor	81	88	2024-06-01	GOR Purna Krida
Pelita Jaya Jakarta	Bima Perkasa Jogja	91	64	2024-06-01	GOR Universitas Negeri Jakarta (UNJ)
Borneo Hornbills	Satria Muda Pertamina	84	94	2024-06-01	GOR Laga Tangkas
Prawira Harum Bandung	Rajawali Medan	81	66	2024-06-01	C-Tra Prawira Arena
Amartha Hangtuah	Tangerang Hawks	82	70	2024-06-02	GOR Universitas Negeri Jakarta (UNJ)
Pelita Jaya Jakarta	Kesatria Bengawan Solo	88	69	2024-06-02	GOR Universitas Negeri Jakarta (UNJ)
Borneo Hornbills	Bima Perkasa Jogja	82	76	2024-06-02	GOR Laga Tangkas
Prawira Harum Bandung	Dewa United Banten	99	94	2024-06-02	C-Tra Prawira Arena
Dewa United Banten	Kesatria Bengawan Solo	102	111	2024-06-07	Dewa United Arena
Satria Muda Pertamina	Pacific Caesar Surabaya	93	45	2024-06-08	The BritAma Arena
RANS Simba Bogor	Tangerang Hawks	95	84	2024-06-08	Gymnasium Sekolah Vokasi IPB
Dewa United Banten	Bima Perkasa Jogja	96	77	2024-06-08	Dewa United Arena
Satria Muda Pertamina	Tangerang Hawks	102	71	2024-06-09	The BritAma Arena
RANS Simba Bogor	Kesatria Bengawan Solo	82	101	2024-06-09	Gymnasium Sekolah Vokasi IPB
Borneo Hornbills	Amartha Hangtuah	90	81	2024-06-09	GOR Laga Tangkas
Amartha Hangtuah	Rajawali Medan	100	81	2024-06-15	GOR Universitas Negeri Jakarta (UNJ)
Satya Wacana Saints Salatiga	Bali United Basketball	83	102	2024-06-15	GOR Knight Stadium
Tangerang Hawks	Bima Perkasa Jogja	70	69	2024-06-15	Indoor Stadium Sport Center
Amartha Hangtuah	Borneo Hornbills	75	103	2024-06-16	GOR Universitas Negeri Jakarta (UNJ)
Satya Wacana Saints Salatiga	Satria Muda Pertamina	68	112	2024-06-16	GOR Knight Stadium
Pacific Caesar Surabaya	RANS Simba Bogor	95	105	2024-06-16	GOR Pacific Caesar
Kesatria Bengawan Solo	Dewa United Banten	85	116	2024-06-16	Sritex Arena
Rajawali Medan	Borneo Hornbills	88	91	2024-06-19	GOR Universitas Medan
Tangerang Hawks	Dewa United Banten	67	97	2024-06-19	Indoor Stadium Sport Center
Rajawali Medan	Pacific Caesar Surabaya	93	87	2024-06-21	GOR Universitas Medan
Tangerang Hawks	Kesatria Bengawan Solo	93	101	2024-06-21	Indoor Stadium Sport Center
Amartha Hangtuah	Bali United Basketball	84	82	2024-06-22	GOR Universitas Negeri Jakarta (UNJ)
Pelita Jaya Jakarta	Dewa United Banten	70	93	2024-06-22	The BritAma Arena
Prawira Harum Bandung	Satya Wacana Saints Salatiga	78	61	2024-06-22	C-Tra Prawira Arena
Borneo Hornbills	Kesatria Bengawan Solo	93	74	2024-06-23	GOR Laga Tangkas
Pelita Jaya Jakarta	RANS Simba Bogor	97	102	2024-06-23	The BritAma Arena
Prawira Harum Bandung	Satria Muda Pertamina	97	98	2024-06-23	C-Tra Prawira Arena
Tangerang Hawks	Prawira Harum Bandung	63	78	2024-06-26	Indoor Stadium Sport Center
Kesatria Bengawan Solo	Prawira Harum Bandung	72	88	2024-06-28	Sritex Arena
Pacific Caesar Surabaya	Pelita Jaya Jakarta	65	98	2024-06-28	GOR Pacific Caesar
Bima Perkasa Jogja	RANS Simba Bogor	85	89	2024-06-29	Among Rogo Sports Hall
Bali United Basketball	Dewa United Banten	79	93	2024-06-29	GOR Purna Krida
Satya Wacana Saints Salatiga	Prawira Harum Bandung	78	100	2024-06-30	GOR Knight Stadium
Bima Perkasa Jogja	Amartha Hangtuah	93	84	2024-06-30	Among Rogo Sports Hall
Bali United Basketball	Pelita Jaya Jakarta	75	89	2024-06-30	GOR Purna Krida
Kesatria Bengawan Solo	Tangerang Hawks	95	98	2024-07-03	Sritex Arena
Pacific Caesar Surabaya	Prawira Harum Bandung	65	87	2024-07-03	GOR Pacific Caesar
Pacific Caesar Surabaya	Satya Wacana Saints Salatiga	101	95	2024-07-05	GOR Pacific Caesar
Kesatria Bengawan Solo	Pelita Jaya Jakarta	75	94	2024-07-05	Sritex Arena
Bima Perkasa Jogja	Bali United Basketball	68	85	2024-07-06	Among Rogo Sports Hall
Borneo Hornbills	Prawira Harum Bandung	92	99	2024-07-06	GOR Laga Tangkas
Dewa United Banten	Satria Muda Pertamina	75	90	2024-07-06	Dewa United Arena
Rajawali Medan	Tangerang Hawks	88	95	2024-07-06	GOR Universitas Medan
Bima Perkasa Jogja	Satya Wacana Saints Salatiga	79	99	2024-07-07	Among Rogo Sports Hall
Prawira Harum Bandung	Amartha Hangtuah	91	83	2024-07-07	C-Tra Prawira Arena
RANS Simba Bogor	Pacific Caesar Surabaya	79	76	2024-07-07	Gymnasium Sekolah Vokasi IPB
Satria Muda Pertamina	Pelita Jaya Jakarta	73	72	2024-07-07	The BritAma Arena
\.


--
-- Data for Name: official; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.official (name, roles, email, team_name) FROM stdin;
Gading Ramadhan Joedo	Presiden Klub (Owner)	\N	Amartha Hangtuah
?Eddi Danusaputro	Wakil Presiden Klub	\N	Amartha Hangtuah
Andi Taufan Garuda Putra	Direktur Utama	\N	Amartha Hangtuah
Ramdhan Anggakaradibrata	Direktur	\N	Amartha Hangtuah
Musab Mochammad	Komisaris	\N	Amartha Hangtuah
Zulfikar Pujiadi	Penasehat Tim	\N	Amartha Hangtuah
Ardi Darmawan Moeljoto	General Manager	\N	Amartha Hangtuah
Fadly Rhamdani	Manager operasional	\N	Amartha Hangtuah
Raden Yohanes Kristian	Pelatih Kepal	\N	Amartha Hangtuah
Muhammad Fajar	Asisten Pelatih	\N	Amartha Hangtuah
Juan Prince Enid Zebua	Ofisial	\N	Amartha Hangtuah
Philmon Tanuri	Presiden Klub (Owner)	\N	Bali United Basketball
Yabes Tanuri	Komisaris	\N	Bali United Basketball
Putri Sudali	Direktur Utama	\N	Bali United Basketball
Selly Balerina?	General Affair	\N	Bali United Basketball
Kadek Yuli?	General Affair	\N	Bali United Basketball
Sigit Sugiantoro	General Manager	\N	Bali United Basketball
Anthony Garbelotto	Pelatih Kepala	\N	Bali United Basketball
I Gusti Rusta Wijaya	Asisten Pelatih	\N	Bali United Basketball
I Gusti Ngurah Teguh	Asisten Pelatih	\N	Bali United Basketball
dr. Edy Wibowo, SP.M., M.PH	Owner	\N	Bima Perkasa Jogja
Raden Mas Gusthilantika Marrel Suryokusumo	Presiden Klub	\N	Bima Perkasa Jogja
Mikael Radhite Badra Kumala	Wakil Presiden Klub	\N	Bima Perkasa Jogja
Johannes Berchmans Heroe Susanto	Direktur	\N	Bima Perkasa Jogja
Christya Putri Adinda	General Affair	\N	Bima Perkasa Jogja
Fadhil Driya Warastra	Asisten Manager	\N	Bima Perkasa Jogja
Fika Nurazam Wirastuti	Manager Tim	\N	Bima Perkasa Jogja
Pregrad Lukic	Pelatih Kepala	\N	Bima Perkasa Jogja
Oleh	Asisten Pelatih	\N	Bima Perkasa Jogja
Muhammad Feldy Syafaat	Strength & Conditioning	\N	Bima Perkasa Jogja
Yanuar Dwi Priasmoro	Performance Trainer	\N	Bima Perkasa Jogja
Muhammad Qorib	Fisioterapi	\N	Bima Perkasa Jogja
Muh. Fiqyh Zulfikar	Utility	\N	Bima Perkasa Jogja
Swadesta Arya Wisesa	Media & Komunikasi Manager	\N	Bima Perkasa Jogja
Ica Qonita	Spesialis Sosial Media	\N	Bima Perkasa Jogja
Lutfi Hidayat	Videografer	\N	Bima Perkasa Jogja
Safril Aliyatno	Fotografer	\N	Bima Perkasa Jogja
Leo Goutama	Presiden Klub (Owner)	\N	Borneo Hornbills
Isenta Hioe	Komisaris	\N	Borneo Hornbills
Andromeda Manuputty	General Manager	\N	Borneo Hornbills
Ridwan Eka Saputra	Asisten Manager	\N	Borneo Hornbills
Ismael	Pelatih Kepala	\N	Borneo Hornbills
Rimbun Maruli Tua Sidauruk	Asisten Pelatih	\N	Borneo Hornbills
Rendy Putrama	Asisten Pelatih	\N	Borneo Hornbills
Yuditya Perdana	Strength & Conditioning	\N	Borneo Hornbills
Erfan Leo Ricardo Nainggolan	Fisioterapi	\N	Borneo Hornbills
Medianto Arikusprastyo	Utility	\N	Borneo Hornbills
Ahmad Junaedi	Analis Video	\N	Borneo Hornbills
Blasius Jaya SAbda Kusuma	Masseur	\N	Borneo Hornbills
Agus	Masseur	\N	Borneo Hornbills
Danny Mulya Kusuma?	Analis Statistik	\N	Borneo Hornbills
Ronaldo	Fotografer	\N	Borneo Hornbills
Tommy Hermawan Lo	Founder / Presiden Klu	\N	Dewa United Banten
Lexyndo Hakim	Komisaris Klu	\N	Dewa United Banten
Michael Oliver Wellerz	Direktur Utama / CE	\N	Dewa United Banten
Wijaya Saputra	General Manager	\N	Dewa United Banten
Zaki Iskandar	Manager	\N	Dewa United Banten
Pablo Favarel	Pelatih Kepal	\N	Dewa United Banten
Antonius Ferry Rinaldo	Asisten Pelatih	\N	Dewa United Banten
Joel Pose	Asisten Pelatih	\N	Dewa United Banten
??Maddis Abieza	Asisten Pelatih	\N	Dewa United Banten
Martin Galdeano	Pelatih Fisik	\N	Dewa United Banten
Muhammad Fajeriannor	Fisioterapi	\N	Dewa United Banten
? Nabil?	Fisioterapi	\N	Dewa United Banten
Yakup Hasibuan	Presiden Klub	\N	Kesatria Bengawan Solo
Todotua Pasaribu	Founder	\N	Kesatria Bengawan Solo
Andrian Jahjamalik	Founder	\N	Kesatria Bengawan Solo
Andra R. Pasaribu	Commisioner	\N	Kesatria Bengawan Solo
Alvin Reynaldi Setiawan	Vice President of Bussines	\N	Kesatria Bengawan Solo
Bagus Andriaan John	Vice President of Operational	\N	Kesatria Bengawan Solo
John Nawawi	Vice President of Players	\N	Kesatria Bengawan Solo
Helmi Bostam	General Manager	\N	Kesatria Bengawan Solo
Arfinsa Gunawan	Team Managers	\N	Kesatria Bengawan Solo
Fachrudin Siregar	Game Director	\N	Kesatria Bengawan Solo
Respati Ardy	Marketing, Sales & Partnership	\N	Kesatria Bengawan Solo
Sofyan Aji Prakosa	Media Manager	\N	Kesatria Bengawan Solo
M. Fachrie Hadi	Utility	\N	Kesatria Bengawan Solo
Bambang Susanto	Presiden Klub (Owner)	\N	Pacific Caesar Surabaya
The Irsan Pribadi Susanto	Direktur Utama	\N	Pacific Caesar Surabaya
Jossi Susanto	Komisaris Klub	\N	Pacific Caesar Surabaya
Soegiono Hartono?	General Manager	\N	Pacific Caesar Surabaya
Dean Julyanto	Asisten Manage	\N	Pacific Caesar Surabaya
Agus Wijaksono	Penasehat Tim	\N	Pacific Caesar Surabaya
Meliani Susanto	General Affair	\N	Pacific Caesar Surabaya
Reiner Anggakara	General Affair	\N	Pacific Caesar Surabaya
Diky Freedo Pratama	Pelatih Kepala	\N	Pacific Caesar Surabaya
Muhammad Usdi Abdullah	Asisten Pelatih	\N	Pacific Caesar Surabaya
Ramadhani Fikri Ananta	Pelatih Fisik	\N	Pacific Caesar Surabaya
Andiko Ardi Purnomo	Presiden Klu	\N	Pelita Jaya Jakarta
Fictor Gideon Roring	Komisaris Klu	\N	Pelita Jaya Jakarta
Anindhita Anestya Bakrie	Komisaris Klu	\N	Pelita Jaya Jakarta
Adhi Pratama Prasetyo	General Manage	\N	Pelita Jaya Jakarta
Nugroho Budi Cahyono	Manajer Facilit	\N	Pelita Jaya Jakarta
Cyrus Harsaningtyas	Manager Keuanga	\N	Pelita Jaya Jakarta
Radityo Yunus Utomo	General Affai	\N	Pelita Jaya Jakarta
Rob William Beveridge	Pelati	\N	Pelita Jaya Jakarta
Johannis Winar	Asisten Pelati	\N	Pelita Jaya Jakarta
Koko Heru Setyo Nugroho	Asisten Pelati	\N	Pelita Jaya Jakarta
Hermanto	Asisten Pelati	\N	Pelita Jaya Jakarta
Agus Ryanto	Utilit	\N	Pelita Jaya Jakarta
Fahmi Al Khadry	Fisioterap	\N	Pelita Jaya Jakarta
Raul Jr Romero	Ofisia	\N	Pelita Jaya Jakarta
Luis Apricio Villa	Ofisial	\N	Pelita Jaya Jakarta
Tyler Arturo Farias	Ofisial	\N	Pelita Jaya Jakarta
Yunaidy Wu	Komisaris Klu	\N	Prawira Harum Bandung
Teddy Tjahjono	Direktur Utama	\N	Prawira Harum Bandung
Andri Syarel Octreanes	General Manage	\N	Prawira Harum Bandung
Rangga Ilhamsany	General Affair	\N	Prawira Harum Bandung
David Reynard Singleton	Pelati	\N	Prawira Harum Bandung
Andri Malay	Asisten Pelati	\N	Prawira Harum Bandung
Nico Donnda Fitzgerald	Asisten Pelati	\N	Prawira Harum Bandung
Basir Ali Ismail	Strength?& Condition Coach	\N	Prawira Harum Bandung
Brandon Andesta	Physiotheraphist	\N	Prawira Harum Bandung
Ridwan Mintarjaya	Ofisia	\N	Prawira Harum Bandung
Wisnu Catur	Ofisia	\N	Prawira Harum Bandung
Erwin	Direktur Utama	\N	Rajawali Medan
A Kiat	Manager	\N	Rajawali Medan
RAOUL MIGUEL HADINOTO?	Head Coach	\N	Rajawali Medan
IWAN MURRYAWAN?	Ass Coach	\N	Rajawali Medan
A.MOOSA PERMADI	Ass Coach	\N	Rajawali Medan
ZUFAR ALFEN?	Massuer	\N	Rajawali Medan
ALBERTUS GRACIA	Physio	\N	Rajawali Medan
NOSSANANDI K. S.R	\N	\N	Rajawali Medan
SANTOSO?	\N	\N	Rajawali Medan
GUNTUR JIWOKUSUMO	Utility	\N	Rajawali Medan
EDY HARTONO	Operasional Manager	\N	Rajawali Medan
Raffi Farid Ahmad	Komisaris Utama	\N	RANS Simba Bogor
Norman Edward Sebastian	Direktur Klub	\N	RANS Simba Bogor
Angkling Gading Gumilang	Presiden Klub (Owner)	\N	RANS Simba Bogor
Ardima Rama Putra?	Wakil Presiden Klub	\N	RANS Simba Bogor
Anthony Gunawan	General Manager	\N	RANS Simba Bogor
Andrey Rido Mahardika	Manager Tim	\N	RANS Simba Bogor
Rizky Julian Rifai	Media Sosial, Merchandising, & Event Manager	\N	RANS Simba Bogor
Thomas Petrus Godefrida Jozef Roijakkers	Pelatih Kepala	\N	RANS Simba Bogor
Wahyu Widayat Jati	Technical Coordinator	\N	RANS Simba Bogor
Yudhi Mardiansyah	Asisten Pelatih	\N	RANS Simba Bogor
Agus Pamungkas	Asisten Pelatih	\N	RANS Simba Bogor
Wendha Wijaya	Asisten Pelatih	\N	RANS Simba Bogor
Tri Prasetyo Utomo	Strength & Conditioning	\N	RANS Simba Bogor
Rafi Aditya Sasono	Fisioterapi	\N	RANS Simba Bogor
Muslihudin	Utility	\N	RANS Simba Bogor
Firdaus Tri Pamungkas	Utility	\N	RANS Simba Bogor
Muhammad Fauzan Aziz	Masseur	\N	RANS Simba Bogor
Dika Kawengian	Fotografer	\N	RANS Simba Bogor
Awan Yosi	Videografer	\N	RANS Simba Bogor
Nur Asrifah Rahmah	Sosial Media Admin	\N	RANS Simba Bogor
Ryan Ardiansyah Achmad	Desain Grafis	\N	RANS Simba Bogor
dr. Febry Siswanto	Tim Dokter	\N	RANS Simba Bogor
Muhammad Ibrahim	Presiden Klub	\N	Satria Muda Pertamina
Rony Gunawan	Vice Presiden Klu	\N	Satria Muda Pertamina
Riska Natalia Dewi	Managing Directo	\N	Satria Muda Pertamina
Wan Amran	Penasehat Ti	\N	Satria Muda Pertamina
Cecilia Dwi Maya Siswari	General Affai	\N	Satria Muda Pertamina
Youbel Sondakh	Pelatih Kepal	\N	Satria Muda Pertamina
Cesar Canara Perez	Asisten Pelatih	\N	Satria Muda Pertamina
Moh. Tohirno	Masseur	\N	Satria Muda Pertamina
Martin Setyawan	General Manajer	\N	Satya Wacana Saints Salatiga
Dodik Tri Purnomo	Assisten Manaje	\N	Satya Wacana Saints Salatiga
Jerry Lolowang	Pelati	\N	Satya Wacana Saints Salatiga
Revan Jonathan	Assisten Pelati	\N	Satya Wacana Saints Salatiga
Rahmad Yuli Ardiyanto	Analis Dat	\N	Satya Wacana Saints Salatiga
Dimas Zena Wijaya	Phystiotherap	\N	Satya Wacana Saints Salatiga
Benny Malaila	Utilit	\N	Satya Wacana Saints Salatiga
Mustofa Ramadhan	Utilit	\N	Satya Wacana Saints Salatiga
Ahmat Syukron	Utility	\N	Satya Wacana Saints Salatiga
?Ahmed Rully Zulfikar	Komisaris Utama (Owner)	\N	Tangerang Hawks
Husin Arief	Komisari	\N	Tangerang Hawks
Iskandarsyah Rama Datau	CEO/Presiden Klu	\N	Tangerang Hawks
Evelyn Cathy	Direktur Operasiona	\N	Tangerang Hawks
Tikky Suwantikno	Assisten Direktur	\N	Tangerang Hawks
Indra Budianto	Manager	\N	Tangerang Hawks
Antonius Joko Endratmo	Pelatih Kepal	\N	Tangerang Hawks
F.W. Daniel Poetiray	Assisten Pelatih	\N	Tangerang Hawks
Tri Hartanto	Assisten Pelati	\N	Tangerang Hawks
Arnata Anggara Putra	Physiotheraphist	\N	Tangerang Hawks
Dwi Prasetiyono	Pelatih Fisik	\N	Tangerang Hawks
A. Mundziri	Utilit	\N	Tangerang Hawks
Muhammad Rais Almuharie	Utilit	\N	Tangerang Hawks
\.


--
-- Data for Name: official_phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.official_phone (name, phone_number) FROM stdin;
Gading Ramadhan Joedo	1
?Eddi Danusaputro	1
Andi Taufan Garuda Putra	1
Ramdhan Anggakaradibrata	1
Musab Mochammad	1
Zulfikar Pujiadi	1
Ardi Darmawan Moeljoto	1
Fadly Rhamdani	1
Raden Yohanes Kristian	1
Muhammad Fajar	1
Juan Prince Enid Zebua	1
Philmon Tanuri	1
Yabes Tanuri	1
Putri Sudali	1
Selly Balerina?	1
Kadek Yuli?	1
Sigit Sugiantoro	1
Anthony Garbelotto	1
I Gusti Rusta Wijaya	1
I Gusti Ngurah Teguh	1
dr. Edy Wibowo, SP.M., M.PH	1
Raden Mas Gusthilantika Marrel Suryokusumo	1
Mikael Radhite Badra Kumala	1
Johannes Berchmans Heroe Susanto	1
Christya Putri Adinda	1
Fadhil Driya Warastra	1
Fika Nurazam Wirastuti	1
Pregrad Lukic	1
Oleh	1
Muhammad Feldy Syafaat	1
Yanuar Dwi Priasmoro	1
Muhammad Qorib	1
Muh. Fiqyh Zulfikar	1
Swadesta Arya Wisesa	1
Ica Qonita	1
Lutfi Hidayat	1
Safril Aliyatno	1
Leo Goutama	1
Isenta Hioe	1
Andromeda Manuputty	1
Ridwan Eka Saputra	1
Ismael	1
Rimbun Maruli Tua Sidauruk	1
Rendy Putrama	1
Yuditya Perdana	1
Erfan Leo Ricardo Nainggolan	1
Medianto Arikusprastyo	1
Ahmad Junaedi	1
Blasius Jaya SAbda Kusuma	1
Agus	1
Danny Mulya Kusuma?	1
Ronaldo	1
Tommy Hermawan Lo	1
Lexyndo Hakim	1
Michael Oliver Wellerz	1
Wijaya Saputra	1
Zaki Iskandar	1
Pablo Favarel	1
Antonius Ferry Rinaldo	1
Joel Pose	1
??Maddis Abieza	1
Martin Galdeano	1
Muhammad Fajeriannor	1
? Nabil?	1
Yakup Hasibuan	1
Todotua Pasaribu	1
Andrian Jahjamalik	1
Andra R. Pasaribu	1
Alvin Reynaldi Setiawan	1
Bagus Andriaan John	1
John Nawawi	1
Helmi Bostam	1
Arfinsa Gunawan	1
Fachrudin Siregar	1
Respati Ardy	1
Sofyan Aji Prakosa	1
M. Fachrie Hadi	1
Bambang Susanto	1
The Irsan Pribadi Susanto	1
Jossi Susanto	1
Soegiono Hartono?	1
Dean Julyanto	1
Agus Wijaksono	1
Meliani Susanto	1
Reiner Anggakara	1
Diky Freedo Pratama	1
Muhammad Usdi Abdullah	1
Ramadhani Fikri Ananta	1
Andiko Ardi Purnomo	1
Fictor Gideon Roring	1
Anindhita Anestya Bakrie	1
Adhi Pratama Prasetyo	1
Nugroho Budi Cahyono	1
Cyrus Harsaningtyas	1
Radityo Yunus Utomo	1
Rob William Beveridge	1
Johannis Winar	1
Koko Heru Setyo Nugroho	1
Hermanto	1
Agus Ryanto	1
Fahmi Al Khadry	1
Raul Jr Romero	1
Luis Apricio Villa	1
Tyler Arturo Farias	1
Yunaidy Wu	1
Teddy Tjahjono	1
Andri Syarel Octreanes	1
Rangga Ilhamsany	1
David Reynard Singleton	1
Andri Malay	1
Nico Donnda Fitzgerald	1
Basir Ali Ismail	1
Brandon Andesta	1
Ridwan Mintarjaya	1
Wisnu Catur	1
Erwin	1
A Kiat	1
RAOUL MIGUEL HADINOTO?	1
IWAN MURRYAWAN?	1
A.MOOSA PERMADI	1
ZUFAR ALFEN?	1
ALBERTUS GRACIA	1
NOSSANANDI K. S.R	1
SANTOSO?	1
GUNTUR JIWOKUSUMO	1
EDY HARTONO	1
Raffi Farid Ahmad	1
Norman Edward Sebastian	1
Angkling Gading Gumilang	1
Ardima Rama Putra?	1
Anthony Gunawan	1
Andrey Rido Mahardika	1
Rizky Julian Rifai	1
Thomas Petrus Godefrida Jozef Roijakkers	1
Wahyu Widayat Jati	1
Yudhi Mardiansyah	1
Agus Pamungkas	1
Wendha Wijaya	1
Tri Prasetyo Utomo	1
Rafi Aditya Sasono	1
Muslihudin	1
Firdaus Tri Pamungkas	1
Muhammad Fauzan Aziz	1
Dika Kawengian	1
Awan Yosi	1
Nur Asrifah Rahmah	1
Ryan Ardiansyah Achmad	1
dr. Febry Siswanto	1
Muhammad Ibrahim	1
Rony Gunawan	1
Riska Natalia Dewi	1
Wan Amran	1
Cecilia Dwi Maya Siswari	1
Youbel Sondakh	1
Cesar Canara Perez	1
Moh. Tohirno	1
Martin Setyawan	1
Dodik Tri Purnomo	1
Jerry Lolowang	1
Revan Jonathan	1
Rahmad Yuli Ardiyanto	1
Dimas Zena Wijaya	1
Benny Malaila	1
Mustofa Ramadhan	1
Ahmat Syukron	1
?Ahmed Rully Zulfikar	1
Husin Arief	1
Iskandarsyah Rama Datau	1
Evelyn Cathy	1
Tikky Suwantikno	1
Indra Budianto	1
Antonius Joko Endratmo	1
F.W. Daniel Poetiray	1
Tri Hartanto	1
Arnata Anggara Putra	1
Dwi Prasetiyono	1
A. Mundziri	1
Muhammad Rais Almuharie	1
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player (name, height, shirt_number, "position", team_name) FROM stdin;
Amaluddin Ragol	194	19	C	Amartha Hangtuah
Anthony Denell January Jr.	202	44	C	Amartha Hangtuah
Dandung O'neal Pamungkas	185	6	PG	Amartha Hangtuah
Diftha Pratama	183	1	SG	Amartha Hangtuah
Fisyaiful Amir	183	17	SG	Amartha Hangtuah
Govinda Julian Saputra	194	20	SF	Amartha Hangtuah
Gunawan Gunawan	190	13	SG	Amartha Hangtuah
Kelly Purwanto	178	3	PG	Amartha Hangtuah
Michael Ayodele Kolawole	195	5	PG	Amartha Hangtuah
Muhammed Aofar Hedyan	180	0	PG	Amartha Hangtuah
Rizky Agung Pranata	190	34	SF	Amartha Hangtuah
Stevan Wilfredo Neno	180	11	SG	Amartha Hangtuah
Nicholas David Jordan Faust	181	12	SG	Amartha Hangtuah
Ronald Earl Delph	182	13	SG	Amartha Hangtuah
Zoran Talley Jr	183	14	SG	Amartha Hangtuah
Thomas Hugo R De Thaey	198	31	C	Amartha Hangtuah
Tri Hartanto	197	33	C	Amartha Hangtuah
Yogi Saputra Chan	188	12	SF	Amartha Hangtuah
Yosua Otto Sunarko Judaprajitna	195	21	PF	Amartha Hangtuah
Abraham R. Wenas	174	6	PG	Bali United Basketball
Anak Agung Gede Agung Bagus	0	18	PF	Bali United Basketball
Bima Riski Ardiansyah	182	27	SF	Bali United Basketball
Galank Gunawan	198	66	C	Bali United Basketball
Gede Elgi Wimbardi	178	7	PG	Bali United Basketball
Irvine Kurniawan	173	10	PG	Bali United Basketball
Kierell Ardarius Green	197	12	C	Bali United Basketball
Lutfi Alfian Eka Koswara	184	5	SG	Bali United Basketball
Ponsianus Nyoman Indrawan	193	13	C	Bali United Basketball
Putu J. Satria Pande	196	24	C/P	Bali United Basketball
Rico Aditya Putra	196	8	PF	Bali United Basketball
Rivaldo Tomatala	194	28	C/P	Bali United Basketball
Ryan Taylor Batte	192	44	F	Bali United Basketball
Surliyadin Surliyadin	188	52	SF	Bali United Basketball
Xavier Charles Cannefax	184	1	F	Bali United Basketball
Ali Mustofa	187	12	F	Bima Perkasa Jogja
Andre Rizqiano	183	13	G	Bima Perkasa Jogja
Avin Kurniawan	178	8	G	Bima Perkasa Jogja
Bayu Bima Prasetya	180	7	G	Bima Perkasa Jogja
Brandis Raley Ross	187	5	G	Bima Perkasa Jogja
Feliciano Perez Neto	209	94	C/F	Bima Perkasa Jogja
Garrius De Marquise Holloman	198	23	F	Bima Perkasa Jogja
Habib Ahmeda Annur	189	18	F	Bima Perkasa Jogja
Handri Satrya Santosa	182	9	G	Bima Perkasa Jogja
Jonathan Komagum	0	21	C/P	Bima Perkasa Jogja
Joseph Paian De Smet	176	11	G	Bima Perkasa Jogja
Moh Saroni	199	24	C	Bima Perkasa Jogja
Muhammad Mukhlisin	179	1	G	Bima Perkasa Jogja
Muhammad Rifqi Lubis	178	2	G	Bima Perkasa Jogja
Martyce Joshua Kimbrough	165	2	G	Bima Perkasa Jogja
Restu Dwi Purnomo	192	32	F	Bima Perkasa Jogja
A. A Ngurah Wisnu Budidharma	180	8	G	Borneo Hornbills
Agam Subastian	165	4	G	Borneo Hornbills
Akeem Scott	180	1	G	Borneo Hornbills
Devondrick Deshawn Walker	178	3	G	Borneo Hornbills
Baltazar Noerisqun Wasi	188	12	F	Borneo Hornbills
Calvin Chrissler	175	11	G	Borneo Hornbills
Daniel Timothy Wenas	190	5	SF	Borneo Hornbills
Jamarr Andre Johnson	198	71	G	Borneo Hornbills
Michael Rashad Qualls	196	24	G	Borneo Hornbills
Muhammad Rizky Ari Daffa	194	13	C	Borneo Hornbills
Pondra Purnawan Anjas	177	10	F	Borneo Hornbills
Raymond Shariputra	181	22	F	Borneo Hornbills
Sevly Victory A. Rondonuwu	173	9	G	Borneo Hornbills
Steve Taylor Jr	203	25	F	Borneo Hornbills
Steven Orlando	183	7	G	Borneo Hornbills
Sultan Prawira	179	3	F	Borneo Hornbills
Valentino Wuwungan	192	23	C	Borneo Hornbills
Bryan Fernando Korisano	183	3	PG	Dewa United Banten
Darryl Winata	176	10	SG	Dewa United Banten
Dio Tirta Saputra	190	25	F	Dewa United Banten
Febrianus Khiandio	181	23	SG	Dewa United Banten
Firman Dwi Nugroho	202	16	C	Dewa United Banten
Gelvis Andres Solano Paulino	185	4	PG	Dewa United Banten
Hardianus Hardianus	172	2	PG	Dewa United Banten
Jordan Oei	183	24	SG	Dewa United Banten
Jordan Lavell Adams	194	5	F	Dewa United Banten
Kaleb Ramot Gemilang	184	13	F	Dewa United Banten
Kristian Liem	201	99	C	Dewa United Banten
Lester Prosper	209	32	C	Dewa United Banten
Lucky Abdi Pasondok	180	7	PG	Dewa United Banten
Patrick Nikolas	187	8	PF	Dewa United Banten
Radithyo Wibowo	177	55	PG	Dewa United Banten
Rio Disi	185	9	SG	Dewa United Banten
Tavario Earnest Ptristian Miller	0	11	C	Dewa United Banten
Andre Rorimpandey	177	11	G	Kesatria Bengawan Solo
Andre Adrianno	178	7	SG	Kesatria Bengawan Solo
Bagus Dwi Cahyono	175	6	SG	Kesatria Bengawan Solo
Bryan Adha Elang Praditya	196	18	C	Kesatria Bengawan Solo
Chanceler James Gettys	213	34	C	Kesatria Bengawan Solo
Esha Lapian	189	12	F	Kesatria Bengawan Solo
Ferdian Dwi Purwoko	188	2	PF	Kesatria Bengawan Solo
Hengki Infandi	180	29	SF	Kesatria Bengawan Solo
Katon Adjie Baskoro	184	17	SG	Kesatria Bengawan Solo
Kentrell Debarus Barkley	194	24	SF	Kesatria Bengawan Solo
Kevin Moses Eliazer Poetiray	184	22	SG/	Kesatria Bengawan Solo
Nuke Tri Saputra	177	3	G	Kesatria Bengawan Solo
Ruslan Ruslan	197	23	C/P	Kesatria Bengawan Solo
Samuel Devin Susanto	178	1	PG	Kesatria Bengawan Solo
Tifan Eka Pradita	178	5	PG	Kesatria Bengawan Solo
Travin Marquell Thibodeaux	197	25	F	Kesatria Bengawan Solo
Aditya Bagaskara	185	10	SG	Pacific Caesar Surabaya
Aven Ryan Pratama	0	14	PF	Pacific Caesar Surabaya
Boby Gillian Wibisono	195	31	PF	Pacific Caesar Surabaya
Christian Yudha	185	0	PF	Pacific Caesar Surabaya
Daffa Dhoifullah	185	9	PG	Pacific Caesar Surabaya
Dio Freedo Putra	175	1	PG	Pacific Caesar Surabaya
Faishal Luqmanul Hakim	183	24	SF	Pacific Caesar Surabaya
Firdan Maulana Kusnadi	183	29	SF	Pacific Caesar Surabaya
Frederico Nathaniel Darmawan	173	3	SG	Pacific Caesar Surabaya
Gregorio Claudie Wibowo	182	7	SF	Pacific Caesar Surabaya
Jaylyn Maurice Richardson	189	2	PG	Pacific Caesar Surabaya
Keljin Deshawn Blevins	198	21	PF	Pacific Caesar Surabaya
Muhammad Aulaz Ariezky	185	8	SG	Pacific Caesar Surabaya
Muhammad Iqbal Hardianto	180	22	PF	Pacific Caesar Surabaya
Senakusuma Aryo Ibrahim	190	15	PF	Pacific Caesar Surabaya
Stephen Lane Hurt	208	4	C/P	Pacific Caesar Surabaya
Yonatan Yonatan	189	12	C/F	Pacific Caesar Surabaya
Abiyyu Ramadhan	196	4	F	Pelita Jaya Jakarta
Agassi Yeshe Goantara	187	9	G	Pelita Jaya Jakarta
Aldy Izzatur Rachman	192	11	F	Pelita Jaya Jakarta
Andakara Prastawa Dhyaksa	173	7	G	Pelita Jaya Jakarta
Anto Febryanto Boyratan	196	22	C	Pelita Jaya Jakarta
Brandon Van Dorn Jawato	193	13	F	Pelita Jaya Jakarta
Greans Chandra Bartes Tangkulung	178	17	G	Pelita Jaya Jakarta
Hendrick Xavi Yonga	183	21	F	Pelita Jaya Jakarta
James L Dickey III	208	2	C	Pelita Jaya Jakarta
Jerome Anthony Beane JR	180	8	G	Pelita Jaya Jakarta
Justin Donta Brownlee	197	24	G	Pelita Jaya Jakarta
Kevin Ornell Chapman MC Daniels	197	32	F	Pelita Jaya Jakarta
M. Reza Fahdani Guntara	193	19	F	Pelita Jaya Jakarta
Malachi Lewis Richardson	197	5	G	Pelita Jaya Jakarta
Muhamad Arighi	182	1	G	Pelita Jaya Jakarta
Nickson Damara Gosal	194	26	F	Pelita Jaya Jakarta
Vincent Rivaldi Kosasih	203	15	C	Pelita Jaya Jakarta
Yesaya Alessandro Saudale	178	3	G	Pelita Jaya Jakarta
Antonio Kurtis Hester	198	5	PF	Prawira Harum Bandung
Brandone Francis	194	11	SG	Prawira Harum Bandung
Fernando Fransco Manansang	185	22	SG	Prawira Harum Bandung
Hans Abraham	180	13	SG	Prawira Harum Bandung
Indra Muhamad	189	24	SF	Prawira Harum Bandung
James Clough Gist III	206	15	C	Prawira Harum Bandung
Kelvin Sanjaya	199	27	C/P	Prawira Harum Bandung
Manuel Alejandro Suarez	208	44	C	Prawira Harum Bandung
Muhammad Fhirdan Guntara	184	77	SF	Prawira Harum Bandung
Muhammad Rizal Falconi	197	12	SF	Prawira Harum Bandung
Pandu Wiguna	194	34	C/P	Prawira Harum Bandung
Refka Djalu Pangestu	184	6	SF	Prawira Harum Bandung
Sandy Febiansyakh Kurniawan	189	9	SF	Prawira Harum Bandung
Sulthan Fauzan	187	2	SG	Prawira Harum Bandung
Teemo Teemo	178	3	PG	Prawira Harum Bandung
Victory Jacob Emilio Lobbu	175	1	PG	Prawira Harum Bandung
Yudha Saputera	176	8	PG	Prawira Harum Bandung
Andrian Danny Christianto	181	12	SG	Rajawali Medan
Anggi Alfiandi	191	44	PF	Rajawali Medan
Cassiopeia Thomas Manuputty	179	3	PG/	Rajawali Medan
Christopher Jason Winata	185	14	PG/	Rajawali Medan
Hendra Thio	174	9	PG	Rajawali Medan
Jabari Carl Bird	167	92	G	Rajawali Medan
Jonas Zohore Bergstedt	210	6	C	Rajawali Medan
Juan Alexius Anggara	180	7	PG/	Rajawali Medan
Julius Caesar Wongso	189	45	C/P	Rajawali Medan
M.Arief Setiawan	178	13	PG/	Rajawali Medan
Muhammad Yassier Rahmat	184	11	SF/	Rajawali Medan
Padre Taranngiar Hosbach	193	91	C/P	Rajawali Medan
Patrick James McGlynn IV	189	22	G	Rajawali Medan
Respati Ragil Pamungkas	179	0	G	Rajawali Medan
Rheza Saputra Butarbutar	193	33	PF	Rajawali Medan
Ryan Mauliza	179	8	SG	Rajawali Medan
William Rivaldi Kosasih	198	15	C/P	Rajawali Medan
Agus Salim	197	97	C	RANS Simba Bogor
Alexander Franklyn	180	3	PG	RANS Simba Bogor
Althof Dwira Satrio	184	11	SG	RANS Simba Bogor
Argus Sanyudy	192	10	C	RANS Simba Bogor
Bailey John Fields III	0	12	C	RANS Simba Bogor
Daniel William Tunasey Salamena	188	24	SG	RANS Simba Bogor
Darren Vai Celosse	195	18	SF	RANS Simba Bogor
David Liberty Nuban	186	1	SF	RANS Simba Bogor
Devon Doekele Van Oostrum	189	7	PG	RANS Simba Bogor
Fatur Dzikri Shihab	183	5	SF	RANS Simba Bogor
Ida Bagus Ananta Wisnu Putra	183	8	PG	RANS Simba Bogor
Januar Kuntara	171	9	PG	RANS Simba Bogor
Kenneth Dermont Funderburk Jr	193	55	PG/	RANS Simba Bogor
Le'Bryan Keithdrick Nash	198	23	SF/	RANS Simba Bogor
Mohammed Aymane Garudi Arip	194	6	PF	RANS Simba Bogor
Oki Wira Sanjaya	190	2	SG	RANS Simba Bogor
Abraham Damar Grahita	180	4	G	Satria Muda Pertamina
Adrien Maxime Alain Chalias	199	1	G	Satria Muda Pertamina
Ali Bagir Alhadar	193	13	F	Satria Muda Pertamina
Antoni Erga	179	3	G	Satria Muda Pertamina
Arki Dikania Wisnu	187	33	SF	Satria Muda Pertamina
Armando Fredik Yegiwar Kaize	199	27	C	Satria Muda Pertamina
Artem Pustovyi	218	31	C	Satria Muda Pertamina
Dame Diagne	197	2	G	Satria Muda Pertamina
Elgin Rashad Cook	196	28	F	Satria Muda Pertamina
Juan Laurent Kokodiputra	193	0	F	Satria Muda Pertamina
Julian Alexandre Chalias	188	14	PF	Satria Muda Pertamina
Karl Patrick Utiarahman	188	11	SG	Satria Muda Pertamina
M. Sandy Ibrahim Aziz	188	8	SG	Satria Muda Pertamina
Reynaldo Garcia Zamora	187	24	PG	Satria Muda Pertamina
Widyanta Putra Teja	180	71	PG	Satria Muda Pertamina
Calvin Yeremias Biyantaka	177	6	PG	Satya Wacana Saints Salatiga
Henry Cornelis Lakay	196	12	C/P	Satya Wacana Saints Salatiga
Imanuel Mailensun	188	18	PF	Satya Wacana Saints Salatiga
Isaac Pito Asrat	182	1	PG/	Satya Wacana Saints Salatiga
Kevin Immanuel Mendita Sihombing	192	8	SG/	Satya Wacana Saints Salatiga
Maikel Andreas Cores Baliba	188	7	SG	Satya Wacana Saints Salatiga
Mas Kahono Alif Bintang	192	77	C/P	Satya Wacana Saints Salatiga
Michael David Henn	202	24	C	Satya Wacana Saints Salatiga
Naufal Narendra Ranggajaya	196	28	SF	Satya Wacana Saints Salatiga
Putra Wijaya	180	21	SG	Satya Wacana Saints Salatiga
Randy Ady Prasetya	202	14	C	Satya Wacana Saints Salatiga
Rexy Fernando	191	29	SG	Satya Wacana Saints Salatiga
Topo Adi Saputro	182	9	SG	Satya Wacana Saints Salatiga
Tyree Jamal Robinson	196	0	PF	Satya Wacana Saints Salatiga
Yehezkiel Mahesvara Rahadiyanto	180	13	PG/	Satya Wacana Saints Salatiga
Andreas Kristian Vieri	190	32	SF	Tangerang Hawks
Andrew William Lensun	191	13	SG	Tangerang Hawks
Ardian Ariadi	180	4	F	Tangerang Hawks
Augustus Lewis Stone Jr.	191	0	G	Tangerang Hawks
Danny Ray	181	1	SG	Tangerang Hawks
Fabio Matheus Mailangkay	194	15	C	Tangerang Hawks
Gabriel Batistuta Risky	188	3	SF	Tangerang Hawks
Habib Tito Aji	188	44	PF	Tangerang Hawks
Justin Jaya Wiyanto	188	12	PG	Tangerang Hawks
Keefe Fitrano Yoshe	190	27	F	Tangerang Hawks
Leonardo Effendy	195	17	C	Tangerang Hawks
Morakinyo Michael Williams	209	5	C	Tangerang Hawks
Nicholas Craig Stover	198	24	F	Tangerang Hawks
Nikholas Mahesa R	169	9	PG	Tangerang Hawks
Randika Aprilian	192	19	PF	Tangerang Hawks
Steven Bernard Lenard Green	196	10	F/G	Tangerang Hawks
Teddy Apriyana Romadonsyah	190	11	F	Tangerang Hawks
Winston Swenjaya	175	7	PG	Tangerang Hawks
Travion Maurice Leonard	177	9	PG	Borneo Hornbills
Najeal Jewone Young	178	10	PG	Borneo Hornbills
Taylor Johns	179	11	PG	Kesatria Bengawan Solo
Jason Henry Copman	180	12	PG	Kesatria Bengawan Solo
Kamani Kevin Ano Johnson	181	13	PG	Pacific Caesar Surabaya
Nicholas Wiggins	182	14	PG	Pacific Caesar Surabaya
Thomas Earl Robinson	183	15	PG	Pelita Jaya Jakarta
Christian Tyler James	184	16	PG	Prawira Harum Bandung
Dane Anthony Miller Jr	185	17	PG	Prawira Harum Bandung
Julius Jucikas	186	18	PG	Prawira Harum Bandung
Wendell Lewis	187	19	PG	Rajawali Medan
Quintin Dove	188	20	PG	Rajawali Medan
Malik Jhamari Dunbar	189	21	PG	RANS Simba Bogor
\.


--
-- Data for Name: player_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_stats (player, team, gp, mpg, "FG%", "3P%", "2P%", "FT%", rpg, apg, bpg, spg, ppg) FROM stdin;
Stevan Wilfredo Neno	Amartha Hangtuah	12	257:36	29.6	24.6	45.0	64	1.67	2.75	0.17	0.58	5.83
Gunawan Gunawan	Amartha Hangtuah	14	157:13	21.8	21.4	23.1	67	1.07	0.29	0.00	0.21	2.79
Fisyaiful Amir	Amartha Hangtuah	26	739:03	45.6	27.1	53.1	68	3.73	2.65	0.19	1.46	10.04
Kelly Purwanto	Amartha Hangtuah	20	331:12	28.6	14.3	50.0	63	1.55	4.05	0.15	1.20	1.40
Amaluddin Ragol	Amartha Hangtuah	8	71:31	57.1	60.0	50.0	50	1.38	0.25	0.00	0.50	1.50
Michael Ayodele Kolawole	Amartha Hangtuah	15	388:23	43.9	30.5	52.8	66	5.47	3.80	0.27	1.93	18.67
Rizky Agung Pranata	Amartha Hangtuah	11	77:57	33.3	0.0	75.0	0	0.36	0.27	0.00	0.09	0.55
Tri Hartanto	Amartha Hangtuah	12	81:31	38.5	0.0	38.5	67	1.17	0.33	0.17	0.25	1.00
Diftha Pratama	Amartha Hangtuah	26	508:51	34.7	32.0	40.0	66	1.96	1.88	0.12	0.65	6.00
Govinda Julian Saputra	Amartha Hangtuah	22	264:35	28.4	22.9	34.4	50	2.00	0.73	0.36	0.27	2.23
Dandung O'neal Pamungkas	Amartha Hangtuah	24	292:30	26.7	28.3	25.0	56	1.50	1.17	0.13	0.38	2.96
Yosua Otto Sunarko Judaprajitna	Amartha Hangtuah	15	164:54	28.6	12.5	42.1	77	1.67	0.53	0.13	0.13	2.13
Zoran Talley Jr	Amartha Hangtuah	20	566:52	50.7	28.2	54.5	55	8.65	4.20	0.50	1.55	17.10
Muhammed Aofar Hedyan	Amartha Hangtuah	6	38:45	14.3	0.0	16.7	50	1.00	1.17	0.00	0.17	0.67
Yogi Saputra Chan	Amartha Hangtuah	6	28:36	18.2	0.0	33.3	0	1.33	0.00	0.17	0.00	0.67
Nicholas David Jordan Faust	Amartha Hangtuah	10	285:51	37.5	22.5	50.0	59	6.80	2.60	0.80	1.80	20.00
Ronald Earl Delph	Amartha Hangtuah	17	473:56	44.5	34.7	49.1	53	12.47	1.06	2.18	0.47	15.41
Anthony Denell January Jr.	Amartha Hangtuah	5	108:01	42.9	27.8	47.5	75	6.40	1.20	0.60	1.00	16.60
Thomas Hugo R De Thaey	Amartha Hangtuah	8	228:32	50.5	36.0	54.7	73	10.50	2.00	0.25	0.88	19.88
Abraham R. Wenas	Bali United Basketball	26	767:03	41.4	37.0	43.0	77	2.58	4.92	0.00	0.65	12.31
Galank Gunawan	Bali United Basketball	27	447:30	44.4	0.0	44.4	25	5.04	1.41	0.41	0.63	0.33
Lutfi Alfian Eka Koswara	Bali United Basketball	20	128:51	34.7	30.8	50.0	0	0.30	0.35	0.00	0.25	2.30
Surliyadin Surliyadin	Bali United Basketball	28	693:19	30.2	29.3	32.7	59	2.75	2.29	0.07	1.00	6.25
Bima Riski Ardiansyah	Bali United Basketball	28	367:41	26.9	27.2	26.3	75	2.00	1.04	0.07	0.46	3.18
Irvine Kurniawan	Bali United Basketball	17	94:58	33.3	36.4	31.3	75	0.35	0.76	0.00	0.35	1.47
Rico Aditya Putra	Bali United Basketball	25	362:57	35.9	31.6	37.0	48	2.72	0.56	0.16	0.68	3.40
Ponsianus Nyoman Indrawan	Bali United Basketball	27	519:30	47.4	40.0	50.0	53	3.41	1.70	0.04	0.30	5.63
Putu J. Satria Pande	Bali United Basketball	5	22:26	20.0	50.0	12.5	100	2.00	0.00	0.00	0.00	1.40
Gede Elgi Wimbardi	Bali United Basketball	14	93:58	16.0	0.0	26.7	65	0.57	1.00	0.07	0.14	1.50
Anak Agung Gede Agung Bagus	Bali United Basketball	5	14:41	33.3	0.0	50.0	0	1.60	0.00	0.00	0.40	0.80
Xavier Charles Cannefax	Bali United Basketball	28	809:21	49.9	22.2	57.0	70	3.32	4.89	0.14	1.25	19.39
Kierell Ardarius Green	Bali United Basketball	28	829:12	45.3	25.9	50.2	58	14.18	1.82	1.54	1.25	17.00
Ryan Taylor Batte	Bali United Basketball	25	473:33	43.0	32.1	49.3	67	3.60	1.96	0.12	0.72	10.96
Restu Dwi Purnomo	Bima Perkasa Jogja	26	471:45	34.9	20.7	40.3	39	2.31	0.50	0.19	0.23	3.54
Ali Mustofa	Bima Perkasa Jogja	26	447:09	33.3	22.2	42.2	57	1.77	1.19	0.19	0.19	2.88
Joseph Paian De Smet	Bima Perkasa Jogja	26	528:06	28.8	26.0	34.7	53	2.27	1.54	0.15	0.62	4.81
Avin Kurniawan	Bima Perkasa Jogja	26	656:57	45.9	29.0	52.5	67	2.81	1.65	0.08	0.88	9.38
Moh Saroni	Bima Perkasa Jogja	19	164:54	42.9	0.0	45.0	32	1.37	0.16	0.21	0.11	1.26
Habib Ahmeda Annur	Bima Perkasa Jogja	17	109:15	16.0	0.0	16.7	38	1.29	0.24	0.18	0.24	0.65
Handri Satrya Santosa	Bima Perkasa Jogja	24	555:38	33.3	23.2	50.0	56	2.00	1.67	0.13	0.67	4.54
Muhammad Mukhlisin	Bima Perkasa Jogja	17	175:38	27.8	10.0	34.6	50	1.29	0.82	0.00	0.53	1.47
Muhammad Rifqi Lubis	Bima Perkasa Jogja	1	3:51	0.0	0.0	0.0	0	0.00	0.00	0.00	0.00	0.00
Bayu Bima Prasetya	Bima Perkasa Jogja	11	76:35	25.0	18.2	33.3	83	1.18	0.45	0.00	0.09	1.55
Andre Rizqiano	Bima Perkasa Jogja	10	51:15	25.0	0.0	30.0	0	0.50	0.30	0.10	0.20	0.60
Martyce Joshua Kimbrough	Bima Perkasa Jogja	5	164:20	22.0	18.8	26.5	50	6.20	5.80	0.00	1.40	9.20
Garrius De Marquise Holloman	Bima Perkasa Jogja	26	597:48	40.6	26.8	49.2	53	7.96	2.42	0.85	0.96	15.92
Feliciano Perez Neto	Bima Perkasa Jogja	9	191:20	42.4	15.4	50.0	33	6.67	0.89	1.33	0.89	6.44
Brandis Raley Ross	Bima Perkasa Jogja	21	677:54	42.1	35.0	48.2	84	6.90	4.95	0.19	1.29	22.57
Jonathan Komagum	Bima Perkasa Jogja	16	352:34	34.6	0.0	36.4	67	9.00	1.63	0.56	0.44	6.88
Sevly Victory A. Rondonuwu	Borneo Hornbills	25	602:39	31.4	33.9	23.7	58	1.56	1.68	0.00	0.64	6.20
Daniel Timothy Wenas	Borneo Hornbills	12	74:25	27.8	18.2	42.9	75	0.83	0.50	0.08	0.08	1.25
Valentino Wuwungan	Borneo Hornbills	9	80:27	42.9	42.9	42.9	0	2.33	0.67	0.00	0.00	2.33
Raymond Shariputra	Borneo Hornbills	28	401:02	21.7	17.4	30.4	56	1.00	0.82	0.14	0.25	1.54
Jamarr Andre Johnson	Borneo Hornbills	29	860:27	41.8	24.0	51.7	78	6.14	2.31	0.66	1.17	11.28
Calvin Chrissler	Borneo Hornbills	28	455:48	34.4	35.7	29.6	80	1.36	1.00	0.04	0.54	4.75
Agam Subastian	Borneo Hornbills	17	181:05	43.6	50.0	33.3	50	0.65	0.88	0.00	0.53	2.82
Steven Orlando	Borneo Hornbills	25	504:27	31.1	28.9	42.9	0	1.56	3.24	0.16	0.80	3.12
Muhammad Rizky Ari Daffa	Borneo Hornbills	26	378:39	51.0	0.0	51.0	64	2.65	0.77	0.27	0.62	4.65
Sultan Prawira	Borneo Hornbills	17	62:46	40.0	0.0	100.0	0	0.29	0.24	0.00	0.00	0.47
A. A Ngurah Wisnu Budidharma	Borneo Hornbills	8	35:15	20.0	0.0	28.6	0	0.38	0.38	0.00	0.25	0.50
Akeem Scott	Borneo Hornbills	18	301:51	46.4	27.0	62.3	70	2.44	3.17	0.33	1.61	10.50
Devondrick Deshawn Walker	Borneo Hornbills	2	41:43	14.3	11.1	33.3	50	6.50	4.00	0.00	0.50	4.50
Travion Maurice Leonard	Borneo Hornbills	6	201:30	38.5	0.0	40.5	33	12.83	2.83	1.17	1.83	10.50
Pondra Purnawan Anjas	Borneo Hornbills	6	17:45	0.0	0.0	0.0	0	0.67	0.17	0.00	0.33	0.00
Baltazar Noerisqun Wasi	Borneo Hornbills	1	1:20	0.0	0.0	0.0	0	0.00	0.00	0.00	0.00	0.00
Najeal Jewone Young	Borneo Hornbills	10	239:07	49.5	46.7	50.0	72	5.10	1.40	0.00	1.20	14.20
Michael Rashad Qualls	Borneo Hornbills	23	768:29	47.5	32.0	53.3	70	9.57	4.87	1.26	2.09	27.13
Steve Taylor Jr	Borneo Hornbills	22	716:17	55.5	30.0	65.1	58	11.50	4.68	0.77	1.23	20.14
Lucky Abdi Pasondok	Dewa United Banten	3	13:34	0.0	0.0	0.0	0	0.00	1.00	0.00	0.33	0.00
Kaleb Ramot Gemilang	Dewa United Banten	29	749:21	52.8	45.1	60.0	86	2.90	2.31	0.10	0.59	10.17
Lester Prosper	Dewa United Banten	31	856:46	51.2	37.4	59.9	76	9.65	1.74	1.35	0.97	16.90
Dio Tirta Saputra	Dewa United Banten	29	350:43	33.0	24.7	50.0	90	2.31	0.45	0.00	0.34	3.90
Firman Dwi Nugroho	Dewa United Banten	4	21:60	20.0	0.0	20.0	50	1.00	0.00	0.00	0.00	0.75
Kristian Liem	Dewa United Banten	19	122:54	60.0	0.0	60.0	50	1.26	0.21	0.42	0.26	1.00
Febrianus Khiandio	Dewa United Banten	11	86:58	21.9	23.3	0.0	80	0.64	0.09	0.00	0.00	2.27
Patrick Nikolas	Dewa United Banten	28	265:19	34.8	36.4	33.3	71	1.68	0.21	0.04	0.36	2.32
Rio Disi	Dewa United Banten	31	441:29	35.9	25.0	59.5	68	1.19	1.68	0.03	0.74	3.77
Bryan Fernando Korisano	Dewa United Banten	14	64:39	32.0	22.2	57.1	0	0.21	0.07	0.00	0.00	1.43
Hardianus Hardianus	Dewa United Banten	29	581:50	32.7	28.4	41.0	79	1.72	4.55	0.00	0.52	3.93
Jordan Oei	Dewa United Banten	2	8:37	0.0	0.0	0.0	0	0.00	0.50	0.00	0.00	0.00
Gelvis Andres Solano Paulino	Dewa United Banten	31	727:51	44.0	30.4	52.2	73	3.71	7.35	0.90	1.94	15.97
Jordan Lavell Adams	Dewa United Banten	31	879:03	51.8	41.1	58.6	81	7.45	4.71	0.29	2.71	22.97
Darryl Winata	Dewa United Banten	4	18:56	28.6	25.0	33.3	50	0.50	0.50	0.00	0.25	1.50
Tavario Earnest Ptristian Miller	Dewa United Banten	31	738:30	62.3	12.5	66.5	74	9.39	1.97	0.84	1.23	14.16
Radithyo Wibowo	Dewa United Banten	22	271:30	31.3	27.7	36.4	67	1.27	2.32	0.00	0.82	3.41
Nuke Tri Saputra	Kesatria Bengawan Solo	23	525:10	29.4	25.0	37.9	59	3.00	1.57	0.09	1.17	6.30
Tifan Eka Pradita	Kesatria Bengawan Solo	8	54:33	33.3	0.0	36.4	100	0.75	1.50	0.00	0.50	1.75
Kevin Moses Eliazer Poetiray	Kesatria Bengawan Solo	29	758:25	29.7	25.2	37.1	66	1.90	1.59	0.10	0.55	7.97
Andre Rorimpandey	Kesatria Bengawan Solo	28	453:30	30.8	26.7	44.4	62	0.96	2.11	0.00	0.68	3.89
Hengki Infandi	Kesatria Bengawan Solo	15	74:53	15.4	0.0	25.0	25	0.53	0.33	0.00	0.20	0.33
Katon Adjie Baskoro	Kesatria Bengawan Solo	28	454:32	34.6	22.4	44.8	47	1.43	1.29	0.04	0.71	3.36
Bryan Adha Elang Praditya	Kesatria Bengawan Solo	4	10:54	50.0	0.0	50.0	50	0.00	0.00	0.25	0.50	0.75
Andre Adrianno	Kesatria Bengawan Solo	27	246:21	32.4	37.0	24.0	50	0.59	0.70	0.00	0.37	2.74
Samuel Devin Susanto	Kesatria Bengawan Solo	27	446:39	46.3	24.0	53.0	54	1.78	1.74	0.07	0.59	4.44
Ruslan Ruslan	Kesatria Bengawan Solo	10	48:54	57.1	0.0	100.0	0	0.40	0.00	0.10	0.10	0.80
Esha Lapian	Kesatria Bengawan Solo	25	207:37	49.2	33.3	60.0	60	1.24	0.28	0.00	0.24	2.76
Ferdian Dwi Purwoko	Kesatria Bengawan Solo	22	245:13	43.5	20.0	48.6	63	1.64	0.59	0.14	0.36	3.95
Taylor Johns	Kesatria Bengawan Solo	21	558:11	51.4	31.3	54.3	47	10.48	4.24	1.05	2.14	15.14
Bagus Dwi Cahyono	Kesatria Bengawan Solo	2	14:03	16.7	0.0	100.0	0	0.50	0.50	0.00	0.50	1.00
Kentrell Debarus Barkley	Kesatria Bengawan Solo	26	875:15	53.2	30.7	64.2	63	11.81	5.35	0.92	1.81	24.65
Jason Henry Copman	Kesatria Bengawan Solo	8	95:48	43.8	0.0	43.8	53	5.13	0.63	0.13	1.38	4.63
Chanceler James Gettys	Kesatria Bengawan Solo	21	570:21	56.2	28.2	61.1	44	10.24	3.90	1.19	0.76	16.19
Travin Marquell Thibodeaux	Kesatria Bengawan Solo	6	184:41	47.1	35.8	59.2	81	10.00	3.50	0.67	0.67	22.83
Yonatan Yonatan	Pacific Caesar Surabaya	26	305:25	36.4	22.2	40.0	14	2.08	0.23	0.15	0.19	1.35
Dio Freedo Putra	Pacific Caesar Surabaya	23	274:12	30.5	29.8	33.3	58	1.26	1.09	0.00	0.48	2.48
Gregorio Claudie Wibowo	Pacific Caesar Surabaya	23	430:02	30.1	15.2	40.3	50	2.04	2.04	0.13	0.65	3.91
Muhammad Aulaz Ariezky	Pacific Caesar Surabaya	26	386:13	36.5	28.8	75.0	75	1.88	0.88	0.46	0.38	3.69
Daffa Dhoifullah	Pacific Caesar Surabaya	26	654:55	38.3	29.8	45.8	52	3.00	1.69	0.08	0.88	8.23
Muhammad Iqbal Hardianto	Pacific Caesar Surabaya	16	102:23	20.0	10.0	26.7	25	0.94	0.19	0.00	0.06	0.75
Christian Yudha	Pacific Caesar Surabaya	20	362:53	35.2	36.4	33.3	71	2.75	1.15	0.10	0.65	5.30
Boby Gillian Wibisono	Pacific Caesar Surabaya	1	1:55	0.0	0.0	0.0	0	1.00	0.00	0.00	0.00	0.00
Frederico Nathaniel Darmawan	Pacific Caesar Surabaya	17	108:46	42.9	30.8	62.5	57	0.53	0.65	0.00	0.24	1.53
Aven Ryan Pratama	Pacific Caesar Surabaya	26	600:43	30.2	20.9	40.7	54	3.31	0.88	0.46	0.58	3.73
Jaylyn Maurice Richardson	Pacific Caesar Surabaya	18	521:19	41.6	32.6	46.2	74	4.94	5.67	0.78	1.28	20.11
Aditya Bagaskara	Pacific Caesar Surabaya	2	10:04	0.0	0.0	0.0	0	0.00	1.00	0.00	0.00	0.00
Senakusuma Aryo Ibrahim	Pacific Caesar Surabaya	1	2:01	0.0	0.0	0.0	0	0.00	0.00	0.00	0.00	0.00
Kamani Kevin Ano Johnson	Pacific Caesar Surabaya	2	29:07	57.1	0.0	57.1	38	5.50	1.50	0.50	1.50	6.50
Stephen Lane Hurt	Pacific Caesar Surabaya	26	877:34	49.5	36.3	54.3	75	12.54	4.88	1.00	0.62	19.35
Nicholas Wiggins	Pacific Caesar Surabaya	9	141:11	42.0	12.5	54.4	62	3.44	1.22	0.11	0.56	10.22
Keljin Deshawn Blevins	Pacific Caesar Surabaya	15	466:17	42.3	31.5	50.3	71	5.87	4.33	0.40	1.33	21.07
Vincent Rivaldi Kosasih	Pelita Jaya Jakarta	24	225:28	48.1	0.0	49.0	53	2.33	0.63	0.33	0.21	2.46
Andakara Prastawa Dhyaksa	Pelita Jaya Jakarta	28	675:15	37.2	32.7	46.8	82	1.93	3.18	0.04	1.39	9.68
Brandon Van Dorn Jawato	Pelita Jaya Jakarta	22	399:12	39.3	31.1	45.6	76	4.00	2.14	0.05	0.68	6.73
M. Reza Fahdani Guntara	Pelita Jaya Jakarta	28	648:41	39.2	37.3	42.5	65	4.04	1.54	0.32	1.04	8.18
Aldy Izzatur Rachman	Pelita Jaya Jakarta	17	128:59	36.1	25.0	75.0	25	1.29	0.65	0.18	0.29	2.00
Yesaya Alessandro Saudale	Pelita Jaya Jakarta	25	295:02	45.0	25.9	54.7	67	1.72	1.76	0.12	1.12	3.32
Muhamad Arighi	Pelita Jaya Jakarta	30	508:49	35.7	29.1	46.0	94	1.53	1.40	0.03	0.73	4.37
Hendrick Xavi Yonga	Pelita Jaya Jakarta	11	114:06	50.0	50.0	50.0	43	1.09	1.36	0.45	0.64	4.09
Abiyyu Ramadhan	Pelita Jaya Jakarta	3	10:59	100.0	0.0	100.0	0	0.67	0.33	0.33	0.00	0.67
Agassi Yeshe Goantara	Pelita Jaya Jakarta	21	369:24	31.4	25.0	34.8	72	2.67	1.71	0.05	0.24	4.19
Nickson Damara Gosal	Pelita Jaya Jakarta	8	27:20	0.0	0.0	0.0	0	0.63	0.50	0.00	0.13	0.00
Anto Febryanto Boyratan	Pelita Jaya Jakarta	5	25:23	72.7	0.0	80.0	25	2.00	0.20	0.00	0.20	3.40
Greans Chandra Bartes Tangkulung	Pelita Jaya Jakarta	4	29:10	50.0	50.0	50.0	0	0.75	0.25	0.00	0.00	2.50
Jerome Anthony Beane JR	Pelita Jaya Jakarta	23	576:41	45.3	31.6	58.2	71	2.65	4.30	0.13	1.74	14.17
Thomas Earl Robinson	Pelita Jaya Jakarta	15	351:49	58.6	44.4	59.4	45	9.20	1.73	0.27	1.00	16.27
Malachi Lewis Richardson	Pelita Jaya Jakarta	8	157:14	38.6	32.6	45.9	78	3.88	1.63	0.38	0.50	12.13
Kevin Ornell Chapman MC Daniels	Pelita Jaya Jakarta	26	698:36	53.6	32.1	59.8	60	9.27	3.50	1.54	1.42	18.35
Justin Donta Brownlee	Pelita Jaya Jakarta	14	391:41	55.2	38.9	61.2	77	7.93	4.71	0.21	1.57	13.50
James L Dickey III	Pelita Jaya Jakarta	13	366:11	54.6	0.0	54.6	50	10.08	2.62	2.69	1.85	14.92
Indra Muhamad	Prawira Harum Bandung	30	383:34	22.7	21.0	31.3	83	1.97	0.70	0.13	0.27	2.67
Hans Abraham	Prawira Harum Bandung	29	603:56	35.0	32.1	47.4	78	2.41	1.03	0.03	0.86	7.34
Pandu Wiguna	Prawira Harum Bandung	31	544:51	57.7	0.0	58.3	54	3.77	0.81	0.29	0.52	4.35
Muhammad Rizal Falconi	Prawira Harum Bandung	22	162:58	59.0	100.0	57.9	67	1.41	0.27	0.05	0.27	2.50
Muhammad Fhirdan Guntara	Prawira Harum Bandung	30	575:59	31.7	16.0	42.1	59	2.50	2.03	0.00	0.60	2.23
Yudha Saputera	Prawira Harum Bandung	31	943:34	39.7	32.9	51.1	67	3.10	5.26	0.10	1.29	13.26
Kelvin Sanjaya	Prawira Harum Bandung	5	22:31	33.3	0.0	33.3	0	1.40	0.00	0.00	0.00	0.40
Sandy Febiansyakh Kurniawan	Prawira Harum Bandung	16	91:39	28.1	29.0	0.0	0	0.06	0.56	0.00	0.25	1.69
Teemo Teemo	Prawira Harum Bandung	17	98:19	33.3	33.3	33.3	0	0.53	0.65	0.06	0.29	0.59
Fernando Fransco Manansang	Prawira Harum Bandung	21	181:34	47.5	41.7	50.0	50	1.48	0.52	0.05	0.38	2.29
Victory Jacob Emilio Lobbu	Prawira Harum Bandung	27	208:50	19.4	6.7	28.6	67	0.93	1.26	0.04	0.52	1.07
Brandone Francis	Prawira Harum Bandung	26	761:48	47.8	37.0	52.8	75	5.15	3.96	0.27	0.96	21.85
Christian Tyler James	Prawira Harum Bandung	5	158:03	35.2	20.6	48.6	78	7.80	4.60	0.00	0.60	18.60
Dane Anthony Miller Jr	Prawira Harum Bandung	5	160:28	50.9	20.0	53.8	65	9.20	5.60	1.40	2.00	15.80
Julius Jucikas	Prawira Harum Bandung	3	59:36	52.2	0.0	54.5	50	5.33	1.33	0.67	0.00	8.67
Antonio Kurtis Hester	Prawira Harum Bandung	26	591:30	56.0	12.5	57.4	63	9.92	2.27	0.38	1.04	15.08
James Clough Gist III	Prawira Harum Bandung	17	453:26	48.8	21.4	58.5	69	8.47	2.65	1.06	1.18	11.18
Manuel Alejandro Suarez	Prawira Harum Bandung	9	222:24	51.2	32.4	59.1	74	9.33	2.33	1.22	1.22	18.33
Respati Ragil Pamungkas	Rajawali Medan	26	497:46	36.6	33.7	40.3	68	1.54	2.27	0.00	0.58	6.38
Andrian Danny Christianto	Rajawali Medan	23	273:58	16.3	10.0	26.3	60	1.22	1.39	0.00	1.09	1.09
Cassiopeia Thomas Manuputty	Rajawali Medan	12	109:36	36.0	18.2	50.0	50	1.08	1.42	0.00	0.75	2.00
M.Arief Setiawan	Rajawali Medan	1	1:12	0.0	0.0	0.0	0	0.00	0.00	0.00	0.00	0.00
Julius Caesar Wongso	Rajawali Medan	12	300:29	49.1	0.0	60.0	55	5.00	1.25	0.00	0.67	5.00
Juan Alexius Anggara	Rajawali Medan	15	113:56	22.2	12.5	30.0	33	0.73	1.13	0.00	0.40	0.80
Anggi Alfiandi	Rajawali Medan	10	111:16	26.7	0.0	30.8	67	2.20	0.20	0.00	0.40	1.20
Hendra Thio	Rajawali Medan	26	556:51	30.4	26.8	32.9	49	2.08	3.15	0.08	0.85	4.65
Muhammad Yassier Rahmat	Rajawali Medan	13	98:02	24.2	13.0	50.0	25	1.08	0.23	0.08	0.23	1.54
Christopher Jason Winata	Rajawali Medan	25	323:39	34.5	28.9	38.5	40	1.48	0.92	0.04	0.32	3.64
Padre Taranngiar Hosbach	Rajawali Medan	26	507:36	37.2	100.0	35.7	56	2.42	1.08	0.27	0.65	1.62
Rheza Saputra Butarbutar	Rajawali Medan	10	122:16	30.4	12.5	40.0	0	2.10	0.70	0.30	0.70	1.50
Ryan Mauliza	Rajawali Medan	11	161:12	37.5	19.2	59.1	67	1.18	1.73	0.00	0.82	4.27
Wendell Lewis	Rajawali Medan	12	338:16	59.3	0.0	59.7	47	8.33	2.00	1.17	1.42	14.67
Quintin Dove	Rajawali Medan	10	280:38	48.1	22.4	59.8	86	8.70	1.60	0.60	1.20	22.70
Jabari Carl Bird	Rajawali Medan	22	642:59	52.4	33.8	58.1	58	7.73	3.09	0.82	1.45	19.77
Patrick James McGlynn IV	Rajawali Medan	14	392:25	42.1	37.0	46.7	88	3.36	3.86	0.14	0.79	22.86
Jonas Zohore Bergstedt	Rajawali Medan	14	367:53	51.3	32.4	56.8	56	10.14	1.93	0.29	1.07	14.86
Januar Kuntara	RANS Simba Bogor	12	113:57	26.9	25.0	28.6	25	0.67	2.00	0.00	0.42	1.50
David Liberty Nuban	RANS Simba Bogor	21	380:58	31.7	27.0	38.8	57	1.52	0.57	0.00	0.48	5.29
Alexander Franklyn	RANS Simba Bogor	4	24:59	50.0	0.0	100.0	0	1.25	0.25	0.00	0.00	1.00
Oki Wira Sanjaya	RANS Simba Bogor	29	533:21	31.2	27.0	52.2	36	1.97	1.28	0.14	0.38	4.17
Julius Caesar Wongso	RANS Simba Bogor	6	31:47	100.0	0.0	100.0	0	0.67	0.17	0.00	0.17	0.67
Fatur Dzikri Shihab	RANS Simba Bogor	12	94:46	40.9	9.1	72.7	57	1.17	0.50	0.00	0.67	2.25
Ida Bagus Ananta Wisnu Putra	RANS Simba Bogor	26	308:44	31.7	28.2	34.9	63	2.19	1.54	0.12	0.35	3.00
Althof Dwira Satrio	RANS Simba Bogor	26	377:32	28.9	25.9	43.8	56	1.23	1.19	0.19	0.77	3.35
Agus Salim	RANS Simba Bogor	12	72:38	42.9	0.0	42.9	100	1.83	0.33	0.33	0.25	1.58
Rheza Saputra Butarbutar	RANS Simba Bogor	13	91:47	30.4	18.2	41.7	75	1.62	0.31	0.62	0.23	1.46
Daniel William Tunasey Salamena	RANS Simba Bogor	28	604:28	35.3	24.8	53.7	62	2.14	1.07	0.18	0.75	6.71
Mohammed Aymane Garudi Arip	RANS Simba Bogor	3	9:17	0.0	0.0	0.0	0	1.00	0.33	0.00	0.00	0.00
Argus Sanyudy	RANS Simba Bogor	27	313:25	50.0	0.0	50.0	24	2.89	0.26	0.07	0.30	2.52
Malik Jhamari Dunbar	RANS Simba Bogor	5	109:33	40.4	54.5	36.1	73	4.80	0.40	1.40	0.60	10.40
Devon Doekele Van Oostrum	RANS Simba Bogor	23	757:10	38.5	28.5	54.1	78	6.30	8.74	0.30	1.78	15.22
Le'Bryan Keithdrick Nash	RANS Simba Bogor	28	887:17	57.0	23.0	63.2	64	9.89	4.39	0.50	0.64	21.93
Kenneth Dermont Funderburk Jr	RANS Simba Bogor	12	297:25	45.8	29.8	55.2	55	6.08	3.17	0.33	0.92	16.50
Bailey John Fields III	RANS Simba Bogor	9	209:32	66.2	0.0	66.2	60	9.56	0.67	0.78	0.22	13.22
Abraham Damar Grahita	Satria Muda Pertamina	31	794:25	46.6	42.2	52.4	69	2.84	2.81	0.06	1.45	13.97
Arki Dikania Wisnu	Satria Muda Pertamina	30	509:27	34.1	23.6	42.3	69	2.67	1.63	0.23	0.73	4.27
Widyanta Putra Teja	Satria Muda Pertamina	29	465:33	37.4	23.3	52.7	79	1.93	4.10	0.07	0.66	4.34
M. Sandy Ibrahim Aziz	Satria Muda Pertamina	31	414:13	32.3	29.8	40.0	54	1.29	0.45	0.16	0.90	3.90
Juan Laurent Kokodiputra	Satria Muda Pertamina	31	535:12	46.8	34.2	58.5	55	2.77	1.03	0.06	0.55	6.32
Antoni Erga	Satria Muda Pertamina	29	307:20	34.6	31.7	37.5	74	1.52	1.90	0.03	0.69	3.28
Ali Bagir Alhadar	Satria Muda Pertamina	26	285:11	33.3	27.7	48.4	55	2.81	0.58	0.12	0.73	4.04
Dame Diagne	Satria Muda Pertamina	31	581:14	47.6	27.8	56.9	56	6.16	0.97	0.58	0.74	8.84
Julian Alexandre Chalias	Satria Muda Pertamina	31	367:54	51.8	0.0	53.1	55	2.35	0.65	0.39	0.55	3.16
Karl Patrick Utiarahman	Satria Muda Pertamina	8	21:08	12.5	0.0	50.0	50	0.13	0.25	0.00	0.13	0.50
Armando Fredik Yegiwar Kaize	Satria Muda Pertamina	3	5:56	100.0	0.0	100.0	0	1.00	0.00	0.00	0.00	0.67
Reynaldo Garcia Zamora	Satria Muda Pertamina	15	336:15	51.0	28.6	57.6	75	4.93	8.40	0.27	3.33	15.13
Artem Pustovyi	Satria Muda Pertamina	11	287:29	60.4	33.3	67.1	73	6.45	1.82	1.27	0.73	15.55
Elgin Rashad Cook	Satria Muda Pertamina	8	152:26	52.2	41.2	56.0	58	5.13	2.75	0.38	0.63	11.38
Henry Cornelis Lakay	Satya Wacana Saints Salatiga	21	485:50	30.1	29.6	32.0	50	2.71	1.10	0.38	0.76	5.38
Randy Ady Prasetya	Satya Wacana Saints Salatiga	24	383:07	47.1	100.0	46.3	50	2.96	0.25	1.08	0.38	3.00
Mas Kahono Alif Bintang	Satya Wacana Saints Salatiga	25	232:06	36.8	0.0	38.9	56	1.56	0.12	0.12	0.28	0.92
Topo Adi Saputro	Satya Wacana Saints Salatiga	15	105:15	13.0	0.0	30.0	100	0.73	0.40	0.00	0.53	0.67
Naufal Narendra Ranggajaya	Satya Wacana Saints Salatiga	13	89:45	11.1	6.3	50.0	33	0.77	0.00	0.00	0.15	0.46
Putra Wijaya	Satya Wacana Saints Salatiga	6	18:23	20.0	20.0	0.0	50	0.67	0.00	0.00	0.17	0.67
Tyree Jamal Robinson	Satya Wacana Saints Salatiga	24	683:43	55.4	28.6	56.3	61	10.46	2.29	1.67	2.29	23.96
Calvin Yeremias Biyantaka	Satya Wacana Saints Salatiga	26	739:37	28.1	13.6	34.0	52	3.27	3.19	0.04	1.08	6.50
Isaac Pito Asrat	Satya Wacana Saints Salatiga	23	689:09	41.6	28.7	49.3	71	4.30	5.87	0.09	1.87	15.48
Kevin Immanuel Mendita Sihombing	Satya Wacana Saints Salatiga	17	90:18	20.8	17.6	28.6	17	0.53	0.12	0.06	0.18	0.82
Yehezkiel Mahesvara Rahadiyanto	Satya Wacana Saints Salatiga	21	323:50	31.0	19.0	37.8	63	1.24	0.95	0.05	0.71	2.81
Imanuel Mailensun	Satya Wacana Saints Salatiga	26	314:22	25.0	15.8	30.3	55	2.00	0.42	0.23	0.77	1.35
Michael David Henn	Satya Wacana Saints Salatiga	26	605:40	33.1	28.9	38.1	69	7.85	1.54	0.19	0.50	13.35
Rexy Fernando	Satya Wacana Saints Salatiga	26	438:55	29.8	23.1	35.5	27	1.08	0.96	0.00	0.46	3.23
Nikholas Mahesa R	Tangerang Hawks	6	28:11	0.0	0.0	0.0	0	0.83	0.17	0.00	0.00	0.00
Leonardo Effendy	Tangerang Hawks	25	236:06	59.1	100.0	58.1	57	2.24	0.12	0.20	0.20	2.60
Randika Aprilian	Tangerang Hawks	25	397:33	42.6	33.3	51.9	71	1.64	1.08	0.00	0.32	2.68
Gabriel Batistuta Risky	Tangerang Hawks	23	450:56	36.0	37.9	30.3	55	1.57	0.87	0.00	0.48	6.74
Teddy Apriyana Romadonsyah	Tangerang Hawks	16	312:58	37.7	34.4	40.5	60	3.63	1.63	0.06	0.50	4.31
Danny Ray	Tangerang Hawks	26	724:13	34.3	34.2	34.5	75	2.69	2.19	0.04	0.38	7.62
Ardian Ariadi	Tangerang Hawks	3	4:51	0.0	0.0	0.0	0	0.00	0.33	0.00	0.00	0.00
Winston Swenjaya	Tangerang Hawks	23	233:46	33.9	28.6	41.7	33	1.04	1.13	0.09	0.57	2.39
Andreas Kristian Vieri	Tangerang Hawks	18	189:14	22.9	22.2	33.3	60	1.78	0.17	0.11	0.28	2.11
Habib Tito Aji	Tangerang Hawks	17	214:41	36.4	36.4	36.4	71	1.88	0.65	0.06	0.24	4.06
Fabio Matheus Mailangkay	Tangerang Hawks	19	121:38	18.2	0.0	19.0	50	0.95	0.32	0.00	0.21	0.53
Keefe Fitrano Yoshe	Tangerang Hawks	3	8:56	0.0	0.0	0.0	0	0.00	0.33	0.00	0.00	0.00
Andrew William Lensun	Tangerang Hawks	21	231:20	33.3	26.3	37.9	55	1.19	1.10	0.00	0.33	2.05
Justin Jaya Wiyanto	Tangerang Hawks	1	2:50	0.0	0.0	0.0	0	0.00	1.00	0.00	1.00	0.00
Morakinyo Michael Williams	Tangerang Hawks	16	448:56	42.9	14.3	44.1	60	9.00	1.19	1.13	0.31	12.38
Augustus Lewis Stone Jr.	Tangerang Hawks	13	337:35	47.1	33.3	55.0	73	3.08	3.15	0.31	0.85	21.08
Steven Bernard Lenard Green	Tangerang Hawks	15	461:27	39.7	25.7	51.6	69	6.53	6.00	0.07	1.93	18.93
Nicholas Craig Stover	Tangerang Hawks	13	281:47	41.7	31.1	48.7	77	7.15	2.46	0.31	0.85	17.15
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (team, born_date, city) FROM stdin;
Amartha Hangtuah	17 Februari 2006	Jakarta
Bali United Basketball	15 Februari 1989	Badung, Bali
Bima Perkasa Jogja	1 Desember 1989	Yogyakarta
Borneo Hornbills	25 Oktober 2021	Cibinong, Bogor
Dewa United Banten	15 Oktober 2020	Tangerang
Kesatria Bengawan Solo	13 Januari 2023	Solo
Pacific Caesar Surabaya	8 Mei 1968	Surabaya
Pelita Jaya Jakarta	20 Mei 1987	Jakarta
Prawira Harum Bandung	30 Mei 2018	Bandung
Rajawali Medan	3 Maret 2003	Medan
RANS Simba Bogor	30 Mei 2003	Bogor
Satria Muda Pertamina	28 Oktober 1993	Jakarta
Satya Wacana Saints Salatiga	1 Agustus 2007	Semarang
Tangerang Hawks	17 Juli 2013	Tangerang
\.


--
-- Data for Name: team_standings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_standings (team, game, win, lose, points, rank) FROM stdin;
Dewa United Banten	26	22	4	48	1
Pelita Jaya Jakarta	26	21	5	47	2
Prawira Harum Bandung	26	21	5	47	3
Kesatria Bengawan Solo	26	19	7	45	4
Satria Muda Pertamina	26	19	7	45	5
RANS Simba Bogor	26	16	10	42	6
Bali United Basketball	26	13	13	39	7
Borneo Hornbills	26	11	15	37	8
Rajawali Medan	26	10	16	36	9
Amartha Hangtuah	26	9	17	35	10
Tangerang Hawks	26	8	18	34	11
Satya Wacana Saints Salatiga	26	6	20	32	12
Bima Perkasa Jogja	26	4	22	30	13
Pacific Caesar Surabaya	26	3	23	29	14
\.


--
-- Data for Name: venue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venue (venue, team, address) FROM stdin;
GOR Universitas Negeri Jakarta (UNJ)	Amartha Hangtuah	Jl. Pemuda No.10, Rawamangun, Jakarta
GOR Purna Krida	Bali United Basketball	Jl. Raya Kerobokan No.11, Kerobokan Kaja, Kec. Kuta Utara, Kabupaten Badung, Bali
Among Rogo Sports Hall	Bima Perkasa Jogja	Semaki, Umbulharjo, Yogyakarta City, Special Region of Yogyakarta?
GOR Laga Tangkas	Borneo Hornbills	Pakansari, Cibinong, Bogor, Jawa Barat
Dewa United Arena	Dewa United Banten	Jl. Raya Pagedangan, Cicalengka, Kec. Pagedangan, Kabupaten Tangerang, Banten
Sritex Arena	Kesatria Bengawan Solo	Jl. Abiyoso No.21, Sriwedari, Kec. Laweyan, Kota Surakarta, Jawa Tengah
GOR Pacific Caesar	Pacific Caesar Surabaya	Raya Gading Pantai No.4, Dukuh Sutorejo, Kec. Mulyorejo, Surabaya, Jawa Timur
Tennis Indoor Senayan	Pelita Jaya Jakarta	Jl. Pintu Satu Senayan No.B,Tanah Abang, Kota Jakarta Pusat, Jakarta
C-Tra Prawira Arena	Prawira Harum Bandung	Jl. Cikutra No.278, Neglasari, Kec. Cibeunying Kaler, Kota Bandung
GOR Universitas Medan	Rajawali Medan	Jl. Dr. Mansur (belakang gedung CIKAL USU), Medan
Gymnasium Sekolah Vokasi IPB	RANS Simba Bogor	Jl. Raya Dramaga, Babakan, Kec. Dramaga, Kabupaten Bogor
The BritAma Arena	Satria Muda Pertamina	Jl. Raya Kelapa Nias No.6, Klp. Gading Bar., Kec. Klp. Gading, Jkt Utara, Jakarta
GOR Knight Stadium	Satya Wacana Saints Salatiga	Jl. Grand Marina Jalan Ariloka, Tawangsari, Semarang Barat, Semarang
Indoor Stadium Sport Center	Tangerang Hawks	Jl. Dasana Indah, Bojong Nangka, Kec. Klp. Dua, Kabupaten Tangerang, Banten
\.


--
-- Name: match_stats match_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match_stats
    ADD CONSTRAINT match_stats_pkey PRIMARY KEY (home, away);


--
-- Name: official_phone official_phone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.official_phone
    ADD CONSTRAINT official_phone_pkey PRIMARY KEY (name, phone_number);


--
-- Name: official official_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.official
    ADD CONSTRAINT official_pkey PRIMARY KEY (name);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (name);


--
-- Name: player_stats player_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_stats
    ADD CONSTRAINT player_stats_pkey PRIMARY KEY (player, team);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (team);


--
-- Name: team_standings team_standings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_standings
    ADD CONSTRAINT team_standings_pkey PRIMARY KEY (team);


--
-- Name: venue venue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venue
    ADD CONSTRAINT venue_pkey PRIMARY KEY (venue);


--
-- Name: match_stats match_stats_away_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match_stats
    ADD CONSTRAINT match_stats_away_fkey FOREIGN KEY (away) REFERENCES public.team(team);


--
-- Name: match_stats match_stats_home_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match_stats
    ADD CONSTRAINT match_stats_home_fkey FOREIGN KEY (home) REFERENCES public.team(team);


--
-- Name: match_stats match_stats_venue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match_stats
    ADD CONSTRAINT match_stats_venue_fkey FOREIGN KEY (venue) REFERENCES public.venue(venue);


--
-- Name: official_phone official_phone_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.official_phone
    ADD CONSTRAINT official_phone_name_fkey FOREIGN KEY (name) REFERENCES public.official(name);


--
-- Name: official official_team_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.official
    ADD CONSTRAINT official_team_name_fkey FOREIGN KEY (team_name) REFERENCES public.team(team);


--
-- Name: player_stats player_stats_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_stats
    ADD CONSTRAINT player_stats_player_fkey FOREIGN KEY (player) REFERENCES public.player(name);


--
-- Name: player_stats player_stats_team_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_stats
    ADD CONSTRAINT player_stats_team_fkey FOREIGN KEY (team) REFERENCES public.team(team);


--
-- Name: player player_team_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_team_name_fkey FOREIGN KEY (team_name) REFERENCES public.team(team);


--
-- Name: team_standings team_standings_team_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_standings
    ADD CONSTRAINT team_standings_team_fkey FOREIGN KEY (team) REFERENCES public.team(team);


--
-- Name: venue venue_team_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venue
    ADD CONSTRAINT venue_team_fkey FOREIGN KEY (team) REFERENCES public.team(team);


--
-- PostgreSQL database dump complete
--

