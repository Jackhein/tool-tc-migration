CREATE TABLE `motd` (
  `realmid` INT UNSIGNED NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  PRIMARY KEY (`realmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS `motd_localized` (
  `realmid` INT,
  `locale` VARCHAR(4) NOT NULL COLLATE 'utf8mb4_unicode_ci',
  `text` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
  PRIMARY KEY (`realmid`, `locale`)
) CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci ENGINE = InnoDB;

