CREATE TABLE 'Reservations' (
	'id'	INTEGER,
	'name'	TEXT,
	'amount'	TEXT,
	'from'	TEXT,
	'to'	TEXT,
	'day'	TEXT,
	'date'	TEXT,
	PRIMARY KEY('id' AUTOINCREMENT)
);


CREATE TABLE 'Cash' (
	'id'	INTEGER,
	'item'	TEXT,
	'amount'	TEXT,
	PRIMARY KEY('id' AUTOINCREMENT)
);

CREATE TABLE 'People' (
	'id'	INTEGER,
	'name'	TEXT,
	PRIMARY KEY('id' AUTOINCREMENT)
);

CREATE TABLE 'user' (
	'id'	INTEGER NOT NULL,
	'name'	TEXT,
	'pas'	TEXT,
	PRIMARY KEY('id')
);