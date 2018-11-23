--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auteur; Type: TABLE; Schema: public; Owner: thomas
--

CREATE TABLE public.auteur (
    id_author integer NOT NULL,
    name_author character varying(50),
    code_author character varying(2)
);


ALTER TABLE public.auteur OWNER TO thomas;

--
-- Name: command; Type: TABLE; Schema: public; Owner: thomas
--

CREATE TABLE public.command (
    id_command character varying(50) NOT NULL,
    number_copies integer,
    date_arrive date,
    date_command date
);


ALTER TABLE public.command OWNER TO thomas;

--
-- Name: ouvrage; Type: TABLE; Schema: public; Owner: thomas
--

CREATE TABLE public.ouvrage (
    id_book integer NOT NULL,
    isbn character varying(16),
    edition character varying(50),
    code_title character varying(2),
    id_theme integer,
    title character varying(300),
    number_example integer,
    id_author integer NOT NULL
);


ALTER TABLE public.ouvrage OWNER TO thomas;

--
-- Name: pret; Type: TABLE; Schema: public; Owner: thomas
--

CREATE TABLE public.pret (
    id_pret integer NOT NULL,
    date_start date,
    date_end date,
    is_delay boolean,
    id_subscriber integer NOT NULL,
    id_book integer NOT NULL
);


ALTER TABLE public.pret OWNER TO thomas;

--
-- Name: reservation; Type: TABLE; Schema: public; Owner: thomas
--

CREATE TABLE public.reservation (
    id_reservation integer NOT NULL,
    date_reservation date,
    id_subscriber integer NOT NULL
);


ALTER TABLE public.reservation OWNER TO thomas;

--
-- Name: subscriber; Type: TABLE; Schema: public; Owner: thomas
--

CREATE TABLE public.subscriber (
    id_subscriber integer NOT NULL,
    card_number integer,
    last_name character varying(50),
    email character varying(50),
    first_name character varying(50),
    delay boolean,
    date_start date,
    date_end date
);


ALTER TABLE public.subscriber OWNER TO thomas;

--
-- Name: theme; Type: TABLE; Schema: public; Owner: thomas
--

CREATE TABLE public.theme (
    id_theme integer NOT NULL,
    room character varying(25),
    name_theme character varying(50),
    code_theme character varying(2)
);


ALTER TABLE public.theme OWNER TO thomas;

--
-- Name: vendeur; Type: TABLE; Schema: public; Owner: thomas
--

CREATE TABLE public.vendeur (
    id_vendeur integer NOT NULL,
    type_vendeur character varying(50),
    nom character varying(50),
    id_command character varying(50) NOT NULL
);


ALTER TABLE public.vendeur OWNER TO thomas;

--
-- Data for Name: auteur; Type: TABLE DATA; Schema: public; Owner: thomas
--

