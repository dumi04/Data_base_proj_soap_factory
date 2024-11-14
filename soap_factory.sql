--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

SET statement_timeout = 0; -- Setează limita de timp pentru executarea unei instrucțiuni la 0
SET lock_timeout = 0; --  Setează timpul de așteptare pentru obținerea unui lock la 0
SET idle_in_transaction_session_timeout = 0; -- Setează limita de timp pentru o sesiune inactivă într-o tranzacție la 0
SET client_encoding = 'UTF8'; -- Setează encoding-ul clientului la UTF-8
SET standard_conforming_strings = on; -- Activează conformitatea standard pentru șiruri de caractere
SELECT pg_catalog.set_config('search_path', '', false); -- Setează calea de căutare a schemelor la o valoare goală
SET check_function_bodies = false; -- Dezactivează verificarea corpurilor funcțiilor în timpul încărcării dump-ului
SET xmloption = content; -- Setează opțiunea XML la content, indicând că datele XML ar trebui tratate ca și conținut XML
SET client_min_messages = warning; -- Setează nivelul minim de mesaje care vor fi trimise clientului la warning
SET row_security = off; -- Dezactivează securitatea la nivel de rânduri

--
-- Name: factory; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA factory;

ALTER SCHEMA factory OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: employees; Type: TABLE; Schema: factory; Owner: postgres
--

CREATE TABLE factory.employees (
    employee_id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    "position" character varying(255) NOT NULL,
    salary numeric NOT NULL,
    contact_info character varying(255)
);

ALTER TABLE factory.employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: factory; Owner: postgres
--

CREATE SEQUENCE factory.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE factory.employees_employee_id_seq OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: factory; Owner: postgres
--

ALTER SEQUENCE factory.employees_employee_id_seq OWNED BY factory.employees.employee_id;

--
-- Name: items; Type: TABLE; Schema: factory; Owner: postgres
--

CREATE TABLE factory.items (
    item_id integer NOT NULL,
    item_name character varying(255) NOT NULL,
    item_description text,
    price numeric NOT NULL
);

ALTER TABLE factory.items OWNER TO postgres;

--
-- Name: items_item_id_seq; Type: SEQUENCE; Schema: factory; Owner: postgres
--

CREATE SEQUENCE factory.items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE factory.items_item_id_seq OWNER TO postgres;

--
-- Name: items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: factory; Owner: postgres
--

ALTER SEQUENCE factory.items_item_id_seq OWNED BY factory.items.item_id;


--
-- Name: partners; Type: TABLE; Schema: factory; Owner: postgres
--

CREATE TABLE factory.partners (
    partner_id integer NOT NULL,
    partner_name character varying(255) NOT NULL,
    partner_type character varying(50) NOT NULL,
    contact_info character varying(255)
);


ALTER TABLE factory.partners OWNER TO postgres;

--
-- Name: partners_partner_id_seq; Type: SEQUENCE; Schema: factory; Owner: postgres
--

CREATE SEQUENCE factory.partners_partner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE factory.partners_partner_id_seq OWNER TO postgres;

--
-- Name: partners_partner_id_seq; Type: SEQUENCE OWNED BY; Schema: factory; Owner: postgres
--

ALTER SEQUENCE factory.partners_partner_id_seq OWNED BY factory.partners.partner_id;


--
-- Name: transactions; Type: TABLE; Schema: factory; Owner: postgres
--

CREATE TABLE factory.transactions (
    transaction_id integer NOT NULL,
    transaction_date date NOT NULL,
    partner_id integer NOT NULL,
    item_type character varying(50) NOT NULL,
    item_id integer NOT NULL,
    quantity integer NOT NULL,
    transaction_type character varying(50) NOT NULL,
    transaction_amount numeric NOT NULL,
    transaction_details text
);


ALTER TABLE factory.transactions OWNER TO postgres;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: factory; Owner: postgres
--

CREATE SEQUENCE factory.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE factory.transactions_transaction_id_seq OWNER TO postgres;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: factory; Owner: postgres
--

ALTER SEQUENCE factory.transactions_transaction_id_seq OWNED BY factory.transactions.transaction_id;


--
-- Name: employees employee_id; Type: DEFAULT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.employees ALTER COLUMN employee_id SET DEFAULT nextval('factory.employees_employee_id_seq'::regclass);


--
-- Name: items item_id; Type: DEFAULT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.items ALTER COLUMN item_id SET DEFAULT nextval('factory.items_item_id_seq'::regclass);


--
-- Name: partners partner_id; Type: DEFAULT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.partners ALTER COLUMN partner_id SET DEFAULT nextval('factory.partners_partner_id_seq'::regclass);


--
-- Name: transactions transaction_id; Type: DEFAULT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('factory.transactions_transaction_id_seq'::regclass);


--
-- Data for Name: employees; Type: TABLE DATA; Schema: factory; Owner: postgres
--


INSERT INTO factory.employees (full_name, position, salary, contact_info)
VALUES
    ('John Doe', 'Production Manager', 60000.00, 'john.doe@example.com'),
    ('Jane Smith', 'Quality Control Specialist', 50000.00, 'jane.smith@example.com'),
    ('Bob Johnson', 'Packaging Supervisor', 55000.00, 'bob.johnson@example.com'),
    ('Alice Brown', 'Marketing Coordinator', 48000.00, 'alice.brown@example.com'),
    ('Charlie Davis', 'Sales Representative', 55000.00, 'charlie.davis@example.com');


