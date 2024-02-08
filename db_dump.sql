PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
DROP TABLE IF EXISTS 'domainlist_by_group';
DROP TABLE IF EXISTS 'group';
DROP TABLE IF EXISTS 'domainlist';
DROP TABLE IF EXISTS 'adlist';
CREATE TABLE IF NOT EXISTS "group"
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	enabled BOOLEAN NOT NULL DEFAULT 1,
	name TEXT UNIQUE NOT NULL,
	date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	description TEXT
);
INSERT INTO "group" VALUES(0,1,'Default',1706559061,1706559061,'The default group');
CREATE TABLE domainlist
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	type INTEGER NOT NULL DEFAULT 0,
	domain TEXT NOT NULL,
	enabled BOOLEAN NOT NULL DEFAULT 1,
	date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	comment TEXT,
	UNIQUE(domain, type)
);
INSERT INTO domainlist VALUES(2,0,'fls-na.amazon.com',1,1706689716,1706689716,'Added from Query Log');
CREATE TABLE adlist
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	address TEXT UNIQUE NOT NULL,
	enabled BOOLEAN NOT NULL DEFAULT 1,
	date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
	comment TEXT,
	date_updated INTEGER,
	number INTEGER NOT NULL DEFAULT 0,
	invalid_domains INTEGER NOT NULL DEFAULT 0,
	status INTEGER NOT NULL DEFAULT 0
);
INSERT INTO adlist VALUES(1,'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',1,1706559061,1706559061,'Migrated from /etc/pihole/adlists.list',1707422098,162080,1,2);
INSERT INTO adlist VALUES(2,'https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt',1,1707247825,1707247825,'PolishFilters Team',1707422100,123686,1,1);
INSERT INTO adlist VALUES(3,'https://adaway.org/hosts.txt',1,1707248531,1707248531,'Adaway',1707422102,6540,0,2);
INSERT INTO adlist VALUES(4,'https://github.com/DandelionSprout/adfilt',1,1707255312,1707255312,'DandelionSprout&#039;s Anti-Malware List',1707422103,180,1881,1);
CREATE TABLE domainlist_by_group
(
	domainlist_id INTEGER NOT NULL REFERENCES domainlist (id),
	group_id INTEGER NOT NULL REFERENCES "group" (id),
	PRIMARY KEY (domainlist_id, group_id)
);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(1,2,0);
COMMIT;
