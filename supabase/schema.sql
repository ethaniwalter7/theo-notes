-- Theo Notes – Supabase schema (v2 – columnar tables)
-- Run in: https://supabase.com/dashboard/project/mzwnqybhwdsnqbeqslzg/sql/new

-- ── NOTES TABLE ──────────────────────────────────────────────
-- One row per note; project_id distinguishes projects (default = 1)
CREATE TABLE IF NOT EXISTS notes (
  id          TEXT    NOT NULL,
  project_id  INTEGER NOT NULL DEFAULT 1,
  title       TEXT    NOT NULL DEFAULT '',
  content     TEXT    NOT NULL DEFAULT '',
  category    TEXT    NOT NULL DEFAULT 'general',
  note_date   TEXT    NOT NULL DEFAULT '',
  PRIMARY KEY (id, project_id)
);

ALTER TABLE notes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "notes_anon_read"   ON notes FOR SELECT USING (true);
CREATE POLICY "notes_anon_insert" ON notes FOR INSERT WITH CHECK (true);
CREATE POLICY "notes_anon_update" ON notes FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "notes_anon_delete" ON notes FOR DELETE USING (true);

-- ── CONNECTIONS TABLE ─────────────────────────────────────────
-- One row per connection between notes within a project
CREATE TABLE IF NOT EXISTS connections (
  id          SERIAL  PRIMARY KEY,
  project_id  INTEGER NOT NULL DEFAULT 1,
  source_id   TEXT    NOT NULL,
  target_id   TEXT    NOT NULL,
  UNIQUE (project_id, source_id, target_id)
);

ALTER TABLE connections ENABLE ROW LEVEL SECURITY;
CREATE POLICY "conn_anon_read"   ON connections FOR SELECT USING (true);
CREATE POLICY "conn_anon_insert" ON connections FOR INSERT WITH CHECK (true);
CREATE POLICY "conn_anon_delete" ON connections FOR DELETE USING (true);

-- ── LEGACY TABLE (kept for reference, no longer used by app) ──
-- CREATE TABLE IF NOT EXISTS notes_data (
--   id INTEGER PRIMARY KEY DEFAULT 1, payload JSONB, updated_at TIMESTAMPTZ DEFAULT NOW()
-- );
