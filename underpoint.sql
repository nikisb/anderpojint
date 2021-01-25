-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 25, 2021 at 08:57 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `varadero`
--

-- --------------------------------------------------------

--
-- Table structure for table `aktori`
--

CREATE TABLE `aktori` (
  `ActorSQLID` int(11) NOT NULL,
  `ActorSkinID` int(11) NOT NULL DEFAULT 24,
  `ActorAnimID` int(11) NOT NULL DEFAULT 1,
  `ActorPos_X` float NOT NULL DEFAULT 0,
  `ActorPos_Y` float NOT NULL DEFAULT 0,
  `ActorPos_Z` float NOT NULL DEFAULT 0,
  `ActorRotation` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `aktori`
--

INSERT INTO `aktori` (`ActorSQLID`, `ActorSkinID`, `ActorAnimID`, `ActorPos_X`, `ActorPos_Y`, `ActorPos_Z`, `ActorRotation`) VALUES
(1, 286, 2, 1827.81, -1661.74, 13.5469, 91),
(3, 24, 2, 1827.5, -1647.75, 13.5469, 85.7889);

-- --------------------------------------------------------

--
-- Table structure for table `bankomati`
--

CREATE TABLE `bankomati` (
  `banSQLID` int(11) NOT NULL,
  `Postavljen` float NOT NULL DEFAULT 1,
  `banX` float NOT NULL DEFAULT 0,
  `banY` float NOT NULL DEFAULT 0,
  `banZ` float NOT NULL DEFAULT 0,
  `Angle` float NOT NULL DEFAULT 0,
  `banInt` int(11) NOT NULL DEFAULT 0,
  `banVW` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bankomati`
--

INSERT INTO `bankomati` (`banSQLID`, `Postavljen`, `banX`, `banY`, `banZ`, `Angle`, `banInt`, `banVW`) VALUES
(1, 1, 1993.64, -1703.08, 13.5469, 91.3197, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `drvo`
--

CREATE TABLE `drvo` (
  `dSQLID` int(11) NOT NULL,
  `dDrvoX` float NOT NULL DEFAULT 0,
  `dDrvoY` float NOT NULL DEFAULT 0,
  `dDrvoZ` float NOT NULL DEFAULT 0,
  `dVrsta` int(11) NOT NULL DEFAULT 1,
  `dRast` int(11) NOT NULL DEFAULT 0,
  `dRastVoca` int(11) NOT NULL DEFAULT 0,
  `dPostavljeno` int(11) NOT NULL DEFAULT 1,
  `dIDImanja` int(11) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `drvo`
--

INSERT INTO `drvo` (`dSQLID`, `dDrvoX`, `dDrvoY`, `dDrvoZ`, `dVrsta`, `dRast`, `dRastVoca`, `dPostavljeno`, `dIDImanja`) VALUES
(1, -705.657, 848.655, 12.123, 3, 24, 710, 1, 3),
(2, -701.935, 860.603, 11.425, 0, 24, 742, 1, 3),
(4, -709.508, 854.008, 12.4279, 1, 24, 718, 1, 3),
(5, -713.842, 854.775, 12.7939, 1, 24, 718, 1, 3),
(6, -706.59, 855.305, 12.0892, 0, 24, 62, 1, 3),
(7, -705.214, 851.603, 12.0068, 0, 24, 62, 1, 3),
(8, -708.543, 850.093, 12.4326, 0, 24, 62, 1, 3),
(9, -705.657, 848.655, 12.123, 0, 24, 62, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `firme`
--

CREATE TABLE `firme` (
  `fSQLID` int(11) NOT NULL,
  `ImaVlasnika` int(11) NOT NULL DEFAULT 0,
  `Vlasnik` varchar(32) NOT NULL DEFAULT 'Niko',
  `Vrsta` int(11) NOT NULL DEFAULT 0,
  `Naziv` varchar(64) NOT NULL DEFAULT 'Nema',
  `Iznuda` varchar(64) NOT NULL DEFAULT 'Niko',
  `UlazX` float NOT NULL DEFAULT 0,
  `UlazY` float NOT NULL DEFAULT 0,
  `UlazZ` float NOT NULL DEFAULT 0,
  `IzlazX` float NOT NULL DEFAULT 0,
  `IzlazY` float NOT NULL DEFAULT 0,
  `IzlazZ` float NOT NULL DEFAULT 0,
  `Neaktivnost` int(11) NOT NULL DEFAULT 0,
  `Level` int(11) NOT NULL DEFAULT 999,
  `Cena` int(11) NOT NULL DEFAULT 0,
  `Kasa` int(11) NOT NULL DEFAULT 0,
  `Int` int(11) NOT NULL DEFAULT 0,
  `Zatvoreno` int(11) NOT NULL DEFAULT 1,
  `Proizvodi` int(11) NOT NULL DEFAULT 300,
  `MaxProizvodi` int(11) NOT NULL DEFAULT 300,
  `VW` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `firme`
--

INSERT INTO `firme` (`fSQLID`, `ImaVlasnika`, `Vlasnik`, `Vrsta`, `Naziv`, `Iznuda`, `UlazX`, `UlazY`, `UlazZ`, `IzlazX`, `IzlazY`, `IzlazZ`, `Neaktivnost`, `Level`, `Cena`, `Kasa`, `Int`, `Zatvoreno`, `Proizvodi`, `MaxProizvodi`, `VW`) VALUES
(4, 0, 'Niko', 16, 'Djole Frizer', 'Niko', 1856.11, -1680.21, 12.5451, 418.653, -82.6398, 1001.8, 0, 10, 12, 0, 3, 1, 299, 300, 4),
(5, 0, 'Niko', 10, 'Gun Shop', 'Niko', 1870.02, -1045.7, 24.2162, 315.763, -143.661, 999.602, 0, 999, 1, 0, 7, 1, 300, 300, 5),
(6, 0, 'Niko', 18, 'Preimenovati', 'Niko', 1818.4, -1443.62, 13.5952, 0, 0, 0, 0, 999, 1, 0, 0, 1, 300, 300, 6);

-- --------------------------------------------------------

--
-- Table structure for table `gangzone`
--

CREATE TABLE `gangzone` (
  `gZSQLID` int(11) NOT NULL,
  `minX` float NOT NULL DEFAULT 0,
  `minY` float NOT NULL DEFAULT 0,
  `maxX` float NOT NULL DEFAULT 0,
  `maxY` float NOT NULL DEFAULT 0,
  `Team` int(11) NOT NULL DEFAULT 0,
  `Preuzeto` int(11) NOT NULL DEFAULT 0,
  `Glavna` int(11) NOT NULL DEFAULT 0,
  `Pickupx` float NOT NULL DEFAULT 0,
  `Pickupy` float NOT NULL DEFAULT 0,
  `Pickupz` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gangzone`
--

INSERT INTO `gangzone` (`gZSQLID`, `minX`, `minY`, `maxX`, `maxY`, `Team`, `Preuzeto`, `Glavna`, `Pickupx`, `Pickupy`, `Pickupz`) VALUES
(1, 1934.67, -1619.17, 1828.51, -1746.01, 3, 0, 0, 1865.64, -1723.46, 12.5451);

-- --------------------------------------------------------

--
-- Table structure for table `garaze`
--

CREATE TABLE `garaze` (
  `gSQLID` int(11) NOT NULL,
  `gOwned` int(11) NOT NULL DEFAULT 0,
  `gPrice` int(11) NOT NULL DEFAULT 1,
  `gOwner` varchar(32) NOT NULL DEFAULT 'Drzava',
  `gType` int(11) NOT NULL DEFAULT 1,
  `gLocked` int(11) NOT NULL DEFAULT 1,
  `gMoney` int(11) NOT NULL DEFAULT 0,
  `gEntranceX` float NOT NULL DEFAULT 0,
  `gEntranceY` float NOT NULL DEFAULT 0,
  `gEntranceZ` float NOT NULL DEFAULT 0,
  `gEntranceA` float NOT NULL DEFAULT 0,
  `gExitX` float NOT NULL DEFAULT 0,
  `gExitY` float NOT NULL DEFAULT 0,
  `gExitZ` float NOT NULL DEFAULT 0,
  `gExitA` int(11) NOT NULL DEFAULT 0,
  `gInt` int(11) NOT NULL DEFAULT 0,
  `gWorld` int(11) NOT NULL DEFAULT 0,
  `gInsideInt` int(11) NOT NULL DEFAULT 0,
  `gInsideWorld` int(11) NOT NULL DEFAULT 0,
  `gName` varchar(128) NOT NULL DEFAULT 'Nista'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `garaze`
--

INSERT INTO `garaze` (`gSQLID`, `gOwned`, `gPrice`, `gOwner`, `gType`, `gLocked`, `gMoney`, `gEntranceX`, `gEntranceY`, `gEntranceZ`, `gEntranceA`, `gExitX`, `gExitY`, `gExitZ`, `gExitA`, `gInt`, `gWorld`, `gInsideInt`, `gInsideWorld`, `gName`) VALUES
(1, 0, 1, 'Niko', 4, 0, 0, 2235.13, -1723.39, 13.5547, 180, 1643.84, -1514.82, 13.5666, 0, 0, 0, 0, 1, 'None'),
(2, 0, 1, 'Niko', 4, 0, 0, 2248.16, -1723.19, 13.5469, 180, 1643.84, -1514.82, 13.5666, 0, 0, 0, 0, 2, 'None'),
(3, 1, 1, 'bunta', 4, 0, 0, 1854.19, -1663.57, 12.5451, 180, 1643.84, -1514.82, 13.5666, 0, 0, 0, 0, 3, 'None');

-- --------------------------------------------------------

--
-- Table structure for table `gepek`
--

CREATE TABLE `gepek` (
  `gepekSQLID` int(11) NOT NULL,
  `Novac` int(11) NOT NULL DEFAULT 0,
  `Oruzije` int(11) NOT NULL DEFAULT 0,
  `Municija` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `imanja`
--

CREATE TABLE `imanja` (
  `iSQLID` int(11) NOT NULL,
  `iImaVlasnika` int(11) NOT NULL DEFAULT 0,
  `iVlasnik` varchar(32) NOT NULL DEFAULT 'Drzava',
  `iImanjeX` float NOT NULL DEFAULT 0,
  `iImanjeY` float NOT NULL DEFAULT 0,
  `iImanjeZ` float NOT NULL DEFAULT 0,
  `iLevel` int(11) NOT NULL DEFAULT 999,
  `iCena` int(11) NOT NULL DEFAULT 1,
  `iNeakt` int(11) NOT NULL DEFAULT 0,
  `iPostavljeno` int(11) NOT NULL DEFAULT 1,
  `iRadius` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `imanja`
--

INSERT INTO `imanja` (`iSQLID`, `iImaVlasnika`, `iVlasnik`, `iImanjeX`, `iImanjeY`, `iImanjeZ`, `iLevel`, `iCena`, `iNeakt`, `iPostavljeno`, `iRadius`) VALUES
(1, 0, 'Niko', -697.68, 890.295, 12.6582, 1, 1, 0, 1, 200),
(2, 0, 'Niko', -703.056, 878.411, 13.0523, 1, 1, 0, 1, 20),
(4, 0, 'Niko', -706.627, 865.981, 13.6484, 1, 1, 0, 1, 20),
(5, 1, 'bunta', -708.066, 860.587, 14.0125, 1, 1, 0, 1, 20);

-- --------------------------------------------------------

--
-- Table structure for table `jelke`
--

CREATE TABLE `jelke` (
  `jSQLID` int(11) NOT NULL,
  `Postavljena` int(11) NOT NULL DEFAULT 0,
  `X` float NOT NULL DEFAULT 0,
  `Y` float NOT NULL DEFAULT 0,
  `Z` float NOT NULL DEFAULT 0,
  `Angle` float NOT NULL DEFAULT 0,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `VW` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jelke`
--

INSERT INTO `jelke` (`jSQLID`, `Postavljena`, `X`, `Y`, `Z`, `Angle`, `Interior`, `VW`) VALUES
(1, 1, 1815.6, -1685.42, 13.5469, 0, 0, 0),
(2, 1, 1811.88, -1603.28, 13.5312, 0, 0, 0),
(3, 1, 1800.84, -1605.29, 13.5469, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `kuce`
--

CREATE TABLE `kuce` (
  `kSQLID` int(11) NOT NULL,
  `ProveraVlasnika` int(11) NOT NULL DEFAULT 0,
  `Vlasnik` varchar(32) NOT NULL DEFAULT 'Drzava',
  `Vrsta` varchar(32) NOT NULL DEFAULT 'Mala Kuca',
  `UlazX` float NOT NULL DEFAULT 0,
  `UlazY` float NOT NULL DEFAULT 0,
  `UlazZ` float NOT NULL DEFAULT 0,
  `IzlazX` float NOT NULL DEFAULT 0,
  `IzlazY` float NOT NULL DEFAULT 0,
  `IzlazZ` int(11) NOT NULL DEFAULT 0,
  `Neaktivnost` int(11) NOT NULL DEFAULT 0,
  `Level` int(11) NOT NULL DEFAULT 999,
  `Cena` int(11) NOT NULL DEFAULT 1000000,
  `Novac` int(11) NOT NULL DEFAULT 0,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `Zatvoreno` int(11) NOT NULL DEFAULT 0,
  `VW` int(11) NOT NULL DEFAULT 0,
  `Oruzije` int(11) NOT NULL DEFAULT -1,
  `Municija` int(11) NOT NULL DEFAULT 0,
  `Rent` int(11) NOT NULL DEFAULT 0,
  `CenaRenta` int(11) NOT NULL DEFAULT 0,
  `Zvono` int(11) NOT NULL DEFAULT 0,
  `Heal` int(11) NOT NULL DEFAULT 0,
  `Mats` int(11) NOT NULL DEFAULT 0,
  `Droga` int(11) NOT NULL DEFAULT 0,
  `Odjeca` int(11) NOT NULL DEFAULT 0,
  `VrstaIntKuce` int(11) NOT NULL DEFAULT 0,
  `Hrana` int(11) NOT NULL DEFAULT 0,
  `Naziv` varchar(64) NOT NULL DEFAULT 'Nema'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kuce`
--

INSERT INTO `kuce` (`kSQLID`, `ProveraVlasnika`, `Vlasnik`, `Vrsta`, `UlazX`, `UlazY`, `UlazZ`, `IzlazX`, `IzlazY`, `IzlazZ`, `Neaktivnost`, `Level`, `Cena`, `Novac`, `Interior`, `Zatvoreno`, `VW`, `Oruzije`, `Municija`, `Rent`, `CenaRenta`, `Zvono`, `Heal`, `Mats`, `Droga`, `Odjeca`, `VrstaIntKuce`, `Hrana`, `Naziv`) VALUES
(2, 0, 'Niko', 'Srednja Kuca', 1840.07, -1683.83, 12.5451, 2365.28, -1134.52, 1051, 0, 12, 127, 0, 8, 1, 2, -1, 0, 0, 50, 0, 0, 0, 0, 0, 2, 0, ''),
(3, 0, 'Niko', 'Mala Kuca', 2018.04, -1629.88, 14.0426, 223.073, 1288.37, 1082, 0, 5, 300000, 0, 1, 1, 3, -1, 0, 0, 50, 0, 0, 0, 0, 0, 1, 0, ''),
(6, 0, 'Niko', 'Mala Kuca', 2018.08, -1703.25, 14.2344, 223.073, 1288.37, 1082, 0, 5, 300000, 0, 1, 1, 6, -1, 0, 0, 50, 0, 0, 0, 0, 0, 1, 0, ''),
(8, 0, 'Niko', 'Mala Kuca', 2016.08, -1641.54, 13.7824, 223.073, 1288.37, 1082, 0, 5, 300000, 0, 1, 1, 8, -1, 0, 0, 50, 0, 0, 0, 0, 0, 1, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `org_podesavanja`
--

CREATE TABLE `org_podesavanja` (
  `TvfDroga` int(11) NOT NULL,
  `BdtDroga` int(11) NOT NULL,
  `GsfDroga` int(11) NOT NULL,
  `TvfMats` int(11) NOT NULL,
  `BdtMats` int(11) NOT NULL,
  `Po3Droga` int(11) NOT NULL,
  `Po3Mats` int(11) NOT NULL,
  `Po3Novac` int(11) NOT NULL,
  `Po4Droga` int(11) NOT NULL,
  `Po4Mats` int(11) NOT NULL,
  `Po4Novac` int(11) NOT NULL,
  `Po2Droga` int(11) NOT NULL,
  `Po2Mats` int(11) NOT NULL,
  `Po2Novac` int(11) NOT NULL,
  `GsfMats` int(11) NOT NULL,
  `TvfNovac` int(11) NOT NULL,
  `BdtNovac` int(11) NOT NULL,
  `GsfNovac` int(11) NOT NULL,
  `TvfMasina` int(11) NOT NULL,
  `BallasDroga` int(11) NOT NULL,
  `BallasMats` int(11) NOT NULL,
  `BallasNovac` int(11) NOT NULL,
  `BallasOruzije` int(11) NOT NULL,
  `CondorDroga` int(11) NOT NULL,
  `PoDroga` int(11) NOT NULL,
  `CondorMats` int(11) NOT NULL,
  `PoMats` int(11) NOT NULL,
  `CondorOruzije` int(11) NOT NULL,
  `PoOruzije` int(11) NOT NULL,
  `BaseNovac` int(11) NOT NULL,
  `BaseDroga` int(11) NOT NULL,
  `BaseMats` int(11) NOT NULL,
  `BaseOruzije` int(11) NOT NULL,
  `LCNOruzije` int(11) NOT NULL,
  `RbNovac` int(11) NOT NULL,
  `RbDroga` int(11) NOT NULL,
  `RbMats` int(11) NOT NULL,
  `LCNNovac` int(11) NOT NULL,
  `LCNDroga` int(11) NOT NULL,
  `LCNMats` int(11) NOT NULL,
  `LSPDClanovi` int(11) NOT NULL,
  `DrzavaNovac` int(11) NOT NULL,
  `PSSef` int(11) NOT NULL,
  `SmithNovac` int(11) NOT NULL,
  `SmithDroga` int(11) NOT NULL,
  `SmithMats` int(11) NOT NULL,
  `LCSNovac` int(11) NOT NULL,
  `LCSDroga` int(11) NOT NULL,
  `LCSMats` int(11) NOT NULL,
  `TCNovac` int(11) NOT NULL,
  `TCDroga` int(11) NOT NULL,
  `TCMats` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `org_podesavanja`
--

INSERT INTO `org_podesavanja` (`TvfDroga`, `BdtDroga`, `GsfDroga`, `TvfMats`, `BdtMats`, `Po3Droga`, `Po3Mats`, `Po3Novac`, `Po4Droga`, `Po4Mats`, `Po4Novac`, `Po2Droga`, `Po2Mats`, `Po2Novac`, `GsfMats`, `TvfNovac`, `BdtNovac`, `GsfNovac`, `TvfMasina`, `BallasDroga`, `BallasMats`, `BallasNovac`, `BallasOruzije`, `CondorDroga`, `PoDroga`, `CondorMats`, `PoMats`, `CondorOruzije`, `PoOruzije`, `BaseNovac`, `BaseDroga`, `BaseMats`, `BaseOruzije`, `LCNOruzije`, `RbNovac`, `RbDroga`, `RbMats`, `LCNNovac`, `LCNDroga`, `LCNMats`, `LSPDClanovi`, `DrzavaNovac`, `PSSef`, `SmithNovac`, `SmithDroga`, `SmithMats`, `LCSNovac`, `LCSDroga`, `LCSMats`, `TCNovac`, `TCDroga`, `TCMats`) VALUES
(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `SQLID` int(11) NOT NULL,
  `Name` varchar(24) NOT NULL,
  `Password` varchar(22) NOT NULL,
  `Adminpin` int(11) NOT NULL DEFAULT 0,
  `NovacDzep` int(11) NOT NULL DEFAULT 0,
  `Admin` int(11) NOT NULL DEFAULT 0,
  `DLider` int(11) NOT NULL DEFAULT 0,
  `DGM` int(11) NOT NULL DEFAULT 0,
  `DAdmin` int(11) NOT NULL DEFAULT 0,
  `DRPE` int(11) NOT NULL DEFAULT 0,
  `DVIP` int(11) NOT NULL DEFAULT 0,
  `DPromoter` int(11) NOT NULL DEFAULT 0,
  `DNagrade` int(11) NOT NULL DEFAULT 0,
  `DPStats` int(11) NOT NULL DEFAULT 0,
  `DChangeName` int(11) NOT NULL DEFAULT 0,
  `Ubistava` int(11) NOT NULL DEFAULT 0,
  `Smrti` int(11) NOT NULL DEFAULT 0,
  `Level` int(11) NOT NULL DEFAULT 0,
  `Gamemaster` int(11) NOT NULL DEFAULT 0,
  `Skin` int(11) NOT NULL DEFAULT 24,
  `Godine` int(11) NOT NULL DEFAULT 0,
  `Disarm` int(11) NOT NULL DEFAULT 0,
  `DisarmVreme` int(11) NOT NULL DEFAULT 0,
  `Drzava` int(11) NOT NULL DEFAULT 0,
  `Pol` int(11) NOT NULL DEFAULT 0,
  `Tutorial` int(11) NOT NULL DEFAULT 1,
  `Email` varchar(64) NOT NULL DEFAULT 'Nema',
  `LastSeen` varchar(64) NOT NULL DEFAULT 'Nikad',
  `Lider` int(11) NOT NULL DEFAULT 0,
  `Clan` int(11) NOT NULL DEFAULT 0,
  `Rank` int(11) NOT NULL DEFAULT 0,
  `Mutiran` int(11) NOT NULL DEFAULT 0,
  `NovacBanka` int(11) NOT NULL DEFAULT 0,
  `Warn` int(11) NOT NULL DEFAULT 0,
  `BankovniRacun` int(11) NOT NULL DEFAULT 0,
  `Zatvor` int(11) NOT NULL DEFAULT 0,
  `ZatvorenVreme` int(11) NOT NULL DEFAULT 0,
  `MutiranVreme` int(11) NOT NULL DEFAULT 0,
  `Respekti` int(11) NOT NULL DEFAULT 0,
  `UhapsenPuta` int(11) NOT NULL DEFAULT 0,
  `Droga` int(11) NOT NULL DEFAULT 0,
  `Mats` int(11) NOT NULL DEFAULT 0,
  `PayDayPoeni` int(11) NOT NULL DEFAULT 0,
  `SatiIgre` int(11) NOT NULL DEFAULT 0,
  `IznosRate` int(11) NOT NULL DEFAULT 0,
  `IznosKredita` int(11) NOT NULL DEFAULT 0,
  `RankName` varchar(128) NOT NULL DEFAULT 'Nema',
  `PreostaloZaOtplatu` int(11) NOT NULL DEFAULT 0,
  `ADozvola` int(11) NOT NULL DEFAULT 0,
  `KamionDozvola` int(11) NOT NULL DEFAULT 0,
  `AvionDozvola` int(11) NOT NULL DEFAULT 0,
  `MotorDozvola` int(11) NOT NULL DEFAULT 0,
  `BrodDozvola` int(11) NOT NULL DEFAULT 0,
  `GunDozvola` int(11) NOT NULL DEFAULT 0,
  `Skinuto` int(11) NOT NULL DEFAULT 0,
  `PosedovanjeFirme` int(11) NOT NULL DEFAULT -1,
  `Mobilni` int(11) NOT NULL DEFAULT 0,
  `Kartica` int(11) NOT NULL DEFAULT 0,
  `Imenik` int(11) NOT NULL DEFAULT 0,
  `MobKredit` int(11) NOT NULL DEFAULT 0,
  `Cigare` int(11) NOT NULL DEFAULT 0,
  `Upaljac` int(11) NOT NULL DEFAULT 0,
  `Kanap` int(11) NOT NULL DEFAULT 0,
  `Povez` int(11) NOT NULL DEFAULT 0,
  `Naocare` int(11) NOT NULL DEFAULT 0,
  `Sat` int(11) NOT NULL DEFAULT 0,
  `BorbeniStil` int(11) NOT NULL DEFAULT 0,
  `Posao` int(11) NOT NULL DEFAULT 0,
  `Hrana` int(11) NOT NULL DEFAULT 0,
  `Radio` int(11) NOT NULL DEFAULT 0,
  `PosedovanjeKuce` int(11) NOT NULL DEFAULT -1,
  `ProveraSpawna` int(11) NOT NULL DEFAULT 0,
  `Rent` int(11) NOT NULL DEFAULT -1,
  `PosedovanjeStana` int(11) NOT NULL DEFAULT -1,
  `PosedovanjeVikendice` int(11) NOT NULL DEFAULT -1,
  `OrgUgovor` int(11) NOT NULL DEFAULT 0,
  `PosaoUgovor` int(11) NOT NULL DEFAULT 0,
  `PosedovanjeAuta` int(11) NOT NULL DEFAULT -1,
  `PosedovanjeAuta2` int(11) NOT NULL DEFAULT -1,
  `DzeparosVreme` int(11) NOT NULL DEFAULT 0,
  `PosedovanjeMotora` int(11) NOT NULL DEFAULT -1,
  `Kaciga` int(11) NOT NULL DEFAULT 0,
  `PosedovanjeBicikla` int(11) NOT NULL DEFAULT -1,
  `PosedovanjeAviona` int(11) NOT NULL DEFAULT -1,
  `PosedovanjePlovila` int(11) NOT NULL DEFAULT -1,
  `Specteam` int(11) NOT NULL DEFAULT 0,
  `Promoter` int(11) NOT NULL DEFAULT 0,
  `Minus` int(11) NOT NULL DEFAULT 0,
  `Plus` int(11) NOT NULL DEFAULT 0,
  `Vip` int(11) NOT NULL DEFAULT 0,
  `DrvoSljiva` int(11) NOT NULL DEFAULT 0,
  `DrvoJabuka` int(11) NOT NULL DEFAULT 0,
  `DrvoKruska` int(11) NOT NULL DEFAULT 0,
  `Kruska` int(11) NOT NULL DEFAULT 0,
  `KljucImanja` int(11) NOT NULL DEFAULT -1,
  `Jabuka` int(11) NOT NULL DEFAULT 0,
  `Sljiva` int(11) NOT NULL DEFAULT 0,
  `Nemas` int(11) NOT NULL DEFAULT 0,
  `Goto` int(11) NOT NULL DEFAULT 0,
  `Prisluskivanje` int(11) NOT NULL DEFAULT 0,
  `Prislusk` int(11) NOT NULL DEFAULT 0,
  `GPS` int(11) NOT NULL DEFAULT 0,
  `Pomocnik` int(11) NOT NULL DEFAULT 0,
  `Cmarenje` int(11) NOT NULL DEFAULT 0,
  `Radi` int(11) NOT NULL DEFAULT 0,
  `Suky` int(11) NOT NULL DEFAULT 0,
  `ChatF` int(11) NOT NULL DEFAULT 0,
  `RobBank` int(11) NOT NULL DEFAULT 0,
  `KonopacVreme` int(11) NOT NULL DEFAULT 0,
  `PovezVreme` int(11) NOT NULL DEFAULT 0,
  `ElektricarVremeDoKraja` int(11) NOT NULL DEFAULT 0,
  `Narucen` int(11) NOT NULL DEFAULT 0,
  `Skripter` int(11) NOT NULL DEFAULT 0,
  `DvaV` int(11) NOT NULL DEFAULT 0,
  `Mutirang` int(11) NOT NULL DEFAULT 0,
  `Mutiranl` int(11) NOT NULL DEFAULT 0,
  `Diploma` int(11) NOT NULL DEFAULT 0,
  `Vabjuzera` int(11) NOT NULL DEFAULT 0,
  `Vlidera` int(11) NOT NULL DEFAULT 0,
  `Turcin` int(11) NOT NULL DEFAULT 0,
  `VAdmin` int(11) NOT NULL DEFAULT 0,
  `VGM` int(11) NOT NULL DEFAULT 0,
  `Probaj` int(11) NOT NULL DEFAULT 0,
  `TestAdmin` int(11) NOT NULL DEFAULT 0,
  `PUBG` int(11) NOT NULL DEFAULT 0,
  `Kantica` int(11) NOT NULL DEFAULT 0,
  `abjuzera` int(11) NOT NULL DEFAULT 0,
  `Pasos` int(11) NOT NULL DEFAULT 0,
  `Kzlato` int(11) NOT NULL DEFAULT 0,
  `Married` int(11) NOT NULL DEFAULT 0,
  `UPUBG` int(11) NOT NULL DEFAULT 0,
  `MarriedTo` varchar(25) NOT NULL DEFAULT 'Niko',
  `War` int(11) NOT NULL DEFAULT 0,
  `Privilegija` int(11) NOT NULL DEFAULT 0,
  `LPodg` int(11) NOT NULL DEFAULT 0,
  `Ddodelirank` int(11) NOT NULL DEFAULT 0,
  `Bonus` int(11) NOT NULL DEFAULT 0,
  `Imunitet` int(11) NOT NULL DEFAULT 0,
  `Imunitett` int(11) NOT NULL DEFAULT 0,
  `BrojBanned` int(11) NOT NULL DEFAULT 0,
  `BrojWarn` int(11) NOT NULL DEFAULT 0,
  `BrojMute` int(11) NOT NULL DEFAULT 0,
  `BrojJail` int(11) NOT NULL DEFAULT 0,
  `SatiIgreS` int(11) NOT NULL DEFAULT 0,
  `Zlato` int(11) NOT NULL DEFAULT 0,
  `LotoBr1` int(11) NOT NULL DEFAULT 0,
  `Wanted` int(11) NOT NULL DEFAULT 0,
  `PositionX` float NOT NULL DEFAULT 0,
  `PositionY` float NOT NULL DEFAULT 0,
  `PositionZ` float NOT NULL DEFAULT 0,
  `PositionInt` int(11) NOT NULL DEFAULT 0,
  `PositionVw` int(11) NOT NULL DEFAULT 0,
  `PistolSkill` int(11) NOT NULL DEFAULT 0,
  `SilencedSkill` int(11) NOT NULL DEFAULT 0,
  `DesertSkill` int(11) NOT NULL DEFAULT 0,
  `ShotgunSkill` int(11) NOT NULL DEFAULT 0,
  `SawnoffSkill` int(11) NOT NULL DEFAULT 0,
  `CombatSkill` int(11) NOT NULL DEFAULT 0,
  `UziSkill` int(11) NOT NULL DEFAULT 0,
  `SMGSkill` int(11) NOT NULL DEFAULT 0,
  `AK47Skill` int(11) NOT NULL DEFAULT 0,
  `M4Skill` int(11) NOT NULL DEFAULT 0,
  `RPucitelj` int(11) NOT NULL DEFAULT 0,
  `Dme` int(11) NOT NULL DEFAULT 0,
  `Rpe` int(11) NOT NULL DEFAULT 0,
  `PosedovanjeRanca` int(11) NOT NULL DEFAULT 0,
  `Donate` int(11) NOT NULL DEFAULT 0,
  `DutyTime` int(11) NOT NULL DEFAULT 0,
  `Fchat` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`SQLID`, `Name`, `Password`, `Adminpin`, `NovacDzep`, `Admin`, `DLider`, `DGM`, `DAdmin`, `DRPE`, `DVIP`, `DPromoter`, `DNagrade`, `DPStats`, `DChangeName`, `Ubistava`, `Smrti`, `Level`, `Gamemaster`, `Skin`, `Godine`, `Disarm`, `DisarmVreme`, `Drzava`, `Pol`, `Tutorial`, `Email`, `LastSeen`, `Lider`, `Clan`, `Rank`, `Mutiran`, `NovacBanka`, `Warn`, `BankovniRacun`, `Zatvor`, `ZatvorenVreme`, `MutiranVreme`, `Respekti`, `UhapsenPuta`, `Droga`, `Mats`, `PayDayPoeni`, `SatiIgre`, `IznosRate`, `IznosKredita`, `RankName`, `PreostaloZaOtplatu`, `ADozvola`, `KamionDozvola`, `AvionDozvola`, `MotorDozvola`, `BrodDozvola`, `GunDozvola`, `Skinuto`, `PosedovanjeFirme`, `Mobilni`, `Kartica`, `Imenik`, `MobKredit`, `Cigare`, `Upaljac`, `Kanap`, `Povez`, `Naocare`, `Sat`, `BorbeniStil`, `Posao`, `Hrana`, `Radio`, `PosedovanjeKuce`, `ProveraSpawna`, `Rent`, `PosedovanjeStana`, `PosedovanjeVikendice`, `OrgUgovor`, `PosaoUgovor`, `PosedovanjeAuta`, `PosedovanjeAuta2`, `DzeparosVreme`, `PosedovanjeMotora`, `Kaciga`, `PosedovanjeBicikla`, `PosedovanjeAviona`, `PosedovanjePlovila`, `Specteam`, `Promoter`, `Minus`, `Plus`, `Vip`, `DrvoSljiva`, `DrvoJabuka`, `DrvoKruska`, `Kruska`, `KljucImanja`, `Jabuka`, `Sljiva`, `Nemas`, `Goto`, `Prisluskivanje`, `Prislusk`, `GPS`, `Pomocnik`, `Cmarenje`, `Radi`, `Suky`, `ChatF`, `RobBank`, `KonopacVreme`, `PovezVreme`, `ElektricarVremeDoKraja`, `Narucen`, `Skripter`, `DvaV`, `Mutirang`, `Mutiranl`, `Diploma`, `Vabjuzera`, `Vlidera`, `Turcin`, `VAdmin`, `VGM`, `Probaj`, `TestAdmin`, `PUBG`, `Kantica`, `abjuzera`, `Pasos`, `Kzlato`, `Married`, `UPUBG`, `MarriedTo`, `War`, `Privilegija`, `LPodg`, `Ddodelirank`, `Bonus`, `Imunitet`, `Imunitett`, `BrojBanned`, `BrojWarn`, `BrojMute`, `BrojJail`, `SatiIgreS`, `Zlato`, `LotoBr1`, `Wanted`, `PositionX`, `PositionY`, `PositionZ`, `PositionInt`, `PositionVw`, `PistolSkill`, `SilencedSkill`, `DesertSkill`, `ShotgunSkill`, `SawnoffSkill`, `CombatSkill`, `UziSkill`, `SMGSkill`, `AK47Skill`, `M4Skill`, `RPucitelj`, `Dme`, `Rpe`, `PosedovanjeRanca`, `Donate`, `DutyTime`, `Fchat`) VALUES
(1, 'zoki', 'nikola232', 1112, 224800, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 123, 0, 0, 0, 0, 0, 1, 'ss@ss.s', '14/1/2021 at 5:16:21', 22, 22, 6, 0, -9816, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 1, 0, 0, 'Nema', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1862.06, -1683.67, 12.5451, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 79, 0),
(4, 'bunta', 'nikola232', 1112, 4692783, 7, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 12, 0, 292, 56, 0, 0, 4, 2, 1, 'idegas@namax.com', '24/1/2021 at 13:2:36', 11, 11, 6, 0, 138394, 0, 0, 0, 0, 0, 12, 0, 0, 0, 2, 29, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, -1, 1, -1, 4, -1, 0, 0, 2, -1, 0, -1, -1, -1, -1, -1, 0, 0, 0, 0, 4, 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'No-one', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, -687.877, 945.264, 13.2552, 0, 0, 0, 0, 999, 0, 0, 0, 0, 0, 0, 999, 0, 0, 0, 0, 0, 1821, 0),
(5, 'Dragan_Zoranovic', 'nikola232', 0, 500000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 240, 22, 0, 0, 1, 1, 1, 'ss@ss.s', '24/1/2021 at 11:45:21', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, -1, -1, 0, 0, -1, -1, 0, -1, -1, -1, -1, -1, 0, 0, 0, 0, 4, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'No-one', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2360.5, 474.959, 30.3944, 0, 0, 0, 0, 999, 0, 0, 0, 0, 0, 0, 999, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `server_podesavanja`
--

CREATE TABLE `server_podesavanja` (
  `Registracija` int(11) NOT NULL DEFAULT 0,
  `Oglas` int(11) NOT NULL DEFAULT 0,
  `Pitanja` int(11) NOT NULL DEFAULT 0,
  `Report` int(11) NOT NULL DEFAULT 0,
  `Kupovina` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `server_podesavanja`
--

INSERT INTO `server_podesavanja` (`Registracija`, `Oglas`, `Pitanja`, `Report`, `Kupovina`) VALUES
(0, 0, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `stanovi`
--

CREATE TABLE `stanovi` (
  `sSQLID` int(11) NOT NULL,
  `ProveraVlasnika` int(11) NOT NULL DEFAULT 0,
  `Vlasnik` varchar(32) NOT NULL DEFAULT 'Drzava',
  `UlazX` float NOT NULL DEFAULT 0,
  `UlazY` float NOT NULL DEFAULT 0,
  `UlazZ` float NOT NULL DEFAULT 0,
  `IzlazX` float NOT NULL DEFAULT 0,
  `IzlazY` float NOT NULL DEFAULT 0,
  `IzlazZ` float NOT NULL DEFAULT 0,
  `Neaktivnost` int(11) NOT NULL DEFAULT 0,
  `Level` int(11) NOT NULL DEFAULT 999,
  `Cena` int(11) NOT NULL DEFAULT 1,
  `Novac` int(11) NOT NULL DEFAULT 0,
  `Interior` int(11) NOT NULL DEFAULT 1,
  `Zatvoreno` int(11) NOT NULL DEFAULT 0,
  `VW` int(11) NOT NULL DEFAULT 0,
  `Oruzije` int(11) NOT NULL DEFAULT -1,
  `Municija` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stanovi`
--

INSERT INTO `stanovi` (`sSQLID`, `ProveraVlasnika`, `Vlasnik`, `UlazX`, `UlazY`, `UlazZ`, `IzlazX`, `IzlazY`, `IzlazZ`, `Neaktivnost`, `Level`, `Cena`, `Novac`, `Interior`, `Zatvoreno`, `VW`, `Oruzije`, `Municija`) VALUES
(6, 0, 'Niko', 2111.63, 2376.86, 15.1172, 244.152, 305.073, 999.148, 0, 1, 1, 0, 1, 1, 6, -1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ulice`
--

CREATE TABLE `ulice` (
  `uSQLID` int(11) NOT NULL,
  `uUlicaX` float NOT NULL DEFAULT 0,
  `uUlicaY` float NOT NULL DEFAULT 0,
  `uUlicaZ` float NOT NULL DEFAULT 0,
  `uPostavljena` int(11) NOT NULL DEFAULT 1,
  `uText` varchar(64) NOT NULL DEFAULT 'Tekst',
  `uIme` varchar(64) NOT NULL DEFAULT 'Ime',
  `uVlasnik` varchar(32) NOT NULL DEFAULT 'Vlasnik'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ulice`
--

INSERT INTO `ulice` (`uSQLID`, `uUlicaX`, `uUlicaY`, `uUlicaZ`, `uPostavljena`, `uText`, `uIme`, `uVlasnik`) VALUES
(1, 1845.48, -1666.41, 12.5451, 1, 'test', 'konj', '_xunder'),
(3, 1815.03, -1676.78, 13.5469, 1, 'ovaj sistem je glup kao noc', 'Svetog oca kalamarka', 'bunta');

-- --------------------------------------------------------

--
-- Table structure for table `vikendice`
--

CREATE TABLE `vikendice` (
  `vSQLID` int(11) NOT NULL,
  `ProveraVlasnika` int(11) NOT NULL DEFAULT 0,
  `Vlasnik` varchar(32) NOT NULL DEFAULT 'Drzava',
  `UlazX` float NOT NULL DEFAULT 0,
  `UlazY` float NOT NULL DEFAULT 0,
  `UlazZ` float NOT NULL DEFAULT 0,
  `IzlazX` float NOT NULL DEFAULT 0,
  `IzlazY` float NOT NULL DEFAULT 0,
  `IzlazZ` float NOT NULL DEFAULT 0,
  `Neaktivnost` int(11) NOT NULL DEFAULT 0,
  `Level` int(11) NOT NULL DEFAULT 999,
  `Cena` int(11) NOT NULL DEFAULT 1,
  `Novac` int(11) NOT NULL DEFAULT 0,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `Zatvoreno` int(11) NOT NULL DEFAULT 0,
  `VW` int(11) NOT NULL DEFAULT 1,
  `Droga` int(11) NOT NULL DEFAULT 0,
  `Mats` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vikendice`
--

INSERT INTO `vikendice` (`vSQLID`, `ProveraVlasnika`, `Vlasnik`, `UlazX`, `UlazY`, `UlazZ`, `IzlazX`, `IzlazY`, `IzlazZ`, `Neaktivnost`, `Level`, `Cena`, `Novac`, `Interior`, `Zatvoreno`, `VW`, `Droga`, `Mats`) VALUES
(1, 0, 'Niko', 0, -1679.03, 12.5451, 421.919, 2536.45, 10, 0, 1, 1, 0, 10, 1, 1, 0, 0),
(2, 0, 'Niko', 0, -1667.81, 12.5451, 421.919, 2536.45, 10, 0, 1, 1, 0, 10, 1, 2, 0, 0),
(3, 0, 'Niko', 0, -1664.4, 12.5451, 421.919, 2536.45, 10, 0, 3, 3, 0, 10, 1, 3, 0, 0),
(4, 0, 'Niko', 0, -1660.84, 12.5451, 421.919, 2536.45, 10, 0, 4, 4, 0, 10, 1, 4, 0, 0),
(5, 0, 'Niko', 0, -1657.78, 12.5451, 421.919, 2536.45, 10, 0, 5, 5, 0, 10, 1, 5, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `vozila`
--

CREATE TABLE `vozila` (
  `vSQLID` int(11) NOT NULL,
  `vModel` int(11) NOT NULL,
  `vPozX` float NOT NULL DEFAULT 0,
  `vPozY` float NOT NULL DEFAULT 0,
  `vPozZ` float NOT NULL DEFAULT 0,
  `vPozA` float NOT NULL DEFAULT 0,
  `vBoja1` int(11) NOT NULL DEFAULT 0,
  `vBoja2` int(11) NOT NULL DEFAULT 0,
  `vVlasnik` varchar(32) NOT NULL DEFAULT 'Niko',
  `vImaVlasnika` int(11) NOT NULL DEFAULT 0,
  `vID` int(11) DEFAULT NULL,
  `vZakljucan` int(11) NOT NULL DEFAULT 1,
  `vDroga` int(11) NOT NULL DEFAULT 0,
  `vMats` int(11) NOT NULL DEFAULT 0,
  `vOruzije` int(11) NOT NULL DEFAULT 0,
  `vMunicija` int(11) NOT NULL DEFAULT 0,
  `vRadio` int(11) NOT NULL DEFAULT 0,
  `vMod` varchar(128) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `vDatumReg` varchar(32) NOT NULL DEFAULT '01/01/2021',
  `vBrojReg` int(11) NOT NULL DEFAULT 0,
  `vSpawn` int(11) NOT NULL DEFAULT 0,
  `vRegistracija` int(11) NOT NULL DEFAULT 0,
  `vTehnickiPregled` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aktori`
--
ALTER TABLE `aktori`
  ADD PRIMARY KEY (`ActorSQLID`);

--
-- Indexes for table `bankomati`
--
ALTER TABLE `bankomati`
  ADD PRIMARY KEY (`banSQLID`);

--
-- Indexes for table `drvo`
--
ALTER TABLE `drvo`
  ADD PRIMARY KEY (`dSQLID`);

--
-- Indexes for table `firme`
--
ALTER TABLE `firme`
  ADD PRIMARY KEY (`fSQLID`);

--
-- Indexes for table `gangzone`
--
ALTER TABLE `gangzone`
  ADD PRIMARY KEY (`gZSQLID`);

--
-- Indexes for table `garaze`
--
ALTER TABLE `garaze`
  ADD PRIMARY KEY (`gSQLID`);

--
-- Indexes for table `gepek`
--
ALTER TABLE `gepek`
  ADD PRIMARY KEY (`gepekSQLID`);

--
-- Indexes for table `imanja`
--
ALTER TABLE `imanja`
  ADD PRIMARY KEY (`iSQLID`);

--
-- Indexes for table `jelke`
--
ALTER TABLE `jelke`
  ADD PRIMARY KEY (`jSQLID`);

--
-- Indexes for table `kuce`
--
ALTER TABLE `kuce`
  ADD PRIMARY KEY (`kSQLID`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`SQLID`);

--
-- Indexes for table `stanovi`
--
ALTER TABLE `stanovi`
  ADD PRIMARY KEY (`sSQLID`);

--
-- Indexes for table `ulice`
--
ALTER TABLE `ulice`
  ADD PRIMARY KEY (`uSQLID`);

--
-- Indexes for table `vikendice`
--
ALTER TABLE `vikendice`
  ADD PRIMARY KEY (`vSQLID`);

--
-- Indexes for table `vozila`
--
ALTER TABLE `vozila`
  ADD PRIMARY KEY (`vSQLID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aktori`
--
ALTER TABLE `aktori`
  MODIFY `ActorSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bankomati`
--
ALTER TABLE `bankomati`
  MODIFY `banSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `drvo`
--
ALTER TABLE `drvo`
  MODIFY `dSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `firme`
--
ALTER TABLE `firme`
  MODIFY `fSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `gangzone`
--
ALTER TABLE `gangzone`
  MODIFY `gZSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `garaze`
--
ALTER TABLE `garaze`
  MODIFY `gSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gepek`
--
ALTER TABLE `gepek`
  MODIFY `gepekSQLID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `imanja`
--
ALTER TABLE `imanja`
  MODIFY `iSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jelke`
--
ALTER TABLE `jelke`
  MODIFY `jSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kuce`
--
ALTER TABLE `kuce`
  MODIFY `kSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `SQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `stanovi`
--
ALTER TABLE `stanovi`
  MODIFY `sSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ulice`
--
ALTER TABLE `ulice`
  MODIFY `uSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vikendice`
--
ALTER TABLE `vikendice`
  MODIFY `vSQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vozila`
--
ALTER TABLE `vozila`
  MODIFY `vSQLID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
