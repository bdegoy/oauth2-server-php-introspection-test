-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le :  ven. 05 juil. 2019 à 15:33
-- Version du serveur :  5.6.44
-- Version de PHP :  7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `o2spdnc_data`
--

-- --------------------------------------------------------

--
-- Structure de la table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `access_token` varchar(1000) NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `user_id` varchar(80) DEFAULT NULL,
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `scope` varchar(4000) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `oauth_authorization_codes`
--

CREATE TABLE `oauth_authorization_codes` (
  `authorization_code` varchar(40) NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `user_id` varchar(80) DEFAULT NULL,
  `redirect_uri` varchar(2000) DEFAULT NULL,
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `scope` varchar(4000) DEFAULT NULL,
  `id_token` varchar(1000) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `client_id` varchar(80) NOT NULL,
  `client_secret` varchar(80) DEFAULT NULL,
  `redirect_uri` varchar(2000) DEFAULT NULL,
  `grant_types` varchar(80) DEFAULT NULL,
  `scope` varchar(4000) DEFAULT NULL,
  `user_id` varchar(80) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `oauth_clients`
--

INSERT INTO `oauth_clients` (`client_id`, `client_secret`, `redirect_uri`, `grant_types`, `scope`, `user_id`) VALUES
('testclient', 'testpass', 'https://o2sp.dnc.global/client.php', 'authorization_code', 'openid profile', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `oauth_jwt`
--

CREATE TABLE `oauth_jwt` (
  `client_id` varchar(80) NOT NULL,
  `subject` varchar(80) DEFAULT NULL,
  `public_key` varchar(2000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `oauth_public_keys`
--

CREATE TABLE `oauth_public_keys` (
  `client_id` varchar(80) DEFAULT NULL,
  `public_key` varchar(2000) DEFAULT NULL,
  `private_key` varchar(2000) DEFAULT NULL,
  `encryption_algorithm` varchar(100) DEFAULT 'RS256'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `oauth_public_keys`
--

INSERT INTO `oauth_public_keys` (`client_id`, `public_key`, `private_key`, `encryption_algorithm`) VALUES
('testclient', '-----BEGIN PUBLIC KEY-----\r\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzNyMTFLGBbkwIjb00h0H\r\nVxPKs1FpBrr6YjviQ9ey9Yt+rf9svANMLPmKo00Iz5E2acfxClsa1Pidns5cFAOH\r\nJFXjvot8e2Xd09jr2NSfDO4V7lDLVUAJ5a6eiOodqiYW4LCs8DvODMPtxl+CCGT7\r\nGcexzNqfYNof+Lk2DbRboT/YVTwLiKUAtl8c+fuhDW2rOUMaL0XvSgq5ROcnpNln\r\neSBlVO/Oh4/J4ltkklvW9IdzVk/hHG7ERKVJcZ9QZ01RMicM6raz96YyXW31+aWq\r\no+hQgH4b9oUYy3i0YjVqq9XMAuvngHN3f8zelyV+HD7zxVsuYMQiLbaGgM/P/kSF\r\nMQIDAQAB\r\n-----END PUBLIC KEY-----\r\n', '-----BEGIN PRIVATE KEY-----\r\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDM3IxMUsYFuTAi\r\nNvTSHQdXE8qzUWkGuvpiO+JD17L1i36t/2y8A0ws+YqjTQjPkTZpx/EKWxrU+J2e\r\nzlwUA4ckVeO+i3x7Zd3T2OvY1J8M7hXuUMtVQAnlrp6I6h2qJhbgsKzwO84Mw+3G\r\nX4IIZPsZx7HM2p9g2h/4uTYNtFuhP9hVPAuIpQC2Xxz5+6ENbas5QxovRe9KCrlE\r\n5yek2Wd5IGVU786Hj8niW2SSW9b0h3NWT+EcbsREpUlxn1BnTVEyJwzqtrP3pjJd\r\nbfX5paqj6FCAfhv2hRjLeLRiNWqr1cwC6+eAc3d/zN6XJX4cPvPFWy5gxCIttoaA\r\nz8/+RIUxAgMBAAECggEAaAkw7qmyisGLIjUKi5HWYnBYpkwXrCVUdoK224E1DuGy\r\niaaHj8uU6doof9nlOZQjMAEr9fhiXfmMAlQGCtvny5oauG+Z3gjTaHxm+Yyw4R4f\r\n4REC0d5dqFjPhfRu8DO7tovCp5WXhIATxoRGQwEVS/hP4Rq9ia/8QJG+U6NeTTp3\r\n21ktus9SM7OX5ucCUYdF/AiaiSvnLXZf6lZtCLyUnEqo6c+WDgXZY13pL8DtbfRK\r\nxMdk4/OZZKBLr9Ss9hJd/R0YPSgy8LHOffsnG3w2QUMhFWCu7QGvXew7U8dysEgd\r\nZvrITUqZgeqN2s/h0fqR+fbcRNtez1qRX/teBZmz4QKBgQD3EHLzpPJeugYlnUsR\r\nexxMuki22zMfeORajka+H4EyJuGa+pxmXB9Pv7w+Mxnh8uh7wrLd+D66KCx6CI8X\r\n3s2v5Izc0LoUOP4uojL4LJwnGNx1+xsF1sIiRoCKppTOc6RTVBn4zPnfkz7WVeoa\r\nQTZxSNXg1dMLhhSHE2BdmPq4XQKBgQDURVjEyW4Dgq3y5aDYPW8MSngRgRkhvXJi\r\ntSmb2O1XwjaguI/9KerILse6UdOpiuRLu4hiogmxaDk+DIcVoyIFFfN+xZK40DQO\r\n/m3bXgifo0fFOeK86psxeQTz3+F6yvZ+JqxHV2GaqIsE0FFWdR0ASkVporJq+449\r\nT9TXOnJi5QKBgQCb9Vw7BRKiTVd4AxTSEh7JKIaiNzjMUyoDJ/DsL0ME/5pGlJCJ\r\n5Pk3BFe2A9gA06+CAGOczwn5xUZeOmzpqpG4yNNKyM/N2DRMB8OY+cAQxhbUuxBR\r\n3UFrFYoq/ADPWhyPJXXHoszRH0f5UP6YWDYfyNSKOzAgBCGNKuQX8WvDWQKBgQDP\r\n/S7wiwoPyIDWymci2ncvzNv/EsbkR3OIAkjF2vUcE0Fhk9YKUoMpKKUtDDZgHqZ5\r\nCkSlmG309dF42d+WtOSFpS+UHNUZ32/S7TwJQQckHGIbfw+K2jm8bP8MUmbl4W9K\r\nxmvx703Es7abvd6k31XOTffbfL5jkx6ZNtqvFSa1fQKBgQCbTnbremkpmFW52dG/\r\ndwPf23rI8+H8t6XxJV2scQccHVaR+vDhSGxcOKSegKLYKA1BMuUq3qFCKcz62Czi\r\nSijgtWiua4zXDAoAOHHYaebztz1RuYtDOcEgnzHyQ18V5vkGgiW0zrOeg+63NVpW\r\nJ+SAzqM7pVVib/N/piNsURjo4g==\r\n-----END PRIVATE KEY-----\r\n', 'RS256');

-- --------------------------------------------------------

--
-- Structure de la table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `refresh_token` varchar(40) NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `user_id` varchar(80) DEFAULT NULL,
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `scope` varchar(4000) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `oauth_scopes`
--

CREATE TABLE `oauth_scopes` (
  `scope` varchar(80) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `oauth_users`
--

CREATE TABLE `oauth_users` (
  `username` varchar(80) NOT NULL DEFAULT '',
  `password` varchar(80) DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `last_name` varchar(80) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `scope` varchar(4000) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `oauth_users`
--

INSERT INTO `oauth_users` (`username`, `password`, `first_name`, `last_name`, `email`, `email_verified`, `scope`) VALUES
('testuser', 'password', NULL, NULL, NULL, NULL, NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`access_token`);

--
-- Index pour la table `oauth_authorization_codes`
--
ALTER TABLE `oauth_authorization_codes`
  ADD PRIMARY KEY (`authorization_code`);

--
-- Index pour la table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Index pour la table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`refresh_token`);

--
-- Index pour la table `oauth_scopes`
--
ALTER TABLE `oauth_scopes`
  ADD PRIMARY KEY (`scope`);

--
-- Index pour la table `oauth_users`
--
ALTER TABLE `oauth_users`
  ADD PRIMARY KEY (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