COPY public.auteur (id_author, name_author, code_author) FROM stdin;
32515115	Fiodor Dostoïevski	84
19584819	Marcel Proust	89
54757320	Fernando Pessoa	75
10077623	David Simon	18
84781252	H. P. Lovecraft	82
81248607	Jack London	21
7199332	François Truffaut	57
69342567	Arthur Rimbaud	95
58142305	John Steinbeck	77
67950924	Michel Ciment	12
32446285	Pierre Desproges	15
63202137	Pierre Bottero	84
79179397	Christelle Dabos	76
61445295	Jean-Philippe Jaworski	90
36775052	Bill Bryson	86
77794554	Roberto Bolaño	52
9565235	Don Winslow	14
35619622	Edgar Allan Poe	88
29752402	Howard Zinn	66
62261016	Patrick Ness	79
29926390	Pat Conroy	94
23107722	Andreï Tarkovski	95
51822193	Joseph Kessel	89
9630132	Wajdi Mouawad	79
87156041	Vladimir Nabokov	63
29185754	Art Spiegelman	30
21423475	Isaac Asimov	45
78562322	Jared Diamond	90
83668570	Robin Hobb	26
20461265	George Orwell	41
60543766	Alain Damasio	77
23322248	Jaume Cabre	52
61717193	William Faulkner	36
41433409	Stefan Zweig	66
19707466	Robert Musil	33
37843499	Claude Ponti	33
88822631	Patrick Rothfuss	10
40436500	Terry Pratchett	56
87759763	Georges Perec	32
5295041	David Gemmell	57
97939436	Karine Giebel	11
8324635	Eiji Yoshikawa	92
87554898	Dante Alighieri	36
82199548	John Milton	94
92800455	Friedrich Nietzsche	12
18413075	M. Aguéev	40
38077086	J.R.R. Tolkien	96
84532349	Gérard de Nerval	43
49799232	Arthur Schopenhauer	45
32655281	Louis Calaferte	75
64397382	Stéphane Mallarmé	44
44256098	Elie Wiesel	40
75186882	Timothée de Fombelle	23
14334689	Jeffrey Eugenides	77
34593732	Aleksandr Sergueïevitch Pouchkine	90
8295857	Romain Gary (Émile Ajar)	41
9597097	Sidney Lumet	97
41385565	Andrus Kivirähk	11
41742867	Daniel Arasse	15
20341636	Alexandre Dumas	76
42665652	Frank Conroy	99
72114286	Johann Wolfgang von Goethe	50
6620356	Raymond Elias Feist	78
27175576	Jon Krakauer	49
4142100	Charles Baudelaire	78
88434699	Comte de Lautréamont (Isidore Ducasse)	93
97698161	Mark Z. Danielewski	21
85204848	Greg Egan	41
57344248	Louis-Ferdinand Céline	57
39771347	Ken Kesey	33
94739578	Ivan Gontcharov	30
92469521	Henri Laborit	49
84861941	Sîn-lēqi-unninni	66
35104353	William Blake	26
61702664	Louis Aragon	74
58323152	Sorj Chalandon	51
74874610	Tristan Egolf	19
71149727	Harper Lee	25
45880211	William Shakespeare	35
59877669	Gabrielle Clark	36
\.


--
-- Data for Name: command; Type: TABLE DATA; Schema: public; Owner: thomas
--

COPY public.command (id_command, number_copies, date_arrive, date_command) FROM stdin;
\.


--
-- Data for Name: ouvrage; Type: TABLE DATA; Schema: public; Owner: thomas
--

