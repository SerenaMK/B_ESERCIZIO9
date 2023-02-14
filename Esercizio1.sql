-- CREAZIONE TABELLE

CREATE TABLE IF NOT EXISTS clienti (
	numerocliente SERIAL PRIMARY KEY,
	nome VARCHAR NOT NULL,
	cognome VARCHAR NOT NULL,
	datanascita INT4 NOT NULL,
	regioneresidenza VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS fatture (
	numerofattura SERIAL PRIMARY KEY,
	tipologia VARCHAR NOT NULL,
	importo INT8 NOT NULL,
	iva INT4 NOT NULL,
	idcliente INT8 NOT NULL,
	datafattura INT4 NOT NULL,
	numerofornitore INT4 NOT NULL,
	CONSTRAINT idcliente_fk FOREIGN KEY (idcliente) REFERENCES clienti(numerocliente),
	CONSTRAINT numerofornitore_fk FOREIGN KEY (numerofornitore) REFERENCES fornitori(numerofornitore)
);

CREATE TABLE IF NOT EXISTS prodotti (
	idprodotto SERIAL PRIMARY KEY,
	descrizione VARCHAR NOT NULL,
	inproduzione boolean NOT NULL,
	incommercio boolean NOT NULL,
	dataattivazione INT4 NOT NULL,
	datadisattivazione INT4 NOT NULL
);

CREATE TABLE IF NOT EXISTS fornitori (
	numerofornitore SERIAL PRIMARY KEY,
	denominazione VARCHAR NOT NULL,
	regioneresidenza VARCHAR NOT NULL
);


--/*
DROP TABLE fatture;
DROP TABLE clienti;
DROP TABLE prodotti;
DROP TABLE fornitori;
--*/

-- inserimento dati
INSERT INTO clienti (nome, cognome, datanascita, regioneresidenza)
			VALUES	('Mario', 'Rossi', 1980, 'Lazio'),
					('Anna', 'Verdi', 1982, 'Lazio'),
					('Aldo', 'Neri', 1982, 'Lombardia'
					('Giovanni', 'Bianchi', 1990, 'Puglia')
					('Giulia', 'Rosa', 1980, 'Basilicata');

INSERT INTO fatture (tipologia, importo, iva, idcliente, datafattura, numerofornitore)
			 VALUES	('A', 50, 10, 3, 2022, 2),
					('A', 20, 20, 2, 2020, 2),
					('B', 30, 20, 2, 2021, 1),
					('A', 100, 10, 1, 2022, 2);

INSERT INTO prodotti (descrizione, inproduzione, incommercio, dataattivazione, datadisattivazione)
			 VALUES	('pallone da calcio', TRUE, FALSE, 2017, 2120),
			 		('pallone da pallavolo', TRUE, TRUE, 2022, 2122),
			 		('pallone da basket', FALSE, TRUE, 2017, 2121),
			 		('ombrellone da spiaggia', FALSE, FALSE, 2017, 2040),
			 		('tiragraffi per gatti', TRUE, TRUE, 2023, 2025);


INSERT INTO fornitori (denominazione, regioneresidenza)
			 VALUES ('MondoSport', 'Lazio'),
			 		('PetWorld', 'Lombardia'),
			 		('Funlab', 'Veneto');


/* QUERIES */
			 
--Estrarre il nome e il cognome dei clienti nati nel 1982
SELECT
	nome, cognome
	FROM clienti
	WHERE datanascita = 1982;
	
--Estrarre il numero delle fatture con iva al 20%
SELECT
	numerofattura
	FROM fatture
	WHERE iva = 20;
	
--Riportare il numero di fatture e la somma dei relativi importi divisi per anno di fatturazione
SELECT 
	datafattura AS anno,
	COUNT(*),
	SUM(importo) AS somma
	FROM fatture
	GROUP BY datafattura;
	
--Estrarre i prodotti attivati nel 2017 e che sono in produzione oppure in commercio
SELECT
	descrizione
	FROM prodotti
	WHERE dataattivazione = 2017
	and inproduzione = TRUE
	or incommercio = TRUE;
	
--Considerando soltanto le fatture con iva al 20 per cento, estrarre il numero di fatture per ogni anno
SELECT
	datafattura,
	count(*)
	FROM fatture
	WHERE iva = 20
	GROUP BY datafattura;
	
--Estrarre gli anni in cui sono state registrate più di 2 fatture con tipologia ‘A’
SELECT
	datafattura,
	count(*)
	FROM fatture
	WHERE tipologia = 'A'
	GROUP BY datafattura
	HAVING COUNT(*) >= 2;
	
--Riportare l’elenco delle fatture (numero, importo, iva e data) con in aggiunta il nome del fornitore
SELECT
	numerofattura, importo, iva, datafattura, denominazione
	FROM fatture
	INNER JOIN fornitori
	on fatture.numerofornitore = fornitori.numerofornitore;
	
--Estrarre il totale degli importi delle fatture divisi per residenza dei clienti
SELECT
	SUM (importo) AS somma
	FROM fatture
	INNER JOIN clienti
	on fatture.idcliente = clienti.numerocliente
	GROUP BY regioneresidenza;
	
--Estrarre il numero dei clienti nati nel 1980 che hanno almeno una fattura superiore a 50 euro
SELECT
	COUNT(c.numerocliente)
	FROM clienti AS c
	INNER JOIN fatture AS f
	ON c.numerocliente = f.idcliente
	WHERE datanascita = 1980
	AND f.importo > 50;

/* Estrarre una colonna di nome “Denominazione” contenente il nome, seguito da un carattere “-“, seguito dal cognome, per i
soli clienti residenti nella regione Lombardia */
SELECT
	CONCAT (nome, ' - ', cognome) AS denominazione
	FROM clienti
	WHERE regioneresidenza = 'Lombardia';