ALTER TABLE genders
    ADD COLUMN updated_at DATETIME DEFAULT NULL;
ALTER TABLE people
    ADD COLUMN updated_at DATETIME DEFAULT NULL;
ALTER TABLE pronouns
    ADD COLUMN updated_at DATETIME DEFAULT NULL;