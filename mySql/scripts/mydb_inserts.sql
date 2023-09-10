

CREATE TABLE IF NOT EXISTS `Ingredients` (
  `ingredients_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ingredients_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT IGNORE INTO Ingredients (ingredients_id, name) VALUES
 (0, 'tomates'),
 (1, 'aubergines');
 

CREATE TABLE IF NOT EXISTS `customers` (
  `id_customers` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_customers`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
 INSERT IGNORE INTO customers (id_customers, name) VALUES
 (0, 'Daniel'),
 (1, 'Jeremy'); 



CREATE TABLE IF NOT EXISTS `pizzerias` (
  `pizzeria_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`pizzeria_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
 INSERT IGNORE INTO pizzerias (pizzeria_id, name) VALUES
 (0, 'Awesome pizza'),
 (1, 'That pizza');
 

CREATE TABLE IF NOT EXISTS `inventory` (
  `inventory_id` int NOT NULL,
  `ingredients_id` int DEFAULT NULL,
  `pizzerias_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `pizzerias_key_id` (`pizzerias_id`),
  KEY `ingredients_key_idx` (`ingredients_id`),
  CONSTRAINT `ingredients_key` FOREIGN KEY (`ingredients_id`) REFERENCES `Ingredients` (`ingredients_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pizzerias_key` FOREIGN KEY (`pizzerias_id`) REFERENCES `pizzerias` (`pizzeria_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
 INSERT IGNORE INTO inventory (inventory_id, ingredients_id, pizzerias_id, quantity) VALUES
 (0, 0, 0, 5),
 (1, 1, 1, 5);
 

CREATE TABLE IF NOT EXISTS `pizzas` (
  `pizzas_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `creationTimestamp` datetime DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`pizzas_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
 INSERT IGNORE INTO pizzas (pizzas_id, name, price) VALUES
 (0, 'Four cheese', 35),
 (1, 'Andalouse', 35);
 

CREATE TABLE IF NOT EXISTS `pizzaiolos` (
  `pizzaiolos_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `pizzerias_id` int DEFAULT NULL,
  PRIMARY KEY (`pizzaiolos_id`),
  KEY `pizzerias_key_idx` (`pizzerias_id`),
  CONSTRAINT `pizzerias_pizzaiolos_key` FOREIGN KEY (`pizzerias_id`) REFERENCES `pizzerias` (`pizzeria_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
 INSERT IGNORE INTO pizzaiolos (pizzaiolos_id, pizzerias_id, name) VALUES
 (0, 0, "Jordan"),
 (1, 0, "Romain");
 

CREATE TABLE IF NOT EXISTS `Menu` (
  `menu_id` int NOT NULL,
  `pizzas_id` int DEFAULT NULL,
  `pizzerias_id` int DEFAULT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `menu_key_idx` (`pizzas_id`),
  KEY `menu_pizzerias_idx` (`pizzerias_id`),
  CONSTRAINT `menu_pizzas` FOREIGN KEY (`pizzas_id`) REFERENCES `pizzas` (`pizzas_id`),
  CONSTRAINT `menu_pizzerias` FOREIGN KEY (`pizzerias_id`) REFERENCES `pizzerias` (`pizzeria_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT IGNORE INTO Menu (menu_id, pizzas_id, pizzerias_id) VALUES
 (0, 0, 0),
 (1, 1, 1);
 

CREATE TABLE IF NOT EXISTS `Recettes` (
  `recette_id` int NOT NULL,
  `pizzas_id` int DEFAULT NULL,
  `ingredients_id` int DEFAULT NULL,
  `quantity` float DEFAULT NULL,
  `unit` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`recette_id`),
  KEY `pizzas_id_idx` (`pizzas_id`),
  KEY `ingredients_id_idx` (`ingredients_id`),
  CONSTRAINT `recette_ingredients_id` FOREIGN KEY (`ingredients_id`) REFERENCES `Ingredients` (`ingredients_id`),
  CONSTRAINT `recette_pizzas_id` FOREIGN KEY (`pizzas_id`) REFERENCES `pizzas` (`pizzas_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT IGNORE INTO Recettes (recette_id, pizzas_id, ingredients_id, quantity ) VALUES
 (0, 0, 0, 5),
 (1, 1, 1, 7);
 

CREATE TABLE IF NOT EXISTS `memo` (
  `memo_id` int NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `recettes_id` int DEFAULT NULL,
  PRIMARY KEY (`memo_id`),
  KEY `recettes_key_idx` (`recettes_id`),
  CONSTRAINT `recettes_key` FOREIGN KEY (`recettes_id`) REFERENCES `Recettes` (`recette_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
 INSERT IGNORE INTO memo (memo_id, description) VALUES
 (0, 'Passer une commande pour demain'),
 (1, 'Informer le chef du manque de courgettes');

CREATE TABLE IF NOT EXISTS `orders` (
  `id_orders` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `creationTimestamp` datetime DEFAULT NULL,
  `id_customers` int DEFAULT NULL,
  `id_pizzerias` int DEFAULT NULL,
  PRIMARY KEY (`id_orders`),
  KEY `customers_key_idx` (`id_customers`),
  KEY `pizzerias_key_idx` (`id_pizzerias`),
  CONSTRAINT `customers_key` FOREIGN KEY (`id_customers`) REFERENCES `customers` (`id_customers`),
  CONSTRAINT `pizzerias_orders_key` FOREIGN KEY (`id_pizzerias`) REFERENCES `pizzerias` (`pizzeria_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
 INSERT IGNORE INTO orders (id_orders, name) VALUES
 (0, 'quatres saisons'),
 (1, 'végétarienne');
 

CREATE TABLE IF NOT EXISTS `orders_content` (
  `id_orders_content` int NOT NULL,
  `id_pizzas` int DEFAULT NULL,
  `size` int DEFAULT NULL,
  `commentary` varchar(100) DEFAULT NULL,
  `orders_content` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_orders_content`),
  KEY `pizzas_key_idx` (`id_pizzas`),
  CONSTRAINT `orders_key` FOREIGN KEY (`id_orders_content`) REFERENCES `orders` (`id_orders`),
  CONSTRAINT `pizzas_key` FOREIGN KEY (`id_pizzas`) REFERENCES `pizzas` (`pizzas_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
 INSERT IGNORE INTO orders_content (id_orders_content, id_pizzas, size, commentary) VALUES
 (0, 0, 10, 'first order'),
 (1, 1, 15, 'big order');
 

CREATE TABLE IF NOT EXISTS `cook` (
  `cook_id` int NOT NULL,
  `orders_content_id` int DEFAULT NULL,
  `pizzaiolos_id` int DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `commentary` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cook_id`),
  KEY `pizzaiolos_key_idx` (`pizzaiolos_id`),
  KEY `orders_content_key_idx` (`orders_content_id`),
  CONSTRAINT `orders_content_key` FOREIGN KEY (`orders_content_id`) REFERENCES `orders_content` (`id_orders_content`),
  CONSTRAINT `pizzaiolos_key` FOREIGN KEY (`pizzaiolos_id`) REFERENCES `pizzaiolos` (`pizzaiolos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
 INSERT IGNORE INTO cook (cook_id, orders_content_id, pizzaiolos_id, status) VALUES
 (0, 1, 1, 'finish'),
 (1, 0, 0, 'in progress');
 

CREATE TABLE IF NOT EXISTS `payment` (
  `payment_id` int NOT NULL,
  `orders_id` int DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `orders_key_idx` (`orders_id`),
  CONSTRAINT `orders_payment_key` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id_orders`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT IGNORE INTO payment (payment_id, orders_id, status) VALUES
 (0, 0,  'Cancel'),
 (1, 1,  'Finish');
 

CREATE TABLE IF NOT EXISTS `delivery` (
  `id_delivery` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `id_payment` int DEFAULT NULL,
  `id_customers` int DEFAULT NULL,
  PRIMARY KEY (`id_delivery`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT INTO delivery (id_delivery, name) VALUES
 (0, 'delivery one'),
 (1, 'delivery two');
