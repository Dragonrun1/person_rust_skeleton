-- Drop created_at columns
ALTER TABLE pronouns
    DROP COLUMN created_at;
ALTER TABLE people
    DROP COLUMN created_at;
ALTER TABLE genders
    DROP COLUMN created_at;
