CREATE TABLE genders
(
    id              CHAR(22)    NOT NULL,
    gender_identity VARCHAR(255) DEFAULT NULL,
    sex             VARCHAR(10) NOT NULL,
    created_at      DATETIME    NOT NULL,
    UNIQUE INDEX unq_g_gender (sex, gender_identity),
    PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8mb4
  COLLATE 'utf8mb4_unicode_ci'
  ENGINE = InnoDB;
CREATE TABLE people
(
    id               CHAR(22)     NOT NULL,
    additional_name  VARCHAR(255) DEFAULT NULL,
    birthday         DATETIME     DEFAULT NULL,
    family_name      VARCHAR(100) NOT NULL,
    gender_id        CHAR(22)     DEFAULT NULL,
    given_name       VARCHAR(100) NOT NULL,
    honorific_prefix VARCHAR(50)  DEFAULT NULL,
    honorific_suffix VARCHAR(50)  DEFAULT NULL,
    pronoun_id       CHAR(22)     DEFAULT NULL,
    created_at       DATETIME     NOT NULL,
    INDEX idx_p_family_name (family_name),
    INDEX fk_p_gender (gender_id),
    INDEX fk_p_pronoun (pronoun_id),
    PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8mb4
  COLLATE 'utf8mb4_unicode_ci'
  ENGINE = InnoDB;
CREATE TABLE pronouns
(
    id         CHAR(22)    NOT NULL,
    object     VARCHAR(10) NOT NULL,
    possessive VARCHAR(10) NOT NULL,
    subject    VARCHAR(10) NOT NULL,
    created_at DATETIME    NOT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8mb4
  COLLATE 'utf8mb4_unicode_ci'
  ENGINE = InnoDB;
CREATE UNIQUE INDEX unq_pr_pronouns ON pronouns (subject, object, possessive);
ALTER TABLE people
    ADD CONSTRAINT FK_28166A26708A0E0 FOREIGN KEY (gender_id) REFERENCES genders (id);
ALTER TABLE people
    ADD CONSTRAINT FK_28166A2693BDCD30 FOREIGN KEY (pronoun_id) REFERENCES pronouns (id);
