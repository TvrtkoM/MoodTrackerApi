--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

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

ALTER TABLE IF EXISTS ONLY "public"."items" DROP CONSTRAINT IF EXISTS "items_pkey";
ALTER TABLE IF EXISTS "public"."items" ALTER COLUMN "id" DROP DEFAULT;
DROP SEQUENCE IF EXISTS "public"."items_id_seq";
DROP TABLE IF EXISTS "public"."items";
SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: items; Type: TABLE; Schema: public; Owner: moodtracker
--

CREATE TABLE "public"."items" (
    "id" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "now"() NOT NULL,
    "eventTime" timestamp with time zone NOT NULL,
    "title" character varying(100) NOT NULL,
    "description" "text",
    "mood" smallint,
    CONSTRAINT "items_mood_check" CHECK ((("mood" > 0) AND ("mood" < 11)))
);


ALTER TABLE "public"."items" OWNER TO "moodtracker";

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: moodtracker
--

CREATE SEQUENCE "public"."items_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."items_id_seq" OWNER TO "moodtracker";

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moodtracker
--

ALTER SEQUENCE "public"."items_id_seq" OWNED BY "public"."items"."id";


--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: moodtracker
--

ALTER TABLE ONLY "public"."items" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."items_id_seq"'::"regclass");


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: moodtracker
--

ALTER TABLE ONLY "public"."items"
    ADD CONSTRAINT "items_pkey" PRIMARY KEY ("id");


--
-- PostgreSQL database dump complete
--

