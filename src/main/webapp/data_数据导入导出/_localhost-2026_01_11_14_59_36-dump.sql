-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pet_db
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_breed`
--

DROP TABLE IF EXISTS `tb_breed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_breed` (
  `breedId` int NOT NULL AUTO_INCREMENT COMMENT '品种ID',
  `breedName` varchar(45) NOT NULL COMMENT '品种名称',
  `breedDesc` varchar(200) DEFAULT NULL COMMENT '品种描述',
  PRIMARY KEY (`breedId`),
  UNIQUE KEY `breedName` (`breedName`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='宠物品种表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_breed`
--

LOCK TABLES `tb_breed` WRITE;
/*!40000 ALTER TABLE `tb_breed` DISABLE KEYS */;
INSERT INTO `tb_breed` VALUES (1,'金毛寻回犬','金毛寻回犬是一种大型犬，性格友善、聪明活泼，适合家庭饲养'),(2,'拉布拉多犬','拉布拉多犬是一种大型犬，性格温和、聪明易训，是优秀的导盲犬和搜救犬'),(3,'哈士奇','哈士奇是一种中型犬，性格活泼、精力旺盛，外观像狼'),(4,'德国牧羊犬','德国牧羊犬是一种大型犬，聪明忠诚、工作能力强，常用于警犬和军犬'),(5,'博美犬','博美犬是一种小型犬，性格活泼可爱，毛发蓬松'),(6,'泰迪犬','泰迪犬是一种小型犬，聪明活泼，毛发卷曲'),(7,'柯基犬','柯基犬是一种小型犬，身材矮小，性格友善活泼'),(8,'比熊犬','比熊犬是一种小型犬，性格温和友善，毛发白色蓬松'),(9,'英短蓝猫','英短蓝猫是一种短毛猫，性格温和安静，毛发为蓝色'),(10,'布偶猫','布偶猫是一种长毛猫，性格温顺，喜欢被人抱'),(11,'波斯猫','波斯猫是一种长毛猫，毛发华丽，性格优雅'),(12,'暹罗猫','暹罗猫是一种短毛猫，聪明活泼，毛发重点色');
/*!40000 ALTER TABLE `tb_breed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cart`
--

DROP TABLE IF EXISTS `tb_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_cart` (
  `cartId` int NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `userId` varchar(100) NOT NULL COMMENT '用户ID（游客使用session ID）',
  `petId` int NOT NULL COMMENT '宠物ID',
  `petNo` varchar(45) NOT NULL COMMENT '宠物编号',
  `petName` varchar(45) NOT NULL COMMENT '宠物名称',
  `breedName` varchar(45) NOT NULL COMMENT '品种名称',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `quantity` int NOT NULL DEFAULT '1' COMMENT '数量',
  `image` varchar(200) DEFAULT NULL COMMENT '宠物图片',
  `timeAdd` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`cartId`),
  KEY `idx_userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='购物车表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cart`
--

LOCK TABLES `tb_cart` WRITE;
/*!40000 ALTER TABLE `tb_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_order`
--

DROP TABLE IF EXISTS `tb_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_order` (
  `orderId` int NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `orderNo` varchar(45) NOT NULL COMMENT '订单编号',
  `userId` varchar(100) NOT NULL COMMENT '用户ID',
  `username` varchar(45) DEFAULT NULL COMMENT '用户名',
  `totalAmount` decimal(10,2) NOT NULL COMMENT '总金额',
  `status` varchar(20) NOT NULL DEFAULT '待付款' COMMENT '订单状态（待付款、已付款、已发货、已完成、已取消）',
  `receiverName` varchar(45) NOT NULL COMMENT '收货人姓名',
  `receiverPhone` varchar(45) NOT NULL COMMENT '收货人电话',
  `receiverAddress` varchar(200) NOT NULL COMMENT '收货地址',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `timeCreate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `timeUpdate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`orderId`),
  UNIQUE KEY `orderNo` (`orderNo`),
  KEY `idx_userId` (`userId`),
  KEY `idx_orderNo` (`orderNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_order`
--

LOCK TABLES `tb_order` WRITE;
/*!40000 ALTER TABLE `tb_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_order_detail`
--

DROP TABLE IF EXISTS `tb_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_order_detail` (
  `detailId` int NOT NULL AUTO_INCREMENT COMMENT '订单详情ID',
  `orderId` int NOT NULL COMMENT '订单ID',
  `orderNo` varchar(45) NOT NULL COMMENT '订单编号',
  `petId` int NOT NULL COMMENT '宠物ID',
  `petNo` varchar(45) NOT NULL COMMENT '宠物编号',
  `petName` varchar(45) NOT NULL COMMENT '宠物名称',
  `breedName` varchar(45) NOT NULL COMMENT '品种名称',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `quantity` int NOT NULL COMMENT '数量',
  `image` varchar(200) DEFAULT NULL COMMENT '宠物图片',
  PRIMARY KEY (`detailId`),
  KEY `idx_orderId` (`orderId`),
  CONSTRAINT `tb_order_detail_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `tb_order` (`orderId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单详情表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_order_detail`
--

LOCK TABLES `tb_order_detail` WRITE;
/*!40000 ALTER TABLE `tb_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pet`
--

DROP TABLE IF EXISTS `tb_pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_pet` (
  `petId` int NOT NULL AUTO_INCREMENT COMMENT '宠物ID',
  `petNo` varchar(45) NOT NULL COMMENT '宠物编号',
  `petName` varchar(45) NOT NULL COMMENT '宠物名称',
  `breedId` int NOT NULL COMMENT '品种ID',
  `breedName` varchar(45) NOT NULL COMMENT '品种名称',
  `gender` varchar(10) NOT NULL COMMENT '性别（公/母）',
  `age` int DEFAULT NULL COMMENT '年龄（岁）',
  `weight` decimal(5,2) DEFAULT NULL COMMENT '体重（公斤）',
  `color` varchar(45) DEFAULT NULL COMMENT '颜色',
  `healthStatus` varchar(45) DEFAULT '健康' COMMENT '健康状况',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `image` varchar(200) DEFAULT NULL COMMENT '宠物图片',
  `detail` text COMMENT '详细描述',
  `timeRegister` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '登记时间',
  `timeRenew` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`petId`),
  UNIQUE KEY `petNo` (`petNo`),
  KEY `breedId` (`breedId`),
  CONSTRAINT `tb_pet_ibfk_1` FOREIGN KEY (`breedId`) REFERENCES `tb_breed` (`breedId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='宠物信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pet`
--

LOCK TABLES `tb_pet` WRITE;
/*!40000 ALTER TABLE `tb_pet` DISABLE KEYS */;
INSERT INTO `tb_pet` VALUES (1,'PET2024001','大黄',1,'金毛寻回犬','公',2,28.50,'金黄色','健康',3000.00,NULL,'性格友善，喜欢和人互动，已完成基础训练','2026-01-11 14:53:07','2026-01-11 14:53:07'),(2,'PET2024002','豆豆',2,'拉布拉多犬','母',3,26.00,'黑色','健康',3500.00,NULL,'聪明易训，适合作为导盲犬训练对象','2026-01-11 14:53:07','2026-01-11 14:53:07'),(3,'PET2024003','雪儿',3,'哈士奇','公',1,22.00,'黑白相间','健康',2500.00,NULL,'精力旺盛，需要大量运动','2026-01-11 14:53:07','2026-01-11 14:53:07'),(4,'PET2024004','贝贝',6,'泰迪犬','母',2,3.50,'棕色','健康',1500.00,NULL,'聪明活泼，毛发卷曲可爱','2026-01-11 14:53:07','2026-01-11 14:53:07'),(5,'PET2024005','旺财',4,'德国牧羊犬','公',3,35.00,'黑褐色','健康',5000.00,NULL,'忠诚勇敢，工作能力强','2026-01-11 14:53:07','2026-01-11 14:53:07'),(6,'PET2024006','毛毛',5,'博美犬','母',1,2.80,'橙色','健康',1800.00,NULL,'活泼可爱，毛发蓬松','2026-01-11 14:53:07','2026-01-11 14:53:07'),(7,'PET2024007','小白',9,'英短蓝猫','母',2,4.50,'蓝色','健康',2000.00,NULL,'性格温和安静，喜欢待在室内','2026-01-11 14:53:07','2026-01-11 14:53:07'),(8,'PET2024008','公主',10,'布偶猫','母',1,4.00,'双色','健康',4000.00,NULL,'性格温顺，喜欢被人抱','2026-01-11 14:53:07','2026-01-11 14:53:07'),(9,'PET2024009','阿宝',7,'柯基犬','公',2,12.00,'黄白相间','健康',2800.00,NULL,'身材矮小，性格友善活泼','2026-01-11 14:53:07','2026-01-11 14:53:07'),(10,'PET2024010','雪球',8,'比熊犬','母',1,3.00,'白色','健康',1600.00,NULL,'性格温和友善，毛发白色蓬松','2026-01-11 14:53:07','2026-01-11 14:53:07'),(11,'PET2024011','小黑',11,'波斯猫','公',3,5.00,'白色','健康',3500.00,NULL,'毛发华丽，性格优雅','2026-01-11 14:53:07','2026-01-11 14:53:07'),(12,'PET2024012','咪咪',12,'暹罗猫','母',2,3.80,'重点色','健康',2200.00,NULL,'聪明活泼，毛发重点色','2026-01-11 14:53:07','2026-01-11 14:53:07');
/*!40000 ALTER TABLE `tb_pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user` (
  `userId` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(45) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `realName` varchar(45) DEFAULT NULL COMMENT '真实姓名',
  `role` varchar(20) DEFAULT 'guest' COMMENT '角色级别：guest、user、admin',
  `timeRenew` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (1,'admin','535233C93920248A51708D2BC0868224','系统管理员','admin','2026-01-11 14:53:10'),(2,'user','5F66E20DDB743F1D204FC29A9BD633D6','用户','user','2026-01-11 14:57:10'),(3,'guest','D2D2378BD5A5C447F782768178AA78AD','游客','guest','2026-01-11 14:57:31');
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-11 14:59:36
