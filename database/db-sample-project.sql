USE grafana;

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `doc` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `active` varchar(255) DEFAULT NULL,
  `createdAt` datetime,
  `updatedAt` datetime,
  `deletedAt` datetime,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `purchases` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `product` varchar(255) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `quantity` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `createdAt` datetime,
  `updatedAt` datetime,
  `deletedAt` datetime,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