--
-- Data for Name: items; Type: TABLE DATA; Schema: factory; Owner: postgres
--



INSERT INTO factory.items (item_name, item_description, price)
VALUES
    ('Handmade Soap', 'Artisanal soap with natural ingredients', 7.00),
    ('Scented Soap', 'Soap with refreshing scents for relaxation', 8.00),
    ('Colorful Soap', 'Vibrantly colored soap bars', 6.00),
    ('Moisturizing Soap', 'Soap enriched with glycerin for hydration', 9.00),
    ('Special Edition Soap', 'Limited edition soap with unique features', 12.00);


--
-- Data for Name: partners; Type: TABLE DATA; Schema: factory; Owner: postgres
--


INSERT INTO factory.partners (partner_name, partner_type, contact_info)
VALUES
    ('Supplier1', 'Supplier', 'supplier1@example.com'),
    ('Manufacturer1', 'Manufacturer', 'manufacturer1@example.com'),
    ('Distributor1', 'Distributor', 'distributor1@example.com'),
    ('Retailer1', 'Retailer', 'retailer1@example.com'),
    ('ServiceProvider1', 'Service Provider', 'serviceprovider1@example.com');


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: factory; Owner: postgres
--


INSERT INTO factory.transactions (transaction_date, partner_id, item_type, item_id, quantity, transaction_type, transaction_amount, transaction_details)
VALUES
    ('2024-02-15', 1, 'Product', 1, 50, 'Purchase', 5000.00, 'Bulk purchase of raw materials'),
    ('2024-02-18', 3, 'Service', 2, 2, 'Order', 300.00, 'Consulting services for production'),
    ('2024-02-20', 2, 'Product', 3, 20, 'Purchase', 15000.00, 'Order for manufacturing raw materials'),
    ('2024-02-22', 4, 'Product', 4, 10, 'Purchase', 1000.00, 'Purchase of hardware tools'),
    ('2024-02-25', 5, 'Service', 5, 1, 'Order', 1000.00, 'Installation and setup of equipment');

SELECT transaction_id, transaction_date, partner_id, item_type, item_id, quantity, transaction_amount
FROM factory.transactions
WHERE transaction_type = 'sale' AND transaction_date = '2024-05-28';

--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: factory; Owner: postgres
--

SELECT pg_catalog.setval('factory.employees_employee_id_seq', 10, true);


--
-- Name: items_item_id_seq; Type: SEQUENCE SET; Schema: factory; Owner: postgres
--

SELECT pg_catalog.setval('factory.items_item_id_seq', 15, true);


--
-- Name: partners_partner_id_seq; Type: SEQUENCE SET; Schema: factory; Owner: postgres
--

SELECT pg_catalog.setval('factory.partners_partner_id_seq', 15, true);


--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: factory; Owner: postgres
--

SELECT pg_catalog.setval('factory.transactions_transaction_id_seq', 20, true);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (partner_id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: factory; Owner: postgres
--

ALTER TABLE ONLY factory.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);

--
-- Name: orders; Type: TABLE; Schema: factory; Owner: postgres
--

CREATE TABLE factory.orders (
    order_id integer NOT NULL,
    employee_id integer NOT NULL,
    partner_id integer NOT NULL,
    item_id integer NOT NULL,
    order_date date NOT NULL,
    quantity integer NOT NULL CHECK (quantity > 0),
    total_amount numeric NOT NULL CHECK (total_amount >= 0)
);

ALTER TABLE factory.orders OWNER TO postgres;

CREATE SEQUENCE factory.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE factory.orders_order_id_seq OWNER TO postgres;

ALTER SEQUENCE factory.orders_order_id_seq OWNED BY factory.orders.order_id;

ALTER TABLE ONLY factory.orders ALTER COLUMN order_id SET DEFAULT nextval('factory.orders_order_id_seq'::regclass);

ALTER TABLE ONLY factory.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


ALTER TABLE ONLY factory.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES factory.employees(employee_id);

ALTER TABLE ONLY factory.orders
    ADD CONSTRAINT orders_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES factory.partners(partner_id);

ALTER TABLE ONLY factory.orders
    ADD CONSTRAINT orders_item_id_fkey FOREIGN KEY (item_id) REFERENCES factory.items(item_id);

ALTER TABLE ONLY factory.transactions
    ADD CONSTRAINT transactions_item_id_fkey FOREIGN KEY (item_id) REFERENCES factory.items(item_id);

ALTER TABLE ONLY factory.transactions
    ADD CONSTRAINT transactions_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES factory.partners(partner_id);




INSERT INTO factory.orders (employee_id, partner_id, item_id, order_date, quantity, total_amount)
VALUES
(1, 1, 1, '2022-03-21', 50, 250.00),
(2, 2, 2, '2021-05-12', 100, 400.00),
(3, 3, 3, '2024-07-03', 200, 600.00),
(4, 4, 4, '2023-02-13', 150, 450.00),
(5, 5, 5, '2024-08-15', 75, 375.00);

--
-- PostgreSQL database dump complete
--

