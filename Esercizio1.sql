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
INSERT INTO clienti (nome, cognome, datanascita, regioneresidenza) VALUES ('Mario', 'Rossi', 1980, 'Lazio');
INSERT INTO clienti (nome, cognome, datanascita, regioneresidenza) VALUES ('Anna', 'Verdi', 1982, 'Lazio');
INSERT INTO clienti (nome, cognome, datanascita, regioneresidenza) VALUES ('Aldo', 'Neri', 1982, 'Lombardia');
INSERT INTO clienti (nome, cognome, datanascita, regioneresidenza) VALUES ('Giovanni', 'Bianchi', 1990, 'Puglia');
INSERT INTO clienti (nome, cognome, datanascita, regioneresidenza) VALUES ('Giulia', 'Rosa', 1980, 'Basilicata');

INSERT INTO fatture (tipologia, importo, iva, idcliente, datafattura, numerofornitore) VALUES ('A', 50, 10, 3, 2022, 2);
INSERT INTO fatture (tipologia, importo, iva, idcliente, datafattura, numerofornitore) VALUES ('A', 20, 20, 2, 2020, 2);
INSERT INTO fatture (tipologia, importo, iva, idcliente, datafattura, numerofornitore) VALUES ('B', 30, 20, 2, 2021, 1);
INSERT INTO fatture (tipologia, importo, iva, idcliente, datafattura, numerofornitore) VALUES ('A', 100, 10, 1, 2022, 2);

INSERT INTO prodotti (descrizione, inproduzione, incommercio, dataattivazione, datadisattivazione) VALUES ('pallone da calcio', TRUE, FALSE, 2017, 2120);
INSERT INTO prodotti (descrizione, inproduzione, incommercio, dataattivazione, datadisattivazione) VALUES ('pallone da pallavolo', TRUE, TRUE, 2022, 2122);
INSERT INTO prodotti (descrizione, inproduzione, incommercio, dataattivazione, datadisattivazione) VALUES ('pallone da basket', FALSE, TRUE, 2017, 2121);
INSERT INTO prodotti (descrizione, inproduzione, incommercio, dataattivazione, datadisattivazione) VALUES ('ombrellone da spiaggia', FALSE, FALSE, 2017, 2040);
INSERT INTO prodotti (descrizione, inproduzione, incommercio, dataattivazione, datadisattivazione) VALUES ('tiragraffi per gatti', TRUE, TRUE, 2023, 2025);

INSERT INTO fornitori (denominazione, regioneresidenza) VALUES ('MondoSport', 'Lazio');
INSERT INTO fornitori (denominazione, regioneresidenza) VALUES ('PetWorld', 'Lombardia');
INSERT INTO fornitori (denominazione, regioneresidenza) VALUES ('Funlab', 'Veneto');


-- QUERIES

SELECT nome, cognome FROM clienti WHERE datanascita = 1982;
SELECT numerofattura FROM fatture WHERE iva = 20;
SELECT datafattura, SUM (importo) AS somma FROM fatture GROUP BY datafattura; /* ??? */
SELECT descrizione FROM prodotti WHERE dataattivazione = 2017 and inproduzione = TRUE or incommercio = TRUE;
SELECT datafattura, count(*) FROM fatture WHERE iva = 20 GROUP BY datafattura;
SELECT datafattura, count(*) FROM fatture WHERE tipologia = 'A' GROUP BY datafattura HAVING COUNT(*) >= 2;
SELECT numerofattura, importo, iva, datafattura, denominazione FROM fatture INNER JOIN fornitori on fatture.numerofornitore = fornitori.numerofornitore;
SELECT SUM (importo) AS somma FROM fatture INNER JOIN clienti on fatture.idcliente = clienti.numerocliente GROUP BY regioneresidenza;
--SELECT * FROM clienti WHERE datanascita = 1980 and fatture.idcliente in (SELECT idcliente FROM fatture WHERE importo > 50);
--SELECT idcliente FROM fatture WHERE importo > 50 and idcliente IN (SELECT nome FROM clienti WHERE datanascita = 1980);

-- Boh non ci sto riuscendo
