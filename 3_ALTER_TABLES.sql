-- character_spell_cooldown / pet_spell_cooldown AC commit: bd956b5a5750014bd4168dd82df3438dcc5df43f
ALTER TABLE `character_spell_cooldown` ADD COLUMN `category` MEDIUMINT UNSIGNED DEFAULT 0 NOT NULL AFTER `spell`;
ALTER TABLE `pet_spell_cooldown` ADD COLUMN `category` MEDIUMINT UNSIGNED DEFAULT 0 NOT NULL AFTER `spell`;

ALTER TABLE `character_spell_cooldown` ADD COLUMN `needSend` tinyint(3) unsigned DEFAULT 1 NOT NULL AFTER `time`;

ALTER TABLE `character_spell_cooldown` DROP COLUMN `categoryEnd`;
ALTER TABLE `character_spell_cooldown` DROP COLUMN `categoryId`;
ALTER TABLE `pet_spell_cooldown` DROP COLUMN `categoryEnd`;
ALTER TABLE `pet_spell_cooldown` DROP COLUMN `categoryId`;

-- channels
ALTER TABLE `channels` 
ADD COLUMN `channelId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`channelId`);
ALTER TABLE channels DROP COLUMN `bannedList`;

-- character_talent
TRUNCATE TABLE `character_talent`;
ALTER TABLE `character_talent` CHANGE COLUMN `talentGroup` `specMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`guid`, `spell`);
ALTER TABLE `character_talent` MODIFY `spell` INT UNSIGNED NOT NULL; -- 2023_04_23

-- character_instance
ALTER TABLE `character_instance` CHANGE COLUMN `extendState` `extended` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0' ;

-- character_arena_stats
ALTER TABLE `character_arena_stats` ADD COLUMN `maxMMR` SMALLINT(5) NOT NULL AFTER `matchMakerRating`;

-- corpse
TRUNCATE TABLE `corpse`;
ALTER TABLE `corpse` 
ADD COLUMN `corpseGuid` INT(10) UNSIGNED NOT NULL DEFAULT '0' FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`corpseGuid`, `guid`);
ALTER TABLE corpse DROP PRIMARY KEY;
ALTER TABLE corpse DROP COLUMN `corpseGuid`;
ALTER TABLE corpse ADD PRIMARY KEY (guid);

-- character_aura
ALTER TABLE character_aura DROP COLUMN `critChance`;
ALTER TABLE character_aura DROP COLUMN `applyResilience`;
ALTER TABLE `character_aura` MODIFY `spell` INT UNSIGNED DEFAULT '0'; -- 2023_04_23

-- character_spell
ALTER TABLE character_spell DROP COLUMN `active`;
ALTER TABLE character_spell DROP COLUMN `disabled`;
ALTER TABLE character_spell ADD `specMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT 255;
ALTER TABLE `character_spell` MODIFY `spell` INT UNSIGNED DEFAULT '0' COMMENT 'Spell Identifier'; -- 2023_04_23

-- character_spell_cooldown
ALTER TABLE `character_spell_cooldown` MODIFY `category` INT UNSIGNED DEFAULT '0'; -- 2023_04_23
ALTER TABLE `character_spell_cooldown` MODIFY `spell` INT UNSIGNED DEFAULT '0' COMMENT 'Spell Identifier'; -- 2023_04_23

-- characters
ALTER TABLE `characters` ADD `order` tinyint(4) NULL AFTER grantableLevels;
ALTER TABLE `characters` ADD COLUMN `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `grantableLevels`;
ALTER TABLE `characters` ADD COLUMN extraBonusTalentCount int NOT NULL DEFAULT 0 AFTER `innTriggerId`;
ALTER TABLE `characters` MODIFY `latency` INT UNSIGNED DEFAULT '0'; -- 2023_04_23
ALTER TABLE `characters` MODIFY `transguid` INT DEFAULT '0'; -- 2023_04_23

-- character_pet
ALTER TABLE `character_pet` MODIFY `CreatedBySpell` INT UNSIGNED DEFAULT '0'; -- 2023_04_23

