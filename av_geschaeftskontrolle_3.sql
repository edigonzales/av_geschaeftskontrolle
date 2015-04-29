PGDMP     #    4                s           rosebud2    9.3.6    9.3.6 {               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                        2615    19335    av_geschaeftskontrolle    SCHEMA     &   CREATE SCHEMA av_geschaeftskontrolle;
 $   DROP SCHEMA av_geschaeftskontrolle;
             stefan    false            	           0    0    av_geschaeftskontrolle    ACL     �   REVOKE ALL ON SCHEMA av_geschaeftskontrolle FROM PUBLIC;
REVOKE ALL ON SCHEMA av_geschaeftskontrolle FROM stefan;
GRANT ALL ON SCHEMA av_geschaeftskontrolle TO stefan;
                  stefan    false    8                       1247    19337    jahr    TYPE     e   CREATE TYPE jahr AS ENUM (
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017'
);
 '   DROP TYPE av_geschaeftskontrolle.jahr;
       av_geschaeftskontrolle       postgres    false    8                       1255    19349 *   calculate_budget_payment_from_total_cost()    FUNCTION     %  CREATE FUNCTION calculate_budget_payment_from_total_cost() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
 BEGIN

UPDATE av_geschaeftskontrolle.planzahlung SET kosten = auf.kosten * (prozent/100) 
FROM av_geschaeftskontrolle.auftrag as auf
WHERE auf.id = auftrag_id;
 
 RETURN NULL;
 END;$$;
 Q   DROP FUNCTION av_geschaeftskontrolle.calculate_budget_payment_from_total_cost();
       av_geschaeftskontrolle       stefan    false    8                       1255    19350 '   calculate_order_costs_from_percentage()    FUNCTION     :  CREATE FUNCTION calculate_order_costs_from_percentage() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ DECLARE gesamtkosten DOUBLE PRECISION;
 BEGIN

SELECT kosten FROM av_geschaeftskontrolle.auftrag WHERE id = NEW.auftrag_id INTO gesamtkosten;
NEW.kosten = gesamtkosten*(NEW.prozent/100);
 
 RETURN NEW;
 END;$$;
 N   DROP FUNCTION av_geschaeftskontrolle.calculate_order_costs_from_percentage();
       av_geschaeftskontrolle       stefan    false    8            �            1259    19351    amo    TABLE     m   CREATE TABLE amo (
    id integer NOT NULL,
    auftrag_id integer NOT NULL,
    amo_nr character varying
);
 '   DROP TABLE av_geschaeftskontrolle.amo;
       av_geschaeftskontrolle         stefan    false    8            
           0    0    amo    ACL     �   REVOKE ALL ON TABLE amo FROM PUBLIC;
REVOKE ALL ON TABLE amo FROM stefan;
GRANT ALL ON TABLE amo TO stefan;
GRANT SELECT ON TABLE amo TO mspublic;
            av_geschaeftskontrolle       stefan    false    179            �            1259    19357 
   amo_id_seq    SEQUENCE     l   CREATE SEQUENCE amo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE av_geschaeftskontrolle.amo_id_seq;
       av_geschaeftskontrolle       stefan    false    8    179                       0    0 
   amo_id_seq    SEQUENCE OWNED BY     +   ALTER SEQUENCE amo_id_seq OWNED BY amo.id;
            av_geschaeftskontrolle       stefan    false    180            �            1259    19359    auftrag    TABLE     l  CREATE TABLE auftrag (
    id integer NOT NULL,
    projekt_id integer NOT NULL,
    name character varying NOT NULL,
    kosten numeric(20,2),
    mwst double precision,
    verguetungsart_id integer,
    unternehmer_id integer NOT NULL,
    datum_start date,
    datum_ende date,
    datum_abschluss date,
    geplant boolean,
    bemerkung character varying
);
 +   DROP TABLE av_geschaeftskontrolle.auftrag;
       av_geschaeftskontrolle         stefan    false    8            �            1259    19365    auftrag_id_seq    SEQUENCE     p   CREATE SEQUENCE auftrag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE av_geschaeftskontrolle.auftrag_id_seq;
       av_geschaeftskontrolle       stefan    false    8    181                       0    0    auftrag_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE auftrag_id_seq OWNED BY auftrag.id;
            av_geschaeftskontrolle       stefan    false    182            �            1259    19367    konto    TABLE     �   CREATE TABLE konto (
    id integer NOT NULL,
    nr integer NOT NULL,
    name character varying,
    bemerkung character varying
);
 )   DROP TABLE av_geschaeftskontrolle.konto;
       av_geschaeftskontrolle         stefan    false    8                       0    0    konto    ACL     �   REVOKE ALL ON TABLE konto FROM PUBLIC;
REVOKE ALL ON TABLE konto FROM stefan;
GRANT ALL ON TABLE konto TO stefan;
GRANT SELECT ON TABLE konto TO mspublic;
            av_geschaeftskontrolle       stefan    false    183            �            1259    19373    konto_id_seq    SEQUENCE     n   CREATE SEQUENCE konto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE av_geschaeftskontrolle.konto_id_seq;
       av_geschaeftskontrolle       stefan    false    183    8                       0    0    konto_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE konto_id_seq OWNED BY konto.id;
            av_geschaeftskontrolle       stefan    false    184            �            1259    19375 	   perimeter    TABLE     �   CREATE TABLE perimeter (
    id integer NOT NULL,
    projekt_id integer NOT NULL,
    perimeter public.geometry(MultiPolygon,21781)
);
 -   DROP TABLE av_geschaeftskontrolle.perimeter;
       av_geschaeftskontrolle         stefan    false    8            �            1259    19381    perimeter_id_seq    SEQUENCE     r   CREATE SEQUENCE perimeter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE av_geschaeftskontrolle.perimeter_id_seq;
       av_geschaeftskontrolle       stefan    false    185    8                       0    0    perimeter_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE perimeter_id_seq OWNED BY perimeter.id;
            av_geschaeftskontrolle       stefan    false    186            �            1259    19383    plankostenkonto    TABLE     �   CREATE TABLE plankostenkonto (
    id integer NOT NULL,
    konto_id integer NOT NULL,
    budget numeric(20,2) NOT NULL,
    jahr integer NOT NULL,
    bemerkung character varying
);
 3   DROP TABLE av_geschaeftskontrolle.plankostenkonto;
       av_geschaeftskontrolle         stefan    false    8                       0    0    plankostenkonto    ACL     �   REVOKE ALL ON TABLE plankostenkonto FROM PUBLIC;
REVOKE ALL ON TABLE plankostenkonto FROM stefan;
GRANT ALL ON TABLE plankostenkonto TO stefan;
GRANT SELECT ON TABLE plankostenkonto TO mspublic;
            av_geschaeftskontrolle       stefan    false    187            �            1259    19389    plankostenkonto_id_seq    SEQUENCE     x   CREATE SEQUENCE plankostenkonto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE av_geschaeftskontrolle.plankostenkonto_id_seq;
       av_geschaeftskontrolle       stefan    false    8    187                       0    0    plankostenkonto_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE plankostenkonto_id_seq OWNED BY plankostenkonto.id;
            av_geschaeftskontrolle       stefan    false    188            �            1259    19391    planzahlung    TABLE     /  CREATE TABLE planzahlung (
    id integer NOT NULL,
    auftrag_id integer NOT NULL,
    prozent numeric(6,3),
    kosten numeric(20,2),
    mwst double precision,
    rechnungsjahr integer,
    bemerkung character varying,
    CONSTRAINT planzahlung_positiv_prozent CHECK ((prozent > (0)::numeric))
);
 /   DROP TABLE av_geschaeftskontrolle.planzahlung;
       av_geschaeftskontrolle         stefan    false    8                       0    0    TABLE planzahlung    COMMENT     >   COMMENT ON TABLE planzahlung IS 'Geplante Zahlung pro Jahr.';
            av_geschaeftskontrolle       stefan    false    189                       0    0    COLUMN planzahlung.kosten    COMMENT     C   COMMENT ON COLUMN planzahlung.kosten IS 'exlusive Mehrwertsteuer';
            av_geschaeftskontrolle       stefan    false    189                       0    0    planzahlung    ACL     �   REVOKE ALL ON TABLE planzahlung FROM PUBLIC;
REVOKE ALL ON TABLE planzahlung FROM stefan;
GRANT ALL ON TABLE planzahlung TO stefan;
GRANT SELECT ON TABLE planzahlung TO mspublic;
            av_geschaeftskontrolle       stefan    false    189            �            1259    19398    planzahlung_id_seq    SEQUENCE     t   CREATE SEQUENCE planzahlung_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE av_geschaeftskontrolle.planzahlung_id_seq;
       av_geschaeftskontrolle       stefan    false    189    8                       0    0    planzahlung_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE planzahlung_id_seq OWNED BY planzahlung.id;
            av_geschaeftskontrolle       stefan    false    190            �            1259    19400    projekt    TABLE        CREATE TABLE projekt (
    id integer NOT NULL,
    konto_id integer NOT NULL,
    name character varying NOT NULL,
    kosten numeric(20,2),
    mwst double precision,
    datum_start date NOT NULL,
    datum_ende date,
    bemerkung character varying
);
 +   DROP TABLE av_geschaeftskontrolle.projekt;
       av_geschaeftskontrolle         stefan    false    8                       0    0    COLUMN projekt.kosten    COMMENT     ?   COMMENT ON COLUMN projekt.kosten IS 'exlusive Mehrwertsteuer';
            av_geschaeftskontrolle       stefan    false    191                       0    0    projekt    ACL     �   REVOKE ALL ON TABLE projekt FROM PUBLIC;
