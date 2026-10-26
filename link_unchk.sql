-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 26 oct. 2026 à 01:48
-- Version du serveur : 10.11.16-MariaDB
-- Version de PHP : 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `link_unchk`
--

-- --------------------------------------------------------

--
-- Structure de la table `academic_resources`
--

CREATE TABLE `academic_resources` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `filiere` varchar(150) NOT NULL,
  `niveau` varchar(80) NOT NULL,
  `matiere` varchar(150) NOT NULL,
  `resource_type` enum('cours','fiche','exercice','corrige','annale','autre') NOT NULL DEFAULT 'cours',
  `original_filename` varchar(255) NOT NULL,
  `stored_filename` varchar(255) NOT NULL,
  `mime_type` varchar(120) NOT NULL,
  `file_size` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('pending','published','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `academic_resources`
--

INSERT INTO `academic_resources` (`id`, `user_id`, `title`, `description`, `filiere`, `niveau`, `matiere`, `resource_type`, `original_filename`, `stored_filename`, `mime_type`, `file_size`, `status`, `created_at`, `updated_at`) VALUES
(2, 2, 'Note algo', NULL, 'SIMAC', 'L1', 'Algo', 'cours', 'Notes_algorithme_1.docx', '7cb236248f630787e89ea8bd40acb76a96bc.docx', 'application/zip', 58536, 'pending', '2026-10-25 23:16:20', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `admin_users`
--

CREATE TABLE `admin_users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `clubs`
--

CREATE TABLE `clubs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(180) NOT NULL,
  `description` text DEFAULT NULL,
  `logo_path` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected','suspended') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `club_members`
--

CREATE TABLE `club_members` (
  `club_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `club_role` enum('member','leader','assistant') NOT NULL DEFAULT 'member',
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `content_reports`
--

CREATE TABLE `content_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reporter_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reason` varchar(500) NOT NULL,
  `status` enum('open','reviewed','dismissed') NOT NULL DEFAULT 'open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `content_reports`
--

INSERT INTO `content_reports` (`id`, `reporter_id`, `post_id`, `comment_id`, `reason`, `status`, `created_at`) VALUES
(1, 2, 2, NULL, 'Contenu à examiner', 'open', '2026-10-25 07:29:18'),
(2, 2, 2, NULL, 'Contenu à examiner', 'open', '2026-10-25 07:29:21');

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `event_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `organizer_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `organizer_club_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('pending','published','rejected','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `event_bookmarks`
--

CREATE TABLE `event_bookmarks` (
  `event_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `friend_requests`
--

CREATE TABLE `friend_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','accepted','rejected','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `friend_requests`
--

INSERT INTO `friend_requests` (`id`, `sender_id`, `receiver_id`, `status`, `created_at`, `updated_at`) VALUES
(2, 1, 2, 'rejected', '2026-10-25 18:32:40', '2026-10-25 20:22:09'),
(3, 1, 3, 'pending', '2026-10-25 20:33:38', NULL),
(4, 4, 3, 'pending', '2026-10-25 22:59:11', NULL),
(5, 4, 2, 'accepted', '2026-10-25 22:59:44', '2026-10-25 22:59:51'),
(6, 5, 1, 'pending', '2026-10-26 00:15:12', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `group_members`
--

CREATE TABLE `group_members` (
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `member_role` enum('member','moderator','owner') NOT NULL DEFAULT 'member',
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `group_members`
--

INSERT INTO `group_members` (`group_id`, `user_id`, `member_role`, `joined_at`) VALUES
(1, 1, 'member', '2026-10-25 17:47:25'),
(1, 2, 'owner', '2026-10-25 06:22:04'),
(1, 4, 'member', '2026-10-25 23:02:31'),
(1, 5, 'member', '2026-10-25 23:09:04'),
(2, 2, 'owner', '2026-10-25 17:46:11'),
(2, 4, 'member', '2026-10-25 23:02:11');

-- --------------------------------------------------------

--
-- Structure de la table `group_posts`
--

CREATE TABLE `group_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `group_posts`
--

INSERT INTO `group_posts` (`id`, `group_id`, `user_id`, `content`, `created_at`) VALUES
(1, 1, 2, 'Salut les gars', '2026-10-25 06:22:19'),
(2, 1, 2, 'salut again', '2026-10-25 17:45:42'),
(3, 1, 1, 'Salut Hady', '2026-10-25 17:47:40'),
(4, 2, 4, 'sluu', '2026-10-25 23:02:27'),
(5, 2, 2, 'Salut', '2026-10-25 23:08:54'),
(6, 1, 5, 'Wassup', '2026-10-25 23:09:24');

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `content` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(60) NOT NULL,
  `message` varchar(500) NOT NULL,
  `related_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `message`, `related_id`, `is_read`, `created_at`) VALUES
(1, 3, 'like', 'Un étudiant a aimé ta publication.', 2, 0, '2026-10-25 07:27:25'),
(2, 3, 'like', 'Un étudiant a aimé ta publication.', 2, 0, '2026-10-25 07:29:30'),
(3, 3, 'comment', 'Un étudiant a commenté ta publication.', 2, 0, '2026-10-25 18:33:05'),
(4, 3, 'like', 'Un étudiant a aimé ta publication.', 2, 0, '2026-10-25 18:43:50'),
(5, 3, 'like', 'Un étudiant a aimé ta publication.', 2, 0, '2026-10-25 20:26:03'),
(6, 3, 'friend_request', 'Tu as reçu une nouvelle demande d’amitié.', 3, 0, '2026-10-25 20:33:38'),
(7, 3, 'like', 'Un étudiant a aimé ta publication.', 2, 0, '2026-10-25 22:55:27'),
(8, 3, 'comment', 'Un étudiant a commenté ta publication.', 2, 0, '2026-10-25 22:55:32'),
(9, 3, 'friend_request', 'Tu as reçu une nouvelle demande d’amitié.', 4, 0, '2026-10-25 22:59:11'),
(10, 2, 'friend_request', 'Tu as reçu une nouvelle demande d’amitié.', 5, 1, '2026-10-25 22:59:44'),
(11, 1, 'friend_request', 'Tu as reçu une nouvelle demande d’amitié.', 6, 0, '2026-10-26 00:15:12');

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `content` text NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `visibility` enum('public','friends') NOT NULL DEFAULT 'public',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `content`, `image_path`, `visibility`, `created_at`, `updated_at`) VALUES
(2, 3, 'Salut guys', 'assets/uploads/posts/538d8179de07fcfb05b727123fe138c7.png', 'public', '2026-10-25 06:02:04', NULL),
(3, 2, 'Bonjour', 'assets/uploads/posts/ab4b575fae3c8f58b380b6267383386b.webp', 'public', '2026-10-25 22:56:12', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `post_comments`
--

CREATE TABLE `post_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `post_comments`
--

INSERT INTO `post_comments` (`id`, `post_id`, `user_id`, `content`, `created_at`) VALUES
(3, 2, 2, 'boom', '2026-10-25 18:33:05');

-- --------------------------------------------------------

--
-- Structure de la table `post_likes`
--

CREATE TABLE `post_likes` (
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `post_likes`
--

INSERT INTO `post_likes` (`post_id`, `user_id`, `created_at`) VALUES
(2, 1, '2026-10-25 07:27:25'),
(2, 2, '2026-10-25 22:55:27'),
(2, 3, '2026-10-25 06:10:49'),
(3, 2, '2026-10-25 23:11:28');

-- --------------------------------------------------------

--
-- Structure de la table `private_messages`
--

CREATE TABLE `private_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `private_messages`
--

INSERT INTO `private_messages` (`id`, `sender_id`, `receiver_id`, `body`, `created_at`, `read_at`) VALUES
(1, 2, 1, 'Salut My g', '2026-10-25 05:40:23', '2026-10-25 05:41:27'),
(2, 2, 1, 'Oui bro what\'s up', '2026-10-25 05:49:49', '2026-10-25 05:52:00'),
(3, 1, 2, 'Lou bess nak', '2026-10-25 17:49:07', '2026-10-25 17:52:22'),
(4, 2, 4, 'Salut', '2026-10-25 23:00:24', '2026-10-25 23:00:51'),
(5, 4, 2, 'slu', '2026-10-25 23:01:01', '2026-10-25 23:07:39');

-- --------------------------------------------------------

--
-- Structure de la table `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `technologies` varchar(500) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `demo_url` varchar(500) DEFAULT NULL,
  `repository_url` varchar(500) DEFAULT NULL,
  `status` enum('in_progress','completed','looking_for_team') NOT NULL DEFAULT 'in_progress',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `projects`
--

INSERT INTO `projects` (`id`, `user_id`, `title`, `description`, `category`, `technologies`, `image_path`, `demo_url`, `repository_url`, `status`, `created_at`, `updated_at`) VALUES
(2, 1, 'Doxantu', 'Site pour vente de chaussures', 'Web', 'JavaScript', NULL, 'https://doxantuu.netlify.app', NULL, 'in_progress', '2026-10-25 05:16:26', NULL),
(3, 2, 'Algorithme en pseudo code Simac', 'Ce projet résous un problème précis qui est le fait d\'écrire des algorithmes sans jamais pouvoir vérifier leur sortie . En effet on ne fait qu\'imaginer leur sortie mais ce problème est réglé .', 'Site Web', 'HTML , CSS , Javascript', NULL, 'https://algorithme.oneapp.dev/', NULL, 'completed', '2026-10-25 18:28:52', '2026-10-25 20:34:26');

-- --------------------------------------------------------

--
-- Structure de la table `student_groups`
--

CREATE TABLE `student_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `avatar_path` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `group_type` enum('discussion','project') NOT NULL DEFAULT 'discussion',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `student_groups`
--

INSERT INTO `student_groups` (`id`, `name`, `description`, `avatar_path`, `created_by`, `group_type`, `created_at`) VALUES
(1, 'Bambaa', '', NULL, 2, 'project', '2026-10-25 06:22:04'),
(2, 'parlons', '', NULL, 2, 'discussion', '2026-10-25 17:46:11');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `filiere` varchar(150) NOT NULL,
  `eno` varchar(150) NOT NULL,
  `bio` text DEFAULT NULL,
  `avatar_path` varchar(255) DEFAULT NULL,
  `role` enum('student','club_manager','admin') NOT NULL DEFAULT 'student',
  `email_verified_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `is_private` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `filiere`, `eno`, `bio`, `avatar_path`, `role`, `email_verified_at`, `created_at`, `updated_at`, `is_private`) VALUES
(1, 'Bamba', 'Faye', 'poolemedzo@gmail.com', '$2y$12$KlIf28sazxO9sNVEWmevw.YVzM0EZX5KgGRm.43FgTRT8wrhVcG4m', 'SIMAC', 'SEBI', NULL, 'uploads/avatars/avatar_1_3e04c201619cbdc4.webp', 'student', NULL, '2026-10-25 04:50:41', '2026-10-25 05:07:49', 0),
(2, 'Hady', 'Gueye', 'medzo@gmail.com', '$2y$12$VHEIgrLhmZjVuyhbbK8Wl.yNQPla7Qv9a/uQI57o6uFcDwz6RQ9nK', 'SIMAC', 'Mermoz', NULL, 'uploads/avatars/avatar_2_d941431414558692.jpg', 'student', NULL, '2026-10-25 05:19:49', '2026-10-25 17:42:12', 0),
(3, 'Bam', 'Zo', 'bam@gmail.com', '$2y$12$J5mYv0jz1cNYcSFeWfLS5ey5gGi47j.9eWlayYnOm4w0X/QnQldNe', 'Simac', 'Sebi', NULL, NULL, 'student', NULL, '2026-10-25 05:53:56', '2026-10-25 05:54:43', 0),
(4, 'Maman', 'Ba', 'seyni.ba3@unchk.edu.sn', '$2y$12$L6xl7jQBX4.JOvWeAxemvOPOHcdZgzY9hhax532VgaMBq8biFdHfm', 'Cybersécurité', 'Sébikotane', NULL, NULL, 'student', NULL, '2026-10-25 22:57:25', NULL, 0),
(5, 'Mouhamadou', 'Gaye', 'mouhamadouhady.gaye@unchk.edu.sn', '$2y$12$05MiMkBmPDZCJbwYiOr2v.Xzfyg2bSUsClJac7i6XJsG8g21og0Kq', 'SIMAC', 'Mermoz', NULL, NULL, 'student', NULL, '2026-10-25 23:08:27', NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `user_skills`
--

CREATE TABLE `user_skills` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `skill_name` varchar(80) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `academic_resources`
--
ALTER TABLE `academic_resources`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_academic_filter` (`status`,`filiere`,`niveau`,`matiere`,`resource_type`,`created_at`),
  ADD KEY `idx_academic_user` (`user_id`,`created_at`);

--
-- Index pour la table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`user_id`);

--
-- Index pour la table `clubs`
--
ALTER TABLE `clubs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `club_members`
--
ALTER TABLE `club_members`
  ADD PRIMARY KEY (`club_id`,`user_id`),
  ADD KEY `fk_club_members_user` (`user_id`);

--
-- Index pour la table `content_reports`
--
ALTER TABLE `content_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_reports_status` (`status`,`created_at`),
  ADD KEY `fk_v7_reporter` (`reporter_id`),
  ADD KEY `fk_v7_report_post` (`post_id`),
  ADD KEY `fk_v7_report_comment` (`comment_id`);

--
-- Index pour la table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_events_date_status` (`event_date`,`status`),
  ADD KEY `fk_events_user` (`organizer_user_id`),
  ADD KEY `fk_events_club` (`organizer_club_id`);

--
-- Index pour la table `event_bookmarks`
--
ALTER TABLE `event_bookmarks`
  ADD PRIMARY KEY (`event_id`,`user_id`),
  ADD KEY `fk_event_bookmarks_user` (`user_id`);

--
-- Index pour la table `friend_requests`
--
ALTER TABLE `friend_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_friend_request` (`sender_id`,`receiver_id`),
  ADD KEY `idx_friend_receiver_status` (`receiver_id`,`status`);

--
-- Index pour la table `group_members`
--
ALTER TABLE `group_members`
  ADD PRIMARY KEY (`group_id`,`user_id`),
  ADD KEY `fk_group_members_user` (`user_id`);

--
-- Index pour la table `group_posts`
--
ALTER TABLE `group_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_group_posts` (`group_id`,`created_at`),
  ADD KEY `fk_v7_gp_user` (`user_id`);

--
-- Index pour la table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_private_messages` (`sender_id`,`receiver_id`,`created_at`),
  ADD KEY `idx_group_messages` (`group_id`,`created_at`),
  ADD KEY `fk_messages_receiver` (`receiver_id`);

--
-- Index pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_notifications_user` (`user_id`,`is_read`,`created_at`);

--
-- Index pour la table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_posts_created` (`created_at`),
  ADD KEY `fk_posts_user` (`user_id`);

--
-- Index pour la table `post_comments`
--
ALTER TABLE `post_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_comments_post` (`post_id`,`created_at`),
  ADD KEY `fk_comments_user` (`user_id`);

--
-- Index pour la table `post_likes`
--
ALTER TABLE `post_likes`
  ADD PRIMARY KEY (`post_id`,`user_id`),
  ADD KEY `fk_likes_user` (`user_id`);

--
-- Index pour la table `private_messages`
--
ALTER TABLE `private_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pm_sender_receiver_id` (`sender_id`,`receiver_id`,`id`),
  ADD KEY `idx_pm_receiver_unread` (`receiver_id`,`read_at`,`id`);

--
-- Index pour la table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_projects_status` (`status`),
  ADD KEY `fk_projects_user` (`user_id`);

--
-- Index pour la table `student_groups`
--
ALTER TABLE `student_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_groups_creator` (`created_by`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_filiere` (`filiere`),
  ADD KEY `idx_users_eno` (`eno`),
  ADD KEY `idx_users_name` (`last_name`,`first_name`);

--
-- Index pour la table `user_skills`
--
ALTER TABLE `user_skills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_skill` (`user_id`,`skill_name`),
  ADD KEY `idx_skill_name` (`skill_name`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `academic_resources`
--
ALTER TABLE `academic_resources`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `clubs`
--
ALTER TABLE `clubs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `content_reports`
--
ALTER TABLE `content_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `friend_requests`
--
ALTER TABLE `friend_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `group_posts`
--
ALTER TABLE `group_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `post_comments`
--
ALTER TABLE `post_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `private_messages`
--
ALTER TABLE `private_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `student_groups`
--
ALTER TABLE `student_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `user_skills`
--
ALTER TABLE `user_skills`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `academic_resources`
--
ALTER TABLE `academic_resources`
  ADD CONSTRAINT `fk_academic_resource_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `admin_users`
--
ALTER TABLE `admin_users`
  ADD CONSTRAINT `fk_v7_admin_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `club_members`
--
ALTER TABLE `club_members`
  ADD CONSTRAINT `fk_club_members_club` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_club_members_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `content_reports`
--
ALTER TABLE `content_reports`
  ADD CONSTRAINT `fk_v7_report_comment` FOREIGN KEY (`comment_id`) REFERENCES `post_comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_v7_report_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_v7_reporter` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_events_club` FOREIGN KEY (`organizer_club_id`) REFERENCES `clubs` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_events_user` FOREIGN KEY (`organizer_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `event_bookmarks`
--
ALTER TABLE `event_bookmarks`
  ADD CONSTRAINT `fk_event_bookmarks_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_event_bookmarks_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `friend_requests`
--
ALTER TABLE `friend_requests`
  ADD CONSTRAINT `fk_friend_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_friend_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `fk_group_members_group` FOREIGN KEY (`group_id`) REFERENCES `student_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_group_members_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `group_posts`
--
ALTER TABLE `group_posts`
  ADD CONSTRAINT `fk_v7_gp_group` FOREIGN KEY (`group_id`) REFERENCES `student_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_v7_gp_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_messages_group` FOREIGN KEY (`group_id`) REFERENCES `student_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_messages_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_messages_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_posts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `post_comments`
--
ALTER TABLE `post_comments`
  ADD CONSTRAINT `fk_comments_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `post_likes`
--
ALTER TABLE `post_likes`
  ADD CONSTRAINT `fk_likes_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_likes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `fk_projects_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `student_groups`
--
ALTER TABLE `student_groups`
  ADD CONSTRAINT `fk_groups_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
