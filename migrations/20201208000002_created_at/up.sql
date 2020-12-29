-- Add created_at columns
-- Must add the column with a default set because of NOT NULL so any existing
-- rows are updated.
ALTER TABLE genders
    ADD COLUMN created_at DATETIME NOT NULL DEFAULT '2020-12-08 00:00:02';
ALTER TABLE people
    ADD COLUMN created_at DATETIME NOT NULL DEFAULT '2020-12-08 00:00:02';
ALTER TABLE pronouns
    ADD COLUMN created_at DATETIME NOT NULL DEFAULT '2020-12-08 00:00:02';
-- Can now drop the defaults so column must be given a value during future inserts.
ALTER TABLE genders
    ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE people
    ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE pronouns
    ALTER COLUMN created_at DROP DEFAULT;
