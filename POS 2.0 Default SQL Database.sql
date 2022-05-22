#
# Table structure for table 'Employees'
#

DROP TABLE IF EXISTS `Employees`;

CREATE TABLE `Employees` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `FullName` VARCHAR(255), 
  `Surname` VARCHAR(255), 
  `Email` VARCHAR(255), 
  `CellPhone` VARCHAR(255), 
  `Username` VARCHAR(255), 
  `Password` LONGTEXT, 
  `Admin` TINYINT(1) DEFAULT 0, 
  PRIMARY KEY (`ID`)
) ENGINE=maria DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'Employees'
#

INSERT INTO `Employees` (`ID`, `FullName`, `Surname`, `Email`, `CellPhone`, `Username`, `Password`, `Admin`) VALUES (1, 'Admin', 'Admin', NULL, NULL, 'Admin', '$2a$11$ldoAUX6p4Duk0Ecoi38LP.lOUN61j2yJFOZC8TNW/iwPf4SAHA/7e', 1);
# 1 records

#
# Table structure for table 'GiftCard'
#

DROP TABLE IF EXISTS `GiftCard`;

CREATE TABLE `GiftCard` (
  `GiftCardNum` VARCHAR(255) NOT NULL, 
  `OwnerName` VARCHAR(255), 
  `OwnerSurname` VARCHAR(255), 
  `CardBalance` DECIMAL(19,4) DEFAULT 0, 
  PRIMARY KEY (`GiftCardNum`)
) ENGINE=maria DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'GiftCard'
#

# 0 records

#
# Table structure for table 'Stock'
#

DROP TABLE IF EXISTS `Stock`;

CREATE TABLE `Stock` (
  `Barcode` VARCHAR(20) NOT NULL, 
  `ProductName` VARCHAR(50), 
  `ProductCost` DECIMAL(19,4) DEFAULT 0, 
  `ProductSellPrice` DECIMAL(19,4) DEFAULT 0, 
  `ProductAmountAvailable` INTEGER DEFAULT 0, 
  UNIQUE (`Barcode`)
) ENGINE=maria DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'Stock'
#

# 0 records

#
# Table structure for table 'Transactions'
#

DROP TABLE IF EXISTS `Transactions`;

CREATE TABLE `Transactions` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `EmployeeID` INTEGER DEFAULT 0, 
  `TotalCost` DECIMAL(19,4) DEFAULT 0, 
  `AmountPaid` DECIMAL(19,4) DEFAULT 0, 
  `AmountItems` INTEGER DEFAULT 0, 
  `DateWhen` DATETIME, 
  `GiftCardNum` VARCHAR(255), 
  INDEX (`AmountPaid`), 
  INDEX (`GiftCardNum`), 
  PRIMARY KEY (`ID`)
) ENGINE=maria DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'Transactions'
#

# 0 records

