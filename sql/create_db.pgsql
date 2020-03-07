--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-2.pgdg18.04+1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-2.pgdg18.04+1)

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
DROP EXTENSION IF EXISTS "plpgsql";
DROP SCHEMA IF EXISTS "public";
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "public";


ALTER SCHEMA "public" OWNER TO "postgres";

--
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "plpgsql" WITH SCHEMA "pg_catalog";


--
-- Name: EXTENSION "plpgsql"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "plpgsql" IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: items; Type: TABLE; Schema: public; Owner: tvrtko
--

CREATE TABLE "public"."items" (
    "id" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT "now"() NOT NULL,
    "eventTime" timestamp with time zone NOT NULL,
    "title" character varying(100) NOT NULL,
    "description" "text",
    "mood" smallint,
    CONSTRAINT "eventTimeChk" CHECK (("eventTime" > "createdAt")),
    CONSTRAINT "items_mood_check" CHECK ((("mood" > 0) AND ("mood" < 11)))
);


ALTER TABLE "public"."items" OWNER TO "tvrtko";

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: tvrtko
--

CREATE SEQUENCE "public"."items_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."items_id_seq" OWNER TO "tvrtko";

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tvrtko
--

ALTER SEQUENCE "public"."items_id_seq" OWNED BY "public"."items"."id";


--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: tvrtko
--

ALTER TABLE ONLY "public"."items" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."items_id_seq"'::"regclass");


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: tvrtko
--

ALTER TABLE ONLY "public"."items"
    ADD CONSTRAINT "items_pkey" PRIMARY KEY ("id");


--
-- Name: SCHEMA "public"; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA "public" TO PUBLIC;


--
-- PostgreSQL database dump complete
--