-- pet_aura
ALTER TABLE pet_aura DROP COLUMN `critChance`;
ALTER TABLE pet_aura DROP COLUMN `applyResilience`;
ALTER TABLE `pet_aura` MODIFY `amount0` INT DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pet_aura` MODIFY `amount1` INT DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pet_aura` MODIFY `amount2` INT DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pet_aura` MODIFY `base_amount0` INT DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pet_aura` MODIFY `base_amount1` INT DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pet_aura` MODIFY `base_amount2` INT DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pet_aura` MODIFY `spell` INT UNSIGNED DEFAULT '0'; -- 2023_04_23

-- pet_spell
ALTER TABLE `pet_spell` MODIFY `spell` INT UNSIGNED DEFAULT '0' COMMENT 'Spell Identifier'; -- 2023_04_23

-- pet_spell_cooldown
ALTER TABLE `pet_spell_cooldown` MODIFY `category` INT UNSIGNED DEFAULT '0'; -- 2023_04_23
ALTER TABLE `pet_spell_cooldown` MODIFY `spell` INT UNSIGNED DEFAULT '0' COMMENT 'Spell Identifier'; -- 2023_04_23

-- instance
ALTER TABLE `instance` MODIFY `resettime` int unsigned NOT NULL DEFAULT '0'; --

-- instance_reset
ALTER TABLE `instance_reset` MODIFY `resettime` int unsigned NOT NULL DEFAULT '0'; --

-- item_instance
ALTER TABLE `item_instance` MODIFY `flags` INT UNSIGNED DEFAULT '0'; -- 2023_04_23
ALTER TABLE `item_instance` MODIFY `itemEntry` INT UNSIGNED DEFAULT '0'; -- 2023_04_23

-- pvpstats_players
ALTER TABLE `pvpstats_players` MODIFY `attr_1` INT UNSIGNED DEFAULT '0'; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `attr_2` INT UNSIGNED DEFAULT '0'; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `attr_3` INT UNSIGNED DEFAULT '0'; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `attr_4` INT UNSIGNED DEFAULT '0'; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `attr_5` INT UNSIGNED DEFAULT '0'; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `score_bonus_honor` INT UNSIGNED DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `score_damage_done` INT UNSIGNED DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `score_deaths` INT UNSIGNED DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `score_healing_done` INT UNSIGNED DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `score_honorable_kills` INT UNSIGNED DEFAULT NULL; -- 2023_04_23
ALTER TABLE `pvpstats_players` MODIFY `score_killing_blows` INT UNSIGNED DEFAULT NULL; -- 2023_04_23

-- quest_tracker
ALTER TABLE `quest_tracker` MODIFY `id` INT UNSIGNED DEFAULT '0'; -- 2023_04_23

-- recovery_item
ALTER TABLE `recovery_item` MODIFY `itemEntry` INT UNSIGNED DEFAULT '0'; -- 2023_04_23

-- guild_rank
ALTER TABLE `guild_rank` MODIFY `rights` INT UNSIGNED DEFAULT '0'; -- 2023_04_23

-- character_homebind AC commit: 2e6f6e26da8f01cd67bbb56e0e7aa961ffd5f51f
ALTER TABLE `character_homebind` ADD COLUMN `posO` FLOAT NOT NULL DEFAULT '0' AFTER `posZ`;

-- log_money AC commit: 2fec54c4429a03b406b30bbce29c5b376ad04e31
ALTER TABLE `log_money` ADD COLUMN `type` TINYINT NOT NULL COMMENT '1=COD,2=AH,3=GB DEPOSIT,4=GB WITHDRAW,5=MAIL,6=TRADE' AFTER `date`;

-- log_money
ALTER TABLE `log_money` MODIFY `receiver_name` text COLLATE utf8mb4_unicode_ci NOT NULL; --
ALTER TABLE `log_money` MODIFY `sender_ip` text COLLATE utf8mb4_unicode_ci NOT NULL; --
ALTER TABLE `log_money` MODIFY `sender_name` text COLLATE utf8mb4_unicode_ci NOT NULL; --
ALTER TABLE `log_money` MODIFY `topic` text COLLATE utf8mb4_unicode_ci NOT NULL; --

--
ALTER TABLE auctionhouse DROP COLUMN `Flags`;
