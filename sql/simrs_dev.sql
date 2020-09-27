-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 27 Sep 2020 pada 22.11
-- Versi server: 8.0.21-0ubuntu0.20.04.4
-- Versi PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simrs_dev`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_agama`
--

CREATE TABLE `tbl_agama` (
  `id_agama` int NOT NULL,
  `agama` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_agama`
--

INSERT INTO `tbl_agama` (`id_agama`, `agama`) VALUES
(1, 'ISLAM'),
(2, 'KRISTEN'),
(3, 'HINDU'),
(4, 'BUDHA');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_akses_menu`
--

CREATE TABLE `tbl_akses_menu` (
  `id_akses_menu` int NOT NULL,
  `id_user_level` int NOT NULL,
  `id_menu` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_akses_menu`
--

INSERT INTO `tbl_akses_menu` (`id_akses_menu`, `id_user_level`, `id_menu`) VALUES
(1, 3, 25),
(2, 3, 26),
(22, 5, 30),
(23, 5, 27),
(24, 5, 28),
(25, 5, 29),
(26, 5, 31),
(27, 5, 32),
(28, 5, 34),
(29, 4, 41),
(30, 3, 42);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_antrean`
--

CREATE TABLE `tbl_antrean` (
  `id_antrean` int NOT NULL,
  `id_tipe_antrean` int NOT NULL,
  `no_antrean` int NOT NULL,
  `tanggal_antrean` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('ongoing','done','skipped') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_antrean`
--

INSERT INTO `tbl_antrean` (`id_antrean`, `id_tipe_antrean`, `no_antrean`, `tanggal_antrean`, `status`) VALUES
(17, 1, 1, '2020-09-22 16:04:03', 'ongoing'),
(18, 1, 2, '2020-09-22 16:04:08', 'ongoing'),
(19, 1, 3, '2020-09-22 16:04:13', 'ongoing'),
(20, 1, 1, '2020-09-26 17:01:26', 'done');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_antrean_type`
--

CREATE TABLE `tbl_antrean_type` (
  `id_tipe_antrean` int NOT NULL,
  `kode_antrean` varchar(10) NOT NULL,
  `nama_antrean` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_antrean_type`
--

INSERT INTO `tbl_antrean_type` (`id_tipe_antrean`, `kode_antrean`, `nama_antrean`) VALUES
(1, 'P', 'Poliklinik'),
(2, 'A', 'Apotek');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_bidang`
--

CREATE TABLE `tbl_bidang` (
  `id_bidang` int NOT NULL,
  `nama_bidang` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_bidang`
--

INSERT INTO `tbl_bidang` (`id_bidang`, `nama_bidang`) VALUES
(1, 'BIDANG 1'),
(2, 'BIDANG 2'),
(3, 'Pemeriksa Sampel');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_departemen`
--

CREATE TABLE `tbl_departemen` (
  `id_departemen` int NOT NULL,
  `nama_departemen` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_departemen`
--

INSERT INTO `tbl_departemen` (`id_departemen`, `nama_departemen`) VALUES
(1, 'DEPARTEMEN 1'),
(2, 'KEAMANAN'),
(3, 'KEUANGAN'),
(4, 'APOTEK');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_diagnosa_penyakit`
--

CREATE TABLE `tbl_diagnosa_penyakit` (
  `kode_diagnosa` varchar(6) NOT NULL,
  `nama_penyakit` varchar(50) NOT NULL,
  `ciri_ciri_penyakit` text NOT NULL,
  `keterangan` text NOT NULL,
  `ciri_ciri_umum` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_dokter`
--

CREATE TABLE `tbl_dokter` (
  `kode_dokter` varchar(20) NOT NULL,
  `id_gol_darah` int NOT NULL,
  `id_status_menikah` int NOT NULL,
  `id_agama` int NOT NULL,
  `id_spesialis` int NOT NULL,
  `nama_dokter` varchar(254) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `tempat_lahir` varchar(30) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `alamat_tinggal` text NOT NULL,
  `no_hp` varchar(13) NOT NULL,
  `no_izin_praktek` varchar(20) NOT NULL,
  `alumni` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_dokter`
--

INSERT INTO `tbl_dokter` (`kode_dokter`, `id_gol_darah`, `id_status_menikah`, `id_agama`, `id_spesialis`, `nama_dokter`, `jenis_kelamin`, `tempat_lahir`, `tanggal_lahir`, `alamat_tinggal`, `no_hp`, `no_izin_praktek`, `alumni`) VALUES
('1', 1, 1, 1, 11, 'BURHAN, DR., SP.A.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('10', 1, 1, 1, 4, 'AKHMAD IMRON, DR. DR., SP.BS (K)., M. KES', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('11', 1, 1, 1, 6, 'IRZAN GUSTANTO NUGRAHA LUBIS, DR. SP.B.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('12', 1, 1, 1, 6, 'CATUR SETYO DAMARIANTO, H. DR., SP. B.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('13', 1, 1, 1, 1, 'TJAHJODJATI, DR., SP.B, (K) U', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('14', 1, 1, 1, 20, 'DEWI ROSMALADEWI, DRG., SPKG', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('15', 1, 1, 1, 18, 'RULIA, DRG.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('16', 1, 1, 1, 18, 'TINI KARTINI DAHLAN, DRG.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('17', 1, 1, 1, 19, 'RITA RATNASARI, DR., SP.GK', 'P', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('18', 1, 1, 1, 10, 'FAJAR ASHARI, H. DR., SP. JP.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('19', 1, 1, 1, 10, 'M. AGUS THOSIN H. A. T., H. DR., SP.JP.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('2', 1, 1, 1, 11, 'DICKY SANTOSA, DR.,SP.A., MM., M.KES.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('20', 1, 1, 1, 10, 'SUGIANTORO, DR., SP. JP.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('21', 1, 1, 1, 10, 'WIDI NUGRAHA HADIAN, DR, SP.JP', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('22', 1, 1, 1, 21, 'DELLE HELIANI AMALI, DR., SP.OG.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('23', 1, 1, 1, 21, 'ANDI RINALDI, DR., SP.OG(K).', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('24', 1, 1, 1, 21, 'DWIWAHJU DIAN INDAHWATI, DR., SP.OG.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('25', 1, 1, 1, 25, 'MALI PAMUAJI W., H. DR.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('26', 1, 1, 1, 7, 'WIDIATI, DR. , SP.KK', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('27', 1, 1, 1, 13, 'RETNO DWIYANTI, DR., SP.M', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('28', 1, 1, 1, 26, 'HILLDA HERAWATI, DRG., SP.ORT', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('29', 1, 1, 1, 24, 'AZRIL HASAN, DR.,SP.P.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('3', 1, 1, 1, 11, 'LIA MARLIA K., HJ. DR. SP. A.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('30', 1, 1, 1, 5, 'EKA SURYA NUGRAHA, SP.PD', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('31', 1, 1, 1, 5, 'IWAN S. MERTASUDIRA, DR. SP.PD', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('32', 1, 1, 1, 5, 'MUHAMMAD IQBAL, H. DR.,SP.PD.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('33', 1, 1, 1, 5, 'RADEN BENI BENARDI, DR., SPPD', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('34', 1, 1, 1, 5, 'TULUS WIDIYANTO, DR., SP.PD.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('35', 1, 1, 1, 5, 'HARSYA PRIYANGGA P NUGRAHA, DR., SPPD', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('36', 1, 1, 1, 29, 'RHENI SAFIRA ISNAENI, DRG., SP.PROS', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('37', 1, 1, 1, 22, 'UNTUNG SENTOSA, DR., SP. KJ.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('38', 1, 1, 1, 23, 'SELLY MAHLIANI, DRA. PSI', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('39', 1, 1, 1, 4, 'NURI AMALIA, HJ. DR., SP.S.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('4', 1, 1, 1, 11, 'WEDI ISKANDAR, DR. SP.A.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('40', 1, 1, 1, 4, 'ROSLAINI, DR., SP.S', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('41', 1, 1, 1, 15, 'KOM POL PURWADI, DR., SP.THT-KL', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('42', 1, 1, 1, 11, 'REBY KUSUMAJAYA, DR., SP.A(K), M.KES.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('43', 1, 1, 1, 6, 'ABEL TASMAN YUZA, DRG., SP.BM', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('44', 1, 1, 1, 6, 'ACHMAD ADAM, DR., SP.BS. (K)', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('45', 1, 1, 1, 6, 'LIZA NURSANTY, DR., SP.B, M.KES, FINACS', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('46', 1, 1, 1, 1, 'AHMAD AGIL, DR., SP.U', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('47', 1, 1, 1, 6, 'BIDAN BKIA', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('48', 1, 1, 1, 18, 'KUSHARI SUSANTO NB, DRG.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('49', 1, 1, 1, 10, 'DENDI PUJI WAHYUDI, DR., SP.JP.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('5', 1, 1, 1, 11, 'YENI ANDAYANI, HJ. DR. SP.A.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('50', 1, 1, 1, 10, 'HARVI PUSPA WARDANI, DR., SP.JP.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('51', 1, 1, 1, 21, 'ALI BUDI HARSONO, DR., SP.OG(K).', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('52', 1, 1, 1, 21, 'ANNISA, DR., SP.OG.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('53', 1, 1, 1, 21, 'ARIF TRIBAWONO, DR., SP.OG., M.KES.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('54', 1, 1, 1, 21, 'INDAH MAHARANI, DR. SP.OG', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('55', 1, 1, 1, 25, 'DICKY ROSYADI, DR.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('56', 1, 1, 1, 7, 'ANDI FAUZIAH, DR., SP.KK', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('57', 1, 1, 1, 13, 'GILANG MUTIARA, DR., SP. M', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('58', 1, 1, 1, 23, 'KHAMSHA NOORY FINALISYA, , S.PSI, MPSI', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('59', 1, 1, 1, 17, 'ABDILLA RIDHWAN IRIANTO, DR., SP.BP-RE.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('6', 1, 1, 1, 9, 'DENY HERMANA, DR, SP.OT.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('60', 1, 1, 1, 6, 'KIKI LUKMAN, DR., SP.B (K) BD.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('61', 1, 1, 1, 18, 'R. GINANDJAR ASLAMA MAULID, DRG.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('62', 1, 1, 1, 18, 'RINA JOEANDA, DRG.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('63', 1, 1, 1, 19, 'GAGA IRAWAN,DR. DR., SP.GK, M.GIZI', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('64', 1, 1, 1, 19, 'IKBAL GENTAR ALAM, DR. SP. GK. M.KES.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('65', 1, 1, 1, 10, 'CHARLOTTE JOHANNA COOL, DR., SPJP, FIHA', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('66', 1, 1, 1, 10, 'RATNA NURMELIANI, DR., SPJP', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('67', 1, 1, 1, 21, 'HILMAN, DR., SP.OG', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('68', 1, 1, 1, 7, 'IRMA JANTHY, DR., SP.KK', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('69', 1, 1, 1, 26, 'YOURI ADRINATA SAYUTO, DRG., SP. ORT', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('7', 1, 1, 1, 3, 'ARIF BUDIMAN, DR,. SP. B (K) A', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('70', 1, 1, 1, 5, 'YANA AKHMAD, DR., DR., SP.PD (K).', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('71', 1, 1, 1, 28, 'DEWI LIDYA ICHWANA, DRG., SP.PERIO', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('72', 1, 1, 1, 23, 'SELLA FAUZIAH RAHMAH PERMATA', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('73', 1, 1, 1, 4, 'DASWARA DJAJASASMITA, DR., SP.S', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('74', 1, 1, 1, 6, 'DIPO KENTJONO, DRG., SP.BM', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('75', 1, 1, 1, 5, 'RESNO HADIONO ADELA, DR., SP.PD.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('76', 1, 1, 1, 18, 'ANNA NURWULAN, HJ. DRG.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('77', 1, 1, 1, 10, 'APRILIANASARY UTAMI DEWI, DR., SP.JP.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('78', 1, 1, 1, 25, 'MAHMUD MUHYIDDIN, DR', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('79', 1, 1, 1, 25, 'WAHYU PITRA RAHAYU, DR.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('8', 1, 1, 1, 6, 'SRI UTARI,DRG., SPBM', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('80', 1, 1, 1, 7, 'MIRANTI PANGASTUTI, DR., SPKK', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('81', 1, 1, 1, 13, 'ANDRIAFI SYAH, DR.,SP.M.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('82', 1, 1, 1, 26, 'MOUNA YASMIEN, DRG., SP. ORT', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('83', 1, 1, 1, 27, 'ASRI SATIVA, DRG., SP.KGA', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('84', 1, 1, 1, 6, 'ACHMAD PETER SYARIEF, DR., SP.BTKV.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('85', 1, 1, 1, 11, 'NUR SURYAWAN, DR., SP.A.(K)', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('86', 1, 1, 1, 6, 'BAMBANG A.S. SULTHANA, DR., SP.B (K) BD.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('87', 1, 1, 1, 20, 'DIAN KARTINA, DRG., SP.KG', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('88', 1, 1, 1, 10, 'M. RIZKI AKBAR, DR. DR.,SP.JP (K), M. KES', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('89', 1, 1, 1, 7, 'OKI SUWARSA,DR.,DR., SPKK(K)., M. KES', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('9', 1, 1, 1, 9, 'DADANG RUKANTA, H. DR., SP.OT.FICS., M.KES.', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('90', 1, 1, 1, 13, 'R. ANGGA KARTIWA, DR., SP.M (K).,M.KES', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung'),
('91', 1, 1, 1, 5, 'AMELIA ANDRIANI, DR.,SP.PD.,M.KES', 'L', 'Bandung', '1970-01-01', 'Cibiru', '088872811129', '0101', 'UIN Bandung');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_gedung_rawat_inap`
--

CREATE TABLE `tbl_gedung_rawat_inap` (
  `kode_gedung_rawat_inap` varchar(20) NOT NULL,
  `nama_gedung` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_gedung_rawat_inap`
--

INSERT INTO `tbl_gedung_rawat_inap` (`kode_gedung_rawat_inap`, `nama_gedung`) VALUES
('GC', 'GEDUNG CICIK'),
('GC1', 'GEDUNG CHANDRA'),
('GD00001', 'GEDUNG A'),
('GD00002', 'GEDUNG B'),
('GD00003', 'GEDUNG C'),
('GDCND', 'GEDUNG CUT NYAK DHIEN'),
('GDMLYHT', 'GEDUNG MALAYAHATI'),
('TKMR', 'GEDUNG TEUKU UMAR');

--
-- Trigger `tbl_gedung_rawat_inap`
--
DELIMITER $$
CREATE TRIGGER `incrementKode` BEFORE INSERT ON `tbl_gedung_rawat_inap` FOR EACH ROW BEGIN
     declare kode_gedung_rawat_inap_orig varchar(20);
     declare kode_counter int;
     set kode_gedung_rawat_inap_orig = new.kode_gedung_rawat_inap;
     set kode_counter = 1;
     while exists (select true from tbl_gedung_rawat_inap where kode_gedung_rawat_inap = new.kode_gedung_rawat_inap) do
        set new.kode_gedung_rawat_inap = concat(kode_gedung_rawat_inap_orig, kode_counter); 
        set kode_counter = kode_counter + 1;
     end while;

  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_gol_darah`
--

CREATE TABLE `tbl_gol_darah` (
  `id_gol_darah` int NOT NULL,
  `nama_gol_darah` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_gol_darah`
--

INSERT INTO `tbl_gol_darah` (`id_gol_darah`, `nama_gol_darah`) VALUES
(1, 'A'),
(2, 'B'),
(3, 'AB'),
(4, 'O');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jabatan`
--

CREATE TABLE `tbl_jabatan` (
  `id_jabatan` int NOT NULL,
  `nama_jabatan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jabatan`
--

INSERT INTO `tbl_jabatan` (`id_jabatan`, `nama_jabatan`) VALUES
(1, 'JABATAN 1'),
(2, 'JABATAN 2'),
(3, 'PENGANGGUNG JAWAB LAB'),
(4, 'KARYAWAN KEUANGAN'),
(5, 'APOTEKER');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jadwal_praktek_dokter`
--

CREATE TABLE `tbl_jadwal_praktek_dokter` (
  `id_jadwal` int NOT NULL,
  `kode_dokter` varchar(20) NOT NULL,
  `hari` varchar(13) NOT NULL,
  `jam_mulai` time(6) NOT NULL,
  `jam_selesai` time(6) NOT NULL,
  `id_poliklinik` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jadwal_praktek_dokter`
--

INSERT INTO `tbl_jadwal_praktek_dokter` (`id_jadwal`, `kode_dokter`, `hari`, `jam_mulai`, `jam_selesai`, `id_poliklinik`) VALUES
(6, '1', 'SENIN', '07:30:00.000000', '09:00:00.000000', 1),
(7, '2', 'SENIN', '14:00:00.000000', '16:00:00.000000', 1),
(8, '3', 'SENIN', '08:00:00.000000', '10:00:00.000000', 1),
(9, '4', 'SENIN', '07:50:00.000000', '10:00:00.000000', 1),
(10, '5', 'SENIN', '09:00:00.000000', '12:00:00.000000', 1),
(11, '3', 'SENIN', '11:00:00.000000', '13:00:00.000000', 1),
(12, '4', 'SENIN', '10:00:00.000000', '12:00:00.000000', 2),
(13, '6', 'SENIN', '08:00:00.000000', '10:00:00.000000', 3),
(14, '7', 'SENIN', '15:00:00.000000', '16:00:00.000000', 4),
(15, '8', 'SENIN', '09:00:00.000000', '11:00:00.000000', 5),
(16, '9', 'SENIN', '10:00:00.000000', '12:00:00.000000', 6),
(17, '10', 'SENIN', '16:00:00.000000', '17:00:00.000000', 7),
(18, '11', 'SENIN', '08:00:00.000000', '10:00:00.000000', 8),
(19, '12', 'SENIN', '10:00:00.000000', '12:00:00.000000', 9),
(20, '13', 'SENIN', '14:00:00.000000', '16:00:00.000000', 10),
(21, '14', 'SENIN', '09:00:00.000000', '12:00:00.000000', 11),
(22, '15', 'SENIN', '09:00:00.000000', '12:00:00.000000', 12),
(23, '16', 'SENIN', '09:00:00.000000', '12:00:00.000000', 12),
(24, '17', 'SENIN', '10:00:00.000000', '12:00:00.000000', 13),
(25, '18', 'SENIN', '09:00:00.000000', '12:00:00.000000', 14),
(26, '19', 'SENIN', '15:30:00.000000', '16:00:00.000000', 14),
(27, '20', 'SENIN', '10:00:00.000000', '15:00:00.000000', 14),
(28, '21', 'SENIN', '09:00:00.000000', '12:00:00.000000', 14),
(29, '22', 'SENIN', '14:00:00.000000', '15:00:00.000000', 15),
(30, '23', 'SENIN', '15:00:00.000000', '16:30:00.000000', 16),
(31, '22', 'SENIN', '09:00:00.000000', '12:00:00.000000', 16),
(32, '24', 'SENIN', '15:00:00.000000', '17:00:00.000000', 16),
(33, '25', 'SENIN', '10:00:00.000000', '12:00:00.000000', 17),
(34, '26', 'SENIN', '10:00:00.000000', '12:00:00.000000', 18),
(35, '27', 'SENIN', '14:00:00.000000', '16:00:00.000000', 19),
(36, '28', 'SENIN', '12:30:00.000000', '14:00:00.000000', 20),
(37, '29', 'SENIN', '10:00:00.000000', '12:00:00.000000', 21),
(38, '30', 'SENIN', '17:00:00.000000', '18:00:00.000000', 22),
(39, '31', 'SENIN', '12:00:00.000000', '15:00:00.000000', 22),
(40, '32', 'SENIN', '11:00:00.000000', '13:00:00.000000', 22),
(41, '33', 'SENIN', '14:30:00.000000', '16:00:00.000000', 22),
(42, '34', 'SENIN', '14:00:00.000000', '15:00:00.000000', 22),
(43, '34', 'SENIN', '09:00:00.000000', '13:00:00.000000', 23),
(44, '35', 'SENIN', '08:00:00.000000', '10:00:00.000000', 24),
(45, '31', 'SENIN', '10:00:00.000000', '12:00:00.000000', 24),
(46, '32', 'SENIN', '09:00:00.000000', '11:00:00.000000', 24),
(47, '34', 'SENIN', '14:00:00.000000', '16:00:00.000000', 24),
(48, '36', 'SENIN', '13:00:00.000000', '14:00:00.000000', 25),
(49, '37', 'SENIN', '08:00:00.000000', '14:00:00.000000', 26),
(50, '38', 'SENIN', '10:00:00.000000', '12:00:00.000000', 27),
(51, '39', 'SENIN', '08:00:00.000000', '11:00:00.000000', 28),
(52, '40', 'SENIN', '11:00:00.000000', '14:00:00.000000', 28),
(53, '39', 'SENIN', '11:00:00.000000', '13:00:00.000000', 29),
(54, '40', 'SENIN', '09:00:00.000000', '11:00:00.000000', 29),
(55, '41', 'SENIN', '16:00:00.000000', '17:00:00.000000', 30),
(56, '25', 'SELASA', '14:00:00.000000', '15:00:00.000000', 31),
(57, '1', 'SELASA', '07:30:00.000000', '09:00:00.000000', 1),
(58, '42', 'SELASA', '15:00:00.000000', '16:00:00.000000', 1),
(59, '4', 'SELASA', '09:00:00.000000', '12:00:00.000000', 1),
(60, '5', 'SELASA', '08:00:00.000000', '10:00:00.000000', 1),
(61, '3', 'SELASA', '11:00:00.000000', '13:00:00.000000', 1),
(62, '3', 'SELASA', '10:00:00.000000', '12:00:00.000000', 2),
(63, '9', 'SELASA', '10:00:00.000000', '12:00:00.000000', 3),
(64, '43', 'SELASA', '11:00:00.000000', '13:00:00.000000', 5),
(65, '6', 'SELASA', '08:00:00.000000', '10:00:00.000000', 6),
(66, '44', 'SELASA', '17:00:00.000000', '17:30:00.000000', 7),
(67, '12', 'SELASA', '10:00:00.000000', '12:00:00.000000', 8),
(68, '45', 'SELASA', '10:00:00.000000', '12:00:00.000000', 9),
(69, '46', 'SELASA', '09:00:00.000000', '12:00:00.000000', 10),
(70, '47', 'SELASA', '10:00:00.000000', '12:00:00.000000', 32),
(71, '14', 'SELASA', '09:00:00.000000', '12:00:00.000000', 11),
(72, '48', 'SELASA', '09:00:00.000000', '12:00:00.000000', 12),
(73, '15', 'SELASA', '09:00:00.000000', '12:00:00.000000', 12),
(74, '17', 'SELASA', '10:00:00.000000', '12:00:00.000000', 13),
(75, '49', 'SELASA', '14:00:00.000000', '16:00:00.000000', 14),
(76, '18', 'SELASA', '09:00:00.000000', '12:00:00.000000', 14),
(77, '50', 'SELASA', '08:00:00.000000', '10:30:00.000000', 14),
(78, '19', 'SELASA', '15:30:00.000000', '16:00:00.000000', 14),
(79, '20', 'SELASA', '10:00:00.000000', '12:30:00.000000', 14),
(80, '51', 'SELASA', '16:30:00.000000', '17:00:00.000000', 15),
(81, '52', 'SELASA', '12:00:00.000000', '13:00:00.000000', 15),
(82, '53', 'SELASA', '16:30:00.000000', '17:00:00.000000', 15),
(83, '51', 'SELASA', '16:00:00.000000', '16:30:00.000000', 16),
(84, '52', 'SELASA', '09:00:00.000000', '12:00:00.000000', 16),
(85, '53', 'SELASA', '15:00:00.000000', '16:30:00.000000', 16),
(86, '54', 'SELASA', '13:00:00.000000', '15:00:00.000000', 16),
(87, '55', 'SELASA', '10:00:00.000000', '12:00:00.000000', 17),
(88, '56', 'SELASA', '10:00:00.000000', '12:00:00.000000', 18),
(89, '57', 'SELASA', '10:00:00.000000', '12:00:00.000000', 19),
(90, '29', 'SELASA', '10:00:00.000000', '12:00:00.000000', 21),
(91, '35', 'SELASA', '07:30:00.000000', '09:00:00.000000', 22),
(92, '31', 'SELASA', '12:00:00.000000', '15:00:00.000000', 22),
(93, '34', 'SELASA', '10:00:00.000000', '12:00:00.000000', 23),
(94, '31', 'SELASA', '10:00:00.000000', '12:00:00.000000', 24),
(95, '32', 'SELASA', '07:30:00.000000', '09:00:00.000000', 24),
(96, '34', 'SELASA', '08:30:00.000000', '10:00:00.000000', 24),
(97, '44', 'SELASA', '16:00:00.000000', '17:00:00.000000', 33),
(98, '37', 'SELASA', '08:00:00.000000', '14:00:00.000000', 26),
(99, '58', 'SELASA', '10:00:00.000000', '12:00:00.000000', 27),
(100, '39', 'SELASA', '08:00:00.000000', '11:00:00.000000', 28),
(101, '40', 'SELASA', '11:00:00.000000', '14:00:00.000000', 28),
(102, '39', 'SELASA', '11:00:00.000000', '13:00:00.000000', 29),
(103, '40', 'SELASA', '09:00:00.000000', '11:00:00.000000', 29),
(104, '41', 'SELASA', '16:00:00.000000', '17:00:00.000000', 30),
(105, '59', 'RABU', '10:00:00.000000', '12:00:00.000000', 34),
(106, '13', 'RABU', '14:00:00.000000', '15:00:00.000000', 35),
(107, '2', 'RABU', '14:00:00.000000', '16:00:00.000000', 1),
(108, '3', 'RABU', '07:30:00.000000', '09:00:00.000000', 1),
(109, '4', 'RABU', '08:00:00.000000', '10:00:00.000000', 1),
(110, '5', 'RABU', '07:59:00.000000', '10:00:00.000000', 1),
(111, '1', 'RABU', '11:00:00.000000', '13:00:00.000000', 1),
(112, '5', 'RABU', '10:00:00.000000', '12:00:00.000000', 2),
(113, '6', 'RABU', '08:00:00.000000', '10:00:00.000000', 3),
(114, '7', 'RABU', '15:00:00.000000', '16:00:00.000000', 4),
(115, '60', 'RABU', '15:00:00.000000', '16:00:00.000000', 36),
(116, '9', 'RABU', '10:00:00.000000', '12:00:00.000000', 6),
(117, '59', 'RABU', '13:00:00.000000', '14:00:00.000000', 37),
(118, '45', 'RABU', '10:00:00.000000', '12:00:00.000000', 8),
(119, '11', 'RABU', '10:00:00.000000', '12:00:00.000000', 9),
(120, '61', 'RABU', '09:00:00.000000', '12:00:00.000000', 12),
(121, '62', 'RABU', '09:00:00.000000', '12:00:00.000000', 12),
(122, '63', 'RABU', '14:00:00.000000', '16:00:00.000000', 13),
(123, '64', 'RABU', '09:00:00.000000', '12:00:00.000000', 13),
(124, '65', 'RABU', '12:00:00.000000', '14:00:00.000000', 14),
(125, '18', 'RABU', '09:00:00.000000', '12:00:00.000000', 14),
(126, '50', 'RABU', '14:00:00.000000', '17:00:00.000000', 14),
(127, '66', 'RABU', '08:00:00.000000', '12:00:00.000000', 14),
(128, '21', 'RABU', '09:00:00.000000', '12:00:00.000000', 14),
(129, '22', 'RABU', '14:00:00.000000', '15:00:00.000000', 15),
(130, '67', 'RABU', '16:30:00.000000', '17:00:00.000000', 15),
(131, '22', 'RABU', '09:00:00.000000', '12:00:00.000000', 16),
(132, '67', 'RABU', '15:00:00.000000', '16:30:00.000000', 16),
(133, '25', 'RABU', '10:00:00.000000', '12:00:00.000000', 17),
(134, '68', 'RABU', '13:00:00.000000', '14:00:00.000000', 18),
(135, '26', 'RABU', '09:00:00.000000', '10:30:00.000000', 18),
(136, '57', 'RABU', '10:00:00.000000', '12:00:00.000000', 19),
(137, '69', 'RABU', '09:00:00.000000', '12:00:00.000000', 20),
(138, '29', 'RABU', '10:00:00.000000', '12:00:00.000000', 21),
(139, '30', 'RABU', '17:00:00.000000', '18:00:00.000000', 22),
(140, '32', 'RABU', '11:00:00.000000', '13:00:00.000000', 22),
(141, '34', 'RABU', '08:00:00.000000', '10:00:00.000000', 22),
(142, '70', 'RABU', '17:00:00.000000', '18:00:00.000000', 22),
(143, '34', 'RABU', '09:00:00.000000', '13:00:00.000000', 23),
(144, '32', 'RABU', '09:00:00.000000', '11:00:00.000000', 24),
(145, '33', 'RABU', '14:30:00.000000', '16:00:00.000000', 24),
(146, '71', 'RABU', '09:00:00.000000', '12:00:00.000000', 38),
(147, '37', 'RABU', '08:00:00.000000', '14:00:00.000000', 26),
(148, '72', 'RABU', '10:00:00.000000', '12:00:00.000000', 27),
(149, '38', 'RABU', '10:00:00.000000', '12:00:00.000000', 27),
(150, '73', 'RABU', '09:00:00.000000', '13:00:00.000000', 28),
(151, '39', 'RABU', '09:00:00.000000', '11:00:00.000000', 29),
(152, '40', 'RABU', '11:00:00.000000', '13:00:00.000000', 29),
(153, '41', 'RABU', '16:00:00.000000', '17:00:00.000000', 30),
(154, '3', 'KAMIS', '07:30:00.000000', '09:00:00.000000', 1),
(155, '42', 'KAMIS', '15:00:00.000000', '16:00:00.000000', 1),
(156, '4', 'KAMIS', '09:00:00.000000', '12:00:00.000000', 1),
(157, '5', 'KAMIS', '08:00:00.000000', '10:00:00.000000', 1),
(158, '3', 'KAMIS', '11:00:00.000000', '13:00:00.000000', 1),
(159, '1', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 2),
(160, '6', 'KAMIS', '08:00:00.000000', '10:00:00.000000', 3),
(161, '74', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 5),
(162, '9', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 6),
(163, '11', 'KAMIS', '08:00:00.000000', '10:00:00.000000', 8),
(164, '12', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 9),
(165, '46', 'KAMIS', '09:00:00.000000', '12:00:00.000000', 10),
(166, '62', 'KAMIS', '09:00:00.000000', '12:00:00.000000', 12),
(167, '17', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 13),
(168, '18', 'KAMIS', '09:00:00.000000', '12:00:00.000000', 14),
(169, '50', 'KAMIS', '14:00:00.000000', '17:00:00.000000', 14),
(170, '19', 'KAMIS', '15:30:00.000000', '16:00:00.000000', 14),
(171, '20', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 14),
(172, '51', 'KAMIS', '16:30:00.000000', '17:00:00.000000', 15),
(173, '52', 'KAMIS', '12:00:00.000000', '13:00:00.000000', 15),
(174, '51', 'KAMIS', '16:00:00.000000', '16:30:00.000000', 16),
(175, '23', 'KAMIS', '15:00:00.000000', '16:30:00.000000', 16),
(176, '52', 'KAMIS', '09:00:00.000000', '12:00:00.000000', 16),
(177, '55', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 17),
(178, '56', 'KAMIS', '14:00:00.000000', '15:00:00.000000', 18),
(179, '26', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 18),
(180, '57', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 19),
(181, '28', 'KAMIS', '12:30:00.000000', '14:00:00.000000', 20),
(182, '29', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 21),
(183, '35', 'KAMIS', '08:00:00.000000', '10:00:00.000000', 22),
(184, '31', 'KAMIS', '12:00:00.000000', '15:00:00.000000', 22),
(185, '32', 'KAMIS', '11:00:00.000000', '13:00:00.000000', 22),
(186, '75', 'KAMIS', '08:00:00.000000', '12:00:00.000000', 22),
(187, '31', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 24),
(188, '32', 'KAMIS', '09:00:00.000000', '11:00:00.000000', 24),
(189, '34', 'KAMIS', '08:30:00.000000', '10:00:00.000000', 24),
(190, '36', 'KAMIS', '13:00:00.000000', '14:00:00.000000', 25),
(191, '37', 'KAMIS', '08:00:00.000000', '14:00:00.000000', 26),
(192, '72', 'KAMIS', '10:00:00.000000', '12:00:00.000000', 27),
(193, '73', 'KAMIS', '09:00:00.000000', '11:00:00.000000', 28),
(194, '39', 'KAMIS', '08:00:00.000000', '11:00:00.000000', 28),
(195, '40', 'KAMIS', '11:00:00.000000', '14:00:00.000000', 28),
(196, '39', 'KAMIS', '11:00:00.000000', '13:00:00.000000', 29),
(197, '40', 'KAMIS', '09:00:00.000000', '11:00:00.000000', 29),
(198, '41', 'KAMIS', '16:00:00.000000', '17:00:00.000000', 30),
(199, '1', 'JUMAT', '08:00:00.000000', '10:00:00.000000', 1),
(200, '2', 'JUMAT', '14:00:00.000000', '16:00:00.000000', 1),
(201, '4', 'JUMAT', '08:00:00.000000', '11:00:00.000000', 1),
(202, '5', 'JUMAT', '09:00:00.000000', '12:00:00.000000', 1),
(203, '1', 'JUMAT', '11:00:00.000000', '13:00:00.000000', 1),
(204, '2', 'JUMAT', '13:00:00.000000', '15:00:00.000000', 2),
(205, '3', 'JUMAT', '10:00:00.000000', '12:00:00.000000', 2),
(206, '9', 'JUMAT', '10:00:00.000000', '12:00:00.000000', 3),
(207, '7', 'JUMAT', '15:00:00.000000', '16:00:00.000000', 4),
(208, '6', 'JUMAT', '08:00:00.000000', '10:00:00.000000', 6),
(209, '12', 'JUMAT', '10:00:00.000000', '12:00:00.000000', 8),
(210, '45', 'JUMAT', '10:00:00.000000', '12:00:00.000000', 9),
(211, '13', 'JUMAT', '14:00:00.000000', '15:00:00.000000', 10),
(212, '76', 'JUMAT', '09:00:00.000000', '12:00:00.000000', 12),
(213, '48', 'JUMAT', '09:00:00.000000', '12:00:00.000000', 12),
(214, '16', 'JUMAT', '09:00:00.000000', '12:00:00.000000', 12),
(215, '64', 'JUMAT', '09:00:00.000000', '12:00:00.000000', 13),
(216, '77', 'JUMAT', '09:00:00.000000', '11:30:00.000000', 14),
(217, '18', 'JUMAT', '08:00:00.000000', '11:00:00.000000', 14),
(218, '66', 'JUMAT', '14:00:00.000000', '16:00:00.000000', 14),
(219, '20', 'JUMAT', '10:00:00.000000', '15:00:00.000000', 14),
(220, '21', 'JUMAT', '13:00:00.000000', '15:00:00.000000', 14),
(221, '24', 'JUMAT', '16:00:00.000000', '17:00:00.000000', 15),
(222, '54', 'JUMAT', '12:00:00.000000', '13:00:00.000000', 15),
(223, '24', 'JUMAT', '13:00:00.000000', '16:00:00.000000', 16),
(224, '67', 'JUMAT', '16:00:00.000000', '17:00:00.000000', 16),
(225, '54', 'JUMAT', '09:00:00.000000', '12:00:00.000000', 16),
(226, '78', 'JUMAT', '10:00:00.000000', '12:00:00.000000', 17),
(227, '25', 'JUMAT', '10:00:00.000000', '12:00:00.000000', 17),
(228, '79', 'JUMAT', '10:00:00.000000', '12:00:00.000000', 17),
(229, '80', 'JUMAT', '13:00:00.000000', '15:00:00.000000', 18),
(230, '26', 'JUMAT', '09:00:00.000000', '10:30:00.000000', 18),
(231, '81', 'JUMAT', '14:00:00.000000', '16:00:00.000000', 19),
(232, '82', 'JUMAT', '13:00:00.000000', '14:00:00.000000', 20),
(233, '29', 'JUMAT', '09:30:00.000000', '11:00:00.000000', 21),
(234, '83', 'JUMAT', '09:00:00.000000', '12:00:00.000000', 39),
(235, '31', 'JUMAT', '12:00:00.000000', '15:00:00.000000', 22),
(236, '32', 'JUMAT', '11:00:00.000000', '13:00:00.000000', 22),
(237, '33', 'JUMAT', '14:30:00.000000', '16:00:00.000000', 22),
(238, '34', 'JUMAT', '09:00:00.000000', '13:00:00.000000', 23),
(239, '31', 'JUMAT', '10:00:00.000000', '12:00:00.000000', 24),
(240, '32', 'JUMAT', '09:00:00.000000', '11:00:00.000000', 24),
(241, '34', 'JUMAT', '14:00:00.000000', '16:00:00.000000', 24),
(242, '37', 'JUMAT', '08:00:00.000000', '14:00:00.000000', 26),
(243, '58', 'JUMAT', '10:00:00.000000', '12:00:00.000000', 27),
(244, '73', 'JUMAT', '09:00:00.000000', '11:00:00.000000', 28),
(245, '39', 'JUMAT', '08:00:00.000000', '11:00:00.000000', 28),
(246, '40', 'JUMAT', '11:00:00.000000', '14:00:00.000000', 28),
(247, '39', 'JUMAT', '11:00:00.000000', '13:00:00.000000', 29),
(248, '40', 'JUMAT', '09:00:00.000000', '11:00:00.000000', 29),
(249, '41', 'JUMAT', '16:00:00.000000', '17:00:00.000000', 30),
(250, '59', 'SABTU', '08:00:00.000000', '10:00:00.000000', 34),
(251, '84', 'SABTU', '09:00:00.000000', '10:00:00.000000', 40),
(252, '3', 'SABTU', '07:30:00.000000', '09:00:00.000000', 1),
(253, '85', 'SABTU', '09:00:00.000000', '12:00:00.000000', 1),
(254, '4', 'SABTU', '08:59:00.000000', '11:00:00.000000', 1),
(255, '5', 'SABTU', '09:00:00.000000', '12:00:00.000000', 1),
(256, '1', 'SABTU', '10:00:00.000000', '12:00:00.000000', 1),
(257, '1', 'SABTU', '10:00:00.000000', '12:00:00.000000', 2),
(258, '86', 'SABTU', '13:00:00.000000', '14:00:00.000000', 36),
(259, '43', 'SABTU', '08:00:00.000000', '11:00:00.000000', 5),
(260, '84', 'SABTU', '10:00:00.000000', '12:00:00.000000', 41),
(261, '45', 'SABTU', '08:30:00.000000', '10:00:00.000000', 8),
(262, '11', 'SABTU', '10:00:00.000000', '12:00:00.000000', 9),
(263, '46', 'SABTU', '09:00:00.000000', '12:00:00.000000', 10),
(264, '47', 'SABTU', '10:00:00.000000', '12:00:00.000000', 32),
(265, '87', 'SABTU', '10:00:00.000000', '13:00:00.000000', 11),
(266, '76', 'SABTU', '09:00:00.000000', '12:00:00.000000', 12),
(267, '61', 'SABTU', '09:00:00.000000', '12:00:00.000000', 12),
(268, '63', 'SABTU', '13:00:00.000000', '14:00:00.000000', 13),
(269, '49', 'SABTU', '09:00:00.000000', '11:00:00.000000', 14),
(270, '88', 'SABTU', '08:00:00.000000', '10:00:00.000000', 14),
(271, '21', 'SABTU', '09:00:00.000000', '12:00:00.000000', 14),
(272, '18', 'SABTU', '08:00:00.000000', '09:00:00.000000', 42),
(273, '54', 'SABTU', '12:00:00.000000', '13:00:00.000000', 15),
(274, '53', 'SABTU', '13:00:00.000000', '15:00:00.000000', 16),
(275, '54', 'SABTU', '09:00:00.000000', '12:00:00.000000', 16),
(276, '79', 'SABTU', '10:00:00.000000', '12:00:00.000000', 17),
(277, '56', 'SABTU', '09:00:00.000000', '11:30:00.000000', 18),
(278, '89', 'SABTU', '13:00:00.000000', '14:00:00.000000', 18),
(279, '90', 'SABTU', '14:00:00.000000', '15:00:00.000000', 19),
(280, '27', 'SABTU', '10:00:00.000000', '12:00:00.000000', 19),
(281, '69', 'SABTU', '09:00:00.000000', '12:00:00.000000', 20),
(282, '91', 'SABTU', '08:00:00.000000', '10:00:00.000000', 22),
(283, '70', 'SABTU', '11:00:00.000000', '13:00:00.000000', 22),
(284, '30', 'SABTU', '08:00:00.000000', '11:00:00.000000', 24),
(285, '70', 'SABTU', '09:00:00.000000', '11:00:00.000000', 24),
(286, '37', 'SABTU', '08:00:00.000000', '12:00:00.000000', 26),
(287, '38', 'SABTU', '10:00:00.000000', '12:00:00.000000', 27),
(288, '73', 'SABTU', '09:00:00.000000', '11:00:00.000000', 28),
(289, '73', 'SABTU', '11:00:00.000000', '12:00:00.000000', 29);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jenis_bayar`
--

CREATE TABLE `tbl_jenis_bayar` (
  `id_jenis_bayar` int NOT NULL,
  `jenis_bayar` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jenis_bayar`
--

INSERT INTO `tbl_jenis_bayar` (`id_jenis_bayar`, `jenis_bayar`) VALUES
(1, 'Bayar Sendiri'),
(2, 'BPJS');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jenjang`
--

CREATE TABLE `tbl_jenjang` (
  `kode_jenjang` varchar(10) NOT NULL,
  `nama_jenjang` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jenjang`
--

INSERT INTO `tbl_jenjang` (`kode_jenjang`, `nama_jenjang`) VALUES
('J1', 'JENJANG 1'),
('J2', 'JENJANG 2'),
('J3', 'JENJANG 3'),
('J4', 'JENJANG 4');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jenjang_pendidikan`
--

CREATE TABLE `tbl_jenjang_pendidikan` (
  `id_jenjang_pendidikan` int NOT NULL,
  `jenjang_pendidikan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jenjang_pendidikan`
--

INSERT INTO `tbl_jenjang_pendidikan` (`id_jenjang_pendidikan`, `jenjang_pendidikan`) VALUES
(1, 'SD'),
(2, 'SMP'),
(3, 'SMA'),
(4, 'D3'),
(5, 'D4'),
(6, 'S1'),
(7, 'S2');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kategori_barang`
--

CREATE TABLE `tbl_kategori_barang` (
  `id_kategori_barang` int NOT NULL,
  `nama_kategori` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_kategori_barang`
--

INSERT INTO `tbl_kategori_barang` (`id_kategori_barang`, `nama_kategori`) VALUES
(1, 'Obat Penenang'),
(2, 'Obat Tidur'),
(3, 'Infus'),
(4, 'Obat Batuk'),
(5, 'Obat Flu'),
(6, 'Obat Lainnya');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kategori_harga_brg`
--

CREATE TABLE `tbl_kategori_harga_brg` (
  `id_kategori_harga_brg` int NOT NULL,
  `nama_kategori_harga_brg` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_kategori_harga_brg`
--

INSERT INTO `tbl_kategori_harga_brg` (`id_kategori_harga_brg`, `nama_kategori_harga_brg`) VALUES
(1, 'Generik'),
(2, 'Umum');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kategori_tindakan`
--

CREATE TABLE `tbl_kategori_tindakan` (
  `kode_kategori_tindakan` varchar(6) NOT NULL,
  `kategori_tindakan` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_kategori_tindakan`
--

INSERT INTO `tbl_kategori_tindakan` (`kode_kategori_tindakan`, `kategori_tindakan`) VALUES
('BM01', 'Bedah Mata'),
('GG001', 'Tindakan Gigi'),
('ILJ1', 'INTERVENSI LAYANAN JANTUNG'),
('JT001', 'Tindakan Jantung'),
('PL01', 'BEDAH PLASTIK'),
('TBA1', 'BEDAH ANAK');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kelas_ruang_ranap`
--

CREATE TABLE `tbl_kelas_ruang_ranap` (
  `id_kelas_ruang_ranap` int NOT NULL,
  `nama_kelas_ruang_ranap` varchar(50) NOT NULL,
  `deskripsi_kelas_ruang_ranap` text CHARACTER SET latin1 COLLATE latin1_swedish_ci
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_kelas_ruang_ranap`
--

INSERT INTO `tbl_kelas_ruang_ranap` (`id_kelas_ruang_ranap`, `nama_kelas_ruang_ranap`, `deskripsi_kelas_ruang_ranap`) VALUES
(1, 'VVIP', ''),
(2, 'VIP', ''),
(3, 'KELAS 1', ''),
(4, 'KELAS 2', ''),
(5, 'KELAS 3', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_menu`
--

CREATE TABLE `tbl_menu` (
  `id_menu` int NOT NULL,
  `title` varchar(50) NOT NULL,
  `url` varchar(30) NOT NULL,
  `icon` varchar(30) NOT NULL,
  `is_main_menu` int NOT NULL,
  `is_aktif` enum('y','n') NOT NULL COMMENT 'y=yes,n=no',
  `tabel` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_menu`
--

INSERT INTO `tbl_menu` (`id_menu`, `title`, `url`, `icon`, `is_main_menu`, `is_aktif`, `tabel`) VALUES
(1, 'KELOLA MENU', 'kelolamenu', 'fa fa-server', 0, 'y', 'tbl_menu'),
(2, 'KELOLA PENGGUNA', 'user', 'fa fa-users', 0, 'y', 'tbl_user'),
(3, 'level PENGGUNA', 'userlevel', 'fa fa-users', 0, 'n', NULL),
(6, 'DATA JENJANG', 'jenjang', 'fa fa-chart-area', 19, 'y', NULL),
(7, 'DATA JABATAN', 'jabatan', 'fa fa-briefcase', 19, 'y', NULL),
(8, 'DATA PEGAWAI', 'pegawai', 'fa fa-user-friends', 0, 'y', 'tbl_pegawai'),
(9, 'Contoh Form', 'welcome/form', 'fa fa-id-card', 0, 'n', NULL),
(13, 'DATA DOKTER', 'dokter', 'fa fa-graduation-cap', 0, 'y', 'tbl_dokter'),
(14, 'JADWAL PRAKTEK DOKTER', 'jadwalpraktek', 'fa fa-calendar', 0, 'y', 'tbl_jadwal_praktek_dokter'),
(15, 'DATA POLIKLINIK', 'poliklinik', 'fa fa-university', 19, 'y', NULL),
(16, 'DATA SPESIALIS', 'spesialis', 'fa fa-heartbeat', 19, 'y', NULL),
(17, 'DATA DEPARTEMEN', 'departemen', 'fa fa-building', 19, 'y', NULL),
(18, 'DATA BIDANG PEGAWAI', 'bidang', 'fa fa-binoculars', 19, 'y', NULL),
(19, 'data master', '#', 'fa fa-id-card', 0, 'y', NULL),
(20, 'data gedung', 'gedung', 'fa fa-hospital', 19, 'y', NULL),
(21, 'data pasien', 'pasien', 'fa fa-user-injured', 0, 'y', 'tbl_pasien'),
(22, 'form pendaftaran', 'pendaftaran/create', 'fa fa-receipt', 0, 'y', NULL),
(23, 'data ruang rawat inap', 'ruangranap', 'fa fa-building', 19, 'y', NULL),
(24, 'data tempat tidur', 'tempattidur', 'fa fa-bed', 0, 'y', 'tbl_tempat_tidur'),
(25, 'laporan rawat jalan', 'pendaftaran/ralan', 'fa fa-clinic-medical', 0, 'y', 'tbl_rawat_inap'),
(26, 'laporan rawat inap', 'pendaftaran/ranap', 'fa fa-id-card', 0, 'y', 'tbl_rawat_inap'),
(27, 'data obat dan alkes', 'dataobat', 'fa fa-medkit', 30, 'y', NULL),
(28, 'data kategori barang', 'kategoribarang', 'fa fa-align-justify', 30, 'y', NULL),
(29, 'data satuan barang', 'datasatuan', 'fa fa-object-group', 30, 'y', NULL),
(30, 'MODUL APOTEK', '#', 'fa fa-bed', 0, 'y', NULL),
(31, 'LAPORAN PENGADAAN OBAT', 'pengadaan', 'fa fa-capsules', 30, 'y', NULL),
(32, 'laporan penjualan', 'penjualan', 'fa fa-chart-line', 30, 'y', NULL),
(33, 'Profile Rumah Sakit', 'profile/update/1', 'fa fa-hospital-alt', 0, 'y', 'tbl_profil_rumah_sakit'),
(34, 'Data Supplier', 'supplier', 'fa fa-store', 30, 'y', NULL),
(35, 'MENU TINDAKAN', '#', 'fa fa-graduation-cap', 0, 'y', NULL),
(36, 'DATA DIGANOSA PENYAKIT', 'diagnosa', 'fa fa-stethoscope', 35, 'y', NULL),
(37, 'data kategori tindakan', 'kategoritindakan', 'fa fa-microchip', 35, 'y', NULL),
(38, 'data pemeriksaan lab', 'periksalabor', 'fa fa-bed', 35, 'y', NULL),
(39, 'data tindakan', 'data_tindakan', 'fa fa-map', 35, 'y', NULL),
(40, 'Nomor Antrean', 'antrean', 'fa fa-people-arrows', 0, 'y', NULL),
(41, 'Area Keuangan', 'keuangan_area', 'fa fa-money-bill-wave-alt', 0, 'y', NULL),
(42, 'Laporan UGD', 'pendaftaran/ugd', 'fa fa-ambulance', 0, 'y', NULL),
(43, 'Area Apoteker', 'apotek_area', 'fa fa-capsules', 0, 'y', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_mutasi_deposit`
--

CREATE TABLE `tbl_mutasi_deposit` (
  `id_mutasi` bigint NOT NULL,
  `no_rawat` varchar(18) NOT NULL,
  `user_in_charge` int DEFAULT NULL,
  `tanggal_mutasi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `keterangan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah_mutasi` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_mutasi_deposit`
--

INSERT INTO `tbl_mutasi_deposit` (`id_mutasi`, `no_rawat`, `user_in_charge`, `tanggal_mutasi`, `keterangan`, `jumlah_mutasi`) VALUES
(1, '2020/09/26/0003', 1, '2020-09-26 16:41:55', 'Penambahan deposit pasien', 1500000),
(2, '2020/09/26/0003', 1, '2020-09-27 12:41:34', 'Pembelian obat \"Betadine\" 3 buah', -25000),
(3, '2020/09/26/0003', 1, '2020-09-27 13:41:34', 'Pembelian barang \"Infus\" 3 labu', -45000),
(4, '2020/09/26/0003', 1, '2020-09-27 16:41:34', 'Pengembalian barang \"Infus\" sejumlah 1 labu.', -15000),
(5, '2020/09/26/0003', 1, '2020-09-27 17:46:17', '19896', -927),
(6, '2020/09/26/0003', 1, '2020-09-27 17:47:52', 'PEMBELIAN \"HEMORID KAPS\" (KODE BARANG: \"00928\") SEJUMLAH 5 KAPS', -3735),
(7, '2020/09/26/0003', 1, '2020-09-27 20:43:06', 'PEMBELIAN \"GRAFAMIC\" (KODE BARANG: \"00871\") SEJUMLAH 5 TABLET', -1760),
(17, '2020/09/23/0003', 1, '2020-09-27 21:25:39', 'DEPOSIT AWAL', 123456789),
(18, '2020/09/23/0003', 1, '2020-09-27 21:25:40', 'BIAYA RAWAT INAP DI RUANGAN \"KANA/\" SELAMA -90 HARI', -4050000),
(19, '2020/09/23/0002', 1, '2020-09-27 21:27:09', 'DEPOSIT AWAL', 40112333),
(20, '2020/09/23/0002', 1, '2020-09-27 21:27:09', 'BIAYA RAWAT INAP DI RUANGAN \"AMARILIS\" SELAMA 60 HARI', -2700000),
(21, '2020/09/23/0002', 1, '2020-09-27 21:27:42', 'PEMBELIAN \"GRISEOFULVIN TAB 125MG INF\" (KODE BARANG: \"00887\") SEJUMLAH 10 TABLET', -3120),
(23, '2020/09/23/0002', 1, '2020-09-27 21:36:08', 'PEMBERIAN TINDAKAN \"pemasangan implant denture\"', -4600000),
(24, '2020/09/23/0003', 1, '2020-09-27 21:56:47', 'PEMBERIAN TINDAKAN \"LIPSUCTION 2 AREA\"', -70123456),
(25, '2020/09/23/0003', 1, '2020-09-27 22:02:07', 'PEMERIKSAAN KESEHATAN \"Darah\"', -45000),
(26, '2020/09/23/0003', 1, '2020-09-27 22:05:21', 'PEMBELIAN \"HIGH ELASTIS B GC 7,5CM\" (KODE BARANG: \"00946\") SEJUMLAH 2 PCS', -16100);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_obat_alkes_bhp`
--

CREATE TABLE `tbl_obat_alkes_bhp` (
  `kode_barang` varchar(6) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `id_kategori_harga_brg` int NOT NULL,
  `id_kategori_barang` int NOT NULL,
  `id_satuan_barang` int NOT NULL,
  `harga` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_obat_alkes_bhp`
--

INSERT INTO `tbl_obat_alkes_bhp` (`kode_barang`, `nama_barang`, `id_kategori_harga_brg`, `id_kategori_barang`, `id_satuan_barang`, `harga`) VALUES
('00001', 'ABBOCATH 18', 1, 6, 3, 14950),
('00002', 'ABBOCATH 20', 1, 6, 3, 14950),
('00003', 'ABSOLUTE', 1, 6, 3, 14400),
('00004', 'ACETON 60ML', 1, 6, 1, 6750),
('00005', 'ACIFAR CR 5 GR', 1, 6, 5, 6400),
('00006', 'ACITRAL TAB', 1, 6, 6, 1380),
('00007', 'ACLONAC GEL', 1, 6, 5, 33902),
('00008', 'ACNOL 10ML', 1, 6, 3, 9517),
('00009', 'ACTIFED H 60ML', 1, 6, 1, 29040),
('00010', 'ACTIFED K 60ML', 1, 6, 1, 26289),
('00011', 'ACTIFED M 60ML', 1, 6, 1, 29040),
('00012', 'ACTIRAL', 1, 6, 3, 1600),
('00013', 'ACYCLOVIR CR 5GR INF', 1, 6, 5, 3900),
('00014', 'ACYCLOVIR CR 5GR KF', 1, 6, 5, 4095),
('00015', 'ACYCLOVIR TAB 200MG', 1, 6, 7, 408),
('00016', 'ACYCLOVIR TAB 200MG INF', 1, 6, 7, 500),
('00017', 'ACYCLOVIR TAB 400MG HEX', 1, 6, 7, 559),
('00018', 'ACYCLOVIR TAB 400MG INF', 1, 6, 7, 714),
('00019', 'ADEM SARI', 1, 6, 8, 1174),
('00020', 'ADEM SARI @1', 1, 6, 3, 1507),
('00021', 'ADEM SARI @24', 1, 6, 3, 1289),
('00022', 'ADEM SARI FRESH @6', 1, 6, 9, 1241),
('00023', 'ADI CUP 240ML', 1, 6, 1, 680),
('00024', 'AFI FLU TAB @1000', 1, 6, 7, 360),
('00025', 'AFIFLU TAB', 1, 6, 7, 384),
('00026', 'AFIRHEUMA', 1, 6, 10, 313),
('00027', 'AFITRACIN 10 ML', 1, 6, 1, 1560),
('00028', 'AFITSON CENGKEH', 1, 6, 3, 3450),
('00029', 'AGUARIA 330ML', 1, 6, 1, 1707),
('00030', 'AILIN TM 5ML', 1, 6, 1, 5009),
('00031', 'AINIE SBN SIRIH 110 ML', 1, 6, 1, 5959),
('00032', 'AKURAT', 1, 6, 3, 9900),
('00033', 'AKURAT COMPACT', 1, 6, 8, 15813),
('00034', 'ALANG SARI @7', 1, 6, 3, 1011),
('00035', 'ALAT PEMANCUNG HIDUNG', 1, 6, 3, 10400),
('00036', 'ALAT PEMB. KOMEDO', 1, 6, 3, 10400),
('00037', 'ALAT PEMB. TELINGA', 1, 6, 3, 10400),
('00038', 'ALBA PASTILES', 1, 6, 8, 8000),
('00039', 'ALBI GURAH', 1, 6, 1, 26450),
('00040', 'ALBIGURAA 25 KAPS ALBIRUNI', 1, 6, 1, 22880),
('00041', 'ALBOTHYL 10 ML', 1, 6, 1, 30993),
('00042', 'ALBOTHYL 5ML', 1, 6, 1, 19888),
('00043', 'ALBU GURAH JUMBO', 1, 6, 1, 51750),
('00044', 'ALCO PLUS DMP 100 ML', 1, 6, 1, 29095),
('00045', 'ALERDEX TAB', 1, 6, 7, 1224),
('00046', 'ALKOHOL 100ML ONEMED', 1, 6, 1, 3000),
('00047', 'ALKOHOL 70% 100 ML AFI', 1, 6, 1, 3840),
('00048', 'ALKOHOL 70% 100 ML HAKO', 1, 6, 1, 2960),
('00049', 'ALKOHOL 70% 100 ML SEINO', 1, 6, 1, 3000),
('00050', 'ALKOHOL 70% 100ML BERLICO', 1, 6, 1, 3789),
('00051', 'ALKOHOL 70% 100ML NUFA', 1, 6, 1, 3551),
('00052', 'ALKOHOL 70% 300 ML ONEMED', 1, 6, 1, 9000),
('00053', 'ALKOHOL 70% 300ML AFI', 1, 6, 1, 13585),
('00054', 'ALKOHOL SWAB', 1, 6, 3, 230),
('00055', 'ALLERGIL CR 2% 5GR', 1, 6, 5, 3749),
('00056', 'ALLERIN EXP 60 ML', 1, 6, 1, 12548),
('00057', 'ALLERON TAB', 1, 6, 7, 158),
('00058', 'ALLETROL TM 5 ML', 1, 6, 1, 12279),
('00059', 'ALLETROL ZM 3,5GR', 1, 6, 5, 10382),
('00060', 'ALLOPURINOL 100 MG', 1, 6, 7, 165),
('00061', 'ALLOPURINOL 300 MG', 1, 6, 7, 319),
('00062', 'ALLOPURINOL TAB 100MG FM', 1, 6, 7, 172),
('00063', 'ALMINA KIDS', 1, 6, 1, 35200),
('00064', 'ALMINA MADU JINTEN', 1, 6, 1, 50600),
('00065', 'ALOFAR TAB 300MG', 1, 6, 7, 465),
('00066', 'ALPARA 60ML', 1, 6, 1, 9331),
('00067', 'ALPARA TAB', 1, 6, 7, 578),
('00068', 'ALPHARA 60ML', 1, 6, 1, 11963),
('00069', 'ALVIT DROP', 1, 6, 3, 9200),
('00070', 'AMBEVEN CAP', 1, 6, 6, 11845),
('00071', 'AMBROXOL SYR 60 ML', 1, 6, 1, 4125),
('00072', 'AMBROXOL TAB', 1, 6, 7, 156),
('00073', 'AMINOPHYLLIN 200MG @1000', 1, 6, 7, 180),
('00074', 'AMLODIPIN TAB 10 MG HEX', 1, 6, 7, 2646),
('00075', 'AMLODIPIN TAB 10 MG INDO', 1, 6, 7, 2115),
('00076', 'AMLODIPIN TAB 10 MG SOHO', 1, 6, 7, 1150),
('00077', 'AMLODIPIN TAB 5 MG', 1, 6, 7, 1199),
('00078', 'AMLODIPIN TAB 5 MG DEXA', 1, 6, 7, 625),
('00079', 'AMLODIPIN TAB 5 MG HEX', 1, 6, 7, 3025),
('00080', 'AMLODIPIN TAB 5 MG INF', 1, 6, 9, 1200),
('00081', 'AMLODIPIN TAB 5 MG KF', 1, 6, 7, 1200),
('00082', 'AMOXSAN CAP 500MG', 1, 6, 11, 3875),
('00083', 'AMOXSAN DROP', 1, 6, 1, 26441),
('00084', 'AMOXSAN DRY SYR 125MG', 1, 6, 1, 24326),
('00085', 'AMOXSAN SYR 60ML', 1, 6, 1, 37709),
('00086', 'AMOXYCILLIN SYR 60ML', 1, 6, 1, 4625),
('00087', 'AMOXYCILLIN TAB 500 MG', 1, 6, 7, 363),
('00088', 'AMOXYCILLIN TAB 500 MG BERNO', 1, 6, 7, 351),
('00089', 'AMOXYCILLIN TAB 500 MG INDO', 1, 6, 7, 481),
('00090', 'AMOXYCILLIN TAB 500 MG KF', 1, 6, 7, 481),
('00091', 'AMOXYCILLIN TAB 500 MG NOVA', 1, 6, 7, 450),
('00092', 'AMOXYCILLIN TAB 500MG RAMA', 1, 6, 7, 429),
('00093', 'AMPICILIN TAB 500 MG INDO', 1, 6, 7, 463),
('00094', 'AMPICILLIN TAB 500 MG ERITA', 1, 6, 7, 377),
('00095', 'AMPICILLIN TAB 500 MG KF', 1, 6, 7, 491),
('00096', 'AMPICILLIN TAB 500 MG MEPRO', 1, 6, 7, 481),
('00097', 'AMPICILLIN TAB 500 MG RAMA', 1, 6, 7, 429),
('00098', 'AMURATEN', 1, 6, 12, 2990),
('00099', 'ANABION 60 ML', 1, 6, 1, 6072),
('00100', 'ANABION DHA 60 ML', 1, 6, 1, 7590),
('00101', 'ANACETIN SYR 60ML', 1, 6, 1, 6324),
('00102', 'ANAKONIDIN OBH 30 ML', 1, 6, 1, 6148),
('00103', 'ANAKONIDIN OBH 60ML', 1, 6, 1, 9981),
('00104', 'ANAKONIDIN SYR 30ML', 1, 6, 1, 6041),
('00105', 'ANAKONIDIN SYR 60ML', 1, 6, 1, 9981),
('00106', 'ANASTAN TAB', 1, 6, 7, 540),
('00107', 'ANATON 60 ML', 1, 6, 1, 4950),
('00108', 'ANATON TAB', 1, 6, 7, 396),
('00109', 'ANDALAN LAKTASI', 1, 6, 6, 11385),
('00110', 'ANDALAN PIL KB', 1, 6, 6, 4025),
('00111', 'ANLENE ACT CHO 100GR', 1, 6, 8, 12075),
('00112', 'ANLENE ACT CHO 250GR', 1, 6, 8, 27972),
('00113', 'ANLENE ACT VAN 100GR', 1, 6, 8, 11558),
('00114', 'ANLENE ACT VAN 250GR', 1, 6, 8, 27810),
('00115', 'ANLENE ACTIFIT 250GR PLN', 1, 6, 8, 27783),
('00116', 'ANLENE ACTIVIT 600 GR PLAIN', 1, 6, 8, 62501),
('00117', 'ANLENE GOLD CHO 100GR', 1, 6, 8, 11610),
('00118', 'ANLENE GOLD CHO 250GR', 1, 6, 8, 31212),
('00119', 'ANLENE GOLD PLAIN 250GR', 1, 6, 8, 31212),
('00120', 'ANLENE GOLD PLN 100GR', 1, 6, 8, 11610),
('00121', 'ANLENE GOLD VAN 250GR', 1, 6, 8, 31212),
('00122', 'ANLENE TOTAL 200GR PLN', 1, 6, 8, 33480),
('00123', 'ANLENE TOTAL CHO 200GR', 1, 6, 8, 32832),
('00124', 'ANLENE TOTAL VAN 200GR', 1, 6, 8, 32832),
('00125', 'ANMUM MATERNA CHO 80GR', 1, 6, 8, 12708),
('00126', 'ANMUM MATERNA PLAIN 80GR', 1, 6, 8, 11558),
('00127', 'ANMUM MATERNA VAN MG 200 GR', 1, 6, 8, 36369),
('00128', 'ANMUM SB CHO 200 GR', 1, 6, 8, 38726),
('00129', 'ANMUM SB PLAIN 200 GR', 1, 6, 8, 35829),
('00130', 'ANTALGIN TAB', 1, 6, 7, 325),
('00131', 'ANTALGIN TAB BERLICO', 1, 6, 7, 322),
('00132', 'ANTALGIN TAB INDO', 1, 6, 7, 194),
('00133', 'ANTANGIN CAIR', 1, 6, 12, 1824),
('00134', 'ANTANGIN JRG BOX @10', 1, 6, 12, 1872),
('00135', 'ANTANGIN JRG TAB', 1, 6, 6, 1824),
('00136', 'ANTANGIN PERMEN HONEY MINT', 1, 6, 3, 1040),
('00137', 'ANTASIDA DOEN 60 ML KF', 1, 6, 1, 4620),
('00138', 'ANTASIDA DOEN 60ML FM', 1, 6, 1, 4428),
('00139', 'ANTASIDA DOEN TAB ERRELA', 1, 6, 7, 216),
('00140', 'ANTASIDA DOEN TAB KF', 1, 6, 7, 190),
('00141', 'ANTASIDA SYR 60 ML SAMP', 1, 6, 1, 3558),
('00142', 'ANTASIDA TAB @100', 1, 6, 7, 176),
('00143', 'ANTASIDA TAB @1000', 1, 6, 7, 35),
('00144', 'ANTASIDA TAB AFI', 1, 6, 7, 102),
('00145', 'ANTASIDA TAB FM', 1, 6, 7, 146),
('00146', 'ANTIMO TAB', 1, 6, 6, 3960),
('00147', 'ANTIPLAQUE PG 75GR', 1, 6, 3, 15275),
('00148', 'ANTIZ GEL 60ML JRK', 1, 6, 1, 6565),
('00149', 'ANTIZ GEL BT60 FRESH', 1, 6, 1, 6565),
('00150', 'ANTIZA 60 ML', 1, 6, 1, 16731),
('00151', 'ANTIZA TAB', 1, 6, 7, 928),
('00152', 'APIALYS DROP 10ML', 1, 6, 1, 31625),
('00153', 'APIALYS SYR 60ML', 1, 6, 1, 28175),
('00154', 'AQUA DANONE 1500ML', 1, 6, 1, 4440),
('00155', 'AQUARIA BTL 330 ML', 1, 6, 1, 1861),
('00156', 'AQUARIA BTL 600 ML', 1, 6, 1, 2360),
('00157', 'ARM SLIM (L)', 1, 6, 3, 28600),
('00158', 'ARM SLIM (M)', 1, 6, 3, 28600),
('00159', 'ARM SLIM (S)', 1, 6, 3, 28600),
('00160', 'AROMATIC', 1, 6, 1, 9945),
('00161', 'ARTHRIFEN PLUS TAB', 1, 6, 7, 734),
('00162', 'ARTHRIFEN SYR', 1, 6, 1, 17710),
('00163', 'ASAM MEFENAMAT TAB 500 MG AFI', 1, 6, 7, 203),
('00164', 'ASAM MEFENAMAT TAB 500 MG INDO', 1, 6, 7, 229),
('00165', 'ASAM MEFENAMAT TAB 500 MG KF', 1, 6, 7, 229),
('00166', 'ASAM MEFENAMAT TAB 500 MG LAND', 1, 6, 7, 169),
('00167', 'ASAM MEFENAMAT TAB 500 MG NOVA', 1, 6, 7, 156),
('00168', 'ASEPSO FRESH ORANGE', 1, 6, 8, 5938),
('00169', 'ASEPSO SOAP CLEAN 80 GR', 1, 6, 3, 5938),
('00170', 'ASEPSO SOAP REG 80GR', 1, 6, 3, 6395),
('00171', 'ASIFIT TAB @30', 1, 6, 1, 48984),
('00172', 'ASMASOLON TAB @4', 1, 6, 6, 1656),
('00173', 'ASPILET TAB@100', 1, 6, 7, 667),
('00174', 'ASTHIN FORCE', 1, 6, 7, 4083),
('00175', 'ASTHMA SOHO @1000', 1, 6, 7, 278),
('00176', 'ASTHMA SOHO@4', 1, 6, 6, 1670),
('00177', 'AUTAN JNR LOT 50ML', 1, 6, 1, 7849),
('00178', 'AUTAN LOT FAM @5', 1, 6, 12, 594),
('00179', 'AUTAN S&S LOT 50ML', 1, 6, 1, 6469),
('00180', 'AVAIL BIRU', 1, 6, 8, 31850),
('00181', 'AVAIL HIJAU', 1, 6, 8, 27300),
('00182', 'AVAIL MERAH', 1, 6, 8, 31850),
('00183', 'B & B KIDS SHP 100 ML', 1, 6, 1, 6240),
('00184', 'B&B KIDS SHAMPO', 1, 6, 1, 5003),
('00185', 'BABY COUGH PACDIN 60 ML', 1, 6, 1, 4433),
('00186', 'BABY COUGH SYR 60ML', 1, 6, 1, 3855),
('00187', 'BALPIRIK HIJAU EKSTA KUAT', 1, 6, 3, 4746),
('00188', 'BALPIRIK JASMINE', 1, 6, 3, 5226),
('00189', 'BALPIRIK KAYU PTH', 1, 6, 3, 4727),
('00190', 'BALPIRIK KUNING EKSTRA KUAT', 1, 6, 3, 4727),
('00191', 'BALPIRIK LAVENDER', 1, 6, 3, 5226),
('00192', 'BALPIRIK MERAH EKSTRA KUAT', 1, 6, 3, 5292),
('00193', 'BALPIRIK ROSE', 1, 6, 3, 5226),
('00194', 'BAN LENG TJENG', 1, 6, 1, 10580),
('00195', 'BATUGIN 120 ML', 1, 6, 1, 16129),
('00196', 'BATUGIN 300 ML', 1, 6, 1, 28641),
('00197', 'BAYCUTEN N CR 5 GR', 1, 6, 5, 41859),
('00198', 'BAYGON COIL REG STD', 1, 6, 8, 2610),
('00199', 'BD ALKOHOL SWABS', 1, 6, 8, 480),
('00200', 'BEAKER GLASS 50CC', 1, 6, 3, 48000),
('00201', 'BEAR BRAND 189 ML', 1, 6, 1, 6696),
('00202', 'BEBELAC 2 200GR', 1, 6, 8, 28134),
('00203', 'BEBELOVE 1 200GR', 1, 6, 8, 34074),
('00204', 'BEBELOVE 2 200GR', 1, 6, 8, 32400),
('00205', 'BEBELOVE 3 200GR', 1, 6, 8, 26811),
('00206', 'BECOM-C', 1, 6, 7, 1366),
('00207', 'BECOMBION 100ML', 1, 6, 1, 21850),
('00208', 'BECOMBION PLUS 110ML', 1, 6, 1, 24550),
('00209', 'BEDAK MARCK CREAM', 1, 6, 3, 10924),
('00210', 'BEDAK MARCK PUTIH', 1, 6, 3, 9430),
('00211', 'BEDAK MARCK ROSE', 1, 6, 3, 9430),
('00212', 'BENACOL EXP 100ML', 1, 6, 1, 15307),
('00213', 'BENDERA 123 CHO 400 GR', 1, 6, 8, 30186),
('00214', 'BENDERA 123 MADU 200 GR', 1, 6, 8, 16119),
('00215', 'BENDERA 123 VAN 400 GR', 1, 6, 8, 31482),
('00216', 'BENDERA 456 CHO 400GR', 1, 6, 8, 30807),
('00217', 'BENDERA 456 VAN 300GR', 1, 6, 8, 12015),
('00218', 'BENDERA CAIR 115ML CHO', 1, 6, 8, 2243),
('00219', 'BENDERA CAIR 115ML STRW', 1, 6, 8, 2231),
('00220', 'BENDERA CAIR CHO 190', 1, 6, 1, 2500),
('00221', 'BENDERA CAIR STRW 190', 1, 6, 1, 2500),
('00222', 'BENDERA CHO 200GR', 1, 6, 8, 12312),
('00223', 'BENDERA CHO KLG', 1, 6, 1, 7290),
('00224', 'BENDERA FORMULA 1 200 GR', 1, 6, 8, 16362),
('00225', 'BENDERA FORMULA 2 200 GR', 1, 6, 8, 16470),
('00226', 'BENDERA FORMULA 2 400 GR', 1, 6, 8, 35019),
('00227', 'BENDERA FULL KRIM 200GR', 1, 6, 8, 14850),
('00228', 'BENDERA GOLD KLG', 1, 6, 1, 9477),
('00229', 'BENDERA HI-LO 250 CK', 1, 6, 8, 3780),
('00230', 'BENDERA KID 115 CHO', 1, 6, 8, 2535),
('00231', 'BENDERA KID 115 STRW', 1, 6, 8, 2522),
('00232', 'BENDERA KRIMER', 1, 6, 1, 7668),
('00233', 'BENDERA SCHOL 190 CO', 1, 6, 8, 3120),
('00234', 'BENDERA SCHOL 190 STRW', 1, 6, 8, 3090),
('00235', 'BENDERA SKM GOLD SACH', 1, 6, 12, 1485),
('00236', 'BENDERA UHT 115ML BR', 1, 6, 8, 2243),
('00237', 'BENDERA UHT 115ML CHO', 1, 6, 8, 2070),
('00238', 'BENDERA UHT 190 CHO', 1, 6, 8, 3014),
('00239', 'BENDERA UHT 190 STRW', 1, 6, 8, 3014),
('00240', 'BENDERA UHT 190ML BR', 1, 6, 8, 3014),
('00241', 'BENOSON CR 5GR', 1, 6, 5, 11000),
('00242', 'BENOSON N CR 15 GR', 1, 6, 5, 27500),
('00243', 'BENZOLAC 2,5% CR 5GR', 1, 6, 3, 13613),
('00244', 'BENZOLAC CR 5% 5GR', 1, 6, 5, 14520),
('00245', 'BENZOLAC-CL 5% 10 GR', 1, 6, 5, 30250),
('00246', 'BERLICORT CR', 1, 6, 5, 11049),
('00247', 'BERLOSID 60ML', 1, 6, 1, 6841),
('00248', 'BERLOSID TAB', 1, 6, 7, 243),
('00249', 'BERLOSON N CR 5 GR', 1, 6, 5, 5395),
('00250', 'BERLOSYD SYR 60ML', 1, 6, 1, 5066),
('00251', 'BERNESTEN CR 5GR', 1, 6, 5, 7095),
('00252', 'BETADINE FMN', 1, 6, 1, 19048),
('00253', 'BETADINE GARGLE', 1, 6, 1, 9504),
('00254', 'BETADINE GARGLE 190ML', 1, 6, 1, 16408),
('00255', 'BETADINE JNR', 1, 6, 3, 474),
('00256', 'BETADINE KIDS 5ML', 1, 6, 1, 3416),
('00257', 'BETADINE OINT 10GR', 1, 6, 5, 14295),
('00258', 'BETADINE OINT 5 GR', 1, 6, 3, 8778),
('00259', 'BETADINE SABUN CAIR 100 ML', 1, 6, 1, 30360),
('00260', 'BETADINE SABUN CAIR 60 ML', 1, 6, 1, 21505),
('00261', 'BETADINE SOL 15 ML', 1, 6, 3, 8976),
('00262', 'BETADINE SOL 30 ML', 1, 6, 1, 14916),
('00263', 'BETADINE SOL 5 ML', 1, 6, 1, 3099),
('00264', 'BETADINE SOL 60 ML', 1, 6, 1, 24563),
('00265', 'BETADINE VAG DOUCHE (+) ALAT', 1, 6, 1, 48477),
('00266', 'BETADINE VAG DOUCHE (-) ALAT', 1, 6, 1, 41140),
('00267', 'BETAHISTINE TAB 6MG NOVELL', 1, 6, 7, 1155),
('00268', 'BETAMETASON 0,1% CR 5GR', 1, 6, 5, 2634),
('00269', 'BETASIN CR 10GR', 1, 6, 5, 31625),
('00270', 'BETASON N CR 5 GR', 1, 6, 3, 10120),
('00271', 'BETOPIC CR', 1, 6, 5, 30030),
('00272', 'BIKIN JOSS', 1, 6, 1, 16000),
('00273', 'BIMACYL TAB', 1, 6, 7, 400),
('00274', 'BIMAFLOX TAB 500MG', 1, 6, 7, 449),
('00275', 'BIMATRA KAPS 500MG', 1, 6, 10, 455),
('00276', 'BIMOXYL TAB 500MG', 1, 6, 7, 487),
('00277', 'BINOTAL 500MG', 1, 6, 7, 4892),
('00278', 'BIO JANNA', 1, 6, 8, 74750),
('00279', 'BIO KNK', 1, 6, 8, 11700),
('00280', 'BIOGESIC 60ML', 1, 6, 1, 22138),
('00281', 'BIOGESIC TAB', 1, 6, 6, 1543),
('00282', 'BIOLYSIN 60ML', 1, 6, 1, 10120),
('00283', 'BIOLYSIN EMUL 250 ML', 1, 6, 1, 15180),
('00284', 'BIOLYSIN KIDS ANGGUR', 1, 6, 8, 8855),
('00285', 'BIOLYSIN KIDS JERUK', 1, 6, 8, 8855),
('00286', 'BIOLYSIN KIDS STRW', 1, 6, 8, 8855),
('00287', 'BIOLYSIN SMART 100ML', 1, 6, 1, 16781),
('00288', 'BIOLYSIN SMART 60ML', 1, 6, 1, 11385),
('00289', 'BIOMEGA TAB', 1, 6, 7, 483),
('00290', 'BIOPLACENTON 10GR', 1, 6, 3, 15813),
('00291', 'BIORE BF B100 AC DEO', 1, 6, 3, 5298),
('00292', 'BIORE BF B100 ANTISEPT', 1, 6, 1, 5298),
('00293', 'BIORE BF B100 HEALTH', 1, 6, 3, 5298),
('00294', 'BIORE BF LIVELY', 1, 6, 1, 5330),
('00295', 'BIORE FF 40 ACNE&CARE', 1, 6, 1, 9133),
('00296', 'BIORE FF 40 POR&OIL', 1, 6, 1, 9133),
('00297', 'BIORE MEN FF 40 ACT', 1, 6, 1, 8483),
('00298', 'BIOSENTRA 1000GR', 1, 6, 9, 37481),
('00299', 'BIOSENTRA 500GR', 1, 6, 9, 21464),
('00300', 'BIOSTRUM', 1, 6, 1, 44850),
('00301', 'BIOVISION CAP', 1, 6, 7, 1794),
('00302', 'BISOLTUSIN 60 ML', 1, 6, 1, 24736),
('00303', 'BISOLVON ELIX 60ML', 1, 6, 1, 25174),
('00304', 'BISOLVON EXTRA 60ML', 1, 6, 1, 26216),
('00305', 'BISOLVON FLU 60ML', 1, 6, 1, 27968),
('00306', 'BISOLVON KID 60ML', 1, 6, 1, 25933),
('00307', 'BISOLVON TAB', 1, 6, 6, 2013),
('00308', 'BLACK COFFE AROMATIC', 1, 6, 8, 30000),
('00309', 'BLOOD LANCET CRN @200', 1, 6, 9, 49400),
('00310', 'BODREX BATUK FLU TAB @4', 1, 6, 6, 1380),
('00311', 'BODREX EXTRA TAB @4', 1, 6, 6, 1668),
('00312', 'BODREX FLU&BTK ATT', 1, 6, 1, 7091),
('00313', 'BODREX FLU&BTK EXP 60 ML', 1, 6, 1, 7216),
('00314', 'BODREX MIGRA', 1, 6, 6, 1758),
('00315', 'BODREX TAB @10', 1, 6, 6, 2635),
('00316', 'BODREXIN 60ML', 1, 6, 1, 5750),
('00317', 'BODREXIN FLU BATUK 60M ML', 1, 6, 1, 5750),
('00318', 'BODREXIN TAB @10', 1, 6, 6, 1610),
('00319', 'BORAX GLYCERIN', 1, 6, 1, 2161),
('00320', 'BORRAGINOL N OINT', 1, 6, 3, 44125),
('00321', 'BORRAGINOL N SUPP @10', 1, 6, 13, 9874),
('00322', 'BRAITO TEARS 5 ML', 1, 6, 1, 7084),
('00323', 'BRAITO TM 6ML', 1, 6, 1, 7084),
('00324', 'BRONCHITIN 60ML', 1, 6, 1, 4980),
('00325', 'BRONKRIS ELIX 60 ML', 1, 6, 1, 5600),
('00326', 'BRONSOLVAN TAB', 1, 6, 7, 456),
('00327', 'BRONSULVAN SYR', 1, 6, 1, 14030),
('00328', 'BUFACARYL TAB', 1, 6, 7, 202),
('00329', 'BUFACOMB CR', 1, 6, 3, 15125),
('00330', 'BUFACORT N CR', 1, 6, 3, 4944),
('00331', 'BUFAGAN 60ML', 1, 6, 1, 3606),
('00332', 'BUFANTACID F 60ML', 1, 6, 1, 5526),
('00333', 'BUFANTACID TAB', 1, 6, 7, 142),
('00334', 'BUFECT 100 ML', 1, 6, 1, 14878),
('00335', 'BUFENOL KAPS', 1, 6, 10, 281),
('00336', 'BURNAZIN CR 35 GR', 1, 6, 5, 48703),
('00337', 'BYE BYE FEVER BABY @10', 1, 6, 3, 6672),
('00338', 'BYE BYE FEVER CHILD @5', 1, 6, 3, 9266),
('00339', 'CAL 95', 1, 6, 7, 4375),
('00340', 'CALADINE LOT 60ML', 1, 6, 1, 10278),
('00341', 'CALADINE LOT 95', 1, 6, 1, 14520),
('00342', 'CALADINE POWDER ORIG 60GR', 1, 6, 1, 7464),
('00343', 'CALADINE PWD ACT', 1, 6, 1, 9631),
('00344', 'CALADINE PWD ORG 100GR', 1, 6, 1, 10956),
('00345', 'CALADINE PWD SOFT 100GR', 1, 6, 1, 10296),
('00346', 'CALCIFAR TAB', 1, 6, 7, 160),
('00347', 'CALCIUM LACT @1000', 1, 6, 7, 105),
('00348', 'CALCUSOL CAP @30', 1, 6, 10, 995),
('00349', 'CALCUSOL CAP @50', 1, 6, 1, 44390),
('00350', 'CALLUSOL', 1, 6, 1, 27671),
('00351', 'CANDISTIN DROP', 1, 6, 1, 40563),
('00352', 'CANESTEN CR 3GR', 1, 6, 3, 16141),
('00353', 'CANESTEN CR 5GR', 1, 6, 3, 19784),
('00354', 'CANTIK LANGSING KAPS', 1, 6, 1, 35750),
('00355', 'CAPORIT 50 GR AFI', 1, 6, 1, 2960),
('00356', 'CAPTOPRIL 12,5MG KF', 1, 6, 7, 117),
('00357', 'CAPTOPRIL 25MG', 1, 6, 7, 170),
('00358', 'CAPTOPRIL TAB 12,5 MG INDO', 1, 6, 7, 127),
('00359', 'CAPTOPRIL TAB 25 MG INDO', 1, 6, 7, 207),
('00360', 'CARBIDU 0,75MG TAB', 1, 6, 7, 303),
('00361', 'CARBIDU TAB 0,5MG', 1, 6, 7, 288),
('00362', 'CATAFLAM 50MG', 1, 6, 7, 4954),
('00363', 'CAVICUR DHA 60ML', 1, 6, 1, 7167),
('00364', 'CAVICUR TAB', 1, 6, 6, 5445),
('00365', 'CAVIPLEX 60 ML', 1, 6, 1, 5768),
('00366', 'CAVIPLEX CAP', 1, 6, 10, 430),
('00367', 'CAVIPLEX DROPS', 1, 6, 1, 4506),
('00368', 'CAZETIN DROP', 1, 6, 1, 20625),
('00369', 'CDR EFF @10', 1, 6, 3, 31379),
('00370', 'CDR FORTOS EFF@10', 1, 6, 1, 33953),
('00371', 'CEFADROXYL 60 ML INDO', 1, 6, 1, 11440),
('00372', 'CEFADROXYL KAPS', 1, 6, 10, 1038),
('00373', 'CEFADROXYL KAPS 500MG BERNO', 1, 6, 10, 1144),
('00374', 'CEFADROXYL KAPS 500MG DEXA', 1, 6, 10, 767),
('00375', 'CEFADROXYL KAPS 500MG MEDIKON', 1, 6, 10, 878),
('00376', 'CEFAT DS 60ML', 1, 6, 1, 46653),
('00377', 'CEFIXIME 100MG HEX @50', 1, 6, 10, 3113),
('00378', 'CEFIXIME CAP', 1, 6, 7, 3375),
('00379', 'CEIXIME SYR', 1, 6, 1, 37813),
('00380', 'CENDO AUGENTONIC 5ML', 1, 6, 3, 31250),
('00381', 'CENDO CATARLENT 15ML', 1, 6, 1, 29728),
('00382', 'CENDO CATARLENT 5ML', 1, 6, 3, 23890),
('00383', 'CENDO CENFRESH MD', 1, 6, 3, 4537),
('00384', 'CENDO CENFRESH TM 5ML', 1, 6, 1, 33902),
('00385', 'CENDO EYE FRESH MD', 1, 6, 3, 4881),
('00386', 'CENDO FENICOL 0,25% TM 5ML', 1, 6, 1, 23031),
('00387', 'CENDO FENICOL 0,5% TM 5ML', 1, 6, 1, 32313),
('00388', 'CENDO GENTA 0,3% TM 5ML', 1, 6, 1, 29906),
('00389', 'CENDO GENTAMYCIN EO 0,3%', 1, 6, 5, 33344),
('00390', 'CENDO LITERS 15ML', 1, 6, 1, 21821),
('00391', 'CENDO LYTERS MD', 1, 6, 3, 3732),
('00392', 'CENDO MYCETIN SM 3,5GR', 1, 6, 5, 17531),
('00393', 'CENDO POLYDEX ED 5ML', 1, 6, 1, 41113),
('00394', 'CENDO POLYDEX MD', 1, 6, 3, 5603),
('00395', 'CENDO TIMOL 0,5% TM 5ML', 1, 6, 1, 56202),
('00396', 'CENDO XITROL 5ML', 1, 6, 3, 29728),
('00397', 'CENDO XITROL EO', 1, 6, 3, 35234),
('00398', 'CEREBORFORT GINKO', 1, 6, 1, 13513),
('00399', 'CEREBROFORT GOLD 200ML', 1, 6, 3, 30360),
('00400', 'CEREBROFORT GOLD 60ML ORG', 1, 6, 1, 10285),
('00401', 'CEREBROFORT GOLD JRK 100ML', 1, 6, 1, 15538),
('00402', 'CEREBROFORT GOLD STRW 100ML', 1, 6, 1, 15538),
('00403', 'CEREBROFORT SYR', 1, 6, 1, 14295),
('00404', 'CEREBROVIT GINKO', 1, 6, 8, 15028),
('00405', 'CEREBROVIT X-CEL', 1, 6, 8, 15028),
('00406', 'CERELAC AYAM BWG 120 GR', 1, 6, 8, 7705),
('00407', 'CETEME @12', 1, 6, 6, 1479),
('00408', 'CETIRIZINE TAB 10 MG HEXP', 1, 6, 7, 392),
('00409', 'CETIRIZINE TAB 10 MG KF', 1, 6, 7, 397),
('00410', 'CETIRIZINE TAB 10 MG NOVELL', 1, 6, 7, 392),
('00411', 'CHAOBA-GENOUILLERE ROT', 1, 6, 3, 15600),
('00412', 'CHARM BF ACT SLIM WING 10', 1, 6, 3, 6570),
('00413', 'CHARM BF ACT WINGS @10', 1, 6, 8, 5642),
('00414', 'CHARM BF EX MAXI 8', 1, 6, 8, 3575),
('00415', 'CHARM BF EX MAXI W10', 1, 6, 8, 6533),
('00416', 'CHARM BF EXT MAXI 1', 1, 6, 8, 469),
('00417', 'CHARM SINGLE', 1, 6, 8, 510),
('00418', 'CHIL KID DHA 200 MD', 1, 6, 8, 32427),
('00419', 'CHIL KID DHA 200 VNL', 1, 6, 8, 32427),
('00420', 'CHLORAMPHECORT H CR 10GR', 1, 6, 3, 10863),
('00421', 'CHLORAMPHENICOL KAPS 250 MG INDO', 1, 6, 10, 346),
('00422', 'CHOLESVIT TAB', 1, 6, 7, 913),
('00423', 'CHRYSANTHENUM', 1, 6, 3, 1725),
('00424', 'CIMETIDIN TAB 200 MG FM', 1, 6, 7, 210),
('00425', 'CIMETIDINE TAB 200 MG', 1, 6, 7, 170),
('00426', 'CINDERELLA CT BUDS BABY', 1, 6, 8, 1674),
('00427', 'CIPROFLOXACIN TAB 500 MG NOVA', 1, 6, 7, 390),
('00428', 'CIPROFLOXACIN TAB 500 MG PROMED', 1, 6, 7, 338),
('00429', 'CIPROFLOXACIN TAB 500 NOVELL', 1, 6, 7, 429),
('00430', 'CIPROFLOXACIN TAB 500MG HEX', 1, 6, 7, 429),
('00431', 'CIPTADENT PG 30 GR ICE', 1, 6, 3, 2088),
('00432', 'CIPTADENT PG120 COOL', 1, 6, 8, 4843),
('00433', 'CIPTADENT S WHITE 65 GR', 1, 6, 3, 4120),
('00434', 'CITOCETIN SYR 60ML', 1, 6, 1, 4669),
('00435', 'CITRA FC 130ML FRADIAN', 1, 6, 1, 13618),
('00436', 'CITRA FC 130ML WHT UV', 1, 6, 1, 13618),
('00437', 'CITRA LASTING WHITE 120 ML', 1, 6, 1, 10440),
('00438', 'CLEAR COMPL SC 90ML', 1, 6, 1, 8999),
('00439', 'CLEAR UNI SHP 80 CSC', 1, 6, 1, 10758),
('00440', 'CLINDAMYCIN 300MG INDO', 1, 6, 10, 979),
('00441', 'CLONIDIN TAB 0,15 MG INDO', 1, 6, 7, 267),
('00442', 'CLOSE UP GREEN 65 GR', 1, 6, 5, 4949),
('00443', 'CLUB AIR MINUM 240ML', 1, 6, 1, 688),
('00444', 'COHISTAN 60 ML', 1, 6, 1, 13283),
('00445', 'COLDREXIN SYR 60ML', 1, 6, 1, 4239),
('00446', 'COLFIN SYR 60ML', 1, 6, 1, 6052),
('00447', 'COMBANTRIN JRK', 1, 6, 1, 13514),
('00448', 'COMBANTRIN TAB 125MG', 1, 6, 6, 9680),
('00449', 'COMBANTRIN TAB 250MG', 1, 6, 6, 10319),
('00450', 'COMBI KIDS FRUIT&VEGGIE', 1, 6, 8, 25300),
('00451', 'COMBI KIDS JRK', 1, 6, 8, 19263),
('00452', 'COMBI KIDS STRW', 1, 6, 8, 22138),
('00453', 'COMTUSI 60ML STRW', 1, 6, 1, 38638),
('00454', 'COMTUSI SYR 60ML', 1, 6, 1, 38638),
('00455', 'CONDIABET TAB', 1, 6, 7, 865),
('00456', 'CONFIDENC DIAPER M10', 1, 6, 8, 52211),
('00457', 'CONFIDENCE DIAPER L @1', 1, 6, 8, 5356),
('00458', 'CONFIDENCE DIAPER L10', 1, 6, 8, 58276),
('00459', 'CONFIDENCE DIAPER M @1', 1, 6, 8, 4773),
('00460', 'CONTREXIN TAB', 1, 6, 6, 679),
('00461', 'COOCOOLANT EXT 350ML', 1, 6, 1, 5759),
('00462', 'COOLANT EXTR 350ML', 1, 6, 1, 6399),
('00463', 'COOLING 5 SPRAY', 1, 6, 3, 23760),
('00464', 'COPAL 25GR', 1, 6, 3, 13596),
('00465', 'COPAL CHEST 36GR', 1, 6, 14, 18343),
('00466', 'COPARCETIN KID COUGH 60 ML', 1, 6, 1, 4768),
('00467', 'COPARCTINE 60 ML', 1, 6, 1, 4416),
('00468', 'COREDRYL EXP 100 ML', 1, 6, 1, 6435),
('00469', 'CORTIGRA CR 5 GR', 1, 6, 5, 10523),
('00470', 'COTRIMOXAZOLE TAB', 1, 6, 7, 206),
('00471', 'COUNTERPAIN 15 GR', 1, 6, 3, 21054),
('00472', 'COUNTERPAIN 30GR', 1, 6, 3, 30976),
('00473', 'COUNTERPAIN 5 GR', 1, 6, 3, 12803),
('00474', 'COUNTERPAIN 60GR', 1, 6, 5, 52360),
('00475', 'COUNTERPAIN COOL 15GR', 1, 6, 3, 23825),
('00476', 'COUNTERPAIN COOL 30GR', 1, 6, 5, 33685),
('00477', 'COUNTERPAIN CR 120 GR', 1, 6, 5, 78045),
('00478', 'CROM OPTHAL ED 5ML', 1, 6, 1, 52111),
('00479', 'CTM 4MG @1000', 1, 6, 7, 24),
('00480', 'CTM TAB 4 MG PIM @1000', 1, 6, 7, 30),
('00481', 'CTM TAB PIM', 1, 6, 6, 1146),
('00482', 'CUKA APEL TAHESTA 300ML', 1, 6, 1, 26565),
('00483', 'CURCUMA PLUS DHA JRK 60ML', 1, 6, 1, 12430),
('00484', 'CURCUMA PLUS DHA STRW 60ML', 1, 6, 1, 12430),
('00485', 'CURCUMA PLUS EMULSION JRK', 1, 6, 1, 18645),
('00486', 'CURCUMA PLUS EMULSION STRW', 1, 6, 1, 19888),
('00487', 'CURCUMA PLUS FRUITPUNCH 60ML', 1, 6, 1, 12018),
('00488', 'CURCUMA PLUS IMUNS 60ML', 1, 6, 1, 13915),
('00489', 'CURCUMA PLUS ORG 60ML', 1, 6, 1, 9944),
('00490', 'CURCUMA PLUS SUSU 180GR MD', 1, 6, 8, 21600),
('00491', 'CURCUMA TAB', 1, 6, 7, 871),
('00492', 'CURVIT CL EMUL', 1, 6, 1, 48400),
('00493', 'CURVIT SYR 60ML', 1, 6, 1, 21505),
('00494', 'CUSSON BABY OIL 100ML', 1, 6, 1, 10010),
('00495', 'CUSSON BABY OIL NAT 50ML', 1, 6, 1, 9100),
('00496', 'CUSSON BABY PWD C&P 100 GR', 1, 6, 1, 6175),
('00497', 'CUSSON BABY PWD M&G 100 GR', 1, 6, 1, 6175),
('00498', 'CUSSON BABY PWD MILD&GENT', 1, 6, 1, 5700),
('00499', 'CUSSON BABY PWD SOFT&SMT', 1, 6, 1, 5700),
('00500', 'CUSSON BEDAK 100GR', 1, 6, 8, 6160),
('00501', 'CUSSON CREAM 50 S&S', 1, 6, 14, 14658),
('00502', 'CUSSON CREAM C&P 50GR', 1, 6, 14, 14983),
('00503', 'CUSSON HAIR LOT 50 ML', 1, 6, 1, 11895),
('00504', 'CUSSON OIL 50 M&G', 1, 6, 1, 9100),
('00505', 'CUSSON PWD SS&PK 100GR', 1, 6, 1, 6175),
('00506', 'CUSSON S&S 50 GR', 1, 6, 3, 13530),
('00507', 'CUSSON SHP A&H 50ML', 1, 6, 1, 7800),
('00508', 'CUSSON SHP C&P 50ML', 1, 6, 1, 7800),
('00509', 'CUSSON SOAP M&G 80GR', 1, 6, 3, 2821),
('00510', 'CUSSON SOAP S&S 75 GR', 1, 6, 3, 2821),
('00511', 'CUSSONS OIL S&S 100ML', 1, 6, 1, 15958),
('00512', 'CUSSONS PWD 50 CP-HJ', 1, 6, 1, 3283),
('00513', 'CUSSONS PWD 50GR MG-BR', 1, 6, 1, 3283),
('00514', 'CUSSONS PWD 50GR SS-PK', 1, 6, 1, 3283),
('00515', 'CYCLOFEM INJ', 1, 6, 15, 10439),
('00516', 'DAHLIA KAMFER', 1, 6, 8, 1081),
('00517', 'DAKTARIN CR 10GR', 1, 6, 3, 33770),
('00518', 'DAKTARIN CR 5GR', 1, 6, 3, 20096),
('00519', 'DAKTARIN DIAPER CR 10GR', 1, 6, 5, 56059),
('00520', 'DAKTARIN ORAL GEL', 1, 6, 5, 61468),
('00521', 'DAKTARIN POWDER 20GR', 1, 6, 1, 50600),
('00522', 'DAMABEN DROPS', 1, 6, 1, 15180),
('00523', 'DAMABEN SYR', 1, 6, 1, 11722),
('00524', 'DANCOW 1+ MADU 200GR', 1, 6, 8, 18603),
('00525', 'DANCOW 3+ MADU 200GR', 1, 6, 8, 18198),
('00526', 'DANCOW BATITA 150 VAN', 1, 6, 8, 11232),
('00527', 'DANCOW BATITA MADU 150GR', 1, 6, 8, 11232),
('00528', 'DANCOW BATITA MD 300GR', 1, 6, 8, 21141),
('00529', 'DANCOW CAL CHO 200GR', 1, 6, 8, 15687),
('00530', 'DANCOW DATITA MD 150GR', 1, 6, 8, 10530),
('00531', 'DANCOW DATITA VAN 150GR', 1, 6, 8, 10206),
('00532', 'DANCOW IRON FULL CR 200GR', 1, 6, 8, 16659),
('00533', 'DANCOW IRON FULL CREAM 400GR', 1, 6, 8, 32805),
('00534', 'DANCOW IRON INSTA 200GR', 1, 6, 8, 16281),
('00535', 'DANCOW UHT 190 ML ACTIV', 1, 6, 8, 3840),
('00536', 'DANEURON TAB', 1, 6, 7, 342),
('00537', 'DAPYRIN TAB 500MG @200', 1, 6, 7, 195),
('00538', 'DARSI PIL', 1, 6, 8, 7910),
('00539', 'DECADRYL SYR 120 ML', 1, 6, 1, 14548),
('00540', 'DECADRYL SYR 60ML', 1, 6, 1, 10753),
('00541', 'DECOLGEN HERBAFLU', 1, 6, 12, 1898),
('00542', 'DECOLGEN TAB', 1, 6, 6, 1498),
('00543', 'DECOLSIN CAP', 1, 6, 6, 2366),
('00544', 'DECOLSIN SYR 60ML', 1, 6, 1, 16262),
('00545', 'DECUBAL CR 20 GR', 1, 6, 5, 20592),
('00546', 'DEE DEE MOSQUITO 50 GR', 1, 6, 1, 5753),
('00547', 'DEE DEE SHP REF 125 ML', 1, 6, 1, 5265),
('00548', 'DEGIROL TAB', 1, 6, 6, 2985),
('00549', 'DEMACOLIN 60 ML', 1, 6, 1, 8040),
('00550', 'DEMACOLIN TAB', 1, 6, 7, 306),
('00551', 'DEMACOLIN TAB 1000', 1, 6, 7, 364),
('00552', 'DEPO PROGESTIN 3CC', 1, 6, 15, 8450),
('00553', 'DERMOVATE CR 5 GR', 1, 6, 5, 52938),
('00554', 'DESOLEX N CR 10 GR', 1, 6, 5, 26787),
('00555', 'DETTOL HAND SNT', 1, 6, 1, 6859),
('00556', 'DETTOL LIQ 100ML', 1, 6, 1, 13048),
('00557', 'DETTOL LIQ 50ML', 1, 6, 1, 5585),
('00558', 'DETTOL SOAP 110 GR ALL', 1, 6, 3, 4628),
('00559', 'DETTOL SOAP 70GR ACT', 1, 6, 3, 2977),
('00560', 'DETTOL SOAP 70GR FRESH', 1, 6, 3, 2993),
('00561', 'DETTOL SOAP 70GR SENS', 1, 6, 3, 2977),
('00562', 'DETTOL SOAP COOL 70GR', 1, 6, 3, 3438),
('00563', 'DETTOL SOAP ORG 70GR', 1, 6, 3, 2993),
('00564', 'DETTOL TALK 150 GR', 1, 6, 1, 16385),
('00565', 'DETTOL TALK 75GR', 1, 6, 3, 10625),
('00566', 'DEXAMETHASON 0,5MG @1000', 1, 6, 7, 41),
('00567', 'DEXAMETHASON 0,5MG HARSEN', 1, 6, 7, 199),
('00568', 'DEXAMETHASON 0,75MG HARSEN', 1, 6, 7, 217),
('00569', 'DEXANTA SYR', 1, 6, 1, 12144),
('00570', 'DEXANTA TAB', 1, 6, 7, 192),
('00571', 'DEXIGEN CR 5 GR', 1, 6, 5, 8625),
('00572', 'DEXMOLEX 100ML', 1, 6, 1, 9075),
('00573', 'DEXTAMIN 60ML', 1, 6, 1, 37754),
('00574', 'DEXTAMIN TAB', 1, 6, 7, 1817),
('00575', 'DEXTEEM PLUS TAB', 1, 6, 7, 303),
('00576', 'DEXTRAL 100 ML', 1, 6, 1, 10428),
('00577', 'DEXTRAL 60 ML', 1, 6, 1, 8437),
('00578', 'DEXTRAL F TAB', 1, 6, 7, 756),
('00579', 'DEXTRAL TAB', 1, 6, 7, 591),
('00580', 'DEXTROFORT 60 ML', 1, 6, 1, 8494),
('00581', 'DEXTROMETHORHAN 15MG TAB', 1, 6, 7, 119),
('00582', 'DEXTROMETHORPAN 60 ML INDO', 1, 6, 1, 3723),
('00583', 'DEXTROMETHORPAN 60 ML RAMA', 1, 6, 1, 3300),
('00584', 'DEXTROSE 5% 500ML', 1, 6, 1, 13650),
('00585', 'DEXYCOL TAB 500 MG', 1, 6, 7, 767),
('00586', 'DHE DHE SHP', 1, 6, 1, 1524),
('00587', 'DIABETASOL CAPPU 180GR', 1, 6, 8, 39339),
('00588', 'DIABETASOL CHO 180GR', 1, 6, 8, 38934),
('00589', 'DIABETASOL NR', 1, 6, 6, 2530),
('00590', 'DIABETASOL SWEET 37,5', 1, 6, 8, 16705),
('00591', 'DIABETASOL VAN 180GR', 1, 6, 8, 38934),
('00592', 'DIABETASOL VD 180 GR VNL', 1, 6, 8, 40122),
('00593', 'DIALET', 1, 6, 7, 144),
('00594', 'DIAPET CAP', 1, 6, 6, 1518),
('00595', 'DIAPET NR', 1, 6, 3, 2600),
('00596', 'DIAPET SYR', 1, 6, 1, 6958),
('00597', 'DIASEC TAB', 1, 6, 7, 2338),
('00598', 'DIGOXIN TAB', 1, 6, 7, 179),
('00599', 'DILTIAZEM 30MG TAB GKF', 1, 6, 7, 255),
('00600', 'DINA KAPAS BIASA', 1, 6, 8, 1438),
('00601', 'DINA KAPAS POTONG 30GR', 1, 6, 8, 3125),
('00602', 'DIONICOL KAPS', 1, 6, 10, 848),
('00603', 'DIONICOL SYR 60ML', 1, 6, 1, 5999),
('00604', 'DIPROGENTA OINT 5GR', 1, 6, 5, 51321),
('00605', 'DIPS SYR 10 CC', 1, 6, 3, 3600),
('00606', 'DISP SYR NIPRO 10 CC', 1, 6, 3, 3600),
('00607', 'DISP SYR NIPRO 20 CC', 1, 6, 3, 8000),
('00608', 'DISP SYR NIPRO 3 CC', 1, 6, 3, 1750),
('00609', 'DISP SYR NIPRO 5 CC', 1, 6, 3, 3000),
('00610', 'DISP. SYR 10CC TERUMO', 1, 6, 3, 2340),
('00611', 'DISP. SYR 1CC INS TERUMO', 1, 6, 3, 2600),
('00612', 'DISP. SYR 1CC TERUMO', 1, 6, 3, 2400),
('00613', 'DISP. SYR 3CC BD', 1, 6, 3, 1280),
('00614', 'DISP. SYR 3CC TERUMO', 1, 6, 3, 1560),
('00615', 'DISP. SYR 5CC BD', 1, 6, 3, 2400),
('00616', 'DISP. SYR 5CC TERUMO', 1, 6, 3, 4550),
('00617', 'DIYET BOROBUDUR', 1, 6, 8, 9200),
('00618', 'DODO BUD BB Z100 133', 1, 6, 8, 3738),
('00619', 'DOLO LICOBION', 1, 6, 7, 520),
('00620', 'DOLO NEUROBION', 1, 6, 6, 14856),
('00621', 'DOMESTOS PRO LAV JMB', 1, 6, 8, 3300),
('00622', 'DOMPERIDONE', 1, 6, 7, 253),
('00623', 'DOXIGEN CR 5GR', 1, 6, 5, 6581),
('00624', 'DOXYCYCLIN KAPS 100 MG INDO', 1, 6, 10, 329),
('00625', 'DR KANG ADULT DIAPERS @L2', 1, 6, 8, 18480),
('00626', 'DR KANG ADULT DIAPERS XL@8', 1, 6, 8, 66000),
('00627', 'DR KANG ADUTL DIAPERS @L8', 1, 6, 8, 72000),
('00628', 'DR. KANG XL8', 1, 6, 3, 63250),
('00629', 'DR. P ADULT BASIC L2', 1, 6, 8, 15600),
('00630', 'DR. P ADULT BASIC M2', 1, 6, 8, 14400),
('00631', 'DR. P ADULT SPECIAL L2', 1, 6, 8, 13193),
('00632', 'DR. P ADULT SPECIAL L8', 1, 6, 8, 46161),
('00633', 'DR. P BASIC L8', 1, 6, 3, 51387),
('00634', 'DR. P BASIC M10', 1, 6, 3, 48590),
('00635', 'DR. P SPC M8', 1, 6, 3, 46330),
('00636', 'DRAGON MENTHOL (K)', 1, 6, 3, 3795),
('00637', 'DRAGON MENTHOL H1', 1, 6, 3, 6199),
('00638', 'DRAGON MENTHOL H2', 1, 6, 3, 4744),
('00639', 'DRAGON MENTHOL HSB 20GR', 1, 6, 3, 18695),
('00640', 'DRAGON MENTHOL HSP 8GR', 1, 6, 3, 7865),
('00641', 'DRAMAMINE TAB 50 MG', 1, 6, 7, 1500),
('00642', 'DRP. P ADULT BASIC M2', 1, 6, 8, 11115),
('00643', 'DS 5% 500ML', 1, 6, 1, 6250),
('00644', 'DULCOLACTOL SYR 60 ML', 1, 6, 1, 46101),
('00645', 'DULCOLAX SUPP ADULT', 1, 6, 13, 16976),
('00646', 'DULCOLAX SUPP ANAK', 1, 6, 13, 13728),
('00647', 'DULCOLAX TAB', 1, 6, 6, 4687),
('00648', 'DUMIN 60 ML', 1, 6, 1, 16859),
('00649', 'DUMIN TAB', 1, 6, 7, 401),
('00650', 'DUMOCALCIN MINT 30', 1, 6, 7, 481),
('00651', 'DUREX EXTRA SAFE @3', 1, 6, 3, 14561),
('00652', 'DUREX FETHERLITE @3', 1, 6, 3, 13236),
('00653', 'DUREX RIBBED @3', 1, 6, 8, 13236),
('00654', 'DUREX TOGETHER @3', 1, 6, 3, 11108),
('00655', 'E JUSS', 1, 6, 8, 3910),
('00656', 'EASY TOUCH BLOOD CHOLESTEROL @10', 1, 6, 3, 17550),
('00657', 'EASY TOUCH BLOOD GLUCOSE @25', 1, 6, 3, 80500),
('00658', 'EASY TOUCH URIC ACID @25', 1, 6, 3, 4160),
('00659', 'EFISOL LIQ 10ML', 1, 6, 1, 21505),
('00660', 'EKSIM 7GR', 1, 6, 3, 7000),
('00661', 'ELKANA SYR 60ML', 1, 6, 1, 21175),
('00662', 'ELKANA TAB', 1, 6, 7, 805),
('00663', 'EM KAPSUL', 1, 6, 8, 7910),
('00664', 'EMBALAGE', 1, 6, 3, 100),
('00665', 'EMERON SHP 50 ML SM', 1, 6, 1, 2145),
('00666', 'EMERON SHP 50ML LIME', 1, 6, 1, 2145),
('00667', 'EMINETON', 1, 6, 7, 1725),
('00668', 'EMPENG GROSIR', 1, 6, 3, 10010),
('00669', 'EMPENG NINIO @24', 1, 6, 3, 7084),
('00670', 'ENATIN', 1, 6, 10, 1392),
('00671', 'ENBATIC', 1, 6, 3, 2544),
('00672', 'ENBATIC ZALF', 1, 6, 3, 7081),
('00673', 'ENERVON C @30', 1, 6, 1, 28359),
('00674', 'ENERVON C @4', 1, 6, 6, 3969),
('00675', 'ENERVON C EFF', 1, 6, 3, 26964),
('00676', 'ENERVON C PLUS 120 ML', 1, 6, 1, 16569),
('00677', 'ENKASARI SYR 60ML', 1, 6, 1, 13685),
('00678', 'ENTRASOL CHO 185 GR', 1, 6, 8, 32292),
('00679', 'ENTRASOL GOLD CHO 185 GR', 1, 6, 8, 30024),
('00680', 'ENTRASOL GOLD PLAIN 185 GR', 1, 6, 8, 28971),
('00681', 'ENTRASOL GOLD VAN 185 GR', 1, 6, 8, 29700),
('00682', 'ENTROSTOP', 1, 6, 6, 3500),
('00683', 'ENTROSTOP ANAK', 1, 6, 12, 1531),
('00684', 'ENZIM MINT 35 GR', 1, 6, 5, 8580),
('00685', 'ENZIM PG MILD', 1, 6, 3, 21700),
('00686', 'ENZIM PG MINT', 1, 6, 3, 12708),
('00687', 'ENZYPLEX @4', 1, 6, 6, 3682),
('00688', 'EQUAL POT @100', 1, 6, 3, 23316),
('00689', 'ERICAF TAB', 1, 6, 7, 5255),
('00690', 'ERLA NEO HYDROCORT CR 5 GR', 1, 6, 5, 5134),
('00691', 'ERLADERM N CR', 1, 6, 5, 4719),
('00692', 'ERLAMYCETIN SM', 1, 6, 3, 4689),
('00693', 'ERLAMYCETIN TM 5ML', 1, 6, 3, 6875),
('00694', 'ERLAMYCETIN TT 5ML', 1, 6, 3, 4386),
('00695', 'ERLAMYCETINE ED PLUS', 1, 6, 1, 9910),
('00696', 'ERMETHASONE 0,5MG TAB', 1, 6, 7, 165),
('00697', 'ERPHAMAZOLE CR 5GR', 1, 6, 5, 4490),
('00698', 'ERPHAMOL 60ML', 1, 6, 1, 11638),
('00699', 'ERPHAMOL TAB 500 MG', 1, 6, 7, 170),
('00700', 'ERSYLAN 60ML', 1, 6, 1, 11495),
('00701', 'ERYSANBE D.S 60ML', 1, 6, 1, 24750),
('00702', 'ERYTHROMICIN 500MG', 1, 6, 7, 813),
('00703', 'ERYTHROMYCIN 100MG SYR INDO', 1, 6, 1, 10518),
('00704', 'ESKIM ZALF', 1, 6, 3, 6670),
('00705', 'ESPERSON CR 0,25% 5GR', 1, 6, 5, 44300),
('00706', 'ESQUISE BARU', 1, 6, 12, 518),
('00707', 'ESTER C @30', 1, 6, 1, 34122),
('00708', 'ESTER C @4', 1, 6, 6, 5000),
('00709', 'ESTER C EFF', 1, 6, 3, 27025),
('00710', 'ESVAT TAB 10MG', 1, 6, 7, 1502),
('00711', 'ETABION TAB', 1, 6, 7, 197),
('00712', 'ETAFLUSIN SYR 60ML', 1, 6, 1, 4048),
('00713', 'ETAFLUSIN TAB', 1, 6, 7, 525),
('00714', 'ETAGESIC 60ML', 1, 6, 1, 3723),
('00715', 'ETAMOX 60ML', 1, 6, 1, 5280),
('00716', 'ETAMOX TAB 500MG', 1, 6, 7, 480),
('00717', 'ETAMOXUL F TAB', 1, 6, 7, 377),
('00718', 'ETAMOXUL TAB', 1, 6, 7, 221),
('00719', 'ETTAWA SUSU KAMBING', 1, 6, 8, 31050),
('00720', 'ETTAWA SUSU KAMBING PAKET', 1, 6, 8, 50600),
('00721', 'EVER E 250 BOTOL', 1, 6, 1, 57558),
('00722', 'EVER E 250IU @12', 1, 6, 8, 23866),
('00723', 'EVION TAB 100', 1, 6, 7, 1299),
('00724', 'EXLUTON PIL KB', 1, 6, 6, 21299),
('00725', 'EXSIM 19 BIRU', 1, 6, 8, 2588),
('00726', 'EXTRA JOSS', 1, 6, 8, 925),
('00727', 'EXTRAFLU TAB', 1, 6, 7, 177),
('00728', 'FACIAL NASA TRAVEL PACK', 1, 6, 8, 2888),
('00729', 'FACIAL SUCCESSFUL', 1, 6, 8, 5606),
('00730', 'FAKTU OINT 20GR', 1, 6, 5, 99220),
('00731', 'FAMEPRIM TAB', 1, 6, 7, 288),
('00732', 'FAMOTODINE KAPS', 1, 6, 10, 147),
('00733', 'FANBO PWD PUFF', 1, 6, 14, 3673),
('00734', 'FARGETIK TAB 500MG', 1, 6, 7, 495),
('00735', 'FARIDEXON TAB', 1, 6, 7, 161),
('00736', 'FARIDEXON TAB 0,5MG', 1, 6, 7, 103),
('00737', 'FARMOTEN TAB 12,5MG', 1, 6, 7, 329),
('00738', 'FARSIFEN 400MG TAB', 1, 6, 7, 371),
('00739', 'FARSIFEN 60 ML', 1, 6, 1, 8750),
('00740', 'FASIDOL DROP', 1, 6, 1, 8353),
('00741', 'FASIDOL F 60 ML', 1, 6, 1, 4741),
('00742', 'FASIDOL SYR 60ML', 1, 6, 1, 4649),
('00743', 'FASORBID 5MG TAB', 1, 6, 7, 279),
('00744', 'FATIGON SPIRIT', 1, 6, 6, 5579),
('00745', 'FATIGON TAB @4', 1, 6, 6, 2650),
('00746', 'FATIGON VIRO @5', 1, 6, 6, 3416),
('00747', 'FAXIDEN TAB 20MG', 1, 6, 7, 351),
('00748', 'FEMINAX @4', 1, 6, 6, 1800),
('00749', 'FERMINO', 1, 6, 1, 15000),
('00750', 'FEVRIN SYR 60ML', 1, 6, 1, 14295),
('00751', 'FEVRIN TAB', 1, 6, 6, 4599),
('00752', 'FG TROCHES @120', 1, 6, 7, 1028),
('00753', 'FIESTA ALL NIGHT @3', 1, 6, 8, 6749),
('00754', 'FIESTA PASSION @3', 1, 6, 8, 6749),
('00755', 'FITKOM ANGGUR', 1, 6, 1, 11385),
('00756', 'FITKOM GUMMY', 1, 6, 8, 14916),
('00757', 'FITKOM GUMMY CALCIUM', 1, 6, 8, 16445),
('00758', 'FITKOM GUMMY FRUIT&VEGGIE', 1, 6, 8, 20350),
('00759', 'FITKOM JERUK', 1, 6, 8, 11385),
('00760', 'FITKOM PLATINUM 100 ML', 1, 6, 1, 15307),
('00761', 'FITKOM STRW', 1, 6, 8, 11385),
('00762', 'FLAGYSTATIS OVULE', 1, 6, 13, 21137),
('00763', 'FLAMAR GEL 20 GR', 1, 6, 5, 16964),
('00764', 'FLAMESON 4 MG', 1, 6, 7, 862),
('00765', 'FLAMIGRA TAB', 1, 6, 7, 434),
('00766', 'FLORA MADU TRPC 100ML', 1, 6, 1, 13685),
('00767', 'FLOXIFAR TAB', 1, 6, 7, 560),
('00768', 'FLOXIGRA 500MG TAB', 1, 6, 7, 946),
('00769', 'FLUCADEX SYR 60 ML', 1, 6, 1, 10078),
('00770', 'FLUCADEX TAB', 1, 6, 7, 480),
('00771', 'FLUDANE PLUS SYR 60ML', 1, 6, 1, 18343),
('00772', 'FLUDANE SYR 60ML', 1, 6, 1, 14916),
('00773', 'FLUDANE TAB @4', 1, 6, 6, 2935),
('00774', 'FLUDEXIN TAB', 1, 6, 6, 2500),
('00775', 'FLUIMUCIL 60 ML', 1, 6, 1, 49335),
('00776', 'FLUMIN TAB', 1, 6, 7, 438),
('00777', 'FLUNAX 60ML', 1, 6, 1, 4670),
('00778', 'FLUTAMOL 60ML', 1, 6, 1, 12650),
('00779', 'FLUTAMOL TAB', 1, 6, 7, 509),
('00780', 'FLUTOP-C 60 ML', 1, 6, 1, 6400),
('00781', 'FOLAVIT TAB 400IU', 1, 6, 7, 702),
('00782', 'FORA HO KEMIRI 65ML', 1, 6, 1, 6305),
('00783', 'FORMULA JNR PG 50GR', 1, 6, 3, 4375),
('00784', 'FORMULA KITA GIGI DWS', 1, 6, 3, 2443),
('00785', 'FORMULA SG HC 50GR', 1, 6, 3, 4514),
('00786', 'FORMULA SG HC DORAEMON', 1, 6, 3, 7183),
('00787', 'FORMULA SG PROT', 1, 6, 3, 2827),
('00788', 'FORMULA SG S PROT SYS S', 1, 6, 3, 2633),
('00789', 'FORMULA YNR PG 50GR', 1, 6, 3, 3594),
('00790', 'FORMYCO TAB', 1, 6, 7, 5418),
('00791', 'FORUMEN ED 10 ML', 1, 6, 1, 28655),
('00792', 'FRAGOR TAB', 1, 6, 7, 813),
('00793', 'FRESH CARE GREEN TEA', 1, 6, 1, 10063),
('00794', 'FRESH CARE HOT', 1, 6, 1, 10063),
('00795', 'FRESH CARE LAVENDER', 1, 6, 1, 10063),
('00796', 'FRESH CARE ORIGINAL', 1, 6, 1, 10063),
('00797', 'FRESH CARE SPLASH FRUIT', 1, 6, 1, 10063),
('00798', 'FRESH CREAM', 1, 6, 1, 22750),
('00799', 'FREZZA SPRAY REG', 1, 6, 1, 17078),
('00800', 'FRISIAN F 456 200 MD', 1, 6, 8, 14229),
('00801', 'FRISIAN GLAG SCHOOL 190ML', 1, 6, 3, 3088),
('00802', 'FRISIAN KID 115ML STRW', 1, 6, 8, 2481),
('00803', 'FRISIAN SCHOOL 190 ML STRW', 1, 6, 8, 3368),
('00804', 'FRISIAN UHT 190 BERRY', 1, 6, 8, 3120),
('00805', 'FRISIAN UHT190 COBLS', 1, 6, 8, 3088),
('00806', 'FROZZ BLUE MINT', 1, 6, 8, 6034),
('00807', 'FROZZ LIME MINT', 1, 6, 8, 6034),
('00808', 'FROZZ MINT', 1, 6, 8, 6034),
('00809', 'FROZZ ORANGE', 1, 6, 8, 6034),
('00810', 'FROZZ PERMENT', 1, 6, 8, 6296),
('00811', 'FUMADRYL 60 ML', 1, 6, 1, 3750),
('00812', 'FUNGIDERM 10GR', 1, 6, 3, 17250),
('00813', 'FUNGIDERM 5GR', 1, 6, 3, 11969),
('00814', 'FUROSEMID 40MG', 1, 6, 7, 128),
('00815', 'FUSICOM CR 5GR', 1, 6, 5, 47438),
('00816', 'FUSON CR 5GR', 1, 6, 5, 47438),
('00817', 'GABITEN TAB', 1, 6, 7, 416),
('00818', 'GALIAN WANITA PIM', 1, 6, 1, 16000),
('00819', 'GARAMYCIN CR 5 GR', 1, 6, 5, 29893),
('00820', 'GARAMYCIN OINT 5 GR', 1, 6, 5, 29893),
('00821', 'GARGLIN 15 ML @6', 1, 6, 3, 1576),
('00822', 'GARLIC SAUDA PLUS PROPOLIS', 1, 6, 1, 30800),
('00823', 'GASTBY WG 30 SOFT', 1, 6, 14, 3023),
('00824', 'GASTRUCID SYR 60ML', 1, 6, 1, 4337),
('00825', 'GASTRUCID TAB', 1, 6, 7, 296),
('00826', 'GAZERO @6', 1, 6, 12, 1392),
('00827', 'GELAS UKUR 50ML', 1, 6, 3, 30000),
('00828', 'GELIGA BALSAM 10GR', 1, 6, 3, 2923),
('00829', 'GELIGA BALSAM 20GR', 1, 6, 3, 5708),
('00830', 'GELIGA BALSAM 40GR', 1, 6, 3, 10926),
('00831', 'GEMFIBROZIL 300MG', 1, 6, 7, 438),
('00832', 'GEMUK SEHAT BOROBUDUR', 1, 6, 8, 9200),
('00833', 'GEMUK SEHAT PIM', 1, 6, 1, 16000),
('00834', 'GENERAL CARE EB 10 X 4,5 CM', 1, 6, 3, 23400),
('00835', 'GENOINT EYE OINT 0,3%', 1, 6, 7, 7161),
('00836', 'GENOINT TM', 1, 6, 3, 8470),
('00837', 'GENOINT ZALF', 1, 6, 3, 4620),
('00838', 'GENTALEX CR 5 GR', 1, 6, 5, 6188),
('00839', 'GENTAMYCIN 0,1% 5GR', 1, 6, 3, 2500),
('00840', 'GENTIAN VIOLET', 1, 6, 3, 2694),
('00841', 'GILLET BLUE II', 1, 6, 3, 5219),
('00842', 'GILLET GOAL II HC', 1, 6, 3, 4810),
('00843', 'GILLET GOAL KLIK HC', 1, 6, 3, 4844),
('00844', 'GINIFAR TAB', 1, 6, 7, 360),
('00845', 'GIV SABUN 80 GR MERAH', 1, 6, 8, 1820),
('00846', 'GIV SABUN 80 PEAR SC', 1, 6, 3, 1750),
('00847', 'GIV SABUN 80GR BKG', 1, 6, 8, 1820),
('00848', 'GIV SABUN 80GR PEPAYA', 1, 6, 8, 1820),
('00849', 'GIV SABUN 80GR UNGU', 1, 6, 8, 1820),
('00850', 'GIV SABUN COKLAT 80GR', 1, 6, 3, 1750),
('00851', 'GIV SABUN PUTIH 80GR', 1, 6, 3, 1820),
('00852', 'GIZI SUPER CR', 1, 6, 3, 7791),
('00853', 'GLIBENCLAMIDE TAB', 1, 6, 7, 108),
('00854', 'GLIMEPIRIDE TAB 10MG HEXP', 1, 6, 7, 950),
('00855', 'GLUCOSAMIN 500 MG INDO', 1, 6, 7, 2640),
('00856', 'GLUCOSAMIN MPL 500MG', 1, 6, 7, 1914),
('00857', 'GLUCOSE DX 5%', 1, 6, 8, 6250),
('00858', 'GLUDEPATIC TAB 500MG', 1, 6, 7, 257),
('00859', 'GLYCERIL GUAICOLAT', 1, 6, 7, 132),
('00860', 'GPU M. URUT 30ML', 1, 6, 1, 5896),
('00861', 'GPU M.URUT 60ML', 1, 6, 1, 10980),
('00862', 'GRADILEX TAB', 1, 6, 7, 284),
('00863', 'GRADINE 100 MG', 1, 6, 7, 550),
('00864', 'GRAFACHLOR TAB', 1, 6, 7, 330),
('00865', 'GRAFADON DROPS', 1, 6, 1, 8430),
('00866', 'GRAFADON F TAB', 1, 6, 7, 242),
('00867', 'GRAFADON SYR 60ML', 1, 6, 1, 6230),
('00868', 'GRAFADON TAB', 1, 6, 7, 136),
('00869', 'GRAFALIN 2MG', 1, 6, 7, 118),
('00870', 'GRAFALIN 4MG', 1, 6, 7, 323),
('00871', 'GRAFAMIC', 1, 6, 7, 352),
('00872', 'GRAFAZOL TAB', 1, 6, 7, 600),
('00873', 'GRAFLOXIN TAB 400 MG', 1, 6, 7, 2240),
('00874', 'GRAGENTA CR 5 GR', 1, 6, 5, 9500),
('00875', 'GRAHABION TAB', 1, 6, 10, 507),
('00876', 'GRALIXA 40MG TAB', 1, 6, 7, 150),
('00877', 'GRALYSIN 60 ML', 1, 6, 1, 11002),
('00878', 'GRAMETA DROPS', 1, 6, 1, 4374),
('00879', 'GRAMETA TAB', 1, 6, 7, 282),
('00880', 'GRANTUSIF TAB', 1, 6, 7, 649),
('00881', 'GRAPERIDE TAB 100', 1, 6, 7, 247),
('00882', 'GRAPRIMA F TAB', 1, 6, 7, 397),
('00883', 'GRATHAZON TAB', 1, 6, 7, 252),
('00884', 'GRATHEOS 50 MG @50', 1, 6, 7, 502),
('00885', 'GRAZEO TAB 20 MG', 1, 6, 7, 306),
('00886', 'GREEN CARE', 1, 6, 1, 20400),
('00887', 'GRISEOFULVIN TAB 125MG INF', 1, 6, 7, 312),
('00888', 'GROWFAT CAP', 1, 6, 1, 50050),
('00889', 'GUANISTREP SYR 60 ML', 1, 6, 1, 4370),
('00890', 'GURAH ALBI DWS', 1, 6, 1, 26450),
('00891', 'GURAH AS SYIFA @12', 1, 6, 1, 14400),
('00892', 'H. KURMA AJWA 120 NHM', 1, 6, 1, 18480),
('00893', 'H. KURMA AJWA 120 TKU', 1, 6, 1, 33600),
('00894', 'H. KURMA AJWA 210 NHM', 1, 6, 1, 24948),
('00895', 'H. KURMA AJWA @100', 1, 6, 1, 21850),
('00896', 'H. KURMA AJWA @100 TKU', 1, 6, 1, 24000),
('00897', 'H. KURMA AJWA @120', 1, 6, 1, 28250),
('00898', 'H.KURMA AJWA @210', 1, 6, 1, 43700),
('00899', 'HABASYA OIL', 1, 6, 1, 40700),
('00900', 'HABASYI OIL', 1, 6, 1, 42550),
('00901', 'HABATUS SAUDANA 100', 1, 6, 1, 17600),
('00902', 'HABATUS SAUDANA 200', 1, 6, 1, 42550),
('00903', 'HABBAFIT KIDS', 1, 6, 1, 30510),
('00904', 'HALFILYN 100ML', 1, 6, 1, 6875),
('00905', 'HALMEZINE SYR 100ML', 1, 6, 1, 28188),
('00906', 'HANSAPLAST @100', 1, 6, 3, 230),
('00907', 'HANSAPLAST JUMBO', 1, 6, 3, 542),
('00908', 'HANSAPLAST KOYO HANGAT @10', 1, 6, 3, 3955),
('00909', 'HANSAPLAST KOYO PANAS @10', 1, 6, 3, 3955),
('00910', 'HANSAPLAST ROL 1,25X1 @20', 1, 6, 3, 2990),
('00911', 'HANSAPLAST ROL 1,25X5 @10', 1, 6, 3, 8450),
('00912', 'HANSAPLAST ROLL', 1, 6, 3, 2405),
('00913', 'HANSAPLAST S. CARE @10', 1, 6, 8, 385),
('00914', 'HANSAPLAST S. CARE JNR', 1, 6, 3, 450),
('00915', 'HAPPYDENT BLIST 14GR', 1, 6, 8, 2588),
('00916', 'HAU FUNG SAN', 1, 6, 8, 2500),
('00917', 'HC SENSI GLOVES (L)', 1, 6, 3, 740),
('00918', 'HC SENSI GLOVES (M) ECERAN', 1, 6, 3, 780),
('00919', 'HC SENSI GLOVES (M) GROSIR', 1, 6, 9, 46800),
('00920', 'HC SENSI GLOVES (S) ECERAN', 1, 6, 8, 1140),
('00921', 'HC SENSI GLOVES (S) GROSIR', 1, 6, 8, 45600),
('00922', 'HEMAVITON ACTION @5', 1, 6, 6, 5335),
('00923', 'HEMAVITON C 1000 150ML', 1, 6, 1, 4154),
('00924', 'HEMAVITON C 1000 @5', 1, 6, 3, 1064),
('00925', 'HEMAVITON E DRINK 150 ML', 1, 6, 1, 3640),
('00926', 'HEMAVITON SKIN N', 1, 6, 6, 4715),
('00927', 'HEMAVITON STAMINA', 1, 6, 6, 4974),
('00928', 'HEMORID KAPS', 1, 6, 10, 747),
('00929', 'HEPATOSOL VAN 185GR', 1, 6, 8, 69552),
('00930', 'HERBA JAWI', 1, 6, 1, 25300),
('00931', 'HERBORIST SB SERE 160GR', 1, 6, 3, 6611),
('00932', 'HERBORIST SR 80GR', 1, 6, 3, 3996),
('00933', 'HERKUAT KAPS', 1, 6, 10, 1604),
('00934', 'HEROCYN 150GR', 1, 6, 3, 12036),
('00935', 'HEROCYN 75GR', 1, 6, 3, 7876),
('00936', 'HEROCYN BABY 100GR', 1, 6, 1, 4479),
('00937', 'HEXAVASK TAB 5MG', 1, 6, 7, 2383),
('00938', 'HEXON SYR 60ML', 1, 6, 1, 8476),
('00939', 'HEXOS MINT PERMENT', 1, 6, 3, 1459),
('00940', 'HEXOS SUGAR FREE', 1, 6, 3, 8159),
('00941', 'HI-LO ACT KH 200GR', 1, 6, 8, 23760),
('00942', 'HI-LO ACT VAN 200GR', 1, 6, 8, 23760),
('00943', 'HI-LO TEEN CHO 200GR', 1, 6, 8, 22680),
('00944', 'HICO GEL CR 15GR', 1, 6, 5, 14850),
('00945', 'HIGH ELASTIS B GC 10CM', 1, 6, 3, 20700),
('00946', 'HIGH ELASTIS B GC 7,5CM', 1, 6, 3, 8050),
('00947', 'HILO ACTIV 250GR CHO', 1, 6, 8, 32157),
('00948', 'HILO KH 200 GR', 1, 6, 8, 26799),
('00949', 'HILO TEEN 250GR CHO', 1, 6, 8, 28512),
('00950', 'HILO VANILA 200 GR', 1, 6, 8, 28512);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pasien`
--

CREATE TABLE `tbl_pasien` (
  `no_rekamedis` varchar(10) NOT NULL,
  `id_gol_darah` int NOT NULL,
  `id_agama` int NOT NULL,
  `id_pekerjaan` int NOT NULL,
  `nama_pasien` varchar(30) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `tempat_lahir` varchar(30) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `nama_ibu` varchar(30) NOT NULL,
  `alamat` text NOT NULL,
  `status_menikah` varchar(30) NOT NULL,
  `no_hp` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pasien`
--

INSERT INTO `tbl_pasien` (`no_rekamedis`, `id_gol_darah`, `id_agama`, `id_pekerjaan`, `nama_pasien`, `jenis_kelamin`, `tempat_lahir`, `tanggal_lahir`, `nama_ibu`, `alamat`, `status_menikah`, `no_hp`) VALUES
('000006', 4, 1, 2, 'Khaerul Manaf', 'L', 'Bandung', '1979-03-30', 'ATUN', 'CICAHEUM', '1', '081123281928'),
('0002', 1, 1, 1, 'Ujang', 'L', 'Cibiru', '2020-02-13', 'hh', 'ghjg', '1', '00876'),
('0003', 2, 1, 1, 'TEMY', 'L', 'Bandung', '1998-03-11', 'ATUN', 'BANDUNG', '1', '081123281928'),
('0004', 1, 1, 1, 'AGUNG', 'L', 'Bandung', '1998-03-12', 'IBU', 'RANCAEKEK', '2', '081123281928'),
('0005', 3, 1, 1, 'AA', 'L', 'Cibiru', '2020-02-13', 'hh', 'hjbhb', '1', '00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pegawai`
--

CREATE TABLE `tbl_pegawai` (
  `nik` int NOT NULL,
  `nama_pegawai` varchar(50) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `npwp` varchar(25) NOT NULL,
  `id_jenjang_pendidikan` int NOT NULL,
  `tempat_lahir` varchar(30) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `id_jabatan` int NOT NULL,
  `kode_jenjang` varchar(10) NOT NULL,
  `id_departemen` int NOT NULL,
  `id_bidang` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pegawai`
--

INSERT INTO `tbl_pegawai` (`nik`, `nama_pegawai`, `jenis_kelamin`, `npwp`, `id_jenjang_pendidikan`, `tempat_lahir`, `tanggal_lahir`, `id_jabatan`, `kode_jenjang`, `id_departemen`, `id_bidang`) VALUES
(121919, 'Harha', 'L', '123', 6, 'Cibiru', '2020-01-11', 1, 'J1', 1, 1),
(19281927, 'Haryanto', 'L', '1266', 6, 'Bandung', '1998-03-01', 5, 'J1', 4, 1),
(19281929, 'Waksim', 'L', '889899', 6, 'Bandung', '1998-03-01', 4, 'J1', 3, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pekerjaan`
--

CREATE TABLE `tbl_pekerjaan` (
  `id_pekerjaan` int NOT NULL,
  `nama_pekerjaan` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pekerjaan`
--

INSERT INTO `tbl_pekerjaan` (`id_pekerjaan`, `nama_pekerjaan`) VALUES
(1, 'PNS'),
(2, 'SWASTA');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pemeriksaan_laboratorium`
--

CREATE TABLE `tbl_pemeriksaan_laboratorium` (
  `kode_periksa` varchar(6) NOT NULL,
  `nama_periksa` varchar(100) NOT NULL,
  `tarif` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pemeriksaan_laboratorium`
--

INSERT INTO `tbl_pemeriksaan_laboratorium` (`kode_periksa`, `nama_periksa`, `tarif`) VALUES
('DR', 'Darah', 45000),
('SB', 'Urin', 40000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pendaftaran`
--

CREATE TABLE `tbl_pendaftaran` (
  `no_registrasi` varchar(10) NOT NULL,
  `no_rawat` varchar(18) NOT NULL,
  `no_rekamedis` varchar(6) NOT NULL,
  `cara_masuk` varchar(30) NOT NULL,
  `tanggal_daftar` datetime NOT NULL,
  `tanggal_keluar` date DEFAULT NULL,
  `kode_dokter_penanggung_jawab` int NOT NULL,
  `id_poli` int NOT NULL,
  `nama_penanggung_jawab` varchar(30) NOT NULL,
  `hubungan_dengan_penanggung_jawab` varchar(30) NOT NULL,
  `alamat_penanggung_jawab` text NOT NULL,
  `id_jenis_bayar` int NOT NULL,
  `asal_rujukan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pendaftaran`
--

INSERT INTO `tbl_pendaftaran` (`no_registrasi`, `no_rawat`, `no_rekamedis`, `cara_masuk`, `tanggal_daftar`, `tanggal_keluar`, `kode_dokter_penanggung_jawab`, `id_poli`, `nama_penanggung_jawab`, `hubungan_dengan_penanggung_jawab`, `alamat_penanggung_jawab`, `id_jenis_bayar`, `asal_rujukan`) VALUES
('0002', '2020/09/23/0002', '0004', 'RAWAT INAP', '2020-09-23 00:00:00', NULL, 59, 37, 'SETIADI', 'saudara kandung', 'Cigondewah', 1, '-'),
('0003', '2020/09/23/0003', '0004', 'RAWAT INAP', '2020-09-23 00:00:00', NULL, 59, 37, 'SETIADI', 'saudara kandung', 'cigo', 1, '-'),
('0004', '2020/09/23/0004', '0004', 'RAWAT JALAN', '2020-09-23 00:00:00', NULL, 61, 12, 'SETIADI', 'saudara kandung', 'Cijagra', 1, '-'),
('0001', '2020/09/24/0001', '0002', 'RAWAT INAP', '2020-09-24 00:00:00', NULL, 74, 5, 'Dede', 'saudara kandung', 'Cilamaka', 1, '-'),
('0001', '2020/09/26/0001', '000006', 'RAWAT JALAN', '2020-09-26 00:00:00', NULL, 1, 37, 'Dede', 'saudara kandung', 'JAJA', 1, '-'),
('0002', '2020/09/26/0002', '000006', 'UGD', '2020-09-26 00:00:00', NULL, 11, 37, 'Dede', 'saudara kandung', 'Cigondewah', 1, '-'),
('0003', '2020/09/26/0003', '000006', 'RAWAT INAP', '2020-09-26 00:00:00', NULL, 11, 37, 'SETIADI', 'saudara kandung', 'cigondewah', 1, '-');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pengadaan_detail`
--

CREATE TABLE `tbl_pengadaan_detail` (
  `id_pengadaan` int NOT NULL,
  `kode_barang` varchar(6) NOT NULL,
  `qty` int NOT NULL,
  `no_faktur` varchar(10) NOT NULL,
  `harga` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pengadaan_detail`
--

INSERT INTO `tbl_pengadaan_detail` (`id_pengadaan`, `kode_barang`, `qty`, `no_faktur`, `harga`) VALUES
(17, '001', 40, 'TR00020', 10000),
(19, '002', 10, 'TR00020', 50000),
(20, '001', 5, 'FK0031', 10),
(21, '002', 70, '', 45000),
(22, '001', 70, '', 45000),
(23, '001', 70, 'BR00034', 45000),
(24, '002', 70, 'BR00034', 45000),
(25, '00677', 3, 'ff01', 6500);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pengadaan_obat_alkes_bhp`
--

CREATE TABLE `tbl_pengadaan_obat_alkes_bhp` (
  `no_faktur` varchar(10) NOT NULL,
  `tanggal` date NOT NULL,
  `kode_supplier` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pengadaan_obat_alkes_bhp`
--

INSERT INTO `tbl_pengadaan_obat_alkes_bhp` (`no_faktur`, `tanggal`, `kode_supplier`) VALUES
('FK0031', '2017-12-13', '0001'),
('TR00020', '2017-12-12', 'kimia fa');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_penjualan_detail`
--

CREATE TABLE `tbl_penjualan_detail` (
  `id_penjualan` int NOT NULL,
  `kode_barang` int NOT NULL,
  `qty` int NOT NULL,
  `no_faktur` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_penjualan_detail`
--

INSERT INTO `tbl_penjualan_detail` (`id_penjualan`, `kode_barang`, `qty`, `no_faktur`) VALUES
(3, 1, 1, '1234'),
(4, 1, 1, '1234');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_penjualan_obat_alkes_bhp`
--

CREATE TABLE `tbl_penjualan_obat_alkes_bhp` (
  `no_faktur` varchar(8) NOT NULL,
  `tanggal` date NOT NULL,
  `nama_pembeli` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_penjualan_obat_alkes_bhp`
--

INSERT INTO `tbl_penjualan_obat_alkes_bhp` (`no_faktur`, `tanggal`, `nama_pembeli`) VALUES
('1234', '2017-12-24', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pj_riwayat_tindakan`
--

CREATE TABLE `tbl_pj_riwayat_tindakan` (
  `id_pj_riwayat_tindakan` int NOT NULL,
  `nama_pj_riwayat_tindakan` varchar(100) NOT NULL,
  `deskripsi_pj_riwayat_tindakan` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pj_riwayat_tindakan`
--

INSERT INTO `tbl_pj_riwayat_tindakan` (`id_pj_riwayat_tindakan`, `nama_pj_riwayat_tindakan`, `deskripsi_pj_riwayat_tindakan`) VALUES
(1, 'Dokter', NULL),
(2, 'Petugas', NULL),
(3, 'Dokter dan petugas', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_poliklinik`
--

CREATE TABLE `tbl_poliklinik` (
  `id_poliklinik` int NOT NULL,
  `nama_poliklinik` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_poliklinik`
--

INSERT INTO `tbl_poliklinik` (`id_poliklinik`, `nama_poliklinik`) VALUES
(1, 'POLIKLINIK ANAK'),
(2, 'POLIKLINIK ANAK PINERE'),
(3, 'POLIKLINIK BEDAH ORTHOPEDI (RAUDHAH)'),
(4, 'POLIKLINIK BEDAH ANAK'),
(5, 'POLIKLINIK BEDAH MULUT'),
(6, 'POLIKLINIK BEDAH ORTHOPEDY'),
(7, 'POLIKLINIK BEDAH SYARAF'),
(8, 'POLIKLINIK BEDAH UMUM'),
(9, 'POLIKLINIK BEDAH UMUM (RAUDHAH)'),
(10, 'POLIKLINIK BEDAH UROLOGI'),
(11, 'POLIKLINIK ENDODONTI'),
(12, 'POLIKLINIK GIGI'),
(13, 'POLIKLINIK GIZI'),
(14, 'POLIKLINIK JANTUNG'),
(15, 'POLIKLINIK KANDUNGAN'),
(16, 'POLIKLINIK KANDUNGAN (RAUDHAH)'),
(17, 'POLIKLINIK KHITAN'),
(18, 'POLIKLINIK KULIT DAN KELAMIN'),
(19, 'POLIKLINIK MATA'),
(20, 'POLIKLINIK ORTODONTI'),
(21, 'POLIKLINIK PARU'),
(22, 'POLIKLINIK PENYAKIT DALAM'),
(23, 'POLIKLINIK PENYAKIT DALAM PINERE'),
(24, 'POLIKLINIK PENYAKIT DALAM (RAUDHAH)'),
(25, 'POLIKLINIK PROSTODONTI'),
(26, 'POLIKLINIK PSIKIATRI'),
(27, 'POLIKLINIK PSIKOLOGI'),
(28, 'POLIKLINIK SYARAF'),
(29, 'POLIKLINIK SYARAF (RAUDHAH)'),
(30, 'POLIKLINIK THT'),
(31, 'KONSULTASI VCT'),
(32, 'POLIKLINIK BKIA'),
(33, 'POLIKLINIK PERJANJIAN (RAUDHAH)'),
(34, 'KLINIK BEDAH PLASTIK (RAUDHAH)'),
(35, 'KLINIK BEDAH UROLOGI (RAUDHAH)'),
(36, 'POLIKLINIK BEDAH DIGESTIV'),
(37, 'POLIKLINIK BEDAH PLASTIK'),
(38, 'POLIKLINIK PERIODONTI'),
(39, 'POLIKLINIK PEDODONTI'),
(40, 'KLINIK BEDAH THORAX (RAUDHAH)'),
(41, 'POLIKLINIK BEDAH THORAX'),
(42, 'POLIKLINIK JANTUNG (RAUDHAH)');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_profil_rumah_sakit`
--

CREATE TABLE `tbl_profil_rumah_sakit` (
  `id` int NOT NULL,
  `nama_rumah_sakit` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  `propinsi` varchar(30) NOT NULL,
  `kabupaten` varchar(30) NOT NULL,
  `no_telpon` varchar(13) NOT NULL,
  `logo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_profil_rumah_sakit`
--

INSERT INTO `tbl_profil_rumah_sakit` (`id`, `nama_rumah_sakit`, `alamat`, `propinsi`, `kabupaten`, `no_telpon`, `logo`) VALUES
(1, 'Sistem Informasi Rumah Sakit', 'Jl A.H Nasution No.107', 'Jawa Barat', 'Bandung', '021-32432323', 'logo-rs3.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_rawat_inap`
--

CREATE TABLE `tbl_rawat_inap` (
  `no_rawat` varchar(18) NOT NULL,
  `tanggal_masuk` datetime NOT NULL,
  `tanggal_keluar` datetime DEFAULT NULL,
  `kode_tempat_tidur` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_rawat_inap`
--

INSERT INTO `tbl_rawat_inap` (`no_rawat`, `tanggal_masuk`, `tanggal_keluar`, `kode_tempat_tidur`) VALUES
('2020/09/23/0002', '2020-09-27 00:00:00', '2020-11-26 00:00:00', 'KSRMRLS0016'),
('2020/09/23/0003', '2020-09-27 00:00:00', '2020-12-26 00:00:00', 'KSRKN0015'),
('2020/09/26/0003', '2020-09-26 00:00:00', '2020-09-26 00:00:00', 'KSRZL0015');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_riwayat_pemberian_obat`
--

CREATE TABLE `tbl_riwayat_pemberian_obat` (
  `id_riwayat` int NOT NULL,
  `no_rawat` varchar(18) NOT NULL,
  `id_status_acc` int NOT NULL DEFAULT '1',
  `tanggal` date NOT NULL,
  `kode_barang` varchar(6) NOT NULL,
  `jumlah` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_riwayat_pemberian_obat`
--

INSERT INTO `tbl_riwayat_pemberian_obat` (`id_riwayat`, `no_rawat`, `id_status_acc`, `tanggal`, `kode_barang`, `jumlah`) VALUES
(7, '2020/09/23/0004', 2, '2020-09-23', '00198', 3),
(8, '2020/09/26/0001', 1, '2020-09-26', '00940', 3),
(9, '2020/09/26/0001', 1, '2020-09-26', '00948', 2),
(10, '2020/09/26/0001', 2, '2020-09-26', '00928', 1),
(11, '2020/09/26/0003', 1, '2020-09-26', '00949', 2),
(12, '2020/09/26/0003', 1, '2020-09-26', '00512', 4),
(13, '2020/09/26/0003', 1, '2020-09-27', '00924', 4),
(14, '2020/09/26/0003', 1, '2020-09-27', '00173', 4),
(15, '2020/09/26/0003', 1, '2020-09-27', '00927', 4),
(16, '2020/09/26/0003', 1, '2020-09-27', '00902', 5),
(17, '2020/09/26/0003', 1, '2020-09-27', '00928', 5),
(18, '2020/09/26/0003', 1, '2020-09-27', '00871', 5),
(19, '2020/09/23/0002', 1, '2020-09-27', '00887', 10),
(20, '2020/09/23/0003', 1, '2020-09-27', '00946', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_riwayat_pemeriksaan_laboratorium`
--

CREATE TABLE `tbl_riwayat_pemeriksaan_laboratorium` (
  `id_riwayat` int NOT NULL,
  `no_rawat` varchar(20) NOT NULL,
  `tanggal` date NOT NULL,
  `kode_periksa` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_riwayat_pemeriksaan_laboratorium`
--

INSERT INTO `tbl_riwayat_pemeriksaan_laboratorium` (`id_riwayat`, `no_rawat`, `tanggal`, `kode_periksa`) VALUES
(7, '2017/12/17/0001', '2017-12-21', 'DR'),
(8, '2017/12/17/0001', '2017-12-21', 'sb'),
(9, '2019/11/28/0001', '2019-11-28', 'DR'),
(10, '2020/09/26/0001', '2020-09-26', 'DR'),
(11, '2020/09/23/0003', '2020-09-27', 'DR');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_riwayat_pemeriksaan_laboratorium_detail`
--

CREATE TABLE `tbl_riwayat_pemeriksaan_laboratorium_detail` (
  `id_rawat_detail` int NOT NULL,
  `id_rawat` int NOT NULL,
  `kode_sub_periksa` varchar(6) NOT NULL,
  `hasil` int NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_riwayat_pemeriksaan_laboratorium_detail`
--

INSERT INTO `tbl_riwayat_pemeriksaan_laboratorium_detail` (`id_rawat_detail`, `id_rawat`, `kode_sub_periksa`, `hasil`, `keterangan`) VALUES
(3, 7, 'gd', 10, 'ok'),
(4, 7, 'hg', 20, 'ok'),
(5, 8, 'sb', 40, 'normal'),
(6, 9, 'gd', 10, ''),
(7, 9, 'hg', 10, ''),
(8, 10, 'gd', 1, 'baik'),
(9, 10, 'hg', 2, 'baik'),
(10, 11, 'gd', 50, 'baik'),
(11, 11, 'hg', 90, 'baik');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_riwayat_tindakan`
--

CREATE TABLE `tbl_riwayat_tindakan` (
  `id_riwayat_tindakan` int NOT NULL,
  `id_pegawai` int DEFAULT NULL,
  `id_dokter` varchar(20) DEFAULT NULL,
  `kode_tindakan` varchar(6) NOT NULL,
  `no_rawat` varchar(18) NOT NULL,
  `hasil_periksa` varchar(100) NOT NULL,
  `perkembangan` varchar(100) NOT NULL,
  `tanggal` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_riwayat_tindakan`
--

INSERT INTO `tbl_riwayat_tindakan` (`id_riwayat_tindakan`, `id_pegawai`, `id_dokter`, `kode_tindakan`, `no_rawat`, `hasil_periksa`, `perkembangan`, `tanggal`) VALUES
(12, 99, '61', '9', '2020/09/23/0004', 'BAIK', 'aa', '2020-09-23 00:00:00'),
(13, 98, '61', '9', '2020/09/23/0004', 'BAIK', 'aa', '2020-09-23 00:00:00'),
(14, 99, '61', '6', '2020/09/23/0004', 'BAIK', 'aa', '2020-09-23 00:00:00'),
(15, 19281927, '10', '8', '2020/09/26/0001', 'BAIK', 'BAIK', '2020-09-26 00:00:00'),
(17, 19281929, '59', '6', '2020/09/23/0002', 'BAIK', 'BAIK', '2020-09-27 00:00:00'),
(18, NULL, '1', '9', '2020/09/23/0003', 'BAIK', 'BAIK', '2020-09-27 00:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_ruang_rawat_inap`
--

CREATE TABLE `tbl_ruang_rawat_inap` (
  `kode_ruang_rawat_inap` varchar(30) NOT NULL,
  `kode_gedung_rawat_inap` varchar(30) NOT NULL,
  `kode_kelas` int NOT NULL,
  `nama_ruangan` varchar(35) NOT NULL,
  `tarif` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_ruang_rawat_inap`
--

INSERT INTO `tbl_ruang_rawat_inap` (`kode_ruang_rawat_inap`, `kode_gedung_rawat_inap`, `kode_kelas`, `nama_ruangan`, `tarif`) VALUES
('CNDMLT', 'GDCND', 3, 'RUANGAN MELATI', 50000),
('DNM00001', 'GD00003', 4, 'ADENIUM', 45000),
('FRS00002', 'GD00002', 3, 'FRESIA', 45000),
('HMDLS00003', 'GD00002', 3, 'HEMODIALISA', 45000),
('KMNNG00001', 'GD00001', 3, 'KEMUNING', 45000),
('KN00001', 'GD00002', 3, 'KANA', 45000),
('KNNG00003', 'GD00001', 3, 'KENANGA', 45000),
('LB00002', 'GD00001', 3, 'ULB', 45000),
('LMND00004', 'GD00002', 3, 'ALAMANDA', 45000),
('MRLS00003', 'GD00003', 3, 'AMARILIS', 45000),
('NGSN00004', 'GD00003', 3, 'ANGSANA', 45000),
('ZL00002', 'GD00003', 2, 'AZALEA', 45000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_satuan_barang`
--

CREATE TABLE `tbl_satuan_barang` (
  `id_satuan` int NOT NULL,
  `nama_satuan` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_satuan_barang`
--

INSERT INTO `tbl_satuan_barang` (`id_satuan`, `nama_satuan`) VALUES
(1, 'botol'),
(2, 'ampul'),
(3, 'PCS'),
(5, 'TUBE'),
(6, 'STRIP'),
(7, 'TABLET'),
(8, 'PACK'),
(9, 'BOX'),
(10, 'KAPS'),
(11, 'CAP'),
(12, 'SCT'),
(13, 'SUPPO'),
(14, 'POT'),
(15, 'VIAL');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_spesialis`
--

CREATE TABLE `tbl_spesialis` (
  `id_spesialis` int NOT NULL,
  `spesialis` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_spesialis`
--

INSERT INTO `tbl_spesialis` (`id_spesialis`, `spesialis`) VALUES
(1, 'UROLOGI'),
(2, 'RADIOLOGI'),
(3, 'BEDAH ANAK'),
(4, 'BEDAH SYARAF'),
(5, 'PENYAKIT DALAM'),
(6, 'BEDAH UMUM'),
(7, 'KULIT DAN KELAMIN'),
(8, 'REHAB MEDIK DAN FISIK'),
(9, 'ORTHOPEDI DAN TRAUMATOLOGI'),
(10, 'JANTUNG DAN PEMBULUH DARAH'),
(11, 'ANAK'),
(12, 'OBGIEN'),
(13, 'MATA'),
(14, 'ANDROLOGI'),
(15, 'THT'),
(16, 'SYARAF'),
(17, 'BEDAH PLASTIK'),
(18, 'GIGI'),
(19, 'GIZI'),
(20, 'ENDODONTI'),
(21, 'KANDUNGAN'),
(22, 'PSIKIATRI'),
(23, 'PSIKOLOGI'),
(24, 'PARU'),
(25, 'KHITAN'),
(26, 'ORTODONTI'),
(27, 'PEDODONTI'),
(28, 'PERIODONTI'),
(29, 'PROSTODONTI');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_status_acc`
--

CREATE TABLE `tbl_status_acc` (
  `id_status_acc` int NOT NULL,
  `nama_status_acc` varchar(100) NOT NULL,
  `deskripsi_status_acc` text CHARACTER SET latin1 COLLATE latin1_swedish_ci
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_status_acc`
--

INSERT INTO `tbl_status_acc` (`id_status_acc`, `nama_status_acc`, `deskripsi_status_acc`) VALUES
(1, 'pending', 'Menunggu persetujuan'),
(2, 'accepted', 'Permintaan telah disetujui'),
(3, 'denied', 'Permintaan telah ditolak');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_status_menikah`
--

CREATE TABLE `tbl_status_menikah` (
  `id_status_menikah` int NOT NULL,
  `nama_status_menikah` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_status_menikah`
--

INSERT INTO `tbl_status_menikah` (`id_status_menikah`, `nama_status_menikah`) VALUES
(1, 'kawin'),
(2, 'belum kawin'),
(3, 'duda'),
(4, 'janda');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_sub_pemeriksaan_laboratoirum`
--

CREATE TABLE `tbl_sub_pemeriksaan_laboratoirum` (
  `kode_sub_periksa` varchar(6) NOT NULL,
  `kode_periksa` varchar(6) NOT NULL,
  `nama_pemeriksaan` varchar(50) NOT NULL,
  `satuan` varchar(10) NOT NULL,
  `nilai_rujukan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_sub_pemeriksaan_laboratoirum`
--

INSERT INTO `tbl_sub_pemeriksaan_laboratoirum` (`kode_sub_periksa`, `kode_periksa`, `nama_pemeriksaan`, `satuan`, `nilai_rujukan`) VALUES
('', 'DR2', 'TESTING', 'mg', 10),
('gd', 'DR', 'gula darah', 'mkl', 0),
('hg', 'DR', 'Hemoglobin', 'gdr', 0),
('sb', 'sb', 'tinggi suhu badan', 'celcius', 10),
('TTS', 'DR2', 'TEST KEDUA', 'MG', 10);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_supplier`
--

CREATE TABLE `tbl_supplier` (
  `kode_supplier` varchar(6) NOT NULL,
  `nama_supplier` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamat` text NOT NULL,
  `no_telpon` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_supplier`
--

INSERT INTO `tbl_supplier` (`kode_supplier`, `nama_supplier`, `alamat`, `no_telpon`) VALUES
('1', 'Afiat Pharmaceutical Industries, PT', 'Jl. Leuwigajah No. 110\nCimindi\nCimahi, JB 40522', 'T. 022-6613330\nF. 022-6613343'),
('10', 'Ipha Laboratories, PT', 'Jl. Raya Batujajar\nDesa Laksanamekar\nPadalarang\nBandung, JB 40553', 'T. 022-6866056\nF. 022-6866057'),
('11', 'Ipha Laboratories, PT', 'Jl. Gempol Wetan No. 215\nBandung, JB 40115', 'T. 022-4237930\nF. 022-4236621'),
('12', 'Kimia Farma, PT', 'Jl. Cicendo No. 43\nBandung, JB 40173 ', 'T. 022-4204043\nF. 022-4237079'),
('13', 'Kimia Farma, PT \nDivisi Riset & Pengembangan', 'Jl. Cihampelas No. 5\nBandung, JB 40171', 'T. 022- 441830 , 4206023\nF. 022-4206018'),
('14', 'Lafi – Ditkesad', 'Jl. Gudang Utara No. 25 – 26\nBandung, JB 40113', 'T. 022-433219\nF. 022-4205408'),
('15', 'Lembaga Farmasi Angkatan Udara “Roostiyan Effendie” ', 'Jl. Abdurachman Saleh\n Lanud Husein Sastranegara\nBandung, JB', ' '),
('16', 'Lucas Jaya, PT', 'Jl. Belitung No. 7\nBandung, JB', ' '),
('17', 'Marin Liza Farma, PT', 'Terusan Kiaracondong No. 43\nBandung, JB 40115', ' '),
('18', 'Medion,  PT', 'Jl. Babakan Ciparay No. 282\nBandung, JB 40223', 'T. 022-6030612\nF. 022-6015625'),
('19', 'Meditrika Agung Indonesia, PT', 'Jl. Cihideung Balong No. 32\nTasikmalaya, JB', 'T./ F. 0265-331189'),
('2', 'Biofarma, PT', ' Jl. Pasteur 28\nBandung, JB 40016\nPO Box 1136', 'T. 022-2033755\nF. 022-2041306'),
('20', 'Meprofarm, PT', 'Jl. Sukarno Hatta 789\nBandung, JB 40294', 'T. 022-7805588\nF. 022-7805577'),
('21', 'Otto Pharmaceutical Industries Ltd, PT', 'Jl. Dr. Setiabudhi Km 12.1\nBandung, JB 40391 ', 'T. 022-2786068, 2786137\nF. 022-2786818'),
('22', 'Palvindra, PT', 'Jl. Wangsareja No. 3\nBandung, JB 40261 ', 'T. 022-345095'),
('23', 'Rohto Laboratories Indonesia, PT', 'Jl. Raya Cimareme 203\nPadalarang, JB 40552', 'T. 022-6809742, 6807046\nF. 022-6808050'),
('24', 'Sanbe Farma, PT', 'Jl. Industri I No. 9\n Desa Utama, Leuwigajah\nCimindi\nCimahi, JB 40552', 'T. 022-630036\nF. 022-630050'),
('25', 'Sandoz Indonesia, PT', 'Jl. Raya Caringin 363\nPadalarang, JB 40553\nPOB Box 7074/BDKB Bandung 40262', 'T. 022-6866228\nF. 022-6866227'),
('26', 'Seger Surya, PT', 'Jl. Soekarno Hatta No. 76\nBandung, JB', 'T. 022-220976'),
('27', 'Sidola Pharmaceutical, PT', 'Jl. Purnawarman No. 52 RT 02/01\nTamansari\nBandung, JB 40116', 'T. 022-4205861\nF. 022-4232747'),
('28', 'Solas Langgeng Sejahtera, PT', 'Jl. Industri Cimareme I/18\nPadalarang, JB 40553', 'T. / F. 022-6865831'),
('29', 'Sumber Tanushu Farma, PT', 'Jl. Cihanjuang No. 28\nCimahi, JB 40153', 'T. 022-6634468\nF. 022-6652904'),
('3', 'Cendo Pratama, PT', 'Jl. Moch. Toha Km 6.7\nCisirung, Palasari\nBandung, JB 40255 ', 'T. 022-503999, 505888\nF. 022-503997'),
('30', 'Tanabe Indonesia, PT', 'Jl. Rumahsakit 104\nUjungberung\nBandung, JB 40612\nPO Box 24', 'T. 022-7800001\nF. 022-7800081'),
('31', 'Trifa Raya Laboratories, PT', ' jl. Sukarno Hatta 219\nBojongloa\nBandung, JB 40223', ' '),
('32', 'Triman Pharmaceutical Industries, PT', ' jl. Peundeuy Km 1\nRancaekek\nBandung, JB\nd/a\nJl. Banten No. 6\nBandung', 'T. 022-7949361\nF. 022-7949361 '),
('4', 'Chandra Nusantara, PT', 'Jl. Terusan Kiaracondong No. 440\nBandung, JB', ' '),
('5', 'Combiphar,  PT', 'Jl. Raya Simpang 383\nPadalarang, JB 40553', 'T. 022-6809129\nF. 022-6809128'),
('6', 'Delta Mulia Chemical Industries, PT', 'Jl. Leuwigajah No. 89A\nKel. Cigugur\nSimahi, JB 40522 ', 'T. 022-6031870\nF. 022-6038562 , bubar'),
('7', 'Errita Pharmaceutical Industries, PT', 'Desa Bojongsalam RT 04 RW 07\nKec. Rancaekek\nKab. Bandung 40395\nPO Boxs No. 4/RCK/UJB ', 'T. 022-7949062\nF. 022-7949063'),
('8', 'Gracia Pharmindo,  PT', 'Kawasan Industri Dwipapuri Blok M-30\nJl. Raya Rancaekek Km 24.5\nBandung, JB 45364', 'T. 022-7780033\nF. 022-7791045'),
('9', 'Holi Pharmaceutical Industries, PT', 'Jl. Leuwigajah No. 100\nCimindi, JB 40522', ' ');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_tempat_tidur`
--

CREATE TABLE `tbl_tempat_tidur` (
  `kode_tempat_tidur` varchar(254) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_ruang_rawat_inap` varchar(20) NOT NULL,
  `status` enum('kosong','diisi') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_tempat_tidur`
--

INSERT INTO `tbl_tempat_tidur` (`kode_tempat_tidur`, `kode_ruang_rawat_inap`, `status`) VALUES
('A001', 'CNDMLT', 'kosong'),
('A002', 'CNDMLT', 'kosong'),
('KSRDNM0001', 'DNM00001', 'kosong'),
('KSRDNM0002', 'DNM00001', 'kosong'),
('KSRDNM0003', 'DNM00001', 'kosong'),
('KSRDNM0004', 'DNM00001', 'kosong'),
('KSRDNM0005', 'DNM00001', 'kosong'),
('KSRDNM0006', 'DNM00001', 'kosong'),
('KSRDNM0007', 'DNM00001', 'kosong'),
('KSRDNM0008', 'DNM00001', 'kosong'),
('KSRDNM0009', 'DNM00001', 'kosong'),
('KSRDNM0010', 'DNM00001', 'kosong'),
('KSRDNM0011', 'DNM00001', 'kosong'),
('KSRDNM0012', 'DNM00001', 'kosong'),
('KSRDNM0013', 'DNM00001', 'kosong'),
('KSRDNM0014', 'DNM00001', 'kosong'),
('KSRDNM0015', 'DNM00001', 'kosong'),
('KSRDNM0016', 'DNM00001', 'kosong'),
('KSRDNM0017', 'DNM00001', 'kosong'),
('KSRDNM0018', 'DNM00001', 'kosong'),
('KSRDNM0019', 'DNM00001', 'kosong'),
('KSRDNM0020', 'DNM00001', 'kosong'),
('KSRDNM0021', 'DNM00001', 'kosong'),
('KSRDNM0022', 'DNM00001', 'kosong'),
('KSRDNM0023', 'DNM00001', 'kosong'),
('KSRDNM0024', 'DNM00001', 'kosong'),
('KSRDNM0025', 'DNM00001', 'kosong'),
('KSRDNM0026', 'DNM00001', 'kosong'),
('KSRDNM0027', 'DNM00001', 'kosong'),
('KSRDNM0028', 'DNM00001', 'kosong'),
('KSRDNM0029', 'DNM00001', 'kosong'),
('KSRDNM0030', 'DNM00001', 'kosong'),
('KSRDNM0031', 'DNM00001', 'kosong'),
('KSRDNM0032', 'DNM00001', 'kosong'),
('KSRDNM0033', 'DNM00001', 'kosong'),
('KSRDNM0034', 'DNM00001', 'kosong'),
('KSRDNM0035', 'DNM00001', 'kosong'),
('KSRDNM0036', 'DNM00001', 'kosong'),
('KSRDNM0037', 'DNM00001', 'kosong'),
('KSRDNM0038', 'DNM00001', 'kosong'),
('KSRDNM0039', 'DNM00001', 'kosong'),
('KSRDNM0040', 'DNM00001', 'kosong'),
('KSRFRS0001', 'FRS00002', 'kosong'),
('KSRFRS0002', 'FRS00002', 'kosong'),
('KSRFRS0003', 'FRS00002', 'kosong'),
('KSRFRS0004', 'FRS00002', 'kosong'),
('KSRFRS0005', 'FRS00002', 'kosong'),
('KSRFRS0006', 'FRS00002', 'kosong'),
('KSRFRS0007', 'FRS00002', 'kosong'),
('KSRFRS0008', 'FRS00002', 'kosong'),
('KSRFRS0009', 'FRS00002', 'kosong'),
('KSRFRS0010', 'FRS00002', 'kosong'),
('KSRFRS0011', 'FRS00002', 'kosong'),
('KSRFRS0012', 'FRS00002', 'kosong'),
('KSRFRS0013', 'FRS00002', 'kosong'),
('KSRFRS0014', 'FRS00002', 'kosong'),
('KSRFRS0015', 'FRS00002', 'kosong'),
('KSRFRS0016', 'FRS00002', 'kosong'),
('KSRFRS0017', 'FRS00002', 'kosong'),
('KSRFRS0018', 'FRS00002', 'kosong'),
('KSRFRS0019', 'FRS00002', 'kosong'),
('KSRFRS0020', 'FRS00002', 'kosong'),
('KSRFRS0021', 'FRS00002', 'kosong'),
('KSRFRS0022', 'FRS00002', 'kosong'),
('KSRFRS0023', 'FRS00002', 'kosong'),
('KSRFRS0024', 'FRS00002', 'kosong'),
('KSRFRS0025', 'FRS00002', 'kosong'),
('KSRFRS0026', 'FRS00002', 'kosong'),
('KSRFRS0027', 'FRS00002', 'kosong'),
('KSRFRS0028', 'FRS00002', 'kosong'),
('KSRFRS0029', 'FRS00002', 'kosong'),
('KSRFRS0030', 'FRS00002', 'kosong'),
('KSRFRS0031', 'FRS00002', 'kosong'),
('KSRFRS0032', 'FRS00002', 'kosong'),
('KSRFRS0033', 'FRS00002', 'kosong'),
('KSRFRS0034', 'FRS00002', 'kosong'),
('KSRFRS0035', 'FRS00002', 'kosong'),
('KSRFRS0036', 'FRS00002', 'kosong'),
('KSRFRS0037', 'FRS00002', 'kosong'),
('KSRFRS0038', 'FRS00002', 'kosong'),
('KSRFRS0039', 'FRS00002', 'kosong'),
('KSRFRS0040', 'FRS00002', 'kosong'),
('KSRHMDLS0001', 'HMDLS00003', 'kosong'),
('KSRHMDLS0002', 'HMDLS00003', 'kosong'),
('KSRHMDLS0003', 'HMDLS00003', 'kosong'),
('KSRHMDLS0004', 'HMDLS00003', 'kosong'),
('KSRHMDLS0005', 'HMDLS00003', 'kosong'),
('KSRHMDLS0006', 'HMDLS00003', 'kosong'),
('KSRHMDLS0007', 'HMDLS00003', 'kosong'),
('KSRHMDLS0008', 'HMDLS00003', 'kosong'),
('KSRHMDLS0009', 'HMDLS00003', 'kosong'),
('KSRHMDLS0010', 'HMDLS00003', 'kosong'),
('KSRHMDLS0011', 'HMDLS00003', 'kosong'),
('KSRHMDLS0012', 'HMDLS00003', 'kosong'),
('KSRHMDLS0013', 'HMDLS00003', 'kosong'),
('KSRHMDLS0014', 'HMDLS00003', 'kosong'),
('KSRHMDLS0015', 'HMDLS00003', 'kosong'),
('KSRHMDLS0016', 'HMDLS00003', 'kosong'),
('KSRHMDLS0017', 'HMDLS00003', 'kosong'),
('KSRHMDLS0018', 'HMDLS00003', 'kosong'),
('KSRHMDLS0019', 'HMDLS00003', 'kosong'),
('KSRHMDLS0020', 'HMDLS00003', 'kosong'),
('KSRHMDLS0021', 'HMDLS00003', 'kosong'),
('KSRHMDLS0022', 'HMDLS00003', 'kosong'),
('KSRHMDLS0023', 'HMDLS00003', 'kosong'),
('KSRHMDLS0024', 'HMDLS00003', 'kosong'),
('KSRHMDLS0025', 'HMDLS00003', 'kosong'),
('KSRHMDLS0026', 'HMDLS00003', 'kosong'),
('KSRHMDLS0027', 'HMDLS00003', 'kosong'),
('KSRHMDLS0028', 'HMDLS00003', 'kosong'),
('KSRHMDLS0029', 'HMDLS00003', 'kosong'),
('KSRHMDLS0030', 'HMDLS00003', 'kosong'),
('KSRHMDLS0031', 'HMDLS00003', 'kosong'),
('KSRHMDLS0032', 'HMDLS00003', 'kosong'),
('KSRHMDLS0033', 'HMDLS00003', 'kosong'),
('KSRHMDLS0034', 'HMDLS00003', 'kosong'),
('KSRHMDLS0035', 'HMDLS00003', 'kosong'),
('KSRHMDLS0036', 'HMDLS00003', 'kosong'),
('KSRHMDLS0037', 'HMDLS00003', 'kosong'),
('KSRHMDLS0038', 'HMDLS00003', 'kosong'),
('KSRHMDLS0039', 'HMDLS00003', 'kosong'),
('KSRHMDLS0040', 'HMDLS00003', 'kosong'),
('KSRKMNNG0001', 'KMNNG00001', 'kosong'),
('KSRKMNNG0002', 'KMNNG00001', 'kosong'),
('KSRKMNNG0003', 'KMNNG00001', 'kosong'),
('KSRKMNNG0004', 'KMNNG00001', 'kosong'),
('KSRKMNNG0005', 'KMNNG00001', 'kosong'),
('KSRKMNNG0006', 'KMNNG00001', 'kosong'),
('KSRKMNNG0007', 'KMNNG00001', 'kosong'),
('KSRKMNNG0008', 'KMNNG00001', 'kosong'),
('KSRKMNNG0009', 'KMNNG00001', 'kosong'),
('KSRKMNNG0010', 'KMNNG00001', 'kosong'),
('KSRKMNNG0011', 'KMNNG00001', 'kosong'),
('KSRKMNNG0012', 'KMNNG00001', 'kosong'),
('KSRKMNNG0013', 'KMNNG00001', 'kosong'),
('KSRKMNNG0014', 'KMNNG00001', 'kosong'),
('KSRKMNNG0015', 'KMNNG00001', 'kosong'),
('KSRKMNNG0016', 'KMNNG00001', 'kosong'),
('KSRKMNNG0017', 'KMNNG00001', 'kosong'),
('KSRKMNNG0018', 'KMNNG00001', 'kosong'),
('KSRKMNNG0019', 'KMNNG00001', 'kosong'),
('KSRKMNNG0020', 'KMNNG00001', 'kosong'),
('KSRKMNNG0021', 'KMNNG00001', 'kosong'),
('KSRKMNNG0022', 'KMNNG00001', 'kosong'),
('KSRKMNNG0023', 'KMNNG00001', 'kosong'),
('KSRKMNNG0024', 'KMNNG00001', 'kosong'),
('KSRKMNNG0025', 'KMNNG00001', 'kosong'),
('KSRKMNNG0026', 'KMNNG00001', 'kosong'),
('KSRKMNNG0027', 'KMNNG00001', 'kosong'),
('KSRKMNNG0028', 'KMNNG00001', 'kosong'),
('KSRKMNNG0029', 'KMNNG00001', 'kosong'),
('KSRKMNNG0030', 'KMNNG00001', 'kosong'),
('KSRKMNNG0031', 'KMNNG00001', 'kosong'),
('KSRKMNNG0032', 'KMNNG00001', 'kosong'),
('KSRKMNNG0033', 'KMNNG00001', 'kosong'),
('KSRKMNNG0034', 'KMNNG00001', 'kosong'),
('KSRKMNNG0035', 'KMNNG00001', 'kosong'),
('KSRKMNNG0036', 'KMNNG00001', 'kosong'),
('KSRKMNNG0037', 'KMNNG00001', 'kosong'),
('KSRKMNNG0038', 'KMNNG00001', 'kosong'),
('KSRKMNNG0039', 'KMNNG00001', 'kosong'),
('KSRKMNNG0040', 'KMNNG00001', 'kosong'),
('KSRKN0001', 'KN00001', 'kosong'),
('KSRKN0002', 'KN00001', 'kosong'),
('KSRKN0003', 'KN00001', 'kosong'),
('KSRKN0004', 'KN00001', 'kosong'),
('KSRKN0005', 'KN00001', 'kosong'),
('KSRKN0006', 'KN00001', 'kosong'),
('KSRKN0007', 'KN00001', 'kosong'),
('KSRKN0008', 'KN00001', 'kosong'),
('KSRKN0009', 'KN00001', 'kosong'),
('KSRKN0010', 'KN00001', 'kosong'),
('KSRKN0011', 'KN00001', 'kosong'),
('KSRKN0012', 'KN00001', 'kosong'),
('KSRKN0013', 'KN00001', 'kosong'),
('KSRKN0014', 'KN00001', 'kosong'),
('KSRKN0015', 'KN00001', 'kosong'),
('KSRKN0016', 'KN00001', 'kosong'),
('KSRKN0017', 'KN00001', 'kosong'),
('KSRKN0018', 'KN00001', 'kosong'),
('KSRKN0019', 'KN00001', 'kosong'),
('KSRKN0020', 'KN00001', 'kosong'),
('KSRKN0021', 'KN00001', 'kosong'),
('KSRKN0022', 'KN00001', 'kosong'),
('KSRKN0023', 'KN00001', 'kosong'),
('KSRKN0024', 'KN00001', 'kosong'),
('KSRKN0025', 'KN00001', 'kosong'),
('KSRKN0026', 'KN00001', 'kosong'),
('KSRKN0027', 'KN00001', 'kosong'),
('KSRKN0028', 'KN00001', 'kosong'),
('KSRKN0029', 'KN00001', 'kosong'),
('KSRKN0030', 'KN00001', 'kosong'),
('KSRKN0031', 'KN00001', 'kosong'),
('KSRKN0032', 'KN00001', 'kosong'),
('KSRKN0033', 'KN00001', 'kosong'),
('KSRKN0034', 'KN00001', 'kosong'),
('KSRKN0035', 'KN00001', 'kosong'),
('KSRKN0036', 'KN00001', 'kosong'),
('KSRKN0037', 'KN00001', 'kosong'),
('KSRKN0038', 'KN00001', 'kosong'),
('KSRKN0039', 'KN00001', 'kosong'),
('KSRKN0040', 'KN00001', 'kosong'),
('KSRKNNG0001', 'KNNG00003', 'kosong'),
('KSRKNNG0002', 'KNNG00003', 'kosong'),
('KSRKNNG0003', 'KNNG00003', 'kosong'),
('KSRKNNG0004', 'KNNG00003', 'kosong'),
('KSRKNNG0005', 'KNNG00003', 'kosong'),
('KSRKNNG0006', 'KNNG00003', 'kosong'),
('KSRKNNG0007', 'KNNG00003', 'kosong'),
('KSRKNNG0008', 'KNNG00003', 'kosong'),
('KSRKNNG0009', 'KNNG00003', 'kosong'),
('KSRKNNG0010', 'KNNG00003', 'kosong'),
('KSRKNNG0011', 'KNNG00003', 'kosong'),
('KSRKNNG0012', 'KNNG00003', 'kosong'),
('KSRKNNG0013', 'KNNG00003', 'kosong'),
('KSRKNNG0014', 'KNNG00003', 'kosong'),
('KSRKNNG0015', 'KNNG00003', 'kosong'),
('KSRKNNG0016', 'KNNG00003', 'kosong'),
('KSRKNNG0017', 'KNNG00003', 'kosong'),
('KSRKNNG0018', 'KNNG00003', 'kosong'),
('KSRKNNG0019', 'KNNG00003', 'kosong'),
('KSRKNNG0020', 'KNNG00003', 'kosong'),
('KSRKNNG0021', 'KNNG00003', 'kosong'),
('KSRKNNG0022', 'KNNG00003', 'kosong'),
('KSRKNNG0023', 'KNNG00003', 'kosong'),
('KSRKNNG0024', 'KNNG00003', 'kosong'),
('KSRKNNG0025', 'KNNG00003', 'kosong'),
('KSRKNNG0026', 'KNNG00003', 'kosong'),
('KSRKNNG0027', 'KNNG00003', 'kosong'),
('KSRKNNG0028', 'KNNG00003', 'kosong'),
('KSRKNNG0029', 'KNNG00003', 'kosong'),
('KSRKNNG0030', 'KNNG00003', 'kosong'),
('KSRKNNG0031', 'KNNG00003', 'kosong'),
('KSRKNNG0032', 'KNNG00003', 'kosong'),
('KSRKNNG0033', 'KNNG00003', 'kosong'),
('KSRKNNG0034', 'KNNG00003', 'kosong'),
('KSRKNNG0035', 'KNNG00003', 'kosong'),
('KSRKNNG0036', 'KNNG00003', 'kosong'),
('KSRKNNG0037', 'KNNG00003', 'kosong'),
('KSRKNNG0038', 'KNNG00003', 'kosong'),
('KSRKNNG0039', 'KNNG00003', 'kosong'),
('KSRKNNG0040', 'KNNG00003', 'kosong'),
('KSRLB0001', 'LB00002', 'kosong'),
('KSRLB0002', 'LB00002', 'kosong'),
('KSRLB0003', 'LB00002', 'kosong'),
('KSRLB0004', 'LB00002', 'kosong'),
('KSRLB0005', 'LB00002', 'kosong'),
('KSRLB0006', 'LB00002', 'kosong'),
('KSRLB0007', 'LB00002', 'kosong'),
('KSRLB0008', 'LB00002', 'kosong'),
('KSRLB0009', 'LB00002', 'kosong'),
('KSRLB0010', 'LB00002', 'kosong'),
('KSRLB0011', 'LB00002', 'kosong'),
('KSRLB0012', 'LB00002', 'kosong'),
('KSRLB0013', 'LB00002', 'kosong'),
('KSRLB0014', 'LB00002', 'kosong'),
('KSRLB0015', 'LB00002', 'kosong'),
('KSRLB0016', 'LB00002', 'kosong'),
('KSRLB0017', 'LB00002', 'kosong'),
('KSRLB0018', 'LB00002', 'kosong'),
('KSRLB0019', 'LB00002', 'kosong'),
('KSRLB0020', 'LB00002', 'kosong'),
('KSRLB0021', 'LB00002', 'kosong'),
('KSRLB0022', 'LB00002', 'kosong'),
('KSRLB0023', 'LB00002', 'kosong'),
('KSRLB0024', 'LB00002', 'kosong'),
('KSRLB0025', 'LB00002', 'kosong'),
('KSRLB0026', 'LB00002', 'kosong'),
('KSRLB0027', 'LB00002', 'kosong'),
('KSRLB0028', 'LB00002', 'kosong'),
('KSRLB0029', 'LB00002', 'kosong'),
('KSRLB0030', 'LB00002', 'kosong'),
('KSRLB0031', 'LB00002', 'kosong'),
('KSRLB0032', 'LB00002', 'kosong'),
('KSRLB0033', 'LB00002', 'kosong'),
('KSRLB0034', 'LB00002', 'kosong'),
('KSRLB0035', 'LB00002', 'kosong'),
('KSRLB0036', 'LB00002', 'kosong'),
('KSRLB0037', 'LB00002', 'kosong'),
('KSRLB0038', 'LB00002', 'kosong'),
('KSRLB0039', 'LB00002', 'kosong'),
('KSRLB0040', 'LB00002', 'kosong'),
('KSRLMND0001', 'LMND00004', 'kosong'),
('KSRLMND0002', 'LMND00004', 'kosong'),
('KSRLMND0003', 'LMND00004', 'kosong'),
('KSRLMND0004', 'LMND00004', 'kosong'),
('KSRLMND0005', 'LMND00004', 'kosong'),
('KSRLMND0006', 'LMND00004', 'kosong'),
('KSRLMND0007', 'LMND00004', 'kosong'),
('KSRLMND0008', 'LMND00004', 'kosong'),
('KSRLMND0009', 'LMND00004', 'kosong'),
('KSRLMND0010', 'LMND00004', 'kosong'),
('KSRLMND0011', 'LMND00004', 'kosong'),
('KSRLMND0012', 'LMND00004', 'kosong'),
('KSRLMND0013', 'LMND00004', 'kosong'),
('KSRLMND0014', 'LMND00004', 'kosong'),
('KSRLMND0015', 'LMND00004', 'kosong'),
('KSRLMND0016', 'LMND00004', 'kosong'),
('KSRLMND0017', 'LMND00004', 'kosong'),
('KSRLMND0018', 'LMND00004', 'kosong'),
('KSRLMND0019', 'LMND00004', 'kosong'),
('KSRLMND0020', 'LMND00004', 'kosong'),
('KSRLMND0021', 'LMND00004', 'kosong'),
('KSRLMND0022', 'LMND00004', 'kosong'),
('KSRLMND0023', 'LMND00004', 'kosong'),
('KSRLMND0024', 'LMND00004', 'kosong'),
('KSRLMND0025', 'LMND00004', 'kosong'),
('KSRLMND0026', 'LMND00004', 'kosong'),
('KSRLMND0027', 'LMND00004', 'kosong'),
('KSRLMND0028', 'LMND00004', 'kosong'),
('KSRLMND0029', 'LMND00004', 'kosong'),
('KSRLMND0030', 'LMND00004', 'kosong'),
('KSRLMND0031', 'LMND00004', 'kosong'),
('KSRLMND0032', 'LMND00004', 'kosong'),
('KSRLMND0033', 'LMND00004', 'kosong'),
('KSRLMND0034', 'LMND00004', 'kosong'),
('KSRLMND0035', 'LMND00004', 'kosong'),
('KSRLMND0036', 'LMND00004', 'kosong'),
('KSRLMND0037', 'LMND00004', 'kosong'),
('KSRLMND0038', 'LMND00004', 'kosong'),
('KSRLMND0039', 'LMND00004', 'kosong'),
('KSRLMND0040', 'LMND00004', 'kosong'),
('KSRMRLS0001', 'MRLS00003', 'kosong'),
('KSRMRLS0002', 'MRLS00003', 'kosong'),
('KSRMRLS0003', 'MRLS00003', 'kosong'),
('KSRMRLS0004', 'MRLS00003', 'kosong'),
('KSRMRLS0005', 'MRLS00003', 'kosong'),
('KSRMRLS0006', 'MRLS00003', 'kosong'),
('KSRMRLS0007', 'MRLS00003', 'kosong'),
('KSRMRLS0008', 'MRLS00003', 'kosong'),
('KSRMRLS0009', 'MRLS00003', 'kosong'),
('KSRMRLS0010', 'MRLS00003', 'kosong'),
('KSRMRLS0011', 'MRLS00003', 'kosong'),
('KSRMRLS0012', 'MRLS00003', 'kosong'),
('KSRMRLS0013', 'MRLS00003', 'kosong'),
('KSRMRLS0014', 'MRLS00003', 'kosong'),
('KSRMRLS0015', 'MRLS00003', 'kosong'),
('KSRMRLS0016', 'MRLS00003', 'kosong'),
('KSRMRLS0017', 'MRLS00003', 'kosong'),
('KSRMRLS0018', 'MRLS00003', 'kosong'),
('KSRMRLS0019', 'MRLS00003', 'kosong'),
('KSRMRLS0020', 'MRLS00003', 'kosong'),
('KSRMRLS0021', 'MRLS00003', 'kosong'),
('KSRMRLS0022', 'MRLS00003', 'kosong'),
('KSRMRLS0023', 'MRLS00003', 'kosong'),
('KSRMRLS0024', 'MRLS00003', 'kosong'),
('KSRMRLS0025', 'MRLS00003', 'kosong'),
('KSRMRLS0026', 'MRLS00003', 'kosong'),
('KSRMRLS0027', 'MRLS00003', 'kosong'),
('KSRMRLS0028', 'MRLS00003', 'kosong'),
('KSRMRLS0029', 'MRLS00003', 'kosong'),
('KSRMRLS0030', 'MRLS00003', 'kosong'),
('KSRMRLS0031', 'MRLS00003', 'kosong'),
('KSRMRLS0032', 'MRLS00003', 'kosong'),
('KSRMRLS0033', 'MRLS00003', 'kosong'),
('KSRMRLS0034', 'MRLS00003', 'kosong'),
('KSRMRLS0035', 'MRLS00003', 'kosong'),
('KSRMRLS0036', 'MRLS00003', 'kosong'),
('KSRMRLS0037', 'MRLS00003', 'kosong'),
('KSRMRLS0038', 'MRLS00003', 'kosong'),
('KSRMRLS0039', 'MRLS00003', 'kosong'),
('KSRMRLS0040', 'MRLS00003', 'kosong'),
('KSRNGSN0001', 'NGSN00004', 'kosong'),
('KSRNGSN0002', 'NGSN00004', 'kosong'),
('KSRNGSN0003', 'NGSN00004', 'kosong'),
('KSRNGSN0004', 'NGSN00004', 'kosong'),
('KSRNGSN0005', 'NGSN00004', 'kosong'),
('KSRNGSN0006', 'NGSN00004', 'kosong'),
('KSRNGSN0007', 'NGSN00004', 'kosong'),
('KSRNGSN0008', 'NGSN00004', 'kosong'),
('KSRNGSN0009', 'NGSN00004', 'kosong'),
('KSRNGSN0010', 'NGSN00004', 'kosong'),
('KSRNGSN0011', 'NGSN00004', 'kosong'),
('KSRNGSN0012', 'NGSN00004', 'kosong'),
('KSRNGSN0013', 'NGSN00004', 'kosong'),
('KSRNGSN0014', 'NGSN00004', 'kosong'),
('KSRNGSN0015', 'NGSN00004', 'kosong'),
('KSRNGSN0016', 'NGSN00004', 'kosong'),
('KSRNGSN0017', 'NGSN00004', 'kosong'),
('KSRNGSN0018', 'NGSN00004', 'kosong'),
('KSRNGSN0019', 'NGSN00004', 'kosong'),
('KSRNGSN0020', 'NGSN00004', 'kosong'),
('KSRNGSN0021', 'NGSN00004', 'kosong'),
('KSRNGSN0022', 'NGSN00004', 'kosong'),
('KSRNGSN0023', 'NGSN00004', 'kosong'),
('KSRNGSN0024', 'NGSN00004', 'kosong'),
('KSRNGSN0025', 'NGSN00004', 'kosong'),
('KSRNGSN0026', 'NGSN00004', 'kosong'),
('KSRNGSN0027', 'NGSN00004', 'kosong'),
('KSRNGSN0028', 'NGSN00004', 'kosong'),
('KSRNGSN0029', 'NGSN00004', 'kosong'),
('KSRNGSN0030', 'NGSN00004', 'kosong'),
('KSRNGSN0031', 'NGSN00004', 'kosong'),
('KSRNGSN0032', 'NGSN00004', 'kosong'),
('KSRNGSN0033', 'NGSN00004', 'kosong'),
('KSRNGSN0034', 'NGSN00004', 'kosong'),
('KSRNGSN0035', 'NGSN00004', 'kosong'),
('KSRNGSN0036', 'NGSN00004', 'kosong'),
('KSRNGSN0037', 'NGSN00004', 'kosong'),
('KSRNGSN0038', 'NGSN00004', 'kosong'),
('KSRNGSN0039', 'NGSN00004', 'kosong'),
('KSRNGSN0040', 'NGSN00004', 'kosong'),
('KSRZL0001', 'ZL00002', 'kosong'),
('KSRZL0002', 'ZL00002', 'kosong'),
('KSRZL0003', 'ZL00002', 'kosong'),
('KSRZL0004', 'ZL00002', 'kosong'),
('KSRZL0005', 'ZL00002', 'kosong'),
('KSRZL0006', 'ZL00002', 'kosong'),
('KSRZL0007', 'ZL00002', 'kosong'),
('KSRZL0008', 'ZL00002', 'kosong'),
('KSRZL0009', 'ZL00002', 'kosong'),
('KSRZL0010', 'ZL00002', 'kosong'),
('KSRZL0011', 'ZL00002', 'kosong'),
('KSRZL0012', 'ZL00002', 'kosong'),
('KSRZL0013', 'ZL00002', 'kosong'),
('KSRZL0014', 'ZL00002', 'kosong'),
('KSRZL0015', 'ZL00002', 'kosong'),
('KSRZL0016', 'ZL00002', 'kosong'),
('KSRZL0017', 'ZL00002', 'kosong'),
('KSRZL0018', 'ZL00002', 'kosong'),
('KSRZL0019', 'ZL00002', 'kosong'),
('KSRZL0020', 'ZL00002', 'kosong'),
('KSRZL0021', 'ZL00002', 'kosong'),
('KSRZL0022', 'ZL00002', 'kosong'),
('KSRZL0023', 'ZL00002', 'kosong'),
('KSRZL0024', 'ZL00002', 'kosong'),
('KSRZL0025', 'ZL00002', 'kosong'),
('KSRZL0026', 'ZL00002', 'kosong'),
('KSRZL0027', 'ZL00002', 'kosong'),
('KSRZL0028', 'ZL00002', 'kosong'),
('KSRZL0029', 'ZL00002', 'kosong'),
('KSRZL0030', 'ZL00002', 'kosong'),
('KSRZL0031', 'ZL00002', 'kosong'),
('KSRZL0032', 'ZL00002', 'kosong'),
('KSRZL0033', 'ZL00002', 'kosong'),
('KSRZL0034', 'ZL00002', 'kosong'),
('KSRZL0035', 'ZL00002', 'kosong'),
('KSRZL0036', 'ZL00002', 'kosong'),
('KSRZL0037', 'ZL00002', 'kosong'),
('KSRZL0038', 'ZL00002', 'kosong'),
('KSRZL0039', 'ZL00002', 'kosong'),
('KSRZL0040', 'ZL00002', 'kosong');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_tindakan`
--

CREATE TABLE `tbl_tindakan` (
  `kode_tindakan` varchar(6) NOT NULL,
  `jenis_tindakan` enum('rawat_jalan','rawat_inap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_tindakan` varchar(254) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_kategori_tindakan` varchar(6) NOT NULL,
  `tarif` int NOT NULL,
  `tindakan_oleh` enum('dokter','petugas','dokter_dan_petugas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_poliklinik` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_tindakan`
--

INSERT INTO `tbl_tindakan` (`kode_tindakan`, `jenis_tindakan`, `nama_tindakan`, `kode_kategori_tindakan`, `tarif`, `tindakan_oleh`, `id_poliklinik`) VALUES
('1', 'rawat_jalan', 'Phacoemulsification Tanpa IOL', 'BM01', 11500, 'dokter', 19),
('10', 'rawat_inap', 'CLITORAL REDUCTION', 'PL01', 27123456, 'dokter', 37),
('11', 'rawat_inap', 'LIPSUCTION >2 AREA', 'PL01', 81987654, 'dokter', 1),
('2', 'rawat_jalan', 'PHACOEMULSIFICATION PAKET LENSA MONOFOCAL', 'BM01', 13500, 'dokter', 19),
('3', 'rawat_jalan', 'PHACOEMULSIFICATION PAKET LENSA MULTIFOCAL', 'BM01', 30000, 'dokter', 19),
('4', 'rawat_jalan', 'PHACOEMULSIFICATION PAKET LENSA TORIX', 'BM01', 33000, 'dokter', 19),
('5', 'rawat_jalan', 'PHACOEMULSIFICATION PAKET LENSA PANOPTIX', 'BM01', 32000, 'dokter', 19),
('6', 'rawat_jalan', 'pemasangan implant denture', 'GG001', 4600000, 'dokter', 12),
('7', 'rawat_jalan', 'protesa bahan vaplas', 'GG001', 2000000, 'dokter', 12),
('8', 'rawat_inap', 'LIPSUCTION 1 AREA', 'PL01', 57500123, 'dokter', 37),
('9', 'rawat_inap', 'LIPSUCTION 2 AREA', 'PL01', 70123456, 'dokter', 37);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id_users` int NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `images` text NOT NULL,
  `id_user_level` int NOT NULL,
  `is_aktif` enum('y','n') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_user`
--

INSERT INTO `tbl_user` (`id_users`, `full_name`, `email`, `password`, `images`, `id_user_level`, `is_aktif`) VALUES
(1, 'System Administrator', 'admsys@rs.go.id', '21232f297a57a5a743894a0e4a801fc3', 'cc.png', 1, 'y'),
(2, 'Kontributor', 'sys@rs.go.id', 'e807f1fcf82d132f9bb018ca6738a19f', 'cc.png', 2, 'y'),
(3, 'temy', 'temyramdhan6740@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'Call-Centre-PNG-Photo1.png', 1, 'y'),
(5, 'temys', 'm.fajar980527@gmail.com', 'e6899c965aece2c88a83f972e2775181', '', 1, 'y'),
(6, 'BURHAN, DR., SP.A.', '1@dokter.login', 'ecb8501d271598536c0dc3d434bd5b3f', '', 3, 'y'),
(7, 'R. GINANDJAR ASLAMA MAULID, DRG.', '61@dokter.login', '21232f297a57a5a743894a0e4a801fc3', '', 3, 'y'),
(9, 'Haryanto', '19281927@apoteker.login', '5907cee206610515aa4a0624f80dedae', '', 5, 'y'),
(10, 'Waksim', '19281929@keuangan.login', 'a4151d4b2856ec63368a7c784b1f0a6e', '', 4, 'y');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_user_level`
--

CREATE TABLE `tbl_user_level` (
  `id_user_level` int NOT NULL,
  `nama_level` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_user_level`
--

INSERT INTO `tbl_user_level` (`id_user_level`, `nama_level`) VALUES
(1, 'Super Admin'),
(2, 'Admin'),
(3, 'Dokter'),
(4, 'Keuangan'),
(5, 'Apoteker');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbl_agama`
--
ALTER TABLE `tbl_agama`
  ADD PRIMARY KEY (`id_agama`);

--
-- Indeks untuk tabel `tbl_akses_menu`
--
ALTER TABLE `tbl_akses_menu`
  ADD PRIMARY KEY (`id_akses_menu`),
  ADD KEY `ifbk_akses_ulevel_1` (`id_user_level`),
  ADD KEY `ifbk_akses_menu_1` (`id_menu`);

--
-- Indeks untuk tabel `tbl_antrean`
--
ALTER TABLE `tbl_antrean`
  ADD PRIMARY KEY (`id_antrean`),
  ADD KEY `ifbk_tipe_antrean_1` (`id_tipe_antrean`);

--
-- Indeks untuk tabel `tbl_antrean_type`
--
ALTER TABLE `tbl_antrean_type`
  ADD PRIMARY KEY (`id_tipe_antrean`);

--
-- Indeks untuk tabel `tbl_bidang`
--
ALTER TABLE `tbl_bidang`
  ADD PRIMARY KEY (`id_bidang`);

--
-- Indeks untuk tabel `tbl_departemen`
--
ALTER TABLE `tbl_departemen`
  ADD PRIMARY KEY (`id_departemen`);

--
-- Indeks untuk tabel `tbl_diagnosa_penyakit`
--
ALTER TABLE `tbl_diagnosa_penyakit`
  ADD PRIMARY KEY (`kode_diagnosa`);

--
-- Indeks untuk tabel `tbl_dokter`
--
ALTER TABLE `tbl_dokter`
  ADD PRIMARY KEY (`kode_dokter`),
  ADD KEY `id_agama` (`id_agama`),
  ADD KEY `id_spesialis` (`id_spesialis`),
  ADD KEY `ifbk_dokter_gol_darah_1` (`id_gol_darah`),
  ADD KEY `ifbk_dokter_status_nikah_1` (`id_status_menikah`);

--
-- Indeks untuk tabel `tbl_gedung_rawat_inap`
--
ALTER TABLE `tbl_gedung_rawat_inap`
  ADD PRIMARY KEY (`kode_gedung_rawat_inap`);

--
-- Indeks untuk tabel `tbl_gol_darah`
--
ALTER TABLE `tbl_gol_darah`
  ADD PRIMARY KEY (`id_gol_darah`);

--
-- Indeks untuk tabel `tbl_jabatan`
--
ALTER TABLE `tbl_jabatan`
  ADD PRIMARY KEY (`id_jabatan`);

--
-- Indeks untuk tabel `tbl_jadwal_praktek_dokter`
--
ALTER TABLE `tbl_jadwal_praktek_dokter`
  ADD PRIMARY KEY (`id_jadwal`),
  ADD KEY `id_poliklinik` (`id_poliklinik`),
  ADD KEY `kode_dokter` (`kode_dokter`);

--
-- Indeks untuk tabel `tbl_jenis_bayar`
--
ALTER TABLE `tbl_jenis_bayar`
  ADD PRIMARY KEY (`id_jenis_bayar`);

--
-- Indeks untuk tabel `tbl_jenjang`
--
ALTER TABLE `tbl_jenjang`
  ADD PRIMARY KEY (`kode_jenjang`);

--
-- Indeks untuk tabel `tbl_jenjang_pendidikan`
--
ALTER TABLE `tbl_jenjang_pendidikan`
  ADD PRIMARY KEY (`id_jenjang_pendidikan`);

--
-- Indeks untuk tabel `tbl_kategori_barang`
--
ALTER TABLE `tbl_kategori_barang`
  ADD PRIMARY KEY (`id_kategori_barang`);

--
-- Indeks untuk tabel `tbl_kategori_harga_brg`
--
ALTER TABLE `tbl_kategori_harga_brg`
  ADD PRIMARY KEY (`id_kategori_harga_brg`);

--
-- Indeks untuk tabel `tbl_kategori_tindakan`
--
ALTER TABLE `tbl_kategori_tindakan`
  ADD PRIMARY KEY (`kode_kategori_tindakan`);

--
-- Indeks untuk tabel `tbl_kelas_ruang_ranap`
--
ALTER TABLE `tbl_kelas_ruang_ranap`
  ADD PRIMARY KEY (`id_kelas_ruang_ranap`);

--
-- Indeks untuk tabel `tbl_menu`
--
ALTER TABLE `tbl_menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indeks untuk tabel `tbl_mutasi_deposit`
--
ALTER TABLE `tbl_mutasi_deposit`
  ADD PRIMARY KEY (`id_mutasi`),
  ADD KEY `ifbk_mutasi_no_rawat_1` (`no_rawat`),
  ADD KEY `ifbk_pic_1` (`user_in_charge`);

--
-- Indeks untuk tabel `tbl_obat_alkes_bhp`
--
ALTER TABLE `tbl_obat_alkes_bhp`
  ADD PRIMARY KEY (`kode_barang`),
  ADD KEY `ifbk_satuan_barang_1` (`id_satuan_barang`),
  ADD KEY `ifbk_kategori_barang_1` (`id_kategori_barang`),
  ADD KEY `ibfk_kat_harga_brg_1` (`id_kategori_harga_brg`);

--
-- Indeks untuk tabel `tbl_pasien`
--
ALTER TABLE `tbl_pasien`
  ADD PRIMARY KEY (`no_rekamedis`),
  ADD KEY `ifbk_pasien_gol_darah_1` (`id_gol_darah`),
  ADD KEY `ifbk_pasien_agama_1` (`id_agama`),
  ADD KEY `ifbk_pasien_pekerjaan_1` (`id_pekerjaan`);

--
-- Indeks untuk tabel `tbl_pegawai`
--
ALTER TABLE `tbl_pegawai`
  ADD PRIMARY KEY (`nik`),
  ADD KEY `id_bidang` (`id_bidang`),
  ADD KEY `id_departemen` (`id_departemen`),
  ADD KEY `id_jabatan` (`id_jabatan`),
  ADD KEY `id_pendidikan` (`id_jenjang_pendidikan`),
  ADD KEY `kode_jenjang` (`kode_jenjang`);

--
-- Indeks untuk tabel `tbl_pekerjaan`
--
ALTER TABLE `tbl_pekerjaan`
  ADD PRIMARY KEY (`id_pekerjaan`);

--
-- Indeks untuk tabel `tbl_pemeriksaan_laboratorium`
--
ALTER TABLE `tbl_pemeriksaan_laboratorium`
  ADD PRIMARY KEY (`kode_periksa`);

--
-- Indeks untuk tabel `tbl_pendaftaran`
--
ALTER TABLE `tbl_pendaftaran`
  ADD PRIMARY KEY (`no_rawat`);

--
-- Indeks untuk tabel `tbl_pengadaan_detail`
--
ALTER TABLE `tbl_pengadaan_detail`
  ADD PRIMARY KEY (`id_pengadaan`);

--
-- Indeks untuk tabel `tbl_pengadaan_obat_alkes_bhp`
--
ALTER TABLE `tbl_pengadaan_obat_alkes_bhp`
  ADD PRIMARY KEY (`no_faktur`);

--
-- Indeks untuk tabel `tbl_penjualan_detail`
--
ALTER TABLE `tbl_penjualan_detail`
  ADD PRIMARY KEY (`id_penjualan`);

--
-- Indeks untuk tabel `tbl_penjualan_obat_alkes_bhp`
--
ALTER TABLE `tbl_penjualan_obat_alkes_bhp`
  ADD PRIMARY KEY (`no_faktur`);

--
-- Indeks untuk tabel `tbl_pj_riwayat_tindakan`
--
ALTER TABLE `tbl_pj_riwayat_tindakan`
  ADD PRIMARY KEY (`id_pj_riwayat_tindakan`);

--
-- Indeks untuk tabel `tbl_poliklinik`
--
ALTER TABLE `tbl_poliklinik`
  ADD PRIMARY KEY (`id_poliklinik`);

--
-- Indeks untuk tabel `tbl_profil_rumah_sakit`
--
ALTER TABLE `tbl_profil_rumah_sakit`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_rawat_inap`
--
ALTER TABLE `tbl_rawat_inap`
  ADD PRIMARY KEY (`no_rawat`);

--
-- Indeks untuk tabel `tbl_riwayat_pemberian_obat`
--
ALTER TABLE `tbl_riwayat_pemberian_obat`
  ADD PRIMARY KEY (`id_riwayat`),
  ADD KEY `ifbk_riwayat_kd_obat_1` (`kode_barang`),
  ADD KEY `ifbk_pasien_no_rawat_1` (`no_rawat`),
  ADD KEY `ifbk_status_acc_obat_1` (`id_status_acc`);

--
-- Indeks untuk tabel `tbl_riwayat_pemeriksaan_laboratorium`
--
ALTER TABLE `tbl_riwayat_pemeriksaan_laboratorium`
  ADD PRIMARY KEY (`id_riwayat`);

--
-- Indeks untuk tabel `tbl_riwayat_pemeriksaan_laboratorium_detail`
--
ALTER TABLE `tbl_riwayat_pemeriksaan_laboratorium_detail`
  ADD PRIMARY KEY (`id_rawat_detail`);

--
-- Indeks untuk tabel `tbl_riwayat_tindakan`
--
ALTER TABLE `tbl_riwayat_tindakan`
  ADD PRIMARY KEY (`id_riwayat_tindakan`);

--
-- Indeks untuk tabel `tbl_ruang_rawat_inap`
--
ALTER TABLE `tbl_ruang_rawat_inap`
  ADD PRIMARY KEY (`kode_ruang_rawat_inap`),
  ADD KEY `ifbk_gedung_1` (`kode_gedung_rawat_inap`),
  ADD KEY `ifbk_kode_kelas_1` (`kode_kelas`);

--
-- Indeks untuk tabel `tbl_satuan_barang`
--
ALTER TABLE `tbl_satuan_barang`
  ADD PRIMARY KEY (`id_satuan`);

--
-- Indeks untuk tabel `tbl_spesialis`
--
ALTER TABLE `tbl_spesialis`
  ADD PRIMARY KEY (`id_spesialis`);

--
-- Indeks untuk tabel `tbl_status_acc`
--
ALTER TABLE `tbl_status_acc`
  ADD PRIMARY KEY (`id_status_acc`);

--
-- Indeks untuk tabel `tbl_status_menikah`
--
ALTER TABLE `tbl_status_menikah`
  ADD PRIMARY KEY (`id_status_menikah`);

--
-- Indeks untuk tabel `tbl_sub_pemeriksaan_laboratoirum`
--
ALTER TABLE `tbl_sub_pemeriksaan_laboratoirum`
  ADD PRIMARY KEY (`kode_sub_periksa`);

--
-- Indeks untuk tabel `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  ADD PRIMARY KEY (`kode_supplier`);

--
-- Indeks untuk tabel `tbl_tempat_tidur`
--
ALTER TABLE `tbl_tempat_tidur`
  ADD PRIMARY KEY (`kode_tempat_tidur`),
  ADD KEY `ifbk_kode_ruang_2` (`kode_ruang_rawat_inap`);

--
-- Indeks untuk tabel `tbl_tindakan`
--
ALTER TABLE `tbl_tindakan`
  ADD PRIMARY KEY (`kode_tindakan`);

--
-- Indeks untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id_users`);

--
-- Indeks untuk tabel `tbl_user_level`
--
ALTER TABLE `tbl_user_level`
  ADD PRIMARY KEY (`id_user_level`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_agama`
--
ALTER TABLE `tbl_agama`
  MODIFY `id_agama` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_akses_menu`
--
ALTER TABLE `tbl_akses_menu`
  MODIFY `id_akses_menu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `tbl_antrean`
--
ALTER TABLE `tbl_antrean`
  MODIFY `id_antrean` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `tbl_antrean_type`
--
ALTER TABLE `tbl_antrean_type`
  MODIFY `id_tipe_antrean` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_bidang`
--
ALTER TABLE `tbl_bidang`
  MODIFY `id_bidang` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_departemen`
--
ALTER TABLE `tbl_departemen`
  MODIFY `id_departemen` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_gol_darah`
--
ALTER TABLE `tbl_gol_darah`
  MODIFY `id_gol_darah` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_jabatan`
--
ALTER TABLE `tbl_jabatan`
  MODIFY `id_jabatan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tbl_jadwal_praktek_dokter`
--
ALTER TABLE `tbl_jadwal_praktek_dokter`
  MODIFY `id_jadwal` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=290;

--
-- AUTO_INCREMENT untuk tabel `tbl_jenis_bayar`
--
ALTER TABLE `tbl_jenis_bayar`
  MODIFY `id_jenis_bayar` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_jenjang_pendidikan`
--
ALTER TABLE `tbl_jenjang_pendidikan`
  MODIFY `id_jenjang_pendidikan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `tbl_kategori_barang`
--
ALTER TABLE `tbl_kategori_barang`
  MODIFY `id_kategori_barang` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tbl_kategori_harga_brg`
--
ALTER TABLE `tbl_kategori_harga_brg`
  MODIFY `id_kategori_harga_brg` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_kelas_ruang_ranap`
--
ALTER TABLE `tbl_kelas_ruang_ranap`
  MODIFY `id_kelas_ruang_ranap` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tbl_menu`
--
ALTER TABLE `tbl_menu`
  MODIFY `id_menu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT untuk tabel `tbl_mutasi_deposit`
--
ALTER TABLE `tbl_mutasi_deposit`
  MODIFY `id_mutasi` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `tbl_pekerjaan`
--
ALTER TABLE `tbl_pekerjaan`
  MODIFY `id_pekerjaan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_pengadaan_detail`
--
ALTER TABLE `tbl_pengadaan_detail`
  MODIFY `id_pengadaan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `tbl_penjualan_detail`
--
ALTER TABLE `tbl_penjualan_detail`
  MODIFY `id_penjualan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_pj_riwayat_tindakan`
--
ALTER TABLE `tbl_pj_riwayat_tindakan`
  MODIFY `id_pj_riwayat_tindakan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_poliklinik`
--
ALTER TABLE `tbl_poliklinik`
  MODIFY `id_poliklinik` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT untuk tabel `tbl_riwayat_pemberian_obat`
--
ALTER TABLE `tbl_riwayat_pemberian_obat`
  MODIFY `id_riwayat` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `tbl_riwayat_pemeriksaan_laboratorium`
--
ALTER TABLE `tbl_riwayat_pemeriksaan_laboratorium`
  MODIFY `id_riwayat` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `tbl_riwayat_pemeriksaan_laboratorium_detail`
--
ALTER TABLE `tbl_riwayat_pemeriksaan_laboratorium_detail`
  MODIFY `id_rawat_detail` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `tbl_riwayat_tindakan`
--
ALTER TABLE `tbl_riwayat_tindakan`
  MODIFY `id_riwayat_tindakan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `tbl_satuan_barang`
--
ALTER TABLE `tbl_satuan_barang`
  MODIFY `id_satuan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `tbl_spesialis`
--
ALTER TABLE `tbl_spesialis`
  MODIFY `id_spesialis` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT untuk tabel `tbl_status_acc`
--
ALTER TABLE `tbl_status_acc`
  MODIFY `id_status_acc` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_status_menikah`
--
ALTER TABLE `tbl_status_menikah`
  MODIFY `id_status_menikah` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id_users` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tbl_user_level`
--
ALTER TABLE `tbl_user_level`
  MODIFY `id_user_level` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tbl_akses_menu`
--
ALTER TABLE `tbl_akses_menu`
  ADD CONSTRAINT `ifbk_akses_menu_1` FOREIGN KEY (`id_menu`) REFERENCES `tbl_menu` (`id_menu`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_akses_ulevel_1` FOREIGN KEY (`id_user_level`) REFERENCES `tbl_user_level` (`id_user_level`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_antrean`
--
ALTER TABLE `tbl_antrean`
  ADD CONSTRAINT `ifbk_tipe_antrean_1` FOREIGN KEY (`id_tipe_antrean`) REFERENCES `tbl_antrean_type` (`id_tipe_antrean`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_dokter`
--
ALTER TABLE `tbl_dokter`
  ADD CONSTRAINT `ifbk_dokter_agama_1` FOREIGN KEY (`id_agama`) REFERENCES `tbl_agama` (`id_agama`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_dokter_gol_darah_1` FOREIGN KEY (`id_gol_darah`) REFERENCES `tbl_gol_darah` (`id_gol_darah`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_dokter_spesialis_1` FOREIGN KEY (`id_spesialis`) REFERENCES `tbl_spesialis` (`id_spesialis`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_dokter_status_nikah_1` FOREIGN KEY (`id_status_menikah`) REFERENCES `tbl_status_menikah` (`id_status_menikah`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_jadwal_praktek_dokter`
--
ALTER TABLE `tbl_jadwal_praktek_dokter`
  ADD CONSTRAINT `ifbk_kode_dokter_1` FOREIGN KEY (`kode_dokter`) REFERENCES `tbl_dokter` (`kode_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_kode_poli_prak_1` FOREIGN KEY (`id_poliklinik`) REFERENCES `tbl_poliklinik` (`id_poliklinik`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_mutasi_deposit`
--
ALTER TABLE `tbl_mutasi_deposit`
  ADD CONSTRAINT `ifbk_mutasi_no_rawat_1` FOREIGN KEY (`no_rawat`) REFERENCES `tbl_pendaftaran` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_pic_1` FOREIGN KEY (`user_in_charge`) REFERENCES `tbl_user` (`id_users`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_obat_alkes_bhp`
--
ALTER TABLE `tbl_obat_alkes_bhp`
  ADD CONSTRAINT `ibfk_kat_harga_brg_1` FOREIGN KEY (`id_kategori_harga_brg`) REFERENCES `tbl_kategori_harga_brg` (`id_kategori_harga_brg`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_kategori_barang_1` FOREIGN KEY (`id_kategori_barang`) REFERENCES `tbl_kategori_barang` (`id_kategori_barang`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_satuan_barang_1` FOREIGN KEY (`id_satuan_barang`) REFERENCES `tbl_satuan_barang` (`id_satuan`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_pasien`
--
ALTER TABLE `tbl_pasien`
  ADD CONSTRAINT `ifbk_pasien_agama_1` FOREIGN KEY (`id_agama`) REFERENCES `tbl_agama` (`id_agama`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pasien_gol_darah_1` FOREIGN KEY (`id_gol_darah`) REFERENCES `tbl_gol_darah` (`id_gol_darah`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pasien_pekerjaan_1` FOREIGN KEY (`id_pekerjaan`) REFERENCES `tbl_pekerjaan` (`id_pekerjaan`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_riwayat_pemberian_obat`
--
ALTER TABLE `tbl_riwayat_pemberian_obat`
  ADD CONSTRAINT `ifbk_pasien_no_rawat_1` FOREIGN KEY (`no_rawat`) REFERENCES `tbl_pendaftaran` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_riwayat_kd_obat_1` FOREIGN KEY (`kode_barang`) REFERENCES `tbl_obat_alkes_bhp` (`kode_barang`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_status_acc_obat_1` FOREIGN KEY (`id_status_acc`) REFERENCES `tbl_status_acc` (`id_status_acc`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_ruang_rawat_inap`
--
ALTER TABLE `tbl_ruang_rawat_inap`
  ADD CONSTRAINT `ifbk_gedung_1` FOREIGN KEY (`kode_gedung_rawat_inap`) REFERENCES `tbl_gedung_rawat_inap` (`kode_gedung_rawat_inap`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_kode_kelas_1` FOREIGN KEY (`kode_kelas`) REFERENCES `tbl_kelas_ruang_ranap` (`id_kelas_ruang_ranap`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_tempat_tidur`
--
ALTER TABLE `tbl_tempat_tidur`
  ADD CONSTRAINT `ifbk_kode_ruang_2` FOREIGN KEY (`kode_ruang_rawat_inap`) REFERENCES `tbl_ruang_rawat_inap` (`kode_ruang_rawat_inap`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
