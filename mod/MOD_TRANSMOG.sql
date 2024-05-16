-- MOD_TRANSMOGRIFICATION - Copy existing transmogrification in new table custom_transmogrification
INSERT IGNORE INTO `custom_transmogrification` (`GUID`, `Owner`, `FakeEntry`)
SELECT `guid`, `owner_guid`, `transmog`
FROM `item_instance`
WHERE `transmog` != 0 and `transmog` != `itemEntry`;

-- MOD_TRANSMOGRIFICATION - Remove unused column
ALTER TABLE `item_instance`
DROP COLUMN IF EXISTS `transmog`;

-- MOD_TRANSMOGRIFICATION - Add table custom_unlocked_appearances
CREATE TABLE IF NOT EXISTS `custom_unlocked_appearances` (
    `account_id`       int(10) unsigned      NOT NULL,
    `item_template_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`account_id`, `item_template_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