COPY public.ouvrage (id_book, isbn, edition, code_title, id_theme, title, number_example, id_author) FROM stdin;
23610190	8479661314403	AYOUBA&co	Le	56115562	Les Démons	3	32515115
71312534	7032597336204	PornHub	Le	5214335	Les Frères Karamazov	2	32515115
46520312	7618416481493	FREDO l'AGLO	Al	5214335	Albertine disparue	6	19584819
43228582	7135406164037	UNICORN	Le	13602041	Le Livre de l intranquillité	9	54757320
22837152	8451328560939	FREDO l'AGLO	Ba	5214335	Baltimore	5	10077623
42475956	4012762215836	PONEY	Œu	99134283	Œuvres de H.P. Lovecraft, tome 2	6	84781252
5580841	8587357509694	FREDO l'AGLO	Ma	5214335	Martin Eden	9	81248607
47438017	5483784618944	PONEY	Hi	99134283	Hitchcock / Truffaut	5	7199332
78047317	6453958535394	PONEY	Po	5214335	Poésie, Une saison en enfer, Illuminations	8	69342567
3684634	8172137341185	AYOUBA&co	À 	99134283	À l est d Eden	8	58142305
95759561	8054005870967	UNICORN	Ku	96255916	Kubrick	9	67950924
51864979	9458778578025	Jacky et michmich	Cr	5214335	Crime et Châtiment	6	32515115
82373698	4226040643900	FREDO l'AGLO	To	5214335	Tout Desproges	2	32446285
17499875	3078954286653	Jacky et michmich	Le	5214335	Le Pacte des Marchombres : L Intégrale	1	63202137
80606021	4747876038894	Jacky et michmich	Le	13602041	Les Disparus du Clairdelune - La Passe-Miroir, tome 2	3	79179397
4830414	7965190319723	Jacky et michmich	Ga	5214335	Gagner la guerre	6	61445295
99951106	3324341680172	Jacky et michmich	Un	99134283	Une histoire de tout ou presque	9	36775052
38304457	2304812155853	Jacky et michmich	Le	56115562	Le Bateau ivre	2	69342567
43961285	1758924594972	FREDO l'AGLO	Le	5214335	Les Détectives sauvages	5	77794554
37870050	9008278402893	AYOUBA&co	La	99134283	La Griffe du chien	3	9565235
56773911	6076158762827	Jacky et michmich	Un	96255916	Une saison en enfer	9	69342567
52596077	3076775323044	FREDO l'AGLO	Le	5214335	Les Contes macabres	5	35619622
9611850	8933152656331	AYOUBA&co	Le	56115562	Le Corbeau	7	35619622
21715286	5890359717660	Playboy	Un	13602041	Une Histoire populaire des Etats Unis	4	29752402
16189071	2720305084098	Playboy	Qu	96255916	Quelques minutes après minuit	7	62261016
13693137	4997114331366	Jacky et michmich	Le	5214335	Le Prince des marées	6	29926390
38133130	1553538965522	UNICORN	Le	13602041	Le Temps scellé	9	23107722
54227605	4683826924965	PornHub	Le	56115562	Les cavaliers	2	51822193
41014082	7201490941662	AYOUBA&co	L 	13602041	L Idiot	9	32515115
61321231	7944539979094	AYOUBA&co	An	56115562	Anima	4	9630132
71616824	4302471970544	PONEY	Ad	56115562	Ada ou l ardeur	3	87156041
19565264	6621529641658	PornHub	Me	5214335	MetaMaus	8	29185754
23104761	3130149227400	UNICORN	Le	96255916	Le cycle de Fondation	9	21423475
70703180	3795729337353	Jacky et michmich	De	56115562	De l inégalité parmi les sociétés	1	78562322
87753280	6112088303455	Jacky et michmich	La	99134283	La Citadelle des ombres 1 - L Assassin royal, intégrale 1	2	83668570
48711359	2188848789359	AYOUBA&co	19	99134283	1984	7	20461265
15897323	5244520358697	Playboy	La	5214335	La Horde du Contrevent	2	60543766
54131466	1882744332208	UNICORN	Co	56115562	Confiteor	8	23322248
83582876	3616075789261	UNICORN	Te	13602041	Textes de scène	6	32446285
44111808	5248942852949	FREDO l'AGLO	Fo	56115562	Fondation foudroyée - Le Cycle de Fondation, tome 2	6	21423475
14790964	9537366755777	AYOUBA&co	Lu	96255916	Lumière d août	2	61717193
84360380	6066691411436	Jacky et michmich	In	5214335	Incendies	1	9630132
42218269	3776657016218	UNICORN	Le	96255916	Le Monde d hier	8	41433409
18869760	8002876758926	AYOUBA&co	L 	5214335	L Homme sans qualités, tome 1	5	19707466
65696263	5410389403471	PornHub	Ma	96255916	Ma vallée	5	37843499
92603752	8507937072235	FREDO l'AGLO	Le	56115562	Le Nom du vent	4	88822631
18661617	9754423159624	PONEY	L 	56115562	L arbre sans fin	7	37843499
57633354	2449230567022	AYOUBA&co	26	56115562	2666	7	77794554
49432048	4075096669492	FREDO l'AGLO	Ro	96255916	Ronde de nuit	6	40436500
80104694	3571985085059	PONEY	Le	99134283	Le Cœur révélateur	6	35619622
7345616	5557271310545	PONEY	Es	96255916	Espèces d espaces	2	87759763
87802569	5286048107107	Jacky et michmich	La	13602041	La Chute des rois - Troie, tome 3	9	5295041
80393236	6637652932890	FREDO l'AGLO	Me	96255916	Meurtres pour rédemption	5	97939436
57954804	8289097111361	PornHub	La	99134283	La Parfaite Lumière	7	8324635
90747030	2414493565137	UNICORN	Ch	96255916	Chroniques de la haine ordinaire, tome 1	1	32446285
35099178	1264901418299	FREDO l'AGLO	L 	96255916	L Enfer	1	87554898
95267665	4047674606177	Jacky et michmich	Le	96255916	Le Paradis perdu	2	82199548
7377126	4300166106938	Playboy	Le	5214335	Les Réquisitoires du Tribunal des flagrants délires	3	32446285
12561259	7149765084767	PONEY	La	5214335	La Tempête	1	37843499
52624895	1445996340014	PONEY	Le	5214335	Le Bouclier du tonnerre - Troie, tome 2	2	5295041
28523600	7982963873477	Jacky et michmich	La	96255916	La Citadelle des ombres 2 - L Assassin royal, intégrale 2	6	83668570
66257567	3756671637396	FREDO l'AGLO	La	96255916	La Divine Comédie	4	87554898
58215258	7388809736017	FREDO l'AGLO	Le	99134283	Le Gai Savoir	3	92800455
28041835	8682374428351	Jacky et michmich	Ro	96255916	Roman avec cocaïne	9	18413075
50265909	7543774367947	PONEY	Le	13602041	Le Seigneur des Anneaux : Les Deux Tours	6	38077086
76097611	5963933616895	AYOUBA&co	Il	13602041	Illuminations	4	69342567
10687266	2900400306597	Playboy	Le	13602041	Les Chimères	8	84532349
46399716	9788974850843	PONEY	Le	99134283	Le monde comme volonté et comme représentation	1	49799232
82451874	1239719584804	Playboy	Fo	96255916	Fouché	8	41433409
80543159	3426812246105	AYOUBA&co	Se	56115562	Septentrion	3	32655281
76255869	2570109207383	UNICORN	Un	96255916	Un coup de dés jamais n abolira le hasard	9	64397382
67780036	2941815364697	PONEY	Bl	56115562	Blaise et le château d Anne Hiversère	7	37843499
31756631	8818115824846	Playboy	Pé	5214335	Pétronille et ses 120 petits	4	37843499
39027385	3325405231034	FREDO l'AGLO	La	96255916	La Peur du sage	6	88822631
17308472	3722272840742	FREDO l'AGLO	La	5214335	La Nuit	1	44256098
2985531	6629213705349	PONEY	Un	99134283	Un prince sans royaume - Vango tome 2	3	75186882
6836449	8625482485169	Playboy	Le	13602041	Le Seigneur des Anneaux : La Communauté de l anneau	8	38077086
84156164	4597024388742	FREDO l'AGLO	Mi	13602041	Middlesex	4	14334689
73650618	2591157842143	Playboy	Eu	5214335	Eugène Onéguine	1	34593732
50942042	2511389631786	AYOUBA&co	Le	13602041	Les Cerfs-volants	6	8295857
80801882	9828197339819	AYOUBA&co	Fa	96255916	Faire un film	1	9597097
56491515	3933053956890	FREDO l'AGLO	L 	96255916	L homme qui savait la langue des serpents	1	41385565
36026303	4728047308283	UNICORN	Hi	13602041	Histoires de peintures	2	41742867
59905265	6079316622664	FREDO l'AGLO	Le	99134283	Les Raisins de la colère	9	58142305
7242020	7123102969834	Playboy	Le	99134283	Le Comte de Monte-Cristo	1	20341636
93207298	6513538218450	AYOUBA&co	Co	96255916	Corps et âme	5	42665652
9726219	9103428069650	AYOUBA&co	Fa	5214335	Faust I et II	6	72114286
32604558	1678982784644	PornHub	Pa	13602041	Pair de l Empire - La Trilogie de l Empire, tome 2	7	6620356
50457495	4314215537198	UNICORN	Tr	96255916	Tragédie à l Everest	3	27175576
80152792	6571488926127	UNICORN	Le	5214335	Les Fleurs du mal	8	4142100
5931813	5791755993957	Jacky et michmich	Le	99134283	Les Chants de Maldoror	5	88434699
35581698	6936189309994	PONEY	La	56115562	La Maison des Feuilles	3	97698161
65346791	3203123341952	Playboy	Le	99134283	Les Carnets du sous-sol	3	32515115
98298530	7163634827657	Playboy	Ax	56115562	Axiomatique	2	85204848
88228708	2098921731133	PornHub	Mo	5214335	Mort à crédit	2	57344248
68138087	8936259288548	Playboy	Vo	13602041	Vol au-dessus d un nid de coucou	5	39771347
80116941	2442339485808	Playboy	Ho	5214335	Hommage à la Catalogne	1	20461265
56027979	1357372049564	AYOUBA&co	Ob	5214335	Oblomov	5	94739578
19196700	8682633066605	FREDO l'AGLO	El	5214335	Eloge de la fuite	3	92469521
89114723	8943990613033	Playboy	L 	13602041	L Epopée de Gilgamesh	8	84861941
39462660	5027188473693	Playboy	Ti	5214335	Timbré	8	40436500
22266150	6115476261817	Playboy	Ch	5214335	Chasse royale I - Rois du monde, tome 2	5	61445295
1473403	3216142510764	UNICORN	Le	56115562	Le Mariage du Ciel et de l Enfer	7	35104353
77670016	5139051313976	PornHub	Le	99134283	Le Seigneur de l arc d argent - Troie, tome 1	3	5295041
94411395	6385382789484	PONEY	Au	99134283	Aurélien	1	61702664
57263164	4710617852626	Jacky et michmich	Le	56115562	Le Quatrième Mur	1	58323152
52903223	9403454473344	AYOUBA&co	Le	13602041	Le Seigneur des porcheries	2	74874610
18357688	7012318703707	Playboy	Pr	56115562	Prélude à Trantor - Le Grand Livre des robots, tome 1	2	21423475
38122437	6340968184282	AYOUBA&co	Ne	56115562	Ne tirez pas sur l oiseau moqueur	6	71149727
35724897	2866500986854	UNICORN	Ha	99134283	Hamlet	6	45880211
70650884	4611744385962	UNICORN	La	13602041	La Pierre et le Sabre	4	8324635
40285385	3600700356323	FREDO l'AGLO	Ti	99134283	Time of Each	9	59877669
\.


