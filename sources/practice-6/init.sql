-- Схема базы данных учебного стенда «Умный офис».
-- Применяется к data/telemetry.sqlite3 до первого запуска контейнера storage:
--   sqlite3 data/telemetry.sqlite3 < init.sql

PRAGMA journal_mode = WAL;

CREATE TABLE IF NOT EXISTS measurements (
    id INTEGER PRIMARY KEY,
    source TEXT NOT NULL,
    device_id TEXT NOT NULL,
    metric TEXT NOT NULL,
    zone TEXT NOT NULL,
    timestamp INTEGER NOT NULL,
    received_at INTEGER NOT NULL,
    value REAL NOT NULL,
    unit TEXT NOT NULL,
    labels TEXT NOT NULL DEFAULT '{}'
);

CREATE TABLE IF NOT EXISTS actuator_events (
    id INTEGER PRIMARY KEY,
    source TEXT NOT NULL,
    device_id TEXT NOT NULL,
    zone TEXT NOT NULL,
    timestamp INTEGER NOT NULL,
    received_at INTEGER NOT NULL,
    state TEXT NOT NULL,
    mode TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_measurements_device_time
    ON measurements (device_id, timestamp);

CREATE INDEX IF NOT EXISTS idx_actuator_events_device_time
    ON actuator_events (device_id, timestamp);
