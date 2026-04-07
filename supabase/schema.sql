-- Theo Notes – Supabase schema
-- Run this once in the Supabase SQL Editor (Database → SQL Editor → New Query)
-- No migration needed if you already ran the original version.

-- One row per project; the default project uses id=1, others use a hash of their string ID.
CREATE TABLE IF NOT EXISTS notes_data (
  id          INTEGER     PRIMARY KEY DEFAULT 1,
  payload     JSONB       NOT NULL,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE notes_data ENABLE ROW LEVEL SECURITY;

-- Allow the anon key to read and write (personal single-user app)
CREATE POLICY "anon_read"   ON notes_data FOR SELECT USING (true);
CREATE POLICY "anon_write"  ON notes_data FOR INSERT WITH CHECK (true);
CREATE POLICY "anon_update" ON notes_data FOR UPDATE USING (true) WITH CHECK (true);