REVOKE ALL ON TABLE projekt FROM stefan;
GRANT ALL ON TABLE projekt TO stefan;
GRANT SELECT ON TABLE projekt TO mspublic;
            av_geschaeftskontrolle       stefan    false    191            �            1259    19406    projekt_id_seq    SEQUENCE     p   CREATE SEQUENCE projekt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE av_geschaeftskontrolle.projekt_id_seq;
       av_geschaeftskontrolle       stefan    false    191    8                       0    0    projekt_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE projekt_id_seq OWNED BY projekt.id;
            av_geschaeftskontrolle       stefan    false    192            �            1259    19408    rechnung    TABLE     �   CREATE TABLE rechnung (
    id integer NOT NULL,
    auftrag_id integer NOT NULL,
    kosten numeric(20,2),
    mwst double precision,
    datum_eingang date,
    datum_ausgang date,
    rechnungsjahr integer,
    bemerkung character varying
);
 ,   DROP TABLE av_geschaeftskontrolle.rechnung;
       av_geschaeftskontrolle         stefan    false    8                       0    0    COLUMN rechnung.kosten    COMMENT     A   COMMENT ON COLUMN rechnung.kosten IS 'exklusive Mehrwertsteuer';
            av_geschaeftskontrolle       stefan    false    193                       0    0    COLUMN rechnung.datum_ausgang    COMMENT     K   COMMENT ON COLUMN rechnung.datum_ausgang IS 'Beim Sekretariat im Kistli.';
            av_geschaeftskontrolle       stefan    false    193            �            1259    19414    rechnung_id_seq    SEQUENCE     q   CREATE SEQUENCE rechnung_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE av_geschaeftskontrolle.rechnung_id_seq;
       av_geschaeftskontrolle       stefan    false    8    193                       0    0    rechnung_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE rechnung_id_seq OWNED BY rechnung.id;
            av_geschaeftskontrolle       stefan    false    194            �            1259    19416    rechnungsjahr    TABLE     S   CREATE TABLE rechnungsjahr (
    id integer NOT NULL,
    jahr integer NOT NULL
);
 1   DROP TABLE av_geschaeftskontrolle.rechnungsjahr;
       av_geschaeftskontrolle         stefan    false    8            �            1259    19419    rechnungsjahr_id_seq    SEQUENCE     v   CREATE SEQUENCE rechnungsjahr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE av_geschaeftskontrolle.rechnungsjahr_id_seq;
       av_geschaeftskontrolle       stefan    false    195    8                       0    0    rechnungsjahr_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE rechnungsjahr_id_seq OWNED BY rechnungsjahr.id;
            av_geschaeftskontrolle       stefan    false    196            �            1259    19421    unternehmer    TABLE     @  CREATE TABLE unternehmer (
    id integer NOT NULL,
    firma character varying NOT NULL,
    uid integer,
    nachname character varying,
    vorname character varying,
    strasse character varying,
    hausnummer character varying,
    plz integer,
    ortschaft character varying,
    bemerkung character varying
);
 /   DROP TABLE av_geschaeftskontrolle.unternehmer;
       av_geschaeftskontrolle         stefan    false    8            �            1259    19427    unternehmer_id_seq    SEQUENCE     t   CREATE SEQUENCE unternehmer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE av_geschaeftskontrolle.unternehmer_id_seq;
       av_geschaeftskontrolle       stefan    false    8    197                       0    0    unternehmer_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE unternehmer_id_seq OWNED BY unternehmer.id;
            av_geschaeftskontrolle       stefan    false    198            �            1259    19429    verguetungsart    TABLE     ]   CREATE TABLE verguetungsart (
    id integer NOT NULL,
    art character varying NOT NULL
);
 2   DROP TABLE av_geschaeftskontrolle.verguetungsart;
       av_geschaeftskontrolle         stefan    false    8                       0    0    verguetungsart    ACL     �   REVOKE ALL ON TABLE verguetungsart FROM PUBLIC;
REVOKE ALL ON TABLE verguetungsart FROM stefan;
GRANT ALL ON TABLE verguetungsart TO stefan;
GRANT SELECT ON TABLE verguetungsart TO mspublic;
            av_geschaeftskontrolle       stefan    false    199            �            1259    19435    verguetungsart_id_seq    SEQUENCE     w   CREATE SEQUENCE verguetungsart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE av_geschaeftskontrolle.verguetungsart_id_seq;
       av_geschaeftskontrolle       stefan    false    8    199                       0    0    verguetungsart_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE verguetungsart_id_seq OWNED BY verguetungsart.id;
            av_geschaeftskontrolle       stefan    false    200            �            1259    19437    vr_firma_verpflichtungen    VIEW     �  CREATE VIEW vr_firma_verpflichtungen AS
 SELECT
        CASE
            WHEN (foo.firma IS NULL) THEN bar.firma
            ELSE foo.firma
        END AS firma,
        CASE
            WHEN (foo.jahr IS NULL) THEN (bar.jahr)::double precision
            ELSE foo.jahr
        END AS jahr,
    foo.kosten_vertrag_inkl,
    bar.kosten_bezahlt_inkl
   FROM (( SELECT a.kosten_vertrag_inkl,
            a.unternehmer_id,
            a.jahr,
            un.firma
           FROM ( SELECT sum(((auf.kosten)::double precision * ((1)::double precision + (auf.mwst / (100)::double precision)))) AS kosten_vertrag_inkl,
                    auf.unternehmer_id,
                    date_part('year'::text, auf.datum_start) AS jahr
                   FROM auftrag auf
                  WHERE (auf.geplant = false)
                  GROUP BY auf.unternehmer_id, date_part('year'::text, auf.datum_start)) a,
            unternehmer un
          WHERE (a.unternehmer_id = un.id)) foo
     FULL JOIN ( SELECT sum(a.kosten_bezahlt_inkl) AS kosten_bezahlt_inkl,
            a.jahr,
            auf.unternehmer_id,
            un.firma
           FROM ( SELECT sum(((rechnung.kosten)::double precision * ((1)::double precision + (rechnung.mwst / (100)::double precision)))) AS kosten_bezahlt_inkl,
                    rechnung.auftrag_id,
                    rechnung.rechnungsjahr AS jahr
                   FROM rechnung
                  GROUP BY rechnung.auftrag_id, rechnung.rechnungsjahr) a,
            auftrag auf,
            unternehmer un
          WHERE ((a.auftrag_id = auf.id) AND (auf.unternehmer_id = un.id))
          GROUP BY auf.unternehmer_id, un.firma, a.jahr) bar ON (((foo.unternehmer_id = bar.unternehmer_id) AND (foo.jahr = (bar.jahr)::double precision))));
 ;   DROP VIEW av_geschaeftskontrolle.vr_firma_verpflichtungen;
       av_geschaeftskontrolle       stefan    false    181    197    197    193    193    193    193    181    181    181    181    181    8                        0    0    vr_firma_verpflichtungen    ACL     �   REVOKE ALL ON TABLE vr_firma_verpflichtungen FROM PUBLIC;
REVOKE ALL ON TABLE vr_firma_verpflichtungen FROM stefan;
GRANT ALL ON TABLE vr_firma_verpflichtungen TO stefan;
GRANT SELECT ON TABLE vr_firma_verpflichtungen TO mspublic;
            av_geschaeftskontrolle       stefan    false    201            �            1259    19442    vr_kontr_planprozent    TABLE     �   CREATE TABLE vr_kontr_planprozent (
    auf_name character varying,
    firma character varying,
    proj_name character varying,
    konto_nr integer,
    sum_planprozent numeric
);
 8   DROP TABLE av_geschaeftskontrolle.vr_kontr_planprozent;
       av_geschaeftskontrolle         stefan    false    8            !           0    0    vr_kontr_planprozent    ACL     �   REVOKE ALL ON TABLE vr_kontr_planprozent FROM PUBLIC;
REVOKE ALL ON TABLE vr_kontr_planprozent FROM stefan;
GRANT ALL ON TABLE vr_kontr_planprozent TO stefan;
GRANT SELECT ON TABLE vr_kontr_planprozent TO mspublic;
            av_geschaeftskontrolle       stefan    false    202            �            1259    19448    vr_laufende_auftraege    VIEW     +  CREATE VIEW vr_laufende_auftraege AS
 SELECT af.auf_id,
    af.auftrag_name,
    af.firma,
    af.geplant,
    af.proj_id,
    af.projekt_name,
    af.konto,
    af.datum_start,
    af.datum_ende,
    af.verguetungsart,
    af.kosten_exkl,
    af.mwst,
    af.kosten_inkl,
    af.bezahlt,
    af.ausstehend,
    am.id_auftrag,
    am.amo_nr
   FROM (( SELECT a.auf_id,
            a.auftrag_name,
            a.firma,
            a.geplant,
            a.proj_id,
            a.projekt_name,
            a.konto,
            a.datum_start,
            a.datum_ende,
            v.verguetungsart,
            a.kosten_exkl,
            a.mwst,
            a.kosten_inkl,
            a.bezahlt,
            a.ausstehend
           FROM (( SELECT auftrag.auf_id,
                    auftrag.auftrag_name,
                    auftrag.firma,
                    auftrag.geplant,
                    auftrag.verguetungsart_id,
                    auftrag.proj_id,
                    auftrag.projekt_name,
                    auftrag.konto,
                    auftrag.datum_start,
                    auftrag.datum_ende,
                    auftrag.kosten_exkl,
                    auftrag.mwst,
                    auftrag.kosten_inkl,
                    rechnung.bezahlt,
                    (auftrag.kosten_inkl -
                        CASE
                            WHEN (rechnung.bezahlt IS NULL) THEN (0)::double precision
                            ELSE rechnung.bezahlt
                        END) AS ausstehend
                   FROM (( SELECT auf.id AS auf_id,
                            auf.name AS auftrag_name,
                            u.firma,
                            auf.geplant,
                            auf.verguetungsart_id,
                            proj.id AS proj_id,
                            proj.name AS projekt_name,
                            (konto.nr)::text AS konto,
                            auf.datum_start,
                            auf.datum_ende,
                            auf.kosten AS kosten_exkl,
                            auf.mwst,
                            ((auf.kosten)::double precision * ((1)::double precision + (auf.mwst / (100)::double precision))) AS kosten_inkl
                           FROM auftrag auf,
                            projekt proj,
                            konto konto,
                            unternehmer u
                          WHERE (((((auf.projekt_id = proj.id) AND (proj.konto_id = konto.id)) AND (auf.unternehmer_id = u.id)) AND (auf.datum_abschluss IS NULL)) OR (btrim((auf.datum_abschluss)::text, ''::text) = ''::text))) auftrag
                     LEFT JOIN ( SELECT sum(((rechnung_1.kosten)::double precision * ((1)::double precision + (rechnung_1.mwst / (100)::double precision)))) AS bezahlt,
                            rechnung_1.auftrag_id
                           FROM rechnung rechnung_1
                          GROUP BY rechnung_1.auftrag_id) rechnung ON ((rechnung.auftrag_id = auftrag.auf_id)))) a
             LEFT JOIN ( SELECT verguetungsart.id,
                    verguetungsart.art AS verguetungsart
                   FROM verguetungsart) v ON ((a.verguetungsart_id = v.id)))) af
     LEFT JOIN ( SELECT ao.auftrag_id AS id_auftrag,
            array_to_string(array_agg(ao.amo_nr), ', '::text) AS amo_nr
           FROM ( SELECT amo.id,
                    amo.auftrag_id,
                    amo.amo_nr
                   FROM amo
                  ORDER BY amo.amo_nr) ao
          GROUP BY ao.auftrag_id) am ON ((af.auf_id = am.id_auftrag)))
  ORDER BY af.datum_start, af.auftrag_name;
 8   DROP VIEW av_geschaeftskontrolle.vr_laufende_auftraege;
       av_geschaeftskontrolle       stefan    false    199    199    197    197    193    193    191    193    191    183    191    181    181    181    181    181    181    181    181    181    181    179    179    179    181    183    8            "           0    0    vr_laufende_auftraege    ACL     �   REVOKE ALL ON TABLE vr_laufende_auftraege FROM PUBLIC;
