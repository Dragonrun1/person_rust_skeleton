-- Drop the foreign key constraints
ALTER TABLE pronouns
    DROP CONSTRAINT fk_pronouns_updated_by;
ALTER TABLE people
    DROP CONSTRAINT fk_people_updated_by;
ALTER TABLE genders
    DROP CONSTRAINT fk_genders_updated_by;
-- Drop the foreign key indexes
ALTER TABLE pronouns
    DROP INDEX idx_fk_pronouns_updated_by;
ALTER TABLE people
    DROP INDEX idx_fk_people_updated_by;
ALTER TABLE genders
    DROP INDEX idx_fk_genders_updated_by;
-- Drop the columns
ALTER TABLE pronouns
    DROP COLUMN updated_by;
ALTER TABLE people
    DROP COLUMN updated_by;
ALTER TABLE genders
    DROP COLUMN updated_by;
