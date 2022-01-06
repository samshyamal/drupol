/*
SQLyog Community v13.1.1 (64 bit)
MySQL - 5.7.23-log : Database - wweave
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`wweave` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `wweave`;

/*Table structure for table `actions` */

DROP TABLE IF EXISTS `actions`;

CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';

/*Data for the table `actions` */

LOCK TABLES `actions` WRITE;

insert  into `actions`(`aid`,`type`,`callback`,`parameters`,`label`) values 
('node_make_sticky_action','node','node_make_sticky_action','','Make content sticky'),
('node_make_unsticky_action','node','node_make_unsticky_action','','Make content unsticky'),
('node_promote_action','node','node_promote_action','','Promote content to front page'),
('node_publish_action','node','node_publish_action','','Publish content'),
('node_save_action','node','node_save_action','','Save content'),
('node_unpromote_action','node','node_unpromote_action','','Remove content from front page'),
('node_unpublish_action','node','node_unpublish_action','','Unpublish content'),
('system_block_ip_action','user','system_block_ip_action','','Ban IP address of current user'),
('user_block_user_action','user','user_block_user_action','','Block current user');

UNLOCK TABLES;

/*Table structure for table `apachesolr_environment` */

DROP TABLE IF EXISTS `apachesolr_environment`;

CREATE TABLE `apachesolr_environment` (
  `env_id` varchar(64) NOT NULL COMMENT 'Unique identifier for the environment',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Human-readable name for the server',
  `url` varchar(1000) NOT NULL COMMENT 'Full url for the server',
  `service_class` varchar(255) NOT NULL DEFAULT '' COMMENT 'Optional class name to use for connection',
  PRIMARY KEY (`env_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The Solr search environment table.';

/*Data for the table `apachesolr_environment` */

LOCK TABLES `apachesolr_environment` WRITE;

insert  into `apachesolr_environment`(`env_id`,`name`,`url`,`service_class`) values 
('solr','localhost server','http://localhost:8983/solr','');

UNLOCK TABLES;

/*Table structure for table `apachesolr_environment_variable` */

DROP TABLE IF EXISTS `apachesolr_environment_variable`;

CREATE TABLE `apachesolr_environment_variable` (
  `env_id` varchar(64) NOT NULL COMMENT 'Unique identifier for the environment',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`env_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable values for each Solr search environment.';

/*Data for the table `apachesolr_environment_variable` */

LOCK TABLES `apachesolr_environment_variable` WRITE;

insert  into `apachesolr_environment_variable`(`env_id`,`name`,`value`) values 
('solr','apachesolr_index_last','a:0:{}'),
('solr','apachesolr_index_updated','i:0;'),
('solr','apachesolr_last_optimize','i:1549340252;');

UNLOCK TABLES;

/*Table structure for table `apachesolr_index_bundles` */

DROP TABLE IF EXISTS `apachesolr_index_bundles`;

CREATE TABLE `apachesolr_index_bundles` (
  `env_id` varchar(64) NOT NULL COMMENT 'The name of the environment.',
  `entity_type` varchar(32) NOT NULL COMMENT 'The type of entity.',
  `bundle` varchar(128) NOT NULL COMMENT 'The bundle to index.',
  PRIMARY KEY (`env_id`,`entity_type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Records what bundles we should be indexing for a given...';

/*Data for the table `apachesolr_index_bundles` */

LOCK TABLES `apachesolr_index_bundles` WRITE;

insert  into `apachesolr_index_bundles`(`env_id`,`entity_type`,`bundle`) values 
('solr','node','blog');

UNLOCK TABLES;

/*Table structure for table `apachesolr_index_entities` */

DROP TABLE IF EXISTS `apachesolr_index_entities`;

CREATE TABLE `apachesolr_index_entities` (
  `entity_type` varchar(32) NOT NULL COMMENT 'The type of entity.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The primary identifier for an entity.',
  `bundle` varchar(128) NOT NULL COMMENT 'The bundle to which this entity belongs.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the entity should be in the index.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when an entity was changed.',
  PRIMARY KEY (`entity_id`,`entity_type`),
  KEY `bundle_changed` (`bundle`,`changed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores a record of when an entity changed to determine if...';

/*Data for the table `apachesolr_index_entities` */

LOCK TABLES `apachesolr_index_entities` WRITE;

UNLOCK TABLES;

/*Table structure for table `apachesolr_index_entities_node` */

DROP TABLE IF EXISTS `apachesolr_index_entities_node`;

CREATE TABLE `apachesolr_index_entities_node` (
  `entity_type` varchar(32) NOT NULL COMMENT 'The type of entity.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The primary identifier for an entity.',
  `bundle` varchar(128) NOT NULL COMMENT 'The bundle to which this entity belongs.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the entity should be in the index.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when an entity was changed.',
  PRIMARY KEY (`entity_id`),
  KEY `bundle_changed` (`bundle`,`changed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores a record of when an entity changed to determine if...';

/*Data for the table `apachesolr_index_entities_node` */

LOCK TABLES `apachesolr_index_entities_node` WRITE;

UNLOCK TABLES;

/*Table structure for table `authmap` */

DROP TABLE IF EXISTS `authmap`;

CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`),
  KEY `uid_module` (`uid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';

/*Data for the table `authmap` */

LOCK TABLES `authmap` WRITE;

UNLOCK TABLES;

/*Table structure for table `batch` */

DROP TABLE IF EXISTS `batch`;

CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';

/*Data for the table `batch` */

LOCK TABLES `batch` WRITE;

UNLOCK TABLES;

/*Table structure for table `block` */

DROP TABLE IF EXISTS `block`;

CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';

/*Data for the table `block` */

LOCK TABLES `block` WRITE;

insert  into `block`(`bid`,`module`,`delta`,`theme`,`status`,`weight`,`region`,`custom`,`visibility`,`pages`,`title`,`cache`) values 
(1,'system','main','bartik',1,0,'content',0,0,'','',-1),
(2,'user','login','bartik',1,0,'sidebar_first',0,0,'','',-1),
(3,'system','navigation','bartik',1,0,'sidebar_first',0,0,'','',-1),
(4,'system','management','bartik',1,1,'sidebar_first',0,0,'','',-1),
(5,'system','help','bartik',1,0,'help',0,0,'','',-1),
(6,'node','syndicate','bartik',0,0,'-1',0,0,'','',-1),
(7,'node','recent','bartik',1,0,'dashboard_inactive',0,0,'','',1),
(8,'system','powered-by','bartik',0,10,'-1',0,0,'','',-1),
(9,'system','user-menu','bartik',0,0,'-1',0,0,'','',-1),
(10,'system','main-menu','bartik',0,0,'-1',0,0,'','',-1),
(11,'user','new','bartik',1,0,'dashboard_inactive',0,0,'','',1),
(12,'user','online','bartik',1,0,'dashboard_inactive',0,0,'','',-1),
(13,'system','main','wweave',1,0,'content',0,0,'','',-1),
(14,'user','login','wweave',1,0,'content',0,0,'','',-1),
(15,'system','navigation','wweave',1,0,'content',0,0,'','',-1),
(16,'system','management','wweave',1,1,'content',0,0,'','',-1),
(17,'system','help','wweave',1,0,'content',0,0,'','',-1),
(18,'node','syndicate','wweave',0,0,'-1',0,0,'','',-1),
(19,'node','recent','wweave',1,0,'dashboard_inactive',0,0,'','',1),
(20,'system','powered-by','wweave',0,10,'-1',0,0,'','',-1),
(21,'system','user-menu','wweave',0,0,'-1',0,0,'','',-1),
(22,'system','main-menu','wweave',0,0,'-1',0,0,'','',-1),
(23,'user','new','wweave',1,0,'dashboard_inactive',0,0,'','',1),
(24,'user','online','wweave',1,0,'dashboard_inactive',0,0,'','',-1),
(25,'blog','recent','bartik',1,0,'dashboard_inactive',0,0,'','',1),
(26,'devel_node_access','dna_node','bartik',1,0,'footer',0,0,'','',-1),
(27,'devel_node_access','dna_user','bartik',0,0,'-1',0,0,'','',-1),
(28,'locale','language','bartik',0,0,'-1',0,0,'','',-1),
(29,'menu','devel','bartik',0,0,'-1',0,0,'','',-1),
(30,'devel','execute_php','bartik',0,0,'-1',0,0,'','',-1),
(31,'devel','switch_user','bartik',0,0,'-1',0,0,'','',-1),
(32,'blog','recent','wweave',1,0,'dashboard_inactive',0,0,'','',1),
(33,'devel_node_access','dna_node','wweave',0,0,'-1',0,0,'','',-1),
(34,'devel_node_access','dna_user','wweave',0,0,'-1',0,0,'','',-1),
(35,'locale','language','wweave',0,0,'-1',0,0,'','',-1),
(36,'menu','devel','wweave',0,0,'-1',0,0,'','',-1),
(37,'devel','execute_php','wweave',0,0,'-1',0,0,'','',-1),
(38,'devel','switch_user','wweave',0,0,'-1',0,0,'','',-1),
(39,'blog','recent','seven',1,0,'dashboard_inactive',0,0,'','',1),
(40,'devel','execute_php','seven',0,0,'-1',0,0,'','',-1),
(41,'devel','switch_user','seven',0,0,'-1',0,0,'','',-1),
(42,'devel_node_access','dna_node','seven',1,0,'content',0,0,'','',-1),
(43,'devel_node_access','dna_user','seven',0,0,'-1',0,0,'','',-1),
(44,'locale','language','seven',0,0,'-1',0,0,'','',-1),
(45,'menu','devel','seven',0,0,'-1',0,0,'','',-1),
(46,'node','recent','seven',1,0,'dashboard_inactive',0,0,'','',1),
(47,'node','syndicate','seven',0,0,'-1',0,0,'','',-1),
(48,'system','help','seven',1,0,'help',0,0,'','',-1),
(49,'system','main','seven',1,0,'content',0,0,'','',-1),
(50,'system','main-menu','seven',0,0,'-1',0,0,'','',-1),
(51,'system','management','seven',1,1,'content',0,0,'','',-1),
(52,'system','navigation','seven',1,0,'content',0,0,'','',-1),
(53,'system','powered-by','seven',0,10,'-1',0,0,'','',-1),
(54,'system','user-menu','seven',0,0,'-1',0,0,'','',-1),
(55,'user','login','seven',1,0,'content',0,0,'','',-1),
(56,'user','new','seven',1,0,'dashboard_inactive',0,0,'','',1),
(57,'user','online','seven',1,0,'dashboard_inactive',0,0,'','',-1);

UNLOCK TABLES;

/*Table structure for table `block_custom` */

DROP TABLE IF EXISTS `block_custom`;

CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';

/*Data for the table `block_custom` */

LOCK TABLES `block_custom` WRITE;

UNLOCK TABLES;

/*Table structure for table `block_node_type` */

DROP TABLE IF EXISTS `block_node_type`;

CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';

/*Data for the table `block_node_type` */

LOCK TABLES `block_node_type` WRITE;

UNLOCK TABLES;

/*Table structure for table `block_role` */

DROP TABLE IF EXISTS `block_role`;

CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';

/*Data for the table `block_role` */

LOCK TABLES `block_role` WRITE;

UNLOCK TABLES;

/*Table structure for table `blocked_ips` */

DROP TABLE IF EXISTS `blocked_ips`;

CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';

/*Data for the table `blocked_ips` */

LOCK TABLES `blocked_ips` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache` */

DROP TABLE IF EXISTS `cache`;

CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

/*Data for the table `cache` */

LOCK TABLES `cache` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_apachesolr` */

DROP TABLE IF EXISTS `cache_apachesolr`;

CREATE TABLE `cache_apachesolr` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for apachesolr to store Luke data and...';

/*Data for the table `cache_apachesolr` */

LOCK TABLES `cache_apachesolr` WRITE;

insert  into `cache_apachesolr`(`cid`,`data`,`expire`,`created`,`serialized`) values 
('apachesolr:environments','a:1:{s:4:\"solr\";a:6:{s:6:\"env_id\";s:4:\"solr\";s:4:\"name\";s:16:\"localhost server\";s:3:\"url\";s:26:\"http://localhost:8983/solr\";s:13:\"service_class\";s:0:\"\";s:13:\"index_bundles\";a:1:{s:4:\"node\";a:1:{i:0;s:4:\"blog\";}}s:4:\"conf\";a:3:{s:21:\"apachesolr_index_last\";a:0:{}s:24:\"apachesolr_index_updated\";i:0;s:24:\"apachesolr_last_optimize\";i:1549340252;}}}',0,1549344346,1);

UNLOCK TABLES;

/*Table structure for table `cache_block` */

DROP TABLE IF EXISTS `cache_block`;

CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';

/*Data for the table `cache_block` */

LOCK TABLES `cache_block` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_bootstrap` */

DROP TABLE IF EXISTS `cache_bootstrap`;

CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';

/*Data for the table `cache_bootstrap` */

LOCK TABLES `cache_bootstrap` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_field` */

DROP TABLE IF EXISTS `cache_field`;

CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Field module to store already built...';

/*Data for the table `cache_field` */

LOCK TABLES `cache_field` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_filter` */

DROP TABLE IF EXISTS `cache_filter`;

CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';

/*Data for the table `cache_filter` */

LOCK TABLES `cache_filter` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_form` */

DROP TABLE IF EXISTS `cache_form`;

CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';

/*Data for the table `cache_form` */

LOCK TABLES `cache_form` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_image` */

DROP TABLE IF EXISTS `cache_image`;

CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';

/*Data for the table `cache_image` */

LOCK TABLES `cache_image` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_menu` */

DROP TABLE IF EXISTS `cache_menu`;

CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';

/*Data for the table `cache_menu` */

LOCK TABLES `cache_menu` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_page` */

DROP TABLE IF EXISTS `cache_page`;

CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';

/*Data for the table `cache_page` */

LOCK TABLES `cache_page` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_path` */

DROP TABLE IF EXISTS `cache_path`;

CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';

/*Data for the table `cache_path` */

LOCK TABLES `cache_path` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache_update` */

DROP TABLE IF EXISTS `cache_update`;

CREATE TABLE `cache_update` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Update module to store information...';

/*Data for the table `cache_update` */

LOCK TABLES `cache_update` WRITE;

insert  into `cache_update`(`cid`,`data`,`expire`,`created`,`serialized`) values 
('available_releases::admin_menu','a:11:{s:5:\"title\";s:19:\"Administration menu\";s:10:\"short_name\";s:10:\"admin_menu\";s:4:\"type\";s:14:\"project_module\";s:11:\"api_version\";s:3:\"7.x\";s:17:\"recommended_major\";s:1:\"3\";s:16:\"supported_majors\";s:1:\"3\";s:13:\"default_major\";s:1:\"3\";s:14:\"project_status\";s:9:\"published\";s:4:\"link\";s:41:\"https://www.drupal.org/project/admin_menu\";s:5:\"terms\";s:0:\"\";s:8:\"releases\";a:7:{s:11:\"7.x-3.0-rc6\";a:15:{s:4:\"name\";s:22:\"admin_menu 7.x-3.0-rc6\";s:7:\"version\";s:11:\"7.x-3.0-rc6\";s:3:\"tag\";s:11:\"7.x-3.0-rc6\";s:13:\"version_major\";s:1:\"3\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/admin_menu/releases/7.x-3.0-rc6\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/admin_menu-7.x-3.0-rc6.tar.gz\";s:4:\"date\";s:10:\"1543859280\";s:6:\"mdhash\";s:32:\"91f08440f64fc2ddee565aab3198cb70\";s:8:\"filesize\";s:5:\"53905\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:11:\"7.x-3.0-rc5\";a:15:{s:4:\"name\";s:22:\"admin_menu 7.x-3.0-rc5\";s:7:\"version\";s:11:\"7.x-3.0-rc5\";s:3:\"tag\";s:11:\"7.x-3.0-rc5\";s:13:\"version_major\";s:1:\"3\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc5\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/admin_menu/releases/7.x-3.0-rc5\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/admin_menu-7.x-3.0-rc5.tar.gz\";s:4:\"date\";s:10:\"1419029280\";s:6:\"mdhash\";s:32:\"4f1a0c14001c880bd7eb170318b91303\";s:8:\"filesize\";s:5:\"53401\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:11:\"7.x-3.0-rc4\";a:15:{s:4:\"name\";s:22:\"admin_menu 7.x-3.0-rc4\";s:7:\"version\";s:11:\"7.x-3.0-rc4\";s:3:\"tag\";s:11:\"7.x-3.0-rc4\";s:13:\"version_major\";s:1:\"3\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/admin_menu/releases/7.x-3.0-rc4\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/admin_menu-7.x-3.0-rc4.tar.gz\";s:4:\"date\";s:10:\"1359651687\";s:6:\"mdhash\";s:32:\"3d8359538878723720fca6ddb2f82c7a\";s:8:\"filesize\";s:5:\"55064\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:11:\"7.x-3.0-rc3\";a:15:{s:4:\"name\";s:22:\"admin_menu 7.x-3.0-rc3\";s:7:\"version\";s:11:\"7.x-3.0-rc3\";s:3:\"tag\";s:11:\"7.x-3.0-rc3\";s:13:\"version_major\";s:1:\"3\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/admin_menu/releases/7.x-3.0-rc3\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/admin_menu-7.x-3.0-rc3.tar.gz\";s:4:\"date\";s:10:\"1337292349\";s:6:\"mdhash\";s:32:\"86b659c35823d541354179eccbfdc2d4\";s:8:\"filesize\";s:5:\"50950\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:11:\"7.x-3.0-rc2\";a:15:{s:4:\"name\";s:22:\"admin_menu 7.x-3.0-rc2\";s:7:\"version\";s:11:\"7.x-3.0-rc2\";s:3:\"tag\";s:11:\"7.x-3.0-rc2\";s:13:\"version_major\";s:1:\"3\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/admin_menu/releases/7.x-3.0-rc2\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/admin_menu-7.x-3.0-rc2.tar.gz\";s:4:\"date\";s:10:\"1335198071\";s:6:\"mdhash\";s:32:\"47761c79c351697f295d933b85441328\";s:8:\"filesize\";s:5:\"49988\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:11:\"7.x-3.0-rc1\";a:15:{s:4:\"name\";s:22:\"admin_menu 7.x-3.0-rc1\";s:7:\"version\";s:11:\"7.x-3.0-rc1\";s:3:\"tag\";s:11:\"7.x-3.0-rc1\";s:13:\"version_major\";s:1:\"3\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/admin_menu/releases/7.x-3.0-rc1\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/admin_menu-7.x-3.0-rc1.tar.gz\";s:4:\"date\";s:10:\"1294378871\";s:6:\"mdhash\";s:32:\"9d0cfb26adda4da7bd309bdf5be305a0\";s:8:\"filesize\";s:5:\"70961\";s:5:\"files\";s:0:\"\";s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";s:5:\"terms\";a:0:{}}s:11:\"7.x-3.x-dev\";a:14:{s:4:\"name\";s:22:\"admin_menu 7.x-3.x-dev\";s:7:\"version\";s:11:\"7.x-3.x-dev\";s:3:\"tag\";s:7:\"7.x-3.x\";s:13:\"version_major\";s:1:\"3\";s:13:\"version_extra\";s:3:\"dev\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/admin_menu/releases/7.x-3.x-dev\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/admin_menu-7.x-3.x-dev.tar.gz\";s:4:\"date\";s:10:\"1545336480\";s:6:\"mdhash\";s:32:\"0783fc65da6a23a43e3d59f30b75d439\";s:8:\"filesize\";s:5:\"55114\";s:5:\"files\";s:0:\"\";s:8:\"security\";s:59:\"Dev releases are not covered by Drupal security advisories.\";s:5:\"terms\";a:0:{}}}}',1549430808,1549344399,1),
('available_releases::apachesolr','a:11:{s:5:\"title\";s:18:\"Apache Solr Search\";s:10:\"short_name\";s:10:\"apachesolr\";s:4:\"type\";s:14:\"project_module\";s:11:\"api_version\";s:3:\"7.x\";s:17:\"recommended_major\";s:1:\"1\";s:16:\"supported_majors\";s:1:\"1\";s:13:\"default_major\";s:1:\"1\";s:14:\"project_status\";s:9:\"published\";s:4:\"link\";s:41:\"https://www.drupal.org/project/apachesolr\";s:5:\"terms\";s:0:\"\";s:8:\"releases\";a:38:{s:8:\"7.x-1.11\";a:14:{s:4:\"name\";s:19:\"apachesolr 7.x-1.11\";s:7:\"version\";s:8:\"7.x-1.11\";s:3:\"tag\";s:8:\"7.x-1.11\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:2:\"11\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:59:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.11\";s:13:\"download_link\";s:64:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.11.tar.gz\";s:4:\"date\";s:10:\"1526662380\";s:6:\"mdhash\";s:32:\"66344c849ccdc378add58c944419e66d\";s:8:\"filesize\";s:6:\"264969\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:8:\"7.x-1.10\";a:14:{s:4:\"name\";s:19:\"apachesolr 7.x-1.10\";s:7:\"version\";s:8:\"7.x-1.10\";s:3:\"tag\";s:8:\"7.x-1.10\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:2:\"10\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:59:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.10\";s:13:\"download_link\";s:64:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.10.tar.gz\";s:4:\"date\";s:10:\"1520973180\";s:6:\"mdhash\";s:32:\"7c4799baecf6d7fa7b8981bff91bd2a4\";s:8:\"filesize\";s:6:\"264424\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.9\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.9\";s:7:\"version\";s:7:\"7.x-1.9\";s:3:\"tag\";s:7:\"7.x-1.9\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"9\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.9\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.9.tar.gz\";s:4:\"date\";s:10:\"1508966345\";s:6:\"mdhash\";s:32:\"28b850c0976d81c1ef2ad8c4c8af8e84\";s:8:\"filesize\";s:6:\"263544\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.8\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.8\";s:7:\"version\";s:7:\"7.x-1.8\";s:3:\"tag\";s:7:\"7.x-1.8\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"8\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.8\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.8.tar.gz\";s:4:\"date\";s:10:\"1449085446\";s:6:\"mdhash\";s:32:\"82e7ff73db6c11b95bcafcb13fa6d0a3\";s:8:\"filesize\";s:6:\"237087\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.7\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.7\";s:7:\"version\";s:7:\"7.x-1.7\";s:3:\"tag\";s:7:\"7.x-1.7\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"7\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.7\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.7.tar.gz\";s:4:\"date\";s:10:\"1409316831\";s:6:\"mdhash\";s:32:\"126f6e722b8d05b410afc6e66d09f06e\";s:8:\"filesize\";s:6:\"237083\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.6\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.6\";s:7:\"version\";s:7:\"7.x-1.6\";s:3:\"tag\";s:7:\"7.x-1.6\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.6\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.6.tar.gz\";s:4:\"date\";s:10:\"1384712304\";s:6:\"mdhash\";s:32:\"6d45171efdb17aa0efedf1f0d0b21257\";s:8:\"filesize\";s:6:\"232748\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.5\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.5\";s:7:\"version\";s:7:\"7.x-1.5\";s:3:\"tag\";s:7:\"7.x-1.5\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"5\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.5\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.5.tar.gz\";s:4:\"date\";s:10:\"1382562931\";s:6:\"mdhash\";s:32:\"166db27190df497325f8115465d50883\";s:8:\"filesize\";s:6:\"231857\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.4\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.4\";s:7:\"version\";s:7:\"7.x-1.4\";s:3:\"tag\";s:7:\"7.x-1.4\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.4\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.4.tar.gz\";s:4:\"date\";s:10:\"1374808868\";s:6:\"mdhash\";s:32:\"916555b6fe9af12112308951f99eb7a4\";s:8:\"filesize\";s:6:\"225782\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.3\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.3\";s:7:\"version\";s:7:\"7.x-1.3\";s:3:\"tag\";s:7:\"7.x-1.3\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.3\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.3.tar.gz\";s:4:\"date\";s:10:\"1370923255\";s:6:\"mdhash\";s:32:\"99414d373a4df3e7cba5978de1053b35\";s:8:\"filesize\";s:6:\"225427\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.2\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.2\";s:7:\"version\";s:7:\"7.x-1.2\";s:3:\"tag\";s:7:\"7.x-1.2\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.2\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.2.tar.gz\";s:4:\"date\";s:10:\"1365631829\";s:6:\"mdhash\";s:32:\"e7de90926df789fb86e09ade32acbc96\";s:8:\"filesize\";s:6:\"223779\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.1\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.1\";s:7:\"version\";s:7:\"7.x-1.1\";s:3:\"tag\";s:7:\"7.x-1.1\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.1\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.1.tar.gz\";s:4:\"date\";s:10:\"1350356169\";s:6:\"mdhash\";s:32:\"032a62f09bad5c816e92bcd58568efb7\";s:8:\"filesize\";s:6:\"181927\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.0\";a:14:{s:4:\"name\";s:18:\"apachesolr 7.x-1.0\";s:7:\"version\";s:7:\"7.x-1.0\";s:3:\"tag\";s:7:\"7.x-1.0\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:58:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0\";s:13:\"download_link\";s:63:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0.tar.gz\";s:4:\"date\";s:10:\"1350126667\";s:6:\"mdhash\";s:32:\"3c3815b585feb56ebc2c960077c64e12\";s:8:\"filesize\";s:6:\"181334\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:11:\"7.x-1.0-rc5\";a:15:{s:4:\"name\";s:22:\"apachesolr 7.x-1.0-rc5\";s:7:\"version\";s:11:\"7.x-1.0-rc5\";s:3:\"tag\";s:11:\"7.x-1.0-rc5\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc5\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-rc5\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-rc5.tar.gz\";s:4:\"date\";s:10:\"1349125568\";s:6:\"mdhash\";s:32:\"8e0c83f94be049c93527aed8d6b59640\";s:8:\"filesize\";s:6:\"180153\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:11:\"7.x-1.0-rc4\";a:15:{s:4:\"name\";s:22:\"apachesolr 7.x-1.0-rc4\";s:7:\"version\";s:11:\"7.x-1.0-rc4\";s:3:\"tag\";s:11:\"7.x-1.0-rc4\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-rc4\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-rc4.tar.gz\";s:4:\"date\";s:10:\"1348251393\";s:6:\"mdhash\";s:32:\"9eca565a424812a4f676eefef11ec5dd\";s:8:\"filesize\";s:6:\"178915\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:11:\"7.x-1.0-rc3\";a:15:{s:4:\"name\";s:22:\"apachesolr 7.x-1.0-rc3\";s:7:\"version\";s:11:\"7.x-1.0-rc3\";s:3:\"tag\";s:11:\"7.x-1.0-rc3\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-rc3\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-rc3.tar.gz\";s:4:\"date\";s:10:\"1344627704\";s:6:\"mdhash\";s:32:\"6fdb71ca145bd080914164d9f4d73577\";s:8:\"filesize\";s:6:\"172902\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:11:\"7.x-1.0-rc2\";a:15:{s:4:\"name\";s:22:\"apachesolr 7.x-1.0-rc2\";s:7:\"version\";s:11:\"7.x-1.0-rc2\";s:3:\"tag\";s:11:\"7.x-1.0-rc2\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-rc2\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-rc2.tar.gz\";s:4:\"date\";s:10:\"1340280372\";s:6:\"mdhash\";s:32:\"af703df7ac401c6229421308efdf7c07\";s:8:\"filesize\";s:6:\"168596\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:11:\"7.x-1.0-rc1\";a:15:{s:4:\"name\";s:22:\"apachesolr 7.x-1.0-rc1\";s:7:\"version\";s:11:\"7.x-1.0-rc1\";s:3:\"tag\";s:11:\"7.x-1.0-rc1\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-rc1\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-rc1.tar.gz\";s:4:\"date\";s:10:\"1340276171\";s:6:\"mdhash\";s:32:\"84df9fbea964afd40f4e78239565cbfb\";s:8:\"filesize\";s:6:\"168574\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta19\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta19\";s:7:\"version\";s:14:\"7.x-1.0-beta19\";s:3:\"tag\";s:14:\"7.x-1.0-beta19\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta19\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta19\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta19.tar.gz\";s:4:\"date\";s:10:\"1333625738\";s:6:\"mdhash\";s:32:\"1c3490b5a29e116f31e589c69d6cb1af\";s:8:\"filesize\";s:6:\"164948\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta18\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta18\";s:7:\"version\";s:14:\"7.x-1.0-beta18\";s:3:\"tag\";s:14:\"7.x-1.0-beta18\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta18\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta18\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta18.tar.gz\";s:4:\"date\";s:10:\"1333529442\";s:6:\"mdhash\";s:32:\"a98b423cc213a4bcf00487ee81ed5c12\";s:8:\"filesize\";s:6:\"164557\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta17\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta17\";s:7:\"version\";s:14:\"7.x-1.0-beta17\";s:3:\"tag\";s:14:\"7.x-1.0-beta17\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta17\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta17\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta17.tar.gz\";s:4:\"date\";s:10:\"1333466138\";s:6:\"mdhash\";s:32:\"bda9db3ddcb4680172b43439163f0e8d\";s:8:\"filesize\";s:6:\"164556\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta16\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta16\";s:7:\"version\";s:14:\"7.x-1.0-beta16\";s:3:\"tag\";s:14:\"7.x-1.0-beta16\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta16\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta16\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta16.tar.gz\";s:4:\"date\";s:10:\"1328160337\";s:6:\"mdhash\";s:32:\"869a61765aefb861333711240182c8c5\";s:8:\"filesize\";s:6:\"161502\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta15\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta15\";s:7:\"version\";s:14:\"7.x-1.0-beta15\";s:3:\"tag\";s:14:\"7.x-1.0-beta15\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta15\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta15\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta15.tar.gz\";s:4:\"date\";s:10:\"1326383737\";s:6:\"mdhash\";s:32:\"08e5db9318d82f7fe54f4cc386ca2d5f\";s:8:\"filesize\";s:6:\"158325\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta14\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta14\";s:7:\"version\";s:14:\"7.x-1.0-beta14\";s:3:\"tag\";s:14:\"7.x-1.0-beta14\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta14\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta14\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta14.tar.gz\";s:4:\"date\";s:10:\"1326367537\";s:6:\"mdhash\";s:32:\"6da7499be14e90dc0207fc0b14f00edb\";s:8:\"filesize\";s:6:\"155155\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta13\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta13\";s:7:\"version\";s:14:\"7.x-1.0-beta13\";s:3:\"tag\";s:14:\"7.x-1.0-beta13\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta13\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta13\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta13.tar.gz\";s:4:\"date\";s:10:\"1324464937\";s:6:\"mdhash\";s:32:\"18f1aebdbccf0adc296cbbd197973e7c\";s:8:\"filesize\";s:6:\"136738\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta12\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta12\";s:7:\"version\";s:14:\"7.x-1.0-beta12\";s:3:\"tag\";s:14:\"7.x-1.0-beta12\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta12\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta12\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta12.tar.gz\";s:4:\"date\";s:10:\"1323751237\";s:6:\"mdhash\";s:32:\"a44d2c3455a0105088a8783fc6d4797e\";s:8:\"filesize\";s:6:\"136619\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta11\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta11\";s:7:\"version\";s:14:\"7.x-1.0-beta11\";s:3:\"tag\";s:14:\"7.x-1.0-beta11\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta11\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta11\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta11.tar.gz\";s:4:\"date\";s:10:\"1321501537\";s:6:\"mdhash\";s:32:\"020614f8d9a710263aa3f641264b35bb\";s:8:\"filesize\";s:6:\"133280\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-beta10\";a:15:{s:4:\"name\";s:25:\"apachesolr 7.x-1.0-beta10\";s:7:\"version\";s:14:\"7.x-1.0-beta10\";s:3:\"tag\";s:14:\"7.x-1.0-beta10\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"beta10\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:65:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta10\";s:13:\"download_link\";s:70:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta10.tar.gz\";s:4:\"date\";s:10:\"1319070049\";s:6:\"mdhash\";s:32:\"c164f285df3e1a64d2fac236482c0972\";s:8:\"filesize\";s:6:\"130061\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta9\";a:15:{s:4:\"name\";s:24:\"apachesolr 7.x-1.0-beta9\";s:7:\"version\";s:13:\"7.x-1.0-beta9\";s:3:\"tag\";s:13:\"7.x-1.0-beta9\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta9\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:64:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta9\";s:13:\"download_link\";s:69:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta9.tar.gz\";s:4:\"date\";s:10:\"1318479101\";s:6:\"mdhash\";s:32:\"a38ed59f08882f9e10602e9bad554790\";s:8:\"filesize\";s:6:\"129436\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta8\";a:15:{s:4:\"name\";s:24:\"apachesolr 7.x-1.0-beta8\";s:7:\"version\";s:13:\"7.x-1.0-beta8\";s:3:\"tag\";s:13:\"7.x-1.0-beta8\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta8\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:64:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta8\";s:13:\"download_link\";s:69:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta8.tar.gz\";s:4:\"date\";s:10:\"1308019915\";s:6:\"mdhash\";s:32:\"3bff40ac4af1aa52c20db537fc2f82ef\";s:8:\"filesize\";s:6:\"113830\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta7\";a:15:{s:4:\"name\";s:24:\"apachesolr 7.x-1.0-beta7\";s:7:\"version\";s:13:\"7.x-1.0-beta7\";s:3:\"tag\";s:13:\"7.x-1.0-beta7\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta7\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:64:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta7\";s:13:\"download_link\";s:69:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta7.tar.gz\";s:4:\"date\";s:10:\"1306296115\";s:6:\"mdhash\";s:32:\"72236fdb46a0da6dab667d892a5fcc32\";s:8:\"filesize\";s:6:\"113830\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta6\";a:15:{s:4:\"name\";s:24:\"apachesolr 7.x-1.0-beta6\";s:7:\"version\";s:13:\"7.x-1.0-beta6\";s:3:\"tag\";s:13:\"7.x-1.0-beta6\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:64:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta6\";s:13:\"download_link\";s:69:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta6.tar.gz\";s:4:\"date\";s:10:\"1304689615\";s:6:\"mdhash\";s:32:\"6ad61e638deb1228324b2b10c6a431c8\";s:8:\"filesize\";s:6:\"113525\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta5\";a:15:{s:4:\"name\";s:24:\"apachesolr 7.x-1.0-beta5\";s:7:\"version\";s:13:\"7.x-1.0-beta5\";s:3:\"tag\";s:13:\"7.x-1.0-beta5\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta5\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:64:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta5\";s:13:\"download_link\";s:69:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta5.tar.gz\";s:4:\"date\";s:10:\"1302187015\";s:6:\"mdhash\";s:32:\"9066c4c7864662a8b70ce3bd76f9fda5\";s:8:\"filesize\";s:6:\"119783\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta4\";a:15:{s:4:\"name\";s:24:\"apachesolr 7.x-1.0-beta4\";s:7:\"version\";s:13:\"7.x-1.0-beta4\";s:3:\"tag\";s:13:\"7.x-1.0-beta4\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:64:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta4\";s:13:\"download_link\";s:69:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta4.tar.gz\";s:4:\"date\";s:10:\"1301956014\";s:6:\"mdhash\";s:32:\"a4a2a9c73cb07ef0da581210adbf576b\";s:8:\"filesize\";s:6:\"119846\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta3\";a:15:{s:4:\"name\";s:24:\"apachesolr 7.x-1.0-beta3\";s:7:\"version\";s:13:\"7.x-1.0-beta3\";s:3:\"tag\";s:13:\"7.x-1.0-beta3\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:64:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta3\";s:13:\"download_link\";s:69:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta3.tar.gz\";s:4:\"date\";s:10:\"1294367749\";s:6:\"mdhash\";s:32:\"389662b78a561888cb88ae08d254f119\";s:8:\"filesize\";s:6:\"105741\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta2\";a:15:{s:4:\"name\";s:24:\"apachesolr 7.x-1.0-beta2\";s:7:\"version\";s:13:\"7.x-1.0-beta2\";s:3:\"tag\";s:13:\"7.x-1.0-beta2\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:64:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta2\";s:13:\"download_link\";s:69:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta2.tar.gz\";s:4:\"date\";s:10:\"1292728840\";s:6:\"mdhash\";s:32:\"23b9cc3bcfb6d87cf721822129806365\";s:8:\"filesize\";s:6:\"103269\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta1\";a:15:{s:4:\"name\";s:24:\"apachesolr 7.x-1.0-beta1\";s:7:\"version\";s:13:\"7.x-1.0-beta1\";s:3:\"tag\";s:13:\"7.x-1.0-beta1\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:64:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-beta1\";s:13:\"download_link\";s:69:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-beta1.tar.gz\";s:4:\"date\";s:10:\"1291874134\";s:6:\"mdhash\";s:32:\"9199332f2bf234218d7844c88b2344e2\";s:8:\"filesize\";s:6:\"103089\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:17:\"7.x-1.0-unstable1\";a:15:{s:4:\"name\";s:28:\"apachesolr 7.x-1.0-unstable1\";s:7:\"version\";s:17:\"7.x-1.0-unstable1\";s:3:\"tag\";s:17:\"7.x-1.0-unstable1\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:9:\"unstable1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:68:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.0-unstable1\";s:13:\"download_link\";s:73:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.0-unstable1.tar.gz\";s:4:\"date\";s:10:\"1291873838\";s:6:\"mdhash\";s:32:\"fbe99a52b1d93da12e733e44911110af\";s:8:\"filesize\";s:6:\"111430\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:64:\"Unstable releases are not covered by Drupal security advisories.\";}s:11:\"7.x-1.x-dev\";a:14:{s:4:\"name\";s:22:\"apachesolr 7.x-1.x-dev\";s:7:\"version\";s:11:\"7.x-1.x-dev\";s:3:\"tag\";s:7:\"7.x-1.x\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_extra\";s:3:\"dev\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.x-dev\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.x-dev.tar.gz\";s:4:\"date\";s:10:\"1526662080\";s:6:\"mdhash\";s:32:\"9f18bba501a0f14d6e8d5aed2c9ac8bb\";s:8:\"filesize\";s:6:\"264991\";s:5:\"files\";s:0:\"\";s:8:\"security\";s:59:\"Dev releases are not covered by Drupal security advisories.\";s:5:\"terms\";a:0:{}}}}',1549430809,1549344399,1),
('available_releases::devel','a:11:{s:5:\"title\";s:5:\"Devel\";s:10:\"short_name\";s:5:\"devel\";s:4:\"type\";s:14:\"project_module\";s:11:\"api_version\";s:3:\"7.x\";s:17:\"recommended_major\";s:1:\"1\";s:16:\"supported_majors\";s:1:\"1\";s:13:\"default_major\";s:1:\"1\";s:14:\"project_status\";s:9:\"published\";s:4:\"link\";s:36:\"https://www.drupal.org/project/devel\";s:5:\"terms\";s:0:\"\";s:8:\"releases\";a:12:{s:7:\"7.x-1.6\";a:14:{s:4:\"name\";s:13:\"devel 7.x-1.6\";s:7:\"version\";s:7:\"7.x-1.6\";s:3:\"tag\";s:7:\"7.x-1.6\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:53:\"https://www.drupal.org/project/devel/releases/7.x-1.6\";s:13:\"download_link\";s:58:\"https://ftp.drupal.org/files/projects/devel-7.x-1.6.tar.gz\";s:4:\"date\";s:10:\"1524009780\";s:6:\"mdhash\";s:32:\"1176b4c249ef0c398a763c6ffcc9b18c\";s:8:\"filesize\";s:6:\"193355\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.5\";a:14:{s:4:\"name\";s:13:\"devel 7.x-1.5\";s:7:\"version\";s:7:\"7.x-1.5\";s:3:\"tag\";s:7:\"7.x-1.5\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"5\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:53:\"https://www.drupal.org/project/devel/releases/7.x-1.5\";s:13:\"download_link\";s:58:\"https://ftp.drupal.org/files/projects/devel-7.x-1.5.tar.gz\";s:4:\"date\";s:10:\"1398963228\";s:6:\"mdhash\";s:32:\"f06c912eb4edbd48fbcc2867516726a3\";s:8:\"filesize\";s:6:\"193378\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.4\";a:14:{s:4:\"name\";s:13:\"devel 7.x-1.4\";s:7:\"version\";s:7:\"7.x-1.4\";s:3:\"tag\";s:7:\"7.x-1.4\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:53:\"https://www.drupal.org/project/devel/releases/7.x-1.4\";s:13:\"download_link\";s:58:\"https://ftp.drupal.org/files/projects/devel-7.x-1.4.tar.gz\";s:4:\"date\";s:10:\"1391635405\";s:6:\"mdhash\";s:32:\"bfdea9f0eee5dea87c8a1828fdd2f092\";s:8:\"filesize\";s:6:\"193388\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.3\";a:14:{s:4:\"name\";s:13:\"devel 7.x-1.3\";s:7:\"version\";s:7:\"7.x-1.3\";s:3:\"tag\";s:7:\"7.x-1.3\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:53:\"https://www.drupal.org/project/devel/releases/7.x-1.3\";s:13:\"download_link\";s:58:\"https://ftp.drupal.org/files/projects/devel-7.x-1.3.tar.gz\";s:4:\"date\";s:10:\"1338940281\";s:6:\"mdhash\";s:32:\"c556e6de4b3d3e5451ee772d862bc516\";s:8:\"filesize\";s:6:\"190925\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.2\";a:14:{s:4:\"name\";s:13:\"devel 7.x-1.2\";s:7:\"version\";s:7:\"7.x-1.2\";s:3:\"tag\";s:7:\"7.x-1.2\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:53:\"https://www.drupal.org/project/devel/releases/7.x-1.2\";s:13:\"download_link\";s:58:\"https://ftp.drupal.org/files/projects/devel-7.x-1.2.tar.gz\";s:4:\"date\";s:10:\"1311355316\";s:6:\"mdhash\";s:32:\"477e55a4a98b8d00c9eec17aa4093d2a\";s:8:\"filesize\";s:6:\"186138\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.1\";a:14:{s:4:\"name\";s:13:\"devel 7.x-1.1\";s:7:\"version\";s:7:\"7.x-1.1\";s:3:\"tag\";s:7:\"7.x-1.1\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:53:\"https://www.drupal.org/project/devel/releases/7.x-1.1\";s:13:\"download_link\";s:58:\"https://ftp.drupal.org/files/projects/devel-7.x-1.1.tar.gz\";s:4:\"date\";s:10:\"1311192116\";s:6:\"mdhash\";s:32:\"7d75493eb42b06ca1649f1bbd1674909\";s:8:\"filesize\";s:6:\"186092\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:12:\"New features\";i:2;s:9:\"Bug fixes\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.x-1.0\";a:14:{s:4:\"name\";s:13:\"devel 7.x-1.0\";s:7:\"version\";s:7:\"7.x-1.0\";s:3:\"tag\";s:7:\"7.x-1.0\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:53:\"https://www.drupal.org/project/devel/releases/7.x-1.0\";s:13:\"download_link\";s:58:\"https://ftp.drupal.org/files/projects/devel-7.x-1.0.tar.gz\";s:4:\"date\";s:10:\"1294172175\";s:6:\"mdhash\";s:32:\"b3de4c4611ccd5e3e6329c775be69613\";s:8:\"filesize\";s:6:\"188724\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:11:\"7.x-1.0-rc1\";a:15:{s:4:\"name\";s:17:\"devel 7.x-1.0-rc1\";s:7:\"version\";s:11:\"7.x-1.0-rc1\";s:3:\"tag\";s:11:\"7.x-1.0-rc1\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:57:\"https://www.drupal.org/project/devel/releases/7.x-1.0-rc1\";s:13:\"download_link\";s:62:\"https://ftp.drupal.org/files/projects/devel-7.x-1.0-rc1.tar.gz\";s:4:\"date\";s:10:\"1291608173\";s:6:\"mdhash\";s:32:\"fab96f90db6a569620c3f072a8e58984\";s:8:\"filesize\";s:6:\"210984\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta2\";a:15:{s:4:\"name\";s:19:\"devel 7.x-1.0-beta2\";s:7:\"version\";s:13:\"7.x-1.0-beta2\";s:3:\"tag\";s:13:\"7.x-1.0-beta2\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:59:\"https://www.drupal.org/project/devel/releases/7.x-1.0-beta2\";s:13:\"download_link\";s:64:\"https://ftp.drupal.org/files/projects/devel-7.x-1.0-beta2.tar.gz\";s:4:\"date\";s:10:\"1271879406\";s:6:\"mdhash\";s:32:\"d7b04a39c0ff4835a467887ac80c0032\";s:8:\"filesize\";s:6:\"154404\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:13:\"7.x-1.0-beta1\";a:15:{s:4:\"name\";s:19:\"devel 7.x-1.0-beta1\";s:7:\"version\";s:13:\"7.x-1.0-beta1\";s:3:\"tag\";s:13:\"7.x-1.0-beta1\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:59:\"https://www.drupal.org/project/devel/releases/7.x-1.0-beta1\";s:13:\"download_link\";s:64:\"https://ftp.drupal.org/files/projects/devel-7.x-1.0-beta1.tar.gz\";s:4:\"date\";s:10:\"1268976905\";s:6:\"mdhash\";s:32:\"c9e9d320362f8601752cff87fbfa162f\";s:8:\"filesize\";s:6:\"151951\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:14:\"7.x-1.0-alpha1\";a:15:{s:4:\"name\";s:20:\"devel 7.x-1.0-alpha1\";s:7:\"version\";s:14:\"7.x-1.0-alpha1\";s:3:\"tag\";s:14:\"7.x-1.0-alpha1\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:60:\"https://www.drupal.org/project/devel/releases/7.x-1.0-alpha1\";s:13:\"download_link\";s:65:\"https://ftp.drupal.org/files/projects/devel-7.x-1.0-alpha1.tar.gz\";s:4:\"date\";s:10:\"1265080507\";s:6:\"mdhash\";s:32:\"67055f722b47aad39790d3ff346017cf\";s:8:\"filesize\";s:6:\"146771\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:61:\"Alpha releases are not covered by Drupal security advisories.\";}s:11:\"7.x-1.x-dev\";a:14:{s:4:\"name\";s:17:\"devel 7.x-1.x-dev\";s:7:\"version\";s:11:\"7.x-1.x-dev\";s:3:\"tag\";s:7:\"7.x-1.x\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_extra\";s:3:\"dev\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:57:\"https://www.drupal.org/project/devel/releases/7.x-1.x-dev\";s:13:\"download_link\";s:62:\"https://ftp.drupal.org/files/projects/devel-7.x-1.x-dev.tar.gz\";s:4:\"date\";s:10:\"1533400380\";s:6:\"mdhash\";s:32:\"a7ecbec2d2d0cd27837f0ce92decb9f6\";s:8:\"filesize\";s:6:\"193637\";s:5:\"files\";s:0:\"\";s:8:\"security\";s:59:\"Dev releases are not covered by Drupal security advisories.\";s:5:\"terms\";a:0:{}}}}',1549430811,1549344399,1),
('available_releases::drupal','a:11:{s:5:\"title\";s:11:\"Drupal core\";s:10:\"short_name\";s:6:\"drupal\";s:4:\"type\";s:12:\"project_core\";s:11:\"api_version\";s:3:\"7.x\";s:17:\"recommended_major\";s:1:\"7\";s:16:\"supported_majors\";s:1:\"7\";s:13:\"default_major\";s:1:\"7\";s:14:\"project_status\";s:9:\"published\";s:4:\"link\";s:37:\"https://www.drupal.org/project/drupal\";s:5:\"terms\";s:0:\"\";s:8:\"releases\";a:74:{s:4:\"7.63\";a:14:{s:4:\"name\";s:11:\"drupal 7.63\";s:7:\"version\";s:4:\"7.63\";s:3:\"tag\";s:4:\"7.63\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"63\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.63\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.63.tar.gz\";s:4:\"date\";s:10:\"1547681580\";s:6:\"mdhash\";s:32:\"926f05ef0acadfa4ea75fd1d94c8489c\";s:8:\"filesize\";s:7:\"3298415\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.62\";a:14:{s:4:\"name\";s:11:\"drupal 7.62\";s:7:\"version\";s:4:\"7.62\";s:3:\"tag\";s:4:\"7.62\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"62\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.62\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.62.tar.gz\";s:4:\"date\";s:10:\"1547663557\";s:6:\"mdhash\";s:32:\"ba6c2d9f1757da31e804b92cab09dc17\";s:8:\"filesize\";s:7:\"3298412\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.61\";a:14:{s:4:\"name\";s:11:\"drupal 7.61\";s:7:\"version\";s:4:\"7.61\";s:3:\"tag\";s:4:\"7.61\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"61\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.61\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.61.tar.gz\";s:4:\"date\";s:10:\"1541684280\";s:6:\"mdhash\";s:32:\"94bc49170d98e0cfe59db487911ecb9d\";s:8:\"filesize\";s:7:\"3287629\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.60\";a:14:{s:4:\"name\";s:11:\"drupal 7.60\";s:7:\"version\";s:4:\"7.60\";s:3:\"tag\";s:4:\"7.60\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"60\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.60\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.60.tar.gz\";s:4:\"date\";s:10:\"1539816180\";s:6:\"mdhash\";s:32:\"ba14bf3ddc8e182adb49eb50ae117f3e\";s:8:\"filesize\";s:7:\"3283058\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.59\";a:14:{s:4:\"name\";s:11:\"drupal 7.59\";s:7:\"version\";s:4:\"7.59\";s:3:\"tag\";s:4:\"7.59\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"59\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.59\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.59.tar.gz\";s:4:\"date\";s:10:\"1524672780\";s:6:\"mdhash\";s:32:\"7e09c6b177345a81439fe0aa9a2d15fc\";s:8:\"filesize\";s:7:\"3282260\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.58\";a:14:{s:4:\"name\";s:11:\"drupal 7.58\";s:7:\"version\";s:4:\"7.58\";s:3:\"tag\";s:4:\"7.58\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"58\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.58\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.58.tar.gz\";s:4:\"date\";s:10:\"1522263480\";s:6:\"mdhash\";s:32:\"c59949bcfd0d68b4f272bc05a91d4dc6\";s:8:\"filesize\";s:7:\"3281269\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.57\";a:14:{s:4:\"name\";s:11:\"drupal 7.57\";s:7:\"version\";s:4:\"7.57\";s:3:\"tag\";s:4:\"7.57\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"57\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.57\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.57.tar.gz\";s:4:\"date\";s:10:\"1519234680\";s:6:\"mdhash\";s:32:\"44dec95a0ef56c4786785f575ac59a60\";s:8:\"filesize\";s:7:\"3279405\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.56\";a:14:{s:4:\"name\";s:11:\"drupal 7.56\";s:7:\"version\";s:4:\"7.56\";s:3:\"tag\";s:4:\"7.56\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"56\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.56\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.56.tar.gz\";s:4:\"date\";s:10:\"1498069782\";s:6:\"mdhash\";s:32:\"5d198f40f0f1cbf9cdf1bf3de842e534\";s:8:\"filesize\";s:7:\"3277833\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.55\";a:14:{s:4:\"name\";s:11:\"drupal 7.55\";s:7:\"version\";s:4:\"7.55\";s:3:\"tag\";s:4:\"7.55\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"55\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.55\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.55.tar.gz\";s:4:\"date\";s:10:\"1496873942\";s:6:\"mdhash\";s:32:\"ad97f8c86cee7be9d6ab13724b55fa1c\";s:8:\"filesize\";s:7:\"3277355\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.54\";a:14:{s:4:\"name\";s:11:\"drupal 7.54\";s:7:\"version\";s:4:\"7.54\";s:3:\"tag\";s:4:\"7.54\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"54\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.54\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.54.tar.gz\";s:4:\"date\";s:10:\"1485986883\";s:6:\"mdhash\";s:32:\"3068cbe488075ae166e23ea6cd29cf0f\";s:8:\"filesize\";s:7:\"3275864\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.53\";a:14:{s:4:\"name\";s:11:\"drupal 7.53\";s:7:\"version\";s:4:\"7.53\";s:3:\"tag\";s:4:\"7.53\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"53\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.53\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.53.tar.gz\";s:4:\"date\";s:10:\"1481152384\";s:6:\"mdhash\";s:32:\"4230279ecca4f0cde652a219e10327e7\";s:8:\"filesize\";s:7:\"3273245\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.52\";a:14:{s:4:\"name\";s:11:\"drupal 7.52\";s:7:\"version\";s:4:\"7.52\";s:3:\"tag\";s:4:\"7.52\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"52\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.52\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.52.tar.gz\";s:4:\"date\";s:10:\"1479322810\";s:6:\"mdhash\";s:32:\"4963e68ca12918d3a3eae56054214191\";s:8:\"filesize\";s:7:\"3289714\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.51\";a:14:{s:4:\"name\";s:11:\"drupal 7.51\";s:7:\"version\";s:4:\"7.51\";s:3:\"tag\";s:4:\"7.51\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"51\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.51\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.51.tar.gz\";s:4:\"date\";s:10:\"1475693339\";s:6:\"mdhash\";s:32:\"49f82c1cac8e4bd4941ca160fcbee93d\";s:8:\"filesize\";s:7:\"3288987\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.50\";a:14:{s:4:\"name\";s:11:\"drupal 7.50\";s:7:\"version\";s:4:\"7.50\";s:3:\"tag\";s:4:\"7.50\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"50\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.50\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.50.tar.gz\";s:4:\"date\";s:10:\"1467918239\";s:6:\"mdhash\";s:32:\"f23905b0248d76f0fc8316692cd64753\";s:8:\"filesize\";s:7:\"3286826\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.44\";a:14:{s:4:\"name\";s:11:\"drupal 7.44\";s:7:\"version\";s:4:\"7.44\";s:3:\"tag\";s:4:\"7.44\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"44\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.44\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.44.tar.gz\";s:4:\"date\";s:10:\"1466021480\";s:6:\"mdhash\";s:32:\"965ab5fe5457625ec8c18e5c1c455008\";s:8:\"filesize\";s:7:\"3265819\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.43\";a:14:{s:4:\"name\";s:11:\"drupal 7.43\";s:7:\"version\";s:4:\"7.43\";s:3:\"tag\";s:4:\"7.43\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"43\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.43\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.43.tar.gz\";s:4:\"date\";s:10:\"1456341749\";s:6:\"mdhash\";s:32:\"c6fb49bc88a6408a985afddac76b9f8b\";s:8:\"filesize\";s:7:\"3265824\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.42\";a:14:{s:4:\"name\";s:11:\"drupal 7.42\";s:7:\"version\";s:4:\"7.42\";s:3:\"tag\";s:4:\"7.42\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"42\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.42\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.42.tar.gz\";s:4:\"date\";s:10:\"1454516939\";s:6:\"mdhash\";s:32:\"9a96f67474e209dd48750ba6fccc77db\";s:8:\"filesize\";s:7:\"3264065\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.41\";a:14:{s:4:\"name\";s:11:\"drupal 7.41\";s:7:\"version\";s:4:\"7.41\";s:3:\"tag\";s:4:\"7.41\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"41\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.41\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.41.tar.gz\";s:4:\"date\";s:10:\"1445457239\";s:6:\"mdhash\";s:32:\"7636e75e8be213455b4ac7911ce5801f\";s:8:\"filesize\";s:7:\"3257325\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.40\";a:14:{s:4:\"name\";s:11:\"drupal 7.40\";s:7:\"version\";s:4:\"7.40\";s:3:\"tag\";s:4:\"7.40\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"40\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.40\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.40.tar.gz\";s:4:\"date\";s:10:\"1444865639\";s:6:\"mdhash\";s:32:\"d4509f13c23999a76e61ec4d5ccfaf26\";s:8:\"filesize\";s:7:\"3257401\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.39\";a:14:{s:4:\"name\";s:11:\"drupal 7.39\";s:7:\"version\";s:4:\"7.39\";s:3:\"tag\";s:4:\"7.39\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"39\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.39\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.39.tar.gz\";s:4:\"date\";s:10:\"1440019139\";s:6:\"mdhash\";s:32:\"6f42a7e9c7a1c2c4c9c2f20c81b8e79a\";s:8:\"filesize\";s:7:\"3249343\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.38\";a:14:{s:4:\"name\";s:11:\"drupal 7.38\";s:7:\"version\";s:4:\"7.38\";s:3:\"tag\";s:4:\"7.38\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"38\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.38\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.38.tar.gz\";s:4:\"date\";s:10:\"1434566280\";s:6:\"mdhash\";s:32:\"c18298c1a5aed32ddbdac605fdef7fce\";s:8:\"filesize\";s:7:\"3247864\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.37\";a:14:{s:4:\"name\";s:11:\"drupal 7.37\";s:7:\"version\";s:4:\"7.37\";s:3:\"tag\";s:4:\"7.37\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"37\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.37\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.37.tar.gz\";s:4:\"date\";s:10:\"1430972281\";s:6:\"mdhash\";s:32:\"3a70696c87b786365f2c6c3aeb895d8a\";s:8:\"filesize\";s:7:\"3244291\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.36\";a:14:{s:4:\"name\";s:11:\"drupal 7.36\";s:7:\"version\";s:4:\"7.36\";s:3:\"tag\";s:4:\"7.36\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"36\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.36\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.36.tar.gz\";s:4:\"date\";s:10:\"1427943181\";s:6:\"mdhash\";s:32:\"98e1f62c11a5dc5f9481935eefc814c5\";s:8:\"filesize\";s:7:\"3244905\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.35\";a:14:{s:4:\"name\";s:11:\"drupal 7.35\";s:7:\"version\";s:4:\"7.35\";s:3:\"tag\";s:4:\"7.35\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"35\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.35\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.35.tar.gz\";s:4:\"date\";s:10:\"1426706281\";s:6:\"mdhash\";s:32:\"fecc55bd0bd476bc35d9ebf68452942d\";s:8:\"filesize\";s:7:\"3234349\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.34\";a:14:{s:4:\"name\";s:11:\"drupal 7.34\";s:7:\"version\";s:4:\"7.34\";s:3:\"tag\";s:4:\"7.34\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"34\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.34\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.34.tar.gz\";s:4:\"date\";s:10:\"1416429264\";s:6:\"mdhash\";s:32:\"bb4d212e1eb1d7375e41613fbefa04f2\";s:8:\"filesize\";s:7:\"3229858\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.33\";a:14:{s:4:\"name\";s:11:\"drupal 7.33\";s:7:\"version\";s:4:\"7.33\";s:3:\"tag\";s:4:\"7.33\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"33\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.33\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.33.tar.gz\";s:4:\"date\";s:10:\"1415374080\";s:6:\"mdhash\";s:32:\"187b076a5753960d5d5cb12d30d93e73\";s:8:\"filesize\";s:7:\"3229397\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.32\";a:14:{s:4:\"name\";s:11:\"drupal 7.32\";s:7:\"version\";s:4:\"7.32\";s:3:\"tag\";s:4:\"7.32\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"32\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.32\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.32.tar.gz\";s:4:\"date\";s:10:\"1413387329\";s:6:\"mdhash\";s:32:\"d5d121a6ce974f2d20604a7e10e1987a\";s:8:\"filesize\";s:7:\"3215563\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.31\";a:14:{s:4:\"name\";s:11:\"drupal 7.31\";s:7:\"version\";s:4:\"7.31\";s:3:\"tag\";s:4:\"7.31\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"31\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.31\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.31.tar.gz\";s:4:\"date\";s:10:\"1407346427\";s:6:\"mdhash\";s:32:\"de256f202930d3ef5ccc6aebc550adaf\";s:8:\"filesize\";s:7:\"3216766\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.30\";a:14:{s:4:\"name\";s:11:\"drupal 7.30\";s:7:\"version\";s:4:\"7.30\";s:3:\"tag\";s:4:\"7.30\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"30\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.30\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.30.tar.gz\";s:4:\"date\";s:10:\"1406239728\";s:6:\"mdhash\";s:32:\"ef7bce65ca6395f1e6bc44c15fdbc3cb\";s:8:\"filesize\";s:7:\"3215744\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.29\";a:14:{s:4:\"name\";s:11:\"drupal 7.29\";s:7:\"version\";s:4:\"7.29\";s:3:\"tag\";s:4:\"7.29\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"29\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.29\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.29.tar.gz\";s:4:\"date\";s:10:\"1405543128\";s:6:\"mdhash\";s:32:\"6ffdfb0ee08fadfb531c7fed1d2c5633\";s:8:\"filesize\";s:7:\"3213499\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.28\";a:14:{s:4:\"name\";s:11:\"drupal 7.28\";s:7:\"version\";s:4:\"7.28\";s:3:\"tag\";s:4:\"7.28\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"28\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.28\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.28.tar.gz\";s:4:\"date\";s:10:\"1399522729\";s:6:\"mdhash\";s:32:\"6255884d7e15c654fc8856805b271551\";s:8:\"filesize\";s:7:\"3212823\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.27\";a:14:{s:4:\"name\";s:11:\"drupal 7.27\";s:7:\"version\";s:4:\"7.27\";s:3:\"tag\";s:4:\"7.27\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"27\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.27\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.27.tar.gz\";s:4:\"date\";s:10:\"1397686464\";s:6:\"mdhash\";s:32:\"e9b05562f1a7f8bbcb5922cd3a0d55cb\";s:8:\"filesize\";s:7:\"3207398\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.26\";a:14:{s:4:\"name\";s:11:\"drupal 7.26\";s:7:\"version\";s:4:\"7.26\";s:3:\"tag\";s:4:\"7.26\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"26\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.26\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.26.tar.gz\";s:4:\"date\";s:10:\"1389815904\";s:6:\"mdhash\";s:32:\"740bd57f524b8ac18a203b663ca1329d\";s:8:\"filesize\";s:7:\"3204587\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.25\";a:14:{s:4:\"name\";s:11:\"drupal 7.25\";s:7:\"version\";s:4:\"7.25\";s:3:\"tag\";s:4:\"7.25\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"25\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.25\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.25.tar.gz\";s:4:\"date\";s:10:\"1388709505\";s:6:\"mdhash\";s:32:\"25906158083d89aa86534df1c683b4ea\";s:8:\"filesize\";s:7:\"3203256\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.24\";a:14:{s:4:\"name\";s:11:\"drupal 7.24\";s:7:\"version\";s:4:\"7.24\";s:3:\"tag\";s:4:\"7.24\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"24\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.24\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.24.tar.gz\";s:4:\"date\";s:10:\"1384982905\";s:6:\"mdhash\";s:32:\"c1ddb37155e4b6160f6508636c06f2a7\";s:8:\"filesize\";s:7:\"3195735\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.23\";a:14:{s:4:\"name\";s:11:\"drupal 7.23\";s:7:\"version\";s:4:\"7.23\";s:3:\"tag\";s:4:\"7.23\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"23\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.23\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.23.tar.gz\";s:4:\"date\";s:10:\"1375928239\";s:6:\"mdhash\";s:32:\"0beca6fec15b8cf8c35a6fdda6675342\";s:8:\"filesize\";s:7:\"3191695\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.22\";a:14:{s:4:\"name\";s:11:\"drupal 7.22\";s:7:\"version\";s:4:\"7.22\";s:3:\"tag\";s:4:\"7.22\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"22\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.22\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.22.tar.gz\";s:4:\"date\";s:10:\"1365027013\";s:6:\"mdhash\";s:32:\"068d7a77958fce6bb002659aa7ccaeb7\";s:8:\"filesize\";s:7:\"3183014\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.21\";a:14:{s:4:\"name\";s:11:\"drupal 7.21\";s:7:\"version\";s:4:\"7.21\";s:3:\"tag\";s:4:\"7.21\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"21\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.21\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.21.tar.gz\";s:4:\"date\";s:10:\"1362616997\";s:6:\"mdhash\";s:32:\"eff054cd53be39ff719f77c81dce1aac\";s:8:\"filesize\";s:7:\"3163798\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.20\";a:14:{s:4:\"name\";s:11:\"drupal 7.20\";s:7:\"version\";s:4:\"7.20\";s:3:\"tag\";s:4:\"7.20\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"20\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.20\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.20.tar.gz\";s:4:\"date\";s:10:\"1361393684\";s:6:\"mdhash\";s:32:\"ee576d63f1fd8a1f1c072a56978da0c5\";s:8:\"filesize\";s:7:\"3163257\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.19\";a:14:{s:4:\"name\";s:11:\"drupal 7.19\";s:7:\"version\";s:4:\"7.19\";s:3:\"tag\";s:4:\"7.19\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"19\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.19\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.19.tar.gz\";s:4:\"date\";s:10:\"1358374871\";s:6:\"mdhash\";s:32:\"c1dd3960f1555df208c80ef612e0c53a\";s:8:\"filesize\";s:7:\"3163130\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.18\";a:14:{s:4:\"name\";s:11:\"drupal 7.18\";s:7:\"version\";s:4:\"7.18\";s:3:\"tag\";s:4:\"7.18\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"18\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.18\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.18.tar.gz\";s:4:\"date\";s:10:\"1355944004\";s:6:\"mdhash\";s:32:\"5c048f60a53acd7cb3c2b6d5fe42f082\";s:8:\"filesize\";s:7:\"3162333\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.17\";a:14:{s:4:\"name\";s:11:\"drupal 7.17\";s:7:\"version\";s:4:\"7.17\";s:3:\"tag\";s:4:\"7.17\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"17\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.17\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.17.tar.gz\";s:4:\"date\";s:10:\"1352325358\";s:6:\"mdhash\";s:32:\"439e8ca7e6a33bb879a4624d8f01bed0\";s:8:\"filesize\";s:7:\"3162429\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.16\";a:14:{s:4:\"name\";s:11:\"drupal 7.16\";s:7:\"version\";s:4:\"7.16\";s:3:\"tag\";s:4:\"7.16\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"16\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.16\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.16.tar.gz\";s:4:\"date\";s:10:\"1350508568\";s:6:\"mdhash\";s:32:\"352497b2df94b5308e31cb8da020b631\";s:8:\"filesize\";s:7:\"3142889\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.15\";a:14:{s:4:\"name\";s:11:\"drupal 7.15\";s:7:\"version\";s:4:\"7.15\";s:3:\"tag\";s:4:\"7.15\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"15\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.15\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.15.tar.gz\";s:4:\"date\";s:10:\"1343839327\";s:6:\"mdhash\";s:32:\"f42c9baccd74e1d035d61ff537ae21b4\";s:8:\"filesize\";s:7:\"3142219\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.14\";a:14:{s:4:\"name\";s:11:\"drupal 7.14\";s:7:\"version\";s:4:\"7.14\";s:3:\"tag\";s:4:\"7.14\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"14\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.14\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.14.tar.gz\";s:4:\"date\";s:10:\"1335997556\";s:6:\"mdhash\";s:32:\"af7abd95c03ecad4e1567ed94a438334\";s:8:\"filesize\";s:7:\"3128473\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.13\";a:14:{s:4:\"name\";s:11:\"drupal 7.13\";s:7:\"version\";s:4:\"7.13\";s:3:\"tag\";s:4:\"7.13\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"13\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.13\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.13.tar.gz\";s:4:\"date\";s:10:\"1335997261\";s:6:\"mdhash\";s:32:\"80587b66375c7fc539414a20a2c6f2de\";s:8:\"filesize\";s:7:\"3088448\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.12\";a:14:{s:4:\"name\";s:11:\"drupal 7.12\";s:7:\"version\";s:4:\"7.12\";s:3:\"tag\";s:4:\"7.12\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"12\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.12\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.12.tar.gz\";s:4:\"date\";s:10:\"1328134561\";s:6:\"mdhash\";s:32:\"db2284beb97241c9bdca9c638cd8a4f1\";s:8:\"filesize\";s:7:\"3088472\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.11\";a:14:{s:4:\"name\";s:11:\"drupal 7.11\";s:7:\"version\";s:4:\"7.11\";s:3:\"tag\";s:4:\"7.11\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"11\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.11\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.11.tar.gz\";s:4:\"date\";s:10:\"1328134275\";s:6:\"mdhash\";s:32:\"e9857e1749762367d7631d74cc6564a7\";s:8:\"filesize\";s:7:\"2789336\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:4:\"7.10\";a:14:{s:4:\"name\";s:11:\"drupal 7.10\";s:7:\"version\";s:4:\"7.10\";s:3:\"tag\";s:4:\"7.10\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"10\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.10\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.10.tar.gz\";s:4:\"date\";s:10:\"1323125439\";s:6:\"mdhash\";s:32:\"1caafb849bc756e62dd874b90b95ab31\";s:8:\"filesize\";s:7:\"3067653\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.9\";a:14:{s:4:\"name\";s:10:\"drupal 7.9\";s:7:\"version\";s:3:\"7.9\";s:3:\"tag\";s:3:\"7.9\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"9\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.9\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.9.tar.gz\";s:4:\"date\";s:10:\"1319660731\";s:6:\"mdhash\";s:32:\"7f45f109c413ca69ebb6e3140ed47225\";s:8:\"filesize\";s:7:\"2788086\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.8\";a:14:{s:4:\"name\";s:10:\"drupal 7.8\";s:7:\"version\";s:3:\"7.8\";s:3:\"tag\";s:3:\"7.8\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"8\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.8\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.8.tar.gz\";s:4:\"date\";s:10:\"1314817617\";s:6:\"mdhash\";s:32:\"e0226b56e8d5c57c6b126e8ed5866b1f\";s:8:\"filesize\";s:7:\"2766967\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.7\";a:14:{s:4:\"name\";s:10:\"drupal 7.7\";s:7:\"version\";s:3:\"7.7\";s:3:\"tag\";s:3:\"7.7\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"7\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.7\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.7.tar.gz\";s:4:\"date\";s:10:\"1311813880\";s:6:\"mdhash\";s:32:\"2eeb63fd1ef6b23b0a9f5f6b8aef8850\";s:8:\"filesize\";s:7:\"2754113\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.6\";a:14:{s:4:\"name\";s:10:\"drupal 7.6\";s:7:\"version\";s:3:\"7.6\";s:3:\"tag\";s:3:\"7.6\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.6\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.6.tar.gz\";s:4:\"date\";s:10:\"1311798716\";s:6:\"mdhash\";s:32:\"e88e63c4da9e5e170f089d050c88c827\";s:8:\"filesize\";s:7:\"2753784\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.5\";a:14:{s:4:\"name\";s:10:\"drupal 7.5\";s:7:\"version\";s:3:\"7.5\";s:3:\"tag\";s:3:\"7.5\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"5\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.5\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.5.tar.gz\";s:4:\"date\";s:10:\"1311798416\";s:6:\"mdhash\";s:32:\"36d65b7a97c58226c64a6abdf481de45\";s:8:\"filesize\";s:7:\"2744690\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.4\";a:14:{s:4:\"name\";s:10:\"drupal 7.4\";s:7:\"version\";s:3:\"7.4\";s:3:\"tag\";s:3:\"7.4\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.4\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.4.tar.gz\";s:4:\"date\";s:10:\"1309397516\";s:6:\"mdhash\";s:32:\"84704de078e9f5432c9bb5c6ecd841d4\";s:8:\"filesize\";s:7:\"2744808\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.3\";a:14:{s:4:\"name\";s:10:\"drupal 7.3\";s:7:\"version\";s:3:\"7.3\";s:3:\"tag\";s:3:\"7.3\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.3\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.3.tar.gz\";s:4:\"date\";s:10:\"1309397216\";s:6:\"mdhash\";s:32:\"c290775724bc309647d84d03ddb88e2e\";s:8:\"filesize\";s:7:\"2735461\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.2\";a:14:{s:4:\"name\";s:10:\"drupal 7.2\";s:7:\"version\";s:3:\"7.2\";s:3:\"tag\";s:3:\"7.2\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.2\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.2.tar.gz\";s:4:\"date\";s:10:\"1306357017\";s:6:\"mdhash\";s:32:\"cf88c87e3694ebd15b62ba6f6a69124f\";s:8:\"filesize\";s:7:\"2731345\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.1\";a:14:{s:4:\"name\";s:10:\"drupal 7.1\";s:7:\"version\";s:3:\"7.1\";s:3:\"tag\";s:3:\"7.1\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.1\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.1.tar.gz\";s:4:\"date\";s:10:\"1306354916\";s:6:\"mdhash\";s:32:\"27eb45cb894a76f3a9ae6715584a10cc\";s:8:\"filesize\";s:7:\"2713977\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:3:\"7.0\";a:14:{s:4:\"name\";s:10:\"drupal 7.0\";s:7:\"version\";s:3:\"7.0\";s:3:\"tag\";s:3:\"7.0\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:50:\"https://www.drupal.org/project/drupal/releases/7.0\";s:13:\"download_link\";s:55:\"https://ftp.drupal.org/files/projects/drupal-7.0.tar.gz\";s:4:\"date\";s:10:\"1294208759\";s:6:\"mdhash\";s:32:\"e96c0a5e47c5d7706897384069dfb920\";s:8:\"filesize\";s:7:\"2728271\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}s:7:\"7.0-rc4\";a:15:{s:4:\"name\";s:14:\"drupal 7.0-rc4\";s:7:\"version\";s:7:\"7.0-rc4\";s:3:\"tag\";s:8:\"7.0-rc-4\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:54:\"https://www.drupal.org/project/drupal/releases/7.0-rc4\";s:13:\"download_link\";s:59:\"https://ftp.drupal.org/files/projects/drupal-7.0-rc4.tar.gz\";s:4:\"date\";s:10:\"1293684084\";s:6:\"mdhash\";s:32:\"104c08e609c64bb1e45b55a7ad1ad857\";s:8:\"filesize\";s:7:\"2717666\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:7:\"7.0-rc3\";a:15:{s:4:\"name\";s:14:\"drupal 7.0-rc3\";s:7:\"version\";s:7:\"7.0-rc3\";s:3:\"tag\";s:8:\"7.0-rc-3\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:54:\"https://www.drupal.org/project/drupal/releases/7.0-rc3\";s:13:\"download_link\";s:59:\"https://ftp.drupal.org/files/projects/drupal-7.0-rc3.tar.gz\";s:4:\"date\";s:10:\"1293099424\";s:6:\"mdhash\";s:32:\"be9a3f190e2648fa03dcb2bf3d8be199\";s:8:\"filesize\";s:7:\"2719115\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:7:\"7.0-rc2\";a:15:{s:4:\"name\";s:14:\"drupal 7.0-rc2\";s:7:\"version\";s:7:\"7.0-rc2\";s:3:\"tag\";s:8:\"7.0-rc-2\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:54:\"https://www.drupal.org/project/drupal/releases/7.0-rc2\";s:13:\"download_link\";s:59:\"https://ftp.drupal.org/files/projects/drupal-7.0-rc2.tar.gz\";s:4:\"date\";s:10:\"1292101847\";s:6:\"mdhash\";s:32:\"f31982c73f1707ddccb2927325bc9cb9\";s:8:\"filesize\";s:7:\"2705734\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:7:\"7.0-rc1\";a:15:{s:4:\"name\";s:14:\"drupal 7.0-rc1\";s:7:\"version\";s:7:\"7.0-rc1\";s:3:\"tag\";s:8:\"7.0-rc-1\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:54:\"https://www.drupal.org/project/drupal/releases/7.0-rc1\";s:13:\"download_link\";s:59:\"https://ftp.drupal.org/files/projects/drupal-7.0-rc1.tar.gz\";s:4:\"date\";s:10:\"1291190142\";s:6:\"mdhash\";s:32:\"b554e79cf60c02d4dec592151c4b58ee\";s:8:\"filesize\";s:7:\"2694689\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:4:{i:0;s:15:\"Security update\";i:1;s:12:\"New features\";i:2;s:9:\"Bug fixes\";i:3;s:8:\"Insecure\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}s:9:\"7.0-beta3\";a:15:{s:4:\"name\";s:16:\"drupal 7.0-beta3\";s:7:\"version\";s:9:\"7.0-beta3\";s:3:\"tag\";s:9:\"7.0-beta3\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:56:\"https://www.drupal.org/project/drupal/releases/7.0-beta3\";s:13:\"download_link\";s:61:\"https://ftp.drupal.org/files/projects/drupal-7.0-beta3.tar.gz\";s:4:\"date\";s:10:\"1289694735\";s:6:\"mdhash\";s:32:\"c942f010a2535586c4578cd7b107c652\";s:8:\"filesize\";s:7:\"2660883\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:4:{i:0;s:15:\"Security update\";i:1;s:12:\"New features\";i:2;s:9:\"Bug fixes\";i:3;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:9:\"7.0-beta2\";a:15:{s:4:\"name\";s:16:\"drupal 7.0-beta2\";s:7:\"version\";s:9:\"7.0-beta2\";s:3:\"tag\";s:9:\"7.0-beta2\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:56:\"https://www.drupal.org/project/drupal/releases/7.0-beta2\";s:13:\"download_link\";s:61:\"https://ftp.drupal.org/files/projects/drupal-7.0-beta2.tar.gz\";s:4:\"date\";s:10:\"1287812133\";s:6:\"mdhash\";s:32:\"c2de0bdb657b77af8c8369a355cab8ce\";s:8:\"filesize\";s:7:\"2638949\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:9:\"7.0-beta1\";a:15:{s:4:\"name\";s:16:\"drupal 7.0-beta1\";s:7:\"version\";s:9:\"7.0-beta1\";s:3:\"tag\";s:9:\"7.0-beta1\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:56:\"https://www.drupal.org/project/drupal/releases/7.0-beta1\";s:13:\"download_link\";s:61:\"https://ftp.drupal.org/files/projects/drupal-7.0-beta1.tar.gz\";s:4:\"date\";s:10:\"1286422866\";s:6:\"mdhash\";s:32:\"490ce0d95eacc15f2918becd60f6821c\";s:8:\"filesize\";s:7:\"2622225\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:60:\"Beta releases are not covered by Drupal security advisories.\";}s:10:\"7.0-alpha7\";a:15:{s:4:\"name\";s:17:\"drupal 7.0-alpha7\";s:7:\"version\";s:10:\"7.0-alpha7\";s:3:\"tag\";s:10:\"7.0-alpha7\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha7\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:57:\"https://www.drupal.org/project/drupal/releases/7.0-alpha7\";s:13:\"download_link\";s:62:\"https://ftp.drupal.org/files/projects/drupal-7.0-alpha7.tar.gz\";s:4:\"date\";s:10:\"1284599764\";s:6:\"mdhash\";s:32:\"15183fcf862be97f7e96991e6e56fe2e\";s:8:\"filesize\";s:7:\"2586833\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:61:\"Alpha releases are not covered by Drupal security advisories.\";}s:10:\"7.0-alpha6\";a:15:{s:4:\"name\";s:17:\"drupal 7.0-alpha6\";s:7:\"version\";s:10:\"7.0-alpha6\";s:3:\"tag\";s:10:\"7.0-alpha6\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:57:\"https://www.drupal.org/project/drupal/releases/7.0-alpha6\";s:13:\"download_link\";s:62:\"https://ftp.drupal.org/files/projects/drupal-7.0-alpha6.tar.gz\";s:4:\"date\";s:10:\"1278634809\";s:6:\"mdhash\";s:32:\"eb64647263affc36f76d1e7ffb751d32\";s:8:\"filesize\";s:7:\"2458211\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:4:{i:0;s:15:\"Security update\";i:1;s:12:\"New features\";i:2;s:9:\"Bug fixes\";i:3;s:8:\"Insecure\";}}s:8:\"security\";s:61:\"Alpha releases are not covered by Drupal security advisories.\";}s:10:\"7.0-alpha5\";a:15:{s:4:\"name\";s:17:\"drupal 7.0-alpha5\";s:7:\"version\";s:10:\"7.0-alpha5\";s:3:\"tag\";s:10:\"7.0-alpha5\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha5\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:57:\"https://www.drupal.org/project/drupal/releases/7.0-alpha5\";s:13:\"download_link\";s:62:\"https://ftp.drupal.org/files/projects/drupal-7.0-alpha5.tar.gz\";s:4:\"date\";s:10:\"1274628613\";s:6:\"mdhash\";s:32:\"de9c1d51f0ce730f7356bd0a160e8ce1\";s:8:\"filesize\";s:7:\"2424226\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:61:\"Alpha releases are not covered by Drupal security advisories.\";}s:10:\"7.0-alpha4\";a:15:{s:4:\"name\";s:17:\"drupal 7.0-alpha4\";s:7:\"version\";s:10:\"7.0-alpha4\";s:3:\"tag\";s:10:\"7.0-alpha4\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:57:\"https://www.drupal.org/project/drupal/releases/7.0-alpha4\";s:13:\"download_link\";s:62:\"https://ftp.drupal.org/files/projects/drupal-7.0-alpha4.tar.gz\";s:4:\"date\";s:10:\"1272318014\";s:6:\"mdhash\";s:32:\"c8f371a388bc65b2211d7d29856fb993\";s:8:\"filesize\";s:7:\"2403384\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";i:2;s:8:\"Insecure\";}}s:8:\"security\";s:61:\"Alpha releases are not covered by Drupal security advisories.\";}s:10:\"7.0-alpha3\";a:15:{s:4:\"name\";s:17:\"drupal 7.0-alpha3\";s:7:\"version\";s:10:\"7.0-alpha3\";s:3:\"tag\";s:10:\"7.0-alpha3\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:57:\"https://www.drupal.org/project/drupal/releases/7.0-alpha3\";s:13:\"download_link\";s:62:\"https://ftp.drupal.org/files/projects/drupal-7.0-alpha3.tar.gz\";s:4:\"date\";s:10:\"1269192317\";s:6:\"mdhash\";s:32:\"9efc083f09d6b523d655bc90a6869945\";s:8:\"filesize\";s:7:\"2357934\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:4:{i:0;s:15:\"Security update\";i:1;s:12:\"New features\";i:2;s:9:\"Bug fixes\";i:3;s:8:\"Insecure\";}}s:8:\"security\";s:61:\"Alpha releases are not covered by Drupal security advisories.\";}s:10:\"7.0-alpha2\";a:15:{s:4:\"name\";s:17:\"drupal 7.0-alpha2\";s:7:\"version\";s:10:\"7.0-alpha2\";s:3:\"tag\";s:10:\"7.0-alpha2\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:57:\"https://www.drupal.org/project/drupal/releases/7.0-alpha2\";s:13:\"download_link\";s:62:\"https://ftp.drupal.org/files/projects/drupal-7.0-alpha2.tar.gz\";s:4:\"date\";s:10:\"1266777910\";s:6:\"mdhash\";s:32:\"cfbfdd2249638a266054f2532348065d\";s:8:\"filesize\";s:7:\"2314834\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:61:\"Alpha releases are not covered by Drupal security advisories.\";}s:10:\"7.0-alpha1\";a:15:{s:4:\"name\";s:17:\"drupal 7.0-alpha1\";s:7:\"version\";s:10:\"7.0-alpha1\";s:3:\"tag\";s:10:\"7.0-alpha1\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:57:\"https://www.drupal.org/project/drupal/releases/7.0-alpha1\";s:13:\"download_link\";s:62:\"https://ftp.drupal.org/files/projects/drupal-7.0-alpha1.tar.gz\";s:4:\"date\";s:10:\"1263566711\";s:6:\"mdhash\";s:32:\"508109c6cf0ead868e02d8c3db2a4d1f\";s:8:\"filesize\";s:7:\"2283220\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:12:\"New features\";i:1;s:8:\"Insecure\";}}s:8:\"security\";s:61:\"Alpha releases are not covered by Drupal security advisories.\";}s:7:\"7.x-dev\";a:14:{s:4:\"name\";s:14:\"drupal 7.x-dev\";s:7:\"version\";s:7:\"7.x-dev\";s:3:\"tag\";s:3:\"7.x\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_extra\";s:3:\"dev\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:54:\"https://www.drupal.org/project/drupal/releases/7.x-dev\";s:13:\"download_link\";s:59:\"https://ftp.drupal.org/files/projects/drupal-7.x-dev.tar.gz\";s:4:\"date\";s:10:\"1548431280\";s:6:\"mdhash\";s:32:\"95197a6a64e3b637e5b348047929c58b\";s:8:\"filesize\";s:7:\"3298030\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";}}s:8:\"security\";s:59:\"Dev releases are not covered by Drupal security advisories.\";}}}',1549430810,1549344399,1),
('available_releases::wweave','N;',1549430822,1549344416,1),
('fetch_failures','a:0:{}',1549344722,1549344416,1),
('fetch_task::wweave',NULL,0,1549344424,0),
('update_project_data','a:5:{s:10:\"admin_menu\";a:17:{s:4:\"name\";s:10:\"admin_menu\";s:4:\"info\";a:6:{s:4:\"name\";s:32:\"Administration Development tools\";s:7:\"package\";s:14:\"Administration\";s:7:\"version\";s:11:\"7.x-3.0-rc5\";s:7:\"project\";s:10:\"admin_menu\";s:9:\"datestamp\";s:10:\"1419029284\";s:16:\"_info_file_ctime\";i:1549339110;}s:9:\"datestamp\";s:10:\"1419029284\";s:8:\"includes\";a:1:{s:11:\"admin_devel\";s:32:\"Administration Development tools\";}s:12:\"project_type\";s:6:\"module\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}s:16:\"existing_version\";s:11:\"7.x-3.0-rc5\";s:14:\"existing_major\";s:1:\"3\";s:12:\"install_type\";s:8:\"official\";s:5:\"title\";s:19:\"Administration menu\";s:4:\"link\";s:41:\"https://www.drupal.org/project/admin_menu\";s:14:\"latest_version\";s:11:\"7.x-3.0-rc6\";s:8:\"releases\";a:1:{s:11:\"7.x-3.0-rc6\";a:15:{s:4:\"name\";s:22:\"admin_menu 7.x-3.0-rc6\";s:7:\"version\";s:11:\"7.x-3.0-rc6\";s:3:\"tag\";s:11:\"7.x-3.0-rc6\";s:13:\"version_major\";s:1:\"3\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:62:\"https://www.drupal.org/project/admin_menu/releases/7.x-3.0-rc6\";s:13:\"download_link\";s:67:\"https://ftp.drupal.org/files/projects/admin_menu-7.x-3.0-rc6.tar.gz\";s:4:\"date\";s:10:\"1543859280\";s:6:\"mdhash\";s:32:\"91f08440f64fc2ddee565aab3198cb70\";s:8:\"filesize\";s:5:\"53905\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";}}s:8:\"security\";s:58:\"RC releases are not covered by Drupal security advisories.\";}}s:11:\"recommended\";s:11:\"7.x-3.0-rc6\";s:6:\"status\";i:4;}s:10:\"apachesolr\";a:17:{s:4:\"name\";s:10:\"apachesolr\";s:4:\"info\";a:6:{s:4:\"name\";s:21:\"Apache Solr framework\";s:7:\"package\";s:14:\"Search Toolkit\";s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:10:\"apachesolr\";s:9:\"datestamp\";s:10:\"1449085462\";s:16:\"_info_file_ctime\";i:1549339110;}s:9:\"datestamp\";s:10:\"1449085462\";s:8:\"includes\";a:1:{s:10:\"apachesolr\";s:21:\"Apache Solr framework\";}s:12:\"project_type\";s:6:\"module\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}s:16:\"existing_version\";s:7:\"7.x-1.8\";s:14:\"existing_major\";s:1:\"1\";s:12:\"install_type\";s:8:\"official\";s:5:\"title\";s:18:\"Apache Solr Search\";s:4:\"link\";s:41:\"https://www.drupal.org/project/apachesolr\";s:14:\"latest_version\";s:8:\"7.x-1.11\";s:8:\"releases\";a:1:{s:8:\"7.x-1.11\";a:14:{s:4:\"name\";s:19:\"apachesolr 7.x-1.11\";s:7:\"version\";s:8:\"7.x-1.11\";s:3:\"tag\";s:8:\"7.x-1.11\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:2:\"11\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:59:\"https://www.drupal.org/project/apachesolr/releases/7.x-1.11\";s:13:\"download_link\";s:64:\"https://ftp.drupal.org/files/projects/apachesolr-7.x-1.11.tar.gz\";s:4:\"date\";s:10:\"1526662380\";s:6:\"mdhash\";s:32:\"66344c849ccdc378add58c944419e66d\";s:8:\"filesize\";s:6:\"264969\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}}s:11:\"recommended\";s:8:\"7.x-1.11\";s:6:\"status\";i:4;}s:6:\"drupal\";a:17:{s:4:\"name\";s:6:\"drupal\";s:4:\"info\";a:6:{s:4:\"name\";s:5:\"Block\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:16:\"_info_file_ctime\";i:1548995168;}s:9:\"datestamp\";s:10:\"1547681965\";s:8:\"includes\";a:21:{s:5:\"block\";s:5:\"Block\";s:4:\"blog\";s:4:\"Blog\";s:9:\"dashboard\";s:9:\"Dashboard\";s:5:\"dblog\";s:16:\"Database logging\";s:5:\"field\";s:5:\"Field\";s:17:\"field_sql_storage\";s:17:\"Field SQL storage\";s:8:\"field_ui\";s:8:\"Field UI\";s:4:\"file\";s:4:\"File\";s:6:\"filter\";s:6:\"Filter\";s:5:\"image\";s:5:\"Image\";s:6:\"locale\";s:6:\"Locale\";s:4:\"menu\";s:4:\"Menu\";s:4:\"node\";s:4:\"Node\";s:6:\"syslog\";s:6:\"Syslog\";s:6:\"system\";s:6:\"System\";s:4:\"text\";s:4:\"Text\";s:7:\"toolbar\";s:7:\"Toolbar\";s:6:\"update\";s:14:\"Update manager\";s:4:\"user\";s:4:\"User\";s:6:\"bartik\";s:6:\"Bartik\";s:5:\"seven\";s:5:\"Seven\";}s:12:\"project_type\";s:4:\"core\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}s:16:\"existing_version\";s:4:\"7.63\";s:14:\"existing_major\";s:1:\"7\";s:12:\"install_type\";s:8:\"official\";s:5:\"title\";s:11:\"Drupal core\";s:4:\"link\";s:37:\"https://www.drupal.org/project/drupal\";s:14:\"latest_version\";s:4:\"7.63\";s:8:\"releases\";a:1:{s:4:\"7.63\";a:14:{s:4:\"name\";s:11:\"drupal 7.63\";s:7:\"version\";s:4:\"7.63\";s:3:\"tag\";s:4:\"7.63\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"63\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:51:\"https://www.drupal.org/project/drupal/releases/7.63\";s:13:\"download_link\";s:56:\"https://ftp.drupal.org/files/projects/drupal-7.63.tar.gz\";s:4:\"date\";s:10:\"1547681580\";s:6:\"mdhash\";s:32:\"926f05ef0acadfa4ea75fd1d94c8489c\";s:8:\"filesize\";s:7:\"3298415\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}}s:11:\"recommended\";s:4:\"7.63\";s:6:\"status\";i:5;}s:5:\"devel\";a:17:{s:4:\"name\";s:5:\"devel\";s:4:\"info\";a:6:{s:4:\"name\";s:5:\"Devel\";s:7:\"package\";s:11:\"Development\";s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:5:\"devel\";s:9:\"datestamp\";s:10:\"1398963366\";s:16:\"_info_file_ctime\";i:1549339141;}s:9:\"datestamp\";s:10:\"1398963366\";s:8:\"includes\";a:2:{s:5:\"devel\";s:5:\"Devel\";s:17:\"devel_node_access\";s:17:\"Devel node access\";}s:12:\"project_type\";s:6:\"module\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}s:16:\"existing_version\";s:7:\"7.x-1.5\";s:14:\"existing_major\";s:1:\"1\";s:12:\"install_type\";s:8:\"official\";s:5:\"title\";s:5:\"Devel\";s:4:\"link\";s:36:\"https://www.drupal.org/project/devel\";s:14:\"latest_version\";s:7:\"7.x-1.6\";s:8:\"releases\";a:1:{s:7:\"7.x-1.6\";a:14:{s:4:\"name\";s:13:\"devel 7.x-1.6\";s:7:\"version\";s:7:\"7.x-1.6\";s:3:\"tag\";s:7:\"7.x-1.6\";s:13:\"version_major\";s:1:\"1\";s:13:\"version_patch\";s:1:\"6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:53:\"https://www.drupal.org/project/devel/releases/7.x-1.6\";s:13:\"download_link\";s:58:\"https://ftp.drupal.org/files/projects/devel-7.x-1.6.tar.gz\";s:4:\"date\";s:10:\"1524009780\";s:6:\"mdhash\";s:32:\"1176b4c249ef0c398a763c6ffcc9b18c\";s:8:\"filesize\";s:6:\"193355\";s:5:\"files\";s:0:\"\";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:9:\"Bug fixes\";i:1;s:12:\"New features\";}}s:8:\"security\";s:44:\"Covered by Drupal\'s security advisory policy\";}}s:11:\"recommended\";s:7:\"7.x-1.6\";s:6:\"status\";i:4;}s:6:\"wweave\";a:14:{s:4:\"name\";s:6:\"wweave\";s:4:\"info\";a:6:{s:4:\"name\";s:6:\"wweave\";s:7:\"package\";s:6:\"Sonata\";s:7:\"version\";s:7:\"7.x-1.0\";s:7:\"project\";s:6:\"wweave\";s:16:\"_info_file_ctime\";i:1549339170;s:9:\"datestamp\";i:0;}s:9:\"datestamp\";i:0;s:8:\"includes\";a:1:{s:6:\"wweave\";s:6:\"wweave\";}s:12:\"project_type\";s:6:\"module\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}s:16:\"existing_version\";s:7:\"7.x-1.0\";s:14:\"existing_major\";s:1:\"1\";s:12:\"install_type\";s:8:\"official\";s:6:\"status\";i:-4;s:6:\"reason\";s:24:\"No available update data\";s:12:\"fetch_status\";i:-4;}}',1549348030,1549344430,1),
('update_project_projects','a:5:{s:10:\"admin_menu\";a:8:{s:4:\"name\";s:10:\"admin_menu\";s:4:\"info\";a:6:{s:4:\"name\";s:32:\"Administration Development tools\";s:7:\"package\";s:14:\"Administration\";s:7:\"version\";s:11:\"7.x-3.0-rc5\";s:7:\"project\";s:10:\"admin_menu\";s:9:\"datestamp\";s:10:\"1419029284\";s:16:\"_info_file_ctime\";i:1549339110;}s:9:\"datestamp\";s:10:\"1419029284\";s:8:\"includes\";a:1:{s:11:\"admin_devel\";s:32:\"Administration Development tools\";}s:12:\"project_type\";s:6:\"module\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}}s:10:\"apachesolr\";a:8:{s:4:\"name\";s:10:\"apachesolr\";s:4:\"info\";a:6:{s:4:\"name\";s:21:\"Apache Solr framework\";s:7:\"package\";s:14:\"Search Toolkit\";s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:10:\"apachesolr\";s:9:\"datestamp\";s:10:\"1449085462\";s:16:\"_info_file_ctime\";i:1549339110;}s:9:\"datestamp\";s:10:\"1449085462\";s:8:\"includes\";a:1:{s:10:\"apachesolr\";s:21:\"Apache Solr framework\";}s:12:\"project_type\";s:6:\"module\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}}s:6:\"drupal\";a:8:{s:4:\"name\";s:6:\"drupal\";s:4:\"info\";a:6:{s:4:\"name\";s:5:\"Block\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:16:\"_info_file_ctime\";i:1548995168;}s:9:\"datestamp\";s:10:\"1547681965\";s:8:\"includes\";a:21:{s:5:\"block\";s:5:\"Block\";s:4:\"blog\";s:4:\"Blog\";s:9:\"dashboard\";s:9:\"Dashboard\";s:5:\"dblog\";s:16:\"Database logging\";s:5:\"field\";s:5:\"Field\";s:17:\"field_sql_storage\";s:17:\"Field SQL storage\";s:8:\"field_ui\";s:8:\"Field UI\";s:4:\"file\";s:4:\"File\";s:6:\"filter\";s:6:\"Filter\";s:5:\"image\";s:5:\"Image\";s:6:\"locale\";s:6:\"Locale\";s:4:\"menu\";s:4:\"Menu\";s:4:\"node\";s:4:\"Node\";s:6:\"syslog\";s:6:\"Syslog\";s:6:\"system\";s:6:\"System\";s:4:\"text\";s:4:\"Text\";s:7:\"toolbar\";s:7:\"Toolbar\";s:6:\"update\";s:14:\"Update manager\";s:4:\"user\";s:4:\"User\";s:6:\"bartik\";s:6:\"Bartik\";s:5:\"seven\";s:5:\"Seven\";}s:12:\"project_type\";s:4:\"core\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}}s:5:\"devel\";a:8:{s:4:\"name\";s:5:\"devel\";s:4:\"info\";a:6:{s:4:\"name\";s:5:\"Devel\";s:7:\"package\";s:11:\"Development\";s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:5:\"devel\";s:9:\"datestamp\";s:10:\"1398963366\";s:16:\"_info_file_ctime\";i:1549339141;}s:9:\"datestamp\";s:10:\"1398963366\";s:8:\"includes\";a:2:{s:5:\"devel\";s:5:\"Devel\";s:17:\"devel_node_access\";s:17:\"Devel node access\";}s:12:\"project_type\";s:6:\"module\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}}s:6:\"wweave\";a:8:{s:4:\"name\";s:6:\"wweave\";s:4:\"info\";a:6:{s:4:\"name\";s:6:\"wweave\";s:7:\"package\";s:6:\"Sonata\";s:7:\"version\";s:7:\"7.x-1.0\";s:7:\"project\";s:6:\"wweave\";s:16:\"_info_file_ctime\";i:1549339170;s:9:\"datestamp\";i:0;}s:9:\"datestamp\";i:0;s:8:\"includes\";a:1:{s:6:\"wweave\";s:6:\"wweave\";}s:12:\"project_type\";s:6:\"module\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}}}',1549348030,1549344430,1);

UNLOCK TABLES;

/*Table structure for table `date_format_locale` */

DROP TABLE IF EXISTS `date_format_locale`;

CREATE TABLE `date_format_locale` (
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';

/*Data for the table `date_format_locale` */

LOCK TABLES `date_format_locale` WRITE;

UNLOCK TABLES;

/*Table structure for table `date_format_type` */

DROP TABLE IF EXISTS `date_format_type`;

CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';

/*Data for the table `date_format_type` */

LOCK TABLES `date_format_type` WRITE;

insert  into `date_format_type`(`type`,`title`,`locked`) values 
('long','Long',1),
('medium','Medium',1),
('short','Short',1);

UNLOCK TABLES;

/*Table structure for table `date_formats` */

DROP TABLE IF EXISTS `date_formats`;

CREATE TABLE `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';

/*Data for the table `date_formats` */

LOCK TABLES `date_formats` WRITE;

insert  into `date_formats`(`dfid`,`format`,`type`,`locked`) values 
(1,'m/d/Y - H:i','short',1),
(2,'d/m/Y - H:i','short',1),
(3,'Y/m/d - H:i','short',1),
(4,'d.m.Y - H:i','short',1),
(5,'Y-m-d H:i','short',1),
(6,'m/d/Y - g:ia','short',1),
(7,'d/m/Y - g:ia','short',1),
(8,'Y/m/d - g:ia','short',1),
(9,'M j Y - H:i','short',1),
(10,'j M Y - H:i','short',1),
(11,'Y M j - H:i','short',1),
(12,'M j Y - g:ia','short',1),
(13,'j M Y - g:ia','short',1),
(14,'Y M j - g:ia','short',1),
(15,'D, m/d/Y - H:i','medium',1),
(16,'D, d/m/Y - H:i','medium',1),
(17,'D, Y/m/d - H:i','medium',1),
(18,'D, Y-m-d H:i','medium',1),
(19,'F j, Y - H:i','medium',1),
(20,'j F, Y - H:i','medium',1),
(21,'Y, F j - H:i','medium',1),
(22,'D, m/d/Y - g:ia','medium',1),
(23,'D, d/m/Y - g:ia','medium',1),
(24,'D, Y/m/d - g:ia','medium',1),
(25,'F j, Y - g:ia','medium',1),
(26,'j F Y - g:ia','medium',1),
(27,'Y, F j - g:ia','medium',1),
(28,'j. F Y - G:i','medium',1),
(29,'l, F j, Y - H:i','long',1),
(30,'l, j F, Y - H:i','long',1),
(31,'l, Y,  F j - H:i','long',1),
(32,'l, F j, Y - g:ia','long',1),
(33,'l, j F Y - g:ia','long',1),
(34,'l, Y,  F j - g:ia','long',1),
(35,'l, j. F Y - G:i','long',1);

UNLOCK TABLES;

/*Table structure for table `field_config` */

DROP TABLE IF EXISTS `field_config`;

CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `field_config` */

LOCK TABLES `field_config` WRITE;

insert  into `field_config`(`id`,`field_name`,`type`,`module`,`active`,`storage_type`,`storage_module`,`storage_active`,`locked`,`data`,`cardinality`,`translatable`,`deleted`) values 
(1,'body','text_with_summary','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:4:\"node\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}',1,0,0);

UNLOCK TABLES;

/*Table structure for table `field_config_instance` */

DROP TABLE IF EXISTS `field_config_instance`;

CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `field_config_instance` */

LOCK TABLES `field_config_instance` WRITE;

insert  into `field_config_instance`(`id`,`field_id`,`field_name`,`entity_type`,`bundle`,`data`,`deleted`) values 
(1,1,'body','node','blog','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";i:-4;s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0);

UNLOCK TABLES;

/*Table structure for table `field_data_body` */

DROP TABLE IF EXISTS `field_data_body`;

CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (body)';

/*Data for the table `field_data_body` */

LOCK TABLES `field_data_body` WRITE;

UNLOCK TABLES;

/*Table structure for table `field_revision_body` */

DROP TABLE IF EXISTS `field_revision_body`;

CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (body)';

/*Data for the table `field_revision_body` */

LOCK TABLES `field_revision_body` WRITE;

UNLOCK TABLES;

/*Table structure for table `file_managed` */

DROP TABLE IF EXISTS `file_managed`;

CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';

/*Data for the table `file_managed` */

LOCK TABLES `file_managed` WRITE;

UNLOCK TABLES;

/*Table structure for table `file_usage` */

DROP TABLE IF EXISTS `file_usage`;

CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';

/*Data for the table `file_usage` */

LOCK TABLES `file_usage` WRITE;

UNLOCK TABLES;

/*Table structure for table `filter` */

DROP TABLE IF EXISTS `filter`;

CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';

/*Data for the table `filter` */

LOCK TABLES `filter` WRITE;

insert  into `filter`(`format`,`module`,`name`,`weight`,`status`,`settings`) values 
('plain_text','filter','filter_autop',2,1,'a:0:{}'),
('plain_text','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}'),
('plain_text','filter','filter_htmlcorrector',10,0,'a:0:{}'),
('plain_text','filter','filter_html_escape',0,1,'a:0:{}'),
('plain_text','filter','filter_url',1,1,'a:1:{s:17:\"filter_url_length\";i:72;}');

UNLOCK TABLES;

/*Table structure for table `filter_format` */

DROP TABLE IF EXISTS `filter_format`;

CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';

/*Data for the table `filter_format` */

LOCK TABLES `filter_format` WRITE;

insert  into `filter_format`(`format`,`name`,`cache`,`status`,`weight`) values 
('plain_text','Plain text',1,1,10);

UNLOCK TABLES;

/*Table structure for table `flood` */

DROP TABLE IF EXISTS `flood`;

CREATE TABLE `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';

/*Data for the table `flood` */

LOCK TABLES `flood` WRITE;

UNLOCK TABLES;

/*Table structure for table `history` */

DROP TABLE IF EXISTS `history`;

CREATE TABLE `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';

/*Data for the table `history` */

LOCK TABLES `history` WRITE;

UNLOCK TABLES;

/*Table structure for table `image_effects` */

DROP TABLE IF EXISTS `image_effects`;

CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';

/*Data for the table `image_effects` */

LOCK TABLES `image_effects` WRITE;

UNLOCK TABLES;

/*Table structure for table `image_styles` */

DROP TABLE IF EXISTS `image_styles`;

CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';

/*Data for the table `image_styles` */

LOCK TABLES `image_styles` WRITE;

UNLOCK TABLES;

/*Table structure for table `languages` */

DROP TABLE IF EXISTS `languages`;

CREATE TABLE `languages` (
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'Language code, e.g. ’de’ or ’en-US’.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Language name in English.',
  `native` varchar(64) NOT NULL DEFAULT '' COMMENT 'Native language name.',
  `direction` int(11) NOT NULL DEFAULT '0' COMMENT 'Direction of language (Left-to-Right = 0, Right-to-Left = 1).',
  `enabled` int(11) NOT NULL DEFAULT '0' COMMENT 'Enabled flag (1 = Enabled, 0 = Disabled).',
  `plurals` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of plural indexes in this language.',
  `formula` varchar(255) NOT NULL DEFAULT '' COMMENT 'Plural formula in PHP code to evaluate to get plural indexes.',
  `domain` varchar(128) NOT NULL DEFAULT '' COMMENT 'Domain to use for this language.',
  `prefix` varchar(128) NOT NULL DEFAULT '' COMMENT 'Path prefix to use for this language.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight, used in lists of languages.',
  `javascript` varchar(64) NOT NULL DEFAULT '' COMMENT 'Location of JavaScript translation file.',
  PRIMARY KEY (`language`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of all available languages in the system.';

/*Data for the table `languages` */

LOCK TABLES `languages` WRITE;

insert  into `languages`(`language`,`name`,`native`,`direction`,`enabled`,`plurals`,`formula`,`domain`,`prefix`,`weight`,`javascript`) values 
('en','English','English',0,1,0,'','','',0,'');

UNLOCK TABLES;

/*Table structure for table `locales_source` */

DROP TABLE IF EXISTS `locales_source`;

CREATE TABLE `locales_source` (
  `lid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier of this string.',
  `location` longtext COMMENT 'Drupal path in case of online discovered translations or file path in case of imported strings.',
  `textgroup` varchar(255) NOT NULL DEFAULT 'default' COMMENT 'A module defined group of translations, see hook_locale().',
  `source` blob NOT NULL COMMENT 'The original string in English.',
  `context` varchar(255) NOT NULL DEFAULT '' COMMENT 'The context this string applies to.',
  `version` varchar(20) NOT NULL DEFAULT 'none' COMMENT 'Version of Drupal, where the string was last used (for locales optimization).',
  PRIMARY KEY (`lid`),
  KEY `source_context` (`source`(30),`context`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='List of English source strings.';

/*Data for the table `locales_source` */

LOCK TABLES `locales_source` WRITE;

insert  into `locales_source`(`lid`,`location`,`textgroup`,`source`,`context`,`version`) values 
(1,'misc/drupal.js','default','An AJAX HTTP error occurred.','','none'),
(2,'misc/drupal.js','default','HTTP Result Code: !status','','none'),
(3,'misc/drupal.js','default','An AJAX HTTP request terminated abnormally.','','none'),
(4,'misc/drupal.js','default','Debugging information follows.','','none'),
(5,'misc/drupal.js','default','Path: !uri','','none'),
(6,'misc/drupal.js','default','StatusText: !statusText','','none'),
(7,'misc/drupal.js','default','ResponseText: !responseText','','none'),
(8,'misc/drupal.js','default','ReadyState: !readyState','','none'),
(9,'misc/drupal.js','default','CustomMessage: !customMessage','','none'),
(10,'misc/collapse.js','default','Hide','','none'),
(11,'misc/collapse.js','default','Show','','none'),
(12,'modules/toolbar/toolbar.js','default','Show shortcuts','','none'),
(13,'modules/toolbar/toolbar.js','default','Hide shortcuts','','none'),
(14,'modules/dashboard/dashboard.js','default','Customize dashboard','','none'),
(15,'modules/dashboard/dashboard.js','default','Done','','none');

UNLOCK TABLES;

/*Table structure for table `locales_target` */

DROP TABLE IF EXISTS `locales_target`;

CREATE TABLE `locales_target` (
  `lid` int(11) NOT NULL DEFAULT '0' COMMENT 'Source string ID. References locales_source.lid.',
  `translation` blob NOT NULL COMMENT 'Translation string value in this language.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'Language code. References languages.language.',
  `plid` int(11) NOT NULL DEFAULT '0' COMMENT 'Parent lid (lid of the previous string in the plural chain) in case of plural strings. References locales_source.lid.',
  `plural` int(11) NOT NULL DEFAULT '0' COMMENT 'Plural index number in case of plural strings.',
  PRIMARY KEY (`language`,`lid`,`plural`),
  KEY `lid` (`lid`),
  KEY `plid` (`plid`),
  KEY `plural` (`plural`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores translated versions of strings.';

/*Data for the table `locales_target` */

LOCK TABLES `locales_target` WRITE;

UNLOCK TABLES;

/*Table structure for table `menu_custom` */

DROP TABLE IF EXISTS `menu_custom`;

CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';

/*Data for the table `menu_custom` */

LOCK TABLES `menu_custom` WRITE;

insert  into `menu_custom`(`menu_name`,`title`,`description`) values 
('devel','Development','Development link'),
('main-menu','Main menu','The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.'),
('management','Management','The <em>Management</em> menu contains links for administrative tasks.'),
('navigation','Navigation','The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.'),
('user-menu','User menu','The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.');

UNLOCK TABLES;

/*Table structure for table `menu_links` */

DROP TABLE IF EXISTS `menu_links`;

CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';

/*Data for the table `menu_links` */

LOCK TABLES `menu_links` WRITE;

insert  into `menu_links`(`menu_name`,`mlid`,`plid`,`link_path`,`router_path`,`link_title`,`options`,`module`,`hidden`,`external`,`has_children`,`expanded`,`weight`,`depth`,`customized`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`,`updated`) values 
('management',1,0,'admin','admin','Administration','a:0:{}','system',0,0,1,0,9,1,0,1,0,0,0,0,0,0,0,0,0),
('user-menu',2,0,'user','user','User account','a:1:{s:5:\"alter\";b:1;}','system',0,0,0,0,-10,1,0,2,0,0,0,0,0,0,0,0,0),
('navigation',3,0,'filter/tips','filter/tips','Compose tips','a:0:{}','system',1,0,1,0,0,1,0,3,0,0,0,0,0,0,0,0,0),
('navigation',4,0,'node/%','node/%','','a:0:{}','system',0,0,0,0,0,1,0,4,0,0,0,0,0,0,0,0,0),
('navigation',5,0,'node/add','node/add','Add content','a:0:{}','system',0,0,1,0,0,1,0,5,0,0,0,0,0,0,0,0,0),
('management',6,1,'admin/appearance','admin/appearance','Appearance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"Select and configure your themes.\";}}','system',0,0,0,0,-6,2,0,1,6,0,0,0,0,0,0,0,0),
('management',7,1,'admin/config','admin/config','Configuration','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:20:\"Administer settings.\";}}','system',0,0,1,0,0,2,0,1,7,0,0,0,0,0,0,0,0),
('management',8,1,'admin/content','admin/content','Content','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Find and manage content.\";}}','system',0,0,0,0,-10,2,0,1,8,0,0,0,0,0,0,0,0),
('user-menu',9,2,'user/register','user/register','Create new account','a:0:{}','system',-1,0,0,0,0,2,0,2,9,0,0,0,0,0,0,0,0),
('management',10,1,'admin/index','admin/index','Index','a:0:{}','system',-1,0,0,0,-18,2,0,1,10,0,0,0,0,0,0,0,0),
('user-menu',11,2,'user/login','user/login','Log in','a:0:{}','system',-1,0,0,0,0,2,0,2,11,0,0,0,0,0,0,0,0),
('user-menu',12,0,'user/logout','user/logout','Log out','a:0:{}','system',0,0,0,0,10,1,0,12,0,0,0,0,0,0,0,0,0),
('management',13,1,'admin/modules','admin/modules','Modules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:26:\"Extend site functionality.\";}}','system',0,0,0,0,-2,2,0,1,13,0,0,0,0,0,0,0,0),
('navigation',14,0,'user/%','user/%','My account','a:0:{}','system',0,0,1,0,0,1,0,14,0,0,0,0,0,0,0,0,0),
('management',15,1,'admin/people','admin/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Manage user accounts, roles, and permissions.\";}}','system',0,0,0,0,-4,2,0,1,15,0,0,0,0,0,0,0,0),
('management',16,1,'admin/reports','admin/reports','Reports','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View reports, updates, and errors.\";}}','system',0,0,1,0,5,2,0,1,16,0,0,0,0,0,0,0,0),
('user-menu',17,2,'user/password','user/password','Request new password','a:0:{}','system',-1,0,0,0,0,2,0,2,17,0,0,0,0,0,0,0,0),
('management',18,1,'admin/structure','admin/structure','Structure','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Administer blocks, content types, menus, etc.\";}}','system',0,0,1,0,-8,2,0,1,18,0,0,0,0,0,0,0,0),
('management',19,1,'admin/tasks','admin/tasks','Tasks','a:0:{}','system',-1,0,0,0,-20,2,0,1,19,0,0,0,0,0,0,0,0),
('navigation',20,3,'filter/tips/%','filter/tips/%','Compose tips','a:0:{}','system',0,0,0,0,0,2,0,3,20,0,0,0,0,0,0,0,0),
('management',21,15,'admin/people/create','admin/people/create','Add user','a:0:{}','system',-1,0,0,0,0,3,0,1,15,21,0,0,0,0,0,0,0),
('management',22,18,'admin/structure/block','admin/structure/block','Blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:79:\"Configure what block content appears in your site\'s sidebars and other regions.\";}}','system',0,0,1,0,0,3,0,1,18,22,0,0,0,0,0,0,0),
('navigation',23,14,'user/%/cancel','user/%/cancel','Cancel account','a:0:{}','system',0,0,1,0,0,2,0,14,23,0,0,0,0,0,0,0,0),
('management',24,8,'admin/content/node','admin/content/node','Content','a:0:{}','system',-1,0,0,0,-10,3,0,1,8,24,0,0,0,0,0,0,0),
('management',25,7,'admin/config/content','admin/config/content','Content authoring','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Settings related to formatting and authoring content.\";}}','system',0,0,1,0,-15,3,0,1,7,25,0,0,0,0,0,0,0),
('management',26,18,'admin/structure/types','admin/structure/types','Content types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:92:\"Manage content types, including default status, front page promotion, comment settings, etc.\";}}','system',0,0,1,0,0,3,0,1,18,26,0,0,0,0,0,0,0),
('navigation',27,4,'node/%/delete','node/%/delete','Delete','a:0:{}','system',-1,0,0,0,1,2,0,4,27,0,0,0,0,0,0,0,0),
('management',28,7,'admin/config/development','admin/config/development','Development','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Development tools.\";}}','system',0,0,1,0,-10,3,0,1,7,28,0,0,0,0,0,0,0),
('navigation',29,14,'user/%/edit','user/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,14,29,0,0,0,0,0,0,0,0),
('navigation',30,4,'node/%/edit','node/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,4,30,0,0,0,0,0,0,0,0),
('management',31,13,'admin/modules/list','admin/modules/list','List','a:0:{}','system',-1,0,0,0,0,3,0,1,13,31,0,0,0,0,0,0,0),
('management',32,15,'admin/people/people','admin/people/people','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:50:\"Find and manage people interacting with your site.\";}}','system',-1,0,0,0,-10,3,0,1,15,32,0,0,0,0,0,0,0),
('management',33,6,'admin/appearance/list','admin/appearance/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Select and configure your theme\";}}','system',-1,0,0,0,-1,3,0,1,6,33,0,0,0,0,0,0,0),
('management',34,7,'admin/config/media','admin/config/media','Media','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:12:\"Media tools.\";}}','system',0,0,1,0,-10,3,0,1,7,34,0,0,0,0,0,0,0),
('management',35,7,'admin/config/people','admin/config/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Configure user accounts.\";}}','system',0,0,1,0,-20,3,0,1,7,35,0,0,0,0,0,0,0),
('management',36,15,'admin/people/permissions','admin/people/permissions','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,0,3,0,1,15,36,0,0,0,0,0,0,0),
('management',37,16,'admin/reports/dblog','admin/reports/dblog','Recent log messages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"View events that have recently been logged.\";}}','system',0,0,0,0,-1,3,0,1,16,37,0,0,0,0,0,0,0),
('management',38,7,'admin/config/regional','admin/config/regional','Regional and language','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Regional settings, localization and translation.\";}}','system',0,0,1,0,-5,3,0,1,7,38,0,0,0,0,0,0,0),
('navigation',39,4,'node/%/revisions','node/%/revisions','Revisions','a:0:{}','system',-1,0,1,0,2,2,0,4,39,0,0,0,0,0,0,0,0),
('management',40,7,'admin/config/search','admin/config/search','Search and metadata','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Local site search, metadata and SEO.\";}}','system',0,0,1,0,-10,3,0,1,7,40,0,0,0,0,0,0,0),
('management',41,6,'admin/appearance/settings','admin/appearance/settings','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Configure default and theme specific settings.\";}}','system',-1,0,0,0,20,3,0,1,6,41,0,0,0,0,0,0,0),
('management',42,16,'admin/reports/status','admin/reports/status','Status report','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Get a status report about your site\'s operation and any detected problems.\";}}','system',0,0,0,0,-60,3,0,1,16,42,0,0,0,0,0,0,0),
('management',43,7,'admin/config/system','admin/config/system','System','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"General system related configuration.\";}}','system',0,0,1,0,-20,3,0,1,7,43,0,0,0,0,0,0,0),
('management',44,16,'admin/reports/access-denied','admin/reports/access-denied','Top \'access denied\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:35:\"View \'access denied\' errors (403s).\";}}','system',0,0,0,0,0,3,0,1,16,44,0,0,0,0,0,0,0),
('management',45,16,'admin/reports/page-not-found','admin/reports/page-not-found','Top \'page not found\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"View \'page not found\' errors (404s).\";}}','system',0,0,0,0,0,3,0,1,16,45,0,0,0,0,0,0,0),
('management',46,13,'admin/modules/uninstall','admin/modules/uninstall','Uninstall','a:0:{}','system',-1,0,0,0,20,3,0,1,13,46,0,0,0,0,0,0,0),
('management',47,7,'admin/config/user-interface','admin/config/user-interface','User interface','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Tools that enhance the user interface.\";}}','system',0,0,0,0,-15,3,0,1,7,47,0,0,0,0,0,0,0),
('navigation',48,4,'node/%/view','node/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,4,48,0,0,0,0,0,0,0,0),
('navigation',49,14,'user/%/view','user/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,14,49,0,0,0,0,0,0,0,0),
('management',50,7,'admin/config/services','admin/config/services','Web services','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"Tools related to web services.\";}}','system',0,0,1,0,0,3,0,1,7,50,0,0,0,0,0,0,0),
('management',51,7,'admin/config/workflow','admin/config/workflow','Workflow','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Content workflow, editorial workflow tools.\";}}','system',0,0,0,0,5,3,0,1,7,51,0,0,0,0,0,0,0),
('management',52,35,'admin/config/people/accounts','admin/config/people/accounts','Account settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:109:\"Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.\";}}','system',0,0,0,0,-10,4,0,1,7,35,52,0,0,0,0,0,0),
('management',53,43,'admin/config/system/actions','admin/config/system/actions','Actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',0,0,1,0,0,4,0,1,7,43,53,0,0,0,0,0,0),
('management',54,22,'admin/structure/block/add','admin/structure/block/add','Add block','a:0:{}','system',-1,0,0,0,0,4,0,1,18,22,54,0,0,0,0,0,0),
('management',55,26,'admin/structure/types/add','admin/structure/types/add','Add content type','a:0:{}','system',-1,0,0,0,0,4,0,1,18,26,55,0,0,0,0,0,0),
('management',57,41,'admin/appearance/settings/bartik','admin/appearance/settings/bartik','Bartik','a:0:{}','system',-1,0,0,0,0,4,0,1,6,41,57,0,0,0,0,0,0),
('management',58,40,'admin/config/search/clean-urls','admin/config/search/clean-urls','Clean URLs','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Enable or disable clean URLs for your site.\";}}','system',0,0,0,0,5,4,0,1,7,40,58,0,0,0,0,0,0),
('management',60,43,'admin/config/system/cron','admin/config/system/cron','Cron','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:40:\"Manage automatic site maintenance tasks.\";}}','system',0,0,0,0,20,4,0,1,7,43,60,0,0,0,0,0,0),
('management',61,38,'admin/config/regional/date-time','admin/config/regional/date-time','Date and time','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',0,0,0,0,-15,4,0,1,7,38,61,0,0,0,0,0,0),
('management',62,16,'admin/reports/event/%','admin/reports/event/%','Details','a:0:{}','system',0,0,0,0,0,3,0,1,16,62,0,0,0,0,0,0,0),
('management',63,34,'admin/config/media/file-system','admin/config/media/file-system','File system','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:68:\"Tell Drupal where to store uploaded files and how they are accessed.\";}}','system',0,0,0,0,-10,4,0,1,7,34,63,0,0,0,0,0,0),
('management',64,41,'admin/appearance/settings/garland','admin/appearance/settings/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,1,6,41,64,0,0,0,0,0,0),
('management',65,41,'admin/appearance/settings/global','admin/appearance/settings/global','Global settings','a:0:{}','system',-1,0,0,0,-1,4,0,1,6,41,65,0,0,0,0,0,0),
('management',68,35,'admin/config/people/ip-blocking','admin/config/people/ip-blocking','IP address blocking','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Manage blocked IP addresses.\";}}','system',0,0,1,0,10,4,0,1,7,35,68,0,0,0,0,0,0),
('management',69,34,'admin/config/media/image-toolkit','admin/config/media/image-toolkit','Image toolkit','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Choose which image toolkit to use if you have installed optional toolkits.\";}}','system',0,0,0,0,20,4,0,1,7,34,69,0,0,0,0,0,0),
('management',70,26,'admin/structure/types/list','admin/structure/types/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,18,26,70,0,0,0,0,0,0),
('management',71,31,'admin/modules/list/confirm','admin/modules/list/confirm','List','a:0:{}','system',-1,0,0,0,0,4,0,1,13,31,71,0,0,0,0,0,0),
('management',72,28,'admin/config/development/logging','admin/config/development/logging','Logging and errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:154:\"Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.\";}}','system',0,0,0,0,-15,4,0,1,7,28,72,0,0,0,0,0,0),
('management',73,28,'admin/config/development/maintenance','admin/config/development/maintenance','Maintenance mode','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:62:\"Take the site offline for maintenance or bring it back online.\";}}','system',0,0,0,0,-10,4,0,1,7,28,73,0,0,0,0,0,0),
('management',75,28,'admin/config/development/performance','admin/config/development/performance','Performance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:101:\"Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.\";}}','system',0,0,0,0,-20,4,0,1,7,28,75,0,0,0,0,0,0),
('management',76,36,'admin/people/permissions/list','admin/people/permissions/list','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,-8,4,0,1,15,36,76,0,0,0,0,0,0),
('management',77,50,'admin/config/services/rss-publishing','admin/config/services/rss-publishing','RSS publishing','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:114:\"Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.\";}}','system',0,0,0,0,0,4,0,1,7,50,77,0,0,0,0,0,0),
('management',78,38,'admin/config/regional/settings','admin/config/regional/settings','Regional settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:54:\"Settings for the site\'s default time zone and country.\";}}','system',0,0,0,0,-20,4,0,1,7,38,78,0,0,0,0,0,0),
('management',79,36,'admin/people/permissions/roles','admin/people/permissions/roles','Roles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"List, edit, or add user roles.\";}}','system',-1,0,1,0,-5,4,0,1,15,36,79,0,0,0,0,0,0),
('management',80,41,'admin/appearance/settings/seven','admin/appearance/settings/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,1,6,41,80,0,0,0,0,0,0),
('management',81,43,'admin/config/system/site-information','admin/config/system/site-information','Site information','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:104:\"Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.\";}}','system',0,0,0,0,-20,4,0,1,7,43,81,0,0,0,0,0,0),
('management',82,41,'admin/appearance/settings/stark','admin/appearance/settings/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,1,6,41,82,0,0,0,0,0,0),
('management',83,25,'admin/config/content/formats','admin/config/content/formats','Text formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:127:\"Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.\";}}','system',0,0,1,0,0,4,0,1,7,25,83,0,0,0,0,0,0),
('management',84,46,'admin/modules/uninstall/confirm','admin/modules/uninstall/confirm','Uninstall','a:0:{}','system',-1,0,0,0,0,4,0,1,13,46,84,0,0,0,0,0,0),
('navigation',87,29,'user/%/edit/account','user/%/edit/account','Account','a:0:{}','system',-1,0,0,0,0,3,0,14,29,87,0,0,0,0,0,0,0),
('management',88,83,'admin/config/content/formats/%','admin/config/content/formats/%','','a:0:{}','system',0,0,1,0,0,5,0,1,7,25,83,88,0,0,0,0,0),
('management',89,83,'admin/config/content/formats/add','admin/config/content/formats/add','Add text format','a:0:{}','system',-1,0,0,0,1,5,0,1,7,25,83,89,0,0,0,0,0),
('management',91,22,'admin/structure/block/list/bartik','admin/structure/block/list/bartik','Bartik','a:0:{}','system',-1,0,0,0,-10,4,0,1,18,22,91,0,0,0,0,0,0),
('management',93,53,'admin/config/system/actions/configure','admin/config/system/actions/configure','Configure an advanced action','a:0:{}','system',-1,0,0,0,0,5,0,1,7,43,53,93,0,0,0,0,0),
('management',94,26,'admin/structure/types/manage/%','admin/structure/types/manage/%','Edit content type','a:0:{}','system',0,0,1,0,0,4,0,1,18,26,94,0,0,0,0,0,0),
('management',95,61,'admin/config/regional/date-time/formats','admin/config/regional/date-time/formats','Formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:51:\"Configure display format strings for date and time.\";}}','system',-1,0,1,0,-9,5,0,1,7,38,61,95,0,0,0,0,0),
('management',96,22,'admin/structure/block/list/garland','admin/structure/block/list/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,1,18,22,96,0,0,0,0,0,0),
('management',99,83,'admin/config/content/formats/list','admin/config/content/formats/list','List','a:0:{}','system',-1,0,0,0,0,5,0,1,7,25,83,99,0,0,0,0,0),
('management',100,53,'admin/config/system/actions/manage','admin/config/system/actions/manage','Manage actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',-1,0,0,0,-2,5,0,1,7,43,53,100,0,0,0,0,0),
('management',102,52,'admin/config/people/accounts/settings','admin/config/people/accounts/settings','Settings','a:0:{}','system',-1,0,0,0,-10,5,0,1,7,35,52,102,0,0,0,0,0),
('management',103,22,'admin/structure/block/list/seven','admin/structure/block/list/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,1,18,22,103,0,0,0,0,0,0),
('management',104,22,'admin/structure/block/list/stark','admin/structure/block/list/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,1,18,22,104,0,0,0,0,0,0),
('management',105,61,'admin/config/regional/date-time/types','admin/config/regional/date-time/types','Types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',-1,0,1,0,-10,5,0,1,7,38,61,105,0,0,0,0,0),
('navigation',108,39,'node/%/revisions/%/delete','node/%/revisions/%/delete','Delete earlier revision','a:0:{}','system',0,0,0,0,0,3,0,4,39,108,0,0,0,0,0,0,0),
('navigation',109,39,'node/%/revisions/%/revert','node/%/revisions/%/revert','Revert to earlier revision','a:0:{}','system',0,0,0,0,0,3,0,4,39,109,0,0,0,0,0,0,0),
('navigation',110,39,'node/%/revisions/%/view','node/%/revisions/%/view','Revisions','a:0:{}','system',0,0,0,0,0,3,0,4,39,110,0,0,0,0,0,0,0),
('management',113,96,'admin/structure/block/list/garland/add','admin/structure/block/list/garland/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,18,22,96,113,0,0,0,0,0),
('management',119,104,'admin/structure/block/list/stark/add','admin/structure/block/list/stark/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,18,22,104,119,0,0,0,0,0),
('management',121,105,'admin/config/regional/date-time/types/add','admin/config/regional/date-time/types/add','Add date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Add new date type.\";}}','system',-1,0,0,0,-10,6,0,1,7,38,61,105,121,0,0,0,0),
('management',122,95,'admin/config/regional/date-time/formats/add','admin/config/regional/date-time/formats/add','Add format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Allow users to add additional date formats.\";}}','system',-1,0,0,0,-10,6,0,1,7,38,61,95,122,0,0,0,0),
('management',123,22,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Configure block','a:0:{}','system',0,0,0,0,0,4,0,1,18,22,123,0,0,0,0,0,0),
('navigation',124,23,'user/%/cancel/confirm/%/%','user/%/cancel/confirm/%/%','Confirm account cancellation','a:0:{}','system',0,0,0,0,0,3,0,14,23,124,0,0,0,0,0,0,0),
('management',125,94,'admin/structure/types/manage/%/delete','admin/structure/types/manage/%/delete','Delete','a:0:{}','system',0,0,0,0,0,5,0,1,18,26,94,125,0,0,0,0,0),
('management',126,68,'admin/config/people/ip-blocking/delete/%','admin/config/people/ip-blocking/delete/%','Delete IP address','a:0:{}','system',0,0,0,0,0,5,0,1,7,35,68,126,0,0,0,0,0),
('management',127,53,'admin/config/system/actions/delete/%','admin/config/system/actions/delete/%','Delete action','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"Delete an action.\";}}','system',0,0,0,0,0,5,0,1,7,43,53,127,0,0,0,0,0),
('management',128,79,'admin/people/permissions/roles/delete/%','admin/people/permissions/roles/delete/%','Delete role','a:0:{}','system',0,0,0,0,0,5,0,1,15,36,79,128,0,0,0,0,0),
('management',129,88,'admin/config/content/formats/%/disable','admin/config/content/formats/%/disable','Disable text format','a:0:{}','system',0,0,0,0,0,6,0,1,7,25,83,88,129,0,0,0,0),
('management',130,94,'admin/structure/types/manage/%/edit','admin/structure/types/manage/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,5,0,1,18,26,94,130,0,0,0,0,0),
('management',131,79,'admin/people/permissions/roles/edit/%','admin/people/permissions/roles/edit/%','Edit role','a:0:{}','system',0,0,0,0,0,5,0,1,15,36,79,131,0,0,0,0,0),
('management',132,123,'admin/structure/block/manage/%/%/configure','admin/structure/block/manage/%/%/configure','Configure block','a:0:{}','system',-1,0,0,0,0,5,0,1,18,22,123,132,0,0,0,0,0),
('management',133,123,'admin/structure/block/manage/%/%/delete','admin/structure/block/manage/%/%/delete','Delete block','a:0:{}','system',-1,0,0,0,0,5,0,1,18,22,123,133,0,0,0,0,0),
('management',134,95,'admin/config/regional/date-time/formats/%/delete','admin/config/regional/date-time/formats/%/delete','Delete date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Allow users to delete a configured date format.\";}}','system',0,0,0,0,0,6,0,1,7,38,61,95,134,0,0,0,0),
('management',135,105,'admin/config/regional/date-time/types/%/delete','admin/config/regional/date-time/types/%/delete','Delete date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to delete a configured date type.\";}}','system',0,0,0,0,0,6,0,1,7,38,61,105,135,0,0,0,0),
('management',136,95,'admin/config/regional/date-time/formats/%/edit','admin/config/regional/date-time/formats/%/edit','Edit date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to edit a configured date format.\";}}','system',0,0,0,0,0,6,0,1,7,38,61,95,136,0,0,0,0),
('management',137,16,'admin/reports/updates','admin/reports/updates','Available updates','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:82:\"Get a status report about available updates for your installed modules and themes.\";}}','system',0,0,0,0,-50,3,0,1,16,137,0,0,0,0,0,0,0),
('management',138,13,'admin/modules/install','admin/modules/install','Install new module','a:0:{}','system',-1,0,0,0,25,3,0,1,13,138,0,0,0,0,0,0,0),
('management',139,6,'admin/appearance/install','admin/appearance/install','Install new theme','a:0:{}','system',-1,0,0,0,25,3,0,1,6,139,0,0,0,0,0,0,0),
('management',140,13,'admin/modules/update','admin/modules/update','Update','a:0:{}','system',-1,0,0,0,10,3,0,1,13,140,0,0,0,0,0,0,0),
('management',141,6,'admin/appearance/update','admin/appearance/update','Update','a:0:{}','system',-1,0,0,0,10,3,0,1,6,141,0,0,0,0,0,0,0),
('management',142,137,'admin/reports/updates/list','admin/reports/updates/list','List','a:0:{}','system',-1,0,0,0,0,4,0,1,16,137,142,0,0,0,0,0,0),
('management',143,137,'admin/reports/updates/settings','admin/reports/updates/settings','Settings','a:0:{}','system',-1,0,0,0,50,4,0,1,16,137,143,0,0,0,0,0,0),
('management',144,137,'admin/reports/updates/install','admin/reports/updates/install','Install new module or theme','a:0:{}','system',-1,0,0,0,25,4,0,1,16,137,144,0,0,0,0,0,0),
('management',145,137,'admin/reports/updates/update','admin/reports/updates/update','Update','a:0:{}','system',-1,0,0,0,10,4,0,1,16,137,145,0,0,0,0,0,0),
('management',146,1,'admin/dashboard','admin/dashboard','Dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View and customize your dashboard.\";}}','system',0,0,0,0,-15,2,0,1,146,0,0,0,0,0,0,0,0),
('management',147,146,'admin/dashboard/configure','admin/dashboard/configure','Configure available dashboard blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Configure which blocks can be shown on the dashboard.\";}}','system',-1,0,0,0,0,3,0,1,146,147,0,0,0,0,0,0,0),
('management',148,146,'admin/dashboard/customize','admin/dashboard/customize','Customize dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Customize your dashboard.\";}}','system',-1,0,0,0,0,3,0,1,146,148,0,0,0,0,0,0,0),
('management',149,41,'admin/appearance/settings/wweave','admin/appearance/settings/wweave','wweave','a:0:{}','system',-1,0,0,0,0,4,0,1,6,41,149,0,0,0,0,0,0),
('management',150,22,'admin/structure/block/list/wweave','admin/structure/block/list/wweave','wweave','a:0:{}','system',-1,0,0,0,0,4,0,1,18,22,150,0,0,0,0,0,0),
('navigation',154,0,'blog','blog','Blogs','a:0:{}','system',1,0,1,0,0,1,0,154,0,0,0,0,0,0,0,0,0),
('navigation',155,154,'blog/%','blog/%','My blog','a:0:{}','system',0,0,0,0,0,2,0,154,155,0,0,0,0,0,0,0,0),
('devel',156,0,'devel/settings','devel/settings','Devel settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:175:\"Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href=\"/ww_cms/admin/structure/block\">block administration</a> page.\";}}','system',0,0,0,0,0,1,0,156,0,0,0,0,0,0,0,0,0),
('devel',157,0,'devel/php','devel/php','Execute PHP Code','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:21:\"Execute some PHP code\";}}','system',0,0,0,0,0,1,0,157,0,0,0,0,0,0,0,0,0),
('devel',158,0,'devel/reference','devel/reference','Function reference','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:73:\"View a list of currently defined user functions with documentation links.\";}}','system',0,0,0,0,0,1,0,158,0,0,0,0,0,0,0,0,0),
('devel',159,0,'devel/elements','devel/elements','Hook_elements()','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:51:\"View the active form/render elements for this site.\";}}','system',0,0,0,0,0,1,0,159,0,0,0,0,0,0,0,0,0),
('devel',160,0,'devel/phpinfo','devel/phpinfo','PHPinfo()','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"View your server\'s PHP configuration\";}}','system',0,0,0,0,0,1,0,160,0,0,0,0,0,0,0,0,0),
('devel',161,0,'devel/reinstall','devel/reinstall','Reinstall modules','a:2:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Run hook_uninstall() and then hook_install() for a given module.\";}s:5:\"alter\";b:1;}','system',0,0,0,0,0,1,0,161,0,0,0,0,0,0,0,0,0),
('devel',162,0,'devel/run-cron','devel/run-cron','Run cron','a:0:{}','system',0,0,0,0,0,1,0,162,0,0,0,0,0,0,0,0,0),
('devel',163,0,'devel/session','devel/session','Session viewer','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"List the contents of $_SESSION.\";}}','system',0,0,0,0,0,1,0,163,0,0,0,0,0,0,0,0,0),
('devel',164,0,'devel/variable','devel/variable','Variable editor','a:2:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Edit and delete site variables.\";}s:5:\"alter\";b:1;}','system',0,0,0,0,0,1,0,164,0,0,0,0,0,0,0,0,0),
('navigation',165,0,'comment/%comment/devel','comment/%comment/devel','Devel','a:0:{}','system',-1,0,0,0,100,1,0,165,0,0,0,0,0,0,0,0,0),
('management',166,1,'admin/settings/oapachesolr_custom_results','admin/settings/oapachesolr_custom_results','Apache Solr Custom Results','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Settings for how your Solr search results should look\";}}','system',0,0,0,0,0,2,0,1,166,0,0,0,0,0,0,0,0),
('management',167,16,'admin/reports/apachesolr','admin/reports/apachesolr','Apache Solr search index','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:57:\"Information about the contents of the index on the server\";}}','system',0,0,1,0,0,3,0,1,16,167,0,0,0,0,0,0,0),
('navigation',168,5,'node/add/blog','node/add/blog','Blog entry','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:58:\"Use for multi-user blogs. Every user gets a personal blog.\";}}','system',0,0,0,0,0,2,0,5,168,0,0,0,0,0,0,0,0),
('devel',169,0,'devel/cache/clear','devel/cache/clear','Clear cache','a:2:{s:10:\"attributes\";a:1:{s:5:\"title\";s:100:\"Clear the CSS cache and all database cache tables which store page, node, theme and variable caches.\";}s:5:\"alter\";b:1;}','system',0,0,0,0,0,1,0,169,0,0,0,0,0,0,0,0,0),
('navigation',170,4,'node/%/devel','node/%/devel','Devel','a:0:{}','system',-1,0,0,0,100,2,0,4,170,0,0,0,0,0,0,0,0),
('navigation',171,14,'user/%/devel','user/%/devel','Devel','a:0:{}','system',-1,0,0,0,100,2,0,14,171,0,0,0,0,0,0,0,0),
('devel',172,0,'devel/entity/info','devel/entity/info','Entity info','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"View entity information across the whole site.\";}}','system',0,0,0,0,0,1,0,172,0,0,0,0,0,0,0,0,0),
('devel',173,0,'devel/field/info','devel/field/info','Field info','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"View fields information across the whole site.\";}}','system',0,0,0,0,0,1,0,173,0,0,0,0,0,0,0,0,0),
('devel',174,0,'devel/menu/item','devel/menu/item','Menu item','a:2:{s:10:\"attributes\";a:1:{s:5:\"title\";s:32:\"Details about a given menu item.\";}s:5:\"alter\";b:1;}','system',0,0,0,0,0,1,0,174,0,0,0,0,0,0,0,0,0),
('management',175,18,'admin/structure/menu','admin/structure/menu','Menus','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:86:\"Add new menus to your site, edit existing menus, and rename and reorganize menu links.\";}}','system',0,0,1,0,0,3,0,1,18,175,0,0,0,0,0,0,0),
('devel',176,0,'devel/menu/reset','devel/menu/reset','Rebuild menus','a:2:{s:10:\"attributes\";a:1:{s:5:\"title\";s:113:\"Rebuild menu based on hook_menu() and revert any custom changes. All menu items return to their default settings.\";}s:5:\"alter\";b:1;}','system',0,0,0,0,0,1,0,176,0,0,0,0,0,0,0,0,0),
('devel',177,0,'devel/theme/registry','devel/theme/registry','Theme registry','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:63:\"View a list of available theme functions across the whole site.\";}}','system',0,0,0,0,0,1,0,177,0,0,0,0,0,0,0,0,0),
('navigation',178,0,'taxonomy/term/%taxonomy_term/devel','taxonomy/term/%taxonomy_term/devel','Devel','a:0:{}','system',-1,0,0,0,100,1,0,178,0,0,0,0,0,0,0,0,0),
('navigation',179,165,'comment/%comment/devel/load','comment/%comment/devel/load','Load','a:0:{}','system',-1,0,0,0,0,2,0,165,179,0,0,0,0,0,0,0,0),
('navigation',180,165,'comment/%comment/devel/render','comment/%comment/devel/render','Render','a:0:{}','system',-1,0,0,0,100,2,0,165,180,0,0,0,0,0,0,0,0),
('management',181,175,'admin/structure/menu/add','admin/structure/menu/add','Add menu','a:0:{}','system',-1,0,0,0,0,4,0,1,18,175,181,0,0,0,0,0,0),
('navigation',182,170,'node/%/devel/apachesolr','node/%/devel/apachesolr','Apache Solr','a:0:{}','system',-1,0,0,0,0,3,0,4,170,182,0,0,0,0,0,0,0),
('management',183,40,'admin/config/search/apachesolr','admin/config/search/apachesolr','Apache Solr search','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:23:\"Administer Apache Solr.\";}}','system',0,0,0,0,-8,4,0,1,7,40,183,0,0,0,0,0,0),
('management',184,167,'admin/reports/apachesolr/%','admin/reports/apachesolr/%','Apache Solr search index','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:57:\"Information about the contents of the index on the server\";}}','system',0,0,0,0,0,4,0,1,16,167,184,0,0,0,0,0,0),
('management',185,28,'admin/config/development/devel','admin/config/development/devel','Devel settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:175:\"Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href=\"/ww_cms/admin/structure/block\">block administration</a> page.\";}}','system',0,0,0,0,0,4,0,1,7,28,185,0,0,0,0,0,0),
('navigation',186,170,'node/%/devel/render','node/%/devel/render','Render','a:0:{}','system',-1,0,0,0,100,3,0,4,170,186,0,0,0,0,0,0,0),
('navigation',187,171,'user/%/devel/render','user/%/devel/render','Render','a:0:{}','system',-1,0,0,0,100,3,0,14,171,187,0,0,0,0,0,0,0),
('management',188,175,'admin/structure/menu/list','admin/structure/menu/list','List menus','a:0:{}','system',-1,0,0,0,-10,4,0,1,18,175,188,0,0,0,0,0,0),
('navigation',189,170,'node/%/devel/load','node/%/devel/load','Load','a:0:{}','system',-1,0,0,0,0,3,0,4,170,189,0,0,0,0,0,0,0),
('navigation',190,171,'user/%/devel/load','user/%/devel/load','Load','a:0:{}','system',-1,0,0,0,0,3,0,14,171,190,0,0,0,0,0,0,0),
('management',191,175,'admin/structure/menu/settings','admin/structure/menu/settings','Settings','a:0:{}','system',-1,0,0,0,5,4,0,1,18,175,191,0,0,0,0,0,0),
('navigation',192,178,'taxonomy/term/%taxonomy_term/devel/load','taxonomy/term/%taxonomy_term/devel/load','Load','a:0:{}','system',-1,0,0,0,0,2,0,178,192,0,0,0,0,0,0,0,0),
('navigation',193,178,'taxonomy/term/%taxonomy_term/devel/render','taxonomy/term/%taxonomy_term/devel/render','Render','a:0:{}','system',-1,0,0,0,100,2,0,178,193,0,0,0,0,0,0,0,0),
('management',194,184,'admin/reports/apachesolr/%/conf','admin/reports/apachesolr/%/conf','Configuration files','a:0:{}','system',-1,0,0,0,5,5,0,1,16,167,184,194,0,0,0,0,0),
('management',195,175,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Customize menu','a:0:{}','system',0,0,1,0,0,4,0,1,18,175,195,0,0,0,0,0,0),
('management',196,183,'admin/config/search/apachesolr/index','admin/config/search/apachesolr/index','Default index','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:23:\"Administer Apache Solr.\";}}','system',-1,0,0,0,-8,5,0,1,7,40,183,196,0,0,0,0,0),
('management',197,184,'admin/reports/apachesolr/%/index','admin/reports/apachesolr/%/index','Search index','a:0:{}','system',-1,0,0,0,0,5,0,1,16,167,184,197,0,0,0,0,0),
('management',198,183,'admin/config/search/apachesolr/settings','admin/config/search/apachesolr/settings','Settings','a:0:{}','system',-1,0,1,0,10,5,0,1,7,40,183,198,0,0,0,0,0),
('management',199,195,'admin/structure/menu/manage/%/add','admin/structure/menu/manage/%/add','Add link','a:0:{}','system',-1,0,0,0,0,5,0,1,18,175,195,199,0,0,0,0,0),
('management',200,198,'admin/config/search/apachesolr/settings/add','admin/config/search/apachesolr/settings/add','Add search environment','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Add Apache Solr environment.\";}}','system',-1,0,0,0,0,6,0,1,7,40,183,198,200,0,0,0,0),
('management',201,195,'admin/structure/menu/manage/%/delete','admin/structure/menu/manage/%/delete','Delete menu','a:0:{}','system',0,0,0,0,0,5,0,1,18,175,195,201,0,0,0,0,0),
('management',202,175,'admin/structure/menu/item/%/delete','admin/structure/menu/item/%/delete','Delete menu link','a:0:{}','system',0,0,0,0,0,4,0,1,18,175,202,0,0,0,0,0,0),
('management',203,195,'admin/structure/menu/manage/%/edit','admin/structure/menu/manage/%/edit','Edit menu','a:0:{}','system',-1,0,0,0,0,5,0,1,18,175,195,203,0,0,0,0,0),
('management',204,175,'admin/structure/menu/item/%/edit','admin/structure/menu/item/%/edit','Edit menu link','a:0:{}','system',0,0,0,0,0,4,0,1,18,175,204,0,0,0,0,0,0),
('management',205,195,'admin/structure/menu/manage/%/list','admin/structure/menu/manage/%/list','List links','a:0:{}','system',-1,0,0,0,-10,5,0,1,18,175,195,205,0,0,0,0,0),
('management',206,175,'admin/structure/menu/item/%/reset','admin/structure/menu/item/%/reset','Reset menu link','a:0:{}','system',0,0,0,0,0,4,0,1,18,175,206,0,0,0,0,0,0),
('management',207,198,'admin/config/search/apachesolr/settings/%/clone','admin/config/search/apachesolr/settings/%/clone','Apache Solr search environment clone','a:0:{}','system',0,0,0,0,0,6,0,1,7,40,183,198,207,0,0,0,0),
('management',208,198,'admin/config/search/apachesolr/settings/%/delete','admin/config/search/apachesolr/settings/%/delete','Apache Solr search environment delete','a:0:{}','system',0,0,0,0,0,6,0,1,7,40,183,198,208,0,0,0,0),
('management',209,198,'admin/config/search/apachesolr/settings/%/edit','admin/config/search/apachesolr/settings/%/edit','Edit','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Edit Apache Solr search environment.\";}}','system',-1,0,0,0,10,6,0,1,7,40,183,198,209,0,0,0,0),
('management',210,198,'admin/config/search/apachesolr/settings/%/index','admin/config/search/apachesolr/settings/%/index','Index','a:0:{}','system',-1,0,0,0,0,6,0,1,7,40,183,198,210,0,0,0,0),
('management',211,175,'admin/structure/menu/manage/main-menu','admin/structure/menu/manage/%','Main menu','a:0:{}','menu',0,0,0,0,0,4,0,1,18,175,211,0,0,0,0,0,0),
('management',212,175,'admin/structure/menu/manage/management','admin/structure/menu/manage/%','Management','a:0:{}','menu',0,0,0,0,0,4,0,1,18,175,212,0,0,0,0,0,0),
('management',213,175,'admin/structure/menu/manage/navigation','admin/structure/menu/manage/%','Navigation','a:0:{}','menu',0,0,0,0,0,4,0,1,18,175,213,0,0,0,0,0,0),
('management',214,175,'admin/structure/menu/manage/user-menu','admin/structure/menu/manage/%','User menu','a:0:{}','menu',0,0,0,0,0,4,0,1,18,175,214,0,0,0,0,0,0),
('management',215,16,'admin/reports/fields','admin/reports/fields','Field list','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Overview of fields on all entity types.\";}}','system',0,0,0,0,0,3,0,1,16,215,0,0,0,0,0,0,0),
('devel',216,0,'devel/node_access/summary','devel/node_access/summary','Node_access summary','a:0:{}','system',0,0,0,0,0,1,0,216,0,0,0,0,0,0,0,0,0),
('management',217,34,'admin/config/media/image-styles','admin/config/media/image-styles','Image styles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:78:\"Configure styles that can be used for resizing or adjusting images on display.\";}}','system',0,0,1,0,0,4,0,1,7,34,217,0,0,0,0,0,0),
('management',218,38,'admin/config/regional/language','admin/config/regional/language','Languages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:55:\"Configure languages for content and the user interface.\";}}','system',0,0,1,0,-10,4,0,1,7,38,218,0,0,0,0,0,0),
('management',219,38,'admin/config/regional/translate','admin/config/regional/translate','Translate interface','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:59:\"Translate the built in interface and optionally other text.\";}}','system',0,0,1,0,-5,4,0,1,7,38,219,0,0,0,0,0,0),
('management',220,218,'admin/config/regional/language/add','admin/config/regional/language/add','Add language','a:0:{}','system',-1,0,0,0,5,5,0,1,7,38,218,220,0,0,0,0,0),
('management',221,217,'admin/config/media/image-styles/add','admin/config/media/image-styles/add','Add style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Add a new image style.\";}}','system',-1,0,0,0,2,5,0,1,7,34,217,221,0,0,0,0,0),
('management',222,218,'admin/config/regional/language/configure','admin/config/regional/language/configure','Detection and selection','a:0:{}','system',-1,0,0,0,10,5,0,1,7,38,218,222,0,0,0,0,0),
('management',223,219,'admin/config/regional/translate/export','admin/config/regional/translate/export','Export','a:0:{}','system',-1,0,0,0,30,5,0,1,7,38,219,223,0,0,0,0,0),
('management',224,219,'admin/config/regional/translate/import','admin/config/regional/translate/import','Import','a:0:{}','system',-1,0,0,0,20,5,0,1,7,38,219,224,0,0,0,0,0),
('management',225,218,'admin/config/regional/language/overview','admin/config/regional/language/overview','List','a:0:{}','system',-1,0,0,0,0,5,0,1,7,38,218,225,0,0,0,0,0),
('management',226,217,'admin/config/media/image-styles/list','admin/config/media/image-styles/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"List the current image styles on the site.\";}}','system',-1,0,0,0,1,5,0,1,7,34,217,226,0,0,0,0,0),
('management',227,61,'admin/config/regional/date-time/locale','admin/config/regional/date-time/locale','Localize','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Configure date formats for each locale\";}}','system',-1,0,1,0,-8,5,0,1,7,38,61,227,0,0,0,0,0),
('management',228,52,'admin/config/people/accounts/display','admin/config/people/accounts/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,7,35,52,228,0,0,0,0,0),
('management',229,52,'admin/config/people/accounts/fields','admin/config/people/accounts/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,7,35,52,229,0,0,0,0,0),
('management',230,219,'admin/config/regional/translate/overview','admin/config/regional/translate/overview','Overview','a:0:{}','system',-1,0,0,0,0,5,0,1,7,38,219,230,0,0,0,0,0),
('management',231,219,'admin/config/regional/translate/translate','admin/config/regional/translate/translate','Translate','a:0:{}','system',-1,0,0,0,10,5,0,1,7,38,219,231,0,0,0,0,0),
('management',232,218,'admin/config/regional/language/delete/%','admin/config/regional/language/delete/%','Confirm','a:0:{}','system',0,0,0,0,0,5,0,1,7,38,218,232,0,0,0,0,0),
('management',233,228,'admin/config/people/accounts/display/default','admin/config/people/accounts/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,7,35,52,228,233,0,0,0,0),
('management',234,219,'admin/config/regional/translate/delete/%','admin/config/regional/translate/delete/%','Delete string','a:0:{}','system',0,0,0,0,0,5,0,1,7,38,219,234,0,0,0,0,0),
('management',235,218,'admin/config/regional/language/edit/%','admin/config/regional/language/edit/%','Edit language','a:0:{}','system',0,0,0,0,0,5,0,1,7,38,218,235,0,0,0,0,0),
('management',236,219,'admin/config/regional/translate/edit/%','admin/config/regional/translate/edit/%','Edit string','a:0:{}','system',0,0,0,0,0,5,0,1,7,38,219,236,0,0,0,0,0),
('management',237,217,'admin/config/media/image-styles/edit/%','admin/config/media/image-styles/edit/%','Edit style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Configure an image style.\";}}','system',0,0,1,0,0,5,0,1,7,34,217,237,0,0,0,0,0),
('management',238,94,'admin/structure/types/manage/%/display','admin/structure/types/manage/%/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,18,26,94,238,0,0,0,0,0),
('management',239,94,'admin/structure/types/manage/%/fields','admin/structure/types/manage/%/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,18,26,94,239,0,0,0,0,0),
('management',240,222,'admin/config/regional/language/configure/session','admin/config/regional/language/configure/session','Session language detection configuration','a:0:{}','system',-1,0,0,0,0,6,0,1,7,38,218,222,240,0,0,0,0),
('management',241,222,'admin/config/regional/language/configure/url','admin/config/regional/language/configure/url','URL language detection configuration','a:0:{}','system',-1,0,0,0,0,6,0,1,7,38,218,222,241,0,0,0,0),
('management',242,228,'admin/config/people/accounts/display/full','admin/config/people/accounts/display/full','User account','a:0:{}','system',-1,0,0,0,0,6,0,1,7,35,52,228,242,0,0,0,0),
('management',243,217,'admin/config/media/image-styles/delete/%','admin/config/media/image-styles/delete/%','Delete style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Delete an image style.\";}}','system',0,0,0,0,0,5,0,1,7,34,217,243,0,0,0,0,0),
('management',244,217,'admin/config/media/image-styles/revert/%','admin/config/media/image-styles/revert/%','Revert style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Revert an image style.\";}}','system',0,0,0,0,0,5,0,1,7,34,217,244,0,0,0,0,0),
('management',245,229,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,7,35,52,229,245,0,0,0,0),
('management',246,238,'admin/structure/types/manage/%/display/default','admin/structure/types/manage/%/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,18,26,94,238,246,0,0,0,0),
('management',247,238,'admin/structure/types/manage/%/display/full','admin/structure/types/manage/%/display/full','Full content','a:0:{}','system',-1,0,0,0,0,6,0,1,18,26,94,238,247,0,0,0,0),
('management',248,227,'admin/config/regional/date-time/locale/%/edit','admin/config/regional/date-time/locale/%/edit','Localize date formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Configure date formats for each locale\";}}','system',0,0,0,0,0,6,0,1,7,38,61,227,248,0,0,0,0),
('management',249,238,'admin/structure/types/manage/%/display/rss','admin/structure/types/manage/%/display/rss','RSS','a:0:{}','system',-1,0,0,0,2,6,0,1,18,26,94,238,249,0,0,0,0),
('management',250,227,'admin/config/regional/date-time/locale/%/reset','admin/config/regional/date-time/locale/%/reset','Reset date formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Reset localized date formats to global defaults\";}}','system',0,0,0,0,0,6,0,1,7,38,61,227,250,0,0,0,0),
('management',251,238,'admin/structure/types/manage/%/display/teaser','admin/structure/types/manage/%/display/teaser','Teaser','a:0:{}','system',-1,0,0,0,1,6,0,1,18,26,94,238,251,0,0,0,0),
('management',252,239,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,18,26,94,239,252,0,0,0,0),
('management',253,245,'admin/config/people/accounts/fields/%/delete','admin/config/people/accounts/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,7,35,52,229,245,253,0,0,0),
('management',254,245,'admin/config/people/accounts/fields/%/edit','admin/config/people/accounts/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,7,35,52,229,245,254,0,0,0),
('management',255,245,'admin/config/people/accounts/fields/%/field-settings','admin/config/people/accounts/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,7,35,52,229,245,255,0,0,0),
('management',256,245,'admin/config/people/accounts/fields/%/widget-type','admin/config/people/accounts/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,7,35,52,229,245,256,0,0,0),
('management',257,237,'admin/config/media/image-styles/edit/%/add/%','admin/config/media/image-styles/edit/%/add/%','Add image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Add a new effect to a style.\";}}','system',0,0,0,0,0,6,0,1,7,34,217,237,257,0,0,0,0),
('management',258,237,'admin/config/media/image-styles/edit/%/effects/%','admin/config/media/image-styles/edit/%/effects/%','Edit image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Edit an existing effect within a style.\";}}','system',0,0,1,0,0,6,0,1,7,34,217,237,258,0,0,0,0),
('management',259,252,'admin/structure/types/manage/%/fields/%/delete','admin/structure/types/manage/%/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,18,26,94,239,252,259,0,0,0),
('management',260,252,'admin/structure/types/manage/%/fields/%/edit','admin/structure/types/manage/%/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,18,26,94,239,252,260,0,0,0),
('management',261,252,'admin/structure/types/manage/%/fields/%/field-settings','admin/structure/types/manage/%/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,18,26,94,239,252,261,0,0,0),
('management',262,252,'admin/structure/types/manage/%/fields/%/widget-type','admin/structure/types/manage/%/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,18,26,94,239,252,262,0,0,0),
('management',263,258,'admin/config/media/image-styles/edit/%/effects/%/delete','admin/config/media/image-styles/edit/%/effects/%/delete','Delete image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Delete an existing effect from a style.\";}}','system',0,0,0,0,0,7,0,1,7,34,217,237,258,263,0,0,0),
('management',267,103,'admin/structure/block/list/seven/add','admin/structure/block/list/seven/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,18,22,103,267,0,0,0,0,0),
('management',268,150,'admin/structure/block/list/wweave/add','admin/structure/block/list/wweave/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,18,22,150,268,0,0,0,0,0);

UNLOCK TABLES;

/*Table structure for table `menu_router` */

DROP TABLE IF EXISTS `menu_router`;

CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';

/*Data for the table `menu_router` */

LOCK TABLES `menu_router` WRITE;

insert  into `menu_router`(`path`,`load_functions`,`to_arg_functions`,`access_callback`,`access_arguments`,`page_callback`,`page_arguments`,`delivery_callback`,`fit`,`number_parts`,`context`,`tab_parent`,`tab_root`,`title`,`title_callback`,`title_arguments`,`theme_callback`,`theme_arguments`,`type`,`description`,`position`,`weight`,`include_file`) values 
('admin','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',1,1,0,'','admin','Administration','t','','','a:0:{}',6,'','',9,'modules/system/system.admin.inc'),
('admin/appearance','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_themes_page','a:0:{}','',3,2,0,'','admin/appearance','Appearance','t','','','a:0:{}',6,'Select and configure your themes.','left',-6,'modules/system/system.admin.inc'),
('admin/appearance/default','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_theme_default','a:0:{}','',7,3,0,'','admin/appearance/default','Set default theme','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('admin/appearance/disable','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_theme_disable','a:0:{}','',7,3,0,'','admin/appearance/disable','Disable theme','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('admin/appearance/enable','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_theme_enable','a:0:{}','',7,3,0,'','admin/appearance/enable','Enable theme','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('admin/appearance/install','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:27:\"update_manager_install_form\";i:1;s:5:\"theme\";}','',7,3,1,'admin/appearance','admin/appearance','Install new theme','t','','','a:0:{}',388,'','',25,'modules/update/update.manager.inc'),
('admin/appearance/list','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_themes_page','a:0:{}','',7,3,1,'admin/appearance','admin/appearance','List','t','','','a:0:{}',140,'Select and configure your theme','',-1,'modules/system/system.admin.inc'),
('admin/appearance/settings','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','drupal_get_form','a:1:{i:0;s:21:\"system_theme_settings\";}','',7,3,1,'admin/appearance','admin/appearance','Settings','t','','','a:0:{}',132,'Configure default and theme specific settings.','',20,'modules/system/system.admin.inc'),
('admin/appearance/settings/bartik','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:6:\"bartik\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Bartik','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc'),
('admin/appearance/settings/garland','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:7:\"garland\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Garland','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc'),
('admin/appearance/settings/global','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','drupal_get_form','a:1:{i:0;s:21:\"system_theme_settings\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Global settings','t','','','a:0:{}',140,'','',-1,'modules/system/system.admin.inc'),
('admin/appearance/settings/seven','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:5:\"seven\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Seven','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc'),
('admin/appearance/settings/stark','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:5:\"stark\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Stark','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc'),
('admin/appearance/settings/wweave','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":13:{s:8:\"filename\";s:35:\"sites/all/themes/wweave/wweave.info\";s:4:\"name\";s:6:\"wweave\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"1\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:15:{s:4:\"name\";s:6:\"wweave\";s:11:\"description\";s:29:\"A flexible, responsive theme.\";s:7:\"version\";s:7:\"7.x-1.0\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:4:{s:21:\"css/bootstrap.min.css\";s:45:\"sites/all/themes/wweave/css/bootstrap.min.css\";s:17:\"css/ww_styles.css\";s:41:\"sites/all/themes/wweave/css/ww_styles.css\";s:18:\"css/responsive.css\";s:42:\"sites/all/themes/wweave/css/responsive.css\";s:15:\"css/mdb.min.css\";s:39:\"sites/all/themes/wweave/css/mdb.min.css\";}}s:7:\"scripts\";a:4:{s:16:\"js/jquery.min.js\";s:40:\"sites/all/themes/wweave/js/jquery.min.js\";s:19:\"js/bootstrap.min.js\";s:43:\"sites/all/themes/wweave/js/bootstrap.min.js\";s:10:\"js/main.js\";s:34:\"sites/all/themes/wweave/js/main.js\";s:33:\"js/material-components-web.min.js\";s:57:\"sites/all/themes/wweave/js/material-components-web.min.js\";}s:7:\"regions\";a:6:{s:7:\"content\";s:7:\"Content\";s:21:\"search_filter_sidebar\";s:21:\"Search Filter Sidebar\";s:14:\"social_sharing\";s:14:\"Social Sharing\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:38:\"sites/all/themes/wweave/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"mtime\";i:1549344031;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:4:{s:21:\"css/bootstrap.min.css\";s:45:\"sites/all/themes/wweave/css/bootstrap.min.css\";s:17:\"css/ww_styles.css\";s:41:\"sites/all/themes/wweave/css/ww_styles.css\";s:18:\"css/responsive.css\";s:42:\"sites/all/themes/wweave/css/responsive.css\";s:15:\"css/mdb.min.css\";s:39:\"sites/all/themes/wweave/css/mdb.min.css\";}}s:7:\"scripts\";a:4:{s:16:\"js/jquery.min.js\";s:40:\"sites/all/themes/wweave/js/jquery.min.js\";s:19:\"js/bootstrap.min.js\";s:43:\"sites/all/themes/wweave/js/bootstrap.min.js\";s:10:\"js/main.js\";s:34:\"sites/all/themes/wweave/js/main.js\";s:33:\"js/material-components-web.min.js\";s:57:\"sites/all/themes/wweave/js/material-components-web.min.js\";}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:6:\"wweave\";}','',15,4,1,'admin/appearance/settings','admin/appearance','wweave','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc'),
('admin/appearance/update','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:26:\"update_manager_update_form\";i:1;s:5:\"theme\";}','',7,3,1,'admin/appearance','admin/appearance','Update','t','','','a:0:{}',132,'','',10,'modules/update/update.manager.inc'),
('admin/compact','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_compact_page','a:0:{}','',3,2,0,'','admin/compact','Compact mode','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('admin/config','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_config_page','a:0:{}','',3,2,0,'','admin/config','Configuration','t','','','a:0:{}',6,'Administer settings.','',0,'modules/system/system.admin.inc'),
('admin/config/content','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/content','Content authoring','t','','','a:0:{}',6,'Settings related to formatting and authoring content.','left',-15,'modules/system/system.admin.inc'),
('admin/config/content/formats','','','user_access','a:1:{i:0;s:18:\"administer filters\";}','drupal_get_form','a:1:{i:0;s:21:\"filter_admin_overview\";}','',15,4,0,'','admin/config/content/formats','Text formats','t','','','a:0:{}',6,'Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.','',0,'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%','a:1:{i:4;s:18:\"filter_format_load\";}','','user_access','a:1:{i:0;s:18:\"administer filters\";}','filter_admin_format_page','a:1:{i:0;i:4;}','',30,5,0,'','admin/config/content/formats/%','','filter_admin_format_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%/disable','a:1:{i:4;s:18:\"filter_format_load\";}','','_filter_disable_format_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:20:\"filter_admin_disable\";i:1;i:4;}','',61,6,0,'','admin/config/content/formats/%/disable','Disable text format','t','','','a:0:{}',6,'','',0,'modules/filter/filter.admin.inc'),
('admin/config/content/formats/add','','','user_access','a:1:{i:0;s:18:\"administer filters\";}','filter_admin_format_page','a:0:{}','',31,5,1,'admin/config/content/formats','admin/config/content/formats','Add text format','t','','','a:0:{}',388,'','',1,'modules/filter/filter.admin.inc'),
('admin/config/content/formats/list','','','user_access','a:1:{i:0;s:18:\"administer filters\";}','drupal_get_form','a:1:{i:0;s:21:\"filter_admin_overview\";}','',31,5,1,'admin/config/content/formats','admin/config/content/formats','List','t','','','a:0:{}',140,'','',0,'modules/filter/filter.admin.inc'),
('admin/config/development','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/development','Development','t','','','a:0:{}',6,'Development tools.','right',-10,'modules/system/system.admin.inc'),
('admin/config/development/devel','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:20:\"devel_admin_settings\";}','',15,4,0,'','admin/config/development/devel','Devel settings','t','','','a:0:{}',6,'Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href=\"/ww_cms/admin/structure/block\">block administration</a> page.','',0,'sites/all/modules/devel/devel.admin.inc'),
('admin/config/development/logging','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:23:\"system_logging_settings\";}','',15,4,0,'','admin/config/development/logging','Logging and errors','t','','','a:0:{}',6,'Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.','',-15,'modules/system/system.admin.inc'),
('admin/config/development/maintenance','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:28:\"system_site_maintenance_mode\";}','',15,4,0,'','admin/config/development/maintenance','Maintenance mode','t','','','a:0:{}',6,'Take the site offline for maintenance or bring it back online.','',-10,'modules/system/system.admin.inc'),
('admin/config/development/performance','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:27:\"system_performance_settings\";}','',15,4,0,'','admin/config/development/performance','Performance','t','','','a:0:{}',6,'Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.','',-20,'modules/system/system.admin.inc'),
('admin/config/media','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/media','Media','t','','','a:0:{}',6,'Media tools.','left',-10,'modules/system/system.admin.inc'),
('admin/config/media/file-system','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:27:\"system_file_system_settings\";}','',15,4,0,'','admin/config/media/file-system','File system','t','','','a:0:{}',6,'Tell Drupal where to store uploaded files and how they are accessed.','',-10,'modules/system/system.admin.inc'),
('admin/config/media/image-styles','','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','image_style_list','a:0:{}','',15,4,0,'','admin/config/media/image-styles','Image styles','t','','','a:0:{}',6,'Configure styles that can be used for resizing or adjusting images on display.','',0,'modules/image/image.admin.inc'),
('admin/config/media/image-styles/add','','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:1:{i:0;s:20:\"image_style_add_form\";}','',31,5,1,'admin/config/media/image-styles','admin/config/media/image-styles','Add style','t','','','a:0:{}',388,'Add a new image style.','',2,'modules/image/image.admin.inc'),
('admin/config/media/image-styles/delete/%','a:1:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;N;i:1;s:1:\"1\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:2:{i:0;s:23:\"image_style_delete_form\";i:1;i:5;}','',62,6,0,'','admin/config/media/image-styles/delete/%','Delete style','t','','','a:0:{}',6,'Delete an image style.','',0,'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%','a:1:{i:5;s:16:\"image_style_load\";}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:2:{i:0;s:16:\"image_style_form\";i:1;i:5;}','',62,6,0,'','admin/config/media/image-styles/edit/%','Edit style','t','','','a:0:{}',6,'Configure an image style.','',0,'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/add/%','a:2:{i:5;a:1:{s:16:\"image_style_load\";a:1:{i:0;i:5;}}i:7;a:1:{s:28:\"image_effect_definition_load\";a:1:{i:0;i:5;}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:3:{i:0;s:17:\"image_effect_form\";i:1;i:5;i:2;i:7;}','',250,8,0,'','admin/config/media/image-styles/edit/%/add/%','Add image effect','t','','','a:0:{}',6,'Add a new effect to a style.','',0,'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%','a:2:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}i:7;a:1:{s:17:\"image_effect_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:3:{i:0;s:17:\"image_effect_form\";i:1;i:5;i:2;i:7;}','',250,8,0,'','admin/config/media/image-styles/edit/%/effects/%','Edit image effect','t','','','a:0:{}',6,'Edit an existing effect within a style.','',0,'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%/delete','a:2:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}i:7;a:1:{s:17:\"image_effect_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:3:{i:0;s:24:\"image_effect_delete_form\";i:1;i:5;i:2;i:7;}','',501,9,0,'','admin/config/media/image-styles/edit/%/effects/%/delete','Delete image effect','t','','','a:0:{}',6,'Delete an existing effect from a style.','',0,'modules/image/image.admin.inc'),
('admin/config/media/image-styles/list','','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','image_style_list','a:0:{}','',31,5,1,'admin/config/media/image-styles','admin/config/media/image-styles','List','t','','','a:0:{}',140,'List the current image styles on the site.','',1,'modules/image/image.admin.inc'),
('admin/config/media/image-styles/revert/%','a:1:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;N;i:1;s:1:\"2\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:2:{i:0;s:23:\"image_style_revert_form\";i:1;i:5;}','',62,6,0,'','admin/config/media/image-styles/revert/%','Revert style','t','','','a:0:{}',6,'Revert an image style.','',0,'modules/image/image.admin.inc'),
('admin/config/media/image-toolkit','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:29:\"system_image_toolkit_settings\";}','',15,4,0,'','admin/config/media/image-toolkit','Image toolkit','t','','','a:0:{}',6,'Choose which image toolkit to use if you have installed optional toolkits.','',20,'modules/system/system.admin.inc'),
('admin/config/people','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/people','People','t','','','a:0:{}',6,'Configure user accounts.','left',-20,'modules/system/system.admin.inc'),
('admin/config/people/accounts','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:1:{i:0;s:19:\"user_admin_settings\";}','',15,4,0,'','admin/config/people/accounts','Account settings','t','','','a:0:{}',6,'Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.','',-10,'modules/user/user.admin.inc'),
('admin/config/people/accounts/display','','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:16:\"administer users\";}}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:7:\"default\";}','',31,5,1,'admin/config/people/accounts','admin/config/people/accounts','Manage display','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/display/default','','','_field_ui_view_mode_menu_access','a:6:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:7:\"default\";i:3;s:21:\"field_ui_admin_access\";i:4;s:11:\"user_access\";i:5;a:1:{i:0;s:16:\"administer users\";}}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:7:\"default\";}','',63,6,1,'admin/config/people/accounts/display','admin/config/people/accounts','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/display/full','','','_field_ui_view_mode_menu_access','a:6:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:4:\"full\";i:3;s:21:\"field_ui_admin_access\";i:4;s:11:\"user_access\";i:5;a:1:{i:0;s:16:\"administer users\";}}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:4:\"full\";}','',63,6,1,'admin/config/people/accounts/display','admin/config/people/accounts','User account','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields','','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:16:\"administer users\";}}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";}','',31,5,1,'admin/config/people/accounts','admin/config/people/accounts','Manage fields','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:16:\"administer users\";}}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',62,6,0,'','admin/config/people/accounts/fields/%','','field_ui_menu_title','a:1:{i:0;i:5;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/delete','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:16:\"administer users\";}}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/edit','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:16:\"administer users\";}}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/field-settings','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:16:\"administer users\";}}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/widget-type','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:16:\"administer users\";}}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/settings','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:1:{i:0;s:19:\"user_admin_settings\";}','',31,5,1,'admin/config/people/accounts','admin/config/people/accounts','Settings','t','','','a:0:{}',140,'','',-10,'modules/user/user.admin.inc'),
('admin/config/people/ip-blocking','','','user_access','a:1:{i:0;s:18:\"block IP addresses\";}','system_ip_blocking','a:0:{}','',15,4,0,'','admin/config/people/ip-blocking','IP address blocking','t','','','a:0:{}',6,'Manage blocked IP addresses.','',10,'modules/system/system.admin.inc'),
('admin/config/people/ip-blocking/delete/%','a:1:{i:5;s:15:\"blocked_ip_load\";}','','user_access','a:1:{i:0;s:18:\"block IP addresses\";}','drupal_get_form','a:2:{i:0;s:25:\"system_ip_blocking_delete\";i:1;i:5;}','',62,6,0,'','admin/config/people/ip-blocking/delete/%','Delete IP address','t','','','a:0:{}',6,'','',0,'modules/system/system.admin.inc'),
('admin/config/regional','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/regional','Regional and language','t','','','a:0:{}',6,'Regional settings, localization and translation.','left',-5,'modules/system/system.admin.inc'),
('admin/config/regional/date-time','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_date_time_settings\";}','',15,4,0,'','admin/config/regional/date-time','Date and time','t','','','a:0:{}',6,'Configure display formats for date and time.','',-15,'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_date_time_formats','a:0:{}','',31,5,1,'admin/config/regional/date-time','admin/config/regional/date-time','Formats','t','','','a:0:{}',132,'Configure display format strings for date and time.','',-9,'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/delete','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:30:\"system_date_delete_format_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/formats/%/delete','Delete date format','t','','','a:0:{}',6,'Allow users to delete a configured date format.','',0,'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/edit','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:34:\"system_configure_date_formats_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/formats/%/edit','Edit date format','t','','','a:0:{}',6,'Allow users to edit a configured date format.','',0,'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/add','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:34:\"system_configure_date_formats_form\";}','',63,6,1,'admin/config/regional/date-time/formats','admin/config/regional/date-time','Add format','t','','','a:0:{}',388,'Allow users to add additional date formats.','',-10,'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/lookup','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_date_time_lookup','a:0:{}','',63,6,0,'','admin/config/regional/date-time/formats/lookup','Date and time lookup','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('admin/config/regional/date-time/locale','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','locale_date_format_language_overview_page','a:0:{}','',31,5,1,'admin/config/regional/date-time','admin/config/regional/date-time','Localize','t','','','a:0:{}',132,'Configure date formats for each locale','',-8,'modules/locale/locale.admin.inc'),
('admin/config/regional/date-time/locale/%/edit','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:23:\"locale_date_format_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/locale/%/edit','Localize date formats','t','','','a:0:{}',6,'Configure date formats for each locale','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/date-time/locale/%/reset','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:29:\"locale_date_format_reset_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/locale/%/reset','Reset date formats','t','','','a:0:{}',6,'Reset localized date formats to global defaults','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/date-time/types','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_date_time_settings\";}','',31,5,1,'admin/config/regional/date-time','admin/config/regional/date-time','Types','t','','','a:0:{}',140,'Configure display formats for date and time.','',-10,'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types/%/delete','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:35:\"system_delete_date_format_type_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/types/%/delete','Delete date type','t','','','a:0:{}',6,'Allow users to delete a configured date type.','',0,'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types/add','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:32:\"system_add_date_format_type_form\";}','',63,6,1,'admin/config/regional/date-time/types','admin/config/regional/date-time','Add date type','t','','','a:0:{}',388,'Add new date type.','',-10,'modules/system/system.admin.inc'),
('admin/config/regional/language','','','user_access','a:1:{i:0;s:20:\"administer languages\";}','drupal_get_form','a:1:{i:0;s:30:\"locale_languages_overview_form\";}','',15,4,0,'','admin/config/regional/language','Languages','t','','','a:0:{}',6,'Configure languages for content and the user interface.','',-10,'modules/locale/locale.admin.inc'),
('admin/config/regional/language/add','','','user_access','a:1:{i:0;s:20:\"administer languages\";}','locale_languages_add_screen','a:0:{}','',31,5,1,'admin/config/regional/language','admin/config/regional/language','Add language','t','','','a:0:{}',388,'','',5,'modules/locale/locale.admin.inc'),
('admin/config/regional/language/configure','','','user_access','a:1:{i:0;s:20:\"administer languages\";}','drupal_get_form','a:1:{i:0;s:31:\"locale_languages_configure_form\";}','',31,5,1,'admin/config/regional/language','admin/config/regional/language','Detection and selection','t','','','a:0:{}',132,'','',10,'modules/locale/locale.admin.inc'),
('admin/config/regional/language/configure/session','','','user_access','a:1:{i:0;s:20:\"administer languages\";}','drupal_get_form','a:1:{i:0;s:38:\"locale_language_providers_session_form\";}','',63,6,0,'','admin/config/regional/language/configure/session','Session language detection configuration','t','','','a:0:{}',4,'','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/language/configure/url','','','user_access','a:1:{i:0;s:20:\"administer languages\";}','drupal_get_form','a:1:{i:0;s:34:\"locale_language_providers_url_form\";}','',63,6,0,'','admin/config/regional/language/configure/url','URL language detection configuration','t','','','a:0:{}',4,'','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/language/delete/%','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:20:\"administer languages\";}','drupal_get_form','a:2:{i:0;s:28:\"locale_languages_delete_form\";i:1;i:5;}','',62,6,0,'','admin/config/regional/language/delete/%','Confirm','t','','','a:0:{}',6,'','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/language/edit/%','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:20:\"administer languages\";}','drupal_get_form','a:2:{i:0;s:26:\"locale_languages_edit_form\";i:1;i:5;}','',62,6,0,'','admin/config/regional/language/edit/%','Edit language','t','','','a:0:{}',6,'','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/language/overview','','','user_access','a:1:{i:0;s:20:\"administer languages\";}','drupal_get_form','a:1:{i:0;s:30:\"locale_languages_overview_form\";}','',31,5,1,'admin/config/regional/language','admin/config/regional/language','List','t','','','a:0:{}',140,'','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/settings','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:24:\"system_regional_settings\";}','',15,4,0,'','admin/config/regional/settings','Regional settings','t','','','a:0:{}',6,'Settings for the site\'s default time zone and country.','',-20,'modules/system/system.admin.inc'),
('admin/config/regional/translate','','','user_access','a:1:{i:0;s:19:\"translate interface\";}','locale_translate_overview_screen','a:0:{}','',15,4,0,'','admin/config/regional/translate','Translate interface','t','','','a:0:{}',6,'Translate the built in interface and optionally other text.','',-5,'modules/locale/locale.admin.inc'),
('admin/config/regional/translate/delete/%','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:19:\"translate interface\";}','locale_translate_delete_page','a:1:{i:0;i:5;}','',62,6,0,'','admin/config/regional/translate/delete/%','Delete string','t','','','a:0:{}',6,'','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/translate/edit/%','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:19:\"translate interface\";}','drupal_get_form','a:2:{i:0;s:26:\"locale_translate_edit_form\";i:1;i:5;}','',62,6,0,'','admin/config/regional/translate/edit/%','Edit string','t','','','a:0:{}',6,'','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/translate/export','','','user_access','a:1:{i:0;s:19:\"translate interface\";}','locale_translate_export_screen','a:0:{}','',31,5,1,'admin/config/regional/translate','admin/config/regional/translate','Export','t','','','a:0:{}',132,'','',30,'modules/locale/locale.admin.inc'),
('admin/config/regional/translate/import','','','user_access','a:1:{i:0;s:19:\"translate interface\";}','drupal_get_form','a:1:{i:0;s:28:\"locale_translate_import_form\";}','',31,5,1,'admin/config/regional/translate','admin/config/regional/translate','Import','t','','','a:0:{}',132,'','',20,'modules/locale/locale.admin.inc'),
('admin/config/regional/translate/overview','','','user_access','a:1:{i:0;s:19:\"translate interface\";}','locale_translate_overview_screen','a:0:{}','',31,5,1,'admin/config/regional/translate','admin/config/regional/translate','Overview','t','','','a:0:{}',140,'','',0,'modules/locale/locale.admin.inc'),
('admin/config/regional/translate/translate','','','user_access','a:1:{i:0;s:19:\"translate interface\";}','locale_translate_seek_screen','a:0:{}','',31,5,1,'admin/config/regional/translate','admin/config/regional/translate','Translate','t','','','a:0:{}',132,'','',10,'modules/locale/locale.admin.inc'),
('admin/config/search','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/search','Search and metadata','t','','','a:0:{}',6,'Local site search, metadata and SEO.','left',-10,'modules/system/system.admin.inc'),
('admin/config/search/apachesolr','','','user_access','a:1:{i:0;s:17:\"administer search\";}','apachesolr_status_page','a:0:{}','',15,4,0,'','admin/config/search/apachesolr','Apache Solr search','t','','','a:0:{}',6,'Administer Apache Solr.','',-8,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/index','','','user_access','a:1:{i:0;s:17:\"administer search\";}','apachesolr_status_page','a:0:{}','',31,5,1,'admin/config/search/apachesolr','admin/config/search/apachesolr','Default index','t','','','a:0:{}',140,'Administer Apache Solr.','',-8,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/index/confirm/clear','','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:1:{i:0;s:30:\"apachesolr_clear_index_confirm\";}','',127,7,0,'','admin/config/search/apachesolr/index/confirm/clear','Confirm the re-indexing of all content','t','','','a:0:{}',0,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/index/confirm/delete','','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:1:{i:0;s:31:\"apachesolr_delete_index_confirm\";}','',127,7,0,'','admin/config/search/apachesolr/index/confirm/delete','Confirm index deletion','t','','','a:0:{}',0,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings','','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:1:{i:0;s:19:\"apachesolr_settings\";}','',31,5,1,'admin/config/search/apachesolr','admin/config/search/apachesolr','Settings','t','','','a:0:{}',132,'','',10,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/%/clone','a:1:{i:5;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:2:{i:0;s:33:\"apachesolr_environment_clone_form\";i:1;i:5;}','',125,7,0,'','admin/config/search/apachesolr/settings/%/clone','Apache Solr search environment clone','t','','','a:0:{}',6,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/%/delete','a:1:{i:5;s:27:\"apachesolr_environment_load\";}','','apachesolr_environment_delete_page_access','a:2:{i:0;s:17:\"administer search\";i:1;i:5;}','drupal_get_form','a:2:{i:0;s:34:\"apachesolr_environment_delete_form\";i:1;i:5;}','',125,7,0,'','admin/config/search/apachesolr/settings/%/delete','Apache Solr search environment delete','t','','','a:0:{}',6,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/%/edit','a:1:{i:5;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:2:{i:0;s:32:\"apachesolr_environment_edit_form\";i:1;i:5;}','',125,7,1,'admin/config/search/apachesolr/settings','admin/config/search/apachesolr','Edit','t','','','a:0:{}',132,'Edit Apache Solr search environment.','',10,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/%/index','a:1:{i:5;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:17:\"administer search\";}','apachesolr_status_page','a:1:{i:0;i:5;}','',125,7,1,'admin/config/search/apachesolr/settings','admin/config/search/apachesolr','Index','t','','','a:0:{}',132,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/%/index/delete','a:1:{i:5;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:2:{i:0;s:43:\"apachesolr_index_action_form_delete_confirm\";i:1;i:5;}','',251,8,0,'','admin/config/search/apachesolr/settings/%/index/delete','Reindex','t','','','a:0:{}',0,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/%/index/delete/confirm','a:1:{i:5;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:2:{i:0;s:31:\"apachesolr_delete_index_confirm\";i:1;i:5;}','',503,9,0,'','admin/config/search/apachesolr/settings/%/index/delete/confirm','Confirm index deletion','t','','','a:0:{}',0,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/%/index/remaining','a:1:{i:5;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:2:{i:0;s:46:\"apachesolr_index_action_form_remaining_confirm\";i:1;i:5;}','',251,8,0,'','admin/config/search/apachesolr/settings/%/index/remaining','Remaining','t','','','a:0:{}',0,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/%/index/reset','a:1:{i:5;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:2:{i:0;s:42:\"apachesolr_index_action_form_reset_confirm\";i:1;i:5;}','',251,8,0,'','admin/config/search/apachesolr/settings/%/index/reset','Reindex','t','','','a:0:{}',0,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/%/index/reset/confirm','a:1:{i:5;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:2:{i:0;s:30:\"apachesolr_clear_index_confirm\";i:1;i:5;}','',503,9,0,'','admin/config/search/apachesolr/settings/%/index/reset/confirm','Confirm the re-indexing of all content','t','','','a:0:{}',0,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/apachesolr/settings/add','','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:1:{i:0;s:32:\"apachesolr_environment_edit_form\";}','',63,6,1,'admin/config/search/apachesolr/settings','admin/config/search/apachesolr','Add search environment','t','','','a:0:{}',388,'Add Apache Solr environment.','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/config/search/clean-urls','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_clean_url_settings\";}','',15,4,0,'','admin/config/search/clean-urls','Clean URLs','t','','','a:0:{}',6,'Enable or disable clean URLs for your site.','',5,'modules/system/system.admin.inc'),
('admin/config/search/clean-urls/check','','','1','a:0:{}','drupal_json_output','a:1:{i:0;a:1:{s:6:\"status\";b:1;}}','',31,5,0,'','admin/config/search/clean-urls/check','Clean URL check','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('admin/config/services','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/services','Web services','t','','','a:0:{}',6,'Tools related to web services.','right',0,'modules/system/system.admin.inc'),
('admin/config/services/rss-publishing','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_rss_feeds_settings\";}','',15,4,0,'','admin/config/services/rss-publishing','RSS publishing','t','','','a:0:{}',6,'Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.','',0,'modules/system/system.admin.inc'),
('admin/config/system','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/system','System','t','','','a:0:{}',6,'General system related configuration.','right',-20,'modules/system/system.admin.inc'),
('admin/config/system/actions','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','system_actions_manage','a:0:{}','',15,4,0,'','admin/config/system/actions','Actions','t','','','a:0:{}',6,'Manage the actions defined for your site.','',0,'modules/system/system.admin.inc'),
('admin/config/system/actions/configure','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','drupal_get_form','a:1:{i:0;s:24:\"system_actions_configure\";}','',31,5,0,'','admin/config/system/actions/configure','Configure an advanced action','t','','','a:0:{}',4,'','',0,'modules/system/system.admin.inc'),
('admin/config/system/actions/delete/%','a:1:{i:5;s:12:\"actions_load\";}','','user_access','a:1:{i:0;s:18:\"administer actions\";}','drupal_get_form','a:2:{i:0;s:26:\"system_actions_delete_form\";i:1;i:5;}','',62,6,0,'','admin/config/system/actions/delete/%','Delete action','t','','','a:0:{}',6,'Delete an action.','',0,'modules/system/system.admin.inc'),
('admin/config/system/actions/manage','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','system_actions_manage','a:0:{}','',31,5,1,'admin/config/system/actions','admin/config/system/actions','Manage actions','t','','','a:0:{}',140,'Manage the actions defined for your site.','',-2,'modules/system/system.admin.inc'),
('admin/config/system/actions/orphan','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','system_actions_remove_orphans','a:0:{}','',31,5,0,'','admin/config/system/actions/orphan','Remove orphans','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('admin/config/system/cron','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:20:\"system_cron_settings\";}','',15,4,0,'','admin/config/system/cron','Cron','t','','','a:0:{}',6,'Manage automatic site maintenance tasks.','',20,'modules/system/system.admin.inc'),
('admin/config/system/site-information','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:32:\"system_site_information_settings\";}','',15,4,0,'','admin/config/system/site-information','Site information','t','','','a:0:{}',6,'Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.','',-20,'modules/system/system.admin.inc'),
('admin/config/user-interface','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/user-interface','User interface','t','','','a:0:{}',6,'Tools that enhance the user interface.','right',-15,'modules/system/system.admin.inc'),
('admin/config/workflow','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/workflow','Workflow','t','','','a:0:{}',6,'Content workflow, editorial workflow tools.','right',5,'modules/system/system.admin.inc'),
('admin/content','','','user_access','a:1:{i:0;s:23:\"access content overview\";}','drupal_get_form','a:1:{i:0;s:18:\"node_admin_content\";}','',3,2,0,'','admin/content','Content','t','','','a:0:{}',6,'Find and manage content.','',-10,'modules/node/node.admin.inc'),
('admin/content/node','','','user_access','a:1:{i:0;s:23:\"access content overview\";}','drupal_get_form','a:1:{i:0;s:18:\"node_admin_content\";}','',7,3,1,'admin/content','admin/content','Content','t','','','a:0:{}',140,'','',-10,'modules/node/node.admin.inc'),
('admin/dashboard','','','user_access','a:1:{i:0;s:16:\"access dashboard\";}','dashboard_admin','a:0:{}','',3,2,0,'','admin/dashboard','Dashboard','t','','','a:0:{}',6,'View and customize your dashboard.','',-15,''),
('admin/dashboard/block-content/%/%','a:2:{i:3;N;i:4;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_show_block_content','a:2:{i:0;i:3;i:1;i:4;}','',28,5,0,'','admin/dashboard/block-content/%/%','','t','','','a:0:{}',0,'','',0,''),
('admin/dashboard/configure','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_admin_blocks','a:0:{}','',7,3,0,'','admin/dashboard/configure','Configure available dashboard blocks','t','','','a:0:{}',4,'Configure which blocks can be shown on the dashboard.','',0,''),
('admin/dashboard/customize','','','user_access','a:1:{i:0;s:16:\"access dashboard\";}','dashboard_admin','a:1:{i:0;b:1;}','',7,3,0,'','admin/dashboard/customize','Customize dashboard','t','','','a:0:{}',4,'Customize your dashboard.','',0,''),
('admin/dashboard/drawer','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_show_disabled','a:0:{}','',7,3,0,'','admin/dashboard/drawer','','t','','','a:0:{}',0,'','',0,''),
('admin/dashboard/update','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_update','a:0:{}','',7,3,0,'','admin/dashboard/update','','t','','','a:0:{}',0,'','',0,''),
('admin/index','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_index','a:0:{}','',3,2,1,'admin','admin','Index','t','','','a:0:{}',132,'','',-18,'modules/system/system.admin.inc'),
('admin/modules','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:14:\"system_modules\";}','',3,2,0,'','admin/modules','Modules','t','','','a:0:{}',6,'Extend site functionality.','',-2,'modules/system/system.admin.inc'),
('admin/modules/install','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:27:\"update_manager_install_form\";i:1;s:6:\"module\";}','',7,3,1,'admin/modules','admin/modules','Install new module','t','','','a:0:{}',388,'','',25,'modules/update/update.manager.inc'),
('admin/modules/list','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:14:\"system_modules\";}','',7,3,1,'admin/modules','admin/modules','List','t','','','a:0:{}',140,'','',0,'modules/system/system.admin.inc'),
('admin/modules/list/confirm','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:14:\"system_modules\";}','',15,4,0,'','admin/modules/list/confirm','List','t','','','a:0:{}',4,'','',0,'modules/system/system.admin.inc'),
('admin/modules/uninstall','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:24:\"system_modules_uninstall\";}','',7,3,1,'admin/modules','admin/modules','Uninstall','t','','','a:0:{}',132,'','',20,'modules/system/system.admin.inc'),
('admin/modules/uninstall/confirm','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:24:\"system_modules_uninstall\";}','',15,4,0,'','admin/modules/uninstall/confirm','Uninstall','t','','','a:0:{}',4,'','',0,'modules/system/system.admin.inc'),
('admin/modules/update','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:26:\"update_manager_update_form\";i:1;s:6:\"module\";}','',7,3,1,'admin/modules','admin/modules','Update','t','','','a:0:{}',132,'','',10,'modules/update/update.manager.inc'),
('admin/people','','','user_access','a:1:{i:0;s:16:\"administer users\";}','user_admin','a:1:{i:0;s:4:\"list\";}','',3,2,0,'','admin/people','People','t','','','a:0:{}',6,'Manage user accounts, roles, and permissions.','left',-4,'modules/user/user.admin.inc'),
('admin/people/create','','','user_access','a:1:{i:0;s:16:\"administer users\";}','user_admin','a:1:{i:0;s:6:\"create\";}','',7,3,1,'admin/people','admin/people','Add user','t','','','a:0:{}',388,'','',0,'modules/user/user.admin.inc'),
('admin/people/people','','','user_access','a:1:{i:0;s:16:\"administer users\";}','user_admin','a:1:{i:0;s:4:\"list\";}','',7,3,1,'admin/people','admin/people','List','t','','','a:0:{}',140,'Find and manage people interacting with your site.','',-10,'modules/user/user.admin.inc'),
('admin/people/permissions','','','user_access','a:1:{i:0;s:22:\"administer permissions\";}','drupal_get_form','a:1:{i:0;s:22:\"user_admin_permissions\";}','',7,3,1,'admin/people','admin/people','Permissions','t','','','a:0:{}',132,'Determine access to features by selecting permissions for roles.','',0,'modules/user/user.admin.inc'),
('admin/people/permissions/list','','','user_access','a:1:{i:0;s:22:\"administer permissions\";}','drupal_get_form','a:1:{i:0;s:22:\"user_admin_permissions\";}','',15,4,1,'admin/people/permissions','admin/people','Permissions','t','','','a:0:{}',140,'Determine access to features by selecting permissions for roles.','',-8,'modules/user/user.admin.inc'),
('admin/people/permissions/roles','','','user_access','a:1:{i:0;s:22:\"administer permissions\";}','drupal_get_form','a:1:{i:0;s:16:\"user_admin_roles\";}','',15,4,1,'admin/people/permissions','admin/people','Roles','t','','','a:0:{}',132,'List, edit, or add user roles.','',-5,'modules/user/user.admin.inc'),
('admin/people/permissions/roles/delete/%','a:1:{i:5;s:14:\"user_role_load\";}','','user_role_edit_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:30:\"user_admin_role_delete_confirm\";i:1;i:5;}','',62,6,0,'','admin/people/permissions/roles/delete/%','Delete role','t','','','a:0:{}',6,'','',0,'modules/user/user.admin.inc'),
('admin/people/permissions/roles/edit/%','a:1:{i:5;s:14:\"user_role_load\";}','','user_role_edit_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:15:\"user_admin_role\";i:1;i:5;}','',62,6,0,'','admin/people/permissions/roles/edit/%','Edit role','t','','','a:0:{}',6,'','',0,'modules/user/user.admin.inc'),
('admin/reports','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','system_admin_menu_block_page','a:0:{}','',3,2,0,'','admin/reports','Reports','t','','','a:0:{}',6,'View reports, updates, and errors.','left',5,'modules/system/system.admin.inc'),
('admin/reports/access-denied','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_top','a:1:{i:0;s:13:\"access denied\";}','',7,3,0,'','admin/reports/access-denied','Top \'access denied\' errors','t','','','a:0:{}',6,'View \'access denied\' errors (403s).','',0,'modules/dblog/dblog.admin.inc'),
('admin/reports/apachesolr','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','apachesolr_index_report','a:0:{}','',7,3,0,'','admin/reports/apachesolr','Apache Solr search index','t','','','a:0:{}',6,'Information about the contents of the index on the server','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/reports/apachesolr/%','a:1:{i:3;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:19:\"access site reports\";}','apachesolr_index_report','a:1:{i:0;i:3;}','',14,4,0,'','admin/reports/apachesolr/%','Apache Solr search index','t','','','a:0:{}',6,'Information about the contents of the index on the server','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/reports/apachesolr/%/conf','a:1:{i:3;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:19:\"access site reports\";}','apachesolr_config_files_overview','a:0:{}','',29,5,1,'admin/reports/apachesolr/%','admin/reports/apachesolr/%','Configuration files','t','','','a:0:{}',132,'','',5,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/reports/apachesolr/%/conf/%','a:2:{i:3;s:27:\"apachesolr_environment_load\";i:5;N;}','','user_access','a:1:{i:0;s:19:\"access site reports\";}','apachesolr_config_file','a:2:{i:0;i:5;i:1;i:3;}','',58,6,0,'','admin/reports/apachesolr/%/conf/%','Configuration file','t','','','a:0:{}',0,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/reports/apachesolr/%/index','a:1:{i:3;s:27:\"apachesolr_environment_load\";}','','user_access','a:1:{i:0;s:19:\"access site reports\";}','apachesolr_index_report','a:1:{i:0;i:3;}','',29,5,1,'admin/reports/apachesolr/%','admin/reports/apachesolr/%','Search index','t','','','a:0:{}',140,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('admin/reports/dblog','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_overview','a:0:{}','',7,3,0,'','admin/reports/dblog','Recent log messages','t','','','a:0:{}',6,'View events that have recently been logged.','',-1,'modules/dblog/dblog.admin.inc'),
('admin/reports/event/%','a:1:{i:3;N;}','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_event','a:1:{i:0;i:3;}','',14,4,0,'','admin/reports/event/%','Details','t','','','a:0:{}',6,'','',0,'modules/dblog/dblog.admin.inc'),
('admin/reports/fields','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','field_ui_fields_list','a:0:{}','',7,3,0,'','admin/reports/fields','Field list','t','','','a:0:{}',6,'Overview of fields on all entity types.','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/reports/page-not-found','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_top','a:1:{i:0;s:14:\"page not found\";}','',7,3,0,'','admin/reports/page-not-found','Top \'page not found\' errors','t','','','a:0:{}',6,'View \'page not found\' errors (404s).','',0,'modules/dblog/dblog.admin.inc'),
('admin/reports/status','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_status','a:0:{}','',7,3,0,'','admin/reports/status','Status report','t','','','a:0:{}',6,'Get a status report about your site\'s operation and any detected problems.','',-60,'modules/system/system.admin.inc'),
('admin/reports/status/php','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_php','a:0:{}','',15,4,0,'','admin/reports/status/php','PHP','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('admin/reports/status/rebuild','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','drupal_get_form','a:1:{i:0;s:30:\"node_configure_rebuild_confirm\";}','',15,4,0,'','admin/reports/status/rebuild','Rebuild permissions','t','','','a:0:{}',0,'','',0,'modules/node/node.admin.inc'),
('admin/reports/status/run-cron','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_run_cron','a:0:{}','',15,4,0,'','admin/reports/status/run-cron','Run cron','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('admin/reports/updates','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','update_status','a:0:{}','',7,3,0,'','admin/reports/updates','Available updates','t','','','a:0:{}',6,'Get a status report about available updates for your installed modules and themes.','',-50,'modules/update/update.report.inc'),
('admin/reports/updates/check','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','update_manual_status','a:0:{}','',15,4,0,'','admin/reports/updates/check','Manual update check','t','','','a:0:{}',0,'','',0,'modules/update/update.fetch.inc'),
('admin/reports/updates/install','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:27:\"update_manager_install_form\";i:1;s:6:\"report\";}','',15,4,1,'admin/reports/updates','admin/reports/updates','Install new module or theme','t','','','a:0:{}',388,'','',25,'modules/update/update.manager.inc'),
('admin/reports/updates/list','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','update_status','a:0:{}','',15,4,1,'admin/reports/updates','admin/reports/updates','List','t','','','a:0:{}',140,'','',0,'modules/update/update.report.inc'),
('admin/reports/updates/settings','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:15:\"update_settings\";}','',15,4,1,'admin/reports/updates','admin/reports/updates','Settings','t','','','a:0:{}',132,'','',50,'modules/update/update.settings.inc'),
('admin/reports/updates/update','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:26:\"update_manager_update_form\";i:1;s:6:\"report\";}','',15,4,1,'admin/reports/updates','admin/reports/updates','Update','t','','','a:0:{}',132,'','',10,'modules/update/update.manager.inc'),
('admin/settings/oapachesolr_custom_results','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','drupal_get_form','a:1:{i:0;s:31:\"apachesolr_custom_results_admin\";}','',7,3,0,'','admin/settings/oapachesolr_custom_results','Apache Solr Custom Results','t','','','a:0:{}',6,'Settings for how your Solr search results should look','',0,''),
('admin/structure','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',3,2,0,'','admin/structure','Structure','t','','','a:0:{}',6,'Administer blocks, content types, menus, etc.','right',-8,'modules/system/system.admin.inc'),
('admin/structure/block','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','block_admin_display','a:1:{i:0;s:6:\"bartik\";}','',7,3,0,'','admin/structure/block','Blocks','t','','','a:0:{}',6,'Configure what block content appears in your site\'s sidebars and other regions.','',0,'modules/block/block.admin.inc'),
('admin/structure/block/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',15,4,1,'admin/structure/block','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/demo/bartik','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:6:\"bartik\";}','',31,5,0,'','admin/structure/block/demo/bartik','Bartik','t','','_block_custom_theme','a:1:{i:0;s:6:\"bartik\";}',0,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/demo/garland','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:7:\"garland\";}','',31,5,0,'','admin/structure/block/demo/garland','Garland','t','','_block_custom_theme','a:1:{i:0;s:7:\"garland\";}',0,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/demo/seven','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:5:\"seven\";}','',31,5,0,'','admin/structure/block/demo/seven','Seven','t','','_block_custom_theme','a:1:{i:0;s:5:\"seven\";}',0,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/demo/stark','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:5:\"stark\";}','',31,5,0,'','admin/structure/block/demo/stark','Stark','t','','_block_custom_theme','a:1:{i:0;s:5:\"stark\";}',0,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/demo/wweave','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":13:{s:8:\"filename\";s:35:\"sites/all/themes/wweave/wweave.info\";s:4:\"name\";s:6:\"wweave\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"1\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:15:{s:4:\"name\";s:6:\"wweave\";s:11:\"description\";s:29:\"A flexible, responsive theme.\";s:7:\"version\";s:7:\"7.x-1.0\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:4:{s:21:\"css/bootstrap.min.css\";s:45:\"sites/all/themes/wweave/css/bootstrap.min.css\";s:17:\"css/ww_styles.css\";s:41:\"sites/all/themes/wweave/css/ww_styles.css\";s:18:\"css/responsive.css\";s:42:\"sites/all/themes/wweave/css/responsive.css\";s:15:\"css/mdb.min.css\";s:39:\"sites/all/themes/wweave/css/mdb.min.css\";}}s:7:\"scripts\";a:4:{s:16:\"js/jquery.min.js\";s:40:\"sites/all/themes/wweave/js/jquery.min.js\";s:19:\"js/bootstrap.min.js\";s:43:\"sites/all/themes/wweave/js/bootstrap.min.js\";s:10:\"js/main.js\";s:34:\"sites/all/themes/wweave/js/main.js\";s:33:\"js/material-components-web.min.js\";s:57:\"sites/all/themes/wweave/js/material-components-web.min.js\";}s:7:\"regions\";a:6:{s:7:\"content\";s:7:\"Content\";s:21:\"search_filter_sidebar\";s:21:\"Search Filter Sidebar\";s:14:\"social_sharing\";s:14:\"Social Sharing\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:38:\"sites/all/themes/wweave/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"mtime\";i:1549344031;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:4:{s:21:\"css/bootstrap.min.css\";s:45:\"sites/all/themes/wweave/css/bootstrap.min.css\";s:17:\"css/ww_styles.css\";s:41:\"sites/all/themes/wweave/css/ww_styles.css\";s:18:\"css/responsive.css\";s:42:\"sites/all/themes/wweave/css/responsive.css\";s:15:\"css/mdb.min.css\";s:39:\"sites/all/themes/wweave/css/mdb.min.css\";}}s:7:\"scripts\";a:4:{s:16:\"js/jquery.min.js\";s:40:\"sites/all/themes/wweave/js/jquery.min.js\";s:19:\"js/bootstrap.min.js\";s:43:\"sites/all/themes/wweave/js/bootstrap.min.js\";s:10:\"js/main.js\";s:34:\"sites/all/themes/wweave/js/main.js\";s:33:\"js/material-components-web.min.js\";s:57:\"sites/all/themes/wweave/js/material-components-web.min.js\";}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:6:\"wweave\";}','',31,5,0,'','admin/structure/block/demo/wweave','wweave','t','','_block_custom_theme','a:1:{i:0;s:6:\"wweave\";}',0,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/list/bartik','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:6:\"bartik\";}','',31,5,1,'admin/structure/block','admin/structure/block','Bartik','t','','','a:0:{}',140,'','',-10,'modules/block/block.admin.inc'),
('admin/structure/block/list/garland','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:7:\"garland\";}','',31,5,1,'admin/structure/block','admin/structure/block','Garland','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/list/garland/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/garland','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/list/seven','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:5:\"seven\";}','',31,5,1,'admin/structure/block','admin/structure/block','Seven','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/list/seven/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/seven','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/list/stark','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:5:\"stark\";}','',31,5,1,'admin/structure/block','admin/structure/block','Stark','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/list/stark/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/stark','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/list/wweave','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":13:{s:8:\"filename\";s:35:\"sites/all/themes/wweave/wweave.info\";s:4:\"name\";s:6:\"wweave\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"1\";s:14:\"schema_version\";s:1:\"0\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:15:{s:4:\"name\";s:6:\"wweave\";s:11:\"description\";s:29:\"A flexible, responsive theme.\";s:7:\"version\";s:7:\"7.x-1.0\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:4:{s:21:\"css/bootstrap.min.css\";s:45:\"sites/all/themes/wweave/css/bootstrap.min.css\";s:17:\"css/ww_styles.css\";s:41:\"sites/all/themes/wweave/css/ww_styles.css\";s:18:\"css/responsive.css\";s:42:\"sites/all/themes/wweave/css/responsive.css\";s:15:\"css/mdb.min.css\";s:39:\"sites/all/themes/wweave/css/mdb.min.css\";}}s:7:\"scripts\";a:4:{s:16:\"js/jquery.min.js\";s:40:\"sites/all/themes/wweave/js/jquery.min.js\";s:19:\"js/bootstrap.min.js\";s:43:\"sites/all/themes/wweave/js/bootstrap.min.js\";s:10:\"js/main.js\";s:34:\"sites/all/themes/wweave/js/main.js\";s:33:\"js/material-components-web.min.js\";s:57:\"sites/all/themes/wweave/js/material-components-web.min.js\";}s:7:\"regions\";a:6:{s:7:\"content\";s:7:\"Content\";s:21:\"search_filter_sidebar\";s:21:\"Search Filter Sidebar\";s:14:\"social_sharing\";s:14:\"Social Sharing\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:38:\"sites/all/themes/wweave/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"mtime\";i:1549344031;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:4:{s:21:\"css/bootstrap.min.css\";s:45:\"sites/all/themes/wweave/css/bootstrap.min.css\";s:17:\"css/ww_styles.css\";s:41:\"sites/all/themes/wweave/css/ww_styles.css\";s:18:\"css/responsive.css\";s:42:\"sites/all/themes/wweave/css/responsive.css\";s:15:\"css/mdb.min.css\";s:39:\"sites/all/themes/wweave/css/mdb.min.css\";}}s:7:\"scripts\";a:4:{s:16:\"js/jquery.min.js\";s:40:\"sites/all/themes/wweave/js/jquery.min.js\";s:19:\"js/bootstrap.min.js\";s:43:\"sites/all/themes/wweave/js/bootstrap.min.js\";s:10:\"js/main.js\";s:34:\"sites/all/themes/wweave/js/main.js\";s:33:\"js/material-components-web.min.js\";s:57:\"sites/all/themes/wweave/js/material-components-web.min.js\";}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:6:\"wweave\";}','',31,5,1,'admin/structure/block','admin/structure/block','wweave','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/list/wweave/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/wweave','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%','a:2:{i:4;N;i:5;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:3:{i:0;s:21:\"block_admin_configure\";i:1;i:4;i:2;i:5;}','',60,6,0,'','admin/structure/block/manage/%/%','Configure block','t','','','a:0:{}',6,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/configure','a:2:{i:4;N;i:5;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:3:{i:0;s:21:\"block_admin_configure\";i:1;i:4;i:2;i:5;}','',121,7,2,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Configure block','t','','','a:0:{}',140,'','',0,'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/delete','a:2:{i:4;N;i:5;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:3:{i:0;s:25:\"block_custom_block_delete\";i:1;i:4;i:2;i:5;}','',121,7,0,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Delete block','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc'),
('admin/structure/menu','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_overview_page','a:0:{}','',7,3,0,'','admin/structure/menu','Menus','t','','','a:0:{}',6,'Add new menus to your site, edit existing menus, and rename and reorganize menu links.','',0,'modules/menu/menu.admin.inc'),
('admin/structure/menu/add','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:14:\"menu_edit_menu\";i:1;s:3:\"add\";}','',15,4,1,'admin/structure/menu','admin/structure/menu','Add menu','t','','','a:0:{}',388,'','',0,'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/delete','a:1:{i:4;s:14:\"menu_link_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_item_delete_page','a:1:{i:0;i:4;}','',61,6,0,'','admin/structure/menu/item/%/delete','Delete menu link','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/edit','a:1:{i:4;s:14:\"menu_link_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:4:{i:0;s:14:\"menu_edit_item\";i:1;s:4:\"edit\";i:2;i:4;i:3;N;}','',61,6,0,'','admin/structure/menu/item/%/edit','Edit menu link','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/reset','a:1:{i:4;s:14:\"menu_link_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:23:\"menu_reset_item_confirm\";i:1;i:4;}','',61,6,0,'','admin/structure/menu/item/%/reset','Reset menu link','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc'),
('admin/structure/menu/list','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_overview_page','a:0:{}','',15,4,1,'admin/structure/menu','admin/structure/menu','List menus','t','','','a:0:{}',140,'','',-10,'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:18:\"menu_overview_form\";i:1;i:4;}','',30,5,0,'','admin/structure/menu/manage/%','Customize menu','menu_overview_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/add','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:4:{i:0;s:14:\"menu_edit_item\";i:1;s:3:\"add\";i:2;N;i:3;i:4;}','',61,6,1,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Add link','t','','','a:0:{}',388,'','',0,'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/delete','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_delete_menu_page','a:1:{i:0;i:4;}','',61,6,0,'','admin/structure/menu/manage/%/delete','Delete menu','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/edit','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:3:{i:0;s:14:\"menu_edit_menu\";i:1;s:4:\"edit\";i:2;i:4;}','',61,6,3,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Edit menu','t','','','a:0:{}',132,'','',0,'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/list','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:18:\"menu_overview_form\";i:1;i:4;}','',61,6,3,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','List links','t','','','a:0:{}',140,'','',-10,'modules/menu/menu.admin.inc'),
('admin/structure/menu/parents','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_parent_options_js','a:0:{}','',15,4,0,'','admin/structure/menu/parents','Parent menu items','t','','','a:0:{}',0,'','',0,''),
('admin/structure/menu/settings','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:1:{i:0;s:14:\"menu_configure\";}','',15,4,1,'admin/structure/menu','admin/structure/menu','Settings','t','','','a:0:{}',132,'','',5,'modules/menu/menu.admin.inc'),
('admin/structure/types','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','node_overview_types','a:0:{}','',7,3,0,'','admin/structure/types','Content types','t','','','a:0:{}',6,'Manage content types, including default status, front page promotion, comment settings, etc.','',0,'modules/node/content_types.inc'),
('admin/structure/types/add','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:1:{i:0;s:14:\"node_type_form\";}','',15,4,1,'admin/structure/types','admin/structure/types','Add content type','t','','','a:0:{}',388,'','',0,'modules/node/content_types.inc'),
('admin/structure/types/list','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','node_overview_types','a:0:{}','',15,4,1,'admin/structure/types','admin/structure/types','List','t','','','a:0:{}',140,'','',-10,'modules/node/content_types.inc'),
('admin/structure/types/manage/%','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:14:\"node_type_form\";i:1;i:4;}','',30,5,0,'','admin/structure/types/manage/%','Edit content type','node_type_page_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/node/content_types.inc'),
('admin/structure/types/manage/%/delete','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"node_type_delete_confirm\";i:1;i:4;}','',61,6,0,'','admin/structure/types/manage/%/delete','Delete','t','','','a:0:{}',6,'','',0,'modules/node/content_types.inc'),
('admin/structure/types/manage/%/display','a:1:{i:4;s:14:\"node_type_load\";}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:7:\"default\";}','',61,6,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Manage display','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/default','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:6:{i:0;s:4:\"node\";i:1;i:4;i:2;s:7:\"default\";i:3;s:21:\"field_ui_admin_access\";i:4;s:11:\"user_access\";i:5;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:7:\"default\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/full','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:6:{i:0;s:4:\"node\";i:1;i:4;i:2;s:4:\"full\";i:3;s:21:\"field_ui_admin_access\";i:4;s:11:\"user_access\";i:5;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:4:\"full\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Full content','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/rss','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:6:{i:0;s:4:\"node\";i:1;i:4;i:2;s:3:\"rss\";i:3;s:21:\"field_ui_admin_access\";i:4;s:11:\"user_access\";i:5;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:3:\"rss\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','RSS','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/teaser','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:6:{i:0;s:4:\"node\";i:1;i:4;i:2;s:6:\"teaser\";i:3;s:21:\"field_ui_admin_access\";i:4;s:11:\"user_access\";i:5;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:6:\"teaser\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Teaser','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/edit','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:14:\"node_type_form\";i:1;i:4;}','',61,6,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Edit','t','','','a:0:{}',140,'','',0,'modules/node/content_types.inc'),
('admin/structure/types/manage/%/fields','a:1:{i:4;s:14:\"node_type_load\";}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:4:\"node\";i:2;i:4;}','',61,6,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Manage fields','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:6;}','',122,7,0,'','admin/structure/types/manage/%/fields/%','','field_ui_menu_title','a:1:{i:0;i:6;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/delete','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/edit','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/field-settings','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/widget-type','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','field_ui_admin_access','a:2:{i:0;s:11:\"user_access\";i:1;a:1:{i:0;s:24:\"administer content types\";}}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc'),
('admin/tasks','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',3,2,1,'admin','admin','Tasks','t','','','a:0:{}',140,'','',-20,'modules/system/system.admin.inc'),
('admin/update/ready','','','update_manager_access','a:0:{}','drupal_get_form','a:1:{i:0;s:32:\"update_manager_update_ready_form\";}','',7,3,0,'','admin/update/ready','Ready to update','t','','','a:0:{}',0,'','',0,'modules/update/update.manager.inc'),
('batch','','','1','a:0:{}','system_batch_page','a:0:{}','',1,1,0,'','batch','','t','','_system_batch_theme','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('blog','','','user_access','a:1:{i:0;s:14:\"access content\";}','blog_page_last','a:0:{}','',1,1,0,'','blog','Blogs','t','','','a:0:{}',20,'','',0,'modules/blog/blog.pages.inc'),
('blog/%','a:1:{i:1;s:22:\"user_uid_optional_load\";}','a:1:{i:1;s:24:\"user_uid_optional_to_arg\";}','blog_page_user_access','a:1:{i:0;i:1;}','blog_page_user','a:1:{i:0;i:1;}','',2,2,0,'','blog/%','My blog','t','','','a:0:{}',6,'','',0,'modules/blog/blog.pages.inc'),
('blog/%/feed','a:1:{i:1;s:9:\"user_load\";}','','blog_page_user_access','a:1:{i:0;i:1;}','blog_feed_user','a:1:{i:0;i:1;}','',5,3,0,'','blog/%/feed','Blogs','t','','','a:0:{}',0,'','',0,'modules/blog/blog.pages.inc'),
('blog/feed','','','user_access','a:1:{i:0;s:14:\"access content\";}','blog_feed_last','a:0:{}','',3,2,0,'','blog/feed','Blogs','t','','','a:0:{}',0,'','',0,'modules/blog/blog.pages.inc'),
('comment/%comment/devel','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_load_object','a:2:{i:0;s:7:\"comment\";i:1;i:1;}','',7,3,1,'','comment/%comment/devel','Devel','t','','','a:0:{}',132,'','',100,'sites/all/modules/devel/devel.pages.inc'),
('comment/%comment/devel/load','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_load_object','a:2:{i:0;s:7:\"comment\";i:1;i:1;}','',15,4,1,'comment/%comment/devel','comment/%comment/devel/load','Load','t','','','a:0:{}',140,'','',0,'sites/all/modules/devel/devel.pages.inc'),
('comment/%comment/devel/render','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_render_object','a:2:{i:0;s:7:\"comment\";i:1;i:1;}','',15,4,1,'comment/%comment/devel','comment/%comment/devel/render','Render','t','','','a:0:{}',132,'','',100,'sites/all/modules/devel/devel.pages.inc'),
('devel/arguments','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_querylog_arguments','a:0:{}','',3,2,0,'','devel/arguments','Arguments query','t','','','a:0:{}',0,'Return a given query, with arguments instead of placeholders. Used by query log','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/cache/clear','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_cache_clear','a:0:{}','',7,3,0,'','devel/cache/clear','Clear cache','t','','','a:0:{}',6,'Clear the CSS cache and all database cache tables which store page, node, theme and variable caches.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/elements','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_elements_page','a:0:{}','',3,2,0,'','devel/elements','Hook_elements()','t','','','a:0:{}',6,'View the active form/render elements for this site.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/entity/info','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_entity_info_page','a:0:{}','',7,3,0,'','devel/entity/info','Entity info','t','','','a:0:{}',6,'View entity information across the whole site.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/explain','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_querylog_explain','a:0:{}','',3,2,0,'','devel/explain','Explain query','t','','','a:0:{}',0,'Run an EXPLAIN on a given query. Used by query log','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/field/info','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_field_info_page','a:0:{}','',7,3,0,'','devel/field/info','Field info','t','','','a:0:{}',6,'View fields information across the whole site.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/menu/item','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_menu_item','a:0:{}','',7,3,0,'','devel/menu/item','Menu item','t','','','a:0:{}',6,'Details about a given menu item.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/menu/reset','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','drupal_get_form','a:1:{i:0;s:18:\"devel_menu_rebuild\";}','',7,3,0,'','devel/menu/reset','Rebuild menus','t','','','a:0:{}',6,'Rebuild menu based on hook_menu() and revert any custom changes. All menu items return to their default settings.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/node_access/by_user/%/%','a:2:{i:3;N;i:4;N;}','','user_access','a:1:{i:0;s:34:\"view devel_node_access information\";}','devel_node_access_user_ajax','a:2:{i:0;i:3;i:1;i:4;}','',28,5,0,'','devel/node_access/by_user/%/%','','t','','','a:0:{}',0,'','',0,''),
('devel/node_access/summary','','','user_access','a:1:{i:0;s:34:\"view devel_node_access information\";}','dna_summary','a:0:{}','',7,3,0,'','devel/node_access/summary','Node_access summary','t','','','a:0:{}',6,'','',0,''),
('devel/php','','','user_access','a:1:{i:0;s:16:\"execute php code\";}','drupal_get_form','a:1:{i:0;s:18:\"devel_execute_form\";}','',3,2,0,'','devel/php','Execute PHP Code','t','','','a:0:{}',6,'Execute some PHP code','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/phpinfo','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_phpinfo','a:0:{}','',3,2,0,'','devel/phpinfo','PHPinfo()','t','','','a:0:{}',6,'View your server\'s PHP configuration','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/reference','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_function_reference','a:0:{}','',3,2,0,'','devel/reference','Function reference','t','','','a:0:{}',6,'View a list of currently defined user functions with documentation links.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/reinstall','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','drupal_get_form','a:1:{i:0;s:15:\"devel_reinstall\";}','',3,2,0,'','devel/reinstall','Reinstall modules','t','','','a:0:{}',6,'Run hook_uninstall() and then hook_install() for a given module.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/run-cron','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_run_cron','a:0:{}','',3,2,0,'','devel/run-cron','Run cron','t','','','a:0:{}',6,'','',0,'modules/system/system.admin.inc'),
('devel/session','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_session','a:0:{}','',3,2,0,'','devel/session','Session viewer','t','','','a:0:{}',6,'List the contents of $_SESSION.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/settings','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:20:\"devel_admin_settings\";}','',3,2,0,'','devel/settings','Devel settings','t','','','a:0:{}',6,'Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href=\"/ww_cms/admin/structure/block\">block administration</a> page.','',0,'sites/all/modules/devel/devel.admin.inc'),
('devel/switch','','','_devel_switch_user_access','a:1:{i:0;i:2;}','devel_switch_user','a:0:{}','',3,2,0,'','devel/switch','Switch user','t','','','a:0:{}',0,'','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/theme/registry','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_theme_registry','a:0:{}','',7,3,0,'','devel/theme/registry','Theme registry','t','','','a:0:{}',6,'View a list of available theme functions across the whole site.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/variable','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','drupal_get_form','a:1:{i:0;s:19:\"devel_variable_form\";}','',3,2,0,'','devel/variable','Variable editor','t','','','a:0:{}',6,'Edit and delete site variables.','',0,'sites/all/modules/devel/devel.pages.inc'),
('devel/variable/edit/%','a:1:{i:3;N;}','','user_access','a:1:{i:0;s:24:\"access devel information\";}','drupal_get_form','a:2:{i:0;s:19:\"devel_variable_edit\";i:1;i:3;}','',14,4,0,'','devel/variable/edit/%','Variable editor','t','','','a:0:{}',0,'','',0,'sites/all/modules/devel/devel.pages.inc'),
('file/ajax','','','user_access','a:1:{i:0;s:14:\"access content\";}','file_ajax_upload','a:0:{}','ajax_deliver',3,2,0,'','file/ajax','','t','','ajax_base_page_theme','a:0:{}',0,'','',0,''),
('file/progress','','','user_access','a:1:{i:0;s:14:\"access content\";}','file_ajax_progress','a:0:{}','',3,2,0,'','file/progress','','t','','ajax_base_page_theme','a:0:{}',0,'','',0,''),
('filter/tips','','','1','a:0:{}','filter_tips_long','a:0:{}','',3,2,0,'','filter/tips','Compose tips','t','','','a:0:{}',20,'','',0,'modules/filter/filter.pages.inc'),
('filter/tips/%','a:1:{i:2;s:18:\"filter_format_load\";}','','filter_access','a:1:{i:0;i:2;}','filter_tips_long','a:1:{i:0;i:2;}','',6,3,0,'','filter/tips/%','Compose tips','t','','','a:0:{}',6,'','',0,'modules/filter/filter.pages.inc'),
('node','','','user_access','a:1:{i:0;s:14:\"access content\";}','node_page_default','a:0:{}','',1,1,0,'','node','','t','','','a:0:{}',0,'','',0,''),
('node/%','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:4:\"view\";i:1;i:1;}','node_page_view','a:1:{i:0;i:1;}','',2,2,0,'','node/%','','node_page_title','a:1:{i:0;i:1;}','','a:0:{}',6,'','',0,''),
('node/%/delete','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:6:\"delete\";i:1;i:1;}','drupal_get_form','a:2:{i:0;s:19:\"node_delete_confirm\";i:1;i:1;}','',5,3,2,'node/%','node/%','Delete','t','','','a:0:{}',132,'','',1,'modules/node/node.pages.inc'),
('node/%/devel','a:1:{i:1;s:9:\"node_load\";}','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_load_object','a:2:{i:0;s:4:\"node\";i:1;i:1;}','',5,3,1,'node/%','node/%','Devel','t','','','a:0:{}',132,'','',100,'sites/all/modules/devel/devel.pages.inc'),
('node/%/devel/apachesolr','a:1:{i:1;s:9:\"node_load\";}','','user_access','a:1:{i:0;s:24:\"access devel information\";}','apachesolr_devel','a:1:{i:0;i:1;}','',11,4,1,'node/%/devel','node/%','Apache Solr','t','','','a:0:{}',132,'','',0,'sites/all/modules/apachesolr/apachesolr.admin.inc'),
('node/%/devel/load','a:1:{i:1;s:9:\"node_load\";}','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_load_object','a:2:{i:0;s:4:\"node\";i:1;i:1;}','',11,4,1,'node/%/devel','node/%','Load','t','','','a:0:{}',140,'','',0,'sites/all/modules/devel/devel.pages.inc'),
('node/%/devel/render','a:1:{i:1;s:9:\"node_load\";}','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_render_object','a:2:{i:0;s:4:\"node\";i:1;i:1;}','',11,4,1,'node/%/devel','node/%','Render','t','','','a:0:{}',132,'','',100,'sites/all/modules/devel/devel.pages.inc'),
('node/%/edit','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:6:\"update\";i:1;i:1;}','node_page_edit','a:1:{i:0;i:1;}','',5,3,3,'node/%','node/%','Edit','t','','','a:0:{}',132,'','',0,'modules/node/node.pages.inc'),
('node/%/revisions','a:1:{i:1;s:9:\"node_load\";}','','_node_revision_access','a:1:{i:0;i:1;}','node_revision_overview','a:1:{i:0;i:1;}','',5,3,1,'node/%','node/%','Revisions','t','','','a:0:{}',132,'','',2,'modules/node/node.pages.inc'),
('node/%/revisions/%/delete','a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}','','_node_revision_access','a:2:{i:0;i:1;i:1;s:6:\"delete\";}','drupal_get_form','a:2:{i:0;s:28:\"node_revision_delete_confirm\";i:1;i:1;}','',21,5,0,'','node/%/revisions/%/delete','Delete earlier revision','t','','','a:0:{}',6,'','',0,'modules/node/node.pages.inc'),
('node/%/revisions/%/revert','a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}','','_node_revision_access','a:2:{i:0;i:1;i:1;s:6:\"update\";}','drupal_get_form','a:2:{i:0;s:28:\"node_revision_revert_confirm\";i:1;i:1;}','',21,5,0,'','node/%/revisions/%/revert','Revert to earlier revision','t','','','a:0:{}',6,'','',0,'modules/node/node.pages.inc'),
('node/%/revisions/%/view','a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}','','_node_revision_access','a:1:{i:0;i:1;}','node_show','a:2:{i:0;i:1;i:1;b:1;}','',21,5,0,'','node/%/revisions/%/view','Revisions','t','','','a:0:{}',6,'','',0,''),
('node/%/view','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:4:\"view\";i:1;i:1;}','node_page_view','a:1:{i:0;i:1;}','',5,3,1,'node/%','node/%','View','t','','','a:0:{}',140,'','',-10,''),
('node/add','','','_node_add_access','a:0:{}','node_add_page','a:0:{}','',3,2,0,'','node/add','Add content','t','','','a:0:{}',6,'','',0,'modules/node/node.pages.inc'),
('node/add/blog','','','node_access','a:2:{i:0;s:6:\"create\";i:1;s:4:\"blog\";}','node_add','a:1:{i:0;s:4:\"blog\";}','',7,3,0,'','node/add/blog','Blog entry','check_plain','','','a:0:{}',6,'Use for multi-user blogs. Every user gets a personal blog.','',0,'modules/node/node.pages.inc'),
('rss.xml','','','user_access','a:1:{i:0;s:14:\"access content\";}','node_feed','a:2:{i:0;b:0;i:1;a:0:{}}','',1,1,0,'','rss.xml','RSS feed','t','','','a:0:{}',0,'','',0,''),
('sites/default/files/styles/%','a:1:{i:4;s:16:\"image_style_load\";}','','1','a:0:{}','image_style_deliver','a:1:{i:0;i:4;}','',30,5,0,'','sites/default/files/styles/%','Generate image style','t','','','a:0:{}',0,'','',0,''),
('system/ajax','','','1','a:0:{}','ajax_form_callback','a:0:{}','ajax_deliver',3,2,0,'','system/ajax','AHAH callback','t','','ajax_base_page_theme','a:0:{}',0,'','',0,'includes/form.inc'),
('system/files','','','1','a:0:{}','file_download','a:1:{i:0;s:7:\"private\";}','',3,2,0,'','system/files','File download','t','','','a:0:{}',0,'','',0,''),
('system/files/styles/%','a:1:{i:3;s:16:\"image_style_load\";}','','1','a:0:{}','image_style_deliver','a:1:{i:0;i:3;}','',14,4,0,'','system/files/styles/%','Generate image style','t','','','a:0:{}',0,'','',0,''),
('system/temporary','','','1','a:0:{}','file_download','a:1:{i:0;s:9:\"temporary\";}','',3,2,0,'','system/temporary','Temporary files','t','','','a:0:{}',0,'','',0,''),
('system/timezone','','','1','a:0:{}','system_timezone','a:0:{}','',3,2,0,'','system/timezone','Time zone','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc'),
('taxonomy/term/%taxonomy_term/devel','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_load_object','a:3:{i:0;s:13:\"taxonomy_term\";i:1;i:2;i:2;s:4:\"term\";}','',15,4,1,'','taxonomy/term/%taxonomy_term/devel','Devel','t','','','a:0:{}',132,'','',100,'sites/all/modules/devel/devel.pages.inc'),
('taxonomy/term/%taxonomy_term/devel/load','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_load_object','a:3:{i:0;s:13:\"taxonomy_term\";i:1;i:2;i:2;s:4:\"term\";}','',31,5,1,'taxonomy/term/%taxonomy_term/devel','taxonomy/term/%taxonomy_term/devel/load','Load','t','','','a:0:{}',140,'','',0,'sites/all/modules/devel/devel.pages.inc'),
('taxonomy/term/%taxonomy_term/devel/render','','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_render_object','a:3:{i:0;s:13:\"taxonomy_term\";i:1;i:2;i:2;s:4:\"term\";}','',31,5,1,'taxonomy/term/%taxonomy_term/devel','taxonomy/term/%taxonomy_term/devel/render','Render','t','','','a:0:{}',132,'','',100,'sites/all/modules/devel/devel.pages.inc'),
('toolbar/toggle','','','user_access','a:1:{i:0;s:14:\"access toolbar\";}','toolbar_toggle_page','a:0:{}','',3,2,0,'','toolbar/toggle','Toggle drawer visibility','t','','','a:0:{}',0,'','',0,''),
('user','','','1','a:0:{}','user_page','a:0:{}','',1,1,0,'','user','User account','user_menu_title','','','a:0:{}',6,'','',-10,'modules/user/user.pages.inc'),
('user/%','a:1:{i:1;s:9:\"user_load\";}','','user_view_access','a:1:{i:0;i:1;}','user_view_page','a:1:{i:0;i:1;}','',2,2,0,'','user/%','My account','user_page_title','a:1:{i:0;i:1;}','','a:0:{}',6,'','',0,''),
('user/%/cancel','a:1:{i:1;s:9:\"user_load\";}','','user_cancel_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:24:\"user_cancel_confirm_form\";i:1;i:1;}','',5,3,0,'','user/%/cancel','Cancel account','t','','','a:0:{}',6,'','',0,'modules/user/user.pages.inc'),
('user/%/cancel/confirm/%/%','a:3:{i:1;s:9:\"user_load\";i:4;N;i:5;N;}','','user_cancel_access','a:1:{i:0;i:1;}','user_cancel_confirm','a:3:{i:0;i:1;i:1;i:4;i:2;i:5;}','',44,6,0,'','user/%/cancel/confirm/%/%','Confirm account cancellation','t','','','a:0:{}',6,'','',0,'modules/user/user.pages.inc'),
('user/%/devel','a:1:{i:1;s:9:\"user_load\";}','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_load_object','a:2:{i:0;s:4:\"user\";i:1;i:1;}','',5,3,1,'user/%','user/%','Devel','t','','','a:0:{}',132,'','',100,'sites/all/modules/devel/devel.pages.inc'),
('user/%/devel/load','a:1:{i:1;s:9:\"user_load\";}','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_load_object','a:2:{i:0;s:4:\"user\";i:1;i:1;}','',11,4,1,'user/%/devel','user/%','Load','t','','','a:0:{}',140,'','',0,'sites/all/modules/devel/devel.pages.inc'),
('user/%/devel/render','a:1:{i:1;s:9:\"user_load\";}','','user_access','a:1:{i:0;s:24:\"access devel information\";}','devel_render_object','a:2:{i:0;s:4:\"user\";i:1;i:1;}','',11,4,1,'user/%/devel','user/%','Render','t','','','a:0:{}',132,'','',100,'sites/all/modules/devel/devel.pages.inc'),
('user/%/edit','a:1:{i:1;s:9:\"user_load\";}','','user_edit_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:17:\"user_profile_form\";i:1;i:1;}','',5,3,1,'user/%','user/%','Edit','t','','','a:0:{}',132,'','',0,'modules/user/user.pages.inc'),
('user/%/edit/account','a:1:{i:1;a:1:{s:18:\"user_category_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}','','user_edit_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:17:\"user_profile_form\";i:1;i:1;}','',11,4,1,'user/%/edit','user/%','Account','t','','','a:0:{}',140,'','',0,'modules/user/user.pages.inc'),
('user/%/view','a:1:{i:1;s:9:\"user_load\";}','','user_view_access','a:1:{i:0;i:1;}','user_view_page','a:1:{i:0;i:1;}','',5,3,1,'user/%','user/%','View','t','','','a:0:{}',140,'','',-10,''),
('user/autocomplete','','','user_access','a:1:{i:0;s:20:\"access user profiles\";}','user_autocomplete','a:0:{}','',3,2,0,'','user/autocomplete','User autocomplete','t','','','a:0:{}',0,'','',0,'modules/user/user.pages.inc'),
('user/login','','','user_is_anonymous','a:0:{}','user_page','a:0:{}','',3,2,1,'user','user','Log in','t','','','a:0:{}',140,'','',0,'modules/user/user.pages.inc'),
('user/logout','','','user_is_logged_in','a:0:{}','user_logout','a:0:{}','',3,2,0,'','user/logout','Log out','t','','','a:0:{}',6,'','',10,'modules/user/user.pages.inc'),
('user/password','','','1','a:0:{}','drupal_get_form','a:1:{i:0;s:9:\"user_pass\";}','',3,2,1,'user','user','Request new password','t','','','a:0:{}',132,'','',0,'modules/user/user.pages.inc'),
('user/register','','','user_register_access','a:0:{}','drupal_get_form','a:1:{i:0;s:18:\"user_register_form\";}','',3,2,1,'user','user','Create new account','t','','','a:0:{}',132,'','',0,''),
('user/reset/%/%/%','a:3:{i:2;N;i:3;N;i:4;N;}','','1','a:0:{}','drupal_get_form','a:4:{i:0;s:15:\"user_pass_reset\";i:1;i:2;i:2;i:3;i:3;i:4;}','',24,5,0,'','user/reset/%/%/%','Reset password','t','','','a:0:{}',0,'','',0,'modules/user/user.pages.inc');

UNLOCK TABLES;

/*Table structure for table `node` */

DROP TABLE IF EXISTS `node`;

CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';

/*Data for the table `node` */

LOCK TABLES `node` WRITE;

UNLOCK TABLES;

/*Table structure for table `node_access` */

DROP TABLE IF EXISTS `node_access`;

CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';

/*Data for the table `node_access` */

LOCK TABLES `node_access` WRITE;

insert  into `node_access`(`nid`,`gid`,`realm`,`grant_view`,`grant_update`,`grant_delete`) values 
(0,0,'all',1,0,0);

UNLOCK TABLES;

/*Table structure for table `node_revision` */

DROP TABLE IF EXISTS `node_revision`;

CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';

/*Data for the table `node_revision` */

LOCK TABLES `node_revision` WRITE;

UNLOCK TABLES;

/*Table structure for table `node_type` */

DROP TABLE IF EXISTS `node_type`;

CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';

/*Data for the table `node_type` */

LOCK TABLES `node_type` WRITE;

insert  into `node_type`(`type`,`name`,`base`,`module`,`description`,`help`,`has_title`,`title_label`,`custom`,`modified`,`locked`,`disabled`,`orig_type`) values 
('blog','Blog entry','blog','blog','Use for multi-user blogs. Every user gets a personal blog.','',1,'Title',0,0,1,0,'blog');

UNLOCK TABLES;

/*Table structure for table `queue` */

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';

/*Data for the table `queue` */

LOCK TABLES `queue` WRITE;

insert  into `queue`(`item_id`,`name`,`data`,`expire`,`created`) values 
(32,'update_fetch_tasks','a:8:{s:4:\"name\";s:6:\"wweave\";s:4:\"info\";a:6:{s:4:\"name\";s:6:\"wweave\";s:7:\"package\";s:6:\"Sonata\";s:7:\"version\";s:7:\"7.x-1.0\";s:7:\"project\";s:6:\"wweave\";s:16:\"_info_file_ctime\";i:1549339170;s:9:\"datestamp\";i:0;}s:9:\"datestamp\";i:0;s:8:\"includes\";a:1:{s:6:\"wweave\";s:6:\"wweave\";}s:12:\"project_type\";s:6:\"module\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}}',0,1549344426);

UNLOCK TABLES;

/*Table structure for table `registry` */

DROP TABLE IF EXISTS `registry`;

CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';

/*Data for the table `registry` */

LOCK TABLES `registry` WRITE;

insert  into `registry`(`name`,`type`,`filename`,`module`,`weight`) values 
('AbstractDrupalSolrOnlineWebTestCase','class','sites/all/modules/apachesolr/tests/solr_index_and_search.test','apachesolr',0),
('AccessDeniedTestCase','class','modules/system/system.test','system',0),
('AdminMetaTagTestCase','class','modules/system/system.test','system',0),
('ApacheSolrDocument','class','sites/all/modules/apachesolr/Apache_Solr_Document.php','apachesolr',0),
('ApacheSolrFacetapiAdapter','class','sites/all/modules/apachesolr/plugins/facetapi/adapter.inc','apachesolr',0),
('ApacheSolrFacetapiDate','class','sites/all/modules/apachesolr/plugins/facetapi/query_type_date.inc','apachesolr',0),
('ApacheSolrFacetapiGeo','class','sites/all/modules/apachesolr/plugins/facetapi/query_type_geo.inc','apachesolr',0),
('ApacheSolrFacetapiNumericRange','class','sites/all/modules/apachesolr/plugins/facetapi/query_type_numeric_range.inc','apachesolr',0),
('ApacheSolrFacetapiTerm','class','sites/all/modules/apachesolr/plugins/facetapi/query_type_term.inc','apachesolr',0),
('ArchiverInterface','interface','includes/archiver.inc','',0),
('ArchiverTar','class','modules/system/system.archiver.inc','system',0),
('ArchiverZip','class','modules/system/system.archiver.inc','system',0),
('Archive_Tar','class','modules/system/system.tar.inc','system',0),
('BatchMemoryQueue','class','includes/batch.queue.inc','',0),
('BatchQueue','class','includes/batch.queue.inc','',0),
('BlockAdminThemeTestCase','class','modules/block/block.test','block',0),
('BlockCacheTestCase','class','modules/block/block.test','block',0),
('BlockHashTestCase','class','modules/block/block.test','block',0),
('BlockHiddenRegionTestCase','class','modules/block/block.test','block',0),
('BlockHTMLIdTestCase','class','modules/block/block.test','block',0),
('BlockInvalidRegionTestCase','class','modules/block/block.test','block',0),
('BlockTemplateSuggestionsUnitTest','class','modules/block/block.test','block',0),
('BlockTestCase','class','modules/block/block.test','block',0),
('BlockViewModuleDeltaAlterWebTest','class','modules/block/block.test','block',0),
('BlogTestCase','class','modules/blog/blog.test','blog',0),
('ConfirmFormTest','class','modules/system/system.test','system',0),
('CronQueueTestCase','class','modules/system/system.test','system',0),
('CronRunTestCase','class','modules/system/system.test','system',0),
('DashboardBlocksTestCase','class','modules/dashboard/dashboard.test','dashboard',0),
('Database','class','includes/database/database.inc','',0),
('DatabaseCondition','class','includes/database/query.inc','',0),
('DatabaseConnection','class','includes/database/database.inc','',0),
('DatabaseConnectionNotDefinedException','class','includes/database/database.inc','',0),
('DatabaseConnection_mysql','class','includes/database/mysql/database.inc','',0),
('DatabaseConnection_pgsql','class','includes/database/pgsql/database.inc','',0),
('DatabaseConnection_sqlite','class','includes/database/sqlite/database.inc','',0),
('DatabaseDriverNotSpecifiedException','class','includes/database/database.inc','',0),
('DatabaseLog','class','includes/database/log.inc','',0),
('DatabaseSchema','class','includes/database/schema.inc','',0),
('DatabaseSchemaObjectDoesNotExistException','class','includes/database/schema.inc','',0),
('DatabaseSchemaObjectExistsException','class','includes/database/schema.inc','',0),
('DatabaseSchema_mysql','class','includes/database/mysql/schema.inc','',0),
('DatabaseSchema_pgsql','class','includes/database/pgsql/schema.inc','',0),
('DatabaseSchema_sqlite','class','includes/database/sqlite/schema.inc','',0),
('DatabaseStatementBase','class','includes/database/database.inc','',0),
('DatabaseStatementEmpty','class','includes/database/database.inc','',0),
('DatabaseStatementInterface','interface','includes/database/database.inc','',0),
('DatabaseStatementPrefetch','class','includes/database/prefetch.inc','',0),
('DatabaseStatement_sqlite','class','includes/database/sqlite/database.inc','',0),
('DatabaseTaskException','class','includes/install.inc','',0),
('DatabaseTasks','class','includes/install.inc','',0),
('DatabaseTasks_mysql','class','includes/database/mysql/install.inc','',0),
('DatabaseTasks_pgsql','class','includes/database/pgsql/install.inc','',0),
('DatabaseTasks_sqlite','class','includes/database/sqlite/install.inc','',0),
('DatabaseTransaction','class','includes/database/database.inc','',0),
('DatabaseTransactionCommitFailedException','class','includes/database/database.inc','',0),
('DatabaseTransactionExplicitCommitNotAllowedException','class','includes/database/database.inc','',0),
('DatabaseTransactionNameNonUniqueException','class','includes/database/database.inc','',0),
('DatabaseTransactionNoActiveException','class','includes/database/database.inc','',0),
('DatabaseTransactionOutOfOrderException','class','includes/database/database.inc','',0),
('DateFormatTestCase','class','modules/system/system.test','system',0),
('DateTimeFunctionalTest','class','modules/system/system.test','system',0),
('DBLogTestCase','class','modules/dblog/dblog.test','dblog',0),
('DefaultMailSystem','class','modules/system/system.mail.inc','system',0),
('DeleteQuery','class','includes/database/query.inc','',0),
('DeleteQuery_sqlite','class','includes/database/sqlite/query.inc','',0),
('DevelMailLog','class','sites/all/modules/devel/devel.mail.inc','devel',0),
('DevelMailTest','class','sites/all/modules/devel/devel.test','devel',0),
('DrupalApacheSolrService','class','sites/all/modules/apachesolr/Drupal_Apache_Solr_Service.php','apachesolr',0),
('DrupalApacheSolrServiceInterface','interface','sites/all/modules/apachesolr/apachesolr.interface.inc','apachesolr',0),
('DrupalCacheArray','class','includes/bootstrap.inc','',0),
('DrupalCacheInterface','interface','includes/cache.inc','',0),
('DrupalDatabaseCache','class','includes/cache.inc','',0),
('DrupalDefaultEntityController','class','includes/entity.inc','',0),
('DrupalEntityControllerInterface','interface','includes/entity.inc','',0),
('DrupalFakeCache','class','includes/cache-install.inc','',0),
('DrupalLocalStreamWrapper','class','includes/stream_wrappers.inc','',0),
('DrupalPrivateStreamWrapper','class','includes/stream_wrappers.inc','',0),
('DrupalPublicStreamWrapper','class','includes/stream_wrappers.inc','',0),
('DrupalQueue','class','modules/system/system.queue.inc','system',0),
('DrupalQueueInterface','interface','modules/system/system.queue.inc','system',0),
('DrupalReliableQueueInterface','interface','modules/system/system.queue.inc','system',0),
('DrupalRequestSanitizer','class','includes/request-sanitizer.inc','',0),
('DrupalSetMessageTest','class','modules/system/system.test','system',0),
('DrupalSolrDocumentTest','class','sites/all/modules/apachesolr/tests/solr_document.test','apachesolr',0),
('DrupalSolrFilterSubQueryTests','class','sites/all/modules/apachesolr/tests/solr_base_subquery.test','apachesolr',0),
('DrupalSolrMatchTestCase','class','sites/all/modules/apachesolr/tests/solr_index_and_search.test','apachesolr',0),
('DrupalSolrNodeTestCase','class','sites/all/modules/apachesolr/tests/apachesolr_base.test','apachesolr',0),
('DrupalSolrOfflineEnvironmentWebTestCase','class','sites/all/modules/apachesolr/tests/apachesolr_base.test','apachesolr',0),
('DrupalSolrOfflineSearchPagesWebTestCase','class','sites/all/modules/apachesolr/tests/apachesolr_base.test','apachesolr',0),
('DrupalSolrOfflineUnitTestCase','class','sites/all/modules/apachesolr/tests/apachesolr_base.test','apachesolr',0),
('DrupalSolrOfflineWebTestCase','class','sites/all/modules/apachesolr/tests/apachesolr_base.test','apachesolr',0),
('DrupalSolrOnlineWebTestCase','class','sites/all/modules/apachesolr/tests/solr_index_and_search.test','apachesolr',0),
('DrupalSolrQueryInterface','interface','sites/all/modules/apachesolr/apachesolr.interface.inc','apachesolr',0),
('DrupalStreamWrapperInterface','interface','includes/stream_wrappers.inc','',0),
('DrupalTemporaryStreamWrapper','class','includes/stream_wrappers.inc','',0),
('DrupalUpdateException','class','includes/update.inc','',0),
('DrupalUpdaterInterface','interface','includes/updater.inc','',0),
('DummySolr','class','sites/all/modules/apachesolr/tests/Dummy_Solr.php','apachesolr',0),
('EnableDisableTestCase','class','modules/system/system.test','system',0),
('EntityFieldQuery','class','includes/entity.inc','',0),
('EntityFieldQueryException','class','includes/entity.inc','',0),
('EntityMalformedException','class','includes/entity.inc','',0),
('EntityPropertiesTestCase','class','modules/field/tests/field.test','field',0),
('FieldAttachOtherTestCase','class','modules/field/tests/field.test','field',0),
('FieldAttachStorageTestCase','class','modules/field/tests/field.test','field',0),
('FieldAttachTestCase','class','modules/field/tests/field.test','field',0),
('FieldBulkDeleteTestCase','class','modules/field/tests/field.test','field',0),
('FieldCrudTestCase','class','modules/field/tests/field.test','field',0),
('FieldDisplayAPITestCase','class','modules/field/tests/field.test','field',0),
('FieldException','class','modules/field/field.module','field',0),
('FieldFormTestCase','class','modules/field/tests/field.test','field',0),
('FieldInfo','class','modules/field/field.info.class.inc','field',0),
('FieldInfoTestCase','class','modules/field/tests/field.test','field',0),
('FieldInstanceCrudTestCase','class','modules/field/tests/field.test','field',0),
('FieldsOverlapException','class','includes/database/database.inc','',0),
('FieldSqlStorageTestCase','class','modules/field/modules/field_sql_storage/field_sql_storage.test','field_sql_storage',0),
('FieldTestCase','class','modules/field/tests/field.test','field',0),
('FieldTranslationsTestCase','class','modules/field/tests/field.test','field',0),
('FieldUIAlterTestCase','class','modules/field_ui/field_ui.test','field_ui',0),
('FieldUIManageDisplayTestCase','class','modules/field_ui/field_ui.test','field_ui',0),
('FieldUIManageFieldsTestCase','class','modules/field_ui/field_ui.test','field_ui',0),
('FieldUITestCase','class','modules/field_ui/field_ui.test','field_ui',0),
('FieldUpdateForbiddenException','class','modules/field/field.module','field',0),
('FieldValidationException','class','modules/field/field.attach.inc','field',0),
('FileFieldAnonymousSubmission','class','modules/file/tests/file.test','file',0),
('FileFieldDisplayTestCase','class','modules/file/tests/file.test','file',0),
('FileFieldPathTestCase','class','modules/file/tests/file.test','file',0),
('FileFieldRevisionTestCase','class','modules/file/tests/file.test','file',0),
('FileFieldTestCase','class','modules/file/tests/file.test','file',0),
('FileFieldValidateTestCase','class','modules/file/tests/file.test','file',0),
('FileFieldWidgetTestCase','class','modules/file/tests/file.test','file',0),
('FileManagedFileElementTestCase','class','modules/file/tests/file.test','file',0),
('FilePrivateTestCase','class','modules/file/tests/file.test','file',0),
('FileTaxonomyTermTestCase','class','modules/file/tests/file.test','file',0),
('FileTokenReplaceTestCase','class','modules/file/tests/file.test','file',0),
('FileTransfer','class','includes/filetransfer/filetransfer.inc','',0),
('FileTransferChmodInterface','interface','includes/filetransfer/filetransfer.inc','',0),
('FileTransferException','class','includes/filetransfer/filetransfer.inc','',0),
('FileTransferFTP','class','includes/filetransfer/ftp.inc','',0),
('FileTransferFTPExtension','class','includes/filetransfer/ftp.inc','',0),
('FileTransferLocal','class','includes/filetransfer/local.inc','',0),
('FileTransferSSH','class','includes/filetransfer/ssh.inc','',0),
('FilterAdminTestCase','class','modules/filter/filter.test','filter',0),
('FilterCRUDTestCase','class','modules/filter/filter.test','filter',0),
('FilterDefaultFormatTestCase','class','modules/filter/filter.test','filter',0),
('FilterDOMSerializeTestCase','class','modules/filter/filter.test','filter',0),
('FilterFormatAccessTestCase','class','modules/filter/filter.test','filter',0),
('FilterHooksTestCase','class','modules/filter/filter.test','filter',0),
('FilterNoFormatTestCase','class','modules/filter/filter.test','filter',0),
('FilterSecurityTestCase','class','modules/filter/filter.test','filter',0),
('FilterSettingsTestCase','class','modules/filter/filter.test','filter',0),
('FilterUnitTestCase','class','modules/filter/filter.test','filter',0),
('FloodFunctionalTest','class','modules/system/system.test','system',0),
('FrontPageTestCase','class','modules/system/system.test','system',0),
('HookRequirementsTestCase','class','modules/system/system.test','system',0),
('ImageAdminStylesUnitTest','class','modules/image/image.test','image',0),
('ImageAdminUiTestCase','class','modules/image/image.test','image',0),
('ImageDimensionsScaleTestCase','class','modules/image/image.test','image',0),
('ImageDimensionsTestCase','class','modules/image/image.test','image',0),
('ImageEffectsUnitTest','class','modules/image/image.test','image',0),
('ImageFieldDefaultImagesTestCase','class','modules/image/image.test','image',0),
('ImageFieldDisplayTestCase','class','modules/image/image.test','image',0),
('ImageFieldTestCase','class','modules/image/image.test','image',0),
('ImageFieldValidateTestCase','class','modules/image/image.test','image',0),
('ImageStyleFlushTest','class','modules/image/image.test','image',0),
('ImageStylesPathAndUrlTestCase','class','modules/image/image.test','image',0),
('ImageThemeFunctionWebTestCase','class','modules/image/image.test','image',0),
('InfoFileParserTestCase','class','modules/system/system.test','system',0),
('InsertQuery','class','includes/database/query.inc','',0),
('InsertQuery_mysql','class','includes/database/mysql/query.inc','',0),
('InsertQuery_pgsql','class','includes/database/pgsql/query.inc','',0),
('InsertQuery_sqlite','class','includes/database/sqlite/query.inc','',0),
('InvalidMergeQueryException','class','includes/database/database.inc','',0),
('IPAddressBlockingTestCase','class','modules/system/system.test','system',0),
('LocaleBrowserDetectionTest','class','modules/locale/locale.test','locale',0),
('LocaleCommentLanguageFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleConfigurationTest','class','modules/locale/locale.test','locale',0),
('LocaleContentFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleCSSAlterTest','class','modules/locale/locale.test','locale',0),
('LocaleDateFormatsFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleExportFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleImportFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleInstallTest','class','modules/locale/locale.test','locale',0),
('LocaleJavascriptTranslationTest','class','modules/locale/locale.test','locale',0),
('LocaleLanguageNegotiationInfoFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleLanguageSwitchingFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleLibraryInfoAlterTest','class','modules/locale/locale.test','locale',0),
('LocaleMultilingualFieldsFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocalePathFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocalePluralFormatTest','class','modules/locale/locale.test','locale',0),
('LocaleStringIsSafeTest','class','modules/locale/locale.test','locale',0),
('LocaleTranslationFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleUILanguageNegotiationTest','class','modules/locale/locale.test','locale',0),
('LocaleUninstallFrenchFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleUninstallFunctionalTest','class','modules/locale/locale.test','locale',0),
('LocaleUrlRewritingTest','class','modules/locale/locale.test','locale',0),
('LocaleUserCreationTest','class','modules/locale/locale.test','locale',0),
('LocaleUserLanguageFunctionalTest','class','modules/locale/locale.test','locale',0),
('MailSystemInterface','interface','includes/mail.inc','',0),
('MemoryQueue','class','modules/system/system.queue.inc','system',0),
('MenuNodeTestCase','class','modules/menu/menu.test','menu',0),
('MenuTestCase','class','modules/menu/menu.test','menu',0),
('MergeQuery','class','includes/database/query.inc','',0),
('ModuleDependencyTestCase','class','modules/system/system.test','system',0),
('ModuleRequiredTestCase','class','modules/system/system.test','system',0),
('ModuleTestCase','class','modules/system/system.test','system',0),
('ModuleUpdater','class','modules/system/system.updater.inc','system',0),
('ModuleVersionTestCase','class','modules/system/system.test','system',0),
('MultiStepNodeFormBasicOptionsTest','class','modules/node/node.test','node',0),
('NewDefaultThemeBlocks','class','modules/block/block.test','block',0),
('NodeAccessBaseTableTestCase','class','modules/node/node.test','node',0),
('NodeAccessFieldTestCase','class','modules/node/node.test','node',0),
('NodeAccessPagerTestCase','class','modules/node/node.test','node',0),
('NodeAccessRebuildTestCase','class','modules/node/node.test','node',0),
('NodeAccessRecordsTestCase','class','modules/node/node.test','node',0),
('NodeAccessTestCase','class','modules/node/node.test','node',0),
('NodeAdminTestCase','class','modules/node/node.test','node',0),
('NodeBlockFunctionalTest','class','modules/node/node.test','node',0),
('NodeBlockTestCase','class','modules/node/node.test','node',0),
('NodeBuildContent','class','modules/node/node.test','node',0),
('NodeController','class','modules/node/node.module','node',0),
('NodeCreationTestCase','class','modules/node/node.test','node',0),
('NodeEntityFieldQueryAlter','class','modules/node/node.test','node',0),
('NodeEntityViewModeAlterTest','class','modules/node/node.test','node',0),
('NodeFeedTestCase','class','modules/node/node.test','node',0),
('NodeLoadHooksTestCase','class','modules/node/node.test','node',0),
('NodeLoadMultipleTestCase','class','modules/node/node.test','node',0),
('NodeMultiByteUtf8Test','class','modules/node/node.test','node',0),
('NodePageCacheTest','class','modules/node/node.test','node',0),
('NodePostSettingsTestCase','class','modules/node/node.test','node',0),
('NodeQueryAlter','class','modules/node/node.test','node',0),
('NodeRevisionPermissionsTestCase','class','modules/node/node.test','node',0),
('NodeRevisionsTestCase','class','modules/node/node.test','node',0),
('NodeRSSContentTestCase','class','modules/node/node.test','node',0),
('NodeSaveTestCase','class','modules/node/node.test','node',0),
('NodeTitleTestCase','class','modules/node/node.test','node',0),
('NodeTitleXSSTestCase','class','modules/node/node.test','node',0),
('NodeTokenReplaceTestCase','class','modules/node/node.test','node',0),
('NodeTypePersistenceTestCase','class','modules/node/node.test','node',0),
('NodeTypeTestCase','class','modules/node/node.test','node',0),
('NodeWebTestCase','class','modules/node/node.test','node',0),
('NoFieldsException','class','includes/database/database.inc','',0),
('NonDefaultBlockAdmin','class','modules/block/block.test','block',0),
('PageEditTestCase','class','modules/node/node.test','node',0),
('PageNotFoundTestCase','class','modules/system/system.test','system',0),
('PagePreviewTestCase','class','modules/node/node.test','node',0),
('PagerDefault','class','includes/pager.inc','',0),
('PageTitleFiltering','class','modules/system/system.test','system',0),
('PageViewTestCase','class','modules/node/node.test','node',0),
('Query','class','includes/database/query.inc','',0),
('QueryAlterableInterface','interface','includes/database/query.inc','',0),
('QueryConditionInterface','interface','includes/database/query.inc','',0),
('QueryExtendableInterface','interface','includes/database/select.inc','',0),
('QueryPlaceholderInterface','interface','includes/database/query.inc','',0),
('QueueTestCase','class','modules/system/system.test','system',0),
('RetrieveFileTestCase','class','modules/system/system.test','system',0),
('SchemaCache','class','includes/bootstrap.inc','',0),
('SelectQuery','class','includes/database/select.inc','',0),
('SelectQueryExtender','class','includes/database/select.inc','',0),
('SelectQueryInterface','interface','includes/database/select.inc','',0),
('SelectQuery_pgsql','class','includes/database/pgsql/select.inc','',0),
('SelectQuery_sqlite','class','includes/database/sqlite/select.inc','',0),
('ShutdownFunctionsTest','class','modules/system/system.test','system',0),
('SiteMaintenanceTestCase','class','modules/system/system.test','system',0),
('SkipDotsRecursiveDirectoryIterator','class','includes/filetransfer/filetransfer.inc','',0),
('SolrBaseQuery','class','sites/all/modules/apachesolr/Solr_Base_Query.php','apachesolr',0),
('SolrBaseQueryTests','class','sites/all/modules/apachesolr/tests/solr_base_query.test','apachesolr',0),
('SolrFilterSubQuery','class','sites/all/modules/apachesolr/Solr_Base_Query.php','apachesolr',0),
('StreamWrapperInterface','interface','includes/stream_wrappers.inc','',0),
('SummaryLengthTestCase','class','modules/node/node.test','node',0),
('SyslogTestCase','class','modules/syslog/syslog.test','syslog',0),
('SystemAdminTestCase','class','modules/system/system.test','system',0),
('SystemAuthorizeCase','class','modules/system/system.test','system',0),
('SystemBlockTestCase','class','modules/system/system.test','system',0),
('SystemIndexPhpTest','class','modules/system/system.test','system',0),
('SystemInfoAlterTestCase','class','modules/system/system.test','system',0),
('SystemMainContentFallback','class','modules/system/system.test','system',0),
('SystemQueue','class','modules/system/system.queue.inc','system',0),
('SystemThemeFunctionalTest','class','modules/system/system.test','system',0),
('SystemValidTokenTest','class','modules/system/system.test','system',0),
('TableSort','class','includes/tablesort.inc','',0),
('TestingMailSystem','class','modules/system/system.mail.inc','system',0),
('TextFieldTestCase','class','modules/field/modules/text/text.test','text',0),
('TextSummaryTestCase','class','modules/field/modules/text/text.test','text',0),
('TextTranslationTestCase','class','modules/field/modules/text/text.test','text',0),
('ThemeRegistry','class','includes/theme.inc','',0),
('ThemeUpdater','class','modules/system/system.updater.inc','system',0),
('TokenReplaceTestCase','class','modules/system/system.test','system',0),
('TokenScanTest','class','modules/system/system.test','system',0),
('TruncateQuery','class','includes/database/query.inc','',0),
('TruncateQuery_mysql','class','includes/database/mysql/query.inc','',0),
('TruncateQuery_sqlite','class','includes/database/sqlite/query.inc','',0),
('UpdateCoreTestCase','class','modules/update/update.test','update',0),
('UpdateCoreUnitTestCase','class','modules/update/update.test','update',0),
('UpdateQuery','class','includes/database/query.inc','',0),
('UpdateQuery_pgsql','class','includes/database/pgsql/query.inc','',0),
('UpdateQuery_sqlite','class','includes/database/sqlite/query.inc','',0),
('Updater','class','includes/updater.inc','',0),
('UpdaterException','class','includes/updater.inc','',0),
('UpdaterFileTransferException','class','includes/updater.inc','',0),
('UpdateScriptFunctionalTest','class','modules/system/system.test','system',0),
('UpdateTestContribCase','class','modules/update/update.test','update',0),
('UpdateTestHelper','class','modules/update/update.test','update',0),
('UpdateTestUploadCase','class','modules/update/update.test','update',0),
('UserAccountLinksUnitTests','class','modules/user/user.test','user',0),
('UserAdminTestCase','class','modules/user/user.test','user',0),
('UserAuthmapAssignmentTestCase','class','modules/user/user.test','user',0),
('UserAutocompleteTestCase','class','modules/user/user.test','user',0),
('UserBlocksUnitTests','class','modules/user/user.test','user',0),
('UserCancelTestCase','class','modules/user/user.test','user',0),
('UserController','class','modules/user/user.module','user',0),
('UserCreateTestCase','class','modules/user/user.test','user',0),
('UserEditedOwnAccountTestCase','class','modules/user/user.test','user',0),
('UserEditRebuildTestCase','class','modules/user/user.test','user',0),
('UserEditTestCase','class','modules/user/user.test','user',0),
('UserLoginTestCase','class','modules/user/user.test','user',0),
('UserPasswordResetTestCase','class','modules/user/user.test','user',0),
('UserPermissionsTestCase','class','modules/user/user.test','user',0),
('UserPictureTestCase','class','modules/user/user.test','user',0),
('UserRegistrationTestCase','class','modules/user/user.test','user',0),
('UserRoleAdminTestCase','class','modules/user/user.test','user',0),
('UserRolesAssignmentTestCase','class','modules/user/user.test','user',0),
('UserSaveTestCase','class','modules/user/user.test','user',0),
('UserSignatureTestCase','class','modules/user/user.test','user',0),
('UserTimeZoneFunctionalTest','class','modules/user/user.test','user',0),
('UserTokenReplaceTestCase','class','modules/user/user.test','user',0),
('UserUserSearchTestCase','class','modules/user/user.test','user',0),
('UserValidateCurrentPassCustomForm','class','modules/user/user.test','user',0),
('UserValidationTestCase','class','modules/user/user.test','user',0);

UNLOCK TABLES;

/*Table structure for table `registry_file` */

DROP TABLE IF EXISTS `registry_file`;

CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';

/*Data for the table `registry_file` */

LOCK TABLES `registry_file` WRITE;

insert  into `registry_file`(`filename`,`hash`) values 
('includes/actions.inc','f36b066681463c7dfe189e0430cb1a89bf66f7e228cbb53cdfcd93987193f759'),
('includes/ajax.inc','3d1c0d2efcdab327224122df1156a665f9bbf60873907dde2f189b018d4e9be3'),
('includes/archiver.inc','bdbb21b712a62f6b913590b609fd17cd9f3c3b77c0d21f68e71a78427ed2e3e9'),
('includes/authorize.inc','6d64d8c21aa01eb12fc29918732e4df6b871ed06e5d41373cb95c197ed661d13'),
('includes/batch.inc','1fe00f9a25481cd43e19fbd6bd37b7ff9dca79f8405ec3e55ffb011be12ec2c3'),
('includes/batch.queue.inc','554b2e92e1dad0f7fd5a19cb8dff7e109f10fbe2441a5692d076338ec908de0f'),
('includes/bootstrap.inc','3d0b82fa4c7c2d9c7f7a9ec4f993837f4c601d287c0ec4e9a77a89468f013576'),
('includes/cache-install.inc','e7ed123c5805703c84ad2cce9c1ca46b3ce8caeeea0d8ef39a3024a4ab95fa0e'),
('includes/cache.inc','033c9bf2555dba29382b077f78cc00c82fd7f42a959ba31b710adddf6fdf24fe'),
('includes/common.inc','bdb273fc8494d8a8f2f53f1ca4cd0d230fba36437194cc9ee9c805f6814fbd8f'),
('includes/database/database.inc','2ef46543fb9cf61ed9fa9aed4e44dd31630c22604ea6b8e48b57ebd7ad11a111'),
('includes/database/log.inc','9feb5a17ae2fabcf26a96d2a634ba73da501f7bcfc3599a693d916a6971d00d1'),
('includes/database/mysql/database.inc','32a577354dba6030043500873f8a2a7359c80c179a213284b026c1a9b0452b70'),
('includes/database/mysql/install.inc','6ae316941f771732fbbabed7e1d6b4cbb41b1f429dd097d04b3345aa15e461a0'),
('includes/database/mysql/query.inc','0212a871646c223bf77aa26b945c77a8974855373967b5fb9fdc09f8a1de88a6'),
('includes/database/mysql/schema.inc','2ef729f8d6466d5cd87ba233152d88590bce629d8366040b2509b4e24258d780'),
('includes/database/pgsql/database.inc','651bec324e2204aa35a28fdbd876aa8e4f7a9e909e75cc8db811e9c156b0df88'),
('includes/database/pgsql/install.inc','39587f26a9e054afaab2064d996af910f1b201ef1c6b82938ef130e4ff8c6aab'),
('includes/database/pgsql/query.inc','0df57377686c921e722a10b49d5e433b131176c8059a4ace4680964206fc14b4'),
('includes/database/pgsql/schema.inc','1588daadfa53506aa1f5d94572162a45a46dc3ceabdd0e2f224532ded6508403'),
('includes/database/pgsql/select.inc','1e509bc97c58223750e8ea735145b316827e36f43c07b946003e41f5bca23659'),
('includes/database/prefetch.inc','b5b207a66a69ecb52ee4f4459af16a7b5eabedc87254245f37cc33bebb61c0fb'),
('includes/database/query.inc','982d44a294eea1c9619687c14df2987257e3776fcabeba05f01432e934cf61c6'),
('includes/database/schema.inc','6ea8e4063eb72d8f6b1a9f8b8908489d9f89b4a158ef37002d21209fb500358c'),
('includes/database/select.inc','02a2d4345287df62b163ca2524e99b7370c9ec167bc937245328683d4e3e3d56'),
('includes/database/sqlite/database.inc','62f6669c4610557c4b34ada9f0a0f61d6cb7b377e0a9032d2efca7b5f39b0965'),
('includes/database/sqlite/install.inc','6620f354aa175a116ba3a0562c980d86cc3b8b481042fc3cc5ed6a4d1a7a6d74'),
('includes/database/sqlite/query.inc','0eb02ad036ef61c490fb3f189a4cdc8fc1ae0d442737806346fd63aea8f30db3'),
('includes/database/sqlite/schema.inc','3a7d22ec1f0ee09bfa267309b90e30edbe39e453b3025b30cbe3ae7412a4df2d'),
('includes/database/sqlite/select.inc','8d1c426dbd337733c206cce9f59a172546c6ed856d8ef3f1c7bef05a16f7bf68'),
('includes/date.inc','1de2c25e3b67a9919fc6c8061594442b6fb2cdd3a48ddf1591ee3aa98484b737'),
('includes/entity.inc','f06b508f93e72ba70f979d8391be57662c018a03a32fac0a6d3baa752740133d'),
('includes/errors.inc','d731bbe3a60508e164cfa90b8edc06400c7f15844f9f9bc3935dd87e44c460db'),
('includes/file.inc','a25c3547c44325a023841137f534034f0ebdde0fb4ad6e5e605ecf74a6492bab'),
('includes/file.mimetypes.inc','33266e837f4ce076378e7e8cef6c5af46446226ca4259f83e13f605856a7f147'),
('includes/file.phar.inc','d1734f8aa6ba5192b3a21f7ad4902f6d98bdf7993ead57e466f2127b5b831f43'),
('includes/filetransfer/filetransfer.inc','fdea8ae48345ec91885ac48a9bc53daf87616271472bb7c29b7e3ce219b22034'),
('includes/filetransfer/ftp.inc','51eb119b8e1221d598ffa6cc46c8a322aa77b49a3d8879f7fb38b7221cf7e06d'),
('includes/filetransfer/local.inc','7cbfdb46abbdf539640db27e66fb30e5265128f31002bd0dfc3af16ae01a9492'),
('includes/filetransfer/ssh.inc','92f1232158cb32ab04cbc93ae38ad3af04796e18f66910a9bc5ca8e437f06891'),
('includes/form.inc','54f3c2072206f75b6270606fff8c7bcfb99bfdcc46ab17a1b949772897f40e2a'),
('includes/graph.inc','8e0e313a8bb33488f371df11fc1b58d7cf80099b886cd1003871e2c896d1b536'),
('includes/image.inc','bcdc7e1599c02227502b9d0fe36eeb2b529b130a392bc709eb737647bd361826'),
('includes/install.core.inc','189653e4bb7d4828bd6e1b61015fabcc7182e23d9dd8858170f98114d99400c8'),
('includes/install.inc','4d0b8c1532a8829051e17f275fa27e9c379ab826aee2e27229a9679ea6775da7'),
('includes/iso.inc','0ce4c225edcfa9f037703bc7dd09d4e268a69bcc90e55da0a3f04c502bd2f349'),
('includes/json-encode.inc','02a822a652d00151f79db9aa9e171c310b69b93a12f549bc2ce00533a8efa14e'),
('includes/language.inc','4e08f30843a7ccaeea5c041083e9f77d33d57ff002f1ab4f66168e2c683ce128'),
('includes/locale.inc','ca50acc0780cbffeca17f99a0997f91b8b9402f0eec1898c3122e1d73664d01d'),
('includes/lock.inc','a181c8bd4f88d292a0a73b9f1fbd727e3314f66ec3631f288e6b9a54ba2b70fa'),
('includes/mail.inc','41d0e657119a05f8d7e85ebf32e74b12a1c3107d717a348158414b113e208b9c'),
('includes/menu.inc','a2e43ead45e97a047ceb130260452e45f15999ece7b0fe65fdad6e235a23311a'),
('includes/module.inc','943626f94bc69e95e36fde030475d57893f3296f0f8df461e2ee9f122dd37473'),
('includes/pager.inc','6f9494b85c07a2cc3be4e54aff2d2757485238c476a7da084d25bde1d88be6d8'),
('includes/password.inc','fd9a1c94fe5a0fa7c7049a2435c7280b1d666b2074595010e3c492dd15712775'),
('includes/path.inc','2dca08d14a46e5ac6a665b7a5dde78045d8de2b35aaa78c6fb811e1125ce4953'),
('includes/registry.inc','f47b20859f0fc80bf4bb2849a1282d6c54006957b69da0e5f4691de585ca4cdf'),
('includes/request-sanitizer.inc','8d43f991b57cbedb2dc99d153f053a24e3ab43849b4816c0353529b918a66441'),
('includes/session.inc','5851ff6941aba2744dd0c247f077fc02fbbe24e9786e04ea0a3c372d68ca6d16'),
('includes/stream_wrappers.inc','b8a5a53f3d3ef26ea868037547f76af8049ce0c55b464810c627310a84f24924'),
('includes/tablesort.inc','2d88768a544829595dd6cda2a5eb008bedb730f36bba6dfe005d9ddd999d5c0f'),
('includes/theme.inc','cb2b6a95aa65f3d8cefc89adcb187fddbab374b8701303290ef3ed0157355453'),
('includes/theme.maintenance.inc','39f068b3eee4d10a90d6aa3c86db587b6d25844c2919d418d34d133cfe330f5a'),
('includes/token.inc','5e7898cd78689e2c291ed3cd8f41c032075656896f1db57e49217aac19ae0428'),
('includes/unicode.entities.inc','2b858138596d961fbaa4c6e3986e409921df7f76b6ee1b109c4af5970f1e0f54'),
('includes/unicode.inc','e18772dafe0f80eb139fcfc582fef1704ba9f730647057d4f4841d6a6e4066ca'),
('includes/update.inc','25c30f1e61ef9c91a7bdeb37791c2215d9dc2ae07dba124722d783ca31bb01e7'),
('includes/updater.inc','d2da0e74ed86e93c209f16069f3d32e1a134ceb6c06a0044f78e841a1b54e380'),
('includes/utility.inc','3458fd2b55ab004dd0cc529b8e58af12916e8bd36653b072bdd820b26b907ed5'),
('includes/xmlrpc.inc','ea24176ec445c440ba0c825fc7b04a31b440288df8ef02081560dc418e34e659'),
('includes/xmlrpcs.inc','925c4d5bf429ad9650f059a8862a100bd394dce887933f5b3e7e32309a51fd8e'),
('modules/block/block.test','40d9de00589211770a85c47d38c8ad61c598ec65d9332128a882eb8750e65a16'),
('modules/blog/blog.test','f7534b972951c05d34bd832d3e06176b372fff6f4999c428f789fdd7703ed2e2'),
('modules/dashboard/dashboard.test','125df00fc6deb985dc554aa7807a48e60a68dbbddbad9ec2c4718da724f0e683'),
('modules/dblog/dblog.test','79ba7991c3f40f9241e9a03ffa43faf945c82658ca9b52ec62bd13bd80f41269'),
('modules/field/field.attach.inc','2df4687b5ec078c4893dc1fea514f67524fd5293de717b9e05caf977e5ae2327'),
('modules/field/field.info.class.inc','cf18178e119d43897d3abd882ba3acc0cf59d1ad747663437c57b1ec4d0a4322'),
('modules/field/field.module','48b5b83f214a8d19e446f46c5d7a1cd35faa656ccb7b540f9f02462a440cacdd'),
('modules/field/modules/field_sql_storage/field_sql_storage.test','315eedaf2022afc884c35efd3b7c400eddab6ea30bec91924bc82ab5cd3e79f2'),
('modules/field/modules/text/text.test','5c28b9da26417d2ed8a169850989c0b59f2b188a0161eb58e2b87c67994d602d'),
('modules/field/tests/field.test','5eaad7a933ef8ea05b958056492ce17858cd542111f0fe81dd1a5949ad8f966e'),
('modules/field_ui/field_ui.test','f535e5627c969e9083a63aaf72d4ac645e30709d7b87af15c6c3b870481f283a'),
('modules/file/tests/file.test','09a4233406b2913692c91986ef0509197ffbf4a59d3c9843acf8bdd81ec0832b'),
('modules/filter/filter.test','b8aa5e6b832422c6ad5fe963898ec9526c814614f27ecccb67107ce194997d6a'),
('modules/image/image.test','6e7a0cbcb58f6210127b0ac7c1d118d488abd0925fe8db10a3405af87f1d9fe1'),
('modules/locale/locale.test','413fc972f27bf09c6dd3183fe61237566a0f69762e650fd21db54eac185414a6'),
('modules/menu/menu.test','71efd7117a882fdcdd50971b4a68f7f2895b532e09acf094d747f27a15742c5b'),
('modules/node/node.module','70f969229d03819dba439546ae7aef30283b93e410af1b45f5a25b90d3cb8edd'),
('modules/node/node.test','35bf40fde62f3a1de95bab9f037b84f20c2f93a1c579d7d19e4a87afe75dc330'),
('modules/syslog/syslog.test','ad873b3d499ebad748784ae88df3496f39de1b9bbfd98c3193ef1ea70c6376ae'),
('modules/system/system.archiver.inc','faa849f3e646a910ab82fd6c8bbf0a4e6b8c60725d7ba81ec0556bd716616cd1'),
('modules/system/system.mail.inc','d2f4fca46269981db5edb6316176b7b8161de59d4c24c514b63fe3c536ebb4d6'),
('modules/system/system.queue.inc','a77a5913d84368092805ac551ca63737c1d829455504fcccb95baa2932f28009'),
('modules/system/system.tar.inc','9cf4a264a4388de84ac12270bdc92b2b8c8ca457cd6dd9100d59c4ea2ae0ff17'),
('modules/system/system.test','af23ac0692e67139d965243555ce12ce49f0b38a96e126c760ac186abaeb80e3'),
('modules/system/system.updater.inc','9433fa8d39500b8c59ab05f41c0aac83b2586a43be4aa949821380e36c4d3c48'),
('modules/update/update.test','994b66b737f16eb98ee18c9e9ecd62e86de2792159e70b36982e95b48f2746a3'),
('modules/user/user.module','675ffb3a1cf007302e90807fb62b1df875c30f088cdc683c8c47e19a00d22dfd'),
('modules/user/user.test','e06e82b188ba40a390e300ee7b16299d806039c7482d51815ebdc0257bb5f557'),
('sites/all/modules/apachesolr/apachesolr.interface.inc','5ffce6ca23a4986a8bc25bc8a68ae2ecb52c7556ef8389c4c2da42a84d6b364c'),
('sites/all/modules/apachesolr/Apache_Solr_Document.php','6c16a507dcaaedb443184afbbc735ddfbe3e91574a6d5d34242b5a130ce51bf9'),
('sites/all/modules/apachesolr/Drupal_Apache_Solr_Service.php','f08f228dded2ed660e76576ea0bd13b5c60ff5fe3c4a667f33476fc67450b250'),
('sites/all/modules/apachesolr/plugins/facetapi/adapter.inc','ede3a9c8ef4435eac634da811520fe5c813c4ef9884def90383c1a50113ef19b'),
('sites/all/modules/apachesolr/plugins/facetapi/query_type_date.inc','2cae8436f91f99f600a180e5c7d89662f45035c5589eb6870386dde7a0da52bc'),
('sites/all/modules/apachesolr/plugins/facetapi/query_type_geo.inc','3b131d310bee33fc70b4f5df451fa6fe73adc51208d15e32ae67c3fba31f5ccb'),
('sites/all/modules/apachesolr/plugins/facetapi/query_type_numeric_range.inc','be754ec34dba0a1351fcd8e176e377f8c6bebc00b083ae34d01c27650c6bea1e'),
('sites/all/modules/apachesolr/plugins/facetapi/query_type_term.inc','49332bd83d794c9872b21a339d5da6fd67e5803e32b0432314af6a73d3d53873'),
('sites/all/modules/apachesolr/Solr_Base_Query.php','06138f29844c5c7f00572299420e54433895558aae75a2e8ec7d62fa805d04a4'),
('sites/all/modules/apachesolr/tests/apachesolr_base.test','6c655a569a96db70cb2e8cb6c0f74a1805758f967c36b335bbfdd14f77ad3aa5'),
('sites/all/modules/apachesolr/tests/Dummy_Solr.php','b589b6b3a8094bdf4d138a5d0d39b0eda7bdf641d88441e31fc3e69636512aed'),
('sites/all/modules/apachesolr/tests/solr_base_query.test','6631da8cc4f79953ee69bf291cc78f4887837da52b40f62f1dafcb7e1d5ac575'),
('sites/all/modules/apachesolr/tests/solr_base_subquery.test','96f5fe17fbc8811b9cbc278002953232f706315aeea5ab1324849b936a5dbf50'),
('sites/all/modules/apachesolr/tests/solr_document.test','28b9004322e605b88a81a6bbfc87ca107dbfe775a0e054a85ac9e7232c3c2e30'),
('sites/all/modules/apachesolr/tests/solr_index_and_search.test','cdfc2ef839e5a5c0ce09d47ff635174998a2a4f99d8cb2b681794fe835995b73'),
('sites/all/modules/devel/devel.mail.inc','82d59623a0c8ee5e295f7e601ff931bb91704ab082fac8ade0b28d4d1ccbb4e2'),
('sites/all/modules/devel/devel.test','48c7f27d6496e7587f545a1d36cbd6a531591ad886cbae3af41f5a4699b4c393');

UNLOCK TABLES;

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';

/*Data for the table `role` */

LOCK TABLES `role` WRITE;

insert  into `role`(`rid`,`name`,`weight`) values 
(1,'anonymous user',0),
(2,'authenticated user',1);

UNLOCK TABLES;

/*Table structure for table `role_permission` */

DROP TABLE IF EXISTS `role_permission`;

CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';

/*Data for the table `role_permission` */

LOCK TABLES `role_permission` WRITE;

insert  into `role_permission`(`rid`,`permission`,`module`) values 
(1,'access content','node'),
(2,'access content','node');

UNLOCK TABLES;

/*Table structure for table `semaphore` */

DROP TABLE IF EXISTS `semaphore`;

CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';

/*Data for the table `semaphore` */

LOCK TABLES `semaphore` WRITE;

UNLOCK TABLES;

/*Table structure for table `sequences` */

DROP TABLE IF EXISTS `sequences`;

CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';

/*Data for the table `sequences` */

LOCK TABLES `sequences` WRITE;

insert  into `sequences`(`value`) values 
(1);

UNLOCK TABLES;

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';

/*Data for the table `sessions` */

LOCK TABLES `sessions` WRITE;

insert  into `sessions`(`uid`,`sid`,`ssid`,`hostname`,`timestamp`,`cache`,`session`) values 
(0,'HQOx82iqh-o2KmRqVQNSEf3L74CdV2euqkdBMwRJNiw','','::1',1549344438,0,'language|s:2:\"en\";'),
(1,'ielsY4NyZihuQ8a_zVS6dPOAa6IDkTooolp12XGtazw','','::1',1549344424,0,'language|s:2:\"en\";');

UNLOCK TABLES;

/*Table structure for table `system` */

DROP TABLE IF EXISTS `system`;

CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  PRIMARY KEY (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';

/*Data for the table `system` */

LOCK TABLES `system` WRITE;

insert  into `system`(`filename`,`name`,`type`,`owner`,`status`,`bootstrap`,`schema_version`,`weight`,`info`) values 
('modules/aggregator/aggregator.module','aggregator','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:10:\"Aggregator\";s:11:\"description\";s:57:\"Aggregates syndicated content (RSS, RDF, and Atom feeds).\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"aggregator.test\";}s:9:\"configure\";s:41:\"admin/config/services/aggregator/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:14:\"aggregator.css\";s:33:\"modules/aggregator/aggregator.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/aggregator/tests/aggregator_test.module','aggregator_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:23:\"Aggregator module tests\";s:11:\"description\";s:46:\"Support module for aggregator related testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/block/block.module','block','module','',1,0,7009,-5,'a:13:{s:4:\"name\";s:5:\"Block\";s:11:\"description\";s:140:\"Controls the visual building blocks a page is constructed with. Blocks are boxes of content rendered into an area, or region, of a web page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"block.test\";}s:9:\"configure\";s:21:\"admin/structure/block\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/block/tests/block_test.module','block_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Block test\";s:11:\"description\";s:21:\"Provides test blocks.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/blog/blog.module','blog','module','',1,0,0,0,'a:12:{s:4:\"name\";s:4:\"Blog\";s:11:\"description\";s:25:\"Enables multi-user blogs.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"blog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/book/book.module','book','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:4:\"Book\";s:11:\"description\";s:66:\"Allows users to create and organize related content in an outline.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"book.test\";}s:9:\"configure\";s:27:\"admin/content/book/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"book.css\";s:21:\"modules/book/book.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/color/color.module','color','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:5:\"Color\";s:11:\"description\";s:70:\"Allows administrators to change the color scheme of compatible themes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"color.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/comment/comment.module','comment','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:7:\"Comment\";s:11:\"description\";s:57:\"Allows users to comment on and discuss published content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"text\";}s:5:\"files\";a:2:{i:0;s:14:\"comment.module\";i:1;s:12:\"comment.test\";}s:9:\"configure\";s:21:\"admin/content/comment\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:11:\"comment.css\";s:27:\"modules/comment/comment.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/contact/contact.module','contact','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:7:\"Contact\";s:11:\"description\";s:61:\"Enables the use of both personal and site-wide contact forms.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"contact.test\";}s:9:\"configure\";s:23:\"admin/structure/contact\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/contextual/contextual.module','contextual','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"Contextual links\";s:11:\"description\";s:75:\"Provides contextual links to perform actions related to elements on a page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"contextual.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/dashboard/dashboard.module','dashboard','module','',1,0,0,0,'a:13:{s:4:\"name\";s:9:\"Dashboard\";s:11:\"description\";s:136:\"Provides a dashboard page in the administrative interface for organizing administrative tasks and tracking information within your site.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:5:\"files\";a:1:{i:0;s:14:\"dashboard.test\";}s:12:\"dependencies\";a:1:{i:0;s:5:\"block\";}s:9:\"configure\";s:25:\"admin/dashboard/customize\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/dblog/dblog.module','dblog','module','',1,1,7003,0,'a:12:{s:4:\"name\";s:16:\"Database logging\";s:11:\"description\";s:47:\"Logs and records system events to the database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"dblog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/field/field.module','field','module','',1,0,7004,0,'a:14:{s:4:\"name\";s:5:\"Field\";s:11:\"description\";s:57:\"Field API to add fields to entities like nodes and users.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:4:{i:0;s:12:\"field.module\";i:1;s:16:\"field.attach.inc\";i:2;s:20:\"field.info.class.inc\";i:3;s:16:\"tests/field.test\";}s:12:\"dependencies\";a:1:{i:0;s:17:\"field_sql_storage\";}s:8:\"required\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"theme/field.css\";s:29:\"modules/field/theme/field.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/field/modules/field_sql_storage/field_sql_storage.module','field_sql_storage','module','',1,0,7002,0,'a:13:{s:4:\"name\";s:17:\"Field SQL storage\";s:11:\"description\";s:37:\"Stores field data in an SQL database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:22:\"field_sql_storage.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/field/modules/list/list.module','list','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:4:\"List\";s:11:\"description\";s:69:\"Defines list field types. Use with Options to create selection lists.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:5:\"field\";i:1;s:7:\"options\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/list.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/field/modules/list/tests/list_test.module','list_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:9:\"List test\";s:11:\"description\";s:41:\"Support module for the List module tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/field/modules/number/number.module','number','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:6:\"Number\";s:11:\"description\";s:28:\"Defines numeric field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:11:\"number.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/field/modules/options/options.module','options','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:7:\"Options\";s:11:\"description\";s:82:\"Defines selection, check box and radio button widgets for text and numeric fields.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:12:\"options.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/field/modules/text/text.module','text','module','',1,0,7000,0,'a:14:{s:4:\"name\";s:4:\"Text\";s:11:\"description\";s:32:\"Defines simple text field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:9:\"text.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:11:\"explanation\";s:80:\"Field type(s) in use - see <a href=\"/ww_cms/admin/reports/fields\">Field list</a>\";}'),
('modules/field/tests/field_test.module','field_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:14:\"Field API Test\";s:11:\"description\";s:39:\"Support module for the Field API tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:5:\"files\";a:1:{i:0;s:21:\"field_test.entity.inc\";}s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/field_ui/field_ui.module','field_ui','module','',1,0,0,0,'a:12:{s:4:\"name\";s:8:\"Field UI\";s:11:\"description\";s:33:\"User interface for the Field API.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:13:\"field_ui.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/file/file.module','file','module','',1,0,0,0,'a:12:{s:4:\"name\";s:4:\"File\";s:11:\"description\";s:26:\"Defines a file field type.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/file.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/file/tests/file_module_test.module','file_module_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:9:\"File test\";s:11:\"description\";s:53:\"Provides hooks for testing File module functionality.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/filter/filter.module','filter','module','',1,0,7010,0,'a:14:{s:4:\"name\";s:6:\"Filter\";s:11:\"description\";s:43:\"Filters content in preparation for display.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"filter.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:28:\"admin/config/content/formats\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/forum/forum.module','forum','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:5:\"Forum\";s:11:\"description\";s:27:\"Provides discussion forums.\";s:12:\"dependencies\";a:2:{i:0;s:8:\"taxonomy\";i:1;s:7:\"comment\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"forum.test\";}s:9:\"configure\";s:21:\"admin/structure/forum\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:9:\"forum.css\";s:23:\"modules/forum/forum.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/help/help.module','help','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:4:\"Help\";s:11:\"description\";s:35:\"Manages the display of online help.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"help.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/image/image.module','image','module','',1,0,7005,0,'a:13:{s:4:\"name\";s:5:\"Image\";s:11:\"description\";s:34:\"Provides image manipulation tools.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"file\";}s:5:\"files\";a:1:{i:0;s:10:\"image.test\";}s:9:\"configure\";s:31:\"admin/config/media/image-styles\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/image/tests/image_module_test.module','image_module_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Image test\";s:11:\"description\";s:69:\"Provides hook implementations for testing Image module functionality.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:24:\"image_module_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/locale/locale.module','locale','module','',1,0,7005,0,'a:13:{s:4:\"name\";s:6:\"Locale\";s:11:\"description\";s:119:\"Adds language handling functionality and enables the translation of the user interface to languages other than English.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"locale.test\";}s:9:\"configure\";s:30:\"admin/config/regional/language\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/locale/tests/locale_test.module','locale_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:11:\"Locale Test\";s:11:\"description\";s:42:\"Support module for the locale layer tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/menu/menu.module','menu','module','',1,0,7003,0,'a:13:{s:4:\"name\";s:4:\"Menu\";s:11:\"description\";s:60:\"Allows administrators to customize the site navigation menu.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"menu.test\";}s:9:\"configure\";s:20:\"admin/structure/menu\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/node/node.module','node','module','',1,0,7016,0,'a:15:{s:4:\"name\";s:4:\"Node\";s:11:\"description\";s:66:\"Allows content to be submitted to the site and displayed on pages.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"node.module\";i:1;s:9:\"node.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:21:\"admin/structure/types\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"node.css\";s:21:\"modules/node/node.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/node/tests/node_access_test.module','node_access_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:24:\"Node module access tests\";s:11:\"description\";s:43:\"Support module for node permission testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/node/tests/node_test.module','node_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:17:\"Node module tests\";s:11:\"description\";s:40:\"Support module for node related testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/node/tests/node_test_exception.module','node_test_exception','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:27:\"Node module exception tests\";s:11:\"description\";s:50:\"Support module for node related exception testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/openid/openid.module','openid','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:6:\"OpenID\";s:11:\"description\";s:48:\"Allows users to log into your site using OpenID.\";s:7:\"version\";s:4:\"7.63\";s:7:\"package\";s:4:\"Core\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"openid.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/openid/tests/openid_test.module','openid_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:21:\"OpenID dummy provider\";s:11:\"description\";s:33:\"OpenID provider used for testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"openid\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/overlay/overlay.module','overlay','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:7:\"Overlay\";s:11:\"description\";s:59:\"Displays the Drupal administration interface in an overlay.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/path/path.module','path','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:4:\"Path\";s:11:\"description\";s:28:\"Allows users to rename URLs.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"path.test\";}s:9:\"configure\";s:24:\"admin/config/search/path\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/php/php.module','php','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"PHP filter\";s:11:\"description\";s:50:\"Allows embedded PHP code/snippets to be evaluated.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:8:\"php.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/poll/poll.module','poll','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:4:\"Poll\";s:11:\"description\";s:95:\"Allows your site to capture votes on different topics in the form of multiple choice questions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"poll.test\";}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"poll.css\";s:21:\"modules/poll/poll.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/profile/profile.module','profile','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:7:\"Profile\";s:11:\"description\";s:36:\"Supports configurable user profiles.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"profile.test\";}s:9:\"configure\";s:27:\"admin/config/people/profile\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/rdf/rdf.module','rdf','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:3:\"RDF\";s:11:\"description\";s:148:\"Enriches your content with metadata to let other applications (e.g. search engines, aggregators) better understand its relationships and attributes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:8:\"rdf.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/rdf/tests/rdf_test.module','rdf_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:16:\"RDF module tests\";s:11:\"description\";s:38:\"Support module for RDF module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:4:\"blog\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/search/search.module','search','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:6:\"Search\";s:11:\"description\";s:36:\"Enables site-wide keyword searching.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:19:\"search.extender.inc\";i:1;s:11:\"search.test\";}s:9:\"configure\";s:28:\"admin/config/search/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"search.css\";s:25:\"modules/search/search.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/search/tests/search_embedded_form.module','search_embedded_form','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:20:\"Search embedded form\";s:11:\"description\";s:59:\"Support module for search module testing of embedded forms.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/search/tests/search_extra_type.module','search_extra_type','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:16:\"Test search type\";s:11:\"description\";s:41:\"Support module for search module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/search/tests/search_node_tags.module','search_node_tags','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:21:\"Test search node tags\";s:11:\"description\";s:44:\"Support module for Node search tags testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/shortcut/shortcut.module','shortcut','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:8:\"Shortcut\";s:11:\"description\";s:60:\"Allows users to manage customizable lists of shortcut links.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:13:\"shortcut.test\";}s:9:\"configure\";s:36:\"admin/config/user-interface/shortcut\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/simpletest.module','simpletest','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:7:\"Testing\";s:11:\"description\";s:53:\"Provides a framework for unit and functional testing.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:50:{i:0;s:15:\"simpletest.test\";i:1;s:24:\"drupal_web_test_case.php\";i:2;s:18:\"tests/actions.test\";i:3;s:15:\"tests/ajax.test\";i:4;s:16:\"tests/batch.test\";i:5;s:15:\"tests/boot.test\";i:6;s:20:\"tests/bootstrap.test\";i:7;s:16:\"tests/cache.test\";i:8;s:17:\"tests/common.test\";i:9;s:24:\"tests/database_test.test\";i:10;s:22:\"tests/entity_crud.test\";i:11;s:32:\"tests/entity_crud_hook_test.test\";i:12;s:23:\"tests/entity_query.test\";i:13;s:16:\"tests/error.test\";i:14;s:15:\"tests/file.test\";i:15;s:23:\"tests/filetransfer.test\";i:16;s:15:\"tests/form.test\";i:17;s:16:\"tests/graph.test\";i:18;s:16:\"tests/image.test\";i:19;s:15:\"tests/lock.test\";i:20;s:15:\"tests/mail.test\";i:21;s:15:\"tests/menu.test\";i:22;s:17:\"tests/module.test\";i:23;s:16:\"tests/pager.test\";i:24;s:19:\"tests/password.test\";i:25;s:15:\"tests/path.test\";i:26;s:19:\"tests/registry.test\";i:27;s:17:\"tests/schema.test\";i:28;s:18:\"tests/session.test\";i:29;s:20:\"tests/tablesort.test\";i:30;s:16:\"tests/theme.test\";i:31;s:18:\"tests/unicode.test\";i:32;s:17:\"tests/update.test\";i:33;s:17:\"tests/xmlrpc.test\";i:34;s:26:\"tests/upgrade/upgrade.test\";i:35;s:34:\"tests/upgrade/upgrade.comment.test\";i:36;s:33:\"tests/upgrade/upgrade.filter.test\";i:37;s:32:\"tests/upgrade/upgrade.forum.test\";i:38;s:33:\"tests/upgrade/upgrade.locale.test\";i:39;s:31:\"tests/upgrade/upgrade.menu.test\";i:40;s:31:\"tests/upgrade/upgrade.node.test\";i:41;s:35:\"tests/upgrade/upgrade.taxonomy.test\";i:42;s:34:\"tests/upgrade/upgrade.trigger.test\";i:43;s:39:\"tests/upgrade/upgrade.translatable.test\";i:44;s:33:\"tests/upgrade/upgrade.upload.test\";i:45;s:31:\"tests/upgrade/upgrade.user.test\";i:46;s:36:\"tests/upgrade/update.aggregator.test\";i:47;s:33:\"tests/upgrade/update.trigger.test\";i:48;s:31:\"tests/upgrade/update.field.test\";i:49;s:30:\"tests/upgrade/update.user.test\";}s:9:\"configure\";s:41:\"admin/config/development/testing/settings\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/actions_loop_test.module','actions_loop_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:17:\"Actions loop test\";s:11:\"description\";s:39:\"Support module for action loop testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/ajax_forms_test.module','ajax_forms_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:26:\"AJAX form test mock module\";s:11:\"description\";s:25:\"Test for AJAX form calls.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/ajax_test.module','ajax_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:9:\"AJAX Test\";s:11:\"description\";s:40:\"Support module for AJAX framework tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/batch_test.module','batch_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:14:\"Batch API test\";s:11:\"description\";s:35:\"Support module for Batch API tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/boot_test_1.module','boot_test_1','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:21:\"Early bootstrap tests\";s:11:\"description\";s:39:\"A support module for hook_boot testing.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/boot_test_2.module','boot_test_2','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:21:\"Early bootstrap tests\";s:11:\"description\";s:44:\"A support module for hook_boot hook testing.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/common_test.module','common_test','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:11:\"Common Test\";s:11:\"description\";s:32:\"Support module for Common tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:15:\"common_test.css\";s:40:\"modules/simpletest/tests/common_test.css\";}s:5:\"print\";a:1:{s:21:\"common_test.print.css\";s:46:\"modules/simpletest/tests/common_test.print.css\";}}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/common_test_cron_helper.module','common_test_cron_helper','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:23:\"Common Test Cron Helper\";s:11:\"description\";s:56:\"Helper module for CronRunTestCase::testCronExceptions().\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/database_test.module','database_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:13:\"Database Test\";s:11:\"description\";s:40:\"Support module for Database layer tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/drupal_autoload_test/drupal_autoload_test.module','drupal_autoload_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:25:\"Drupal code registry test\";s:11:\"description\";s:45:\"Support module for testing the code registry.\";s:5:\"files\";a:2:{i:0;s:34:\"drupal_autoload_test_interface.inc\";i:1;s:30:\"drupal_autoload_test_class.inc\";}s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/drupal_system_listing_compatible_test/drupal_system_listing_compatible_test.module','drupal_system_listing_compatible_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:37:\"Drupal system listing compatible test\";s:11:\"description\";s:62:\"Support module for testing the drupal_system_listing function.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/drupal_system_listing_incompatible_test/drupal_system_listing_incompatible_test.module','drupal_system_listing_incompatible_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:39:\"Drupal system listing incompatible test\";s:11:\"description\";s:62:\"Support module for testing the drupal_system_listing function.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/entity_cache_test.module','entity_cache_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:17:\"Entity cache test\";s:11:\"description\";s:40:\"Support module for testing entity cache.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:28:\"entity_cache_test_dependency\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/entity_cache_test_dependency.module','entity_cache_test_dependency','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:28:\"Entity cache test dependency\";s:11:\"description\";s:51:\"Support dependency module for testing entity cache.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/entity_crud_hook_test.module','entity_crud_hook_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:22:\"Entity CRUD Hooks Test\";s:11:\"description\";s:35:\"Support module for CRUD hook tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/entity_query_access_test.module','entity_query_access_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:24:\"Entity query access test\";s:11:\"description\";s:49:\"Support module for checking entity query results.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/error_test.module','error_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Error test\";s:11:\"description\";s:47:\"Support module for error and exception testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/file_test.module','file_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:9:\"File test\";s:11:\"description\";s:39:\"Support module for file handling tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:16:\"file_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/filter_test.module','filter_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:18:\"Filter test module\";s:11:\"description\";s:33:\"Tests filter hooks and functions.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/form_test.module','form_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:12:\"FormAPI Test\";s:11:\"description\";s:34:\"Support module for Form API tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/image_test.module','image_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Image test\";s:11:\"description\";s:39:\"Support module for image toolkit tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/menu_test.module','menu_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:15:\"Hook menu tests\";s:11:\"description\";s:37:\"Support module for menu hook testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/module_test.module','module_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:11:\"Module test\";s:11:\"description\";s:41:\"Support module for module system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/path_test.module','path_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:15:\"Hook path tests\";s:11:\"description\";s:37:\"Support module for path hook testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/psr_0_test/psr_0_test.module','psr_0_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:16:\"PSR-0 Test cases\";s:11:\"description\";s:44:\"Test classes to be discovered by simpletest.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/psr_4_test/psr_4_test.module','psr_4_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:16:\"PSR-4 Test cases\";s:11:\"description\";s:44:\"Test classes to be discovered by simpletest.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/requirements1_test.module','requirements1_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:19:\"Requirements 1 Test\";s:11:\"description\";s:80:\"Tests that a module is not installed when it fails hook_requirements(\'install\').\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/requirements2_test.module','requirements2_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:19:\"Requirements 2 Test\";s:11:\"description\";s:98:\"Tests that a module is not installed when the one it depends on fails hook_requirements(\'install).\";s:12:\"dependencies\";a:2:{i:0;s:18:\"requirements1_test\";i:1;s:7:\"comment\";}s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/session_test.module','session_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:12:\"Session test\";s:11:\"description\";s:40:\"Support module for session data testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/system_dependencies_test.module','system_dependencies_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:22:\"System dependency test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:19:\"_missing_dependency\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/system_incompatible_core_version_dependencies_test.module','system_incompatible_core_version_dependencies_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:50:\"System incompatible core version dependencies test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:37:\"system_incompatible_core_version_test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/system_incompatible_core_version_test.module','system_incompatible_core_version_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:37:\"System incompatible core version test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"5.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/system_incompatible_module_version_dependencies_test.module','system_incompatible_module_version_dependencies_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:52:\"System incompatible module version dependencies test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:46:\"system_incompatible_module_version_test (>2.0)\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/system_incompatible_module_version_test.module','system_incompatible_module_version_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:39:\"System incompatible module version test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/system_project_namespace_test.module','system_project_namespace_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:29:\"System project namespace test\";s:11:\"description\";s:58:\"Support module for testing project namespace dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:13:\"drupal:filter\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/system_test.module','system_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:11:\"System test\";s:11:\"description\";s:34:\"Support module for system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:18:\"system_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/taxonomy_test.module','taxonomy_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:20:\"Taxonomy test module\";s:11:\"description\";s:45:\"\"Tests functions and hooks not used in core\".\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:8:\"taxonomy\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/theme_test.module','theme_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Theme test\";s:11:\"description\";s:40:\"Support module for theme system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/update_script_test.module','update_script_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:18:\"Update script test\";s:11:\"description\";s:41:\"Support module for update script testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/update_test_1.module','update_test_1','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/update_test_2.module','update_test_2','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/update_test_3.module','update_test_3','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/url_alter_test.module','url_alter_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:15:\"Url_alter tests\";s:11:\"description\";s:45:\"A support modules for url_alter hook testing.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/simpletest/tests/xmlrpc_test.module','xmlrpc_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:12:\"XML-RPC Test\";s:11:\"description\";s:75:\"Support module for XML-RPC tests according to the validator1 specification.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/statistics/statistics.module','statistics','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Statistics\";s:11:\"description\";s:37:\"Logs access statistics for your site.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"statistics.test\";}s:9:\"configure\";s:30:\"admin/config/system/statistics\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/syslog/syslog.module','syslog','module','',1,1,0,0,'a:13:{s:4:\"name\";s:6:\"Syslog\";s:11:\"description\";s:41:\"Logs and records system events to syslog.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"syslog.test\";}s:9:\"configure\";s:32:\"admin/config/development/logging\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/system/system.module','system','module','',1,0,7081,0,'a:14:{s:4:\"name\";s:6:\"System\";s:11:\"description\";s:54:\"Handles general site configuration for administrators.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:6:{i:0;s:19:\"system.archiver.inc\";i:1;s:15:\"system.mail.inc\";i:2;s:16:\"system.queue.inc\";i:3;s:14:\"system.tar.inc\";i:4;s:18:\"system.updater.inc\";i:5;s:11:\"system.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/system\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/system/tests/cron_queue_test.module','cron_queue_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:15:\"Cron Queue test\";s:11:\"description\";s:41:\"Support module for the cron queue runner.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/system/tests/system_cron_test.module','system_cron_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:16:\"System Cron Test\";s:11:\"description\";s:45:\"Support module for testing the system_cron().\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/taxonomy/taxonomy.module','taxonomy','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:8:\"Taxonomy\";s:11:\"description\";s:38:\"Enables the categorization of content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"options\";}s:5:\"files\";a:2:{i:0;s:15:\"taxonomy.module\";i:1;s:13:\"taxonomy.test\";}s:9:\"configure\";s:24:\"admin/structure/taxonomy\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/toolbar/toolbar.module','toolbar','module','',1,0,0,0,'a:12:{s:4:\"name\";s:7:\"Toolbar\";s:11:\"description\";s:99:\"Provides a toolbar that shows the top-level administration menu items and links from other modules.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/tracker/tracker.module','tracker','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:7:\"Tracker\";s:11:\"description\";s:45:\"Enables tracking of recent content for users.\";s:12:\"dependencies\";a:1:{i:0;s:7:\"comment\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"tracker.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/translation/tests/translation_test.module','translation_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:24:\"Content Translation Test\";s:11:\"description\";s:49:\"Support module for the content translation tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/translation/translation.module','translation','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:19:\"Content translation\";s:11:\"description\";s:57:\"Allows content to be translated into different languages.\";s:12:\"dependencies\";a:1:{i:0;s:6:\"locale\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:16:\"translation.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/trigger/tests/trigger_test.module','trigger_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:12:\"Trigger Test\";s:11:\"description\";s:33:\"Support module for Trigger tests.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.63\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/trigger/trigger.module','trigger','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:7:\"Trigger\";s:11:\"description\";s:90:\"Enables actions to be fired on certain system events, such as when new content is created.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"trigger.test\";}s:9:\"configure\";s:23:\"admin/structure/trigger\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/update/tests/aaa_update_test.module','aaa_update_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:15:\"AAA Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.63\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/update/tests/bbb_update_test.module','bbb_update_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:15:\"BBB Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.63\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/update/tests/ccc_update_test.module','ccc_update_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:15:\"CCC Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.63\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/update/tests/update_test.module','update_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/update/update.module','update','module','',1,0,7001,0,'a:13:{s:4:\"name\";s:14:\"Update manager\";s:11:\"description\";s:104:\"Checks for available updates, and can securely install or update modules and themes via a web interface.\";s:7:\"version\";s:4:\"7.63\";s:7:\"package\";s:4:\"Core\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"update.test\";}s:9:\"configure\";s:30:\"admin/reports/updates/settings\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('modules/user/tests/user_form_test.module','user_form_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:22:\"User module form tests\";s:11:\"description\";s:37:\"Support module for user form testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('modules/user/user.module','user','module','',1,0,7019,0,'a:15:{s:4:\"name\";s:4:\"User\";s:11:\"description\";s:47:\"Manages the user registration and login system.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"user.module\";i:1;s:9:\"user.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/people\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"user.css\";s:21:\"modules/user/user.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('profiles/minimal/minimal.profile','minimal','module','',1,0,0,1000,'a:15:{s:4:\"name\";s:7:\"Minimal\";s:11:\"description\";s:38:\"Start with only a few modules enabled.\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:5:\"block\";i:1;s:5:\"dblog\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:5:\"mtime\";i:1547662166;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;s:6:\"hidden\";b:1;s:8:\"required\";b:1;s:17:\"distribution_name\";s:6:\"Drupal\";}'),
('sites/all/modules/admin_menu/admin_devel/admin_devel.module','admin_devel','module','',1,0,0,0,'a:13:{s:4:\"name\";s:32:\"Administration Development tools\";s:11:\"description\";s:76:\"Administration and debugging functionality for developers and site builders.\";s:7:\"package\";s:14:\"Administration\";s:4:\"core\";s:3:\"7.x\";s:7:\"scripts\";a:1:{s:14:\"admin_devel.js\";s:55:\"sites/all/modules/admin_menu/admin_devel/admin_devel.js\";}s:7:\"version\";s:11:\"7.x-3.0-rc5\";s:7:\"project\";s:10:\"admin_menu\";s:9:\"datestamp\";s:10:\"1419029284\";s:5:\"mtime\";i:1542781010;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/admin_menu/admin_menu.module','admin_menu','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:19:\"Administration menu\";s:11:\"description\";s:123:\"Provides a dropdown menu to most administrative tasks and other common destinations (to users with the proper permissions).\";s:7:\"package\";s:14:\"Administration\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:38:\"admin/config/administration/admin_menu\";s:12:\"dependencies\";a:1:{i:0;s:14:\"system (>7.10)\";}s:5:\"files\";a:1:{i:0;s:21:\"tests/admin_menu.test\";}s:7:\"version\";s:11:\"7.x-3.0-rc5\";s:7:\"project\";s:10:\"admin_menu\";s:9:\"datestamp\";s:10:\"1419029284\";s:5:\"mtime\";i:1542781010;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/admin_menu/admin_menu_toolbar/admin_menu_toolbar.module','admin_menu_toolbar','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:33:\"Administration menu Toolbar style\";s:11:\"description\";s:17:\"A better Toolbar.\";s:7:\"package\";s:14:\"Administration\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:10:\"admin_menu\";}s:7:\"version\";s:11:\"7.x-3.0-rc5\";s:7:\"project\";s:10:\"admin_menu\";s:9:\"datestamp\";s:10:\"1419029284\";s:5:\"mtime\";i:1542781010;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/apachesolr/apachesolr.module','apachesolr','module','',1,0,7017,0,'a:13:{s:4:\"name\";s:21:\"Apache Solr framework\";s:11:\"description\";s:33:\"Framework for searching with Solr\";s:7:\"package\";s:14:\"Search Toolkit\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:39:\"admin/config/search/apachesolr/settings\";s:5:\"files\";a:15:{i:0;s:24:\"apachesolr.interface.inc\";i:1;s:30:\"Drupal_Apache_Solr_Service.php\";i:2;s:24:\"Apache_Solr_Document.php\";i:3;s:19:\"Solr_Base_Query.php\";i:4;s:28:\"plugins/facetapi/adapter.inc\";i:5;s:36:\"plugins/facetapi/query_type_date.inc\";i:6;s:36:\"plugins/facetapi/query_type_term.inc\";i:7;s:45:\"plugins/facetapi/query_type_numeric_range.inc\";i:8;s:35:\"plugins/facetapi/query_type_geo.inc\";i:9;s:20:\"tests/Dummy_Solr.php\";i:10;s:26:\"tests/apachesolr_base.test\";i:11;s:32:\"tests/solr_index_and_search.test\";i:12;s:26:\"tests/solr_base_query.test\";i:13;s:29:\"tests/solr_base_subquery.test\";i:14;s:24:\"tests/solr_document.test\";}s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:10:\"apachesolr\";s:9:\"datestamp\";s:10:\"1449085462\";s:5:\"mtime\";i:1542781010;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/apachesolr/apachesolr_access/apachesolr_access.module','apachesolr_access','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:18:\"Apache Solr Access\";s:11:\"description\";s:68:\"Integrates node access and other permissions with Apache Solr search\";s:12:\"dependencies\";a:1:{i:0;s:10:\"apachesolr\";}s:7:\"package\";s:14:\"Search Toolkit\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:28:\"tests/apachesolr_access.test\";}s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:10:\"apachesolr\";s:9:\"datestamp\";s:10:\"1449085462\";s:5:\"mtime\";i:1542781010;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/apachesolr/apachesolr_search.module','apachesolr_search','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:18:\"Apache Solr search\";s:11:\"description\";s:16:\"Search with Solr\";s:12:\"dependencies\";a:2:{i:0;s:6:\"search\";i:1;s:10:\"apachesolr\";}s:7:\"package\";s:14:\"Search Toolkit\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:43:\"admin/config/search/apachesolr/search-pages\";s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:10:\"apachesolr\";s:9:\"datestamp\";s:10:\"1449085462\";s:5:\"mtime\";i:1542781010;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/apachesolr/tests/apachesolr_test/apachesolr_test.module','apachesolr_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:35:\"Apache Solr helper module for tests\";s:11:\"description\";s:45:\"Support module for apachesolr module testing.\";s:7:\"package\";s:14:\"Search Toolkit\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:10:\"apachesolr\";}s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:10:\"apachesolr\";s:9:\"datestamp\";s:10:\"1449085462\";s:5:\"mtime\";i:1542781011;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/apachesolr_autocomplete/apachesolr_autocomplete.module','apachesolr_autocomplete','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"Apache Solr autocomplete\";s:11:\"description\";s:48:\"Enables autocomplete on Apache Solr search boxes\";s:12:\"dependencies\";a:2:{i:0;s:10:\"apachesolr\";i:1;s:17:\"apachesolr_search\";}s:7:\"package\";s:14:\"Search Toolkit\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:7:\"7.x-1.6\";s:7:\"project\";s:23:\"apachesolr_autocomplete\";s:9:\"datestamp\";s:10:\"1456437540\";s:5:\"mtime\";i:1542781011;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/apachesolr_custom_results/apachesolr_custom_results.module','apachesolr_custom_results','module','',1,0,0,0,'a:10:{s:4:\"name\";s:33:\"Apache Solr Custom Search Results\";s:11:\"description\";s:70:\"Customise the search results from the super Apache Solr search engine.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:11:\"Apache Solr\";s:12:\"dependencies\";a:1:{i:0;s:10:\"apachesolr\";}s:5:\"mtime\";i:1542781011;s:7:\"version\";N;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/bean/bean.module','bean','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:4:\"Bean\";s:11:\"description\";s:28:\"Create Bean (Block Entities)\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:12:{i:0;s:22:\"includes/bean.core.inc\";i:1;s:22:\"includes/bean.info.inc\";i:2;s:28:\"plugins/BeanPlugin.class.php\";i:3;s:29:\"plugins/BeanDefault.class.php\";i:4;s:37:\"includes/translation.handler.bean.inc\";i:5;s:36:\"includes/bean.inline_entity_form.inc\";i:6;s:40:\"views/views_handler_filter_bean_type.inc\";i:7;s:39:\"views/views_handler_field_bean_type.inc\";i:8;s:44:\"views/views_handler_field_bean_edit_link.inc\";i:9;s:46:\"views/views_handler_field_bean_delete_link.inc\";i:10;s:45:\"views/views_handler_field_bean_operations.inc\";i:11;s:9:\"bean.test\";}s:12:\"dependencies\";a:2:{i:0;s:6:\"entity\";i:1;s:6:\"ctools\";}s:7:\"package\";s:4:\"Bean\";s:7:\"version\";s:8:\"7.x-1.11\";s:7:\"project\";s:4:\"bean\";s:9:\"datestamp\";s:10:\"1470638340\";s:5:\"mtime\";i:1542781011;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/bean/bean_admin_ui/bean_admin_ui.module','bean_admin_ui','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:13:\"Bean Admin UI\";s:11:\"description\";s:47:\"Add the ability to create Block Types in the UI\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:20:\"bean_admin_ui.module\";i:1;s:28:\"plugins/BeanCustom.class.php\";}s:12:\"dependencies\";a:1:{i:0;s:4:\"bean\";}s:9:\"configure\";s:27:\"admin/structure/block-types\";s:7:\"package\";s:4:\"Bean\";s:7:\"version\";s:8:\"7.x-1.11\";s:7:\"project\";s:4:\"bean\";s:9:\"datestamp\";s:10:\"1470638340\";s:5:\"mtime\";i:1542781011;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/bean/bean_entitycache/bean_entitycache.module','bean_entitycache','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:18:\"Bean - Entitycache\";s:11:\"description\";s:54:\"Integrates the Bean module with the Entitycache module\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:27:\"Performance and scalability\";s:5:\"files\";a:1:{i:0;s:34:\"includes/bean_entitycache.core.inc\";}s:12:\"dependencies\";a:2:{i:0;s:4:\"bean\";i:1;s:11:\"entitycache\";}s:7:\"version\";s:8:\"7.x-1.11\";s:7:\"project\";s:4:\"bean\";s:9:\"datestamp\";s:10:\"1470638340\";s:5:\"mtime\";i:1542781011;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/bean/bean_usage/bean_usage.module','bean_usage','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Bean Usage\";s:11:\"description\";s:32:\"View Bean (Block Entities) Usage\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:4:\"bean\";i:1;s:14:\"blockreference\";}s:7:\"package\";s:4:\"Bean\";s:7:\"version\";s:8:\"7.x-1.11\";s:7:\"project\";s:4:\"bean\";s:9:\"datestamp\";s:10:\"1470638340\";s:5:\"mtime\";i:1542781011;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/bean/bean_uuid/bean_uuid.module','bean_uuid','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"Bean UUID\";s:11:\"description\";s:60:\"Allow deploying bean blocks through Deploy and UUID modules.\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:4:\"bean\";i:1;s:4:\"uuid\";}s:7:\"package\";s:4:\"Bean\";s:7:\"version\";s:8:\"7.x-1.11\";s:7:\"project\";s:4:\"bean\";s:9:\"datestamp\";s:10:\"1470638340\";s:5:\"mtime\";i:1542781011;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/bean/tests/bean_test.module','bean_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:9:\"Bean Test\";s:11:\"description\";s:29:\"Creates test plugins for bean\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"bean\";}s:5:\"files\";a:1:{i:0;s:16:\"bean_test.module\";}s:6:\"hidden\";b:1;s:7:\"version\";s:8:\"7.x-1.11\";s:7:\"project\";s:4:\"bean\";s:9:\"datestamp\";s:10:\"1470638340\";s:5:\"mtime\";i:1542781011;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/builder/builder.module','builder','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:7:\"Builder\";s:11:\"description\";s:55:\"Entity Field builder. Create a page with drag and drop.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:5:\"Tabvn\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:9:\"configure\";s:32:\"admin/config/builder/permissions\";s:7:\"version\";s:5:\"7.1.6\";s:5:\"mtime\";i:1542781011;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ckeditor/ckeditor.module','ckeditor','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:8:\"CKEditor\";s:11:\"description\";s:76:\"Enables CKEditor (WYSIWYG HTML editor) for use instead of plain text fields.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:14:\"User interface\";s:9:\"configure\";s:29:\"admin/config/content/ckeditor\";s:5:\"files\";a:1:{i:0;s:19:\"tests/ckeditor.test\";}s:7:\"version\";s:8:\"7.x-1.18\";s:7:\"project\";s:8:\"ckeditor\";s:9:\"datestamp\";s:10:\"1498506247\";s:5:\"mtime\";i:1542781012;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/bulk_export/bulk_export.module','bulk_export','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Bulk Export\";s:11:\"description\";s:67:\"Performs bulk exporting of data objects known about by Chaos tools.\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781014;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/ctools.module','ctools','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Chaos tools\";s:11:\"description\";s:46:\"A library of helpful tools by Merlin of Chaos.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:5:\"files\";a:11:{i:0;s:20:\"includes/context.inc\";i:1;s:22:\"includes/css-cache.inc\";i:2;s:22:\"includes/math-expr.inc\";i:3;s:21:\"includes/stylizer.inc\";i:4;s:18:\"tests/context.test\";i:5;s:14:\"tests/css.test\";i:6;s:20:\"tests/css_cache.test\";i:7;s:25:\"tests/ctools.plugins.test\";i:8;s:26:\"tests/math_expression.test\";i:9;s:32:\"tests/math_expression_stack.test\";i:10;s:23:\"tests/object_cache.test\";}s:7:\"version\";s:8:\"7.x-1.12\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781014;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/ctools_access_ruleset/ctools_access_ruleset.module','ctools_access_ruleset','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"Custom rulesets\";s:11:\"description\";s:81:\"Create custom, exportable, reusable access rulesets for applications like Panels.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781014;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/ctools_ajax_sample/ctools_ajax_sample.module','ctools_ajax_sample','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:33:\"Chaos Tools (CTools) AJAX Example\";s:11:\"description\";s:41:\"Shows how to use the power of Chaos AJAX.\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781014;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/ctools_custom_content/ctools_custom_content.module','ctools_custom_content','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:20:\"Custom content panes\";s:11:\"description\";s:79:\"Create custom, exportable, reusable content panes for applications like Panels.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781014;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/ctools_plugin_example/ctools_plugin_example.module','ctools_plugin_example','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:35:\"Chaos Tools (CTools) Plugin Example\";s:11:\"description\";s:75:\"Shows how an external module can provide ctools plugins (for Panels, etc.).\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:12:\"dependencies\";a:4:{i:0;s:6:\"ctools\";i:1;s:6:\"panels\";i:2;s:12:\"page_manager\";i:3;s:13:\"advanced_help\";}s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781014;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/page_manager/page_manager.module','page_manager','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"Page manager\";s:11:\"description\";s:54:\"Provides a UI and API to manage pages within the site.\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781014;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/stylizer/stylizer.module','stylizer','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:8:\"Stylizer\";s:11:\"description\";s:53:\"Create custom styles for applications such as Panels.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:12:\"dependencies\";a:2:{i:0;s:6:\"ctools\";i:1;s:5:\"color\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781015;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/term_depth/term_depth.module','term_depth','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:17:\"Term Depth access\";s:11:\"description\";s:48:\"Controls access to context based upon term depth\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781015;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/tests/ctools_export_test/ctools_export_test.module','ctools_export_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:18:\"CTools export test\";s:11:\"description\";s:25:\"CTools export test module\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:6:\"hidden\";b:1;s:5:\"files\";a:1:{i:0;s:18:\"ctools_export.test\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781015;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/tests/ctools_plugin_test.module','ctools_plugin_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:24:\"Chaos tools plugins test\";s:11:\"description\";s:42:\"Provides hooks for testing ctools plugins.\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:8:\"7.x-1.12\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:5:\"files\";a:6:{i:0;s:19:\"ctools.plugins.test\";i:1;s:17:\"object_cache.test\";i:2;s:8:\"css.test\";i:3;s:12:\"context.test\";i:4;s:20:\"math_expression.test\";i:5;s:26:\"math_expression_stack.test\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781015;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/ctools/views_content/views_content.module','views_content','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:19:\"Views content panes\";s:11:\"description\";s:104:\"Allows Views content to be used in Panels, Dashboard and other modules which use the CTools Content API.\";s:7:\"package\";s:16:\"Chaos tool suite\";s:12:\"dependencies\";a:2:{i:0;s:6:\"ctools\";i:1;s:5:\"views\";}s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:8:\"7.x-1.12\";s:5:\"files\";a:3:{i:0;s:61:\"plugins/views/views_content_plugin_display_ctools_context.inc\";i:1;s:57:\"plugins/views/views_content_plugin_display_panel_pane.inc\";i:2;s:59:\"plugins/views/views_content_plugin_style_ctools_context.inc\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1479787162\";s:5:\"mtime\";i:1542781016;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/delete_all/delete_all.module','delete_all','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"Delete content and users\";s:11:\"description\";s:112:\"Allows deletion of all nodes, comments and users on a site. Useful for development or prior to launching a site.\";s:7:\"package\";s:11:\"Development\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:7:\"7.x-1.1\";s:7:\"project\";s:10:\"delete_all\";s:9:\"datestamp\";s:10:\"1351902070\";s:5:\"mtime\";i:1542781016;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/devel/devel.module','devel','module','',1,1,7006,88,'a:14:{s:4:\"name\";s:5:\"Devel\";s:11:\"description\";s:52:\"Various blocks, pages, and functions for developers.\";s:7:\"package\";s:11:\"Development\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:30:\"admin/config/development/devel\";s:4:\"tags\";a:1:{i:0;s:9:\"developer\";}s:5:\"files\";a:2:{i:0;s:10:\"devel.test\";i:1;s:14:\"devel.mail.inc\";}s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:5:\"devel\";s:9:\"datestamp\";s:10:\"1398963366\";s:5:\"mtime\";i:1542781017;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/devel/devel_generate/devel_generate.module','devel_generate','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:14:\"Devel generate\";s:11:\"description\";s:48:\"Generate dummy users, nodes, and taxonomy terms.\";s:7:\"package\";s:11:\"Development\";s:4:\"core\";s:3:\"7.x\";s:4:\"tags\";a:1:{i:0;s:9:\"developer\";}s:9:\"configure\";s:33:\"admin/config/development/generate\";s:5:\"files\";a:1:{i:0;s:19:\"devel_generate.test\";}s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:5:\"devel\";s:9:\"datestamp\";s:10:\"1398963366\";s:5:\"mtime\";i:1542781018;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/devel/devel_node_access.module','devel_node_access','module','',1,0,0,0,'a:14:{s:4:\"name\";s:17:\"Devel node access\";s:11:\"description\";s:68:\"Developer blocks and page illustrating relevant node_access records.\";s:7:\"package\";s:11:\"Development\";s:12:\"dependencies\";a:1:{i:0;s:4:\"menu\";}s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:30:\"admin/config/development/devel\";s:4:\"tags\";a:1:{i:0;s:9:\"developer\";}s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:5:\"devel\";s:9:\"datestamp\";s:10:\"1398963366\";s:5:\"mtime\";i:1542781018;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/entity/entity.module','entity','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Entity API\";s:11:\"description\";s:69:\"Enables modules to work with any entity type and to provide entities.\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:24:{i:0;s:19:\"entity.features.inc\";i:1;s:15:\"entity.i18n.inc\";i:2;s:15:\"entity.info.inc\";i:3;s:16:\"entity.rules.inc\";i:4;s:11:\"entity.test\";i:5;s:19:\"includes/entity.inc\";i:6;s:30:\"includes/entity.controller.inc\";i:7;s:22:\"includes/entity.ui.inc\";i:8;s:27:\"includes/entity.wrapper.inc\";i:9;s:22:\"views/entity.views.inc\";i:10;s:52:\"views/handlers/entity_views_field_handler_helper.inc\";i:11;s:51:\"views/handlers/entity_views_handler_area_entity.inc\";i:12;s:53:\"views/handlers/entity_views_handler_field_boolean.inc\";i:13;s:50:\"views/handlers/entity_views_handler_field_date.inc\";i:14;s:54:\"views/handlers/entity_views_handler_field_duration.inc\";i:15;s:52:\"views/handlers/entity_views_handler_field_entity.inc\";i:16;s:51:\"views/handlers/entity_views_handler_field_field.inc\";i:17;s:53:\"views/handlers/entity_views_handler_field_numeric.inc\";i:18;s:53:\"views/handlers/entity_views_handler_field_options.inc\";i:19;s:50:\"views/handlers/entity_views_handler_field_text.inc\";i:20;s:49:\"views/handlers/entity_views_handler_field_uri.inc\";i:21;s:62:\"views/handlers/entity_views_handler_relationship_by_bundle.inc\";i:22;s:52:\"views/handlers/entity_views_handler_relationship.inc\";i:23;s:53:\"views/plugins/entity_views_plugin_row_entity_view.inc\";}s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:6:\"entity\";s:9:\"datestamp\";s:10:\"1474546503\";s:5:\"mtime\";i:1542781018;s:12:\"dependencies\";a:0:{}s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/entity/entity_token.module','entity_token','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:13:\"Entity tokens\";s:11:\"description\";s:99:\"Provides token replacements for all properties that have no tokens and are known to the entity API.\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:23:\"entity_token.tokens.inc\";i:1;s:19:\"entity_token.module\";}s:12:\"dependencies\";a:1:{i:0;s:6:\"entity\";}s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:6:\"entity\";s:9:\"datestamp\";s:10:\"1474546503\";s:5:\"mtime\";i:1542781018;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/entity/tests/entity_feature.module','entity_feature','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:21:\"Entity feature module\";s:11:\"description\";s:31:\"Provides some entities in code.\";s:7:\"version\";s:7:\"7.x-1.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:21:\"entity_feature.module\";}s:12:\"dependencies\";a:1:{i:0;s:11:\"entity_test\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"entity\";s:9:\"datestamp\";s:10:\"1474546503\";s:5:\"mtime\";i:1542781019;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/entity/tests/entity_test.module','entity_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:23:\"Entity CRUD test module\";s:11:\"description\";s:46:\"Provides entity types based upon the CRUD API.\";s:7:\"version\";s:7:\"7.x-1.8\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:18:\"entity_test.module\";i:1;s:19:\"entity_test.install\";}s:12:\"dependencies\";a:1:{i:0;s:6:\"entity\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"entity\";s:9:\"datestamp\";s:10:\"1474546503\";s:5:\"mtime\";i:1542781019;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/entity/tests/entity_test_i18n.module','entity_test_i18n','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:28:\"Entity-test type translation\";s:11:\"description\";s:37:\"Allows translating entity-test types.\";s:12:\"dependencies\";a:2:{i:0;s:11:\"entity_test\";i:1;s:11:\"i18n_string\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:6:\"entity\";s:9:\"datestamp\";s:10:\"1474546503\";s:5:\"mtime\";i:1542781020;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/entitycache/entitycache.module','entitycache','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"Entity cache\";s:11:\"description\";s:70:\"Provides caching for core entities including nodes and taxonomy terms.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:27:\"Performance and scalability\";s:5:\"files\";a:7:{i:0;s:52:\"includes/entitycache.entitycachecontrollerhelper.inc\";i:1;s:32:\"includes/entitycache.comment.inc\";i:2;s:48:\"includes/entitycache.defaultentitycontroller.inc\";i:3;s:29:\"includes/entitycache.node.inc\";i:4;s:33:\"includes/entitycache.taxonomy.inc\";i:5;s:29:\"includes/entitycache.user.inc\";i:6;s:16:\"entitycache.test\";}s:12:\"dependencies\";a:1:{i:0;s:15:\"system (>=7.36)\";}s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:11:\"entitycache\";s:9:\"datestamp\";s:10:\"1445943840\";s:5:\"mtime\";i:1542781020;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/facetapi/contrib/current_search/current_search.module','current_search','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:21:\"Current Search Blocks\";s:11:\"description\";s:90:\"Provides an interface for creating blocks containing information about the current search.\";s:12:\"dependencies\";a:1:{i:0;s:8:\"facetapi\";}s:7:\"package\";s:14:\"Search Toolkit\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:5:{i:0;s:31:\"plugins/current_search/item.inc\";i:1;s:38:\"plugins/current_search/item_active.inc\";i:2;s:37:\"plugins/current_search/item_group.inc\";i:3;s:36:\"plugins/current_search/item_text.inc\";i:4;s:25:\"tests/current_search.test\";}s:9:\"configure\";s:34:\"admin/config/search/current_search\";s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:8:\"facetapi\";s:9:\"datestamp\";s:10:\"1405685332\";s:5:\"mtime\";i:1542781020;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/facetapi/facetapi.module','facetapi','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"Facet API\";s:11:\"description\";s:68:\"An abstracted facet API that can be used by various search backends.\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"package\";s:14:\"Search Toolkit\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:14:{i:0;s:28:\"plugins/facetapi/adapter.inc\";i:1;s:31:\"plugins/facetapi/dependency.inc\";i:2;s:38:\"plugins/facetapi/dependency_bundle.inc\";i:3;s:36:\"plugins/facetapi/dependency_role.inc\";i:4;s:35:\"plugins/facetapi/empty_behavior.inc\";i:5;s:40:\"plugins/facetapi/empty_behavior_text.inc\";i:6;s:27:\"plugins/facetapi/filter.inc\";i:7;s:31:\"plugins/facetapi/query_type.inc\";i:8;s:34:\"plugins/facetapi/url_processor.inc\";i:9;s:43:\"plugins/facetapi/url_processor_standard.inc\";i:10;s:27:\"plugins/facetapi/widget.inc\";i:11;s:33:\"plugins/facetapi/widget_links.inc\";i:12;s:31:\"tests/facetapi_test.plugins.inc\";i:13;s:19:\"tests/facetapi.test\";}s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:8:\"facetapi\";s:9:\"datestamp\";s:10:\"1405685332\";s:5:\"mtime\";i:1542781020;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/facetapi/tests/facetapi_test.module','facetapi_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:14:\"Facet API Test\";s:11:\"description\";s:36:\"Provides a test adapter and plugins.\";s:12:\"dependencies\";a:1:{i:0;s:8:\"facetapi\";}s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:8:\"facetapi\";s:9:\"datestamp\";s:10:\"1405685332\";s:5:\"mtime\";i:1542781020;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/fbconnect/fbconnect.module','fbconnect','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:9:\"FBConnect\";s:11:\"description\";s:45:\"Allows users to connect with Facebook account\";s:7:\"package\";s:15:\"Facebook Social\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{s:3:\"] \";s:20:\"tests/fbconnect.test\";}s:9:\"configure\";s:29:\"admin/config/people/fbconnect\";s:7:\"version\";s:20:\"7.x-2.0-beta4+27-dev\";s:7:\"project\";s:9:\"fbconnect\";s:9:\"datestamp\";s:10:\"1452418742\";s:5:\"mtime\";i:1542781020;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/fbconnect/fbconnect_invite/fbconnect_invite.module','fbconnect_invite','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:33:\"FBConnect Facebook Friends Invite\";s:12:\"dependencies\";a:2:{i:0;s:9:\"fbconnect\";i:1;s:15:\"fbconnect_login\";}s:7:\"package\";s:15:\"Facebook Social\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:20:\"7.x-2.0-beta4+27-dev\";s:7:\"project\";s:9:\"fbconnect\";s:9:\"datestamp\";s:10:\"1452418742\";s:5:\"mtime\";i:1542781020;s:11:\"description\";s:0:\"\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/fbconnect/fbconnect_login/fbconnect_login.module','fbconnect_login','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"FBConnect Facebook Login\";s:12:\"dependencies\";a:1:{i:0;s:9:\"fbconnect\";}s:7:\"package\";s:15:\"Facebook Social\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:20:\"7.x-2.0-beta4+27-dev\";s:7:\"project\";s:9:\"fbconnect\";s:9:\"datestamp\";s:10:\"1452418742\";s:5:\"mtime\";i:1542781020;s:11:\"description\";s:0:\"\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/fbconnect/fbconnect_stream_publish/fbconnect_stream_publish.module','fbconnect_stream_publish','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"FBConnect Stream Publish\";s:7:\"package\";s:15:\"Facebook Social\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:20:\"7.x-2.0-beta4+27-dev\";s:7:\"project\";s:9:\"fbconnect\";s:9:\"datestamp\";s:10:\"1452418742\";s:5:\"mtime\";i:1542781020;s:12:\"dependencies\";a:0:{}s:11:\"description\";s:0:\"\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/fbconnect/tests/fbconnect_test.module','fbconnect_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:14:\"FBConnect Test\";s:12:\"dependencies\";a:1:{i:0;s:9:\"fbconnect\";}s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:20:\"7.x-2.0-beta4+27-dev\";s:7:\"project\";s:9:\"fbconnect\";s:9:\"datestamp\";s:10:\"1452418742\";s:5:\"mtime\";i:1542781020;s:11:\"description\";s:0:\"\";s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/features/features.module','features','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:8:\"Features\";s:11:\"description\";s:39:\"Provides feature management for Drupal.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:8:\"Features\";s:5:\"files\";a:1:{i:0;s:19:\"tests/features.test\";}s:17:\"test_dependencies\";a:4:{i:0;s:5:\"image\";i:1;s:9:\"strongarm\";i:2;s:8:\"taxonomy\";i:3;s:5:\"views\";}s:9:\"configure\";s:33:\"admin/structure/features/settings\";s:7:\"version\";s:8:\"7.x-2.10\";s:7:\"project\";s:8:\"features\";s:9:\"datestamp\";s:10:\"1461011641\";s:5:\"mtime\";i:1542781020;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/features/tests/features_test/features_test.module','features_test','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:14:\"Features Tests\";s:11:\"description\";s:33:\"Test module for Features testing.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:3:\"php\";s:5:\"5.2.0\";s:12:\"dependencies\";a:5:{i:0;s:8:\"features\";i:1;s:5:\"image\";i:2;s:9:\"strongarm\";i:3;s:8:\"taxonomy\";i:4;s:5:\"views\";}s:8:\"features\";a:10:{s:6:\"ctools\";a:2:{i:0;s:21:\"strongarm:strongarm:1\";i:1;s:23:\"views:views_default:3.0\";}s:12:\"features_api\";a:1:{i:0;s:5:\"api:2\";}s:10:\"field_base\";a:1:{i:0;s:19:\"field_features_test\";}s:14:\"field_instance\";a:1:{i:0;s:38:\"node-features_test-field_features_test\";}s:6:\"filter\";a:1:{i:0;s:13:\"features_test\";}s:5:\"image\";a:1:{i:0;s:13:\"features_test\";}s:4:\"node\";a:1:{i:0;s:13:\"features_test\";}s:8:\"taxonomy\";a:1:{i:0;s:22:\"taxonomy_features_test\";}s:15:\"user_permission\";a:1:{i:0;s:28:\"create features_test content\";}s:10:\"views_view\";a:1:{i:0;s:13:\"features_test\";}}s:6:\"hidden\";s:1:\"1\";s:7:\"version\";s:8:\"7.x-2.10\";s:7:\"project\";s:8:\"features\";s:9:\"datestamp\";s:10:\"1461011641\";s:5:\"mtime\";i:1542781020;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/field_collection/field_collection.module','field_collection','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:16:\"Field collection\";s:11:\"description\";s:81:\"Provides a field collection field, to which any number of fields can be attached.\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"entity\";}s:5:\"files\";a:5:{i:0;s:21:\"field_collection.test\";i:1;s:27:\"field_collection.entity.inc\";i:2;s:25:\"field_collection.info.inc\";i:3;s:47:\"views/field_collection_handler_relationship.inc\";i:4;s:28:\"field_collection.migrate.inc\";}s:9:\"configure\";s:33:\"admin/structure/field-collections\";s:7:\"package\";s:6:\"Fields\";s:7:\"version\";s:14:\"7.x-1.0-beta11\";s:7:\"project\";s:16:\"field_collection\";s:9:\"datestamp\";s:10:\"1454338759\";s:5:\"mtime\";i:1542781020;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/fivestar/fivestar.module','fivestar','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:8:\"Fivestar\";s:11:\"description\";s:48:\"Enables fivestar ratings on content, users, etc.\";s:7:\"package\";s:6:\"Voting\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:9:\"votingapi\";}s:9:\"configure\";s:29:\"admin/config/content/fivestar\";s:5:\"files\";a:3:{i:0;s:20:\"fivestar.migrate.inc\";i:1;s:23:\"test/fivestar.base.test\";i:2;s:24:\"test/fivestar.field.test\";}s:7:\"version\";s:7:\"7.x-2.2\";s:7:\"project\";s:8:\"fivestar\";s:9:\"datestamp\";s:10:\"1461406444\";s:5:\"mtime\";i:1542781020;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/front/front_page.module','front_page','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Front Page\";s:11:\"description\";s:57:\"Allows site admins setup custom front pages for the site.\";s:7:\"package\";s:14:\"Administration\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:27:\"admin/config/front/settings\";s:7:\"version\";s:7:\"7.x-2.4\";s:7:\"project\";s:5:\"front\";s:9:\"datestamp\";s:10:\"1370619956\";s:5:\"mtime\";i:1542781021;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n.module','i18n','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:20:\"Internationalization\";s:11:\"description\";s:49:\"Extends Drupal support for multilingual features.\";s:12:\"dependencies\";a:2:{i:0;s:6:\"locale\";i:1;s:8:\"variable\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:15:\"i18n_object.inc\";i:1;s:9:\"i18n.test\";}s:9:\"configure\";s:26:\"admin/config/regional/i18n\";s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_block/i18n_block.module','i18n_block','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"Block languages\";s:11:\"description\";s:68:\"Enables language selector for blocks and optional block translation.\";s:12:\"dependencies\";a:2:{i:0;s:5:\"block\";i:1;s:11:\"i18n_string\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:14:\"i18n_block.inc\";i:1;s:15:\"i18n_block.test\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_contact/i18n_contact.module','i18n_contact','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:19:\"Contact translation\";s:11:\"description\";s:63:\"Makes contact categories and replies available for translation.\";s:12:\"dependencies\";a:2:{i:0;s:7:\"contact\";i:1;s:11:\"i18n_string\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_field/i18n_field.module','i18n_field','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:17:\"Field translation\";s:11:\"description\";s:26:\"Translate field properties\";s:12:\"dependencies\";a:2:{i:0;s:5:\"field\";i:1;s:11:\"i18n_string\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:14:\"i18n_field.inc\";i:1;s:15:\"i18n_field.test\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_forum/i18n_forum.module','i18n_forum','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:18:\"Multilingual forum\";s:11:\"description\";s:60:\"Enables multilingual forum, translates names and containers.\";s:12:\"dependencies\";a:3:{i:0;s:5:\"forum\";i:1;s:13:\"i18n_taxonomy\";i:2;s:9:\"i18n_node\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"i18n_forum.test\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_menu/i18n_menu.module','i18n_menu','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"Menu translation\";s:11:\"description\";s:40:\"Supports translatable custom menu items.\";s:12:\"dependencies\";a:4:{i:0;s:4:\"i18n\";i:1;s:4:\"menu\";i:2;s:11:\"i18n_string\";i:3;s:16:\"i18n_translation\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:13:\"i18n_menu.inc\";i:1;s:14:\"i18n_menu.test\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_node/i18n_node.module','i18n_node','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:20:\"Multilingual content\";s:11:\"description\";s:46:\"Extended node options for multilingual content\";s:12:\"dependencies\";a:3:{i:0;s:11:\"translation\";i:1;s:4:\"i18n\";i:2;s:11:\"i18n_string\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:31:\"admin/config/regional/i18n/node\";s:5:\"files\";a:2:{i:0;s:14:\"i18n_node.test\";i:1;s:22:\"i18n_node.variable.inc\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_path/i18n_path.module','i18n_path','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"Path translation\";s:11:\"description\";s:37:\"Define translations for generic paths\";s:12:\"dependencies\";a:1:{i:0;s:16:\"i18n_translation\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:13:\"i18n_path.inc\";i:1;s:14:\"i18n_path.test\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_redirect/i18n_redirect.module','i18n_redirect','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:20:\"Translation redirect\";s:11:\"description\";s:71:\"Redirect to translated page when available. SEO for multilingual sites.\";s:12:\"dependencies\";a:1:{i:0;s:4:\"i18n\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_select/i18n_select.module','i18n_select','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:19:\"Multilingual select\";s:11:\"description\";s:45:\"API module for multilingual content selection\";s:12:\"dependencies\";a:1:{i:0;s:4:\"i18n\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:33:\"admin/config/regional/i18n/select\";s:5:\"files\";a:1:{i:0;s:16:\"i18n_select.test\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_string/i18n_string.module','i18n_string','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:18:\"String translation\";s:11:\"description\";s:57:\"Provides support for translation of user defined strings.\";s:12:\"dependencies\";a:2:{i:0;s:6:\"locale\";i:1;s:4:\"i18n\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:3:{i:0;s:21:\"i18n_string.admin.inc\";i:1;s:15:\"i18n_string.inc\";i:2;s:16:\"i18n_string.test\";}s:9:\"configure\";s:34:\"admin/config/regional/i18n/strings\";s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_sync/i18n_sync.module','i18n_sync','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"Synchronize translations\";s:11:\"description\";s:74:\"Synchronizes taxonomy and fields accross translations of the same content.\";s:12:\"dependencies\";a:2:{i:0;s:4:\"i18n\";i:1;s:11:\"translation\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:5:{i:0;s:16:\"i18n_sync.module\";i:1;s:17:\"i18n_sync.install\";i:2;s:20:\"i18n_sync.module.inc\";i:3;s:18:\"i18n_sync.node.inc\";i:4;s:14:\"i18n_sync.test\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_taxonomy/i18n_taxonomy.module','i18n_taxonomy','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:20:\"Taxonomy translation\";s:11:\"description\";s:30:\"Enables multilingual taxonomy.\";s:12:\"dependencies\";a:3:{i:0;s:8:\"taxonomy\";i:1;s:11:\"i18n_string\";i:2;s:16:\"i18n_translation\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:4:{i:0;s:17:\"i18n_taxonomy.inc\";i:1;s:23:\"i18n_taxonomy.pages.inc\";i:2;s:23:\"i18n_taxonomy.admin.inc\";i:3;s:18:\"i18n_taxonomy.test\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_translation/i18n_translation.module','i18n_translation','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"Translation sets\";s:11:\"description\";s:47:\"Simple translation sets API for generic objects\";s:12:\"dependencies\";a:1:{i:0;s:4:\"i18n\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:20:\"i18n_translation.inc\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_user/i18n_user.module','i18n_user','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:21:\"User mail translation\";s:11:\"description\";s:43:\"Translate emails sent from the User module.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:12:\"dependencies\";a:1:{i:0;s:13:\"i18n_variable\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/i18n_variable/i18n_variable.module','i18n_variable','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:20:\"Variable translation\";s:11:\"description\";s:71:\"Multilingual variables that switch language depending on page language.\";s:12:\"dependencies\";a:3:{i:0;s:4:\"i18n\";i:1;s:24:\"variable_store (7.x-2.x)\";i:2;s:24:\"variable_realm (7.x-2.x)\";}s:7:\"package\";s:35:\"Multilingual - Internationalization\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:35:\"admin/config/regional/i18n/variable\";s:5:\"files\";a:2:{i:0;s:23:\"i18n_variable.class.inc\";i:1;s:18:\"i18n_variable.test\";}s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/i18n/tests/i18n_test.module','i18n_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:26:\"Internationalization tests\";s:11:\"description\";s:55:\"Helper module for testing i18n (do not enable manually)\";s:12:\"dependencies\";a:3:{i:0;s:6:\"locale\";i:1;s:11:\"translation\";i:2;s:4:\"i18n\";}s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:8:\"7.x-1.14\";s:7:\"project\";s:4:\"i18n\";s:9:\"datestamp\";s:10:\"1477154943\";s:5:\"mtime\";i:1542781021;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/imce/imce.module','imce','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:4:\"IMCE\";s:11:\"description\";s:82:\"An image/file uploader and browser supporting personal directories and user quota.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:5:\"Media\";s:9:\"configure\";s:23:\"admin/config/media/imce\";s:7:\"version\";s:8:\"7.x-1.11\";s:7:\"project\";s:4:\"imce\";s:9:\"datestamp\";s:10:\"1495890787\";s:5:\"mtime\";i:1542781022;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/jquery_update/jquery_update.module','jquery_update','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:13:\"jQuery Update\";s:11:\"description\";s:53:\"Update jQuery and jQuery UI to a more recent version.\";s:7:\"package\";s:14:\"User interface\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:20:\"jquery_update.module\";i:1;s:21:\"jquery_update.install\";}s:9:\"configure\";s:38:\"admin/config/development/jquery_update\";s:7:\"version\";s:7:\"7.x-2.7\";s:7:\"project\";s:13:\"jquery_update\";s:9:\"datestamp\";s:10:\"1445379855\";s:5:\"mtime\";i:1542781022;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/libraries/libraries.module','libraries','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"Libraries\";s:11:\"description\";s:64:\"Allows version-dependent and shared usage of external libraries.\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:15:\"system (>=7.11)\";}s:5:\"files\";a:4:{i:0;s:32:\"tests/LibrariesAdminWebTest.test\";i:1;s:31:\"tests/LibrariesLoadWebTest.test\";i:2;s:28:\"tests/LibrariesUnitTest.test\";i:3;s:31:\"tests/LibrariesWebTestBase.test\";}s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:9:\"libraries\";s:9:\"datestamp\";s:10:\"1463077450\";s:5:\"mtime\";i:1542781023;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/libraries/tests/modules/libraries_test_module/libraries_test_module.module','libraries_test_module','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:21:\"Libraries test module\";s:11:\"description\";s:36:\"Tests library detection and loading.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:12:\"dependencies\";a:1:{i:0;s:9:\"libraries\";}s:6:\"hidden\";b:1;s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:9:\"libraries\";s:9:\"datestamp\";s:10:\"1463077450\";s:5:\"mtime\";i:1542781023;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/memcache/memcache.module','memcache','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:8:\"Memcache\";s:11:\"description\";s:43:\"High performance integration with memcache.\";s:7:\"package\";s:27:\"Performance and scalability\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:3:{i:0;s:12:\"memcache.inc\";i:1;s:19:\"tests/memcache.test\";i:2;s:24:\"tests/memcache-lock.test\";}s:7:\"version\";s:7:\"7.x-1.6\";s:7:\"project\";s:8:\"memcache\";s:9:\"datestamp\";s:10:\"1487954088\";s:5:\"mtime\";i:1542781023;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/memcache/memcache_admin/memcache_admin.module','memcache_admin','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:14:\"Memcache Admin\";s:11:\"description\";s:60:\"Adds a User Interface to monitor the Memcache for this site.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:27:\"Performance and scalability\";s:9:\"configure\";s:28:\"admin/config/system/memcache\";s:7:\"version\";s:7:\"7.x-1.6\";s:7:\"project\";s:8:\"memcache\";s:9:\"datestamp\";s:10:\"1487954088\";s:5:\"mtime\";i:1542781024;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/memcache/tests/memcache_test.module','memcache_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:13:\"Memcache test\";s:11:\"description\";s:36:\"Support module for memcache testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:7:\"7.x-1.6\";s:7:\"project\";s:8:\"memcache\";s:9:\"datestamp\";s:10:\"1487954088\";s:5:\"mtime\";i:1542781024;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/memcache_storage/memcache_storage.module','memcache_storage','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:16:\"Memcache Storage\";s:11:\"description\";s:68:\"Provides integration with memcached backend for storing cached data.\";s:7:\"package\";s:27:\"Performance and scalability\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:41:\"admin/config/development/memcache_storage\";s:5:\"files\";a:1:{i:0;s:24:\"memcache_storage.api.inc\";}s:7:\"version\";s:7:\"7.x-1.4\";s:7:\"project\";s:16:\"memcache_storage\";s:9:\"datestamp\";s:10:\"1385456005\";s:5:\"mtime\";i:1542781024;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/minify/minify.module','minify','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:6:\"Minify\";s:11:\"description\";s:57:\"Provides a mechanism to minify HTML and JavaScript files.\";s:7:\"package\";s:27:\"Performance and scalability\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:44:\"admin/config/development/performance/default\";s:7:\"version\";s:7:\"7.x-1.4\";s:7:\"project\";s:6:\"minify\";s:9:\"datestamp\";s:10:\"1493957003\";s:5:\"mtime\";i:1542781024;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/modules/multivariate_chart/multivariate_chart.module','multivariate_chart','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:18:\"Multivariate Chart\";s:11:\"description\";s:38:\"Provide multivariate results charting.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:2:{i:0;s:12:\"multivariate\";i:1;s:9:\"libraries\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/multivariate.module','multivariate','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:12:\"Multivariate\";s:11:\"description\";s:37:\"Provide multivariate testing utility.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:2:{i:0;s:6:\"ctools\";i:1;s:6:\"entity\";}s:5:\"files\";a:1:{i:0;s:27:\"multivariate.controller.inc\";}s:9:\"configure\";s:25:\"admin/config/multivariate\";s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/mutations/multivariate_form_css/multivariate_form_css.module','multivariate_form_css','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:17:\"CSS form mutation\";s:11:\"description\";s:25:\"CSS Form mutation plugin.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:1:{i:0;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/mutations/multivariate_ga/multivariate_ga.module','multivariate_ga','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"GA Mutation\";s:11:\"description\";s:94:\"Google Analytics mutation plugin for sending test tracking results to Google analytics server.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:2:{i:0;s:15:\"googleanalytics\";i:1;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/mutations/multivariate_internal_css/multivariate_internal_css.module','multivariate_internal_css','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:21:\"Internal CSS mutation\";s:11:\"description\";s:29:\"Internal CSS mutation plugin.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:1:{i:0;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/mutations/multivariate_internal_js/multivariate_internal_js.module','multivariate_internal_js','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:28:\"Internal Javascript mutation\";s:11:\"description\";s:36:\"Internal Javascript mutation plugin.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:1:{i:0;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/mutations/multivariate_node_load/multivariate_node_load.module','multivariate_node_load','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"Node load\";s:11:\"description\";s:26:\"Node load mutation plugin.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:1:{i:0;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/mutations/multivariate_path_mutation/multivariate_path_mutation.module','multivariate_path_mutation','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:13:\"Path mutation\";s:11:\"description\";s:21:\"Path mutation plugin.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:1:{i:0;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/mutations/multivariate_path_redirection/multivariate_path_redirection.module','multivariate_path_redirection','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"Path redirection\";s:11:\"description\";s:33:\"Path redirection mutation plugin.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:1:{i:0;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/mutations/multivariate_variable_change/multivariate_variable_change.module','multivariate_variable_change','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"Variable change\";s:11:\"description\";s:32:\"Variable change mutation plugin.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:1:{i:0;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/success_conditions/multivariate_form_submit_sc/multivariate_form_submit_sc.module','multivariate_form_submit_sc','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:29:\"Form submit success condition\";s:11:\"description\";s:37:\"Form submit success condition plugin.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:1:{i:0;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/multivariate/plugins/success_conditions/multivariate_path_sc/multivariate_path_sc.module','multivariate_path_sc','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:22:\"Path success condition\";s:11:\"description\";s:30:\"Path success condition plugin.\";s:7:\"package\";s:23:\"Usability testing suite\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:1:\"5\";s:12:\"dependencies\";a:1:{i:0;s:12:\"multivariate\";}s:7:\"version\";s:11:\"7.x-1.x-dev\";s:7:\"project\";s:12:\"multivariate\";s:9:\"datestamp\";s:10:\"1380592388\";s:5:\"mtime\";i:1542781024;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/prlp/prlp.module','prlp','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:34:\"Password Reset Landing Page (PRLP)\";s:11:\"description\";s:130:\"Enhances the password reset landing page by letting user change their password there (and potentially username and email address).\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:14:\"Administration\";s:9:\"configure\";s:33:\"admin/config/people/accounts/prlp\";s:7:\"version\";s:7:\"7.x-1.3\";s:7:\"project\";s:4:\"prlp\";s:9:\"datestamp\";s:10:\"1465582441\";s:5:\"mtime\";i:1542781024;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/roles_for_menu/roles_for_menu.module','roles_for_menu','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:14:\"Roles for menu\";s:11:\"description\";s:76:\"Allows administrators to specify for each roles to show/hide specific menus.\";s:12:\"dependencies\";a:1:{i:0;s:4:\"menu\";}s:9:\"conflicts\";a:2:{i:0;s:13:\"menu_per_role\";i:1;s:20:\"menu_item_visibility\";}s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:14:\"Access control\";s:9:\"configure\";s:29:\"admin/structure/menu/settings\";s:7:\"version\";s:7:\"7.x-1.1\";s:7:\"project\";s:14:\"roles_for_menu\";s:9:\"datestamp\";s:10:\"1424099925\";s:5:\"mtime\";i:1542781024;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/simpleads/modules/simpleads_campaigns/simpleads_campaigns.module','simpleads_campaigns','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:9:\"Campaigns\";s:11:\"description\";s:23:\"Advertisement campaigns\";s:7:\"package\";s:9:\"SimpleAds\";s:4:\"core\";s:3:\"7.x\";s:7:\"scripts\";a:1:{s:22:\"simpleads_campaigns.js\";s:78:\"sites/all/modules/simpleads/modules/simpleads_campaigns/simpleads_campaigns.js\";}s:12:\"dependencies\";a:1:{i:0;s:9:\"simpleads\";}s:7:\"version\";s:7:\"7.x-1.9\";s:7:\"project\";s:9:\"simpleads\";s:9:\"datestamp\";s:10:\"1418928698\";s:5:\"mtime\";i:1542781024;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/simpleads/simpleads.module','simpleads','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:9:\"SimpleAds\";s:11:\"description\";s:14:\"Advertisements\";s:7:\"package\";s:9:\"SimpleAds\";s:4:\"core\";s:3:\"7.x\";s:7:\"scripts\";a:1:{s:12:\"simpleads.js\";s:40:\"sites/all/modules/simpleads/simpleads.js\";}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:13:\"simpleads.css\";s:41:\"sites/all/modules/simpleads/simpleads.css\";}}s:5:\"files\";a:1:{i:0;s:35:\"includes/views_simpleads_plugin.inc\";}s:12:\"dependencies\";a:8:{i:0;s:8:\"taxonomy\";i:1;s:5:\"field\";i:2;s:7:\"options\";i:3;s:4:\"list\";i:4;s:17:\"field_sql_storage\";i:5;s:4:\"file\";i:6;s:5:\"image\";i:7;s:4:\"text\";}s:7:\"version\";s:7:\"7.x-1.9\";s:7:\"project\";s:9:\"simpleads\";s:9:\"datestamp\";s:10:\"1418928698\";s:5:\"mtime\";i:1542781024;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/smtp/smtp.module','smtp','module','',0,0,-1,0,'a:14:{s:4:\"name\";s:27:\"SMTP Authentication Support\";s:11:\"description\";s:71:\"Allow for site emails to be sent through an SMTP server of your choice.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Mail\";s:9:\"configure\";s:24:\"admin/config/system/smtp\";s:5:\"files\";a:4:{i:0;s:13:\"smtp.mail.inc\";i:1;s:18:\"smtp.phpmailer.inc\";i:2;s:18:\"smtp.transport.inc\";i:3;s:20:\"tests/smtp.unit.test\";}s:17:\"test_dependencies\";a:1:{i:0;s:7:\"maillog\";}s:7:\"version\";s:7:\"7.x-1.4\";s:7:\"project\";s:4:\"smtp\";s:9:\"datestamp\";s:10:\"1462454772\";s:5:\"mtime\";i:1542781024;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/smtp/tests/smtp_tests.module','smtp_tests','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"SMTP tests\";s:11:\"description\";s:41:\"Contains helper logic for the SMTP tests.\";s:7:\"package\";s:4:\"Mail\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:7:\"7.x-1.4\";s:7:\"project\";s:4:\"smtp\";s:9:\"datestamp\";s:10:\"1462454772\";s:5:\"mtime\";i:1542781024;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/variable/variable.module','variable','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:8:\"Variable\";s:11:\"description\";s:43:\"Variable Information and basic variable API\";s:7:\"package\";s:8:\"Variable\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:9:{i:0;s:27:\"includes/forum.variable.inc\";i:1;s:28:\"includes/locale.variable.inc\";i:2;s:26:\"includes/menu.variable.inc\";i:3;s:26:\"includes/node.variable.inc\";i:4;s:28:\"includes/system.variable.inc\";i:5;s:30:\"includes/taxonomy.variable.inc\";i:6;s:33:\"includes/translation.variable.inc\";i:7;s:26:\"includes/user.variable.inc\";i:8;s:13:\"variable.test\";}s:7:\"version\";s:7:\"7.x-2.5\";s:7:\"project\";s:8:\"variable\";s:9:\"datestamp\";s:10:\"1398250128\";s:5:\"mtime\";i:1542781025;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/variable/variable_admin/variable_admin.module','variable_admin','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:14:\"Variable admin\";s:11:\"description\";s:26:\"Variable Administration UI\";s:12:\"dependencies\";a:1:{i:0;s:8:\"variable\";}s:7:\"package\";s:8:\"Variable\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:7:\"7.x-2.5\";s:7:\"project\";s:8:\"variable\";s:9:\"datestamp\";s:10:\"1398250128\";s:5:\"mtime\";i:1542781025;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/variable/variable_example/variable_example.module','variable_example','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"Variable example\";s:11:\"description\";s:83:\"An example module showing how to use the Variable API and providing some variables.\";s:12:\"dependencies\";a:2:{i:0;s:8:\"variable\";i:1;s:14:\"variable_store\";}s:7:\"package\";s:15:\"Example modules\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:29:\"variable_example.variable.inc\";}s:7:\"version\";s:7:\"7.x-2.5\";s:7:\"project\";s:8:\"variable\";s:9:\"datestamp\";s:10:\"1398250128\";s:5:\"mtime\";i:1542781025;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/variable/variable_realm/variable_realm.module','variable_realm','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:14:\"Variable realm\";s:11:\"description\";s:49:\"API to use variable realms from different modules\";s:12:\"dependencies\";a:1:{i:0;s:8:\"variable\";}s:7:\"package\";s:8:\"Variable\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:7:\"7.x-2.5\";s:5:\"files\";a:2:{i:0;s:24:\"variable_realm.class.inc\";i:1;s:30:\"variable_realm_union.class.inc\";}s:7:\"project\";s:8:\"variable\";s:9:\"datestamp\";s:10:\"1398250128\";s:5:\"mtime\";i:1542781025;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/variable/variable_store/variable_store.module','variable_store','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:14:\"Variable store\";s:11:\"description\";s:60:\"Database storage for variable realms. This is an API module.\";s:12:\"dependencies\";a:1:{i:0;s:8:\"variable\";}s:7:\"package\";s:8:\"Variable\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:7:\"7.x-2.5\";s:5:\"files\";a:2:{i:0;s:24:\"variable_store.class.inc\";i:1;s:19:\"variable_store.test\";}s:7:\"project\";s:8:\"variable\";s:9:\"datestamp\";s:10:\"1398250128\";s:5:\"mtime\";i:1542781025;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/variable/variable_views/variable_views.module','variable_views','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:14:\"Variable views\";s:11:\"description\";s:78:\"Provides views integration for variable, included a default variable argument.\";s:12:\"dependencies\";a:2:{i:0;s:8:\"variable\";i:1;s:5:\"views\";}s:7:\"package\";s:8:\"Variable\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:3:{i:0;s:51:\"includes/views_plugin_argument_default_variable.inc\";i:1;s:47:\"includes/views_handler_field_variable_title.inc\";i:2;s:47:\"includes/views_handler_field_variable_value.inc\";}s:7:\"version\";s:7:\"7.x-2.5\";s:7:\"project\";s:8:\"variable\";s:9:\"datestamp\";s:10:\"1398250128\";s:5:\"mtime\";i:1542781025;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/views/tests/views_test.module','views_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Views Test\";s:11:\"description\";s:22:\"Test module for Views.\";s:7:\"package\";s:5:\"Views\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"views\";}s:6:\"hidden\";b:1;s:7:\"version\";s:8:\"7.x-3.13\";s:7:\"project\";s:5:\"views\";s:9:\"datestamp\";s:10:\"1446804876\";s:5:\"mtime\";i:1542781029;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/views/views.module','views','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:5:\"Views\";s:11:\"description\";s:55:\"Create customized lists and queries from your database.\";s:7:\"package\";s:5:\"Views\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:3:\"5.2\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:13:\"css/views.css\";s:37:\"sites/all/modules/views/css/views.css\";}}s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:5:\"files\";a:303:{i:0;s:31:\"handlers/views_handler_area.inc\";i:1;s:40:\"handlers/views_handler_area_messages.inc\";i:2;s:38:\"handlers/views_handler_area_result.inc\";i:3;s:36:\"handlers/views_handler_area_text.inc\";i:4;s:43:\"handlers/views_handler_area_text_custom.inc\";i:5;s:36:\"handlers/views_handler_area_view.inc\";i:6;s:35:\"handlers/views_handler_argument.inc\";i:7;s:40:\"handlers/views_handler_argument_date.inc\";i:8;s:43:\"handlers/views_handler_argument_formula.inc\";i:9;s:47:\"handlers/views_handler_argument_many_to_one.inc\";i:10;s:40:\"handlers/views_handler_argument_null.inc\";i:11;s:43:\"handlers/views_handler_argument_numeric.inc\";i:12;s:42:\"handlers/views_handler_argument_string.inc\";i:13;s:52:\"handlers/views_handler_argument_group_by_numeric.inc\";i:14;s:32:\"handlers/views_handler_field.inc\";i:15;s:40:\"handlers/views_handler_field_counter.inc\";i:16;s:40:\"handlers/views_handler_field_boolean.inc\";i:17;s:49:\"handlers/views_handler_field_contextual_links.inc\";i:18;s:39:\"handlers/views_handler_field_custom.inc\";i:19;s:37:\"handlers/views_handler_field_date.inc\";i:20;s:39:\"handlers/views_handler_field_entity.inc\";i:21;s:39:\"handlers/views_handler_field_markup.inc\";i:22;s:37:\"handlers/views_handler_field_math.inc\";i:23;s:40:\"handlers/views_handler_field_numeric.inc\";i:24;s:47:\"handlers/views_handler_field_prerender_list.inc\";i:25;s:46:\"handlers/views_handler_field_time_interval.inc\";i:26;s:43:\"handlers/views_handler_field_serialized.inc\";i:27;s:45:\"handlers/views_handler_field_machine_name.inc\";i:28;s:36:\"handlers/views_handler_field_url.inc\";i:29;s:33:\"handlers/views_handler_filter.inc\";i:30;s:50:\"handlers/views_handler_filter_boolean_operator.inc\";i:31;s:57:\"handlers/views_handler_filter_boolean_operator_string.inc\";i:32;s:41:\"handlers/views_handler_filter_combine.inc\";i:33;s:38:\"handlers/views_handler_filter_date.inc\";i:34;s:42:\"handlers/views_handler_filter_equality.inc\";i:35;s:47:\"handlers/views_handler_filter_entity_bundle.inc\";i:36;s:50:\"handlers/views_handler_filter_group_by_numeric.inc\";i:37;s:45:\"handlers/views_handler_filter_in_operator.inc\";i:38;s:45:\"handlers/views_handler_filter_many_to_one.inc\";i:39;s:41:\"handlers/views_handler_filter_numeric.inc\";i:40;s:40:\"handlers/views_handler_filter_string.inc\";i:41;s:48:\"handlers/views_handler_filter_fields_compare.inc\";i:42;s:39:\"handlers/views_handler_relationship.inc\";i:43;s:53:\"handlers/views_handler_relationship_groupwise_max.inc\";i:44;s:31:\"handlers/views_handler_sort.inc\";i:45;s:36:\"handlers/views_handler_sort_date.inc\";i:46;s:39:\"handlers/views_handler_sort_formula.inc\";i:47;s:48:\"handlers/views_handler_sort_group_by_numeric.inc\";i:48;s:46:\"handlers/views_handler_sort_menu_hierarchy.inc\";i:49;s:38:\"handlers/views_handler_sort_random.inc\";i:50;s:17:\"includes/base.inc\";i:51;s:21:\"includes/handlers.inc\";i:52;s:20:\"includes/plugins.inc\";i:53;s:17:\"includes/view.inc\";i:54;s:60:\"modules/aggregator/views_handler_argument_aggregator_fid.inc\";i:55;s:60:\"modules/aggregator/views_handler_argument_aggregator_iid.inc\";i:56;s:69:\"modules/aggregator/views_handler_argument_aggregator_category_cid.inc\";i:57;s:64:\"modules/aggregator/views_handler_field_aggregator_title_link.inc\";i:58;s:62:\"modules/aggregator/views_handler_field_aggregator_category.inc\";i:59;s:70:\"modules/aggregator/views_handler_field_aggregator_item_description.inc\";i:60;s:57:\"modules/aggregator/views_handler_field_aggregator_xss.inc\";i:61;s:67:\"modules/aggregator/views_handler_filter_aggregator_category_cid.inc\";i:62;s:54:\"modules/aggregator/views_plugin_row_aggregator_rss.inc\";i:63;s:56:\"modules/book/views_plugin_argument_default_book_root.inc\";i:64;s:59:\"modules/comment/views_handler_argument_comment_user_uid.inc\";i:65;s:47:\"modules/comment/views_handler_field_comment.inc\";i:66;s:53:\"modules/comment/views_handler_field_comment_depth.inc\";i:67;s:52:\"modules/comment/views_handler_field_comment_link.inc\";i:68;s:60:\"modules/comment/views_handler_field_comment_link_approve.inc\";i:69;s:59:\"modules/comment/views_handler_field_comment_link_delete.inc\";i:70;s:57:\"modules/comment/views_handler_field_comment_link_edit.inc\";i:71;s:58:\"modules/comment/views_handler_field_comment_link_reply.inc\";i:72;s:57:\"modules/comment/views_handler_field_comment_node_link.inc\";i:73;s:56:\"modules/comment/views_handler_field_comment_username.inc\";i:74;s:61:\"modules/comment/views_handler_field_ncs_last_comment_name.inc\";i:75;s:56:\"modules/comment/views_handler_field_ncs_last_updated.inc\";i:76;s:52:\"modules/comment/views_handler_field_node_comment.inc\";i:77;s:57:\"modules/comment/views_handler_field_node_new_comments.inc\";i:78;s:62:\"modules/comment/views_handler_field_last_comment_timestamp.inc\";i:79;s:57:\"modules/comment/views_handler_filter_comment_user_uid.inc\";i:80;s:57:\"modules/comment/views_handler_filter_ncs_last_updated.inc\";i:81;s:53:\"modules/comment/views_handler_filter_node_comment.inc\";i:82;s:53:\"modules/comment/views_handler_sort_comment_thread.inc\";i:83;s:60:\"modules/comment/views_handler_sort_ncs_last_comment_name.inc\";i:84;s:55:\"modules/comment/views_handler_sort_ncs_last_updated.inc\";i:85;s:48:\"modules/comment/views_plugin_row_comment_rss.inc\";i:86;s:49:\"modules/comment/views_plugin_row_comment_view.inc\";i:87;s:52:\"modules/contact/views_handler_field_contact_link.inc\";i:88;s:43:\"modules/field/views_handler_field_field.inc\";i:89;s:59:\"modules/field/views_handler_relationship_entity_reverse.inc\";i:90;s:51:\"modules/field/views_handler_argument_field_list.inc\";i:91;s:57:\"modules/field/views_handler_filter_field_list_boolean.inc\";i:92;s:58:\"modules/field/views_handler_argument_field_list_string.inc\";i:93;s:49:\"modules/field/views_handler_filter_field_list.inc\";i:94;s:57:\"modules/filter/views_handler_field_filter_format_name.inc\";i:95;s:52:\"modules/locale/views_handler_field_node_language.inc\";i:96;s:53:\"modules/locale/views_handler_filter_node_language.inc\";i:97;s:54:\"modules/locale/views_handler_argument_locale_group.inc\";i:98;s:57:\"modules/locale/views_handler_argument_locale_language.inc\";i:99;s:51:\"modules/locale/views_handler_field_locale_group.inc\";i:100;s:54:\"modules/locale/views_handler_field_locale_language.inc\";i:101;s:55:\"modules/locale/views_handler_field_locale_link_edit.inc\";i:102;s:52:\"modules/locale/views_handler_filter_locale_group.inc\";i:103;s:55:\"modules/locale/views_handler_filter_locale_language.inc\";i:104;s:54:\"modules/locale/views_handler_filter_locale_version.inc\";i:105;s:53:\"modules/node/views_handler_argument_dates_various.inc\";i:106;s:53:\"modules/node/views_handler_argument_node_language.inc\";i:107;s:48:\"modules/node/views_handler_argument_node_nid.inc\";i:108;s:49:\"modules/node/views_handler_argument_node_type.inc\";i:109;s:48:\"modules/node/views_handler_argument_node_vid.inc\";i:110;s:57:\"modules/node/views_handler_argument_node_uid_revision.inc\";i:111;s:59:\"modules/node/views_handler_field_history_user_timestamp.inc\";i:112;s:41:\"modules/node/views_handler_field_node.inc\";i:113;s:46:\"modules/node/views_handler_field_node_link.inc\";i:114;s:53:\"modules/node/views_handler_field_node_link_delete.inc\";i:115;s:51:\"modules/node/views_handler_field_node_link_edit.inc\";i:116;s:50:\"modules/node/views_handler_field_node_revision.inc\";i:117;s:55:\"modules/node/views_handler_field_node_revision_link.inc\";i:118;s:62:\"modules/node/views_handler_field_node_revision_link_delete.inc\";i:119;s:62:\"modules/node/views_handler_field_node_revision_link_revert.inc\";i:120;s:46:\"modules/node/views_handler_field_node_path.inc\";i:121;s:46:\"modules/node/views_handler_field_node_type.inc\";i:122;s:60:\"modules/node/views_handler_filter_history_user_timestamp.inc\";i:123;s:49:\"modules/node/views_handler_filter_node_access.inc\";i:124;s:49:\"modules/node/views_handler_filter_node_status.inc\";i:125;s:47:\"modules/node/views_handler_filter_node_type.inc\";i:126;s:55:\"modules/node/views_handler_filter_node_uid_revision.inc\";i:127;s:51:\"modules/node/views_plugin_argument_default_node.inc\";i:128;s:52:\"modules/node/views_plugin_argument_validate_node.inc\";i:129;s:42:\"modules/node/views_plugin_row_node_rss.inc\";i:130;s:43:\"modules/node/views_plugin_row_node_view.inc\";i:131;s:52:\"modules/profile/views_handler_field_profile_date.inc\";i:132;s:52:\"modules/profile/views_handler_field_profile_list.inc\";i:133;s:58:\"modules/profile/views_handler_filter_profile_selection.inc\";i:134;s:48:\"modules/search/views_handler_argument_search.inc\";i:135;s:51:\"modules/search/views_handler_field_search_score.inc\";i:136;s:46:\"modules/search/views_handler_filter_search.inc\";i:137;s:50:\"modules/search/views_handler_sort_search_score.inc\";i:138;s:47:\"modules/search/views_plugin_row_search_view.inc\";i:139;s:57:\"modules/statistics/views_handler_field_accesslog_path.inc\";i:140;s:50:\"modules/system/views_handler_argument_file_fid.inc\";i:141;s:43:\"modules/system/views_handler_field_file.inc\";i:142;s:53:\"modules/system/views_handler_field_file_extension.inc\";i:143;s:52:\"modules/system/views_handler_field_file_filemime.inc\";i:144;s:47:\"modules/system/views_handler_field_file_uri.inc\";i:145;s:50:\"modules/system/views_handler_field_file_status.inc\";i:146;s:51:\"modules/system/views_handler_filter_file_status.inc\";i:147;s:52:\"modules/taxonomy/views_handler_argument_taxonomy.inc\";i:148;s:57:\"modules/taxonomy/views_handler_argument_term_node_tid.inc\";i:149;s:63:\"modules/taxonomy/views_handler_argument_term_node_tid_depth.inc\";i:150;s:72:\"modules/taxonomy/views_handler_argument_term_node_tid_depth_modifier.inc\";i:151;s:58:\"modules/taxonomy/views_handler_argument_vocabulary_vid.inc\";i:152;s:67:\"modules/taxonomy/views_handler_argument_vocabulary_machine_name.inc\";i:153;s:49:\"modules/taxonomy/views_handler_field_taxonomy.inc\";i:154;s:54:\"modules/taxonomy/views_handler_field_term_node_tid.inc\";i:155;s:55:\"modules/taxonomy/views_handler_field_term_link_edit.inc\";i:156;s:55:\"modules/taxonomy/views_handler_filter_term_node_tid.inc\";i:157;s:61:\"modules/taxonomy/views_handler_filter_term_node_tid_depth.inc\";i:158;s:56:\"modules/taxonomy/views_handler_filter_vocabulary_vid.inc\";i:159;s:65:\"modules/taxonomy/views_handler_filter_vocabulary_machine_name.inc\";i:160;s:62:\"modules/taxonomy/views_handler_relationship_node_term_data.inc\";i:161;s:65:\"modules/taxonomy/views_plugin_argument_validate_taxonomy_term.inc\";i:162;s:63:\"modules/taxonomy/views_plugin_argument_default_taxonomy_tid.inc\";i:163;s:67:\"modules/tracker/views_handler_argument_tracker_comment_user_uid.inc\";i:164;s:65:\"modules/tracker/views_handler_filter_tracker_comment_user_uid.inc\";i:165;s:65:\"modules/tracker/views_handler_filter_tracker_boolean_operator.inc\";i:166;s:51:\"modules/system/views_handler_filter_system_type.inc\";i:167;s:56:\"modules/translation/views_handler_argument_node_tnid.inc\";i:168;s:63:\"modules/translation/views_handler_field_node_link_translate.inc\";i:169;s:65:\"modules/translation/views_handler_field_node_translation_link.inc\";i:170;s:54:\"modules/translation/views_handler_filter_node_tnid.inc\";i:171;s:60:\"modules/translation/views_handler_filter_node_tnid_child.inc\";i:172;s:62:\"modules/translation/views_handler_relationship_translation.inc\";i:173;s:48:\"modules/user/views_handler_argument_user_uid.inc\";i:174;s:55:\"modules/user/views_handler_argument_users_roles_rid.inc\";i:175;s:41:\"modules/user/views_handler_field_user.inc\";i:176;s:50:\"modules/user/views_handler_field_user_language.inc\";i:177;s:46:\"modules/user/views_handler_field_user_link.inc\";i:178;s:53:\"modules/user/views_handler_field_user_link_cancel.inc\";i:179;s:51:\"modules/user/views_handler_field_user_link_edit.inc\";i:180;s:46:\"modules/user/views_handler_field_user_mail.inc\";i:181;s:46:\"modules/user/views_handler_field_user_name.inc\";i:182;s:53:\"modules/user/views_handler_field_user_permissions.inc\";i:183;s:49:\"modules/user/views_handler_field_user_picture.inc\";i:184;s:47:\"modules/user/views_handler_field_user_roles.inc\";i:185;s:50:\"modules/user/views_handler_filter_user_current.inc\";i:186;s:47:\"modules/user/views_handler_filter_user_name.inc\";i:187;s:54:\"modules/user/views_handler_filter_user_permissions.inc\";i:188;s:48:\"modules/user/views_handler_filter_user_roles.inc\";i:189;s:59:\"modules/user/views_plugin_argument_default_current_user.inc\";i:190;s:51:\"modules/user/views_plugin_argument_default_user.inc\";i:191;s:52:\"modules/user/views_plugin_argument_validate_user.inc\";i:192;s:43:\"modules/user/views_plugin_row_user_view.inc\";i:193;s:31:\"plugins/views_plugin_access.inc\";i:194;s:36:\"plugins/views_plugin_access_none.inc\";i:195;s:36:\"plugins/views_plugin_access_perm.inc\";i:196;s:36:\"plugins/views_plugin_access_role.inc\";i:197;s:41:\"plugins/views_plugin_argument_default.inc\";i:198;s:45:\"plugins/views_plugin_argument_default_php.inc\";i:199;s:47:\"plugins/views_plugin_argument_default_fixed.inc\";i:200;s:45:\"plugins/views_plugin_argument_default_raw.inc\";i:201;s:42:\"plugins/views_plugin_argument_validate.inc\";i:202;s:50:\"plugins/views_plugin_argument_validate_numeric.inc\";i:203;s:46:\"plugins/views_plugin_argument_validate_php.inc\";i:204;s:30:\"plugins/views_plugin_cache.inc\";i:205;s:35:\"plugins/views_plugin_cache_none.inc\";i:206;s:35:\"plugins/views_plugin_cache_time.inc\";i:207;s:32:\"plugins/views_plugin_display.inc\";i:208;s:43:\"plugins/views_plugin_display_attachment.inc\";i:209;s:38:\"plugins/views_plugin_display_block.inc\";i:210;s:40:\"plugins/views_plugin_display_default.inc\";i:211;s:38:\"plugins/views_plugin_display_embed.inc\";i:212;s:41:\"plugins/views_plugin_display_extender.inc\";i:213;s:37:\"plugins/views_plugin_display_feed.inc\";i:214;s:37:\"plugins/views_plugin_display_page.inc\";i:215;s:43:\"plugins/views_plugin_exposed_form_basic.inc\";i:216;s:37:\"plugins/views_plugin_exposed_form.inc\";i:217;s:52:\"plugins/views_plugin_exposed_form_input_required.inc\";i:218;s:42:\"plugins/views_plugin_localization_core.inc\";i:219;s:37:\"plugins/views_plugin_localization.inc\";i:220;s:42:\"plugins/views_plugin_localization_none.inc\";i:221;s:30:\"plugins/views_plugin_pager.inc\";i:222;s:35:\"plugins/views_plugin_pager_full.inc\";i:223;s:35:\"plugins/views_plugin_pager_mini.inc\";i:224;s:35:\"plugins/views_plugin_pager_none.inc\";i:225;s:35:\"plugins/views_plugin_pager_some.inc\";i:226;s:30:\"plugins/views_plugin_query.inc\";i:227;s:38:\"plugins/views_plugin_query_default.inc\";i:228;s:28:\"plugins/views_plugin_row.inc\";i:229;s:35:\"plugins/views_plugin_row_fields.inc\";i:230;s:39:\"plugins/views_plugin_row_rss_fields.inc\";i:231;s:30:\"plugins/views_plugin_style.inc\";i:232;s:38:\"plugins/views_plugin_style_default.inc\";i:233;s:35:\"plugins/views_plugin_style_grid.inc\";i:234;s:35:\"plugins/views_plugin_style_list.inc\";i:235;s:40:\"plugins/views_plugin_style_jump_menu.inc\";i:236;s:38:\"plugins/views_plugin_style_mapping.inc\";i:237;s:34:\"plugins/views_plugin_style_rss.inc\";i:238;s:38:\"plugins/views_plugin_style_summary.inc\";i:239;s:48:\"plugins/views_plugin_style_summary_jump_menu.inc\";i:240;s:50:\"plugins/views_plugin_style_summary_unformatted.inc\";i:241;s:36:\"plugins/views_plugin_style_table.inc\";i:242;s:34:\"tests/handlers/views_handlers.test\";i:243;s:43:\"tests/handlers/views_handler_area_text.test\";i:244;s:47:\"tests/handlers/views_handler_argument_null.test\";i:245;s:49:\"tests/handlers/views_handler_argument_string.test\";i:246;s:39:\"tests/handlers/views_handler_field.test\";i:247;s:47:\"tests/handlers/views_handler_field_boolean.test\";i:248;s:46:\"tests/handlers/views_handler_field_custom.test\";i:249;s:47:\"tests/handlers/views_handler_field_counter.test\";i:250;s:44:\"tests/handlers/views_handler_field_date.test\";i:251;s:54:\"tests/handlers/views_handler_field_file_extension.test\";i:252;s:49:\"tests/handlers/views_handler_field_file_size.test\";i:253;s:44:\"tests/handlers/views_handler_field_math.test\";i:254;s:43:\"tests/handlers/views_handler_field_url.test\";i:255;s:43:\"tests/handlers/views_handler_field_xss.test\";i:256;s:48:\"tests/handlers/views_handler_filter_combine.test\";i:257;s:45:\"tests/handlers/views_handler_filter_date.test\";i:258;s:49:\"tests/handlers/views_handler_filter_equality.test\";i:259;s:52:\"tests/handlers/views_handler_filter_in_operator.test\";i:260;s:48:\"tests/handlers/views_handler_filter_numeric.test\";i:261;s:47:\"tests/handlers/views_handler_filter_string.test\";i:262;s:45:\"tests/handlers/views_handler_sort_random.test\";i:263;s:43:\"tests/handlers/views_handler_sort_date.test\";i:264;s:38:\"tests/handlers/views_handler_sort.test\";i:265;s:46:\"tests/test_handlers/views_test_area_access.inc\";i:266;s:60:\"tests/test_plugins/views_test_plugin_access_test_dynamic.inc\";i:267;s:59:\"tests/test_plugins/views_test_plugin_access_test_static.inc\";i:268;s:59:\"tests/test_plugins/views_test_plugin_style_test_mapping.inc\";i:269;s:39:\"tests/plugins/views_plugin_display.test\";i:270;s:46:\"tests/styles/views_plugin_style_jump_menu.test\";i:271;s:36:\"tests/styles/views_plugin_style.test\";i:272;s:41:\"tests/styles/views_plugin_style_base.test\";i:273;s:44:\"tests/styles/views_plugin_style_mapping.test\";i:274;s:48:\"tests/styles/views_plugin_style_unformatted.test\";i:275;s:23:\"tests/views_access.test\";i:276;s:24:\"tests/views_analyze.test\";i:277;s:22:\"tests/views_basic.test\";i:278;s:33:\"tests/views_argument_default.test\";i:279;s:35:\"tests/views_argument_validator.test\";i:280;s:29:\"tests/views_exposed_form.test\";i:281;s:31:\"tests/field/views_fieldapi.test\";i:282;s:25:\"tests/views_glossary.test\";i:283;s:24:\"tests/views_groupby.test\";i:284;s:25:\"tests/views_handlers.test\";i:285;s:23:\"tests/views_module.test\";i:286;s:22:\"tests/views_pager.test\";i:287;s:40:\"tests/views_plugin_localization_test.inc\";i:288;s:29:\"tests/views_translatable.test\";i:289;s:22:\"tests/views_query.test\";i:290;s:24:\"tests/views_upgrade.test\";i:291;s:34:\"tests/views_test.views_default.inc\";i:292;s:58:\"tests/comment/views_handler_argument_comment_user_uid.test\";i:293;s:56:\"tests/comment/views_handler_filter_comment_user_uid.test\";i:294;s:45:\"tests/node/views_node_revision_relations.test\";i:295;s:61:\"tests/taxonomy/views_handler_relationship_node_term_data.test\";i:296;s:45:\"tests/user/views_handler_field_user_name.test\";i:297;s:43:\"tests/user/views_user_argument_default.test\";i:298;s:44:\"tests/user/views_user_argument_validate.test\";i:299;s:26:\"tests/user/views_user.test\";i:300;s:22:\"tests/views_cache.test\";i:301;s:21:\"tests/views_view.test\";i:302;s:19:\"tests/views_ui.test\";}s:7:\"version\";s:8:\"7.x-3.13\";s:7:\"project\";s:5:\"views\";s:9:\"datestamp\";s:10:\"1446804876\";s:5:\"mtime\";i:1542781029;s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/views/views_ui.module','views_ui','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:8:\"Views UI\";s:11:\"description\";s:93:\"Administrative interface to views. Without this module, you cannot create or edit your views.\";s:7:\"package\";s:5:\"Views\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:21:\"admin/structure/views\";s:12:\"dependencies\";a:1:{i:0;s:5:\"views\";}s:5:\"files\";a:2:{i:0;s:15:\"views_ui.module\";i:1;s:57:\"plugins/views_wizard/views_ui_base_views_wizard.class.php\";}s:7:\"version\";s:8:\"7.x-3.13\";s:7:\"project\";s:5:\"views\";s:9:\"datestamp\";s:10:\"1446804876\";s:5:\"mtime\";i:1542781029;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/votingapi/votingapi.module','votingapi','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Voting API\";s:11:\"description\";s:47:\"Provides a shared voting API for other modules.\";s:7:\"package\";s:6:\"Voting\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:29:\"admin/config/search/votingapi\";s:5:\"files\";a:4:{i:0;s:20:\"tests/votingapi.test\";i:1;s:45:\"views/votingapi_views_handler_field_value.inc\";i:2;s:47:\"views/votingapi_views_handler_sort_nullable.inc\";i:3;s:46:\"views/votingapi_views_handler_relationship.inc\";}s:7:\"version\";s:8:\"7.x-2.12\";s:7:\"project\";s:9:\"votingapi\";s:9:\"datestamp\";s:10:\"1407995929\";s:5:\"mtime\";i:1542781029;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}'),
('sites/all/modules/wweave/wweave.module','wweave','module','',1,1,0,0,'a:11:{s:4:\"name\";s:6:\"wweave\";s:11:\"description\";s:36:\"Drupal and Ofbiz Integration module.\";s:7:\"package\";s:6:\"Sonata\";s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:7:\"7.x-1.0\";s:7:\"project\";s:6:\"wweave\";s:5:\"mtime\";i:1549343425;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}'),
('sites/all/themes/wweave/wweave.info','wweave','theme','themes/engines/phptemplate/phptemplate.engine',1,1,0,0,'a:15:{s:4:\"name\";s:6:\"wweave\";s:11:\"description\";s:29:\"A flexible, responsive theme.\";s:7:\"version\";s:7:\"7.x-1.0\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:4:{s:21:\"css/bootstrap.min.css\";s:45:\"sites/all/themes/wweave/css/bootstrap.min.css\";s:17:\"css/ww_styles.css\";s:41:\"sites/all/themes/wweave/css/ww_styles.css\";s:18:\"css/responsive.css\";s:42:\"sites/all/themes/wweave/css/responsive.css\";s:15:\"css/mdb.min.css\";s:39:\"sites/all/themes/wweave/css/mdb.min.css\";}}s:7:\"scripts\";a:4:{s:16:\"js/jquery.min.js\";s:40:\"sites/all/themes/wweave/js/jquery.min.js\";s:19:\"js/bootstrap.min.js\";s:43:\"sites/all/themes/wweave/js/bootstrap.min.js\";s:10:\"js/main.js\";s:34:\"sites/all/themes/wweave/js/main.js\";s:33:\"js/material-components-web.min.js\";s:57:\"sites/all/themes/wweave/js/material-components-web.min.js\";}s:7:\"regions\";a:6:{s:7:\"content\";s:7:\"Content\";s:21:\"search_filter_sidebar\";s:21:\"Search Filter Sidebar\";s:14:\"social_sharing\";s:14:\"Social Sharing\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:38:\"sites/all/themes/wweave/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"mtime\";i:1549344031;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}'),
('themes/bartik/bartik.info','bartik','theme','themes/engines/phptemplate/phptemplate.engine',1,0,-1,0,'a:19:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}'),
('themes/garland/garland.info','garland','theme','themes/engines/phptemplate/phptemplate.engine',0,0,-1,0,'a:19:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}'),
('themes/seven/seven.info','seven','theme','themes/engines/phptemplate/phptemplate.engine',1,0,-1,0,'a:19:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}'),
('themes/stark/stark.info','stark','theme','themes/engines/phptemplate/phptemplate.engine',0,0,-1,0,'a:18:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.63\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1547681965\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1547662166;s:15:\"overlay_regions\";a:3:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');

UNLOCK TABLES;

/*Table structure for table `url_alias` */

DROP TABLE IF EXISTS `url_alias`;

CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';

/*Data for the table `url_alias` */

LOCK TABLES `url_alias` WRITE;

UNLOCK TABLES;

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`),
  KEY `picture` (`picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';

/*Data for the table `users` */

LOCK TABLES `users` WRITE;

insert  into `users`(`uid`,`name`,`pass`,`mail`,`theme`,`signature`,`signature_format`,`created`,`access`,`login`,`status`,`timezone`,`language`,`picture`,`init`,`data`) values 
(0,'','','','','',NULL,0,0,0,0,NULL,'',0,'',NULL),
(1,'admin','$S$DL1exr.5fvDqxBKUMnI8QRJ8kUp5ckuoZiSsUC/WoWoceRfrkU1n','kiran.chaitanya@sonata-software.com','','',NULL,1534402327,1549344416,1549337611,1,'Asia/Kolkata','',0,'kiran.chaitanya@sonata-software.com','b:0;');

UNLOCK TABLES;

/*Table structure for table `users_roles` */

DROP TABLE IF EXISTS `users_roles`;

CREATE TABLE `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';

/*Data for the table `users_roles` */

LOCK TABLES `users_roles` WRITE;

UNLOCK TABLES;

/*Table structure for table `variable` */

DROP TABLE IF EXISTS `variable`;

CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';

/*Data for the table `variable` */

LOCK TABLES `variable` WRITE;

insert  into `variable`(`name`,`value`) values 
('apachesolr_search_mlt_blocks','a:1:{s:7:\"mlt-001\";a:12:{s:4:\"name\";s:14:\"More like this\";s:11:\"num_results\";s:1:\"5\";s:6:\"mlt_fl\";a:2:{s:5:\"label\";s:5:\"label\";s:14:\"taxonomy_names\";s:14:\"taxonomy_names\";}s:10:\"mlt_env_id\";s:4:\"solr\";s:9:\"mlt_mintf\";s:1:\"1\";s:9:\"mlt_mindf\";s:1:\"1\";s:9:\"mlt_minwl\";s:1:\"3\";s:9:\"mlt_maxwl\";s:2:\"15\";s:9:\"mlt_maxqt\";s:2:\"20\";s:16:\"mlt_type_filters\";a:0:{}s:18:\"mlt_custom_filters\";s:0:\"\";s:5:\"delta\";s:7:\"mlt-001\";}}'),
('clean_url','s:1:\"1\";'),
('cron_key','s:43:\"M9aw5PTipLKsVk-QR5tu5WGaKohkcxQ6_MUYI8ZGpK0\";'),
('cron_last','i:1549344416;'),
('css_js_query_string','s:6:\"pmftq1\";'),
('date_default_timezone','s:12:\"Asia/Kolkata\";'),
('drupal_http_request_fails','b:0;'),
('drupal_private_key','s:43:\"hNJvJ3IdfbX53Ip9-gJIk6KMzzAI7wv2iyMzJcRBu3U\";'),
('file_temporary_path','s:12:\"C:\\xampp\\tmp\";'),
('filter_fallback_format','s:10:\"plain_text\";'),
('install_profile','s:7:\"minimal\";'),
('install_task','s:4:\"done\";'),
('install_time','i:1534403387;'),
('javascript_parsed','a:19:{i:0;s:14:\"misc/drupal.js\";i:1;s:14:\"misc/jquery.js\";i:2;s:19:\"misc/jquery.once.js\";i:3;s:40:\"sites/all/themes/wweave/js/jquery.min.js\";i:4;s:43:\"sites/all/themes/wweave/js/bootstrap.min.js\";i:5;s:34:\"sites/all/themes/wweave/js/main.js\";i:6;s:57:\"sites/all/themes/wweave/js/material-components-web.min.js\";i:7;s:55:\"sites/all/modules/admin_menu/admin_devel/admin_devel.js\";i:8;s:43:\"sites/all/modules/devel/devel_krumo_path.js\";i:9;s:24:\"modules/system/system.js\";i:10;s:12:\"misc/form.js\";i:11;s:21:\"misc/jquery.cookie.js\";i:12;s:26:\"modules/toolbar/toolbar.js\";i:13;s:29:\"misc/ui/jquery.ui.core.min.js\";i:14;s:31:\"misc/ui/jquery.ui.widget.min.js\";i:15;s:30:\"misc/ui/jquery.ui.mouse.min.js\";i:16;s:33:\"misc/ui/jquery.ui.sortable.min.js\";i:17;s:30:\"modules/dashboard/dashboard.js\";i:18;s:19:\"misc/tableheader.js\";}'),
('language_negotiation_language','a:0:{}'),
('language_negotiation_language_content','a:1:{s:16:\"locale-interface\";a:2:{s:9:\"callbacks\";a:1:{s:8:\"language\";s:30:\"locale_language_from_interface\";}s:4:\"file\";s:19:\"includes/locale.inc\";}}'),
('language_negotiation_language_url','a:2:{s:10:\"locale-url\";a:2:{s:9:\"callbacks\";a:3:{s:8:\"language\";s:24:\"locale_language_from_url\";s:8:\"switcher\";s:28:\"locale_language_switcher_url\";s:11:\"url_rewrite\";s:31:\"locale_language_url_rewrite_url\";}s:4:\"file\";s:19:\"includes/locale.inc\";}s:19:\"locale-url-fallback\";a:2:{s:9:\"callbacks\";a:1:{s:8:\"language\";s:28:\"locale_language_url_fallback\";}s:4:\"file\";s:19:\"includes/locale.inc\";}}'),
('language_types','a:3:{s:8:\"language\";b:1;s:16:\"language_content\";b:0;s:12:\"language_url\";b:0;}'),
('menu_expanded','a:0:{}'),
('menu_masks','a:31:{i:0;i:503;i:1;i:501;i:2;i:251;i:3;i:250;i:4;i:245;i:5;i:127;i:6;i:125;i:7;i:123;i:8;i:122;i:9;i:121;i:10;i:63;i:11;i:62;i:12;i:61;i:13;i:60;i:14;i:58;i:15;i:44;i:16;i:31;i:17;i:30;i:18;i:29;i:19;i:28;i:20;i:24;i:21;i:21;i:22;i:15;i:23;i:14;i:24;i:11;i:25;i:7;i:26;i:6;i:27;i:5;i:28;i:3;i:29;i:2;i:30;i:1;}'),
('path_alias_whitelist','a:0:{}'),
('site_default_country','s:2:\"IN\";'),
('site_mail','s:35:\"kiran.chaitanya@sonata-software.com\";'),
('site_name','s:9:\"localhost\";'),
('theme_default','s:6:\"bartik\";'),
('update_last_check','i:1549344422;'),
('update_notify_emails','a:1:{i:0;s:35:\"kiran.chaitanya@sonata-software.com\";}'),
('user_register','i:2;');

UNLOCK TABLES;

/*Table structure for table `watchdog` */

DROP TABLE IF EXISTS `watchdog`;

CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`),
  KEY `severity` (`severity`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';

/*Data for the table `watchdog` */

LOCK TABLES `watchdog` WRITE;

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