REVOKE ALL ON TABLE vr_laufende_auftraege FROM stefan;
GRANT ALL ON TABLE vr_laufende_auftraege TO stefan;
GRANT SELECT ON TABLE vr_laufende_auftraege TO mspublic;
            av_geschaeftskontrolle       stefan    false    203            �            1259    19453    vr_zahlungsplan_13_16    TABLE     =  CREATE TABLE vr_zahlungsplan_13_16 (
    auf_name character varying,
    auf_geplant boolean,
    proj_name character varying,
    konto integer,
    auf_start date,
    auf_ende date,
    auf_abschluss date,
    plan_summe_a double precision,
    plan_prozent_a numeric,
    re_summe_a double precision,
    re_prozent_a double precision,
    plan_summe_b double precision,
    plan_prozent_b numeric,
    plan_summe_c double precision,
    plan_prozent_c numeric,
    plan_summe_d double precision,
    plan_prozent_d numeric,
    a_id integer,
    projekt_id integer
);
 9   DROP TABLE av_geschaeftskontrolle.vr_zahlungsplan_13_16;
       av_geschaeftskontrolle         stefan    false    8            #           0    0    vr_zahlungsplan_13_16    ACL     �   REVOKE ALL ON TABLE vr_zahlungsplan_13_16 FROM PUBLIC;
REVOKE ALL ON TABLE vr_zahlungsplan_13_16 FROM stefan;
GRANT ALL ON TABLE vr_zahlungsplan_13_16 TO stefan;
GRANT SELECT ON TABLE vr_zahlungsplan_13_16 TO mspublic;
            av_geschaeftskontrolle       stefan    false    204            �            1259    19459    vr_zahlungsplan_14_17    TABLE     =  CREATE TABLE vr_zahlungsplan_14_17 (
    auf_name character varying,
    auf_geplant boolean,
    proj_name character varying,
    konto integer,
    auf_start date,
    auf_ende date,
    auf_abschluss date,
    plan_summe_a double precision,
    plan_prozent_a numeric,
    re_summe_a double precision,
    re_prozent_a double precision,
    plan_summe_b double precision,
    plan_prozent_b numeric,
    plan_summe_c double precision,
    plan_prozent_c numeric,
    plan_summe_d double precision,
    plan_prozent_d numeric,
    a_id integer,
    projekt_id integer
);
 9   DROP TABLE av_geschaeftskontrolle.vr_zahlungsplan_14_17;
       av_geschaeftskontrolle         stefan    false    8            $           0    0    vr_zahlungsplan_14_17    ACL     �   REVOKE ALL ON TABLE vr_zahlungsplan_14_17 FROM PUBLIC;
REVOKE ALL ON TABLE vr_zahlungsplan_14_17 FROM stefan;
GRANT ALL ON TABLE vr_zahlungsplan_14_17 TO stefan;
GRANT SELECT ON TABLE vr_zahlungsplan_14_17 TO mspublic;
            av_geschaeftskontrolle       stefan    false    205            �            1259    30087    vr_zahlungsplan_15_18    TABLE     =  CREATE TABLE vr_zahlungsplan_15_18 (
    auf_name character varying,
    auf_geplant boolean,
    proj_name character varying,
    konto integer,
    auf_start date,
    auf_ende date,
    auf_abschluss date,
    plan_summe_a double precision,
    plan_prozent_a numeric,
    re_summe_a double precision,
    re_prozent_a double precision,
    plan_summe_b double precision,
    plan_prozent_b numeric,
    plan_summe_c double precision,
    plan_prozent_c numeric,
    plan_summe_d double precision,
    plan_prozent_d numeric,
    a_id integer,
    projekt_id integer
);
 9   DROP TABLE av_geschaeftskontrolle.vr_zahlungsplan_15_18;
       av_geschaeftskontrolle         stefan    false    8            %           0    0    vr_zahlungsplan_15_18    ACL     �   REVOKE ALL ON TABLE vr_zahlungsplan_15_18 FROM PUBLIC;
