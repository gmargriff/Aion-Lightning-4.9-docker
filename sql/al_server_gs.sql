DROP DATABASE IF EXISTS al_server_gs;
CREATE DATABASE al_server_gs CHARACTER SET utf8 COLLATE utf8_general_ci;

USE al_server_gs;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for abyss_rank
-- ----------------------------
DROP TABLE IF EXISTS `abyss_rank`;
CREATE TABLE `abyss_rank` (
  `player_id` int(11) NOT NULL,
  `daily_ap` int(11) NOT NULL,
  `daily_gp` int(11) NOT NULL,
  `weekly_ap` int(11) NOT NULL,
  `weekly_gp` int(11) NOT NULL,
  `ap` int(11) NOT NULL,
  `gp` int(11) NOT NULL,
  `rank` int(2) NOT NULL DEFAULT '1',
  `top_ranking` int(4) NOT NULL,
  `daily_kill` int(5) NOT NULL,
  `weekly_kill` int(5) NOT NULL,
  `all_kill` int(4) NOT NULL DEFAULT '0',
  `max_rank` int(2) NOT NULL DEFAULT '1',
  `last_kill` int(5) NOT NULL,
  `last_ap` int(11) NOT NULL,
  `last_gp` int(11) NOT NULL,
  `last_update` decimal(20,0) NOT NULL,
  `rank_pos` int(11) NOT NULL DEFAULT '0',
  `old_rank_pos` int(11) NOT NULL DEFAULT '0',
  `rank_ap` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`),
  CONSTRAINT `abyss_rank_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of abyss_rank
-- ----------------------------

-- ----------------------------
-- Table structure for announcements
-- ----------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `announce` text NOT NULL,
  `faction` enum('ALL','ASMODIANS','ELYOS') NOT NULL DEFAULT 'ALL',
  `type` enum('SHOUT','ORANGE','YELLOW','WHITE','SYSTEM') NOT NULL DEFAULT 'SYSTEM',
  `delay` int(4) NOT NULL DEFAULT '1800',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of announcements
-- ----------------------------

-- ----------------------------
-- Table structure for blocks
-- ----------------------------
DROP TABLE IF EXISTS `blocks`;
CREATE TABLE `blocks` (
  `player` int(11) NOT NULL,
  `blocked_player` int(11) NOT NULL,
  `reason` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`player`,`blocked_player`),
  KEY `blocked_player` (`blocked_player`),
  CONSTRAINT `blocks_ibfk_1` FOREIGN KEY (`player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `blocks_ibfk_2` FOREIGN KEY (`blocked_player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blocks
-- ----------------------------

-- ----------------------------
-- Table structure for bookmark
-- ----------------------------
DROP TABLE IF EXISTS `bookmark`;
CREATE TABLE `bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `char_id` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `world_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bookmark
-- ----------------------------

-- ----------------------------
-- Table structure for broker
-- ----------------------------
DROP TABLE IF EXISTS `broker`;
CREATE TABLE `broker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_pointer` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL,
  `item_count` bigint(20) NOT NULL,
  `item_creator` varchar(50) DEFAULT NULL,
  `seller` varchar(50) DEFAULT NULL,
  `price` bigint(20) NOT NULL DEFAULT '0',
  `broker_race` enum('ELYOS','ASMODIAN') NOT NULL,
  `expire_time` timestamp NOT NULL DEFAULT '2010-01-01 02:00:00',
  `settle_time` timestamp NOT NULL DEFAULT '2010-01-01 02:00:00',
  `seller_id` int(11) NOT NULL,
  `is_sold` tinyint(1) NOT NULL,
  `is_settled` tinyint(1) NOT NULL,
  `is_partsale` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `broker_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of broker
-- ----------------------------

-- ----------------------------
-- Table structure for challenge_tasks
-- ----------------------------
DROP TABLE IF EXISTS `challenge_tasks`;
CREATE TABLE `challenge_tasks` (
  `task_id` int(11) NOT NULL,
  `quest_id` int(10) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_type` enum('LEGION','TOWN') NOT NULL,
  `complete_count` int(3) unsigned NOT NULL DEFAULT '0',
  `complete_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`task_id`,`quest_id`,`owner_id`,`owner_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of challenge_tasks
-- ----------------------------

-- ----------------------------
-- Table structure for craft_cooldowns
-- ----------------------------
DROP TABLE IF EXISTS `craft_cooldowns`;
CREATE TABLE `craft_cooldowns` (
  `player_id` int(11) NOT NULL,
  `delay_id` int(11) unsigned NOT NULL,
  `reuse_time` bigint(13) unsigned NOT NULL,
  PRIMARY KEY (`player_id`,`delay_id`),
  CONSTRAINT `craft_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of craft_cooldowns
-- ----------------------------

-- ----------------------------
-- Table structure for friends
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `player` int(11) NOT NULL,
  `friend` int(11) NOT NULL,
  PRIMARY KEY (`player`,`friend`),
  KEY `friend` (`friend`),
  CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friend`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friends
-- ----------------------------

-- ----------------------------
-- Table structure for guides
-- ----------------------------
DROP TABLE IF EXISTS `guides`;
CREATE TABLE `guides` (
  `guide_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  PRIMARY KEY (`guide_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `guides_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=329193 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guides
-- ----------------------------

-- ----------------------------
-- Table structure for guild_quests
-- ----------------------------
DROP TABLE IF EXISTS `guild_quests`;
CREATE TABLE `guild_quests` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(2) NOT NULL DEFAULT '0',
  `recently_taken_quest` int(6) NOT NULL DEFAULT '0',
  `completion_timestamp` timestamp NULL DEFAULT NULL,
  `currently_started_quest` int(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`),
  CONSTRAINT `guild_quests_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guild_quests
-- ----------------------------

-- ----------------------------
-- Table structure for houses
-- ----------------------------
DROP TABLE IF EXISTS `houses`;
CREATE TABLE `houses` (
  `id` int(10) NOT NULL,
  `player_id` int(10) NOT NULL DEFAULT '0',
  `building_id` int(10) NOT NULL,
  `address` int(10) NOT NULL,
  `acquire_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `settings` int(11) NOT NULL DEFAULT '0',
  `status` enum('ACTIVE','SELL_WAIT','INACTIVE','NOSALE') NOT NULL DEFAULT 'ACTIVE',
  `fee_paid` tinyint(1) NOT NULL DEFAULT '1',
  `next_pay` timestamp NULL DEFAULT NULL,
  `sell_started` timestamp NULL DEFAULT NULL,
  `sign_notice` binary(130) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_2` (`address`),
  KEY `address` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of houses
-- ----------------------------

-- ----------------------------
-- Table structure for house_bids
-- ----------------------------
DROP TABLE IF EXISTS `house_bids`;
CREATE TABLE `house_bids` (
  `player_id` int(10) NOT NULL,
  `house_id` int(10) NOT NULL,
  `bid` bigint(20) NOT NULL,
  `bid_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`player_id`,`house_id`,`bid`),
  KEY `house_id_ibfk_1` (`house_id`),
  CONSTRAINT `house_id_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of house_bids
-- ----------------------------

-- ----------------------------
-- Table structure for house_object_cooldowns
-- ----------------------------
DROP TABLE IF EXISTS `house_object_cooldowns`;
CREATE TABLE `house_object_cooldowns` (
  `player_id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `reuse_time` bigint(20) NOT NULL,
  PRIMARY KEY (`player_id`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of house_object_cooldowns
-- ----------------------------

-- ----------------------------
-- Table structure for house_scripts
-- ----------------------------
DROP TABLE IF EXISTS `house_scripts`;
CREATE TABLE `house_scripts` (
  `house_id` int(11) NOT NULL,
  `index` tinyint(4) NOT NULL,
  `script` mediumtext,
  PRIMARY KEY (`house_id`,`index`),
  CONSTRAINT `houses_id_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=16;

-- ----------------------------
-- Records of house_scripts
-- ----------------------------


-- ----------------------------
-- Table structure for ingameshop_log
-- ----------------------------
DROP TABLE IF EXISTS `ingameshop_log`;
CREATE TABLE `ingameshop_log` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_type` enum('BUY','GIFT') NOT NULL,
  `transaction_date` timestamp NULL DEFAULT NULL,
  `payer_name` varchar(50) NOT NULL,
  `payer_account_name` varchar(50) NOT NULL,
  `receiver_name` varchar(50) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` bigint(13) NOT NULL DEFAULT '0',
  `item_price` bigint(13) NOT NULL DEFAULT '0',
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ingameshop_log
-- ----------------------------

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `item_unique_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` bigint(20) NOT NULL DEFAULT '0',
  `item_color` int(11) NOT NULL DEFAULT '0',
  `color_expires` int(11) NOT NULL DEFAULT '0',
  `item_creator` varchar(50) DEFAULT NULL,
  `expire_time` int(11) NOT NULL DEFAULT '0',
  `activation_count` int(11) NOT NULL DEFAULT '0',
  `item_owner` int(11) NOT NULL,
  `is_equiped` tinyint(1) NOT NULL DEFAULT '0',
  `is_soul_bound` tinyint(1) NOT NULL DEFAULT '0',
  `slot` bigint(20) NOT NULL DEFAULT '0',
  `item_location` tinyint(1) DEFAULT '0',
  `enchant` tinyint(1) DEFAULT '0',
  `item_skin` int(11) NOT NULL DEFAULT '0',
  `fusioned_item` int(11) NOT NULL DEFAULT '0',
  `optional_socket` int(1) NOT NULL DEFAULT '0',
  `optional_fusion_socket` int(1) NOT NULL DEFAULT '0',
  `charge` mediumint(9) NOT NULL DEFAULT '0',
  `rnd_bonus` smallint(6) DEFAULT NULL,
  `rnd_count` smallint(6) NOT NULL DEFAULT '0',
  `pack_count` smallint(6) NOT NULL DEFAULT '0',
  `authorize` int(11) NOT NULL DEFAULT '0',
  `is_packed` tinyint(1) NOT NULL DEFAULT '0',
  `is_amplified` tinyint(1) NOT NULL DEFAULT '0',
  `buff_skill` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_unique_id`),
  KEY `item_location` (`item_location`) USING HASH,
  KEY `index3` (`item_owner`,`item_location`,`is_equiped`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of inventory
-- ----------------------------

-- ----------------------------
-- Table structure for item_cooldowns
-- ----------------------------
DROP TABLE IF EXISTS `item_cooldowns`;
CREATE TABLE `item_cooldowns` (
  `player_id` int(11) NOT NULL,
  `delay_id` int(11) NOT NULL,
  `use_delay` int(10) unsigned NOT NULL,
  `reuse_time` bigint(13) NOT NULL,
  PRIMARY KEY (`player_id`,`delay_id`),
  CONSTRAINT `item_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of item_cooldowns
-- ----------------------------

-- ----------------------------
-- Table structure for item_stones
-- ----------------------------
DROP TABLE IF EXISTS `item_stones`;
CREATE TABLE `item_stones` (
  `item_unique_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `slot` int(2) NOT NULL,
  `category` int(2) NOT NULL DEFAULT '0',
  `polishNumber` int(11) NOT NULL DEFAULT '0',
  `polishCharge` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_unique_id`,`slot`,`category`),
  CONSTRAINT `item_stones_ibfk_1` FOREIGN KEY (`item_unique_id`) REFERENCES `inventory` (`item_unique_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of item_stones
-- ----------------------------

-- ----------------------------
-- Table structure for legions
-- ----------------------------
DROP TABLE IF EXISTS `legions`;
CREATE TABLE `legions` (
  `id` int(11) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `level` int(1) NOT NULL DEFAULT '1',
  `contribution_points` bigint(20) NOT NULL DEFAULT '0',
  `deputy_permission` int(11) NOT NULL DEFAULT '7692',
  `centurion_permission` int(11) NOT NULL DEFAULT '7176',
  `legionary_permission` int(11) NOT NULL DEFAULT '6144',
  `volunteer_permission` int(11) NOT NULL DEFAULT '2048',
  `disband_time` int(11) NOT NULL DEFAULT '0',
  `rank_cp` int(11) NOT NULL DEFAULT '0',
  `rank_pos` int(11) NOT NULL DEFAULT '0',
  `old_rank_pos` int(11) NOT NULL DEFAULT '0',
  `world_owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of legions
-- ----------------------------

-- ----------------------------
-- Table structure for legion_announcement_list
-- ----------------------------
DROP TABLE IF EXISTS `legion_announcement_list`;
CREATE TABLE `legion_announcement_list` (
  `legion_id` int(11) NOT NULL,
  `announcement` varchar(256) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `legion_id` (`legion_id`),
  CONSTRAINT `legion_announcement_list_ibfk_1` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of legion_announcement_list
-- ----------------------------

-- ----------------------------
-- Table structure for legion_emblems
-- ----------------------------
DROP TABLE IF EXISTS `legion_emblems`;
CREATE TABLE `legion_emblems` (
  `legion_id` int(11) NOT NULL,
  `emblem_id` int(1) NOT NULL DEFAULT '0',
  `color_r` int(3) NOT NULL DEFAULT '0',
  `color_g` int(3) NOT NULL DEFAULT '0',
  `color_b` int(3) NOT NULL DEFAULT '0',
  `emblem_type` enum('DEFAULT','CUSTOM') NOT NULL DEFAULT 'DEFAULT',
  `emblem_data` longblob,
  PRIMARY KEY (`legion_id`),
  CONSTRAINT `legion_emblems_ibfk_1` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of legion_emblems
-- ----------------------------

-- ----------------------------
-- Table structure for legion_history
-- ----------------------------
DROP TABLE IF EXISTS `legion_history`;
CREATE TABLE `legion_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `legion_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `history_type` enum('CREATE','JOIN','KICK','APPOINTED','EMBLEM_REGISTER','EMBLEM_MODIFIED','ITEM_DEPOSIT','ITEM_WITHDRAW','KINAH_DEPOSIT','KINAH_WITHDRAW','LEVEL_UP') NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `tab_id` smallint(3) NOT NULL DEFAULT '0',
  `description` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `legion_id` (`legion_id`),
  CONSTRAINT `legion_history_ibfk_1` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of legion_history
-- ----------------------------

-- ----------------------------
-- Table structure for legion_members
-- ----------------------------
DROP TABLE IF EXISTS `legion_members`;
CREATE TABLE `legion_members` (
  `legion_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `nickname` varchar(10) NOT NULL DEFAULT '',
  `rank` enum('BRIGADE_GENERAL','CENTURION','LEGIONARY','DEPUTY','VOLUNTEER') NOT NULL DEFAULT 'VOLUNTEER',
  `selfintro` varchar(32) DEFAULT '',
  `challenge_score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`),
  KEY `player_id` (`player_id`),
  KEY `legion_id` (`legion_id`),
  CONSTRAINT `legion_members_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `legion_members_ibfk_2` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of legion_members
-- ----------------------------

-- ----------------------------
-- Table structure for mail
-- ----------------------------
DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail` (
  `mail_unique_id` int(11) NOT NULL,
  `mail_recipient_id` int(11) NOT NULL,
  `sender_name` varchar(26) NOT NULL,
  `mail_title` varchar(26) NOT NULL,
  `mail_message` varchar(1000) NOT NULL,
  `unread` tinyint(4) NOT NULL DEFAULT '1',
  `attached_item_id` int(11) NOT NULL,
  `attached_kinah_count` bigint(20) NOT NULL,
  `express` tinyint(4) NOT NULL DEFAULT '0',
  `recieved_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mail_unique_id`),
  KEY `mail_recipient_id` (`mail_recipient_id`),
  CONSTRAINT `FK_mail` FOREIGN KEY (`mail_recipient_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mail
-- ----------------------------

-- ----------------------------
-- Table structure for old_names
-- ----------------------------
DROP TABLE IF EXISTS `old_names`;
CREATE TABLE `old_names` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `old_name` varchar(50) NOT NULL,
  `new_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of old_names
-- ----------------------------

-- ----------------------------
-- Table structure for petitions
-- ----------------------------
DROP TABLE IF EXISTS `petitions`;
CREATE TABLE `petitions` (
  `id` bigint(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `add_data` varchar(255) DEFAULT NULL,
  `time` bigint(11) NOT NULL DEFAULT '0',
  `status` enum('PENDING','IN_PROGRESS','REPLIED') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of petitions
-- ----------------------------

-- ----------------------------
-- Table structure for players
-- ----------------------------
DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `account_id` int(11) NOT NULL,
  `account_name` varchar(50) NOT NULL,
  `exp` bigint(20) NOT NULL DEFAULT '0',
  `recoverexp` bigint(20) NOT NULL DEFAULT '0',
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` int(11) NOT NULL,
  `world_id` int(11) NOT NULL,
  `world_owner` int(11) NOT NULL DEFAULT '0',
  `gender` enum('MALE','FEMALE') NOT NULL,
  `race` enum('ASMODIANS','ELYOS') NOT NULL,
  `player_class` enum('WARRIOR','GLADIATOR','TEMPLAR','SCOUT','ASSASSIN','RANGER','MAGE','SORCERER','SPIRIT_MASTER','PRIEST','CLERIC','CHANTER','ENGINEER','GUNNER','ARTIST','BARD','RIDER','ALL') NOT NULL,
  `creation_date` timestamp NULL DEFAULT NULL,
  `deletion_date` timestamp NULL DEFAULT NULL,
  `last_online` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `quest_expands` tinyint(1) NOT NULL DEFAULT '0',
  `npc_expands` tinyint(1) NOT NULL DEFAULT '0',
  `advanced_stigma_slot_size` tinyint(1) NOT NULL DEFAULT '0',
  `warehouse_size` tinyint(1) NOT NULL DEFAULT '0',
  `mailbox_letters` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `title_id` int(3) NOT NULL DEFAULT '-1',
  `bonus_title_id` int(3) NOT NULL DEFAULT '-1',
  `dp` int(3) NOT NULL DEFAULT '0',
  `soul_sickness` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reposte_energy` bigint(20) NOT NULL DEFAULT '0',
  `event_exp` bigint(20) NOT NULL DEFAULT '0',
  `bg_points` int(11) NOT NULL DEFAULT '0',
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `note` text,
  `mentor_flag_time` int(11) NOT NULL DEFAULT '0',
  `initial_gamestats` int(11) NOT NULL DEFAULT '0',
  `last_transfer_time` decimal(20,0) NOT NULL DEFAULT '0',
  `fatigue` int(11) NOT NULL DEFAULT '0',
  `fatigueRecover` int(11) NOT NULL DEFAULT '0',
  `fatigueReset` int(11) NOT NULL DEFAULT '0',
  `stamps` int(11) NOT NULL DEFAULT '0',
  `last_stamp` timestamp NULL DEFAULT NULL,
  `rewarded_pass` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of players
-- ----------------------------

-- ----------------------------
-- Table structure for player_appearance
-- ----------------------------
DROP TABLE IF EXISTS `player_appearance`;
CREATE TABLE `player_appearance` (
  `player_id` int(11) NOT NULL,
  `face` int(11) NOT NULL,
  `hair` int(11) NOT NULL,
  `deco` int(11) NOT NULL,
  `tattoo` int(11) NOT NULL,
  `face_contour` int(11) NOT NULL,
  `expression` int(11) NOT NULL,
  `jaw_line` int(11) NOT NULL,
  `skin_rgb` int(11) NOT NULL,
  `hair_rgb` int(11) NOT NULL,
  `lip_rgb` int(11) NOT NULL,
  `eye_rgb` int(11) NOT NULL,
  `face_shape` int(11) NOT NULL,
  `forehead` int(11) NOT NULL,
  `eye_height` int(11) NOT NULL,
  `eye_space` int(11) NOT NULL,
  `eye_width` int(11) NOT NULL,
  `eye_size` int(11) NOT NULL,
  `eye_shape` int(11) NOT NULL,
  `eye_angle` int(11) NOT NULL,
  `brow_height` int(11) NOT NULL,
  `brow_angle` int(11) NOT NULL,
  `brow_shape` int(11) NOT NULL,
  `nose` int(11) NOT NULL,
  `nose_bridge` int(11) NOT NULL,
  `nose_width` int(11) NOT NULL,
  `nose_tip` int(11) NOT NULL,
  `cheek` int(11) NOT NULL,
  `lip_height` int(11) NOT NULL,
  `mouth_size` int(11) NOT NULL,
  `lip_size` int(11) NOT NULL,
  `smile` int(11) NOT NULL,
  `lip_shape` int(11) NOT NULL,
  `jaw_height` int(11) NOT NULL,
  `chin_jut` int(11) NOT NULL,
  `ear_shape` int(11) NOT NULL,
  `head_size` int(11) NOT NULL,
  `neck` int(11) NOT NULL,
  `neck_length` int(11) NOT NULL,
  `shoulders` int(11) NOT NULL,
  `shoulder_size` int(11) NOT NULL,
  `torso` int(11) NOT NULL,
  `chest` int(11) NOT NULL,
  `waist` int(11) NOT NULL,
  `hips` int(11) NOT NULL,
  `arm_thickness` int(11) NOT NULL,
  `arm_length` int(11) NOT NULL,
  `hand_size` int(11) NOT NULL,
  `leg_thickness` int(11) NOT NULL,
  `leg_length` int(11) NOT NULL,
  `foot_size` int(11) NOT NULL,
  `facial_rate` int(11) NOT NULL,
  `voice` int(11) NOT NULL,
  `height` float NOT NULL,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `player_id_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_appearance
-- ----------------------------

-- ----------------------------
-- Table structure for player_bind_point
-- ----------------------------
DROP TABLE IF EXISTS `player_bind_point`;
CREATE TABLE `player_bind_point` (
  `player_id` int(11) NOT NULL,
  `map_id` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` int(3) NOT NULL,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `player_bind_point_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_bind_point
-- ----------------------------

-- ----------------------------
-- Table structure for player_cooldowns
-- ----------------------------
DROP TABLE IF EXISTS `player_cooldowns`;
CREATE TABLE `player_cooldowns` (
  `player_id` int(11) NOT NULL,
  `cooldown_id` int(6) NOT NULL,
  `reuse_delay` bigint(13) NOT NULL,
  PRIMARY KEY (`player_id`,`cooldown_id`),
  CONSTRAINT `player_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_cooldowns
-- ----------------------------

-- ----------------------------
-- Table structure for player_effects
-- ----------------------------
DROP TABLE IF EXISTS `player_effects`;
CREATE TABLE `player_effects` (
  `player_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_lvl` tinyint(4) NOT NULL,
  `current_time` int(11) NOT NULL,
  `end_time` bigint(13) NOT NULL,
  PRIMARY KEY (`player_id`,`skill_id`),
  CONSTRAINT `player_effects_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_effects
-- ----------------------------

-- ----------------------------
-- Table structure for player_emotions
-- ----------------------------
DROP TABLE IF EXISTS `player_emotions`;
CREATE TABLE `player_emotions` (
  `player_id` int(11) NOT NULL,
  `emotion` int(11) NOT NULL,
  `remaining` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`emotion`),
  CONSTRAINT `player_emotions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_emotions
-- ----------------------------

-- ----------------------------
-- Table structure for player_game_stats
-- ----------------------------
DROP TABLE IF EXISTS `player_game_stats`;
CREATE TABLE `player_game_stats` (
  `player_id` int(11) NOT NULL,
  `defense_physic` int(11) NOT NULL DEFAULT '1',
  `block` int(11) NOT NULL DEFAULT '1',
  `parry` int(11) NOT NULL DEFAULT '1',
  `magical_critical` int(11) NOT NULL DEFAULT '1',
  `evasion` int(11) NOT NULL DEFAULT '1',
  `precision` int(11) NOT NULL DEFAULT '1',
  `attack` int(11) NOT NULL DEFAULT '1',
  `magical_precision` int(11) NOT NULL DEFAULT '1',
  `attack_speed` int(11) NOT NULL DEFAULT '1',
  `magical_resist` int(11) NOT NULL DEFAULT '1',
  `magical_attack` int(11) NOT NULL DEFAULT '1',
  `main_hand_magical_attack` int(11) NOT NULL DEFAULT '1',
  `off_hand_magical_attack` int(11) NOT NULL DEFAULT '1',
  `physical_critical` int(11) NOT NULL DEFAULT '1',
  `attack_range` int(11) NOT NULL DEFAULT '1',
  `magical_defense` int(11) NOT NULL DEFAULT '1',
  `agility` int(11) NOT NULL DEFAULT '1',
  `knowledge` int(11) NOT NULL DEFAULT '1',
  `will` int(11) NOT NULL DEFAULT '1',
  `magical_boost` int(11) NOT NULL DEFAULT '1',
  `magical_boost_resist` int(11) NOT NULL DEFAULT '1',
  `physical_critical_resist` int(11) NOT NULL DEFAULT '1',
  `magical_critical_resist` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_id`),
  CONSTRAINT `player_game_stats` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_game_stats
-- ----------------------------

-- ----------------------------
-- Table structure for player_life_stats
-- ----------------------------
DROP TABLE IF EXISTS `player_life_stats`;
CREATE TABLE `player_life_stats` (
  `player_id` int(11) NOT NULL,
  `hp` int(11) NOT NULL DEFAULT '1',
  `mp` int(11) NOT NULL DEFAULT '1',
  `fp` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_id`),
  CONSTRAINT `FK_player_life_stats` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_life_stats
-- ----------------------------

-- ----------------------------
-- Table structure for player_macrosses
-- ----------------------------
DROP TABLE IF EXISTS `player_macrosses`;
CREATE TABLE `player_macrosses` (
  `player_id` int(11) NOT NULL,
  `order` int(3) NOT NULL,
  `macro` text NOT NULL,
  UNIQUE KEY `main` (`player_id`,`order`),
  CONSTRAINT `player_macrosses_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_macrosses
-- ----------------------------

-- ----------------------------
-- Table structure for player_motions
-- ----------------------------
DROP TABLE IF EXISTS `player_motions`;
CREATE TABLE `player_motions` (
  `player_id` int(11) NOT NULL,
  `motion_id` int(3) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`motion_id`) USING BTREE,
  CONSTRAINT `motions_player_id_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_motions
-- ----------------------------

-- ----------------------------
-- Table structure for player_npc_factions
-- ----------------------------
DROP TABLE IF EXISTS `player_npc_factions`;
CREATE TABLE `player_npc_factions` (
  `player_id` int(11) NOT NULL,
  `faction_id` int(2) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `time` int(11) NOT NULL,
  `state` enum('NOTING','START','COMPLETE') NOT NULL DEFAULT 'NOTING',
  `quest_id` int(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`faction_id`),
  CONSTRAINT `player_npc_factions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_npc_factions
-- ----------------------------

-- ----------------------------
-- Table structure for player_passkey
-- ----------------------------
DROP TABLE IF EXISTS `player_passkey`;
CREATE TABLE `player_passkey` (
  `account_id` int(11) NOT NULL,
  `passkey` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`,`passkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_passkey
-- ----------------------------

-- ----------------------------
-- Table structure for player_passports
-- ----------------------------
DROP TABLE IF EXISTS `player_passports`;
CREATE TABLE `player_passports` (
	`account_id`  int(11) NOT NULL ,
	`passport_id`  int(11) NOT NULL ,
	`stamps`  int(11) NOT NULL DEFAULT 0 ,
	`last_stamp`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
	`rewarded`  tinyint(1) NOT NULL DEFAULT 0 ,
	UNIQUE INDEX `account_passport` USING BTREE (`account_id`, `passport_id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_passports
-- ----------------------------

-- ----------------------------
-- Table structure for player_pets
-- ----------------------------
DROP TABLE IF EXISTS `player_pets`;
CREATE TABLE `player_pets` (
  `player_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `decoration` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `hungry_level` tinyint(4) NOT NULL DEFAULT '0',
  `feed_progress` int(11) NOT NULL DEFAULT '0',
  `reuse_time` bigint(20) NOT NULL DEFAULT '0',
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mood_started` bigint(20) NOT NULL DEFAULT '0',
  `counter` int(11) NOT NULL DEFAULT '0',
  `mood_cd_started` bigint(20) NOT NULL DEFAULT '0',
  `gift_cd_started` bigint(20) NOT NULL DEFAULT '0',
  `dopings` varchar(80) CHARACTER SET ascii DEFAULT NULL,
  `despawn_time` timestamp NULL DEFAULT NULL,
  `expire_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`pet_id`),
  CONSTRAINT `FK_player_pets` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_pets
-- ----------------------------

-- ----------------------------
-- Table structure for player_punishments
-- ----------------------------
DROP TABLE IF EXISTS `player_punishments`;
CREATE TABLE `player_punishments` (
  `player_id` int(11) NOT NULL,
  `punishment_type` enum('PRISON','GATHER','CHARBAN') NOT NULL,
  `start_time` int(10) unsigned DEFAULT '0',
  `duration` int(10) unsigned DEFAULT '0',
  `reason` text,
  PRIMARY KEY (`player_id`,`punishment_type`),
  CONSTRAINT `player_punishments_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_punishments
-- ----------------------------

-- ----------------------------
-- Table structure for player_quests
-- ----------------------------
DROP TABLE IF EXISTS `player_quests`;
CREATE TABLE `player_quests` (
  `player_id` int(11) NOT NULL,
  `quest_id` int(10) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT 'NONE',
  `quest_vars` int(10) unsigned NOT NULL DEFAULT '0',
  `complete_count` int(3) unsigned NOT NULL DEFAULT '0',
  `next_repeat_time` timestamp NULL DEFAULT NULL,
  `reward` smallint(3) DEFAULT NULL,
  `complete_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`,`quest_id`),
  CONSTRAINT `player_quests_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_quests
-- ----------------------------

-- ----------------------------
-- Table structure for player_recipes
-- ----------------------------
DROP TABLE IF EXISTS `player_recipes`;
CREATE TABLE `player_recipes` (
  `player_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  PRIMARY KEY (`player_id`,`recipe_id`),
  CONSTRAINT `player_recipes_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_recipes
-- ----------------------------

-- ----------------------------
-- Table structure for player_registered_items
-- ----------------------------
DROP TABLE IF EXISTS `player_registered_items`;
CREATE TABLE `player_registered_items` (
  `player_id` int(10) NOT NULL,
  `item_unique_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `expire_time` int(20) DEFAULT NULL,
  `color` int(11) DEFAULT NULL,
  `color_expires` int(11) NOT NULL DEFAULT '0',
  `owner_use_count` int(10) NOT NULL DEFAULT '0',
  `visitor_use_count` int(10) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `h` smallint(3) DEFAULT NULL,
  `area` enum('NONE','INTERIOR','EXTERIOR','ALL','DECOR') NOT NULL DEFAULT 'NONE',
  `floor` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`item_unique_id`,`item_id`),
  CONSTRAINT `player_regitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_registered_items
-- ----------------------------

-- ----------------------------
-- Table structure for player_settings
-- ----------------------------
DROP TABLE IF EXISTS `player_settings`;
CREATE TABLE `player_settings` (
  `player_id` int(11) NOT NULL,
  `settings_type` tinyint(1) NOT NULL,
  `settings` blob NOT NULL,
  PRIMARY KEY (`player_id`,`settings_type`),
  CONSTRAINT `ps_pl_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_settings
-- ----------------------------

-- ----------------------------
-- Table structure for player_skills
-- ----------------------------
DROP TABLE IF EXISTS `player_skills`;
CREATE TABLE `player_skills` (
  `player_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_level` int(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_id`,`skill_id`),
  CONSTRAINT `player_skills_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_skills
-- ----------------------------

-- ----------------------------
-- Table structure for player_titles
-- ----------------------------
DROP TABLE IF EXISTS `player_titles`;
CREATE TABLE `player_titles` (
  `player_id` int(11) NOT NULL,
  `title_id` int(11) NOT NULL,
  `remaining` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`title_id`),
  CONSTRAINT `player_titles_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_titles
-- ----------------------------

-- ----------------------------
-- Table structure for player_vars
-- ----------------------------
DROP TABLE IF EXISTS `player_vars`;
CREATE TABLE `player_vars` (
  `player_id` int(11) NOT NULL,
  `param` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `time` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`player_id`,`param`),
  CONSTRAINT `player_vars_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_vars
-- ----------------------------

-- ----------------------------
-- Table structure for player_world_bans
-- ----------------------------
DROP TABLE IF EXISTS `player_world_bans`;
CREATE TABLE `player_world_bans` (
  `player` int(11) NOT NULL,
  `by` varchar(255) NOT NULL,
  `duration` bigint(11) NOT NULL,
  `date` bigint(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY (`player`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_world_bans
-- ----------------------------

-- ----------------------------
-- Table structure for portal_cooldowns
-- ----------------------------
DROP TABLE IF EXISTS `portal_cooldowns`;
CREATE TABLE `portal_cooldowns` (
  `player_id` int(11) NOT NULL,
  `world_id` int(11) NOT NULL,
  `reuse_time` bigint(13) NOT NULL,
  `entry_count` int(2) NOT NULL,
  PRIMARY KEY (`player_id`,`world_id`),
  CONSTRAINT `portal_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of portal_cooldowns
-- ----------------------------

-- ----------------------------
-- Table structure for server_variables
-- ----------------------------
DROP TABLE IF EXISTS `server_variables`;
CREATE TABLE `server_variables` (
  `key` varchar(30) NOT NULL,
  `value` varchar(30) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of server_variables
-- ----------------------------
INSERT INTO `server_variables` VALUES ('time', '3341');

-- ----------------------------
-- Table structure for siege_locations
-- ----------------------------
DROP TABLE IF EXISTS `siege_locations`;
CREATE TABLE `siege_locations` (
  `id` int(11) NOT NULL,
  `race` enum('ELYOS','ASMODIANS','BALAUR') NOT NULL,
  `legion_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of siege_locations
-- ----------------------------

-- ----------------------------
-- Table structure for siege_spawns
-- ----------------------------
DROP TABLE IF EXISTS `siege_spawns`;
CREATE TABLE `siege_spawns` (
  `spawn_id` int(10) NOT NULL,
  `siege_id` int(10) NOT NULL,
  `race` enum('ELYOS','ASMODIANS','BALAUR') NOT NULL,
  `protector` int(10) DEFAULT '0',
  `stype` enum('PEACE','GUARD','ARTIFACT','PROTECTOR','MINE','PORTAL','GENERATOR','SPRING','RACEPROTECTOR','UNDERPASS') DEFAULT NULL,
  PRIMARY KEY (`spawn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of siege_spawns
-- ----------------------------

-- ----------------------------
-- Table structure for skill_motions
-- ----------------------------
DROP TABLE IF EXISTS `skill_motions`;
CREATE TABLE `skill_motions` (
  `motion_name` varchar(255) NOT NULL DEFAULT '',
  `skill_id` int(11) NOT NULL,
  `attack_speed` int(11) NOT NULL,
  `weapon_type` varchar(255) NOT NULL,
  `off_weapon_type` varchar(255) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`motion_name`,`skill_id`,`attack_speed`,`weapon_type`,`off_weapon_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of skill_motions
-- ----------------------------

-- ----------------------------
-- Table structure for spawns
-- ----------------------------
DROP TABLE IF EXISTS `spawns`;
CREATE TABLE `spawns` (
  `spawn_id` int(10) NOT NULL AUTO_INCREMENT,
  `npc_id` int(10) NOT NULL,
  `npc_name` varchar(50) NOT NULL DEFAULT '',
  `map_id` int(10) NOT NULL,
  `pool_size` int(5) NOT NULL DEFAULT '1',
  `anchor` varchar(100) DEFAULT NULL,
  `handler` enum('RIFT','STATIC') DEFAULT NULL,
  `spawn_time` enum('ALL','DAY','NIGHT') NOT NULL DEFAULT 'ALL',
  `walker_id` int(10) NOT NULL DEFAULT '0',
  `random_walk` int(10) NOT NULL DEFAULT '0',
  `static_id` int(10) NOT NULL DEFAULT '0',
  `fly` tinyint(1) NOT NULL DEFAULT '0',
  `respawn_time` int(10) NOT NULL DEFAULT '0',
  `last_despawn_time` timestamp NULL DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `author` varchar(50) NOT NULL DEFAULT 'system',
  PRIMARY KEY (`spawn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of spawns
-- ----------------------------

-- ----------------------------
-- Table structure for surveys
-- ----------------------------
DROP TABLE IF EXISTS `surveys`;
CREATE TABLE `surveys` (
  `unique_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` decimal(20,0) NOT NULL DEFAULT '1',
  `html_text` text NOT NULL,
  `html_radio` varchar(100) NOT NULL DEFAULT 'accept',
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `used_time` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`unique_id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `surveys_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of surveys
-- ----------------------------

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(5) NOT NULL,
  `task_type` enum('SHUTDOWN','RESTART') NOT NULL,
  `trigger_type` enum('FIXED_IN_TIME') NOT NULL,
  `trigger_param` text NOT NULL,
  `exec_param` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tasks
-- ----------------------------
INSERT INTO `tasks` VALUES ('1', 'RESTART', 'FIXED_IN_TIME', '04:20:00', '60 5 320');

-- ----------------------------
-- Table structure for towns
-- ----------------------------
DROP TABLE IF EXISTS `towns`;
CREATE TABLE `towns` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  `points` int(10) NOT NULL DEFAULT '0',
  `race` enum('ELYOS','ASMODIANS') NOT NULL,
  `level_up_date` timestamp NOT NULL DEFAULT '1970-01-01 07:00:01',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of towns
-- ----------------------------

-- ----------------------------
-- Table structure for web_reward
-- ----------------------------
DROP TABLE IF EXISTS `web_reward`;
CREATE TABLE `web_reward` (
  `unique` int(11) NOT NULL AUTO_INCREMENT,
  `item_owner` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` decimal(20,0) NOT NULL DEFAULT '1',
  `rewarded` tinyint(1) NOT NULL DEFAULT '0',
  `added` varchar(70) DEFAULT '',
  `received` varchar(70) DEFAULT '',
  PRIMARY KEY (`unique`),
  KEY `item_owner` (`item_owner`),
  CONSTRAINT `web_reward_ibfk_1` FOREIGN KEY (`item_owner`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_reward
-- ----------------------------

-- ----------------------------
-- Table structure for weddings
-- ----------------------------
DROP TABLE IF EXISTS `weddings`;
CREATE TABLE `weddings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player1` int(11) NOT NULL,
  `player2` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `player1` (`player1`),
  KEY `player2` (`player2`),
  CONSTRAINT `weddings_ibfk_1` FOREIGN KEY (`player1`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `weddings_ibfk_2` FOREIGN KEY (`player2`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weddings
-- ----------------------------

-- ----------------------------
-- View structure for pet_feed_data
-- ----------------------------
DROP VIEW IF EXISTS `pet_feed_data`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `pet_feed_data` AS select `player_pets`.`player_id` AS `player_id`,`player_pets`.`pet_id` AS `pet_id`,`player_pets`.`name` AS `name`,`player_pets`.`hungry_level` AS `hungry_level`,(`player_pets`.`feed_progress` >> 24) AS `regular_count`,(((`player_pets`.`feed_progress` & 0xfffc00) >> 10) * 4) AS `feed_points`,((`player_pets`.`feed_progress` & 0x03f0) >> 4) AS `loved_count` from `player_pets` where (`player_pets`.`feed_progress` <> 0) ;
CREATE TABLE IF NOT EXISTS `event_items` (
  `player_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `counts` INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY (`player_id`, `item_id`),
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;ALTER TABLE `friends`
ADD COLUMN `note`  varchar(255) NULL AFTER `friend`;/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 50616
Source Host           : localhost:3306
Source Database       : al_server_gs

Target Server Type    : MYSQL
Target Server Version : 50616
File Encoding         : 65001

Date: 2014-12-19 23:16:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(5) NOT NULL,
  `task_type` enum('SHUTDOWN','RESTART') NOT NULL,
  `trigger_type` enum('FIXED_IN_TIME') NOT NULL,
  `trigger_param` text NOT NULL,
  `exec_param` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tasks
-- ----------------------------
INSERT INTO `tasks` VALUES ('1', 'RESTART', 'FIXED_IN_TIME', '04:20:00', '60 5 320');
-- ----------------------------
-- Table structure for `ingameshop`
-- ----------------------------
DROP TABLE IF EXISTS `ingameshop`;
CREATE TABLE IF NOT EXISTS `ingameshop` (
  `object_id` int(11) NOT NULL auto_increment,
  `item_id` int(11) NOT NULL,
  `item_count` bigint(13) NOT NULL DEFAULT '0',
  `item_price` bigint(13) NOT NULL DEFAULT '0',
  `category` tinyint(1) NOT NULL DEFAULT '0',
  `sub_category` tinyint(1) NOT NULL DEFAULT '0',
  `list` int(11) NOT NULL DEFAULT '0',
  `sales_ranking` int(11) NOT NULL DEFAULT '0',
  `item_type` tinyint(1) NOT NULL DEFAULT '0',
  `gift` tinyint(1) NOT NULL DEFAULT '0',
  `title_description` varchar(120) NOT NULL,
  `description` varchar(60) NOT NULL,
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- RIDES
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(190100038, 1, 150, 0, 10, 0, 0, 0, 1, "Surfeur eclat-de-sable 1jour", "Surfeur eclat-de-sable 1jour"), 	
(190100039, 1, 750, 0, 10, 0, 0, 0, 1, "Surfeur eclat-de-sable 7jours", "Surfeur eclat-de-sable 7jours"),        		
(190100040, 1, 1500, 0, 10, 0, 0, 0, 1, "Surfeur eclat-de-sable 15jours", "Surfeur eclat-de-sable 15jours"),     		
(190100041, 1, 2500, 0, 10, 0, 0, 0, 1, "Surfeur eclat-de-sable 30jours", "Surfeur eclat-de-sable 30jours"),      		
(190100016, 1, 2600, 0, 10, 0, 0, 0, 1, "surfeur de vague 30jours", "Surfeur de vague 30jours"),   				 		
(190100017, 1, 2600, 0, 10, 0, 0, 0, 1, "jupi agile 30jours", "jupi agile 30jours"),                             		
(190100018, 1, 2600, 0, 10, 0, 0, 0, 1, "vitesse du cirrus 30jours", "vitesse du cirrus 30jours"),               		
(190100045, 1, 2800, 0, 10, 0, 0, 0, 1, "cumulus 30jours", "cumulus 30jours"),   							     		
(190100054, 1, 1800, 0, 10, 0, 0, 0, 1, "Pagati aero 15jours", "pagati aero 15jours"),                           		
(190100055, 1, 2800, 0, 10, 0, 0, 0, 1, "Pagati aero 30jours", "Pagati aero 30jours"),                           		
(190100050, 1, 2550, 0, 10, 0, 0, 0, 1, "grande crete cito 30jours", "grande crete cito 30jours"),               		
(190100033, 1, 165, 0, 10, 0, 0, 0, 1, "cuir de fer Pagati 1jour", "cuir de fer Pagati 1jour"),                  		
(190100034, 1, 800, 0, 10, 0, 0, 0, 1, "cuir de fer Pagati 7jours", "cuir de fer Pagati 7jours"),                		
(190100035, 1, 1600, 0, 10, 0, 0, 0, 1, "cuir de fer Pagati 15jours", "cuir de fer Pagati 15jours"),             		
(190100036, 1, 2600, 0, 10, 0, 0, 0, 1, "cuir de fer Pagati 30jours", "cuir de fer Pagati 30jours"),    			 	
(190100024, 1, 175, 0, 10, 0, 0, 0, 1, "cyclon pria 1jour", "cyclon pria 1jour"),        						 		
(190100025, 1, 850, 0, 10, 0, 0, 0, 1, "cyclon pria 7jours", "cyclon pria 7jours"),  						     		
(190100026, 1, 1650, 0, 10, 0, 0, 0, 1, "cyclon pria 15jours", "cyclon pria 15jours"),                           		
(190100027, 1, 2600, 0, 10, 0, 0, 0, 1, "cyclon pria 30jours", "cyclon pria 30jours"),                           		
(190100019, 1, 195, 0, 10, 0, 0, 0, 1, "cyclon optima 1jours", "cyclon optima 1jours"), 				         		
(190100020, 1, 900, 0, 10, 0, 0, 0, 1, "cyclon optima 7jours", "cyclon optima 7jours"),                          		
(190100022, 1, 2750, 0, 10, 0, 0, 0, 1, "cyclon optima 30jours", "cyclon optima 30jours"),                      		
(190100028, 1, 185, 0, 10, 0, 0, 0, 1, "chevaucheur pagati 1jour", "chevaucheur pagati 1jour"),                  		
(190100029, 1, 850, 0, 10, 0, 0, 0, 1, "chevaucheur pagati 7jours", "chevaucheur pagati 7jours"),                		
(190100030, 1, 1700, 0, 10, 0, 0, 0, 1, "chevaucheur pagati 15jours", "chevaucheur pagati 15jours"),             		
(190100031, 1, 2700, 0, 10, 0, 0, 0, 1, "chevaucheur pagati 30jours", "chevaucheur pagati 30jours"),
(190100066, 1, 205, 0, 10, 0, 0, 0, 1, "dent-tranchante de runes d ether 1jour", "dent-tranchante de runes d ether 1jour"),
(190100067, 1, 1050, 0, 10, 0, 0, 0, 1, "dent-tranchante de runes d ether 7jours", "dent-tranchante de runes d ether 7jours"),
(190100068, 1, 2100, 0, 10, 0, 0, 0, 1, "dent-tranchante de runes d ether 15jours", "dent-tranchante de runes d ether 15jours"),
(190100069, 1, 3100, 0, 10, 0, 0, 0, 1, "dent-tranchante de runes d ether 30jours", "dent-tranchante de runes d ether 30jours"),
(190100038, 1, 150, 1, 10, 0, 0, 0, 1, "Surfeur eclat-de-sable 1jour", "Surfeur eclat-de-sable 1jour"), 	            
(190100039, 1, 750, 1, 10, 0, 0, 0, 1, "Surfeur eclat-de-sable 7jours", "Surfeur eclat-de-sable 7jours"),        		
(190100040, 1, 1500, 1, 10, 0, 0, 0, 1, "Surfeur eclat-de-sable 15jours", "Surfeur eclat-de-sable 15jours"),     		
(190100041, 1, 2500, 1, 10, 0, 0, 0, 1, "Surfeur eclat-de-sable 30jours", "Surfeur eclat-de-sable 30jours"),      		
(190100016, 1, 2600, 1, 10, 0, 0, 0, 1, "surfeur de vague 30jours", "Surfeur de vague 30jours"),   				 		
(190100017, 1, 2600, 1, 10, 0, 0, 0, 1, "jupi agile 30jours", "jupi agile 30jours"),                             		
(190100018, 1, 2600, 1, 10, 0, 0, 0, 1, "vitesse du cirrus 30jours", "vitesse du cirrus 30jours"),               		
(190100045, 1, 2800, 1, 10, 0, 0, 0, 1, "cumulus 30jours", "cumulus 30jours"),   							     		
(190100054, 1, 1800, 1, 10, 0, 0, 0, 1, "Pagati aero 15jours", "pagati aero 15jours"),                           		
(190100055, 1, 2800, 1, 10, 0, 0, 0, 1, "Pagati aero 30jours", "Pagati aero 30jours"),                           		
(190100050, 1, 2550, 1, 10, 0, 0, 0, 1, "grande crete cito 30jours", "grande crete cito 30jours"),               		
(190100033, 1, 165, 1, 10, 0, 0, 0, 1, "cuir de fer Pagati 1jour", "cuir de fer Pagati 1jour"),                  		
(190100034, 1, 800, 1, 10, 0, 0, 0, 1, "cuir de fer Pagati 7jours", "cuir de fer Pagati 7jours"),                		
(190100035, 1, 1600, 1, 10, 0, 0, 0, 1, "cuir de fer Pagati 15jours", "cuir de fer Pagati 15jours"),             		
(190100036, 1, 2600, 1, 10, 0, 0, 0, 1, "cuir de fer Pagati 30jours", "cuir de fer Pagati 30jours"),    			 	
(190100024, 1, 175, 1, 10, 0, 0, 0, 1, "cyclon pria 1jour", "cyclon pria 1jour"),        						 		
(190100025, 1, 850, 1, 10, 0, 0, 0, 1, "cyclon pria 7jours", "cyclon pria 7jours"),  						     		
(190100026, 1, 1650, 1, 10, 0, 0, 0, 1, "cyclon pria 15jours", "cyclon pria 15jours"),                           		
(190100027, 1, 2600, 1, 10, 0, 0, 0, 1, "cyclon pria 30jours", "cyclon pria 30jours"),                           		
(190100019, 1, 195, 1, 10, 0, 0, 0, 1, "cyclon optima 1jours", "cyclon optima 1jours"), 				         		
(190100020, 1, 900, 1, 10, 0, 0, 0, 1, "cyclon optima 7jours", "cyclon optima 7jours"),                          		
(190100022, 1, 2750, 1, 10, 0, 0, 0, 1, "cyclon optima 30jours", "cyclon optima 30jours"),                      		
(190100028, 1, 185, 1, 10, 0, 0, 0, 1, "chevaucheur pagati 1jour", "chevaucheur pagati 1jour"),                  		
(190100029, 1, 850, 1, 10, 0, 0, 0, 1, "chevaucheur pagati 7jours", "chevaucheur pagati 7jours"),                		
(190100030, 1, 1700, 1, 10, 0, 0, 0, 1, "chevaucheur pagati 15jours", "chevaucheur pagati 15jours"),             	
(190100031, 1, 2700, 1, 10, 0, 0, 0, 1, "chevaucheur pagati 30jours", "chevaucheur pagati 30jours"),
(190100066, 1, 205, 1, 10, 0, 0, 0, 1, "dent-tranchante de runes d ether 1jour", "dent-tranchante de runes d ether 1jour"),
(190100067, 1, 1050, 1, 10, 0, 0, 0, 1, "dent-tranchante de runes d ether 7jours", "dent-tranchante de runes d ether 7jours");
-- WINGS
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(187000038, 1, 3000, 0, 12, 0, 0, 0, 1, "Ailes de la chance", "Ailes de la chance"),
(187000038, 1, 3000, 1, 12, 0, 0, 0, 1, "Ailes de la chance", "Ailes de la chance"),
(187060009, 1, 750, 0, 12, 0, 0, 0, 1, "Aile de javirunerk du nuage noir", "Aile de javirunerk du nuage noir"),
(187060009, 1, 750, 1, 12, 0, 0, 0, 1, "Aile de javirunerk du nuage noir", "Aile de javirunerk du nuage noir"),
(187060008, 1, 1000, 0, 12, 0, 0, 0, 1, "Ailes de Lolarinerk du Nuage Noir", "Ailes de Lolarinerk du Nuage Noir"),
(187060008, 1, 1000, 1, 12, 0, 0, 0, 1, "Ailes de Lolarinerk du Nuage Noir", "Ailes de Lolarinerk du Nuage Noir"),
(187060001, 1, 750, 0, 12, 0, 0, 0, 1, "Ailes du Nuage Noir S301", "Ailes du Nuage Noir S301"),
(187060001, 1, 750, 1, 12, 0, 0, 0, 1, "Ailes du Nuage Noir S301", "Ailes du Nuage Noir S301"),
(187060000, 1, 1000, 0, 12, 0, 0, 0, 1, "Ailes du Nuage Noir S401", "Ailes du Nuage Noir S401"),
(187060000, 1, 1000, 1, 12, 0, 0, 0, 1, "Ailes du Nuage Noir S401", "Ailes du Nuage Noir S401");
-- EXPRESS
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(188050982, 1, 50, 0, 20, 0, 0, 0, 1, "Paquet de 5 biscuits a la poudre dEther", "express"),
(188050983, 1, 100, 0, 20, 0, 0, 0, 1, "Paquet de 10 biscuits a la poudre dEther", "express"),
(188050984, 1, 50, 0, 20, 0, 0, 0, 1, "Paquet de 5 biscuits aux cristaux dEther", "express"),
(188050985, 1, 100, 0, 20, 0, 0, 0, 1, "Paquet de 10 biscuits aux cristaux dEther", "express"),
(188050982, 1, 50, 1, 20, 0, 0, 0, 1, "Paquet de 5 biscuits a la poudre dEther", "express"),
(188050983, 1, 100, 1, 20, 0, 0, 0, 1, "Paquet de 10 biscuits a la poudre dEther", "express"),
(188050984, 1, 50, 1, 20, 0, 0, 0, 1, "Paquet de 5 biscuits aux cristaux dEther", "express"),
(188050985, 1, 100, 1, 20, 0, 0, 0, 1, "Paquet de 10 biscuits aux cristaux dEther", "express" );
-- FOOD
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(160010071, 1, 50, 0, 5, 0, 0, 0, 1, "Kerub E", "Kerub E"),
(160010069, 1, 50, 0, 5, 0, 0, 0, 1, "Tigre E", "Tigre E"),
(160010013, 1, 75, 0, 5, 0, 0, 0, 1, "Tigre Calin E", "Tigre Calin E"),
(160010111, 1, 100, 0, 5, 0, 0, 0, 1, "Moine Sauteur E", "Moine Sauteur E"),
(160003531, 1, 50, 0, 5, 0, 0, 0, 1, "Marin BE1", "Marin BE1"),
(160003532, 1, 50, 0, 5, 0, 0, 0, 1, "Marin BE2", "Marin BE2"),
(160010059, 1, 50, 0, 5, 0, 0, 0, 1, "Marin E1", "Marin E1"),
(160010101, 1, 75, 0, 5, 0, 0, 0, 1, "Inquin E", "Inquin E"),
(160010091, 1, 75, 0, 5, 0, 0, 0, 1, "Inquin E1", "Inquin E1"),
(160010105, 1, 100, 0, 5, 0, 0, 0, 1, "Ours E", "Ours E"),
(160010103, 1, 100, 1, 5, 0, 0, 0, 1, "Shugo E", "Shugo E"),
(160010074, 1, 2000, 0, 5, 0, 0, 0, 1, "Friandise Forme de General de divinite protectrice Elyseen", "Friandise Forme de General de divinite protectrice Elyseen"),
(164002000, 1, 50, 0, 5, 0, 0, 0, 1,  "Vous transforme en Granker au nez rouge pendant 9 minutes", "Vous transforme en Granker au nez rouge pendant 9 minutes"),
(160010072, 1, 50, 1, 5, 0, 0, 0, 1, "Kerub A", "Kerub A"),
(160010070, 1, 50, 1, 5, 0, 0, 0, 1, "Tigre A", "Tigre A"),
(160010014, 1, 75, 1, 5, 0, 0, 0, 1, "Tigre Calin A", "Tigre Calin A"),
(160010112, 1, 100, 1, 5, 0, 0, 0, 1, "Moine Sauteur A", "Moine Sauteur A"),
(160003531, 1, 50, 1, 5, 0, 0, 0, 1, "Marin BE1", "Marin BE1"),
(160003532, 1, 50, 1, 5, 0, 0, 0, 1, "Marin BE2", "Marin BE2"),
(160010060, 1, 50, 1, 5, 0, 0, 0, 1, "Marin A1", "Marin A1"),
(160010102, 1, 75, 1, 5, 0, 0, 0, 1, "Inquin A", "Inquin A"),
(160010092, 1, 75, 1, 5, 0, 0, 0, 1, "Inquin A1", "Inquin A1"),
(160010106, 1, 100, 1, 5, 0, 0, 0, 1, "Ours A", "Ours A"),
(160010104, 1, 100, 1, 5, 0, 0, 0, 1, "Shugo A", "Shugo A"),
(160010075, 1, 2000, 1, 5, 0, 0, 0, 1, "Friandise Forme de General de divinite protectrice Asmodien", "Friandise Forme de General de divinite protectrice Asmodien"),
(164002000, 1, 50, 1, 5, 0, 0, 0, 1,  "Vous transforme en Granker au nez rouge pendant 9 minutes", "Vous transforme en Granker au nez rouge pendant 9 minutes");
-- SKIN PNJ
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(101700020, 1, 500, 0, 24, 0, 0, 0, 1, "Arc de l ame monstrueuse", "Arc de l ame monstrueuse"),
(100000020, 1, 500, 0, 24, 0, 0, 0, 1, "Masse de l ame monstrueuse", "Masse de l ame monstrueuse"),
(101300007, 1, 500, 0, 24, 0, 0, 0, 1, "Lance de l ame monstrueuse", "Lance de l ame monstrueuse"),
(100900011, 1, 500, 0, 24, 0, 0, 0, 1, "Espadon de l ame monstrueuse", "Espadon de l ame monstrueuse"),
(100500007, 1, 500, 0, 24, 0, 0, 0, 1, "Orbe de l ame monstrueuse", "Orbe de l ame monstrueuse"),
(100200086, 1, 500, 0, 24, 0, 0, 0, 1, "Dague de l ame monstrueuse", "Dague de l ame monstrueuse"),
(101500008, 1, 500, 0, 24, 0, 0, 0, 1, "Baton de l ame monstrueuse", "Baton de l ame monstrueuse"),
(101700022, 1, 500, 0, 24, 0, 0, 0, 1, "Arc asmodien de la phase de chargement 01", "Arc asmodien de la phase de chargement 01"),
(101700027, 1, 500, 0, 24, 0, 0, 0, 1, "Arc BW C005 de pnj", "Arc BW C005 de pnj"),
(101700029, 1, 500, 0, 24, 0, 0, 0, 1, "Arc BW C107 de pnj", "Arc BW C107 de pnj"),
(101700041, 1, 500, 0, 24, 0, 0, 0, 1, "Arc BW R012 de pnj", "Arc BW R012 de pnj"),
(101500022, 1, 500, 0, 24, 0, 0, 0, 1, "Baton ST C006 de pnj", "Baton ST C006 de pnj"),
(101500024, 1, 500, 0, 24, 0, 0, 0, 1, "Baton ST C008 de pnj", "Baton ST C008 de pnj"),
(101500033, 1, 500, 0, 24, 0, 0, 0, 1, "Baton ST R009 de pnj", "Baton ST R009 de pnj"),
(100900279, 1, 500, 0, 24, 0, 0, 0, 1, "Rateau de fermier01", "Rateau de fermier01"),
(100900280, 1, 500, 0, 24, 0, 0, 0, 1, "Pelle01", "Pelle01"),
(101300015, 1, 500, 0, 24, 0, 0, 0, 1, "Guisarme PA C006 de pnj", "Guisarme PA C006 de pnj"),
(100500011, 1, 500, 0, 24, 0, 0, 0, 1, "Orbe 01 pour asmodien debutant", "Orbe 01 pour asmodien debutant"),
(100600008, 1, 500, 0, 24, 0, 0, 0, 1, "Grimoire de l ame monstrueuse", "Grimoire de l ame monstrueuse"),
(100600030, 1, 500, 0, 24, 0, 0, 0, 1, "Livre de sorts BO_R011 de pnj", "Livre de sorts BO_R011 de pnj"),
(100000713, 1, 500, 0, 24, 0, 0, 0, 1, "Masse de l ame monstrueuse02", "Masse de l ame monstrueuse02"),
(100000800, 1, 500, 0, 24, 0, 0, 0, 1, "Masse de l ame monstrueuse03", "Masse de l ame monstrueuse03"),
(100000034, 1, 500, 0, 24, 0, 0, 0, 1, "Epee 01 pour elyseen Debutant", "Epee 01 pour elyseen Debutant"),
(100000033, 1, 500, 0, 24, 0, 0, 0, 1, "Hache a double tranchant", "Hache a double tranchant"),
(100000035, 1, 500, 0, 24, 0, 0, 0, 1, "Epee 01 pour asmodien debutant", "Epee 01 pour asmodien debutant"),
(100900035, 1, 500, 0, 24, 0, 0, 0, 1, "Espadon TS R012 de pnj", "Espadon TS R012 de pnj"),
(100900036, 1, 500, 0, 24, 0, 0, 0, 1, "Espadon TS R013 de pnj", "Espadon TS R013 de pnj"),
(100900037, 1, 500, 0, 24, 0, 0, 0, 1, "Espadon TS U001 de pnj", "Espadon TS U001 de pnj"),
(101300018, 1, 500, 0, 24, 0, 0, 0, 1, "Guisarme PA R002 de pnj", "Guisarme PA R002 de pnj"),
(101300023, 1, 500, 0, 24, 0, 0, 0, 1, "Guisarme Pa R007 de pnj", "Guisarme Pa R007 de pnj"),
(101700877, 1, 750, 0, 24, 0, 0, 0, 1, "Arc long legendaire de tahabata 1h", "Arc long legendaire de tahabata 1h"),
(101500861, 1, 750, 0, 24, 0, 0, 0, 1, "Baton legendaire de tahabata 1h", "Baton legendaire de tahabata 1h"),
(100200968, 1, 750, 0, 24, 0, 0, 0, 1, "Dague legendaire de tahabata 1h", "Dague legendaire de tahabata 1h"),
(100001098, 1, 750, 0, 24, 0, 0, 0, 1, "Epee legendaire de tahabata 1h", "Epee legendaire de tahabata 1h"),
(100900834, 1, 750, 0, 24, 0, 0, 0, 1, "Espadon legendaire de tahabata 1h", "Espadon legendaire de tahabata 1h"),
(100600909, 1, 750, 0, 24, 0, 0, 0, 1, "Grimoire legendaire de tahabata 1h", "Grimoire legendaire de tahabata 1h"),
(100500853, 1, 750, 0, 24, 0, 0, 0, 1, "Joyau legendaire de tahabata 1h", "Joyau legendaire de tahabata 1h"),
(101300802, 1, 750, 0, 24, 0, 0, 0, 1, "Lance legendaire de tahabata 1h", "Lance legendaire de tahabata 1h"),
(100100839, 1, 750, 0, 24, 0, 0, 0, 1, "Marteau de guerre legendaire de tahabata 1h", "Marteau de guerre legendaire de tahabata 1h"),
(100600920, 1, 500, 0, 24, 0, 0, 0, 1, "Rosetta Tablet", "Rosetta Tablet"),
(100100673, 1, 500, 0, 24, 0, 0, 0, 1, "Sartuan Snack", "Sartuan Snack"),
(100500695, 1, 500, 0, 24, 0, 0, 0, 1, "Cadran de Siel", "Cadran de Siel"),
(100900850, 1, 500, 0, 24, 0, 0, 0, 1, "Arbre de Solorius", "Arbre de Solorius"),
(100500867, 1, 500, 0, 24, 0, 0, 0, 1, "Guilande de solorius", "Guilande de solorius"),
(100600923, 1, 500, 0, 24, 0, 0, 0, 1, "Carte Surprise de solorius", "Carte Surprise de solorius"),
(100001114, 1, 500, 0, 24, 0, 0, 0, 1, "Sucre dorge en forme de canne", "Sucre dorge en forme de canne"),
(100000389, 1, 500, 0, 24, 0, 0, 0, 1, "Aroseur deau01", "Aroseur deau01"),
(100000381, 1, 500, 0, 24, 0, 0, 0, 1, "Hache de bucheron", "Hache de bucheron"),
(101500876, 1, 500, 0, 24, 0, 0, 0, 1, "Baton de yule", "Baton de yule"),
(100100852, 1, 500, 0, 24, 0, 0, 0, 1, "Cloche en argent", "Cloche en argent"),
(100200981, 1, 500, 0, 24, 0, 0, 0, 1, "Glacon de neige", "Glacon de neige"),
(101700036, 1, 500, 0, 24, 0, 0, 0, 1, "Arc BW R007 de pnj", "Arc BW R007 de pnj"),
(101700726, 1, 500, 0, 24, 0, 0, 0, 1, "Arc 01 de pnj de la tribu rean", "Arc 01 de pnj de la tribu rean"),
(100000015, 1, 500, 0, 24, 0, 0, 0, 1, "Epee de l ame monstrueuse asmodien", "Epee de l ame monstrueuse asmodien"),
(100000894, 1, 500, 0, 24, 0, 0, 0, 1, "Epee de pnj Fanatic", "Epee de pnj Fanatic"),
(100000879, 1, 500, 0, 24, 0, 0, 0, 1, "Sabre ethere", "Sabre ethere"),
(100900395, 1, 500, 0, 24, 0, 0, 0, 1, "Espadon du general divin celeste", "Espadon du general divin celeste"),
(101700416, 1, 500, 0, 24, 0, 0, 0, 1, "Arc long du general divin celeste", "Arc long du general divin celeste"),
(101300387, 1, 500, 0, 24, 0, 0, 0, 1, "Lance du general divin celeste", "Lance du general divin celeste"),
(101500403, 1, 500, 0, 24, 0, 0, 0, 1, "Baton du general divin celeste", "Baton du general divin celeste"),
(100000529, 1, 500, 0, 24, 0, 0, 0, 1, "Epee du general divin celeste", "Epee du general divin celeste"),
(100100405, 1, 500, 0, 24, 0, 0, 0, 1, "Marteau de guerre du general divin celeste", "Marteau de guerre du general divin celeste"),
(100900396, 1, 500, 0, 24, 0, 0, 0, 1, "Espadon de general demon", "Espadon de general demon"),
(101700417, 1, 500, 0, 24, 0, 0, 0, 1, "Arc long de general demon", "Arc long de general demon"),
(101300388, 1, 500, 0, 24, 0, 0, 0, 1, "Lance de general demon", "Lance de general demon"),
(101500404, 1, 500, 0, 24, 0, 0, 0, 1, "Baton de general demon", "Baton de general demon"),
(100000530, 1, 500, 0, 24, 0, 0, 0, 1, "Epee de general demon", "Epee de general demon"),
(100100406, 1, 500, 0, 24, 0, 0, 0, 1, "Marteau de guerre de general demon", "Marteau de guerre de general demon"),
(100900847, 1, 500, 0, 24, 0, 0, 0, 1, "Machoires du cataclysme", "Machoires du cataclysme"),
(100600433, 1, 500, 0, 24, 0, 0, 0, 1, "Ouvrage de general demon", "Ouvrage de general demon"),
(101500695, 1, 500, 0, 24, 0, 0, 0, 1, "Force d israphel", "Force d israphel"),
(101300652, 1, 500, 0, 24, 0, 0, 0, 1, "Candelabre de luxe", "Candelabre de luxe"),
(100200979, 1, 500, 0, 24, 0, 0, 0, 1, "Gaterie de mellin", "Gaterie de mellin"),
(101700020, 1, 500, 1, 24, 0, 0, 0, 1, "Arc de l ame monstrueuse", "Arc de l ame monstrueuse"),
(100000020, 1, 500, 1, 24, 0, 0, 0, 1, "Masse de l ame monstrueuse", "Masse de l ame monstrueuse"),
(101300007, 1, 500, 1, 24, 0, 0, 0, 1, "Lance de l ame monstrueuse", "Lance de l ame monstrueuse"),
(100900011, 1, 500, 1, 24, 0, 0, 0, 1, "Espadon de l ame monstrueuse", "Espadon de l ame monstrueuse"),
(100500007, 1, 500, 1, 24, 0, 0, 0, 1, "Orbe de l ame monstrueuse", "Orbe de l ame monstrueuse"),
(100200086, 1, 500, 1, 24, 0, 0, 0, 1, "Dague de l ame monstrueuse", "Dague de l ame monstrueuse"),
(101500008, 1, 500, 1, 24, 0, 0, 0, 1, "Baton de l ame monstrueuse", "Baton de l ame monstrueuse"),
(101700022, 1, 500, 1, 24, 0, 0, 0, 1, "Arc asmodien de la phase de chargement 01", "Arc asmodien de la phase de chargement 01"),
(101700027, 1, 500, 1, 24, 0, 0, 0, 1, "Arc BW C005 de pnj", "Arc BW C005 de pnj"),
(101700029, 1, 500, 1, 24, 0, 0, 0, 1, "Arc BW C107 de pnj", "Arc BW C107 de pnj"),
(101700041, 1, 500, 1, 24, 0, 0, 0, 1, "Arc BW R012 de pnj", "Arc BW R012 de pnj"),
(101500022, 1, 500, 1, 24, 0, 0, 0, 1, "Baton ST C006 de pnj", "Baton ST C006 de pnj"),
(101500024, 1, 500, 1, 24, 0, 0, 0, 1, "Baton ST C008 de pnj", "Baton ST C008 de pnj"),
(101500033, 1, 500, 1, 24, 0, 0, 0, 1, "Baton ST R009 de pnj", "Baton ST R009 de pnj"),
(100900279, 1, 500, 1, 24, 0, 0, 0, 1, "Rateau de fermier01", "Rateau de fermier01"),
(100900280, 1, 500, 1, 24, 0, 0, 0, 1, "Pelle01", "Pelle01"),
(101300015, 1, 500, 1, 24, 0, 0, 0, 1, "Guisarme PA C006 de pnj", "Guisarme PA C006 de pnj"),
(100500011, 1, 500, 1, 24, 0, 0, 0, 1, "Orbe 01 pour asmodien debutant", "Orbe 01 pour asmodien debutant"),
(100600008, 1, 500, 1, 24, 0, 0, 0, 1, "Grimoire de l ame monstrueuse", "Grimoire de l ame monstrueuse"),
(100600030, 1, 500, 1, 24, 0, 0, 0, 1, "Livre de sorts BO_R011 de pnj", "Livre de sorts BO_R011 de pnj"),
(100000713, 1, 500, 1, 24, 0, 0, 0, 1, "Masse de l ame monstrueuse02", "Masse de l ame monstrueuse02"),
(100000800, 1, 500, 1, 24, 0, 0, 0, 1, "Masse de l ame monstrueuse03", "Masse de l ame monstrueuse03"),
(100000034, 1, 500, 1, 24, 0, 0, 0, 1, "Epee 01 pour elyseen Debutant", "Epee 01 pour elyseen Debutant"),
(100000033, 1, 500, 1, 24, 0, 0, 0, 1, "Hache a double tranchant", "Hache a double tranchant"),
(100000035, 1, 500, 1, 24, 0, 0, 0, 1, "Epee 01 pour asmodien debutant", "Epee 01 pour asmodien debutant"),
(100900035, 1, 500, 1, 24, 0, 0, 0, 1, "Espadon TS R012 de pnj", "Espadon TS R012 de pnj"),
(100900036, 1, 500, 1, 24, 0, 0, 0, 1, "Espadon TS R013 de pnj", "Espadon TS R013 de pnj"),
(100900037, 1, 500, 1, 24, 0, 0, 0, 1, "Espadon TS U001 de pnj", "Espadon TS U001 de pnj"),
(101300018, 1, 500, 1, 24, 0, 0, 0, 1, "Guisarme PA R002 de pnj", "Guisarme PA R002 de pnj"),
(101300023, 1, 500, 1, 24, 0, 0, 0, 1, "Guisarme Pa R007 de pnj", "Guisarme Pa R007 de pnj"),
(101700877, 1, 750, 1, 24, 0, 0, 0, 1, "Arc long legendaire de tahabata 1h", "Arc long legendaire de tahabata 1h"),
(101500861, 1, 750, 1, 24, 0, 0, 0, 1, "Baton legendaire de tahabata 1h", "Baton legendaire de tahabata 1h"),
(100200968, 1, 750, 1, 24, 0, 0, 0, 1, "Dague legendaire de tahabata 1h", "Dague legendaire de tahabata 1h"),
(100001098, 1, 750, 1, 24, 0, 0, 0, 1, "Epee legendaire de tahabata 1h", "Epee legendaire de tahabata 1h"),
(100900834, 1, 750, 1, 24, 0, 0, 0, 1, "Espadon legendaire de tahabata 1h", "Espadon legendaire de tahabata 1h"),
(100600909, 1, 750, 1, 24, 0, 0, 0, 1, "Grimoire legendaire de tahabata 1h", "Grimoire legendaire de tahabata 1h"),
(100500853, 1, 750, 1, 24, 0, 0, 0, 1, "Joyau legendaire de tahabata 1h", "Joyau legendaire de tahabata 1h"),
(101300802, 1, 750, 1, 24, 0, 0, 0, 1, "Lance legendaire de tahabata 1h", "Lance legendaire de tahabata 1h"),
(100100839, 1, 750, 1, 24, 0, 0, 0, 1, "Marteau de guerre legendaire de tahabata 1h", "Marteau de guerre legendaire de tahabata 1h"),
(100600920, 1, 500, 1, 24, 0, 0, 0, 1, "Rosetta Tablet", "Rosetta Tablet"),
(100100673, 1, 500, 1, 24, 0, 0, 0, 1, "Sartuan Snack", "Sartuan Snack"),
(100500695, 1, 500, 1, 24, 0, 0, 0, 1, "Cadran de Siel", "Cadran de Siel"),
(100900850, 1, 500, 1, 24, 0, 0, 0, 1, "Arbre de Solorius", "Arbre de Solorius"),
(100500867, 1, 500, 1, 24, 0, 0, 0, 1, "Guilande de solorius", "Guilande de solorius"),
(100600923, 1, 500, 1, 24, 0, 0, 0, 1, "Carte Surprise de solorius", "Carte Surprise de solorius"),
(100001114, 1, 500, 1, 24, 0, 0, 0, 1, "Sucre dorge en forme de canne", "Sucre dorge en forme de canne"),
(100000389, 1, 500, 1, 24, 0, 0, 0, 1, "Aroseur deau01", "Aroseur deau01"),
(100000381, 1, 500, 1, 24, 0, 0, 0, 1, "Hache de bucheron", "Hache de bucheron"),
(101500876, 1, 500, 1, 24, 0, 0, 0, 1, "Baton de yule", "Baton de yule"),
(100100852, 1, 500, 1, 24, 0, 0, 0, 1, "Cloche en argent", "Cloche en argent"),
(100200981, 1, 500, 1, 24, 0, 0, 0, 1, "Glacon de neige", "Glacon de neige"),
(101700036, 1, 500, 1, 24, 0, 0, 0, 1, "Arc BW R007 de pnj", "Arc BW R007 de pnj"),
(101700726, 1, 500, 1, 24, 0, 0, 0, 1, "Arc 01 de pnj de la tribu rean", "Arc 01 de pnj de la tribu rean"),
(100000015, 1, 500, 1, 24, 0, 0, 0, 1, "Epee de l ame monstrueuse asmodien", "Epee de l ame monstrueuse asmodien"),
(100000894, 1, 500, 1, 24, 0, 0, 0, 1, "Epee de pnj Fanatic", "Epee de pnj Fanatic"),
(100000879, 1, 500, 1, 24, 0, 0, 0, 1, "Sabre ethere", "Sabre ethere"),
(100900395, 1, 500, 1, 24, 0, 0, 0, 1, "Espadon du general divin celeste", "Espadon du general divin celeste"),
(101700416, 1, 500, 1, 24, 0, 0, 0, 1, "Arc long du general divin celeste", "Arc long du general divin celeste"),
(101300387, 1, 500, 1, 24, 0, 0, 0, 1, "Lance du general divin celeste", "Lance du general divin celeste"),
(101500403, 1, 500, 1, 24, 0, 0, 0, 1, "Baton du general divin celeste", "Baton du general divin celeste"),
(100000529, 1, 500, 1, 24, 0, 0, 0, 1, "Epee du general divin celeste", "Epee du general divin celeste"),
(100100405, 1, 500, 1, 24, 0, 0, 0, 1, "Marteau de guerre du general divin celeste", "Marteau de guerre du general divin celeste"),
(100900396, 1, 500, 1, 24, 0, 0, 0, 1, "Espadon de general demon", "Espadon de general demon"),
(101700417, 1, 500, 1, 24, 0, 0, 0, 1, "Arc long de general demon", "Arc long de general demon"),
(101300388, 1, 500, 1, 24, 0, 0, 0, 1, "Lance de general demon", "Lance de general demon"),
(101500404, 1, 500, 1, 24, 0, 0, 0, 1, "Baton de general demon", "Baton de general demon"),
(100000530, 1, 500, 1, 24, 0, 0, 0, 1, "Epee de general demon", "Epee de general demon"),
(100100406, 1, 500, 1, 24, 0, 0, 0, 1, "Marteau de guerre de general demon", "Marteau de guerre de general demon"),
(100900847, 1, 500, 1, 24, 0, 0, 0, 1, "Machoires du cataclysme", "Machoires du cataclysme"),
(100600433, 1, 500, 1, 24, 0, 0, 0, 1, "Ouvrage de general demon", "Ouvrage de general demon"),
(101500695, 1, 500, 1, 24, 0, 0, 0, 1, "Force d israphel", "Force d israphel"),
(101300652, 1, 500, 1, 24, 0, 0, 0, 1, "Candelabre de luxe", "Candelabre de luxe"),
(100200979, 1, 500, 1, 24, 0, 0, 0, 1, "Gaterie de mellin", "Gaterie de mellin"),
(100001277, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_2nd divinization Hero", "Skin Arme Ordalie"),
(100001278, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_1nd divinization PVP unique", "Skin Arme Ordalie"),
(100100973, 1, 750, 0, 24, 0, 0, 0, 1, "Type Epee", "Skin Arme Ordalie"),
(100201130, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_2nd Dague", "Skin Arme Ordalie"),
(100201131, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_2nd PVP unique dague", "Skin Arme Ordalie"),
(100500988, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_2nd divinization Hero ORBE", "Skin Arme Ordalie"),
(100500989, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_2nd PVP unique ORBE", "Skin Arme Ordalie"),
(100601042, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_2nd divinization Hero GRIMOIRE", "Skin Arme Ordalie"),
(100601043, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_2nd PVP unique GRIMOIRE", "Skin Arme Ordalie"),
(100900975, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_1ST divinization Hero ESPADON", "Skin Arme Ordalie"),
(100900976, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_1ST PVP unique ESPADON", "Skin Arme Ordalie"),
(101501000, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_2nd divinization Hero Baton", "Skin Arme Ordalie"),
(101501001, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_2nd PVP unique Baton", "Skin Arme Ordalie"),
(100900977, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_1ST PVP Hero ESPADON", "Skin Arme Ordalie"),
(101501002, 1, 750, 0, 24, 0, 0, 0, 1, "NPC_temple_1ST PVP Hero Baton", "Skin Arme Ordalie"),
(100001277, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_2nd divinization Hero", "Skin Arme Ordalie"),
(100001278, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_1nd divinization PVP unique", "Skin Arme Ordalie"),
(100100973, 1, 750, 1, 24, 0, 0, 0, 1, "Type Epee", "Skin Arme Ordalie"),
(100201130, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_2nd Dague", "Skin Arme Ordalie"),
(100201131, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_2nd PVP unique dague", "Skin Arme Ordalie"),
(100500988, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_2nd divinization Hero ORBE", "Skin Arme Ordalie"),
(100500989, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_2nd PVP unique ORBE", "Skin Arme Ordalie"),
(100601042, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_2nd divinization Hero GRIMOIRE", "Skin Arme Ordalie"),
(100601043, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_2nd PVP unique GRIMOIRE", "Skin Arme Ordalie"),
(100900975, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_1ST divinization Hero ESPADON", "Skin Arme Ordalie"),
(100900976, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_1ST PVP unique ESPADON", "Skin Arme Ordalie"),
(101501000, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_2nd divinization Hero Baton", "Skin Arme Ordalie"),
(101501001, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_2nd PVP unique Baton", "Skin Arme Ordalie"),
(100900977, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_1ST PVP Hero ESPADON", "Skin Arme Ordalie"),
(101501002, 1, 750, 1, 24, 0, 0, 0, 1, "NPC_temple_1ST PVP Hero Baton", "Skin Arme Ordalie");
-- SKIN HAT
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(125040037, 1, 500, 0, 4, 0, 0, 0, 1, "T�te enflammee", "Skin Casque"),
(125040053, 1, 500, 0, 4, 0, 0, 0, 1, "Accesoire des amoureux", "Skin Casque"),
(125040057, 1, 500, 0, 4, 0, 0, 0, 1, "Aureole de beatitude", "Skin Casque"),
(125040069, 1, 500, 0, 4, 0, 0, 0, 1, "Bandeau d oreille d ours", "Skin Casque"),
(125040070, 1, 500, 0, 4, 0, 0, 0, 1, "bandeau d oreille de lapin", "Skin Casque"),
(125040071, 1, 500, 0, 4, 0, 0, 0, 1, "Bandeau de ballons en coeur", "Skin Casque"),
(125040005, 1, 500, 0, 4, 0, 0, 0, 1, "Bandeau de tournesol", "Skin Casque"),
(125050005, 1, 500, 0, 4, 0, 0, 0, 1, "Bandeau tulipe", "Skin Casque"),
(125040078, 1, 500, 0, 4, 0, 0, 0, 1, "bonnet de bain", "Skin Casque"),
(125040064, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau citrouille", "Skin Casque"),
(125040012, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau a oreille de spriggle", "Skin Casque"),
(125040067, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau a oreille de sprigg", "Skin Casque"),
(125040108, 1, 500, 0, 4, 0, 0, 0, 1, "Casquette en resille", "Skin Casque"),
(125040096, 1, 500, 0, 4, 0, 0, 0, 1, "Casque Viking badin", "Skin Casque"),
(125040009, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau cornu de kerubiel", "Skin Casque"),
(125040079, 1, 500, 0, 4, 0, 0, 0, 1, "Casque de plongee/Bandana estival", "Skin Casque"),
(125040097, 1, 500, 0, 4, 0, 0, 0, 1, "Casque de pilote badin", "Skin Casque"),
(125040021, 1, 500, 0, 4, 0, 0, 0, 1, "Capuche de Porgus", "Skin Casque"),
(125040066, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau cornu kerubien", "Skin Casque"),
(125040099, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau d abex badin", "Skin Casque"),
(125040106, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau d elroco vadin", "Skin Casque"),
(125000651, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau de chasse", "Skin Casque"),
(125040101, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau daru badin", "Skin Casque"),
(125040103, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau dragon collerette badin", "Skin Casque"),
(125040100, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau de manduri badin", "Skin Casque"),
(125040046, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau de plage", "Skin Casque"),
(125040054, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau de valse des amoureux", "Skin Casque"),
(125040058, 1, 500, 0, 4, 0, 0, 0, 1, "Coiffe de beatitude", "Skin Casque"),
(125040055, 1, 500, 0, 4, 0, 0, 0, 1, "Coiffe des amoureux", "Skin Casque"),
(125040074, 1, 500, 0, 4, 0, 0, 0, 1, "Corne Demonique", "Skin Casque"),
(125040056, 1, 500, 0, 4, 0, 0, 0, 1, "Diademe beatitude", "Skin Casque"),
(125040107, 1, 500, 0, 4, 0, 0, 0, 1, "Feutre a rebort", "Skin Casque"),
(125001592, 1, 500, 0, 4, 0, 0, 0, 1, "Haume de garde de la cite novice (Asmodien)", "Skin Casque"),
(125001590, 1, 500, 0, 4, 0, 0, 0, 1, "Haume de garde de la cite novice (Elyseen) ", "Skin Casque"),
(125000650, 1, 500, 0, 4, 0, 0, 0, 1, "Laurier", "Skin Casque"),
(125000044, 1, 500, 0, 4, 0, 0, 0, 1, "Masque guerrier", "Skin Casque"),
(125040039, 1, 500, 0, 4, 0, 0, 0, 1, "Verre Miroir style", "Skin Casque"),
(125040180, 1, 500, 0, 4, 0, 0, 0, 1, "Casquette de sport", "Skin Casque"),
(125040172, 1, 500, 0, 4, 0, 0, 0, 1, "Epingle a cheveux de beatitude", "Skin Casque"),
(125040045, 1, 500, 0, 4, 0, 0, 0, 1, "Casque de plongee  Bandana estival", "Skin Casque"),
(125040111, 1, 500, 0, 4, 0, 0, 0, 1, "Chapeau de Citrouille-sorcier", "Skin Casque"),
(125040037, 1, 500, 1, 4, 0, 0, 0, 1, "T�te enflammee", "Skin Casque"),
(125040053, 1, 500, 1, 4, 0, 0, 0, 1, "Accesoire des amoureux", "Skin Casque"),
(125040057, 1, 500, 1, 4, 0, 0, 0, 1, "Aureole de beatitude", "Skin Casque"),
(125040069, 1, 500, 1, 4, 0, 0, 0, 1, "Bandeau d oreille d ours", "Skin Casque"),
(125040070, 1, 500, 1, 4, 0, 0, 0, 1, "bandeau d oreille de lapin", "Skin Casque"),
(125040071, 1, 500, 1, 4, 0, 0, 0, 1, "Bandeau de ballons en coeur", "Skin Casque"),
(125040005, 1, 500, 1, 4, 0, 0, 0, 1, "Bandeau de tournesol", "Skin Casque"),
(125050005, 1, 500, 1, 4, 0, 0, 0, 1, "Bandeau tulipe", "Skin Casque"),
(125040078, 1, 500, 1, 4, 0, 0, 0, 1, "bonnet de bain", "Skin Casque"),
(125040064, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau citrouille", "Skin Casque"),
(125040012, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau a oreille de spriggle", "Skin Casque"),
(125040067, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau a oreille de sprigg", "Skin Casque"),
(125040108, 1, 500, 1, 4, 0, 0, 0, 1, "Casquette en resille", "Skin Casque"),
(125040096, 1, 500, 1, 4, 0, 0, 0, 1, "Casque Viking badin", "Skin Casque"),
(125040009, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau cornu de kerubiel", "Skin Casque"),
(125040079, 1, 500, 1, 4, 0, 0, 0, 1, "Casque de plongee/Bandana estival", "Skin Casque"),
(125040097, 1, 500, 1, 4, 0, 0, 0, 1, "Casque de pilote badin", "Skin Casque"),
(125040021, 1, 500, 1, 4, 0, 0, 0, 1, "Capuche de Porgus", "Skin Casque"),
(125040066, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau cornu kerubien", "Skin Casque"),
(125040099, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau d abex badin", "Skin Casque"),
(125040106, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau d elroco vadin", "Skin Casque"),
(125000651, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau de chasse", "Skin Casque"),
(125040101, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau daru badin", "Skin Casque"),
(125040103, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau dragon collerette badin", "Skin Casque"),
(125040100, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau de manduri badin", "Skin Casque"),
(125040046, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau de plage", "Skin Casque"),
(125040054, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau de valse des amoureux", "Skin Casque"),
(125040058, 1, 500, 1, 4, 0, 0, 0, 1, "Coiffe de beatitude", "Skin Casque"),
(125040055, 1, 500, 1, 4, 0, 0, 0, 1, "Coiffe des amoureux", "Skin Casque"),
(125040074, 1, 500, 1, 4, 0, 0, 0, 1, "Corne Demonique", "Skin Casque"),
(125040056, 1, 500, 1, 4, 0, 0, 0, 1, "Diademe beatitude", "Skin Casque"),
(125040107, 1, 500, 1, 4, 0, 0, 0, 1, "Feutre a rebort", "Skin Casque"),
(125001592, 1, 500, 1, 4, 0, 0, 0, 1, "Haume de garde de la cite novice (Asmodien)", "Skin Casque"),
(125001590, 1, 500, 1, 4, 0, 0, 0, 1, "Haume de garde de la cite novice (Elyseen) ", "Skin Casque"),
(125001756, 1, 500, 1, 4, 0, 0, 0, 1, "Haume teleporteur asmodien", "Skin Casque"),
(125000650, 1, 500, 1, 4, 0, 0, 0, 1, "Laurier", "Skin Casque"),
(125000044, 1, 500, 1, 4, 0, 0, 0, 1, "Masque guerrier", "Skin Casque"),
(125040039, 1, 500, 1, 4, 0, 0, 0, 1, "Verre Miroir style", "Skin Casque"),
(125040180, 1, 500, 1, 4, 0, 0, 0, 1, "Casquette de sport", "Skin Casque"),
(125040172, 1, 500, 1, 4, 0, 0, 0, 1, "Epingle a cheveux de beatitude", "Skin Casque"),
(125040045, 1, 500, 1, 4, 0, 0, 0, 1, "Casque de plongee  Bandana estival", "Skin Casque"),
(125040111, 1, 500, 1, 4, 0, 0, 0, 1, "Chapeau de Citrouille-sorcier", "Skin Casque");
-- SKIN SET
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(110900199, 1, 750, 0, 3, 0, 0, 0, 1, "Costume de l �le paradisiaque", "Skin Costume"),
(110900201, 1, 750, 0, 3, 0, 0, 0, 1, "Costume de pure envie", "Skin Costume"),
(110900209, 1, 750, 0, 3, 0, 0, 0, 1, "Gante et elegant", "Skin Costume"),
(110900203, 1, 750, 0, 3, 0, 0, 0, 1, "Special mono epaule", "Skin Costume"),
(110900202, 1, 750, 0, 3, 0, 0, 0, 1, "Seduction a manche longue", "Skin Costume"),
(110900197, 1, 750, 0, 3, 0, 0, 0, 1, "tenue de seremonie a rubans", "Skin Costume"),
(110900205, 1, 750, 0, 3, 0, 0, 0, 1, "Tenue de soiree audacieux", "Skin Costume"),
(110900198, 1, 750, 0, 3, 0, 0, 0, 1, "Tenue rouge rebelle", "Skin Costume"),
(110900195, 1, 750, 0, 3, 0, 0, 0, 1, "tenue decontractee embellis", "Skin Costume"),
(110900048, 1, 750, 0, 3, 0, 0, 0, 1, "Armure lourde de la dynastie", "Skin Costume"),
(110900049, 1, 750, 0, 3, 0, 0, 0, 1, "Armure legere de la dynastie", "Skin Costume"),
(110900216, 1, 750, 0, 3, 0, 0, 0, 1, "Atour bourgeois", "Skin Costume"),
(110900212, 1, 750, 0, 3, 0, 0, 0, 1, "Atour de beatitude", "Skin Costume"),
(110900243, 1, 750, 0, 3, 0, 0, 0, 1, "T-Shirt assorti je n attend que toi", "Skin Costume"),
(110900244, 1, 750, 0, 3, 0, 0, 0, 1, "T-Shirt assorti je t appartiens", "Skin Costume"),
(110900242, 1, 750, 0, 3, 0, 0, 0, 1, "T-Shirt assorti ma douce moitier", "Skin Costume"),
(110900010, 1, 750, 0, 3, 0, 0, 0, 1, "Costume de solorius pour femme", "Skin Costume"),
(110900117, 1, 750, 0, 3, 0, 0, 0, 1, "Costume de bain aguicheur", "Skin Costume"),
(110900118, 1, 750, 0, 3, 0, 0, 0, 1, "Costume de bain mignon", "Skin Costume"),
(110900184, 1, 750, 0, 3, 0, 0, 0, 1, "Mini tenue de ceremonie", "Skin Costume"),
(110900122, 1, 750, 0, 3, 0, 0, 0, 1, "Ensemble de Tell Me,femme", "Skin Costume,femme"),
(110900136, 1, 750, 0, 3, 0, 0, 0, 1, "Ensemble pantalon sexy en queue de renard,femme", "Skin Costume,femme"),
(110900185, 1, 750, 0, 3, 0, 0, 0, 1, "Mini Costume blanc", "Skin Costume"),
(110900135, 1, 750, 0, 3, 0, 0, 0, 1, "Robe de mariee Benie/smoking", "Skin Costume"),
(110900139, 1, 750, 0, 3, 0, 0, 0, 1, "Robe du sorcier", "Skin Costume"),
(110900085, 1, 750, 0, 3, 0, 0, 0, 1, "Robe jeans affriolante,femme", "Skin Costume,femme"),
(110900087, 1, 750, 0, 3, 0, 0, 0, 1, "Robe jeans chatoyante,femme", "Skin Costume,femme"),
(110900086, 1, 750, 0, 3, 0, 0, 0, 1, "Robe Jeans Vivace,femme", "Skin Costume,femme"),
(110900089, 1, 750, 0, 3, 0, 0, 0, 1, "Robe retro de nobody,femme", "Skin Costume,femme"),
(110900090, 1, 750, 0, 3, 0, 0, 0, 1, "Tenue des amoureux,homme", "Skin Costume,homme"),
(110900178, 1, 750, 0, 3, 0, 0, 0, 1, "Tunique du festival d hiver", "Skin Costume"),
(110900166, 1, 750, 0, 3, 0, 0, 0, 1, "Tunique en fourrure de daru argente", "Skin Costume"),
(110900137, 1, 750, 0, 3, 0, 0, 0, 1, "Tutu Raye,femme", "Skin Costume,femme"),
(110900215, 1, 750, 0, 3, 0, 0, 0, 1, "Uniforme Scolaire chic", "Skin Costume"),
(110900223, 1, 750, 0, 3, 0, 0, 0, 1, "Surv�tement", "Skin Costume"),
(110900138, 1, 750, 0, 3, 0, 0, 0, 1, "Pantalon et veste en cuir sauvage,homme", "Skin Costume,homme"),
(110900040, 1, 750, 0, 3, 0, 0, 0, 1, "Robe de gente dame,femme", "Skin Costume,femme"),
(110900199, 1, 750, 1, 3, 0, 0, 0, 1, "Costume de l �le paradisiaque", "Skin Costume"),
(110900201, 1, 750, 1, 3, 0, 0, 0, 1, "Costume de pure envie", "Skin Costume"),
(110900209, 1, 750, 1, 3, 0, 0, 0, 1, "Gante et elegant", "Skin Costume"),
(110900203, 1, 750, 1, 3, 0, 0, 0, 1, "Special mono epaule", "Skin Costume"),
(110900202, 1, 750, 1, 3, 0, 0, 0, 1, "Seduction a manche longue", "Skin Costume"),
(110900197, 1, 750, 1, 3, 0, 0, 0, 1, "tenue de seremonie a rubans", "Skin Costume"),
(110900205, 1, 750, 1, 3, 0, 0, 0, 1, "Tenue de soiree audacieux", "Skin Costume"),
(110900198, 1, 750, 1, 3, 0, 0, 0, 1, "Tenue rouge rebelle", "Skin Costume"),
(110900195, 1, 750, 1, 3, 0, 0, 0, 1, "tenue decontractee embellis", "Skin Costume"),
(110900048, 1, 750, 1, 3, 0, 0, 0, 1, "Armure lourde de la dynastie", "Skin Costume"),
(110900049, 1, 750, 1, 3, 0, 0, 0, 1, "Armure legere de la dynastie", "Skin Costume"),
(110900216, 1, 750, 1, 3, 0, 0, 0, 1, "Atour bourgeois", "Skin Costume"),
(110900212, 1, 750, 1, 3, 0, 0, 0, 1, "Atour de beatitude", "Skin Costume"),
(110900243, 1, 750, 1, 3, 0, 0, 0, 1, "T-Shirt assorti je n attend que toi", "Skin Costume"),
(110900244, 1, 750, 1, 3, 0, 0, 0, 1, "T-Shirt assorti je t appartiens", "Skin Costume"),
(110900242, 1, 750, 1, 3, 0, 0, 0, 1, "T-Shirt assorti ma douce moitier", "Skin Costume"),
(110900010, 1, 750, 1, 3, 0, 0, 0, 1, "Costume de solorius pour femme", "Skin Costume"),
(110900117, 1, 750, 1, 3, 0, 0, 0, 1, "Costume de bain aguicheur", "Skin Costume"),
(110900118, 1, 750, 1, 3, 0, 0, 0, 1, "Costume de bain mignon", "Skin Costume"),
(110900184, 1, 750, 1, 3, 0, 0, 0, 1, "Mini tenue de ceremonie", "Skin Costume"),
(110900122, 1, 750, 1, 3, 0, 0, 0, 1, "Ensemble de Tell Me,femme", "Skin Costume,femme"),
(110900136, 1, 750, 1, 3, 0, 0, 0, 1, "Ensemble pantalon sexy en queue de renard,femme", "Skin Costume,femme"),
(110900185, 1, 750, 1, 3, 0, 0, 0, 1, "Mini Costume blanc", "Skin Costume"),
(110900135, 1, 750, 1, 3, 0, 0, 0, 1, "Robe de mariee Benie/smoking", "Skin Costume"),
(110900139, 1, 750, 1, 3, 0, 0, 0, 1, "Robe du sorcier", "Skin Costume"),
(110900085, 1, 750, 1, 3, 0, 0, 0, 1, "Robe jeans affriolante,femme", "Skin Costume,femme"),
(110900087, 1, 750, 1, 3, 0, 0, 0, 1, "Robe jeans chatoyante,femme", "Skin Costume,femme"),
(110900086, 1, 750, 1, 3, 0, 0, 0, 1, "Robe Jeans Vivace,femme", "Skin Costume,femme"),
(110900089, 1, 750, 1, 3, 0, 0, 0, 1, "Robe retro de nobody,femme", "Skin Costume,femme"),
(110900090, 1, 750, 1, 3, 0, 0, 0, 1, "Tenue des amoureux,homme", "Skin Costume,homme"),
(110900178, 1, 750, 1, 3, 0, 0, 0, 1, "Tunique du festival d hiver", "Skin Costume"),
(110900166, 1, 750, 1, 3, 0, 0, 0, 1, "Tunique en fourrure de daru argente", "Skin Costume"),
(110900137, 1, 750, 1, 3, 0, 0, 0, 1, "Tutu Raye,femme", "Skin Costume,femme"),
(110900215, 1, 750, 1, 3, 0, 0, 0, 1, "Uniforme Scolaire chic", "Skin Costume"),
(110900223, 1, 750, 1, 3, 0, 0, 0, 1, "Surv�tement", "Skin Costume"),
(110900138, 1, 750, 1, 3, 0, 0, 0, 1, "Pantalon et veste en cuir sauvage,homme", "Skin Costume,homme"),
(110900040, 1, 750, 1, 3, 0, 0, 0, 1, "Robe de gente dame,femme", "Skin Costume,femme");
-- SKIN SET 1
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(125040059, 1, 250, 0, 4, 0, 0, 0, 1, "Chapeau de bouffon", "Skin set"),
(111000012, 1, 250, 0, 3, 0, 0, 0, 1, "Gant de bouffon", "Skin set"),
(114000012, 1, 250, 0, 3, 0, 0, 0, 1, "Chaussure de bouffon", "Skin set"),
(110900112, 1, 250, 0, 3, 0, 0, 0, 1, "Tunique du bouffon", "Skin set"),
(114000020, 1, 250, 0, 3, 0, 0, 0, 1, "Chaussures Ensorceleuse", "Skin Set"),
(111000025, 1, 250, 0, 3, 0, 0, 0, 1, "Gants ensorceleur", "Skin Set"),
(125040160, 1, 250, 0, 4, 0, 0, 0, 1, "Chapeau Ensorceleur", "Skin Set"),
(110900171, 1, 250, 0, 3, 0, 0, 0, 1, "Veste Ensorceleuse", "Skin Set"),
(110900061, 1, 250, 0, 3, 0, 0, 0, 1, "Costume de Porgus", "Skin Set"),
(125040021, 1, 250, 0, 4, 0, 0, 0, 1, "Capuche de Porgus", "Skin Set"),
(114000013, 1, 250, 0, 3, 0, 0, 0, 1, "Pieds de Porgus", "Skin Set"),
(111000008, 1, 250, 0, 3, 0, 0, 0, 1, "Sabots de Porgus", "Skin Set"),
(114000026, 1, 250, 0, 3, 0, 0, 0, 1, "Chaussures en fourrure de Daru argente", "Skin Set"),
(111000020, 1, 250, 0, 3, 0, 0, 0, 1, "Gants en fourrure de Daru argente", "Skin Set"),
(113000007, 1, 250, 0, 3, 0, 0, 0, 1, "Jambieres en fourrure de Daru argente", "Skin Set"),
(110900166, 1, 250, 0, 3, 0, 0, 0, 1, "Tunique en fourrure de Daru argente", "Skin Set"),
(125040155, 1, 250, 0, 4, 0, 0, 0, 1, "Casquette en fourrure de Daru argente", "Skin Set"),
(110900112, 1, 250, 1, 3, 0, 0, 0, 1, "Tunique du bouffon", "Skin set"),
(111000012, 1, 250, 1, 3, 0, 0, 0, 1, "Gant de bouffon", "Skin set"),
(114000012, 1, 250, 1, 3, 0, 0, 0, 1, "Chaussure de bouffon", "Skin set"),
(125040059, 1, 250, 1, 4, 0, 0, 0, 1, "Chapeau de bouffon", "Skin set"),
(114000020, 1, 250, 1, 3, 0, 0, 0, 1, "Chaussures Ensorceleuse", "Skin Set"),
(111000025, 1, 250, 1, 3, 0, 0, 0, 1, "Gants ensorceleur", "Skin Set"),
(125040160, 1, 250, 1, 4, 0, 0, 0, 1, "Chapeau Ensorceleur", "Skin Set"),
(110900171, 1, 250, 1, 3, 0, 0, 0, 1, "Veste Ensorceleuse", "Skin Set"),
(110900061, 1, 250, 1, 3, 0, 0, 0, 1, "Costume de Porgus", "Skin Set"),
(125040021, 1, 250, 1, 4, 0, 0, 0, 1, "Capuche de Porgus", "Skin Set"),
(114000013, 1, 250, 1, 3, 0, 0, 0, 1, "Pieds de Porgus", "Skin Set"),
(111000008, 1, 250, 1, 3, 0, 0, 0, 1, "Sabots de Porgus", "Skin Set"),
(114000026, 1, 250, 1, 3, 0, 0, 0, 1, "Chaussures en fourrure de Daru argente", "Skin Set"),
(111000020, 1, 250, 1, 3, 0, 0, 0, 1, "Gants en fourrure de Daru argente", "Skin Set"),
(113000007, 1, 250, 1, 3, 0, 0, 0, 1, "Jambieres en fourrure de Daru argente", "Skin Set"),
(110900166, 1, 250, 1, 3, 0, 0, 0, 1, "Tunique en fourrure de Daru argente", "Skin Set"),
(125040155, 1, 250, 1, 4, 0, 0, 0, 1, "Casquette en fourrure de Daru argente", "Skin Set");
-- DYE
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(169220002, 1, 150, 0, 7, 0, 0, 0, 1, "Blanc", "Teinture"),
(169220028, 1, 150, 0, 7, 0, 0, 0, 1, "Blanc profond", "Teinture"),
(169200002, 1, 150, 0, 7, 0, 0, 0, 1, "Bleu", "Teinture"),
(169220027, 1, 150, 0, 7, 0, 0, 0, 1, "Bleu intense", "Teinture"),
(169220019, 1, 150, 0, 7, 0, 0, 0, 1, "bleu intense eclatant" , "Teinture"),
(169200003, 1, 150, 0, 7, 0, 0, 0, 1, "Brun", "Teinture"),
(169220007, 1, 150, 0, 7, 0, 0, 0, 1, "Jaune moutarde", "Teinture"),
(169220016, 1, 150, 0, 7, 0, 0, 0, 1, "Jaune moutarde eclatant", "Teinture"),
(169220003, 1, 150, 0, 7, 0, 0, 0, 1, "Noir", "Teinture"),
(169220029, 1, 150, 0, 7, 0, 0, 0, 1, "Noir profond", "Teinture"),
(169220004, 1, 150, 0, 7, 0, 0, 0, 1, "Orange Vif", "Teinture"),
(169220013, 1, 150, 0, 7, 0, 0, 0, 1, "Orange eclatant", "Teinture"),
(169220035, 1, 150, 0, 7, 0, 0, 0, 1, "Rose Vif", "Teinture"),
(169220015, 1, 150, 0, 7, 0, 0, 0, 1, "Rose eclatant", "Teinture"),
(169220001, 1, 150, 0, 7, 0, 0, 0, 1, "Rouge", "Teinture"),
(169220033, 1, 150, 0, 7, 0, 0, 0, 1, "Rouge profond", "Teinture"),
(169220030, 1, 150, 0, 7, 0, 0, 0, 1, "Rouge Taegeuk", "Teinture"),
(169220012, 1, 150, 0, 7, 0, 0, 0, 1, "Rouge eclatant", "Teinture"),
(169220038, 1, 150, 0, 7, 0, 0, 0, 1, "The Vert", "Teinture"),
(169220017, 1, 150, 0, 7, 0, 0, 0, 1, "The vert eclatant", "Teinture"),
(169200001, 1, 150, 0, 7, 0, 0, 0, 1, "Turquoise", "Teinture"),
(169220009, 1, 150, 0, 7, 0, 0, 0, 1, "Vert olive", "Teinture"),
(169220018, 1, 150, 0, 7, 0, 0, 0, 1, "Vert olive eclatant", "Teinture"),
(169200004, 1, 150, 0, 7, 0, 0, 0, 1, "Violet", "Teinture"),
(169220036, 1, 150, 0, 7, 0, 0, 0, 1, "Violet Vif", "Teinture"),
(169220014, 1, 150, 0, 7, 0, 0, 0, 1, "Violet eclatant", "Teinture"),
(169220002, 5, 600, 0, 7, 0, 0, 0, 1, "Blanc", "Teinture"),
(169220028, 5, 600, 0, 7, 0, 0, 0, 1, "Blanc profond", "Lots Teinture"),
(169200002, 5, 600, 0, 7, 0, 0, 0, 1, "Bleu", "Lots Teinture"),
(169220027, 5, 600, 0, 7, 0, 0, 0, 1, "Bleu intense", "Lots Teinture"),
(169220019, 5, 600, 0, 7, 0, 0, 0, 1, "bleu intense eclatant", "Lots Teinture"),
(169200003, 5, 600, 0, 7, 0, 0, 0, 1, "Brun", "Lots Teinture"),
(169220007, 5, 600, 0, 7, 0, 0, 0, 1, "Jaune moutarde", "Lots Teinture"),
(169220016, 5, 600, 0, 7, 0, 0, 0, 1, "Jaune moutarde eclatant", "Lots Teinture"),
(169220003, 5, 600, 0, 7, 0, 0, 0, 1, "Noir", "Lots Teinture"),
(169220029, 5, 600, 0, 7, 0, 0, 0, 1, "Noir profond", "Lots Teinture"),
(169220004, 5, 600, 0, 7, 0, 0, 0, 1, "Orange Vif", "Lots Teinture"),
(169220013, 5, 600, 0, 7, 0, 0, 0, 1, "Orange eclatant", "Lots Teinture"),
(169220035, 5, 600, 0, 7, 0, 0, 0, 1, "Rose Vif", "Lots Teinture"),
(169220015, 5, 600, 0, 7, 0, 0, 0, 1, "Rose eclatant", "Lots Teinture"),
(169220001, 5, 600, 0, 7, 0, 0, 0, 1, "Rouge", "Lots Teinture"),
(169220033, 5, 600, 0, 7, 0, 0, 0, 1, "Rouge profond", "Lots Teinture"),
(169220030, 5, 600, 0, 7, 0, 0, 0, 1, "Rouge Taegeuk","Lots Teinture"),
(169220012, 5, 600, 0, 7, 0, 0, 0, 1, "Rouge eclatant", "Lots Teinture"),
(169220038, 5, 600, 0, 7, 0, 0, 0, 1, "The Vert", "Lots Teinture"),
(169220017, 5, 600, 0, 7, 0, 0, 0, 1, "The vert eclatant" , "Lots Teinture"),
(169200001, 5, 600, 0, 7, 0, 0, 0, 1, "Turquoise", "Lots Teinture"),
(169220009, 5, 600, 0, 7, 0, 0, 0, 1, "Vert olive", "Lots Teinture"),
(169220018, 5, 600, 0, 7, 0, 0, 0, 1, "Vert olive eclatant", "Lots Teinture"),
(169200004, 5, 600, 0, 7, 0, 0, 0, 1, "Violet", "Lots Teinture"),
(169220036, 5, 600, 0, 7, 0, 0, 0, 1, "Violet Vif", "Lots Teinture"),
(169220014, 5, 600, 0, 7, 0, 0, 0, 1, "Violet eclatant", "Lots Teinture"),
(169220002, 1, 150, 1, 7, 0, 0, 0, 1, "Blanc", "Teinture"),
(169220028, 1, 150, 1, 7, 0, 0, 0, 1, "Blanc profond", "Teinture"),
(169200002, 1, 150, 1, 7, 0, 0, 0, 1, "Bleu", "Teinture"),
(169220027, 1, 150, 1, 7, 0, 0, 0, 1, "Bleu intense", "Teinture"),
(169220019, 1, 150, 1, 7, 0, 0, 0, 1, "bleu intense eclatant", "Teinture"),
(169200003, 1, 150, 1, 7, 0, 0, 0, 1, "Brun", "Teinture"),
(169220007, 1, 150, 1, 7, 0, 0, 0, 1, "Jaune moutarde", "Teinture"),
(169220016, 1, 150, 1, 7, 0, 0, 0, 1, "Jaune moutarde eclatant", "Teinture"),
(169220003, 1, 150, 1, 7, 0, 0, 0, 1, "Noir", "Teinture"),
(169220029, 1, 150, 1, 7, 0, 0, 0, 1, "Noir profond", "Teinture"),
(169220004, 1, 150, 1, 7, 0, 0, 0, 1, "Orange Vif", "Teinture"),
(169220013, 1, 150, 1, 7, 0, 0, 0, 1, "Orange eclatant", "Teinture"),
(169220035, 1, 150, 1, 7, 0, 0, 0, 1, "Rose Vif", "Teinture"),
(169220015, 1, 150, 1, 7, 0, 0, 0, 1, "Rose eclatant", "Teinture"),
(169220001, 1, 150, 1, 7, 0, 0, 0, 1, "Rouge", "Teinture"),
(169220033, 1, 150, 1, 7, 0, 0, 0, 1, "Rouge profond", "Teinture"),
(169220030, 1, 150, 1, 7, 0, 0, 0, 1, "Rouge Taegeuk", "Teinture"),
(169220012, 1, 150, 1, 7, 0, 0, 0, 1, "Rouge eclatant", "Teinture"),
(169220038, 1, 150, 1, 7, 0, 0, 0, 1, "The Vert", "Teinture"),
(169220017, 1, 150, 1, 7, 0, 0, 0, 1, "The vert eclatant", "Teinture"),
(169200001, 1, 150, 1, 7, 0, 0, 0, 1, "Turquoise", "Teinture"),
(169220009, 1, 150, 1, 7, 0, 0, 0, 1, "Vert olive", "Teinture"),
(169220018, 1, 150, 1, 7, 0, 0, 0, 1, "Vert olive eclatant", "Teinture"),
(169200004, 1, 150, 1, 7, 0, 0, 0, 1, "Violet", "Teinture"),
(169220036, 1, 150, 1, 7, 0, 0, 0, 1, "Violet Vif", "Teinture"),
(169220014, 1, 150, 1, 7, 0, 0, 0, 1, "Violet eclatant", "Teinture"),
(169220002, 5, 600, 1, 7, 0, 0, 0, 1, "Blanc", "Teinture"),
(169220028, 5, 600, 1, 7, 0, 0, 0, 1, "Blanc profond", "Lots Teinture"),
(169200002, 5, 600, 1, 7, 0, 0, 0, 1, "Bleu", "Lots Teinture"),
(169220027, 5, 600, 1, 7, 0, 0, 0, 1, "Bleu intense", "Lots Teinture"),
(169220019, 5, 600, 1, 7, 0, 0, 0, 1, "bleu intense eclatant", "Lots Teinture"),
(169200003, 5, 600, 1, 7, 0, 0, 0, 1, "Brun", "Lots Teinture"),
(169220007, 5, 600, 1, 7, 0, 0, 0, 1, "Jaune moutarde", "Lots Teinture"),
(169220016, 5, 600, 1, 7, 0, 0, 0, 1, "Jaune moutarde eclatant", "Lots Teinture"),
(169220003, 5, 600, 1, 7, 0, 0, 0, 1, "Noir", "Lots Teinture"),
(169220029, 5, 600, 1, 7, 0, 0, 0, 1, "Noir profond", "Lots Teinture"),
(169220004, 5, 600, 1, 7, 0, 0, 0, 1, "Orange Vif", "Lots Teinture"),
(169220013, 5, 600, 1, 7, 0, 0, 0, 1, "Orange eclatant", "Lots Teinture"),
(169220035, 5, 600, 1, 7, 0, 0, 0, 1, "Rose Vif", "Lots Teinture"),
(169220015, 5, 600, 1, 7, 0, 0, 0, 1, "Rose eclatant", "Lots Teinture"),
(169220001, 5, 600, 1, 7, 0, 0, 0, 1, "Rouge", "Lots Teinture"),
(169220033, 5, 600, 1, 7, 0, 0, 0, 1, "Rouge profond", "Lots Teinture"),
(169220030, 5, 600, 1, 7, 0, 0, 0, 1, "Rouge Taegeuk","Lots Teinture"),
(169220012, 5, 600, 1, 7, 0, 0, 0, 1, "Rouge eclatant", "Lots Teinture"),
(169220038, 5, 600, 1, 7, 0, 0, 0, 1, "The Vert", "Lots Teinture"),
(169220017, 5, 600, 1, 7, 0, 0, 0, 1, "The vert eclatant", "Lots Teinture"),
(169200001, 5, 600, 1, 7, 0, 0, 0, 1, "Turquoise", "Lots Teinture"),
(169220009, 5, 600, 1, 7, 0, 0, 0, 1, "Vert olive", "Lots Teinture"),
(169220018, 5, 600, 1, 7, 0, 0, 0, 1, "Vert olive eclatant", "Lots Teinture"),
(169200004, 5, 600, 1, 7, 0, 0, 0, 1, "Violet", "Lots Teinture"),
(169220036, 5, 600, 1, 7, 0, 0, 0, 1, "Violet Vif", "Lots Teinture"),
(169220014, 5, 600, 1, 7, 0, 0, 0, 1, "Violet eclatant", "Lots Teinture");
-- TICKETS
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(169630000, 1, 250, 0, 22, 0, 0, 0, 1, "Ext. Cube", "Ext. Cube"),
(169640000, 1, 250, 0, 22, 0, 0, 0, 1, "Ext. Entrepot", "Ext. Entrepot"),
(169680000, 1, 2000, 0, 22, 0, 0, 0, 1, "Nom de Legion", "Nom de Legion"),
(169670000, 1, 1000, 0, 22, 0, 0, 0, 1, "Nom de Personnage", "Nom de Personnage"),
(169650000, 1, 750, 0, 22, 0, 0, 0, 1,  "Apparence", "Apparence"),
(169660000, 1, 750, 0, 22, 0, 0, 0, 1, "Genre", "genre"),
(169661001, 1, 750, 0, 22, 0, 0, 0, 1, "State Exterior Remodeling Ticket", "state Exterior Remodeling Ticket"),
(169661002, 1, 750, 0, 22, 0, 0, 0, 1, "Mansion Exterior Remodeling Ticket", "Mansion Exterior Remodeling Ticket"),
(169661003, 1, 750, 0, 22, 0, 0, 0, 1, "House Exterior Remodeling Ticket", "House Exterior Remodeling Ticket"),
(169661004, 1, 750, 0, 22, 0, 0, 0, 1, "Palace Exterior Remodeling Ticket", "Palace Exterior Remodeling Ticket"),
(169630000, 1, 250, 1, 22, 0, 0, 0, 1, "Ext. Cube", "Ext. Cube"),
(169640000, 1, 250, 1, 22, 0, 0, 0, 1, "Ext. Entrepot", "Ext. Entrepot"),
(169680000, 1, 2000, 1, 22, 0, 0, 0, 1, "Nom de Legion", "Nom de Legion"),
(169670000, 1, 1000, 1, 22, 0, 0, 0, 1, "Nom de Personnage", "Nom de Personnage"),
(169650000, 1, 750, 1, 22, 0, 0, 0, 1,  "Apparence", "Apparence"),
(169660000, 1, 750, 1, 22, 0, 0, 0, 1, "Genre", "genre"),
(169661001, 1, 750, 1, 22, 0, 0, 0, 1, "State Exterior Remodeling Ticket", "state Exterior Remodeling Ticket"),
(169661002, 1, 750, 1, 22, 0, 0, 0, 1, "Mansion Exterior Remodeling Ticket", "Mansion Exterior Remodeling Ticket"),
(169661003, 1, 750, 1, 22, 0, 0, 0, 1, "House Exterior Remodeling Ticket", "House Exterior Remodeling Ticket"),
(169661004, 1, 750, 1, 22, 0, 0, 0, 1, "Palace Exterior Remodeling Ticket", "Palace Exterior Remodeling Ticket");
-- AMULET
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(169620004, 1, 250, 0, 23, 0, 0, 0, 1, "Amulette de Lodas II", "Amulette de Lodas II"),
(169620004, 5, 1000, 0, 23, 0, 0, 0, 1, "Amulette de Lodas II (x5)", "Amulette de Lodas II"),
(169620010, 1, 500, 0, 23, 0, 0, 0, 1, "Amulette de Berdin I", "Amulette de Berdin I"),
(169620010, 5, 2000, 0, 23, 0, 0, 0, 1, "Amulette de Berdin I (x5)", "Amulette de Berdin I (x5)"),
(169625009, 1, 250, 0, 23, 0, 0, 0, 1, "Amulette de La Cle", "Amulette de La Cle"),
(169620007, 1, 250, 0, 23, 0, 0, 0, 1, "Amulette de Virdi", "Amulette de Virdi"),
(169620006, 1, 400, 0, 23, 0, 0, 0, 1, "Amulette de Demro", "Amulette de Demro"),
(169620004, 1, 250, 1, 23, 0, 0, 0, 1, "Amulette de Lodas II", "Amulette de Lodas II"), 
(169620004, 5, 1000, 1, 23, 0, 0, 0, 1, "Amulette de Lodas II (x5)", "Amulette de Lodas II"),
(169620010, 1, 500, 1, 23, 0, 0, 0, 1, "Amulette de Berdin I", "Amulette de Berdin I"),
(169620010, 5, 2000, 1, 23, 0, 0, 0, 1, "Amulette de Berdin I (x5)", "Amulette de Berdin I (x5)"),
(169625009, 1, 250, 1, 23, 0, 0, 0, 1, "Amulette de La Cle", "Amulette de La Cle"),
(169620007, 1, 250, 1, 23, 0, 0, 0, 1, "Amulette de Virdi", "Amulette de Virdi"),
(169620006, 1, 400, 1, 23, 0, 0, 0, 1, "Amulette de Demro", "Amulette de Demro");
-- SKINS
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(100000084, 1, 750, 0, 24, 0, 0, 0, 1, "epee sw_u001 de pnj", "Skin PNJ rare"),
(100000056, 1, 750, 0, 24, 0, 0, 0, 1, "epee sw_r009 de pnj", "Skin PNJ rare"),
(100000741, 1, 750, 0, 24, 0, 0, 0, 1, "epee des abyss 03 de pnj asmodien", "Skin PNJ rare"),
(100001009, 1, 750, 0, 24, 0, 0, 0, 1, "epee des abyss 06 de pnj elyseen", "Skin PNJ rare"),
(100200901, 1, 750, 0, 24, 0, 0, 0, 1, "dague des abyss 06 de pnj elyseen", "Skin PNJ rare"),
(101700808, 1, 750, 0, 24, 0, 0, 0, 1, "arc des abyss 05 de pnj elyseen", "Skin PNJ rare"),
(101300422, 1, 750, 0, 24, 0, 0, 0, 1, "guisarme pa r010a de pnj", "Skin PNJ rare"),
(101300545, 1, 750, 0, 24, 0, 0, 0, 1, "guisarme des abyss 02 de pnj elyseen", "Skin PNJ rare"),
(100100006, 1, 750, 0, 24, 0, 0, 0, 1, "masse 01 pour asmodien debutant", "Skin PNJ rare"),
(100100005, 1, 750, 0, 24, 0, 0, 0, 1, "masse 01 pour elyseen debutant", "Skin PNJ rare"),
(100100100, 1, 750, 0, 24, 0, 0, 0, 1, "masse asmodienne de rang 4", "Skin PNJ rare"),
(101300009, 1, 750, 0, 24, 0, 0, 0, 1, "arme d'hast 01 pour asmodien debutant", "Skin PNJ rare"),
(100600427, 1, 750, 0, 24, 0, 0, 0, 1, "livre 01", "Skin PNJ rare"),
(101500013, 1, 750, 0, 24, 0, 0, 0, 1, "baton 01 pour elyseen debutant", "Skin PNJ rare"),
(115000457, 1, 500, 0, 3, 0, 0, 0, 1, "bouclier de soigneur asmodien de nv 5", "Skin PNJ rare"),
(115000467, 1, 500, 0, 3, 0, 0, 0, 1, "bouclier elyseen de rang 3", "Skin PNJ rare"),
(115000490, 1, 500, 0, 3, 0, 0, 0, 1, "bouclier dimensionnel", "Skin PNJ rare"),
(114601016, 1, 250, 0, 3, 0, 0, 0, 1, "greves de plate de pnj garde d elite inggison", "Skin PNJ rare"),
(111601036, 1, 250, 0, 3, 0, 0, 0, 1, "gantelets de pnj garde d elite inggison", "Skin PNJ rare"),
(113601020, 1, 250, 0, 3, 0, 0, 0, 1, "greves de plates de pnj garde d elite inggison", "Skin PNJ rare"),
(125300028, 1, 250, 0, 4, 0, 0, 0, 1, "casque de centurion elyseen d inggison", "Skin PNJ rare"),
(100001009, 1, 750, 0, 24, 0, 0, 0, 1, "epee des abyss 06 de pnj elyseen", "Skin PNJ rare"),
(112601009, 1, 250, 0, 3, 0, 0, 0, 1, "spallieres de plates de pnj garde d elite inggison", "Skin PNJ rare"),
(115001055, 1, 500, 0, 3, 0, 0, 0, 1, "bouclier des abyss 06 de pnj elyseen", "Skin PNJ rare"),
(110601059, 1, 250, 0, 3, 0, 0, 0, 1, "plastron de pnj garde d elite inggison", "Skin PNJ rare"),
(114300715, 1, 250, 0, 3, 0, 0, 0, 1, "chaussures en cuir legendaires lt_u103 d un pnj asmodien", "Skin PNJ rare"),
(111300676, 1, 250, 0, 3, 0, 0, 0, 1, "gants en cuir legendaire lt_u103 d un pnj asmodien", "Skin PNJ rare"),
(113300699, 1, 250, 0, 3, 0, 0, 0, 1, "jambieres en cuir legendaires lt_u103 d un pnj asmodien", "Skin PNJ rare"),
(112300634, 1, 250, 0, 3, 0, 0, 0, 1, "jambieres de cuir de vie", "Skin PNJ rare"),
(110300716, 1, 250, 0, 3, 0, 0, 0, 1, "jambieres de cuir de seigneur geant", "Skin PNJ rare"),
(114101103, 1, 250, 0, 3, 0, 0, 0, 1, "bottes en tissu de pnj greeta", "Skin PNJ rare"),
(111101062, 1, 250, 0, 3, 0, 0, 0, 1, "gantelets de pnj greeta", "Skin PNJ rare"),
(125000641, 1, 250, 0, 4, 0, 0, 0, 1, "chapeau en tissu rb_c001_helmet", "Skin PNJ rare"),
(113101076, 1, 250, 0, 3, 0, 0, 0, 1, "greves en tissu de pnj greeta", "Skin PNJ rare"),
(112101020, 1, 250, 0, 3, 0, 0, 0, 1, "spalliere en tissus de pnj greeta", "Skin PNJ rare"),
(110101172, 1, 250, 0, 3, 0, 0, 0, 1, "plastron de pnj greeta", "Skin PNJ rare"),
(100000084, 1, 750, 1, 24, 0, 0, 0, 1, "epee sw_u001 de pnj", "Skin PNJ rare"),
(100000056, 1, 750, 1, 24, 0, 0, 0, 1, "epee sw_r009 de pnj", "Skin PNJ rare"),
(100000741, 1, 750, 1, 24, 0, 0, 0, 1, "epee des abyss 03 de pnj asmodien", "Skin PNJ rare"),
(100001009, 1, 750, 1, 24, 0, 0, 0, 1, "epee des abyss 06 de pnj elyseen", "Skin PNJ rare"),
(100200901, 1, 750, 1, 24, 0, 0, 0, 1, "dague des abyss 06 de pnj elyseen", "Skin PNJ rare"),
(101700808, 1, 750, 1, 24, 0, 0, 0, 1, "arc des abyss 05 de pnj elyseen", "Skin PNJ rare"),
(101300422, 1, 750, 1, 24, 0, 0, 0, 1, "guisarme pa r010a de pnj", "Skin PNJ rare"),
(101300545, 1, 750, 1, 24, 0, 0, 0, 1, "guisarme des abyss 02 de pnj elyseen", "Skin PNJ rare"),
(100100006, 1, 750, 1, 24, 0, 0, 0, 1, "masse 01 pour asmodien debutant", "Skin PNJ rare"),
(100100005, 1, 750, 1, 24, 0, 0, 0, 1, "masse 01 pour elyseen debutant", "Skin PNJ rare"),
(100100100, 1, 750, 1, 24, 0, 0, 0, 1, "masse asmodienne de rang 4", "Skin PNJ rare"),
(101300009, 1, 750, 1, 24, 0, 0, 0, 1, "arme d'hast 01 pour asmodien debutant", "Skin PNJ rare"),
(100600427, 1, 750, 1, 24, 0, 0, 0, 1, "livre 01", "Skin PNJ rare"),
(101500013, 1, 750, 1, 24, 0, 0, 0, 1, "baton 01 pour elyseen debutant", "Skin PNJ rare"),
(115000457, 1, 500, 1, 3, 0, 0, 0, 1, "bouclier de soigneur asmodien de nv 5", "Skin PNJ rare"),
(115000467, 1, 500, 1, 3, 0, 0, 0, 1, "bouclier elyseen de rang 3", "Skin PNJ rare"),
(115000490, 1, 500, 1, 3, 0, 0, 0, 1, "bouclier dimensionnel", "Skin PNJ rare"),
(114601016, 1, 250, 1, 3, 0, 0, 0, 1, "greves de plate de pnj garde d elite inggison", "Skin PNJ rare"),
(111601036, 1, 250, 1, 3, 0, 0, 0, 1, "gantelets de pnj garde d elite inggison", "Skin PNJ rare"),
(113601020, 1, 250, 1, 3, 0, 0, 0, 1, "greves de plates de pnj garde d elite inggison", "Skin PNJ rare"),
(125300028, 1, 250, 1, 4, 0, 0, 0, 1, "casque de centurion elyseen d inggison", "Skin PNJ rare"),
(100001009, 1, 750, 1, 24, 0, 0, 0, 1, "epee des abyss 06 de pnj elyseen", "Skin PNJ rare"),
(112601009, 1, 250, 1, 3, 0, 0, 0, 1, "spallieres de plates de pnj garde d elite inggison", "Skin PNJ rare"),
(115001055, 1, 500, 1, 3, 0, 0, 0, 1, "bouclier des abyss 06 de pnj elyseen", "Skin PNJ rare"),
(110601059, 1, 250, 1, 3, 0, 0, 0, 1, "plastron de pnj garde d elite inggison", "Skin PNJ rare"),
(114300715, 1, 250, 1, 3, 0, 0, 0, 1, "chaussures en cuir legendaires lt_u103 d un pnj asmodien", "Skin PNJ rare"),
(111300676, 1, 250, 1, 3, 0, 0, 0, 1, "gants en cuir legendaire lt_u103 d un pnj asmodien", "Skin PNJ rare"),
(113300699, 1, 250, 1, 3, 0, 0, 0, 1, "jambieres en cuir legendaires lt_u103 d un pnj asmodien", "Skin PNJ rare"),
(112300634, 1, 250, 1, 3, 0, 0, 0, 1, "jambieres de cuir de vie", "Skin PNJ rare"),
(110300716, 1, 250, 1, 3, 0, 0, 0, 1, "jambieres de cuir de seigneur geant", "Skin PNJ rare"),
(114101103, 1, 250, 1, 3, 0, 0, 0, 1, "bottes en tissu de pnj greeta", "Skin PNJ rare"),
(111101062, 1, 250, 1, 3, 0, 0, 0, 1, "gantelets de pnj greeta", "Skin PNJ rare"),
(125000641, 1, 250, 1, 4, 0, 0, 0, 1, "chapeau en tissu rb_c001_helmet", "Skin PNJ rare"),
(113101076, 1, 250, 1, 3, 0, 0, 0, 1, "greves en tissu de pnj greeta", "Skin PNJ rare"),
(112101020, 1, 250, 1, 3, 0, 0, 0, 1, "spalliere en tissus de pnj greeta", "Skin PNJ rare"),
(110101172, 1, 250, 1, 3, 0, 0, 0, 1, "plastron de pnj greeta", "Skin PNJ rare"),
(113300862, 1, 400, 0, 3, 0, 0, 0, 1, "Jambiere de cuir de Kromede", "Jambiere de cuir de Kromede"),
(110300885, 1, 400, 0, 3, 0, 0, 0, 1, "Pourpoint de kromede", "Pourpoint de kromede"),
(112300786, 1, 400, 0, 3, 0, 0, 0, 1, "Spalliere de cuir de kromede", "Spalliere de cuir de kromede"),
(111300836, 1, 400, 0, 3, 0, 0, 0, 1, "Gants de cuir de kromede", "Gants de cuir de kromede"),
(114300895, 1, 400, 0, 3, 0, 0, 0, 1, "Chaussures de cuir de kromede", "Chaussures de cuir de kromede"),
(113300862, 1, 400, 1, 3, 0, 0, 0, 1, "Jambiere de cuir de Kromede", "Jambiere de cuir de Kromede"),
(110300885, 1, 400, 1, 3, 0, 0, 0, 1, "Pourpoint de kromede", "Pourpoint de kromede"),
(112300786, 1, 400, 1, 3, 0, 0, 0, 1, "Spalliere de cuir de kromede", "Spalliere de cuir de kromede"),
(111300836, 1, 400, 1, 3, 0, 0, 0, 1, "Gants de cuir de kromede", "Gants de cuir de kromede"),
(114300895, 1, 400, 1, 3, 0, 0, 0, 1, "Chaussures de cuir de kromede", "Chaussures de cuir de kromede");
-- PETS
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(190020034, 1, 750, 0, 11, 0, 0, 0, 1, "kitter d altgard", "kitter d altgard"),
(190000063, 1, 750, 0, 11, 0, 0, 0, 1, "garnoulle doree", "garnoulle doree"),
(190000039, 1, 750, 0, 11, 0, 0, 0, 1, "oeuf kitter de beluslan", "oeuf kitter de beluslan"),
(190000064, 1, 750, 0, 11, 0, 0, 0, 1, "oeuf de garnoulle noire", "oeuf de garnoulle noire"),
(190020084, 1, 750, 0, 11, 0, 0, 0, 1, "oeuf kobushka", "oeuf kobushka"),
(190020083, 1, 750, 0, 11, 0, 0, 0, 1, "bulldozer", "bulldozer"),
(190020089, 1, 750, 0, 11, 0, 0, 0, 1, "merek bleu", "merek bleu"),
(190000058, 1, 750, 0, 11, 0, 0, 0, 1, "garnoulle bleue", "garnoulle bleue"),
(190000052, 1, 750, 0, 11, 0, 0, 0, 1, "clebbie beige", "clebbie beige"),
(190020002, 1, 750, 0, 11, 0, 0, 0, 1, "moutard mau", "moutard mau"),
(190020078, 1, 750, 0, 11, 0, 0, 0, 1, "boite en bois", "boite en bois"),
(190000026, 1, 750, 0, 11, 0, 0, 0, 1, "mycellion", "mycellion"),
(190000073, 1, 750, 0, 11, 0, 0, 0, 1, "kitter mazette", "kitter mazette"),
(190000057, 1, 750, 0, 11, 0, 0, 0, 1, "garnoulle olive", "garnoulle olive"),
(190020050, 1, 750, 0, 11, 0, 0, 0, 1, "shugo taegeuk mignon", "shugo taegeuk mignon"),
(190020049, 1, 750, 0, 11, 0, 0, 0, 1, "shugo taegeuk elegant", "shugo taegeuk elegant"),
(190020075, 1, 750, 0, 11, 0, 0, 0, 1, "bogel d eclair", "bogel d eclair"),
(190020072, 1, 750, 0, 11, 0, 0, 0, 1, "mycellion", "mycellion"),
(190000053, 1, 750, 0, 11, 0, 0, 0, 1, "elroco mouffette", "elroco mouffette"),
(190000043, 1, 750, 0, 11, 0, 0, 0, 1, "wuf dore", "wuf dore"),
(190010000, 1, 750, 0, 11, 0, 0, 0, 1, "drakie des prairies", "drakie des prairies"),
(190020087, 1, 750, 0, 11, 0, 0, 0, 1, "diabol vert", "diabol vert"),
(190000056, 1, 750, 0, 11, 0, 0, 0, 1, "garnoulle verte", "garnoulle verte"),
(190020077, 1, 750, 0, 11, 0, 0, 0, 1, "crabe a carapace verte", "crabe a carapace verte"),
(190000041, 1, 750, 0, 11, 0, 0, 0, 1, "kitter d heiron", "kitter d heiron"),
(190000014, 1, 750, 0, 11, 0, 0, 0, 1, "garnoulle indigo", "garnoulle indigo"),
(190000012, 1, 750, 0, 11, 0, 0, 0, 1, "aukwi maniaque", "aukwi maniaque"),
(190020003, 1, 750, 0, 11, 0, 0, 0, 1, "petite mau espiegle", "petite mau espiegle"),
(190000034, 1, 750, 0, 11, 0, 0, 0, 1, "manduri malicieux", "manduri malicieux"),
(190000033, 1, 750, 0, 11, 0, 0, 0, 1, "manduri agacant", "manduri agacant"),
(190020114, 1, 750, 0, 11, 0, 0, 0, 1, "kitter pointu", "kitter pointu"),
(190000055, 1, 750, 0, 11, 0, 0, 0, 1, "garnouille pourpre", "garnouille pourpre"),
(190000011, 1, 750, 0, 11, 0, 0, 0, 1, "kirca vif", "kirca vif"),
(190000010, 1, 750, 0, 11, 0, 0, 0, 1, "larail oeil rouge", "larail oeil rouge"),
(190010000, 1, 750, 0, 11, 0, 0, 0, 1, "drakie", "drakie"),
(190020087, 1, 750, 0, 11, 0, 0, 0, 1, "diabol vert", "diabol vert"),
(190000056, 1, 750, 0, 11, 0, 0, 0, 1, "garnouille verte", "garnouille verte"),
(190000060, 1, 750, 0, 11, 0, 0, 0, 1, "garnouille rouge", "garnouille rouge"),
(190000059, 1, 750, 0, 11, 0, 0, 0, 1, "garnoullotron", "garnoullotron"),
(190020063, 1, 750, 0, 11, 0, 0, 0, 1, "ailu robuste", "ailu robuste"),
(190000013, 1, 750, 0, 11, 0, 0, 0, 1, "methu spherique", "methu spherique"),
(190000016, 1, 750, 0, 11, 0, 0, 0, 1, "rotan dents de scie", "rotan dents de scie"),
(190020001, 1, 750, 0, 11, 0, 0, 0, 1, "krall cranabra", "krall cranabra"),
(190020061, 1, 750, 0, 11, 0, 0, 0, 1, "radama neigeux", "radama neigeux"),
(190020057, 1, 750, 0, 11, 0, 0, 0, 1, "grande crete imposante", "grande crete imposante"),
(190000015, 1, 750, 0, 11, 0, 0, 0, 1, "elroco rayures", "elroco rayures"),
(190000061, 1, 750, 0, 11, 0, 0, 0, 1, "garnoulle mandarine", "garnoulle mandarine"),
(190000071, 1, 750, 0, 11, 0, 0, 0, 1, "kitter truc", "kitter truc"),
(190000062, 1, 750, 0, 11, 0, 0, 0, 1, "garnoulle", "garnoulle"),
(190020081, 1, 750, 0, 11, 0, 0, 0, 1, "worg bossu gomine", "worg bossu gomine"),
(190000025, 1, 750, 0, 11, 0, 0, 0, 1, "clebbie blanc", "clebbie blanc"),
(190000024, 1, 750, 0, 11, 0, 0, 0, 1, "kitter sauvage", "kitter sauvage"),
(190020059, 1, 750, 0, 11, 0, 0, 0, 1, "acarun quilleret", "acarun quilleret"),
(190020015, 1, 800, 0, 11, 0, 0, 0, 1, "trico crin bleu 12 places", "trico crin bleu 12 places"),
(190020014, 1, 800, 0, 11, 0, 0, 0, 1, "inquin demi lune 12 places", "inquin demi lune 12 places"),
(190000036, 1, 800, 0, 11, 0, 0, 0, 1, "kerubim cramoisi 12 places", "kerubim cramoisi 12 places"),
(190000035, 1, 800, 0, 11, 0, 0, 0, 1, "sprigg avide 12 places", "sprigg avide 12 places"),
(190000076, 1, 850, 0, 11, 0, 0, 0, 1, "drakie dore 18 places", "drakie dore 18 places"),
(190020029, 1, 800, 0, 11, 0, 0, 0, 1, "drakie dore 12 places", "drakie dore 12 places"),
(190000046, 1, 800, 0, 11, 0, 0, 0, 1, "trico crin d or 12 places", "trico crin d or 12 places"),
(190000019, 1, 750, 0, 11, 0, 0, 0, 1, "dorion queue doree 6 places", "dorion queue doree 6 places"),
(190020093, 1, 850, 0, 11, 0, 0, 0, 1, "micro mumu 18 places", "micro mumu 18 places"),
(190020018, 1, 850, 0, 11, 0, 0, 0, 1, "mini mumu 18 places", "mini mumu 18 places"),
(190020094, 1, 850, 0, 11, 0, 0, 0, 1, "mini mumu 18 places", "mini mumu 18 places"),
(190010001, 1, 800, 0, 11, 0, 0, 0, 1, "inquin dodu 12 places", "inquin dodu 12 places"),
(190000046, 1, 800, 0, 11, 0, 0, 0, 1, "trico crin d or 12 places", "trico crin d or 12 places"),
(190020076, 1, 800, 0, 11, 0, 0, 0, 1, "crabe carapace 12 places", "crabe carapace 12 places"),
(190020020, 1, 900, 0, 11, 0, 0, 0, 1, "adolescent shugo 24 places", "adolescent shugo 24 places"),
(190020019, 1, 900, 0, 11, 0, 0, 0, 1, "adolescente shugo 24 places", "adolescente shugo 24 places"),
(190000018, 1, 750, 0, 11, 0, 0, 0, 1, "dorion queue argentee 6 places", "dorion queue argentee 6 places"),
(190020047, 1, 800, 0, 11, 0, 0, 0, 1, "ailu sherpa 12 places", "ailu sherpa 12 places"),
(190010003, 1, 750, 0, 11, 0, 0, 0, 1, "ailu sherpa 6 places", "ailu sherpa 6 places"),
(190000067, 1, 850, 0, 11, 0, 0, 0, 1, "drakie vesperal 18 places", "drakie vesperal 18 places"),
(190020007, 1, 1000, 0, 11, 0, 0, 0, 1, "shugo braillard", "shugo braillard"),
(190020067, 1, 1000, 0, 11, 0, 0, 0, 1, "shugo braillard", "shugo braillard"),
(190020010, 1, 1000, 0, 11, 0, 0, 0, 1, "manduri enervant", "manduri enervant"),
(190020012, 1, 1000, 0, 11, 0, 0, 0, 1, "steren bleu", "steren bleu"),
(190020073, 1, 1000, 0, 11, 0, 0, 0, 1, "mycellion brosse", "mycellion brosse"),
(190000027, 1, 1000, 0, 11, 0, 0, 0, 1, "naede du desert", "naede du desert"),
(190000048, 1, 1000, 0, 11, 0, 0, 0, 1, "oeuf de nyanco dore", "oeuf de nyanco dore"),
(190020079, 1, 1000, 0, 11, 0, 0, 0, 1, "boite en bois", "boite en bois"),
(190020006, 1, 1000, 0, 11, 0, 0, 0, 1, "shugo hurleur", "shugo hurleur"),
(190020090, 1, 1000, 0, 11, 0, 0, 0, 1, "kung fu manduri", "kung fu manduri"),
(190020088, 1, 1000, 0, 11, 0, 0, 0, 1, "merek rose", "merek rose"),
(190020013, 1, 1000, 0, 11, 0, 0, 0, 1, "steren rose", "steren rose"),
(190000045, 1, 1000, 0, 11, 0, 0, 0, 1, "wuf argente", "wuf argente"),
(190020064, 1, 1000, 0, 11, 0, 0, 0, 1, "ailu vigilant", "ailu vigilant"),
(190020074, 1, 950, 0, 11, 0, 0, 0, 1, "bogel de flammes", "bogel de flammes"),
(190000049, 1, 950, 0, 11, 0, 0, 0, 1, "nyanco rose", "nyanco rose" ),
(190020080, 1, 950, 0, 11, 0, 0, 0, 1, "worg de la mort", "worg de la mort"),
(190020070, 1, 1000, 0, 11, 0, 0, 0, 1, "sprigg",  "sprigg"),
(190020068, 1, 1000, 0, 11, 0, 0, 0, 1, "shugo sauteur", "shugo sauteur"),
(190020156, 1, 1000, 0, 11, 0, 0, 0, 1, "shugo male victorieux", "shugo male victorieux"),
(190020025, 1, 1000, 0, 11, 0, 0, 0, 1, "sprigg a chapeau", "sprigg a chapeau"),
(190000050, 1, 1000, 0, 11, 0, 0, 0, 1, "manduri barbe blanche", "manduri barbe blanche"),
(190000054, 1, 1000, 0, 11, 0, 0, 0, 1, "oeuf de drakie azur", "oeuf de drakie azur"),
(190010005, 1, 1000, 0, 11, 0, 0, 0, 1, "oeuf de drakie azur", "oeuf de drakie azur"),
(190000020, 1, 1000, 0, 11, 0, 0, 0, 1, "mookie petits yeux", "mookie petits yeux"),
(190020023, 1, 1000, 0, 11, 0, 0, 0, 1, "poroco tetu", "poroco tetu"),
(190000023, 1, 1000, 0, 11, 0, 0, 0, 1, "porgus insa", "porgus insa"),
(190000021, 1, 1000, 0, 11, 0, 0, 0, 1, "ksellid serein", "ksellid serein"),
(190020022, 1, 1000, 0, 11, 0, 0, 0, 1, "poroco hargneux", "poroco hargneux"),
(190000075, 1, 1000, 0, 11, 0, 0, 0, 1, "poppy la fugitive", "poppy la fugitive"),
(190020021, 1, 1000, 0, 11, 0, 0, 0, 1, "porgus goulu", "porgus goulu"),
(190020031, 1, 1200, 0, 11, 0, 0, 0, 1, "griffon d eau", "griffon d eau"),
(190020026, 1, 1200, 0, 11, 0, 0, 0, 1, "roi kerubim", "roi kerubim"),
(190020092, 1, 1200, 0, 11, 0, 0, 0, 1, "inquin demi lune", "inquin demi lune"),
(190020136, 1, 1400, 0, 11, 0, 0, 0, 1, "manduri kung fu", "manduri kung fu"),
(190020135, 1, 1200, 0, 11, 0, 0, 0, 1, "sherpa ailu", "sherpa ailu"),
(190020137, 1, 1200, 0, 11, 0, 0, 0, 1, "jefi taquin", "jefi taquin"),
(190020062, 1, 1200, 0, 11, 0, 0, 0, 1, "oeuf de ramada dore", "oeuf de ramada dore"),
(190020028, 1, 1200, 0, 11, 0, 0, 0, 1, "griffon rose", "griffon rose"),
(190020060, 1, 1200, 0, 11, 0, 0, 0, 1, "acarun celeste", "acarun celeste"),
(190020091, 1, 1200, 0, 11, 0, 0, 0, 1, "inquin dodu", "inquin dodu"),
(190020086, 1, 1400, 0, 11, 0, 0, 0, 1, "diabol rouge", "diabol rouge"),
(190020109, 1, 1200, 0, 11, 0, 0, 0, 1, "solorinerk", "solorinerk"),
(190020032, 1, 1200, 0, 11, 0, 0, 0, 1, "drakie vesperal", "drakie vesperal"),
(190020071, 1, 1200, 0, 11, 0, 0, 0, 1, "saam dore millenaire", "saam dore millenaire"),
(190020027, 1, 1400, 0, 11, 0, 0, 0, 1, "narky ferblanteux", "narky ferblanteux"),
(190020022, 1, 1400, 0, 11, 0, 0, 0, 1, "poroco hargneux", "poroco hargneux"),
(190020141, 1, 150, 0, 11, 0, 0, 0, 1, "tahabata 1j", "tahabata 1j"),   
(190020106, 1, 600, 0, 11, 0, 0, 0, 1, "tahabata 7j", "tahabata 7j"),   
(190020117, 1, 1000, 0, 11, 0, 0, 0, 1, "tahabata 15j", "tahabata 15j"),  
(190020120, 1, 1500, 0, 11, 0, 0, 0, 1, "tahabata 30j", "tahabata 30j"),  
(190020125, 1, 300, 0, 11, 0, 0, 0, 1, "tahabata 3j", "tahabata 3j"),   
(190020140, 1, 150, 0, 11, 0, 0, 0, 1, "aile-ouragan 1j", "aile-ouragan 1j"),       
(190020107, 1, 600, 0, 11, 0, 0, 0, 1, "aile-ouragan 7j", "aile-ouragan 7j"),     
(190020118, 1, 1000, 0, 11, 0, 0, 0, 1, "aile-ouragan 15j", "aile-ouragan 15j"),    
(190020121, 1, 1500, 0, 11, 0, 0, 0, 1, "aile-ouragan 30j", "aile-ouragan 30j"),   
(190020034, 1, 750, 1, 11, 0, 0, 0, 1, "kitter d altgard", "kitter d altgard"),
(190000063, 1, 750, 1, 11, 0, 0, 0, 1, "garnoulle doree", "garnoulle doree"),
(190000039, 1, 750, 1, 11, 0, 0, 0, 1, "oeuf kitter de beluslan", "oeuf kitter de beluslan"),
(190000064, 1, 750, 1, 11, 0, 0, 0, 1, "oeuf de garnoulle noire", "oeuf de garnoulle noire"),
(190020084, 1, 750, 1, 11, 0, 0, 0, 1, "oeuf kobushka", "oeuf kobushka"),
(190020083, 1, 750, 1, 11, 0, 0, 0, 1, "bulldozer", "bulldozer"),
(190020089, 1, 750, 1, 11, 0, 0, 0, 1, "merek bleu", "merek bleu"),
(190000058, 1, 750, 1, 11, 0, 0, 0, 1, "garnoulle bleue", "garnoulle bleue"),
(190000052, 1, 750, 1, 11, 0, 0, 0, 1, "clebbie beige", "clebbie beige"),
(190020002, 1, 750, 1, 11, 0, 0, 0, 1, "moutard mau", "moutard mau"),
(190020078, 1, 750, 1, 11, 0, 0, 0, 1, "boite en bois", "boite en bois"),
(190000026, 1, 750, 1, 11, 0, 0, 0, 1, "mycellion", "mycellion"),
(190000073, 1, 750, 1, 11, 0, 0, 0, 1, "kitter mazette", "kitter mazette"),
(190000057, 1, 750, 1, 11, 0, 0, 0, 1, "garnoulle olive", "garnoulle olive"),
(190020050, 1, 750, 1, 11, 0, 0, 0, 1, "shugo taegeuk mignon", "shugo taegeuk mignon"),
(190020049, 1, 750, 1, 11, 0, 0, 0, 1, "shugo taegeuk elegant", "shugo taegeuk elegant"),
(190020075, 1, 750, 1, 11, 0, 0, 0, 1, "bogel d eclair", "bogel d eclair"),
(190020072, 1, 750, 1, 11, 0, 0, 0, 1, "mycellion", "mycellion"),
(190000053, 1, 750, 1, 11, 0, 0, 0, 1, "elroco mouffette", "elroco mouffette"),
(190000043, 1, 750, 1, 11, 0, 0, 0, 1, "wuf dore", "wuf dore"),
(190010000, 1, 750, 1, 11, 0, 0, 0, 1, "drakie des prairies", "drakie des prairies"),
(190020087, 1, 750, 1, 11, 0, 0, 0, 1, "diabol vert", "diabol vert"),
(190000056, 1, 750, 1, 11, 0, 0, 0, 1, "garnoulle verte", "garnoulle verte"),
(190020077, 1, 750, 1, 11, 0, 0, 0, 1, "crabe a carapace verte", "crabe a carapace verte"),
(190000041, 1, 750, 1, 11, 0, 0, 0, 1, "kitter d heiron", "kitter d heiron"),
(190000014, 1, 750, 1, 11, 0, 0, 0, 1, "garnoulle indigo", "garnoulle indigo"),
(190000012, 1, 750, 1, 11, 0, 0, 0, 1, "aukwi maniaque", "aukwi maniaque"),
(190020003, 1, 750, 1, 11, 0, 0, 0, 1, "petite mau espiegle", "petite mau espiegle"),
(190000034, 1, 750, 1, 11, 0, 0, 0, 1, "manduri malicieux", "manduri malicieux"),
(190000033, 1, 750, 1, 11, 0, 0, 0, 1, "manduri agacant", "manduri agacant"),
(190020114, 1, 750, 1, 11, 0, 0, 0, 1, "kitter pointu", "kitter pointu"),
(190000055, 1, 750, 1, 11, 0, 0, 0, 1, "garnouille pourpre", "garnouille pourpre"),
(190000011, 1, 750, 1, 11, 0, 0, 0, 1, "kirca vif", "kirca vif"),
(190000010, 1, 750, 1, 11, 0, 0, 0, 1, "larail oeil rouge", "larail oeil rouge"),
(190010000, 1, 750, 1, 11, 0, 0, 0, 1, "drakie", "drakie"),
(190020087, 1, 750, 1, 11, 0, 0, 0, 1, "diabol vert", "diabol vert"),
(190000056, 1, 750, 1, 11, 0, 0, 0, 1, "garnouille verte", "garnouille verte"),
(190000060, 1, 750, 1, 11, 0, 0, 0, 1, "garnouille rouge", "garnouille rouge"),
(190000059, 1, 750, 1, 11, 0, 0, 0, 1, "garnoullotron", "garnoullotron"),
(190020063, 1, 750, 1, 11, 0, 0, 0, 1, "ailu robuste", "ailu robuste"),
(190000013, 1, 750, 1, 11, 0, 0, 0, 1, "methu spherique", "methu spherique"),
(190000016, 1, 750, 1, 11, 0, 0, 0, 1, "rotan dents de scie", "rotan dents de scie"),
(190020001, 1, 750, 1, 11, 0, 0, 0, 1, "krall cranabra", "krall cranabra"),
(190020061, 1, 750, 1, 11, 0, 0, 0, 1, "radama neigeux", "radama neigeux"),
(190020057, 1, 750, 1, 11, 0, 0, 0, 1, "grande crete imposante", "grande crete imposante"),
(190000015, 1, 750, 1, 11, 0, 0, 0, 1, "elroco rayures", "elroco rayures"),
(190000061, 1, 750, 1, 11, 0, 0, 0, 1, "garnoulle mandarine", "garnoulle mandarine"),
(190000071, 1, 750, 1, 11, 0, 0, 0, 1, "kitter truc", "kitter truc"),
(190000062, 1, 750, 1, 11, 0, 0, 0, 1, "garnoulle", "garnoulle"),
(190020081, 1, 750, 1, 11, 0, 0, 0, 1, "worg bossu gomine", "worg bossu gomine"),
(190000025, 1, 750, 1, 11, 0, 0, 0, 1, "clebbie blanc", "clebbie blanc"),
(190000024, 1, 750, 1, 11, 0, 0, 0, 1, "kitter sauvage", "kitter sauvage"),
(190020059, 1, 750, 1, 11, 0, 0, 0, 1, "acarun quilleret", "acarun quilleret"),
(190020015, 1, 800, 1, 11, 0, 0, 0, 1, "trico crin bleu 12 places", "trico crin bleu 12 places"),
(190020014, 1, 800, 1, 11, 0, 0, 0, 1, "inquin demi lune 12 places", "inquin demi lune 12 places"),
(190000036, 1, 800, 1, 11, 0, 0, 0, 1, "kerubim cramoisi 12 places", "kerubim cramoisi 12 places"),
(190000035, 1, 800, 1, 11, 0, 0, 0, 1, "sprigg avide 12 places", "sprigg avide 12 places"),
(190000076, 1, 850, 1, 11, 0, 0, 0, 1, "drakie dore 18 places", "drakie dore 18 places"),
(190020029, 1, 800, 1, 11, 0, 0, 0, 1, "drakie dore 12 places", "drakie dore 12 places"),
(190000046, 1, 800, 1, 11, 0, 0, 0, 1, "trico crin d or 12 places", "trico crin d or 12 places"),
(190000019, 1, 750, 1, 11, 0, 0, 0, 1, "dorion queue doree 6 places", "dorion queue doree 6 places"),
(190020093, 1, 850, 1, 11, 0, 0, 0, 1, "micro mumu 18 places", "micro mumu 18 places"),
(190020018, 1, 850, 1, 11, 0, 0, 0, 1, "mini mumu 18 places", "mini mumu 18 places"),
(190020094, 1, 850, 1, 11, 0, 0, 0, 1, "mini mumu 18 places", "mini mumu 18 places"),
(190010001, 1, 800, 1, 11, 0, 0, 0, 1, "inquin dodu 12 places", "inquin dodu 12 places"),
(190000046, 1, 800, 1, 11, 0, 0, 0, 1, "trico crin d or 12 places", "trico crin d or 12 places"),
(190020076, 1, 800, 1, 11, 0, 0, 0, 1, "crabe carapace 12 places", "crabe carapace 12 places"),
(190020020, 1, 900, 1, 11, 0, 0, 0, 1, "adolescent shugo 24 places", "adolescent shugo 24 places"),
(190020019, 1, 900, 1, 11, 0, 0, 0, 1, "adolescente shugo 24 places", "adolescente shugo 24 places"),
(190000018, 1, 750, 1, 11, 0, 0, 0, 1, "dorion queue argentee 6 places", "dorion queue argentee 6 places"),
(190020047, 1, 800, 1, 11, 0, 0, 0, 1, "ailu sherpa 12 places", "ailu sherpa 12 places"),
(190010003, 1, 750, 1, 11, 0, 0, 0, 1, "ailu sherpa 6 places", "ailu sherpa 6 places"),
(190000067, 1, 850, 1, 11, 0, 0, 0, 1, "drakie vesperal 18 places", "drakie vesperal 18 places"),
(190020007, 1, 1000, 1, 11, 0, 0, 0, 1, "shugo braillard", "shugo braillard"),
(190020067, 1, 1000, 1, 11, 0, 0, 0, 1, "shugo braillard", "shugo braillard"),
(190020010, 1, 1000, 1, 11, 0, 0, 0, 1, "manduri enervant", "manduri enervant"),
(190020012, 1, 1000, 1, 11, 0, 0, 0, 1, "steren bleu", "steren bleu"),
(190020073, 1, 1000, 1, 11, 0, 0, 0, 1, "mycellion brosse", "mycellion brosse"),
(190000027, 1, 1000, 1, 11, 0, 0, 0, 1, "naede du desert", "naede du desert"),
(190000048, 1, 1000, 1, 11, 0, 0, 0, 1, "oeuf de nyanco dore", "oeuf de nyanco dore"),
(190020079, 1, 1000, 1, 11, 0, 0, 0, 1, "boite en bois", "boite en bois"),
(190020006, 1, 1000, 1, 11, 0, 0, 0, 1, "shugo hurleur", "shugo hurleur"),
(190020090, 1, 1000, 1, 11, 0, 0, 0, 1, "kung fu manduri", "kung fu manduri"),
(190020088, 1, 1000, 1, 11, 0, 0, 0, 1, "merek rose", "merek rose"),
(190020013, 1, 1000, 1, 11, 0, 0, 0, 1, "steren rose", "steren rose"),
(190000045, 1, 1000, 1, 11, 0, 0, 0, 1, "wuf argente", "wuf argente"),
(190020064, 1, 1000, 1, 11, 0, 0, 0, 1, "ailu vigilant", "ailu vigilant"),
(190020074, 1, 950, 1, 11, 0, 0, 0, 1, "bogel de flammes", "bogel de flammes"),
(190000049, 1, 950, 1, 11, 0, 0, 0, 1, "nyanco rose", "nyanco rose" ),
(190020080, 1, 950, 1, 11, 0, 0, 0, 1, "worg de la mort", "worg de la mort"),
(190020070, 1, 1000, 1, 11, 0, 0, 0, 1, "sprigg",  "sprigg"),
(190020068, 1, 1000, 1, 11, 0, 0, 0, 1, "shugo sauteur", "shugo sauteur"),
(190020156, 1, 1000, 1, 11, 0, 0, 0, 1, "shugo male victorieux", "shugo male victorieux"),
(190020025, 1, 1000, 1, 11, 0, 0, 0, 1, "sprigg a chapeau", "sprigg a chapeau"),
(190000050, 1, 1000, 1, 11, 0, 0, 0, 1, "manduri barbe blanche", "manduri barbe blanche"),
(190000054, 1, 1000, 1, 11, 0, 0, 0, 1, "oeuf de drakie azur", "oeuf de drakie azur"),
(190010005, 1, 1000, 1, 11, 0, 0, 0, 1, "oeuf de drakie azur", "oeuf de drakie azur"),
(190000020, 1, 1000, 1, 11, 0, 0, 0, 1, "mookie petits yeux", "mookie petits yeux"),
(190020023, 1, 1000, 1, 11, 0, 0, 0, 1, "poroco tetu", "poroco tetu"),
(190000023, 1, 1000, 1, 11, 0, 0, 0, 1, "porgus insa", "porgus insa"),
(190000021, 1, 1000, 1, 11, 0, 0, 0, 1, "ksellid serein", "ksellid serein"),
(190020022, 1, 1000, 1, 11, 0, 0, 0, 1, "poroco hargneux", "poroco hargneux"),
(190000075, 1, 1000, 1, 11, 0, 0, 0, 1, "poppy la fugitive", "poppy la fugitive"),
(190020021, 1, 1000, 1, 11, 0, 0, 0, 1, "porgus goulu", "porgus goulu"),
(190020031, 1, 1200, 1, 11, 0, 0, 0, 1, "griffon d eau", "griffon d eau"),
(190020026, 1, 1200, 1, 11, 0, 0, 0, 1, "roi kerubim", "roi kerubim"),
(190020092, 1, 1200, 1, 11, 0, 0, 0, 1, "inquin demi lune", "inquin demi lune"),
(190020136, 1, 1400, 1, 11, 0, 0, 0, 1, "manduri kung fu", "manduri kung fu"),
(190020135, 1, 1200, 1, 11, 0, 0, 0, 1, "sherpa ailu", "sherpa ailu"),
(190020137, 1, 1200, 1, 11, 0, 0, 0, 1, "jefi taquin", "jefi taquin"),
(190020062, 1, 1200, 1, 11, 0, 0, 0, 1, "oeuf de ramada dore", "oeuf de ramada dore"),
(190020028, 1, 1200, 1, 11, 0, 0, 0, 1, "griffon rose", "griffon rose"),
(190020060, 1, 1200, 1, 11, 0, 0, 0, 1, "acarun celeste", "acarun celeste"),
(190020091, 1, 1200, 1, 11, 0, 0, 0, 1, "inquin dodu", "inquin dodu"),
(190020086, 1, 1400, 1, 11, 0, 0, 0, 1, "diabol rouge", "diabol rouge"),
(190020109, 1, 1200, 1, 11, 0, 0, 0, 1, "solorinerk", "solorinerk"),
(190020032, 1, 1200, 1, 11, 0, 0, 0, 1, "drakie vesperal", "drakie vesperal"),
(190020071, 1, 1200, 1, 11, 0, 0, 0, 1, "saam dore millenaire", "saam dore millenaire"),
(190020027, 1, 1400, 1, 11, 0, 0, 0, 1, "narky ferblanteux", "narky ferblanteux"),
(190020022, 1, 1400, 1, 11, 0, 0, 0, 1, "poroco hargneux", "poroco hargneux"),
(190020141, 1, 150, 1, 11, 0, 0, 0, 1, "tahabata 1j", "tahabata 1j"),   
(190020106, 1, 600, 1, 11, 0, 0, 0, 1, "tahabata 7j", "tahabata 7j"),   
(190020117, 1, 1000, 1, 11, 0, 0, 0, 1, "tahabata 15j", "tahabata 15j"),  
(190020120, 1, 1500, 1, 11, 0, 0, 0, 1, "tahabata 30j", "tahabata 30j"),  
(190020125, 1, 300, 1, 11, 0, 0, 0, 1, "tahabata 3j", "tahabata 3j"),   
(190020140, 1, 150, 1, 11, 0, 0, 0, 1, "aile-ouragan 1j", "aile-ouragan 1j"),       
(190020107, 1, 600, 1, 11, 0, 0, 0, 1, "aile-ouragan 7j", "aile-ouragan 7j"),     
(190020118, 1, 1000, 1, 11, 0, 0, 0, 1, "aile-ouragan 15j", "aile-ouragan 15j"),    
(190020121, 1, 1500, 1, 11, 0, 0, 0, 1, "aile-ouragan 30j", "aile-ouragan 30j");
-- SKINS 2
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(125040245, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau fraise", "Skin Casque"),
(125040246, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau pasteque", "Skin Casque"),
(125040247, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau ananas", "Skin Casque"),
(125040248, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau carotte", "Skin Casque"),
(125040249, 1, 500, 0, 4, 0, 0, 0, 1, "epingle a cheveux kiwi", "Skin Casque"),
(125040250, 1, 500, 0, 4, 0, 0, 0, 1, "epingle a cheveux citron", "Skin Casque"),
(125040252, 1, 500, 0, 4, 0, 0, 0, 1, "epingle a cheveux oeuf", "Skin Casque"),
(125045120, 1, 500, 0, 4, 0, 0, 0, 1, "casque de runes d ether", "Skin Casque"),
(125045121, 1, 500, 0, 4, 0, 0, 0, 1, "micro-casque de runes d ether", "Skin Casque"),
(125045122, 1, 500, 0, 4, 0, 0, 0, 1, "lunettes de soleil de runes d ether", "Skin Casque"),
(125045123, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau dore", "Skin Casque"),
(125045114, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau antique des galalantes gens", "Skin Casque"),
(125045115, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau de coq", "Skin Casque"),
(125050042, 1, 500, 0, 4, 0, 0, 0, 1, "chapeau de corbeau", "Skin Casque"),
(125040245, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau fraise", "Skin Casque"),
(125040246, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau pasteque", "Skin Casque"),
(125040247, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau ananas", "Skin Casque"),
(125040248, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau carotte", "Skin Casque"),
(125040249, 1, 500, 1, 4, 0, 0, 0, 1, "epingle a cheveux kiwi", "Skin Casque"),
(125040250, 1, 500, 1, 4, 0, 0, 0, 1, "epingle a cheveux citron", "Skin Casque"),
(125040252, 1, 500, 1, 4, 0, 0, 0, 1, "epingle a cheveux oeuf", "Skin Casque"),
(125045120, 1, 500, 1, 4, 0, 0, 0, 1, "casque de runes d ether", "Skin Casque"),
(125045121, 1, 500, 1, 4, 0, 0, 0, 1, "micro-casque de runes d ether", "Skin Casque"),
(125045122, 1, 500, 1, 4, 0, 0, 0, 1, "lunettes de soleil de runes d ether", "Skin Casque"),
(125045123, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau dore", "Skin Casque"),
(125045114, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau antique des galalantes gens", "Skin Casque"),
(125045115, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau de coq", "Skin Casque"),
(125050042, 1, 500, 1, 4, 0, 0, 0, 1, "chapeau de corbeau", "Skin Casque"),
(125045112, 1, 500, 0, 4, 0, 0, 0, 1, "bandeau d assassin", "Skin Casque"),
(125045111, 1, 500, 0, 4, 0, 0, 0, 1, "coiffe d assassin", "Skin Casque"),
(101501106, 1, 750, 0, 24, 0, 0, 0, 1, "baton d assassin", "Skin rare"),
(100201232, 1, 750, 0, 24, 0, 0, 0, 1, "dague d assassin", "Skin rare"),
(101301025, 1, 750, 0, 24, 0, 0, 0, 1, "guisarme d assassin", "Skin rare"),
(100601137, 1, 750, 0, 24, 0, 0, 0, 1, "grimoire d assassin", "Skin rare"),
(100001389, 1, 750, 0, 24, 0, 0, 0, 1, "epee de l assassin", "Skin rare"),
(100901088, 1, 750, 0, 24, 0, 0, 0, 1, "espadon d assassin", "Skin rare"),
(100101070, 1, 750, 0, 24, 0, 0, 0, 1, "masse d assassin", "Skin rare"),
(115001442, 1, 750, 0, 24, 0, 0, 0, 1, "bouclier d assassin", "Skin rare"),
(100501081, 1, 750, 0, 24, 0, 0, 0, 1, "joyau d assassin", "Skin rare"),
(101701118, 1, 750, 0, 24, 0, 0, 0, 1, "arc d assassin", "Skin rare"),
(125045112, 1, 500, 1, 4, 0, 0, 0, 1, "bandeau d assassin", "Skin Casque"),
(125045111, 1, 500, 1, 4, 0, 0, 0, 1, "coiffe d assassin", "Skin Casque"),
(101501106, 1, 750, 1, 24, 0, 0, 0, 1, "baton d assassin", "Skin rare"),
(100201232, 1, 750, 1, 24, 0, 0, 0, 1, "dague d assassin", "Skin rare"),
(101301025, 1, 750, 1, 24, 0, 0, 0, 1, "guisarme d assassin", "Skin rare"),
(100601137, 1, 750, 1, 24, 0, 0, 0, 1, "grimoire d assassin", "Skin rare"),
(100001389, 1, 750, 1, 24, 0, 0, 0, 1, "epee de l assassin", "Skin rare"),
(100901088, 1, 750, 1, 24, 0, 0, 0, 1, "espadon d assassin", "Skin rare"),
(100101070, 1, 750, 1, 24, 0, 0, 0, 1, "masse d assassin", "Skin rare"),
(115001442, 1, 750, 1, 24, 0, 0, 0, 1, "bouclier d assassin", "Skin rare"),
(100501081, 1, 750, 1, 24, 0, 0, 0, 1, "joyau d assassin", "Skin rare"),
(101701118, 1, 750, 1, 24, 0, 0, 0, 1, "arc d assassin", "Skin rare");
-- KISK 3.5
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(184002022, 1, 2000, 0, 25, 0, 0, 0, 1, "Elyos Kisk Furtif Groupe", "Kisks 3.5"),
(184002023, 1, 3000, 0, 25, 0, 0, 0, 1, "Elyos Kisk Furtif Cohorte", "Kisks 3.5"),
(184002024, 1, 2000, 1, 25, 0, 0, 0, 1, "Asmo Kisk Furtif Groupe", "Kisks 3.5"),
(184002025, 1, 3000, 1, 25, 0, 0, 0, 1, "Asmo Kisk Furtif Cohorte", "Kisks 3.5");
-- UPDATE 09/06/2013
-- INSTANCES TIME SCROLL
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(188600034, 1, 400, 0, 21, 0, 0, 0, 1, "Haramel", "Instance Time Scroll"),
(188600037, 1, 400, 0, 21, 0, 0, 0, 1, "Nochsana", "Instance Time Scroll"),
(188600055, 1, 400, 0, 21, 0, 0, 0, 1, "Temple du Feu", "Instance Time Scroll"),
(188600035, 1, 500, 0, 21, 0, 0, 0, 1, "Proces de Kromede", "Instance Time Scroll"),
(188600039, 1, 500, 0, 21, 0, 0, 0, 1, "Brise-Ecume", "Instance Time Scroll"),
(188600042, 1, 500, 0, 21, 0, 0, 0, 1, "Forteresse d Adma", "Instance Time Scroll"),
(188600036, 1, 500, 0, 21, 0, 0, 0, 1, "Taloc", "Instance Time Scroll"),
(188600041, 1, 500, 0, 21, 0, 0, 0, 1, "Labo Lephariste Theobomos", "Instance Time Scroll"),
(188600021, 1, 1000, 0, 21, 0, 0, 0, 1, "Poeta la Sombre", "Instance Time Scroll"),
(188600022, 1, 750, 0, 21, 0, 0, 0, 1, "Temple Udas", "Instance Time Scroll"),
(188600023, 1, 750, 0, 21, 0, 0, 0, 1, "Temple Udas Inferieur", "Instance Time Scroll"),
(188600024, 1, 1000, 0, 21, 0, 0, 0, 1, "Beshmundir", "Instance Time Scroll"),
(188600033, 1, 1500, 0, 21, 0, 0, 0, 1, "Abysses Confinees", "Instance Time Scroll"),
(188600050, 1, 1500, 0, 21, 0, 0, 0, 1, "Esoterrasse", "Instance Time Scroll"),
(188600051, 1, 750, 0, 21, 0, 0, 0, 1, "Ordalie Empyreenne", "Instance Time Scroll"),
(188600052, 1, 750, 0, 21, 0, 0, 0, 1, "Ordalie Solitaire", "Instance Time Scroll"),
(188600059, 1, 1500, 0, 21, 0, 0, 0, 1, "Brise-Ecume Solo", "Instance Time Scroll"),
(188600075, 1, 1500, 0, 21, 0, 0, 0, 1, "Tahmes", "Instance Time Scroll"),
(188600074, 1, 1500, 0, 21, 0, 0, 0, 1, "Forteresse Celeste d Aturam", "Instance Time Scroll"),
(188600073, 1, 1500, 0, 21, 0, 0, 0, 1, "Base de Rentus", "Instance Time Scroll"),
(188600072, 1, 1500, 0, 21, 0, 0, 0, 1, "Manoir d Argent", "Instance Time Scroll"),
(188600071, 1, 1500, 0, 21, 0, 0, 0, 1, "Foret d Elementis", "Instance Time Scroll"),
(188600080, 1, 750, 0, 21, 0, 0, 0, 1, "Caverne de Draupnir", "Instance Time Scroll"),
(188600091, 1, 1000, 0, 21, 0, 0, 0, 1, "Grotte de Padmarashka", "Instance Time Scroll"),
(188600092, 1, 1500, 0, 21, 0, 0, 0, 1, "Tresor de Satra", "Instance Time Scroll"),
(188600140, 1, 2000, 0, 21, 0, 0, 0, 1, "Forteresse de Tiamat", "Instance Time Scroll"),
(188600141, 1, 2000, 0, 21, 0, 0, 0, 1, "Antre de Tiamat", "Instance Time Scroll"),
(188600199, 1, 2000, 0, 21, 0, 0, 0, 1, "Sepulture de l Empereur Shugo", "Instance Time Scroll"),
(188600204, 1, 2000, 0, 21, 0, 0, 0, 1, "Reliquat des abysses confinees", "Instance Time Scroll"),
(188600197, 1, 2500, 0, 21, 0, 0, 0, 1, "3 Instances Abyssales inferieures", "Instance Time Scroll"),
(188600198, 1, 4000, 0, 21, 0, 0, 0, 1, "Toutes Instances Abyssales Sup + Abysses confinees + Reliquat Abysses confinees + Tresor de satra", "Instance Time Scroll"),
(188600193, 1, 2000, 0, 21, 0, 0, 0, 1, "Toutes instances level 16 a 40", "Instance Time Scroll"),
(188600194, 1, 3000, 0, 21, 0, 0, 0, 1, "Toutes instances level 41 a 50", "Instance Time Scroll"),
(188600195, 1, 3500, 0, 21, 0, 0, 0, 1, "Toutes instances level 51 a 55", "Instance Time Scroll"),
(188600196, 1, 4000, 0, 21, 0, 0, 0, 1, "Toutes instances level 56 a 60", "Instance Time Scroll"),
(188600034, 1, 400, 1, 21, 0, 0, 0, 1, "Haramel", "Instance Time Scroll"),
(188600037, 1, 400, 1, 21, 0, 0, 0, 1, "Nochsana", "Instance Time Scroll"),
(188600055, 1, 400, 1, 21, 0, 0, 0, 1, "Temple du Feu", "Instance Time Scroll"),
(188600035, 1, 500, 1, 21, 0, 0, 0, 1, "Proces de Kromede", "Instance Time Scroll"),
(188600039, 1, 500, 1, 21, 0, 0, 0, 1, "Brise-Ecume", "Instance Time Scroll"),
(188600042, 1, 500, 1, 21, 0, 0, 0, 1, "Forteresse d Adma", "Instance Time Scroll"),
(188600036, 1, 500, 1, 21, 0, 0, 0, 1, "Taloc", "Instance Time Scroll"),
(188600041, 1, 500, 1, 21, 0, 0, 0, 1, "Labo Lephariste Theobomos", "Instance Time Scroll"),
(188600021, 1, 1000, 1, 21, 0, 0, 0, 1, "Poeta la Sombre", "Instance Time Scroll"),
(188600022, 1, 750, 1, 21, 0, 0, 0, 1, "Temple Udas", "Instance Time Scroll"),
(188600023, 1, 750, 1, 21, 0, 0, 0, 1, "Temple Udas Inferieur", "Instance Time Scroll"),
(188600024, 1, 1000, 1, 21, 0, 0, 0, 1, "Beshmundir", "Instance Time Scroll"),
(188600033, 1, 1500, 1, 21, 0, 0, 0, 1, "Abysses Confinees", "Instance Time Scroll"),
(188600050, 1, 1500, 1, 21, 0, 0, 0, 1, "Esoterrasse", "Instance Time Scroll"),
(188600051, 1, 750, 1, 21, 0, 0, 0, 1, "Ordalie Empyreenne", "Instance Time Scroll"),
(188600052, 1, 750, 1, 21, 0, 0, 0, 1, "Ordalie Solitaire", "Instance Time Scroll"),
(188600059, 1, 1500, 1, 21, 0, 0, 0, 1, "Brise-Ecume Solo", "Instance Time Scroll"),
(188600075, 1, 1500, 1, 21, 0, 0, 0, 1, "Tahmes", "Instance Time Scroll"),
(188600074, 1, 1500, 1, 21, 0, 0, 0, 1, "Forteresse Celeste d Aturam", "Instance Time Scroll"),
(188600073, 1, 1500, 1, 21, 0, 0, 0, 1, "Base de Rentus", "Instance Time Scroll"),
(188600072, 1, 1500, 1, 21, 0, 0, 0, 1, "Manoir d Argent", "Instance Time Scroll"),
(188600071, 1, 1500, 1, 21, 0, 0, 0, 1, "Foret d Elementis", "Instance Time Scroll"),
(188600080, 1, 750, 1, 21, 0, 0, 0, 1, "Caverne de Draupnir", "Instance Time Scroll"),
(188600091, 1, 1000, 1, 21, 0, 0, 0, 1, "Grotte de Padmarashka", "Instance Time Scroll"),
(188600092, 1, 1500, 1, 21, 0, 0, 0, 1, "Tresor de Satra", "Instance Time Scroll"),
(188600140, 1, 2000, 1, 21, 0, 0, 0, 1, "Forteresse de Tiamat", "Instance Time Scroll"),
(188600141, 1, 2000, 1, 21, 0, 0, 0, 1, "Antre de Tiamat", "Instance Time Scroll"),
(188600199, 1, 2000, 1, 21, 0, 0, 0, 1, "Sepulture de l Empereur Shugo", "Instance Time Scroll"),
(188600204, 1, 2000, 1, 21, 0, 0, 0, 1, "Reliquat des abysses confinees", "Instance Time Scroll"),
(188600197, 1, 2500, 1, 21, 0, 0, 0, 1, "3 Instances Abyssales inferieures", "Instance Time Scroll"),
(188600198, 1, 4000, 1, 21, 0, 0, 0, 1, "Toutes Instances Abyssales Sup + Abysses confinees + Reliquat Abysses confinees + Tresor de satra", "Instance Time Scroll"),
(188600193, 1, 2000, 1, 21, 0, 0, 0, 1, "Toutes instances level 16 a 40", "Instance Time Scroll"),
(188600194, 1, 3000, 1, 21, 0, 0, 0, 1, "Toutes instances level 41 a 50", "Instance Time Scroll"),
(188600195, 1, 3500, 1, 21, 0, 0, 0, 1, "Toutes instances level 51 a 55", "Instance Time Scroll"),
(188600196, 1, 4000, 1, 21, 0, 0, 0, 1, "Toutes instances level 56 a 60", "Instance Time Scroll");
-- AP EXTRACTION
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(165005068, 1, 1250, 0, 26, 0, 0, 0, 1, "35% Abyss Gold Armor Extraction Tools", "AP Extraction"),
(165005070, 1, 1250, 0, 26, 0, 0, 0, 1, "35% Abyss Gold Wing Extraction Tools", "AP Extraction"),
(165005069, 1, 1250, 0, 26, 0, 0, 0, 1, "35% Abyss Gold Accessory Extraction Tools", "AP Extraction"),
(165005067, 1, 1250, 0, 26, 0, 0, 0, 1, "35% Abyss Gold Weapon Extraction Tools", "AP Extraction"),
(165005078, 1, 1500, 0, 26, 0, 0, 0, 1, "25% Abyss Eternal Armor Extraction Tools", "AP Extraction"),
(165005077, 1, 1500, 0, 26, 0, 0, 0, 1, "25% Abyss Eternal Weapon Extraction Tools", "AP Extraction"),
(165005073, 1, 2000, 0, 26, 0, 0, 0, 1, "35% Abyss Eternal Armor Extraction Tools", "AP Extraction"),
(165005072, 1, 2000, 0, 26, 0, 0, 0, 1, "35% Abyss Eternal Weapon Extraction Tools", "AP Extraction"),
(165005068, 1, 1250, 1, 26, 0, 0, 0, 1, "35% Abyss Gold Armor Extraction Tools", "AP Extraction"),
(165005070, 1, 1250, 1, 26, 0, 0, 0, 1, "35% Abyss Gold Wing Extraction Tools", "AP Extraction"),
(165005069, 1, 1250, 1, 26, 0, 0, 0, 1, "35% Abyss Gold Accessory Extraction Tools", "AP Extraction"),
(165005067, 1, 1250, 1, 26, 0, 0, 0, 1, "35% Abyss Gold Weapon Extraction Tools", "AP Extraction"),
(165005078, 1, 1500, 1, 26, 0, 0, 0, 1, "25% Abyss Eternal Armor Extraction Tools", "AP Extraction"),
(165005077, 1, 1500, 1, 26, 0, 0, 0, 1, "25% Abyss Eternal Weapon Extraction Tools", "AP Extraction"),
(165005073, 1, 2000, 1, 26, 0, 0, 0, 1, "35% Abyss Eternal Armor Extraction Tools", "AP Extraction"),
(165005072, 1, 2000, 1, 26, 0, 0, 0, 1, "35% Abyss Eternal Weapon Extraction Tools", "AP Extraction");
-- SKINS 3.0+
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(125045095, 1, 750, 0, 27, 0, 0, 0, 1, "Masque de cheval", "Skins 3.0+"),
(125040242, 1, 750, 0, 27, 0, 0, 0, 1, "Chapeau de Dragon a collerette", "Skins 3.0+"),
(125040240, 1, 750, 0, 27, 0, 0, 0, 1, "Chapeau de Mycellion", "Skins 3.0+"),
(125045071, 1, 750, 0, 27, 0, 0, 0, 1, "Epingle a cheveux agrementee d un chapeau en forme de fleur Reserve aux Femmes", "Skins 3.0+"),
(125045092, 1, 750, 0, 27, 0, 0, 0, 1, "Coiffure carree d origine", "Skins 3.0+"),
(110900402, 1, 750, 0, 27, 0, 0, 0, 1, "Robe majestueuse", "Skins 3.0+"),
(110900401, 1, 750, 0, 27, 0, 0, 0, 1, "Armure majestueuse", "Skins 3.0+"),
(110900400, 1, 750, 0, 27, 0, 0, 0, 1, "Armure lourde majestueuse", "Skins 3.0+"),
(110900404, 1, 750, 0, 27, 0, 0, 0, 1, "Costume a motif Leopard", "Skins 3.0+"),
(110900403, 1, 750, 0, 27, 0, 0, 0, 1, "Armures dorees", "Skins 3.0+"),
(110900381, 1, 750, 0, 27, 0, 0, 0, 1, "Uniforme de la cavalerie legere", "Skins 3.0+"),
(113000017, 1, 750, 0, 27, 0, 0, 0, 1, "Pantalon de la cavalerie legere", "Skins 3.0+"),
(112000005, 1, 750, 0, 27, 0, 0, 0, 1, "Epaulettes de la cavalerie legere", "Skins 3.0+"),
(114000053, 1, 750, 0, 27, 0, 0, 0, 1, "Chaussures de la cavalerie legere", "Skins 3.0+"),
(125045086, 1, 750, 0, 27, 0, 0, 0, 1, "Coiffe de la cavalerie legere", "Skins 3.0+"),
(110900384, 1, 750, 0, 27, 0, 0, 0, 1, "tenue de combat d assassin", "Skins 3.0+"),
(110900385, 1, 750, 0, 27, 0, 0, 0, 1, "uniforme d assassin", "Skins 3.0+"),
(110900399, 1, 750, 0, 27, 0, 0, 0, 1, "vetements de runes d ether", "Skins 3.0+"),
(110900340, 1, 750, 0, 27, 0, 0, 0, 1, "Costume pour couples adorables", "Skins 3.0+"),
(110900348, 1, 750, 0, 27, 0, 0, 0, 1, "Robe de mariee fringante/Costume fringant", "Skins 3.0+"),
(110900353, 1, 750, 0, 27, 0, 0, 0, 1, "Tenue d employee de maison decente", "Skins 3.0+"),
(110900357, 1, 750, 0, 27, 0, 0, 0, 1, "Jolie tenue d employee de maison", "Skins 3.0+"),
(110900344, 1, 750, 0, 27, 0, 0, 0, 1, "Style marin en vogue", "Skins 3.0+"),
(110900368, 1, 750, 0, 27, 0, 0, 0, 1, "Scaphandre de plongee dans les profondeurs marines", "Skins 3.0+"),
(110900351, 1, 750, 0, 27, 0, 0, 0, 1, "Costume citrouille d Halloween", "Skins 3.0+"),
(111000045, 1, 750, 0, 27, 0, 0, 0, 1, "Gants en citrouille d Halloween", "Skins 3.0+"),
(114000049, 1, 750, 0, 27, 0, 0, 0, 1, "Bottes en citrouille d Halloween", "Skins 3.0+"),
(125045046, 1, 750, 0, 27, 0, 0, 0, 1, "Chapeau en citrouille d Halloween", "Skins 3.0+"),
(125002032, 1, 750, 0, 27, 0, 0, 0, 1, "Epingle de cheveux de princesse ID", "Skins 3.0+"),
(125050030, 1, 750, 0, 27, 0, 0, 0, 1, "Chapeau de celibataire a la mode", "Skins 3.0+"),
(110900343, 1, 750, 0, 27, 0, 0, 0, 1, "Tenue de celibataire a la mode ", "Skins 3.0+"),
(110900259, 1, 750, 0, 27, 0, 0, 0, 1, "Habit de travail Shulack ", "Skins 3.0+"),
(110900341, 1, 750, 0, 27, 0, 0, 0, 1, "Tenue de celibataire", "Skins 3.0+"),
(125050028, 1, 750, 0, 27, 0, 0, 0, 1, "Chapeau de celibataire", "Skins 3.0+"),
(125045095, 1, 750, 1, 27, 0, 0, 0, 1, "Masque de cheval", "Skins 3.0+"),
(125040242, 1, 750, 1, 27, 0, 0, 0, 1, "Chapeau de Dragon a collerette", "Skins 3.0+"),
(125040240, 1, 750, 1, 27, 0, 0, 0, 1, "Chapeau de Mycellion", "Skins 3.0+"),
(125045071, 1, 750, 1, 27, 0, 0, 0, 1, "Epingle a cheveux agrementee d un chapeau en forme de fleur Reserve aux Femmes", "Skins 3.0+"),
(125045092, 1, 750, 1, 27, 0, 0, 0, 1, "Coiffure carree d origine", "Skins 3.0+"),
(110900402, 1, 750, 1, 27, 0, 0, 0, 1, "Robe majestueuse", "Skins 3.0+"),
(110900401, 1, 750, 1, 27, 0, 0, 0, 1, "Armure majestueuse", "Skins 3.0+"),
(110900400, 1, 750, 1, 27, 0, 0, 0, 1, "Armure lourde majestueuse", "Skins 3.0+"),
(110900404, 1, 750, 1, 27, 0, 0, 0, 1, "Costume a motif Leopard", "Skins 3.0+"),
(110900403, 1, 750, 1, 27, 0, 0, 0, 1, "Armures dorees", "Skins 3.0+"),
(110900381, 1, 750, 1, 27, 0, 0, 0, 1, "Uniforme de la cavalerie legere", "Skins 3.0+"),
(113000017, 1, 750, 1, 27, 0, 0, 0, 1, "Pantalon de la cavalerie legere", "Skins 3.0+"),
(112000005, 1, 750, 1, 27, 0, 0, 0, 1, "Epaulettes de la cavalerie legere", "Skins 3.0+"),
(114000053, 1, 750, 1, 27, 0, 0, 0, 1, "Chaussures de la cavalerie legere", "Skins 3.0+"),
(125045086, 1, 750, 1, 27, 0, 0, 0, 1, "Coiffe de la cavalerie legere", "Skins 3.0+"),
(110900384, 1, 750, 1, 27, 0, 0, 0, 1, "tenue de combat d assassin", "Skins 3.0+"),
(110900385, 1, 750, 1, 27, 0, 0, 0, 1, "uniforme d assassin", "Skins 3.0+"),
(110900399, 1, 750, 1, 27, 0, 0, 0, 1, "vetements de runes d ether", "Skins 3.0+"),
(110900340, 1, 750, 1, 27, 0, 0, 0, 1, "Costume pour couples adorables", "Skins 3.0+"),
(110900348, 1, 750, 1, 27, 0, 0, 0, 1, "Robe de mariee fringante/Costume fringant", "Skins 3.0+"),
(110900353, 1, 750, 1, 27, 0, 0, 0, 1, "Tenue d employee de maison decente", "Skins 3.0+"),
(110900357, 1, 750, 1, 27, 0, 0, 0, 1, "Jolie tenue d employee de maison", "Skins 3.0+"),
(110900344, 1, 750, 1, 27, 0, 0, 0, 1, "Style marin en vogue", "Skins 3.0+"),
(110900368, 1, 750, 1, 27, 0, 0, 0, 1, "Scaphandre de plongee dans les profondeurs marines", "Skins 3.0+"),
(110900351, 1, 750, 1, 27, 0, 0, 0, 1, "Costume citrouille d Halloween", "Skins 3.0+"),
(111000045, 1, 750, 1, 27, 0, 0, 0, 1, "Gants en citrouille d Halloween", "Skins 3.0+"),
(114000049, 1, 750, 1, 27, 0, 0, 0, 1, "Bottes en citrouille d Halloween", "Skins 3.0+"),
(125045046, 1, 750, 1, 27, 0, 0, 0, 1, "Chapeau en citrouille d Halloween", "Skins 3.0+"),
(125002032, 1, 750, 1, 27, 0, 0, 0, 1, "Epingle de cheveux de princesse ID", "Skins 3.0+"),
(125050030, 1, 750, 1, 27, 0, 0, 0, 1, "Chapeau de celibataire a la mode", "Skins 3.0+"),
(110900343, 1, 750, 1, 27, 0, 0, 0, 1, "Tenue de celibataire a la mode ", "Skins 3.0+"),
(110900259, 1, 750, 1, 27, 0, 0, 0, 1, "Habit de travail Shulack ", "Skins 3.0+"),
(110900341, 1, 750, 1, 27, 0, 0, 0, 1, "Tenue de celibataire", "Skins 3.0+"),
(125050028, 1, 750, 1, 27, 0, 0, 0, 1, "Chapeau de celibataire", "Skins 3.0+"),
(110900418, 1, 750, 0, 27, 0, 0, 0, 1, "Tenue Infirmiere", "Skins 3.0+"),
(110900419, 1, 750, 0, 27, 0, 0, 0, 1, "Tenue Infirmier", "Skins 3.0+"),
(125045128, 1, 500, 0, 27, 0, 0, 0, 1, "Chapeau Infirmiere", "Skins 3.0+"),
(125045129, 1, 500, 0, 27, 0, 0, 0, 1, "Chapeau Infirmier", "Skins 3.0+"),
(110900418, 1, 750, 1, 27, 0, 0, 0, 1, "Tenue Infirmiere", "Skins 3.0+"),
(110900419, 1, 750, 1, 27, 0, 0, 0, 1, "Tenue Infirmier", "Skins 3.0+"),
(125045128, 1, 500, 1, 27, 0, 0, 0, 1, "Chapeau Infirmiere", "Skins 3.0+"),
(125045129, 1, 500, 1, 27, 0, 0, 0, 1, "Chapeau Infirmier", "Skins 3.0+"),
(110900417, 1, 750, 1, 27, 0, 0, 0, 1, "Veste Sexy Infirmiere", "Skins 3.0+"),
(110900417, 1, 750, 0, 27, 0, 0, 0, 1, "Veste Sexy Infirmiere", "Skins 3.0+");
-- WEAPON 3.0+
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(100001462, 1, 750, 0, 28, 0, 0, 0, 1, "epee de runes d ether", "Weapon 3.0+"),
(100101108, 1, 750, 0, 28, 0, 0, 0, 1, "masse de runes d ether", "Weapon 3.0+"),
(100201271, 1, 750, 0, 28, 0, 0, 0, 1, "dague de ruines d ether", "Weapon 3.0+"),
(100501115, 1, 750, 0, 28, 0, 0, 0, 1, "orbe de runes d ether", "Weapon 3.0+"),
(100601196, 1, 750, 0, 28, 0, 0, 0, 1, "grimoire des runes d ether", "Weapon 3.0+"),
(100901124, 1, 750, 0, 28, 0, 0, 0, 1, "espadon de runes d ether", "Weapon 3.0+"),
(101301060, 1, 750, 0, 28, 0, 0, 0, 1, "lance de runes d ether", "Weapon 3.0+"),
(101501141, 1, 750, 0, 28, 0, 0, 0, 1, "baton de runes d ether", "Weapon 3.0+"),
(101701159, 1, 750, 0, 28, 0, 0, 0, 1, "arc de runes d ether", "Weapon 3.0+"),
(115001481, 1, 750, 0, 28, 0, 0, 0, 1, "bouclier de runes d ether", "Weapon 3.0+"),
(100001462, 1, 750, 1, 28, 0, 0, 0, 1, "epee de runes d ether", "Weapon 3.0+"),
(100101108, 1, 750, 1, 28, 0, 0, 0, 1, "masse de runes d ether", "Weapon 3.0+"),
(100201271, 1, 750, 1, 28, 0, 0, 0, 1, "dague de ruines d ether", "Weapon 3.0+"),
(100501115, 1, 750, 1, 28, 0, 0, 0, 1, "orbe de runes d ether", "Weapon 3.0+"),
(100601196, 1, 750, 1, 28, 0, 0, 0, 1, "grimoire des runes d ether", "Weapon 3.0+"),
(100901124, 1, 750, 1, 28, 0, 0, 0, 1, "espadon de runes d ether", "Weapon 3.0+"),
(101301060, 1, 750, 1, 28, 0, 0, 0, 1, "lance de runes d ether", "Weapon 3.0+"),
(101501141, 1, 750, 1, 28, 0, 0, 0, 1, "baton de runes d ether", "Weapon 3.0+"),
(101701159, 1, 750, 1, 28, 0, 0, 0, 1, "arc de runes d ether", "Weapon 3.0+"),
(115001481, 1, 750, 1, 28, 0, 0, 0, 1, "bouclier de runes d ether", "Weapon 3.0+"),
(100001463, 1, 750, 0, 28, 0, 0, 0, 1, "epee doree", "Weapon 3.0+"),
(100101109, 1, 750, 0, 28, 0, 0, 0, 1, "masse doree", "Weapon 3.0+"),
(100201272, 1, 750, 0, 28, 0, 0, 0, 1, "dague doree", "Weapon 3.0+"),
(100501116, 1, 750, 0, 28, 0, 0, 0, 1, "orbe doree", "Weapon 3.0+"),
(100601197, 1, 750, 0, 28, 0, 0, 0, 1, "grimoire doree", "Weapon 3.0+"),
(100901125, 1, 750, 0, 28, 0, 0, 0, 1, "espadon doree", "Weapon 3.0+"),
(101301061, 1, 750, 0, 28, 0, 0, 0, 1, "lance doree", "Weapon 3.0+"),
(101501142, 1, 750, 0, 28, 0, 0, 0, 1, "baton doree", "Weapon 3.0+"),
(101701160, 1, 750, 0, 28, 0, 0, 0, 1, "arc doree", "Weapon 3.0+"),
(115001482, 1, 750, 0, 28, 0, 0, 0, 1, "bouclier doree", "Weapon 3.0+"),
(100001463, 1, 750, 1, 28, 0, 0, 0, 1, "epee doree", "Weapon 3.0+"),
(100101109, 1, 750, 1, 28, 0, 0, 0, 1, "masse doree", "Weapon 3.0+"),
(100201272, 1, 750, 1, 28, 0, 0, 0, 1, "dague doree", "Weapon 3.0+"),
(100501116, 1, 750, 1, 28, 0, 0, 0, 1, "orbe doree", "Weapon 3.0+"),
(100601197, 1, 750, 1, 28, 0, 0, 0, 1, "grimoire doree", "Weapon 3.0+"),
(100901125, 1, 750, 1, 28, 0, 0, 0, 1, "espadon doree", "Weapon 3.0+"),
(101301061, 1, 750, 1, 28, 0, 0, 0, 1, "lance doree", "Weapon 3.0+"),
(101501142, 1, 750, 1, 28, 0, 0, 0, 1, "baton doree", "Weapon 3.0+"),
(101701160, 1, 750, 1, 28, 0, 0, 0, 1, "arc doree", "Weapon 3.0+"),
(115001482, 1, 750, 1, 28, 0, 0, 0, 1, "bouclier doree", "Weapon 3.0+");
-- AMULET AP/DROP BOOST
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(169620071, 1, 500, 0, 23, 0, 0, 0, 1, "AP Boost - 10%", "AP Boost"),
(169620070, 1, 750, 0, 23, 0, 0, 0, 1, "AP Boost - 20%", "AP Boost"),
(169620069, 1, 1000, 0, 23, 0, 0, 0, 1, "AP Boost - 30%", "AP Boost"),
(169620068, 1, 1250, 0, 23, 0, 0, 0, 1, "AP Boost - 40%", "AP Boost"),
(169620067, 1, 1500, 0, 23, 0, 0, 0, 1, "AP Boost - 50%", "AP Boost"),
(169625004, 1, 150, 0, 23, 0, 0, 0, 1, "XP & Drop Boost 100%", "XP & Drop Boost"),
(169620052, 1, 500, 0, 23, 0, 0, 0, 1, "Drop Boost - 10%", "Drop Boost"),
(169620053, 1, 750, 0, 23, 0, 0, 0, 1, "Drop Boost - 20%", "Drop Boost"),
(169620054, 1, 1000, 0, 23, 0, 0, 0, 1, "Drop Boost - 30%", "Drop Boost"),
(169620071, 1, 500, 1, 23, 0, 0, 0, 1, "AP Boost - 10%", "AP Boost"),
(169620070, 1, 750, 1, 23, 0, 0, 0, 1, "AP Boost - 20%", "AP Boost"),
(169620069, 1, 1000, 1, 23, 0, 0, 0, 1, "AP Boost - 30%", "AP Boost"),
(169620068, 1, 1250, 1, 23, 0, 0, 0, 1, "AP Boost - 40%", "AP Boost"),
(169620067, 1, 1500, 1, 23, 0, 0, 0, 1, "AP Boost - 50%", "AP Boost"),
(169625004, 1, 150, 1, 23, 0, 0, 0, 1, "XP & Drop Boost 100%", "XP & Drop Boost"),
(169620052, 1, 500, 1, 23, 0, 0, 0, 1, "Drop Boost - 10%", "Drop Boost"),
(169620053, 1, 750, 1, 23, 0, 0, 0, 1, "Drop Boost - 20%", "Drop Boost"),
(169620054, 1, 1000, 1, 23, 0, 0, 0, 1, "Drop Boost - 30%", "Drop Boost"),
(169620089, 1, 500, 0, 23, 0, 0, 0, 1, "Craft Boost - 50%", "Craft Boost"),
(169620088, 1, 750, 0, 23, 0, 0, 0, 1, "Craft Boost - 100%", "Craft Boost"),
(169620090, 1, 1000, 0, 23, 0, 0, 0, 1, "Craft Boost - 200%", "Craft Boost"),
(169620083, 1, 500, 0, 23, 0, 0, 0, 1, "Gather Boost - 50%", "Recolte Boost"),
(169620082, 1, 750, 0, 23, 0, 0, 0, 1, "Gather Boost - 100%", "Recolte Boost"),
(169620081, 1, 1000, 0, 23, 0, 0, 0, 1, "Gather Boost - 200%", "Recolte Boost"),
(169620089, 1, 500, 1, 23, 0, 0, 0, 1, "Craft Boost - 50%", "Craft Boost"),
(169620088, 1, 750, 1, 23, 0, 0, 0, 1, "Craft Boost - 100%", "Craft Boost"),
(169620090, 1, 1000, 1, 23, 0, 0, 0, 1, "Craft Boost - 200%", "Craft Boost"),
(169620083, 1, 500, 1, 23, 0, 0, 0, 1, "Gather Boost - 50%", "Recolte Boost"),
(169620082, 1, 750, 1, 23, 0, 0, 0, 1, "Gather Boost - 100%", "Recolte Boost"),
(169620081, 1, 1000, 1, 23, 0, 0, 0, 1, "Gather Boost - 200%", "Recolte Boost");
-- SUMMONING STONE
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(164002190, 1, 750, 0, 29, 0, 0, 0, 1, "Summoning Stone: Courier (Personal)", "Invocation"),
(164002191, 1, 750, 0, 29, 0, 0, 0, 1, "Summoning Stone: Courier (Group)", "Invocation"),
(164002192, 1, 750, 0, 29, 0, 0, 0, 1, "Summoning Stone: Trade Broker (Personal)", "Invocation"),
(164002193, 1, 750, 0, 29, 0, 0, 0, 1, "Summoning Stone: Trade Broker (Group)", "Invocation"),
(164002196, 1, 750, 0, 29, 0, 0, 0, 1, "Summoning Stone: General Goods Merchant (Personal)", "Invocation"),
(164002197, 1, 750, 0, 29, 0, 0, 0, 1, "Summoning Stone: General Goods Merchant (Group)", "Invocation"),
(164002200, 1, 750, 0, 29, 0, 0, 0, 1, "Summoning Stone: Warehouse Manager (Personal)", "Invocation"),
(164002201, 1, 750, 0, 29, 0, 0, 0, 1, "Summoning Stone: Warehouse Manager (Group)", "Invocation"),
(164002190, 1, 750, 1, 29, 0, 0, 0, 1, "Summoning Stone: Courier (Personal)", "Invocation"),
(164002191, 1, 750, 1, 29, 0, 0, 0, 1, "Summoning Stone: Courier (Group)", "Invocation"),
(164002192, 1, 750, 1, 29, 0, 0, 0, 1, "Summoning Stone: Trade Broker (Personal)", "Invocation"),
(164002193, 1, 750, 1, 29, 0, 0, 0, 1, "Summoning Stone: Trade Broker (Group)", "Invocation"),
(164002196, 1, 750, 1, 29, 0, 0, 0, 1, "Summoning Stone: General Goods Merchant (Personal)", "Invocation"),
(164002197, 1, 750, 1, 29, 0, 0, 0, 1, "Summoning Stone: General Goods Merchant (Group)", "Invocation"),
(164002200, 1, 750, 1, 29, 0, 0, 0, 1, "Summoning Stone: Warehouse Manager (Personal)", "Invocation"),
(164002201, 1, 750, 1, 29, 0, 0, 0, 1, "Summoning Stone: Warehouse Manager (Group)", "Invocation");
-- MOTION CARD
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(188500009, 1, 500, 2, 30, 0, 0, 0, 1, "New Concept Shop Sign", "Motion Card");

-- 4.0 NEW COSTUMES
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(110900420, 1, 500, 3, 31, 0, 0, 0, 1, "cool summer look", "Costumes 4.0"),
(110900507, 1, 500, 3, 31, 0, 0, 0, 1, "Aeiatte's cutie costume", "Costumes 4.0"),
(110900422, 1, 500, 3, 31, 0, 0, 0, 1, "Classy Gray cat suit", "Costumes 4.0"),
(110900424, 1, 500, 3, 31, 0, 0, 0, 1, "Classy Gray rabbit suit", "Costumes 4.0"),
(110900426, 1, 500, 3, 31, 0, 0, 0, 1, "Classy Gray raccoon suit", "Costumes 4.0"),
(110900406, 1, 500, 3, 31, 0, 0, 0, 1, "Code blue", "Costumes 4.0"),
(110900405, 1, 500, 3, 31, 0, 0, 0, 1, "Red code", "Costumes 4.0"),
(110900442, 1, 500, 3, 31, 0, 0, 0, 1, "Colored snake costume", "Costumes 4.0"),
(110900427, 1, 500, 3, 31, 0, 0, 0, 1, "Cute rabbit outfit", "Costumes 4.0"),
(110900441, 1, 500, 3, 31, 0, 0, 0, 1, "Dotted snake costume", "Costumes 4.0"),
(110900407, 1, 500, 3, 31, 0, 0, 0, 1, "Emergency ensemble", "Costumes 4.0"),
(110900451, 1, 500, 3, 31, 0, 0, 0, 1, "Lightweight luxury", "Costumes 4.0"),
(110900421, 1, 500, 3, 31, 0, 0, 0, 1, "lovely pink cat suit", "Costumes 4.0"),
(110900423, 1, 500, 3, 31, 0, 0, 0, 1, " Lovely pink rabbit suit", "Costumes 4.0"),
(110900425, 1, 500, 3, 31, 0, 0, 0, 1, "lovely pink raccoon suit", "Costumes 4.0"),
(110900414, 1, 500, 3, 31, 0, 0, 0, 1, "mau tee", "Costumes 4.0"),
(110900482, 1, 500, 3, 31, 0, 0, 0, 1, "nc dinos uniform", "Costumes 4.0"),
(110900475, 1, 500, 3, 31, 0, 0, 0, 1, "nightfall sleepwear", "Costumes 4.0"), 
(110900431, 1, 500, 3, 31, 0, 0, 0, 1, "rabbit suit", "Costumes 4.0"), 
(110900432, 1, 500, 3, 31, 0, 0, 0, 1, "raccoon suit", "Costumes 4.0"), 
(110900413, 1, 500, 3, 31, 0, 0, 0, 1, "raksha tee", "Costumes 4.0"), 
(110900443, 1, 500, 3, 31, 0, 0, 0, 1, "realistic snake costume", "Costumes 4.0"), 
(110900408, 1, 500, 3, 31, 0, 0, 0, 1, "spiffy look", "Costumes 4.0"), 
(110900447, 1, 500, 3, 31, 0, 0, 0, 1, "spotted beachwear", "Costumes 4.0"),
(110900448, 1, 500, 3, 31, 0, 0, 0, 1, "spotted one piece", "Costumes 4.0"),
(110900428, 1, 500, 3, 31, 0, 0, 0, 1, "striped cat suit", "Costumes 4.0"),
(110900468, 1, 500, 3, 31, 0, 0, 0, 1, "sunrise sleepwear", "Costumes 4.0"),
(110900412, 1, 500, 3, 31, 0, 0, 0, 1, "tiamat tee", "Costumes 4.0");
-- 4.0 NEW HATS
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(125045160, 1, 500, 3, 32, 0, 0, 0, 1, "[Event] Bear ear headband", "hat 4.0"),
(125045161, 1, 500, 3, 32, 0, 0, 0, 1, "[Event] Cat hat", "hat 4.0"),
(125045155, 1, 500, 3, 32, 0, 0, 0, 1, "[event] egg hairpin", "hat 4.0"),
(152045159, 1, 500, 3, 32, 0, 0, 0, 1, "[Event] heart balloon headband", "hat 4.0"),
(152045154, 1, 500, 3, 32, 0, 0, 0, 1, "[Event] meon hairpin", "hat 4.0"),
(125045191, 1, 500, 3, 32, 0, 0, 0, 1, "[Event] NC dinos cap", "hat 4.0"),
(152045158, 1, 500, 3, 32, 0, 0, 0, 1, "[Event] Tulip headband", "hat 4.0"),
(125045156, 1, 500, 3, 32, 0, 0, 0, 1, "[Event] Vinna hairpin", "hat 4.0"),
(125045157, 1, 500, 3, 32, 0, 0, 0, 1, "[Event] wiki hairpin", "hat 4.0"),
(125045137, 1, 500, 3, 32, 0, 0, 0, 1, "Classy gray cat hat", "hat 4.0"),
(125045139, 1, 500, 3, 32, 0, 0, 0, 1, "Classy gray rabbit hat", "hat 4.0"),
(125045141, 1, 500, 3, 32, 0, 0, 0, 1, "Classy Gray raccoon hat", "hat 4.0"),
(125050046, 1, 500, 3, 32, 0, 0, 0, 1, "cute rabbit hat", "hat 4.0"),
(125045144, 1, 500, 3, 32, 0, 0, 0, 1, "cute raccoon hat", "hat 4.0"),
(125045124, 1, 500, 3, 32, 0, 0, 0, 1, "emergency ensemble headband", "hat 4.0"),
(125300045, 1, 500, 3, 32, 0, 0, 0, 1, "greenkeeper's hat", "hat 4.0"),
(125050040, 1, 500, 3, 32, 0, 0, 0, 1, "head nurse's cap", "hat 4.0"),
(125045135, 1, 500, 3, 32, 0, 0, 0, 1, "lazy cat hat", "hat 4.0"),
(125045136, 1, 500, 3, 32, 0, 0, 0, 1, "lovely pink cat hat", "hat 4.0"),
(125045138, 1, 500, 3, 32, 0, 0, 0, 1, "lovely pink rabbit hat", "hat 4.0"),
(125045140, 1, 500, 3, 32, 0, 0, 0, 1, "lovely pink raccoon hat", "hat 4.0"),
(125050039, 1, 500, 3, 32, 0, 0, 0, 1, "nurse trainee's cap", "hat 4.0"),
(125045164, 1, 500, 3, 32, 0, 0, 0, 1, "rattan sunhat", "hat 4.0"),
(125045142, 1, 500, 3, 32, 0, 0, 0, 1, "Striped cat head", "hat 4.0"),
(125045162, 1, 500, 3, 32, 0, 0, 0, 1, "summer flower", "hat 4.0"),
(125045163, 1, 500, 3, 32, 0, 0, 0, 1, "sun cap", "hat 4.0");
-- 4.0 NEW PET
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(190070010, 1, 500, 3, 33, 0, 0, 0, 1, "IU", "pets 4.0"),
(190070004, 1, 500, 3, 33, 0, 0, 0, 1, "Su-Ro Kim Summoning Lamp", "pets 4.0"),
(190070005, 1, 500, 3, 33, 0, 0, 0, 1, "Shin-Young Kim Summoning Lamp", "pets 4.0");
-- 4.0 NEW WEAPONS
INSERT INTO `ingameshop` (`item_id`, `item_count`, `item_price`, `category`, `sub_category`, `list`, `sales_ranking`, `item_type`, `gift`, `title_description`, `description`) VALUES
(101801048, 1, 500, 3, 34, 0, 0, 0, 1, "Event] balaur claw pistol skin", "weapon 4.0"),
(102001070, 1, 500, 3, 34, 0, 0, 0, 1, "[Event] butterfly harp skin", "weapon 4.0"),
(102001071, 1, 500, 3, 34, 0, 0, 0, 1, "[Event] chilling harp skin", "weapon 4.0"),
(102001072, 1, 500, 3, 34, 0, 0, 0, 1, "[Event] floating harp skin", "weapon 4.0"),
(101801080, 1, 500, 3, 34, 0, 0, 0, 1, "[Event] floating pistol skin", "weapon 4.0"),
(101801047, 1, 500, 3, 34, 0, 0, 0, 1, "[Event] mookie pistol skin", "weapon 4.0"),
(102001080, 1, 500, 3, 34, 0, 0, 0, 1, "[Event] popstar harp skin", "weapon 4.0"),
(1020011069, 1, 500, 3, 34, 0, 0, 0, 1, "[Event] radiant harp skin", "weapon 4.0"),
(101801077, 1, 500, 3, 34, 0, 0, 0, 1, "[Event] radiant pistol skin", "weapon 4.0"),
(101801076, 1, 500, 3, 34, 0, 0, 0, 1, "[Event] woods pistol skin", "weapon 4.0");ALTER TABLE `legions`
ADD COLUMN `description`  varchar(255) NOT NULL DEFAULT '' AFTER `world_owner`,
ADD COLUMN `joinType`  int(1) NOT NULL DEFAULT 0 AFTER `description`,
ADD COLUMN `minJoinLevel`  int(3) NOT NULL DEFAULT 0 AFTER `joinType`;

ALTER TABLE `players`
ADD COLUMN `joinRequestLegionId`  int(11) NOT NULL DEFAULT 0 AFTER `rewarded_pass`,
ADD COLUMN `joinRequestState`  enum('NONE','DENIED','ACCEPTED') NOT NULL DEFAULT 'NONE' AFTER `joinRequestLegionId`;

CREATE TABLE `legion_join_requests` (
`legionId`  int(11) NOT NULL DEFAULT 0 ,
`playerId`  int(11) NOT NULL DEFAULT 0 ,
`playerName`  varchar(64) NOT NULL DEFAULT '' ,
`playerClassId`  int(2) NOT NULL DEFAULT 0 ,
`playerRaceId`  int(2) NOT NULL DEFAULT 0 ,
`playerLevel`  int(4) NOT NULL DEFAULT 0 ,
`playerGenderId`  int(2) NOT NULL DEFAULT 0 ,
`joinRequestMsg`  varchar(40) NOT NULL DEFAULT '' ,
`date`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
PRIMARY KEY (`legionId`, `playerId`)
)
;

ALTER TABLE `mail`
MODIFY COLUMN `mail_title`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `sender_name`;-- ----------------------------
-- Table structure for `myshop`
-- ----------------------------
DROP TABLE IF EXISTS `myshop`;
CREATE TABLE IF NOT EXISTS `myshop` (
  `object_id` int(11) NOT NULL auto_increment,
  `item` int(11) NOT NULL,
  `nb` bigint(13) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;DELETE FROM `player_passports`
WHERE `passport_id` >= 14 AND `passport_id` <= 39;DROP TABLE IF EXISTS `player_passports`;
CREATE TABLE `player_passports` (
`account_id`  int(11) NOT NULL ,
`passport_id`  int(11) NOT NULL ,
`stamps`  int(11) NOT NULL DEFAULT 0 ,
`last_stamp`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
`rewarded`  tinyint(1) NOT NULL DEFAULT 0 ,
UNIQUE INDEX `account_passport` USING BTREE (`account_id`, `passport_id`) 
)
ENGINE=InnoDB
;DELETE FROM `player_quests`
WHERE `quest_id` >= 10070 AND `quest_id` <= 10073;
DELETE FROM `player_quests`
WHERE `quest_id` >= 20070 AND `quest_id` <= 20073;