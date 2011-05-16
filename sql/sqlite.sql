CREATE TABLE 'type' (
    id         INTEGER PRIMARY KEY,
    name       VARCHAR(50) NOT NULL DEFAULT '',
    name_en    VARCHAR(50) NOT NULL DEFAULT '',
    kind       INTEGER     NOT NULL DEFAULT 0,
    mischief   INTEGER     NOT NULL DEFAULT 0,
    graceful   INTEGER     NOT NULL DEFAULT 0,
    showy      INTEGER     NOT NULL DEFAULT 0,
    aggressive INTEGER     NOT NULL DEFAULT 0,
    reserved   INTEGER     NOT NULL DEFAULT 0,
    vigor      INTEGER     NOT NULL DEFAULT 0,
    shy        INTEGER     NOT NULL DEFAULT 0,
    curiosity  INTEGER     NOT NULL DEFAULT 0,
    mild       INTEGER     NOT NULL DEFAULT 0
);
INSERT INTO type (name, name_en) VALUES ('デフォルト', 'default');
INSERT INTO type (name, name_en, kind, mischief, graceful, showy, aggressive, reserved, vigor, shy, curiosity, mild) VALUES ('天然', 'natural', 200, 200, 200, 200, 200, 200, 200, 200, 200, 200);
INSERT INTO type (name, name_en, kind, vigor, curiosity, mild) VALUES ('甘えん坊', 'spoiled', 1000, 500, 500, 400);