REVOKE ALL ON TABLE vr_zahlungsplan_15_18 FROM stefan;
GRANT ALL ON TABLE vr_zahlungsplan_15_18 TO stefan;
GRANT SELECT ON TABLE vr_zahlungsplan_15_18 TO mspublic;
            av_geschaeftskontrolle       stefan    false    206            J
           2604    19465    id    DEFAULT     R   ALTER TABLE ONLY amo ALTER COLUMN id SET DEFAULT nextval('amo_id_seq'::regclass);
 E   ALTER TABLE av_geschaeftskontrolle.amo ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    180    179            K
           2604    19466    id    DEFAULT     Z   ALTER TABLE ONLY auftrag ALTER COLUMN id SET DEFAULT nextval('auftrag_id_seq'::regclass);
 I   ALTER TABLE av_geschaeftskontrolle.auftrag ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    182    181            L
           2604    19467    id    DEFAULT     V   ALTER TABLE ONLY konto ALTER COLUMN id SET DEFAULT nextval('konto_id_seq'::regclass);
 G   ALTER TABLE av_geschaeftskontrolle.konto ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    184    183            M
           2604    19468    id    DEFAULT     ^   ALTER TABLE ONLY perimeter ALTER COLUMN id SET DEFAULT nextval('perimeter_id_seq'::regclass);
 K   ALTER TABLE av_geschaeftskontrolle.perimeter ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    186    185            N
           2604    19469    id    DEFAULT     j   ALTER TABLE ONLY plankostenkonto ALTER COLUMN id SET DEFAULT nextval('plankostenkonto_id_seq'::regclass);
 Q   ALTER TABLE av_geschaeftskontrolle.plankostenkonto ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    188    187            O
           2604    19470    id    DEFAULT     b   ALTER TABLE ONLY planzahlung ALTER COLUMN id SET DEFAULT nextval('planzahlung_id_seq'::regclass);
 M   ALTER TABLE av_geschaeftskontrolle.planzahlung ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    190    189            Q
           2604    19471    id    DEFAULT     Z   ALTER TABLE ONLY projekt ALTER COLUMN id SET DEFAULT nextval('projekt_id_seq'::regclass);
 I   ALTER TABLE av_geschaeftskontrolle.projekt ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    192    191            R
           2604    19472    id    DEFAULT     \   ALTER TABLE ONLY rechnung ALTER COLUMN id SET DEFAULT nextval('rechnung_id_seq'::regclass);
 J   ALTER TABLE av_geschaeftskontrolle.rechnung ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    194    193            S
           2604    19473    id    DEFAULT     f   ALTER TABLE ONLY rechnungsjahr ALTER COLUMN id SET DEFAULT nextval('rechnungsjahr_id_seq'::regclass);
 O   ALTER TABLE av_geschaeftskontrolle.rechnungsjahr ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    196    195            T
           2604    19474    id    DEFAULT     b   ALTER TABLE ONLY unternehmer ALTER COLUMN id SET DEFAULT nextval('unternehmer_id_seq'::regclass);
 M   ALTER TABLE av_geschaeftskontrolle.unternehmer ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    198    197            U
           2604    19475    id    DEFAULT     h   ALTER TABLE ONLY verguetungsart ALTER COLUMN id SET DEFAULT nextval('verguetungsart_id_seq'::regclass);
 P   ALTER TABLE av_geschaeftskontrolle.verguetungsart ALTER COLUMN id DROP DEFAULT;
       av_geschaeftskontrolle       stefan    false    200    199            �
          0    19351    amo 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    179   0�       &           0    0 
   amo_id_seq    SEQUENCE SET     1   SELECT pg_catalog.setval('amo_id_seq', 5, true);
            av_geschaeftskontrolle       stefan    false    180            �
          0    19359    auftrag 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    181   ��       '           0    0    auftrag_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('auftrag_id_seq', 106, true);
            av_geschaeftskontrolle       stefan    false    182            �
          0    19367    konto 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    183   ��       (           0    0    konto_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('konto_id_seq', 2, true);
            av_geschaeftskontrolle       stefan    false    184            �
          0    19375 	   perimeter 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    185   3�       )           0    0    perimeter_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('perimeter_id_seq', 1, true);
            av_geschaeftskontrolle       stefan    false    186            �
          0    19383    plankostenkonto 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    187   }      *           0    0    plankostenkonto_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('plankostenkonto_id_seq', 6, true);
            av_geschaeftskontrolle       stefan    false    188            �
          0    19391    planzahlung 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    189   +      +           0    0    planzahlung_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('planzahlung_id_seq', 122, true);
            av_geschaeftskontrolle       stefan    false    190            �
          0    19400    projekt 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    191   �      ,           0    0    projekt_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('projekt_id_seq', 45, true);
            av_geschaeftskontrolle       stefan    false    192            �
          0    19408    rechnung 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    193   o$      -           0    0    rechnung_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('rechnung_id_seq', 110, true);
            av_geschaeftskontrolle       stefan    false    194            �
          0    19416    rechnungsjahr 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    195   o+      .           0    0    rechnungsjahr_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('rechnungsjahr_id_seq', 7, true);
            av_geschaeftskontrolle       stefan    false    196                      0    19421    unternehmer 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    197   �+      /           0    0    unternehmer_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('unternehmer_id_seq', 17, true);
            av_geschaeftskontrolle       stefan    false    198                      0    19429    verguetungsart 
   TABLE DATA                     av_geschaeftskontrolle       stefan    false    199   6/      0           0    0    verguetungsart_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('verguetungsart_id_seq', 3, true);
            av_geschaeftskontrolle       stefan    false    200            W
           2606    19478    amo_pkey 
   CONSTRAINT     C   ALTER TABLE ONLY amo
    ADD CONSTRAINT amo_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY av_geschaeftskontrolle.amo DROP CONSTRAINT amo_pkey;
       av_geschaeftskontrolle         stefan    false    179    179            Y
           2606    19480    auftrag_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY auftrag
    ADD CONSTRAINT auftrag_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY av_geschaeftskontrolle.auftrag DROP CONSTRAINT auftrag_pkey;
       av_geschaeftskontrolle         stefan    false    181    181            [
           2606    19482    konto_nr_key 
   CONSTRAINT     H   ALTER TABLE ONLY konto
    ADD CONSTRAINT konto_nr_key UNIQUE (id, nr);
 L   ALTER TABLE ONLY av_geschaeftskontrolle.konto DROP CONSTRAINT konto_nr_key;
       av_geschaeftskontrolle         stefan    false    183    183    183            ]
           2606    19484 
   konto_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY konto
    ADD CONSTRAINT konto_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY av_geschaeftskontrolle.konto DROP CONSTRAINT konto_pkey;
       av_geschaeftskontrolle         stefan    false    183    183            _
           2606    19486    perimeter_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY perimeter
    ADD CONSTRAINT perimeter_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY av_geschaeftskontrolle.perimeter DROP CONSTRAINT perimeter_pkey;
       av_geschaeftskontrolle         stefan    false    185    185            a
           2606    19488 !   plankostenkonto_konto_id_jahr_key 
   CONSTRAINT     o   ALTER TABLE ONLY plankostenkonto
    ADD CONSTRAINT plankostenkonto_konto_id_jahr_key UNIQUE (konto_id, jahr);
 k   ALTER TABLE ONLY av_geschaeftskontrolle.plankostenkonto DROP CONSTRAINT plankostenkonto_konto_id_jahr_key;
       av_geschaeftskontrolle         stefan    false    187    187    187            c
           2606    19490    plankostenkonto_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY plankostenkonto
    ADD CONSTRAINT plankostenkonto_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY av_geschaeftskontrolle.plankostenkonto DROP CONSTRAINT plankostenkonto_pkey;
       av_geschaeftskontrolle         stefan    false    187    187            e
           2606    19492    planzahlung_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY planzahlung
    ADD CONSTRAINT planzahlung_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY av_geschaeftskontrolle.planzahlung DROP CONSTRAINT planzahlung_pkey;
       av_geschaeftskontrolle         stefan    false    189    189            g
           2606    19494    projekt_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY projekt
    ADD CONSTRAINT projekt_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY av_geschaeftskontrolle.projekt DROP CONSTRAINT projekt_pkey;
       av_geschaeftskontrolle         stefan    false    191    191            i
           2606    19496    rechnung_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY rechnung
    ADD CONSTRAINT rechnung_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY av_geschaeftskontrolle.rechnung DROP CONSTRAINT rechnung_pkey;
       av_geschaeftskontrolle         stefan    false    193    193            k
           2606    19498    unternehmer_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY unternehmer
    ADD CONSTRAINT unternehmer_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY av_geschaeftskontrolle.unternehmer DROP CONSTRAINT unternehmer_pkey;
       av_geschaeftskontrolle         stefan    false    197    197            m
           2606    19500    verguetungsart_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY verguetungsart
    ADD CONSTRAINT verguetungsart_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY av_geschaeftskontrolle.verguetungsart DROP CONSTRAINT verguetungsart_pkey;
       av_geschaeftskontrolle         stefan    false    199    199            �
           2618    19501    _RETURN    RULE     /  CREATE RULE "_RETURN" AS
    ON SELECT TO vr_kontr_planprozent DO INSTEAD  SELECT a.name AS auf_name,
    d.firma,
    b.name AS proj_name,
    c.nr AS konto_nr,
    a.sum_planprozent
   FROM ( SELECT sum(pz.kosten) AS sum_plankosten_exkl,
            auf.name,
            sum(pz.prozent) AS sum_planprozent,
            auf.projekt_id,
            auf.unternehmer_id
           FROM planzahlung pz,
            auftrag auf,
            projekt proj
          WHERE ((((pz.auftrag_id = auf.id) AND (auf.projekt_id = proj.id)) AND (auf.datum_abschluss IS NULL)) OR (btrim((auf.datum_abschluss)::text, ''::text) = ''::text))
          GROUP BY auf.id) a,
    projekt b,
    konto c,
    unternehmer d
  WHERE (((a.projekt_id = b.id) AND (c.id = b.konto_id)) AND (a.unternehmer_id = d.id))
  ORDER BY b.name, a.name;
 D   DROP RULE "_RETURN" ON av_geschaeftskontrolle.vr_kontr_planprozent;
       av_geschaeftskontrolle       stefan    false    181    181    181    181    181    183    183    189    189    189    191    191    191    197    197    2649    202            �
           2618    19503    _RETURN    RULE     �  CREATE RULE "_RETURN" AS
    ON SELECT TO vr_zahlungsplan_14_17 DO INSTEAD  SELECT foo.auf_name,
    foo.auf_geplant,
    proj.name AS proj_name,
    konto.nr AS konto,
    foo.auf_start,
    foo.auf_ende,
    foo.auf_abschluss,
    foo.plan_summe_a,
    foo.plan_prozent_a,
    foo.re_summe_a,
    ((foo.re_summe_a / foo.auf_summe) * (100)::double precision) AS re_prozent_a,
    foo.plan_summe_b,
    foo.plan_prozent_b,
    foo.plan_summe_c,
    foo.plan_prozent_c,
    foo.plan_summe_d,
    foo.plan_prozent_d,
    foo.a_id,
    foo.projekt_id
   FROM ( SELECT a.auf_name,
            a.auf_geplant,
            a.auf_start,
            a.auf_ende,
            a.auf_abschluss,
            a.auf_summe,
            a.plan_summe_a,
            a.plan_prozent_a,
            a.a_id,
            a.projekt_id,
            r.re_summe_a,
            r.r_id,
            b.plan_summe_b,
            b.plan_prozent_b,
            b.b_id,
            c.plan_summe_c,
            c.plan_prozent_c,
            c.c_id,
            d.plan_summe_d,
            d.plan_prozent_d,
            d.d_id
           FROM ((((( SELECT auf.name AS auf_name,
                    auf.geplant AS auf_geplant,
                    auf.datum_start AS auf_start,
                    auf.datum_ende AS auf_ende,
                    auf.datum_abschluss AS auf_abschluss,
                    ((auf.kosten)::double precision * ((1)::double precision + (auf.mwst / (100)::double precision))) AS auf_summe,
                    sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_a,
                    sum(pz.prozent) AS plan_prozent_a,
                    auf.id AS a_id,
                    auf.projekt_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2014))
                  GROUP BY auf.id) a
             LEFT JOIN ( SELECT sum(((re.kosten)::double precision * ((1)::double precision + (re.mwst / (100)::double precision)))) AS re_summe_a,
                    auf.id AS r_id
                   FROM rechnung re,
                    auftrag auf
                  WHERE ((re.auftrag_id = auf.id) AND (re.rechnungsjahr = 2014))
                  GROUP BY auf.id) r ON ((a.a_id = r.r_id)))
             LEFT JOIN ( SELECT sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_b,
                    sum(pz.prozent) AS plan_prozent_b,
                    auf.id AS b_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2015))
                  GROUP BY auf.id) b ON ((a.a_id = b.b_id)))
             LEFT JOIN ( SELECT sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_c,
                    sum(pz.prozent) AS plan_prozent_c,
                    auf.id AS c_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2016))
                  GROUP BY auf.id) c ON ((a.a_id = c.c_id)))
             LEFT JOIN ( SELECT sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_d,
                    sum(pz.prozent) AS plan_prozent_d,
                    auf.id AS d_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2017))
                  GROUP BY auf.id) d ON ((a.a_id = d.d_id)))) foo,
    projekt proj,
    konto konto
  WHERE ((foo.projekt_id = proj.id) AND (proj.konto_id = konto.id))
  ORDER BY konto.nr, foo.auf_name;
 E   DROP RULE "_RETURN" ON av_geschaeftskontrolle.vr_zahlungsplan_14_17;
       av_geschaeftskontrolle       stefan    false    191    191    193    193    193    193    2649    181    181    181    181    181    181    181    181    181    183    183    189    189    189    189    189    191    205            �
           2618    19505    _RETURN    RULE     �  CREATE RULE "_RETURN" AS
    ON SELECT TO vr_zahlungsplan_13_16 DO INSTEAD  SELECT foo.auf_name,
    foo.auf_geplant,
    proj.name AS proj_name,
    konto.nr AS konto,
    foo.auf_start,
    foo.auf_ende,
    foo.auf_abschluss,
    foo.plan_summe_a,
    foo.plan_prozent_a,
    foo.re_summe_a,
    ((foo.re_summe_a / foo.auf_summe) * (100)::double precision) AS re_prozent_a,
    foo.plan_summe_b,
    foo.plan_prozent_b,
    foo.plan_summe_c,
    foo.plan_prozent_c,
    foo.plan_summe_d,
    foo.plan_prozent_d,
    foo.a_id,
    foo.projekt_id
   FROM ( SELECT a.auf_name,
            a.auf_geplant,
            a.auf_start,
            a.auf_ende,
            a.auf_abschluss,
            a.auf_summe,
            a.plan_summe_a,
            a.plan_prozent_a,
            a.a_id,
            a.projekt_id,
            r.re_summe_a,
            r.r_id,
            b.plan_summe_b,
            b.plan_prozent_b,
            b.b_id,
            c.plan_summe_c,
            c.plan_prozent_c,
            c.c_id,
            d.plan_summe_d,
            d.plan_prozent_d,
            d.d_id
           FROM ((((( SELECT auf.name AS auf_name,
                    auf.geplant AS auf_geplant,
                    auf.datum_start AS auf_start,
                    auf.datum_ende AS auf_ende,
                    auf.datum_abschluss AS auf_abschluss,
                    ((auf.kosten)::double precision * ((1)::double precision + (auf.mwst / (100)::double precision))) AS auf_summe,
                    sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_a,
                    sum(pz.prozent) AS plan_prozent_a,
                    auf.id AS a_id,
                    auf.projekt_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2013))
                  GROUP BY auf.id) a
             LEFT JOIN ( SELECT sum(((re.kosten)::double precision * ((1)::double precision + (re.mwst / (100)::double precision)))) AS re_summe_a,
                    auf.id AS r_id
                   FROM rechnung re,
                    auftrag auf
                  WHERE ((re.auftrag_id = auf.id) AND (re.rechnungsjahr = 2013))
                  GROUP BY auf.id) r ON ((a.a_id = r.r_id)))
             LEFT JOIN ( SELECT sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_b,
                    sum(pz.prozent) AS plan_prozent_b,
                    auf.id AS b_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2014))
                  GROUP BY auf.id) b ON ((a.a_id = b.b_id)))
             LEFT JOIN ( SELECT sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_c,
                    sum(pz.prozent) AS plan_prozent_c,
                    auf.id AS c_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2015))
                  GROUP BY auf.id) c ON ((a.a_id = c.c_id)))
             LEFT JOIN ( SELECT sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_d,
                    sum(pz.prozent) AS plan_prozent_d,
                    auf.id AS d_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2016))
                  GROUP BY auf.id) d ON ((a.a_id = d.d_id)))) foo,
    projekt proj,
    konto konto
  WHERE ((foo.projekt_id = proj.id) AND (proj.konto_id = konto.id))
  ORDER BY konto.nr, foo.auf_name;
 E   DROP RULE "_RETURN" ON av_geschaeftskontrolle.vr_zahlungsplan_13_16;
       av_geschaeftskontrolle       stefan    false    191    191    193    193    193    193    2649    181    181    181    181    181    181    181    181    181    183    183    189    189    189    189    189    191    204            �
           2618    30090    _RETURN    RULE     �  CREATE RULE "_RETURN" AS
    ON SELECT TO vr_zahlungsplan_15_18 DO INSTEAD  SELECT foo.auf_name,
    foo.auf_geplant,
    proj.name AS proj_name,
    konto.nr AS konto,
    foo.auf_start,
    foo.auf_ende,
    foo.auf_abschluss,
    foo.plan_summe_a,
    foo.plan_prozent_a,
    foo.re_summe_a,
    ((foo.re_summe_a / foo.auf_summe) * (100)::double precision) AS re_prozent_a,
    foo.plan_summe_b,
    foo.plan_prozent_b,
    foo.plan_summe_c,
    foo.plan_prozent_c,
    foo.plan_summe_d,
    foo.plan_prozent_d,
    foo.a_id,
    foo.projekt_id
   FROM ( SELECT a.auf_name,
            a.auf_geplant,
            a.auf_start,
            a.auf_ende,
            a.auf_abschluss,
            a.auf_summe,
            a.plan_summe_a,
            a.plan_prozent_a,
            a.a_id,
            a.projekt_id,
            r.re_summe_a,
            r.r_id,
            b.plan_summe_b,
            b.plan_prozent_b,
            b.b_id,
            c.plan_summe_c,
            c.plan_prozent_c,
            c.c_id,
            d.plan_summe_d,
            d.plan_prozent_d,
            d.d_id
           FROM ((((( SELECT auf.name AS auf_name,
                    auf.geplant AS auf_geplant,
                    auf.datum_start AS auf_start,
                    auf.datum_ende AS auf_ende,
                    auf.datum_abschluss AS auf_abschluss,
                    ((auf.kosten)::double precision * ((1)::double precision + (auf.mwst / (100)::double precision))) AS auf_summe,
                    sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_a,
                    sum(pz.prozent) AS plan_prozent_a,
                    auf.id AS a_id,
                    auf.projekt_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2015))
                  GROUP BY auf.id) a
             LEFT JOIN ( SELECT sum(((re.kosten)::double precision * ((1)::double precision + (re.mwst / (100)::double precision)))) AS re_summe_a,
                    auf.id AS r_id
                   FROM rechnung re,
                    auftrag auf
                  WHERE ((re.auftrag_id = auf.id) AND (re.rechnungsjahr = 2015))
                  GROUP BY auf.id) r ON ((a.a_id = r.r_id)))
             LEFT JOIN ( SELECT sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_b,
                    sum(pz.prozent) AS plan_prozent_b,
                    auf.id AS b_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2016))
                  GROUP BY auf.id) b ON ((a.a_id = b.b_id)))
             LEFT JOIN ( SELECT sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_c,
                    sum(pz.prozent) AS plan_prozent_c,
                    auf.id AS c_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2017))
                  GROUP BY auf.id) c ON ((a.a_id = c.c_id)))
             LEFT JOIN ( SELECT sum(((pz.kosten)::double precision * ((1)::double precision + (pz.mwst / (100)::double precision)))) AS plan_summe_d,
                    sum(pz.prozent) AS plan_prozent_d,
                    auf.id AS d_id
                   FROM planzahlung pz,
                    auftrag auf
                  WHERE ((pz.auftrag_id = auf.id) AND (pz.rechnungsjahr = 2018))
                  GROUP BY auf.id) d ON ((a.a_id = d.d_id)))) foo,
    projekt proj,
    konto konto
  WHERE ((foo.projekt_id = proj.id) AND (proj.konto_id = konto.id))
  ORDER BY konto.nr, foo.auf_name;
 E   DROP RULE "_RETURN" ON av_geschaeftskontrolle.vr_zahlungsplan_15_18;
       av_geschaeftskontrolle       stefan    false    191    193    193    191    2649    193    193    181    181    181    181    181    181    181    181    181    183    183    189    189    189    189    189    191    206            x
           2620    19507    update_kosten    TRIGGER     �   CREATE TRIGGER update_kosten BEFORE INSERT OR UPDATE ON planzahlung FOR EACH ROW EXECUTE PROCEDURE calculate_order_costs_from_percentage();
 B   DROP TRIGGER update_kosten ON av_geschaeftskontrolle.planzahlung;
       av_geschaeftskontrolle       stefan    false    785    189            w
           2620    19508    update_planzahlungskosten    TRIGGER     �   CREATE TRIGGER update_planzahlungskosten AFTER UPDATE ON auftrag FOR EACH ROW EXECUTE PROCEDURE calculate_budget_payment_from_total_cost();
 J   DROP TRIGGER update_planzahlungskosten ON av_geschaeftskontrolle.auftrag;
       av_geschaeftskontrolle       stefan    false    784    181            n
           2606    19509    amo_auftrag_id_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY amo
    ADD CONSTRAINT amo_auftrag_id_fkey FOREIGN KEY (auftrag_id) REFERENCES auftrag(id) MATCH FULL;
 Q   ALTER TABLE ONLY av_geschaeftskontrolle.amo DROP CONSTRAINT amo_auftrag_id_fkey;
       av_geschaeftskontrolle       stefan    false    181    2649    179            o
           2606    19514    auftrag_projekt_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auftrag
    ADD CONSTRAINT auftrag_projekt_id_fkey FOREIGN KEY (projekt_id) REFERENCES projekt(id) MATCH FULL;
 Y   ALTER TABLE ONLY av_geschaeftskontrolle.auftrag DROP CONSTRAINT auftrag_projekt_id_fkey;
       av_geschaeftskontrolle       stefan    false    181    2663    191            p
           2606    19519    auftrag_unternehmer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auftrag
    ADD CONSTRAINT auftrag_unternehmer_id_fkey FOREIGN KEY (unternehmer_id) REFERENCES unternehmer(id) MATCH FULL;
 ]   ALTER TABLE ONLY av_geschaeftskontrolle.auftrag DROP CONSTRAINT auftrag_unternehmer_id_fkey;
       av_geschaeftskontrolle       stefan    false    181    197    2667            q
           2606    19524    auftrag_verguetungsart_id    FK CONSTRAINT     �   ALTER TABLE ONLY auftrag
    ADD CONSTRAINT auftrag_verguetungsart_id FOREIGN KEY (verguetungsart_id) REFERENCES verguetungsart(id) MATCH FULL;
 [   ALTER TABLE ONLY av_geschaeftskontrolle.auftrag DROP CONSTRAINT auftrag_verguetungsart_id;
       av_geschaeftskontrolle       stefan    false    199    181    2669            r
           2606    19529    perimeter_projekt_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY perimeter
    ADD CONSTRAINT perimeter_projekt_id_fkey FOREIGN KEY (projekt_id) REFERENCES projekt(id) MATCH FULL;
 ]   ALTER TABLE ONLY av_geschaeftskontrolle.perimeter DROP CONSTRAINT perimeter_projekt_id_fkey;
       av_geschaeftskontrolle       stefan    false    191    185    2663            s
           2606    19534    plankostenkonto_konto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY plankostenkonto
    ADD CONSTRAINT plankostenkonto_konto_id_fkey FOREIGN KEY (konto_id) REFERENCES konto(id) MATCH FULL;
 g   ALTER TABLE ONLY av_geschaeftskontrolle.plankostenkonto DROP CONSTRAINT plankostenkonto_konto_id_fkey;
       av_geschaeftskontrolle       stefan    false    2653    183    187            t
           2606    19539    planzahlung_projekt_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY planzahlung
    ADD CONSTRAINT planzahlung_projekt_id_fkey FOREIGN KEY (auftrag_id) REFERENCES auftrag(id) MATCH FULL;
 a   ALTER TABLE ONLY av_geschaeftskontrolle.planzahlung DROP CONSTRAINT planzahlung_projekt_id_fkey;
       av_geschaeftskontrolle       stefan    false    189    181    2649            u
           2606    19544    projekt_konto_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY projekt
    ADD CONSTRAINT projekt_konto_id_fkey FOREIGN KEY (konto_id) REFERENCES konto(id) MATCH FULL;
 W   ALTER TABLE ONLY av_geschaeftskontrolle.projekt DROP CONSTRAINT projekt_konto_id_fkey;
       av_geschaeftskontrolle       stefan    false    2653    191    183            v
           2606    19549    rechnung_auftrag_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY rechnung
    ADD CONSTRAINT rechnung_auftrag_id_fkey FOREIGN KEY (auftrag_id) REFERENCES auftrag(id) MATCH FULL;
 [   ALTER TABLE ONLY av_geschaeftskontrolle.rechnung DROP CONSTRAINT rechnung_auftrag_id_fkey;
       av_geschaeftskontrolle       stefan    false    193    181    2649            �
   W   x���v
Q���WH��W��L�QH,M+)JL��s���4�}B]�4u,tԃ���L�5��<I5�TG�b���	�.. =b$�      �
      x��]�r�6��S`:���J2�"ٝmG�''�Ǝ;ӛeA���O����3�*wz�= %�&]%�Y�3��(e��t~���z{9}E^��� a�(�pI��y�l������N�5��4/x�'뻼蓏<[��(�ef�ceR�,�5��z��������'s^���U\�y�,�&�Ԍ�/��M�������%9��>�v���xg�/7���(Mț���l>$o�!�\��I��*\��Y�O�ZV��p��V̢������V���ԕ��a����p~���G����r�>a��	�x�DK�J��l����eV&�,�srZ�qt�r6 l��N<ׅS�R�
v�����i`y�7��[��KqeQ�����
n- `r��gr|γ����x�'��yX�WC1sG�����w+j�"G]�MM�^Ç�$_
�����99с"��l%D��vj��t@��n�65_9-Œ	e��g�r�ԡC���ђ'p����L�,�a����=b��.�60%n�d`�z�`��2�-� 5'�Ӥ��8�o��e�Ē��~^p�*襆�b�����D,0&�1��x��y�
1R��<�(\7��\B�2]�4W�9P΄������-")�p���Û��v��P+٣�����������7��O�"��.I�^ �Y�{F�OGҀub?��!���
���B �H/�I/��w+��G�=(���V{�W��0��p���������Q�qw
��X��S��RM�'�@Xl�Z�n�h�想W�'g�����0�jX0e�,�u���1��߽}q�2]��LQM]��dZ��'�_�w�0焒�wQ�
�bL�Lq��Q��e?X�����Y�}X'�.WHV�0�=Bn!�'� ��!�!ǿA�pŕR�K���"P�J:L%�.n�m0[4�m�A%i�����M���ޡ�j�wJ�y��Zz�2�5b����s;��e��_�'ł�s t|�Ak%b :R��I�܊1t�Q�4���,gQ���o#��{�!I�f>��pZ��TQ���(U�I��"^�1��8׮yV�W�0����A/�Z��H�^SOMdX�'Z7�z�� .�Fr��w��̭7�B���F4��4�(W���t}��phN���
lLK7>�nCH+s��Dqx�إ}�!�,w8b�d�����L[f;�����F�������K�4��|��`�g|&�Q��(9>�%���j35ݪ���j+#����?w�D D�'��#y�O0k}�L�A�m���@H�R�x&��U�`�݁��QP�[r̳,͆q���ב[�Yh�(aU1�e�{���DO-u?B����H���?+�"k/�ݖ�%��(WF*��-I�$il�+I3��{<�)|�M�k��F�^��3D�������%�����t���,���uJ�n�+�s���h=�����o���\'�:'�헌\]>G1�YG��׌s��4��T�sx�Y�g|Cp�*�Q�EV��EZ�<����!'�)hժ�}���g/�6�B�|�p-�g/a�Q�V�@CS|��JM�q��nuR'���L{b�ih5�|F&FuB�=���\J���S�}��U��@�*���L�1G��y4��d��M����:����>Ӏ�ޤ��d�A��@��_VD�nU?�2�w��L����C�&���Ӿ<? ��2+��72N��h�RUK�'jf}��o������}KAѕ���bf$f����=�^�O����r	�̲�+�c�t�&]_����C��$����O@��l�6�_F��_�2&������1�U[������N��]e��
dN�5��$�~)�y,�Lt ٖ;�*o�u�F��Q��uե���eQ��^X�*Sc�@V'V���&��_��6_�r��W�R��e�Vd�7�ȓ��h�$)<�.�I
�S2$��j���9�M�/�/�OyZ�b���c(�.f�,�r m�x�:L��I�ކ��؄IRV�}dVk�	5�w��i�������U��2ښ)tE���p	'1-��$�F@ϰ������zݗ�<�a�D�9:�k�&��῁��u�Q��ZO�+�d�* ��~Y�Q~Ń��Z� 8&қ}���`&i
���ٮ�<u�kcC`l猟}s�(������C�7��ΫjdA�)A��q^�q��=)�ah�&�t���=d"�?a�U��<���R�׺��f�_�6����ۙk��U������h2�O7�Xj����d7p;ǧf�{�2t�3�L�	i�v��k�N����e���U�M�y�v��~Y����{|=�� ��U��im���{ՄN���`�d<ˀ�aH ��d�w1��ד�I��m0Nr�b3�er�4ZFE�,��R�K�ǜ��|�h4E��� �0��YU�ڝ��,I���,��é0����m��r�A��Y�eѿ2����]�l�y�EE����&�>��xf���_WP��Z�w��f����#�K�]�ׄ�C�f�)��>!/�E��>���F$9�x:���f�:C{�����ɀ��}��@�q�X{$<����2(�) ��ѐ�?�;�^/�ށ���=�!6a��~Z�#3�����4���*V Q �-�A���"�O�)%o�|q��R:�� ����.�����]��4&FQpȸb�H:G󄼓��$u@����;+���h���4�~	�����y�D(.�Oӭ�����՞.�7qt����V�'0V��}�{�=7!��O(�_��<��T�aV�\ߥq\HU@+��Ȇ�����|V;�!9�x���h071�0q�	�	��\Z|j�fkL}����3^d�Ґ����X��)�M�ޏO�����'FL�hk�7�#.X9��+w�2N�Q��
�uw�I}r��}�^W6�����]�X�Ӗ!Su��l�s|��S�!y*�E����B��Kԣf��ͱ�He���~Y b/@�nS lS�� ��Q��^��ZV�!�"$���G���.p<� 5�~�`�@��)v�f+>��Ke � ��cH}��q!D�Dg�nhcl�(�����xg��"c�%��bm%�n,AJ���W�p,B���3d7k�,���P��ihוg��I	��8��L�Hy�`��~	n�O�=i!�{Qs�`���E�חUi�1o)PQ[�_[�H�|L���h"�����i���3�ح����2�*���2�,���Q"�O��)������+Ӏ�R�-�i���Sr�Hu��P��glE�HPΘ��[R'9��Ɂ?{H�V�/˵���=�p�Z줶�l?j�m��#<Ѱ�Dl��������z^Q˺Qȏ���Ⱥ7�):�����iU\"j�+z��t#�.h�wG=>r��K�o��M�}�:[Й���<��0y�`�h�����0%�D���ShMX]�"1>%J��m=F��nG;5U�Td��37U``ہ�E\��rf=�A�L��zmٽR'���%�p��X�=��VL{�R�0�H{�K�U�;,�%�̷�7S�E��H�k�# UQ�<��T���&�T�̞�V�} �+0Ss��l�o���}Z���>p�ڨ���5s��t�Ԡ{_˨����w0n��n������Y�*r�*G��M�
�
������0�+�3.Q��Am�\��&����ʜ���2���E�ڵ�+���P�"`$��������!-+Apxub�^��]+�=��:�衸�1��T��Z�./�9^_.�Eqf��kE��gR�G
�Bou��o�p��?T���P�Unl�=Cono�����{^
P���@�<���G���gњ�>sr�JoV�a�/��n
��g�4^��K��Р��`��ư[�lxt4�-����Z���S�c�'���(�'�檥T��SMT7$����.�i��xr��yq?���l8���!���1��4��&�{��G_�P6�{�������H���z�ˌ��gJ��� �   `��&k��_5Y�v��9�6:wwƎ�F)�g�+K�+�s�xL^s|�U�����݋V�����$,�`����9�Re���VV)G�{�=H��E�N�O�� �k�tؚlȱ����� .��Y#(77���UO������'x���G�`mm�6G���#��}�/{�E챕i�x��������XT9dR��Q�L�zb�Cumy�e���,C{$�����&Z      �
   �   x���;�@�{N1��Dl�H��h �գ���'�,���b.�I���'�:�Ȣ)1.l�A��s?���f2���]vk�A,��Iũ�߲%���b�E������|���ٓ ��9����"��?��]�xT�%�v��vcy�%�>�      �
      x��}Iˮ�r�ܿ��l��2R��@�x�I��	!���OV=U�W:d�p����TͪR���?�������?�ӿ��?��/��������_������ǿ����Ͽ������+���k���m��g�����k��gl����b�����O�/ͅ������\�3沪KƭfZ��7�O�0>r�>�����Z�?�;�;�9C.�,Gx�+���S[��	�q�'��i���=���,��6s��(�je��=_����c\��xK��������-v;3��3ڲ�1n�K쌏9��s%����ͭ����V�������0�\�����l-���˞}��z��!ug*s��CH;����i��x�օ�7�ۯ0��%wƱ\%'ۻc�ں��*[i��)�n_eC�-��xH���w[2~�Mۥ�͸_h4���a�1s�11���ք�D~}a �� �+9�PQ\�!_h1�[���o-���ߩ��Z���CC��2���k�&�Â��e�E>}B��mA��]�����M{��o"����s�gd��`�4�_o�)�V�:�)ե��+Xku}�w>�:O������P�XL�jf��X�<����^iB�!���=kNf#x�qD��N��1�8b˅�\���]�g_n�0��9�o}y�=k����ӡ��x�i����8��.52���'�gkޱ�ɶlhP�ϱT�_���I�@�§߅f[<v|�oy��G����<�G���������lF��gh�o|g�Bd<T��)d��Ĕ��I�X�����x��^S0�{��&!n�Zc��3�ig����t{����=2�q����E/���勌�/�k���5'�ɇ���/�y��ͻP�����0�������0^�X&��e��ߵ��D����@��Մ���[���#��B��&����'�a0]7D>)�v"?��+fv'�wʲM����m������=X�~���؜��- ����M����`�<c`,�Z��*Е d��0���OFW�@����¥�:�ȿ5?�����r-�.F�����6�c��N����ib3�Q[T?!L��zۯ��k|�Q���sh	���_#�7"҇��� �p��ښ��Zw�����0ϒB��c<�P҆M���+dB��׺�����cT����1�@�(V�q�w�m�2T��Cg�6�� 6b8�U����#�w�!��>D>�v�P��~�x7="�[�#O6�0<ZU�n�� -����������-Ǆ��?���'�Z�h#�	߇잌�ԱxN_�;F�a���_����Elu�2�كV�Z.%�a{P9����nx�]�b�f&����7��RSQ��> ���!7�Z(�q3a��h������D�LΝB2tD��M�e���]>C�7�5�q&i�)���#}l�$���NJ���{��7��\�����O�>��}��ـp�ᝢ��o�y��"Ft������,���b��8���1^��q���ĸ�_,Cg~BlxT,���Yqb������Fc��B-������F�Iv�^�Wɍ�����>����k�nB���xƍq���T/�O�F@OV�_�A�A���73t��}��*�S�F�3�_h6����_�p��i��_b\�������`�����:}.�q�/��y��Vw?�B�����q�#m����4�
���`�CƏ�Ռ���Ft�����C�iw�{�\c��1\g����Ϭ�J{�	�I3���������	?�q�o�T��>�}�gK��B�p�f�Q��n��/d4��d��e~�e3��^��zZ�Y���x��uY��j[�}�'e��~Km�C�W}	�^��u���FH��3�s��g�Ǹ�^�g�G�Sƍ��?���&�C��y$�8��-����O�$8dI�8�*��s��S���؝qf�{��8�+��/���O�W����A���S-�8[�7AD\�]S��Y'�f\�#|
��/0�;������/��g\珸��,�b��և��A��(XX��by/"���¸	$�6��O�W��<�+�kPD���5�|�

-8[�A����/D/�����8�s���

gd}H��zV�{|��}* �si/��yƥ>4�;��5���Շ\]2���}��_-��W���?�ʯ�D�g��E����g1�#_������wz���}������_�U댳6̞�~Y��<{,��(?��q���1��N_}
Lrp�e���h�E$�(h�q]_���5T$��k>N��[�E���9ޑ��|N�j���1�z����~C�W��ۙ_r=J�/���kM��3��Ƶ���$v˸~������B��߰���^���o���������k|N�q��	ۭ_N�ْ�����q�p�S�v�/�O��{�ݟi�3��~�W�T����3(�|���b\�1����?l�/�xL\�q�k�zm����n��?�띟�Ƹ�I����WZ�]!���`����V?�c���Ie�m�f>yƐo�����|�2�j?3��f����q棐Ne���(�W��+r��on������f��}%�1��υq��3��������}�����R���ͷ�aW��$~�ȁq�OL���i?�D�3-yӎ43�{�C{Ǉ���E�8KÕ6?��c<q6�g�C٤�'�g����~���O��������'9^XxG�9�k1����_�Ͼ�3-�_���4:��X�e5��0��k������jopg��?%1���s��Gv˸�����z#�����%��o�f��;~!���s�=�'��	���[֖����e�yƕ�[�/�j�F�z燴����o>`��q^/�z�ԿC}��_ze\�Ѳ1����e���g�~o{�ܽ>�߰��a,ƕU���}�������Ob��&�}+d�����_2����Ze\�g%���r��b~?��(�@�����,��'�j�Nګ�@�O�C�3,/��$s��$��ꁩR�t�玌3{�X �տ�v�o�ei��_Pi��|������㩡��o���t�����ߚO�����^���#�_~�����G�H����S_�?����ٟ)���/*��+�
��0
��/��O�{���h�����q�o�W��ȸ�ѹ�X����q�?��ï��T�5�~�)p�J�-�u8K�_j?�1�|�U����-?~��v�o!�Y��Al�0������>��]4�W?����ė���6���)�~e�ʟ/{�Xo���������������?��8�����U��h��龯X��V���&8�L۶x�?���ȋq�/T�f\�����`*���(ǭ�q2~�50�|�	>�(��B�~k��n���ob�sŘv���o�3~�$���!���}�"dǖqo�2��:��qmj��#Ɨ�z�}c���F� H��K��E���Z?��ϧԯ5)�q�^���K�CaK������e��c��ωq���UT?��x&��֨X QƵ^0:�<^Б����S����G���^9�J��$�8���K~.[�/�?�Gƿ�O)1��O=e3��|/�d^|��3�{Dv%�!��/�� �*�~	?c>���c��2�G�q�ܼ4�_�E���7�O}��k��9���䯬�Ά����V9�f�Y�O?�����x_�8�ڻ��o3��c��}����������g��K�',��8!��m=��?�*�W��a~��R�
���Sd\�_��U?����Mq�ϧ������[n���_��7��b�������������!�o���%���i��O?����T�Ō}�2������㟣G����|�#0��,*�~���4�MƵ>�+��/a������zB�j���9Y?yZD-�U�����ȯGW�����'~��9�o��B�f8ț�u���?�v�G�Gz�_���+I{�7�3~�w�����aΛX���Q��E�_!�}��~��7�j��çӺ    �?���o��ų�_��|�����
��i���_����_���������ɛq�?���/���'F_W�
���� �7���ߟ�ʘ���X�����Y?c����?P쯾��&��������/跻��ay��~�����ҏ��s�oT�z������v��G�U��؏�7M����S���:��6��A�����:���(�5�~>�EGp��W�0�qͯb�O~��֥�-��ay#��a��I�T�N�+n&�Oq�Г������W�5����?1��>XJ{�A7?��t���>�y�_����o�(��� ����9����o��?㉡��q�O�/�'B����"��߂k}������!��Iګ����9_��ٟd\����Sʼ�׆��q���SΗq�<������-�Mi��m�����(�����C�gwo�q2����;$���-"?�_Y�T?����Bf��x-}�o�c֏�g�<���ϺW��1���� �(���u�/�3�����b}~��g΋�k����Ǖn���q]?��˿U"���}=��n������P�~�
㧞��ֿ���?Wf��_�{~ц�������Пt��:?��������!�|O�2�+~7�:�������e�������Hx�a�o��Gh;���ZZ?$9��%������	��>S���O��ٿ���W}F�G��Ec	��.�/�8�u}��k0&���-���>��w<�M&��'����gV�W�x��m��g�NⳎ�9�O�ھ�������~=��m�u��@��_Ƶ=]Ҹ�먿��m���t%����T\��'3�7���<^���O�<UP��ww�O��1��lI��鬹�?��lY?��q��q�ӏ�߈|u�ｾ5����~�����������W{=n7��+_X|��;�w��1���d~��~��?�z�c���� ����~���������_�m�c��o�q��X{��B�Ƿ+��_�p�/"γ���kw{�_��ߺݸ����{q��?�s~s�o�����o���۾�~&���n����̌�z�ԏ�~�f\�Q�o��~�33���_����wR_ןo�۫~���{��h��t��hX{ϯ����aX~�?�1��7˸�� �'G����OF|����_���8i��Y�g}���_����Z�������O|`�S{������u����?�>qŗ&�K��{3~�``�������C��-��o�ُ!���/̂�������z ?~�/�-�_|���~�]���Ub\�E
Xa�T����[�M�/O}`���ݿ��i��㿼����g\�[?��.�����[�����o������s��E�O>)�Y���ca0/n
��|S��B�m�Ӿ�_�q���?��.��z�����Bg�����kb\�w����=��pKO���TpL��	?�"_��?]Y��k�?�/(�}������Ɨ�Oz�_6������g~[p��$��O]��o��|�����/��%c�������7��w�q���[�J˕q��*�Y�k����V/����f�8|j��{ra�V��]�GɟT%��|�{>Ɋ���{��|81�?�|��I�O=Ϥ'��¸֯ve��O"�>���k�
?��
�#��	����kr�����ϩo���]��tη�����`\��.�����7����.~_C�o�68����1=�k����X�'��q�/���������Z�t�����?�h�O?��r~S�W�"A~��g`\����*� �����>@m��~���/�qW~�KK�^덕�������)����|�������������k�0�/��9�V?����9�}���b���I�W��k|���:_d��_�3�}�(�^�������� �����ɸ��j���zf��w�{���ڳ���{+����sz���W�?��$9���g�A���g��y#��O>/��5~����+�O�Y��ڗ�?8����+��w��2~�,��~����A�O|\���x����ő�;>%��r���^�9��������ϓ�[�O��?���������A�;��g?R�'���x�w�k�_v�WƧ�����o��~�?��s����T�z{��ѓT\ϗK~���-�;�o���~lz�g|�w��}*/������s>���~C����*��������s~X�z0?�r|�����h���N7�}���o9��ǟ����\���������mf�W�d��}�#���v�����O�sL���'�oj�䧾��;]����U��1��!9����d���O?����iۯ���)VD����?�;�����`\�G[���7ϸ�S���E�0�r�/�?���x��#gy_���9O �+����Z��?9���_�ٟ�ߟ�U�~��3�ۿaHҿ�S�7?��������K������X�����g�&����M��_���}�������:������.y��ԯ�]�~Ƴf�˯R�?.K��֗�g7��kH�'���^�k����C{�������]�Cv��s�6�/�}ߊ��[~[�����íH/��_XH��'����҆�ŏ{a\����Cp'�����U����3�'��@=����O�	�z��Ƹ�w��y������gb�H�󭟰���o�u���c'��<~�/F8�f_���m'����ͼ�����w|ڂ��?��|������Z���?��jߡ������/@?�͟�|_�י�S���?�g��s�?!��������X��~��������ȸ�/?��O~���Toz������i�s~fF��/�b��/_o��_~�}���1��s�����yꛊ�zG�o�q�����.��;�@�?["ߓ�"��������O�0�������� ��������_�.��g�t%����'�У%���MƧ��N(��M+������]�w��ʸ�$d����������̲�g�3�������?>������O�o�v�<��a^�?�B�[����S��?�Y�ϟ�-ǧs�I�w�׽�[×�>l2��s~\Ƨ���m��_��������=?������G*]�"9�|��~�����B�������l.����ܣ�%����)t����K�gj�N�w����a^|�>[W����N���o+��������_��>�#?�K���	~�͛N�u|[�gT>f���t��;ѳ�ķ&�/�//��}eǸ�G�o{�Q��a���u�{�t ��7%;{�7��^_����%�����Ͻ��?d������q����0Χ���?�!��?��A�,t��^H��k�¸��z>����$2>���"���K����9�����M:?�o�|�w�&��ޏ���W�{0������VW���>����ì�����T���s���o�1νo:0�~���e����H|�D��2��Ed�|Op~�h��_�dUp��1����0I���e1����E���d@����C݌�������W� �k!2������{�/��(�ޗ�q}!G>�����^����)�����%�w�������g��AԿ�47�r��܃A0�Uڏ�wiao>�� |��׌��7�%��n���G��w���]��R��6�'��o�6�<��sD�`�}�#�yޖq������n��K��{BK��ޯ[]��~��%�gr`-}5���U*���;��}H��X&�_�D~��]�.h��g��5,�_��.�)㣋c�z���d��y��W5ф�����b���g�dckq��
��v�ȧozk��%�݀��6d}|��^p�?����1~�_��{��-��H�d�kF�S��K�s�|�<�]�����M����t�M��M����7<~:ʞL�2?x3�ƊS�EG�2�M���J���wN��U��cnt��N�/t�{xަ��e�Z��&@\%U���ӿ�UE~P���r�jU�l%O����0f�*�������T`����Ar����w_���� ����D?h�^[V��#�Ǣ���ps&_��2��V�qYڇ@4[Y��C�Lu 0  q4���[����t4d����ya�t�z�L�������Q����4�����G��:��K�����d���C�9=ma���*>Ws�ѠO���_�;�7���a$i_�����"�C��X�5���N��8rc̯�ˣ�<���6���[��m|�l��ϙ#��ngq���y��x���������������Ơ���a�� ��cM�i2��끟}��w7*�k&X���g:
S���{�i��c1c���48��g��/�.�{z��7;��M��Ҩ�#���齲,�/m��.��!@hh����A���?"Op�^���X��$�?h�ˣ2~r��������H{���Z���^b���T�� Uv2;h��oT���*.�_�¹fi?��/�v�����_�[�� I�GOڈ90�kB�vF���M�/o-2?�_�O8K�?%?��$3��+;���X��k�A�W�4�B(�3�@�V1^���d���Q��'=���0�|(.0���QO{G�Z*�	>���j���dv����H��EZI��m���kH~N��J�t=W��~_BhIq01$>m���@\J
��1hkm����7�8@�dA�H� ��枺ؗGܡX�&�& ���������ڟMq������^Y�����u��w���WzpY���y��������d��>�_�\�qzX��+Il���_�4X�W���'xQ>Gً���?��Ռ���=uJ�W�_ ߘ�)��=6�x��I�����qu�Q�#������;z#�O�Κ�6���E�#�����p0��x7��'�x��Y���h<�Y.�˛^�g����4ii{'��G����"����A�?�+���|у߂{8?@�ʗ�-z�_��,z�\���=�3����7�	�j�7�ZP\z��SR�2��0�� .��^�A��8��2t�A����`��C�*d��Az�M���c�~z��Be���5�����D���e��t���}_�~�,�M�ȃjWN��<�Z0	����;я�lm�$��� �:���@R���$2H�o�G�pp�%��ZoH{D&yo�	B�ǵ�%42��ut\Q��K�p�S�7}7�3�!�M	yu�0��		L�ϴx&�kdԟ���&L/����W���7���~X�d����Hx1����'�,�l����]���_ǊI���ɫ��HRG����Hv6⭴oklc�d�=���v�-s��A���e}�8�)�n��\?H#.]~����B&Fտ��A���M`z�>��!x��*8?�`���kQ�q��"�n2~zZsǪ�;�v�8d�;K{E���O�P���W�.�G�'�~��������`,=F�+Ӓ��3b6>��,���^�}D�A�S��yei�� BU����2��^���6�!��靥l�^k|�#�A�aD`<Hf{��=9�$��7��[���ېB&�_?B8����e}���*�#����������!���?��%���>}��������20�d6-�4U���>�-��#�_0h�8"g��5b���W䏈:����a��2����*�s1|�	�uP�ٷ�6�MK��9����B�{�D����Z��c!hojR݉��u���)��2r�@�p��?pY,��}mS)��ߛ�4R��gE�_mA�x��a�<�X�C/�QJD��Q7�������c����J�n�/����)!���W����\��3�H��8�x� �;C��Q��72�
� =^�]!��������c�"_(�?����_Y=��ȷ��w�����bd���g��t_��2���+�����s��A��"���82���X"�"]�f�^����q�kdc�ӳ5TR��q��uPyF��{�}��2���tp�"�BΣ�B���.C%ъ����8��5�[��s���w+�?���~�}�ϟC?���_Ѕ����w]����������p#���[���_������>,������'W���Y������~������7�7���~      �
   �   x���v
