-- MOD_TRANSMOGRIFICATION - Copy existing transmogrification 
INSERT IGNORE INTO `custom_transmogrification` (`GUID`, `Owner`, `FakeEntry`)
SELECT `guid`, `owner_guid`, `transmog`
FROM `item_instance`
WHERE `transmog` != 0 and `transmog` != `itemEntry`;

-- MOD_TRANSMOGRIFICATION - Remove unused column
ALTER TABLE `item_instance`
DROP COLUMN IF EXISTS `transmog`;
