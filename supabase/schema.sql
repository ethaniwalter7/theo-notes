-- Theo Notes – Supabase schema
-- Run this once in the Supabase SQL Editor (Database → SQL Editor → New Query)

-- Single-row table that stores the entire notes payload as JSON
CREATE TABLE IF NOT EXISTS notes_data (
  id          INTEGER PRIMARY KEY DEFAULT 1,
  payload     JSONB   NOT NULL,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Constraint: only ever one row
CREATE UNIQUE INDEX IF NOT EXISTS notes_data_singleton ON notes_data (id);

-- Enable Row Level Security
ALTER TABLE notes_data ENABLE ROW LEVEL SECURITY;

-- Allow the anon key to read and write (personal single-user app)
CREATE POLICY "anon_read"  ON notes_data FOR SELECT USING (true);
CREATE POLICY "anon_write" ON notes_data FOR INSERT WITH CHECK (true);
CREATE POLICY "anon_update" ON notes_data FOR UPDATE USING (true) WITH CHECK (true);
