﻿-- Verifikation:
-- Aufträge ohne Ende-Datum
-- Aufträge ohne Planzahlungen


-- to_char(12454.8, E'999\'999\'999\'999D99S')

-- Alle laufenden Projekte.
-- Projekte ohne 'datum_ende'

/*
SELECT proj.*, konto.nr, konto."name" 
FROM av_geschaeftskontrolle.projekt as proj, av_geschaeftskontrolle.konto as konto
WHERE konto.id = proj.konto_id
AND datum_ende IS NULL or trim('' from datum_ende::text) = ''
ORDER BY datum_start, proj."name";
*/

-- Finanzbedarf für das Jahr XXXX
/*
SELECT a.*, b."name"
FROM
(
 SELECT sum(pz.kosten), auf."name", sum(pz.prozent), auf.projekt_id
 FROM av_geschaeftskontrolle.planzahlung as pz, av_geschaeftskontrolle.auftrag as auf, 
      av_geschaeftskontrolle.projekt as proj 
 WHERE pz.auftrag_id = auf.id
 AND auf.projekt_id = proj.id
 AND rechnungsjahr = 2014
 GROUP BY auf.id
) as a, av_geschaeftskontrolle.projekt as b
WHERE a.projekt_id = b.id
ORDER BY b."name", a."name"
*/

-- IDEE: auch geglieder nach Konto, so entspricht summe - differenz dem was ich noch zur verfügung habe.

/*
SELECT *
FROM
(
SELECT c.nr, c."name", a.*, b."name"
FROM
(
 SELECT sum(pz.kosten), auf."name", sum(pz.prozent), auf.id, auf.projekt_id
 FROM av_geschaeftskontrolle.planzahlung as pz, av_geschaeftskontrolle.auftrag as auf, 
      av_geschaeftskontrolle.projekt as proj 
 WHERE pz.auftrag_id = auf.id
 AND auf.projekt_id = proj.id
 AND rechnungsjahr = 2014
 GROUP BY auf.id
) as a, av_geschaeftskontrolle.projekt as b, av_geschaeftskontrolle.konto as c
WHERE a.projekt_id = b.id
AND b.konto_id = c.id
ORDER BY b."name", a."name"
) as x LEFT JOIN 
(
SELECT c.nr, c."name", a.*, b."name"
FROM
(
 SELECT sum(pz.kosten), auf."name", sum(pz.prozent), auf.id, auf.projekt_id
 FROM av_geschaeftskontrolle.planzahlung as pz, av_geschaeftskontrolle.auftrag as auf, 
      av_geschaeftskontrolle.projekt as proj 
 WHERE pz.auftrag_id = auf.id
 AND auf.projekt_id = proj.id
 AND rechnungsjahr = 2015
 GROUP BY auf.id
) as a, av_geschaeftskontrolle.projekt as b, av_geschaeftskontrolle.konto as c
WHERE a.projekt_id = b.id
AND b.konto_id = c.id
ORDER BY b."name", a."name"
) as y ON (y.id = x.id)
*/

/*
-- laufende Aufträge
CREATE OR REPLACE VIEW av_geschaeftskontrolle.vr_laufende_auftraege AS 

SELECT auftrag.*, rechnung.bezahlt, (auftrag.kosten_inkl - CASE WHEN rechnung.bezahlt IS NULL THEN 0 ELSE rechnung.bezahlt END) as ausstehend
FROM
(
 SELECT auf.id as auf_id, auf."name" as auftrag_name, u.firma as firma, auf.geplant, proj.id as proj_id, proj."name" as projekt_name, konto.nr::text as konto, auf.datum_start, auf.datum_ende, auf.kosten as kosten_exkl, auf.mwst, (auf.kosten * (1 + auf.mwst / 100)) as kosten_inkl
 FROM av_geschaeftskontrolle.auftrag as auf, av_geschaeftskontrolle.projekt as proj, av_geschaeftskontrolle.konto as konto, av_geschaeftskontrolle.unternehmer as u
 WHERE auf.projekt_id = proj.id
 AND proj.konto_id = konto.id
 AND auf.unternehmer_id = u.id
 AND auf.datum_abschluss IS NULL or trim('' from datum_abschluss::text) = ''
 ORDER BY auf.datum_start, auf."name"
) as auftrag LEFT JOIN
(
 SELECT sum(kosten * (1 + mwst / 100)) as bezahlt, auftrag_id
 FROM av_geschaeftskontrolle.rechnung
 GROUP BY auftrag_id
) as rechnung ON (rechnung.auftrag_id = auftrag.auf_id);


GRANT ALL ON TABLE av_geschaeftskontrolle.vr_laufende_auftraege TO stefan;
GRANT SELECT ON TABLE av_geschaeftskontrolle.vr_laufende_auftraege TO mspublic;
*/

