-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Дек 21 2023 г., 00:06
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `fooddelivery`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Couriers`
--

CREATE TABLE `Couriers` (
  `IdCourier` int(11) NOT NULL,
  `CourierName` varchar(50) DEFAULT NULL,
  `CurrentLocation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Couriers`
--

INSERT INTO `Couriers` (`IdCourier`, `CourierName`, `CurrentLocation`) VALUES
(1, 'Courier1', 'Location1'),
(2, 'Courier2', 'Location2');

-- --------------------------------------------------------

--
-- Структура таблицы `Customers`
--

CREATE TABLE `Customers` (
  `IdCustomer` int(11) NOT NULL,
  `CustomerName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Customers`
--

INSERT INTO `Customers` (`IdCustomer`, `CustomerName`) VALUES
(1, 'Customer1'),
(2, 'Customer2');

-- --------------------------------------------------------

--
-- Структура таблицы `DeliveryForecasts`
--

CREATE TABLE `DeliveryForecasts` (
  `IdOrder` int(11) NOT NULL,
  `IdCourier` int(11) DEFAULT NULL,
  `AverageDeliveryTime` time DEFAULT NULL,
  `IdDeliveryForecast` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `DeliveryForecasts`
--

INSERT INTO `DeliveryForecasts` (`IdOrder`, `IdCourier`, `AverageDeliveryTime`, `IdDeliveryForecast`) VALUES
(1, 1, '00:30:00', 1),
(2, 2, '00:45:00', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `Locations`
--

CREATE TABLE `Locations` (
  `IdLocation` int(11) NOT NULL,
  `IdRestaurant` int(11) DEFAULT NULL,
  `LocationName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Locations`
--

INSERT INTO `Locations` (`IdLocation`, `IdRestaurant`, `LocationName`) VALUES
(1, NULL, 'Location1'),
(2, NULL, 'Location2');

-- --------------------------------------------------------

--
-- Структура таблицы `Orders`
--

CREATE TABLE `Orders` (
  `IdOrder` int(11) NOT NULL,
  `IdRestaurant` int(11) DEFAULT NULL,
  `IdCustomer` int(11) DEFAULT NULL,
  `DeliveryTimeForecast` datetime DEFAULT NULL,
  `IdCourier` int(11) DEFAULT NULL,
  `OrderTime` datetime DEFAULT NULL,
  `EstimatedDeliveryTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Orders`
--

INSERT INTO `Orders` (`IdOrder`, `IdRestaurant`, `IdCustomer`, `DeliveryTimeForecast`, `IdCourier`, `OrderTime`, `EstimatedDeliveryTime`) VALUES
(1, 1, 1, '2023-01-01 12:00:00', 1, '2023-01-01 11:30:00', '2023-01-01 12:00:00'),
(2, 2, 2, '2023-01-01 18:00:00', 2, '2023-01-01 17:15:00', '2023-01-01 18:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `Restaurants`
--

CREATE TABLE `Restaurants` (
  `IdRestaurant` int(11) NOT NULL,
  `Menu` text DEFAULT NULL,
  `OpeningHours` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Restaurants`
--

INSERT INTO `Restaurants` (`IdRestaurant`, `Menu`, `OpeningHours`) VALUES
(1, 'MenuData1', '08:00 - 22:00'),
(2, 'MenuData2', '09:00 - 23:00');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Couriers`
--
ALTER TABLE `Couriers`
  ADD PRIMARY KEY (`IdCourier`);

--
-- Индексы таблицы `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`IdCustomer`);

--
-- Индексы таблицы `DeliveryForecasts`
--
ALTER TABLE `DeliveryForecasts`
  ADD PRIMARY KEY (`IdDeliveryForecast`),
  ADD UNIQUE KEY `unique_forecast` (`IdOrder`,`IdCourier`),
  ADD UNIQUE KEY `unique_index` (`IdOrder`,`IdCourier`),
  ADD KEY `IdCourier` (`IdCourier`);

--
-- Индексы таблицы `Locations`
--
ALTER TABLE `Locations`
  ADD PRIMARY KEY (`IdLocation`),
  ADD KEY `IdRestaurant` (`IdRestaurant`);

--
-- Индексы таблицы `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`IdOrder`),
  ADD KEY `IdRestaurant` (`IdRestaurant`),
  ADD KEY `IdCustomer` (`IdCustomer`),
  ADD KEY `IdCourier` (`IdCourier`);

--
-- Индексы таблицы `Restaurants`
--
ALTER TABLE `Restaurants`
  ADD PRIMARY KEY (`IdRestaurant`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Couriers`
--
ALTER TABLE `Couriers`
  MODIFY `IdCourier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Customers`
--
ALTER TABLE `Customers`
  MODIFY `IdCustomer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `DeliveryForecasts`
--
ALTER TABLE `DeliveryForecasts`
  MODIFY `IdDeliveryForecast` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Locations`
--
ALTER TABLE `Locations`
  MODIFY `IdLocation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Orders`
--
ALTER TABLE `Orders`
  MODIFY `IdOrder` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Restaurants`
--
ALTER TABLE `Restaurants`
  MODIFY `IdRestaurant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `DeliveryForecasts`
--
ALTER TABLE `DeliveryForecasts`
  ADD CONSTRAINT `deliveryforecasts_ibfk_1` FOREIGN KEY (`IdCourier`) REFERENCES `Couriers` (`IdCourier`);

--
-- Ограничения внешнего ключа таблицы `Locations`
--
ALTER TABLE `Locations`
  ADD CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`IdRestaurant`) REFERENCES `Restaurants` (`IdRestaurant`);

--
-- Ограничения внешнего ключа таблицы `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`IdRestaurant`) REFERENCES `Restaurants` (`IdRestaurant`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`IdCustomer`) REFERENCES `Customers` (`IdCustomer`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`IdCourier`) REFERENCES `Couriers` (`IdCourier`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
