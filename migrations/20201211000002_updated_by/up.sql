-- Add the columns
ALTER TABLE genders
    ADD COLUMN updated_by BINARY(22) DEFAULT NULL;
ALTER TABLE people
    ADD COLUMN updated_by BINARY(22) DEFAULT NULL;
ALTER TABLE pronouns
    ADD COLUMN updated_by BINARY(22) DEFAULT NULL;
-- Add the foreign key indexes
ALTER TABLE genders
    ADD INDEX idx_fk_genders_updated_by (updated_by);
ALTER TABLE people
    ADD INDEX idx_fk_people_updated_by (updated_by);
ALTER TABLE pronouns
    ADD INDEX idx_fk_pronouns_updated_by (updated_by);
-- Add the foreign key constraints
ALTER TABLE genders
    ADD CONSTRAINT fk_genders_updated_by FOREIGN KEY (updated_by)
        REFERENCES people (id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT;
-- Self referencing table constraint.
-- NOTE: Databases do not allow update_by == id use NULL instead for self updates.
ALTER TABLE people
    ADD CONSTRAINT fk_people_updated_by FOREIGN KEY (updated_by)
        REFERENCES people (id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT;
ALTER TABLE pronouns
    ADD CONSTRAINT fk_pronouns_updated_by FOREIGN KEY (updated_by)
        REFERENCES people (id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT;
