ALTER TABLE `owned_vehicles` ADD COLUMN `neons` int(1) NOT NULL DEFAULT '0';

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('neonbox', 'Neon Box', 1, 0, 1),
	('neoncontroller', 'Neon Controller', 1, 0, 1);