Q���W(�I���/.I�y%�
�):
`f<��T���Z�����Q��e��k*�9���+h�(�(������g`h��������i��IEˀ6�3ǰ�/19#��"�jj�i���Nc�i�ş�4����v�#�� ��_      �
   �  x��[MkG��W�цa���nr���P �sgc�kmV2��TM�x�����{�T��^�^߾~�������oӷχӏ�����Ӌ����?���?�������<}�z�p<�ӗ�������$p��pw����_��O����ǯ7o_��^���ɻ4O���Kp���y*���<ݾ��y���� 4~C��( -�4�)u�Ri`J���c��X|Qˬ��L#nBY�G��ŻRqn���XF> фf��	�O>�iؘ&U�8�F�X<��Y�s�'HJ6hr,(0Q
[W�_�
�������X��X(9�8H���#`��%/Ĕ	/�Acwk�!�={���oXJ�|������?�f&F�C�"�Ӱ�D(��5`M�F�$Z��U)��:K�f��	�o�0�I�9����i/�L-�d�IΛ���&�4�]�@�W�e����H��r7�+K�D�R^���'XU����K�cr�7�<��և5v�a	9P�h#2L��@��c[��K6��3�jeu�ڝ��ݡ�Nl��ǂr��lW��Ee͎��B*��Ń���!u�#n^�m�&�AY'�G��(�4`8����bg������pLJ��.*��>�Z���M$_`��vER*�$�L���7,���J�;�]���i�%Ḯׁ��&�c����M����ʼ��Sġѕ����\�)�&~4�ED��]�`��A�5g�hk�E���G�"J�
+�}'+͑P�R�f���`P�c�XǥV�/�B=�0�������떎z�hO�7��XE�{ �uc���u�����^�p�*U (�UZRW`IU��uw��5�����J�װD!-�Ȍ7Kֽ�ܴq��6fy��Qe�VO_����fI]��PӰe;�G ����'a �]�D�8��g[��J���Gt8K��j=R֭QH;��Q��!Yō�#��T��k.���֕dY7�r(H>�>u��a>�]o�NW�J+sǹ#l��2w���ð�-Pw��.�F�&5��Fz̜��W�����-$(.2��IG���-�[�j��w�z|�/JHyvw<&Y�ُ��X�B��Uu���'E��.�U�Œaf��nvcL�
C�-����Q�Z��K�J��nͥ�7i��� (�A��h��UW���9�ZP}Q�ew�BQ<�1�2��G^����ԩ      �
   g  x��ZMS�F��+fOf���d���!ec^��,[�KJFcibi�-)~������?�ǹ�,��He#���M��{=���brwO�o��d#�?�Z�c��u�U���Ì�T����I������*��GpْfT��'�٧ɂ'�=!�3�L2*�<�-�3��M���)9vm�{߃km����	9���c�v���~����"����("�ȥ蓁m�zx#�H¤T_rN�B>1MzJ8�*�
�5L��1Q$LS*�ژ��d��f��Q��h����<��P�I����^����>���a�(1�~!לD�J��Kx~�	��ϐ ��
���^s�RRDH����u:~�̳��~���G���`�` �8�1N7!<��XP�L�bN,r>#�c���tIF�9o�6����_��0���8�]R@�T	ag�ƔC�Õ�Vy�U�P�ON�?C�P!Ez~-%�ZJ��α5�	}\�/쑒��W�7�9F�GӧE���z��/D9������)�"�����\�hQ���ֳB�����z��/�ϹX�$���s��qh�W�	�e�Pc�Fl��&��
3�����u,���2y-�{!C�+%¸6�]�!P.�y���J�״� ��	�u		�F�"�o�A��a��RA&�b"�KѼ���9�KO�G�*� �{���Y�}p�{�6Z#��&���zq:�4�Awi����2a���RN���C����ӫ<���z�~2Q�fCI��)e�Q-�.��a���b|�SY� ��g
9���[���[�`SS�����ȃ^��=k���J��L3����	�)|��C�><F�F��R^�Vc栔�o9�v��]�.!�"C�E�A�pE����������������3Gö�����r^T�����2>S��,L��2�)+�=P�Ak���'aJN˩�q��`T���z;ց5p�emJৌ�5�c�C�U2�j��qMI��^��W�q���y=rZ�����P�7_+���|��Ӵ��%Fnr��{E\�F�︌ZO˳� a��T�ˌ
�ʲǄ6 �3j
��exF��|':W���u�*M�����rwၪ�����,�K�_->xRNy!���vHw+؇]`7�{/X�L��ԝ�~�6�l]j����y��/�����/Rj:����؆���W%}.b)�W���1�45��رA6��Q��`��ۂW�R'����=����;���k��x���b*�X�P���M򲔂@�y��J]�y�ꖦtI�;���T��j��Ds��Q����Co��~KJ&�S���k�k 鎺��g���D@m���3�z@��vEÜ]3ܒ��ηil�@,p��!��7��l�-��������R5�Z�Ku��h�e!��sh)h���!���0���(������
$T�A��]2ki�3V�#֘�K���ȥ�Yd���P�l �Z,^w��p5����kgи�R1َY�h����r��r?�ꎊX*�,C\�u[^k�3yV�Ԓ�ђ�R�{H��\�$_�*/)��n�x���`H�)Kc�dTAo$ˢu�m>h���a��=�y�+�?�VuW
�*&!.��,�pI�u�=�&��Ĳ)r�-�Ѯ���^���3����e���0����b�+Ⱦ���$-�|�T{�|F1p�wm��|'�=c�(=�\�[�(��F4��ֿ��W�q%l�p=��������R=U�^r
����л8?��ݜ��*�f��w�޵5u�X
�|Wq��l����xm;g��Iq���"�`�P���vE��:�"^��C\���/��IB�i�5���o��s�
���]�7:{��=حm����?AC�      �
   �  x�ݜK��F���+Z\Ҍ��"EB"�G\�w׻;aƃ�!���gp�?���g��v��C��0�`����y�������w�~'���96����zE��Mw�n����ۮnVd���V�ꎻ������ۓX�^<�+���aE.�]}��3���_~$O���TkZR�"vE
N�\S�f��%Ċ������_.^'�E�Q���� W�wg�b%�ӥzX� � X�Ť���9-b�.~����M��\��M�׮%������a|[�-��+���i�]�������ȱ�&_�m��5<lIֿ�Wu�}�麺�䫻��o��۾����.�D�Ӡ6P���T�Es��f����d@O�+��3�׌��+b	��G�8�If���5�OR���3`�`\�8In�XB!-0:u�8S3������``�Fp5��k�ϼ �,x���<�/�B�y��.��2x��kLKX�^0������!�O �10�C�p��aj�T�9�pM��~�"���>�ㆹR. ؛/;�hɖ�ˆ,�il�Xꁋ7⺂����pM�>C$�?/�dtL񚒼0������;�#����T��U�]�65y�:և�A�$K���a����}��|�� e,���S���N�R�`i�O�q9�U��d�bK��T�\����"��c-�n�)=9�\e�b ��*3	�2(�!�J���� ����i±ӓc��W��AJ�I"1�v��ٵ�R�T�!e�{`:F�8�
�/���)XC�/��x�3�!0	v��P%���8����p�s�!/F:�	��X�, �"4�M�������"���Ee�;Y� �1k:R��s����\���ƈ� �'�@�|�#bbЪ,b)=1:�}Ǉc�=��:ƥ��P���3l�� g��`�,�xr�LP9�q'!%0{Bۨw�)���Pf�����&�~�wX#9ǣv�8O�����H�5D�<Z��U���x�o��r���2_�˙!�ܚ�dF��PǴ4��R�Ɓ�&q�F�<^ٻ����]&	�R>2��B�A���QO��q
�R5�[�F�)���z��*�V˕�:7��ɔ��kv�#r�0�1!�4[.�y��)E�߽~�lq�I0ᔢd*zS�Rz�C�3��g��%�X���H��]��mD�]ׯ~?�ɡ�*?�lIS놼� x�����6�F��3�$ԆY>�4����̜���d�����a&�U��ޗO�g��ːע7G�Z6��Q��ΛE�(�+�
�G����ؠR�����%xΣ�5�Z"�)b)=��4a;欈��� kA��Cð��3��~(:4�;^����[t')=0�9|�B�8l�q��$����q6YqFDS�Rz`�s�Ǎ���M�i%�)0:԰X�I`a�S,�]��`��qEݚ��D����dq�.W^9�D.�G��p���cA��T˖7,:l+Ji�x�7_b�/��_��̙;���]�v8���>��.����, V�}��=K�q����J-�:0
�D��r�v�"��%ƪ���������X��C8�K�B��w�{ihV����$��M��z��(N{���-6R�L�,�k>Z�����wZ�`{H�wMKɁj������j�jb��<h?K ���Y8|�E=�����)~PǏ\�m_.	���X��y&��S
t���M��Kf���Q�cF�.6����� ��      �
   a   x���v
Q���W(JM��+�K/�J�(R��L�Q �4�}B]�4�t��5��<I�f�fB�6�6SR���������͜Tm�`mF@m\\ O�_I         F  x��WMo�0��W�F�R)@��-��]@@��7��Īc#�����{�?�3-q�S����$���<�Ѭ?���h>&NZ�%�r��9O�d�uN���Z�e&i���M�ba����"��H��}u�u��5ˌ�l��¯N����ܟ��F����;������	�2.\֦�*�{b�n�Xo�C0܆!��M��c���ۇ\�8V �g2�K2��J�k(S&9s�A	�
���2SxY{��%�T	q5+R�X�qv|��I���mA*�|���)��; /L��WJ��Ri�p�5G,w*璿�
蛿2՛OY&�yV� �(�l�t�hCO�=��sc֙��"�2����v��^��Q��FyM��1	l�ZP[�`1���s��U���ر�ǊP�Q�\
�@x�:��IA�@���4ٙǞ'��f�p�ǄY�!���c,I�'l`�<qf���U�5�+��Ȩ�e���sR��e<o��r|Qtu^Pr�g	��3/�����[��s����/��\�T�!�<~����/�2P%�5��om�6��W���cw�^}���Đ��#�q�'=<��	�g�.�m"ܰ��GN�8��)*��o����~گ��.�r+ƈ�E�kc��T�BO�h�w���2�i�
��ޢ�h���، �T.�ʑ���qz��J�=%>8@lU,
,?�^��[́�Cم'Sv�w=�d�,Aˀ�X����wp+�K<�G�
��2if+��{N��0U�ی{hH5��eT=��<-�zT�'J�%<�4ڨ�V�A�����K��]�U�RS;��o1��x��[Y̶l�[8ר��JX���u=�V         o   x���v
Q���W(K-J/M-)�K/N,*Q��L�Q 24�}B]�4uԽ�KR�R�3�5��<I�n�^�XZ����C�fc��Դ���̲Tל��Լ�T�1\\ )=:     