--
-- Data for Name: pret; Type: TABLE DATA; Schema: public; Owner: thomas
--

COPY public.pret (id_pret, date_start, date_end, is_delay, id_subscriber, id_book) FROM stdin;
\.


--
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: thomas
--

COPY public.reservation (id_reservation, date_reservation, id_subscriber) FROM stdin;
\.


--
-- Data for Name: subscriber; Type: TABLE DATA; Schema: public; Owner: thomas
--

COPY public.subscriber (id_subscriber, card_number, last_name, email, first_name, delay, date_start, date_end) FROM stdin;
\.


--
-- Data for Name: theme; Type: TABLE DATA; Schema: public; Owner: thomas
--

COPY public.theme (id_theme, room, name_theme, code_theme) FROM stdin;
56115562	3	Pour adulte	Po
5214335	5	Bd	Bd
13602041	4	Horreur	Ho
99134283	1	Porno	Po
96255916	3	Licornes	Li
\.


--
-- Data for Name: vendeur; Type: TABLE DATA; Schema: public; Owner: thomas
--

COPY public.vendeur (id_vendeur, type_vendeur, nom, id_command) FROM stdin;
\.


--
-- Name: auteur auteur_pkey; Type: CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.auteur
    ADD CONSTRAINT auteur_pkey PRIMARY KEY (id_author);


