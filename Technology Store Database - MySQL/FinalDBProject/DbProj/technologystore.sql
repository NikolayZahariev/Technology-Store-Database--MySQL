-- MySQL Script generated by MySQL Workbench
-- 12/15/15 00:05:12
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `e_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `street_number` INT NULL,
  `street_name` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `e_phone` VARCHAR(45) NULL,
  `worked_from` VARCHAR(45) NULL,
  `worked_till` VARCHAR(45) NULL,
  `Manager_e_id` INT NOT NULL,
  PRIMARY KEY (`e_id`, `Manager_e_id`),
  CONSTRAINT `fk_Employee_Employee1`
    FOREIGN KEY (`Manager_e_id`)
    REFERENCES `mydb`.`Employee` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Warehouse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Warehouse` (
  `w_num` INT NOT NULL,
  `w_name` VARCHAR(45) NOT NULL,
  `w_location` VARCHAR(45) NOT NULL,
  `w_size` VARCHAR(45) NULL,
  `number_of_employees` VARCHAR(45) NULL,
  `manager_first_name` VARCHAR(45) NULL,
  `manager_last_name` VARCHAR(45) NULL,
  PRIMARY KEY (`w_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Brand` (
  `b_name` VARCHAR(45) NOT NULL,
  `market_share` VARCHAR(45) NOT NULL,
  `country_of_origin` VARCHAR(45) NOT NULL,
  `website` VARCHAR(45) NULL,
  `number_of_suppliers` VARCHAR(45) NULL,
  `number_of_employees` VARCHAR(45) NULL,
  `CEO` VARCHAR(45) NULL,
  PRIMARY KEY (`b_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Maintanance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Maintanance` (
  `Employee_e_id` INT NOT NULL,
  `num_repairs` INT NULL,
  `speciality` VARCHAR(45) NULL,
  `average_time_per_repair(hours)` VARCHAR(45) NULL,
  PRIMARY KEY (`Employee_e_id`),
  UNIQUE INDEX `Employee_e_id_UNIQUE` (`Employee_e_id` ASC),
  CONSTRAINT `fk_Maintanance_Employee1`
    FOREIGN KEY (`Employee_e_id`)
    REFERENCES `mydb`.`Employee` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `i_id` INT NOT NULL,
  `i_name` VARCHAR(45) NOT NULL,
  `i_price($)` VARCHAR(45) NOT NULL,
  `qty_left` VARCHAR(45) NOT NULL,
  `Warehouse_w_num` INT NOT NULL,
  `Brand_b_name` VARCHAR(45) NOT NULL,
  `Maintanance_Employee_e_id` INT NOT NULL,
  PRIMARY KEY (`i_id`, `Warehouse_w_num`, `Brand_b_name`, `Maintanance_Employee_e_id`),
  CONSTRAINT `fk_Item_Warehouse1`
    FOREIGN KEY (`Warehouse_w_num`)
    REFERENCES `mydb`.`Warehouse` (`w_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_Brand1`
    FOREIGN KEY (`Brand_b_name`)
    REFERENCES `mydb`.`Brand` (`b_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_Maintanance1`
    FOREIGN KEY (`Maintanance_Employee_e_id`)
    REFERENCES `mydb`.`Maintanance` (`Employee_e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `s_id` INT NOT NULL,
  `s_name` VARCHAR(45) NOT NULL,
  `s_location` VARCHAR(45) NOT NULL,
  `s_phone` VARCHAR(45) NULL,
  `quality_of_products` VARCHAR(45) NULL,
  `s_email` VARCHAR(45) NULL,
  `years_active` VARCHAR(45) NULL,
  PRIMARY KEY (`s_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Provides`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Provides` (
  `Item_i_id` INT NOT NULL,
  `Supplier_s_id` INT NOT NULL,
  `p_date` DATE NOT NULL,
  `p_quantity` VARCHAR(45) NOT NULL,
  `total_cost($)` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Item_i_id`, `Supplier_s_id`),
  CONSTRAINT `i_id`
    FOREIGN KEY (`Item_i_id`)
    REFERENCES `mydb`.`Item` (`i_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `s_id`
    FOREIGN KEY (`Supplier_s_id`)
    REFERENCES `mydb`.`Supplier` (`s_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `c_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL,
  `c_email` VARCHAR(45) NULL,
  `c_phone` VARCHAR(45) NULL,
  `c_street_num` VARCHAR(45) NULL,
  `c_street_name` VARCHAR(45) NULL,
  `c_city` VARCHAR(45) NULL,
  PRIMARY KEY (`c_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Assistant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Assistant` (
  `Employee_e_id` INT NOT NULL,
  `speciality` VARCHAR(45) NULL,
  `customers_served_per_day` INT NULL,
  PRIMARY KEY (`Employee_e_id`),
  UNIQUE INDEX `Employee_e_id_UNIQUE` (`Employee_e_id` ASC),
  CONSTRAINT `fk_Assistant_Employee1`
    FOREIGN KEY (`Employee_e_id`)
    REFERENCES `mydb`.`Employee` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order` (
  `o_num` INT NOT NULL,
  `o_date` DATE NOT NULL,
  `o_time` VARCHAR(45) NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `discount($)` VARCHAR(45) NULL,
  `Customer_c_id` INT NOT NULL,
  `Assistant_Employee_e_id` INT NOT NULL,
  PRIMARY KEY (`o_num`, `Customer_c_id`, `Assistant_Employee_e_id`),
  CONSTRAINT `fk_Order_Customer1`
    FOREIGN KEY (`Customer_c_id`)
    REFERENCES `mydb`.`Customer` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Assistant1`
    FOREIGN KEY (`Assistant_Employee_e_id`)
    REFERENCES `mydb`.`Assistant` (`Employee_e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IT` (
  `i_id` INT NOT NULL,
  `i_type` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NULL,
  `RAM(GB)` VARCHAR(45) NULL,
  `Motherboard` VARCHAR(45) NULL,
  PRIMARY KEY (`i_id`),
  CONSTRAINT `i_id`
    FOREIGN KEY (`i_id`)
    REFERENCES `mydb`.`Item` (`i_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TV`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TV` (
  `i_id` INT NOT NULL,
  `width` VARCHAR(45) NOT NULL,
  `height` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `number_of_channels` VARCHAR(45) NULL,
  `HD/SD` VARCHAR(45) NULL,
  PRIMARY KEY (`i_id`),
  CONSTRAINT `i_id`
    FOREIGN KEY (`i_id`)
    REFERENCES `mydb`.`Item` (`i_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Kitchen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Kitchen` (
  `i_id` INT NOT NULL,
  `k_category` VARCHAR(45) NOT NULL,
  `voltage` VARCHAR(45) NULL,
  `width(cm)` VARCHAR(45) NULL,
  `height(cm)` VARCHAR(45) NULL,
  `Self-cleaning?` VARCHAR(45) NULL,
  PRIMARY KEY (`i_id`),
  CONSTRAINT `i_id`
    FOREIGN KEY (`i_id`)
    REFERENCES `mydb`.`Item` (`i_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Communication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Communication` (
  `i_id` INT NOT NULL,
  `com_type` VARCHAR(45) NOT NULL,
  `OS` VARCHAR(45) NULL,
  `Portable/stationary` VARCHAR(45) NULL,
  `Weight(g)` VARCHAR(45) NULL,
  `Camera(MP)` VARCHAR(45) NULL,
  `Storage(GB)` VARCHAR(45) NULL,
  PRIMARY KEY (`i_id`),
  CONSTRAINT `i_id`
    FOREIGN KEY (`i_id`)
    REFERENCES `mydb`.`Item` (`i_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Accessories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Accessories` (
  `i_id` INT NOT NULL,
  `a_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`i_id`),
  CONSTRAINT `i_id`
    FOREIGN KEY (`i_id`)
    REFERENCES `mydb`.`Item` (`i_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Audio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Audio` (
  `i_id` INT NOT NULL,
  `au_type` VARCHAR(45) NOT NULL,
  `decibel` VARCHAR(45) NULL,
  `Khz` VARCHAR(45) NULL,
  `Resistance(ohms)` VARCHAR(45) NULL,
  PRIMARY KEY (`i_id`),
  CONSTRAINT `i_id`
    FOREIGN KEY (`i_id`)
    REFERENCES `mydb`.`Item` (`i_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payroll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payroll` (
  `P_number` INT NOT NULL,
  `gross_pay` VARCHAR(45) NULL,
  `bonus` VARCHAR(45) NULL,
  `deductions` VARCHAR(45) NULL,
  `from_date` VARCHAR(45) NULL,
  `to_date` VARCHAR(45) NULL,
  `net_pay` VARCHAR(45) NULL,
  `Employee_e_id` INT NOT NULL,
  PRIMARY KEY (`P_number`, `Employee_e_id`),
  CONSTRAINT `fk_Salary_Employee1`
    FOREIGN KEY (`Employee_e_id`)
    REFERENCES `mydb`.`Employee` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cashier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cashier` (
  `checkout_No` INT NOT NULL,
  `revenue_per_day` VARCHAR(45) NULL,
  `for_day` VARCHAR(45) NULL,
  `Employee_e_id` INT NOT NULL,
  PRIMARY KEY (`Employee_e_id`),
  UNIQUE INDEX `Employee_e_id_UNIQUE` (`Employee_e_id` ASC),
  CONSTRAINT `fk_Cashier_Employee1`
    FOREIGN KEY (`Employee_e_id`)
    REFERENCES `mydb`.`Employee` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `B_num` INT NOT NULL,
  `amount` VARCHAR(45) NULL,
  `Order_o_num` INT NOT NULL,
  `Order_Customer_c_id` INT NOT NULL,
  `Cashier_Employee_e_id` INT NOT NULL,
  PRIMARY KEY (`B_num`, `Order_o_num`, `Order_Customer_c_id`, `Cashier_Employee_e_id`),
  CONSTRAINT `fk_Bill_Order1`
    FOREIGN KEY (`Order_o_num` , `Order_Customer_c_id`)
    REFERENCES `mydb`.`Order` (`o_num` , `Customer_c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_Cashier1`
    FOREIGN KEY (`Cashier_Employee_e_id`)
    REFERENCES `mydb`.`Cashier` (`Employee_e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order_has_Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order_has_Item` (
  `Item_i_id` INT NOT NULL,
  `Order_o_num` INT NOT NULL,
  `quantity` VARCHAR(45) NULL,
  PRIMARY KEY (`Item_i_id`, `Order_o_num`),
  CONSTRAINT `fk_Item_has_Order_Item1`
    FOREIGN KEY (`Item_i_id`)
    REFERENCES `mydb`.`Item` (`i_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Order_Order1`
    FOREIGN KEY (`Order_o_num`)
    REFERENCES `mydb`.`Order` (`o_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
