--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Homebrew)
-- Dumped by pg_dump version 14.12 (Homebrew)

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
-- Name: products; Type: TABLE; Schema: public; Owner: ekaaprawira
--

CREATE TABLE public.products (
    name character varying(255) NOT NULL,
    price numeric
);


ALTER TABLE public.products OWNER TO ekaaprawira;

--
-- Name: shipping_info; Type: TABLE; Schema: public; Owner: ekaaprawira
--

CREATE TABLE public.shipping_info (
    product_name character varying(255),
    pick_up text,
    arrival text
);


ALTER TABLE public.shipping_info OWNER TO ekaaprawira;

--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: ekaaprawira
--

COPY public.products (name, price) FROM stdin;
Black Multicolor Mushroom Forest Coir Doormat	1699
Coir Rope Knot Doormat	2999
Red Cherry Shaped Indoor Outdoor Throw Pillow	2999
Olive Green Embroidered Cranes Throw Pillow	2999
This Is Fine Talking Figurine Mini Kit	1395
Dutton Round Marble Top and Gold Metal Side Table	7999
Green Avocado Shaped Tufted Indoor Outdoor Throw Pillow	2999
Natural Green Marble Fluted Trinket Box	2499
Kenwick Round Marble Top and Wood Nesting Tables 2 Piece Set	39999
Keogh's Truffle and Irish Butter Potato Chips Snack Size	149
Antique Gold Metal Orb Taper Candle Holder	1299
Copper Patina Metal Floor Planter	4999
Twig Serving Spoon	799
Lorna Tonal Solid Color Recycled Area Rug	9999
Fall Fragrance Reed Diffuser	1799
The Republic of Tea Tangerine Yuzu Cold Brew Tea 6 Count	1199
Green Hand Painted Floral Wall Mirror	14999
Cafe Mexicano Veracruz Reserve Ground Coffee	1199
Round Enameled Cast Iron Dutch Oven 5 Quart	5999
Dansen Umber Brown Wood Low Back Dining Armchair	19999
Gold Modern Cocktail Flatware Collection	299
Claudius Sand Chenille Scatter Back Pillow Sofa	99999
Yellow Metal Flower Figural 2 Light Floor Lamp	19999
Green Boucle Fabric Pumpkin Decor	799
Bonne Maman Chocolate Shortbread Cookies 14 Pack	749
Natural Rubber Wood Slotted Spoon	799
\.


--
-- Data for Name: shipping_info; Type: TABLE DATA; Schema: public; Owner: ekaaprawira
--

COPY public.shipping_info (product_name, pick_up, arrival) FROM stdin;
Black Multicolor Mushroom Forest Coir Doormat	Pick UpToday Today	Arrives in 4-10 Days
Coir Rope Knot Doormat	Pick UpToday Today	Arrives in 4-10 Days
Red Cherry Shaped Indoor Outdoor Throw Pillow	Pick UpToday Today	Arrives in 4-10 Days
Olive Green Embroidered Cranes Throw Pillow	Pick UpToday Today	Arrives in 4-10 Days
This Is Fine Talking Figurine Mini Kit	Pick UpToday Today	Arrives in 4-10 Days
Dutton Round Marble Top and Gold Metal Side Table	Pick Up in7-14 Days 7-14 Days	Arrives in 9-19 Days
Green Avocado Shaped Tufted Indoor Outdoor Throw Pillow	Pick UpToday Today	Arrives in 4-10 Days
Natural Green Marble Fluted Trinket Box	Pick UpToday Today	Arrives in 4-10 Days
Kenwick Round Marble Top and Wood Nesting Tables 2 Piece Set	Pick Up in7-14 Days 7-14 Days	Arrives in 9-19 Days
Keogh's Truffle and Irish Butter Potato Chips Snack Size	Pick UpToday Today	N/A
Antique Gold Metal Orb Taper Candle Holder	Pick UpToday Today	Arrives in 4-10 Days
Copper Patina Metal Floor Planter	Pick UpToday Today	Arrives in 4-10 Days
Twig Serving Spoon	Pick UpToday Today	Arrives in 4-10 Days
Lorna Tonal Solid Color Recycled Area Rug	Pick UpToday Today	Arrives in 4-10 Days
Fall Fragrance Reed Diffuser	Pick UpToday Today	Arrives in 4-10 Days
The Republic of Tea Tangerine Yuzu Cold Brew Tea 6 Count	Pick UpToday Today	Arrives in 4-10 Days
Green Hand Painted Floral Wall Mirror	Pick Up in7-14 Days 7-14 Days	Arrives in 4-10 Days
Cafe Mexicano Veracruz Reserve Ground Coffee	Pick UpToday Today	Arrives in 4-10 Days
Round Enameled Cast Iron Dutch Oven 5 Quart	Pick UpToday Today	Arrives in 4-10 Days
Dansen Umber Brown Wood Low Back Dining Armchair	Pick Up in7-14 Days 7-14 Days	Arrives in 4-10 Days
Gold Modern Cocktail Flatware Collection	Pick UpToday Today	Arrives in 4-10 Days
Claudius Sand Chenille Scatter Back Pillow Sofa	Pick Up in7-14 Days 7-14 Days	Arrives in 9-19 Days
Yellow Metal Flower Figural 2 Light Floor Lamp	Pick Up in7-14 Days 7-14 Days	Arrives in 4-10 Days
Green Boucle Fabric Pumpkin Decor	Pick UpToday Today	Arrives in 4-10 Days
Bonne Maman Chocolate Shortbread Cookies 14 Pack	Pick UpToday Today	N/A
Natural Rubber Wood Slotted Spoon	Pick UpToday Today	Arrives in 4-10 Days
\.


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: ekaaprawira
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (name);


--
-- Name: shipping_info unique_product_name; Type: CONSTRAINT; Schema: public; Owner: ekaaprawira
--

ALTER TABLE ONLY public.shipping_info
    ADD CONSTRAINT unique_product_name UNIQUE (product_name);


--
-- Name: shipping_info shipping_info_product_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ekaaprawira
--

ALTER TABLE ONLY public.shipping_info
    ADD CONSTRAINT shipping_info_product_name_fkey FOREIGN KEY (product_name) REFERENCES public.products(name);


--
-- PostgreSQL database dump complete
--

