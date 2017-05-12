-- phpMyAdmin SQL Dump
-- version 4.2.5
-- http://www.phpmyadmin.net
--
-- 主機: localhost:8889
-- 產生時間： 2017 年 05 月 12 日 11:16
-- 伺服器版本: 5.5.38
-- PHP 版本： 5.5.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 資料庫： `change`
--

-- --------------------------------------------------------

--
-- 資料表結構 `Game`
--

CREATE TABLE `Game` (
  `id` int(11) NOT NULL,
  `GameName` char(255) NOT NULL,
  `WantGame` char(255) NOT NULL,
  `mail` char(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `Game`
--

INSERT INTO `Game` (`id`, `GameName`, `WantGame`, `mail`) VALUES
(0, '食人巨鷹 TRICO,七龍珠 異戰,刺客教條：埃齊歐合輯,看門狗2', '尼爾：自動人形,地平線,Final Fantasy VII Remaster,仁王', 'wweerr22334@gmail.com'),
(1, '海賊無雙3,火影忍者4:終極風暴,秘境探險4:盜賊末路', '火影忍者:博人傳,無雙群星大亂鬥,巫師3 年度版,最後生還者', 'yyyyy12333@gmail.com'),
(2, '黑暗靈魂3,上古捲軸,人中之龍0', '人中之龍6,航海王 Burning Blood,鬥陣特攻', '3345678@yahoo.com'),
(3, '食人巨鷹 TRICO,刺客教條：埃齊歐合輯,刺客教條：編年史,看門狗2,勇者鬥惡龍英雄 集結 2 雙子王者與預言的終結,樂高：復仇者聯盟,蝙蝠俠：重返阿卡漢', '討鬼傳2,戰國 BASARA 真田幸村傳,NBA 2K17,Final Fantasy 世界', 'wweerr22334@gmail.com'),
(4, '烙印勇士無雙,初音未來 -Project DIVA- X HD', '惡靈古堡 5,惡靈古堡：保護傘公司,初音未來 Project DIVA Future Tone', 'ssddffmm@gmail.com'),
(5, '生死格鬥 5 Last Round,生死格鬥 沙灘排球,Final Fantasy 零式 HD,Final Fantasy VX,勇者鬥惡龍 英雄集結 闇龍與世界樹之城,不思議のクロニクル 振リ返リマセン勝ツマデハ', '撕紙小郵差：拆封,無夜國度,秘境探險HD合集', 'zzddffgq223@gmail.com');

-- --------------------------------------------------------

--
-- 資料表結構 `member`
--

CREATE TABLE `member` (
  `account` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(10) NOT NULL,
  `phone` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `member`
--

INSERT INTO `member` (`account`, `password`, `name`, `phone`) VALUES
('aa123456', '123456', '王小明', 987654321);

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `Game`
--
ALTER TABLE `Game`
 ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `member`
--
ALTER TABLE `member`
 ADD PRIMARY KEY (`account`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