--
-- Name: command command_pkey; Type: CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT command_pkey PRIMARY KEY (id_command);


--
-- Name: ouvrage ouvrage_pkey; Type: CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.ouvrage
    ADD CONSTRAINT ouvrage_pkey PRIMARY KEY (id_book);


--
-- Name: pret pret_pkey; Type: CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.pret
    ADD CONSTRAINT pret_pkey PRIMARY KEY (id_pret);


--
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (id_reservation);


--
-- Name: subscriber subscriber_pkey; Type: CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.subscriber
    ADD CONSTRAINT subscriber_pkey PRIMARY KEY (id_subscriber);


--
-- Name: theme theme_pkey; Type: CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.theme
    ADD CONSTRAINT theme_pkey PRIMARY KEY (id_theme);


--
-- Name: vendeur vendeur_pkey; Type: CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.vendeur
    ADD CONSTRAINT vendeur_pkey PRIMARY KEY (id_vendeur);


--
-- Name: ouvrage ouvrage_id_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.ouvrage
    ADD CONSTRAINT ouvrage_id_author_fkey FOREIGN KEY (id_author) REFERENCES public.auteur(id_author);


--
-- Name: pret pret_id_book_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.pret
    ADD CONSTRAINT pret_id_book_fkey FOREIGN KEY (id_book) REFERENCES public.ouvrage(id_book);


--
-- Name: pret pret_id_subscriber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.pret
    ADD CONSTRAINT pret_id_subscriber_fkey FOREIGN KEY (id_subscriber) REFERENCES public.subscriber(id_subscriber);


--
-- Name: reservation reservation_id_subscriber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_id_subscriber_fkey FOREIGN KEY (id_subscriber) REFERENCES public.subscriber(id_subscriber);


--
-- Name: vendeur vendeur_id_command_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thomas
--

ALTER TABLE ONLY public.vendeur
    ADD CONSTRAINT vendeur_id_command_fkey FOREIGN KEY (id_command) REFERENCES public.command(id_command);


--
-- PostgreSQL database dump complete
--