/*
CREATE OR REPLACE VIEW av_geschaeftskontrolle.vr_zahlungsplan_14_17 AS 

SELECT auf_name, proj."name" as proj_name, konto."nr" as konto, auf_start, auf_ende, auf_abschluss, plan_summe_a, plan_prozent_a, re_summe_a, (re_summe_a / auf_summe) * 100 as re_prozent_a,  plan_summe_b, plan_prozent_b, plan_summe_c, plan_prozent_c, plan_summe_d, plan_prozent_d, a_id, projekt_id
FROM
(
 SELECT *
 FROM
 (
  SELECT auf."name" as auf_name, auf.datum_start as auf_start, auf.datum_ende as auf_ende, auf.datum_abschluss as auf_abschluss, (auf.kosten * (1 + (auf.mwst/100))) as auf_summe, sum(pz.kosten * (1 + (pz.mwst/100))) as plan_summe_a, sum(pz.prozent) as plan_prozent_a, auf.id as a_id, auf.projekt_id
  FROM av_geschaeftskontrolle.planzahlung as pz, av_geschaeftskontrolle.auftrag as auf
  WHERE pz.auftrag_id = auf.id
  AND pz.rechnungsjahr = 2014
  GROUP BY auf.id
 ) as a LEFT JOIN
 (
  SELECT sum(re.kosten * (1 + (re.mwst/100))) as re_summe_a, auf.id as r_id
  FROM av_geschaeftskontrolle.rechnung as re, av_geschaeftskontrolle.auftrag as auf
  WHERE re.auftrag_id = auf.id
  AND re.rechnungsjahr = 2014
  GROUP BY auf.id
 ) as r ON (a.a_id = r.r_id) LEFT JOIN
 (
  SELECT sum(pz.kosten * (1 + (pz.mwst/100))) as plan_summe_b, sum(pz.prozent) as plan_prozent_b, auf.id as b_id
  FROM av_geschaeftskontrolle.planzahlung as pz, av_geschaeftskontrolle.auftrag as auf
  WHERE pz.auftrag_id = auf.id
  AND pz.rechnungsjahr = 2015
  GROUP BY auf.id
 ) as b ON (a.a_id = b.b_id) LEFT JOIN
 (
  SELECT sum(pz.kosten * (1 + (pz.mwst/100))) as plan_summe_c, sum(pz.prozent) as plan_prozent_c, auf.id as c_id
  FROM av_geschaeftskontrolle.planzahlung as pz, av_geschaeftskontrolle.auftrag as auf
  WHERE pz.auftrag_id = auf.id
  AND pz.rechnungsjahr = 2016
  GROUP BY auf.id
 ) as c ON (a.a_id = c.c_id) LEFT JOIN
 (
  SELECT sum(pz.kosten * (1 + (pz.mwst/100))) as plan_summe_d, sum(pz.prozent) as plan_prozent_d, auf.id as d_id
  FROM av_geschaeftskontrolle.planzahlung as pz, av_geschaeftskontrolle.auftrag as auf
  WHERE pz.auftrag_id = auf.id
  AND pz.rechnungsjahr = 2017
  GROUP BY auf.id
 ) as d ON (a.a_id = d.d_id)
) as foo, av_geschaeftskontrolle.projekt as proj, av_geschaeftskontrolle.konto as konto
WHERE foo.projekt_id = proj.id
AND proj.konto_id = konto.id
ORDER BY konto, auf_name;

GRANT ALL ON TABLE av_geschaeftskontrolle.vr_zahlungsplan_14_17 TO stefan;
GRANT SELECT ON TABLE av_geschaeftskontrolle.vr_zahlungsplan_14_17 TO mspublic;
*/

/*
CREATE OR REPLACE VIEW av_geschaeftskontrolle.vr_kontr_planprozent AS 

SELECT a."name" as auf_name, d.firma, b."name" as proj_name, c.nr as konto_nr, a.sum_planprozent
FROM
(
 SELECT sum(pz.kosten) as sum_plankosten_exkl, auf."name", sum(pz.prozent) as sum_planprozent, auf.projekt_id, auf.unternehmer_id
 FROM av_geschaeftskontrolle.planzahlung as pz, av_geschaeftskontrolle.auftrag as auf, 
      av_geschaeftskontrolle.projekt as proj 
 WHERE pz.auftrag_id = auf.id
 AND auf.projekt_id = proj.id
 AND auf.datum_abschluss IS NULL or trim('' from datum_abschluss::text) = ''
 GROUP BY auf.id
) as a, av_geschaeftskontrolle.projekt as b, av_geschaeftskontrolle.konto as c, av_geschaeftskontrolle.unternehmer as d
WHERE a.projekt_id = b.idfile_1388497342682.jrxml
AND c.id = b.konto_id
AND a.unternehmer_id = d.id
ORDER BY b."name", a."name";

GRANT ALL ON TABLE av_geschaeftskontrolle.vr_kontr_planprozent TO stefan;
GRANT SELECT ON TABLE av_geschaeftskontrolle.vr_kontr_planprozent TO mspublic;

*/

CREATE OR REPLACE VIEW av_geschaeftskontrolle.vr_firma_verpflichtungen AS 

SELECT foo.firma, foo.jahr, foo.kosten_vertrag_inkl, bar.kosten_bezahlt_inkl
FROM
(
 SELECT a.*, un.firma
 FROM
 (
  SELECT sum(kosten * (1 + mwst/100)) as kosten_vertrag_inkl, unternehmer_id, EXTRACT(YEAR FROM datum_start) as jahr 
  FROM av_geschaeftskontrolle.auftrag as auf
  WHERE geplant = false
  GROUP BY unternehmer_id, EXTRACT(YEAR FROM datum_start)
 ) as a, av_geschaeftskontrolle.unternehmer as un
 WHERE a.unternehmer_id = un.id
) as foo

LEFT JOIN

(
 SELECT a.*, auf.id, auf.unternehmer_id 
 FROM 
 (
  SELECT sum(kosten * (1 + mwst/100)) as kosten_bezahlt_inkl, auftrag_id, rechnungsjahr
  FROM av_geschaeftskontrolle.rechnung
  GROUP BY auftrag_id, rechnungsjahr
 ) as a, av_geschaeftskontrolle.auftrag as auf
 WHERE a.auftrag_id = auf.id
) bar 

ON (foo.unternehmer_id = bar.unternehmer_id AND foo.jahr = bar.rechnungsjahr);

GRANT ALL ON TABLE av_geschaeftskontrolle.vr_firma_verpflichtungen TO stefan;
GRANT SELECT ON TABLE av_geschaeftskontrolle.vr_firma_verpflichtungen TO mspublic;

