/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.5.27 : Database - fwf_casestudy
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`fwf_casestudy` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `fwf_casestudy`;

/*Table structure for table `cars` */

DROP TABLE IF EXISTS `cars`;

CREATE TABLE `cars` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `production_year` int(4) DEFAULT NULL,
  `mileage` double DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `category_id` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cars` */

/*Table structure for table `cars_equipments` */

DROP TABLE IF EXISTS `cars_equipments`;

CREATE TABLE `cars_equipments` (
  `cars_id` int(4) DEFAULT NULL,
  `equipments_id` int(4) DEFAULT NULL,
  KEY `cars_id` (`cars_id`),
  KEY `equipments_id` (`equipments_id`),
  CONSTRAINT `cars_equipments_ibfk_1` FOREIGN KEY (`cars_id`) REFERENCES `cars` (`id`),
  CONSTRAINT `cars_equipments_ibfk_2` FOREIGN KEY (`equipments_id`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cars_equipments` */

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `categories` */

/*Table structure for table `cities` */

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cities` */

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `age` int(2) DEFAULT NULL,
  `drivers_license_no` varchar(15) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `customers` */

/*Table structure for table `equipment` */

DROP TABLE IF EXISTS `equipment`;

CREATE TABLE `equipment` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `equipment` */

/*Table structure for table `insurance` */

DROP TABLE IF EXISTS `insurance`;

CREATE TABLE `insurance` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `insurance` */

/*Table structure for table `locations` */

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `location` varchar(100) DEFAULT NULL,
  `city_id` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `locations` */

/*Table structure for table `prices` */

DROP TABLE IF EXISTS `prices`;

CREATE TABLE `prices` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `price` double(10,5) DEFAULT NULL,
  `age_criteria` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prices` */

/*Table structure for table `rental` */

DROP TABLE IF EXISTS `rental`;

CREATE TABLE `rental` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `reservation_id` int(4) DEFAULT NULL,
  `pickup_location_id` int(4) DEFAULT NULL,
  `dropoff_location_id` int(4) DEFAULT NULL,
  `car_id` int(4) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `price_id` int(4) DEFAULT NULL,
  `reservation_status` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reservation_id` (`reservation_id`),
  KEY `pickup_location_id` (`pickup_location_id`),
  KEY `dropoff_location_id` (`dropoff_location_id`),
  KEY `car_id` (`car_id`),
  KEY `price_id` (`price_id`),
  CONSTRAINT `rental_ibfk_1` FOREIGN KEY (`pickup_location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `rental_ibfk_2` FOREIGN KEY (`dropoff_location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `rental_ibfk_5` FOREIGN KEY (`car_id`) REFERENCES `cars` (`id`),
  CONSTRAINT `rental_ibfk_6` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`),
  CONSTRAINT `rental_ibfk_7` FOREIGN KEY (`price_id`) REFERENCES `prices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rental` */

/*Table structure for table `rental_insurance` */

DROP TABLE IF EXISTS `rental_insurance`;

CREATE TABLE `rental_insurance` (
  `rental_id` int(4) DEFAULT NULL,
  `insurance_id` int(4) DEFAULT NULL,
  KEY `rental_id` (`rental_id`),
  KEY `insurance_id` (`insurance_id`),
  CONSTRAINT `rental_insurance_ibfk_1` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`id`),
  CONSTRAINT `rental_insurance_ibfk_2` FOREIGN KEY (`insurance_id`) REFERENCES `insurance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rental_insurance` */

/*Table structure for table `reservations` */

DROP TABLE IF EXISTS `reservations`;

CREATE TABLE `reservations` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `pickup_location_id` int(4) DEFAULT NULL,
  `dropoff_location_id` int(4) DEFAULT NULL,
  `customer_id` int(4) DEFAULT NULL,
  `category_id` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pickup_location_id` (`pickup_location_id`),
  KEY `dropoff_location_id` (`dropoff_location_id`),
  KEY `customer_id` (`customer_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `reservations_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `reservations_ibfk_4` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`pickup_location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`dropoff_location_id`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reservations` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
