CREATE TABLE `motd` (
  `realmid` INT UNSIGNED NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  PRIMARY KEY (`realmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
