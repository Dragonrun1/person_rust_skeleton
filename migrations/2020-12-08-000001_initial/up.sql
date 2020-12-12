# Create tables
# Must be created before people because of foreign key.
CREATE TABLE genders
(
    # Primary key
    id              BINARY(22)  NOT NULL,
    # When the record was originally created. This should never be changed.
    created_at      DATETIME    NOT NULL,
    # Personal sense of one's own gender.
    gender_identity VARCHAR(255) DEFAULT NULL,
    # Biological sex - One of Female, Male, Other, None/Not applicable, Unknown, etc.
    sex             VARCHAR(10) NOT NULL,
    UNIQUE INDEX unq_g_gender (sex, gender_identity),
    PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8mb4
  ENGINE = InnoDB;
# Must be created before people because of foreign key.
CREATE TABLE pronouns
(
    # Primary key
    id         BINARY(22)  NOT NULL,
    # When the record was originally created. This should never be changed.
    created_at DATETIME    NOT NULL,
    # Objective pronoun - One of her, him, them, etc.
    object     VARCHAR(10) NOT NULL,
    # Possessive pronoun - One of hers, his, theirs, etc.
    possessive VARCHAR(10) NOT NULL,
    # Subject pronoun - One of he, she, they, etc.
    subject    VARCHAR(10) NOT NULL,
    # Used to prevent duplicate entries.
    UNIQUE INDEX unq_pr_pronouns (subject, object, possessive),
    PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8mb4
  ENGINE = InnoDB;
CREATE TABLE people
(
    # Primary key
    id               BINARY(22)   NOT NULL,
    # When the record was originally created. This should never be changed.
    created_at       DATETIME     NOT NULL,
    # (Optional) Other (e.g. middle) name.
    additional_name  VARCHAR(255) DEFAULT NULL,
    # (Optional) Person's birthday
    birthday         DATETIME     DEFAULT NULL,
    # Family (often last) name.
    family_name      VARCHAR(100) NOT NULL,
    # (Optional) Foreign key to gender table.
    gender_id        BINARY(22)   DEFAULT NULL,
    # Given (often first) name.
    given_name       VARCHAR(100) NOT NULL,
    # (Optional) Honorific prefix e.g. Mrs., Mr. or Dr.
    honorific_prefix VARCHAR(50)  DEFAULT NULL,
    # (Optional) Honorific suffix e.g. Jr., Ph.D, Esq., III (3rd)
    honorific_suffix VARCHAR(50)  DEFAULT NULL,
    # (Optional) Foreign key to pronoun table.
    pronoun_id       BINARY(22)   DEFAULT NULL,
    # Search helper index.
    INDEX idx_p_family_name (family_name),
    # Search helper index.
    INDEX idx_p_given_name (given_name),
    # Required foreign key index.
    INDEX idx_fk_p_gender (gender_id),
    # Required foreign key index.
    INDEX idx_fk_p_pronoun (pronoun_id),
    PRIMARY KEY (id),
    CONSTRAINT fk_p_gender FOREIGN KEY (gender_id)
        REFERENCES genders (id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT fk_p_pronoun FOREIGN KEY (pronoun_id)
        REFERENCES pronouns (id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
) DEFAULT CHARACTER SET utf8mb4
  ENGINE = InnoDB;
# Add common data.
# Genders
INSERT INTO genders
    (id, created_at, gender_identity, sex)
VALUES
       ('BG2edTSZ9CDZIzQY5Q3Bmi', '2020-12-11 00:00:01', 'female', 'female'),
       ('BuuaJbG8lBFJ1WMiyAM2GS', '2020-12-11 00:00:01', 'male', 'male'),
       ('XNV_rXUFQvqQfvqJLSHP5w', '2020-12-11 00:00:01', NULL, 'female'),
       ('sFJPpw75SSmFiF1wnfbZVg', '2020-12-11 00:00:01', NULL, 'male'),
       ('CWZiDGemBFha7Oy-XEyTUx', '2020-12-11 00:00:01', 'male', 'female'),
       ('Aj_ZFxDQZMTZvy4VS4xPXW', '2020-12-11 00:00:01', 'female', 'male');
# Pronouns
INSERT INTO pronouns (id, created_at, object, possessive, subject)
VALUES ('B01Ij6SSS8OT5S0hoJdPcw', '2020-12-11 00:00:01', 'him', 'his', 'he'),
       ('pjKF25EwT_G2bnof7b5yJQ', '2020-12-11 00:00:01', 'them', 'theirs', 'they'),
       ('twPhMNLuTkG9HcZm59kyow', '2020-12-11 00:00:01', 'her', 'hers', 'she');
