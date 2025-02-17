--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: usernames; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.usernames (
    username_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer DEFAULT 99999
);


ALTER TABLE public.usernames OWNER TO freecodecamp;

--
-- Name: usernames_username_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.usernames_username_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usernames_username_id_seq OWNER TO freecodecamp;

--
-- Name: usernames_username_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.usernames_username_id_seq OWNED BY public.usernames.username_id;


--
-- Name: usernames username_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames ALTER COLUMN username_id SET DEFAULT nextval('public.usernames_username_id_seq'::regclass);


--
-- Data for Name: usernames; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.usernames VALUES (22, 'user_1739831196493', 2, 54);
INSERT INTO public.usernames VALUES (29, 'user_1739831977739', 2, 85);
INSERT INTO public.usernames VALUES (21, 'user_1739831196494', 5, 268);
INSERT INTO public.usernames VALUES (28, 'user_1739831977740', 5, 132);
INSERT INTO public.usernames VALUES (20, 'Mike', 7, 1);
INSERT INTO public.usernames VALUES (24, 'user_1739831324521', 2, 739);
INSERT INTO public.usernames VALUES (23, 'user_1739831324522', 5, 370);
INSERT INTO public.usernames VALUES (25, 'a', 0, 99999);
INSERT INTO public.usernames VALUES (31, 'user_1739832046757', 2, 385);
INSERT INTO public.usernames VALUES (30, 'user_1739832046758', 5, 268);
INSERT INTO public.usernames VALUES (27, 'user_1739831539277', 2, 159);
INSERT INTO public.usernames VALUES (26, 'user_1739831539278', 5, 257);
INSERT INTO public.usernames VALUES (33, 'user_1739832080656', 2, 80);
INSERT INTO public.usernames VALUES (32, 'user_1739832080657', 5, 30);
INSERT INTO public.usernames VALUES (35, 'user_1739832138726', 2, 127);
INSERT INTO public.usernames VALUES (34, 'user_1739832138727', 5, 94);
INSERT INTO public.usernames VALUES (37, 'user_1739832143728', 2, 467);
INSERT INTO public.usernames VALUES (36, 'user_1739832143729', 5, 304);


--
-- Name: usernames_username_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.usernames_username_id_seq', 37, true);


--
-- Name: usernames usernames_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames
    ADD CONSTRAINT usernames_pkey PRIMARY KEY (username_id);


--
-- Name: usernames usernames_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames
    ADD CONSTRAINT usernames_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

