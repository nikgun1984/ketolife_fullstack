--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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

DROP DATABASE keto_life;
--
-- Name: keto_life; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE keto_life WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


\connect keto_life

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
-- Name: ingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingredients (
    id integer NOT NULL,
    name text NOT NULL,
    image text,
    recipe_id integer
);


--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ingredients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ingredients_id_seq OWNED BY public.ingredients.id;


--
-- Name: instructions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instructions (
    id integer NOT NULL,
    step_no integer NOT NULL,
    step text NOT NULL,
    recipe_id integer
);


--
-- Name: instructions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.instructions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instructions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.instructions_id_seq OWNED BY public.instructions.id;


--
-- Name: nutrients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.nutrients (
    id integer NOT NULL,
    name text NOT NULL,
    unit_id integer
);


--
-- Name: nutrients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.nutrients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nutrients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.nutrients_id_seq OWNED BY public.nutrients.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text,
    image text,
    net_carbs double precision,
    product_type text,
    calories text
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: recipe_has_nutrients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipe_has_nutrients (
    id integer NOT NULL,
    recipe_id integer NOT NULL,
    nutrient_id integer NOT NULL,
    total_daily integer NOT NULL,
    total_nutrients integer NOT NULL
);


--
-- Name: recipe_has_nutrients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipe_has_nutrients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipe_has_nutrients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipe_has_nutrients_id_seq OWNED BY public.recipe_has_nutrients.id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipes (
    id integer NOT NULL,
    title text NOT NULL,
    image text,
    servings integer,
    tcook integer,
    cuisine text,
    mealtype text,
    dishtype text,
    source text,
    url text,
    user_id integer,
    calories double precision
);


--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.units (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    email text NOT NULL,
    image_url text
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: ingredients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN id SET DEFAULT nextval('public.ingredients_id_seq'::regclass);


--
-- Name: instructions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instructions ALTER COLUMN id SET DEFAULT nextval('public.instructions_id_seq'::regclass);


--
-- Name: nutrients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nutrients ALTER COLUMN id SET DEFAULT nextval('public.nutrients_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: recipe_has_nutrients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipe_has_nutrients ALTER COLUMN id SET DEFAULT nextval('public.recipe_has_nutrients_id_seq'::regclass);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Name: units id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ingredients (id, name, image, recipe_id) FROM stdin;
21	2 small salmon fillets (240 g/ 8.5 oz)	https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg	6
22	1 tbsp ghee (you can make your own)	https://www.edamam.com/food-img/2b5/2b504c036c64481b224c9d74cc4a82e0.jpg	6
23	1 small red onion (60 g/ 2.1 oz)	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	6
24	1/2 cup pecans or walnuts (50 g/ 1.8 oz)	https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg	6
25	2 tbsp mayonnaise (30 g/ 1.1 oz) - you can make your own	https://www.jocooks.com/wp-content/uploads/2020/03/homemade-mayonnaise-1-6.jpg	6
26	1/2 cup cream cheese (120 g/ 4.2 oz)	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	6
27	2 cloves garlic	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	6
28	3 tbsp freshly chopped parsley	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	6
29	½ tsp salt (I like pink Himalayan)	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	6
30	ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	6
31	1 can full fat coconut milk (375 grams)	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	7
32	¼ cup egg-white protein powder (20 grams)	https://www.edamam.com/food-img/76a/76ab108398f84ad08fe841d3409ab70a.jpg	7
33	2 tablespoons ground chia seeds (20 grams)	https://www.edamam.com/food-img/bcc/bcc6e6bf3175772ad00b414636467257.jpg	7
34	½ teaspoon vanilla stevia	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	7
35	&frac13; cup chopped 85% dark chocolate (50 grams)	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	7
36	2-3 cups ice	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	7
37	3 cups blanched almond flour (not almond meal)	/static/images/ing.png	8
38	2 tablespoons egg white protein powder	https://www.edamam.com/food-img/76a/76ab108398f84ad08fe841d3409ab70a.jpg	8
39	1 teaspoon cream of tartar	https://www.edamam.com/food-img/1c0/1c002c4edc6959ef265036bdf3582885.jpg	8
40	½ teaspoon baking soda	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	8
41	¼ teaspoon celtic sea salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	8
42	6 large eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	8
43	1 tablespoon lemon zest	https://www.edamam.com/food-img/540/5405605c8e9b284243f06c0b1587ab6f.jpg	8
44	½ teaspoon vanilla stevia	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	8
45	1 cup blueberries, fresh or frozen	https://www.edamam.com/food-img/f55/f55705a2a9ea9f7abf449a05fa968139.png	8
46	2 oz. Mixed Greens	https://www.edamam.com/food-img/b6d/b6d9f3052d27a3c71220cfa55c6f0a42.jpg	9
47	3 tbsp. Pine Nuts, roasted	https://www.edamam.com/food-img/52f/52fa29cb9d1ab6502f137a98c8a63f09.jpg	9
48	2 tbsp. 5 Minute Keto Raspberry Vinaigrette (recipe here)	https://www.edamam.com/food-img/241/24178db68d42001caf980f8f209534cb.jpg	9
49	2 tbsp. Shaved Parmesan	https://www.edamam.com/food-img/f58/f588658627c59d5041e4664119829aa9.jpg	9
50	2 slices Bacon	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	9
51	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	9
52	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	9
53	2 large eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	10
54	6 large egg whites	/static/images/ing.png	10
55	2 tbs coconut flour	/static/images/ing.png	10
56	1 tbs psyllium husk or ground chia seeds	/static/images/ing.png	10
57	90ml / 3 fl oz coconut milk, cream or almond milk	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	10
58	½ tsp baking soda	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	10
59	1 tsp cream of tartar	https://www.edamam.com/food-img/1c0/1c002c4edc6959ef265036bdf3582885.jpg	10
60	2 tbs ghee or coconut oil	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	10
61	2 tsp garlic powder (omit if making a sweet keto crepe and add sweetener to taste instead)	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	10
62	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	10
63	1 serving Keto Chocolate Cake Mix	/static/images/ing.png	11
64	2 tablespoons carton egg whites—or 1 large egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	11
65	2 tablespoons carton egg whites—or 1 large egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	11
66	1 tablespoon sour cream—or Greek yogurt	/static/images/ing.png	11
67	1/4-1/2 teaspoon vanilla extract, to taste	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	11
68	1/2 tablespoon unfiltered extra virgin olive oil (optional)	/static/images/ing.png	11
69	1 tablespoon water—or heavy cream, if needed	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	11
70	1 cup Blueberries, fresh	https://www.edamam.com/food-img/f55/f55705a2a9ea9f7abf449a05fa968139.png	12
71	2 fl oz Water, tap	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	12
72	.25 tsp Morton's Kosher Salt (substitute 2 TBSP of Stevia if you'd like a sweeter filling, there are no carb counts for either so nutrition information for Keto diet would stay the same)	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	12
73	.5 tsp Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	12
74	.25 tsp Cinnamon, ground	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	12
75	8 oz Cream Cheese	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	12
76	2 medium large flat mushrooms such as Portobello (150 g / 5.3 oz)	https://www.edamam.com/food-img/1d1/1d1c4ddab32a060beb26396fa999b1e1.jpg	13
77	1 tbsp ghee or coconut oil (you can make your own)	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	13
78	1-2 tbsp freshly chopped basil or 1 tsp dried	https://www.edamam.com/food-img/5f1/5f1b05685ac2b404236a5d1c1f3c8c10.jpg	13
79	1 tbsp freshly chopped oregano or ½ tsp dried	https://www.edamam.com/food-img/1b0/1b0eaffb1c261606e0d82fed8e9747a7.jpg	13
80	1 clove garlic, crushed	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	13
81	¼ tsp salt or more to taste (I like pink Himalayan)	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	13
82	freshly ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	13
83	2 keto buns (recipe for my Ultimate Keto Buns is here)	https://www.edamam.com/food-img/dbe/dbe3d135d1336ed19703d359e33d58dd.jpg	13
84	2 tbsp mayonnaise - you can make your own	/static/images/ing.png	13
85	2 large eggs, free-range or organic	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	13
86	2 slices hard cheese such as cheddar or gouda (40 g / 1.4 oz)	/static/images/ing.png	13
87	1 cup mixed lettuce	https://www.edamam.com/food-img/b6d/b6d9f3052d27a3c71220cfa55c6f0a42.jpg	13
88	2 cups Almond Flour	/static/images/ing.png	14
89	1 teaspoon Garlic Powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	14
90	¼ teaspoons Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	14
91	¼ teaspoons Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	14
92	4 Large Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	14
93	1 cup Shredded Cheddar Cheese	/static/images/ing.png	14
94	¼ cups Melted Butter	/static/images/ing.png	14
95	1 stick Butter, Cut Into 1-Tablespoon Slices	/static/images/ing.png	14
96	4 slices Thick Cut Bacon, Cooked And Crumbled	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	14
97	1/2 Cup (8 tbs) Apple cider vinegar	https://www.edamam.com/food-img/c7d/c7dbd1846c5d08e9739930d70a404d50.jpg	15
98	1/2 Cup (8 tbs) Water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	15
99	2 Tablespoon Real butter	/static/images/ing.png	15
100	6 Ounce (1 can) Canned tomato paste	/static/images/ing.png	15
101	1 Teaspoon Garlic powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	15
102	1 Teaspoon Onion powder	https://www.edamam.com/food-img/1e7/1e73e6f5dd96bb233abc0fcc05fb0ec8.jpg	15
103	1 Teaspoon Dry yellow mustard	https://www.edamam.com/food-img/e23/e238f2e4cfa6aa1a30f46dc73e7344eb.jpg	15
104	1 Tablespoon Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	15
105	1 Teaspoon (optional) Cayenne pepper	https://www.edamam.com/food-img/374/3742b9434a0fb66a45e0dd6d227ba669.jpg	15
106	1 Teaspoon (optional) Liquid smoke flavoring	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	15
107	1 Kilogram Chicken wings	https://www.edamam.com/food-img/f92/f928682fc890edded472c5d8baeffed5.jpg	15
108	To Taste Pink salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	15
109	To Taste Freshly ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	15
110	1 cup blanched almond flour	/static/images/ing.png	16
111	3 tablespoons coconut flour	/static/images/ing.png	16
112	2 teaspoons xanthan gum	/static/images/ing.png	16
113	1 teaspoon baking powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	16
114	1 pinch salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	16
115	2 teaspoons apple cider vinegar	https://www.edamam.com/food-img/c7d/c7dbd1846c5d08e9739930d70a404d50.jpg	16
116	1 egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	16
117	3 tablespoons water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	16
118	cooking spray	/static/images/ing.png	16
119	1/2 medium onion, diced or finely chopped	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	17
120	2 cups (7 oz or 200 g) green beans, diced	https://www.edamam.com/food-img/891/89135f10639878a2360e6a33c9af3d91.jpg	17
121	1.5 Tablespoons (10 g) curry powder	https://www.edamam.com/food-img/9ce/9ce02a2887385fd2adaec8dd8adcf9c5.jpg	17
122	1 teaspoon (3 g) garlic powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	17
123	Cream from the top of 1 (14-oz) can of coconut milk	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	17
124	2 cups (480 ml) bone broth	/static/images/ing.png	17
125	1 lb (450 g) of raw salmon, diced (defrost first if frozen)	https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg	17
126	2 Tablespoons (30 ml) coconut oil, to cook with	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	17
127	Salt and pepper, to taste	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	17
128	Salt and pepper, to taste	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	17
129	2 Tablespoons basil (4 g), chopped, for garnish	https://www.edamam.com/food-img/5f1/5f1b05685ac2b404236a5d1c1f3c8c10.jpg	17
130	3 tablespoons (45ml) coconut oil or avocado oil	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	18
131	1 medium onion, thinly sliced	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	18
132	1 clove garlic	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	18
133	1 tablespoon (15 grams) minced fresh ginger	https://www.edamam.com/food-img/b9c/b9c06ef451ef29513880af0a53ebbaa6.jpg	18
134	1 tablespoon (15 grams) fresh turmeric	https://www.edamam.com/food-img/03e/03eb469286b3caf1ae9c13e4eba13587.jpg	18
135	½ cup (125ml) unsweetened full-fat coconut milk	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	18
136	¼ cup (59ml) water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	18
137	Zest from 1 lime	https://www.edamam.com/food-img/48a/48a123c9576647c4ada6a41df5eeb22a.jpg	18
138	1 tablespoon (15ml) lime juice	https://www.edamam.com/food-img/8f0/8f0c10eb3dbf476a05e61018e76ea220.jpg	18
139	3 cups (226 grams) broccoli, steamed	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	18
140	3 cups (226 grams) cauliflower, steamed	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	18
141	sea salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	18
142	freshly ground pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	18
143	Four 6-ounce wild Alaskan salmon filets	https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg	18
144	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	18
145	freshly ground pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	18
146	¼ cup almond flour (25 g / 0.9 oz)	/static/images/ing.png	19
147	¼ cup flaxmeal (38 g / 1.3 oz)	/static/images/ing.png	19
148	¼ tsp baking soda	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	19
149	1 large egg, free-range or organic	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	19
150	2 tbsp cream or coconut milk	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	19
151	2 tbsp water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	19
152	pinch salt (I like pink Himalayan)	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	19
153	60 g smoked salmon (2.1 oz)	https://www.edamam.com/food-img/c91/c918b85b824c85e231e13a2b831d6d18.gif	19
154	2 tbsp freshly chopped chives or spring onion	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	19
155	serve with 2 dollops full-fat cream cheese or sour cream (60 g / 2.1 oz)	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	19
156	6 4oz, Wild Salmon Filet	https://www.edamam.com/food-img/fa2/fa26601f451b5457c298b22ff2dc001e.jpg	20
157	3 tsp, Rosemary Garlic Seasoning (1/4 tsp per side)	https://www.edamam.com/food-img/c23/c23e20823b442067307aa436969358f1.jpg	20
158	1/3 Cup, Sour cream	https://www.edamam.com/food-img/f9d/f9d6183267b041b0aff9a10b89c9c15f.jpg	20
159	1/3 Tbsp, Mayonnaise	/static/images/ing.png	20
160	1/4 tsp, Dill Weed	https://www.edamam.com/food-img/874/8740aacb8e1a348cd5eead1f0bb552d4.jpg	20
161	1/4 tsp, Garlic Powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	20
162	1/4 tsp, Onion Powder	https://www.edamam.com/food-img/1e7/1e73e6f5dd96bb233abc0fcc05fb0ec8.jpg	20
163	16 oz. Cauliflower	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	21
164	6 oz. Cream Cheese, softened	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	21
165	1-2 tbsp. Rice Vinegar (unseasoned)	https://www.edamam.com/food-img/5f6/5f69b84c399d778c4728e9ab4f8065a2.jpg	21
166	1 tbsp. Soy Sauce (or coconut aminos)	https://www.edamam.com/food-img/f56/f562e461eb0618f367f538b836c17b82.jpg	21
167	5 sheets Nori	https://www.edamam.com/food-img/193/1935b3e53c576e0f097393084d11b629.jpg	21
168	1 6 inch Cucumber	https://www.edamam.com/food-img/501/5015da0e5fc2b384696b3d949aefef86.jpg	21
169	1/2 medium Avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	21
170	5 oz. Smoked Salmon (or any seafood)	https://www.edamam.com/food-img/c91/c918b85b824c85e231e13a2b831d6d18.gif	21
171	2.5 tbsp Cream Cheese	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	22
172	2 tbsp Parmesan Cheese, grated	https://www.edamam.com/food-img/f58/f588658627c59d5041e4664119829aa9.jpg	22
173	2 oz Lox - Alaska Sockeye Premium Nova Lox - Wild catch - serving size 2 oz(56g)	/static/images/ing.png	22
174	6 tsp Mrs. Dash (R) Original Blend	/static/images/ing.png	22
175	½ cups Plus 2 Tablespoons Full-fat Coconut Milk	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	23
176	½ cups Plus 2 Tablespoons Full-fat Coconut Milk	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	23
177	2 Tablespoons Mild Curry Paste	/static/images/ing.png	23
178	8 ounces, weight Alaskan Salmon Fillets	https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg	23
179	3 Large Zucchini, Spiralized Or Sliced Into Noodles	https://www.edamam.com/food-img/f63/f637280594e4a731eccc1199194a8847.jpg	23
180	Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	23
181	Fresh Mint For Garnish	https://www.edamam.com/food-img/7f0/7f01cc4f71c5c6ad31051ed74b9c058b.jpg	23
182	100g butter, softened	/static/images/ing.png	24
183	2 tablespoons finely chopped coriander	https://www.edamam.com/food-img/a90/a901cee0b9028841d258f5d07b5924e7.jpg	24
184	2 teaspoons finely grated lime rind	https://www.edamam.com/food-img/48a/48a123c9576647c4ada6a41df5eeb22a.jpg	24
185	2 teaspoons lime juice	https://www.edamam.com/food-img/8f0/8f0c10eb3dbf476a05e61018e76ea220.jpg	24
186	cracked black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	24
187	4 salmon cutlets	https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg	24
188	steamed vegetables, to serve	https://www.edamam.com/food-img/f3f/f3fa6996eba331be219778406f67a5a3.jpg	24
189	1 Large Egg, Fork Beaten	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	25
190	¼ cups Fresh Shredded Parmesan Cheese	https://www.edamam.com/food-img/f58/f588658627c59d5041e4664119829aa9.jpg	25
191	½ teaspoons Garlic Powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	25
192	1 teaspoon Minced Fresh Parsley Or Dried Parsley Flakes	https://www.edamam.com/food-img/e45/e453e0756d9ebe39fbcdae1594587ae1.jpg	25
193	12 ounces, weight Salmon Fillets	https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg	25
194	1 Tablespoon Refined Coconut Oil For Frying	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	25
195	3 large eggs (free-range or organic)	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	26
196	½ average avocado (100g / 3.5 oz)	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	26
197	½ package smoked salmon (50g / 1.8 oz)	https://www.edamam.com/food-img/c91/c918b85b824c85e231e13a2b831d6d18.gif	26
198	2 tbsp full-fat cream cheese (64g / 2.3 oz)	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	26
199	2 tbsp freshly chopped chives	https://www.edamam.com/food-img/f3f/f3f48643a924ba174b894e979cb48620.jpg	26
200	1 medium spring onion (15g / o.5 oz)	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	26
201	1 tbsp ghee / butter	/static/images/ing.png	26
202	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	26
203	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	26
204	1 pound Atlantic Salmon Side	https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg	27
205	¼ cups Avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	27
206	¼ cups Cilantro	https://www.edamam.com/food-img/d57/d57e375b6ff99a90c7ee2b1990a1af36.jpg	27
207	1-½ teaspoon Yellow Curry Powder	https://www.edamam.com/food-img/9ce/9ce02a2887385fd2adaec8dd8adcf9c5.jpg	27
208	½ teaspoons Stonemill Sea Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	27
209	4 teaspoons Tapioca Starch, Plus 1/4 Cup For Dredging	/static/images/ing.png	27
210	4 teaspoons Tapioca Starch, Plus 1/4 Cup For Dredging	/static/images/ing.png	27
211	2 Organic Cage Free Brown Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	27
212	½ cups Organic Coconut Flakes	https://www.edamam.com/food-img/d76/d76b9333b99d55d69b023d81d179aa39.jpg	27
213	Organic Coconut Oil, As Needed	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	27
214	2 teaspoons Coconut Oil, Melted	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	27
215	6 cups Organic Arugula And Spinach Mix, Tightly Packed	https://www.edamam.com/food-img/fa7/fa761a311efc0ec361a5eba4ed71870e.jpeg	27
216	6 cups Organic Arugula And Spinach Mix, Tightly Packed	https://www.edamam.com/food-img/e6e/e6e4be375c4554ce01c8ea75232efaa6.jpg	27
217	1 pinch Sea Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	27
218	4 large eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	28
219	1 large cauliflower (1 kg/ 2.2 lb)	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	28
220	¼ cup + 2 tbsp butter or ghee - you can make your own ghee (85 g/ 3 oz)	/static/images/ing.png	28
221	2-3 fillets white fish such as haddock or cod, skinless (300 g/ 10.6 oz) - I used some smoked	https://www.edamam.com/food-img/25c/25c7b9d6948bbee0d9e3d2c130a4b3f1.jpg	28
222	2 fillets salmon, skinless, preferably wild (220 g/ 7.8 oz)	https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg	28
223	2 fillets mackerel, skinless (180 g/ 6.3 oz)	https://www.edamam.com/food-img/f80/f803095970a3f5c5a8d4ea45ade6908a.jpg	28
224	1 medium red onion (100 g/ 3.5 oz)	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	28
225	2 bay leaves	https://www.edamam.com/food-img/0f9/0f9f5f95df173e9ffaaff2977bef88f3.jpg	28
226	4 cloves or ¼ tsp ground cloves	https://www.edamam.com/food-img/8bc/8bc63f9742815a245d37e5f346674ca4.jpg	28
227	1 cup heavy whipping cream (240 ml/ 8 fl oz)	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	28
228	½ cup water (120 ml/ 4 fl oz)	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	28
229	1 tsp Dijon mustard (you can make your own)	https://www.edamam.com/food-img/e23/e238f2e4cfa6aa1a30f46dc73e7344eb.jpg	28
230	⅛ tsp ground nutmeg	https://www.edamam.com/food-img/b9e/b9e54f78ae18cf99a6504b472ba25e7b.jpg	28
231	1 cup + ½ cup cheddar cheese, shredded (170 g/ 6 oz)	/static/images/ing.png	28
232	4 tbsp freshly chopped chives	https://www.edamam.com/food-img/f3f/f3f48643a924ba174b894e979cb48620.jpg	28
233	fresh parsley	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	28
234	chives	https://www.edamam.com/food-img/f3f/f3f48643a924ba174b894e979cb48620.jpg	28
235	½ tsp salt or to taste (I like pink Himalayan salt)	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	28
236	freshly ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	28
237	16 Tablespoons Almond Flour (Sesame Flour For Nut Free)	/static/images/ing.png	29
238	1 teaspoon Gluten Free Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	29
239	1 teaspoon Lifesource Oat Fiber (Adds Texture, See Notes)	/static/images/ing.png	29
240	¼ teaspoons Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	29
241	½ teaspoons Glucomannan (or Xanthan Gum)	/static/images/ing.png	29
242	2 Tablespoons Cold Butter	/static/images/ing.png	29
243	3 Large Egg Whites, Whisked	/static/images/ing.png	29
244	1 pound Uncooked Salmon Fillets, Skin Removed (Or Other Cooked Protein)	https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg	29
245	Lemon Pepper To Taste	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	29
246	¼ cups Feta Cheese Crumbles, Unseasoned	https://www.edamam.com/food-img/37e/37ef3e404b1c02bf4707cb82010732b8.jpg	29
247	3 Tablespoons Butter	/static/images/ing.png	29
248	4 ounces, weight Baby Bella Mushrooms, Sliced And Halved	https://www.edamam.com/food-img/d63/d639cf4a2afc7407c1d1ce286028136b.jpg	29
249	8 ounces, weight Baby Spinach Leaves, Fresh	https://www.edamam.com/food-img/e6e/e6e4be375c4554ce01c8ea75232efaa6.jpg	29
250	¼ teaspoons Coarse Black Pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	29
251	1 Tablespoon Butter, Melted	/static/images/ing.png	29
252	½ cups Bertolli Organic Garlic Alfredo Sauce	/static/images/ing.png	29
253	2 Tablespoons Lemon Juice	https://www.edamam.com/food-img/e31/e310952d214e78a4cb8b73f30ceeaaf2.jpg	29
254	⅛ teaspoons Dried Dill	https://www.edamam.com/food-img/927/927173abe613e0c9124c406d236e81bd.jpg	29
255	1 teaspoon butter	/static/images/ing.png	30
256	3 cloves garlic, minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	30
257	2 1/2 cups vegetable broth	/static/images/ing.png	30
258	3 cups chopped broccoli	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	30
259	1 cup heavy whipping cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	30
260	3 cups shredded Cheddar cheese	/static/images/ing.png	30
261	2 slices bacon, chopped and cooked	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	30
262	salt and ground black pepper to taste	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	30
263	salt and ground black pepper to taste	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	30
264	Cooking spray	/static/images/ing.png	31
265	3 cup Chicken stock, home-prepared	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	31
266	4 clove Garlic, minced or pressed	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	31
267	4 cup, chopped or diced Broccoli, fresh	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	31
268	1 cup, fluid (yields 2 cups whip Heavy Whipping Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	31
269	1 tbsp Spice World Minced Onions (Dried)	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	31
270	3 cup Kraft Finely Shredded Sharp Cheddar Cheese	/static/images/ing.png	31
271	1 Tbsp Ground Mustard (optional)	https://www.edamam.com/food-img/9ff/9ff9e6d04cbc71ff884f3212afa0adfd.jpg	31
272	sea salt to taste	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	31
273	white pepper to taste	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	31
274	* 1 tbsp extra virgin olive oil	/static/images/ing.png	32
275	* 1/3 cup sugar free mayonnaise	/static/images/ing.png	32
276	* 1 1/2 tbsp apple cider vinegar	https://www.edamam.com/food-img/c7d/c7dbd1846c5d08e9739930d70a404d50.jpg	32
277	* 1 tbsp dijon mustard	https://www.edamam.com/food-img/e23/e238f2e4cfa6aa1a30f46dc73e7344eb.jpg	32
278	* 2 tbsp granulated sugar substitute	https://www.edamam.com/food-img/011/01178ad203a61393cfcfd240d51aa1e6.jpg	32
279	* 1 tsp celery seed	https://www.edamam.com/food-img/06e/06e50b8c121e900b691892132ec43312.jpg	32
280	* 1/2 tsp kosher salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	32
281	* 1/4 tsp black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	32
282	* 4 cup bagged broccoli slaw	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	32
283	* 2 tablespoon butter	/static/images/ing.png	33
284	* 1/4 onion, diced	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	33
285	* 2 garlic clove, minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	33
286	* 4 cup chicken broth	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	33
287	* 1 cup heavy whipping cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	33
288	* 14 oz frozen broccoli floret	https://www.edamam.com/food-img/b11/b11b34a0dd535bf7aabeeb5413f24954.jpeg	33
289	* 3 cup cheddar cheese	/static/images/ing.png	33
290	* 3 slice swiss cheese	https://www.edamam.com/food-img/419/419f6ce36db411c072d0dbf6c8510897.jpg	33
291	* 1/4 tsp nutmeg	https://www.edamam.com/food-img/b9e/b9e54f78ae18cf99a6504b472ba25e7b.jpg	33
292	* 1 tsp parsley	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	33
293	* 1/2 tsp pink salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	33
294	* 1/2 tsp black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	33
295	* 3 piece of bacon, crumbled	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	33
296	* 1/2 cup shredded cheese	/static/images/ing.png	33
297	4 eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	34
298	90ml unsweetened almond milk	/static/images/ing.png	34
299	1 tbsp apple cider vinegar	https://www.edamam.com/food-img/c7d/c7dbd1846c5d08e9739930d70a404d50.jpg	34
300	2 tbsp melted unsalted butter	/static/images/ing.png	34
301	130g cheddar	/static/images/ing.png	34
302	100g broccoli (about 1/2 a head)	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	34
303	1 3/4 cup blanched almond flour (200g)	/static/images/ing.png	34
304	1/2 tsp baking powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	34
305	1/4 tsp baking soda	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	34
306	2 tsp oregano	https://www.edamam.com/food-img/1b0/1b0eaffb1c261606e0d82fed8e9747a7.jpg	34
307	1 tsp parsley	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	34
308	1/2 tsp Himalayan salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	34
309	1/2 tsp black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	34
310	1/2 tsp garlic powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	34
311	1/4 tsp sage powder	https://www.edamam.com/food-img/509/50984580e9aad4b4ddd5b7ed45a64bf4.jpg	34
312	1/2 tsp celery salt	https://www.edamam.com/food-img/c23/c23e20823b442067307aa436969358f1.jpg	34
313	1 Tablespoon Sesame Oil	https://www.edamam.com/food-img/b87/b874ddcfb6770adc7a155355a902ffb8.jpg	35
314	500g/1.1 lbs Chicken Thighs, Diced	https://www.edamam.com/food-img/007/00792642367e1f55de680762f85cfb3b.jpg	35
315	3 Garlic Cloves, Peeled and Diced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	35
316	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	35
317	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	35
318	1 Head of Broccoli, Chopped into bite sized pieces	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	35
319	2 Tablespoons Tamari	https://www.edamam.com/food-img/f52/f5263a232df96ad21cf2120e05c941ae.jpg	35
320	2 heads broccoli, cut into florets	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	36
321	1 large rotisserie chicken, meat pulled and shredded	https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg	36
322	1 cup mayonnaise	/static/images/ing.png	36
323	2/3 cup heavy whipping cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	36
324	1 tablespoon chicken soup base	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	36
325	1 tablespoon dried dill weed	https://www.edamam.com/food-img/927/927173abe613e0c9124c406d236e81bd.jpg	36
326	1 teaspoon ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	36
327	2 cups shredded Cheddar cheese	/static/images/ing.png	36
328	cooking spray	/static/images/ing.png	36
329	1.0 tsp Onion powder	https://www.edamam.com/food-img/1e7/1e73e6f5dd96bb233abc0fcc05fb0ec8.jpg	37
330	4.0 cube Chicken bouillon	/static/images/ing.png	37
331	4.0 cup (8 fl oz) Water, tap	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	37
332	4.5 cup Birds Eye Steamfresh Broccoli Cuts	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	37
333	17.0 tbsp shurr fine heavy whipping cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	37
334	1.0 cup Crystal farm sharp cheddar cheese	/static/images/ing.png	37
335	1.0 cup shirt fine Italian blend cheese	/static/images/ing.png	37
336	4.0 tbsp Butter, salted	https://www.edamam.com/food-img/515/515af390107678fce1533a31ee4cc35b.jpeg	37
337	5 Medium Sweet Potatoes (diced and steamed)	https://www.edamam.com/food-img/b66/b660e3d37b4ea9d58cb98e8ea73933b6.jpg	38
338	2lbs Ground Beef	https://www.edamam.com/food-img/cfa/cfae8f9276eaf8f0d9349ba662744a0c.jpg	38
339	1 Small White Onion	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	38
340	1/2 Cup Broccoli Florets Chopped	https://www.edamam.com/food-img/b11/b11b34a0dd535bf7aabeeb5413f24954.jpeg	38
341	1/2 Carrots Chopped	https://www.edamam.com/food-img/121/121e33fce0bb9546ed7d060b6c114e29.jpg	38
342	3 Tbsp Low Carb Tomato Paste	/static/images/ing.png	38
343	1/4 Cup Lowest Carb Full-Fat Canned Coconut Milk	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	38
344	2 Tbsp Soy Sauce	https://www.edamam.com/food-img/f56/f562e461eb0618f367f538b836c17b82.jpg	38
345	4 tsp Tone’s Rosemary & Garlic Seasoning	https://www.edamam.com/food-img/c23/c23e20823b442067307aa436969358f1.jpg	38
346	1 tsp Ground Thyme	https://www.edamam.com/food-img/3e7/3e7cf3c8d767a90b906447f5e74059f7.jpg	38
347	8 Tbsp Butter	/static/images/ing.png	38
348	3 Tbsp Extra Virgin Olive Oil	/static/images/ing.png	38
349	¼ cups Coconut Aminos, Divided (or Soy Sauce)	/static/images/ing.png	39
350	1 teaspoon Fresh Ginger, Minced And Divided	https://www.edamam.com/food-img/b9c/b9c06ef451ef29513880af0a53ebbaa6.jpg	39
351	1 teaspoon Fresh Garlic, Minced And Divided	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	39
352	1-½ Tablespoon Avocado Oil, Divided	https://www.edamam.com/food-img/ce2/ce24db634b117a51aa525b29a110a318.jpg	39
353	8 ounces, weight Flank Steak, Thinly Sliced Against The Grain	https://www.edamam.com/food-img/f8d/f8dedaeb7292857a4d92019961fb91fb.jpg	39
354	2-½ cups Broccoli, Cut Into Large Florets	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	39
355	¼ cups Reduced Sodium Beef Broth	https://www.edamam.com/food-img/428/4284513ddbf46e51f0f33566c0d61715.jpg	39
356	½ teaspoons Sesame Oil	https://www.edamam.com/food-img/b87/b874ddcfb6770adc7a155355a902ffb8.jpg	39
357	Salt To Taste	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	39
358	Cooked Cauliflower Rice, To Serve	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	39
359	Green Onion And Sesame Seeds, For Garnish	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	39
360	Green Onion And Sesame Seeds, For Garnish	https://www.edamam.com/food-img/291/291b355a7a0948716243164427697279.jpg	39
361	1 lb beef (sirloin, skirt steak, boneless short ribs...etc.)	https://www.edamam.com/food-img/4ed/4ed26a39971cafa1784d9fc02ad1b92d.jpg	40
362	1 to 2 heads broccoli, break into florets	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	40
363	2 cloves garlic, minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	40
364	2 pieces thin sliced ginger, finely chopped	https://www.edamam.com/food-img/b9c/b9c06ef451ef29513880af0a53ebbaa6.jpg	40
365	ghee	https://www.edamam.com/food-img/2b5/2b504c036c64481b224c9d74cc4a82e0.jpg	40
366	2 tbsp coconut aminos	/static/images/ing.png	40
367	1/2 tsp coarse sea salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	40
368	1 tbsp sesame oil	https://www.edamam.com/food-img/b87/b874ddcfb6770adc7a155355a902ffb8.jpg	40
369	1/4 tsp black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	40
370	1 tsp arrowroot/sweet potato powder	https://www.edamam.com/food-img/b66/b660e3d37b4ea9d58cb98e8ea73933b6.jpg	40
371	1/4 tsp baking soda Baking soda is whole30 friendly. See notes section.	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	40
372	2 tbsp coconut aminos	/static/images/ing.png	40
373	1 tbsp red boat fish sauce	https://www.edamam.com/food-img/7b5/7b58b769d8bf7b79acf12a76b79ea9bc.jpg	40
374	2 tsp sesame oil	https://www.edamam.com/food-img/b87/b874ddcfb6770adc7a155355a902ffb8.jpg	40
375	1/4 tsp black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	40
376	2 eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	41
377	1 tbsp cream (skip if paleo)	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	41
378	1 tsp ghee/coconut oil/olive oil	/static/images/ing.png	41
379	3 slices of bacon (50g)	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	41
380	1 large crimini mushroom (40g)	https://www.edamam.com/food-img/17a/17a9ef54308a434004be9ba16c0eea03.jpg	41
381	4 broccoli sticks (60g)	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	41
382	1/4 avocado (40g)	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	41
383	Pinch of salt & pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	41
384	5 cups Broccoli	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	42
385	½ cups Artichoke Hearts Marinated In Olive Oil	https://www.edamam.com/food-img/8f8/8f80887cee9e2455b7f8a162c2615758.jpg	42
386	½ cups Sun Dried Tomatoes In Olive Oil	https://www.edamam.com/food-img/023/0231ec1c0873483bd9747d71d57e6215.jpeg	42
387	½ cups Pitted Kalamata Olives	https://www.edamam.com/food-img/822/8221f2141e8dafd469414b20777735ca.jpg	42
388	⅓ cups Red Onion	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	42
389	¼ cups Roasted And Salted Sunflower Seeds	https://www.edamam.com/food-img/82a/82ab19be86c2370d22b5b59bd1c15f15.jpg	42
390	13.9 serving Chicken Marketplace Lemon Pepper Rotisserie Chicken (3oz)	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	43
391	8.0 serving birdseye steamfresh broccoli florets 1 cup	https://www.edamam.com/food-img/b11/b11b34a0dd535bf7aabeeb5413f24954.jpeg	43
392	6.0 serving Naturally Hickory Smoked Thick Cut Bacon (Great Value)	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	43
393	43.0 tbsp whipped cream cheese spread (great value)	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	43
394	154.0 gram(s) Daisy - Sour Cream	https://www.edamam.com/food-img/f9d/f9d6183267b041b0aff9a10b89c9c15f.jpg	43
395	8.0 oz Cheese - Kroger Mild Cheddar Cheese	/static/images/ing.png	43
396	0.5 cup shredded parmesan, romano, Asiago (kraft)	https://www.edamam.com/food-img/71a/71a53d043eded9a8914415178a07f879.jpg	43
397	2.0 cup Campbell's low sodium chicken broth	https://www.edamam.com/food-img/2eb/2eb3c708f58f5fa1543022650ff0ae8d.png	43
398	5.0 clove Garlic	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	43
399	1 cup Broccoli Slaw Mix	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	44
400	1 whole Green Onion, Sliced	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	44
401	2 Tablespoons Mixed Peppers, Sliced	https://www.edamam.com/food-img/629/629dc9fddc1f8aec27fa337dd6ce2b7c.jpg	44
402	2 ounces, fluid Cooked Chicken, Cubed	/static/images/ing.png	44
403	1 Tablespoon Slivered Almonds	https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg	44
404	3 Tablespoons Aunt Rocky's Almond Butter Dip/Dressing (see Recipe In My TK Recipe Box)	https://www.edamam.com/food-img/5dd/5ddf70b59f27c03902b5d5a3c4574b37.png	44
405	-2 tsp. salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	45
406	-3 cups chicken broth (or veggie)	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	45
407	-1/2 large onion, chopped	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	45
408	-3 small-med heads of broccoli, chopped into florets	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	45
409	-1 avocado, roughly chopped	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	45
410	-1 cup shredded cheddar cheese	/static/images/ing.png	45
411	-3 cups heavy whipping cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	45
412	6 cup, chopped or diced Broccoli, fresh	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	46
413	.5 cup, chopped Onions, raw	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	46
414	1 cup Mayonnaise, regular (mayo)	/static/images/ing.png	46
415	.50 cup, sliced Almonds	https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg	46
416	2 tbsp (C) Vinegar, Red Wine (Gr Value)	https://www.edamam.com/food-img/dc8/dc8e998b32b8d45ba15c1b1e6711e958.jpg	46
477	½ cup pecans	https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg	54
417	8 serving Butterball Turkey Bacon (1 slice)	https://www.edamam.com/food-img/150/1501bfabf0fb0c8b9c7f948e935990e4.jpeg	46
418	2.5 spear (about 5" long) Broccoli, fresh	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	47
419	128 tbsp Great value half & half	https://www.edamam.com/food-img/8f6/8f6397fd80a05aa12ee3b990737388a5.jpg	47
420	4 cup Sargento Classic Sharp Cheddar Fancy Shredded Natural Cheddar Cheese	/static/images/ing.png	47
421	0.25 cup *Kroger Mozzarella Fat Free Shredded Cheese	/static/images/ing.png	47
422	4.35 serving Bob's Red Mill Almond Flour - per 1/4 Cup	/static/images/ing.png	47
423	1 stick Butter, salted	https://www.edamam.com/food-img/515/515af390107678fce1533a31ee4cc35b.jpeg	47
424	8 ounces, fluid Cooked Ham, Cubed Bite Size	https://www.edamam.com/food-img/a4b/a4ba02f547d69f0ab89ae266903f1e49.jpg	48
425	8 ounces, fluid Broccoli, Cooked And Chopped	https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg	48
426	3 ounces, fluid Crimini Mushrooms, Chopped Or Sliced (See Note 1)	https://www.edamam.com/food-img/17a/17a9ef54308a434004be9ba16c0eea03.jpg	48
427	4 Tablespoons Heavy Whipping Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	48
428	2 Tablespoons Unsweetened Almond Milk Or Water	/static/images/ing.png	48
429	1 Tablespoon Dried Minced Onion	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	48
430	1 teaspoon Christopher Ranch Chopped Garlic (or 1 Raw Clove Minced)	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	48
431	1 teaspoon Worcestershire Sauce	https://www.edamam.com/food-img/072/072b61dd1ad5bb641f05b14f716ba6d0.jpg	48
432	1 teaspoon Yellow Mustard	https://www.edamam.com/food-img/e23/e238f2e4cfa6aa1a30f46dc73e7344eb.jpg	48
433	½ teaspoons Coarse Ground Black Pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	48
434	¼ teaspoons Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	48
435	1 cup Sharp Cheddar Cheese, Grated And Divided	/static/images/ing.png	48
436	2 Tablespoons Thai Fried Onion, Crushed (See Note 2)	https://www.edamam.com/food-img/835/835c79ac950fd0c84d3597a03c0c8f86.jpg	48
469	3 eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	54
470	1 cup almond flour	/static/images/ing.png	54
471	⅓ cup Truvia baking blend or other sweetener	https://www.edamam.com/food-img/0e3/0e3edc39fe123b516c4c758f4f09e99f.jpg	54
472	1 teaspoon baking powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	54
473	1 teaspoon apple pie spice	https://www.edamam.com/food-img/be9/be9f44bb5fa838e7e1bf02e16ff29740.jpg	54
474	¼ cup coconut oil	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	54
475	½ cup heavy whipping cream or	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	54
476	1 cup shredded carrots	https://www.edamam.com/food-img/121/121e33fce0bb9546ed7d060b6c114e29.jpg	54
478	6 large eggs, separated	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	55
479	6 Tbsp. cream cheese, room temperature	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	55
480	1/2 tsp. cream of tartar	https://www.edamam.com/food-img/1c0/1c002c4edc6959ef265036bdf3582885.jpg	55
481	2 tsp. vanilla extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	55
482	1/4 cup granulated stevia/erythritol mix	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	55
483	16 oz. cream cheese, softened	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	55
484	2 Tbsp. butter, softened	/static/images/ing.png	55
485	1/3 cup granulated stevia/erythritol mix	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	55
486	1 Tbsp. vanilla extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	55
487	2 tbsp Butter, salted	https://www.edamam.com/food-img/515/515af390107678fce1533a31ee4cc35b.jpeg	56
488	.5 serving Bob's Red Mill Almond Flour - per 1/4 Cup	/static/images/ing.png	56
489	.66 tbsp Bob's Red Mill Coconut Flour (by BABYHUNT)	/static/images/ing.png	56
490	1 large Egg, fresh, whole, raw	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	56
491	2 tbsp Cocoa, dry powder, unsweetened	https://www.edamam.com/food-img/89a/89af89595db3cf2c3007f2b064c5fef6.jpg	56
492	.5 tsp Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	56
493	.75 tsp Truvia Baking Blend Natural Sweetener with Sugar - serving size 1/2 tsp (2g) (by TONIHERRMANN)	https://www.edamam.com/food-img/0e3/0e3edc39fe123b516c4c758f4f09e99f.jpg	56
494	4 ounces dark chocolate chips	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	57
495	1 tablespoon coconut oil	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	57
496	2 tablespoons water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	57
497	1 tablespoon blanched almond flour	/static/images/ing.png	57
498	1 tablespoon coconut flour	/static/images/ing.png	57
499	1 pinch baking soda	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	57
500	1 egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	57
501	1 tablespoon brewed espresso	https://www.edamam.com/food-img/433/43301ebd4f7c5903aa6bac567a890ac3.jpg	57
502	1 Large Egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	58
503	2 Tbsp. Salted Butter	https://www.edamam.com/food-img/515/515af390107678fce1533a31ee4cc35b.jpeg	58
504	2 Tbsp. Almond Flour	/static/images/ing.png	58
505	2 Tbsp. Unsweetened Cocoa Powder	https://www.edamam.com/food-img/89a/89af89595db3cf2c3007f2b064c5fef6.jpg	58
506	1 1/2 Tbsp. Erythritol or Splenda	/static/images/ing.png	58
507	2 tsp. Coconut Flour	/static/images/ing.png	58
508	1/4 tsp. Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	58
509	1/2 tsp. Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	58
510	1 Large Egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	59
511	2 Tbsp Almond Flour	/static/images/ing.png	59
512	2 Tbsp Butter (melted)	/static/images/ing.png	59
513	1 Tbsp Peanut Butter	https://www.edamam.com/food-img/d74/d740276ae1409472a8714b2cee88a310.jpg	59
514	2 Tbsp Stevia	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	59
515	3 Drops Liquid Stevia	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	59
516	1 tsp Cocoa Powder (dark or milk chocolate)	https://www.edamam.com/food-img/818/8181456202f62ca321fdaf8513ce3282.jpg	59
517	1/2 tsp Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	59
518	1/4 tsp Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	59
519	* 2 tb coconut flour	/static/images/ing.png	60
520	* 1 1/2 tb almond flour	/static/images/ing.png	60
521	* 2 tablespoon butter	/static/images/ing.png	60
522	* 1 egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	60
523	* 1/4 teaspoon instant coffee ground	https://www.edamam.com/food-img/336/336e810373dd353a955a6896699b586e.jpg	60
524	* 1 tsp vanilla extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	60
525	* 1 tb lily's chocolate chip	/static/images/ing.png	60
526	* 2 tb cocoa powder	https://www.edamam.com/food-img/89a/89af89595db3cf2c3007f2b064c5fef6.jpg	60
527	* 1 1/2 tb swerve powdered sugar	https://www.edamam.com/food-img/290/290624aa4c0e279551e462443e38bb40.jpg	60
528	* 2 tb sour cream	https://www.edamam.com/food-img/f9d/f9d6183267b041b0aff9a10b89c9c15f.jpg	60
529	2.0 tbsp coconut flour	/static/images/ing.png	61
530	1.0 tbsp Cocoa, dry powder, unsweetened	https://www.edamam.com/food-img/89a/89af89595db3cf2c3007f2b064c5fef6.jpg	61
531	1.0 tbsp Kerrygold (Pure Irish Butter)	/static/images/ing.png	61
532	1.0 tsp splenda natural	/static/images/ing.png	61
533	1.0 large Egg, fresh, whole, raw	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	61
534	0.5 tsp Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	61
535	1 tbsp Coconut Secret Raw Coconut Flour (by GFERBER)	/static/images/ing.png	62
536	.5 serving Bob's Red Mill Almond Flour - per 1/4 Cup	/static/images/ing.png	62
537	1 large Egg, fresh, whole, raw	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	62
538	28 gram(s) Avocado Oil - Chosen Foods - 1 TBSP	https://www.edamam.com/food-img/ce2/ce24db634b117a51aa525b29a110a318.jpg	62
539	.5 tsp Lemon Extract (by AEROBICSAHOLIC)	https://www.edamam.com/food-img/70a/70acba3d4c734d7c70ef4efeed85dc8f.jpg	62
540	.25 tsp Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	62
541	.5 tsp Splenda	/static/images/ing.png	62
661	2 Tablespoons Butter, Melted	/static/images/ing.png	76
542	1 (1 ounce) square unsweetened chocolate	https://www.edamam.com/food-img/ae6/ae60c9ec09f77cab311738f65170e734.jpg	63
543	1/2 cup granular sucralose sweetener (such as Splenda®)	https://www.edamam.com/food-img/0e3/0e3edc39fe123b516c4c758f4f09e99f.jpg	63
544	1/2 cup water, or as needed	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	63
545	1/4 cup butter, melted	/static/images/ing.png	63
546	1 egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	63
547	1/4 cup soy flour	https://www.edamam.com/food-img/23b/23b746f8d8b55291e9415f17faa6ff46.jpg	63
548	1 teaspoon mayonnaise (optional)	/static/images/ing.png	63
549	1/2 teaspoon vanilla extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	63
550	1/2 teaspoon salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	63
551	1/4 teaspoon baking soda	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	63
552	2 large Egg Yolk	https://www.edamam.com/food-img/e3f/e3f697887aec0e8ecf09a9ca8ef3944a.jpg	64
553	1 serving Coffee, Folgers French Roast	https://www.edamam.com/food-img/ee9/ee9566349cb84dfd9ddac1fdf8cbc907.jpg	64
554	4 tbsp Coconut Oil	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	64
555	.50 serving Guittard Extra Dark Chocolate Chips (30 chips)	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	64
556	1/2 cup sugar-free chocolate chips	/static/images/ing.png	65
557	1/2 cup butter	/static/images/ing.png	65
558	3 eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	65
559	1/4 cup Truvia baking blend or other sweetener	https://www.edamam.com/food-img/0e3/0e3edc39fe123b516c4c758f4f09e99f.jpg	65
560	1 tsp Vanilla extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	65
561	120g ground almonds	https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg	66
562	4 medium eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	66
563	3 tbsp extra virgin olive oil	/static/images/ing.png	66
564	2.5 tsp baking powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	66
565	100g blueberries	https://www.edamam.com/food-img/f55/f55705a2a9ea9f7abf449a05fa968139.png	66
566	50g dark chocolate chips (at least 70% cocoa solids)	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	66
567	2 tsp vanilla extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	66
568	1 Cup Heavy Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	67
569	½ Cup Light Cream	https://www.edamam.com/food-img/95c/95cc0b05cfb70cbdd2546504855f4bda.jpg	67
570	½ tsp Liquid Stevia Extract	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	67
571	½ tsp Vanilla (Optional)	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	67
572	Several Drops Peppermint Extract (Optional)	https://www.edamam.com/food-img/fc1/fc1b9eea517ee139e9580908530124b0.jpg	67
573	1 Square Dark Chocolate (Optional)	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	67
574	Several Drops Green food coloring (Optional)	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	67
575	2 Tablespoons Ground Flax Seeds	/static/images/ing.png	68
576	2 Tablespoons Chia Seeds	https://www.edamam.com/food-img/bcc/bcc6e6bf3175772ad00b414636467257.jpg	68
577	½ cups Warm Water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	68
578	¼ teaspoons Stevia, Powder Or Liquid	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	68
579	1-½ teaspoon Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	68
580	½ cups Pepitas	https://www.edamam.com/food-img/1a0/1a091473addbdd02249faddebfb61b8c.jpg	68
581	2 Tablespoons Tahini	https://www.edamam.com/food-img/eed/eed4bb62c2763575b73a8f05963073fb.jpg	68
582	1 Tablespoon Coconut Oil, Melted	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	68
583	1-½ teaspoon Cinnamon	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	68
584	⅛ teaspoons Pink Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	68
585	¼ cups Unsweetened Shredded Coconut	https://www.edamam.com/food-img/d76/d76b9333b99d55d69b023d81d179aa39.jpg	68
586	1 Tablespoon Sesame Seeds	https://www.edamam.com/food-img/291/291b355a7a0948716243164427697279.jpg	68
587	½ cups Hulled Hemp Seeds	/static/images/ing.png	68
588	1 ounce, weight Stevia-sweetened Chocolate Chips Or Unsweetened Baking Chocolate (optional)	/static/images/ing.png	68
589	2/3c almond flour	/static/images/ing.png	69
590	1 cup sweetener	https://www.edamam.com/food-img/0e3/0e3edc39fe123b516c4c758f4f09e99f.jpg	69
591	3 eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	69
592	8oz cream cheese, softened	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	69
593	2 tbs butter, softened	/static/images/ing.png	69
594	1/4 t salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	69
595	1/4 t vanilla	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	69
596	1/2 t xantham	/static/images/ing.png	69
597	1/2 t baking powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	69
598	1/4 c coconut shreds (optional but amazing)	https://www.edamam.com/food-img/d76/d76b9333b99d55d69b023d81d179aa39.jpg	69
599	1 tablespoon coconut flour	/static/images/ing.png	69
600	1 tablespoon cashew butter (optional, any nut butter will do)	https://www.edamam.com/food-img/1f8/1f8e12f6bf2a694c6700304c0ded8f19.jpg	69
601	1 1/2 cups chocolate chips of choice	/static/images/ing.png	69
602	8 tbsp Butter, salted	https://www.edamam.com/food-img/515/515af390107678fce1533a31ee4cc35b.jpeg	70
603	0.50 tsp Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	70
780	1/8 tsp. Xanthan Gum	/static/images/ing.png	88
604	8 serving Bob's Red Mill Almond Flour - per 1/4 Cup	/static/images/ing.png	70
605	0.50 tsp Pink Himalayan Sea Salt (Evolution Salt Co)	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	70
606	3 tsp Pyure Organic Stevia Blend Sweetner - adjusted carbs for erythritol (by BERIEDER)	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	70
607	1/2C Guittard Extra Dark Chocolate Chips (30 chips)	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	70
608	1 cup Raw Almonds, Chopped (140g)	https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg	71
609	1 cup Slivered Almonds (85g)	https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg	71
610	1 cup Unsweetened Coconut Flakes, Tightly Packed (65g)	https://www.edamam.com/food-img/d76/d76b9333b99d55d69b023d81d179aa39.jpg	71
611	1 Large Egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	71
612	4 Tablespoons Monk Fruit	/static/images/ing.png	71
613	2 Tablespoons Almond Butter	https://www.edamam.com/food-img/5dd/5ddf70b59f27c03902b5d5a3c4574b37.png	71
614	1 Tablespoon Coconut Oil	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	71
615	¾ teaspoons Sea Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	71
616	¼ cups Stevia Sweetened Chocolate Chips (or Dairy Free)	/static/images/ing.png	71
617	20.0 tbsp heavy whipping cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	72
618	8.0 oz cream cheese	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	72
619	2.0 tbsp Hershey''s sugar free chocolate chips	/static/images/ing.png	72
620	5.0 tsp xylitol	/static/images/ing.png	72
621	1.0 oz mixed nuts almonds,pecans,pistachios	https://www.edamam.com/food-img/1ed/1eda10468a9c3df61f8208fe156e832d.jpg	72
622	1.0 cup sliced strawberry	https://www.edamam.com/food-img/00c/00c8851e401bf7975be7f73499b4b573.jpg	72
623	2 Tablespoons Walden Farms Pancake Syrup (or Other Sugar Free Syrup)	https://www.edamam.com/food-img/ced/ced25c45453a118e531c8aaf33e2ee38.jpg	73
624	⅓ cups Water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	73
625	⅔ cups Sn Butter (or Almond Butter If Not Allergic)	/static/images/ing.png	73
626	1 teaspoon Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	73
627	½ teaspoons Imitation Butter Flavor	/static/images/ing.png	73
628	½ cups Just Like Sugar (Brown) Or Other Brown Sugar Substitute	https://www.edamam.com/food-img/011/01178ad203a61393cfcfd240d51aa1e6.jpg	73
629	½ teaspoons Rumford Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	73
630	¼ teaspoons Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	73
631	½ cups Golden Flax/Linseed Meal (See Note)	https://www.edamam.com/food-img/e9b/e9bd9cc62d0dbe0753911e295a0ba0ca.jpg	73
632	1 cup Hemp Hearts	/static/images/ing.png	73
633	¼ cups LC Foods Dark Chocolate Chips (Or Other Sugar-free And Dairy-free Brand)	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	73
634	2 Tablespoons Sunflower Seeds (shelled)	https://www.edamam.com/food-img/c03/c035107b6716331396e91f7c2c0f2a04.jpg	73
635	½ cups Coconut Flour	/static/images/ing.png	74
636	1 Tablespoon Lifesource Oat Fiber (or Other Gluten Free Brand)	/static/images/ing.png	74
637	¼ cups FineNaturals Ultra Dark Cacao Powder, Packed (or Other Zero Carb Brand)	https://www.edamam.com/food-img/89a/89af89595db3cf2c3007f2b064c5fef6.jpg	74
638	⅛ teaspoons Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	74
639	¼ teaspoons Rumford Baking Powder (or Other Gluten Free)	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	74
640	½ teaspoons Cinnamon Powder	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	74
641	½ cups Butter, Melted	/static/images/ing.png	74
642	2 Tablespoons Coconut Oil, Melted	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	74
643	3 pieces (1 Oz. Size) Unsweetened Bakers Chocolate, Chopped And Melted	https://www.edamam.com/food-img/0a1/0a1b6f30cb99e1842cac6167f6f424d7.jpg	74
644	1 teaspoon Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	74
645	6 whole Eggs (large)	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	74
646	2 Tablespoons LC Foods Dark Chocolate Chips (sugar Free), Divided	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	74
647	1 cup Swerve Confectioners (powdered Erythritol)	https://www.edamam.com/food-img/290/290624aa4c0e279551e462443e38bb40.jpg	75
648	3 ounces, fluid Nestle Media Crema	https://www.edamam.com/food-img/f9d/f9d6183267b041b0aff9a10b89c9c15f.jpg	75
649	¼ teaspoons Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	75
650	¼ cups Chopped Pecans, Divided	https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg	75
651	5 ounces, weight LC Foods Dark Chocolate Chips (Or Other Sugar Free)	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	75
652	½ cups Walden Farms Marshmallow Dip (See Notes)	https://www.edamam.com/food-img/9c8/9c86a95af817e527adebbf8781aa7c4f.jpg	75
653	½ teaspoons Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	75
654	2 Tablespoons Butter, Cut Into Cubes	/static/images/ing.png	75
655	¼ cups Dehydrated Unsweetened Cranberries, Reconstituted (or Sugar-Free Chocolate Chips)	https://www.edamam.com/food-img/945/94511bef5e26f15bb6eac8e950ac79a9.jpg	76
656	Liquid Sweetener, To Taste (optional)	https://www.edamam.com/food-img/0e3/0e3edc39fe123b516c4c758f4f09e99f.jpg	76
657	2 Large Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	76
658	1 teaspoon Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	76
659	½ teaspoons LorAnn Pumpkin Flavor (Optional, Adds Flavor)	https://www.edamam.com/food-img/f5d/f5d6320e355878cbaef8ed891316946f.jpg	76
660	½ cups Libby's Pure Pumpkin (Canned, Not Pie Filling)	https://www.edamam.com/food-img/f5d/f5d6320e355878cbaef8ed891316946f.jpg	76
662	2 Tablespoons Heavy Whipping Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	76
663	2 cups Almond Flour	/static/images/ing.png	76
664	2 Tablespoons Pumpkin Flour (See Notes)	/static/images/ing.png	76
665	1 teaspoon Gluten Free Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	76
666	1 teaspoon Pumpkin Pie Spice	https://www.edamam.com/food-img/be9/be9f44bb5fa838e7e1bf02e16ff29740.jpg	76
667	¼ teaspoons Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	76
668	⅓ cups Swerve (Granular Erythritol)	/static/images/ing.png	76
669	½ cups Sukrin Gold (Granular)	https://www.edamam.com/food-img/011/01178ad203a61393cfcfd240d51aa1e6.jpg	76
670	¼ cups Chopped Pecans	https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg	76
671	2 Tablespoons Refined Coconut Oil (No Coconut Taste), Melted	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	77
672	2 Large Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	77
673	1 teaspoon Peppermint Extract	https://www.edamam.com/food-img/fc1/fc1b9eea517ee139e9580908530124b0.jpg	77
674	1 teaspoon Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	77
675	⅔ cups FineNaturals Ultra Dark Unsweetened Cacao (See Note)	https://www.edamam.com/food-img/89a/89af89595db3cf2c3007f2b064c5fef6.jpg	77
676	10 Tablespoons Confectioner's Swerve (powdered Erythritol)	https://www.edamam.com/food-img/290/290624aa4c0e279551e462443e38bb40.jpg	77
677	2 Tablespoons Bobs Red Mill Flax Meal	https://www.edamam.com/food-img/e9b/e9bd9cc62d0dbe0753911e295a0ba0ca.jpg	77
678	1 Tablespoon Instant Coffee Crystals Or Powder	https://www.edamam.com/food-img/336/336e810373dd353a955a6896699b586e.jpg	77
679	1 dash Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	77
680	2 Tablespoons LC Foods Dark Chocolate Chips (Sugar Free, Dairy Free)	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	77
681	2 Tablespoons Chopped Pecans (Omit If Nut Free)	https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg	77
682	Crushed Sugar Free Peppermint Candies, For Decoration (optional, See Note)	https://www.edamam.com/food-img/ecb/ecb3f5aaed96d0188c21b8369be07765.jpg	77
683	Crushed Sugar Free Peppermint Candies, For Decoration (optional, See Note)	https://www.edamam.com/food-img/fc1/fc1b9eea517ee139e9580908530124b0.jpg	77
684	Crushed Sugar Free Peppermint Candies, For Decoration (optional, See Note)	https://www.edamam.com/food-img/0a1/0a1b6f30cb99e1842cac6167f6f424d7.jpg	77
685	3 ounces, fluid O-Organics Part-Skim Ricotta Cheese (1 Net Carb Per Ounce)	https://www.edamam.com/food-img/9f7/9f7f95228e22fb736a2b1e8aaaab359c.jpg	78
686	¼ cups Unsweetened Vanilla Almond Milk (coconut Milk For Nut Free)	https://www.edamam.com/food-img/965/965dd9568ca365cf8e157688145fa6af.jpg	78
687	1 Tablespoon Heavy Whipping Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	78
688	1 Tablespoon Spectrum Ground Flaxseed With Mixed Berries (or Golden Flaxseed Meal)	/static/images/ing.png	78
689	1 Tablespoon Butter	/static/images/ing.png	78
690	1 Tablespoon Walden Farms Sugar Free Pancake Syrup (or Sweetener Of Choice)	https://www.edamam.com/food-img/ced/ced25c45453a118e531c8aaf33e2ee38.jpg	78
691	1 Tablespoon Pecans, Rough Chopped (omit For Nut Free)	https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg	78
692	1 whole Meyer Lemon Zested, Zest Divided	https://www.edamam.com/food-img/70a/70acba3d4c734d7c70ef4efeed85dc8f.jpg	79
693	1 whole Meyer Lemon, Juiced, Juice Divided	https://www.edamam.com/food-img/70a/70acba3d4c734d7c70ef4efeed85dc8f.jpg	79
694	½ cups Coconut Flour	/static/images/ing.png	79
695	2 Tablespoons Butter, Melted	/static/images/ing.png	79
696	3 whole Eggs (large)	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	79
697	⅓ cups Unsweetened Almond Milk (Or Milk Substitute Of Choice)	/static/images/ing.png	79
698	1 teaspoon Lemon Extract (Or A Few Drops Of Lemon Oil)	https://www.edamam.com/food-img/07e/07e106ab3536d57428e5c46d009038f8.jpg	79
699	⅓ cups Walden Farms Pancake Syrup (or Other Sugar Free Syrup)	https://www.edamam.com/food-img/ced/ced25c45453a118e531c8aaf33e2ee38.jpg	79
700	½ teaspoons Baking Soda	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	79
701	1 Tablespoon Bragg's Apple Cider Vinegar	https://www.edamam.com/food-img/c7d/c7dbd1846c5d08e9739930d70a404d50.jpg	79
702	½ cubes Blueberries, Fresh Or Frozen	https://www.edamam.com/food-img/f55/f55705a2a9ea9f7abf449a05fa968139.png	79
703	1 Tablespoon Butter, Melted	/static/images/ing.png	79
704	2 drops Lemon Oil (or 1/4 Teaspoon Lemon Extract)	https://www.edamam.com/food-img/07e/07e106ab3536d57428e5c46d009038f8.jpg	79
705	1 teaspoon Lemon Zest	https://www.edamam.com/food-img/540/5405605c8e9b284243f06c0b1587ab6f.jpg	79
706	1 teaspoon Lemon Juice	https://www.edamam.com/food-img/e31/e310952d214e78a4cb8b73f30ceeaaf2.jpg	79
707	2 Tablespoons Non-dairy Milk Of Choice (or As Needed For Pourable Glaze, Not Watery)	https://www.edamam.com/food-img/1d7/1d785da8ce8dca92df262103058b05d1.jpg	79
708	⅓ cups Swerve Confectioners	https://www.edamam.com/food-img/290/290624aa4c0e279551e462443e38bb40.jpg	79
709	0.25 cup Bob's Red Mill Almond Meal/Flour (1/4 cup is 28g)	/static/images/ing.png	80
710	1.0 tbsp Butter, salted	https://www.edamam.com/food-img/515/515af390107678fce1533a31ee4cc35b.jpeg	80
711	1.0 large Egg, fresh, whole, raw	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	80
712	1.0 tsp Leavening agents, baking powder, low-sodium	https://www.edamam.com/food-img/cbf/cbf0ae5538422ef3e0e2714059a30c92.jpg	80
713	5 eggs separated	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	81
714	4 tbs coconut flour	/static/images/ing.png	81
715	3-5 tbs granulated stevia, or sweetener of choice, to taste	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	81
716	1 tsp baking powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	81
717	1-2 tsp vanilla	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	81
718	3 tbs full fat milk	https://www.edamam.com/food-img/7c9/7c9962acf83654a8d98ea6a2ade93735.jpg	81
719	125g/ 4.5 oz butter melted	/static/images/ing.png	81
720	1 teaspoon cooking oil	https://www.edamam.com/food-img/07e/07e106ab3536d57428e5c46d009038f8.jpg	82
721	4 large eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	82
722	4 tablespoons mayonnaise	/static/images/ing.png	82
723	1 tablespoon almond flour	/static/images/ing.png	82
724	2 tablespoons cream cheese	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	82
725	1 Cup (16 tbs) (PEScience Snickerdoodle) Protein powder	https://www.edamam.com/food-img/76a/76ab108398f84ad08fe841d3409ab70a.jpg	83
726	1 Egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	83
727	1 Teaspoon Baking powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	83
728	1/2 Cup (8 tbs) (as required) Water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	83
729	5 eggs separated	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	84
730	4 tbs coconut flour	/static/images/ing.png	84
731	¼ cup cocoa powder, unsweetened	https://www.edamam.com/food-img/89a/89af89595db3cf2c3007f2b064c5fef6.jpg	84
732	3-5 tbs granulated stevia, or sweetener of choice, to taste	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	84
733	1 tsp baking powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	84
734	1-2 tsp vanilla	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	84
735	3 tbs full fat milk	https://www.edamam.com/food-img/7c9/7c9962acf83654a8d98ea6a2ade93735.jpg	84
736	125g/ 4.5 oz butter melted	/static/images/ing.png	84
737	1.0 tbsp Half and Half Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	85
738	4.0 large Egg, fresh, whole, raw	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	85
739	0.25 tsp Cinnamon, ground	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	85
740	2.0 tsp Vanilla Extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	85
741	1.5 tsp Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	85
742	4.0 tbsp Bob's Red Mill Coconut Flour	/static/images/ing.png	85
743	1.0 serving Stevia Extract In The Raw Sugar Substitute [1 packet]	https://www.edamam.com/food-img/011/01178ad203a61393cfcfd240d51aa1e6.jpg	85
744	4.0 tbsp Cream Cheese	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	85
745	2 tablespoons butter	/static/images/ing.png	86
746	1 cup pancetta bacon, diced	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	86
747	1 (12 ounce) package Brussels sprouts	https://www.edamam.com/food-img/28a/28a88a795cd97a3b3b28b65eb8bff5aa.jpg	86
748	1 cup vegetable broth	/static/images/ing.png	86
749	1/2 teaspoon salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	86
750	1/4 teaspoon ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	86
751	1.1 lb Brussels sprouts (500 g / 17.6 oz)	https://www.edamam.com/food-img/28a/28a88a795cd97a3b3b28b65eb8bff5aa.jpg	87
752	¼ ghee, melted (make your own) or butter (55 g / 1.9 oz)	/static/images/ing.png	87
753	juice from ½ lemon (~ 2 tbsp)	https://www.edamam.com/food-img/70a/70acba3d4c734d7c70ef4efeed85dc8f.jpg	87
754	½ tsp salt (I like pink Himalayan)	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	87
755	ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	87
756	4-6 slices crisped up bacon or Pancetta	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	87
757	1 small diced & crisped up chorizo sausage	https://www.edamam.com/food-img/c01/c0139ae7ad8a0334a23365b6284a5819.jpg	87
758	½ cup grated parmesan cheese	https://www.edamam.com/food-img/f58/f588658627c59d5041e4664119829aa9.jpg	87
759	¼ heavy whipping cream + ½ cup soaked dried porcini mushrooms	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	87
760	¼ heavy whipping cream + ½ cup soaked dried porcini mushrooms	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	87
761	2 cloves garlic, crushed	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	87
762	1 medium white onion, sliced	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	87
763	¼ cup toasted pine nuts	https://www.edamam.com/food-img/52f/52fa29cb9d1ab6502f137a98c8a63f09.jpg	87
764	¼ cup toasted cashew nuts	https://www.edamam.com/food-img/d4b/d4bc3f8024cac35e2039ef5ead328e11.jpg	87
765	¼ cup toasted flaked almonds	https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg	87
766	4 servings keto cheese sauce	/static/images/ing.png	87
767	6 oz. Brussels Sprouts	https://www.edamam.com/food-img/28a/28a88a795cd97a3b3b28b65eb8bff5aa.jpg	88
768	1.8 oz. Onion	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	88
769	1 tsp. Minced Garlic	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	88
770	2 tbsp. Butter	/static/images/ing.png	88
771	1 tbsp. Soy Sauce	https://www.edamam.com/food-img/f56/f562e461eb0618f367f538b836c17b82.jpg	88
772	1/2 tsp. Liquid Smoke	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	88
773	1/4 tsp. Pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	88
774	1 tbsp. Butter	/static/images/ing.png	88
775	1/2 cup Heavy Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	88
776	2.5 oz. Cheddar Cheese, grated	/static/images/ing.png	88
777	1/4 tsp. Paprika	https://www.edamam.com/food-img/474/474d63763b9d8b9da98c5f43a114648c.jpg	88
778	1/4 tsp. Turmeric	https://www.edamam.com/food-img/03e/03eb469286b3caf1ae9c13e4eba13587.jpg	88
779	1/4 tsp. Pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	88
781	0.5 oz. Pork Rinds	https://www.edamam.com/food-img/d55/d553f23d42b9c8fb314416ccd5cde3d2.jpg	88
782	3 tbsp. Parmesan Cheese	https://www.edamam.com/food-img/f58/f588658627c59d5041e4664119829aa9.jpg	88
783	1/2 tsp. Paprika	https://www.edamam.com/food-img/474/474d63763b9d8b9da98c5f43a114648c.jpg	88
803	1 package Bacon, Apple Smoked, Uncured	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	91
804	2-3 lbs Beef chuck, arm pot roast	/static/images/ing.png	91
805	2 large Onions, raw	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	91
806	2 cup, shredded Cabbage, savoy, fresh	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	91
807	3 gram(s) Fresh Garlic (1 clove = 3g)	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	91
808	3 tsp Celtic Sea Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	91
809	1 tsp Thyme, fresh	https://www.edamam.com/food-img/3e7/3e7cf3c8d767a90b906447f5e74059f7.jpg	91
810	2 cup Bone Broth, Beef	https://www.edamam.com/food-img/bab/bab88ab3ea40d34e4c8ae35d6b30344a.jpg	91
821	3 slices Kirkland Thick Cut Bacon	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	93
822	1 Tablespoon Bacon Grease (From Cooked Bacon, Included In Nutrition)	https://www.edamam.com/food-img/0c8/0c8bb3745771a7dec087d3f3b6fb6b7d.jpg	93
823	½ Medium Onion, Chopped	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	93
824	1 pound Green Cabbage Chopped	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	93
825	1 Tablespoon Lea & Perrin's Worcestershire Sauce	https://www.edamam.com/food-img/072/072b61dd1ad5bb641f05b14f716ba6d0.jpg	93
826	Salt And Pepper, to taste	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	93
827	Salt And Pepper, to taste	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	93
837	1-½ cup Red Cabbage, Coarsely Shredded	https://www.edamam.com/food-img/222/2227613966b545ff65df7c8c4b311fc1.jpg	95
838	½ cups Curly Parsley Chopped	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	95
839	4 Tablespoons Newman's Own Lite Balsamic Dressing	https://www.edamam.com/food-img/90a/90a1f211768e166ecfff19e8b4747498.jpg	95
840	2 Tablespoons Best Foods/Hellman's Real Mayonnaise	/static/images/ing.png	95
852	32.0 oz Turkey: Ground, 85% Lean Ground	https://www.edamam.com/food-img/45b/45ba5c5df6da8dbc4d19f2bd7d04d345.jpg	97
853	3.0 cup, chopped Cabbage, red, fresh	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	97
854	3.0 cup, chopped Cabbage, fresh	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	97
855	3.0 serving Green Onion (fresh-1 stalk)	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	97
856	1.0 package (10 oz) yields Spinach, frozen	https://www.edamam.com/food-img/e6e/e6e4be375c4554ce01c8ea75232efaa6.jpg	97
857	1.5 cup pictsweet seasoning blend	https://www.edamam.com/food-img/c23/c23e20823b442067307aa436969358f1.jpg	97
858	3.0 tbsp La Choy Lite Soy Sauce (Low sodium)	https://www.edamam.com/food-img/4bc/4bccc4c294a8dddb62020c62935e6fd8.jpg	97
859	2.0 tbsp Vinegar - Natural Rice Vinegar (Nakano)	https://www.edamam.com/food-img/5f6/5f69b84c399d778c4728e9ab4f8065a2.jpg	97
863	2 cups Red Cabbage, Shredded (See Note)	https://www.edamam.com/food-img/222/2227613966b545ff65df7c8c4b311fc1.jpg	99
864	¼ cups Carrots, Shredded	https://www.edamam.com/food-img/121/121e33fce0bb9546ed7d060b6c114e29.jpg	99
865	¼ cups Parsley, Chopped	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	99
866	¼ cups Slivered Almonds	https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg	99
867	2 slices Red Onion, Sliced Thin And Chopped	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	99
868	2 Tablespoons Extra Virgin Olive Oil	/static/images/ing.png	99
869	2 Tablespoons White Wine Vinegar	https://www.edamam.com/food-img/5f6/5f69b84c399d778c4728e9ab4f8065a2.jpg	99
870	¼ teaspoons Coarse Ground Black Pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	99
871	¼ teaspoons Italian Seasoning Blend	https://www.edamam.com/food-img/89b/89b37a04e46e052671d73addcb84aa51.jpg	99
872	¼ teaspoons Christopher Ranch Chopped Garlic	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	99
890	½ heads (medium Size) Green Cabbage	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	101
891	1 Tablespoon Butter (Omit For Dairy Free)	/static/images/ing.png	101
892	1 Tablespoon Olive Oil	/static/images/ing.png	101
893	1 Tablespoon Bragg's Cider Vinegar Or White Wine Vinegar (Optional, Adds Flavor)	https://www.edamam.com/food-img/c7d/c7dbd1846c5d08e9739930d70a404d50.jpg	101
894	¼ teaspoons Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	101
895	¼ teaspoons Coarse Ground Black Pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	101
896	¼ teaspoons Onion Powder	https://www.edamam.com/food-img/1e7/1e73e6f5dd96bb233abc0fcc05fb0ec8.jpg	101
897	1 cup Kitchen Basics Low Sodium Chicken Broth	https://www.edamam.com/food-img/2eb/2eb3c708f58f5fa1543022650ff0ae8d.png	101
909	4 oz Chicken thigh cooked, skin not eaten	https://www.edamam.com/food-img/007/00792642367e1f55de680762f85cfb3b.jpg	103
910	2- 900 mL Chicken Broth	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	103
911	8 stalks, Celery - Raw, cut up	https://www.edamam.com/food-img/d91/d91d2aed1c36d8fad54c4d7dc58f5a18.jpg	103
912	1 cup Cabbage, Dole Classic Cole Slaw	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	103
913	2 cup Spinach, fresh	https://www.edamam.com/food-img/e6e/e6e4be375c4554ce01c8ea75232efaa6.jpg	103
914	0.25 cup Salsa	https://www.edamam.com/food-img/995/995d0f166754a0475c181b9c156fec43.jpg	103
915	1/2 tsp. Cumin Powder	https://www.edamam.com/food-img/07e/07e2a4eb77ce46591033846504817d35.jpg	103
916	1 tsp Garlic powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	103
917	1 tsp Onion powder	https://www.edamam.com/food-img/1e7/1e73e6f5dd96bb233abc0fcc05fb0ec8.jpg	103
784	1 fennel bulb, sliced (approx. 300g or 2 cups)	https://www.edamam.com/food-img/038/038c19f86af781e925c97991e17b90ed.jpeg	89
785	2 cups sliced cauliflower florets	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	89
786	12 Brussels sprouts, halved	https://www.edamam.com/food-img/28a/28a88a795cd97a3b3b28b65eb8bff5aa.jpg	89
787	2 tablespoon red palm oil	https://www.edamam.com/food-img/1d7/1d79385a862f46a42f16ea73e79399e3.jpg	89
788	2 teaspoon ground cumin	https://www.edamam.com/food-img/07e/07e2a4eb77ce46591033846504817d35.jpg	89
789	500 grams grass-fed/finished regular ground beef	https://www.edamam.com/food-img/cfa/cfae8f9276eaf8f0d9349ba662744a0c.jpg	89
790	1 teaspoon ground turmeric	https://www.edamam.com/food-img/03e/03eb469286b3caf1ae9c13e4eba13587.jpg	89
791	1 teaspoon chili powder	https://www.edamam.com/food-img/e6f/e6f19043caefc23b5feda5520076617e.jpg	89
792	¼ cup roughly-ground almond flour	/static/images/ing.png	89
793	1 egg, optional	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	89
794	¼ cup chopped fresh cilantro	https://www.edamam.com/food-img/d57/d57e375b6ff99a90c7ee2b1990a1af36.jpg	89
795	rock salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	89
796	2 tablespoon lemon juice	https://www.edamam.com/food-img/e31/e310952d214e78a4cb8b73f30ceeaaf2.jpg	89
797	2 tablespoon extra-virgin olive oil	/static/images/ing.png	89
798	2 zucchinis, spiralized	https://www.edamam.com/food-img/f63/f637280594e4a731eccc1199194a8847.jpg	89
799	chopped fresh cilantro	https://www.edamam.com/food-img/d57/d57e375b6ff99a90c7ee2b1990a1af36.jpg	89
800	2 cups, shredded, Cabbage	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	90
801	4 slices of bacon	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	90
802	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	90
811	2 pounds Ground Beef (90% fat)	https://www.edamam.com/food-img/cfa/cfae8f9276eaf8f0d9349ba662744a0c.jpg	92
812	1/4 large onion, diced	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	92
813	1 clove garlic, minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	92
814	1 teaspoon cumin, ground	https://www.edamam.com/food-img/07e/07e2a4eb77ce46591033846504817d35.jpg	92
815	1 large head cabbage, chopped	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	92
816	4 bouillon cubes	https://www.edamam.com/food-img/6f7/6f71425571cb38887c2287f9860d33bd.jpg	92
817	1 (10 oz) can Rotel Diced Tomatoes & Green Chilies	https://www.edamam.com/food-img/73f/73ff2eeb21372fe15b0ec51f9ecf368d.jpeg	92
818	4 cups water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	92
819	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	92
820	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	92
828	1 lb ground pork sausage	https://www.edamam.com/food-img/2c7/2c73a127447b754a803e3804898a1afd.jpg	94
829	1 tsp minced garlic	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	94
830	2 tsp minced ginger	https://www.edamam.com/food-img/b9c/b9c06ef451ef29513880af0a53ebbaa6.jpg	94
831	1 tsp sesame oil	https://www.edamam.com/food-img/b87/b874ddcfb6770adc7a155355a902ffb8.jpg	94
832	1 c chopped celery	https://www.edamam.com/food-img/d91/d91d2aed1c36d8fad54c4d7dc58f5a18.jpg	94
833	1/2 c cauliflower "rice"	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	94
834	1-2 bag(s) coleslaw cabbage	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	94
835	5 stalk(s) of green onion chopped	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	94
836	1/2 c soy sauce	https://www.edamam.com/food-img/f56/f562e461eb0618f367f538b836c17b82.jpg	94
841	1 pound ground pork	https://www.edamam.com/food-img/5aa/5aafbc5ff7ea82f835cdb9a7fcd9a02e.jpg	96
842	1 head of cabbage, thinly sliced	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	96
843	½ medium onion, thinly sliced	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	96
844	1 tablespoon sesame oil	https://www.edamam.com/food-img/b87/b874ddcfb6770adc7a155355a902ffb8.jpg	96
845	¼ cup soy sauce or liquid aminos	https://www.edamam.com/food-img/f56/f562e461eb0618f367f538b836c17b82.jpg	96
846	1 clove garlic, minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	96
847	1 teaspoon ground ginger	https://www.edamam.com/food-img/ee0/ee08c937de5c45a36bd0ad1eafc67496.jpg	96
848	2 tablespoons chicken broth	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	96
849	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	96
850	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	96
851	2 stalks of green onion	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	96
860	4.0 tsp Bacon grease	https://www.edamam.com/food-img/0c8/0c8bb3745771a7dec087d3f3b6fb6b7d.jpg	98
861	14.0 oz Coleslaw, Dole Classic	https://www.edamam.com/food-img/4f5/4f5797bc4a894d5efb6699e744fefb21.jpg	98
862	6.0 oz Hillshire Farm Beef Smoked Sausage	https://www.edamam.com/food-img/2c7/2c73a127447b754a803e3804898a1afd.jpg	98
873	* 1 tbsp avocado oil	https://www.edamam.com/food-img/ce2/ce24db634b117a51aa525b29a110a318.jpg	100
874	* 1 tbsp sesame oil	https://www.edamam.com/food-img/b87/b874ddcfb6770adc7a155355a902ffb8.jpg	100
875	* 1 cup raw shrimp, peeled and cut in 1/2	https://www.edamam.com/food-img/33a/33ad937ee2169adc0a69cb97a48da579.jpg	100
876	* 1 cup raw chicken,	https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg	100
877	* 1 tsp garlic, minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	100
878	* 1 tbsp ginger, minced	https://www.edamam.com/food-img/b9c/b9c06ef451ef29513880af0a53ebbaa6.jpg	100
879	* 1 cup raw bell pepper, (i used red and yellow)	https://www.edamam.com/food-img/4dc/4dc48b1a506d334b4ab6671b9d56a18f.jpeg	100
880	* 1 cup snow pea, trimmed	https://www.edamam.com/food-img/d69/d6979db01580bcc6b32ad9a83cb5148c.jpg	100
881	* 1 cup raw bean sprout, washed	https://www.edamam.com/food-img/ad4/ad4635efc3493d3b4f59f6479c1bd27b.jpg	100
882	* 1/4 cup scallion, sliced	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	100
883	* 1 cup napa cabbage, sliced thin	https://www.edamam.com/food-img/1d7/1d785da8ce8dca92df262103058b05d1.jpg	100
884	* 1 cup cooked spaghetti squash strand	https://www.edamam.com/food-img/bc0/bc073855712255d9478fb9baec6f2afc.jpg	100
885	* 2 cup miracle noodle (shiritake)	https://www.edamam.com/food-img/800/800c9c0d7cef6b5474723682ffa2878d.jpg	100
886	* 1 tbsp granulated sweetener **	https://www.edamam.com/food-img/0e3/0e3edc39fe123b516c4c758f4f09e99f.jpg	100
887	* 1 tbsp lime juice	https://www.edamam.com/food-img/8f0/8f0c10eb3dbf476a05e61018e76ea220.jpg	100
888	* 2 tbsp dark soy sauce	https://www.edamam.com/food-img/f56/f562e461eb0618f367f538b836c17b82.jpg	100
889	* 2 tbsp unseasoned rice wine vinegar	https://www.edamam.com/food-img/5f6/5f69b84c399d778c4728e9ab4f8065a2.jpg	100
898	1 pound Roast Beef, Cooked And Cubed	https://www.edamam.com/food-img/634/634aa9adfb65afb5fef3df13d7334985.jpg	102
899	6 cups Kitchen Basics Beef Stock	https://www.edamam.com/food-img/428/4284513ddbf46e51f0f33566c0d61715.jpg	102
900	1 whole Medium Zucchini, Cubbed	https://www.edamam.com/food-img/f63/f637280594e4a731eccc1199194a8847.jpg	102
901	3 ounces, weight Carrots, Chopped	https://www.edamam.com/food-img/121/121e33fce0bb9546ed7d060b6c114e29.jpg	102
902	½ whole Medium Onion, Chopped	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	102
903	8 ounces, weight Cabbage Chopped	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	102
904	1 teaspoon Christopher Ranch Chopped Garlic (or 1 Clove, Minced)	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	102
905	1 teaspoon Roast Beef Spice Mx	https://www.edamam.com/food-img/634/634aa9adfb65afb5fef3df13d7334985.jpg	102
906	⅛ teaspoons Sage	https://www.edamam.com/food-img/509/50984580e9aad4b4ddd5b7ed45a64bf4.jpg	102
907	⅛ teaspoons Tarragon	https://www.edamam.com/food-img/22f/22f8945d157d8b759c30e6738639991b.jpg	102
908	⅛ teaspoons Thyme	https://www.edamam.com/food-img/3e7/3e7cf3c8d767a90b906447f5e74059f7.jpg	102
919	4 Tablespoons Peanut Oil (Coconut Oil For Nut Free), Divided	https://www.edamam.com/food-img/07e/07e106ab3536d57428e5c46d009038f8.jpg	104
920	1 pound Beef, Cut Into Strips	https://www.edamam.com/food-img/bab/bab88ab3ea40d34e4c8ae35d6b30344a.jpg	104
921	3 ounces, weight Leeks, Sliced, White Part Only	https://www.edamam.com/food-img/4ae/4ae9e09d029a28e0e2c64bdfdbf3f6ae.jpg	104
922	½ whole Medium Red Bell Pepper, Thinly Sliced	https://www.edamam.com/food-img/4dc/4dc48b1a506d334b4ab6671b9d56a18f.jpeg	104
923	4 ounces, weight Zucchini, Cubed	https://www.edamam.com/food-img/f63/f637280594e4a731eccc1199194a8847.jpg	104
924	3 ounces, weight Crimini Mushrooms, Sliced	https://www.edamam.com/food-img/17a/17a9ef54308a434004be9ba16c0eea03.jpg	104
925	1 clove Garlic, Minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	104
926	1 teaspoon Minced Ginger	https://www.edamam.com/food-img/b9c/b9c06ef451ef29513880af0a53ebbaa6.jpg	104
927	4 cups Green Cabbage Chopped	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	104
928	2 Tablespoons Tamari (or Gluten Free Soy Sauce)	https://www.edamam.com/food-img/f52/f5263a232df96ad21cf2120e05c941ae.jpg	104
929	2 Tablespoons Mitsukan Rice Vinegar (Zero Carbs)	https://www.edamam.com/food-img/5f6/5f69b84c399d778c4728e9ab4f8065a2.jpg	104
930	¼ teaspoons Crushed Red Pepper Flakes	https://www.edamam.com/food-img/6cb/6cb8e4510251a322178f6e191b3a7b1b.jpeg	104
931	¼ teaspoons Coarse Ground Black Pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	104
932	3 drops Gluten Free Fish Oil (or To Taste)	https://www.edamam.com/food-img/07e/07e106ab3536d57428e5c46d009038f8.jpg	104
946	1 (8 ounce) package breakfast sausage	https://www.edamam.com/food-img/2c7/2c73a127447b754a803e3804898a1afd.jpg	106
947	12 eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	106
948	1 (8 ounce) package shredded Cheddar cheese	/static/images/ing.png	106
949	3/4 cup heavy whipping cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	106
950	1 tablespoon minced onion	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	106
951	2 teaspoons dry mustard	https://www.edamam.com/food-img/9ff/9ff9e6d04cbc71ff884f3212afa0adfd.jpg	106
952	1 teaspoon dried oregano	https://www.edamam.com/food-img/1b0/1b0eaffb1c261606e0d82fed8e9747a7.jpg	106
953	salt and ground black pepper to taste	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	106
954	salt and ground black pepper to taste	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	106
960	8 Large Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	108
961	2 Celery Stalks	https://www.edamam.com/food-img/d91/d91d2aed1c36d8fad54c4d7dc58f5a18.jpg	108
962	2 Green Onion Stalks (tops only)	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	108
963	1 Green Pepper	https://www.edamam.com/food-img/629/629dc9fddc1f8aec27fa337dd6ce2b7c.jpg	108
964	1 tsp Yellow Mustard	https://www.edamam.com/food-img/e23/e238f2e4cfa6aa1a30f46dc73e7344eb.jpg	108
965	2/3 Cup Mayonnaise	/static/images/ing.png	108
971	6.0 large Egg, fresh, whole, raw	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	110
972	2.0 tbsp Sesame Oil	https://www.edamam.com/food-img/b87/b874ddcfb6770adc7a155355a902ffb8.jpg	110
973	99.0 gram Knorr Homestyle Stock - Chicken	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	110
918	0.5 tbsp Turmeric Powder	https://www.edamam.com/food-img/03e/03eb469286b3caf1ae9c13e4eba13587.jpg	103
933	6 cups Homemade Turkey Broth	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	105
934	24 ounces, weight Turkey Meat, Cubed Or Shredded	https://www.edamam.com/food-img/2c5/2c5c2bf2701d4b4adda0d8a85df1eceb.jpg	105
935	1 head (small) Cabbage, Chopped	https://www.edamam.com/food-img/cb1/cb1411c925c19de26620e63cb90d0e14.jpg	105
936	3 Carrots (4 If Small), Peeled And Sliced	https://www.edamam.com/food-img/121/121e33fce0bb9546ed7d060b6c114e29.jpg	105
937	3 sticks Celery, Chopped	https://www.edamam.com/food-img/d91/d91d2aed1c36d8fad54c4d7dc58f5a18.jpg	105
938	1 Onion, Coarse Chopped	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	105
939	14-½ ounces, fluid Uir Glen Organic Diced Tomatoes, Fire Roasted, With Juice	/static/images/ing.png	105
940	1 cube Chicken Bouillon (Gluten And Sugar Free)	/static/images/ing.png	105
941	1 cube Beef Bouillon (Gluten And Sugar Free)	https://www.edamam.com/food-img/6f7/6f71425571cb38887c2287f9860d33bd.jpg	105
942	1 teaspoon Ground Thyme	https://www.edamam.com/food-img/3e7/3e7cf3c8d767a90b906447f5e74059f7.jpg	105
943	1 teaspoon Herbes De Provence	https://www.edamam.com/food-img/89b/89b37a04e46e052671d73addcb84aa51.jpg	105
944	Salt And Pepper, to taste	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	105
945	Salt And Pepper, to taste	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	105
955	1.0 stick Butter, salted	https://www.edamam.com/food-img/515/515af390107678fce1533a31ee4cc35b.jpeg	107
956	8.0 oz Cream Cheese	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	107
957	2.0 tsp Cinnamon, ground	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	107
958	2.0 tsp Vanilla extract, imitation, alcohol	/static/images/ing.png	107
959	8.0 large Egg, fresh, whole, raw	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	107
966	1 1/2 cups Chicken Broth	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	109
967	1/2 cube Chicken Boullion	/static/images/ing.png	109
968	1 tbsp. Bacon Fat (or butter)	https://www.edamam.com/food-img/0c8/0c8bb3745771a7dec087d3f3b6fb6b7d.jpg	109
969	2 large Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	109
970	1 tsp. Chili Garlic Paste	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	109
974	3 cup Cauliflower	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	111
975	2 cup Cooked Shrimp	https://www.edamam.com/food-img/dab/dab4af51e4a31595410ce67fd283e2c6.jpg	111
976	3 cup White Mushrooms	https://www.edamam.com/food-img/d63/d639cf4a2afc7407c1d1ce286028136b.jpg	111
977	2 pieces Spring Onion	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	111
978	1 Tbsp Ginger Root	https://www.edamam.com/food-img/b9c/b9c06ef451ef29513880af0a53ebbaa6.jpg	111
979	1 Tbsp Hot Chili Pepper	https://www.edamam.com/food-img/469/469213672957a242638e20c27e3e8acd.jpeg	111
980	3 whole Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	111
981	0.5 cup Almonds	https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg	111
982	2 Tbsp fresh Basil	https://www.edamam.com/food-img/5f1/5f1b05685ac2b404236a5d1c1f3c8c10.jpg	111
983	2 Tbsp Mint Leaves	https://www.edamam.com/food-img/7f0/7f01cc4f71c5c6ad31051ed74b9c058b.jpg	111
984	2 Tbsp Cilantro	https://www.edamam.com/food-img/d57/d57e375b6ff99a90c7ee2b1990a1af36.jpg	111
985	0.5 pieces Lime Juice	https://www.edamam.com/food-img/8f0/8f0c10eb3dbf476a05e61018e76ea220.jpg	111
986	2 Tbsp Coconut Aminos	/static/images/ing.png	111
987	1 Tbsp Fish Sauce	https://www.edamam.com/food-img/7b5/7b58b769d8bf7b79acf12a76b79ea9bc.jpg	111
988	3 Tbsp Ghee (Clarified Butter)	https://www.edamam.com/food-img/2b5/2b504c036c64481b224c9d74cc4a82e0.jpg	111
989	0.25 tsp Himalayan Pink Sea Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	111
990	6 Large Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	112
991	4 Cups Cashew Milk	/static/images/ing.png	112
992	2 Cups Heavy Whipping Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	112
993	1/2 Cup Stevia	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	112
994	1/2 tsp Nutmeg	https://www.edamam.com/food-img/b9e/b9e54f78ae18cf99a6504b472ba25e7b.jpg	112
995	1/2 tsp All Spice	https://www.edamam.com/food-img/c3f/c3f96d47d334b92f0120ff0b3a512ec3.jpg	112
996	1/2 tsp Cinnamon	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	112
997	1/2 tsp Pumpkin Spice	https://www.edamam.com/food-img/be9/be9f44bb5fa838e7e1bf02e16ff29740.jpg	112
998	1/2 tsp Vanilla (optional)	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	112
999	2 Tablespoons coconut oil, melted	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	113
1000	6 Tablespoons coconut flour	/static/images/ing.png	113
1001	1/4 teaspoon baking soda	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	113
1002	1 Tablespoon Italian seasoning	https://www.edamam.com/food-img/89b/89b37a04e46e052671d73addcb84aa51.jpg	113
1003	1/2 teaspoon salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	113
1004	2 Tablespoons gelatin	/static/images/ing.png	113
1005	6 Tablespoons hot water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	113
1006	1 cup (8 fl oz) Chicken Broth	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	114
1007	3 large Egg, fresh, whole, raw	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	114
1008	2 oz deli sliced ham, Primo Taglio, ham-off-the-bone, (2 oz=3 thin slices)	https://www.edamam.com/food-img/a4b/a4ba02f547d69f0ab89ae266903f1e49.jpg	114
1009	1 tablespoon olive oil	/static/images/ing.png	115
1010	1/2 onion, diced	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	115
1011	1/2 red bell pepper, diced	https://www.edamam.com/food-img/4dc/4dc48b1a506d334b4ab6671b9d56a18f.jpeg	115
1012	2 cloves garlic, minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	115
1013	1 teaspoon chili powder	https://www.edamam.com/food-img/e6f/e6f19043caefc23b5feda5520076617e.jpg	115
1014	1/2 teaspoon smoked paprika	https://www.edamam.com/food-img/474/474d63763b9d8b9da98c5f43a114648c.jpg	115
1015	1/2 teaspoon ground cumin	https://www.edamam.com/food-img/07e/07e2a4eb77ce46591033846504817d35.jpg	115
1016	2 cups baby kale	https://www.edamam.com/food-img/8e9/8e9c5417fa012e5ca068fddc5f8d3d6c.jpg	115
1017	1 1/2 cups marinara sauce	https://www.edamam.com/food-img/08b/08b3bb49c006689a458a8b9c4a4e0057.jpg	115
1018	1/2 teaspoon sea salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	115
1019	1/2 teaspoon ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	115
1020	4 eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	115
1021	1 tablespoon chopped fresh parsley	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	115
1025	8 oz Cream Cheese	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	117
1026	8 large eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	117
1027	4 tbsp Butter We use this!	/static/images/ing.png	117
1028	2 scoops(62g) Whey Protein We use this!	https://www.edamam.com/food-img/8f6/8f65ee1f614c9ee0ea0d28e091e512dc.jpg	117
1033	2 Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	119
1034	2 Avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	119
1035	6 Bacon slices	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	119
1036	4 Tablespoon (fruity rub and Terrano meersalz) Seasoning	https://www.edamam.com/food-img/c23/c23e20823b442067307aa436969358f1.jpg	119
1037	4 Tablespoon Bbq sauce	https://www.edamam.com/food-img/7e3/7e303aa2cbb51e4bd70f71bf5cb4a754.jpg	119
1049	* 2 avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	122
1050	* 1 cup chopped red onion	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	122
1051	* 1/4 cup chopped parsley leaf	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	122
1052	* 1/2 lemon	https://www.edamam.com/food-img/70a/70acba3d4c734d7c70ef4efeed85dc8f.jpg	122
1053	* 1 key lime, a garnish	https://www.edamam.com/food-img/48a/48a123c9576647c4ada6a41df5eeb22a.jpg	122
1059	2 small (196g) Ripe Avocados (cold)	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	124
1060	1.5oz (45mL) Heavy Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	124
1061	1.5 Packets Truvia	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	124
1065	3 oz. chicken breast (cooked, shredded)	https://www.edamam.com/food-img/093/093749f4c93e448119fc81976d2c3067.jpg	126
1066	¼ C red onion (diced)	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	126
1067	2 stalks of celery (diced)	https://www.edamam.com/food-img/d91/d91d2aed1c36d8fad54c4d7dc58f5a18.jpg	126
1068	1 English Cucumber, skin left on	https://www.edamam.com/food-img/501/5015da0e5fc2b384696b3d949aefef86.jpg	126
1069	4 medium avocados	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	126
1070	1 C Avocado Oil Mayo or Sour Cream	https://www.edamam.com/food-img/f9d/f9d6183267b041b0aff9a10b89c9c15f.jpg	126
1076	2 cups shredded Cheddar cheese	/static/images/ing.png	128
1077	1 pound ground beef	https://www.edamam.com/food-img/cfa/cfae8f9276eaf8f0d9349ba662744a0c.jpg	128
1078	1/2 package taco seasoning mix	https://www.edamam.com/food-img/c23/c23e20823b442067307aa436969358f1.jpg	128
1079	1/2 teaspoon salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	128
1080	1/4 teaspoon ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	128
1081	1 avocado, diced	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	128
1082	1 cup shredded lettuce	https://www.edamam.com/food-img/719/71996625d0cb47e197093ecd52c97dc2.jpg	128
1083	1/2 cup shredded Cheddar cheese	/static/images/ing.png	128
1084	1/2 cup tomatoes, diced	https://www.edamam.com/food-img/23e/23e727a14f1035bdc2733bb0477efbd2.jpg	128
1089	4.0 serving Chicken - Boneless & Skinless Breast (4 ounces)	https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg	130
1090	14.0 gram(s) Avocado Oil - Chosen Foods - 1 TBSP	https://www.edamam.com/food-img/ce2/ce24db634b117a51aa525b29a110a318.jpg	130
1091	1.0 clove Garlic	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	130
1092	0.25 cup Sun Dried Tomatoes	https://www.edamam.com/food-img/023/0231ec1c0873483bd9747d71d57e6215.jpeg	130
1093	0.25 cup, fluid (yields 2 cups whipped) Heavy Whipping Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	130
1101	1 slice bacon	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	132
1102	1/2 medium avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	132
1103	3.5 oz chicken breast	https://www.edamam.com/food-img/093/093749f4c93e448119fc81976d2c3067.jpg	132
1104	1 oz Cheddar Cheese	/static/images/ing.png	132
1105	1 large hard boiled egg	https://www.edamam.com/food-img/e54/e54c012fabed0f9cf211a817d1e23c5c.jpg	132
1106	1 head romaine lettuce	/static/images/ing.png	132
1107	1 tbsp olive oil We get ours on Amazon	/static/images/ing.png	132
1108	1 tbsp apple cider vinegar we get ours on amazon	https://www.edamam.com/food-img/c7d/c7dbd1846c5d08e9739930d70a404d50.jpg	132
1117	1/2 medium avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	134
1118	1/2 cup kale	https://www.edamam.com/food-img/8e9/8e9c5417fa012e5ca068fddc5f8d3d6c.jpg	134
1119	1/2 cucumber	https://www.edamam.com/food-img/501/5015da0e5fc2b384696b3d949aefef86.jpg	134
1120	1/2 inch ginger root	https://www.edamam.com/food-img/b9c/b9c06ef451ef29513880af0a53ebbaa6.jpg	134
1121	1/2 cup coconut water (120ml)	https://www.edamam.com/food-img/e87/e8727217b99560851490c217b9a2117c.jpg	134
1022	1.0 large egg, beaten	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	116
1023	0.75 oz Romano Cheese, grated (about 2 heaping Tbsp)	https://www.edamam.com/food-img/71a/71a53d043eded9a8914415178a07f879.jpg	116
1024	1.5 oz Parmesan Cheese, grated (about 4 heaping Tbsp)	https://www.edamam.com/food-img/f58/f588658627c59d5041e4664119829aa9.jpg	116
1029	3 large eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	118
1030	75g ground almonds	https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg	118
1031	1.5tsp baking powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	118
1032	Large knob of butter (American readers: about 2tbsp)	/static/images/ing.png	118
1038	* 1 small head of cauliflower	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	120
1039	* 1 egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	120
1040	* 3/4 cup shredded cheese (cheddar work best)	/static/images/ing.png	120
1041	* 1/4 tsp garlic powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	120
1042	* 1/2 tsp salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	120
1043	* ⅛ tsp black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	120
1044	1 ripe avocado - peeled, pitted, and diced	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	121
1045	1/4 cup heavy whipping cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	121
1046	1/2 teaspoon liquid stevia	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	121
1047	1/4 teaspoon vanilla extract	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	121
1048	1/4 teaspoon ground cinnamon	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	121
1054	2 Large Avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	123
1055	10 oz Monterey Jack Cheese	https://www.edamam.com/food-img/590/59062b9f8d57ebc7d831b7b7c231f726.jpg	123
1056	16 oz Cream Cheese	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	123
1057	1/2 Tbsp Minced Garlic	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	123
1058	1 tsp Onion Powder	https://www.edamam.com/food-img/1e7/1e73e6f5dd96bb233abc0fcc05fb0ec8.jpg	123
1062	1 avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	125
1063	1 lime	https://www.edamam.com/food-img/48a/48a123c9576647c4ada6a41df5eeb22a.jpg	125
1064	10-12 slices of prosciutto (or deli ham or turkey slices)	https://www.edamam.com/food-img/802/8029e7b80cce92694182b85a1ebd1822.jpg	125
1071	4 oz. avocado soft and creamy	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	127
1072	2.5 oz. coconut cream	https://www.edamam.com/food-img/9ab/9ab9561c5090adb4f86631c26c89a391.jpg	127
1073	1.5 oz. cocoa powder unsweetened	https://www.edamam.com/food-img/89a/89af89595db3cf2c3007f2b064c5fef6.jpg	127
1074	2 tbsp. stevia based sweetener (e.g. Truvia)	https://www.edamam.com/food-img/0e3/0e3edc39fe123b516c4c758f4f09e99f.jpg	127
1075	1 tsp. liquid stevia	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	127
1085	* 1 slice of cheddar cheese	/static/images/ing.png	129
1086	* 1/2 avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	129
1087	* 4 streaky bacon rasher	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	129
1088	* a handful of baby kale leaf	https://www.edamam.com/food-img/8e9/8e9c5417fa012e5ca068fddc5f8d3d6c.jpg	129
1094	¾ cup full-fat coconut milk	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	131
1095	3 tablespoons pumpkin puree	/static/images/ing.png	131
1096	1 tablespoon MCT oil, optional	https://www.edamam.com/food-img/07e/07e106ab3536d57428e5c46d009038f8.jpg	131
1097	1 teaspoon loose chai tea	https://www.edamam.com/food-img/793/79376cb6e124624e22780db7401601a4.jpg	131
1098	1 teaspoon alcohol-free vanilla	https://www.edamam.com/food-img/90f/90f910b0bf82750d4f6528263e014cca.jpg	131
1099	½ teaspoon pumpkin pie spice *see note	https://www.edamam.com/food-img/be9/be9f44bb5fa838e7e1bf02e16ff29740.jpg	131
1100	½ fresh or frozen avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	131
1109	4 pastured or organic eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	133
1110	10 kalamata olives, pitted	https://www.edamam.com/food-img/822/8221f2141e8dafd469414b20777735ca.jpg	133
1111	2 Oz full fat Brie Cheese	https://www.edamam.com/food-img/f53/f5340600239cf508f17b167265c6a1cf.jpg	133
1112	1 teaspoon Herbes De Provence (buy it here)	https://www.edamam.com/food-img/89b/89b37a04e46e052671d73addcb84aa51.jpg	133
1113	2 Tbs MCT Oil (buy it here)	https://www.edamam.com/food-img/07e/07e106ab3536d57428e5c46d009038f8.jpg	133
1114	2 Tbs organic butter	/static/images/ing.png	133
1115	½ tsp sea salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	133
1116	1 avocado	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	133
1126	1 medium avocado (150 g/ 5.3 oz)	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	135
1127	½ small white or yellow onion, chopped (35 g/ 1.2 oz)	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	135
1128	2 tbsp fresh lime juice (30 ml/ 1 fl oz)	https://www.edamam.com/food-img/8f0/8f0c10eb3dbf476a05e61018e76ea220.jpg	135
1129	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	135
1130	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	135
1131	ghee	https://www.edamam.com/food-img/2b5/2b504c036c64481b224c9d74cc4a82e0.jpg	135
1132	170 g gluten-free (Italian) sausage meat (6 oz)	https://www.edamam.com/food-img/2c7/2c73a127447b754a803e3804898a1afd.jpg	135
1133	2 large eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	135
1134	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	135
1135	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	135
1122	3/4 cup water (180ml)	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	134
1123	handful of ice	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	134
1124	1 tbsp chia seed	https://www.edamam.com/food-img/bcc/bcc6e6bf3175772ad00b414636467257.jpg	134
1125	1-2 tbsp mct oil	https://www.edamam.com/food-img/07e/07e106ab3536d57428e5c46d009038f8.jpg	134
1136	1 teaspoon Avocado Oil	https://www.edamam.com/food-img/ce2/ce24db634b117a51aa525b29a110a318.jpg	136
1137	1 pound Beef Stew Meat	https://www.edamam.com/food-img/bab/bab88ab3ea40d34e4c8ae35d6b30344a.jpg	136
1138	1 Onion, Diced	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	136
1139	1 Red Bell Pepper, Diced	https://www.edamam.com/food-img/4dc/4dc48b1a506d334b4ab6671b9d56a18f.jpeg	136
1140	6 cloves Garlic, Minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	136
1141	1 pound Ground Beef Chuck	https://www.edamam.com/food-img/bab/bab88ab3ea40d34e4c8ae35d6b30344a.jpg	136
1142	2 Tablespoons Tomato Paste	/static/images/ing.png	136
1143	2 Tablespoons Chili Powder	https://www.edamam.com/food-img/e6f/e6f19043caefc23b5feda5520076617e.jpg	136
1144	1 Tablespoon Garlic Powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	136
1145	1 Tablespoon Onion Powder	https://www.edamam.com/food-img/1e7/1e73e6f5dd96bb233abc0fcc05fb0ec8.jpg	136
1146	1 Tablespoon Cumin	https://www.edamam.com/food-img/07e/07e2a4eb77ce46591033846504817d35.jpg	136
1147	2 Tablespoons Smoked Paprika	https://www.edamam.com/food-img/474/474d63763b9d8b9da98c5f43a114648c.jpg	136
1148	1 Tablespoon Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	136
1149	1 can (28 Oz. Size) Crushed Tomatoes	https://www.edamam.com/food-img/1d7/1d785da8ce8dca92df262103058b05d1.jpg	136
1150	1 lb bacon	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	137
1151	1 lb 73% lean ground beef	https://www.edamam.com/food-img/cfa/cfae8f9276eaf8f0d9349ba662744a0c.jpg	137
1152	1/2 cup Finely Shredded Medium Cheddar Cheese	/static/images/ing.png	137
1153	1/2 cup Heavy Whipping Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	137
1154	4 large eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	137
1155	1 Pack Boneless Skinless Chicken Breast	https://www.edamam.com/food-img/da5/da510379d3650787338ca16fb69f4c94.jpg	138
1156	1 Pack Bacon	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	138
1157	1/2 Cup Heavy Whipping Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	138
1158	3 Tbsp Butter	/static/images/ing.png	138
1159	2 Tbsp Natural Dijon Mustard	https://www.edamam.com/food-img/e23/e238f2e4cfa6aa1a30f46dc73e7344eb.jpg	138
1160	5 Large Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	139
1161	5 Thick Cut Bacon Slices	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	139
1162	2 Tbsp Butter	/static/images/ing.png	139
1163	1/2 Cup Bob's Almond Meal/flour	/static/images/ing.png	139
1164	1/4 Cup Flax Seed Meal	https://www.edamam.com/food-img/e9b/e9bd9cc62d0dbe0753911e295a0ba0ca.jpg	139
1165	1/2 Cup & 1 tsp Cheddar Cheese	/static/images/ing.png	139
1166	1 1/2 Tbsp Psyllium Husk Powder	/static/images/ing.png	139
1167	2 Avocados Cubed	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	139
1168	1 Can Coconut Milk (Unsweetened)	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	139
1169	1 Stalk Green Onions	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	139
1170	1 Tbsp Lemon Juice	https://www.edamam.com/food-img/e31/e310952d214e78a4cb8b73f30ceeaaf2.jpg	139
1171	1 tsp Baking Powder	https://www.edamam.com/food-img/a84/a8410ec57a2e62a1ad9955ac14d40af6.jpg	139
1172	1 tsp Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	139
1173	1 tsp Pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	139
1174	1/4 tsp Garlic Powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	139
1175	1/4 tsp Red Pepper Flake	https://www.edamam.com/food-img/6cb/6cb8e4510251a322178f6e191b3a7b1b.jpeg	139
1176	16 Eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	140
1177	1 Cup Heavy Whipping Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	140
1178	4 tsp Parsley Flakes	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	140
1179	1 Cup Frozen Spinach (thawed and drained)	https://www.edamam.com/food-img/e6e/e6e4be375c4554ce01c8ea75232efaa6.jpg	140
1180	1 Cup Shredded Cheddar Cheese	/static/images/ing.png	140
1181	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	140
1182	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	140
1183	6 chicken breast/fillets	https://www.edamam.com/food-img/093/093749f4c93e448119fc81976d2c3067.jpg	141
1184	6 tbsp cream cheese	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	141
1185	2 slice bacon diced	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	141
1186	1 handful spinach	https://www.edamam.com/food-img/e6e/e6e4be375c4554ce01c8ea75232efaa6.jpg	141
1187	1 1/2 cups almond flour	/static/images/ing.png	142
1188	1/2 teaspoon Italian seasoning	https://www.edamam.com/food-img/89b/89b37a04e46e052671d73addcb84aa51.jpg	142
1189	1/2 teaspoon salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	142
1190	1/4 cup olive oil	/static/images/ing.png	142
1191	2 tablespoons Dijon mustard	https://www.edamam.com/food-img/e23/e238f2e4cfa6aa1a30f46dc73e7344eb.jpg	142
1192	6 slices bacon, cut crosswise into 1/2-inch pieces	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	142
1193	1 1/2 cups heavy cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	142
1194	5 eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	142
1195	1 teaspoon garlic	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	142
1196	1 teaspoon salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	142
1197	1/2 teaspoon ground black pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	142
1198	1/4 teaspoon ground nutmeg	https://www.edamam.com/food-img/b9e/b9e54f78ae18cf99a6504b472ba25e7b.jpg	142
1199	2 cups shredded Gouda cheese	https://www.edamam.com/food-img/7d7/7d700e635219e5185a13c91d8bd02eb1.jpg	142
1200	1/2 cup cherry tomatoes, cut into halves	https://www.edamam.com/food-img/23e/23e727a14f1035bdc2733bb0477efbd2.jpg	142
1201	1/2 teaspoon dried oregano	https://www.edamam.com/food-img/1b0/1b0eaffb1c261606e0d82fed8e9747a7.jpg	142
1208	32 oz Ground beef	https://www.edamam.com/food-img/cfa/cfae8f9276eaf8f0d9349ba662744a0c.jpg	144
1209	3 cup Kraft Finely Shredded Sharp Cheddar Cheese	/static/images/ing.png	144
1210	6 serving Bacon, Applegate Farms Sunday Bacon (2 strips)	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	144
1219	2 Cooked Chicken Breast, Chopped	https://www.edamam.com/food-img/44c/44c95571e5b3071f266e0e742e670585.jpg	146
1220	2 Avocados, Chopped	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	146
1221	1 cup Celery, Diced	https://www.edamam.com/food-img/d91/d91d2aed1c36d8fad54c4d7dc58f5a18.jpg	146
1222	4 slices Bacon, Chopped	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	146
1223	1 Tablespoon Dried Chives	https://www.edamam.com/food-img/f3f/f3f48643a924ba174b894e979cb48620.jpg	146
1224	1 teaspoon Dried Dill	https://www.edamam.com/food-img/927/927173abe613e0c9124c406d236e81bd.jpg	146
1225	3 Tablespoons Lemon Juice	https://www.edamam.com/food-img/e31/e310952d214e78a4cb8b73f30ceeaaf2.jpg	146
1226	3 Tablespoons Olive Oil	/static/images/ing.png	146
1227	1 teaspoon Kosher Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	146
1228	½ teaspoons Fresh Cracked Black Pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	146
1239	1 pound cauliflower florettes	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	148
1240	4 ounces sour cream	https://www.edamam.com/food-img/f9d/f9d6183267b041b0aff9a10b89c9c15f.jpg	148
1241	1 cup grated cheddar cheese	/static/images/ing.png	148
1242	2 slices cooked bacon crumbled	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	148
1243	2 tablespoons snipped chives	https://www.edamam.com/food-img/f3f/f3f48643a924ba174b894e979cb48620.jpg	148
1244	3 tablespoons butter	/static/images/ing.png	148
1245	1/4 teaspoon garlic powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	148
1246	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	148
1247	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	148
1257	¼ cup almond flour (25 g / 0.9 oz)	/static/images/ing.png	150
1258	¼ cup flaxmeal (38 g / 1.3 oz)	/static/images/ing.png	150
1259	¼ tsp baking soda	https://www.edamam.com/food-img/7e5/7e55e4482cc2fde91f427fc568e6f5b8.jpeg	150
1260	1 large egg, free-range or organic	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	150
1261	2 tbsp cream or coconut milk (30 ml/ 1 fl oz)	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	150
1262	2 tbsp water	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	150
1263	pinch salt (I like pink Himalayan)	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	150
1264	4 small or 2 regular slices crisped up bacon (32 g/ 1.1 oz)	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	150
1265	¼ cup sliced mushrooms (25 g/ 0.9 oz)	https://www.edamam.com/food-img/d63/d639cf4a2afc7407c1d1ce286028136b.jpg	150
1266	½ cup diced cheddar cheese (33 g/ 1.2 oz)	/static/images/ing.png	150
1267	1 tbsp freshly chopped basil or parsley	https://www.edamam.com/food-img/5f1/5f1b05685ac2b404236a5d1c1f3c8c10.jpg	150
1268	4 Cans of Tuna	https://www.edamam.com/food-img/b53/b53adeb03d265a094fb598dd89f33450.jpg	151
1269	1/4 Cup Fishers Pecan Halves	https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg	151
1270	1 Cup Mayonnaise	/static/images/ing.png	151
1271	1 Cup Red Seedless Grapes (use 1/2 cup for less carbs)	https://www.edamam.com/food-img/ca5/ca55ac74deb991d159942c65777115df.jpg	151
1278	1 1/2 cups Unsweetened Coconut Milk (from the carton)	https://www.edamam.com/food-img/671/671f7528eadb1b01efb53243d0ef0f80.JPG	153
1279	1/4 cup Heavy Cream	https://www.edamam.com/food-img/484/4848d71f6a14dd5076083f5e17925420.jpg	153
1280	5 tbsp. Butter	/static/images/ing.png	153
1281	1/4 cup Pecans, crushed	https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg	153
1282	25 drops Liquid Stevia	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	153
1283	1/4 tsp. Xanthan Gum	/static/images/ing.png	153
1296	2 ounces cream cheese, softened	https://www.edamam.com/food-img/ddd/dddce306e7ee41e8e07dc62e28cab94b.jpg	155
1297	2 eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	155
1298	1 teaspoon white sugar	https://www.edamam.com/food-img/ecb/ecb3f5aaed96d0188c21b8369be07765.jpg	155
1299	1/2 teaspoon ground cinnamon	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	155
1300	cooking spray	/static/images/ing.png	155
1202	2 Chicken Breasts	https://www.edamam.com/food-img/093/093749f4c93e448119fc81976d2c3067.jpg	143
1203	4 oz Cheddar Cheese	/static/images/ing.png	143
1204	2 oz Jalapeno Slices (Optional)	https://www.edamam.com/food-img/0df/0df9aa459870a6d477b0925c1fdb6d4c.jpg	143
1205	salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	143
1206	pepper	https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg	143
1207	4 slices Bacon	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	143
1211	4 strips bacon	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	145
1212	1 cup whole milk mozzarella cheese, shredded	/static/images/ing.png	145
1213	1 tablespoon ghee	https://www.edamam.com/food-img/2b5/2b504c036c64481b224c9d74cc4a82e0.jpg	145
1214	5 large eggs	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	145
1215	½ avocado, diced	https://www.edamam.com/food-img/984/984a707ea8e9c6bf5f6498970a9e6d9d.jpg	145
1216	1 ounce cheddar cheese, shredded	/static/images/ing.png	145
1217	1 Campari tomato, diced	https://www.edamam.com/food-img/23e/23e727a14f1035bdc2733bb0477efbd2.jpg	145
1218	1 stem green onion, thinly sliced	https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg	145
1229	4 Zucchini, spiralized	https://www.edamam.com/food-img/f63/f637280594e4a731eccc1199194a8847.jpg	147
1230	5 slices Bacon (get Keto and Whole30-compliant bacon from US Wellness Meats)	https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg	147
1231	2 large Chicken Breasts	https://www.edamam.com/food-img/093/093749f4c93e448119fc81976d2c3067.jpg	147
1232	1 head Cauliflower (about 3 cups, broken into small pieces)	https://www.edamam.com/food-img/ca2/ca217d31067dffd35ce1215e7f336bd8.jpg	147
1233	1 small Yellow Onion, chopped	https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg	147
1234	1/2 teaspoon Sea Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	147
1235	1 teaspoon Garlic, minced	https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg	147
1236	1/2 cup Chicken Broth	https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg	147
1237	1 1/4 cups Almond Milk (Watch for ingredients that aren't Paleo or Whole30. When in doubt, make it yourself)	/static/images/ing.png	147
1238	1 tablespoon Fresh Parsley (1 teaspoon dried, chopped)	https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg	147
1248	1 pound turkey, ground	https://www.edamam.com/food-img/45b/45ba5c5df6da8dbc4d19f2bd7d04d345.jpg	149
1249	1 cup mozzarella, grated and loosely packed	https://www.edamam.com/food-img/03e/03ec3a4d46bec5634dc8a352804e4e68.jpg	149
1250	1 egg	https://www.edamam.com/food-img/a7e/a7ec7c337cb47c6550b3b118e357f077.jpg	149
1251	1 teaspoon garlic powder	https://www.edamam.com/food-img/5c3/5c3db1d5a1a16b1f0a74796f74dd5985.jpg	149
1252	2 tablespoons tomato sauce	/static/images/ing.png	149
1253	1/2 cup mozzarella cheese	/static/images/ing.png	149
1254	4 olives, sliced	https://www.edamam.com/food-img/822/8221f2141e8dafd469414b20777735ca.jpg	149
1255	4 slices canadian bacon	https://www.edamam.com/food-img/adc/adc73ce633a9fa7c6c83f8dacac23fcc.jpg	149
1256	8 slices pepperoni	https://www.edamam.com/food-img/10b/10b28aa71cbe520aef944186f2b365b9.jpg	149
1272	1 serving Egg white, large	/static/images/ing.png	152
1273	1 Tbs. Water, tap	https://www.edamam.com/food-img/5dd/5dd9d1361847b2ca53c4b19a8f92627e.jpg	152
1274	2/3 cup Golden Monkfruit Sweetener, Lakanto	https://www.edamam.com/food-img/0e3/0e3edc39fe123b516c4c758f4f09e99f.jpg	152
1275	1 tsp Cinnamon, ground	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	152
1276	1 tsp Himalayan Pink Salt	https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg	152
1277	3 oz (60 halves) Pecans	https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg	152
1284	1 cup Coconut & Pecan Butter (250 g/ 8.8 oz)	https://www.edamam.com/food-img/a27/a27851affdcc1da2d94da0a4fbe3b062.jpg	154
1285	¼ cup powdered Erythritol (40 g/ 1.4 oz) or 2-4 tbsp Homemade Sugar-Free Maple Syrup	https://www.edamam.com/food-img/ced/ced25c45453a118e531c8aaf33e2ee38.jpg	154
1286	¼ cup powdered Erythritol (40 g/ 1.4 oz) or 2-4 tbsp Homemade Sugar-Free Maple Syrup	https://www.edamam.com/food-img/ced/ced25c45453a118e531c8aaf33e2ee38.jpg	154
1287	1 cup vanilla or plain whey protein or egg white protein powder (high quality such as Jay Robb) or plant-based such as NuZest or hydrolysed gelatine powder - collagen (100 g / 3.5 oz)	https://www.edamam.com/food-img/76a/76ab108398f84ad08fe841d3409ab70a.jpg	154
1288	1 tsp sugar-free maple extract (skip if using sugar-free maple syrup)	https://www.edamam.com/food-img/ced/ced25c45453a118e531c8aaf33e2ee38.jpg	154
1289	¼ cup extra virgin coconut oil (55 g/ 1.9 oz)	https://www.edamam.com/food-img/3c9/3c97284c57e76e16093d51572b558be8.jpg	154
1290	Optional: 1 tsp cinnamon and 10-20 drops Stevia extract	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	154
1291	Optional: 1 tsp cinnamon and 10-20 drops Stevia extract	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	154
1292	Optional: 1 tsp cinnamon and 10-20 drops Stevia extract	https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg	154
1293	Optional: 1 tsp cinnamon and 10-20 drops Stevia extract	https://www.edamam.com/food-img/b3f/b3f2a3fc27a8563cbabc38f55bc446ac.jpg	154
1294	3.5 oz 85-90% dark chocolate (100 g)	https://www.edamam.com/food-img/3cf/3cf0e13350f43392dc13c07d27ad145d.jpg	154
1295	1 oz cocoa butter or coconut oil (28 g)	https://www.edamam.com/food-img/1d7/1d785da8ce8dca92df262103058b05d1.jpg	154
\.


--
-- Data for Name: instructions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.instructions (id, step_no, step, recipe_id) FROM stdin;
8	1	Preheat the oven to 200 F / 400 F. Place the salmon filets on a baking tray lined with parchment paper. Drizzle with ghee and transfer into the oven for 20-25 minutes. When done, remove from the oven and let it cool down. Then, peel and discard the skin.	6
9	2	Peel and slice the garlic and dice the onion. Place the cooked salmon and garlic into a food processor and pulse until smooth.	6
10	3	Add the onion, pecan nuts, mayonnaise,...	6
11	4	... cream cheese, lemon juice, salt and pepper.	6
12	5	Pulse for a few seconds until desired consistency is reached.	6
13	6	Spoon the paté into a bowl and add freshly chopped parsley. Mix until well combined. Serve immediately and cover with a wrap and store in the fridge for up to 5 days.	6
14	7	Serve on top of low-carb bread, with breadsticks, tortilla chips or Cheesy Spinach Crackers.	6
15	1	In a vitamix, combine coconut milk, protein powder, chia, and stevia	7
16	2	Blend in chocolate until smooth	7
17	3	Blend in ice cubes until mixture is well combined	7
18	4	Serve	7
19	1	Pulse in eggs, lemon zest, and stevia until batter is very smooth	8
20	2	Stir in blueberries by hand	8
21	3	Transfer batter to a greased 9 x 5 inch baking dish	8
22	4	Bake at 350F for 45-55 min	8
23	5	Cool for 2 hours, then remove from pan	8
24	6	Serve	8
25	1	Cook the bacon in a pan until nice and crisp.Crumble and add to salad with the rest of the ingredients.Shake or mix salad until well dressed.	9
26	2	Serve.	9
27	1	Separate the egg whites and from the egg yolks. You will only need 2 egg yolks and 8 egg whites, as the crepes hold better together when more egg whites are used. Reserve the remaining egg yolks for another recipe.	10
28	2	Place the whole eggs and egg whites, coconut flour, psyllium husk or chia seeds, coconut milk, baking soda and cream of tartar in a bowl and mix well.	10
29	3	Add the garlic powder (or sweetener if making sweet keto crepes) and whisk well.Allow the batter to sit for 5-10 minutes so the coconut flour and psyllium have time to swell and absorb the moisture.	10
30	4	Whisk again.	10
31	5	Heat a nonstick pan evenly with the ghee or coconut oil. Move the pan while pouring in the batter to ensure the batter covers the bottom of the pan in a thin layer. The batter should be runny so it will spread easily. If it is too thick, you may add 1 tablespoon of water to the mixture.Make the crepes one by one, greasing the pan in between to ensure the keto crepes don't stick.Depending on the size, you can make 2 large or 4 medium crepes per serving.Once cool, store in an airtight container in the fridge for up to 5 days.	10
32	1	Stir all ingredients, except water, together using a spatula until evenly mixed.	11
33	2	Mixture should be the consistency of cornbread batter. If batter is too thick, add water or cream, 1 tablespoon at a time.	11
34	3	Spray 4oz ramekin or custard cup with olive oil. Microwave on high for 45 seconds to 1 minute.	11
35	4	Remove cake from ramekin and cool on a wire rack. Frost or top with your favorite sugar free topping or icing and enjoy.	11
36	1	Place blueberries, water and seasonings in small pot over medium heat. Bring to a boil and then turn down to simmer for 15 minutes until reduced by half.	12
37	2	Add cream cheese in and mix until smooth, remove from stove and set aside to cool.I prefer a little sweeter taste and will add Stevia to the concoction until I achieve my desired taste. You will need to add that to your net carbs for the day if you do.I whip my concoction in the food processor as I prefer the texture. I use 2 TBSP per pancake	12
38	3	Serving Size: Makes 16-1 TBSP servings	12
39	1	Make the Ultimate Keto Buns. Prepare the mushrooms for marinating. Season with salt and pepper, add crushed garlic and freshly chopped herbs and ghee, preferably melted. Keep some of the ghee for frying the eggs.	13
40	2	Keep the mushrooms at room temperature and marinate for up to an hour. Although marinating is highly recommended, you can skip it if you don't have time.	13
41	3	Place the mushrooms top side up on a hot griddle pan or a regular pan. Cook over a medium-high heat for about 5 minutes. Then, flip on the other side and cook for 5 more minutes.	13
42	4	Take off the heat. Flip back on the top side and top each of the mushrooms with cheese slices. Just before serving, place under a broiler for a few minutes until the cheese has melted.	13
43	5	Meanwhile, fry the eggs on the remaining ghee. You can use pancake molds to create perfect shapes for the burgers. Cook the eggs until the egg white is opaque and the yolks still runny. Then, take off the heat.	13
44	6	Cut the buns in half and place each halve, cut side down on a hot griddle pan and cook for 2-3 minutes until crispy.	13
45	7	Start assembling the burgers by adding a tablespoon of mayo on each of the keto bun halves. Top with the Portobello mushrooms.	13
46	8	Add fried eggs a slices of tomato and lettuce.	13
47	9	Serve any remaining lettuce aside. The burgers are best eaten fresh. The burger buns can be stored at room temperature for u to about 3 days.	13
48	1	Preheat oven to 400ºF and prepare a baking sheet with parchment paper or a silicone baking mat.	14
49	2	In a medium-sized bowl, combine almond flour, garlic powder, salt and baking powder.	14
50	3	In a large bowl, whisk eggs with cheese and melted butter.	14
51	4	Add dry ingredients and stir well.	14
52	5	Scoop biscuit mixture into 9 rounds, 2 inches apart. I use a 2-tablespoon cookie scoop. Flatten the tops and bake in the preheated oven for 15 minutes.	14
53	6	To make the bacon butter, add bacon and butter to a food processor and pulse until desired texture.	14
54	7	Serve with biscuits.	14
55	8	Nutrition for 1 biscuit and 1/9th of the bacon butter (using Great Value brand almond flour): 399 calories, 36g fat, 15g sat fat, 6g carbs, 4g fiber, 13g protein	14
56	1	Please watch the video for directions!	15
57	1	Combine almond flour, coconut flour, xanthan gum, baking powder, and salt in the bowl of a food processor; pulse until well combined.	16
58	2	Pour apple cider vinegar into the mixture and blend until smooth.	16
59	3	Add egg and water, 1 tablespoon at a time, and blend until a sticky dough ball is formed.	16
60	4	Place the dough on a surface sprinkled with almond flour and knead until soft, about 2 minutes. Wrap dough in plastic wrap and let it stand for 10 minutes. Divide dough into 8 equal balls; roll out each ball into a 5-inch disc between two sheets of parchment paper.	16
61	5	Heat an iron skillet over medium-high heat and grease with cooking spray.	16
62	6	Place dough disc in the hot skillet for just 5 seconds; flip it immediately with a spatula, and cook until lightly golden, about 40 seconds. Flip and cook for another 40 seconds.	16
63	1	Cook the diced onion in the coconut oil until translucent.	17
64	2	Add in the green beans and saute for a few minutes more.	17
65	3	Add in the broth or water and bring to a boil.	17
66	4	Add in the curry powder, garlic powder, and salmon.	17
67	5	Add in the coconut cream and simmer until the salmon is cooked (3-5 minutes).	17
68	6	Add salt and pepper to taste and serve with the chopped basil.	17
69	1	Heat the oil in a large frying pan or cast iron pan.	18
70	2	Add the onion, garlic, ginger, and turmeric. Cook over medium heat, stirring often, until golden, about 8 minutes.	18
71	3	Add the coconut milk, water, lime zest, and lime juice to the mixture and bring to a simmer.Stir in the vegetables and season with salt and pepper. Cover and remove from the heat.Preheat a grill pan. Rub the salmon with salt and pepper. Grill with the skin side touching the pan over medium heat for 5 minutes. Turn and grill until cooked through.	18
72	4	Transfer salmon and vegetables to a serving plate and dig in.	18
73	1	Place all the dry ingredients in a small bowl and combine well.	19
74	2	Add the egg, cream, water and mix well using a fork.	19
75	3	Slice the smoked salmon and finely chop the chives.	19
76	4	Add to the mixture and combine well.	19
77	5	Microwave on high for 60-90 seconds. When done, top with a dollop of cream cheese and enjoy!	19
78	1	Preheat oven to 350	20
79	2	Place salmon filets on a baking sheet	20
80	3	Lightly rub 1/4 tsp of rosemary garlic seasoning on the skin side	20
81	4	Flip salmon and spread 1/4 tsp of rosemary garlic on the other side	20
82	5	Cook skin side down	20
83	6	Bake fish for 20 minutes	20
84	7	Mix all ingredients together until well combined	20
85	8	Serve on warm salmon	20
86	1	Using a food processor, rice the cauliflower into rice-sized pieces by pulsing.Slice the cucumber on each end, then place the cucumber upright and slice off each side.Discard the middle and slice about 2 side pieces into small strips. Set aside in the fridge.In a very hot pan, add cauliflower rice and cook. Season with soy sauce as the cooking process happens, about 1 tbsp.Once the cauliflower is finished up and dried out some, add to a bowl with cream cheese and rice vinegar.	21
87	2	Mix together well and set in the fridge until cool.Once the rice mixture is cooled, slice 1/2 an avocado into small strips and scoop out of the shell.Put a nori sheet down on a bamboo roller covered with saran wrap (this helps with sticking).	21
88	3	Spread some of the cauliflower rice mixture over the nori sheet, add fillings and roll tightly.	21
89	1	Spread the Mrs. Dash on a dish.	22
90	2	Mix the ingredients separately (chop the lox)Make into balls	22
91	3	Roll in the Mrs. Dash	22
92	4	MixServing Size: 1 round (about 1 inch each)Number of Servings: 9Recipe submitted by Spark	22
93	5	People user COUNTESSTAME.	22
94	1	Whisk coconut milk, curry paste and a pinch of salt.	23
95	2	Place salmon, skin-side up in a small baking dish, and pour coconut sauce over top. Spoon sauce all over fish to cover it. Cover with plastic wrap and refrigerate for at least 2 hours.	23
96	3	Once salmon has marinated, place a strainer over a large bowl and place zucchini noodles into the strainer.	23
97	4	Sprinkle with salt and let sit for 30 minutes, stirring around every so often to release the water.	23
98	5	Heat oven to 450ºF and gently flip salmon over, so the skin-side is down. Spoon more sauce over top and bake until fish flakes easily, about 10–12 minutes.	23
99	6	Transfer fish to a plate and cover with tinfoil to keep warm.	23
100	7	Squeeze out all the excess water from the zoodles and place into the bowl.	23
101	8	Pour remaining coconut sauce over zoodles and mix well.	23
102	9	Divide the zoodles between plates, top with salmon and garnish with fresh mint and additional salt, if needed. Devour.	23
103	1	Place the butter in a small bowl.	24
104	2	Add the coriander, lime rind, lime juice and cracked black pepper and mix until well combined. Refrigerate until ready to use.	24
105	3	Heat a little olive oil in a non-stick frying pan over medium heat.	24
106	4	Add 2 salmon cutlets and cook for 2-3 minutes each side or until cooked to your liking.	24
107	5	Transfer to a plate and cover with foil to keep warm. Repeat with remaining salmon.	24
108	6	To serve, divide the salmon cutlets among serving plates. Top with a little lime and coriander butter.	24
109	7	Serve with steamed vegetables, if desired.	24
110	1	In a small bowl just large enough for the salmon pieces, whisk egg well with a fork. Set aside.	25
111	2	In a separate small bowl, mix Parmesan, garlic powder, and parsley.	25
112	3	Rinse salmon and blot dry.	25
113	4	Heat a skillet large enough for all of the fillets over medium heat.	25
114	5	Add coconut oil. When oil is melted and shimmering, dip each piece of fish in the egg, covering completely. Then dip in Parmesan mixture, and flip to coat the other side.	25
115	6	Lay gently in the hot skillet. Repeat with all of the fish.	25
116	7	Let each piece of fish cook until the underside of the crust begins to brown around the edges. Gently lift and turn each piece. Keep turning as needed to assure coating does not burn but fish gets cooked through.	25
117	8	Transfer fish to serving platter or plates. To increase fats, top with Aunt Rocky’s Zero Carb Tartar Sauce (see separate recipe on Tasty Kitchen), drizzle with lemon butter, or serve a high fat side dish.	25
118	1	Crack the eggs into a mixing bowl with a pinch of salt and pepper and beat them well with a whisk or fork.	26
119	2	Mix the cream cheese with chopped chives. Slice the smoked salmon, peel and slice the avocado.	26
120	3	Pour the eggs evenly in a hot pan greased with ghee. Cook over a medium-low heat. Don't rush it and don't try to cook it fast or the omelet will end up being too crispy and dry.	26
121	4	Use a spatula to bring in the egg from the sides towards to centre for the first 30 seconds. Cook for another minute or two. Make sure you don't cook the omelet for too long. The desired texture should be soft, fluffy and not too juicy.	26
122	5	Slide the omelet onto a plate and spoon the cheese spread all over.	26
123	6	Add the salmon, avocado, chopped spring onion and fold into a wrap.	26
124	7	Serve immediately or store in the fridge for up to a day.	26
125	1	Remove skin from salmon, dice the flesh, and add into a large bowl.	27
126	2	Add in avocado, cilantro, curry powder, sea salt and stir until well mixed. Stir in 4 teaspoons tapioca starch until well incorporated.	27
127	3	Line a baking sheet with parchment paper. Form the salmon into eight 1/4 cup-sized patties, just over 1/2 inch thick, and place them onto the pan. Freeze for 20 minutes so they are easier to work with.	27
128	4	While patties freeze, preheat air fryer to 400ºF for 10 minutes, rubbing the basket with coconut oil.	27
129	5	Additionally, whisk eggs and place them into a shallow plate.	27
130	6	Place remaining 1/4 cup tapioca starch and coconut flakes in separate shallow plates as well.	27
131	7	Once patties have chilled, dip one into the tapioca starch, making sure it’s fully covered. Then dip it into the egg, covering it entirely, and gently brushing off any excess. Finally, press just the top and sides of the cake into the coconut flakes and place it, coconut-flake-side up, into the air fryer. Repeat with all cakes.	27
132	8	Gently brush the tops with a little bit of melted coconut oil (optional, but recommended) and cook until outside is golden brown and crispy, and inside is juicy and tender, about 15 minutes. The patties will stick to the Air Fryer basked a little, so use a sharp-edged spatula to remove them.	27
133	9	When cakes have about 5 minutes left to cook, heat coconut oil up in a large pan on medium heat.	27
134	10	Add arugula and spinach mix, and a pinch of salt, and cook, stirring constantly, until greens just begin to wilt, only 30 seconds to 1 minute.	27
135	11	Divide greens between plates, followed by salmon cakes.	27
136	12	Garnish with extra cilantro and devour!	27
137	13	If you want to bake these in the oven, preheat oven to 400ºF and line a baking sheet with parchment paper, placing a cooling rack on top of the pan. Rub the cooling rack with coconut oil.	27
138	14	Place patties, coconut-side up, onto cooling rack and bake for 15–17 minutes until crispy. We liked these better in the air fryer, as they do get a little crispier, but they are still good in the oven!	27
139	1	Start by cooking the eggs. Fill a small saucepan with water up to three quarters.	28
140	2	Add a good pinch of salt. This will prevent the eggs from cracking. Bring to a boil. Using a spoon or hand, dip each egg in and out of the boiling water. Be careful not to get burnt. This will prevent the egg from cracking as the temperature change won't be so dramatic. To get the eggs hard-boiled, you need round 10 minutes. This timing works for large eggs. When done, remove from the heat and place in a bowl filled with cold water. I use an egg timer.) Peel the eggs and set aside.	28
141	3	Prepare the cauliflower topping. Wash the cauliflower and cut into smaller florets.	28
142	4	Place on a steaming rack inside a pot filled with about 2 inches of water. Bring to a boil and cook for about 10 minutes. Do not overcook.	28
143	5	Place the cooked cauliflower into a blender add 1/4 cup of butter and 1/4 tsp salt. Process until smooth and creamy. When, set aside.	28
144	6	Poach the fish. Preheat the oven to 200 °C/ 400 °F (fan assisted), or 220 °C/ 425 °F (conventional).	28
145	7	Remove the skin from the fillets (mackerel skin doesn't need to be removed) and dice into medium-large (about 2 inch/ 5 cm) pieces.	28
146	8	Place the fish in a deep pan and pour in the cream and water.	28
147	9	Peel and finely dice the onion and add to the pan together with the bay leaves and cloves.	28
148	10	Add 1/4 tsp salt and bring to a boil and simmer on low for 8-10 minutes.	28
149	11	Using a slotted spoon, transfer the fish into a baking dish deep enough to fit the fish and cauliflower topping.	28
150	12	Prepare the sauce. Simmer the fish & cream sauce over a medium heat.	28
151	13	Add the remaining 2 tablespoons of butter.	28
152	14	Add nutmeg and Dijon mustard. Simmer for about 5 minutes until it starts to thicken. Turn off the heat. Discard the spices (bay leaves and whole cloves if used).	28
153	15	Add 1 cup of shredded cheddar cheese and stir until melted and thickened.	28
154	16	Layer the fish pie. Halve and quarter the eggs and place them in the baking dish on top of the cooked fish.	28
155	17	Pour the cream & cheese sauce over the eggs and fish.	28
156	18	Sprinkle with chopped chives or spring onion. Top with the cauliflower mash. Using the tines of a fork, create a decorative pattern on top.	28
157	19	Top with the remaining 1/2 cup of shredded cheddar and place in the oven. Cook for 30-35 minutes or until the top is golden brown.	28
158	20	When done, turn off the oven and place on a cooling rack for 15 minutes. The fish pie will have runny sauce when hot but will thicken as it cools down.	28
159	21	Serve hot or let it cool down and store in the fridge for up to 5 days.	28
160	1	Preheat oven to 375ºF and generously grease a 7×11-inch baking pan (or a 9-inch pie pan).  Instructions that follow will be the most efficient way to time everything so you can get the finished tart in the oven soonest. The ingredients listed are in the order that each layer will be put in the tart pan.	29
161	1	Melt butter in a saucepan over medium heat. Cook garlic until tender, about 2 minutes.	30
162	2	Add vegetable broth, heavy cream, and broccoli. Bring to a boil; simmer until broccoli is tender, about 15 minutes.	30
163	3	Add Cheddar cheese gradually, stirring constantly, until completely melted. Stir in bacon pieces. Season with salt and pepper.	30
164	1	Heat the pan until warm and add cooking spray.	31
165	2	Add garlic and saute for one minute.	31
166	3	Add dried onion and saute another 30 seconds. Next, add chicken stock, cream, broccoli, salt, and pepper. Bring to a soft boil, then cover and reduce heat to medium to medium-low (about 4). Simmer for about 20 minutes until broccoli is tender. When broccoli is tender, reduce the heat to low and begin adding cheese. Make sure the heat is low first so the cheese doesn't seize!	31
167	4	Add cheese 1/2 cup at a time, stirring until melted after each addition before you add more. This should keep your cheese from seizing. Taste and make sure you like it. For a little extra tang, add the ground mustard and mix in well. If you don't want it, don't add it. (I like the extra tang.) Serving Size: Makes about 6 serves of about 1 cup each	31
168	5	Number of Servings: 6Recipe submitted by Spark	31
169	6	People user JENNA3.	31
170	1	In a large bowl, whisk the olive oil, mayonnaise, apple cider vinegar, mustard, sugar substitute, celery seeds, salt and pepper together until fully combined.	32
171	2	Add the broccoli slaw.  Toss well to coat.	32
172	3	Serve cold.	32
173	1	Melt butter in a saucepan and saute diced onions and garlic until onions are translucent.	33
174	2	Add chicken broth, heavy whipping cream, frozen broccoli, spices, and salt and pepper.Cook on medium for 5 minutes, then reduce and cook on low until broccoli is tender (approx 10 minutes).Turn stove off and remove from heat.	33
175	3	Add cheddar cheese 1 cup at a time and stir. (the packaged grated cheese works best)	33
176	4	Add Swiss cheese and stir until combined.	33
177	5	Serve each bowl with shredded cheese and bacon on top.	33
178	1	Preheat the oven to 200C/400F.	34
179	2	Mix the almond milk and apple cider vinegar in a large bowl and let sit for 5 minutes.	34
180	3	Add the eggs and melted butter and mix.	34
181	4	Grate the cheddar cheese and thinly slice the broccoli.	34
182	5	In a bowl, combine all of the dry ingredients and mix until well incorporated.	34
183	6	Add the wet ingredients to the dry ingredients and mix.	34
184	7	Add the broccoli and mix again.	34
185	8	Add the cheddar cheese and mix until all of the cheese is evenly mixed in the batter.	34
186	9	Spoon the batter into 6 jumbo muffin moulds. I used silicone muffin moulds	34
187	10	so that they wouldn't stick.	34
188	11	Bake for 30 minutes. Take out of the oven and let cool before serving. You can eat them hot or cold, just be careful when taking them out of the oven as the inside of the muffin is piping hot!!	34
189	1	Heat the sesame oil in a large frying pan.	35
190	2	When hot, add the chicken thighs, garlic, salt and pepper to taste.	35
191	3	Once the chicken starts browning add the broccoli and tamari.	35
192	4	Stir to combine.	35
193	5	Cook until the broccoli has softened, chicken browned and fully cooked through.	35
194	6	Serve as is or with zuccini or cabbage noodles.	35
195	1	Preheat oven to 350 degrees F (175 degrees C).	36
196	2	Place broccoli florets in a 9x13-inch baking dish.	36
197	3	Layer shredded chicken on top; press down onto broccoli.	36
198	4	Combine mayonnaise, heavy cream, chicken soup base, dill, and pepper in a bowl; mix well.	36
199	5	Spread evenly over chicken and top with Cheddar cheese. Grease a piece of aluminum foil with cooking spray and cover baking dish with greased-side down.	36
200	6	Bake covered in the preheated oven, about 45 minutes.	36
201	7	Remove aluminum foil and bake until golden brown, about 15 minutes.	36
202	8	Remove from oven and let stand for 10 to 20 minutes before serving.	36
203	1	Boil water	37
204	2	Add bouillon	37
205	3	Add broccoli and boil for 10 min	37
206	4	Chop broccoli up while cooking	37
207	5	Add whipping cream	37
208	6	Add cheese	37
209	7	Add salt and pepper to taste	37
210	8	Serving Size: 5Number of Servings: 6.0Recipe submitted by Spark	37
211	9	People user KMBATA.	37
212	1	Preheat oven to 35	38
213	2	Dice sweet potatoes into small cubes and place in a bowl. Steam with butter until soft enough to puree in a food processor.	38
214	3	Once your sweet potatoes are soft enough add them to your food processor along with the coconut milk and puree them to the consistency of mashed potatoes.	38
215	4	In a large pan add 2 Tbsp of olive oil, onions, soy sauce, rosemary & garlic seasoning, and thyme. You can also add salt and pepper if you would like. Cook on low until onions caramelize. I was in a hurry and didn’t wait, I don’t recommend this because caramelized onions are the BEST!	38
216	5	Remove and place in a bowl to the side.	38
217	6	Using the same pan saute carrots and broccoli adding the remaining Tbsp of olive oil. After cooking remove from pan and set aside.	38
218	7	When it’s time to brown the beef you can brown it as usual or cook it with your onion mixture. I like to brown my beef with the onions and spices to really cook that flavor in. Once your beef has been browned you can drain it and mix all of your veggies and beef together in a bowl along with your tomato paste.	38
219	8	Now it’s time to layer your pie! Grab a 9×13 pan and spread your beef mixture over the bottom evenly. Then top with your mashed sweet potatoes.	38
220	9	Bake for 15-20 minutes and serve hot!	38
221	1	In a small bowl, whisk 1 tablespoon of the coconut aminos, along with 1/2 teaspoon each of the garlic and ginger.	39
222	2	Place the beef into the marinade and stir. Cover and refrigerate for at least 1 hour.	39
223	3	Heat 1 tablespoon of the oil up in a large pan on medium heat.	39
224	4	Add the broccoli and cook, stirring frequently, until it just begins to soften, about 3–4 minutes.	39
225	5	Add the rest of the garlic and ginger and cook 1 minute.	39
226	6	Turn heat to low, cover pan and cook until broccoli is tender but crisp, about 4–5 minutes. Stir it occasionally.	39
227	7	Once cooked, transfer broccoli to a plate. Turn up the temperature to medium/high and add the remaining 1/2 tablespoon of oil.	39
228	8	Add marinated beef and cook until golden brown, about 2–3 minutes. Stir the broccoli back in.	39
229	9	In a small bowl, whisk together the remaining coconut aminos, broth and sesame oil.	39
230	10	Pour it into the pan and cook until it just begins to thicken, about 1–2 minutes, stirring constantly. You don’t want to cook it too long as you want it to be saucy! Season with salt to taste.	39
231	11	Serve over cauliflower rice with green onion and sesame seeds.	39
232	1	Slice beef into about  inch thin. Marinate thin sliced beef with ingredients under beef marinade.	40
233	2	Mix well.	40
234	3	Place broccoli florets in a microwave safe container.	40
235	4	Add 1-2 tbsp water. Loosely covered with a lid or wet paper towel and microwave for 2 mins. Cook until broccoli is tender but still crunchy. Set aside.	40
236	5	Heat a wok over medium heat w/ 1  tbsp ghee. When hot, lower the heat to medium, add garlic and ginger. Season w/ a small pinch of salt & stir-fry until fragrant (about 10 secs).Turn up the heat to medium-high, add marinated beef.	40
237	6	Spread beef evenly over the bottom of the saute pan and cook until the edge of the beef is slightly darkened and crispy. Do the same thing for flip slide - about  way cooked through with slightly charred and crispy surface.	40
238	7	Add Sauce Combo. Stir-fry about 1 min.	40
239	8	Add broccoli. Stir-fry another 30 secs. Toss everything to combine.	40
240	1	Add some water to a pot and heat.	41
241	2	Add the broccoli sticks to the boiling water and cook for 2-3 minutes.	41
242	3	Add the bacon slices to a frying pan and cook on both sides until nice and crispy. Don't discard of the oil.	41
243	4	Slice the shiitake mushroom and avocado.	41
244	5	Take the broccoli out of the water and add them to the bacon grease along with the mushroom slices.	41
245	6	Fry in the bacon grease until nice and tender.	41
246	7	In a small bowl, whisk the eggs and cream together.	41
247	8	*For this step you can either fry the eggs inside the grease or fry them in some ghee.	41
248	9	Scramble the eggs until desired thickness.	41
249	10	Add your fried eggs, avocado, broccoli, bacon and mushrooms to a plate.	41
250	11	Sprinkle the salt & pepper over.	41
251	1	In a large bowl, mix all the salad ingredients.	42
252	2	In a medium bowl, stir all the dressing ingredients.	42
253	3	Pour dressing over broccoli and stir to coat well. Cover and refrigerate at least 2 hours, up to overnight, so broccoli can absorb the dressing and develop the flavor.	42
254	4	Devour!	42
255	1	.Serving Size: 6 large Servings	43
256	2	Number of Servings: 6.0Recipe submitted by Spark	43
257	3	People user CUDACANCOOK.	43
258	1	Place broccoli slaw mix, green onion, mixed peppers, and chicken in a serving bowl, in the order listed.	44
259	2	Make the dressing (see note below) and drizzle over salad.	44
260	3	Garnish with almonds. (If you are using pre-made dressing, warm it for a few seconds in the microwave and whisk smooth before drizzling.)	44
261	4	Note: The dressing recipe is here on Tasty Kitchen in my recipe box. It works best served warm. To help those who track foods or create recipes and meals using this dip/dressing, the nutritional data has been entered into the food data base on My Fitness Pal.	44
262	5	Nutritional information (estimates are per serving based on exact ingredients I used, calculated with a free online recipe analyzer): Calories 374, Total Fat 24 g, Saturated Fat 4 g, Sodium 92 mg, Potassium 11 mg, Total Carbohydrate 15 g, Dietary Fiber 6 g, Net Carbs 9 g Sugars 2 g, Protein 28 g. Macros:  59% fat, 31% protein, 10% carbs.	44
263	6	© April 26, 2017 Roxana Lopez for Aunt Rocky’s	44
264	7	For more low carb/keto recipes and cooking tips, look for Aunt Rocky’s Low Carb Recipes Group on Facebook.	44
265	1	In a large pot, combine broth, salt, onion, broccoli and bring to a low boil. Lower heat, cover, and simmer for 15 minutes or until the broccoli is nice and soft.	45
266	2	Put the contents of the pot plus the avocado in a big blender of food processor and slightly blend it, or thoroughly puree (depending on how chunky you like it.)Return to the pot on medium heat, stir in the cheese and heavy cream, bring it back up to a low boil. Simmer for another 10 minutes or so, stirring regularly.Serving Size: 10	45
267	1	Stir all ingredients together.Serving Size: 1 cup	46
268	2	Number of Servings: 6Recipe submitted by Spark	46
269	3	People user SLATEGIRL.	46
270	1	Cook broccoli in a pan coved with water. When done drain keeping a bit of juice.  Then  in a separate larger pan melt butter, then add flour next add 1/2 and 1/2 and stir until thickens.  Then add cheeses along with pepper and salt to taste if you want.  Stirring to keep from burning to bottom. Once both are done combine in your pot that you make your creamed mixture in. I use med heat	47
271	2	Serving Size: 1 c. Number of Servings: 20Recipe submitted by Spark	47
272	3	People user SEXYHAIR77.	47
273	1	Preheat oven to 350°F. Spray 8×8 inch (or 9×9 inch) baking pan and set aside.	48
274	2	Put cooked chopped ham, broccoli, and mushrooms in a large mixing bowl. (Broccoli should be well drained, if it was boiled or previously frozen.)	48
275	3	In a small bowl, mix the sauce ingredients: cream, almond milk, minced onion, garlic, Worchestershire, mustard, pepper, salt and glucomannan.	48
559	2	Cook on low for 7 hours.	91
276	4	Pour over the meat and vegetables, stir.	48
277	5	Add 1/2 of the cheese to the meat and vegetables and fold in lightly.	48
278	6	Transfer mixture to baking dish and smooth the top. Top with remaining cheese and fried onions.	48
279	7	Bake 30 minutes, or until cheese is beginning to brown.	48
280	8	Remove from oven and let stand for about 10 minutes before serving.	48
281	9	For more servings, double recipe and bake in 9×13 inch pan.  Leftovers may be frozen.	48
312	1	Mix together all the dry ingredients.	54
313	2	Pour in wet ingredients one by one, mixing well with each addition.	54
314	3	Pour into a springform loaf pan (I used this one) and cover the pan with foil.	54
315	4	Place 2 cups of water into your instant pot liner, and put in a trivet on top.	54
316	5	Set your Instant Pot for 40 minutes at High Pressure, let it release pressure naturally for 10 minutes, and release remaining pressure.	54
317	6	Carefully take out and pan and let it cool for 15-20 minutes. Unclasp the sides and remove the cake and serve.	54
318	1	Preheat oven to 300 degrees Fahrenheit. Spray 2 muffin tins with an oil of choice.  Then in a medium bowl, beat cream cheese, vanilla extract, sweetener, and egg yolks until smooth.	55
319	2	In a separate bowl, whip the egg whites and cream of tartar with an electric mixer until stiff peaks form.	55
320	3	Next, carefully fold the whipped egg whites into the yolk mixture. Be careful to not deflate the whites when doing so.	55
321	4	Scoop about two tablespoons of the mixture into each muffin tin.	55
322	5	Place in preheated oven and bake for 30-35 minutes or until golden brown.	55
323	6	Once done, remove the cake from the muffin tins and place on a cooling rack.	55
324	7	While the cakes are cooling, combine all frosting ingredients together in a medium bowl.	55
325	8	Beat with an electric mixer until smooth.	55
326	9	Transfer frosting to pastry bag with wide tip.	55
327	10	Set aside 3 layers for each cake and then pipe frosting in between each layer of cake.	55
328	1	Measure out 2 Tbsp. butter and put it inside the mug you will be using.	56
329	2	Microwave the butter for 20-25 seconds until it mostly melted and hot.	56
330	3	Add your sweetener to the melted butter.	56
331	4	Add your 2 Tbsp. Cocoa Powder to the butter.	56
332	5	Add your coconut flour, almond flour, baking powder, and vanilla.	56
333	6	Don’t forget the egg! It will help the cake rise.	56
334	7	Mix the ingredients well, until everything is combined and there’s as little lumps as you can get. If you’re going to make 2 servings, this is the point where you would measure the batter out into 2 mugs or 2 ramekins.	56
335	8	Microwave the cake for 60-75 seconds. It takes 75 seconds in my microwave. If you are making 2 servings, probably 50-60 seconds would do the best Serving Size: 2 mug cake snacks or 1 mug cake	56
336	9	Number of Servings: 2Recipe submitted by Spark	56
337	10	People user HATAKEMAARA.	56
338	1	Combine chocolate chips and coconut oil in a microwave-safe mug; heat in the microwave until melted, about 30 seconds.	57
339	2	Whisk water, almond flour, coconut flour, and baking soda into the chocolate mixture until well combined.	57
340	3	Add egg and brewed espresso; whisk until smooth.	57
341	4	Heat in the microwave until cake is cooked through, about 90 seconds.	57
342	5	Let cool before serving, about 2 minutes.	57
343	1	Melt the butter in the microwave for 25 seconds.	58
344	2	Add the rest of the ingredients and mix well.If you are making 2 servings, split the batter into 2 ramekins.Microwave for 60-75 seconds.Whip some heavy cream and put on top. (Optional)	58
345	1	Mix all ingredients in a mug and cook for 60 - 70 seconds in the microwave.	59
346	2	Serve and enjoy!	59
347	1	First, combine the butter and lily's chocolate chips in a bowl and microwave for about 20 seconds until the ingredients have melted.	60
348	2	Mix in the instant coffee grounds and cocoa powder into the warm ingredients. They will blend right in.	60
349	3	Add the coconut flour, almond flour, egg, vanilla extra and Swerve Powdered sugar.	60
350	4	Mix it until all the ingredients have blended together nice and smooth.	60
351	5	Finally, add the 2 tablespoons of sour cream.	60
352	6	Separate the ingredients into two ramekins and microwave them separately for between 45 seconds and 60 seconds each. I have a high powered microwave and it only takes 45 seconds for my cake to be completely done.	60
353	7	Optional: Top with whipped cream.	60
354	1	Add all ingredients to mug and microwave for 60 seconds	61
355	2	Serving Size: 1Number of Servings: 1.0Recipe submitted by Spark	61
356	3	People user STACINUNEZ1986.	61
357	1	mix all ingredients in mug, microwave for 1 minute. Can eat immediately, or cut in half and toast both sides in toaster oven.Serving Size: 1 mug cake	62
358	2	Number of Servings: 1Recipe submitted by Spark	62
359	3	People user MAIGEN.	62
360	1	Preheat oven to 325 degrees F (165 degrees C). Line an 18-cup mini muffin tin with paper liners.	63
361	2	Melt chocolate in a microwave-safe glass or ceramic bowl in 15-second intervals, stirring after each melting, 1 to 3 minutes.	63
362	3	Combine melted chocolate, sweetener, water, butter, and egg in a bowl. Stir until sugar dissolves.	63
363	4	Add soy flour, mayonnaise, vanilla extract, salt, and baking soda.	63
364	5	Whisk until no chunks remain.	63
365	6	Pour batter into the muffin cups.	63
366	7	Bake in the preheated oven until a toothpick inserted into the center of a brownie cake comes out clean, 18 to 21 minutes.	63
367	1	Crack your 2 eggs and separate the yolk; store you egg whites for a later recipe in the fridge.Start your coffee Have your blender out and ready to use, while coffee is getting hot.	64
368	2	Add 15 dark chocolate chips to blender, add in egg yolks.	64
369	3	Pour in hot coffee and blend on high for 2 minutes.	64
370	4	Pour into cups serve and enjoy.  Serving Size: Makes 4 Cups	64
371	1	In a microwave safe bowl, melt butter and chocolate for about 1 minute.	65
372	2	Remove and stir well. You really want to use the heat within the butter and chocolate to melt the rest of the clumps. If you microwave until it's all melted, you've overcooked the chocolate. So get a spoon and start stirring.	65
373	3	Add 10 seconds if needed but stir well before you decide to do that.	65
374	4	In a bowl, add eggs, sweetener, and vanilla and blend until light and frothy.	65
375	5	Pour the melted butter and chocolate into the bowl in a slow stream and beat again until it is well-incorporated. 	65
376	6	Pour the mixture into greased springform container or cake pan and bake at 350F for 30-35 minutes until a knife inserted in the center emerges clean.	65
377	7	Serve with whipped cream if desired (see note)	65
378	1	Pre-heat your oven to 200 Celsius or 390 Fahrenheit	66
379	2	In a mixing bowl combine ground almonds, oil, eggs, vanilla and baking powder.	66
380	3	Whisk for 2 minutes.	66
381	4	Fold in blueberries and chocolate chips.	66
382	5	Grease and line baking tin.	66
383	6	Pour in mixture.	66
384	7	Bake for 25 minutes.	66
385	1	Place ice cream bowl in freezer per ice cream maker instructions (typically 4-12 hours ahead of time)Put all ingredients minus chocolate in metal bowl	67
386	2	Whisk	67
387	3	Put back in freezer for 5 minutes	67
388	4	Setup ice cream maker and add liquidA few minutes before the ice cream is set, add chocolate shavings	67
389	5	Store in an air tight container and put back in the freezer	67
390	1	Preheat oven to 350°F. Line an 8×8 pan with parchment paper and set aside. In a large bowl, mix flax, chia, water, stevia, and vanilla and stir to combine. Set aside to gel while you toast pepitas.	68
391	2	In a skillet or frying pan, spread pepitas into a single layer and heat on medium, stirring frequently. Cook until they start to pop and turn golden brown, about 5–7 minutes. Set aside to cool while you prepare the rest of your ingredients.	68
392	3	Add tahini, coconut oil, cinnamon, and pink salt to flax/chia mixture. Stir until incorporated.	68
393	4	Stir coconut and seeds into flax/chia mixture until evenly distributed. (If desired, add pepitas, hemp seeds, shredded coconut, and sesame seeds to a food processor and pulse a few times until slightly broken up with some large chunks remaining. You can skip this step and use whole ingredients, if you prefer that.)	68
394	5	Spread into lined 8×8 pan and smooth top.	68
395	6	Bake 25–30 minutes, until edges start to turn golden brown. Cool slightly before cutting into 8 bars.	68
396	7	Place cooled granola bars in an airtight container and refrigerate.	68
397	8	If desired, prepare chocolate drizzle.	68
398	9	Heat chocolate in a small pan on low heat, stirring frequently until melted, or microwave on low in 30-second intervals, stirring between each interval until melted.	68
399	10	Drizzle or spread onto cut granola bars.	68
453	6	Add dry ingredients to wet ingredients all at once, and quickly whisk to mix well. Coconut flour is very thirsty, and your batter will be thick, not runny like cake batter. Scoop about 1/4 cup batter into each muffin cup (they don’t rise much, so don’t worry if your cups look too full).	74
400	1	My Father inlaw is a doll! Today he offered me a chocolate chip cookie from Starbucks and just about killed me with cravings the rest of the day. It was seriously tempting especially since I've been battling myself this week, no joke all grains and carby "goodness" sound amazing to me. I'm about ready to eat my foot some days thinking about croissants and pizza aaaaahhhh!!! So today I made these instead of opting for my not so tasty foot, and I was pleasantly surprised! I hope you are too!	69
401	2	Makes 24 good sized cookies Or more if you go smaller! Just remember to adjust your baking time if you make them a different size.	69
402	3	Ingredients	69
403	4	2/3c almond flour	69
404	5	1 cup sweetener	69
405	6	3 eggs	69
406	7	8oz cream cheese, softened	69
407	8	2 tbs butter, softened	69
408	9	1/4 t salt	69
409	10	1/4 t vanilla	69
410	11	1/2 t xantham	69
411	12	1/2 t baking powder	69
412	13	1/4 c coconut shreds (optional but amazing)	69
413	14	1 tablespoon coconut flour	69
414	15	1 tablespoon cashew butter (optional, any nut butter will do)	69
415	16	1 1/2 cups chocolate chips of choice	69
416	17	Cream together butter, cream cheese, cashew butter and sweetener.	69
417	18	Add in eggs one at a time, mixing well in between each.	69
418	19	Add remaining dry ingredients (except chocolate chips and coconut) and mix well	69
419	20	Add in chocolate chips and coconut pop the mix in the freezer to harden up a bit (10 minutes or so, roughly as long as it takes to heat the oven)	69
420	21	Preheat oven to 350	69
421	22	Spoon cookies onto lined baking sheet (about 1 tablespoon sized cookies) and bake for 20 minutes or until the top of the cookie is no longer moist and begins to brown on the raised parts.	69
422	23	UPDATE - One of my wonderful IG followers anmy amazing IG followers have tried this recipe with walnuts and cocoa nibs. I have yet to try the variation but I think it's going to be amazing!	69
423	1	*in a large bowl, using a hand mixer, beat butter until light and fluffy, then add Pyure, vanilla, and salt beat until WELL combined.*slowly beat in your almond flour 1/4 cup at a time until no dry spots remain.*then fold in the chocolate chips, roll into 24 TBSP size balls. refrigerate.  ***lasts in fridge for up to a week, if not consumed freeze for up to 1 month.Serving Size: makes 24 tablespoon size balls	70
424	1	Heat oven to 375ºF and line an 8×8 inch pan with parchment paper, leaving some hanging over the sides to use as a handle later on.	71
425	2	Place chopped almonds, slivered almonds and coconut flakes on 3 separate small baking sheets.	71
426	3	Bake until golden brown and toasted. The coconut will only take 2-4 minutes, the slivered almonds about 3–5 minutes and the chopped almonds about 7–12 minutes.	71
427	4	Let cool completely. Reduce oven temperature to 350ºF.	71
428	5	In a large bowl, whisk egg and monkfruit.	71
429	6	In a separate small, microwave-safe bowl, melt almond butter and coconut oil until smooth, about 30 seconds.	71
430	7	Whisk into the egg mixture until well combined.	71
431	8	Add in all the nuts, coconut and salt and stir until well combined. Finally, stir in chocolate chips.	71
432	9	Press very firmly into the prepared pan. I like to hold a little piece of parchment paper to make this easier. Put some muscle into it because you need to pack these in so they hold together.	71
433	10	Bake until top just feels set, about 15 minutes at 350ºF.	71
434	11	Let cool completely to room temperature in the pan. Once cool, slice and devour!	71
435	12	Note: Bars can be stored in an air-tight container on the counter for 2– days, or refrigerated for longer shelf life!	71
436	1	bottom of pan spread mixture on top and add sliced strawberries chill and serve.Serving Size: 8Number of Servings: 8.0Recipe submitted by Spark	72
437	2	People user ANGELAJ0Y.	72
438	1	Preheat oven to 350ºF. Cover 2 large cookie sheets with parchment or silicone sheet, set aside.	73
439	2	Put all ingredients in a large mixing bowl. Use a hand mixer or stand mixer to mix thoroughly.	73
440	3	Using a 1-inch cookie scoop, drop onto baking sheet. You need to space them so you can get 19 on each sheet. These cookies spread very little, so you need to shape them into a cookie before baking. With your finger tips damp, push/tap them down into a flat cookie about 2 inches in diameter. (I usually get 38 cookies from this recipe.)	73
441	4	Bake 12–14 minutes, or until browning around the edges. (I bake one pan at a time in my oven, to be sure the heat circulates well.)	73
442	5	Immediately transfer to a cooling rack. They will continue to crisp up as they cool. I leave them on the cooling rack overnight, then store in a covered container in the pantry for up to a week.	73
443	6	Note: If you don’t want to use flax meal, substitute 1/2 cup almond flour and 1 large egg.	73
444	7	I don’t get any commission or kickback for products I use or mention in my recipes. Nutritional estimates are per serving based on exact ingredients I used, calculated with My Fitness Pal’s online recipe analyzer. The recipe is stored there and available to MFP users for logging in their food diaries.  I do not include sugar alcohols or liquid sucralose in my nutrition counts, as they are not absorbed by the body and rate zero on the glycemic index.	73
445	8	Nutritional information is based on 38 cookies. Calories 96, Total Fat 7 g, Saturated Fat 1 g, Sodium 67 mg, Potassium 45 mg, Total Carbohydrate 3 g, Dietary Fiber 2 g, Net Carbs 1 g, Sugars 1 g, Protein 4 g.  Macros:  76% fat, 19% protein, 5% carbs.	73
446	9	© July 4, 2017 Roxana Lopez for Aunt Rocky’s	73
447	10	For more low lchf/keto recipes and cooking tips, look for Aunt Rocky’s Low Carb Recipes & Tips Group on Facebook, or follow me on Pinterest at auntrocky2.	73
448	1	Preheat oven to 350ºF. Put 12 parchment muffin tin liners in your muffin pan (or silicone muffin cups on a baking sheet) and set aside.	74
449	2	Whisk all dry ingredients (except chocolate chips) a medium mixing bowl until there are no lumps. Set aside.	74
450	3	In a large mixing bowl, melt the butter, coconut oil, and	74
451	4	Baker’s chocolate pieces in the microwave (45  seconds or so).	74
452	5	Add vanilla and eggs, and whisk well.	74
454	7	Sprinkle 1/2 teaspoon chocolate chips on top of each muffin.	74
455	8	Bake 20 minutes. Use a toothpick to test that they are done.	74
456	9	Remove from oven, but leave in muffin pan for 5 minutes or so to set more, then turn out on to wire rack to cool completely.	74
457	10	Store on counter for up to 5 days in covered container, in refrigerator for up to 10 days, or may be frozen.  These muffins travel well in a plastic container with a lid.	74
458	1	Butter a 4×6 pan.	75
459	2	Cut a strip of parchment or waxed paper wide enough to cover bottom of pan, and long enough to hang over both sides. Set aside.	75
460	3	In a large pot, add sugar, crema and salt. Cook and stir over medium heat until it comes to a rolling boil. Boil for 8 minutes, stirring constantly to avoid sticking or burning.	75
461	4	Add half of the pecans and all of the remaining ingredients. Stir well, pour into buttered pan.	75
462	5	Sprinkle remaining pecans over the top.	75
463	6	Cool on a wire rack, then put in refrigerator to finish setting up. When fully set, run knife along uncovered edges of pan, lift fudge carefully out of dish and onto a cutting board (or cut into pieces while still in the pan, and then lift out).	75
464	7	Cut into 20 pieces: 4 slices on short side, 5 slices on long side. Store in refrigerator or freezer.	75
465	8	Yields 20 squares of about 1 inch each.	75
466	1	Measure dehydrated cranberries into a small mixing bowl. Cover with hot water, add 2 to 4 drops of liquid sweetener (to your taste).	76
467	2	Let sit for at least 20 minutes for cranberries to become soft again.	76
468	3	Preheat oven to 350ºF. Cover 2 large cookie sheets with a silicone mat or parchment, and set aside.	76
469	4	When cranberries are soft and plump (if using), drain well.	76
470	5	Add remaining wet ingredients: eggs, vanilla, pumpkin flavor, canned pumpkin, melted butter, and cream.	76
471	6	Whisk well.	76
472	7	In a large mixing bowl, combine dry ingredients and whisk until there are no lumps and all ingredients are blended: almond meal, pumpkin flour, baking powder, pumpkin pie spice, salt, both sweeteners, nuts (and chocolate chips if using in place of cranberries).	76
473	8	Pour wet ingredients into the bowl with the dry ingredients, and mix all with rubber spatula or large spoon.	76
474	9	Once thoroughly mixed, spoon by rounded 1-tablespoon cookie scoop onto cookie sheet. Flatten the cookies a with your fingers to form a 2-inch round cookie.	76
475	10	Bake 20 minutes, or until edges are beginning to brown (tops will not really brown). Cool completely on rack before serving.	76
476	1	Preheat oven to 350ºF. Line 2 cookie sheets with parchment or silicone liners, set aside.	77
477	2	Melt coconut oil in medium glass mixing bowl.	77
478	3	Add eggs, peppermint extract, and vanilla, and beat with whisk until frothy.	77
479	4	Add remaining ingredients, stir until combined. Batter should be like a thick brownie batter consistency.	77
480	5	Use a tablespoon cookie scoop to place dough onto parchment-lined cookie sheets. Use wet fingertips to flatten cookie to desired size and shape. They don’t spread much at all, so the shape you make is the shape you’ll get.	77
481	6	Bake 10 minutes.	77
482	7	Remove from oven, and sprinkle the crushed peppermint candy on top of each cookie. Return to oven for 1 to 2 minutes to assure the candy melts just enough to adhere to the cookies.	77
483	8	Let cool on cookie sheet for about 5 minutes until they set, then transfer to wire rack to finish cooling. Cookies will dry out as they cool. I recommend allowing to air dry on rack for 24 hours. Store on the counter in an air tight container for up to a week.	77
484	1	In a single serving microwavable bowl, whisk ricotta, almond milk, cream and flax. Cover and microwave for 2 minutes.	78
485	2	Remove from microwave and stir well.	78
486	3	Mixture should be very thick.	78
487	4	Add butter, syrup and pecans. Taste, and add more syrup or sweetener if desired.	78
488	1	Preheat oven to 350ºF. Grease an 8×8 square glass pan (or 9-inch pie pan). Zest your lemon, set aside 1 teaspoon of the zest for the glaze. Juice the lemon and set aside 1 teaspoon juice for glaze.	79
489	2	Put coconut flour and erythritol in a large mixing bowl, and stir with whisk to break up any lumps. Set aside.	79
490	3	In a small mixing bowl, melt butter in the microwave (about 15 seconds). Lightly beat in eggs, almond milk, lemon juice and lemon zest (except what was reserved for the glaze), lemon extract, and syrup.	79
491	4	Add to large bowl with coconut flour and sweetener. Stir/whisk quickly to get everything well blended.	79
492	5	In a pinch bowl, mix baking soda and cider vinegar. It will fizz up. Immediately add to cake mixture and stir in.	79
493	6	Fold in the blueberries. Turn out into the baking pan.	79
494	7	Bake for 30 minutes, or until center is firm (do the tooth pick test, if you aren’t sure), and top is just beginning to turn golden. While cake is baking, get your glaze ingredients and bowl ready, but don’t mix it yet.	79
495	8	When cake is done, use a thick skewer or ice pick to poke holes all over the top of the cake. Melt the butter for the glaze in a small glass measuring cup.	79
496	9	Add remaining ingredients and stir well until powdered sweetener dissolves. If glaze is to thick (you don’t want it runny, but thin enough to spread and go into the holes), add just a tiny bit of lemon juice or water (about 1/4 to 1/2 teaspoon) and see how that works.	79
497	10	Drizzle over the cake, and quickly use an offset spatula (or back of a spoon) to spread it evenly. Some will seep into the holes, and some will stay on top as a glaze. Glaze will set up as the cake cools.	79
498	11	Store left over cake in refrigerator. May be frozen.	79
499	12	I cut this into 6 generous size servings and serve this cake as a breakfast. It may be cut into smaller servings as a dessert or snack.	79
500	13	Note: This recipe works equally well with regular lemons, but you may need a little extra bake time if using a larger lemon. Other berries can be substituted for the blueberries, but may have more carbs.	79
501	14	Tip: To improve macros when serving as a meal, top with whipped cream or melted butter.	79
502	1	Micro in a mug 1 min	80
503	2	Serving Size: 2 rounds	80
504	3	Number of Servings: 2.0Recipe submitted by Spark	80
505	4	People user DARLINGDUMPLING.	80
506	1	Whisk the egg whites until firm and form stiff peaks.	81
507	2	Mix the egg yolks, coconut flour, sweetener, and baking powder.	81
508	3	Add the melted butter slowly, mixing to ensure it is a smooth consistency.	81
509	4	Add the milk and vanilla, mix well.Gently fold spoons of the whisked egg whites into the yolk mixture. Try to keep as much of the air and fluffiness as possible.	81
510	5	Place enough of the waffle mixture into the warm waffle maker to make one waffle. Cook until golden.Repeat until all the mixture has been used.	81
511	1	Cover surface of waffle iron with cooking oil. Turn the iron on to heat for use.Blend eggs, mayonnaise, and almond flour with hand mixer or blender until mixture becomes smooth.	82
512	2	Cut cream cheese into small cubes, about 1x1 centimeter.	82
513	3	Pour the batter onto the middle of the hot waffle iron.	82
514	4	Place a quarter of the cream cheese pieces throughout the iron wells prior to pressing the lid down.Once cream cheese has been distributed, close the lid to begin cooking the waffle. Steam may release from the seal of the waffle iron as the batter cooks; this is normal, but be careful of hot steam!Cook for 3-5 minutes, or until waffle appears golden brown.	82
515	5	Remove waffle from iron and plate.	82
516	6	Serve as-is or with your favorite low carb topping.	82
517	1	Please watch the video for directions.	83
518	1	First bowl.	84
519	2	Whisk the egg whites until firm and form stiff peaks.	84
520	3	Second bowl	84
521	4	Mix the egg yolks, coconut flour, cocoa, sweetener, and baking powder.	84
522	5	Add the melted butter slowly, mixing to ensure it is a smooth consistency.	84
523	6	Add the milk and vanilla, mix well.	84
524	7	Gently fold spoons of the whisked egg whites into the yolk mixture. Try to keep as much of the air and fluffiness as possible.	84
525	8	Place enough of the waffle mixture into the warm waffle maker to make one waffle. Cook until golden.	84
526	9	Repeat until all the mixture has been used.	84
527	1	Combine cream cheese, eggs, vanilla, sugar substitute, maple extract, and cinnamon with a blender or mixer.	85
528	2	Add melted butter to waffle batter if desired.	85
529	3	Add baking powder and coconut flour, blending again until well combined.	85
530	4	dd batter to preheated waffle iron. Cook for 5-7 minutes, or until golden brown.	85
531	5	Serve with butter, sugar free syrup, and/or fruit/jam.	85
532	6	NOTE: The batter may thicken if left to sit for more than a few minutes. If this happens, just add a splash of almond milk, cream, or half and half to thin it again.	85
533	7	Serving Size: makes four waffles	85
534	8	Number of Servings: 4.0Recipe submitted by Spark	85
535	9	People user BRATSSCRAPPY.	85
536	1	Turn on a multi-functional pressure cooker (such as Instant Pot®) and select	86
537	2	Saute function. Melt butter and add pancetta; cook until crispy, about 3 minutes.	86
538	3	Add Brussels sprouts; cook until golden, about 7 minutes.	86
539	4	Pour vegetable broth over Brussels sprouts and sprinkle with salt and pepper. Close and lock the lid. Select high pressure according to manufacturer's instructions; set timer for 3 minutes. Allow 10 to 15 minutes for pressure to build.	86
540	5	Release pressure carefully using the quick-release method according to manufacturer's instructions, about 5 minutes. Unlock and remove lid.	86
541	1	Preheat the oven to 200 C / 400 F. Wash and halve the Brussels sprouts or quarter if too big.	87
542	2	Pour the melted ghee over the sprouts.	87
543	3	Drizzle with the lemon juice. Season with salt and pepper and mix well to allow the oil &amp; seasoning everywhere and place in the oven and bake for 25-35 minutes until crispy on the outside and tender inside.	87
544	4	Mix once or twice to ensure even cooking. The exact cooking time depends on the size of the Brussels sprouts. If you cut them in quarters, it will take less time to cook.Enjoy!	87
545	1	Preheat oven to 375F. Chop stems off of brussels sprouts, then cut them all in half. Dice onion and mince garlic.	88
546	2	Add butter to pan over high heat and add brussels sprouts and pepper. After 2-3 minutes, add onion and garlic. Once onion are soft, add the soy sauce and liquid smoke. Set aside.In a saucepan, combine all sauce ingredients. Stir until well combined and creamy.	88
547	3	Add sauce to brussels sprouts and mix together well. Portion out into 4 ramekins.Grind pork rind crust ingredients in a spice grinder and top each ramekin with a good portion of crust.	88
548	4	Bake for 17-20 minutes until crust is slightly crisped.	88
549	1	Preheat oven to 375F. Chop veggies and place on a baking sheet. Coat with palm oil and cumin. Toss.	89
550	2	Transfer to preheated oven and roast for 20 minutes.Meanwhile, combine meatball ingredients in a large bowl. Press with your hands to combine. Pinch about 1 tablespoon or smaller of the mixture into your hands.	89
551	3	Roll, and place on a parchment paper or silicon-lined baking sheet. Repeat with remaining mixture. Should make about 22 mini meatballs.Once vegetables are complete, reset oven temperature to 320F. Slide in the sheet of meatballs and cook for 15 minutes.Meanwhile, prepare the dressing in a small bowl.	89
552	4	Whisk until combined, set aside. Spiralize zucchini.	89
553	5	Add all ingredients to a large bowl: spiralized zucchini, roasted vegetables, dressing and meatballs. Toss to coat and serve with additional cilantro, if interested.Notes	89
554	6	Vegetables: Use any keto vegetables you'd like here. Celery would be nice.Egg: If you're allergic to egg, don't add it. The meatballs are great without it.Sriracha: If you don't like Sriracha, you could use red curry paste, too. Or harissa would be good!	89
555	1	Fill a pot with just enough water to cover cabbage and boil cabbage for 5-7 minutes	90
556	2	Cook bacon and crumble	90
557	3	Add salt and bacon to cabbage and enjoy	90
558	1	To your slow cooker add in the following order:bacon slices to line the bottomonion slices and garlicthe chuck roastthe cabbage slicesthe thymethe brothadd few pinches of sea salt and a liberal amount of freshly ground black pepper	91
560	3	Serve in bowls with 1thin everything flatbread cracker [7g carb]Serving Size: 4-6 servings	91
566	1	Fry bacon in a large skillet until crisp.	93
567	2	Remove to paper towel to cool, reserving bacon grease in skillet.	93
568	3	Add chopped onions to the bacon grease and fry until onions begin to brown.	93
569	4	Add cabbage and Worcestershire sauce to the skillet, and stir well. Cover, reduce heat to medium-low, and cook about 5 to 10 minutes or until thickest pieces of cabbage are fork-tender. Stir occasionally while cabbage cooks.	93
570	5	Add salt and pepper to taste. Crumble bacon over the cabbage (add any cooked, warmed protein, if using), stir and serve.	93
578	1	Divide cabbage and parsley among small serving bowls.	95
579	2	Mix balsamic dressing and mayonnaise with a small whisk or fork until creamy.	95
580	3	Pour over the salads.	95
581	4	Serve chilled.	95
582	5	This salad may be made ahead. If you want more servings, multiply as needed, and serve on the table in a large bowl.	95
589	1	Brown turkey, then add frozen vegetables, then chop cabbage and add in.	97
590	2	Add soy sauce to taste	97
591	3	Serving Size: Makes 15 1 cup servings	97
592	4	Number of Servings: 15.0Recipe submitted by Spark	97
593	5	People user KATERI33.	97
598	1	Slice, chop, shred all of the salad ingredients and place in medium mixing bowl.	99
599	2	Mix dressing ingredients in small bowl and pour over salad. Toss well to coat all of the cabbage.	99
600	3	Serve chilled.	99
601	4	Yields 6 servings of approximately 1/2 cup each.	99
602	5	Note: This salad can be made up ahead and stored in the refrigerator. If making more than 1 day ahead, reserve the parsley to add when ready to serve.	99
603	6	Nutritional estimates are per serving based on exact ingredients I used, calculated with a free online recipe analyzer. Calories 86, Total Fat 7 g, Saturated Fat 1 g, Sodium 13 mg, Potassium 103 mg, Total Carbohydrate 4 g, Dietary Fiber 2 g, Net Carbs 2 g, Sugars 2 g, Protein 2 g.  Macros: 80% fat, 10% protein, 10% carbs.	99
604	7	© June 24, 2017 Roxana Lopez for Aunt Rocky’s	99
605	8	For more low lchf/keto recipes and cooking tips, look for Aunt Rocky’s Low Carb Recipes & Tips Group on Facebook, or follow me on Pinterest at auntrocky2.	99
613	1	Cut cabbage into 4 wedges.	101
614	2	Melt butter in a small Dutch oven or larger soup pan.	101
615	3	Add everything else, except cabbage. Stir.	101
616	4	Add cabbage wedges, and bring pot to a boil. Reduce heat, cover, simmer about 10–15 minutes, or until fork tender. Gently flip the cabbage wedges over about halfway through the cooking time.	101
617	5	Use a slotted spoon to remove the cabbage from the pan and serve.	101
626	1	Use larger pot, place on stove heat on medium high heat , add chicken broth, spinach, celery, coleslaw , salsa and spices. Bring to boil for 5 minutes then turn heat to simmer for around 30 minutes.	103
627	2	Serve and enjoy	103
628	3	Serving Size: makes 10 - 1.5 serving	103
629	4	Number of Servings: 10Recipe submitted by Spark	103
630	5	People user DREAMWITCH54.	103
647	1	To make homemade turkey broth, boil a turkey carcass (with enough water to get 6 cups of broth) for at least 2 hours, longer if you have time. As soon as the broth cools, remove the large bones, and refrigerate the broth overnight. In the morning, skim off any fat that has risen to the surface and solidified.	105
648	2	Place a large strainer/colander in a big mixing bowl in the sink. Have the soup pot ready on the counter.	105
649	3	Pour the broth/bones/meat into that and lift it to remove all of the solids from your broth.	105
650	4	Pour the broth back into the soup pot and return it to the stove.	105
651	5	Get another medium size bowl and start pulling the meat from the bones in the colander.	105
652	6	Cut or shred it as you go. Set aside when done.	105
653	7	Chop and measure all of the vegetables, and start adding them to the soup pot, which you now need to turn on at medium heat.	105
654	8	Add tomatoes and turkey meat.	105
655	9	Add bouillon and spices. Bring to a full boil, then reduce to simmer, and leave on simmer for at least 1 hours (2 hours is better). Check the flavor and add any more seasoning, if needed.	105
656	10	Divide into serving bowls and serve.	105
663	1	400 degree 20 min	107
664	2	Serving Size: 11x8 cut in to 6 servings	107
665	3	Number of Servings: 6.0Recipe submitted by Spark	107
666	4	People user PATTYFULTON2121.	107
671	1	Put a pan on the stove and turn it to medium-high heat.	109
672	2	Add the chicken broth, boullion cube, and bacon fat (or butter) to the pan.Bring the broth to a boil, add the chili garlic paste and stir. Turn the stove off.Beat the eggs and pour into the steaming broth, stirring and letting sit for a moment.	109
673	3	Serve.	109
680	1	Prepare the Cauli-rice by grating the cauliflower. Don't cook it.Grate the ginger and finely chop the chili peppers.	111
681	2	Place on a large heavy-based pan greased with ghee, butter or coconut oil. Cook briefly for 2-3 minutes over medium-high heat.	111
682	3	Add sliced mushrooms and cook for another 3 minutes (white mushrooms contain less carbs than brown).	111
683	4	Add the cauli-rice and mix in well. Season with salt to taste and cook for another 5 minutes while stirring frequently.Finely chop the spring onion and add it to the pan together with the peeled, cooked prawns.In a bowl, scramble the eggs and pour in the pan while stirring. Cook for 1-2 minutes.	111
684	5	Mix in the coconut aminos and fish sauce.	111
685	6	Add freshly chopped herbs, lime juice and cook for a minute. Take off the heat and set aside.	111
686	7	Add toasted flaked almonds. To toast the almonds, simply place them on a pan and roast over medium-high heat. Do not grease the pan and roast for 2-3 minutes while stirring frequently to prevent the almonds from burning.Done - enjoy!	111
561	1	Brown ground beef over medium heat.	92
562	2	Add onion and cook until translucent.	92
563	3	Transfer ground beef and onion mixture to stock pot.	92
564	4	Add garlic, cumin, cabbage, bouillon cubes, Rotel diced tomatoes & green chilies, and water to the stock pot.	92
565	5	Mix ingredients thoroughly and bring to a boil over high heat.Reduce heat to medium-low and simmer covered for 30 - 45 minutes.	92
571	1	Chop celery, and green onions	94
572	2	Heat a large frying pan or stir fry pan.	94
573	3	Add sesame oil,  sausage, garlic and ginger.  Cook until sausage is cooked through and is all small pebbles.	94
574	4	Add celery, onions and cauliflower.  Cook with sausage for 5 minutes over medium heat.	94
575	5	Add a bag of cabbage and the soy sauce.  Keep stir frying until cabbage is tender.	94
576	6	Add more cabbage and/or soy sauce to taste.  I like lots of cabbage.	94
577	7	Serve immediately while hot.  You can garnish with more chopped green onions or wonton noodles.	94
583	1	Brown ground pork in a large pan or wok over medium heat.Ensure cabbage and onion is thinly sliced into long strands. Use a spiralizer to cut the vegetables for quickest results.	96
584	2	Add sesame oil and onion to pan with browned ground pork.	96
585	3	Mix together and continue cooking over medium heat.	96
586	4	Mix soy sauce, garlic, and ground ginger together in a small bowl. Once onions have browned, add the sauce mixture to the pan.Immediately add the cabbage mixture to the pan and toss to coat the vegetable and evenly distribute ingredients.	96
587	5	Add chicken broth to the pan and mix. Continue cooking over medium heat for three minutes, stirring frequently.	96
588	6	Garnish with salt, pepper, and green onion.	96
594	1	Cut up sausage brown in pan.	98
595	2	Remove from pan and bacon grease to pan with salt and pepper add cabbage. Sweat and stir then add back sausage. With heat on low let cook for 15 minutes. Divide and enjoy!	98
596	3	Serving Size: 4Number of Servings: 4.0Recipe submitted by Spark	98
597	4	People user KETOMONKEYMAMA.	98
606	1	Heat oil in a large saute pan.	100
607	2	Add the shrimp and chicken and stir fry about 3 minutes or until cooked through.	100
608	3	Remove the meat from the pan and set aside.	100
609	4	Add the ginger and garlic and cook about 2 minutes.	100
610	5	Add the peppers, snow peas, bean sprouts, scallions and cabbage and stir fry 3 - 4 minutes or until just soft and still brightly colored.	100
611	6	Add the soy sauce, sweetener, rice wine vinegar, and lime juice and cook 2 minutes.Stir in the meat, spaghetti squash and miracle noodles, turning until well coated in sauce.	100
612	7	Serve hot, garnished with cilantro if desired.	100
618	1	Chop meat and vegetables, and throw in a large soup pot.	102
619	2	Add beef broth, chopped garlic, and spices. Simmer for at least 1 hour. (If you want the meat to be more tender, simmer on low heat for 2 hours.)	102
620	3	Turn off heat, and let soup sit for at least another hour for flavors to blend. Measure out into individual serving dishes. Rewarm the portions you are using immediately, and freeze those that you aren’t for later use on a night that you don’t have time to cook.	102
621	4	Tip: This is a very low fat meal, so it would be best served with a favorite high fat buttered biscuit or cracker to improve the macros for the meal.	102
622	5	I don’t get any commission or kickback for products I use or mention in my recipes. Nutritional estimates are per serving based on exact ingredients I used, calculated with My Fitness Pal’s online recipe analyzer. The recipe is stored there and available to MFP users for logging in their food diaries.	102
623	6	Calories 141, Total Fat 4 g, Sodium 165 mg, Potassium 359 mg, Total Carbohydrate 10 g, Dietary Fiber 2 g, Net Carbs 8 g, Sugars 3 g, Protein 15 g.  Macros:  28% fat, 47% protein, 25% carbs	102
624	7	© October 25, 2016  Roxana Lopez for Aunt Rocky’s	102
625	8	For more low lchf/keto recipes and cooking tips, look for Aunt Rocky’s Low Carb Recipes & Tips Group on Facebook, or follow me on Pinterest at auntrocky2.	102
631	1	Slice beef and chop all of the vegetables before starting.	104
632	2	Heat a large skillet or wok over medium heat.	104
633	3	Add 2 tablespoons oil. When oil shimmers, add beef. Stir and keep frying until beef is cooked and all the pan juices have dried up.	104
634	4	Let beef brown a little, then transfer to a bowl.	104
635	5	Add remaining oil to the skillet. When heated, add sliced leeks and red bell pepper. Stir and cook for about 3 minutes.	104
636	6	Add zucchini, mushrooms, garlic and ginger. Cook for about 3 more minutes.	104
637	7	Add cabbage and cook for an additional 3 minutes.	104
638	8	Meanwhile, in a bowl, combine ingredients for sauce. Set aside.	104
639	9	Add beef back into the skillet.	104
640	10	Add stir fry sauce, stir, cover and allow the vegetables to steam until the cabbage is just fork tender.	104
641	11	Remove from heat, and serve.	104
642	12	Note: If you are on a higher carb allowance, you may serve over cooked cauliflower rice. Carb eaters can serve theirs over regular rice.	104
643	13	I don’t get any commission or kickback for products I use or mention in my recipes. Brand names are included only to more accurately assess nutritional estimates, which are based on exact ingredients I used. Nutrition estimates are calculated per serving with My Fitness Pal’s online recipe analyzer using the exact brands I use. The recipe is stored there and available to MFP users for logging in their food diaries.	104
644	14	Calories 366, Total Fat 27 g, Saturated Fat 7 g, Sodium 84 mg, Potassium 275 mg, Total Carbohydrate 10 g, Dietary Fiber 4 g, Net Carbs 6 g, Sugars 4 g, Protein 21 g. Macros:  69% fat, 24% protein, 7% carbs.	104
645	15	© August 15, 2017 Roxana Lopez for Aunt Rocky’s	104
646	16	For more low lchf/keto recipes and cooking tips, look for Aunt Rocky’s Low Carb Recipes & Tips Group on Facebook, or follow me on Pinterest at auntrocky2.	104
657	1	Preheat oven to 350 degrees F (175 degrees C).	106
658	2	Heat a large skillet over medium-high heat. Cook sausage, breaking it apart with a wooden spoon, until browned and crumbly, 5 to 7 minutes.	106
659	3	Spread over the bottom of a 9x13-inch casserole dish.	106
660	4	Mix eggs, Cheddar cheese, cream, onion, mustard, oregano, salt, and pepper together in a bowl.	106
661	5	Pour mixture over the sausage.	106
662	6	Bake in the preheated oven until firm and cooked through, 30 to 40 minutes.	106
667	1	Boil Eggs -	108
668	2	Place eggs in the bottom of a pot and fill with cold water. Bring the water to a rolling boil and turn off the burner. Cover pot with a lid and let them cook for 15 minutes.	108
669	3	Remove eggs and place in a bowl of ice water. Allow to cool completely and peel.Chop celery, green onions, and green pepper.Peel and cut boiled eggs	108
670	4	In a bowl add yolks, mayo, and mustard and mix well with a spoon.Stir in your chopped whites, green pepper, celery, and green onion.Top with paprika and salt (to taste). This is optional	108
674	1	Separate 3 of 6 yolks from the whites. Bring the yolks, oil and broth to a boil very gradually.	110
675	2	Drizzle in remaining beaten eggs.	110
676	3	Add chicken meat, not included. Top with chives or scallions.	110
677	4	Serving Size: 4 big bowls	110
678	5	Number of Servings: 4.0Recipe submitted by Spark	110
679	6	People user PUFF2TUFF.	110
687	1	Add all ingredients to a mixing bowl and mix on medium for 10-15 minutes.	112
688	2	Refrigerate overnight before serving	112
689	1	Preheat the oven to 300 F (150 C).	113
690	2	Mix together the coconut oil, coconut flour, and baking soda.	113
691	3	In a separate bowl, whisk together the gelatin and hot water to create your gelatin egg.	113
692	4	Pour the gelatin egg into the coconut flour mixture and combine well.	113
693	5	Add in the Italian seasoning and salt to taste (you can taste the mixture to see if you want to add more) and mix well into a dough.	113
694	6	Use your hands to form 2 small rolls from the dough, place the rolls on a baking tray lined with parchment paper, and bake in the oven for 40-50 minutes until the outside of each roll is slightly browned and crispy like youd typically find in a regular bread roll.	113
695	7	Let the rolls cool down before serving so that the gelatin sets a bit and can hold the roll together. Enjoy at room temperature with some ghee or coconut oil.	113
696	8	This recipe can be doubled, tripled, etc. if you want to make more AIP bread rolls at the same time.	113
697	1	Fry up eggs and ham in some bacon drippings, add pepper, then pour chicken broth into skillet.  Enjoy with a BITE of GREEN broccoli salad.Serving Size: 2 servings 4 oz each	114
698	2	Number of Servings: 2Recipe submitted by Spark	114
699	3	People user SKINNYMEX.	114
700	1	Turn on a multi-functional pressure cooker (such as Instant Pot®) and select	115
701	2	Saute function.	115
702	3	Heat olive oil and cook onion, red bell pepper, garlic, chili powder, paprika, and cumin until soft, about 3 minutes.	115
703	4	Add kale and cook until soft, about 2 minutes. Stir in marinara sauce and season with salt and pepper; turn off the pot and let cool for 5 minutes.	115
704	5	Crack eggs carefully in the pot, evenly spaced. Close and lock the lid. Select low pressure according to manufacturer's instructions; set timer for 1 minute. Once it beeps, release pressure carefully using the quick-release method according to manufacturer's instructions, about 2 minutes. Unlock and remove the lid.	115
705	6	Sprinkle with parsley.	115
706	1	Mix all ingredients well and use a spoon to drop onto a parchment-lined baking sheet. Use whatever spoon size you like. Teaspoon drops will result in a small bite-sized snack, and heaping tablespoons will spread to the size of a cookie.	116
707	2	Bake in a 350'F oven until bottom and edges are slightly brown, then remove to a wire rack to cool completely. Store in the fridge for up to a week.	116
708	3	Eat these plain, dipped in a dip or dressing, or on top of a green salad.Serving Size: Makes 2-4 servings	116
709	4	Number of Servings: 2.0Recipe submitted by Spark	116
710	5	People user AOLSON80.	116
711	1	In a mixing bowl melt butter and cream cheese.	117
712	2	Add whey protein and eggs, careful not to cook the eggs from the heat of the butter.	117
713	3	Combine with a hand mixer until completely mixed.	117
714	4	Pour into muffin baking tray and bake at 350 degrees for 26 minutes. Enjoy!	117
715	1	Mix all ingredients in to a bowl until smooth and well combined.	118
716	2	Grease a loaf/cake tin well to make sure the keto bread doesn't stick.	118
717	3	Pre-heat oven to 200C (390F).	118
718	4	Pour the bread mixture in to the tin, and bake in the oven for 20 minutes.	118
719	1	Please watch video for directions!	119
720	1	Grate Cauliflower	120
721	2	Microwave for 3 Minutes	120
722	3	Place in Paper Towel or Cheesecloth to	120
723	4	Remove Excess Water	120
724	5	Put all Ingredients in Bowl and	120
725	6	Mix	120
726	7	Form into Hashbrown shape and place on greased baking sheet	120
727	8	Bake on 400° for 15-20 minutes	120
728	1	Mash avocado in a bowl.	121
729	2	Add heavy cream, stevia, vanilla, and cinnamon; mix thoroughly.	121
730	3	Refrigerate avocado mixture for 1 hour before serving.	121
731	1	Cut avocados in half and place 3 halves in a bowl.	122
732	2	Add the chopped onions and the juice from half lemon.	122
733	3	Use a spoon to mash the avocados and mix the ingredients.	122
734	4	Add the parsley and keep stirring, until it is evenly combined.	122
735	5	Place in a serving bowl.	122
736	6	Garnish with the key lime.	122
737	7	Serve with tortilla chips and enjoy.	122
738	1	Remove skin and seed from avocado, slice or shred cheese, and open cream cheese.	123
739	2	Place in your food processor.Process until well combined and creamy	123
740	3	While still in the food processor stir and mix well	123
741	4	Add minced garlic and onion powder and process until well combined	123
742	5	Serve with pork rinds or veggies and enjoy!	123
749	1	Cut the avocado in half, remove the seed/stone, and score the avocado into large slices (approx. 4-6 slices per avocado half).	125
750	2	Squeeze lime over the avocado slices.	125
751	3	Lay each prosciutto slice flat on a plate and place each avocado slice on the prosciutto slice.	125
752	4	Squeeze a bit more lime on the avocado slice and then roll it up.	125
758	1	Throw all of the ingredients into a food processor, equipped with an S blade. Process until well combined and smooth.	127
759	2	Add more or less sweetener to taste.	127
768	1	start by making the burger bun; leave it to cool.	129
769	2	in a medium pyrex bowl or similar, mix all burger ingredients (using food-safe disposable gloves helps); form a burger shape -either by hand or by using a burger 'maker', and place in the fridge to set for at least 30 minutes (you can do this one day in advance if you prefer).	129
770	3	while you wait for the burger patty to set, make the sauce by combining all 4 ingredients and stirring until smooth; taste test and refrigerate, covered in cling film.	129
771	4	peel and slice avocado and set aside.	129
772	5	wash + dry kale leaves and set aside.	129
773	6	place butternut squash chips in an oven tray, sprinkle a little olive oil (or bacon fat if you have any), salt and pepper and bake for 30-40 mins at 180C fan (200C static), turning over half-way through baking time.	129
774	7	place burger and bacon rashers under the grill and cook on medium-high heat for about 7-10 minutes, then flip over and grill for 6-8 minutes (depending on how well done you like it); I like my bacon very crispy - if you don't, remove it from the grill sooner and keep it warm by wrapping it in foil and leaving it at the bottom of the grill or oven, by the door.	129
775	8	put cheddar slice on top of the burger and continue to grill for a couple of minutes until melted.	129
776	9	while the meat cooks, you may wish to re-heat the bun for a minute or so (oopsies tend to become quite sticky after a while).	129
777	10	now you just need to assemble everything and enjoy it!	129
783	1	Add all ingredients but avocado to the blender and blend until smooth.	131
784	2	Add the avocado and blend until broken apart.	131
785	3	Serve with a sprinkle of pumpkin spice on top, if you’d like.	131
786	4	Did you know MCT oil also comes in powdered form? Ya! In its powdered state, it's much easier to use, travel with, and incorporate into your favorite recipes. Plus, if you've experienced digestive issues with MCT oil before, MCT oil powder is a lot gentler on the gut. Check out my favorite brand of MCT oil powder here.	131
791	1	In a large bowl whisk the eggs with the mct oils, the herbes de provence the olives and the salt, until frothy.	133
792	2	Cut, peel and slice the avocado into thick slices.In a large ceramic skillet melt the butter until foamy on a high flame, then put in the avocado and fry in the butter until slightly golden on all sides.	133
793	3	Remove with a spatula and set aside.Still on a high flame pour the egg mixture in to the skillet.Slice the brie in thin slices and place it on the egg mix (yes it will sink!).Now cover the skillet and cook for about 3 minutes, or until the bottom of the frittata is golden brown.Now with the aid of a lid or a plate flip the frittata and cook for another 2 minutes.	133
794	4	Serve the frittata hot on a large plate topped with the avocado.	133
798	1	Prepare the quick guacamole. Halve the avocado and scoop into a bowl.	135
799	2	Add the lime juice, onion, salt and pepper. Mash using a fork and set aside.	135
800	3	Heat a pan greased with half of the ghee over a medium heat. Using your hands, create small patties from the sausage meat.	135
801	4	Place on the pan and cook undisturbed for 2-3 minutes. Flip on the other side and cook for 1-2 more minutes and set aside.Grease the pan with the remaining ghee and crack in the eggs. Cook until the egg whites are cooked through and the egg yolks are still runny. If you use an egg mold like this one, make sure to lower the heat, as it will take longer to cook through.When done, top each patty with the prepared guacamole and fried egg. Season with salt and pepper to taste and eat immediately.Meal-prep tip: You can prepare the guacamole and fry the sausage patties in advance and keep in an airtight container for up to 3 days.	135
802	5	Serve with fried or poached egg.	135
743	1	Skin and remove pits from Avocados, spoon avocado into a bowl	124
744	2	Add sweetener	124
745	3	Mush avocado with a spoon	124
746	4	Mix in Heavy Cream	124
747	5	This dessert is best enjoyed cold. If avocados aren’t cold, refrigerate mix for an hour.	124
748	6	Enjoy!	124
753	1	Cook the chicken breast on low heat until fully cooked. You can do this in a slow cooker, in a pan or on the grill. Cube or shred chicken.	126
754	2	Combine chicken, red onion, English cucumber & celery in a bowl.	126
755	3	Cut and pit an avocado. Scoop some of the avocado and add it to the bowl.	126
756	4	Add in the sour cream and season with salt and pepper.Toss everything well and then scoop the mix back into the avocado halves.Toss everything well and then scoop the mix back into the avocado halves.We provide nutritional information for our recipes as a courtesy to our readers. The data is calculated using the MyFitness	126
757	5	Pal app. We remove fiber and sugar alcohols, including erythritol, from the final carbohydrate count since they do not affect blood glucose levels in most individuals. We try to be as accurate as possible but we encourage you to calculate nutritional information on your own.	126
760	1	Preheat oven to 350 degrees F (175 degrees C). Line 2 baking sheets with parchment paper or silicone mat.	128
761	2	Spread Cheddar cheese into four 6-inch circles, placed 2 inches apart.	128
762	3	Bake in the preheated oven until cheese melts and is lightly brown, 6 to 8 minutes.	128
763	4	Cool for 2 to 3 minutes before lifting with a spatula.	128
764	5	Place over wooden spoon handle wrapped in aluminum foil balanced over 2 cups/cans.	128
765	6	Let taco shells cool completely, about 10 minutes.	128
766	7	Cook beef in a skillet over medium-high heat until browned, stirring often to separate meat, about 7 minutes. Season with taco seasoning, salt, and pepper; cook for 1 minute more.	128
767	8	Divide beef mixture among cheese taco shells. Top with avocado, lettuce, Cheddar cheese, and tomatoes.	128
778	1	Season chicken with salt, pepper and italian seasoning.	130
779	2	Heat oil in saute pan add chicken and brown in both sides.	130
780	3	Add tomato, garlic and cream and simmer until sauce thickness to your liking.Serving Size: 1 breast plus 1/4 sauce	130
781	4	Number of Servings: 4.0Recipe submitted by Spark	130
782	5	People user KKOB968.	130
787	1	Start by chopping the lettuce and placing into a salad bowl.	132
788	2	Chop all remaining ingredients and place them into individual piles atop the lettuce.	132
789	3	Salt and pepper to taste.	132
790	4	Add oil and vinegar or your dressing of choice. Enjoy!	132
795	1	Place all ingredients in a high speed blender, adding the ice last. I love using my Nutri Ninja for smoothies as it is powerful and easy to clean.	134
796	2	Blend for 1 minute or until smooth and creamy.	134
797	3	Pour into a bowl and sprinkle with your favorite low-carb toppings. 	134
803	1	Heat a heavy pot over medium-high heat.	136
804	2	Add oil and stew meat. Sauté until browned on all sides.	136
805	3	Remove stew meat from pot.	136
806	4	Add onion, red bell pepper, and garlic to the pot.	136
807	5	Saute until translucent.	136
808	6	Add ground beef to the pot and saute until cooked through.	136
809	7	Add tomato paste and spices and stir to combine.	136
810	8	Add sautéed stew meat, crushed tomatoes, and salt. Stir.	136
811	9	Place a lid on top, reduce heat to low, and let simmer for 2 hours, or until stew meat is tender.	136
812	10	Serve chili with shredded cheese, cilantro, sour cream, and avocado.	136
813	11	For the Instant Pot: Brown the stew meat using the saute function, remove from the pot and add the onion, bell pepper, and garlic.	136
814	12	Saute until translucent.	136
815	13	Add the ground beef and cook through.	136
816	14	Add the stew meat back to the pot along with the remaining ingredients.	136
817	15	Place the lid and pressure cook on high for 15 minutes, followed but a 10 minute Natural pressure release.	136
818	16	For the slow cooker: Follow the instructions for the stove top, but transfer to the slow cooker when it is time to simmer and cook on high for 4 hours or low for 8 hours.	136
819	17	Note: If you want your chili spicier, you can add 1 to 2 teaspoons cayenne pepper.	136
820	18	Nutrition per serving: 271 calories, 16g fat, 9g carbs, 3g fiber, 24g protein	136
821	1	Crisp and drain bacon.  Brown ground beef in 1 Tbs. bacon fat.	137
822	2	Drain beef.  Chop bacon.	137
823	3	Mix the two and layer in 9" x 13" baking dish.	137
824	4	Mix whipping cream and eggs and cheese.	137
825	5	Pour over meat.  Top with more cheese.	137
826	6	Bake at 350 degrees F for 30 minutes.  Cool 5 minutes.	137
827	7	Serves 6.Serving Size: 6 servings	137
828	8	Number of Servings: 6Recipe submitted by Spark	137
829	9	People user COMPUCATHY.	137
830	1	Preheat oven to 400	138
831	2	Cut chicken into desired tender size and wrap with bacon	138
832	3	Spray a 9 x 13 pan with Coconut spray and place chicken in the baking pan	138
833	4	Bake for 30 minutes or until meat thermometer reads 160	138
834	5	While baking chicken, melt butter the whisk in cream and cook for 1 minute	138
835	6	Stir in mustard remove from heat and stir in the remaining 2 Tbs of butter	138
836	1	Preheat oven to 350	139
837	2	Cook bacon on the stove and prep all other ingredients	139
838	3	Mix all ingredients (except avocado) in a mixing bowl and mix well.	139
839	4	Fold in avocado	139
840	5	Dish into muffin cups and bake for 25-30 minutes	139
841	6	This recipe makes 15 muffins.	139
842	1	Preheat oven to 375	140
843	2	Cook bacon, drain, and crumble.	140
844	3	Thaw and drain spinach and mix all ingredients together.	140
845	4	Pour into silicon baking cups and bake for 20 - 25 minutes.	140
846	5	Check with a toothpick and bake for additional 3 minute increments until done.	140
847	6	Eggs are tricky to bake and everyone likes them differently. I don't like dry eggs, but my family doesn't like them runny so I really have to bake them until we can all agree they are delicious!	140
853	1	Preheat oven to 350 degrees F (180 degrees C). Grease an 11x7-inch glass baking dish.	142
854	2	Combine almond flour, Italian seasoning, and salt in a bowl; stir well.	142
855	3	Mix in olive oil using a fork until mixture resembles breadcrumbs. Knead dough into a ball. Press down dough into the prepared baking dish to form the crust.	142
856	4	Bake in the preheated oven until lightly golden, about 20 minutes.	142
857	5	Let cool for 5 minutes.	142
858	6	Brush bottom with Dijon mustard.	142
859	7	Cook bacon in a skillet over medium heat until crispy, about 3 minutes.	142
860	8	Whisk eggs and heavy cream together in a bowl. Season with garlic, salt, ground black pepper, and ground nutmeg.	142
861	9	Layer bacon pieces over the bottom of the almond-flour pastry; top with shredded Gouda cheese.	142
862	10	Pour in egg mixture and place cherry tomatoes on top.	142
863	11	Sprinkle with oregano.	142
864	12	Bake in the preheated oven until set and golden, about 30 minutes.	142
871	1	Preheat oven to 350Grease the muffin slots in a 12 slot muffin tray.	144
872	2	Place a slice of bacon around the sides of each muffin sot.	144
873	3	Place ground beef and cheese in layers to your liking through the muffin slots.	144
874	4	Bake for 30 minutes.	144
875	5	Sprinkle remaining cheese on top of the muffins and return to oven to melt.	144
876	6	Remove and allow to cool fro 10 minutes.Line a serving tray with paper towels to absorb remaining bacon grease when removing the muffins.Serving Size: Makes 12 Muffins	144
877	7	Number of Servings: 12Recipe submitted by Spark	144
878	8	People user ZUPHEAL.	144
891	1	Add all of the ingredients to a large bowl and toss well to combine.	146
892	2	Serve with lettuce wraps or in a low carb tortilla.	146
893	3	Nutrition per serving: 329 calories, 26.3g fat, 8.6g carbs, 5.6g fiber, 17.2g protein	146
907	1	Cut the cauliflower into florettes and add them to a microwave safe bowl.	148
908	2	Add 2 tablespoons of water and cover with cling film. Microwave for 5-8 minutes, depending on your microwave, until completely cooked and tender.	148
909	3	Drain the excess water and let sit uncovered for a minute or two. (Alternately, steam your cauliflower the conventional way. You may need to squeeze a little water out of the cauliflower after cooking.)	148
910	4	Add the cauliflower to a food processor and process until fluffy.	148
911	5	Add the butter, garlic powder, and sour cream and process until it resembles the consistency of mashes potatoes.	148
912	6	Remove the mashed cauliflower to a bowl and add most of the chives, saving some to add to the top later.	148
913	7	Add half of the cheddar cheese and mix by hand. Season with salt and pepper.Top the loaded cauliflower with the remaining cheese, remaining chives and bacon. Put back into the microwave to melt the cheese or place the cauliflower under the broiler for a few minutes.I visually divide the cauliflower into sixths. Serving size is approximately 1/3-1/2 cup.	148
923	1	In a pan, fry the bacon slices. Once crisped up, place on a plate, let them cool down and then crumble into small pieces.	150
924	2	Pour the bacon grease - apart from 1 tablespoon - in a jar and reserve for cooking, or discard. Slice the mushrooms, add to the pan and roast them over a medium heat for 3-5 minutes or until lightly browned.	150
925	3	Place all the dry ingredients in a small bowl and combine well.	150
926	4	Add the egg, cream, water and mix well using a fork.	150
927	5	Add the crumbled bacon and roasted mushrooms and combine well.	150
928	6	Divide the dough between 2 mugs or ramekins and add diced cheddar and chopped basil. Microwave on high for 60-90 seconds. When done, let it sit for 5 minutes.	150
929	7	Enjoy!	150
930	8	Cooking in the oven: If you don't have a microwave, I suggest you make 4-8 servings at once. Preheat the oven to 175 °C/ 350 °F and cook for about 12-15 minutes or until cooked in the centre.	150
931	9	Crisping up the bacon: Preheat the oven to 190 °C/ 375 °F. Line a baking tray with baking paper.	150
932	10	Lay the bacon strips out flat on the baking paper, leaving space so they don't overlap.	150
933	11	Place the tray in the oven and cook for about 10-15 minutes until golden brown. The time depends on the thickness of the bacon slices. When done, remove from the oven and set aside to cool down.	150
934	1	Drain tuna and place in a bowl.	151
935	2	Cut grapes in half and mix all ingredients together with tuna.	151
936	3	Serve and enjoy!	151
942	1	Brown butter on low heat until an amber color.	153
943	2	Add cream, stevia, and pecans and stir until combined together.	153
944	3	Whisk coconut milk and xanthan gum into brown butter mixture, then place in ice cream machine.Follow manufacturers instructions for ice cream machine.	153
953	1	Combine cream cheese, eggs, sugar, and cinnamon in a blender; blend until smooth.	155
954	2	Let rest 2 minutes or lightly tap on counter to remove bubbles.	155
955	3	Heat a skillet over medium heat and grease with cooking spray.	155
956	4	Pour 1/4 of the batter into the skillet; cook until bubbles start to form, about 2 minutes. Flip and cook until cooked through, about 1 minute.	155
957	5	Transfer to a clean plate. Repeat with remaining batter.	155
848	1	Slice each chicken breast/fillet along the centre.	141
849	2	Place chopped spinach, cream cheese and diced bacon along the centre of each chicken breast/fillet.	141
850	3	Fold over, and use a toothpick to secure the chicken and its fillings.	141
851	4	Place each chicken breast/fillet in an oiled baking dish and pour some extra oil over each one.	141
852	5	Bake at 180C/350F for 30 minutes, or until cooked in the centre. Cooking times will vary with the size of chicken breast and thickness of meat.	141
865	1	Start with two thawed chicken breasts and season with salt and pepper	143
866	2	Cover with cheese	143
867	3	Add Jalapenos (Optional)	143
868	4	Cut the bacon in half and drape over the chicken	143
869	5	Transfer to a foil lined pan and bake at 350 for 30-45 minutes or until done	143
870	6	If the chicken is done and the bacon is not, put it under the broiler for a few minutes	143
879	1	Cook bacon first in a medium size skillet for 4 minutes over medium heat. Flip bacon and cook for another 4 minutes or until crispy. Using a tongs take bacon out of the skillet and place on a paper towel.	145
880	2	Wipe down the same skillet with a paper towel and place  cup mozzarella cheese into pan creating a 5-inch wide circle.	145
881	3	Melt mozzarella over medium heat on the stove top until edges become golden brown, 4 minutes. Carefully flip cheese with a spatula and let cook for 1 minute.	145
882	4	Place a turkey baster (or anything 6 inches long and round) on the rim of a medium size bowl.	145
883	5	Using a spatula lift cheese out of the skillet and drape over the turkey baster resting on the bowl.	145
884	6	Repeat steps 2-5 with the remaining cheese in batches of  cups to create 3 taco shells total.	145
885	7	In the same skillet, heat up 1 tablespoon of ghee over medium heat.	145
886	8	Wisk 5 large eggs in a small bowl and pour into heated skillet.	145
887	9	Scramble eggs for about 2 minutes or until fully cooked.	145
888	10	Divide the scrambled eggs into three even portions and spoon into prepared taco shells.	145
889	11	Add diced avocado, cheddar cheese and diced tomato on top of the scrambled eggs.	145
890	12	Garnish with sliced green onion.	145
894	1	Place the spiralized zucchini in an 8x8 or 9x9 baking dish that has been lightly greased.  Set aside.	147
895	2	Heat a frying pan on medium high and add the bacon. Cook the bacon on both sides until crisp.	147
896	3	Remove bacon and set aside. Coat both sides of the chicken breasts with salt and pepper.	147
897	4	Add the chicken breasts to the same pan the bacon was cooked in. Cook chicken on both sides until deep golden brown and cooked through, about 4-5 minutes per side (depending on how big the breasts are). While the chicken is cooking, chop the bacon.When the chicken has finished cooking, remove from the pan and place on a cutting board to rest while you make the sauce.	147
898	5	Pour 1/2 of the fat and juices in the frying pan into a blender(preferably a high speed blender), and discard the rest.	147
899	6	Place the cauliflower, onion, salt, garlic, and chicken broth in a saucepan and cover with a lid.	147
900	7	Heat on medium high and steam the mixture for 5 minutes, or until the cauliflower is soft.	147
901	8	Add the contents of the saucepan to the blender and pour in the almond milk. Blend on high speed until the sauce becomes smooth and creamy. Taste the sauce and add more salt and pepper, if needed.	147
902	9	Sprinkle the chopped bacon over the zucchini noodles. Slice the chicken and place the slices on top of the zucchini noodles.	147
903	10	Pour the sauce over the noodles and chicken, covering the entire dish.	147
904	11	Heat the oven to broil.	147
905	12	Place the dish on the middle rack and cook for 10-15 minutes, or until the sauce is hot and bubbling. The zucchini noodles should be heated through, but not cooked to the point that they start releasing all their liquid. If the zucchini does heat to the point that there is liquid in the bottom of the dish, carefully drain off before serving.	147
906	13	Sprinkle the chopped parsley over the top of the bake and serve.	147
914	1	Preheat oven to 400 degrees Farenheit.	149
915	2	Combine turkey, 1 cup mozzarella, egg and garlic powder. Be sure to reserve at least a 1/2 cup of the cheese for the topping.Press the mixture flat into a greased cast-iron skillet.	149
916	3	Bake in oven for 20 minutes.	149
917	4	Remove from oven and carefully drain accumulated grease.	149
918	5	Spread the tomato sauce evenly over the cooked turkey mixture.	149
919	6	Sprinkle half of the remaining mozzarella over the crust, then layer olive, canadian bacon, and pepperoni toppings.	149
920	7	Sprinkle the rest of the mozzarella cheese over the top.	149
921	8	Bake in oven for an additional 20 minutes.	149
922	9	Let cool for 5-10 minutes before slicing into meatza to serve.	149
937	1	In a medium mixing bowl add water to egg white and froth until white.  In another bowl mix golden Monkfruit, cinnamon and pink salt together well.	152
938	2	Add pecans to the bowl with egg white mixture and coat well.  Then gradually start mixing in the dry ingredients, again coating the pecans well.  I saved a little of the dry ingredient mixture to sprinkle on pecans after I removed them from the oven but that’s optional.	152
939	3	Spread coated pecans on a parchment lined cookie sheet and bake at 250 degrees for 1 hour.	152
940	4	Remove and sprinkle rest of monkfruit mixture over hot pecans.	152
941	5	Let cool and enjoy.Serving Size: Nutrient values is per pecan halves.	152
945	1	Prepare the Coconut &amp; Pecan Butter.	154
946	2	Mix the prepared coconut &amp; pecan butter with powdered Erythritol, protein powder, ...... extra virgin coconut oil, ...... and maple extract.	154
947	3	Add stevia and cinnamon (if used).	154
948	4	Mix until well combined and place in the fridge for 30 minutes to firm up.Meanwhile, melt the dark chocolate and cacao butter in a double boiler or a glass bowl on top of a small saucepan filled with a cup of water over a medium heat. Once completely melted, mix well and turn off the heat. Set aside to cool down before using it for coating.Using your hands, create 8 bars and place on a tray lined with baking mat or parchment paper.	154
949	5	Place in the fridge for 30-60 minutes or in the freezer for 15-20 minutes. Use your hands ...... or kitchen tongs to hold the bars so you can coat them in the cooled dark chocolate mixture from all sides.	154
950	6	Place back on the tray.	154
951	7	Drizzle any remaining chocolate on top.	154
952	8	Place in the fridge for 30-60 minutes before serving. Keep refrigerated, especially if you use coconut oil instead of cocoa butter (coconut oil melts at room temperature).	154
\.


--
-- Data for Name: nutrients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.nutrients (id, name, unit_id) FROM stdin;
1	Calories	\N
2	Fat	1
3	Trans Fat	1
4	Saturated Fat	1
5	Mono Unsaturated Fat	1
6	Poly Unsaturated Fat	1
7	Cholesterol	2
8	Sodium	2
9	Carbohydrates	1
10	Net Carbohydrates	1
11	Fiber	1
12	Sugar	1
13	Sugar Alcohol	1
14	Protein	1
15	Caffeine	2
16	Calcium	2
17	Magnesium	3
18	Potassium	2
19	Copper	2
20	Zinc	2
21	Phosphorus	2
22	Iron	2
23	Vitamin A	3
24	Vitamin B1	3
25	Vitamin B2	3
26	Vitamin B1	3
27	Vitamin B1	3
28	Vitamin B3	3
29	Vitamin B5	3
30	Vitamin B6	3
31	Vitamin B12	3
32	Vitamin C	3
33	Vitamin D	3
34	Vitamin E	3
35	Vitamin K	3
36	Folic Acid	3
37	Selenium	3
38	Choline	3
39	Iodine	3
40	Carbs	1
41	Monounsaturated	1
42	Polyunsaturated	1
43	Saturated	3
44	Trans	3
45	Thiamin (B1)	2
46	Riboflavin (B2)	2
47	Niacin (B3)	2
48	Niacin (B3)	2
49	Folate equivalent (total)	2
50	Sugars	1
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, name, image, net_carbs, product_type, calories) FROM stdin;
1	spinach	https://spoonacular.com/cdn/ingredients_100x100/spinach.jpg	1.43	veggies	\N
3	swiss chard	https://spoonacular.com/cdn/ingredients_100x100/swiss-chard.jpg	2.14	veggies	\N
4	celery	https://spoonacular.com/cdn/ingredients_100x100/celery.jpg	1.37	veggies	\N
5	kale	https://spoonacular.com/cdn/ingredients_100x100/kale.jpg	8.75	veggies	\N
6	broccoli	https://spoonacular.com/cdn/ingredients_100x100/broccoli.jpg	4.04	veggies	\N
7	greenbeans	https://spoonacular.com/cdn/ingredients_100x100/green-beans-or-string-beans.jpg	4.27	veggies	\N
8	collards	https://spoonacular.com/cdn/ingredients_100x100/collard-greens.jpg	1.42	veggies	\N
9	arugula	https://spoonacular.com/cdn/ingredients_100x100/arugula-or-rocket-salad.jpg	2.05	veggies	\N
10	lettuce	https://spoonacular.com/cdn/ingredients_100x100/iceberg-lettuce.jpg	1.77	veggies	\N
11	watercress	https://spoonacular.com/cdn/ingredients_100x100/watercress.jpg	0.79	veggies	\N
12	beet greens	https://spoonacular.com/cdn/ingredients_100x100/beet-leaves.jpg	0.63	veggies	\N
13	bok choy	https://spoonacular.com/cdn/ingredients_100x100/bok-choy.jpg	1.18	veggies	\N
14	chicory	https://spoonacular.com/cdn/ingredients_100x100/escarole.jpg	0.25	veggies	\N
15	green cabbage	https://spoonacular.com/cdn/ingredients_100x100/cabbage.jpg	3.3	veggies	\N
16	cauliflower	https://spoonacular.com/cdn/ingredients_100x100/cauliflower.jpg	2.97	veggies	\N
17	spring onion	https://spoonacular.com/cdn/ingredients_100x100/spring-onions.jpg	4.74	veggies	\N
18	savoy cabbage	https://spoonacular.com/cdn/ingredients_100x100/savoy-cabbage.jpg	3	veggies	\N
20	radicchio	https://spoonacular.com/cdn/ingredients_100x100/radicchio.jpg	3.58	veggies	\N
21	mizuna	https://spoonacular.com/cdn/ingredients_100x100/mizuna.jpg	1.47	veggies	\N
22	red cabbage	https://spoonacular.com/cdn/ingredients_100x100/red-cabbage.png	5.27	veggies	\N
23	brussels sprouts	https://spoonacular.com/cdn/ingredients_100x100/brussels-sprouts.jpg	5.15	veggies	\N
24	dandelion greens	https://spoonacular.com/cdn/ingredients_100x100/dandelion-greens.jpg	5.7	veggies	\N
25	radishes	https://spoonacular.com/cdn/ingredients_100x100/radishes.jpg	1.8	veggies	\N
26	mustard greens	https://spoonacular.com/cdn/ingredients_100x100/chinese-mustard-green.jpg	1.47	veggies	\N
27	turnip	https://spoonacular.com/cdn/ingredients_100x100/turnips.png	4.63	veggies	\N
28	zucchini	https://spoonacular.com/cdn/ingredients_100x100/zucchini.jpg	2.11	veggies	\N
2	asparagus	https://cdn.shopify.com/s/files/1/2331/3573/products/asparagus.jpg?v=1505655052	1.78	veggies	\N
19	fennel	https://www.gourmetsleuth.com/images/default-source/food/fennel_300-jpg.jpg?sfvrsn=4	4.2	veggies	\N
29	eggplant	https://spoonacular.com/cdn/ingredients_100x100/eggplant.png	2.88	veggies	\N
30	sugar snap peas	https://spoonacular.com/cdn/ingredients_100x100/sugar-snap-peas.jpg	4.95	veggies	\N
31	bell peppers	https://spoonacular.com/cdn/ingredients_100x100/bell-pepper-orange.png	3.93	veggies	\N
32	cucumber	https://spoonacular.com/cdn/ingredients_100x100/cucumber.jpg	1.46	veggies	\N
33	tomatoes	https://spoonacular.com/cdn/ingredients_100x100/tomato.png	2.69	veggies	\N
34	pumpkin	https://spoonacular.com/cdn/ingredients_100x100/pumpkin.png	6	veggies	\N
35	butternut squash	https://spoonacular.com/cdn/ingredients_100x100/butternut-squash.jpg	9.69	veggies	\N
36	jalapeno peppers	https://spoonacular.com/cdn/ingredients_250x250/jalapeno-pepper.jpg	3.7	veggies	\N
39	beets	https://spoonacular.com/cdn/ingredients_100x100/beets.jpg	6.8	veggies	\N
41	red onions	https://spoonacular.com/cdn/ingredients_100x100/red-onion.jpg	6.5	veggies	\N
42	artichokes	https://spoonacular.com/cdn/ingredients_100x100/artichokes.jpg	5.1	veggies	\N
43	bluberries	https://spoonacular.com/cdn/ingredients_100x100/blueberries.jpg	9.7	fruits	\N
44	blackberries	https://spoonacular.com/cdn/ingredients_100x100/blackberries.jpg	4.3	fruits	\N
45	raspberries	https://spoonacular.com/cdn/ingredients_100x100/raspberries.jpg	5.4	fruits	\N
46	strawberries	https://spoonacular.com/cdn/ingredients_100x100/strawberries.jpg	5.7	fruits	\N
47	coconut	https://spoonacular.com/cdn/ingredients_100x100/coconut.jpg	6.2	fruits	\N
48	avocado	https://spoonacular.com/cdn/ingredients_100x100/avocado.jpg	1.8	fruits	\N
49	olives	https://www.healthdiaries.com/eatthis/wp-content/uploads/2012/08/olives-sm.jpg	0.1	fruits	\N
50	watermelon	https://spoonacular.com/cdn/ingredients_100x100/watermelon.jpg	7.2	fruits	\N
51	cantaloupe	https://spoonacular.com/cdn/ingredients_100x100/cantaloupe.jpg	7.3	fruits	\N
52	honeydew	https://www.producemarketguide.com/sites/default/files/Commodities.tar/Commodities/honeydew_commodity-page.png	8.3	fruits	\N
53	lemons	https://spoonacular.com/cdn/ingredients_100x100/lemon.jpg	9	fruits	\N
54	limes	https://spoonacular.com/cdn/ingredients_100x100/lime.jpg	10	fruits	\N
55	cranberries	https://spoonacular.com/cdn/ingredients_100x100/cranberries.jpg	8.4	fruits	\N
56	blackcurrants	https://www.endurancesportsnutritionist.co.uk/wp-content/uploads/2019/10/Blackcurrants-300x214.jpg	6.6	fruits	\N
57	peach	https://spoonacular.com/cdn/ingredients_100x100/peaches.jpg	8	fruits	\N
58	almonds	https://spoonacular.com/cdn/ingredients_100x100/almonds.jpg	2.6	nuts	\N
59	macadamias	https://foodtolive.com/wp-content/uploads/2014/02/Organic-Macadamia-Nuts.jpg	1.5	nuts	\N
62	pistachios	https://spoonacular.com/cdn/ingredients_100x100/pistachios	5	nuts	\N
63	cashews	https://spoonacular.com/cdn/ingredients_100x100/cashews.jpg	7.6	nuts	\N
64	pecans	https://spoonacular.com/cdn/ingredients_100x100/pecans.jpg	1.2	nuts	\N
65	walnuts	https://spoonacular.com/cdn/ingredients_100x100/walnuts.jpg	2	nuts	\N
66	chia seeds	https://spoonacular.com/cdn/ingredients_100x100/chia-seeds.jpg	1.4	nuts	\N
67	sunflower seeds	https://spoonacular.com/cdn/ingredients_100x100/sunflower-seeds.jpg	3.2	seeds	\N
68	flax seeds	https://spoonacular.com/cdn/ingredients_100x100/flax-seeds.jpg	0.4	seeds	\N
69	sesame seeds	https://spoonacular.com/cdn/ingredients_100x100/sesame-seeds.jpg	3.3	seeds	\N
70	pumpkin seeds	https://spoonacular.com/cdn/ingredients_100x100/pumpkin-seeds.jpg	1.3	seeds	\N
71	pine seeds	https://nuts.com/images/rackcdn/ed910ae2d60f0d25bcb8-80550f96b5feb12604f4f720bfefb46d.ssl.cf1.rackcdn.com/3015_Pine+Nuts_Bowl-RK6ZXdMp-large.jpg	2.7	seeds	\N
72	salmon	https://spoonacular.com/cdn/ingredients_100x100/salmon.jpg	0	healthy fats	\N
73	sardines	https://images-na.ssl-images-amazon.com/images/I/71HI0NrRxuL._SX425_.jpg	0	healthy fats	\N
74	herring	https://upload.wikimedia.org/wikipedia/commons/0/00/Haring_met_ui.jpg	0	healthy fats	\N
75	pork	https://balidirectstore.com/wp-content/uploads/2019/10/Free-Range-Pork-Belly.jpg	0	healthy fats	\N
76	lamb	https://desikasai.com.au/wp-content/uploads/2019/05/lamb-meat.jpg	0	healthy fats	\N
78	duck	https://www.gourmetfoodstore.com/images/Product/large/rougie-flash-frozen-duck-breast-magret-moulard-1S-6177.jpg	0	healthy fats	\N
79	butter	https://spoonacular.com/cdn/ingredients_100x100/butter	0	healthy fats	\N
80	mayonnaise	https://spoonacular.com/cdn/ingredients_100x100/mayonnaise.jpg	0	healthy fats	\N
81	egg yolks	https://spoonacular.com/cdn/ingredients_100x100/egg-yolk.jpg	0	healthy fats	\N
82	avocado oil	https://spoonacular.com/cdn/ingredients_100x100/avocado-oil.jpg	0	healthy oils	\N
83	olive oil (extra virgin)	https://spoonacular.com/cdn/ingredients_100x100/olive-oil.jpg	0	healthy oils	\N
84	red palm oil	https://www.treehugger.com/thmb/E9z-elsd68qyE8JTCWwK6pVtGRU=/530x300/filters:fill(auto,1)/__opt__aboutcom__coeus__resources__content_migration__mnn__images__2013__01__palmoillarge-6f09ef1fc7d2488f8b736a4e1df01320.jpg	0	healthy oils	\N
85	lard	https://spoonacular.com/cdn/ingredients_100x100/lard.jpg	0	healthy oils	\N
86	almond oil	https://spoonacular.com/cdn/ingredients_100x100/almond-oil.jpg	0	healthy oils	\N
87	flaxseed oil	https://spoonacular.com/cdn/ingredients_100x100/flaxseed-oil.jpg	0	healthy oils	\N
61	brazil nuts	https://spoonacular.com/cdn/ingredients_100x100/brazil-nuts.jpg	1.4	nuts	\N
88	allulose	https://shop.wholesomesweet.com/img/thumbs/whsm-958121.jpg	4	sweetener	\N
38	white mushrooms	https://www.markon.com/sites/default/files/pi_photos/Mushrooms_White_Hero.jpg	2.3	veggies	\N
60	hazelnuts	https://image.made-in-china.com/2f0j00GVORTZeKLNoM/Blanched-Roasted-Hazelnuts-Toasted-Hazelnut-Kernels-Inshell-Organic-Hazel-Nuts.jpg	2	nuts	\N
77	beef	https://spoonacular.com/cdn/ingredients_250x250/beef-cubes-raw.png	0	healthy fats	\N
89	monk fruit	https://images-na.ssl-images-amazon.com/images/I/81Sv8evUcJL._SL1500_.jpg	0	sweetener	\N
90	stevia	https://images-na.ssl-images-amazon.com/images/I/610sJ%2BpVB8L._SX425_.jpg	0	sweetener	\N
91	erythritol	https://images-na.ssl-images-amazon.com/images/I/91SjiTdl7LL._SL1500_.jpg	0	sweetener	\N
92	xylitol	https://focusnutrition.com/wp-content/uploads/2019/06/xylitol-2.jpg	4	sweetener	\N
93	chicory root	https://images-na.ssl-images-amazon.com/images/I/71vUAdCXh6L._SL1500_.jpg	5	sweetener	\N
40	carrots	https://www.producemarketguide.com/sites/default/files/Commodities.tar/Commodities/carrots_commodity-page.png	6.8	veggies	\N
37	portabella	https://www.freshdirect.com/media/images/product/vegetables/mushrooms/msh_pkg_portocaps_z.jpg?lastModify=2013-09-25	2.6	veggies	\N
\.


--
-- Data for Name: recipe_has_nutrients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recipe_has_nutrients (id, recipe_id, nutrient_id, total_daily, total_nutrients) FROM stdin;
6	6	2	223	145
7	6	43	225	45
8	6	40	7	22
9	6	11	26	6
10	6	14	124	62
11	6	7	102	308
12	6	8	54	1307
13	6	16	22	223
14	6	17	36	153
15	6	18	31	1462
16	6	22	20	3
17	6	20	36	4
18	6	21	125	878
19	6	23	66	596
20	6	32	47	42
21	6	45	75	0
22	6	46	48	0
23	6	47	136	21
24	6	30	141	1
25	6	49	30	120
26	6	31	335	8
27	6	33	6	0
28	6	34	67	10
29	6	35	164	197
30	7	2	167	108
31	7	43	420	84
32	7	40	16	49
33	7	11	54	13
34	7	14	51	25
35	7	7	0	1
36	7	8	9	232
37	7	16	28	283
38	7	17	88	372
39	7	18	30	1450
40	7	22	123	22
41	7	20	55	6
42	7	21	134	940
43	7	23	0	1
44	7	32	4	4
45	7	45	23	0
46	7	46	8	0
47	7	47	32	5
48	7	30	12	0
49	7	49	27	110
50	7	31	5	0
51	7	33	0	0
52	7	34	2	0
53	7	35	3	3
54	8	2	306	199
55	8	43	107	21
56	8	40	35	105
57	8	11	167	41
58	8	14	277	138
59	8	7	372	1116
60	8	8	77	1860
61	8	16	49	499
62	8	17	17	74
63	8	18	82	3893
64	8	22	82	14
65	8	20	64	7
66	8	21	396	2772
67	8	23	53	484
68	8	32	24	22
69	8	45	25	0
70	8	46	116	1
71	8	47	11	1
72	8	30	51	0
73	8	49	69	278
74	8	31	111	2
75	8	33	40	6
76	8	34	26	4
77	8	35	24	29
78	9	2	94	61
79	9	43	74	14
80	9	40	2	7
81	9	11	7	1
82	9	14	36	18
83	9	7	16	50
84	9	8	27	656
85	9	16	24	249
86	9	17	20	87
87	9	18	8	403
88	9	22	12	2
89	9	20	26	2
90	9	21	53	375
91	9	23	28	255
92	9	32	6	5
93	9	45	24	0
94	9	46	16	0
95	9	47	23	3
96	9	30	19	0
97	9	49	7	31
98	9	31	21	0
99	9	33	2	0
100	9	34	28	4
101	9	35	98	118
102	10	2	88	57
103	10	43	224	44
104	10	40	12	37
105	10	11	76	19
106	10	14	78	39
107	10	7	124	372
108	10	8	47	1145
109	10	16	9	90
110	10	17	18	78
111	10	18	25	1218
112	10	22	47	8
113	10	20	18	2
114	10	21	48	336
115	10	23	17	160
116	10	32	1	0
117	10	45	7	0
118	10	46	102	1
119	10	47	5	0
120	10	30	23	0
121	10	49	17	69
122	10	31	44	1
123	10	33	13	2
124	10	34	7	1
125	10	35	0	0
126	11	2	157	102
127	11	43	122	24
128	11	40	128	384
129	11	11	50	12
130	11	14	84	42
131	11	7	101	305
132	11	8	185	4445
133	11	16	85	850
134	11	17	61	256
135	11	18	39	1847
136	11	22	138	24
137	11	20	47	5
138	11	21	224	1574
139	11	23	20	188
140	11	32	0	0
141	11	45	77	0
142	11	46	92	1
143	11	47	52	8
144	11	30	22	0
145	11	49	133	534
146	11	31	29	0
147	11	33	10	1
148	11	34	51	7
149	11	35	20	24
150	12	2	120	78
151	12	43	218	43
152	12	40	10	31
153	12	11	15	3
154	12	14	29	14
155	12	7	83	249
156	12	8	42	1015
157	12	16	23	239
158	12	17	7	30
159	12	18	9	432
160	12	22	7	1
161	12	20	12	1
162	12	21	36	258
163	12	23	92	834
164	12	32	15	14
165	12	45	8	0
166	12	46	26	0
167	12	47	6	0
168	12	30	12	0
169	12	49	8	33
170	12	31	23	0
171	12	33	9	1
172	12	34	10	1
173	12	35	29	35
174	13	2	97	63
175	13	43	134	26
176	13	40	18	55
177	13	11	29	7
178	13	14	73	36
179	13	7	141	424
180	13	8	44	1078
181	13	16	55	555
182	13	17	19	80
183	13	18	22	1080
184	13	22	39	7
185	13	20	41	4
186	13	21	100	703
187	13	23	45	411
188	13	32	6	6
189	13	45	61	0
190	13	46	112	1
191	13	47	86	13
192	13	30	41	0
193	13	49	63	253
194	13	31	58	1
195	13	33	17	2
196	13	34	14	2
197	13	35	72	87
198	14	2	542	352
199	14	43	692	138
200	14	40	16	49
201	14	11	93	23
202	14	14	237	118
203	14	7	433	1300
204	14	8	80	1923
205	14	16	116	1165
206	14	17	17	74
207	14	18	48	2300
208	14	22	38	6
209	14	20	73	8
210	14	21	332	2328
211	14	23	199	1791
212	14	32	0	0
213	14	45	37	0
214	14	46	120	1
215	14	47	30	4
216	14	30	58	0
217	14	49	32	129
218	14	31	151	3
219	14	33	51	7
220	14	34	49	7
221	14	35	13	15
222	15	2	240	156
223	15	43	277	55
224	15	40	13	41
225	15	11	37	9
226	15	14	368	184
227	15	7	390	1171
228	15	8	141	3390
229	15	16	22	227
230	15	17	61	257
231	15	18	81	3852
232	15	22	60	10
233	15	20	123	13
234	15	21	203	1425
235	15	23	50	452
236	15	32	43	39
237	15	45	57	0
238	15	46	102	1
239	15	47	390	62
240	15	30	444	5
241	15	49	24	97
242	15	31	106	2
243	15	33	9	1
244	15	34	100	15
245	15	35	56	68
246	16	2	101	65
247	16	43	41	8
248	16	40	13	39
249	16	11	93	23
250	16	14	67	33
251	16	7	53	159
252	16	8	24	588
253	16	16	44	443
254	16	17	1	7
255	16	18	19	901
256	16	22	14	2
257	16	20	5	0
258	16	21	155	1089
259	16	23	7	68
260	16	32	0	0
261	16	45	1	0
262	16	46	15	0
263	16	47	0	0
264	16	30	5	0
265	16	49	5	20
266	16	31	15	0
267	16	33	5	0
268	16	34	3	0
269	16	35	0	0
270	17	2	160	104
271	17	43	232	46
272	17	40	10	30
273	17	11	52	13
274	17	14	200	100
275	17	7	99	299
276	17	8	120	2900
277	17	16	24	248
278	17	17	53	223
279	17	18	51	2411
280	17	22	35	6
281	17	20	27	3
282	17	21	180	1263
283	17	23	27	246
284	17	32	53	48
285	17	45	98	1
286	17	46	77	1
287	17	47	258	41
288	17	30	256	3
289	17	49	52	208
290	17	31	613	14
291	17	33	1	0
292	17	34	133	20
293	17	35	60	72
294	18	2	247	160
295	18	43	400	80
296	18	40	22	68
297	18	11	81	20
298	18	14	313	156
299	18	7	124	374
300	18	8	153	3691
301	18	16	36	366
302	18	17	93	391
303	18	18	103	4882
304	18	22	104	18
305	18	20	52	5
306	18	21	301	2111
307	18	23	8	74
308	18	32	413	372
309	18	45	150	1
310	18	46	119	1
311	18	47	394	63
312	18	30	418	5
313	18	49	124	498
314	18	31	915	21
315	18	33	0	0
316	18	34	180	27
317	18	35	238	286
318	19	2	92	59
319	19	43	108	21
320	19	40	7	21
321	19	11	58	14
322	19	14	71	35
323	19	7	88	265
324	19	8	42	1012
325	19	16	18	182
326	19	17	9	38
327	19	18	11	537
328	19	22	28	5
329	19	20	12	1
330	19	21	58	412
331	19	23	35	321
332	19	32	2	2
333	19	45	4	0
334	19	46	28	0
335	19	47	19	3
336	19	30	22	0
337	19	49	10	43
338	19	31	105	2
339	19	33	76	11
340	19	34	10	1
341	19	35	22	26
342	20	2	246	160
343	20	43	197	39
344	20	40	2	6
345	20	11	2	0
346	20	14	1031	515
347	20	7	370	1110
348	20	8	48	1159
349	20	16	98	988
350	20	17	179	755
351	20	18	217	10208
352	20	22	84	15
353	20	20	92	10
354	20	21	903	6326
355	20	23	121	1093
356	20	32	28	25
357	20	45	227	2
358	20	46	266	3
359	20	47	1075	172
360	20	30	1012	13
361	20	49	56	227
362	20	31	4137	99
363	20	33	1427	214
364	20	34	118	17
365	20	35	33	40
366	21	2	124	80
367	21	43	184	36
368	21	40	16	50
369	21	11	69	17
370	21	14	101	50
371	21	7	73	219
372	21	8	108	2608
373	21	16	35	358
374	21	17	45	189
375	21	18	61	2885
376	21	22	31	5
377	21	20	36	4
378	21	21	110	771
379	21	23	79	715
380	21	32	269	242
381	21	45	38	0
382	21	46	72	0
383	21	47	73	11
384	21	30	131	1
385	21	49	100	403
386	21	31	210	5
387	21	33	168	25
388	21	34	33	5
389	21	35	121	146
390	22	2	30	19
391	22	43	52	10
392	22	40	1	3
393	22	11	0	0
394	22	14	38	19
395	22	7	21	65
396	22	8	64	1541
397	22	16	26	268
398	22	17	5	22
399	22	18	3	168
400	22	22	8	1
401	22	20	7	0
402	22	21	37	261
403	22	23	20	185
404	22	32	0	0
405	22	45	5	0
406	22	46	13	0
407	22	47	18	2
408	22	30	14	0
409	22	49	2	11
410	22	31	90	2
411	22	33	2	0
412	22	34	0	0
413	22	35	1	1
414	23	2	101	65
415	23	43	175	35
416	23	40	13	39
417	23	11	44	11
418	23	14	125	62
419	23	7	42	127
420	23	8	132	3187
421	23	16	23	232
422	23	17	75	318
423	23	18	80	3801
424	23	22	58	10
425	23	20	46	5
426	23	21	154	1083
427	23	23	13	123
428	23	32	209	188
429	23	45	81	0
430	23	46	99	1
431	23	47	159	25
432	23	30	241	3
433	23	49	81	324
434	23	31	305	7
435	23	33	0	0
436	23	34	65	9
437	23	35	37	45
438	24	2	454	295
439	24	43	499	99
440	24	40	3	10
441	24	11	23	5
442	24	14	652	326
443	24	7	362	1086
444	24	8	39	950
445	24	16	26	264
446	24	17	112	472
447	24	18	127	5990
448	24	22	42	7
449	24	20	57	6
450	24	21	553	3877
451	24	23	76	685
452	24	32	77	69
453	24	45	276	3
454	24	46	194	2
455	24	47	860	137
456	24	30	776	10
457	24	49	104	417
458	24	31	2138	51
459	24	33	10	1
460	24	34	390	58
461	24	35	19	23
462	25	2	113	73
463	25	43	149	29
464	25	40	0	2
465	25	11	1	0
466	25	14	178	89
467	25	7	132	398
468	25	8	32	786
469	25	16	50	505
470	25	17	27	117
471	25	18	29	1370
472	25	22	14	2
473	25	20	26	2
474	25	21	168	1182
475	25	23	17	157
476	25	32	15	13
477	25	45	62	0
478	25	46	68	0
479	25	47	185	29
480	25	30	177	2
481	25	49	29	116
482	25	31	494	11
483	25	33	7	1
484	25	34	85	12
485	25	35	7	9
486	26	2	93	60
487	26	43	131	26
488	26	40	4	12
489	26	11	23	5
490	26	14	67	33
491	26	7	223	670
492	26	8	38	931
493	26	16	18	186
494	26	17	14	62
495	26	18	17	820
496	26	22	22	4
497	26	20	27	3
498	26	21	71	499
499	26	23	67	610
500	26	32	15	13
501	26	45	12	0
502	26	46	72	0
503	26	47	24	3
504	26	30	48	0
505	26	49	38	155
506	26	31	131	3
507	26	33	80	12
508	26	34	29	4
509	26	35	53	64
510	27	2	397	258
511	27	43	877	175
512	27	40	19	59
513	27	11	68	17
514	27	14	231	115
515	27	7	189	569
516	27	8	68	1644
517	27	16	49	493
518	27	17	92	389
519	27	18	78	3681
520	27	22	69	12
521	27	20	50	5
522	27	21	218	1529
523	27	23	126	1140
524	27	32	101	91
525	27	45	102	1
526	27	46	126	1
527	27	47	263	42
528	27	30	284	3
529	27	49	165	662
530	27	31	642	15
531	27	33	11	1
532	27	34	154	23
533	27	35	855	1026
534	28	2	452	293
535	28	43	762	152
536	28	40	15	47
537	28	11	53	13
538	28	14	479	239
539	28	7	646	1939
540	28	8	173	4162
541	28	16	174	1747
542	28	17	117	494
543	28	18	105	4973
544	28	22	75	13
545	28	20	130	14
546	28	21	518	3626
547	28	23	296	2665
548	28	32	278	250
549	28	45	111	1
550	28	46	265	3
551	28	47	341	54
552	28	30	375	4
553	28	49	141	566
554	28	31	1477	35
555	28	33	262	39
556	28	34	142	21
557	28	35	494	593
558	29	2	332	216
559	29	43	374	74
560	29	40	21	65
561	29	11	86	21
562	29	14	308	154
563	29	7	165	497
564	29	8	124	2988
565	29	16	118	1188
566	29	17	87	367
567	29	18	96	4552
568	29	22	64	11
569	29	20	51	5
570	29	21	387	2712
571	29	23	191	1725
572	29	32	106	95
573	29	45	116	1
574	29	46	185	2
575	29	47	292	46
576	29	30	286	3
577	29	49	151	606
578	29	31	657	15
579	29	33	11	1
580	29	34	159	23
581	29	35	929	1115
582	30	2	355	230
583	30	43	654	130
584	30	40	12	36
585	30	11	34	8
586	30	14	205	102
587	30	7	240	720
588	30	8	144	3473
589	30	16	263	2633
590	30	17	45	189
591	30	18	32	1538
592	30	22	19	3
593	30	20	129	14
594	30	21	291	2041
595	30	23	223	2014
596	30	32	277	249
597	30	45	43	0
598	30	46	163	2
599	30	47	28	4
600	30	30	76	0
601	30	49	68	274
602	30	31	154	3
603	30	33	26	4
604	30	34	51	7
605	30	35	259	311
606	31	2	389	253
607	31	43	676	135
608	31	40	25	76
609	31	11	47	11
610	31	14	263	131
611	31	7	250	751
612	31	8	172	4128
613	31	16	308	3084
614	31	17	63	265
615	31	18	54	2564
616	31	22	34	6
617	31	20	156	17
618	31	21	362	2536
619	31	23	237	2141
620	31	32	369	332
621	31	45	62	0
622	31	46	235	3
623	31	47	90	14
624	31	30	117	1
625	31	49	97	391
626	31	31	163	3
627	31	33	26	4
628	31	34	60	9
629	31	35	332	399
630	32	2	115	75
631	32	43	54	10
632	32	40	9	29
633	32	11	42	10
634	32	14	22	11
635	32	7	10	30
636	32	8	48	1158
637	32	16	24	246
638	32	17	22	95
639	32	18	26	1229
640	32	22	22	4
641	32	20	15	1
642	32	21	38	271
643	32	23	12	113
644	32	32	361	325
645	32	45	24	0
646	32	46	34	0
647	32	47	15	2
648	32	30	51	0
649	32	49	57	230
650	32	31	0	0
651	32	33	0	0
652	32	34	32	4
653	32	35	316	379
654	33	2	515	335
655	33	43	935	187
656	33	40	26	79
657	33	11	4	1
658	33	14	368	184
659	33	7	337	1012
660	33	8	221	5319
661	33	16	413	4131
662	33	17	78	328
663	33	18	67	3161
664	33	22	40	7
665	33	20	217	23
666	33	21	491	3439
667	33	23	351	3167
668	33	32	421	379
669	33	45	91	1
670	33	46	297	3
671	33	47	135	21
672	33	30	147	1
673	33	49	117	471
674	33	31	320	7
675	33	33	37	5
676	33	34	51	7
677	33	35	41	49
678	34	2	285	185
679	34	43	263	52
680	34	40	22	67
681	34	11	123	30
682	34	14	215	107
683	34	7	277	833
684	34	8	92	2213
685	34	16	167	1673
686	34	17	33	142
687	34	18	62	2914
688	34	22	53	9
689	34	20	74	8
690	34	21	342	2396
691	34	23	101	915
692	34	32	303	273
693	34	45	32	0
694	34	46	136	1
695	34	47	15	2
696	34	30	75	0
697	34	49	80	321
698	34	31	113	2
699	34	33	30	4
700	34	34	56	8
701	34	35	306	367
702	35	2	152	99
703	35	43	124	24
704	35	40	16	48
705	35	11	68	17
706	35	14	208	104
707	35	7	163	490
708	35	8	113	2721
709	35	16	35	359
710	35	17	57	240
711	35	18	65	3100
712	35	22	51	9
713	35	20	84	9
714	35	21	178	1252
715	35	23	33	304
716	35	32	605	545
717	35	45	69	0
718	35	46	115	1
719	35	47	178	28
720	35	30	230	2
721	35	49	101	405
722	35	31	129	3
723	35	33	3	0
724	35	34	40	6
725	35	35	529	635
726	36	2	891	579
727	36	43	871	174
728	36	40	33	101
729	36	11	130	32
730	36	14	744	372
731	36	7	554	1663
732	36	8	181	4355
733	36	16	243	2431
734	36	17	153	646
735	36	18	151	7117
736	36	22	136	24
737	36	20	299	32
738	36	21	599	4199
739	36	23	249	2248
740	36	32	1234	1111
741	36	45	156	1
742	36	46	338	4
743	36	47	689	110
744	36	30	584	7
745	36	49	230	922
746	36	31	288	6
747	36	33	36	5
748	36	34	116	17
749	36	35	1061	1273
750	37	2	357	232
751	37	43	697	139
752	37	40	14	44
753	37	11	44	11
754	37	14	167	83
755	37	7	247	743
756	37	8	288	6916
757	37	16	220	2206
758	37	17	45	192
759	37	18	38	1794
760	37	22	21	3
761	37	20	104	11
762	37	21	247	1735
763	37	23	250	2257
764	37	32	408	367
765	37	45	39	0
766	37	46	153	1
767	37	47	22	3
768	37	30	73	0
769	37	49	86	346
770	37	31	122	2
771	37	33	28	4
772	37	34	61	9
773	37	35	363	435
774	38	2	503	327
775	38	43	719	143
776	38	40	52	158
777	38	11	98	24
778	38	14	350	175
779	38	7	296	888
780	38	8	131	3148
781	38	16	53	530
782	38	17	100	423
783	38	18	122	5778
784	38	22	157	28
785	38	20	376	41
786	38	21	282	1978
787	38	23	641	5776
788	38	32	76	68
789	38	45	87	1
790	38	46	155	2
791	38	47	283	45
792	38	30	363	4
793	38	49	52	209
794	38	31	816	19
795	38	33	17	2
796	38	34	93	14
797	38	35	98	118
798	39	2	66	42
799	39	43	53	10
800	39	40	9	29
801	39	11	24	6
802	39	14	111	55
803	39	7	51	154
804	39	8	58	1409
805	39	16	17	178
806	39	17	24	103
807	39	18	33	1597
808	39	22	29	5
809	39	20	88	9
810	39	21	87	611
811	39	23	7	70
812	39	32	226	203
813	39	45	26	0
814	39	46	40	0
815	39	47	109	17
816	39	30	135	1
817	39	49	43	172
818	39	31	111	2
819	39	33	1	0
820	39	34	17	2
821	39	35	195	234
822	40	2	204	132
823	40	43	265	53
824	40	40	26	79
825	40	11	98	24
826	40	14	211	105
827	40	7	127	383
828	40	8	146	3526
829	40	16	50	507
830	40	17	75	315
831	40	18	92	4328
832	40	22	97	17
833	40	20	329	36
834	40	21	197	1379
835	40	23	54	492
836	40	32	906	816
837	40	45	85	1
838	40	46	142	1
839	40	47	134	21
840	40	30	239	3
841	40	49	149	599
842	40	31	551	13
843	40	33	5	0
844	40	34	58	8
845	40	35	783	940
846	41	2	88	57
847	41	43	94	18
848	41	40	2	8
849	41	11	12	3
850	41	14	49	24
851	41	7	132	397
852	41	8	30	720
853	41	16	9	90
854	41	17	9	41
855	41	18	15	737
856	41	22	13	2
857	41	20	26	2
858	41	21	55	391
859	41	23	24	222
860	41	32	39	35
861	41	45	30	0
862	41	46	57	0
863	41	47	36	5
864	41	30	43	0
865	41	49	24	97
866	41	31	52	1
867	41	33	14	2
868	41	34	19	2
869	41	35	39	47
870	42	2	39	25
871	42	43	14	2
872	42	40	23	71
873	42	11	108	27
874	42	14	55	27
875	42	7	0	0
876	42	8	114	2741
877	42	16	38	386
878	42	17	63	264
879	42	18	66	3134
880	42	22	59	10
881	42	20	44	4
882	42	21	126	884
883	42	23	18	167
884	42	32	482	434
885	42	45	50	0
886	42	46	63	0
887	42	47	55	8
888	42	30	103	1
889	42	49	116	467
890	42	31	0	0
891	42	33	0	0
892	42	34	88	13
893	42	35	410	492
894	43	2	613	398
895	43	43	990	198
896	43	40	42	126
897	43	11	87	21
898	43	14	356	178
899	43	7	350	1051
900	43	8	264	6351
901	43	16	353	3534
902	43	17	112	474
903	43	18	108	5082
904	43	22	102	18
905	43	20	179	19
906	43	21	473	3315
907	43	23	379	3412
908	43	32	594	535
909	43	45	128	1
910	43	46	251	3
911	43	47	151	24
912	43	30	199	2
913	43	49	134	539
914	43	31	259	6
915	43	33	40	6
916	43	34	40	6
917	43	35	135	162
918	44	2	54	35
919	44	43	17	3
920	44	40	6	18
921	44	11	36	9
922	44	14	58	29
923	44	7	14	42
924	44	8	3	78
925	44	16	25	252
926	44	17	46	193
927	44	18	19	915
928	44	22	20	3
929	44	20	28	3
930	44	21	66	465
931	44	23	5	45
932	44	32	109	98
933	44	45	13	0
934	44	46	58	0
935	44	47	44	7
936	44	30	38	0
937	44	49	25	100
938	44	31	6	0
939	44	33	0	0
940	44	34	98	14
941	44	35	104	124
942	45	2	534	347
943	45	43	968	193
944	45	40	64	192
945	45	11	248	62
946	45	14	232	116
947	45	7	371	1115
948	45	8	304	7298
949	45	16	214	2149
950	45	17	132	558
951	45	18	175	8226
952	45	22	91	16
953	45	20	140	15
954	45	21	357	2501
955	45	23	424	3818
956	45	32	1842	1658
957	45	45	158	1
958	45	46	331	4
959	45	47	168	26
960	45	30	344	4
961	45	49	355	1420
962	45	31	94	2
963	45	33	37	5
964	45	34	180	27
965	45	35	1602	1923
966	46	2	316	205
967	46	43	146	29
968	46	40	18	54
969	46	11	85	21
970	46	14	57	28
971	46	7	34	103
972	46	8	70	1690
973	46	16	41	413
974	46	17	59	250
975	46	18	47	2246
976	46	22	34	6
977	46	20	38	4
978	46	21	91	642
979	46	23	18	170
980	46	32	547	493
981	46	45	43	0
982	46	46	93	1
983	46	47	36	5
984	46	30	88	1
985	46	49	94	379
986	46	31	7	0
987	46	33	0	0
988	46	34	107	16
989	46	35	462	555
990	47	2	746	485
991	47	43	1453	290
992	47	40	252	758
993	47	11	102	25
994	47	14	532	266
995	47	7	482	1448
996	47	8	195	4680
997	47	16	548	5483
998	47	17	126	532
999	47	18	86	4067
1000	47	22	71	12
1001	47	20	299	32
1002	47	21	733	5135
1003	47	23	437	3934
1004	47	32	96	86
1005	47	45	158	1
1006	47	46	418	5
1007	47	47	81	13
1008	47	30	116	1
1009	47	49	115	462
1010	47	31	449	10
1011	47	33	56	8
1012	47	34	92	13
1013	47	35	106	128
1014	48	2	141	91
1015	48	43	237	47
1016	48	40	14	43
1017	48	11	43	10
1018	48	14	161	80
1019	48	7	115	346
1020	48	8	156	3748
1021	48	16	120	1200
1022	48	17	37	157
1023	48	18	43	2062
1024	48	22	30	5
1025	48	20	89	9
1026	48	21	186	1305
1027	48	23	73	664
1028	48	32	239	215
1029	48	45	148	1
1030	48	46	136	1
1031	48	47	72	11
1032	48	30	108	1
1033	48	49	60	240
1034	48	31	96	2
1035	48	33	19	2
1036	48	34	29	4
1037	48	35	198	238
1758	79	2	94	61
1759	79	43	172	34
1760	79	40	52	158
1761	79	11	99	24
1762	79	14	56	28
1763	79	7	190	571
1764	79	8	42	1022
1765	79	16	38	389
1766	79	17	14	62
1767	79	18	14	681
1768	79	22	21	3
1769	79	20	31	3
1770	79	21	48	339
1771	79	23	55	499
1772	79	32	73	66
1773	79	45	19	0
1774	79	46	156	2
1775	79	47	3	0
1776	79	30	27	0
1777	79	49	21	84
1778	79	31	50	1
1779	79	33	21	3
1780	79	34	35	5
1781	79	35	6	7
1782	80	2	46	30
1783	80	43	49	9
1784	80	40	2	8
1785	80	11	12	3
1786	80	14	25	12
1787	80	7	72	216
1788	80	8	6	167
1789	80	16	26	267
1790	80	17	1	7
1791	80	18	16	781
1792	80	22	8	1
1793	80	20	6	0
1794	80	21	82	578
1795	80	23	19	177
1796	80	32	0	0
1797	80	45	1	0
1798	80	46	17	0
1799	80	47	0	0
1800	80	30	6	0
1801	80	49	5	23
1802	80	31	19	0
1803	80	33	8	1
1804	80	34	5	0
1805	80	35	0	1
1907	85	7	276	828
1908	85	8	46	1107
1909	85	16	69	698
1910	85	17	8	34
1911	85	18	8	383
1912	85	22	25	4
1913	85	20	26	2
1914	85	21	164	1152
1915	85	23	66	594
1916	85	32	0	0
1917	85	45	8	0
1918	85	46	77	1
1919	85	47	1	0
1920	85	30	28	0
1921	85	49	25	101
1922	85	31	81	1
1923	85	33	29	4
1924	85	34	16	2
1925	85	35	2	2
1806	81	2	195	127
1807	81	43	378	75
1808	81	40	23	71
1809	81	11	41	10
1810	81	14	68	34
1811	81	7	357	1073
1812	81	8	31	760
1813	81	16	54	540
1814	81	17	8	35
1815	81	18	8	395
1816	81	22	24	4
1817	81	20	27	3
1818	81	21	135	950
1819	81	23	135	1219
1820	81	32	0	0
1821	81	45	9	0
1822	81	46	85	1
1823	81	47	1	0
1824	81	30	29	0
1825	81	49	26	107
1826	81	31	97	2
1827	81	33	45	6
1828	81	34	34	5
1829	81	35	7	9
1854	83	2	36	23
1855	83	43	26	5
1856	83	40	34	103
1857	83	11	95	23
1858	83	14	405	202
1859	83	7	53	159
1860	83	8	126	3030
1861	83	16	99	998
1862	83	17	56	235
1863	83	18	71	3370
1864	83	22	243	43
1865	83	20	218	23
1866	83	21	722	5055
1867	83	23	7	68
1868	83	32	0	0
1869	83	45	86	1
1870	83	46	59	0
1871	83	47	52	8
1872	83	30	50	0
1873	83	49	261	1045
1874	83	31	15	0
1875	83	33	5	0
1876	83	34	3	0
1877	83	35	0	0
1902	85	2	74	48
1903	85	43	124	24
1904	85	40	8	24
1905	85	11	42	10
1906	85	14	66	33
1158	54	2	312	202
1159	54	43	428	85
1160	54	40	15	46
1161	54	11	80	20
1162	54	14	98	49
1163	54	7	214	642
1164	54	8	28	679
1165	54	16	65	653
1166	54	17	24	102
1167	54	18	35	1687
1168	54	22	33	5
1169	54	20	41	4
1170	54	21	214	1499
1171	54	23	190	1715
1172	54	32	9	8
1173	54	45	40	0
1174	54	46	65	0
1175	54	47	12	1
1176	54	30	40	0
1177	54	49	24	99
1178	54	31	56	1
1179	54	33	22	3
1180	54	34	27	4
1181	54	35	18	22
1182	55	2	364	236
1183	55	43	641	128
1184	55	40	48	144
1185	55	11	0	0
1186	55	14	139	69
1187	55	7	590	1771
1188	55	8	100	2404
1189	55	16	70	707
1190	55	17	20	87
1191	55	18	30	1446
1192	55	22	41	7
1193	55	20	60	6
1194	55	21	167	1175
1195	55	23	294	2652
1196	55	32	0	0
1197	55	45	19	0
1198	55	46	159	2
1199	55	47	6	1
1200	55	30	54	0
1201	55	49	50	201
1202	55	31	169	4
1203	55	33	64	9
1204	55	34	35	5
1205	55	35	15	18
1206	56	2	47	30
1207	56	43	89	17
1208	56	40	29	87
1209	56	11	33	8
1210	56	14	39	19
1211	56	7	82	247
1212	56	8	19	457
1213	56	16	23	233
1214	56	17	19	83
1215	56	18	7	347
1216	56	22	21	3
1217	56	20	19	2
1218	56	21	74	521
1219	56	23	30	274
1220	56	32	0	0
1221	56	45	12	0
1222	56	46	23	0
1223	56	47	9	1
1224	56	30	10	0
1225	56	49	13	53
1226	56	31	20	0
1227	56	33	9	1
1228	56	34	8	1
1229	56	35	2	2
1230	57	2	108	70
1231	57	43	210	42
1232	57	40	19	58
1233	57	11	62	15
1234	57	14	33	16
1235	57	7	54	163
1236	57	8	7	180
1237	57	16	11	112
1238	57	17	65	276
1239	57	18	19	938
1240	57	22	79	14
1241	57	20	39	4
1242	57	21	66	468
1243	57	23	7	71
1244	57	32	0	0
1245	57	45	4	0
1246	57	46	23	0
1247	57	47	12	2
1248	57	30	8	0
1249	57	49	5	20
1250	57	31	29	0
1251	57	33	5	0
1252	57	34	7	1
1253	57	35	7	8
1254	58	2	56	36
1255	58	43	90	18
1256	58	40	4	14
1257	58	11	28	7
1258	58	14	25	12
1259	58	7	82	247
1260	58	8	18	447
1261	58	16	22	227
1262	58	17	14	61
1263	58	18	7	344
1264	58	22	15	2
1265	58	20	12	1
1266	58	21	68	479
1267	58	23	30	274
1268	58	32	0	0
1269	58	45	2	0
1270	58	46	20	0
1271	58	47	1	0
1272	58	30	7	0
1273	58	49	6	27
1274	58	31	20	0
1275	58	33	9	1
1276	58	34	7	1
1277	58	35	2	2
1278	59	2	67	44
1279	59	43	94	18
1280	59	40	11	34
1281	59	11	9	2
1282	59	14	26	13
1283	59	7	82	247
1284	59	8	7	170
1285	59	16	14	143
1286	59	17	8	36
1287	59	18	6	283
1288	59	22	8	1
1289	59	20	10	1
1290	59	21	49	347
1291	59	23	30	276
1292	59	32	0	0
1293	59	45	4	0
1294	59	46	21	0
1295	59	47	13	2
1296	59	30	12	0
1297	59	49	9	38
1298	59	31	21	0
1299	59	33	9	1
1300	59	34	17	2
1301	59	35	1	2
1302	60	2	67	43
1303	60	43	119	23
1304	60	40	13	39
1305	60	11	42	10
1306	60	14	27	13
1307	60	7	78	235
1308	60	8	4	117
1309	60	16	9	95
1310	60	17	15	63
1311	60	18	7	356
1312	60	22	14	2
1313	60	20	12	1
1314	60	21	35	249
1315	60	23	33	305
1316	60	32	0	0
1317	60	45	3	0
1318	60	46	21	0
1319	60	47	2	0
1320	60	30	7	0
1321	60	49	6	26
1322	60	31	20	0
1323	60	33	9	1
1324	60	34	8	1
1325	60	35	2	2
1326	61	2	29	19
1327	61	43	56	11
1328	61	40	4	12
1329	61	11	28	7
1330	61	14	19	9
1331	61	7	72	216
1332	61	8	11	284
1333	61	16	20	207
1334	61	17	8	34
1335	61	18	3	154
1336	61	22	10	1
1337	61	20	9	1
1338	61	21	52	370
1339	61	23	19	177
1340	61	32	0	0
1341	61	45	2	0
1342	61	46	18	0
1343	61	47	1	0
1344	61	30	7	0
1345	61	49	6	25
1346	61	31	19	0
1347	61	33	8	1
1348	61	34	5	0
1349	61	35	1	1
1350	62	2	53	34
1351	62	43	29	5
1352	62	40	27	81
1353	62	11	21	5
1354	62	14	35	17
1355	62	7	62	186
1356	62	8	7	178
1357	62	16	12	128
1358	62	17	6	28
1359	62	18	3	179
1360	62	22	12	2
1361	62	20	12	1
1362	62	21	45	321
1363	62	23	8	80
1364	62	32	1	1
1365	62	45	11	0
1366	62	46	20	0
1367	62	47	8	1
1368	62	30	10	0
1369	62	49	12	49
1370	62	31	18	0
1371	62	33	6	1
1372	62	34	3	0
1373	62	35	0	0
1374	63	2	112	72
1375	63	43	204	40
1376	63	40	5	16
1377	63	11	26	6
1378	63	14	34	17
1379	63	7	94	284
1380	63	8	26	642
1381	63	16	11	113
1382	63	17	45	190
1383	63	18	17	839
1384	63	22	39	7
1385	63	20	37	4
1386	63	21	45	316
1387	63	23	50	458
1388	63	32	0	0
1389	63	45	15	0
1390	63	46	37	0
1391	63	47	8	1
1392	63	30	13	0
1393	63	49	25	102
1394	63	31	19	0
1395	63	33	11	1
1396	63	34	15	2
1397	63	35	17	21
1398	64	2	117	76
1399	64	43	288	57
1400	64	40	4	14
1401	64	11	13	3
1402	64	14	16	8
1403	64	7	123	369
1404	64	8	1	27
1405	64	16	7	70
1406	64	17	18	77
1407	64	18	7	367
1408	64	22	25	4
1409	64	20	16	1
1410	64	21	33	232
1411	64	23	14	130
1412	64	32	0	0
1413	64	45	8	0
1414	64	46	29	0
1415	64	47	4	0
1416	64	30	10	0
1417	64	49	13	54
1418	64	31	31	0
1419	64	33	12	1
1420	64	34	7	1
1421	64	35	2	2
1422	65	2	200	130
1423	65	43	392	78
1424	65	40	26	78
1425	65	11	12	3
1426	65	14	45	22
1427	65	7	246	740
1428	65	8	11	273
1429	65	16	22	229
1430	65	17	4	18
1431	65	18	4	211
1432	65	22	20	3
1433	65	20	16	1
1434	65	21	40	282
1435	65	23	109	982
1436	65	32	0	0
1437	65	45	4	0
1438	65	46	48	0
1439	65	47	1	0
1440	65	30	17	0
1441	65	49	16	64
1442	65	31	55	1
1443	65	33	28	4
1444	65	34	26	3
1445	65	35	6	8
1446	66	2	213	138
1447	66	43	139	27
1448	66	40	22	68
1449	66	11	91	22
1450	66	14	104	52
1451	66	7	218	656
1452	66	8	48	1171
1453	66	16	131	1312
1454	66	17	112	470
1455	66	18	33	1570
1456	66	22	84	15
1457	66	20	71	7
1458	66	21	318	2232
1459	66	23	31	285
1460	66	32	10	9
1461	66	45	30	0
1462	66	46	173	2
1463	66	47	34	5
1464	66	30	41	0
1465	66	49	35	141
1466	66	31	71	1
1467	66	33	23	3
1468	66	34	261	39
1469	66	35	39	47
1470	67	2	210	137
1471	67	43	424	84
1472	67	40	8	25
1473	67	11	12	3
1474	67	14	19	9
1475	67	7	153	459
1476	67	8	5	136
1477	67	16	25	258
1478	67	17	21	89
1479	67	18	10	500
1480	67	22	19	3
1481	67	20	16	1
1482	67	21	43	307
1483	67	23	145	1312
1484	67	32	2	2
1485	67	45	7	0
1486	67	46	33	0
1487	67	47	2	0
1488	67	30	8	0
1489	67	49	3	14
1490	67	31	31	0
1491	67	33	15	2
1492	67	34	24	3
1493	67	35	10	12
1494	68	2	212	138
1495	68	43	206	41
1496	68	40	31	93
1497	68	11	237	59
1498	68	14	127	63
1499	68	7	1	4
1500	68	8	16	387
1501	68	16	67	673
1502	68	17	254	1068
1503	68	18	40	1901
1504	68	22	163	29
1505	68	20	150	16
1506	68	21	373	2613
1507	68	23	0	1
1508	68	32	3	3
1509	68	45	93	1
1510	68	46	34	0
1511	68	47	64	10
1512	68	30	30	0
1513	68	49	18	73
1514	68	31	0	0
1515	68	33	18215	2732
1516	68	34	724	108
1517	68	35	3	4
1518	69	2	386	251
1519	69	43	641	128
1520	69	40	90	270
1521	69	11	96	24
1522	69	14	136	68
1523	69	7	280	840
1524	69	8	81	1964
1525	69	16	92	925
1526	69	17	23	97
1527	69	18	26	1250
1528	69	22	54	9
1529	69	20	37	4
1530	69	21	172	1206
1531	69	23	136	1230
1532	69	32	2	2
1533	69	45	13	0
1534	69	46	71	0
1535	69	47	5	0
1536	69	30	31	0
1537	69	49	24	99
1538	69	31	73	1
1539	69	33	29	4
1540	69	34	18	2
1541	69	35	7	9
1542	70	2	185	120
1543	70	43	340	68
1544	70	40	415	1247
1545	70	11	185	46
1546	70	14	337	168
1547	70	7	81	245
1548	70	8	71	1709
1549	70	16	28	289
1550	70	17	100	422
1551	70	18	41	1957
1552	70	22	124	22
1553	70	20	111	12
1554	70	21	263	1847
1555	70	23	86	777
1556	70	32	0	0
1557	70	45	161	1
1558	70	46	54	0
1559	70	47	127	20
1560	70	30	55	0
1561	70	49	104	419
1562	70	31	11	0
1563	70	33	11	1
1564	70	34	25	3
1565	70	35	12	14
1566	71	2	313	203
1567	71	43	342	68
1568	71	40	37	113
1569	71	11	176	44
1570	71	14	135	67
1571	71	7	64	194
1572	71	8	48	1169
1573	71	16	83	831
1574	71	17	181	764
1575	71	18	50	2358
1576	71	22	74	13
1577	71	20	91	10
1578	71	21	211	1483
1579	71	23	10	93
1580	71	32	2	2
1581	71	45	45	0
1582	71	46	243	3
1583	71	47	61	9
1584	71	30	49	0
1585	71	49	36	147
1586	71	31	18	0
1587	71	33	6	1
1588	71	34	441	66
1589	71	35	0	0
1590	72	2	303	197
1591	72	43	585	117
1592	72	40	23	70
1593	72	11	17	4
1594	72	14	45	22
1595	72	7	221	664
1596	72	8	40	962
1597	72	16	47	479
1598	72	17	15	66
1599	72	18	17	822
1600	72	22	11	2
1601	72	20	19	2
1602	72	21	68	480
1603	72	23	229	2065
1604	72	32	110	99
1605	72	45	14	0
1606	72	46	50	0
1607	72	47	7	1
1608	72	30	22	0
1609	72	49	19	78
1610	72	31	46	1
1611	72	33	23	3
1612	72	34	29	4
1613	72	35	16	19
1614	73	2	428	278
1615	73	43	527	105
1616	73	40	36	108
1617	73	11	209	52
1618	73	14	201	100
1619	73	7	110	331
1620	73	8	38	917
1621	73	16	95	951
1622	73	17	386	1625
1623	73	18	68	3239
1624	73	22	247	44
1625	73	20	208	22
1626	73	21	538	3768
1627	73	23	116	1052
1628	73	32	3	2
1629	73	45	206	2
1630	73	46	78	1
1631	73	47	64	10
1632	73	30	60	0
1633	73	49	22	90
1634	73	31	16	0
1635	73	33	36447	5467
1636	73	34	1480	222
1637	73	35	14	17
1638	74	2	293	190
1639	74	43	601	120
1640	74	40	39	119
1641	74	11	151	37
1642	74	14	107	53
1643	74	7	401	1204
1644	74	8	37	895
1645	74	16	34	346
1646	74	17	73	309
1647	74	18	26	1237
1648	74	22	76	13
1649	74	20	67	7
1650	74	21	149	1044
1651	74	23	132	1189
1652	74	32	0	0
1653	74	45	21	0
1654	74	46	106	1
1655	74	47	9	1
1656	74	30	40	0
1657	74	49	37	148
1658	74	31	106	2
1659	74	33	45	6
1660	74	34	38	5
1661	74	35	13	16
1662	75	2	184	119
1663	75	43	303	60
1664	75	40	70	211
1665	75	11	72	18
1666	75	14	31	15
1667	75	7	36	109
1668	75	8	28	675
1669	75	16	22	225
1670	75	17	87	365
1671	75	18	26	1258
1672	75	22	99	17
1673	75	20	57	6
1674	75	21	88	618
1675	75	23	38	347
1676	75	32	1	1
1677	75	45	21	0
1678	75	46	25	0
1679	75	47	12	1
1680	75	30	12	0
1681	75	49	3	13
1682	75	31	28	0
1683	75	33	5	0
1684	75	34	15	2
1685	75	35	12	14
1686	76	2	270	175
1687	76	43	171	34
1688	76	40	26	79
1689	76	11	112	28
1690	76	14	137	68
1691	76	7	158	474
1692	76	8	48	1173
1693	76	16	72	727
1694	76	17	15	65
1695	76	18	46	2174
1696	76	22	36	6
1697	76	20	27	2
1698	76	21	266	1868
1699	76	23	81	731
1700	76	32	10	9
1701	76	45	23	0
1702	76	46	47	0
1703	76	47	6	1
1704	76	30	23	0
1705	76	49	17	69
1706	76	31	41	0
1707	76	33	17	2
1708	76	34	22	3
1709	76	35	5	6
1710	77	2	111	72
1711	77	43	192	38
1712	77	40	44	134
1713	77	11	122	30
1714	77	14	61	30
1715	77	7	124	372
1716	77	8	13	323
1717	77	16	21	214
1718	77	17	109	457
1719	77	18	32	1514
1720	77	22	78	14
1721	77	20	68	7
1722	77	21	124	868
1723	77	23	17	161
1724	77	32	0	0
1725	77	45	43	0
1726	77	46	52	0
1727	77	47	20	3
1728	77	30	28	0
1729	77	49	21	86
1730	77	31	39	0
1731	77	33	13	2
1732	77	34	10	1
1733	77	35	4	4
1734	78	2	40	26
1735	78	43	63	12
1736	78	40	7	22
1737	78	11	11	2
1738	78	14	11	5
1739	78	7	19	59
1740	78	8	3	75
1741	78	16	23	237
1742	78	17	5	21
1743	78	18	3	147
1744	78	22	4	0
1745	78	20	12	1
1746	78	21	12	86
1747	78	23	25	227
1748	78	32	0	0
1749	78	45	6	0
1750	78	46	34	0
1751	78	47	1	0
1752	78	30	1	0
1753	78	49	1	6
1754	78	31	36	0
1755	78	33	6	0
1756	78	34	15	2
1757	78	35	1	1
1830	82	2	125	81
1831	82	43	95	19
1832	82	40	1	3
1833	82	11	2	0
1834	82	14	56	28
1835	82	7	266	798
1836	82	8	30	723
1837	82	16	14	145
1838	82	17	6	26
1839	82	18	7	366
1840	82	22	20	3
1841	82	20	24	2
1842	82	21	65	459
1843	82	23	47	426
1844	82	32	0	0
1845	82	45	7	0
1846	82	46	73	0
1847	82	47	1	0
1848	82	30	26	0
1849	82	49	24	97
1850	82	31	77	1
1851	82	33	27	4
1852	82	34	19	2
1853	82	35	3	4
1878	84	2	200	130
1879	84	43	387	77
1880	84	40	28	84
1881	84	11	73	18
1882	84	14	76	38
1883	84	7	357	1073
1884	84	8	31	764
1885	84	16	56	568
1886	84	17	33	142
1887	84	18	15	723
1888	84	22	41	7
1889	84	20	41	4
1890	84	21	158	1107
1891	84	23	135	1219
1892	84	32	0	0
1893	84	45	10	0
1894	84	46	89	1
1895	84	47	4	0
1896	84	30	31	0
1897	84	49	28	113
1898	84	31	97	2
1899	84	33	45	6
1900	84	34	34	5
1901	84	35	8	10
1926	86	2	106	69
1927	86	43	149	29
1928	86	40	10	32
1929	86	11	52	13
1930	86	14	52	26
1931	86	7	45	135
1932	86	8	68	1649
1933	86	16	16	167
1934	86	17	22	96
1935	86	18	33	1572
1936	86	22	29	5
1937	86	20	25	2
1938	86	21	58	406
1939	86	23	38	343
1940	86	32	321	289
1941	86	45	65	0
1942	86	46	31	0
1943	86	47	44	7
1944	86	30	81	1
1945	86	49	52	209
1946	86	31	25	0
1947	86	33	5	0
1948	86	34	27	4
1949	86	35	507	608
1950	87	2	410	266
1951	87	43	563	112
1952	87	40	31	93
1953	87	11	118	29
1954	87	14	251	125
1955	87	7	176	530
1956	87	8	150	3615
1957	87	16	209	2092
1958	87	17	123	516
1959	87	18	77	3658
1960	87	22	87	15
1961	87	20	159	17
1962	87	21	338	2372
1963	87	23	147	1327
1964	87	32	501	451
1965	87	45	164	1
1966	87	46	163	2
1967	87	47	101	16
1968	87	30	185	2
1969	87	49	101	405
1970	87	31	167	4
1971	87	33	25	3
1972	87	34	139	20
1973	87	35	777	933
1974	88	2	173	112
1975	88	43	342	68
1976	88	40	9	29
1977	88	11	35	8
1978	88	14	81	40
1979	88	7	118	354
1980	88	8	76	1829
1981	88	16	100	1003
1982	88	17	25	107
1983	88	18	23	1121
1984	88	22	23	4
1985	88	20	44	4
1986	88	21	116	814
1987	88	23	125	1132
1988	88	32	166	150
1989	88	45	38	0
1990	88	46	61	0
1991	88	47	16	2
1992	88	30	53	0
1993	88	49	35	143
1994	88	31	55	1
1995	88	33	14	2
1996	88	34	33	4
1997	88	35	262	314
1998	89	2	272	176
1999	89	43	292	58
2000	89	40	24	74
2001	89	11	119	29
2002	89	14	237	118
2003	89	7	171	514
2004	89	8	170	4081
2005	89	16	52	525
2006	89	17	75	318
2007	89	18	116	5465
2008	89	22	130	23
2009	89	20	229	25
2010	89	21	225	1576
2011	89	23	49	441
2012	89	32	459	413
2013	89	45	76	0
2014	89	46	139	1
2015	89	47	175	28
2016	89	30	265	3
2017	89	49	123	494
2018	89	31	461	11
2019	89	33	9	1
2020	89	34	102	15
2021	89	35	581	697
2022	90	2	71	46
2023	90	43	77	15
2024	90	40	3	9
2025	90	11	14	3
2026	90	14	32	16
2027	90	7	25	76
2028	90	8	33	793
2029	90	16	6	61
2030	90	17	7	30
2031	90	18	9	467
2032	90	22	6	1
2033	90	20	14	1
2034	90	21	29	203
2035	90	23	2	19
2036	90	32	56	51
2037	90	45	33	0
2038	90	46	11	0
2039	90	47	31	4
2040	90	30	37	0
2041	90	49	15	60
2042	90	31	24	0
2043	90	33	3	0
2044	90	34	4	0
2045	90	35	88	106
2046	91	2	615	399
2047	91	43	747	149
2048	91	40	14	43
2049	91	11	35	8
2050	91	14	677	338
2051	91	7	492	1477
2052	91	8	222	5348
2053	91	16	37	374
2054	91	17	89	376
2055	91	18	125	5901
2056	91	22	159	28
2057	91	20	662	72
2058	91	21	473	3312
2059	91	23	7	63
2060	91	32	84	75
2061	91	45	199	2
2062	91	46	199	2
2063	91	47	507	81
2064	91	30	627	8
2065	91	49	59	239
2066	91	31	1202	28
2067	91	33	13	2
2068	91	34	48	7
2069	91	35	108	129
2070	92	2	283	184
2071	92	43	347	69
2072	92	40	37	111
2073	92	11	155	38
2074	92	14	359	179
2075	92	7	214	644
2076	92	8	335	8045
2077	92	16	82	826
2078	92	17	98	414
2079	92	18	123	5788
2080	92	22	163	29
2081	92	20	376	41
2082	92	21	276	1933
2083	92	23	30	270
2084	92	32	1275	1148
2085	92	45	121	1
2086	92	46	166	2
2087	92	47	277	44
2088	92	30	414	5
2089	92	49	168	674
2090	92	31	809	19
2091	92	33	6	0
2092	92	34	37	5
2093	92	35	852	1022
2094	93	2	73	47
2095	93	43	84	16
2096	93	40	12	37
2097	93	11	50	12
2098	93	14	35	17
2099	93	7	23	69
2100	93	8	60	1458
2101	93	16	22	225
2102	93	17	18	75
2103	93	18	25	1184
2104	93	22	20	3
2105	93	20	18	2
2106	93	21	38	272
2107	93	23	3	33
2108	93	32	191	172
2109	93	45	46	0
2110	93	46	22	0
2111	93	47	29	4
2112	93	30	66	0
2113	93	49	51	207
2114	93	31	18	0
2115	93	33	4	0
2116	93	34	7	1
2117	93	35	290	348
2118	94	2	181	118
2119	94	43	177	35
2120	94	40	8	24
2121	94	11	25	6
2122	94	14	167	83
2123	94	7	105	317
2124	94	8	436	10474
2125	94	16	19	199
2126	94	17	46	197
2127	94	18	56	2642
2128	94	22	45	8
2129	94	20	98	10
2130	94	21	128	901
2131	94	23	20	183
2132	94	32	58	52
2133	94	45	96	1
2134	94	46	80	1
2135	94	47	176	28
2136	94	30	97	1
2137	94	49	37	151
2138	94	31	173	4
2139	94	33	42	6
2140	94	34	34	5
2141	94	35	175	210
2142	95	2	34	22
2143	95	43	16	3
2144	95	40	6	20
2145	95	11	12	3
2146	95	14	5	2
2147	95	7	3	11
2148	95	8	9	226
2149	95	16	10	105
2150	95	17	9	39
2151	95	18	10	493
2152	95	22	17	3
2153	95	20	5	0
2154	95	21	8	61
2155	95	23	20	185
2156	95	32	110	99
2157	95	45	7	0
2158	95	46	7	0
2159	95	47	5	0
2160	95	30	18	0
2161	95	49	16	64
2162	95	31	0	0
2163	95	33	0	0
2164	95	34	2	0
2165	95	35	443	532
2166	96	2	171	111
2167	96	43	191	38
2168	96	40	24	72
2169	96	11	110	27
2170	96	14	193	96
2171	96	7	109	327
2172	96	8	165	3979
2173	96	16	52	529
2174	96	17	65	273
2175	96	18	74	3493
2176	96	22	60	10
2177	96	20	115	12
2178	96	21	171	1197
2179	96	23	8	73
2180	96	32	402	362
2181	96	45	332	3
2182	96	46	125	1
2183	96	47	151	24
2184	96	30	244	3
2185	96	49	118	473
2186	96	31	132	3
2187	96	33	0	0
2188	96	34	12	1
2189	96	35	663	796
2214	98	2	151	98
2215	98	43	130	26
2216	98	40	20	60
2217	98	11	30	7
2218	98	14	59	29
2219	98	7	50	151
2220	98	8	87	2090
2221	98	16	13	132
2222	98	17	13	55
2223	98	18	22	1034
2224	98	22	14	2
2225	98	20	36	3
2226	98	21	43	305
2227	98	23	17	157
2228	98	32	64	57
2229	98	45	39	0
2230	98	46	25	0
2231	98	47	62	9
2232	98	30	56	0
2233	98	49	0	3
2234	98	31	66	1
2235	98	33	18	2
2236	98	34	25	3
2237	98	35	234	281
2262	100	2	85	55
2263	100	43	55	11
2264	100	40	30	92
2265	100	11	52	13
2266	100	14	149	74
2267	100	7	163	491
2268	100	8	127	3051
2269	100	16	39	392
2270	100	17	54	229
2271	100	18	35	1678
2272	100	22	67	12
2273	100	20	68	7
2274	100	21	126	882
2275	100	23	50	455
2276	100	32	331	298
2277	100	45	112	1
2278	100	46	74	0
2279	100	47	134	21
2280	100	30	125	1
2281	100	49	133	532
2282	100	31	66	1
2283	100	33	3	0
2284	100	34	36	5
2285	100	35	115	139
2310	102	2	152	98
2311	102	43	193	38
2312	102	40	17	51
2313	102	11	45	11
2314	102	14	399	199
2315	102	7	198	595
2316	102	8	141	3390
2317	102	16	41	418
2318	102	17	84	356
2319	102	18	137	6474
2320	102	22	115	20
2321	102	20	309	34
2322	102	21	313	2196
2323	102	23	82	742
2324	102	32	143	128
2325	102	45	118	1
2326	102	46	214	2
2327	102	47	405	64
2328	102	30	498	6
2329	102	49	72	290
2330	102	31	581	13
2331	102	33	0	0
2332	102	34	27	4
2333	102	35	175	210
2358	104	2	122	79
2359	104	43	67	13
2360	104	40	15	47
2361	104	11	55	13
2362	104	14	224	112
2363	104	7	95	285
2364	104	8	102	2468
2365	104	16	30	306
2366	104	17	51	214
2367	104	18	71	3361
2368	104	22	83	14
2369	104	20	244	26
2370	104	21	188	1321
2371	104	23	22	204
2372	104	32	264	237
2373	104	45	68	0
2374	104	46	121	1
2375	104	47	182	29
2376	104	30	291	3
2377	104	49	75	303
2378	104	31	432	10
2379	104	33	3	0
2380	104	34	86	13
2381	104	35	305	366
2406	106	2	384	249
2407	106	43	592	118
2408	106	40	6	18
2409	106	11	7	1
2410	106	14	318	159
2411	106	7	851	2554
2412	106	8	164	3941
2413	106	16	199	1998
2414	106	17	45	191
2415	106	18	38	1817
2416	106	22	71	12
2417	106	20	179	19
2418	106	21	364	2549
2419	106	23	246	2218
2420	106	32	2	2
2421	106	45	70	0
2422	106	46	299	3
2423	106	47	81	13
2424	106	30	113	1
2425	106	49	81	324
2426	106	31	374	8
2427	106	33	107	16
2428	106	34	77	11
2429	106	35	21	26
2454	108	2	241	157
2455	108	43	151	30
2456	108	40	4	13
2457	108	11	16	4
2458	108	14	105	52
2459	108	7	516	1548
2460	108	8	66	1584
2461	108	16	29	292
2462	108	17	18	76
2463	108	18	22	1053
2464	108	22	44	8
2465	108	20	50	5
2466	108	21	121	850
2467	108	23	77	693
2190	97	2	93	60
2191	97	43	85	17
2192	97	40	38	115
2193	97	11	128	32
2194	97	14	451	225
2195	97	7	217	653
2196	97	8	120	2900
2197	97	16	167	1671
2198	97	17	186	784
2199	97	18	115	5436
2200	97	22	311	56
2201	97	20	202	22
2202	97	21	313	2195
2203	97	23	184	1657
2204	97	32	322	290
2205	97	45	107	1
2206	97	46	211	2
2207	97	47	476	76
2208	97	30	624	8
2209	97	49	254	1017
2210	97	31	461	11
2211	97	33	18	2
2212	97	34	60	9
2213	97	35	2213	2656
2238	99	2	63	40
2239	99	43	24	4
2240	99	40	8	24
2241	99	11	34	8
2242	99	14	18	9
2243	99	7	0	0
2244	99	8	2	70
2245	99	16	18	186
2246	99	17	26	112
2247	99	18	16	792
2248	99	22	20	3
2249	99	20	13	1
2250	99	21	29	206
2251	99	23	44	396
2252	99	32	116	104
2253	99	45	16	0
2254	99	46	34	0
2255	99	47	13	2
2256	99	30	34	0
2257	99	49	18	74
2258	99	31	0	0
2259	99	33	0	0
2260	99	34	75	11
2261	99	35	270	325
2286	101	2	41	26
2287	101	43	48	9
2288	101	40	10	30
2289	101	11	46	11
2290	101	14	21	10
2291	101	7	10	30
2292	101	8	30	738
2293	101	16	20	200
2294	101	17	14	59
2295	101	18	21	1006
2296	101	22	15	2
2297	101	20	10	1
2298	101	21	28	197
2299	101	23	13	119
2300	101	32	184	166
2301	101	45	23	0
2302	101	46	19	0
2303	101	47	27	4
2304	101	30	45	0
2305	101	49	49	196
2306	101	31	11	0
2307	101	33	1	0
2308	101	34	19	2
2309	101	35	295	355
2334	103	2	39	25
2335	103	43	34	6
2336	103	40	15	45
2337	103	11	46	11
2338	103	14	75	37
2339	103	7	41	124
2340	103	8	63	1530
2341	103	16	29	293
2342	103	17	38	160
2343	103	18	50	2392
2344	103	22	45	8
2345	103	20	32	3
2346	103	21	70	492
2347	103	23	44	403
2348	103	32	69	62
2349	103	45	38	0
2350	103	46	70	0
2351	103	47	93	15
2352	103	30	102	1
2353	103	49	75	302
2354	103	31	29	0
2355	103	33	0	0
2356	103	34	24	3
2357	103	35	381	457
2382	105	2	51	33
2383	105	43	42	8
2384	105	40	49	149
2385	105	11	152	38
2386	105	14	417	208
2387	105	7	166	499
2388	105	8	358	8595
2389	105	16	75	759
2390	105	17	105	441
2391	105	18	135	6371
2392	105	22	101	18
2393	105	20	157	17
2394	105	21	299	2096
2395	105	23	194	1754
2396	105	32	379	341
2397	105	45	322	3
2398	105	46	253	3
2399	105	47	532	85
2400	105	30	553	7
2401	105	49	141	567
2402	105	31	352	8
2403	105	33	9	1
2404	105	34	41	6
2405	105	35	542	651
2430	107	2	319	207
2431	107	43	571	114
2432	107	40	5	16
2433	107	11	11	2
2434	107	14	129	64
2435	107	7	660	1980
2436	107	8	88	2123
2437	107	16	52	525
2438	107	17	17	74
2439	107	18	19	922
2440	107	22	46	8
2441	107	20	59	6
2442	107	21	152	1064
2443	107	23	249	2243
2444	107	32	0	0
2445	107	45	17	0
2446	107	46	166	2
2447	107	47	4	0
2448	107	30	59	0
2449	107	49	54	216
2450	107	31	179	4
2451	107	33	73	11
2452	107	34	50	7
2453	107	35	14	17
2478	109	2	41	26
2479	109	43	46	9
2480	109	40	4	14
2481	109	11	0	0
2482	109	14	44	22
2483	109	7	131	395
2484	109	8	52	1252
2485	109	16	7	76
2486	109	17	6	28
2487	109	18	11	536
2488	109	22	14	2
2489	109	20	16	1
2490	109	21	43	304
2468	108	32	112	101
2469	108	45	22	0
2470	108	46	148	1
2471	108	47	8	1
2472	108	30	78	1
2473	108	49	61	247
2474	108	31	148	3
2475	108	33	53	8
2476	108	34	33	5
2477	108	35	79	95
2502	110	2	87	56
2503	110	43	67	13
2504	110	40	1	5
2505	110	11	0	0
2506	110	14	80	40
2507	110	7	372	1118
2508	110	8	23	567
2509	110	16	17	170
2510	110	17	9	39
2511	110	18	11	517
2512	110	22	30	5
2513	110	20	36	4
2514	110	21	88	620
2515	110	23	53	480
2516	110	32	0	0
2517	110	45	12	0
2518	110	46	111	1
2519	110	47	11	1
2520	110	30	43	0
2521	110	49	36	145
2522	110	31	111	2
2523	110	33	40	6
2524	110	34	23	3
2525	110	35	3	4
3486	151	2	311	202
3487	151	43	147	29
3488	151	40	10	30
3489	151	11	14	3
3490	151	14	263	131
3491	151	7	109	327
3492	151	8	123	2966
3493	151	16	14	144
3494	151	17	45	192
3495	151	18	33	1571
3496	151	22	66	11
3497	151	20	52	5
3498	151	21	145	1016
3499	151	23	13	117
3500	151	32	5	5
3501	151	45	38	0
3502	151	46	53	0
3503	151	47	421	67
3504	151	30	175	2
3505	151	49	8	34
3506	151	31	701	16
3507	151	33	52	7
3508	151	34	18	2
3509	151	35	20	24
3534	153	2	261	169
3535	153	43	579	115
3536	153	40	5	16
3537	153	11	11	2
3538	153	14	21	10
3539	153	7	78	234
3540	153	8	3	88
3541	153	16	13	134
3542	153	17	45	191
3543	153	18	19	911
3544	153	22	65	11
3545	153	20	29	3
3546	153	21	64	449
3547	153	23	81	730
3548	153	32	4	4
3549	153	45	21	0
3550	153	46	9	0
3551	153	47	15	2
3552	153	30	12	0
3553	153	49	14	57
3554	153	31	9	0
3555	153	33	9	1
3556	153	34	17	2
3557	153	35	6	7
3582	155	2	44	29
3583	155	43	68	13
3584	155	40	2	8
3585	155	11	2	0
3586	155	14	28	14
3587	155	7	127	382
3588	155	8	13	330
3589	155	16	11	116
3590	155	17	3	16
3591	155	18	4	202
3592	155	22	10	1
3593	155	20	12	1
3594	155	21	33	231
3595	155	23	38	345
3596	155	32	0	0
3597	155	45	3	0
3598	155	46	35	0
3599	155	47	1	0
3600	155	30	12	0
3601	155	49	11	46
3602	155	31	37	0
3603	155	33	13	2
3604	155	34	7	1
3605	155	35	1	2
2491	109	23	18	163
2492	109	32	1	1
2493	109	45	14	0
2494	109	46	59	0
2495	109	47	36	5
2496	109	30	32	0
2497	109	49	16	65
2498	109	31	37	0
2499	109	33	15	2
2500	109	34	8	1
2501	109	35	0	1
2526	111	2	135	88
2527	111	43	155	31
2528	111	40	17	53
2529	111	11	78	19
2530	111	14	97	48
2531	111	7	198	596
2532	111	8	97	2339
2533	111	16	41	419
2534	111	17	79	333
2535	111	18	56	2640
2536	111	22	53	9
2537	111	20	58	6
2538	111	21	140	981
2539	111	23	66	601
2540	111	32	209	188
2541	111	45	48	0
2542	111	46	193	2
2543	111	47	81	13
2544	111	30	102	1
2545	111	49	90	363
2546	111	31	61	1
2547	111	33	24	3
2548	111	34	144	21
2549	111	35	121	145
2550	112	2	332	215
2551	112	43	613	122
2552	112	40	43	129
2553	112	11	27	6
2554	112	14	106	53
2555	112	7	589	1768
2556	112	8	53	1290
2557	112	16	239	2395
2558	112	17	33	142
2559	112	18	30	1442
2560	112	22	50	9
2561	112	20	51	5
2562	112	21	188	1319
2563	112	23	270	2436
2564	112	32	3	3
2565	112	45	67	0
2566	112	46	180	2
2567	112	47	7	1
2568	112	30	60	0
2569	112	49	50	200
2570	112	31	146	3
2571	112	33	62	9
2572	112	34	205	30
2573	112	35	13	16
2574	113	2	51	33
2575	113	43	147	29
2576	113	40	8	26
2577	113	11	65	16
2578	113	14	37	18
2579	113	7	0	0
2580	113	8	18	433
2581	113	16	6	61
2582	113	17	2	9
2583	113	18	0	24
2584	113	22	20	3
2585	113	20	1	0
2586	113	21	1	10
2587	113	23	0	5
2588	113	32	1	1
2589	113	45	1	0
2590	113	46	3	0
2591	113	47	0	0
2592	113	30	1	0
2593	113	49	2	11
2594	113	31	0	0
2595	113	33	0	0
2596	113	34	1	0
2597	113	35	38	46
2598	114	2	30	19
2599	114	43	31	6
2600	114	40	3	10
2601	114	11	1	0
2602	114	14	59	29
2603	114	7	193	581
2604	114	8	36	876
2605	114	16	9	97
2606	114	17	8	33
2607	114	18	11	539
2608	114	22	18	3
2609	114	20	24	2
2610	114	21	57	404
2611	114	23	26	242
2612	114	32	1	1
2613	114	45	26	0
2614	114	46	72	0
2615	114	47	29	4
2616	114	30	37	0
2617	114	49	21	84
2618	114	31	60	1
2619	114	33	21	3
2620	114	34	11	1
2621	114	35	0	0
2622	115	2	56	36
2623	115	43	40	8
2624	115	40	15	46
2625	115	11	47	11
2626	115	14	60	30
2627	115	7	215	647
2628	115	8	83	1996
2629	115	16	28	280
2630	115	17	29	125
2631	115	18	41	1927
2632	115	22	47	8
2633	115	20	33	3
2634	115	21	78	548
2635	115	23	70	637
2636	115	32	120	108
2637	115	45	22	0
2638	115	46	89	1
2639	115	47	106	16
2640	115	30	109	1
2641	115	49	48	194
2642	115	31	63	1
2643	115	33	22	3
2644	115	34	105	15
2645	115	35	175	210
2646	116	2	33	21
2647	116	43	60	12
2648	116	40	0	2
2649	116	11	0	0
2650	116	14	56	28
2651	116	7	79	237
2652	116	8	40	960
2653	116	16	75	757
2654	116	17	7	33
2655	116	18	2	126
2656	116	22	7	1
2657	116	20	21	2
2658	116	21	79	555
2659	116	23	20	188
2660	116	32	0	0
2661	116	45	3	0
2662	116	46	34	0
2663	116	47	1	0
2664	116	30	10	0
2665	116	49	6	27
2666	116	31	49	1
2667	116	33	8	1
2668	116	34	4	0
2669	116	35	1	1
2670	117	2	250	162
2671	117	43	429	85
2672	117	40	5	16
2673	117	11	7	1
2674	117	14	225	112
2675	117	7	623	1869
2676	117	8	62	1498
2677	117	16	75	750
2678	117	17	45	190
2679	117	18	25	1188
2680	117	22	47	8
2681	117	20	92	10
2682	117	21	266	1865
2683	117	23	206	1858
2684	117	32	0	0
2685	117	45	48	0
2686	117	46	260	3
2687	117	47	8	1
2688	117	30	87	1
2689	117	49	58	235
2690	117	31	239	5
2691	117	33	68	10
2692	117	34	41	6
2693	117	35	9	11
2718	119	2	212	137
2719	119	43	174	34
2720	119	40	25	76
2721	119	11	118	29
2722	119	14	86	43
2723	119	7	144	434
2724	119	8	83	2005
2725	119	16	30	302
2726	119	17	46	196
2727	119	18	57	2691
2728	119	22	61	11
2729	119	20	58	6
2730	119	21	96	673
2731	119	23	23	215
2732	119	32	47	42
2733	119	45	70	0
2734	119	46	86	1
2735	119	47	93	14
2736	119	30	148	1
2737	119	49	97	391
2738	119	31	68	1
2739	119	33	16	2
2740	119	34	71	10
2741	119	35	189	227
2790	122	2	91	59
2791	122	43	43	8
2792	122	40	19	59
2793	122	11	131	32
2794	122	14	22	11
2795	122	7	0	0
2796	122	8	1	44
2797	122	16	13	135
2798	122	17	34	146
2799	122	18	50	2374
2800	122	22	22	4
2801	122	20	28	3
2802	122	21	40	280
2803	122	23	10	92
2804	122	32	118	106
2805	122	45	32	0
2806	122	46	46	0
2807	122	47	47	7
2808	122	30	99	1
2809	122	49	96	387
2810	122	31	0	0
2811	122	33	0	0
2812	122	34	57	8
2813	122	35	276	331
2838	124	2	114	74
2839	124	43	91	18
2840	124	40	13	39
2841	124	11	107	26
2842	124	14	17	8
2843	124	7	19	58
2844	124	8	1	44
2845	124	16	7	75
2846	124	17	28	119
2847	124	18	42	1981
2848	124	22	12	2
2849	124	20	24	2
2850	124	21	33	235
2851	124	23	22	202
2852	124	32	44	40
2853	124	45	23	0
2854	124	46	43	0
2855	124	47	43	7
2856	124	30	80	1
2857	124	49	81	327
2858	124	31	3	0
2859	124	33	1	0
2860	124	34	58	8
2861	124	35	71	85
3510	152	2	94	61
3511	152	43	26	5
3512	152	40	4	14
3513	152	11	38	9
3514	152	14	23	11
3515	152	7	0	0
3516	152	8	13	326
3517	152	16	8	88
3518	152	17	25	108
3519	152	18	8	421
3520	152	22	13	2
3521	152	20	35	3
3522	152	21	34	242
3523	152	23	0	2
3524	152	32	1	1
3525	152	45	46	0
3526	152	46	21	0
3527	152	47	6	1
3528	152	30	14	0
3529	152	49	5	20
3530	152	31	1	0
3531	152	33	0	0
3532	152	34	8	1
3533	152	35	3	3
3558	154	2	352	229
3559	154	43	834	166
3560	154	40	100	302
3561	154	11	239	59
3562	154	14	427	213
3563	154	7	1	3
3564	154	8	112	2691
3565	154	16	95	959
3566	154	17	136	572
3567	154	18	112	5286
3568	154	22	339	61
3569	154	20	290	31
3570	154	21	730	5111
3571	154	23	0	2
3572	154	32	9	8
3573	154	45	110	1
3574	154	46	215	2
3575	154	47	68	10
3576	154	30	58	0
3577	154	49	272	1090
3578	154	31	11	0
3579	154	33	0	0
3580	154	34	12	1
3581	154	35	13	16
2694	118	2	123	80
2695	118	43	128	25
2696	118	40	6	18
2697	118	11	37	9
2698	118	14	70	35
2699	118	7	211	634
2700	118	8	31	762
2701	118	16	80	802
2702	118	17	53	223
2703	118	18	16	765
2704	118	22	34	6
2705	118	20	39	4
2706	118	21	192	1350
2707	118	23	53	482
2708	118	32	0	0
2709	118	45	17	0
2710	118	46	119	1
2711	118	47	17	2
2712	118	30	27	0
2713	118	49	26	104
2714	118	31	58	1
2715	118	33	23	3
2716	118	34	144	21
2717	118	35	2	2
2742	120	2	51	33
2743	120	43	90	18
2744	120	40	5	15
2745	120	11	21	5
2746	120	14	62	31
2747	120	7	82	246
2748	120	8	38	915
2749	120	16	65	656
2750	120	17	16	69
2751	120	18	19	930
2752	120	22	11	2
2753	120	20	38	4
2754	120	21	86	606
2755	120	23	32	291
2756	120	32	141	127
2757	120	45	14	0
2758	120	46	55	0
2759	120	47	8	1
2760	120	30	47	0
2761	120	49	48	193
2762	120	31	47	1
2763	120	33	9	1
2764	120	34	8	1
2765	120	35	36	44
2766	121	2	79	51
2767	121	43	89	17
2768	121	40	7	21
2769	121	11	55	13
2770	121	14	10	5
2771	121	7	27	81
2772	121	8	1	36
2773	121	16	6	69
2774	121	17	14	62
2775	121	18	21	1023
2776	121	22	6	1
2777	121	20	13	1
2778	121	21	20	141
2779	121	23	28	258
2780	121	32	22	20
2781	121	45	12	0
2782	121	46	25	0
2783	121	47	22	3
2784	121	30	41	0
2785	121	49	41	165
2786	121	31	4	0
2787	121	33	2	0
2788	121	34	32	4
2789	121	35	36	44
2814	123	2	484	314
2815	123	43	761	152
2816	123	40	22	66
2817	123	11	136	34
2818	123	14	213	106
2819	123	7	250	751
2820	123	8	141	3394
2821	123	16	263	2636
2822	123	17	63	266
2823	123	18	70	3333
2824	123	22	37	6
2825	123	20	128	14
2826	123	21	287	2015
2827	123	23	250	2256
2828	123	32	57	52
2829	123	45	40	0
2830	123	46	179	2
2831	123	47	60	9
2832	123	30	134	1
2833	123	49	127	509
2834	123	31	145	3
2835	123	33	29	4
2836	123	34	83	12
2837	123	35	104	125
2862	125	2	66	43
2863	125	43	44	8
2864	125	40	8	24
2865	125	11	61	15
2866	125	14	100	50
2867	125	7	38	115
2868	125	8	185	4462
2869	125	16	6	62
2870	125	17	24	103
2871	125	18	40	1884
2872	125	22	18	3
2873	125	20	54	5
2874	125	21	91	641
2875	125	23	1	15
2876	125	32	43	39
2877	125	45	90	1
2878	125	46	51	0
2879	125	47	62	10
2880	125	30	95	1
2881	125	49	44	176
2882	125	31	60	1
2883	125	33	9	1
2884	125	34	31	4
2885	125	35	35	42
2886	126	2	264	171
2887	126	43	229	45
2888	126	40	30	92
2889	126	11	229	57
2890	126	14	83	41
2891	126	7	58	174
2892	126	8	12	289
2893	126	16	44	448
2894	126	17	78	329
2895	126	18	108	5119
2896	126	22	36	6
2897	126	20	67	7
2898	126	21	133	933
2899	126	23	57	514
2900	126	32	107	96
2901	126	45	65	0
2902	126	46	128	1
2903	126	47	145	23
2904	126	30	221	2
2905	126	49	182	728
2906	126	31	38	0
2907	126	33	8	1
2908	126	34	121	18
2909	126	35	204	245
2910	127	2	72	47
2911	127	43	138	27
2912	127	40	14	44
2913	127	11	99	24
2914	127	14	26	13
2915	127	7	0	0
2916	127	8	1	28
2917	127	16	7	75
2918	127	17	63	264
2919	127	18	30	1428
2920	127	22	45	8
2921	127	20	39	4
2922	127	21	65	457
2923	127	23	0	7
2924	127	32	14	13
2925	127	45	10	0
2926	127	46	19	0
2927	127	47	22	3
2928	127	30	28	0
2929	127	49	30	121
2930	127	31	0	0
2931	127	33	0	0
2932	127	34	15	2
2933	127	35	20	24
2958	129	2	108	70
2959	129	43	114	22
2960	129	40	3	10
2961	129	11	27	6
2962	129	14	46	23
2963	129	7	35	105
2964	129	8	39	955
2965	129	16	20	207
2966	129	17	12	50
2967	129	18	15	741
2968	129	22	6	1
2969	129	20	27	2
2970	129	21	50	352
2971	129	23	10	96
2972	129	32	12	10
2973	129	45	32	0
2974	129	46	26	0
2975	129	47	40	6
2976	129	30	44	0
2977	129	49	22	89
2978	129	31	34	0
2979	129	33	4	0
2980	129	34	18	2
2981	129	35	22	26
3006	131	2	100	65
3007	131	43	176	35
3008	131	40	6	18
3009	131	11	32	8
3010	131	14	11	5
3011	131	7	0	0
3012	131	8	1	32
3013	131	16	6	60
3014	131	17	28	119
3015	131	18	20	968
3016	131	22	38	6
3017	131	20	15	1
3018	131	21	33	232
3019	131	23	40	364
3020	131	32	15	13
3021	131	45	9	0
3022	131	46	12	0
3023	131	47	18	3
3024	131	30	25	0
3025	131	49	27	111
3026	131	31	0	0
3027	131	33	0	0
3028	131	34	33	5
3029	131	35	32	38
3054	133	2	178	116
3055	133	43	183	36
3056	133	40	7	21
3057	133	11	59	14
3058	133	14	75	37
3059	133	7	252	757
3060	133	8	50	1207
3061	133	16	27	278
3062	133	17	22	94
3063	133	18	27	1315
3064	133	22	37	6
3065	133	20	45	5
3066	133	21	80	561
3067	133	23	65	590
3068	133	32	23	20
3069	133	45	20	0
3070	133	46	104	1
3071	133	47	24	3
3072	133	30	73	0
3073	133	49	71	284
3074	133	31	104	2
3075	133	33	27	4
3076	133	34	81	12
3077	133	35	69	83
3102	135	2	114	74
3103	135	43	112	22
3104	135	40	6	19
3105	135	11	35	8
3106	135	14	83	41
3107	135	7	169	508
3108	135	8	58	1411
3109	135	16	10	107
3110	135	17	18	78
3111	135	18	28	1320
3112	135	22	24	4
3113	135	20	50	5
3114	135	21	71	500
3115	135	23	30	270
3116	135	32	25	22
3117	135	45	42	0
3118	135	46	66	0
3119	135	47	70	11
3120	135	30	62	0
3121	135	49	37	149
3122	135	31	102	2
3123	135	33	30	4
3124	135	34	35	5
3125	135	35	24	29
3150	137	2	542	352
3151	137	43	696	139
3152	137	40	3	11
3153	137	11	0	0
3154	137	14	352	176
3155	137	7	528	1586
3156	137	8	166	3995
3157	137	16	67	675
3158	137	17	42	179
3159	137	18	53	2531
3160	137	22	79	14
3161	137	20	264	29
3162	137	21	300	2106
3163	137	23	113	1025
3164	137	32	0	0
3165	137	45	130	1
3166	137	46	180	2
3167	137	47	235	37
3168	137	30	236	3
3169	137	49	36	145
3170	137	31	602	14
3171	137	33	49	7
3172	137	34	43	6
3173	137	35	11	14
2934	128	2	332	216
2935	128	43	467	93
2936	128	40	8	26
2937	128	11	61	15
2938	128	14	302	151
2939	128	7	203	610
2940	128	8	103	2486
2941	128	16	206	2064
2942	128	17	55	232
2943	128	18	58	2744
2944	128	22	67	12
2945	128	20	274	30
2946	128	21	314	2198
2947	128	23	100	900
2948	128	32	36	32
2949	128	45	39	0
2950	128	46	171	2
2951	128	47	146	23
2952	128	30	173	2
2953	128	49	80	322
2954	128	31	508	12
2955	128	33	14	2
2956	128	34	51	7
2957	128	35	116	139
2982	130	2	82	53
2983	130	43	101	20
2984	130	40	3	10
2985	130	11	6	1
2986	130	14	48	24
2987	130	7	55	166
2988	130	8	5	135
2989	130	16	7	71
2990	130	17	12	53
2991	130	18	15	733
2992	130	22	12	2
2993	130	20	17	1
2994	130	21	36	256
2995	130	23	32	296
2996	130	32	9	8
2997	130	45	13	0
2998	130	46	20	0
2999	130	47	56	8
3000	130	30	38	0
3001	130	49	4	18
3002	130	31	19	0
3003	130	33	4	0
3004	130	34	6	0
3005	130	35	7	9
3030	132	2	101	65
3031	132	43	89	17
3032	132	40	10	30
3033	132	11	79	19
3034	132	14	94	47
3035	132	7	99	298
3036	132	8	23	557
3037	132	16	44	448
3038	132	17	37	158
3039	132	18	51	2404
3040	132	22	45	8
3041	132	20	42	4
3042	132	21	96	675
3043	132	23	323	2912
3044	132	32	38	35
3045	132	45	58	0
3046	132	46	79	1
3047	132	47	92	14
3048	132	30	107	1
3049	132	49	241	966
3050	132	31	53	1
3051	132	33	11	1
3052	132	34	39	5
3053	132	35	559	671
3078	134	2	61	39
3079	134	43	21	4
3080	134	40	8	25
3081	134	11	53	13
3082	134	14	12	6
3083	134	7	0	0
3084	134	8	6	152
3085	134	16	16	160
3086	134	17	30	128
3087	134	18	24	1132
3088	134	22	13	2
3089	134	20	15	1
3090	134	21	32	225
3091	134	23	6	54
3092	134	32	30	27
3093	134	45	19	0
3094	134	46	21	0
3095	134	47	19	3
3096	134	30	30	0
3097	134	49	26	107
3098	134	31	0	0
3099	134	33	0	0
3100	134	34	39	5
3101	134	35	97	117
3126	136	2	87	56
3127	136	43	99	19
3128	136	40	40	120
3129	136	11	137	34
3130	136	14	443	221
3131	136	7	190	571
3132	136	8	198	4771
3133	136	16	64	644
3134	136	17	114	479
3135	136	18	158	7453
3136	136	22	232	41
3137	136	20	493	54
3138	136	21	360	2526
3139	136	23	99	892
3140	136	32	276	249
3141	136	45	141	1
3142	136	46	193	2
3143	136	47	375	60
3144	136	30	614	7
3145	136	49	58	233
3146	136	31	858	20
3147	136	33	6	0
3148	136	34	167	25
3149	136	35	78	94
3174	138	2	151	98
3175	138	43	273	54
3176	138	40	1	5
3177	138	11	4	1
3178	138	14	137	68
3179	138	7	157	472
3180	138	8	29	707
3181	138	16	12	122
3182	138	17	24	103
3183	138	18	23	1112
3184	138	22	9	1
3185	138	20	24	2
3186	138	21	105	738
3187	138	23	89	804
3188	138	32	0	0
3189	138	45	34	0
3190	138	46	51	0
3191	138	47	171	27
3192	138	30	179	2
3193	138	49	8	32
3194	138	31	41	1
3195	138	33	10	1
3196	138	34	26	4
3197	138	35	6	7
3198	139	2	462	300
3199	139	43	672	134
3200	139	40	35	105
3201	139	11	262	65
3202	139	14	176	88
3203	139	7	363	1089
3204	139	8	137	3291
3205	139	16	80	807
3206	139	17	127	536
3207	139	18	93	4381
3208	139	22	167	30
3209	139	20	108	11
3210	139	21	335	2345
3211	139	23	72	655
3212	139	32	59	53
3213	139	45	131	1
3214	139	46	145	1
3215	139	47	107	17
3216	139	30	169	2
3217	139	49	138	554
3218	139	31	125	3
3219	139	33	40	6
3220	139	34	83	12
3221	139	35	104	125
3222	140	2	295	191
3223	140	43	491	98
3224	140	40	5	16
3225	140	11	6	1
3226	140	14	239	119
3227	140	7	1000	3000
3228	140	8	104	2505
3229	140	16	135	1354
3230	140	17	38	161
3231	140	18	30	1451
3232	140	22	76	13
3233	140	20	123	13
3234	140	21	295	2066
3235	140	23	282	2538
3236	140	32	18	16
3237	140	45	32	0
3238	140	46	304	3
3239	140	47	6	0
3240	140	30	104	1
3241	140	49	107	428
3242	140	31	314	7
3243	140	33	107	16
3244	140	34	75	11
3245	140	35	204	245
3246	141	2	229	149
3247	141	43	261	52
3248	141	40	1	4
3249	141	11	0	0
3250	141	14	460	230
3251	141	7	267	802
3252	141	8	56	1362
3253	141	16	20	206
3254	141	17	66	278
3255	141	18	54	2552
3256	141	22	46	8
3257	141	20	86	9
3258	141	21	284	1994
3259	141	23	65	592
3260	141	32	1	1
3261	141	45	69	0
3262	141	46	80	1
3263	141	47	662	105
3264	141	30	440	5
3265	141	49	14	58
3266	141	31	169	4
3267	141	33	32	4
3268	141	34	22	3
3269	141	35	17	20
3270	142	2	646	420
3271	142	43	818	163
3272	142	40	19	58
3273	142	11	82	20
3274	142	14	300	150
3275	142	7	549	1649
3276	142	8	154	3715
3277	142	16	204	2048
3278	142	17	39	164
3279	142	18	57	2687
3280	142	22	49	8
3281	142	20	132	14
3282	142	21	419	2938
3283	142	23	247	2226
3284	142	32	17	15
3285	142	45	67	0
3286	142	46	175	2
3287	142	47	51	8
3288	142	30	94	1
3289	142	49	44	179
3290	142	31	281	6
3291	142	33	57	8
3292	142	34	105	15
3293	142	35	58	70
3294	143	2	179	116
3295	143	43	233	46
3296	143	40	2	7
3297	143	11	8	2
3298	143	14	230	115
3299	143	7	138	414
3300	143	8	71	1719
3301	143	16	82	824
3302	143	17	34	143
3303	143	18	26	1247
3304	143	22	19	3
3305	143	20	74	8
3306	143	21	189	1326
3307	143	23	47	425
3308	143	32	74	67
3309	143	45	49	0
3310	143	46	71	0
3311	143	47	249	39
3312	143	30	188	2
3313	143	49	14	59
3314	143	31	115	2
3315	143	33	16	2
3316	143	34	29	4
3317	143	35	14	16
3318	144	2	520	338
3319	144	43	765	153
3320	144	40	2	6
3321	144	11	0	0
3322	144	14	516	258
3323	144	7	362	1086
3324	144	8	147	3532
3325	144	16	283	2839
3326	144	17	63	268
3327	144	18	60	2865
3328	144	22	102	18
3329	144	20	474	52
3330	144	21	484	3389
3331	144	23	120	1084
3332	144	32	0	0
3333	144	45	54	0
3334	144	46	241	3
3335	144	47	255	40
3336	144	30	252	3
3337	144	49	41	166
3338	144	31	966	23
3339	144	33	23	3
3340	144	34	32	4
3341	144	35	23	27
3342	145	2	263	171
3343	145	43	396	79
3344	145	40	8	24
3345	145	11	34	8
3346	145	14	224	112
3347	145	7	433	1299
3348	145	8	131	3166
3349	145	16	186	1867
3350	145	17	36	151
3351	145	18	34	1612
3352	145	22	36	6
3353	145	20	117	12
3354	145	21	279	1954
3355	145	23	130	1172
3356	145	32	33	29
3357	145	45	49	0
3358	145	46	171	2
3359	145	47	47	7
3360	145	30	98	1
3361	145	49	63	255
3362	145	31	206	4
3363	145	33	47	7
3364	145	34	47	7
3365	145	35	59	71
3366	146	2	230	149
3367	146	43	153	30
3368	146	40	14	43
3369	146	11	117	29
3370	146	14	112	56
3371	146	7	54	164
3372	146	8	78	1894
3373	146	16	14	140
3374	146	17	43	182
3375	146	18	59	2817
3376	146	22	27	4
3377	146	20	47	5
3378	146	21	92	650
3379	146	23	8	79
3380	146	32	70	63
3381	146	45	58	0
3382	146	46	62	0
3383	146	47	164	26
3384	146	30	160	2
3385	146	49	94	378
3386	146	31	38	0
3387	146	33	3	0
3388	146	34	101	15
3389	146	35	122	147
3414	148	2	193	125
3415	148	43	344	68
3416	148	40	10	30
3417	148	11	39	9
3418	148	14	102	51
3419	148	7	107	323
3420	148	8	78	1880
3421	148	16	114	1145
3422	148	17	30	130
3423	148	18	38	1800
3424	148	22	16	2
3425	148	20	63	6
3426	148	21	151	1058
3427	148	23	95	858
3428	148	32	247	223
3429	148	45	39	0
3430	148	46	85	1
3431	148	47	30	4
3432	148	30	88	1
3433	148	49	77	309
3434	148	31	76	1
3435	148	33	14	2
3436	148	34	21	3
3437	148	35	79	95
3462	150	2	93	60
3463	150	43	99	19
3464	150	40	6	19
3465	150	11	58	14
3466	150	14	68	34
3467	150	7	80	240
3468	150	8	34	816
3469	150	16	33	338
3470	150	17	8	36
3471	150	18	10	489
3472	150	22	25	4
3473	150	20	22	2
3474	150	21	67	470
3475	150	23	19	177
3476	150	32	1	1
3477	150	45	12	0
3478	150	46	38	0
3479	150	47	15	2
3480	150	30	17	0
3481	150	49	10	42
3482	150	31	37	0
3483	150	33	9	1
3484	150	34	6	0
3485	150	35	10	12
3390	147	2	164	106
3391	147	43	168	33
3392	147	40	22	68
3393	147	11	86	21
3394	147	14	269	134
3395	147	7	125	377
3396	147	8	116	2788
3397	147	16	92	920
3398	147	17	91	383
3399	147	18	114	5359
3400	147	22	59	10
3401	147	20	88	9
3402	147	21	241	1692
3403	147	23	23	215
3404	147	32	456	410
3405	147	45	129	1
3406	147	46	139	1
3407	147	47	359	57
3408	147	30	399	5
3409	147	49	137	549
3410	147	31	91	2
3411	147	33	15	2
3412	147	34	68	10
3413	147	35	149	179
3438	149	2	151	98
3439	149	43	232	46
3440	149	40	4	12
3441	149	11	4	1
3442	149	14	368	184
3443	149	7	254	762
3444	149	8	148	3563
3445	149	16	141	1415
3446	149	17	48	201
3447	149	18	47	2232
3448	149	22	39	7
3449	149	20	155	17
3450	149	21	309	2168
3451	149	23	67	611
3452	149	32	2	2
3453	149	45	79	0
3454	149	46	149	1
3455	149	47	276	44
3456	149	30	256	3
3457	149	49	19	79
3458	149	31	421	10
3459	149	33	23	3
3460	149	34	15	2
3461	149	35	6	7
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recipes (id, title, image, servings, tcook, cuisine, mealtype, dishtype, source, url, user_id, calories) FROM stdin;
6	Healthy Keto Salmon Paté recipes	https://www.edamam.com/web-img/055/0550a959edd604f79757a4f3e3134238	8	30	\N	appetizer	\N	ketodietapp.com	http://ketodietapp.com/Blog/post/2015/09/21/healthy-keto-salmon-pate	\N	1620
7	Keto Chocolate Smoothie recipes	https://www.edamam.com/web-img/083/0834f93ea42c9df7e2faf4125f2b13c1	2	10	\N	\N	\N	Elana's Pantry	https://elanaspantry.com/keto-chocolate-smoothie/	\N	1212
8	Keto Blueberry Lemon Bread recipes	https://www.edamam.com/web-img/e5e/e5efd86065aecc1e276aa2590f7a6c97	16	65	\N	\N	\N	Elana's Pantry	https://elanaspantry.com/keto-blueberry-lemon-bread/	\N	2662
9	Keto Mixed Green Spring Salad recipes	https://www.edamam.com/web-img/332/332c010aad78689ef18d1d02b3b44127	1	20	\N	\N	\N	ruled.me	http://www.ruled.me/keto-mixed-green-spring-salad/	\N	638
10	Keto Crepes recipes	https://www.edamam.com/web-img/835/835f91bc0dac7f322f75b85b2eba3ce6	4	20	\N	\N	\N	ditchthecarbs.com	http://www.ditchthecarbs.com/2016/01/25/keto-crepes/	\N	806
11	Keto Chocolate Cake recipes	https://www.edamam.com/web-img/962/962c283e4a2201b4ec71a5b1b6971f3d	12	2	\N	\N	\N	fluffychixcook.com	http://fluffychixcook.com/keto-chocolate-cake/	\N	2482
12	Blueberry cream cheese low-carb, Keto filling	https://www.edamam.com/web-img/273/273a4b60c89555489998d6896bcd7bc9.jpg	24	20	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3340233	\N	867
13	Vegetarian Keto Burgers recipes	https://www.edamam.com/web-img/0ed/0ed68f9e847d4d48d81ad3b65dfd000b	2	20	\N	\N	\N	ketodietapp.com	http://ketodietapp.com/Blog/post/2015/05/21/vegetarian-keto-burgers	\N	921
14	Keto Cheddar Bay Biscuits and Bacon Butter	https://www.edamam.com/web-img/830/830314613370d77bc4507505a64ba635.jpg	9	25	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/breads/keto-cheddar-bay-biscuits-and-bacon-butter/	\N	3767
15	Keto Friendly BBQ Sauce - Low Carb Chicken Wing	https://www.edamam.com/web-img/366/366a6045c5310caae7501bcfd694845a.jpg	4	25	\N	\N	\N	ifood.tv	https://ifood.tv/ingredient/1030443-keto-friendly-bbq-sauce-low-carb-chicken-wing	\N	2316
16	Keto Tortillas	https://www.edamam.com/web-img/a2f/a2f235d0aa3758d888f1a779a71bf6b6.jpg	8	25	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/263603/keto-tortillas/	\N	857
17	Keto Salmon Curry Recipe [Paleo, Low-Carb]	https://www.edamam.com/web-img/706/7060181b2afac2d5ff85f1144d616a8f.jpg	2	0	\N	\N	\N	Foodista	http://www.foodista.com/recipe/5DBHMBYJ/keto-salmon-curry-recipe-paleo-low-carb	\N	1447.5172931000714
18	Keto Salmon and Creamy Turmeric Veggies recipes	https://www.edamam.com/web-img/304/304914883022d17ef1644af7afebee93	4	45	\N	\N	\N	healthfulpursuit.com	http://www.healthfulpursuit.com/2016/06/keto-salmon-turmeric-veggies/	\N	2296.2394806867496
19	Keto Salmon & Cream Cheese Mug Muffin recipes	https://www.edamam.com/web-img/499/499142a0cf4d6cc69e9e8b0dcf386757	2	5	\N	\N	\N	ketodietapp.com	http://ketodietapp.com/Blog/post/2015/07/16/keto-salmon-and-cream-cheese-mug-muffin	\N	731.1797751548881
20	Keto Rosemary Dill Salmon recipes	https://www.edamam.com/web-img/f55/f55dfad03e12e17f0e53004af6c0f158	6	25	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-rosemary-dill-salmon/	\N	3668.9134166661033
21	Keto Sushi recipes	https://www.edamam.com/web-img/db6/db65bc6245fd1947f4515acf37c852b7	3	40	\N	\N	\N	ruled.me	https://www.ruled.me/keto-sushi/	\N	1083.97801730625
22	"Everything Bagel and Lox" KETO BOMB	https://www.edamam.com/web-img/4e4/4e44088d0806bbcf1e0e001414f7c602.jpg	9	14	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3400422	\N	269.18144660923844
23	Indian Coconut Curry Salmon	https://www.edamam.com/web-img/4f5/4f54334e3bbd35c0d0070bc2e7997504.jpg	2	20	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/main-courses/indian-coconut-curry-salmon/	\N	956.4658899200001
24	Salmon cutlets with lime and coriander butter	https://www.edamam.com/web-img/82a/82ade15f438e6d39451f9141dc45a442.jpeg	4	15	\N	\N	\N	taste.com.au	https://www.taste.com.au/recipes/salmon-cutlets-lime-coriander-butter/d16360e9-e461-444a-8a90-cde37a55ba9b	\N	4059.792124866801
25	Aunt Rocky’s Parmesan Crusted Salmon (Gluten Free, Low Carb)	https://www.edamam.com/web-img/1e3/1e3c17af800b2bce0f3e00e9af02ddf9.png	4	20	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/gluten-free/aunt-rockye28099s-parmesan-crusted-salmon-gluten-free-low-carb/	\N	1048.6587222
26	Keto Omelet Wrap & Why Eggs Are So Good For Us recipes	https://www.edamam.com/web-img/816/816760afd7a4e325048abd9b3d822f9a	4	20	\N	\N	\N	ketodietapp.com	http://ketodietapp.com/Blog/post/2013/06/05/Keto-Omelet-Wrap-Why-Eggs-Are-So-Good-For-Us	\N	721.6999759999999
27	Air Fryer Low Carb Salmon Cakes	https://www.edamam.com/web-img/c63/c630b36041f54d802799cdad4061c706.jpg	4	50	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/gluten-free/air-fryer-low-carb-salmon-cakes/	\N	2947.9365601066856
28	Keto Fish Pie recipes	https://www.edamam.com/web-img/401/401d2df0291ce2b4c789ffda6d6e2d5c	6	75	\N	\N	\N	ketodietapp.com	http://ketodietapp.com/Blog/post/2015/09/30/keto-fish-pie	\N	3781.9867972241004
29	Aunt Rocky’s Salmon and Spinach Tart (Gluten-Free, Low Carb)	https://www.edamam.com/web-img/16f/16f69aa7e1c24d8db3a02d44d0b0619c.png	6	55	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/aunt-rockye28099s-salmon-and-spinach-tart-gluten-free-low-carb/	\N	2777.93846294542
30	Easy Low-Carb Keto Broccoli Cheddar Soup	https://www.edamam.com/web-img/c4b/c4be8b5ad45fd15d8d976b019507815b.jpg	6	35	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/261029/easy-low-carb-keto-broccoli-cheddar-soup/	\N	2596.118868799922
31	Keto Broccoli Cheese Soup	https://www.edamam.com/web-img/765/765abca83b32fd4db7bde1b9b7935d33.jpg	6	40	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3326271	\N	3066.9511046
32	Easy Keto Broccoli Slaw Recipe (Low Carb a	https://www.edamam.com/web-img/6c5/6c5bf6796556977e25faee6d840508b0.jpg	4	0	\N	\N	\N	ibreatheimhungry.com	http://www.ibreatheimhungry.com/2014/01/easy-keto-broccoli-slaw-recipe-low-carb-gluten-free.html	\N	809.6069999996736
33	Keto Broccoli & Cheese Soup {low carb}	https://www.edamam.com/web-img/c6f/c6f2528d90458a08ee72adf948f75647.jpg	14	0	\N	\N	\N	kaseytrenum.com	http://kaseytrenum.com/keto-broccoli-cheese-soup-low-carb/	\N	4029.0151306500225
34	Keto Broccoli Cheddar Muffins (Gluten-free/Low Carb) recipes	https://www.edamam.com/web-img/282/282a945d1ea1977f166abb674b8d8929	6	45	\N	\N	\N	mypcoskitchen.com	http://www.mypcoskitchen.com/keto-broccoli-cheddar-muffins/	\N	2288.2671791944117
35	Broccoli & Chicken Stir Fry Recipe – Low Carb, Keto & Paleo recipes	https://www.edamam.com/web-img/fe9/fe97d0a2b9ee4dca479fe5e4bafd5a69	4	30	\N	\N	\N	yummyinspirations.net	http://www.yummyinspirations.net/2017/05/chicken-stir-fry-recipe-low-carb-keto-paleo/	\N	1475.738498
36	Cheesy Broccoli and Chicken Casserole	https://www.edamam.com/web-img/fef/fef82a0e10f472e5cc19d8da4b2dc855.jpg	10	85	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/260604/cheesy-broccoli-and-chicken-casserole/	\N	7081.993804799881
37	Keto cheesy broccoli soup	https://www.edamam.com/web-img/f4f/f4f18e4cb35dd74f90799f4b8bee751c.jpg	6	25	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3357137	\N	2544.2760000000003
38	Keto Shepherd’s Pie recipes	https://www.edamam.com/web-img/839/8398cd0ab6f69f87f3b9f9fccb574a36	14	60	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-shepherds-pie-recipe/	\N	4273.079239600001
39	Keto Low Carb Beef and Broccoli	https://www.edamam.com/web-img/ce9/ce9c96d41051035335f9a712ba5495b0.jpg	2	25	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/main-courses/keto-low-carb-beef-and-broccoli/	\N	730.6657052469567
40	Paleo Beef with Broccoli (Whole30/Keto friendly) recipes	https://www.edamam.com/web-img/2aa/2aab4640296447ce6b781cd76100a12c	4	25	\N	\N	\N	iheartumami.com	http://iheartumami.com/paleo-beef-with-broccoli/	\N	1870.2841570545688
41	A Simple Low-Carb Keto Breakfast recipes	https://www.edamam.com/web-img/12f/12f527c9252869c8c8cce3cd8c5087ad	1	20	\N	\N	\N	mypcoskitchen.com	http://www.mypcoskitchen.com/keto-breakfast/	\N	646.0008125004636
42	[DRESSING INGREDIENTS MISSING] Keto Mediterranean Broccoli Salad	https://www.edamam.com/web-img/417/41794c2ca3e72da8c499ab061bf3806f.jpg	8	50	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/salads/dressing-ingredients-missing-keto-mediterranean-broccoli-salad/	\N	550.5683333346398
43	Keto Chicken and Broccoli Casserole	https://www.edamam.com/web-img/6f7/6f73c08bb83bfbc0f14d4c4cb641ca00.jpg	6	0	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3278789	\N	4666.694420231251
44	Aunt Rocky’s Broccoli Slaw with Almond Butter Dip/Dressing	https://www.edamam.com/web-img/d73/d73e7ad7593a2a90d9f9290bd309a267.jpg	1	10	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/salads/aunt-rockye28099s-broccoli-slaw-with-almond-butter-dipdressing/	\N	480.6155322366251
45	Broccoli Cheddar Soup (Keto-3.7 net carbs per serving)	https://www.edamam.com/web-img/cce/cce47ffa709159fca8c6e767b56989b7.jpg	10	40	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=2501871	\N	4153.04
46	Low carb Broccoli salad	https://www.edamam.com/web-img/f81/f81798ed006952bfeb1af85c59d29d11.jpg	6	25	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3377928	\N	2124.002
47	Broccoli chedder soup	https://www.edamam.com/web-img/1a0/1a048513d0312d4aaefc5955285d9254.jpg	20	35	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3415416	\N	8468.45993057251
48	Aunt Rocky’s Ham and Broccoli Divan (LCHF)	https://www.edamam.com/web-img/fdb/fdb8de024bb021048b9b7f96b51faff2.jpg	4	45	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/soups/aunt-rockye28099s-ham-and-broccoli-divan-lchf/	\N	1304.7184197126508
54	Keto Gluten-Free Almond Carrot Cake recipes	https://www.edamam.com/web-img/efc/efc194be040cca5934686c2327411c73	8	50	\N	\N	\N	twosleevers.com	https://twosleevers.com/2017/06/keto-gluten-free-almond-carrot-cake-2/	\N	2121.771
55	Keto Mini Vanilla Cloud Cakes recipes	https://www.edamam.com/web-img/95c/95cb2324f13bd59e7b8948c402cc8260	8	55	\N	\N	\N	ruled.me	http://www.ruled.me/keto-mini-vanilla-cloud-cakes/	\N	2546.9559054000006
56	Keto Mug Cake	https://www.edamam.com/web-img/25b/25bdce3445eeb584290c105896d9394f.jpg	2	6	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3020121	\N	692.2543407995278
57	Dark Chocolate Espresso Paleo and Keto Mug Cake	https://www.edamam.com/web-img/ac8/ac8cd27992e94d8a1f7a0037f32bddb2.jpg	1	9	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/263746/dark-chocolate-espresso-paleo-and-keto-mug-cake/	\N	929.6625931487689
58	Keto Chocolate Cake in a Mug recipes	https://www.edamam.com/web-img/941/941cd32d4e57b4194126772f5da3a20a	12	35	\N	\N	\N	ruled.me	https://www.ruled.me/keto-chocolate-cake-mug/	\N	413.78366666618473
59	Keto Chocolate Peanut Butter Mug Cake recipes	https://www.edamam.com/web-img/d92/d923e2e6d8f5d28ae5786cdb83652f55	1	6	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-chocolate-peanut-butter-mug-cake/	\N	478.1094999995644
60	One Minute Keto Chocolate Mug Cake	https://www.edamam.com/web-img/c22/c2224394f90c3c0d6d9e81bc2b865371.jpg	4	0	\N	\N	\N	isavea2z.com	https://www.isavea2z.com/one-minute-keto-chocolate-mug-cake/	\N	588.4549999967414
61	Chocolate mug cake	https://www.edamam.com/web-img/0c7/0c7ed3e235f96e64913576b93412340a.jpg	1	0	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3420881	\N	249.47699999905393
62	Lemon Mug Cake	https://www.edamam.com/web-img/09a/09a8e89096646433109f8827b870dc6d.jpg	1	2	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3169711	\N	715.585916666226
63	Keto-Friendly Brownie Cakes	https://www.edamam.com/web-img/f0e/f0e13d4ea50c20179a9995e844cafc90.jpg	6	29	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/260367/keto-friendly-brownie-cakes/	\N	783.1019384641893
64	Keto Dark Chocolate Bulletproof Coffee	https://www.edamam.com/web-img/eb2/eb297c9982f6a57942512f0db89901c9.jpg	4	12	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3212194	\N	760.178
65	Keto Flourless Chocolate Brownies recipes	https://www.edamam.com/web-img/b11/b11a5c6c0cd0cacd67133f7e0f1fc565	6	45	\N	\N	\N	twosleevers.com	https://twosleevers.com/2017/06/five-ingredient-keto-flourless-chocolate-brownies/	\N	1573.501
66	Blueberry Keto Cake recipes	https://www.edamam.com/web-img/c0c/c0c9bff679e5aa03fd9867007d9dee1f	4	35	\N	\N	\N	yumdimsum.me	http://www.yumdimsum.me/keto-cake/	\N	1690.557
67	Keto Mint Chocolate Chip Ice Cream recipes	https://www.edamam.com/web-img/9d4/9d44158d78d9eab41cefcf6f6a80a42e	4	35	\N	\N	\N	cavemanketo.com	http://cavemanketo.com/keto-mint-chocolate-chip-ice-cream/	\N	1345.6443333333632
68	Vegan Keto Granola Bars	https://www.edamam.com/web-img/0f4/0f49a1e17c181b6181c6e4ce624d1df1.jpg	8	40	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/vegan-keto-granola-bars/	\N	1853.4036060519738
69	Coconut Chocolate Chip Cookies - Keto and LactoPaleo recipes	https://www.edamam.com/web-img/cda/cda82df0ee7060380af459f014bcc5a0	12	50	\N	\N	\N	blondiespaleojourney.weebly.com	http://blondiespaleojourney.weebly.com/my-blog/coconut-chocolate-chip-cookies-keto-and-lactopaleo	\N	3564.6384526998013
70	hat_wright KETO choc chip cookie dough fat bombs	https://www.edamam.com/web-img/da6/da62202ee8b5adadd51b80fe5f72b6ae.jpg	24	10	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3427741	\N	6823.959999999999
71	Sugar-Free Keto Granola Bars	https://www.edamam.com/web-img/fca/fcac37ee6277ff07b07b975c6f51f2d0.jpg	12	40	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/sugar-free/sugar-free-keto-granola-bars/	\N	2416.4569999996893
72	Strawberry chocolate chip cheesecake	https://www.edamam.com/web-img/180/1802737f427989b5ebf49cbcef77b5d7.jpg	8	15	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3299528	\N	2071.1829526976235
73	Aunt Rocky’s Chocolate Chip Flax & Hemp Cookies (Allergen Friendly)	https://www.edamam.com/web-img/d65/d65b1f6fca191b0dfd88dfdd8bc5cd19.jpg	36	29	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/gluten-free/aunt-rockye28099s-chocolate-chip-flax-hemp-cookies-allergen-friendly/	\N	3285.418062435775
74	Aunt Rocky’s Triple Chocolate Muffin (LCHF)	https://www.edamam.com/web-img/faa/faaeacd182964177f4383baa1e3eac5c.jpeg	12	32	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/breads/aunt-rockye28099s-triple-chocolate-muffin-lchf/	\N	2308.3101329970586
75	Aunt Rocky’s Sugar Free Pecan Fudge	https://www.edamam.com/web-img/78f/78fde42940bb5a83eb18712fb0fb7cbe.png	20	25	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/gluten-free/aunt-rockye28099s-sugar-free-pecan-fudge/	\N	1956.0679803312498
76	Aunt Rocky’s Low Carb Pumpkin Cranberry Cookies (Gluten-free, Sugar-free, Coconut-free)	https://www.edamam.com/web-img/546/5462ba1ea8046859ff32afa54cb227f0.png	34	35	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/gluten-free/aunt-rockye28099s-low-carb-pumpkin-cranberry-cookies-gluten-free-sugar-free-coconut-free/	\N	2094.577666665721
77	Aunt Rocky’s Peppermint Mocha Cookies (Low Carb, Gluten-Free)	https://www.edamam.com/web-img/4d1/4d1e93b395f1a8d621aa6dda1e2733b9.jpg	24	20	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/desserts/aunt-rockye28099s-peppermint-mocha-cookies-low-carb-gluten-free/	\N	1182.641083328751
78	Aunt Rocky’s Maple Ricotta Porridge (LCHF)	https://www.edamam.com/web-img/d28/d28ebc8a5a2764fb50f436eb287bcc4d.jpg	1	7	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/aunt-rockye28099s-maple-ricotta-porridge-lchf/	\N	340.27196691126943
79	Aunt Rocky’s Meyer Lemon Blueberry Poke Cake	https://www.edamam.com/web-img/665/6655783bc8d78560c1260b46218a0dfd.jpg	6	45	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/aunt-rockye28099s-meyer-lemon-blueberry-poke-cake/	\N	1271.0266416677168
80	Keto almond bread	https://www.edamam.com/web-img/533/53322c6ef6a3c8b350d471313ad0694c.jpg	2	0	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3285702	\N	342.048
81	Keto Waffles recipes	https://www.edamam.com/web-img/0fd/0fd0f396b2eda5b25c9d30515fea5167	5	30	\N	\N	\N	ditchthecarbs.com	http://www.ditchthecarbs.com/2015/12/08/keto-waffles/	\N	1373.6359999979375
82	Keto Waffles Stuffed with Cream Cheese [Recipe] recipes	https://www.edamam.com/web-img/b12/b122bbc0bcaa131f411049e877a0c209	4	7	\N	\N	\N	ketogasm.com	http://ketogasm.com/keto-waffles-stuffed-cream-cheese-recipe/	\N	865.5609999925506
83	1 Carb Waffles Low Carb Breakfast Recipe / Keto	https://www.edamam.com/web-img/be6/be64a8bf667516a251edb9fa42ae7189.jpg	1	5	\N	\N	\N	ifood.tv	https://ifood.tv/waffle/1018837-1-carb-waffles-low-carb-breakfast-recipe-keto	\N	1440.77953643
84	Keto Chocolate Waffles recipes	https://www.edamam.com/web-img/3b1/3b1be1c03d8d29f68d286eed256c8e59	5	35	\N	\N	\N	ditchthecarbs.com	http://www.ditchthecarbs.com/2016/11/09/keto-chocolate-waffles/	\N	1422.6559999979374
85	Low carb Cream Cheese Waffle	https://www.edamam.com/web-img/adc/adc160bd1b92f82c4c115e3f37a4b447.jpg	4	25	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3379085	\N	689.1574999979374
86	Instant Pot® Roasted Brussels Sprouts with Pancetta	https://www.edamam.com/web-img/79a/79a4827b46e3c379399be58ca308ba34.jpg	6	35	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/262558/instant-pot-roasted-brussels-sprouts-with-pancetta/	\N	824.75152859428
87	Buttered Brussels Sprouts recipes	https://www.edamam.com/web-img/8be/8be69d5b9c7b395277c51f18775a7a72	4	50	\N	\N	\N	ketodietapp.com	http://ketodietapp.com/Blog/post/2014/12/24/Buttered-Brussels-Sprouts	\N	3179.4042109062502
88	Keto Au Gratin Brussels Sprouts recipes	https://www.edamam.com/web-img/9f0/9f0540488b27175f72b5dfeb3c573f4b	4	45	\N	\N	\N	ruled.me	http://www.ruled.me/keto-au-gratin-brussels-sprouts/	\N	1259.3260821325073
89	Keto Sriracha “Spaghetti" + Meatballs recipes	https://www.edamam.com/web-img/5d3/5d3cb94dc8f3b47d1e77beee54bb5b77	4	60	\N	\N	\N	healthfulpursuit.com	https://www.healthfulpursuit.com/2015/02/sriracha-spaghetti-meatballs-paleo-low-carb-keto/	\N	2309.572479999885
90	Keto Cabbage With Bacon recipes	https://www.edamam.com/web-img/1e1/1e198dc189aca80b51935309a6da2c33	4	20	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-cabbage-with-bacon/	\N	518.72
91	Bacon Cabbage Chuck Roast Stew - Keto Makeover	https://www.edamam.com/web-img/9f3/9f3fdd59a8551a1afec0993f89b1cb3c.jpg	8	430	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3357651	\N	5191.03050325
92	Cabbage Soup Recipe [Keto & Low Carb] recipes	https://www.edamam.com/web-img/b5b/b5b07538252fd8a8d750aac346c34538	9	50	\N	\N	\N	ketogasm.com	http://ketogasm.com/cabbage-soup-recipe/	\N	2784.3654102835126
93	Aunt Rocky’s Fried Cabbage with Bacon and Onions	https://www.edamam.com/web-img/6a8/6a8ecd8150633844614a26a21a85f38f.png	3	25	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/aunt-rockye28099s-fried-cabbage-with-bacon-and-onions/	\N	631.871050038268
94	Unwrapped Pork Eggrolls	https://www.edamam.com/web-img/d22/d22e21799a6f18c4a0b3860c185f9107	6	35	\N	\N	\N	justapinch.com	https://www.justapinch.com/recipes/main-course/casseroles/unwrapped-pork-eggrolls.html	\N	1475.6971019000002
95	Aunt Rocky’s Red Cabbage Salad With Creamy Balsmic Dressing	https://www.edamam.com/web-img/e52/e52b2a9e60cc1c06b077877c29b9f071.jpg	2	5	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/aunt-rockye28099s-red-cabbage-salad-with-creamy-balsmic-dressing/	\N	299.4849999966217
96	Keto Egg Roll in a Bowl [Recipe] recipes	https://www.edamam.com/web-img/367/36762df0599a017df2533807199ef4b2	6	20	\N	\N	\N	ketogasm.com	http://ketogasm.com/keto-egg-roll-bowl-recipe/	\N	1650.1341071459135
97	Keto turkey egg roll casserole	https://www.edamam.com/web-img/df0/df04ac0504d8426cca732e4cdfa7dc63.jpg	15	30	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3399251	\N	1854.6160813929812
98	Fried cabbage and sausage	https://www.edamam.com/web-img/eeb/eeb8c88243e19f59d84ded8d14ca3946.jpg	4	30	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3231386	\N	1249.7095735500002
100	Keto Lo Mein - Low Carb & Gluten Free	https://www.edamam.com/web-img/fa8/fa8cef54b9bde921fd92cceb64a2cb85.jpg	6	0	\N	\N	\N	ibreatheimhungry.com	http://www.ibreatheimhungry.com/2017/04/keto-lo-mein-low-carb-gluten-free.html	\N	1165.9799999998538
102	Aunt Rocky’s Roast Beef & Veggie Soup	https://www.edamam.com/web-img/8d6/8d61bc7df73fa1924a0213c45bc4af90.jpg	6	75	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/soups/aunt-rockye28099s-roast-beef-veggie-soup/	\N	1914.0321439605034
104	Aunt Rocky’s Low Carb Stir Fry (Gluten Free)	https://www.edamam.com/web-img/353/35308763ec658fa4eb55bf57d5c68471.jpg	4	30	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/gluten-free/aunt-rockye28099s-low-carb-stir-fry-gluten-free/	\N	1318.6302568081908
106	Rebekah's Keto Egg Casserole	https://www.edamam.com/web-img/da7/da7b7bb6b582e892103f4b38c7133b1a.jpg	8	50	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/260377/rebekahs-keto-egg-casserole/	\N	2961.1306475961
108	Keto Egg Salad recipes	https://www.edamam.com/web-img/ad9/ad9ecd8bafc600bf0c90162779b17409	4	25	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-egg-salad/	\N	1686.3377777777778
110	Keto Egg Drop Soup	https://www.edamam.com/web-img/a60/a6083652c08fe49286045c539c888256.jpg	4	12	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3305162	\N	705.088
112	Keto Egg Nog recipes	https://www.edamam.com/web-img/b81/b8177bf8b63c9148dda7837205dde63d	8	15	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-egg-nog/	\N	2235.6394999999998
114	KETO Egg and Ham Soup	https://www.edamam.com/web-img/cc3/cc3decfdc5c2e61724f6fa44c1f48d61.jpg	2	6	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3325534	\N	346.53999999999996
116	Keto egg and cheese bites	https://www.edamam.com/web-img/ae7/ae7cefa8c4da69de3a9cc9097576f5d6.jpg	2	13	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3273010	\N	320.47968684531253
118	Keto Bread recipes	https://www.edamam.com/web-img/de7/de72ce793f54593f3a12122325a6ddb1	4	30	\N	\N	\N	yumdimsum.me	http://www.yumdimsum.me/keto-bread/	\N	906.804
120	Keto Hashbrowns	https://www.edamam.com/web-img/bf1/bf10d54cd4257034262a3f8c50cd3f43.jpg	4	0	\N	\N	\N	mysugarfreejourney.com	http://mysugarfreejourney.com/crispy-keto-cauliflower-hashbrown-recipe/	\N	475.30012500000004
121	Keto Avocado Dessert	https://www.edamam.com/web-img/38a/38a50ce221c043a675eaa65a45282760.jpg	2	70	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/254789/keto-avocado-dessert/	\N	531.5045
123	Keto Avocado Cheese Dip recipes	https://www.edamam.com/web-img/7b6/7b6f51a487abd1ecdef3cbd08f284c6a	12	20	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-avocado-cheese-dip/	\N	3427.239617962394
99	Aunt Rocky’s Red Cabbage Slaw	https://www.edamam.com/web-img/7d9/7d9af73729b44e772f70df4708d40aa5.jpg	6	10	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/aunt-rockye28099s-red-cabbage-slaw/	\N	481.49525
101	Aunt Rocky’s German-Style Boiled Cabbage	https://www.edamam.com/web-img/f3f/f3f6fe2d16d0134a5a4c00a7aa9b9716.jpg	4	20	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/sidedishes/aunt-rockye28099s-german-style-boiled-cabbage/	\N	379.67224999999996
103	Lisa's Chicken Vegetable soup	https://www.edamam.com/web-img/a09/a09a03abac3d494e6d156f6d1b01ca0b.jpg	10	35	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3360993	\N	558.4576262011369
105	Grandma’s Turkey Soup (LC/GF)	https://www.edamam.com/web-img/84a/84a953f441b618cebd1646349f970add.jpg	10	150	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/special-dietary-needs/grandmae28099s-turkey-soup-lcgf/	\N	1710.1065517515528
107	Keto Egg loaf	https://www.edamam.com/web-img/434/434fd61fcbc5921351c3c15c3303acd2.jpg	6	0	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3441121	\N	2190.6049527
109	5 Minute Keto Egg Drop Soup recipes	https://www.edamam.com/web-img/556/556c0ecc6a4fcf33d5b00a9626ac711f	1	35	\N	\N	\N	ruled.me	https://www.ruled.me/5-minute-keto-egg-drop-soup/	\N	397.23699999217456
111	Keto Egg Fried Rice recipes	https://www.edamam.com/web-img/4eb/4ebfc5e01e63522f8c04fa224d9c698d	4	50	\N	\N	\N	primalpalate.com	http://www.primalpalate.com/paleo-recipe/keto-egg-fried-rice/	\N	1138.4059999978188
113	AIP Bread Rolls Recipe [Paleo, Keto, Egg-Free, Nut-Free]	https://www.edamam.com/web-img/c3f/c3fc08c8ba37e276a79894a92d1d1d11.jpg	2	0	\N	\N	\N	Foodista	http://www.foodista.com/recipe/KPZSQXKF/aip-bread-rolls-recipe-paleo-keto-egg-free-nut-free	\N	471.1399999969061
115	Instant Pot® Paleo and Keto Egg Shakshuka with Kale	https://www.edamam.com/web-img/318/318db08d395187e1b0bdac7c36ea4406.jpg	4	30	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/263600/instant-pot-paleo-and-keto-egg-shakshuka-with-kale/	\N	636.0006666666667
117	Keto Muffins recipes	https://www.edamam.com/web-img/e04/e0477ba7b3ee39bc1f80b3c5550f5632	4	35	\N	\N	\N	ketoconnect.net	https://www.ketoconnect.net/recipe/keto-muffins/	\N	1973.1389527
119	Smoked Avocado With Egg And Bacon - Keto	https://www.edamam.com/web-img/66f/66f08a01e71eef8085fc14189c78e1e8.jpg	2	35	\N	\N	\N	ifood.tv	https://ifood.tv/course/1025304-smoked-avocado-with-egg-and-bacon-keto	\N	1662.7520000000002
122	Keto Avocado Dip	https://www.edamam.com/web-img/960/96063a75f8dd15ce43fe8c1d9297d184.jpg	4	0	\N	\N	\N	reviewsbypink.com	http://reviewsbypink.com/keto-avocado-dip/	\N	741.11
124	TLC - Easy Keto Avocado Dessert recipes	https://www.edamam.com/web-img/30c/30ccb9907c5c0effcabfed6588a1ac16	1	5	\N	\N	\N	thrivingonlowcarb.com	http://www.thrivingonlowcarb.com/easy-keto-avocado-dessert/	\N	789.908782171875
125	5-Min Prosciutto Avocado Fat Bomb Recipe [Paleo, Keto]	https://www.edamam.com/web-img/ff0/ff09148cb2a522a0be9394b3a9652bef.jpg	10	0	\N	\N	\N	Foodista	http://www.foodista.com/recipe/WQJMCVLV/5-min-prosciutto-avocado-fat-bomb-recipe-paleo-keto	\N	663.45
126	Keto Chicken Salad Stuffed Avocados recipes	https://www.edamam.com/web-img/8ce/8ce4fd67c784cf9d787b75728bd82141	4	10	\N	\N	\N	mymommystyle.com	http://www.mymommystyle.com/2017/06/27/keto-chicken-salad-stuffed-avocados/	\N	1950.5335393250002
127	Keto - friendly Chocolate Mousse recipes	https://www.edamam.com/web-img/a33/a33a6e97efe59e53d212939ca0398967	4	5	\N	\N	\N	mysweetketo.com	http://www.mysweetketo.com/recipe/keto-friendly-chocolate-mousse/	\N	519.4758828687501
128	Easy Keto Beef Tacos	https://www.edamam.com/web-img/8c0/8c0370f4b530f7d3866a1ccf80d59ff1.jpg	4	50	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/261032/easy-keto-beef-tacos/	\N	2649.4318697999997
129	ULTIMATE KETO LOW CARB BACON CHEESE BURGER	https://www.edamam.com/web-img/4e0/4e0620f1168fc3a150cd43fa52e034b1.jpg	4	0	\N	\N	\N	queenketo.com	http://queenketo.com/ultimate-keto-low-carb-bacon-cheese-burger-chips/	\N	758.5266666666668
130	KETO Chicken with sundried tomato and cream	https://www.edamam.com/web-img/805/8057e27c8492b687b88dbf159660f62c.jpg	4	20	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3390810	\N	612.140898875
131	Chai Pumpkin Keto Smoothie recipes	https://www.edamam.com/web-img/780/780e12bbe9624925d338f70a7452ccbe	1	5	\N	\N	\N	healthfulpursuit.com	http://www.healthfulpursuit.com/recipe/chai-pumpkin-keto-smoothie/	\N	649.1460833330718
132	Keto Salad recipes	https://www.edamam.com/web-img/d48/d48806d4fe5bad61d6be40653a453048	4	20	\N	\N	\N	ketoconnect.net	https://www.ketoconnect.net/recipe/keto-salad/	\N	873.8821931000001
133	Keto Breakfast Omelet With Black Olives and Fried Avocado recipes	https://www.edamam.com/web-img/fc8/fc8755cbf0f158cac8e89ba0be727aeb	4	11	\N	\N	\N	thenourishedcaveman.com	http://thenourishedcaveman.com/keto-breakfast-frittata-with-black-olives-and-fried-avocado/	\N	1247.6428144749998
134	Green Keto Smoothie	https://www.edamam.com/web-img/0b8/0b8049176c2df9c4f3905223e5da1f41.jpg	4	0	\N	\N	\N	appetiteforenergy.com	http://www.appetiteforenergy.com/green-keto-smoothie/	\N	460.3837915280606
135	Keto Breakfast Sausage & Guac Stacks recipes	https://www.edamam.com/web-img/2eb/2eb02a92dba79a62d1efe5573bfc1132	2	15	\N	\N	\N	ketodietapp.com	https://ketodietapp.com/Blog/post/2017/06/22/keto-breakfast-sausage-and-guac-stacks	\N	894.4548839779396
136	Keto Chili	https://www.edamam.com/web-img/c93/c936e332ef1018917d4418a5ba08739d.jpg	8	255	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/main-courses/keto-chili/	\N	1774.6898892000002
137	Keto Bacon Cheeseburger Casserole	https://www.edamam.com/web-img/006/0065bbca35b20503d685c0b52e6f3e54.jpg	6	50	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3391563	\N	3969.5448027
138	Keto Bacon Wrapped Chicken Tenders recipes	https://www.edamam.com/web-img/c47/c4741ef431fa1cfa0542f3592c8fcd7e	4	55	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-bacon-wrapped-chicken-tenders/	\N	1181.9969999996842
139	Keto Bacon Avocado Breakfast Cups recipes	https://www.edamam.com/web-img/f1d/f1dc6018b58407db55e6d1e763d65bfe	15	45	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-bacon-avocado-breakfast-cups/	\N	3328.4130859311545
140	Keto Bacon and Egg Florentine Muffins {& Some Weight Loss Updates} recipes	https://www.edamam.com/web-img/335/335b03fefbac911d021aa6fda2074a63	4	40	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-bacon-and-egg-florentine-muffins/	\N	2280.507220000093
141	Keto Spinach Stuffed Chicken recipes	https://www.edamam.com/web-img/3ec/3ec4ab6ec66f5591d3a281740be59dfe	6	40	\N	\N	\N	ditchthecarbs.com	http://www.ditchthecarbs.com/2017/01/11/keto-spinach-stuffed-chicken/	\N	2335.9425
142	Keto Almond-Crusted Bacon and Tomato Quiche	https://www.edamam.com/web-img/c2e/c2e6c36e3e14c041ba65cbf0dbdc9fc6.jpg	10	75	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/262458/keto-almond-crusted-bacon-and-tomato-quiche/	\N	4541.379999999684
143	Lazy Keto Chicken recipes	https://www.edamam.com/web-img/58b/58b341e5d4174a4bac0c8e7819b74bec	2	55	\N	\N	\N	cavemanketo.com	http://cavemanketo.com/lazy-keto-chicken/	\N	1563.8937304172875
144	Keto Cheeseburger Muffin	https://www.edamam.com/web-img/1bc/1bc953468ed93a1e327380bf0524b36e.jpg	12	35	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3062098	\N	4153.8692396
146	Keto Chicken Salad	https://www.edamam.com/web-img/a18/a184053bcba3cb4d0377ca2b85a70ef0.jpg	4	10	\N	\N	\N	tastykitchen.com	https://tastykitchen.com/recipes/salads/keto-chicken-salad/	\N	1689.8344999998299
148	Loaded Cauliflower (low carb, keto) recipes	https://www.edamam.com/web-img/86c/86cd9ee08c5ab5bb7762f991adaabe58	6	20	\N	\N	\N	lowcarbmaven.com	https://www.lowcarbmaven.com/loaded-cauliflower-low-carb-keto/	\N	1425.915592957625
150	Keto Mug Muffin with Bacon, Cheese & Mushrooms recipes	https://www.edamam.com/web-img/fb1/fb143eab9157e7791aeaa3365825dabc	2	15	\N	\N	\N	ketodietapp.com	https://ketodietapp.com/Blog/post/2016/08/24/keto-mug-muffin-with-bacon-cheese-and-mushrooms	\N	723.3695469524296
151	Keto Sweet Pecan Tuna Salad recipes	https://www.edamam.com/web-img/707/70775981111d3bf14ade96b229b33a19	4	20	\N	\N	\N	ketosizeme.com	http://ketosizeme.com/keto-sweet-pecan-tuna-salad/	\N	2441.3325
153	Brown Butter Pecan Keto Ice Cream recipes	https://www.edamam.com/web-img/d2f/d2fd868c17569a940d0f2aa88068601c	3	30	\N	\N	\N	ruled.me	https://www.ruled.me/brown-butter-pecan-keto-ice-cream/	\N	1555.5412500001585
155	Keto Diet Low Carb Pancakes	https://www.edamam.com/web-img/2ad/2adada5039ae5b0c4a4708383cebb2b9.jpg	1	20	\N	\N	\N	Allrecipes	https://www.allrecipes.com/recipe/263958/keto-diet-low-carb-pancakes/	\N	352.3185538446801
145	The Best Keto Tacos	https://www.edamam.com/web-img/343/343d6f211235f7cfcefc90e9cf357745.jpg	3	0	\N	\N	\N	Foodista	http://www.foodista.com/recipe/YN8J2P5T/the-best-keto-tacos	\N	2082.5895638875
147	Chicken Alfredo Bake Recipe {Paleo, Clean Eating, Gluten-Free, Dairy-Free, Whole30} recipes	https://www.edamam.com/web-img/dee/deed7c4f6a1f5b709bc383b487c65059	4	35	\N	\N	\N	mynaturalfamily.com	https://www.mynaturalfamily.com/recipes/paleo-recipes/chicken-alfredo-bake-paleo-clean-eating-gluten-free-dairy-free-whole30/	\N	1742.3144444444445
149	Keto Pizza – Turkey Crust Meatza recipes	https://www.edamam.com/web-img/693/69342f84cab5a3481f50b4fd74136a0f	8	45	\N	\N	\N	ketogasm.com	http://ketogasm.com/low-carb-pizza-turkey-crust-meatza/	\N	1697.2393390998757
152	Keto Candied Pecans	https://www.edamam.com/web-img/922/9224bf348b52236ec0d20eb55c1435a5.jpg	60	75	\N	\N	\N	recipes.sparkpeople.com	https://recipes.sparkpeople.com/recipe-detail.asp?recipe=3440620	\N	616.00761438125
154	Keto Maple Pecan Protein Bars recipes	https://www.edamam.com/web-img/d5b/d5b36ae4f60ee29d43fe6deb79678984	4	50	\N	\N	\N	ketodietapp.com	http://ketodietapp.com/Blog/post/2016/03/20/keto-maple-pecan-protein-bars	\N	4020.970036430865
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.units (id, name) FROM stdin;
1	g
2	mg
3	µg
4	%
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, password, email, image_url) FROM stdin;
1	nick.green	$2b$12$bw4V24btMs7oXPs99o427efnlzuym/5KKXzBMpH7CdPtHIqBUQlha	ngundobin@gmail.com	/static/images/default-pic.png
2	mark.curry123	$2b$12$uNxIOt7xWEdAkRzgENfCeuTFi2yu825201CBskZWLcgAhkjDOD9nm	dhjbf@gmail.com	/static/images/default-pic.png
3	nikgun1984	$2b$12$5VYRPLr1eWL3MX4c7aYuvOBFzHOl0gCzkUdUBAf9.Rny.jNhU6CZ2	big@gmail.com	/static/images/default-pic.png
5	nick.brown	$2b$12$VUliSBOtdQKk7KT/diBnWeaARblOcVxGkQC4.2LYoQE2DwbomVU/u	nbrown@gmail.com	/static/images/default-pic.png
\.


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ingredients_id_seq', 1300, true);


--
-- Name: instructions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.instructions_id_seq', 957, true);


--
-- Name: nutrients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.nutrients_id_seq', 50, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 93, true);


--
-- Name: recipe_has_nutrients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recipe_has_nutrients_id_seq', 3605, true);


--
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recipes_id_seq', 155, true);


--
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.units_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: instructions instructions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instructions
    ADD CONSTRAINT instructions_pkey PRIMARY KEY (id);


--
-- Name: nutrients nutrients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nutrients
    ADD CONSTRAINT nutrients_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: recipe_has_nutrients recipe_has_nutrients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipe_has_nutrients
    ADD CONSTRAINT recipe_has_nutrients_pkey PRIMARY KEY (id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: units units_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_name_key UNIQUE (name);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: ingredients ingredients_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id);


--
-- Name: instructions instructions_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instructions
    ADD CONSTRAINT instructions_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id);


--
-- Name: nutrients nutrients_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nutrients
    ADD CONSTRAINT nutrients_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: recipe_has_nutrients recipe_has_nutrients_nutrient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipe_has_nutrients
    ADD CONSTRAINT recipe_has_nutrients_nutrient_id_fkey FOREIGN KEY (nutrient_id) REFERENCES public.nutrients(id);


--
-- Name: recipe_has_nutrients recipe_has_nutrients_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipe_has_nutrients
    ADD CONSTRAINT recipe_has_nutrients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id);


--
-- Name: recipes recipes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

