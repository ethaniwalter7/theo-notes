-- Theo Notes – Supabase schema
-- Run this once in the Supabase SQL Editor (Database → SQL Editor → New Query)

-- Multi-project table: one row per project
CREATE TABLE IF NOT EXISTS notes_data (
  project_id  TEXT        PRIMARY KEY DEFAULT 'default',
  payload     JSONB       NOT NULL,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE notes_data ENABLE ROW LEVEL SECURITY;

-- Allow the anon key to read and write (personal single-user app)
CREATE POLICY "anon_read"   ON notes_data FOR SELECT USING (true);
CREATE POLICY "anon_write"  ON notes_data FOR INSERT WITH CHECK (true);
CREATE POLICY "anon_update" ON notes_data FOR UPDATE USING (true) WITH CHECK (true);

-- ── Migration (run if you already created the old schema with id INTEGER) ──
-- DROP TABLE IF EXISTS notes_data;
-- Then re-run the CREATE TABLE above.
