-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 08 Okt 2020 pada 12.59
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
-- Database: `simrs`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `abc`
--

CREATE TABLE `abc` (
  `id` bigint NOT NULL,
  `myd` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `abc`
--

INSERT INTO `abc` (`id`, `myd`) VALUES
(1, 0),
(2, 0),
(3, 1),
(4, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `bh_pasien`
--

CREATE TABLE `bh_pasien` (
  `id` bigint NOT NULL,
  `id_gol_darah` tinyint NOT NULL,
  `id_pekerjaan` bigint NOT NULL,
  `id_agama` smallint NOT NULL,
  `id_status_pernikahan` tinyint NOT NULL,
  `id_uic` bigint NOT NULL,
  `id_alamat_kecamatan` bigint DEFAULT NULL,
  `id_alamat_kota` bigint DEFAULT NULL,
  `no_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_identitas` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_jenis_kelamin` tinyint NOT NULL,
  `nama_ibu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tempat_lahir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `nama_pasien` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat` text NOT NULL,
  `no_telepon` varchar(25) NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Trigger `bh_pasien`
--
DELIMITER $$
CREATE TRIGGER `trigger_pasien_insert` BEFORE INSERT ON `bh_pasien` FOR EACH ROW BEGIN
	DECLARE pasien_id bigint;
	DECLARE no_rm varchar(100);
    
	INSERT INTO `tbl_pasien`(`id_gol_darah`, `id_pekerjaan`, `id_agama`, `id_status_pernikahan`, `id_uic`, `id_alamat_kecamatan`, `id_alamat_kota`, `no_kartu`, `no_identitas`, `id_jenis_kelamin`, `nama_ibu`, `tempat_lahir`, `tgl_lahir`, `nama_pasien`, `alamat`, `no_telepon`) VALUES
    (NEW.id_gol_darah, NEW.id_pekerjaan, new.id_agama, new.id_status_pernikahan, new.id_uic, new.id_alamat_kecamatan, new.id_alamat_kota, new.no_kartu, new.no_identitas, new.id_jenis_kelamin, new.nama_ibu, new.tempat_lahir, new.tgl_lahir, new.nama_pasien, new.alamat, new.no_telepon);
    
    SELECT last_insert_id() into pasien_id;
    
    SET no_rm = CONCAT(DATE_FORMAT(NOW(),'%Y%m%d'), "_", pasien_id);
    
    INSERT INTO `tbl_pasien_rekamedis` (`id_pasien`, `id_uic`, `no_rekamedis`) values (pasien_id, new.id_uic, no_rm);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bh_pendaftaran_pasien_baru`
--

CREATE TABLE `bh_pendaftaran_pasien_baru` (
  `id` bigint NOT NULL,
  `id_gol_darah` tinyint NOT NULL,
  `id_pekerjaan` bigint NOT NULL,
  `id_agama` smallint NOT NULL,
  `id_status_pernikahan` tinyint NOT NULL,
  `id_uic` bigint NOT NULL,
  `id_alamat_kecamatan` bigint DEFAULT NULL,
  `id_alamat_kota` bigint DEFAULT NULL,
  `no_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_identitas` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_jenis_kelamin` tinyint NOT NULL,
  `nama_ibu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tempat_lahir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `nama_pasien` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat` text NOT NULL,
  `no_telepon` varchar(25) NOT NULL,
  `id_cara_masuk` bigint NOT NULL,
  `id_status_rawat` bigint NOT NULL,
  `id_pj_dokter` bigint NOT NULL,
  `id_poli` bigint NOT NULL,
  `id_jenis_bayar` bigint NOT NULL,
  `tgl_daftar` datetime NOT NULL,
  `nama_pj` varchar(100) NOT NULL,
  `id_hub_dg_pj` bigint NOT NULL,
  `alamat_pj` text NOT NULL,
  `no_identitas_pj` varchar(100) NOT NULL,
  `asal_rujukan` varchar(100) DEFAULT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Trigger `bh_pendaftaran_pasien_baru`
--
DELIMITER $$
CREATE TRIGGER `trigger_pasien_baru` BEFORE INSERT ON `bh_pendaftaran_pasien_baru` FOR EACH ROW BEGIN
	DECLARE last_idrawat bigint;
	DECLARE last_idpasien bigint;
	DECLARE last_idrekmedis bigint;
	DECLARE _norekmed VARCHAR(100);
	DECLARE _nokartu VARCHAR(50);

	insert into tbl_pasien (`id_gol_darah`, `id_pekerjaan`, `id_agama`, `id_status_pernikahan`, `id_alamat_kecamatan`, `id_alamat_kota`, `no_kartu`, `no_identitas`, `id_jenis_kelamin`, `nama_ibu`, `tempat_lahir`, `tgl_lahir`, `nama_pasien`, `alamat`, `no_telepon`, id_uic) values 
	(NEW.`id_gol_darah`, NEW.`id_pekerjaan`, NEW.`id_agama`, NEW.`id_status_pernikahan`, NEW.`id_alamat_kecamatan`, NEW.`id_alamat_kota`, NEW.`no_kartu`, NEW.`no_identitas`, NEW.`id_jenis_kelamin`, NEW.`nama_ibu`, NEW.`tempat_lahir`, NEW.`tgl_lahir`, NEW.`nama_pasien`, NEW.`alamat`, NEW.`no_telepon`, NEW.id_uic);

	SELECT last_insert_id() into last_idpasien; 
    
    SET _norekmed = CONCAT(DATE_FORMAT(NOW(),'%Y%m%d'), "_", last_idpasien);
    
    INSERT INTO `tbl_pasien_rekamedis` (`id_pasien`, `id_uic`, `no_rekamedis`) values (last_idpasien, new.id_uic, _norekmed);
    
    SELECT last_insert_id() into last_idrekmedis; 

	INSERT INTO tbl_pendaftaran (`id_rekamedis`,  `id_cara_masuk`,  `id_status_rawat`,  `id_pj_dokter`,  `id_poli`,  `id_jenis_bayar`,  `no_rawat`,  `tgl_daftar`,  `asal_rujukan`,  `nama_pj`,  `id_hub_dg_pj`,  `alamat_pj`,  `no_identitas_pj`, id_uic) VALUES 
	(last_idrekmedis, NEW.`id_cara_masuk`, NEW.`id_status_rawat`, NEW.`id_pj_dokter`, NEW.`id_poli`, NEW.`id_jenis_bayar`, '-', NEW.`tgl_daftar`, NEW.`asal_rujukan`, NEW.`nama_pj`, NEW.`id_hub_dg_pj`, NEW.`alamat_pj`, NEW.`no_identitas_pj`, new.id_uic);
    
    SELECT last_insert_id() into last_idrawat;

	select no_kartu into _nokartu
	from tbl_pendaftaran
	join tbl_pasien_rekamedis on tbl_pasien_rekamedis.id = tbl_pendaftaran.id_rekamedis
	join tbl_pasien on tbl_pasien.id = tbl_pasien_rekamedis.id_pasien
    where tbl_pendaftaran.id = last_idrawat;

	UPDATE tbl_pendaftaran
	SET no_rawat = CONCAT(DATE_FORMAT(NOW(), "%Y%m%d"), "/", _norekmed, "/", last_idrawat)
	where id = last_idrawat;
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bh_pendaftaran_pasien_lama`
--

CREATE TABLE `bh_pendaftaran_pasien_lama` (
  `id` bigint NOT NULL,
  `id_rekamedis` bigint NOT NULL,
  `id_cara_masuk` bigint NOT NULL,
  `id_status_rawat` bigint NOT NULL,
  `id_pj_dokter` bigint NOT NULL,
  `id_poli` bigint NOT NULL,
  `id_jenis_bayar` bigint NOT NULL,
  `tgl_daftar` datetime NOT NULL,
  `nama_pj` varchar(100) NOT NULL,
  `id_hub_dg_pj` bigint NOT NULL,
  `alamat_pj` text NOT NULL,
  `no_identitas_pj` varchar(100) NOT NULL,
  `asal_rujukan` varchar(100) DEFAULT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Trigger `bh_pendaftaran_pasien_lama`
--
DELIMITER $$
CREATE TRIGGER `trigger_pasien_lama` BEFORE INSERT ON `bh_pendaftaran_pasien_lama` FOR EACH ROW BEGIN
	DECLARE last_idrawat bigint;
	DECLARE _norekmed VARCHAR(100);
	DECLARE _nokartu VARCHAR(50);
    
	INSERT INTO tbl_pendaftaran (`id_rekamedis`,  `id_cara_masuk`,  `id_status_rawat`,  `id_pj_dokter`,  `id_poli`,  `id_jenis_bayar`,  `no_rawat`,  `tgl_daftar`,  `asal_rujukan`,  `nama_pj`,  `id_hub_dg_pj`,  `alamat_pj`,  `no_identitas_pj`, id_uic) VALUES 
	(NEW.`id_rekamedis`, NEW.`id_cara_masuk`, NEW.`id_status_rawat`, NEW.`id_pj_dokter`, NEW.`id_poli`, NEW.`id_jenis_bayar`, '-', NEW.`tgl_daftar`, NEW.`asal_rujukan`, NEW.`nama_pj`, NEW.`id_hub_dg_pj`, NEW.`alamat_pj`, NEW.`no_identitas_pj`, new.id_uic);
    
    SELECT last_insert_id() into last_idrawat;

	 select no_kartu, no_rekamedis into _nokartu, _norekmed
	from tbl_pendaftaran
	join tbl_pasien_rekamedis on tbl_pasien_rekamedis.id = tbl_pendaftaran.id_rekamedis
	join tbl_pasien on tbl_pasien.id = tbl_pasien_rekamedis.id_pasien
    where tbl_pendaftaran.id = last_idrawat;

	UPDATE tbl_pendaftaran
	SET no_rawat = CONCAT(DATE_FORMAT(NOW(), "%Y%m%d"), "/", _norekmed, "/", last_idrawat)
	where id = last_idrawat;
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bh_pendaftaran_ranap`
--

CREATE TABLE `bh_pendaftaran_ranap` (
  `id` bigint NOT NULL,
  `id_pendaftaran` bigint NOT NULL,
  `id_ruang_ranap` bigint NOT NULL,
  `tgl_keluar` datetime NOT NULL,
  `deposit_awal` bigint NOT NULL,
  `id_uic` bigint NOT NULL
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Trigger `bh_pendaftaran_ranap`
--
DELIMITER $$
CREATE TRIGGER `trigger_pindah_ke_ranap` BEFORE INSERT ON `bh_pendaftaran_ranap` FOR EACH ROW BEGIN
	DECLARE hrg_ruang BIGINT;
    DECLARE tot BIGINT;
    DECLARE last_idranap BIGINT;
    
	UPDATE tbl_pendaftaran
    SET tbl_pendaftaran.id_status_rawat = 2
    where tbl_pendaftaran.id = new.id_pendaftaran;
    
    INSERT INTO `tbl_pendaftaran_ranap`( `id_pendaftaran`, `id_ruang_ranap`, `tanggal_masuk`, `tanggal_keluar`, `id_uic`) VALUES 
    (new.id_pendaftaran, new.id_ruang_ranap, CURRENT_TIMESTAMP, new.tgl_keluar, new.id_uic);
    
    SELECT last_insert_id() into last_idranap;
    
    INSERT INTO `tbl_pendaftaran_mutasi`(`id_pendaftaran`, `jumlah`, `keterangan`,  `id_uic`) VALUES
    (NEW.id_pendaftaran, new.deposit_awal, "PENYETORAN AWAL PASIEN", NEW.id_uic);
    
    SELECT tbl_rs_ruang.tarif into hrg_ruang from tbl_rs_ruang where tbl_rs_ruang.id = new.id_ruang_ranap;
    
    SELECT (hrg_ruang * DATEDIFF(tbl_pendaftaran_ranap.tanggal_keluar, tbl_pendaftaran_ranap.tanggal_masuk)) into tot
    from tbl_pendaftaran_ranap
    where tbl_pendaftaran_ranap.id = last_idranap;
    
    INSERT INTO `tbl_pendaftaran_mutasi`(`id_pendaftaran`, `jumlah`, `keterangan`,  `id_uic`) VALUES
    (NEW.id_pendaftaran, -tot, "BIAYA INAP PASIEN", NEW.id_uic);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_agama`
--

CREATE TABLE `tbl_agama` (
  `id` smallint NOT NULL,
  `agama` varchar(30) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_agama`
--

INSERT INTO `tbl_agama` (`id`, `agama`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'Islam', 1, '2020-10-01 20:02:49', NULL),
(2, 'Katolik', 1, '2020-10-01 20:02:49', NULL),
(3, 'Protestan', 1, '2020-10-01 20:02:49', NULL),
(4, 'Hindu', 1, '2020-10-01 20:02:49', NULL),
(5, 'Buddha', 1, '2020-10-01 20:02:49', NULL),
(6, 'Konghucu', 1, '2020-10-01 20:02:49', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_antrean`
--

CREATE TABLE `tbl_antrean` (
  `id` bigint NOT NULL,
  `id_tipe_antrean` int NOT NULL,
  `no_antrean` int NOT NULL,
  `tanggal_antrean` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('ongoing','done','skipped') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Struktur dari tabel `tbl_barang`
--

CREATE TABLE `tbl_barang` (
  `id` bigint NOT NULL,
  `id_kat_barang` bigint NOT NULL,
  `kode_barang` varchar(100) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `id_satuan_barang` bigint NOT NULL,
  `id_kat_harga` bigint NOT NULL,
  `harga` bigint NOT NULL,
  `keterangan` text,
  `stok` bigint NOT NULL DEFAULT '0',
  `id_uic` bigint NOT NULL DEFAULT '1',
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_barang`
--

INSERT INTO `tbl_barang` (`id`, `id_kat_barang`, `kode_barang`, `nama_barang`, `id_satuan_barang`, `id_kat_harga`, `harga`, `keterangan`, `stok`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 1, '00001', 'ABBOCATH 18 test', 3, 2, 14951, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(2, 1, '00002', 'ABBOCATH 20', 3, 1, 14950, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(3, 1, '00003', 'ABBOCATH 18', 3, 2, 14950, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(4, 1, '00004', 'ACETON 60ML', 1, 1, 6750, NULL, 106, 1, '2020-10-02 10:29:11', NULL),
(5, 1, '00005', 'ACIFAR CR 5 GR', 5, 1, 6400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(6, 1, '00006', 'ACITRAL TAB TEST', 6, 1, 1380, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(7, 1, '00007', 'ACLONAC GEL', 5, 1, 33902, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(8, 1, '00008', 'ACNOL 10ML', 3, 1, 9517, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(9, 1, '00009', 'ACTIFED H 60ML', 1, 1, 29040, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(10, 1, '00010', 'ACTIFED K 60ML', 1, 1, 26289, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(11, 1, '00011', 'ACTIFED M 60ML', 1, 1, 29040, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(12, 1, '00012', 'ACTIRAL', 3, 1, 1600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(13, 1, '00013', 'ACYCLOVIR CR 5GR INF', 5, 1, 3900, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(14, 1, '00014', 'ACYCLOVIR CR 5GR KF', 5, 1, 4095, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(15, 1, '00015', 'ACYCLOVIR TAB 200MG', 7, 1, 408, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(16, 1, '00016', 'ACYCLOVIR TAB 200MG INF', 7, 1, 500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(17, 1, '00017', 'ACYCLOVIR TAB 400MG HEX', 7, 1, 559, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(18, 1, '00018', 'ACYCLOVIR TAB 400MG INF', 7, 1, 714, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(19, 1, '00019', 'ADEM SARI', 8, 1, 1174, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(20, 1, '00020', 'ADEM SARI @1', 3, 1, 1507, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(21, 1, '00021', 'ADEM SARI @24', 3, 1, 1289, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(22, 1, '00022', 'ADEM SARI FRESH @6', 9, 1, 1241, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(23, 1, '00023', 'ADI CUP 240ML', 1, 1, 680, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(24, 1, '00024', 'AFI FLU TAB @1000', 7, 1, 360, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(25, 1, '00025', 'AFIFLU TAB', 7, 1, 384, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(26, 1, '00026', 'AFIRHEUMA', 10, 1, 313, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(27, 1, '00027', 'AFITRACIN 10 ML', 1, 1, 1560, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(28, 1, '00028', 'AFITSON CENGKEH', 3, 1, 3450, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(29, 1, '00029', 'AGUARIA 330ML', 1, 1, 1707, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(30, 1, '00030', 'AILIN TM 5ML', 1, 1, 5009, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(31, 1, '00031', 'AINIE SBN SIRIH 110 ML', 1, 1, 5959, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(32, 1, '00032', 'AKURAT', 3, 1, 9900, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(33, 1, '00033', 'AKURAT COMPACT', 8, 1, 15813, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(34, 1, '00034', 'ALANG SARI @7', 3, 1, 1011, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(35, 1, '00035', 'ALAT PEMANCUNG HIDUNG', 3, 1, 10400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(36, 1, '00036', 'ALAT PEMB. KOMEDO', 3, 1, 10400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(37, 1, '00037', 'ALAT PEMB. TELINGA', 3, 1, 10400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(38, 1, '00038', 'ALBA PASTILES', 8, 1, 8000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(39, 1, '00039', 'ALBI GURAH', 1, 1, 26450, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(40, 1, '00040', 'ALBIGURAA 25 KAPS ALBIRUNI', 1, 1, 22880, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(41, 1, '00041', 'ALBOTHYL 10 ML', 1, 1, 30993, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(42, 1, '00042', 'ALBOTHYL 5ML', 1, 1, 19888, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(43, 1, '00043', 'ALBU GURAH JUMBO', 1, 1, 51750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(44, 1, '00044', 'ALCO PLUS DMP 100 ML', 1, 1, 29095, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(45, 1, '00045', 'ALERDEX TAB', 7, 1, 1224, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(46, 1, '00046', 'ALKOHOL 100ML ONEMED', 1, 1, 3000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(47, 1, '00047', 'ALKOHOL 70% 100 ML AFI', 1, 1, 3840, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(48, 1, '00048', 'ALKOHOL 70% 100 ML HAKO', 1, 1, 2960, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(49, 1, '00049', 'ALKOHOL 70% 100 ML SEINO', 1, 1, 3000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(50, 1, '00050', 'ALKOHOL 70% 100ML BERLICO', 1, 1, 3789, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(51, 1, '00051', 'ALKOHOL 70% 100ML NUFA', 1, 1, 3551, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(52, 1, '00052', 'ALKOHOL 70% 300 ML ONEMED', 1, 1, 9000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(53, 1, '00053', 'ALKOHOL 70% 300ML AFI', 1, 1, 13585, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(54, 1, '00054', 'ALKOHOL SWAB', 3, 1, 230, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(55, 1, '00055', 'ALLERGIL CR 2% 5GR', 5, 1, 3749, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(56, 1, '00056', 'ALLERIN EXP 60 ML', 1, 1, 12548, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(57, 1, '00057', 'ALLERON TAB', 7, 1, 158, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(58, 1, '00058', 'ALLETROL TM 5 ML', 1, 1, 12279, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(59, 1, '00059', 'ALLETROL ZM 3,5GR', 5, 1, 10382, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(60, 1, '00060', 'ALLOPURINOL 100 MG', 7, 1, 165, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(61, 1, '00061', 'ALLOPURINOL 300 MG', 7, 1, 319, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(62, 1, '00062', 'ALLOPURINOL TAB 100MG FM', 7, 1, 172, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(63, 1, '00063', 'ALMINA KIDS', 1, 1, 35200, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(64, 1, '00064', 'ALMINA MADU JINTEN', 1, 1, 50600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(65, 1, '00065', 'ALOFAR TAB 300MG', 7, 1, 465, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(66, 1, '00066', 'ALPARA 60ML', 1, 1, 9331, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(67, 1, '00067', 'ALPARA TAB', 7, 1, 578, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(68, 1, '00068', 'ALPHARA 60ML', 1, 1, 11963, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(69, 1, '00069', 'ALVIT DROP', 3, 1, 9200, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(70, 1, '00070', 'AMBEVEN CAP', 6, 1, 11845, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(71, 1, '00071', 'AMBROXOL SYR 60 ML', 1, 1, 4125, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(72, 1, '00072', 'AMBROXOL TAB', 7, 1, 156, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(73, 1, '00073', 'AMINOPHYLLIN 200MG @1000', 7, 1, 180, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(74, 1, '00074', 'AMLODIPIN TAB 10 MG HEX', 7, 1, 2646, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(75, 1, '00075', 'AMLODIPIN TAB 10 MG INDO', 7, 1, 2115, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(76, 1, '00076', 'AMLODIPIN TAB 10 MG SOHO', 7, 1, 1150, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(77, 1, '00077', 'AMLODIPIN TAB 5 MG', 7, 1, 1199, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(78, 1, '00078', 'AMLODIPIN TAB 5 MG DEXA', 7, 1, 625, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(79, 1, '00079', 'AMLODIPIN TAB 5 MG HEX', 7, 1, 3025, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(80, 1, '00080', 'AMLODIPIN TAB 5 MG INF', 9, 1, 1200, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(81, 1, '00081', 'AMLODIPIN TAB 5 MG KF', 7, 1, 1200, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(82, 1, '00082', 'AMOXSAN CAP 500MG', 11, 1, 3875, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(83, 1, '00083', 'AMOXSAN DROP', 1, 1, 26441, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(84, 1, '00084', 'AMOXSAN DRY SYR 125MG', 1, 1, 24326, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(85, 1, '00085', 'AMOXSAN SYR 60ML', 1, 1, 37709, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(86, 1, '00086', 'AMOXYCILLIN SYR 60ML', 1, 1, 4625, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(87, 1, '00087', 'AMOXYCILLIN TAB 500 MG', 7, 1, 363, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(88, 1, '00088', 'AMOXYCILLIN TAB 500 MG BERNO', 7, 1, 351, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(89, 1, '00089', 'AMOXYCILLIN TAB 500 MG INDO', 7, 1, 481, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(90, 1, '00090', 'AMOXYCILLIN TAB 500 MG KF', 7, 1, 481, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(91, 1, '00091', 'AMOXYCILLIN TAB 500 MG NOVA', 7, 1, 450, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(92, 1, '00092', 'AMOXYCILLIN TAB 500MG RAMA', 7, 1, 429, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(93, 1, '00093', 'AMPICILIN TAB 500 MG INDO', 7, 1, 463, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(94, 1, '00094', 'AMPICILLIN TAB 500 MG ERITA', 7, 1, 377, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(95, 1, '00095', 'AMPICILLIN TAB 500 MG KF', 7, 1, 491, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(96, 1, '00096', 'AMPICILLIN TAB 500 MG MEPRO', 7, 1, 481, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(97, 1, '00097', 'AMPICILLIN TAB 500 MG RAMA', 7, 1, 429, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(98, 1, '00098', 'AMURATEN', 12, 1, 2990, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(99, 1, '00099', 'ANABION 60 ML', 1, 1, 6072, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(100, 1, '00100', 'ANABION DHA 60 ML', 1, 1, 7590, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(101, 1, '00101', 'ANACETIN SYR 60ML', 1, 1, 6324, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(102, 1, '00102', 'ANAKONIDIN OBH 30 ML', 1, 1, 6148, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(103, 1, '00103', 'ANAKONIDIN OBH 60ML', 1, 1, 9981, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(104, 1, '00104', 'ANAKONIDIN SYR 30ML', 1, 1, 6041, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(105, 1, '00105', 'ANAKONIDIN SYR 60ML', 1, 1, 9981, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(106, 1, '00106', 'ANASTAN TAB', 7, 1, 540, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(107, 1, '00107', 'ANATON 60 ML', 1, 1, 4950, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(108, 1, '00108', 'ANATON TAB', 7, 1, 396, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(109, 1, '00109', 'ANDALAN LAKTASI', 6, 1, 11385, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(110, 1, '00110', 'ANDALAN PIL KB', 6, 1, 4025, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(111, 1, '00111', 'ANLENE ACT CHO 100GR', 8, 1, 12075, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(112, 1, '00112', 'ANLENE ACT CHO 250GR', 8, 1, 27972, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(113, 1, '00113', 'ANLENE ACT VAN 100GR', 8, 1, 11558, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(114, 1, '00114', 'ANLENE ACT VAN 250GR', 8, 1, 27810, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(115, 1, '00115', 'ANLENE ACTIFIT 250GR PLN', 8, 1, 27783, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(116, 1, '00116', 'ANLENE ACTIVIT 600 GR PLAIN', 8, 1, 62501, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(117, 1, '00117', 'ANLENE GOLD CHO 100GR', 8, 1, 11610, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(118, 1, '00118', 'ANLENE GOLD CHO 250GR', 8, 1, 31212, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(119, 1, '00119', 'ANLENE GOLD PLAIN 250GR', 8, 1, 31212, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(120, 1, '00120', 'ANLENE GOLD PLN 100GR', 8, 1, 11610, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(121, 1, '00121', 'ANLENE GOLD VAN 250GR', 8, 1, 31212, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(122, 1, '00122', 'ANLENE TOTAL 200GR PLN', 8, 1, 33480, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(123, 1, '00123', 'ANLENE TOTAL CHO 200GR', 8, 1, 32832, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(124, 1, '00124', 'ANLENE TOTAL VAN 200GR', 8, 1, 32832, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(125, 1, '00125', 'ANMUM MATERNA CHO 80GR', 8, 1, 12708, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(126, 1, '00126', 'ANMUM MATERNA PLAIN 80GR', 8, 1, 11558, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(127, 1, '00127', 'ANMUM MATERNA VAN MG 200 GR', 8, 1, 36369, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(128, 1, '00128', 'ANMUM SB CHO 200 GR', 8, 1, 38726, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(129, 1, '00129', 'ANMUM SB PLAIN 200 GR', 8, 1, 35829, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(130, 1, '00130', 'ANTALGIN TAB', 7, 1, 325, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(131, 1, '00131', 'ANTALGIN TAB BERLICO', 7, 1, 322, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(132, 1, '00132', 'ANTALGIN TAB INDO', 7, 1, 194, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(133, 1, '00133', 'ANTANGIN CAIR', 12, 1, 1824, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(134, 1, '00134', 'ANTANGIN JRG BOX @10', 12, 1, 1872, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(135, 1, '00135', 'ANTANGIN JRG TAB', 6, 1, 1824, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(136, 1, '00136', 'ANTANGIN PERMEN HONEY MINT', 3, 1, 1040, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(137, 1, '00137', 'ANTASIDA DOEN 60 ML KF', 1, 1, 4620, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(138, 1, '00138', 'ANTASIDA DOEN 60ML FM', 1, 1, 4428, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(139, 1, '00139', 'ANTASIDA DOEN TAB ERRELA', 7, 1, 216, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(140, 1, '00140', 'ANTASIDA DOEN TAB KF', 7, 1, 190, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(141, 1, '00141', 'ANTASIDA SYR 60 ML SAMP', 1, 1, 3558, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(142, 1, '00142', 'ANTASIDA TAB @100', 7, 1, 176, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(143, 1, '00143', 'ANTASIDA TAB @1000', 7, 1, 35, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(144, 1, '00144', 'ANTASIDA TAB AFI', 7, 1, 102, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(145, 1, '00145', 'ANTASIDA TAB FM', 7, 1, 146, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(146, 1, '00146', 'ANTIMO TAB', 6, 1, 3960, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(147, 1, '00147', 'ANTIPLAQUE PG 75GR', 3, 1, 15275, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(148, 1, '00148', 'ANTIZ GEL 60ML JRK', 1, 1, 6565, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(149, 1, '00149', 'ANTIZ GEL BT60 FRESH', 1, 1, 6565, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(150, 1, '00150', 'ANTIZA 60 ML', 1, 1, 16731, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(151, 1, '00151', 'ANTIZA TAB', 7, 1, 928, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(152, 1, '00152', 'APIALYS DROP 10ML', 1, 1, 31625, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(153, 1, '00153', 'APIALYS SYR 60ML', 1, 1, 28175, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(154, 1, '00154', 'AQUA DANONE 1500ML', 1, 1, 4440, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(155, 1, '00155', 'AQUARIA BTL 330 ML', 1, 1, 1861, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(156, 1, '00156', 'AQUARIA BTL 600 ML', 1, 1, 2360, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(157, 1, '00157', 'ARM SLIM (L)', 3, 1, 28600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(158, 1, '00158', 'ARM SLIM (M)', 3, 1, 28600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(159, 1, '00159', 'ARM SLIM (S)', 3, 1, 28600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(160, 1, '00160', 'AROMATIC', 1, 1, 9945, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(161, 1, '00161', 'ARTHRIFEN PLUS TAB', 7, 1, 734, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(162, 1, '00162', 'ARTHRIFEN SYR', 1, 1, 17710, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(163, 1, '00163', 'ASAM MEFENAMAT TAB 500 MG AFI', 7, 1, 203, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(164, 1, '00164', 'ASAM MEFENAMAT TAB 500 MG INDO', 7, 1, 229, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(165, 1, '00165', 'ASAM MEFENAMAT TAB 500 MG KF', 7, 1, 229, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(166, 1, '00166', 'ASAM MEFENAMAT TAB 500 MG LAND', 7, 1, 169, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(167, 1, '00167', 'ASAM MEFENAMAT TAB 500 MG NOVA', 7, 1, 156, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(168, 1, '00168', 'ASEPSO FRESH ORANGE', 8, 1, 5938, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(169, 1, '00169', 'ASEPSO SOAP CLEAN 80 GR', 3, 1, 5938, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(170, 1, '00170', 'ASEPSO SOAP REG 80GR', 3, 1, 6395, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(171, 1, '00171', 'ASIFIT TAB @30', 1, 1, 48984, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(172, 1, '00172', 'ASMASOLON TAB @4', 6, 1, 1656, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(173, 1, '00173', 'ASPILET TAB@100', 7, 1, 667, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(174, 1, '00174', 'ASTHIN FORCE', 7, 1, 4083, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(175, 1, '00175', 'ASTHMA SOHO @1000', 7, 1, 278, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(176, 1, '00176', 'ASTHMA SOHO@4', 6, 1, 1670, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(177, 1, '00177', 'AUTAN JNR LOT 50ML', 1, 1, 7849, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(178, 1, '00178', 'AUTAN LOT FAM @5', 12, 1, 594, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(179, 1, '00179', 'AUTAN S&S LOT 50ML', 1, 1, 6469, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(180, 1, '00180', 'AVAIL BIRU', 8, 1, 31850, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(181, 1, '00181', 'AVAIL HIJAU', 8, 1, 27300, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(182, 1, '00182', 'AVAIL MERAH', 8, 1, 31850, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(183, 1, '00183', 'B & B KIDS SHP 100 ML', 1, 1, 6240, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(184, 1, '00184', 'B&B KIDS SHAMPO', 1, 1, 5003, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(185, 1, '00185', 'BABY COUGH PACDIN 60 ML', 1, 1, 4433, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(186, 1, '00186', 'BABY COUGH SYR 60ML', 1, 1, 3855, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(187, 1, '00187', 'BALPIRIK HIJAU EKSTA KUAT', 3, 1, 4746, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(188, 1, '00188', 'BALPIRIK JASMINE', 3, 1, 5226, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(189, 1, '00189', 'BALPIRIK KAYU PTH', 3, 1, 4727, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(190, 1, '00190', 'BALPIRIK KUNING EKSTRA KUAT', 3, 1, 4727, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(191, 1, '00191', 'BALPIRIK LAVENDER', 3, 1, 5226, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(192, 1, '00192', 'BALPIRIK MERAH EKSTRA KUAT', 3, 1, 5292, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(193, 1, '00193', 'BALPIRIK ROSE', 3, 1, 5226, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(194, 1, '00194', 'BAN LENG TJENG', 1, 1, 10580, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(195, 1, '00195', 'BATUGIN 120 ML', 1, 1, 16129, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(196, 1, '00196', 'BATUGIN 300 ML', 1, 1, 28641, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(197, 1, '00197', 'BAYCUTEN N CR 5 GR', 5, 1, 41859, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(198, 1, '00198', 'BAYGON COIL REG STD', 8, 1, 2610, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(199, 1, '00199', 'BD ALKOHOL SWABS', 8, 1, 480, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(200, 1, '00200', 'BEAKER GLASS 50CC', 3, 1, 48000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(201, 1, '00201', 'BEAR BRAND 189 ML', 1, 1, 6696, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(202, 1, '00202', 'BEBELAC 2 200GR', 8, 1, 28134, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(203, 1, '00203', 'BEBELOVE 1 200GR', 8, 1, 34074, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(204, 1, '00204', 'BEBELOVE 2 200GR', 8, 1, 32400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(205, 1, '00205', 'BEBELOVE 3 200GR', 8, 1, 26811, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(206, 1, '00206', 'BECOM-C', 7, 1, 1366, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(207, 1, '00207', 'BECOMBION 100ML', 1, 1, 21850, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(208, 1, '00208', 'BECOMBION PLUS 110ML', 1, 1, 24550, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(209, 1, '00209', 'BEDAK MARCK CREAM', 3, 1, 10924, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(210, 1, '00210', 'BEDAK MARCK PUTIH', 3, 1, 9430, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(211, 1, '00211', 'BEDAK MARCK ROSE', 3, 1, 9430, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(212, 1, '00212', 'BENACOL EXP 100ML', 1, 1, 15307, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(213, 1, '00213', 'BENDERA 123 CHO 400 GR', 8, 1, 30186, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(214, 1, '00214', 'BENDERA 123 MADU 200 GR', 8, 1, 16119, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(215, 1, '00215', 'BENDERA 123 VAN 400 GR', 8, 1, 31482, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(216, 1, '00216', 'BENDERA 456 CHO 400GR', 8, 1, 30807, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(217, 1, '00217', 'BENDERA 456 VAN 300GR', 8, 1, 12015, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(218, 1, '00218', 'BENDERA CAIR 115ML CHO', 8, 1, 2243, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(219, 1, '00219', 'BENDERA CAIR 115ML STRW', 8, 1, 2231, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(220, 1, '00220', 'BENDERA CAIR CHO 190', 1, 1, 2500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(221, 1, '00221', 'BENDERA CAIR STRW 190', 1, 1, 2500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(222, 1, '00222', 'BENDERA CHO 200GR', 8, 1, 12312, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(223, 1, '00223', 'BENDERA CHO KLG', 1, 1, 7290, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(224, 1, '00224', 'BENDERA FORMULA 1 200 GR', 8, 1, 16362, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(225, 1, '00225', 'BENDERA FORMULA 2 200 GR', 8, 1, 16470, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(226, 1, '00226', 'BENDERA FORMULA 2 400 GR', 8, 1, 35019, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(227, 1, '00227', 'BENDERA FULL KRIM 200GR', 8, 1, 14850, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(228, 1, '00228', 'BENDERA GOLD KLG', 1, 1, 9477, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(229, 1, '00229', 'BENDERA HI-LO 250 CK', 8, 1, 3780, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(230, 1, '00230', 'BENDERA KID 115 CHO', 8, 1, 2535, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(231, 1, '00231', 'BENDERA KID 115 STRW', 8, 1, 2522, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(232, 1, '00232', 'BENDERA KRIMER', 1, 1, 7668, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(233, 1, '00233', 'BENDERA SCHOL 190 CO', 8, 1, 3120, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(234, 1, '00234', 'BENDERA SCHOL 190 STRW', 8, 1, 3090, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(235, 1, '00235', 'BENDERA SKM GOLD SACH', 12, 1, 1485, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(236, 1, '00236', 'BENDERA UHT 115ML BR', 8, 1, 2243, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(237, 1, '00237', 'BENDERA UHT 115ML CHO', 8, 1, 2070, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(238, 1, '00238', 'BENDERA UHT 190 CHO', 8, 1, 3014, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(239, 1, '00239', 'BENDERA UHT 190 STRW', 8, 1, 3014, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(240, 1, '00240', 'BENDERA UHT 190ML BR', 8, 1, 3014, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(241, 1, '00241', 'BENOSON CR 5GR', 5, 1, 11000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(242, 1, '00242', 'BENOSON N CR 15 GR', 5, 1, 27500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(243, 1, '00243', 'BENZOLAC 2,5% CR 5GR', 3, 1, 13613, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(244, 1, '00244', 'BENZOLAC CR 5% 5GR', 5, 1, 14520, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(245, 1, '00245', 'BENZOLAC-CL 5% 10 GR', 5, 1, 30250, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(246, 1, '00246', 'BERLICORT CR', 5, 1, 11049, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(247, 1, '00247', 'BERLOSID 60ML', 1, 1, 6841, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(248, 1, '00248', 'BERLOSID TAB', 7, 1, 243, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(249, 1, '00249', 'BERLOSON N CR 5 GR', 5, 1, 5395, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(250, 1, '00250', 'BERLOSYD SYR 60ML', 1, 1, 5066, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(251, 1, '00251', 'BERNESTEN CR 5GR', 5, 1, 7095, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(252, 1, '00252', 'BETADINE FMN', 1, 1, 19048, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(253, 1, '00253', 'BETADINE GARGLE', 1, 1, 9504, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(254, 1, '00254', 'BETADINE GARGLE 190ML', 1, 1, 16408, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(255, 1, '00255', 'BETADINE JNR', 3, 1, 474, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(256, 1, '00256', 'BETADINE KIDS 5ML', 1, 1, 3416, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(257, 1, '00257', 'BETADINE OINT 10GR', 5, 1, 14295, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(258, 1, '00258', 'BETADINE OINT 5 GR', 3, 1, 8778, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(259, 1, '00259', 'BETADINE SABUN CAIR 100 ML', 1, 1, 30360, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(260, 1, '00260', 'BETADINE SABUN CAIR 60 ML', 1, 1, 21505, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(261, 1, '00261', 'BETADINE SOL 15 ML', 3, 1, 8976, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(262, 1, '00262', 'BETADINE SOL 30 ML', 1, 1, 14916, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(263, 1, '00263', 'BETADINE SOL 5 ML', 1, 1, 3099, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(264, 1, '00264', 'BETADINE SOL 60 ML', 1, 1, 24563, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(265, 1, '00265', 'BETADINE VAG DOUCHE (+) ALAT', 1, 1, 48477, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(266, 1, '00266', 'BETADINE VAG DOUCHE (-) ALAT', 1, 1, 41140, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(267, 1, '00267', 'BETAHISTINE TAB 6MG NOVELL', 7, 1, 1155, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(268, 1, '00268', 'BETAMETASON 0,1% CR 5GR', 5, 1, 2634, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(269, 1, '00269', 'BETASIN CR 10GR', 5, 1, 31625, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(270, 1, '00270', 'BETASON N CR 5 GR', 3, 1, 10120, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(271, 1, '00271', 'BETOPIC CR', 5, 1, 30030, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(272, 1, '00272', 'BIKIN JOSS', 1, 1, 16000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(273, 1, '00273', 'BIMACYL TAB', 7, 1, 400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(274, 1, '00274', 'BIMAFLOX TAB 500MG', 7, 1, 449, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(275, 1, '00275', 'BIMATRA KAPS 500MG', 10, 1, 455, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(276, 1, '00276', 'BIMOXYL TAB 500MG', 7, 1, 487, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(277, 1, '00277', 'BINOTAL 500MG', 7, 1, 4892, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(278, 1, '00278', 'BIO JANNA', 8, 1, 74750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(279, 1, '00279', 'BIO KNK', 8, 1, 11700, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(280, 1, '00280', 'BIOGESIC 60ML', 1, 1, 22138, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(281, 1, '00281', 'BIOGESIC TAB', 6, 1, 1543, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(282, 1, '00282', 'BIOLYSIN 60ML', 1, 1, 10120, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(283, 1, '00283', 'BIOLYSIN EMUL 250 ML', 1, 1, 15180, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(284, 1, '00284', 'BIOLYSIN KIDS ANGGUR', 8, 1, 8855, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(285, 1, '00285', 'BIOLYSIN KIDS JERUK', 8, 1, 8855, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(286, 1, '00286', 'BIOLYSIN KIDS STRW', 8, 1, 8855, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(287, 1, '00287', 'BIOLYSIN SMART 100ML', 1, 1, 16781, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(288, 1, '00288', 'BIOLYSIN SMART 60ML', 1, 1, 11385, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(289, 1, '00289', 'BIOMEGA TAB', 7, 1, 483, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(290, 1, '00290', 'BIOPLACENTON 10GR', 3, 1, 15813, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(291, 1, '00291', 'BIORE BF B100 AC DEO', 3, 1, 5298, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(292, 1, '00292', 'BIORE BF B100 ANTISEPT', 1, 1, 5298, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(293, 1, '00293', 'BIORE BF B100 HEALTH', 3, 1, 5298, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(294, 1, '00294', 'BIORE BF LIVELY', 1, 1, 5330, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(295, 1, '00295', 'BIORE FF 40 ACNE&CARE', 1, 1, 9133, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(296, 1, '00296', 'BIORE FF 40 POR&OIL', 1, 1, 9133, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(297, 1, '00297', 'BIORE MEN FF 40 ACT', 1, 1, 8483, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(298, 1, '00298', 'BIOSENTRA 1000GR', 9, 1, 37481, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(299, 1, '00299', 'BIOSENTRA 500GR', 9, 1, 21464, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(300, 1, '00300', 'BIOSTRUM', 1, 1, 44850, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(301, 1, '00301', 'BIOVISION CAP', 7, 1, 1794, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(302, 1, '00302', 'BISOLTUSIN 60 ML', 1, 1, 24736, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(303, 1, '00303', 'BISOLVON ELIX 60ML', 1, 1, 25174, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(304, 1, '00304', 'BISOLVON EXTRA 60ML', 1, 1, 26216, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(305, 1, '00305', 'BISOLVON FLU 60ML', 1, 1, 27968, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(306, 1, '00306', 'BISOLVON KID 60ML', 1, 1, 25933, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(307, 1, '00307', 'BISOLVON TAB', 6, 1, 2013, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(308, 1, '00308', 'BLACK COFFE AROMATIC', 8, 1, 30000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(309, 1, '00309', 'BLOOD LANCET CRN @200', 9, 1, 49400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(310, 1, '00310', 'BODREX BATUK FLU TAB @4', 6, 1, 1380, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(311, 1, '00311', 'BODREX EXTRA TAB @4', 6, 1, 1668, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(312, 1, '00312', 'BODREX FLU&BTK ATT', 1, 1, 7091, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(313, 1, '00313', 'BODREX FLU&BTK EXP 60 ML', 1, 1, 7216, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(314, 1, '00314', 'BODREX MIGRA', 6, 1, 1758, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(315, 1, '00315', 'BODREX TAB @10', 6, 1, 2635, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(316, 1, '00316', 'BODREXIN 60ML', 1, 1, 5750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(317, 1, '00317', 'BODREXIN FLU BATUK 60M ML', 1, 1, 5750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(318, 1, '00318', 'BODREXIN TAB @10', 6, 1, 1610, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(319, 1, '00319', 'BORAX GLYCERIN', 1, 1, 2161, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(320, 1, '00320', 'BORRAGINOL N OINT', 3, 1, 44125, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(321, 1, '00321', 'BORRAGINOL N SUPP @10', 13, 1, 9874, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(322, 1, '00322', 'BRAITO TEARS 5 ML', 1, 1, 7084, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(323, 1, '00323', 'BRAITO TM 6ML', 1, 1, 7084, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(324, 1, '00324', 'BRONCHITIN 60ML', 1, 1, 4980, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(325, 1, '00325', 'BRONKRIS ELIX 60 ML', 1, 1, 5600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(326, 1, '00326', 'BRONSOLVAN TAB', 7, 1, 456, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(327, 1, '00327', 'BRONSULVAN SYR', 1, 1, 14030, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(328, 1, '00328', 'BUFACARYL TAB', 7, 1, 202, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(329, 1, '00329', 'BUFACOMB CR', 3, 1, 15125, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(330, 1, '00330', 'BUFACORT N CR', 3, 1, 4944, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(331, 1, '00331', 'BUFAGAN 60ML', 1, 1, 3606, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(332, 1, '00332', 'BUFANTACID F 60ML', 1, 1, 5526, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(333, 1, '00333', 'BUFANTACID TAB', 7, 1, 142, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(334, 1, '00334', 'BUFECT 100 ML', 1, 1, 14878, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(335, 1, '00335', 'BUFENOL KAPS', 10, 1, 281, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(336, 1, '00336', 'BURNAZIN CR 35 GR', 5, 1, 48703, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(337, 1, '00337', 'BYE BYE FEVER BABY @10', 3, 1, 6672, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(338, 1, '00338', 'BYE BYE FEVER CHILD @5', 3, 1, 9266, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(339, 1, '00339', 'CAL 95', 7, 1, 4375, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(340, 1, '00340', 'CALADINE LOT 60ML', 1, 1, 10278, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(341, 1, '00341', 'CALADINE LOT 95', 1, 1, 14520, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(342, 1, '00342', 'CALADINE POWDER ORIG 60GR', 1, 1, 7464, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(343, 1, '00343', 'CALADINE PWD ACT', 1, 1, 9631, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(344, 1, '00344', 'CALADINE PWD ORG 100GR', 1, 1, 10956, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(345, 1, '00345', 'CALADINE PWD SOFT 100GR', 1, 1, 10296, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(346, 1, '00346', 'CALCIFAR TAB', 7, 1, 160, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(347, 1, '00347', 'CALCIUM LACT @1000', 7, 1, 105, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(348, 1, '00348', 'CALCUSOL CAP @30', 10, 1, 995, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(349, 1, '00349', 'CALCUSOL CAP @50', 1, 1, 44390, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(350, 1, '00350', 'CALLUSOL', 1, 1, 27671, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(351, 1, '00351', 'CANDISTIN DROP', 1, 1, 40563, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(352, 1, '00352', 'CANESTEN CR 3GR', 3, 1, 16141, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(353, 1, '00353', 'CANESTEN CR 5GR', 3, 1, 19784, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(354, 1, '00354', 'CANTIK LANGSING KAPS', 1, 1, 35750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(355, 1, '00355', 'CAPORIT 50 GR AFI', 1, 1, 2960, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(356, 1, '00356', 'CAPTOPRIL 12,5MG KF', 7, 1, 117, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(357, 1, '00357', 'CAPTOPRIL 25MG', 7, 1, 170, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(358, 1, '00358', 'CAPTOPRIL TAB 12,5 MG INDO', 7, 1, 127, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(359, 1, '00359', 'CAPTOPRIL TAB 25 MG INDO', 7, 1, 207, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(360, 1, '00360', 'CARBIDU 0,75MG TAB', 7, 1, 303, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(361, 1, '00361', 'CARBIDU TAB 0,5MG', 7, 1, 288, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(362, 1, '00362', 'CATAFLAM 50MG', 7, 1, 4954, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(363, 1, '00363', 'CAVICUR DHA 60ML', 1, 1, 7167, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(364, 1, '00364', 'CAVICUR TAB', 6, 1, 5445, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(365, 1, '00365', 'CAVIPLEX 60 ML', 1, 1, 5768, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(366, 1, '00366', 'CAVIPLEX CAP', 10, 1, 430, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(367, 1, '00367', 'CAVIPLEX DROPS', 1, 1, 4506, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(368, 1, '00368', 'CAZETIN DROP', 1, 1, 20625, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(369, 1, '00369', 'CDR EFF @10', 3, 1, 31379, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(370, 1, '00370', 'CDR FORTOS EFF@10', 1, 1, 33953, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(371, 1, '00371', 'CEFADROXYL 60 ML INDO', 1, 1, 11440, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(372, 1, '00372', 'CEFADROXYL KAPS', 10, 1, 1038, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(373, 1, '00373', 'CEFADROXYL KAPS 500MG BERNO', 10, 1, 1144, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(374, 1, '00374', 'CEFADROXYL KAPS 500MG DEXA', 10, 1, 767, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(375, 1, '00375', 'CEFADROXYL KAPS 500MG MEDIKON', 10, 1, 878, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(376, 1, '00376', 'CEFAT DS 60ML', 1, 1, 46653, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(377, 1, '00377', 'CEFIXIME 100MG HEX @50', 10, 1, 3113, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(378, 1, '00378', 'CEFIXIME CAP', 7, 1, 3375, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(379, 1, '00379', 'CEIXIME SYR', 1, 1, 37813, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(380, 1, '00380', 'CENDO AUGENTONIC 5ML', 3, 1, 31250, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(381, 1, '00381', 'CENDO CATARLENT 15ML', 1, 1, 29728, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(382, 1, '00382', 'CENDO CATARLENT 5ML', 3, 1, 23890, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(383, 1, '00383', 'CENDO CENFRESH MD', 3, 1, 4537, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(384, 1, '00384', 'CENDO CENFRESH TM 5ML', 1, 1, 33902, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(385, 1, '00385', 'CENDO EYE FRESH MD', 3, 1, 4881, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(386, 1, '00386', 'CENDO FENICOL 0,25% TM 5ML', 1, 1, 23031, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(387, 1, '00387', 'CENDO FENICOL 0,5% TM 5ML', 1, 1, 32313, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(388, 1, '00388', 'CENDO GENTA 0,3% TM 5ML', 1, 1, 29906, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(389, 1, '00389', 'CENDO GENTAMYCIN EO 0,3%', 5, 1, 33344, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(390, 1, '00390', 'CENDO LITERS 15ML', 1, 1, 21821, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(391, 1, '00391', 'CENDO LYTERS MD', 3, 1, 3732, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(392, 1, '00392', 'CENDO MYCETIN SM 3,5GR', 5, 1, 17531, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(393, 1, '00393', 'CENDO POLYDEX ED 5ML', 1, 1, 41113, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(394, 1, '00394', 'CENDO POLYDEX MD', 3, 1, 5603, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(395, 1, '00395', 'CENDO TIMOL 0,5% TM 5ML', 1, 1, 56202, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(396, 1, '00396', 'CENDO XITROL 5ML', 3, 1, 29728, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(397, 1, '00397', 'CENDO XITROL EO', 3, 1, 35234, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(398, 1, '00398', 'CEREBORFORT GINKO', 1, 1, 13513, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(399, 1, '00399', 'CEREBROFORT GOLD 200ML', 3, 1, 30360, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(400, 1, '00400', 'CEREBROFORT GOLD 60ML ORG', 1, 1, 10285, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(401, 1, '00401', 'CEREBROFORT GOLD JRK 100ML', 1, 1, 15538, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(402, 1, '00402', 'CEREBROFORT GOLD STRW 100ML', 1, 1, 15538, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(403, 1, '00403', 'CEREBROFORT SYR', 1, 1, 14295, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(404, 1, '00404', 'CEREBROVIT GINKO', 8, 1, 15028, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(405, 1, '00405', 'CEREBROVIT X-CEL', 8, 1, 15028, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(406, 1, '00406', 'CERELAC AYAM BWG 120 GR', 8, 1, 7705, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(407, 1, '00407', 'CETEME @12', 6, 1, 1479, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(408, 1, '00408', 'CETIRIZINE TAB 10 MG HEXP', 7, 1, 392, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(409, 1, '00409', 'CETIRIZINE TAB 10 MG KF', 7, 1, 397, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(410, 1, '00410', 'CETIRIZINE TAB 10 MG NOVELL', 7, 1, 392, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(411, 1, '00411', 'CHAOBA-GENOUILLERE ROT', 3, 1, 15600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(412, 1, '00412', 'CHARM BF ACT SLIM WING 10', 3, 1, 6570, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(413, 1, '00413', 'CHARM BF ACT WINGS @10', 8, 1, 5642, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(414, 1, '00414', 'CHARM BF EX MAXI 8', 8, 1, 3575, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(415, 1, '00415', 'CHARM BF EX MAXI W10', 8, 1, 6533, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(416, 1, '00416', 'CHARM BF EXT MAXI 1', 8, 1, 469, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(417, 1, '00417', 'CHARM SINGLE', 8, 1, 510, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(418, 1, '00418', 'CHIL KID DHA 200 MD', 8, 1, 32427, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(419, 1, '00419', 'CHIL KID DHA 200 VNL', 8, 1, 32427, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(420, 1, '00420', 'CHLORAMPHECORT H CR 10GR', 3, 1, 10863, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(421, 1, '00421', 'CHLORAMPHENICOL KAPS 250 MG INDO', 10, 1, 346, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(422, 1, '00422', 'CHOLESVIT TAB', 7, 1, 913, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(423, 1, '00423', 'CHRYSANTHENUM', 3, 1, 1725, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(424, 1, '00424', 'CIMETIDIN TAB 200 MG FM', 7, 1, 210, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(425, 1, '00425', 'CIMETIDINE TAB 200 MG', 7, 1, 170, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(426, 1, '00426', 'CINDERELLA CT BUDS BABY', 8, 1, 1674, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(427, 1, '00427', 'CIPROFLOXACIN TAB 500 MG NOVA', 7, 1, 390, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(428, 1, '00428', 'CIPROFLOXACIN TAB 500 MG PROMED', 7, 1, 338, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(429, 1, '00429', 'CIPROFLOXACIN TAB 500 NOVELL', 7, 1, 429, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(430, 1, '00430', 'CIPROFLOXACIN TAB 500MG HEX', 7, 1, 429, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(431, 1, '00431', 'CIPTADENT PG 30 GR ICE', 3, 1, 2088, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(432, 1, '00432', 'CIPTADENT PG120 COOL', 8, 1, 4843, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(433, 1, '00433', 'CIPTADENT S WHITE 65 GR', 3, 1, 4120, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(434, 1, '00434', 'CITOCETIN SYR 60ML', 1, 1, 4669, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(435, 1, '00435', 'CITRA FC 130ML FRADIAN', 1, 1, 13618, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(436, 1, '00436', 'CITRA FC 130ML WHT UV', 1, 1, 13618, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(437, 1, '00437', 'CITRA LASTING WHITE 120 ML', 1, 1, 10440, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(438, 1, '00438', 'CLEAR COMPL SC 90ML', 1, 1, 8999, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(439, 1, '00439', 'CLEAR UNI SHP 80 CSC', 1, 1, 10758, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(440, 1, '00440', 'CLINDAMYCIN 300MG INDO', 10, 1, 979, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(441, 1, '00441', 'CLONIDIN TAB 0,15 MG INDO', 7, 1, 267, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(442, 1, '00442', 'CLOSE UP GREEN 65 GR', 5, 1, 4949, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(443, 1, '00443', 'CLUB AIR MINUM 240ML', 1, 1, 688, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(444, 1, '00444', 'COHISTAN 60 ML', 1, 1, 13283, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(445, 1, '00445', 'COLDREXIN SYR 60ML', 1, 1, 4239, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(446, 1, '00446', 'COLFIN SYR 60ML', 1, 1, 6052, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(447, 1, '00447', 'COMBANTRIN JRK', 1, 1, 13514, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(448, 1, '00448', 'COMBANTRIN TAB 125MG', 6, 1, 9680, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(449, 1, '00449', 'COMBANTRIN TAB 250MG', 6, 1, 10319, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(450, 1, '00450', 'COMBI KIDS FRUIT&VEGGIE', 8, 1, 25300, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(451, 1, '00451', 'COMBI KIDS JRK', 8, 1, 19263, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(452, 1, '00452', 'COMBI KIDS STRW', 8, 1, 22138, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(453, 1, '00453', 'COMTUSI 60ML STRW', 1, 1, 38638, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(454, 1, '00454', 'COMTUSI SYR 60ML', 1, 1, 38638, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(455, 1, '00455', 'CONDIABET TAB', 7, 1, 865, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(456, 1, '00456', 'CONFIDENC DIAPER M10', 8, 1, 52211, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(457, 1, '00457', 'CONFIDENCE DIAPER L @1', 8, 1, 5356, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(458, 1, '00458', 'CONFIDENCE DIAPER L10', 8, 1, 58276, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(459, 1, '00459', 'CONFIDENCE DIAPER M @1', 8, 1, 4773, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(460, 1, '00460', 'CONTREXIN TAB', 6, 1, 679, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(461, 1, '00461', 'COOCOOLANT EXT 350ML', 1, 1, 5759, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(462, 1, '00462', 'COOLANT EXTR 350ML', 1, 1, 6399, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(463, 1, '00463', 'COOLING 5 SPRAY', 3, 1, 23760, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(464, 1, '00464', 'COPAL 25GR', 3, 1, 13596, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(465, 1, '00465', 'COPAL CHEST 36GR', 14, 1, 18343, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(466, 1, '00466', 'COPARCETIN KID COUGH 60 ML', 1, 1, 4768, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(467, 1, '00467', 'COPARCTINE 60 ML', 1, 1, 4416, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(468, 1, '00468', 'COREDRYL EXP 100 ML', 1, 1, 6435, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(469, 1, '00469', 'CORTIGRA CR 5 GR', 5, 1, 10523, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(470, 1, '00470', 'COTRIMOXAZOLE TAB', 7, 1, 206, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(471, 1, '00471', 'COUNTERPAIN 15 GR', 3, 1, 21054, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(472, 1, '00472', 'COUNTERPAIN 30GR', 3, 1, 30976, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(473, 1, '00473', 'COUNTERPAIN 5 GR', 3, 1, 12803, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(474, 1, '00474', 'COUNTERPAIN 60GR', 5, 1, 52360, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(475, 1, '00475', 'COUNTERPAIN COOL 15GR', 3, 1, 23825, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(476, 1, '00476', 'COUNTERPAIN COOL 30GR', 5, 1, 33685, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(477, 1, '00477', 'COUNTERPAIN CR 120 GR', 5, 1, 78045, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(478, 1, '00478', 'CROM OPTHAL ED 5ML', 1, 1, 52111, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(479, 1, '00479', 'CTM 4MG @1000', 7, 1, 24, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(480, 1, '00480', 'CTM TAB 4 MG PIM @1000', 7, 1, 30, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(481, 1, '00481', 'CTM TAB PIM', 6, 1, 1146, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(482, 1, '00482', 'CUKA APEL TAHESTA 300ML', 1, 1, 26565, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(483, 1, '00483', 'CURCUMA PLUS DHA JRK 60ML', 1, 1, 12430, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(484, 1, '00484', 'CURCUMA PLUS DHA STRW 60ML', 1, 1, 12430, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(485, 1, '00485', 'CURCUMA PLUS EMULSION JRK', 1, 1, 18645, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(486, 1, '00486', 'CURCUMA PLUS EMULSION STRW', 1, 1, 19888, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(487, 1, '00487', 'CURCUMA PLUS FRUITPUNCH 60ML', 1, 1, 12018, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(488, 1, '00488', 'CURCUMA PLUS IMUNS 60ML', 1, 1, 13915, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(489, 1, '00489', 'CURCUMA PLUS ORG 60ML', 1, 1, 9944, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(490, 1, '00490', 'CURCUMA PLUS SUSU 180GR MD', 8, 1, 21600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(491, 1, '00491', 'CURCUMA TAB', 7, 1, 871, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(492, 1, '00492', 'CURVIT CL EMUL', 1, 1, 48400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(493, 1, '00493', 'CURVIT SYR 60ML', 1, 1, 21505, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(494, 1, '00494', 'CUSSON BABY OIL 100ML', 1, 1, 10010, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(495, 1, '00495', 'CUSSON BABY OIL NAT 50ML', 1, 1, 9100, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(496, 1, '00496', 'CUSSON BABY PWD C&P 100 GR', 1, 1, 6175, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(497, 1, '00497', 'CUSSON BABY PWD M&G 100 GR', 1, 1, 6175, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(498, 1, '00498', 'CUSSON BABY PWD MILD&GENT', 1, 1, 5700, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(499, 1, '00499', 'CUSSON BABY PWD SOFT&SMT', 1, 1, 5700, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(500, 1, '00500', 'CUSSON BEDAK 100GR', 8, 1, 6160, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(501, 1, '00501', 'CUSSON CREAM 50 S&S', 14, 1, 14658, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(502, 1, '00502', 'CUSSON CREAM C&P 50GR', 14, 1, 14983, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(503, 1, '00503', 'CUSSON HAIR LOT 50 ML', 1, 1, 11895, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(504, 1, '00504', 'CUSSON OIL 50 M&G', 1, 1, 9100, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(505, 1, '00505', 'CUSSON PWD SS&PK 100GR', 1, 1, 6175, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(506, 1, '00506', 'CUSSON S&S 50 GR', 3, 1, 13530, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(507, 1, '00507', 'CUSSON SHP A&H 50ML', 1, 1, 7800, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(508, 1, '00508', 'CUSSON SHP C&P 50ML', 1, 1, 7800, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(509, 1, '00509', 'CUSSON SOAP M&G 80GR', 3, 1, 2821, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(510, 1, '00510', 'CUSSON SOAP S&S 75 GR', 3, 1, 2821, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(511, 1, '00511', 'CUSSONS OIL S&S 100ML', 1, 1, 15958, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(512, 1, '00512', 'CUSSONS PWD 50 CP-HJ', 1, 1, 3283, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(513, 1, '00513', 'CUSSONS PWD 50GR MG-BR', 1, 1, 3283, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(514, 1, '00514', 'CUSSONS PWD 50GR SS-PK', 1, 1, 3283, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(515, 1, '00515', 'CYCLOFEM INJ', 15, 1, 10439, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(516, 1, '00516', 'DAHLIA KAMFER', 8, 1, 1081, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(517, 1, '00517', 'DAKTARIN CR 10GR', 3, 1, 33770, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(518, 1, '00518', 'DAKTARIN CR 5GR', 3, 1, 20096, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(519, 1, '00519', 'DAKTARIN DIAPER CR 10GR', 5, 1, 56059, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(520, 1, '00520', 'DAKTARIN ORAL GEL', 5, 1, 61468, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(521, 1, '00521', 'DAKTARIN POWDER 20GR', 1, 1, 50600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(522, 1, '00522', 'DAMABEN DROPS', 1, 1, 15180, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(523, 1, '00523', 'DAMABEN SYR', 1, 1, 11722, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(524, 1, '00524', 'DANCOW 1+ MADU 200GR', 8, 1, 18603, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(525, 1, '00525', 'DANCOW 3+ MADU 200GR', 8, 1, 18198, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(526, 1, '00526', 'DANCOW BATITA 150 VAN', 8, 1, 11232, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(527, 1, '00527', 'DANCOW BATITA MADU 150GR', 8, 1, 11232, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(528, 1, '00528', 'DANCOW BATITA MD 300GR', 8, 1, 21141, NULL, 100, 1, '2020-10-02 10:29:11', NULL);
INSERT INTO `tbl_barang` (`id`, `id_kat_barang`, `kode_barang`, `nama_barang`, `id_satuan_barang`, `id_kat_harga`, `harga`, `keterangan`, `stok`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(529, 1, '00529', 'DANCOW CAL CHO 200GR', 8, 1, 15687, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(530, 1, '00530', 'DANCOW DATITA MD 150GR', 8, 1, 10530, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(531, 1, '00531', 'DANCOW DATITA VAN 150GR', 8, 1, 10206, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(532, 1, '00532', 'DANCOW IRON FULL CR 200GR', 8, 1, 16659, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(533, 1, '00533', 'DANCOW IRON FULL CREAM 400GR', 8, 1, 32805, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(534, 1, '00534', 'DANCOW IRON INSTA 200GR', 8, 1, 16281, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(535, 1, '00535', 'DANCOW UHT 190 ML ACTIV', 8, 1, 3840, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(536, 1, '00536', 'DANEURON TAB', 7, 1, 342, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(537, 1, '00537', 'DAPYRIN TAB 500MG @200', 7, 1, 195, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(538, 1, '00538', 'DARSI PIL', 8, 1, 7910, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(539, 1, '00539', 'DECADRYL SYR 120 ML', 1, 1, 14548, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(540, 1, '00540', 'DECADRYL SYR 60ML', 1, 1, 10753, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(541, 1, '00541', 'DECOLGEN HERBAFLU', 12, 1, 1898, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(542, 1, '00542', 'DECOLGEN TAB', 6, 1, 1498, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(543, 1, '00543', 'DECOLSIN CAP', 6, 1, 2366, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(544, 1, '00544', 'DECOLSIN SYR 60ML', 1, 1, 16262, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(545, 1, '00545', 'DECUBAL CR 20 GR', 5, 1, 20592, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(546, 1, '00546', 'DEE DEE MOSQUITO 50 GR', 1, 1, 5753, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(547, 1, '00547', 'DEE DEE SHP REF 125 ML', 1, 1, 5265, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(548, 1, '00548', 'DEGIROL TAB', 6, 1, 2985, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(549, 1, '00549', 'DEMACOLIN 60 ML', 1, 1, 8040, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(550, 1, '00550', 'DEMACOLIN TAB', 7, 1, 306, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(551, 1, '00551', 'DEMACOLIN TAB 1000', 7, 1, 364, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(552, 1, '00552', 'DEPO PROGESTIN 3CC', 15, 1, 8450, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(553, 1, '00553', 'DERMOVATE CR 5 GR', 5, 1, 52938, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(554, 1, '00554', 'DESOLEX N CR 10 GR', 5, 1, 26787, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(555, 1, '00555', 'DETTOL HAND SNT', 1, 1, 6859, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(556, 1, '00556', 'DETTOL LIQ 100ML', 1, 1, 13048, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(557, 1, '00557', 'DETTOL LIQ 50ML', 1, 1, 5585, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(558, 1, '00558', 'DETTOL SOAP 110 GR ALL', 3, 1, 4628, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(559, 1, '00559', 'DETTOL SOAP 70GR ACT', 3, 1, 2977, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(560, 1, '00560', 'DETTOL SOAP 70GR FRESH', 3, 1, 2993, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(561, 1, '00561', 'DETTOL SOAP 70GR SENS', 3, 1, 2977, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(562, 1, '00562', 'DETTOL SOAP COOL 70GR', 3, 1, 3438, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(563, 1, '00563', 'DETTOL SOAP ORG 70GR', 3, 1, 2993, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(564, 1, '00564', 'DETTOL TALK 150 GR', 1, 1, 16385, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(565, 1, '00565', 'DETTOL TALK 75GR', 3, 1, 10625, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(566, 1, '00566', 'DEXAMETHASON 0,5MG @1000', 7, 1, 41, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(567, 1, '00567', 'DEXAMETHASON 0,5MG HARSEN', 7, 1, 199, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(568, 1, '00568', 'DEXAMETHASON 0,75MG HARSEN', 7, 1, 217, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(569, 1, '00569', 'DEXANTA SYR', 1, 1, 12144, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(570, 1, '00570', 'DEXANTA TAB', 7, 1, 192, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(571, 1, '00571', 'DEXIGEN CR 5 GR', 5, 1, 8625, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(572, 1, '00572', 'DEXMOLEX 100ML', 1, 1, 9075, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(573, 1, '00573', 'DEXTAMIN 60ML', 1, 1, 37754, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(574, 1, '00574', 'DEXTAMIN TAB', 7, 1, 1817, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(575, 1, '00575', 'DEXTEEM PLUS TAB', 7, 1, 303, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(576, 1, '00576', 'DEXTRAL 100 ML', 1, 1, 10428, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(577, 1, '00577', 'DEXTRAL 60 ML', 1, 1, 8437, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(578, 1, '00578', 'DEXTRAL F TAB', 7, 1, 756, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(579, 1, '00579', 'DEXTRAL TAB', 7, 1, 591, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(580, 1, '00580', 'DEXTROFORT 60 ML', 1, 1, 8494, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(581, 1, '00581', 'DEXTROMETHORHAN 15MG TAB', 7, 1, 119, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(582, 1, '00582', 'DEXTROMETHORPAN 60 ML INDO', 1, 1, 3723, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(583, 1, '00583', 'DEXTROMETHORPAN 60 ML RAMA', 1, 1, 3300, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(584, 1, '00584', 'DEXTROSE 5% 500ML', 1, 1, 13650, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(585, 1, '00585', 'DEXYCOL TAB 500 MG', 7, 1, 767, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(586, 1, '00586', 'DHE DHE SHP', 1, 1, 1524, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(587, 1, '00587', 'DIABETASOL CAPPU 180GR', 8, 1, 39339, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(588, 1, '00588', 'DIABETASOL CHO 180GR', 8, 1, 38934, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(589, 1, '00589', 'DIABETASOL NR', 6, 1, 2530, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(590, 1, '00590', 'DIABETASOL SWEET 37,5', 8, 1, 16705, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(591, 1, '00591', 'DIABETASOL VAN 180GR', 8, 1, 38934, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(592, 1, '00592', 'DIABETASOL VD 180 GR VNL', 8, 1, 40122, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(593, 1, '00593', 'DIALET', 7, 1, 144, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(594, 1, '00594', 'DIAPET CAP', 6, 1, 1518, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(595, 1, '00595', 'DIAPET NR', 3, 1, 2600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(596, 1, '00596', 'DIAPET SYR', 1, 1, 6958, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(597, 1, '00597', 'DIASEC TAB', 7, 1, 2338, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(598, 1, '00598', 'DIGOXIN TAB', 7, 1, 179, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(599, 1, '00599', 'DILTIAZEM 30MG TAB GKF', 7, 1, 255, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(600, 1, '00600', 'DINA KAPAS BIASA', 8, 1, 1438, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(601, 1, '00601', 'DINA KAPAS POTONG 30GR', 8, 1, 3125, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(602, 1, '00602', 'DIONICOL KAPS', 10, 1, 848, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(603, 1, '00603', 'DIONICOL SYR 60ML', 1, 1, 5999, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(604, 1, '00604', 'DIPROGENTA OINT 5GR', 5, 1, 51321, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(605, 1, '00605', 'DIPS SYR 10 CC', 3, 1, 3600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(606, 1, '00606', 'DISP SYR NIPRO 10 CC', 3, 1, 3600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(607, 1, '00607', 'DISP SYR NIPRO 20 CC', 3, 1, 8000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(608, 1, '00608', 'DISP SYR NIPRO 3 CC', 3, 1, 1750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(609, 1, '00609', 'DISP SYR NIPRO 5 CC', 3, 1, 3000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(610, 1, '00610', 'DISP. SYR 10CC TERUMO', 3, 1, 2340, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(611, 1, '00611', 'DISP. SYR 1CC INS TERUMO', 3, 1, 2600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(612, 1, '00612', 'DISP. SYR 1CC TERUMO', 3, 1, 2400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(613, 1, '00613', 'DISP. SYR 3CC BD', 3, 1, 1280, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(614, 1, '00614', 'DISP. SYR 3CC TERUMO', 3, 1, 1560, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(615, 1, '00615', 'DISP. SYR 5CC BD', 3, 1, 2400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(616, 1, '00616', 'DISP. SYR 5CC TERUMO', 3, 1, 4550, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(617, 1, '00617', 'DIYET BOROBUDUR', 8, 1, 9200, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(618, 1, '00618', 'DODO BUD BB Z100 133', 8, 1, 3738, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(619, 1, '00619', 'DOLO LICOBION', 7, 1, 520, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(620, 1, '00620', 'DOLO NEUROBION', 6, 1, 14856, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(621, 1, '00621', 'DOMESTOS PRO LAV JMB', 8, 1, 3300, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(622, 1, '00622', 'DOMPERIDONE', 7, 1, 253, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(623, 1, '00623', 'DOXIGEN CR 5GR', 5, 1, 6581, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(624, 1, '00624', 'DOXYCYCLIN KAPS 100 MG INDO', 10, 1, 329, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(625, 1, '00625', 'DR KANG ADULT DIAPERS @L2', 8, 1, 18480, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(626, 1, '00626', 'DR KANG ADULT DIAPERS XL@8', 8, 1, 66000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(627, 1, '00627', 'DR KANG ADUTL DIAPERS @L8', 8, 1, 72000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(628, 1, '00628', 'DR. KANG XL8', 3, 1, 63250, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(629, 1, '00629', 'DR. P ADULT BASIC L2', 8, 1, 15600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(630, 1, '00630', 'DR. P ADULT BASIC M2', 8, 1, 14400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(631, 1, '00631', 'DR. P ADULT SPECIAL L2', 8, 1, 13193, NULL, 103, 1, '2020-10-02 10:29:11', NULL),
(632, 1, '00632', 'DR. P ADULT SPECIAL L8', 8, 1, 46161, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(633, 1, '00633', 'DR. P BASIC L8', 3, 1, 51387, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(634, 1, '00634', 'DR. P BASIC M10', 3, 1, 48590, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(635, 1, '00635', 'DR. P SPC M8', 3, 1, 46330, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(636, 1, '00636', 'DRAGON MENTHOL (K)', 3, 1, 3795, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(637, 1, '00637', 'DRAGON MENTHOL H1', 3, 1, 6199, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(638, 1, '00638', 'DRAGON MENTHOL H2', 3, 1, 4744, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(639, 1, '00639', 'DRAGON MENTHOL HSB 20GR', 3, 1, 18695, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(640, 1, '00640', 'DRAGON MENTHOL HSP 8GR', 3, 1, 7865, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(641, 1, '00641', 'DRAMAMINE TAB 50 MG', 7, 1, 1500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(642, 1, '00642', 'DRP. P ADULT BASIC M2', 8, 1, 11115, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(643, 1, '00643', 'DS 5% 500ML', 1, 1, 6250, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(644, 1, '00644', 'DULCOLACTOL SYR 60 ML', 1, 1, 46101, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(645, 1, '00645', 'DULCOLAX SUPP ADULT', 13, 1, 16976, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(646, 1, '00646', 'DULCOLAX SUPP ANAK', 13, 1, 13728, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(647, 1, '00647', 'DULCOLAX TAB', 6, 1, 4687, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(648, 1, '00648', 'DUMIN 60 ML', 1, 1, 16859, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(649, 1, '00649', 'DUMIN TAB', 7, 1, 401, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(650, 1, '00650', 'DUMOCALCIN MINT 30', 7, 1, 481, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(651, 1, '00651', 'DUREX EXTRA SAFE @3', 3, 1, 14561, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(652, 1, '00652', 'DUREX FETHERLITE @3', 3, 1, 13236, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(653, 1, '00653', 'DUREX RIBBED @3', 8, 1, 13236, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(654, 1, '00654', 'DUREX TOGETHER @3', 3, 1, 11108, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(655, 1, '00655', 'E JUSS', 8, 1, 3910, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(656, 1, '00656', 'EASY TOUCH BLOOD CHOLESTEROL @10', 3, 1, 17550, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(657, 1, '00657', 'EASY TOUCH BLOOD GLUCOSE @25', 3, 1, 80500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(658, 1, '00658', 'EASY TOUCH URIC ACID @25', 3, 1, 4160, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(659, 1, '00659', 'EFISOL LIQ 10ML', 1, 1, 21505, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(660, 1, '00660', 'EKSIM 7GR', 3, 1, 7000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(661, 1, '00661', 'ELKANA SYR 60ML', 1, 1, 21175, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(662, 1, '00662', 'ELKANA TAB', 7, 1, 805, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(663, 1, '00663', 'EM KAPSUL', 8, 1, 7910, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(664, 1, '00664', 'EMBALAGE', 3, 1, 100, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(665, 1, '00665', 'EMERON SHP 50 ML SM', 1, 1, 2145, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(666, 1, '00666', 'EMERON SHP 50ML LIME', 1, 1, 2145, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(667, 1, '00667', 'EMINETON', 7, 1, 1725, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(668, 1, '00668', 'EMPENG GROSIR', 3, 1, 10010, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(669, 1, '00669', 'EMPENG NINIO @24', 3, 1, 7084, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(670, 1, '00670', 'ENATIN', 10, 1, 1392, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(671, 1, '00671', 'ENBATIC', 3, 1, 2544, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(672, 1, '00672', 'ENBATIC ZALF', 3, 1, 7081, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(673, 1, '00673', 'ENERVON C @30', 1, 1, 28359, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(674, 1, '00674', 'ENERVON C @4', 6, 1, 3969, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(675, 1, '00675', 'ENERVON C EFF', 3, 1, 26964, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(676, 1, '00676', 'ENERVON C PLUS 120 ML', 1, 1, 16569, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(677, 1, '00677', 'ENKASARI SYR 60ML', 1, 1, 13685, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(678, 1, '00678', 'ENTRASOL CHO 185 GR', 8, 1, 32292, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(679, 1, '00679', 'ENTRASOL GOLD CHO 185 GR', 8, 1, 30024, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(680, 1, '00680', 'ENTRASOL GOLD PLAIN 185 GR', 8, 1, 28971, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(681, 1, '00681', 'ENTRASOL GOLD VAN 185 GR', 8, 1, 29700, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(682, 1, '00682', 'ENTROSTOP', 6, 1, 3500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(683, 1, '00683', 'ENTROSTOP ANAK', 12, 1, 1531, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(684, 1, '00684', 'ENZIM MINT 35 GR', 5, 1, 8580, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(685, 1, '00685', 'ENZIM PG MILD', 3, 1, 21700, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(686, 1, '00686', 'ENZIM PG MINT', 3, 1, 12708, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(687, 1, '00687', 'ENZYPLEX @4', 6, 1, 3682, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(688, 1, '00688', 'EQUAL POT @100', 3, 1, 23316, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(689, 1, '00689', 'ERICAF TAB', 7, 1, 5255, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(690, 1, '00690', 'ERLA NEO HYDROCORT CR 5 GR', 5, 1, 5134, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(691, 1, '00691', 'ERLADERM N CR', 5, 1, 4719, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(692, 1, '00692', 'ERLAMYCETIN SM', 3, 1, 4689, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(693, 1, '00693', 'ERLAMYCETIN TM 5ML', 3, 1, 6875, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(694, 1, '00694', 'ERLAMYCETIN TT 5ML', 3, 1, 4386, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(695, 1, '00695', 'ERLAMYCETINE ED PLUS', 1, 1, 9910, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(696, 1, '00696', 'ERMETHASONE 0,5MG TAB', 7, 1, 165, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(697, 1, '00697', 'ERPHAMAZOLE CR 5GR', 5, 1, 4490, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(698, 1, '00698', 'ERPHAMOL 60ML', 1, 1, 11638, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(699, 1, '00699', 'ERPHAMOL TAB 500 MG', 7, 1, 170, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(700, 1, '00700', 'ERSYLAN 60ML', 1, 1, 11495, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(701, 1, '00701', 'ERYSANBE D.S 60ML', 1, 1, 24750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(702, 1, '00702', 'ERYTHROMICIN 500MG', 7, 1, 813, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(703, 1, '00703', 'ERYTHROMYCIN 100MG SYR INDO', 1, 1, 10518, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(704, 1, '00704', 'ESKIM ZALF', 3, 1, 6670, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(705, 1, '00705', 'ESPERSON CR 0,25% 5GR', 5, 1, 44300, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(706, 1, '00706', 'ESQUISE BARU', 12, 1, 518, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(707, 1, '00707', 'ESTER C @30', 1, 1, 34122, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(708, 1, '00708', 'ESTER C @4', 6, 1, 5000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(709, 1, '00709', 'ESTER C EFF', 3, 1, 27025, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(710, 1, '00710', 'ESVAT TAB 10MG', 7, 1, 1502, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(711, 1, '00711', 'ETABION TAB', 7, 1, 197, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(712, 1, '00712', 'ETAFLUSIN SYR 60ML', 1, 1, 4048, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(713, 1, '00713', 'ETAFLUSIN TAB', 7, 1, 525, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(714, 1, '00714', 'ETAGESIC 60ML', 1, 1, 3723, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(715, 1, '00715', 'ETAMOX 60ML', 1, 1, 5280, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(716, 1, '00716', 'ETAMOX TAB 500MG', 7, 1, 480, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(717, 1, '00717', 'ETAMOXUL F TAB', 7, 1, 377, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(718, 1, '00718', 'ETAMOXUL TAB', 7, 1, 221, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(719, 1, '00719', 'ETTAWA SUSU KAMBING', 8, 1, 31050, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(720, 1, '00720', 'ETTAWA SUSU KAMBING PAKET', 8, 1, 50600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(721, 1, '00721', 'EVER E 250 BOTOL', 1, 1, 57558, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(722, 1, '00722', 'EVER E 250IU @12', 8, 1, 23866, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(723, 1, '00723', 'EVION TAB 100', 7, 1, 1299, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(724, 1, '00724', 'EXLUTON PIL KB', 6, 1, 21299, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(725, 1, '00725', 'EXSIM 19 BIRU', 8, 1, 2588, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(726, 1, '00726', 'EXTRA JOSS', 8, 1, 925, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(727, 1, '00727', 'EXTRAFLU TAB', 7, 1, 177, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(728, 1, '00728', 'FACIAL NASA TRAVEL PACK', 8, 1, 2888, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(729, 1, '00729', 'FACIAL SUCCESSFUL', 8, 1, 5606, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(730, 1, '00730', 'FAKTU OINT 20GR', 5, 1, 99220, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(731, 1, '00731', 'FAMEPRIM TAB', 7, 1, 288, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(732, 1, '00732', 'FAMOTODINE KAPS', 10, 1, 147, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(733, 1, '00733', 'FANBO PWD PUFF', 14, 1, 3673, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(734, 1, '00734', 'FARGETIK TAB 500MG', 7, 1, 495, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(735, 1, '00735', 'FARIDEXON TAB', 7, 1, 161, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(736, 1, '00736', 'FARIDEXON TAB 0,5MG', 7, 1, 103, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(737, 1, '00737', 'FARMOTEN TAB 12,5MG', 7, 1, 329, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(738, 1, '00738', 'FARSIFEN 400MG TAB', 7, 1, 371, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(739, 1, '00739', 'FARSIFEN 60 ML', 1, 1, 8750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(740, 1, '00740', 'FASIDOL DROP', 1, 1, 8353, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(741, 1, '00741', 'FASIDOL F 60 ML', 1, 1, 4741, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(742, 1, '00742', 'FASIDOL SYR 60ML', 1, 1, 4649, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(743, 1, '00743', 'FASORBID 5MG TAB', 7, 1, 279, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(744, 1, '00744', 'FATIGON SPIRIT', 6, 1, 5579, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(745, 1, '00745', 'FATIGON TAB @4', 6, 1, 2650, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(746, 1, '00746', 'FATIGON VIRO @5', 6, 1, 3416, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(747, 1, '00747', 'FAXIDEN TAB 20MG', 7, 1, 351, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(748, 1, '00748', 'FEMINAX @4', 6, 1, 1800, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(749, 1, '00749', 'FERMINO', 1, 1, 15000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(750, 1, '00750', 'FEVRIN SYR 60ML', 1, 1, 14295, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(751, 1, '00751', 'FEVRIN TAB', 6, 1, 4599, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(752, 1, '00752', 'FG TROCHES @120', 7, 1, 1028, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(753, 1, '00753', 'FIESTA ALL NIGHT @3', 8, 1, 6749, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(754, 1, '00754', 'FIESTA PASSION @3', 8, 1, 6749, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(755, 1, '00755', 'FITKOM ANGGUR', 1, 1, 11385, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(756, 1, '00756', 'FITKOM GUMMY', 8, 1, 14916, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(757, 1, '00757', 'FITKOM GUMMY CALCIUM', 8, 1, 16445, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(758, 1, '00758', 'FITKOM GUMMY FRUIT&VEGGIE', 8, 1, 20350, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(759, 1, '00759', 'FITKOM JERUK', 8, 1, 11385, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(760, 1, '00760', 'FITKOM PLATINUM 100 ML', 1, 1, 15307, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(761, 1, '00761', 'FITKOM STRW', 8, 1, 11385, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(762, 1, '00762', 'FLAGYSTATIS OVULE', 13, 1, 21137, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(763, 1, '00763', 'FLAMAR GEL 20 GR', 5, 1, 16964, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(764, 1, '00764', 'FLAMESON 4 MG', 7, 1, 862, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(765, 1, '00765', 'FLAMIGRA TAB', 7, 1, 434, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(766, 1, '00766', 'FLORA MADU TRPC 100ML', 1, 1, 13685, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(767, 1, '00767', 'FLOXIFAR TAB', 7, 1, 560, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(768, 1, '00768', 'FLOXIGRA 500MG TAB', 7, 1, 946, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(769, 1, '00769', 'FLUCADEX SYR 60 ML', 1, 1, 10078, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(770, 1, '00770', 'FLUCADEX TAB', 7, 1, 480, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(771, 1, '00771', 'FLUDANE PLUS SYR 60ML', 1, 1, 18343, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(772, 1, '00772', 'FLUDANE SYR 60ML', 1, 1, 14916, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(773, 1, '00773', 'FLUDANE TAB @4', 6, 1, 2935, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(774, 1, '00774', 'FLUDEXIN TAB', 6, 1, 2500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(775, 1, '00775', 'FLUIMUCIL 60 ML', 1, 1, 49335, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(776, 1, '00776', 'FLUMIN TAB', 7, 1, 438, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(777, 1, '00777', 'FLUNAX 60ML', 1, 1, 4670, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(778, 1, '00778', 'FLUTAMOL 60ML', 1, 1, 12650, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(779, 1, '00779', 'FLUTAMOL TAB', 7, 1, 509, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(780, 1, '00780', 'FLUTOP-C 60 ML', 1, 1, 6400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(781, 1, '00781', 'FOLAVIT TAB 400IU', 7, 1, 702, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(782, 1, '00782', 'FORA HO KEMIRI 65ML', 1, 1, 6305, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(783, 1, '00783', 'FORMULA JNR PG 50GR', 3, 1, 4375, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(784, 1, '00784', 'FORMULA KITA GIGI DWS', 3, 1, 2443, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(785, 1, '00785', 'FORMULA SG HC 50GR', 3, 1, 4514, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(786, 1, '00786', 'FORMULA SG HC DORAEMON', 3, 1, 7183, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(787, 1, '00787', 'FORMULA SG PROT', 3, 1, 2827, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(788, 1, '00788', 'FORMULA SG S PROT SYS S', 3, 1, 2633, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(789, 1, '00789', 'FORMULA YNR PG 50GR', 3, 1, 3594, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(790, 1, '00790', 'FORMYCO TAB', 7, 1, 5418, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(791, 1, '00791', 'FORUMEN ED 10 ML', 1, 1, 28655, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(792, 1, '00792', 'FRAGOR TAB', 7, 1, 813, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(793, 1, '00793', 'FRESH CARE GREEN TEA', 1, 1, 10063, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(794, 1, '00794', 'FRESH CARE HOT', 1, 1, 10063, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(795, 1, '00795', 'FRESH CARE LAVENDER', 1, 1, 10063, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(796, 1, '00796', 'FRESH CARE ORIGINAL', 1, 1, 10063, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(797, 1, '00797', 'FRESH CARE SPLASH FRUIT', 1, 1, 10063, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(798, 1, '00798', 'FRESH CREAM', 1, 1, 22750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(799, 1, '00799', 'FREZZA SPRAY REG', 1, 1, 17078, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(800, 1, '00800', 'FRISIAN F 456 200 MD', 8, 1, 14229, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(801, 1, '00801', 'FRISIAN GLAG SCHOOL 190ML', 3, 1, 3088, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(802, 1, '00802', 'FRISIAN KID 115ML STRW', 8, 1, 2481, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(803, 1, '00803', 'FRISIAN SCHOOL 190 ML STRW', 8, 1, 3368, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(804, 1, '00804', 'FRISIAN UHT 190 BERRY', 8, 1, 3120, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(805, 1, '00805', 'FRISIAN UHT190 COBLS', 8, 1, 3088, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(806, 1, '00806', 'FROZZ BLUE MINT', 8, 1, 6034, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(807, 1, '00807', 'FROZZ LIME MINT', 8, 1, 6034, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(808, 1, '00808', 'FROZZ MINT', 8, 1, 6034, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(809, 1, '00809', 'FROZZ ORANGE', 8, 1, 6034, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(810, 1, '00810', 'FROZZ PERMENT', 8, 1, 6296, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(811, 1, '00811', 'FUMADRYL 60 ML', 1, 1, 3750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(812, 1, '00812', 'FUNGIDERM 10GR', 3, 1, 17250, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(813, 1, '00813', 'FUNGIDERM 5GR', 3, 1, 11969, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(814, 1, '00814', 'FUROSEMID 40MG', 7, 1, 128, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(815, 1, '00815', 'FUSICOM CR 5GR', 5, 1, 47438, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(816, 1, '00816', 'FUSON CR 5GR', 5, 1, 47438, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(817, 1, '00817', 'GABITEN TAB', 7, 1, 416, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(818, 1, '00818', 'GALIAN WANITA PIM', 1, 1, 16000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(819, 1, '00819', 'GARAMYCIN CR 5 GR', 5, 1, 29893, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(820, 1, '00820', 'GARAMYCIN OINT 5 GR', 5, 1, 29893, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(821, 1, '00821', 'GARGLIN 15 ML @6', 3, 1, 1576, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(822, 1, '00822', 'GARLIC SAUDA PLUS PROPOLIS', 1, 1, 30800, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(823, 1, '00823', 'GASTBY WG 30 SOFT', 14, 1, 3023, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(824, 1, '00824', 'GASTRUCID SYR 60ML', 1, 1, 4337, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(825, 1, '00825', 'GASTRUCID TAB', 7, 1, 296, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(826, 1, '00826', 'GAZERO @6', 12, 1, 1392, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(827, 1, '00827', 'GELAS UKUR 50ML', 3, 1, 30000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(828, 1, '00828', 'GELIGA BALSAM 10GR', 3, 1, 2923, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(829, 1, '00829', 'GELIGA BALSAM 20GR', 3, 1, 5708, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(830, 1, '00830', 'GELIGA BALSAM 40GR', 3, 1, 10926, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(831, 1, '00831', 'GEMFIBROZIL 300MG', 7, 1, 438, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(832, 1, '00832', 'GEMUK SEHAT BOROBUDUR', 8, 1, 9200, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(833, 1, '00833', 'GEMUK SEHAT PIM', 1, 1, 16000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(834, 1, '00834', 'GENERAL CARE EB 10 X 4,5 CM', 3, 1, 23400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(835, 1, '00835', 'GENOINT EYE OINT 0,3%', 7, 1, 7161, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(836, 1, '00836', 'GENOINT TM', 3, 1, 8470, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(837, 1, '00837', 'GENOINT ZALF', 3, 1, 4620, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(838, 1, '00838', 'GENTALEX CR 5 GR', 5, 1, 6188, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(839, 1, '00839', 'GENTAMYCIN 0,1% 5GR', 3, 1, 2500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(840, 1, '00840', 'GENTIAN VIOLET', 3, 1, 2694, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(841, 1, '00841', 'GILLET BLUE II', 3, 1, 5219, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(842, 1, '00842', 'GILLET GOAL II HC', 3, 1, 4810, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(843, 1, '00843', 'GILLET GOAL KLIK HC', 3, 1, 4844, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(844, 1, '00844', 'GINIFAR TAB', 7, 1, 360, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(845, 1, '00845', 'GIV SABUN 80 GR MERAH', 8, 1, 1820, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(846, 1, '00846', 'GIV SABUN 80 PEAR SC', 3, 1, 1750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(847, 1, '00847', 'GIV SABUN 80GR BKG', 8, 1, 1820, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(848, 1, '00848', 'GIV SABUN 80GR PEPAYA', 8, 1, 1820, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(849, 1, '00849', 'GIV SABUN 80GR UNGU', 8, 1, 1820, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(850, 1, '00850', 'GIV SABUN COKLAT 80GR', 3, 1, 1750, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(851, 1, '00851', 'GIV SABUN PUTIH 80GR', 3, 1, 1820, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(852, 1, '00852', 'GIZI SUPER CR', 3, 1, 7791, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(853, 1, '00853', 'GLIBENCLAMIDE TAB', 7, 1, 108, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(854, 1, '00854', 'GLIMEPIRIDE TAB 10MG HEXP', 7, 1, 950, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(855, 1, '00855', 'GLUCOSAMIN 500 MG INDO', 7, 1, 2640, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(856, 1, '00856', 'GLUCOSAMIN MPL 500MG', 7, 1, 1914, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(857, 1, '00857', 'GLUCOSE DX 5%', 8, 1, 6250, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(858, 1, '00858', 'GLUDEPATIC TAB 500MG', 7, 1, 257, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(859, 1, '00859', 'GLYCERIL GUAICOLAT', 7, 1, 132, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(860, 1, '00860', 'GPU M. URUT 30ML', 1, 1, 5896, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(861, 1, '00861', 'GPU M.URUT 60ML', 1, 1, 10980, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(862, 1, '00862', 'GRADILEX TAB', 7, 1, 284, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(863, 1, '00863', 'GRADINE 100 MG', 7, 1, 550, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(864, 1, '00864', 'GRAFACHLOR TAB', 7, 1, 330, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(865, 1, '00865', 'GRAFADON DROPS', 1, 1, 8430, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(866, 1, '00866', 'GRAFADON F TAB', 7, 1, 242, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(867, 1, '00867', 'GRAFADON SYR 60ML', 1, 1, 6230, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(868, 1, '00868', 'GRAFADON TAB', 7, 1, 136, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(869, 1, '00869', 'GRAFALIN 2MG', 7, 1, 118, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(870, 1, '00870', 'GRAFALIN 4MG', 7, 1, 323, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(871, 1, '00871', 'GRAFAMIC', 7, 1, 352, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(872, 1, '00872', 'GRAFAZOL TAB', 7, 1, 600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(873, 1, '00873', 'GRAFLOXIN TAB 400 MG', 7, 1, 2240, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(874, 1, '00874', 'GRAGENTA CR 5 GR', 5, 1, 9500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(875, 1, '00875', 'GRAHABION TAB', 10, 1, 507, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(876, 1, '00876', 'GRALIXA 40MG TAB', 7, 1, 150, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(877, 1, '00877', 'GRALYSIN 60 ML', 1, 1, 11002, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(878, 1, '00878', 'GRAMETA DROPS', 1, 1, 4374, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(879, 1, '00879', 'GRAMETA TAB', 7, 1, 282, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(880, 1, '00880', 'GRANTUSIF TAB', 7, 1, 649, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(881, 1, '00881', 'GRAPERIDE TAB 100', 7, 1, 247, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(882, 1, '00882', 'GRAPRIMA F TAB', 7, 1, 397, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(883, 1, '00883', 'GRATHAZON TAB', 7, 1, 252, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(884, 1, '00884', 'GRATHEOS 50 MG @50', 7, 1, 502, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(885, 1, '00885', 'GRAZEO TAB 20 MG', 7, 1, 306, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(886, 1, '00886', 'GREEN CARE', 1, 1, 20400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(887, 1, '00887', 'GRISEOFULVIN TAB 125MG INF', 7, 1, 312, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(888, 1, '00888', 'GROWFAT CAP', 1, 1, 50050, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(889, 1, '00889', 'GUANISTREP SYR 60 ML', 1, 1, 4370, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(890, 1, '00890', 'GURAH ALBI DWS', 1, 1, 26450, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(891, 1, '00891', 'GURAH AS SYIFA @12', 1, 1, 14400, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(892, 1, '00892', 'H. KURMA AJWA 120 NHM', 1, 1, 18480, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(893, 1, '00893', 'H. KURMA AJWA 120 TKU', 1, 1, 33600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(894, 1, '00894', 'H. KURMA AJWA 210 NHM', 1, 1, 24948, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(895, 1, '00895', 'H. KURMA AJWA @100', 1, 1, 21850, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(896, 1, '00896', 'H. KURMA AJWA @100 TKU', 1, 1, 24000, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(897, 1, '00897', 'H. KURMA AJWA @120', 1, 1, 28250, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(898, 1, '00898', 'H.KURMA AJWA @210', 1, 1, 43700, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(899, 1, '00899', 'HABASYA OIL', 1, 1, 40700, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(900, 1, '00900', 'HABASYI OIL', 1, 1, 42550, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(901, 1, '00901', 'HABATUS SAUDANA 100', 1, 1, 17600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(902, 1, '00902', 'HABATUS SAUDANA 200', 1, 1, 42550, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(903, 1, '00903', 'HABBAFIT KIDS', 1, 1, 30510, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(904, 1, '00904', 'HALFILYN 100ML', 1, 1, 6875, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(905, 1, '00905', 'HALMEZINE SYR 100ML', 1, 1, 28188, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(906, 1, '00906', 'HANSAPLAST @100', 3, 1, 230, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(907, 1, '00907', 'HANSAPLAST JUMBO', 3, 1, 542, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(908, 1, '00908', 'HANSAPLAST KOYO HANGAT @10', 3, 1, 3955, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(909, 1, '00909', 'HANSAPLAST KOYO PANAS @10', 3, 1, 3955, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(910, 1, '00910', 'HANSAPLAST ROL 1,25X1 @20', 3, 1, 2990, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(911, 1, '00911', 'HANSAPLAST ROL 1,25X5 @10', 3, 1, 8450, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(912, 1, '00912', 'HANSAPLAST ROLL', 3, 1, 2405, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(913, 1, '00913', 'HANSAPLAST S. CARE @10', 8, 1, 385, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(914, 1, '00914', 'HANSAPLAST S. CARE JNR', 3, 1, 450, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(915, 1, '00915', 'HAPPYDENT BLIST 14GR', 8, 1, 2588, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(916, 1, '00916', 'HAU FUNG SAN', 8, 1, 2500, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(917, 1, '00917', 'HC SENSI GLOVES (L)', 3, 1, 740, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(918, 1, '00918', 'HC SENSI GLOVES (M) ECERAN', 3, 1, 780, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(919, 1, '00919', 'HC SENSI GLOVES (M) GROSIR', 9, 1, 46800, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(920, 1, '00920', 'HC SENSI GLOVES (S) ECERAN', 8, 1, 1140, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(921, 1, '00921', 'HC SENSI GLOVES (S) GROSIR', 8, 1, 45600, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(922, 1, '00922', 'HEMAVITON ACTION @5', 6, 1, 5335, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(923, 1, '00923', 'HEMAVITON C 1000 150ML', 1, 1, 4154, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(924, 1, '00924', 'HEMAVITON C 1000 @5', 3, 1, 1064, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(925, 1, '00925', 'HEMAVITON E DRINK 150 ML', 1, 1, 3640, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(926, 1, '00926', 'HEMAVITON SKIN N', 6, 1, 4715, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(927, 1, '00927', 'HEMAVITON STAMINA', 6, 1, 4974, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(928, 1, '00928', 'HEMORID KAPS', 10, 1, 747, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(929, 1, '00929', 'HEPATOSOL VAN 185GR', 8, 1, 69552, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(930, 1, '00930', 'HERBA JAWI', 1, 1, 25300, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(931, 1, '00931', 'HERBORIST SB SERE 160GR', 3, 1, 6611, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(932, 1, '00932', 'HERBORIST SR 80GR', 3, 1, 3996, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(933, 1, '00933', 'HERKUAT KAPS', 10, 1, 1604, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(934, 1, '00934', 'HEROCYN 150GR', 3, 1, 12036, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(935, 1, '00935', 'HEROCYN 75GR', 3, 1, 7876, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(936, 1, '00936', 'HEROCYN BABY 100GR', 1, 1, 4479, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(937, 1, '00937', 'HEXAVASK TAB 5MG', 7, 1, 2383, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(938, 1, '00938', 'HEXON SYR 60ML', 1, 1, 8476, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(939, 1, '00939', 'HEXOS MINT PERMENT', 3, 1, 1459, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(940, 1, '00940', 'HEXOS SUGAR FREE', 3, 1, 8159, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(941, 1, '00941', 'HI-LO ACT KH 200GR', 8, 1, 23760, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(942, 1, '00942', 'HI-LO ACT VAN 200GR', 8, 1, 23760, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(943, 1, '00943', 'HI-LO TEEN CHO 200GR', 8, 1, 22680, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(944, 1, '00944', 'HICO GEL CR 15GR', 5, 1, 14850, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(945, 1, '00945', 'HIGH ELASTIS B GC 10CM', 3, 1, 20700, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(946, 1, '00946', 'HIGH ELASTIS B GC 7,5CM', 3, 1, 8050, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(947, 1, '00947', 'HILO ACTIV 250GR CHO', 8, 1, 32157, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(948, 1, '00948', 'HILO KH 200 GR', 8, 1, 26799, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(949, 1, '00949', 'HILO TEEN 250GR CHO', 8, 1, 28512, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(950, 1, '00950', 'HILO VANILA 200 GR', 8, 1, 28512, NULL, 100, 1, '2020-10-02 10:29:11', NULL),
(951, 2, 'IF0101', 'VENTILATOR', 4, 1, 45000, NULL, 100, 1, '2020-10-02 14:51:28', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang_kategori`
--

CREATE TABLE `tbl_barang_kategori` (
  `id` bigint NOT NULL,
  `id_kelompok` bigint NOT NULL,
  `nama_kategori` varchar(100) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang_kategori`
--

INSERT INTO `tbl_barang_kategori` (`id`, `id_kelompok`, `nama_kategori`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 1, 'Obat Lainnya', 1, '2020-10-01 21:01:04', '2020-10-02 06:25:45'),
(2, 2, 'Alat Kesehatan Lainnya', 1, '2020-10-02 14:40:51', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang_kat_harga`
--

CREATE TABLE `tbl_barang_kat_harga` (
  `id` bigint NOT NULL,
  `nama_kategori_harga_brg` varchar(100) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang_kat_harga`
--

INSERT INTO `tbl_barang_kat_harga` (`id`, `nama_kategori_harga_brg`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'Generik', 1, '2020-10-01 08:58:46', NULL),
(2, 'Umum', 1, '2020-10-01 08:58:46', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang_kelompok`
--

CREATE TABLE `tbl_barang_kelompok` (
  `id` bigint NOT NULL,
  `nama_kelompok` varchar(100) NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_barang_kelompok`
--

INSERT INTO `tbl_barang_kelompok` (`id`, `nama_kelompok`, `keterangan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'Obat-obatan', NULL, 1, '2020-10-01 20:50:03', NULL),
(2, 'Alat Kesehatan', NULL, 1, '2020-10-01 20:50:16', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang_mutasi`
--

CREATE TABLE `tbl_barang_mutasi` (
  `id` bigint NOT NULL,
  `id_barang` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `qty` bigint NOT NULL,
  `keterangan` text NOT NULL,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang_mutasi`
--

INSERT INTO `tbl_barang_mutasi` (`id`, `id_barang`, `id_uic`, `qty`, `keterangan`, `tgl_input`) VALUES
(1, 45, 1, 3, 'PENGADAAN BARANG ', '2020-10-03 07:55:02'),
(2, 45, 1, 3, 'PENGADAAN BARANG ALERDEX TAB', '2020-10-03 07:57:06'),
(3, 45, 1, 3, 'PENGADAAN BARANG \"ALERDEX TAB\" DARI SUPPLIER \"Holi Pharmaceutical Industries, PT', '2020-10-03 07:58:19'),
(4, 35, 1, 3, 'PENGADAAN BARANG \"ALAT PEMANCUNG HIDUNG\" DARI SUPPLIER \"Holi Pharmaceutical Industries, PT\"', '2020-10-03 07:59:39'),
(6, 1, 1, 10, 'PENGADAAN BARANG \", nama_brg, \" DARI SUPPLIER \", nama_supp, \"', '2020-10-03 08:07:23'),
(7, 35, 1, 3, 'PENGADAAN BARANG \", nama_brg, \" DARI SUPPLIER \", nama_supp, \"', '2020-10-03 08:08:20'),
(8, 33, 1, 3, 'PENGADAAN BARANG AKURAT COMPACT DARI SUPPLIER Holi Pharmaceutical Industries, PT', '2020-10-03 08:11:26'),
(9, 2, 1, 3, 'PENGADAAN BARANG \'\'ABBOCATH 20\'\' DARI SUPPLIER \'\'Holi Pharmaceutical Industries, PT\'\'', '2020-10-03 08:12:10'),
(10, 2, 1, 14, 'PENGADAAN BARANG \'\'ABBOCATH 20\'\' DARI SUPPLIER \'\'Holi Pharmaceutical Industries, PT\'\'', '2020-10-03 08:12:22'),
(11, 631, 1, 3, 'PEMBELIAN \", nm_barang, \" SEJUMLAH 3 Pack', '2020-10-06 20:53:35'),
(12, 625, 1, -3, 'PEMBELIAN DR KANG ADULT DIAPERS @L2 SEJUMLAH 3 Pack', '2020-10-06 20:55:22'),
(13, 4, 1, -3, 'PEMBELIAN ACETON 60ML SEJUMLAH 3 Botol', '2020-10-06 21:19:41'),
(14, 951, 1, -2, 'PEMBELIAN VENTILATOR SEJUMLAH 2 Kosong', '2020-10-06 21:51:16'),
(15, 4, 1, -3, 'PEMBELIAN ACETON 60ML SEJUMLAH 3 Botol', '2020-10-06 21:52:06'),
(16, 6, 1, -3, 'PEMBELIAN ACITRAL TAB TEST SEJUMLAH 3 Strip', '2020-10-06 21:52:27'),
(17, 8, 1, -5, 'PEMBELIAN ACNOL 10ML SEJUMLAH 5 PCS', '2020-10-06 22:08:49'),
(18, 2, 1, -3, 'PEMBELIAN ABBOCATH 20 SEJUMLAH 3 PCS', '2020-10-08 08:01:08'),
(19, 2, 1, 2, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 2 PCS', '2020-10-08 08:12:46'),
(20, 2, 1, -1, 'PEMBELIAN ABBOCATH 20 SEJUMLAH -1 PCS', '2020-10-08 08:30:22'),
(21, 2, 1, 2, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 2 PCS', '2020-10-08 08:30:45'),
(22, 2, 1, -8, 'PEMBELIAN ABBOCATH 20 SEJUMLAH 8 PCS', '2020-10-08 08:31:41'),
(23, 2, 1, 8, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 8 PCS', '2020-10-08 08:31:59'),
(24, 2, 1, -1, 'PEMBELIAN ABBOCATH 20 SEJUMLAH 1 PCS', '2020-10-08 08:36:00'),
(25, 2, 1, -2, 'PEMBELIAN ABBOCATH 20 SEJUMLAH 2 PCS', '2020-10-08 08:36:50'),
(26, 2, 1, 2, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 2 PCS', '2020-10-08 08:37:10'),
(27, 4, 1, -3, 'PEMBELIAN ACETON 60ML SEJUMLAH 3 Botol', '2020-10-08 08:42:24'),
(28, 4, 1, 2, 'PENGEMBALIAN ACETON 60ML SEJUMLAH 2 Botol', '2020-10-08 08:42:43'),
(29, 4, 1, 1, 'PENGEMBALIAN ACETON 60ML SEJUMLAH 1 Botol', '2020-10-08 11:16:52'),
(30, 2, 1, 1, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 1 PCS', '2020-10-08 12:42:21'),
(31, 631, 1, 3, 'PENGEMBALIAN DR. P ADULT SPECIAL L2 SEJUMLAH 3 Pack', '2020-10-08 12:54:32'),
(32, 4, 1, 3, 'PENGEMBALIAN ACETON 60ML SEJUMLAH 3 Botol', '2020-10-08 12:54:43'),
(33, 4, 1, 3, 'PENGEMBALIAN ACETON 60ML SEJUMLAH 3 Botol', '2020-10-08 12:54:58');

--
-- Trigger `tbl_barang_mutasi`
--
DELIMITER $$
CREATE TRIGGER `tbl_mutasi_trigger` AFTER INSERT ON `tbl_barang_mutasi` FOR EACH ROW BEGIN
    DECLARE jml_skrng bigint;
   
   SELECT stok into jml_skrng from tbl_barang where tbl_barang.id = NEW.id_barang;
   
   SET jml_skrng = jml_skrng + NEW.qty;
   
   update tbl_barang
   set stok = jml_skrng
   where tbl_barang.id = NEW.id_barang;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang_pengadaan`
--

CREATE TABLE `tbl_barang_pengadaan` (
  `id` bigint NOT NULL,
  `no_faktur` varchar(100) NOT NULL,
  `id_supplier` bigint NOT NULL,
  `tanggal` date NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_barang_pengadaan`
--

INSERT INTO `tbl_barang_pengadaan` (`id`, `no_faktur`, `id_supplier`, `tanggal`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'FAKTUR/12/2020', 7, '2020-10-01', 1, '2020-10-02 00:00:00', NULL),
(2, 'FAKTUR/14/2020', 32, '2020-10-01', 1, '2020-10-02 20:47:05', NULL),
(3, 'FAKTUR/15/2020', 4, '2020-10-02', 1, '2020-10-02 21:13:03', NULL),
(5, 'FAKTUR/17/2020', 1, '2020-10-02', 1, '2020-10-02 22:40:43', NULL),
(6, 'FAKTUR/18/2020', 29, '2020-10-02', 1, '2020-10-02 22:42:54', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang_pengadaan_detail`
--

CREATE TABLE `tbl_barang_pengadaan_detail` (
  `id` bigint NOT NULL,
  `id_barang_pengadaan` bigint NOT NULL,
  `id_barang` bigint NOT NULL,
  `qty` bigint NOT NULL,
  `harga` bigint DEFAULT NULL,
  `keterangan` text,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_barang_pengadaan_detail`
--

INSERT INTO `tbl_barang_pengadaan_detail` (`id`, `id_barang_pengadaan`, `id_barang`, `qty`, `harga`, `keterangan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 3, 2, 3, 3475, NULL, 1, '2020-10-02 21:40:40', NULL),
(3, 5, 5, 3, NULL, 'Tdik', 1, '2020-10-02 22:42:35', NULL),
(4, 5, 213, 2, NULL, 'kela', 1, '2020-10-02 22:49:56', NULL),
(5, 5, 5, 2, NULL, '', 1, '2020-10-02 22:50:03', NULL),
(6, 3, 45, 3, NULL, NULL, 1, '2020-10-03 07:07:48', NULL),
(7, 3, 45, 3, NULL, NULL, 1, '2020-10-03 07:10:19', NULL),
(8, 3, 45, 3, NULL, NULL, 1, '2020-10-03 07:19:24', NULL),
(9, 3, 45, 3, NULL, NULL, 1, '2020-10-03 07:19:33', NULL),
(10, 3, 45, 3, NULL, NULL, 1, '2020-10-03 07:22:14', NULL),
(16, 3, 45, 3, NULL, NULL, 1, '2020-10-03 07:55:02', NULL),
(18, 3, 45, 3, NULL, NULL, 1, '2020-10-03 07:57:06', NULL),
(19, 2, 45, 3, NULL, NULL, 1, '2020-10-03 07:58:19', NULL),
(20, 2, 35, 3, NULL, NULL, 1, '2020-10-03 07:59:39', NULL),
(22, 1, 1, 10, NULL, NULL, 1, '2020-10-03 08:07:23', NULL),
(23, 2, 35, 3, NULL, NULL, 1, '2020-10-03 08:08:20', NULL),
(24, 2, 33, 3, NULL, NULL, 1, '2020-10-03 08:11:26', NULL),
(25, 2, 2, 3, NULL, NULL, 1, '2020-10-03 08:12:10', NULL),
(26, 2, 2, 14, NULL, NULL, 1, '2020-10-03 08:12:22', NULL);

--
-- Trigger `tbl_barang_pengadaan_detail`
--
DELIMITER $$
CREATE TRIGGER `barang_pengadaan_trigger` AFTER INSERT ON `tbl_barang_pengadaan_detail` FOR EACH ROW BEGIN
	DECLARE nama_supp varchar(100);
    DECLARE nama_brg varchar(100);
    DECLARE nama_stn varchar(100);
    DECLARE keterangan text;
    
   SELECT DISTINCT(nama_supplier) as supplier into nama_supp FROM `tbl_barang_pengadaan_detail`
join tbl_barang_pengadaan on tbl_barang_pengadaan.id = tbl_barang_pengadaan_detail.id_barang_pengadaan
join tbl_barang_supplier on tbl_barang_supplier.id = tbl_barang_pengadaan.id_supplier
    where tbl_barang_pengadaan_detail.id_barang_pengadaan = NEW.id_barang_pengadaan;
    
    select tbl_barang.nama_barang, tbl_barang_satuan.nama_satuan into nama_brg, nama_stn from tbl_barang join tbl_barang_satuan on tbl_barang_satuan.id = tbl_barang.id_satuan_barang where tbl_barang.id = NEW.id_barang;
    
    set keterangan = CONCAT("PENGADAAN BARANG ''", nama_brg, "'' DARI SUPPLIER ''", nama_supp, "''");
    
   INSERT INTO `tbl_barang_mutasi`(`id_barang`, `id_uic`, `qty`, `keterangan`) VALUES (NEW.id_barang, NEW.id_uic, NEW.qty, keterangan);

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang_satuan`
--

CREATE TABLE `tbl_barang_satuan` (
  `id` bigint NOT NULL,
  `nama_satuan` varchar(60) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang_satuan`
--

INSERT INTO `tbl_barang_satuan` (`id`, `nama_satuan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'Botol', 1, '2020-10-02 10:17:04', NULL),
(2, 'Ampul', 1, '2020-10-02 10:17:11', NULL),
(3, 'PCS', 1, '2020-10-02 10:17:18', NULL),
(4, 'Kosong', 1, '2020-10-02 10:17:41', NULL),
(5, 'Tube', 1, '2020-10-02 10:17:52', NULL),
(6, 'Strip', 1, '2020-10-02 10:18:40', NULL),
(7, 'Tablet', 1, '2020-10-02 10:18:53', NULL),
(8, 'Pack', 1, '2020-10-02 10:22:38', NULL),
(9, 'Box', 1, '2020-10-02 10:22:56', NULL),
(10, 'Caps', 1, '2020-10-02 10:23:03', NULL),
(11, 'Cap', 1, '2020-10-02 10:23:12', NULL),
(12, 'SCT', 1, '2020-10-02 10:23:21', NULL),
(13, 'Suppo', 1, '2020-10-02 10:23:30', NULL),
(14, 'POT', 1, '2020-10-02 10:23:37', NULL),
(15, 'Vial', 1, '2020-10-02 10:23:45', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang_supplier`
--

CREATE TABLE `tbl_barang_supplier` (
  `id` bigint NOT NULL,
  `kode_supplier` varchar(6) NOT NULL,
  `nama_supplier` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamat` text NOT NULL,
  `no_telpon` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang_supplier`
--

INSERT INTO `tbl_barang_supplier` (`id`, `kode_supplier`, `nama_supplier`, `alamat`, `no_telpon`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, '1', 'Afiat Pharmaceutical Industries, PT', 'Jl. Leuwigajah No. 110\nCimindi\nCimahi, JB 40522', 'T. 022-6613330\nF. 022-6613343', 1, '2020-10-01 08:58:48', NULL),
(2, '10', 'Ipha Laboratories, PT', 'Jl. Raya Batujajar\nDesa Laksanamekar\nPadalarang\nBandung, JB 40553', 'T. 022-6866056\nF. 022-6866057', 1, '2020-10-01 08:58:48', NULL),
(3, '11', 'Ipha Laboratories, PT', 'Jl. Gempol Wetan No. 215\nBandung, JB 40115', 'T. 022-4237930\nF. 022-4236621', 1, '2020-10-01 08:58:48', NULL),
(4, '12', 'Kimia Farma, PT', 'Jl. Cicendo No. 43\nBandung, JB 40173 ', 'T. 022-4204043\nF. 022-4237079', 1, '2020-10-01 08:58:48', NULL),
(5, '13', 'Kimia Farma, PT \nDivisi Riset & Pengembangan', 'Jl. Cihampelas No. 5\nBandung, JB 40171', 'T. 022- 441830 , 4206023\nF. 022-4206018', 1, '2020-10-01 08:58:48', NULL),
(6, '14', 'Lafi – Ditkesad', 'Jl. Gudang Utara No. 25 – 26\nBandung, JB 40113', 'T. 022-433219\nF. 022-4205408', 1, '2020-10-01 08:58:48', NULL),
(7, '15', 'Lembaga Farmasi Angkatan Udara “Roostiyan Effendie” ', 'Jl. Abdurachman Saleh\n Lanud Husein Sastranegara\nBandung, JB', ' ', 1, '2020-10-01 08:58:48', NULL),
(8, '16', 'Lucas Jaya, PT', 'Jl. Belitung No. 7\nBandung, JB', ' ', 1, '2020-10-01 08:58:48', NULL),
(9, '17', 'Marin Liza Farma, PT', 'Terusan Kiaracondong No. 43\nBandung, JB 40115', ' ', 1, '2020-10-01 08:58:48', NULL),
(10, '18', 'Medion,  PT', 'Jl. Babakan Ciparay No. 282\nBandung, JB 40223', 'T. 022-6030612\nF. 022-6015625', 1, '2020-10-01 08:58:48', NULL),
(11, '19', 'Meditrika Agung Indonesia, PT', 'Jl. Cihideung Balong No. 32\nTasikmalaya, JB', 'T./ F. 0265-331189', 1, '2020-10-01 08:58:48', NULL),
(12, '2', 'Biofarma, PT', ' Jl. Pasteur 28\nBandung, JB 40016\nPO Box 1136', 'T. 022-2033755\nF. 022-2041306', 1, '2020-10-01 08:58:48', NULL),
(13, '20', 'Meprofarm, PT', 'Jl. Sukarno Hatta 789\nBandung, JB 40294', 'T. 022-7805588\nF. 022-7805577', 1, '2020-10-01 08:58:48', NULL),
(14, '21', 'Otto Pharmaceutical Industries Ltd, PT', 'Jl. Dr. Setiabudhi Km 12.1\nBandung, JB 40391 ', 'T. 022-2786068, 2786137\nF. 022-2786818', 1, '2020-10-01 08:58:48', NULL),
(15, '22', 'Palvindra, PT', 'Jl. Wangsareja No. 3\nBandung, JB 40261 ', 'T. 022-345095', 1, '2020-10-01 08:58:48', NULL),
(16, '23', 'Rohto Laboratories Indonesia, PT', 'Jl. Raya Cimareme 203\nPadalarang, JB 40552', 'T. 022-6809742, 6807046\nF. 022-6808050', 1, '2020-10-01 08:58:48', NULL),
(17, '24', 'Sanbe Farma, PT', 'Jl. Industri I No. 9\n Desa Utama, Leuwigajah\nCimindi\nCimahi, JB 40552', 'T. 022-630036\nF. 022-630050', 1, '2020-10-01 08:58:48', NULL),
(18, '25', 'Sandoz Indonesia, PT', 'Jl. Raya Caringin 363\nPadalarang, JB 40553\nPOB Box 7074/BDKB Bandung 40262', 'T. 022-6866228\nF. 022-6866227', 1, '2020-10-01 08:58:48', NULL),
(19, '26', 'Seger Surya, PT', 'Jl. Soekarno Hatta No. 76\nBandung, JB', 'T. 022-220976', 1, '2020-10-01 08:58:48', NULL),
(20, '27', 'Sidola Pharmaceutical, PT', 'Jl. Purnawarman No. 52 RT 02/01\nTamansari\nBandung, JB 40116', 'T. 022-4205861\nF. 022-4232747', 1, '2020-10-01 08:58:48', NULL),
(21, '28', 'Solas Langgeng Sejahtera, PT', 'Jl. Industri Cimareme I/18\nPadalarang, JB 40553', 'T. / F. 022-6865831', 1, '2020-10-01 08:58:48', NULL),
(22, '29', 'Sumber Tanushu Farma, PT', 'Jl. Cihanjuang No. 28\nCimahi, JB 40153', 'T. 022-6634468\nF. 022-6652904', 1, '2020-10-01 08:58:48', NULL),
(23, '3', 'Cendo Pratama, PT', 'Jl. Moch. Toha Km 6.7\nCisirung, Palasari\nBandung, JB 40255 ', 'T. 022-503999, 505888\nF. 022-503997', 1, '2020-10-01 08:58:48', NULL),
(24, '30', 'Tanabe Indonesia, PT', 'Jl. Rumahsakit 104\nUjungberung\nBandung, JB 40612\nPO Box 24', 'T. 022-7800001\nF. 022-7800081', 1, '2020-10-01 08:58:48', NULL),
(25, '31', 'Trifa Raya Laboratories, PT', ' jl. Sukarno Hatta 219\nBojongloa\nBandung, JB 40223', ' ', 1, '2020-10-01 08:58:48', NULL),
(26, '32', 'Triman Pharmaceutical Industries, PT', ' jl. Peundeuy Km 1\nRancaekek\nBandung, JB\nd/a\nJl. Banten No. 6\nBandung', 'T. 022-7949361\nF. 022-7949361 ', 1, '2020-10-01 08:58:48', NULL),
(27, '4', 'Chandra Nusantara, PT', 'Jl. Terusan Kiaracondong No. 440\nBandung, JB', ' ', 1, '2020-10-01 08:58:48', NULL),
(28, '5', 'Combiphar,  PT', 'Jl. Raya Simpang 383\nPadalarang, JB 40553', 'T. 022-6809129\nF. 022-6809128', 1, '2020-10-01 08:58:48', NULL),
(29, '6', 'Delta Mulia Chemical Industries, PT', 'Jl. Leuwigajah No. 89A\nKel. Cigugur\nSimahi, JB 40522 ', 'T. 022-6031870\nF. 022-6038562 , bubar', 1, '2020-10-01 08:58:48', NULL),
(30, '7', 'Errita Pharmaceutical Industries, PT', 'Desa Bojongsalam RT 04 RW 07\nKec. Rancaekek\nKab. Bandung 40395\nPO Boxs No. 4/RCK/UJB ', 'T. 022-7949062\nF. 022-7949063', 1, '2020-10-01 08:58:48', NULL),
(31, '8', 'Gracia Pharmindo,  PT', 'Kawasan Industri Dwipapuri Blok M-30\nJl. Raya Rancaekek Km 24.5\nBandung, JB 45364', 'T. 022-7780033\nF. 022-7791045', 1, '2020-10-01 08:58:48', NULL),
(32, '9', 'Holi Pharmaceutical Industries, PT', 'Jl. Leuwigajah No. 100\nCimindi, JB 40522', ' ', 1, '2020-10-01 08:58:48', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_departemen`
--

CREATE TABLE `tbl_departemen` (
  `id` bigint NOT NULL,
  `nama_departemen` varchar(40) NOT NULL,
  `keterangan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_departemen`
--

INSERT INTO `tbl_departemen` (`id`, `nama_departemen`, `keterangan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'DEPARTEMEN 1', '', 1, '2020-10-01 19:01:41', NULL),
(2, 'KEAMANAN', '', 1, '2020-10-01 19:01:41', NULL),
(3, 'KEUANGAN', '', 1, '2020-10-01 19:01:41', NULL),
(4, 'APOTEK', '', 1, '2020-10-01 19:01:41', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_deposit_mutasi`
--

CREATE TABLE `tbl_deposit_mutasi` (
  `id` bigint NOT NULL,
  `no_rawat` varchar(18) NOT NULL,
  `id_uic` bigint DEFAULT NULL,
  `tanggal_mutasi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `keterangan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah_mutasi` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_diagnosa_penyakit`
--

CREATE TABLE `tbl_diagnosa_penyakit` (
  `id` bigint NOT NULL,
  `kode_diagnosa` varchar(6) NOT NULL,
  `nama_penyakit` varchar(50) NOT NULL,
  `ciri_ciri_penyakit` text NOT NULL,
  `keterangan` text NOT NULL,
  `ciri_ciri_umum` text NOT NULL,
  `id_uic` bigint DEFAULT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_dokter`
--

CREATE TABLE `tbl_dokter` (
  `id` bigint NOT NULL,
  `id_gol_darah` tinyint NOT NULL,
  `id_agama` smallint NOT NULL,
  `id_status_menikah` tinyint NOT NULL,
  `id_spesialis` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `id_alamat_kecamatan` bigint DEFAULT NULL,
  `id_alamat_kota` bigint DEFAULT NULL,
  `kode_dokter` varchar(100) NOT NULL,
  `no_identitas` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_jenis_kelamin` tinyint NOT NULL,
  `tempat_lahir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `nama_dokter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat` text NOT NULL,
  `no_telepon` varchar(25) NOT NULL,
  `no_izin_praktik` varchar(100) NOT NULL,
  `alumni` text NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_dokter`
--

INSERT INTO `tbl_dokter` (`id`, `id_gol_darah`, `id_agama`, `id_status_menikah`, `id_spesialis`, `id_uic`, `id_alamat_kecamatan`, `id_alamat_kota`, `kode_dokter`, `no_identitas`, `id_jenis_kelamin`, `tempat_lahir`, `tgl_lahir`, `nama_dokter`, `alamat`, `no_telepon`, `no_izin_praktik`, `alumni`, `tgl_input`, `tgl_edit`) VALUES
(1, 1, 1, 1, 11, 1, 1, 1, '1', '1', 1, 'Bandung', '1970-01-01', 'BURHAN, DR., SP.A.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(2, 1, 1, 1, 4, 1, 1, 1, '10', '1', 1, 'Bandung', '1970-01-01', 'AKHMAD IMRON, DR. DR., SP.BS (K)., M. KES', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(3, 1, 1, 1, 6, 1, 1, 1, '11', '1', 1, 'Bandung', '1970-01-01', 'IRZAN GUSTANTO NUGRAHA LUBIS, DR. SP.B.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(4, 1, 1, 1, 6, 1, 1, 1, '12', '1', 1, 'Bandung', '1970-01-01', 'CATUR SETYO DAMARIANTO, H. DR., SP. B.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(5, 1, 1, 1, 1, 1, 1, 1, '13', '1', 1, 'Bandung', '1970-01-01', 'TJAHJODJATI, DR., SP.B, (K) U', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(6, 1, 1, 1, 20, 1, 1, 1, '14', '1', 1, 'Bandung', '1970-01-01', 'DEWI ROSMALADEWI, DRG., SPKG', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(7, 1, 1, 1, 18, 1, 1, 1, '15', '1', 1, 'Bandung', '1970-01-01', 'RULIA, DRG.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(8, 1, 1, 1, 18, 1, 1, 1, '16', '1', 1, 'Bandung', '1970-01-01', 'TINI KARTINI DAHLAN, DRG.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(9, 1, 1, 1, 19, 1, 1, 1, '17', '1', 1, 'Bandung', '1970-01-01', 'RITA RATNASARI, DR., SP.GK', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(10, 1, 1, 1, 10, 1, 1, 1, '18', '1', 1, 'Bandung', '1970-01-01', 'FAJAR ASHARI, H. DR., SP. JP.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(11, 1, 1, 1, 10, 1, 1, 1, '19', '1', 1, 'Bandung', '1970-01-01', 'M. AGUS THOSIN H. A. T., H. DR., SP.JP.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(12, 1, 1, 1, 11, 1, 1, 1, '2', '1', 1, 'Bandung', '1970-01-01', 'DICKY SANTOSA, DR.,SP.A., MM., M.KES.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(13, 1, 1, 1, 10, 1, 1, 1, '20', '1', 1, 'Bandung', '1970-01-01', 'SUGIANTORO, DR., SP. JP.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(14, 1, 1, 1, 10, 1, 1, 1, '21', '1', 1, 'Bandung', '1970-01-01', 'WIDI NUGRAHA HADIAN, DR, SP.JP', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(15, 1, 1, 1, 21, 1, 1, 1, '22', '1', 1, 'Bandung', '1970-01-01', 'DELLE HELIANI AMALI, DR., SP.OG.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(16, 1, 1, 1, 21, 1, 1, 1, '23', '1', 1, 'Bandung', '1970-01-01', 'ANDI RINALDI, DR., SP.OG(K).', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(17, 1, 1, 1, 21, 1, 1, 1, '24', '1', 1, 'Bandung', '1970-01-01', 'DWIWAHJU DIAN INDAHWATI, DR., SP.OG.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(18, 1, 1, 1, 25, 1, 1, 1, '25', '1', 1, 'Bandung', '1970-01-01', 'MALI PAMUAJI W., H. DR.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(19, 1, 1, 1, 7, 1, 1, 1, '26', '1', 1, 'Bandung', '1970-01-01', 'WIDIATI, DR. , SP.KK', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(20, 1, 1, 1, 13, 1, 1, 1, '27', '1', 1, 'Bandung', '1970-01-01', 'RETNO DWIYANTI, DR., SP.M', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(21, 1, 1, 1, 26, 1, 1, 1, '28', '1', 1, 'Bandung', '1970-01-01', 'HILLDA HERAWATI, DRG., SP.ORT', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(22, 1, 1, 1, 24, 1, 1, 1, '29', '1', 1, 'Bandung', '1970-01-01', 'AZRIL HASAN, DR.,SP.P.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(23, 1, 1, 1, 11, 1, 1, 1, '3', '1', 1, 'Bandung', '1970-01-01', 'LIA MARLIA K., HJ. DR. SP. A.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(24, 1, 1, 1, 5, 1, 1, 1, '30', '1', 1, 'Bandung', '1970-01-01', 'EKA SURYA NUGRAHA, SP.PD', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(25, 1, 1, 1, 5, 1, 1, 1, '31', '1', 1, 'Bandung', '1970-01-01', 'IWAN S. MERTASUDIRA, DR. SP.PD', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(26, 1, 1, 1, 5, 1, 1, 1, '32', '1', 1, 'Bandung', '1970-01-01', 'MUHAMMAD IQBAL, H. DR.,SP.PD.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(27, 1, 1, 1, 5, 1, 1, 1, '33', '1', 1, 'Bandung', '1970-01-01', 'RADEN BENI BENARDI, DR., SPPD', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(28, 1, 1, 1, 5, 1, 1, 1, '34', '1', 1, 'Bandung', '1970-01-01', 'TULUS WIDIYANTO, DR., SP.PD.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(29, 1, 1, 1, 5, 1, 1, 1, '35', '1', 1, 'Bandung', '1970-01-01', 'HARSYA PRIYANGGA P NUGRAHA, DR., SPPD', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(30, 1, 1, 1, 29, 1, 1, 1, '36', '1', 1, 'Bandung', '1970-01-01', 'RHENI SAFIRA ISNAENI, DRG., SP.PROS', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(31, 1, 1, 1, 22, 1, 1, 1, '37', '1', 1, 'Bandung', '1970-01-01', 'UNTUNG SENTOSA, DR., SP. KJ.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(32, 1, 1, 1, 23, 1, 1, 1, '38', '1', 1, 'Bandung', '1970-01-01', 'SELLY MAHLIANI, DRA. PSI', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(33, 1, 1, 1, 4, 1, 1, 1, '39', '1', 1, 'Bandung', '1970-01-01', 'NURI AMALIA, HJ. DR., SP.S.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(34, 1, 1, 1, 11, 1, 1, 1, '4', '1', 1, 'Bandung', '1970-01-01', 'WEDI ISKANDAR, DR. SP.A.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(35, 1, 1, 1, 4, 1, 1, 1, '40', '1', 1, 'Bandung', '1970-01-01', 'ROSLAINI, DR., SP.S', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(36, 1, 1, 1, 15, 1, 1, 1, '41', '1', 1, 'Bandung', '1970-01-01', 'KOM POL PURWADI, DR., SP.THT-KL', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(37, 1, 1, 1, 11, 1, 1, 1, '42', '1', 1, 'Bandung', '1970-01-01', 'REBY KUSUMAJAYA, DR., SP.A(K), M.KES.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(38, 1, 1, 1, 6, 1, 1, 1, '43', '1', 1, 'Bandung', '1970-01-01', 'ABEL TASMAN YUZA, DRG., SP.BM', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(39, 1, 1, 1, 6, 1, 1, 1, '44', '1', 1, 'Bandung', '1970-01-01', 'ACHMAD ADAM, DR., SP.BS. (K)', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(40, 1, 1, 1, 6, 1, 1, 1, '45', '1', 1, 'Bandung', '1970-01-01', 'LIZA NURSANTY, DR., SP.B, M.KES, FINACS', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(41, 1, 1, 1, 1, 1, 1, 1, '46', '1', 1, 'Bandung', '1970-01-01', 'AHMAD AGIL, DR., SP.U', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(42, 1, 1, 1, 6, 1, 1, 1, '47', '1', 1, 'Bandung', '1970-01-01', 'BIDAN BKIA', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(43, 1, 1, 1, 18, 1, 1, 1, '48', '1', 1, 'Bandung', '1970-01-01', 'KUSHARI SUSANTO NB, DRG.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(44, 1, 1, 1, 10, 1, 1, 1, '49', '1', 1, 'Bandung', '1970-01-01', 'DENDI PUJI WAHYUDI, DR., SP.JP.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(45, 1, 1, 1, 11, 1, 1, 1, '5', '1', 1, 'Bandung', '1970-01-01', 'YENI ANDAYANI, HJ. DR. SP.A.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(46, 1, 1, 1, 10, 1, 1, 1, '50', '1', 1, 'Bandung', '1970-01-01', 'HARVI PUSPA WARDANI, DR., SP.JP.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(47, 1, 1, 1, 21, 1, 1, 1, '51', '1', 1, 'Bandung', '1970-01-01', 'ALI BUDI HARSONO, DR., SP.OG(K).', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(48, 1, 1, 1, 21, 1, 1, 1, '52', '1', 1, 'Bandung', '1970-01-01', 'ANNISA, DR., SP.OG.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(49, 1, 1, 1, 21, 1, 1, 1, '53', '1', 1, 'Bandung', '1970-01-01', 'ARIF TRIBAWONO, DR., SP.OG., M.KES.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(50, 1, 1, 1, 21, 1, 1, 1, '54', '1', 1, 'Bandung', '1970-01-01', 'INDAH MAHARANI, DR. SP.OG', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(51, 1, 1, 1, 25, 1, 1, 1, '55', '1', 1, 'Bandung', '1970-01-01', 'DICKY ROSYADI, DR.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(52, 1, 1, 1, 7, 1, 1, 1, '56', '1', 1, 'Bandung', '1970-01-01', 'ANDI FAUZIAH, DR., SP.KK', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(53, 1, 1, 1, 13, 1, 1, 1, '57', '1', 1, 'Bandung', '1970-01-01', 'GILANG MUTIARA, DR., SP. M', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(54, 1, 1, 1, 23, 1, 1, 1, '58', '1', 1, 'Bandung', '1970-01-01', 'KHAMSHA NOORY FINALISYA, , S.PSI, MPSI', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(55, 1, 1, 1, 17, 1, 1, 1, '59', '1', 1, 'Bandung', '1970-01-01', 'ABDILLA RIDHWAN IRIANTO, DR., SP.BP-RE.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(56, 1, 1, 1, 9, 1, 1, 1, '6', '1', 1, 'Bandung', '1970-01-01', 'DENY HERMANA, DR, SP.OT.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(57, 1, 1, 1, 6, 1, 1, 1, '60', '1', 1, 'Bandung', '1970-01-01', 'KIKI LUKMAN, DR., SP.B (K) BD.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(58, 1, 1, 1, 18, 1, 1, 1, '61', '1', 1, 'Bandung', '1970-01-01', 'R. GINANDJAR ASLAMA MAULID, DRG.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(59, 1, 1, 1, 18, 1, 1, 1, '62', '1', 1, 'Bandung', '1970-01-01', 'RINA JOEANDA, DRG.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(60, 1, 1, 1, 19, 1, 1, 1, '63', '1', 1, 'Bandung', '1970-01-01', 'GAGA IRAWAN,DR. DR., SP.GK, M.GIZI', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(61, 1, 1, 1, 19, 1, 1, 1, '64', '1', 1, 'Bandung', '1970-01-01', 'IKBAL GENTAR ALAM, DR. SP. GK. M.KES.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(62, 1, 1, 1, 10, 1, 1, 1, '65', '1', 1, 'Bandung', '1970-01-01', 'CHARLOTTE JOHANNA COOL, DR., SPJP, FIHA', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(63, 1, 1, 1, 10, 1, 1, 1, '66', '1', 1, 'Bandung', '1970-01-01', 'RATNA NURMELIANI, DR., SPJP', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(64, 1, 1, 1, 21, 1, 1, 1, '67', '1', 1, 'Bandung', '1970-01-01', 'HILMAN, DR., SP.OG', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(65, 1, 1, 1, 7, 1, 1, 1, '68', '1', 1, 'Bandung', '1970-01-01', 'IRMA JANTHY, DR., SP.KK', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(66, 1, 1, 1, 26, 1, 1, 1, '69', '1', 1, 'Bandung', '1970-01-01', 'YOURI ADRINATA SAYUTO, DRG., SP. ORT', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(67, 1, 1, 1, 3, 1, 1, 1, '7', '1', 1, 'Bandung', '1970-01-01', 'ARIF BUDIMAN, DR,. SP. B (K) A', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(68, 1, 1, 1, 5, 1, 1, 1, '70', '1', 1, 'Bandung', '1970-01-01', 'YANA AKHMAD, DR., DR., SP.PD (K).', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(69, 1, 1, 1, 28, 1, 1, 1, '71', '1', 1, 'Bandung', '1970-01-01', 'DEWI LIDYA ICHWANA, DRG., SP.PERIO', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(70, 1, 1, 1, 23, 1, 1, 1, '72', '1', 1, 'Bandung', '1970-01-01', 'SELLA FAUZIAH RAHMAH PERMATA', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(71, 1, 1, 1, 4, 1, 1, 1, '73', '1', 1, 'Bandung', '1970-01-01', 'DASWARA DJAJASASMITA, DR., SP.S', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(72, 1, 1, 1, 6, 1, 1, 1, '74', '1', 1, 'Bandung', '1970-01-01', 'DIPO KENTJONO, DRG., SP.BM', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(73, 1, 1, 1, 5, 1, 1, 1, '75', '1', 1, 'Bandung', '1970-01-01', 'RESNO HADIONO ADELA, DR., SP.PD.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(74, 1, 1, 1, 18, 1, 1, 1, '76', '1', 1, 'Bandung', '1970-01-01', 'ANNA NURWULAN, HJ. DRG.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(75, 1, 1, 1, 10, 1, 1, 1, '77', '1', 1, 'Bandung', '1970-01-01', 'APRILIANASARY UTAMI DEWI, DR., SP.JP.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(76, 1, 1, 1, 25, 1, 1, 1, '78', '1', 1, 'Bandung', '1970-01-01', 'MAHMUD MUHYIDDIN, DR', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(77, 1, 1, 1, 25, 1, 1, 1, '79', '1', 1, 'Bandung', '1970-01-01', 'WAHYU PITRA RAHAYU, DR.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(78, 1, 1, 1, 6, 1, 1, 1, '8', '1', 1, 'Bandung', '1970-01-01', 'SRI UTARI,DRG., SPBM', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(79, 1, 1, 1, 7, 1, 1, 1, '80', '1', 1, 'Bandung', '1970-01-01', 'MIRANTI PANGASTUTI, DR., SPKK', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(80, 1, 1, 1, 13, 1, 1, 1, '81', '1', 1, 'Bandung', '1970-01-01', 'ANDRIAFI SYAH, DR.,SP.M.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(81, 1, 1, 1, 26, 1, 1, 1, '82', '1', 1, 'Bandung', '1970-01-01', 'MOUNA YASMIEN, DRG., SP. ORT', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(82, 1, 1, 1, 27, 1, 1, 1, '83', '1', 1, 'Bandung', '1970-01-01', 'ASRI SATIVA, DRG., SP.KGA', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(83, 4, 1, 1, 6, 1, 1, 1, '84', '1', 1, 'Bandung', '1970-01-01', 'ACHMAD PETER SYARIEF, DR., SP.BTKV.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, '2020-10-02 15:41:45'),
(84, 1, 1, 1, 11, 1, 1, 1, '85', '1', 1, 'Bandung', '1970-01-01', 'NUR SURYAWAN, DR., SP.A.(K)', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(85, 1, 1, 1, 6, 1, 1, 1, '86', '1', 1, 'Bandung', '1970-01-01', 'BAMBANG A.S. SULTHANA, DR., SP.B (K) BD.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(86, 1, 1, 1, 20, 1, 1, 1, '87', '1', 1, 'Bandung', '1970-01-01', 'DIAN KARTINA, DRG., SP.KG', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(87, 1, 1, 1, 10, 1, 1, 1, '88', '1', 1, 'Bandung', '1970-01-01', 'M. RIZKI AKBAR, DR. DR.,SP.JP (K), M. KES', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(88, 1, 1, 1, 7, 1, 1, 1, '89', '1', 1, 'Bandung', '1970-01-01', 'OKI SUWARSA,DR.,DR., SPKK(K)., M. KES', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(89, 1, 1, 1, 9, 1, 1, 1, '9', '1', 1, 'Bandung', '1970-01-01', 'DADANG RUKANTA, H. DR., SP.OT.FICS., M.KES.', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(90, 1, 1, 1, 13, 1, 1, 1, '90', '1', 1, 'Bandung', '1970-01-01', 'R. ANGGA KARTIWA, DR., SP.M (K).,M.KES', 'Cibiru', '88872811129', '101', 'UIN Bandung', NULL, NULL),
(91, 4, 1, 1, 5, 1, 1, 1, '91', '1', 2, 'Bandung', '1970-01-01', 'AMELIA ANDRIANI, DR.,SP.PD.,M.KES', 'Cibiru', '88872811129', 'SPS/01/1992', 'UIN Bandung', NULL, '2020-10-02 16:58:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_dokter_jadwal`
--

CREATE TABLE `tbl_dokter_jadwal` (
  `id` bigint NOT NULL,
  `id_dokter` bigint NOT NULL,
  `id_poliklinik` int NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL,
  `hari` varchar(13) NOT NULL,
  `jam_mulai` time(6) NOT NULL,
  `jam_selesai` time(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_dokter_jadwal`
--

INSERT INTO `tbl_dokter_jadwal` (`id`, `id_dokter`, `id_poliklinik`, `id_uic`, `tgl_input`, `tgl_edit`, `hari`, `jam_mulai`, `jam_selesai`) VALUES
(6, 1, 1, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '07:30:00.000000', '09:00:00.000000'),
(7, 2, 1, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '14:00:00.000000', '16:00:00.000000'),
(8, 3, 1, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '08:00:00.000000', '10:00:00.000000'),
(9, 4, 1, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '07:50:00.000000', '10:00:00.000000'),
(10, 5, 1, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '12:00:00.000000'),
(11, 3, 1, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '11:00:00.000000', '13:00:00.000000'),
(12, 4, 2, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '12:00:00.000000'),
(13, 6, 3, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '08:00:00.000000', '10:00:00.000000'),
(14, 7, 4, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '15:00:00.000000', '16:00:00.000000'),
(15, 8, 5, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '11:00:00.000000'),
(16, 9, 6, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '12:00:00.000000'),
(17, 10, 7, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '16:00:00.000000', '17:00:00.000000'),
(18, 11, 8, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '08:00:00.000000', '10:00:00.000000'),
(19, 12, 9, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '12:00:00.000000'),
(20, 13, 10, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '14:00:00.000000', '16:00:00.000000'),
(21, 14, 11, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '12:00:00.000000'),
(22, 15, 12, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '12:00:00.000000'),
(23, 16, 12, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '12:00:00.000000'),
(24, 17, 13, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '12:00:00.000000'),
(25, 18, 14, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '12:00:00.000000'),
(26, 19, 14, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '15:30:00.000000', '16:00:00.000000'),
(27, 20, 14, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '15:00:00.000000'),
(28, 21, 14, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '12:00:00.000000'),
(29, 22, 15, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '14:00:00.000000', '15:00:00.000000'),
(30, 23, 16, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '15:00:00.000000', '16:30:00.000000'),
(31, 22, 16, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '12:00:00.000000'),
(32, 24, 16, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '15:00:00.000000', '17:00:00.000000'),
(33, 25, 17, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '12:00:00.000000'),
(34, 26, 18, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '12:00:00.000000'),
(35, 27, 19, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '14:00:00.000000', '16:00:00.000000'),
(36, 28, 20, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '12:30:00.000000', '14:00:00.000000'),
(37, 29, 21, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '12:00:00.000000'),
(38, 30, 22, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '17:00:00.000000', '18:00:00.000000'),
(39, 31, 22, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '12:00:00.000000', '15:00:00.000000'),
(40, 32, 22, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '11:00:00.000000', '13:00:00.000000'),
(41, 33, 22, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '14:30:00.000000', '16:00:00.000000'),
(42, 34, 22, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '14:00:00.000000', '15:00:00.000000'),
(43, 34, 23, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '13:00:00.000000'),
(44, 35, 24, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '08:00:00.000000', '10:00:00.000000'),
(45, 31, 24, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '12:00:00.000000'),
(46, 32, 24, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '11:00:00.000000'),
(47, 34, 24, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '14:00:00.000000', '16:00:00.000000'),
(48, 36, 25, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '13:00:00.000000', '14:00:00.000000'),
(49, 37, 26, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '08:00:00.000000', '14:00:00.000000'),
(50, 38, 27, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '10:00:00.000000', '12:00:00.000000'),
(51, 39, 28, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '08:00:00.000000', '11:00:00.000000'),
(52, 40, 28, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '11:00:00.000000', '14:00:00.000000'),
(53, 39, 29, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '11:00:00.000000', '13:00:00.000000'),
(54, 40, 29, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '09:00:00.000000', '11:00:00.000000'),
(55, 41, 30, 1, '2020-10-02 19:00:01', NULL, 'SENIN', '16:00:00.000000', '17:00:00.000000'),
(56, 25, 31, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '14:00:00.000000', '15:00:00.000000'),
(57, 1, 1, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '07:30:00.000000', '09:00:00.000000'),
(58, 42, 1, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '15:00:00.000000', '16:00:00.000000'),
(59, 4, 1, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '09:00:00.000000', '12:00:00.000000'),
(60, 5, 1, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '08:00:00.000000', '10:00:00.000000'),
(61, 3, 1, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '11:00:00.000000', '13:00:00.000000'),
(62, 3, 2, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(63, 9, 3, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(64, 43, 5, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '11:00:00.000000', '13:00:00.000000'),
(65, 6, 6, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '08:00:00.000000', '10:00:00.000000'),
(66, 44, 7, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '17:00:00.000000', '17:30:00.000000'),
(67, 12, 8, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(68, 45, 9, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(69, 46, 10, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '09:00:00.000000', '12:00:00.000000'),
(70, 47, 32, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(71, 14, 11, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '09:00:00.000000', '12:00:00.000000'),
(72, 48, 12, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '09:00:00.000000', '12:00:00.000000'),
(73, 15, 12, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '09:00:00.000000', '12:00:00.000000'),
(74, 17, 13, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(75, 49, 14, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '14:00:00.000000', '16:00:00.000000'),
(76, 18, 14, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '09:00:00.000000', '12:00:00.000000'),
(77, 50, 14, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '08:00:00.000000', '10:30:00.000000'),
(78, 19, 14, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '15:30:00.000000', '16:00:00.000000'),
(79, 20, 14, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:30:00.000000'),
(80, 51, 15, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '16:30:00.000000', '17:00:00.000000'),
(81, 52, 15, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '12:00:00.000000', '13:00:00.000000'),
(82, 53, 15, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '16:30:00.000000', '17:00:00.000000'),
(83, 51, 16, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '16:00:00.000000', '16:30:00.000000'),
(84, 52, 16, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '09:00:00.000000', '12:00:00.000000'),
(85, 53, 16, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '15:00:00.000000', '16:30:00.000000'),
(86, 54, 16, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '13:00:00.000000', '15:00:00.000000'),
(87, 55, 17, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(88, 56, 18, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(89, 57, 19, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(90, 29, 21, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(91, 35, 22, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '07:30:00.000000', '09:00:00.000000'),
(92, 31, 22, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '12:00:00.000000', '15:00:00.000000'),
(93, 34, 23, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(94, 31, 24, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(95, 32, 24, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '07:30:00.000000', '09:00:00.000000'),
(96, 34, 24, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '08:30:00.000000', '10:00:00.000000'),
(97, 44, 33, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '16:00:00.000000', '17:00:00.000000'),
(98, 37, 26, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '08:00:00.000000', '14:00:00.000000'),
(99, 58, 27, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '10:00:00.000000', '12:00:00.000000'),
(100, 39, 28, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '08:00:00.000000', '11:00:00.000000'),
(101, 40, 28, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '11:00:00.000000', '14:00:00.000000'),
(102, 39, 29, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '11:00:00.000000', '13:00:00.000000'),
(103, 40, 29, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '09:00:00.000000', '11:00:00.000000'),
(104, 41, 30, 1, '2020-10-02 19:00:01', NULL, 'SELASA', '16:00:00.000000', '17:00:00.000000'),
(105, 59, 34, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(106, 13, 35, 1, '2020-10-02 19:00:01', NULL, 'RABU', '14:00:00.000000', '15:00:00.000000'),
(107, 2, 1, 1, '2020-10-02 19:00:01', NULL, 'RABU', '14:00:00.000000', '16:00:00.000000'),
(108, 3, 1, 1, '2020-10-02 19:00:01', NULL, 'RABU', '07:30:00.000000', '09:00:00.000000'),
(109, 4, 1, 1, '2020-10-02 19:00:01', NULL, 'RABU', '08:00:00.000000', '10:00:00.000000'),
(110, 5, 1, 1, '2020-10-02 19:00:01', NULL, 'RABU', '07:59:00.000000', '10:00:00.000000'),
(111, 1, 1, 1, '2020-10-02 19:00:01', NULL, 'RABU', '11:00:00.000000', '13:00:00.000000'),
(112, 5, 2, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(113, 6, 3, 1, '2020-10-02 19:00:01', NULL, 'RABU', '08:00:00.000000', '10:00:00.000000'),
(114, 7, 4, 1, '2020-10-02 19:00:01', NULL, 'RABU', '15:00:00.000000', '16:00:00.000000'),
(115, 60, 36, 1, '2020-10-02 19:00:01', NULL, 'RABU', '15:00:00.000000', '16:00:00.000000'),
(116, 9, 6, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(117, 59, 37, 1, '2020-10-02 19:00:01', NULL, 'RABU', '13:00:00.000000', '14:00:00.000000'),
(118, 45, 8, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(119, 11, 9, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(120, 61, 12, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '12:00:00.000000'),
(121, 62, 12, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '12:00:00.000000'),
(122, 63, 13, 1, '2020-10-02 19:00:01', NULL, 'RABU', '14:00:00.000000', '16:00:00.000000'),
(123, 64, 13, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '12:00:00.000000'),
(124, 65, 14, 1, '2020-10-02 19:00:01', NULL, 'RABU', '12:00:00.000000', '14:00:00.000000'),
(125, 18, 14, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '12:00:00.000000'),
(126, 50, 14, 1, '2020-10-02 19:00:01', NULL, 'RABU', '14:00:00.000000', '17:00:00.000000'),
(127, 66, 14, 1, '2020-10-02 19:00:01', NULL, 'RABU', '08:00:00.000000', '12:00:00.000000'),
(128, 21, 14, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '12:00:00.000000'),
(129, 22, 15, 1, '2020-10-02 19:00:01', NULL, 'RABU', '14:00:00.000000', '15:00:00.000000'),
(130, 67, 15, 1, '2020-10-02 19:00:01', NULL, 'RABU', '16:30:00.000000', '17:00:00.000000'),
(131, 22, 16, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '12:00:00.000000'),
(132, 67, 16, 1, '2020-10-02 19:00:01', NULL, 'RABU', '15:00:00.000000', '16:30:00.000000'),
(133, 25, 17, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(134, 68, 18, 1, '2020-10-02 19:00:01', NULL, 'RABU', '13:00:00.000000', '14:00:00.000000'),
(135, 26, 18, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '10:30:00.000000'),
(136, 57, 19, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(137, 69, 20, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '12:00:00.000000'),
(138, 29, 21, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(139, 30, 22, 1, '2020-10-02 19:00:01', NULL, 'RABU', '17:00:00.000000', '18:00:00.000000'),
(140, 32, 22, 1, '2020-10-02 19:00:01', NULL, 'RABU', '11:00:00.000000', '13:00:00.000000'),
(141, 34, 22, 1, '2020-10-02 19:00:01', NULL, 'RABU', '08:00:00.000000', '10:00:00.000000'),
(142, 70, 22, 1, '2020-10-02 19:00:01', NULL, 'RABU', '17:00:00.000000', '18:00:00.000000'),
(143, 34, 23, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '13:00:00.000000'),
(144, 32, 24, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '11:00:00.000000'),
(145, 33, 24, 1, '2020-10-02 19:00:01', NULL, 'RABU', '14:30:00.000000', '16:00:00.000000'),
(146, 71, 38, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '12:00:00.000000'),
(147, 37, 26, 1, '2020-10-02 19:00:01', NULL, 'RABU', '08:00:00.000000', '14:00:00.000000'),
(148, 72, 27, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(149, 38, 27, 1, '2020-10-02 19:00:01', NULL, 'RABU', '10:00:00.000000', '12:00:00.000000'),
(150, 73, 28, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '13:00:00.000000'),
(151, 39, 29, 1, '2020-10-02 19:00:01', NULL, 'RABU', '09:00:00.000000', '11:00:00.000000'),
(152, 40, 29, 1, '2020-10-02 19:00:01', NULL, 'RABU', '11:00:00.000000', '13:00:00.000000'),
(153, 41, 30, 1, '2020-10-02 19:00:01', NULL, 'RABU', '16:00:00.000000', '17:00:00.000000'),
(154, 3, 1, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '07:30:00.000000', '09:00:00.000000'),
(155, 42, 1, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '15:00:00.000000', '16:00:00.000000'),
(156, 4, 1, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '09:00:00.000000', '12:00:00.000000'),
(157, 5, 1, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '08:00:00.000000', '10:00:00.000000'),
(158, 3, 1, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '11:00:00.000000', '13:00:00.000000'),
(159, 1, 2, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(160, 6, 3, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '08:00:00.000000', '10:00:00.000000'),
(161, 74, 5, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(162, 9, 6, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(163, 11, 8, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '08:00:00.000000', '10:00:00.000000'),
(164, 12, 9, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(165, 46, 10, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '09:00:00.000000', '12:00:00.000000'),
(166, 62, 12, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '09:00:00.000000', '12:00:00.000000'),
(167, 17, 13, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(168, 18, 14, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '09:00:00.000000', '12:00:00.000000'),
(169, 50, 14, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '14:00:00.000000', '17:00:00.000000'),
(170, 19, 14, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '15:30:00.000000', '16:00:00.000000'),
(171, 20, 14, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(172, 51, 15, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '16:30:00.000000', '17:00:00.000000'),
(173, 52, 15, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '12:00:00.000000', '13:00:00.000000'),
(174, 51, 16, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '16:00:00.000000', '16:30:00.000000'),
(175, 23, 16, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '15:00:00.000000', '16:30:00.000000'),
(176, 52, 16, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '09:00:00.000000', '12:00:00.000000'),
(177, 55, 17, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(178, 56, 18, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '14:00:00.000000', '15:00:00.000000'),
(179, 26, 18, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(180, 57, 19, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(181, 28, 20, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '12:30:00.000000', '14:00:00.000000'),
(182, 29, 21, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(183, 35, 22, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '08:00:00.000000', '10:00:00.000000'),
(184, 31, 22, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '12:00:00.000000', '15:00:00.000000'),
(185, 32, 22, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '11:00:00.000000', '13:00:00.000000'),
(186, 75, 22, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '08:00:00.000000', '12:00:00.000000'),
(187, 31, 24, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(188, 32, 24, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '09:00:00.000000', '11:00:00.000000'),
(189, 34, 24, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '08:30:00.000000', '10:00:00.000000'),
(190, 36, 25, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '13:00:00.000000', '14:00:00.000000'),
(191, 37, 26, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '08:00:00.000000', '14:00:00.000000'),
(192, 72, 27, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '10:00:00.000000', '12:00:00.000000'),
(193, 73, 28, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '09:00:00.000000', '11:00:00.000000'),
(194, 39, 28, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '08:00:00.000000', '11:00:00.000000'),
(195, 40, 28, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '11:00:00.000000', '14:00:00.000000'),
(196, 39, 29, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '11:00:00.000000', '13:00:00.000000'),
(197, 40, 29, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '09:00:00.000000', '11:00:00.000000'),
(198, 41, 30, 1, '2020-10-02 19:00:01', NULL, 'KAMIS', '16:00:00.000000', '17:00:00.000000'),
(199, 1, 1, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '08:00:00.000000', '10:00:00.000000'),
(200, 2, 1, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '14:00:00.000000', '16:00:00.000000'),
(201, 4, 1, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '08:00:00.000000', '11:00:00.000000'),
(202, 5, 1, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '12:00:00.000000'),
(203, 1, 1, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '11:00:00.000000', '13:00:00.000000'),
(204, 2, 2, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '13:00:00.000000', '15:00:00.000000'),
(205, 3, 2, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '12:00:00.000000'),
(206, 9, 3, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '12:00:00.000000'),
(207, 7, 4, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '15:00:00.000000', '16:00:00.000000'),
(208, 6, 6, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '08:00:00.000000', '10:00:00.000000'),
(209, 12, 8, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '12:00:00.000000'),
(210, 45, 9, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '12:00:00.000000'),
(211, 13, 10, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '14:00:00.000000', '15:00:00.000000'),
(212, 76, 12, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '12:00:00.000000'),
(213, 48, 12, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '12:00:00.000000'),
(214, 16, 12, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '12:00:00.000000'),
(215, 64, 13, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '12:00:00.000000'),
(216, 77, 14, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '11:30:00.000000'),
(217, 18, 14, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '08:00:00.000000', '11:00:00.000000'),
(218, 66, 14, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '14:00:00.000000', '16:00:00.000000'),
(219, 20, 14, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '15:00:00.000000'),
(220, 21, 14, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '13:00:00.000000', '15:00:00.000000'),
(221, 24, 15, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '16:00:00.000000', '17:00:00.000000'),
(222, 54, 15, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '12:00:00.000000', '13:00:00.000000'),
(223, 24, 16, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '13:00:00.000000', '16:00:00.000000'),
(224, 67, 16, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '16:00:00.000000', '17:00:00.000000'),
(225, 54, 16, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '12:00:00.000000'),
(226, 78, 17, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '12:00:00.000000'),
(227, 25, 17, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '12:00:00.000000'),
(228, 79, 17, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '12:00:00.000000'),
(229, 80, 18, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '13:00:00.000000', '15:00:00.000000'),
(230, 26, 18, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '10:30:00.000000'),
(231, 81, 19, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '14:00:00.000000', '16:00:00.000000'),
(232, 82, 20, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '13:00:00.000000', '14:00:00.000000'),
(233, 29, 21, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:30:00.000000', '11:00:00.000000'),
(234, 83, 39, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '12:00:00.000000'),
(235, 31, 22, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '12:00:00.000000', '15:00:00.000000'),
(236, 32, 22, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '11:00:00.000000', '13:00:00.000000'),
(237, 33, 22, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '14:30:00.000000', '16:00:00.000000'),
(238, 34, 23, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '13:00:00.000000'),
(239, 31, 24, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '12:00:00.000000'),
(240, 32, 24, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '11:00:00.000000'),
(241, 34, 24, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '14:00:00.000000', '16:00:00.000000'),
(242, 37, 26, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '08:00:00.000000', '14:00:00.000000'),
(243, 58, 27, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '10:00:00.000000', '12:00:00.000000'),
(244, 73, 28, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '11:00:00.000000'),
(245, 39, 28, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '08:00:00.000000', '11:00:00.000000'),
(246, 40, 28, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '11:00:00.000000', '14:00:00.000000'),
(247, 39, 29, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '11:00:00.000000', '13:00:00.000000'),
(248, 40, 29, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '09:00:00.000000', '11:00:00.000000'),
(249, 41, 30, 1, '2020-10-02 19:00:01', NULL, 'JUMAT', '16:00:00.000000', '17:00:00.000000'),
(250, 59, 34, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '08:00:00.000000', '10:00:00.000000'),
(251, 84, 40, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '10:00:00.000000'),
(252, 3, 1, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '07:30:00.000000', '09:00:00.000000'),
(253, 85, 1, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '12:00:00.000000'),
(254, 4, 1, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '08:59:00.000000', '11:00:00.000000'),
(255, 5, 1, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '12:00:00.000000'),
(256, 1, 1, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '10:00:00.000000', '12:00:00.000000'),
(257, 1, 2, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '10:00:00.000000', '12:00:00.000000'),
(258, 86, 36, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '13:00:00.000000', '14:00:00.000000'),
(259, 43, 5, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '08:00:00.000000', '11:00:00.000000'),
(260, 84, 41, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '10:00:00.000000', '12:00:00.000000'),
(261, 45, 8, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '08:30:00.000000', '10:00:00.000000'),
(262, 11, 9, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '10:00:00.000000', '12:00:00.000000'),
(263, 46, 10, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '12:00:00.000000'),
(264, 47, 32, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '10:00:00.000000', '12:00:00.000000'),
(265, 87, 11, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '10:00:00.000000', '13:00:00.000000'),
(266, 76, 12, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '12:00:00.000000'),
(267, 61, 12, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '12:00:00.000000'),
(268, 63, 13, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '13:00:00.000000', '14:00:00.000000'),
(269, 49, 14, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '11:00:00.000000'),
(270, 88, 14, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '08:00:00.000000', '10:00:00.000000'),
(271, 21, 14, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '12:00:00.000000'),
(272, 18, 42, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '08:00:00.000000', '09:00:00.000000'),
(273, 54, 15, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '12:00:00.000000', '13:00:00.000000'),
(274, 53, 16, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '13:00:00.000000', '15:00:00.000000'),
(275, 54, 16, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '12:00:00.000000'),
(276, 79, 17, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '10:00:00.000000', '12:00:00.000000'),
(277, 56, 18, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '11:30:00.000000'),
(278, 89, 18, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '13:00:00.000000', '14:00:00.000000'),
(279, 90, 19, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '14:00:00.000000', '15:00:00.000000'),
(280, 27, 19, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '10:00:00.000000', '12:00:00.000000'),
(281, 69, 20, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '12:00:00.000000'),
(282, 91, 22, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '08:00:00.000000', '10:00:00.000000'),
(283, 70, 22, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '11:00:00.000000', '13:00:00.000000'),
(284, 30, 24, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '08:00:00.000000', '11:00:00.000000'),
(285, 70, 24, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '11:00:00.000000'),
(286, 37, 26, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '08:00:00.000000', '12:00:00.000000'),
(287, 38, 27, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '10:00:00.000000', '12:00:00.000000'),
(288, 73, 28, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '09:00:00.000000', '11:00:00.000000'),
(289, 73, 29, 1, '2020-10-02 19:00:01', NULL, 'SABTU', '11:00:00.000000', '12:00:00.000000');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_dokter_spesialis`
--

CREATE TABLE `tbl_dokter_spesialis` (
  `id` bigint NOT NULL,
  `nama_spesialis` varchar(40) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_dokter_spesialis`
--

INSERT INTO `tbl_dokter_spesialis` (`id`, `nama_spesialis`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'UROLOGI', 1, '2020-10-01 18:52:34', NULL),
(2, 'RADIOLOGI', 1, '2020-10-01 18:52:34', NULL),
(3, 'BEDAH ANAK', 1, '2020-10-01 18:52:34', NULL),
(4, 'BEDAH SYARAF', 1, '2020-10-01 18:52:34', NULL),
(5, 'PENYAKIT DALAM', 1, '2020-10-01 18:52:34', NULL),
(6, 'BEDAH UMUM', 1, '2020-10-01 18:52:34', NULL),
(7, 'KULIT DAN KELAMIN', 1, '2020-10-01 18:52:34', NULL),
(8, 'REHAB MEDIK DAN FISIK', 1, '2020-10-01 18:52:34', NULL),
(9, 'ORTHOPEDI DAN TRAUMATOLOGI', 1, '2020-10-01 18:52:34', NULL),
(10, 'JANTUNG DAN PEMBULUH DARAH', 1, '2020-10-01 18:52:34', NULL),
(11, 'ANAK', 1, '2020-10-01 18:52:34', NULL),
(12, 'OBGIEN', 1, '2020-10-01 18:52:34', NULL),
(13, 'MATA', 1, '2020-10-01 18:52:34', NULL),
(14, 'ANDROLOGI', 1, '2020-10-01 18:52:34', NULL),
(15, 'THT', 1, '2020-10-01 18:52:34', NULL),
(16, 'SYARAF', 1, '2020-10-01 18:52:34', NULL),
(17, 'BEDAH PLASTIK', 1, '2020-10-01 18:52:34', NULL),
(18, 'GIGI', 1, '2020-10-01 18:52:34', NULL),
(19, 'GIZI', 1, '2020-10-01 18:52:34', NULL),
(20, 'ENDODONTI', 1, '2020-10-01 18:52:34', NULL),
(21, 'KANDUNGAN', 1, '2020-10-01 18:52:34', NULL),
(22, 'PSIKIATRI', 1, '2020-10-01 18:52:34', NULL),
(23, 'PSIKOLOGI', 1, '2020-10-01 18:52:34', NULL),
(24, 'PARU', 1, '2020-10-01 18:52:34', NULL),
(25, 'KHITAN', 1, '2020-10-01 18:52:34', NULL),
(26, 'ORTODONTI', 1, '2020-10-01 18:52:34', NULL),
(27, 'PEDODONTI', 1, '2020-10-01 18:52:34', NULL),
(28, 'PERIODONTI', 1, '2020-10-01 18:52:34', NULL),
(29, 'PROSTODONTI', 1, '2020-10-01 18:52:34', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_gol_darah`
--

CREATE TABLE `tbl_gol_darah` (
  `id` tinyint NOT NULL,
  `nama_gol_darah` varchar(10) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_gol_darah`
--

INSERT INTO `tbl_gol_darah` (`id`, `nama_gol_darah`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'A', 1, '2020-10-01 08:58:44', NULL),
(2, 'B', 1, '2020-10-01 08:58:44', NULL),
(3, 'AB', 1, '2020-10-01 08:58:44', NULL),
(4, 'O', 1, '2020-10-01 08:58:44', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jabatan`
--

CREATE TABLE `tbl_jabatan` (
  `id` bigint NOT NULL,
  `nama_jabatan` varchar(30) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jabatan`
--

INSERT INTO `tbl_jabatan` (`id`, `nama_jabatan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'JABATAN 1', 1, '2020-10-01 18:31:31', NULL),
(2, 'JABATAN 2', 1, '2020-10-01 18:31:31', NULL),
(3, 'PENGANGGUNG JAWAB LAB', 1, '2020-10-01 18:31:31', NULL),
(4, 'KARYAWAN KEUANGAN', 1, '2020-10-01 18:31:31', NULL),
(5, 'APOTEKER', 1, '2020-10-01 18:31:31', '2020-10-01 18:34:57');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jenis_bayar`
--

CREATE TABLE `tbl_jenis_bayar` (
  `id` bigint NOT NULL,
  `jenis_bayar` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jenis_bayar`
--

INSERT INTO `tbl_jenis_bayar` (`id`, `jenis_bayar`) VALUES
(1, 'DANA PRIBADI'),
(2, 'BPJS');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jenis_kelamin`
--

CREATE TABLE `tbl_jenis_kelamin` (
  `id` tinyint NOT NULL,
  `kode_jk` varchar(10) NOT NULL,
  `nama_jk` varchar(50) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_jenis_kelamin`
--

INSERT INTO `tbl_jenis_kelamin` (`id`, `kode_jk`, `nama_jk`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'L', 'Laki-laki', 1, '2020-10-02 15:07:20', NULL),
(2, 'P', 'Perempuan', 1, '2020-10-02 15:07:20', NULL),
(3, 'T', 'Tidak ingin menyebutkan', 1, '2020-10-02 15:07:20', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jenjang`
--

CREATE TABLE `tbl_jenjang` (
  `id` bigint NOT NULL,
  `kode_jenjang` varchar(10) NOT NULL,
  `nama_jenjang` varchar(40) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jenjang`
--

INSERT INTO `tbl_jenjang` (`id`, `kode_jenjang`, `nama_jenjang`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'J01', 'ESELON I', 1, '2020-10-01 18:20:35', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jenjang_pendidikan`
--

CREATE TABLE `tbl_jenjang_pendidikan` (
  `id` bigint NOT NULL,
  `jenjang_pendidikan` varchar(20) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jenjang_pendidikan`
--

INSERT INTO `tbl_jenjang_pendidikan` (`id`, `jenjang_pendidikan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'S1', 1, '2020-10-02 17:54:07', NULL),
(2, 'S2', 1, '2020-10-02 17:54:07', NULL),
(3, 'D3', 1, '2020-10-02 17:54:07', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_menu`
--

CREATE TABLE `tbl_menu` (
  `id` bigint NOT NULL,
  `title` varchar(50) NOT NULL,
  `url` varchar(30) NOT NULL,
  `icon` varchar(30) NOT NULL,
  `is_main_menu` int NOT NULL,
  `is_aktif` enum('y','n') NOT NULL COMMENT 'y=yes,n=no',
  `tabel` varchar(50) DEFAULT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_menu`
--

INSERT INTO `tbl_menu` (`id`, `title`, `url`, `icon`, `is_main_menu`, `is_aktif`, `tabel`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'KELOLA MENU (BERES)', 'kelolamenu', 'fa fa-server', 0, 'y', 'tbl_menu', 1, '2020-10-01 17:39:36', '2020-10-01 18:00:10'),
(2, 'KELOLA PENGGUNA (BERES)', 'user', 'fa fa-users', 0, 'y', 'tbl_user', 1, '2020-10-01 17:39:36', '2020-10-01 18:29:16'),
(4, 'FORM PENDAFTARAN (BERES)', 'pendaftaran/create', 'fa fa-receipt', 0, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-06 08:44:41'),
(5, 'DATA MASTER', '#', 'fa fa-id-card', 0, 'n', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 07:08:15'),
(6, 'DATA JENJANG (BERES)', 'jenjang', 'fa fa-chart-area', 5, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 18:28:13'),
(7, 'DATA JABATAN (BERES)', 'jabatan', 'fa fa-briefcase', 5, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 18:35:30'),
(8, 'DATA POLIKLINIK (BERES)', 'poliklinik', 'fa fa-university', 5, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 18:45:00'),
(9, 'DATA SPESIALIS (BERES)', 'spesialis', 'fa fa-heartbeat', 5, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 18:54:12'),
(10, 'DATA DEPARTEMEN (BERES)', 'departemen', 'fa fa-building', 5, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 19:06:08'),
(11, 'DATA BIDANG PEGAWAI (BERES)', 'bidang', 'fa fa-binoculars', 5, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 19:19:35'),
(12, 'NOMOR ANTREAN', 'antrean', 'fa fa-people-arrows', 0, 'n', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 21:11:45'),
(13, 'MODUL LAPORAN', '#', 'fa fa-book', 0, 'n', NULL, 1, '2020-10-01 17:39:36', NULL),
(14, 'KEUANGAN PASIEN', 'pendaftaran/laporan_keu', 'fa fa-book', 13, 'y', NULL, 1, '2020-10-01 17:39:36', NULL),
(15, 'MUTASI BARANG', 'dataobat/mutasi', 'fa fa-book', 13, 'y', NULL, 1, '2020-10-01 17:39:36', NULL),
(16, 'MODUL APOTEK', '#', 'fa fa-bed', 0, 'y', NULL, 1, '2020-10-01 17:39:36', NULL),
(17, 'DATA OBAT DAN ALKES', 'dataobat', 'fa fa-medkit', 16, 'n', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 11:39:09'),
(18, 'DATA KATEGORI BARANG (BERES)', 'barang/kategori', 'fa fa-align-justify', 16, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 21:07:48'),
(19, 'DATA SATUAN BARANG (BERES)', 'barang/satuan', 'fa fa-object-group', 16, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 21:30:48'),
(20, 'DATA SUPPLIER (BERES)', 'barang/supplier', 'fa fa-store', 16, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 21:42:32'),
(21, 'LAPORAN PENGADAAN OBAT (BERES)', 'pengadaan', 'fa fa-capsules', 16, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 22:53:59'),
(22, 'LAPORAN PENJUALAN', 'penjualan', 'fa fa-chart-line', 16, 'n', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 22:54:14'),
(23, 'AREA APOTEKER', 'apotek_area', 'fa fa-capsules', 0, 'n', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 21:11:32'),
(24, 'AREA KEUANGAN', 'keuangan_area', 'fa fa-money-bill-wave-alt', 0, 'n', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 21:11:22'),
(25, 'DATA PASIEN (BERES)', 'pasien', 'fa fa-user-injured', 0, 'y', 'tbl_pasien', 1, '2020-10-01 17:39:36', '2020-10-03 16:03:57'),
(26, 'DATA DOKTER (BERES)', 'dokter', 'fa fa-graduation-cap', 0, 'y', 'tbl_dokter', 1, '2020-10-01 17:39:36', '2020-10-02 17:00:31'),
(27, 'JADWAL PRAKTEK DOKTER (BERES)', 'jadwalpraktek', 'fa fa-calendar', 0, 'y', 'tbl_dokter_jadwal', 1, '2020-10-01 17:39:36', '2020-10-02 20:28:58'),
(28, 'DATA PEGAWAI (BERES)', 'pegawai', 'fa fa-user-friends', 0, 'y', 'tbl_pegawai', 1, '2020-10-01 17:39:36', '2020-10-02 18:35:55'),
(29, 'LAPORAN UGD', '#', 'fa fa-bed', 0, 'n', 'tbl_rs_tempat_tidur', 1, '2020-10-01 17:39:36', '2020-10-06 20:19:49'),
(30, 'LAPORAN RAWAT JALAN', 'pendaftaran/ralan', 'fa fa-clinic-medical', 0, 'y', NULL, 1, '2020-10-01 17:39:36', NULL),
(31, 'LAPORAN RAWAT INAP', 'pendaftaran/ranap', 'fa fa-id-card', 0, 'y', NULL, 1, '2020-10-01 17:39:36', NULL),
(32, 'DATA BANGUNAN', '#', 'fa fa-hospital-alt', 0, 'n', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 07:08:29'),
(33, 'DATA GEDUNG (BERES)', 'gedung', 'fa fa-hospital', 32, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-01 22:16:29'),
(34, 'DATA TEMPAT TIDUR (BERES)', 'tempattidur', 'fa fa-bed', 32, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 07:07:43'),
(35, 'DATA RUANG RAWAT INAP (BERES)', 'ruangranap', 'fa fa-building', 32, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 06:24:13'),
(36, 'PROFILE RUMAH SAKIT', 'profile/update/1', 'fa fa-hospital-alt', 0, 'n', 'tbl_profil_rumah_sakit', 1, '2020-10-01 17:39:36', NULL),
(37, 'MENU TINDAKAN', '#', 'fa fa-graduation-cap', 0, 'y', NULL, 1, '2020-10-01 17:39:36', NULL),
(38, 'DATA DIGANOSA PENYAKIT', 'diagnosa', 'fa fa-stethoscope', 37, 'n', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 22:55:42'),
(39, 'DATA KATEGORI TINDAKAN (BERES)', 'kategoritindakan', 'fa fa-microchip', 37, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 07:29:43'),
(40, 'DATA PEMERIKSAAN LAB', 'periksalabor', 'fa fa-bed', 37, 'n', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 07:29:00'),
(41, 'DATA TINDAKAN (BERES)', 'data_tindakan', 'fa fa-map', 37, 'y', NULL, 1, '2020-10-01 17:39:36', '2020-10-02 14:52:49'),
(43, 'DATA KELOMPOK BARANG (BERES)', 'barang/kelompok', 'fa fa-grip-vertical', 16, 'y', NULL, 1, '2020-10-01 21:04:13', '2020-10-01 21:07:29'),
(44, 'DATA OBAT (BERES)', 'barang/obat', 'fa fa-medkit', 16, 'y', NULL, 1, '2020-10-02 09:40:29', '2020-10-02 16:46:03'),
(45, 'DATA ALAT KESEHATAN (BERES)', 'barang/alkes', 'fa fa-medkit', 16, 'y', NULL, 1, '2020-10-02 09:44:32', '2020-10-02 16:46:16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_menu_akses`
--

CREATE TABLE `tbl_menu_akses` (
  `id` bigint NOT NULL,
  `id_user_level` bigint NOT NULL,
  `id_menu` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pasien`
--

CREATE TABLE `tbl_pasien` (
  `id` bigint NOT NULL,
  `id_gol_darah` tinyint NOT NULL,
  `id_pekerjaan` bigint NOT NULL,
  `id_agama` smallint NOT NULL,
  `id_status_pernikahan` tinyint NOT NULL,
  `id_uic` bigint NOT NULL,
  `id_alamat_kecamatan` bigint DEFAULT NULL,
  `id_alamat_kota` bigint DEFAULT NULL,
  `no_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_identitas` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_jenis_kelamin` tinyint NOT NULL,
  `nama_ibu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tempat_lahir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `nama_pasien` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat` text NOT NULL,
  `no_telepon` varchar(25) NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_pasien`
--

INSERT INTO `tbl_pasien` (`id`, `id_gol_darah`, `id_pekerjaan`, `id_agama`, `id_status_pernikahan`, `id_uic`, `id_alamat_kecamatan`, `id_alamat_kota`, `no_kartu`, `no_identitas`, `id_jenis_kelamin`, `nama_ibu`, `tempat_lahir`, `tgl_lahir`, `nama_pasien`, `alamat`, `no_telepon`, `tgl_input`, `tgl_edit`) VALUES
(8, 1, 2, 3, 3, 1, NULL, NULL, '08192', '019223232', 1, 'ATUN', 'Bandung', '1999-01-01', 'Haryani', 'Ciporeat', '08129192232', '2020-10-03 16:01:39', NULL),
(9, 4, 1, 1, 2, 1, NULL, NULL, '202010201', '3502311103900001', 1, 'SRI PUJIASTUTI', 'Bandung', '1998-12-03', 'Agung Satrio Budi Prakoso', 'Rancaekek', '081394782339', '2020-10-04 20:55:50', '2020-10-04 21:03:12'),
(20, 3, 2, 1, 1, 1, NULL, NULL, '045566', '019291', 1, 'ATUN', 'Bandung', '1979-01-01', 'Khaerul Manaf', 'CICAHEUM', '08129192232', '2020-10-06 08:39:20', NULL),
(21, 2, 1, 1, 1, 1, NULL, NULL, '83727382', '019291', 1, 'IBU', 'Bandung', '1992-01-01', 'TEMY', 'cigas', '83923929', '2020-10-06 08:41:39', NULL),
(22, 4, 2, 1, 1, 1, NULL, NULL, '328329389', '320428', 1, 'panjang', 'Bandung', '1999-09-19', 'Testing', 'igandao', '83239892', '2020-10-06 08:43:53', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pasien_cara_masuk`
--

CREATE TABLE `tbl_pasien_cara_masuk` (
  `id` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `kode_cara_masuk` varchar(50) NOT NULL,
  `nama_cara_masuk` varchar(100) NOT NULL,
  `keterangan` text NOT NULL,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_pasien_cara_masuk`
--

INSERT INTO `tbl_pasien_cara_masuk` (`id`, `id_uic`, `kode_cara_masuk`, `nama_cara_masuk`, `keterangan`, `tgl_input`, `tgl_edit`) VALUES
(1, 1, 'RALAN', 'Rawat Jalan', '', '2020-10-01 08:04:57', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pasien_hub_pj`
--

CREATE TABLE `tbl_pasien_hub_pj` (
  `id` bigint NOT NULL,
  `nama_hub_pj` varchar(100) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_pasien_hub_pj`
--

INSERT INTO `tbl_pasien_hub_pj` (`id`, `nama_hub_pj`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'Saudara Kandung', 1, '2020-10-01 08:15:41', NULL),
(2, 'Ayah', 1, '2020-10-01 08:15:41', NULL),
(3, 'Ibu', 1, '2020-10-01 08:15:41', NULL),
(4, 'Anak', 1, '2020-10-01 08:15:41', NULL),
(5, 'Kerabat', 1, '2020-10-01 08:15:41', NULL),
(6, 'Teman', 1, '2020-10-01 08:15:41', NULL),
(7, 'Orang asing', 1, '2020-10-01 08:15:41', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pasien_rekamedis`
--

CREATE TABLE `tbl_pasien_rekamedis` (
  `id` bigint NOT NULL,
  `id_pasien` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `no_rekamedis` varchar(100) NOT NULL,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_pasien_rekamedis`
--

INSERT INTO `tbl_pasien_rekamedis` (`id`, `id_pasien`, `id_uic`, `no_rekamedis`, `tgl_input`, `tgl_edit`) VALUES
(3, 8, 1, '20201003_8', '2020-10-03 16:01:39', NULL),
(4, 9, 1, '20201004_9', '2020-10-04 20:55:50', NULL),
(8, 20, 1, '20201006_20', '2020-10-06 08:39:20', NULL),
(9, 21, 1, '20201006_21', '2020-10-06 08:41:39', NULL),
(10, 22, 1, '20201006_22', '2020-10-06 08:43:53', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pasien_riwayat_perjalanan`
--

CREATE TABLE `tbl_pasien_riwayat_perjalanan` (
  `id` bigint NOT NULL,
  `id_rekamedis` bigint NOT NULL,
  `tgl_berangkat` datetime NOT NULL,
  `tgl_pulang` datetime NOT NULL,
  `keterangan` text NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_pasien_riwayat_perjalanan`
--

INSERT INTO `tbl_pasien_riwayat_perjalanan` (`id`, `id_rekamedis`, `tgl_berangkat`, `tgl_pulang`, `keterangan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 9, '2020-10-15 22:44:48', '2021-01-22 22:44:48', 'Berangkat ke Jogja', 1, '2020-10-06 22:46:07', NULL),
(2, 10, '2020-10-06 22:44:48', '2020-10-31 22:44:48', 'Berangkat ke surabaya', 1, '2020-10-06 22:46:07', NULL),
(4, 9, '2020-10-07 04:00:00', '2020-11-27 06:00:00', 'Pergi membeli baju', 1, '2020-10-07 16:28:44', NULL),
(6, 8, '2020-10-07 04:00:00', '2020-11-27 12:00:00', 'Mengunjungi saudara', 1, '2020-10-07 16:58:55', NULL),
(7, 4, '2020-10-07 05:00:00', '2020-11-20 01:00:00', 'Membuat kue', 1, '2020-10-07 17:04:05', NULL),
(8, 4, '2020-10-15 05:00:00', '2020-11-25 01:00:00', 'Dadanaan', 1, '2020-10-07 17:04:50', NULL),
(9, 4, '2020-10-16 05:00:00', '2020-11-20 01:00:00', 'jsdjsd', 1, '2020-10-07 17:05:26', NULL),
(10, 8, '2020-10-17 05:00:00', '2020-11-18 01:00:00', '.', 1, '2020-10-07 17:06:18', NULL),
(12, 4, '2020-10-07 05:00:00', '2020-11-21 01:00:00', 'Tidak ada', 1, '2020-10-07 17:20:44', NULL),
(13, 4, '2020-10-14 05:00:00', '2020-11-26 01:00:00', 'Ada kutu', 1, '2020-10-07 17:22:28', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pasien_status_rawat`
--

CREATE TABLE `tbl_pasien_status_rawat` (
  `id` bigint NOT NULL,
  `kode_status_rawat` varchar(100) NOT NULL,
  `nama_status_rawat` varchar(100) NOT NULL,
  `id_uic` bigint NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_pasien_status_rawat`
--

INSERT INTO `tbl_pasien_status_rawat` (`id`, `kode_status_rawat`, `nama_status_rawat`, `id_uic`, `keterangan`, `tgl_input`, `tgl_edit`) VALUES
(1, 'SEMBUH', 'Keluar Sembuh', 1, NULL, '2020-10-01 08:13:47', NULL),
(2, 'RANAP', 'Dirawat Inap', 1, NULL, '2020-10-01 08:13:47', NULL),
(3, 'RALAN', 'Rawat Jalan Sekali', 1, NULL, '2020-10-01 08:13:47', NULL),
(4, 'RALAN_RUTIN', 'Rawat Jalan Rutin', 1, NULL, '2020-10-01 08:13:47', NULL),
(5, 'UGD', 'Di ruang UGD', 1, NULL, '2020-10-01 08:13:47', NULL),
(6, 'ISOLASI', 'Di ruang isolasi', 1, NULL, '2020-10-01 08:13:47', NULL),
(7, 'MENINGGAL', 'Meninggal Dunia', 1, NULL, '2020-10-01 08:13:47', NULL),
(8, 'BUNDIR', 'Bunuh Diri', 1, NULL, '2020-10-01 08:13:47', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pegawai`
--

CREATE TABLE `tbl_pegawai` (
  `id` bigint NOT NULL,
  `nik` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_jenjang` bigint NOT NULL,
  `id_departemen` bigint NOT NULL,
  `id_jabatan` bigint NOT NULL,
  `id_alamat_kecamatan` bigint DEFAULT NULL,
  `id_alamat_kota` bigint DEFAULT NULL,
  `id_bidang` bigint NOT NULL,
  `id_jenjang_pendidikan` bigint NOT NULL,
  `id_gol_darah` tinyint NOT NULL,
  `id_status_menikah` tinyint NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL,
  `id_agama` smallint NOT NULL,
  `id_jenis_kelamin` tinyint NOT NULL,
  `npwp` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tempat_lahir` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_pegawai` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_identitas` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_telepon` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alumni` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pegawai`
--

INSERT INTO `tbl_pegawai` (`id`, `nik`, `id_jenjang`, `id_departemen`, `id_jabatan`, `id_alamat_kecamatan`, `id_alamat_kota`, `id_bidang`, `id_jenjang_pendidikan`, `id_gol_darah`, `id_status_menikah`, `id_uic`, `tgl_input`, `tgl_edit`, `id_agama`, `id_jenis_kelamin`, `npwp`, `tempat_lahir`, `nama_pegawai`, `tgl_lahir`, `alamat`, `no_identitas`, `no_telepon`, `alumni`) VALUES
(1, '121919', 1, 1, 1, NULL, NULL, 1, 1, 1, 2, 1, NULL, '2020-10-02 18:35:09', 1, 1, '123', 'Cibiru', 'Harha', '2020-01-11', 'Cibodas', '019291', '081394782339', 'UNIKOM'),
(2, '19281927', 1, 4, 5, NULL, NULL, 1, 1, 1, 2, 1, '2020-10-02 17:24:00', NULL, 1, 1, '1266', 'Bandung', 'Haryanto', '1998-03-01', '', '', '', ''),
(3, '19281929', 1, 3, 4, NULL, NULL, 1, 1, 1, 1, 1, '2020-10-02 17:24:00', NULL, 1, 1, '889899', 'Bandung', 'Waksim', '1998-03-01', '', '', '', ''),
(4, '2011920', 1, 1, 2, NULL, NULL, 1, 1, 4, 2, 1, NULL, '2020-10-02 18:35:22', 2, 2, '889899', 'Bandung', 'Mirna', '1992-01-01', 'Ciporeat', '3502311103900001', '081394782339', 'STIKES UNIKOM');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pegawai_bidang`
--

CREATE TABLE `tbl_pegawai_bidang` (
  `id` bigint NOT NULL,
  `nama_bidang` varchar(35) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pegawai_bidang`
--

INSERT INTO `tbl_pegawai_bidang` (`id`, `nama_bidang`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'Pemeriksa Sampel', 1, '2020-10-01 19:18:18', NULL),
(2, 'Suster 1', 1, '2020-10-01 19:18:30', '2020-10-01 19:18:57'),
(3, 'Perawat', 1, '2020-10-01 19:18:42', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pegawai_departemen`
--

CREATE TABLE `tbl_pegawai_departemen` (
  `id` bigint NOT NULL,
  `nama_departemen` varchar(40) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pegawai_departemen`
--

INSERT INTO `tbl_pegawai_departemen` (`id`, `nama_departemen`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'DEPARTEMEN 1', 1, '2020-10-01 08:58:43', NULL),
(2, 'KEAMANAN', 1, '2020-10-01 08:58:43', NULL),
(3, 'KEUANGAN', 1, '2020-10-01 08:58:43', NULL),
(4, 'APOTEK', 1, '2020-10-01 08:58:43', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pegawai_jabatan`
--

CREATE TABLE `tbl_pegawai_jabatan` (
  `id` int NOT NULL,
  `nama_jabatan` varchar(30) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pegawai_jabatan`
--

INSERT INTO `tbl_pegawai_jabatan` (`id`, `nama_jabatan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'JABATAN 1', 1, '2020-10-01 08:58:44', NULL),
(2, 'JABATAN 2', 1, '2020-10-01 08:58:44', NULL),
(3, 'PENGANGGUNG JAWAB LAB', 1, '2020-10-01 08:58:44', NULL),
(4, 'KARYAWAN KEUANGAN', 1, '2020-10-01 08:58:44', NULL),
(5, 'APOTEKER', 1, '2020-10-01 08:58:44', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pekerjaan`
--

CREATE TABLE `tbl_pekerjaan` (
  `id` bigint NOT NULL,
  `nama_pekerjaan` varchar(40) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pekerjaan`
--

INSERT INTO `tbl_pekerjaan` (`id`, `nama_pekerjaan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'PNS', 1, '2020-10-01 08:58:47', NULL),
(2, 'SWASTA', 1, '2020-10-01 08:58:47', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pendaftaran`
--

CREATE TABLE `tbl_pendaftaran` (
  `id` bigint NOT NULL,
  `id_rekamedis` bigint NOT NULL,
  `id_cara_masuk` bigint NOT NULL,
  `id_status_rawat` bigint NOT NULL,
  `id_pj_dokter` bigint NOT NULL,
  `id_poli` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `id_jenis_bayar` bigint NOT NULL,
  `no_rawat` varchar(100) NOT NULL,
  `tgl_daftar` datetime NOT NULL,
  `asal_rujukan` varchar(100) DEFAULT NULL,
  `nama_pj` varchar(100) NOT NULL,
  `id_hub_dg_pj` bigint NOT NULL,
  `alamat_pj` text NOT NULL,
  `no_identitas_pj` varchar(100) NOT NULL,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_pendaftaran`
--

INSERT INTO `tbl_pendaftaran` (`id`, `id_rekamedis`, `id_cara_masuk`, `id_status_rawat`, `id_pj_dokter`, `id_poli`, `id_uic`, `id_jenis_bayar`, `no_rawat`, `tgl_daftar`, `asal_rujukan`, `nama_pj`, `id_hub_dg_pj`, `alamat_pj`, `no_identitas_pj`, `tgl_input`, `tgl_edit`) VALUES
(3, 4, 1, 3, 6, 3, 1, 1, '20201004/20201004_9/3', '2020-10-05 00:00:00', NULL, 'SETIADI', 1, 'cigondewah', '23283', '2020-10-04 21:22:24', NULL),
(4, 4, 1, 2, 43, 5, 1, 1, '20201006/20201004_9/4', '2020-10-06 00:00:00', NULL, 'SUNIARAJA', 1, 'CIKONDANG', '2322323', '2020-10-06 08:22:48', NULL),
(8, 8, 1, 3, 9, 6, 1, 1, '20201006/8/8', '2020-10-06 00:00:00', NULL, 'SUNIARAJA', 4, 'BANDUNG', '129829', '2020-10-06 08:39:20', NULL),
(9, 9, 1, 2, 18, 14, 1, 1, '20201006/9/9', '2020-10-06 00:00:00', NULL, 'SUNIARAJA', 6, 'dede', 'shjdhjasa', '2020-10-06 08:41:39', NULL),
(10, 10, 1, 3, 41, 30, 1, 1, '20201006/20201006_22/10', '2020-10-06 00:00:00', NULL, 'SETIADI', 1, 'bandung', '2389298329', '2020-10-06 08:43:53', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pendaftaran_diary`
--

CREATE TABLE `tbl_pendaftaran_diary` (
  `id` bigint NOT NULL,
  `id_pendaftaran` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `isi` text NOT NULL,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `tbl_pendaftaran_diary`
--

INSERT INTO `tbl_pendaftaran_diary` (`id`, `id_pendaftaran`, `id_uic`, `isi`, `tgl_input`, `tgl_edit`) VALUES
(1, 3, 1, 'Testing', '2020-10-07 18:39:57', NULL),
(3, 3, 1, 'deho', '2020-10-07 18:44:00', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pendaftaran_mutasi`
--

CREATE TABLE `tbl_pendaftaran_mutasi` (
  `id` bigint NOT NULL,
  `id_pendaftaran` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `jumlah` bigint NOT NULL,
  `keterangan` text NOT NULL,
  `tgl_input` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pendaftaran_mutasi`
--

INSERT INTO `tbl_pendaftaran_mutasi` (`id`, `id_pendaftaran`, `id_uic`, `jumlah`, `keterangan`, `tgl_input`) VALUES
(1, 9, 1, -47585, 'PEMBELIAN ACNOL 10ML SEJUMLAH 5 PCS', '2020-10-06 22:08:49'),
(2, 9, 1, 123456789, 'PENYETORAN AWAL PASIEN', '2020-10-07 20:42:02'),
(3, 9, 1, -862500, 'BIAYA INAP PASIEN', '2020-10-07 20:42:02'),
(4, 8, 1, -44850, 'PEMBELIAN ABBOCATH 20 SEJUMLAH 3 PCS', '2020-10-08 08:01:08'),
(5, 8, 1, 29900, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 2 PCS', '2020-10-08 08:12:46'),
(6, 8, 1, -14950, 'PEMBELIAN ABBOCATH 20 SEJUMLAH -1 PCS', '2020-10-08 08:30:22'),
(7, 8, 1, 29900, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 2 PCS', '2020-10-08 08:30:45'),
(8, 8, 1, -119600, 'PEMBELIAN ABBOCATH 20 SEJUMLAH 8 PCS', '2020-10-08 08:31:41'),
(9, 8, 1, 119600, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 8 PCS', '2020-10-08 08:31:59'),
(10, 4, 1, 987654321, 'PENYETORAN AWAL PASIEN', '2020-10-08 08:35:27'),
(11, 4, 1, -600000, 'BIAYA INAP PASIEN', '2020-10-08 08:35:27'),
(12, 4, 1, -14950, 'PEMBELIAN ABBOCATH 20 SEJUMLAH 1 PCS', '2020-10-08 08:36:00'),
(13, 4, 1, -29900, 'PEMBELIAN ABBOCATH 20 SEJUMLAH 2 PCS', '2020-10-08 08:36:50'),
(14, 4, 1, 29900, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 2 PCS', '2020-10-08 08:37:10'),
(15, 4, 1, -20250, 'PEMBELIAN ACETON 60ML SEJUMLAH 3 Botol', '2020-10-08 08:42:24'),
(16, 4, 1, 13500, 'PENGEMBALIAN ACETON 60ML SEJUMLAH 2 Botol', '2020-10-08 08:42:43'),
(17, 4, 1, 6750, 'PENGEMBALIAN ACETON 60ML SEJUMLAH 1 Botol', '2020-10-08 11:16:52'),
(18, 4, 1, -13500, 'PEMBERIAN TINDAKAN PHACOEMULSIFICATION PAKET LENSA MONOFOCAL', '2020-10-08 12:23:54'),
(19, 4, 1, 14950, 'PENGEMBALIAN ABBOCATH 20 SEJUMLAH 1 PCS', '2020-10-08 12:42:21'),
(20, 4, 1, 13500, 'PEMBATALAN PEMBERIAN TINDAKAN PHACOEMULSIFICATION PAKET LENSA MONOFOCAL', '2020-10-08 12:42:30'),
(21, 9, 1, 39579, 'PENGEMBALIAN DR. P ADULT SPECIAL L2 SEJUMLAH 3 Pack', '2020-10-08 12:54:32'),
(22, 9, 1, 20250, 'PENGEMBALIAN ACETON 60ML SEJUMLAH 3 Botol', '2020-10-08 12:54:43'),
(23, 9, 1, 20250, 'PENGEMBALIAN ACETON 60ML SEJUMLAH 3 Botol', '2020-10-08 12:54:58');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pendaftaran_ranap`
--

CREATE TABLE `tbl_pendaftaran_ranap` (
  `id` bigint NOT NULL,
  `id_pendaftaran` bigint NOT NULL,
  `id_tempat_tidur` bigint DEFAULT NULL,
  `id_ruang_ranap` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL,
  `tanggal_masuk` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tanggal_keluar` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pendaftaran_ranap`
--

INSERT INTO `tbl_pendaftaran_ranap` (`id`, `id_pendaftaran`, `id_tempat_tidur`, `id_ruang_ranap`, `id_uic`, `tgl_input`, `tgl_edit`, `tanggal_masuk`, `tanggal_keluar`) VALUES
(1, 9, NULL, 3, 1, '2020-10-07 20:42:02', NULL, '2020-10-07 20:42:02', '2020-10-30 00:00:00'),
(2, 4, NULL, 9, 1, '2020-10-08 08:35:27', NULL, '2020-10-08 08:35:27', '2020-10-20 00:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pendaftaran_riwayat_obat`
--

CREATE TABLE `tbl_pendaftaran_riwayat_obat` (
  `id` bigint NOT NULL,
  `id_pendaftaran` bigint NOT NULL,
  `id_barang` bigint NOT NULL,
  `id_status_acc` bigint NOT NULL DEFAULT '1',
  `tanggal` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `qty` bigint NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pendaftaran_riwayat_obat`
--

INSERT INTO `tbl_pendaftaran_riwayat_obat` (`id`, `id_pendaftaran`, `id_barang`, `id_status_acc`, `tanggal`, `qty`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(2, 9, 625, 1, '2020-10-06 20:55:22', 3, 1, '2020-10-06 20:55:22', NULL),
(4, 9, 951, 1, '2020-10-06 21:51:16', 2, 1, '2020-10-06 21:51:16', NULL),
(6, 9, 6, 1, '2020-10-06 21:52:27', 3, 1, '2020-10-06 21:52:27', NULL),
(7, 9, 8, 1, '2020-10-06 22:08:49', 5, 1, '2020-10-06 22:08:49', NULL),
(8, 8, 2, 1, '2020-10-08 08:01:08', 1, 1, '2020-10-08 08:01:08', NULL);

--
-- Trigger `tbl_pendaftaran_riwayat_obat`
--
DELIMITER $$
CREATE TRIGGER `trigger_hapus_barang` BEFORE DELETE ON `tbl_pendaftaran_riwayat_obat` FOR EACH ROW up: BEGIN
	DECLARE nm_barang VARCHAR(100);
    DECLARE nm_satuan VARCHAR(100);
    DECLARE keterangan TEXT;
    DECLARE hrg BIGINT;
    DECLARE tot BIGINT;
    DECLARE selisih BIGINT;
    DECLARE jml BIGINT;
    
    SELECT nama_barang, nama_satuan, harga into nm_barang, nm_satuan, hrg
    from tbl_barang
    join tbl_barang_satuan on tbl_barang_satuan.id = tbl_barang.id_satuan_barang
    where tbl_barang.id = OLD.id_barang;
   
    SET keterangan = CONCAT("PENGEMBALIAN ", nm_barang, " SEJUMLAH ", OLD.qty, " ", nm_satuan);
    

    INSERT INTO `tbl_barang_mutasi`(`id_barang`, `id_uic`, `qty`, `keterangan`) VALUES (OLD.id_barang, OLD.id_uic, OLD.qty, keterangan);
    
    SET tot = hrg * OLD.qty;
    
    INSERT INTO `tbl_pendaftaran_mutasi`(`id_pendaftaran`, `id_uic`, `jumlah`, `keterangan`) VALUES (OLD.id_pendaftaran, OLD.id_uic, tot, keterangan);
    
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_perubahan_qty` BEFORE UPDATE ON `tbl_pendaftaran_riwayat_obat` FOR EACH ROW up: BEGIN
	DECLARE nm_barang VARCHAR(100);
    DECLARE nm_satuan VARCHAR(100);
    DECLARE keterangan TEXT;
    DECLARE hrg BIGINT;
    DECLARE tot BIGINT;
    DECLARE selisih BIGINT;
    DECLARE jml BIGINT;
    
    IF (NOT(OLD.qty <> NEW.qty)) THEN
    	LEAVE up;
    END IF;
    
    SELECT nama_barang, nama_satuan, harga into nm_barang, nm_satuan, hrg
    from tbl_barang
    join tbl_barang_satuan on tbl_barang_satuan.id = tbl_barang.id_satuan_barang
    where tbl_barang.id = NEW.id_barang;
    
    SET selisih = OLD.qty - NEW.qty;
   
    IF(SIGN(selisih) < 0) THEN
         SET keterangan = CONCAT("PEMBELIAN ", nm_barang, " SEJUMLAH ", -selisih, " ", nm_satuan);
    ELSE
         SET keterangan = CONCAT("PENGEMBALIAN ", nm_barang, " SEJUMLAH ", selisih, " ", nm_satuan);
    END IF;
    

    INSERT INTO `tbl_barang_mutasi`(`id_barang`, `id_uic`, `qty`, `keterangan`) VALUES (NEW.id_barang, NEW.id_uic, selisih, keterangan);
    
    SET tot = hrg * selisih;
    
    INSERT INTO `tbl_pendaftaran_mutasi`(`id_pendaftaran`, `id_uic`, `jumlah`, `keterangan`) VALUES (NEW.id_pendaftaran, NEW.id_uic, tot, keterangan);
    
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_riwayat_obat` AFTER INSERT ON `tbl_pendaftaran_riwayat_obat` FOR EACH ROW BEGIN
	DECLARE nm_barang VARCHAR(100);
    DECLARE nm_satuan VARCHAR(100);
    DECLARE keterangan TEXT;
    DECLARE hrg BIGINT;
    DECLARE tot BIGINT;
    
    SELECT nama_barang, nama_satuan, harga into nm_barang, nm_satuan, hrg
    from tbl_barang
    join tbl_barang_satuan on tbl_barang_satuan.id = tbl_barang.id_satuan_barang
    where tbl_barang.id = NEW.id_barang;
    
    SET keterangan = CONCAT("PEMBELIAN ", nm_barang, " SEJUMLAH ", NEW.qty, " ", nm_satuan);

    INSERT INTO `tbl_barang_mutasi`(`id_barang`, `id_uic`, `qty`, `keterangan`) VALUES (NEW.id_barang, NEW.id_uic, -NEW.qty, keterangan);
    
    SET tot = hrg * -NEW.qty;
    
    INSERT INTO `tbl_pendaftaran_mutasi`(`id_pendaftaran`, `id_uic`, `jumlah`, `keterangan`) VALUES (NEW.id_pendaftaran, NEW.id_uic, tot, keterangan);
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pendaftaran_riwayat_tindakan`
--

CREATE TABLE `tbl_pendaftaran_riwayat_tindakan` (
  `id` bigint NOT NULL,
  `id_pegawai` bigint DEFAULT NULL,
  `id_dokter` bigint DEFAULT NULL,
  `id_tindakan` bigint NOT NULL,
  `id_pendaftaran` bigint NOT NULL,
  `id_uic` bigint NOT NULL COMMENT 'User in charge',
  `hasil_periksa` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `perkembangan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `id_status_acc` bigint NOT NULL DEFAULT '1',
  `tanggal` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_pendaftaran_riwayat_tindakan`
--

INSERT INTO `tbl_pendaftaran_riwayat_tindakan` (`id`, `id_pegawai`, `id_dokter`, `id_tindakan`, `id_pendaftaran`, `id_uic`, `hasil_periksa`, `perkembangan`, `id_status_acc`, `tanggal`, `tgl_input`, `tgl_edit`) VALUES
(1, NULL, 43, 1, 4, 1, 'BAIK', 'BAIK', 1, '2020-10-08 12:02:48', '2020-10-08 12:02:48', NULL);

--
-- Trigger `tbl_pendaftaran_riwayat_tindakan`
--
DELIMITER $$
CREATE TRIGGER `trigger_add_riwayat` AFTER INSERT ON `tbl_pendaftaran_riwayat_tindakan` FOR EACH ROW BEGIN
	DECLARE nm_tindakan VARCHAR(100);
    DECLARE tot BIGINT;
    DECLARE keterangan TEXT;
    
    SELECT nama_tindakan, tarif into nm_tindakan, tot
    from tbl_tindakan
    where tbl_tindakan.id = new.id_tindakan;
    
    SET keterangan = CONCAT("PEMBERIAN TINDAKAN ", nm_tindakan);
    
    INSERT INTO `tbl_pendaftaran_mutasi`(`id_pendaftaran`, `id_uic`, `jumlah`, `keterangan`) VALUES (NEW.id_pendaftaran, NEW.id_uic, -tot, keterangan);
    
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_batalkan_tindakan` BEFORE DELETE ON `tbl_pendaftaran_riwayat_tindakan` FOR EACH ROW BEGIN
	DECLARE nm_tindakan VARCHAR(100);
    DECLARE tot BIGINT;
    DECLARE keterangan TEXT;
    
    SELECT nama_tindakan, tarif into nm_tindakan, tot
    from tbl_tindakan
    where tbl_tindakan.id = old.id_tindakan;
    
    SET keterangan = CONCAT("PEMBATALAN PEMBERIAN TINDAKAN ", nm_tindakan);
    
    INSERT INTO `tbl_pendaftaran_mutasi`(`id_pendaftaran`, `id_uic`, `jumlah`, `keterangan`) VALUES (old.id_pendaftaran, old.id_uic, tot, keterangan);
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_poliklinik`
--

CREATE TABLE `tbl_poliklinik` (
  `id` bigint NOT NULL,
  `nama_poliklinik` varchar(40) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_poliklinik`
--

INSERT INTO `tbl_poliklinik` (`id`, `nama_poliklinik`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'POLIKLINIK ANAK', 1, '2020-10-01 18:38:47', NULL),
(2, 'POLIKLINIK ANAK PINERE', 1, '2020-10-01 18:38:47', NULL),
(3, 'POLIKLINIK BEDAH ORTHOPEDI (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL),
(4, 'POLIKLINIK BEDAH ANAK', 1, '2020-10-01 18:38:47', NULL),
(5, 'POLIKLINIK BEDAH MULUT', 1, '2020-10-01 18:38:47', NULL),
(6, 'POLIKLINIK BEDAH ORTHOPEDY', 1, '2020-10-01 18:38:47', NULL),
(7, 'POLIKLINIK BEDAH SYARAF', 1, '2020-10-01 18:38:47', NULL),
(8, 'POLIKLINIK BEDAH UMUM', 1, '2020-10-01 18:38:47', NULL),
(9, 'POLIKLINIK BEDAH UMUM (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL),
(10, 'POLIKLINIK BEDAH UROLOGI', 1, '2020-10-01 18:38:47', NULL),
(11, 'POLIKLINIK ENDODONTI', 1, '2020-10-01 18:38:47', NULL),
(12, 'POLIKLINIK GIGI', 1, '2020-10-01 18:38:47', NULL),
(13, 'POLIKLINIK GIZI', 1, '2020-10-01 18:38:47', NULL),
(14, 'POLIKLINIK JANTUNG', 1, '2020-10-01 18:38:47', NULL),
(15, 'POLIKLINIK KANDUNGAN', 1, '2020-10-01 18:38:47', NULL),
(16, 'POLIKLINIK KANDUNGAN (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL),
(17, 'POLIKLINIK KHITAN', 1, '2020-10-01 18:38:47', NULL),
(18, 'POLIKLINIK KULIT DAN KELAMIN', 1, '2020-10-01 18:38:47', NULL),
(19, 'POLIKLINIK MATA', 1, '2020-10-01 18:38:47', NULL),
(20, 'POLIKLINIK ORTODONTI', 1, '2020-10-01 18:38:47', NULL),
(21, 'POLIKLINIK PARU', 1, '2020-10-01 18:38:47', NULL),
(22, 'POLIKLINIK PENYAKIT DALAM', 1, '2020-10-01 18:38:47', NULL),
(23, 'POLIKLINIK PENYAKIT DALAM PINERE', 1, '2020-10-01 18:38:47', NULL),
(24, 'POLIKLINIK PENYAKIT DALAM (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL),
(25, 'POLIKLINIK PROSTODONTI', 1, '2020-10-01 18:38:47', NULL),
(26, 'POLIKLINIK PSIKIATRI', 1, '2020-10-01 18:38:47', NULL),
(27, 'POLIKLINIK PSIKOLOGI', 1, '2020-10-01 18:38:47', NULL),
(28, 'POLIKLINIK SYARAF', 1, '2020-10-01 18:38:47', NULL),
(29, 'POLIKLINIK SYARAF (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL),
(30, 'POLIKLINIK THT', 1, '2020-10-01 18:38:47', NULL),
(31, 'KONSULTASI VCT', 1, '2020-10-01 18:38:47', NULL),
(32, 'POLIKLINIK BKIA', 1, '2020-10-01 18:38:47', NULL),
(33, 'POLIKLINIK PERJANJIAN (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL),
(34, 'KLINIK BEDAH PLASTIK (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL),
(35, 'KLINIK BEDAH UROLOGI (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL),
(36, 'POLIKLINIK BEDAH DIGESTIV', 1, '2020-10-01 18:38:47', NULL),
(37, 'POLIKLINIK BEDAH PLASTIK', 1, '2020-10-01 18:38:47', NULL),
(38, 'POLIKLINIK PERIODONTI', 1, '2020-10-01 18:38:47', NULL),
(39, 'POLIKLINIK PEDODONTI', 1, '2020-10-01 18:38:47', NULL),
(40, 'KLINIK BEDAH THORAX (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL),
(41, 'POLIKLINIK BEDAH THORAX', 1, '2020-10-01 18:38:47', NULL),
(42, 'POLIKLINIK JANTUNG (RAUDHAH)', 1, '2020-10-01 18:38:47', NULL);

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
-- Struktur dari tabel `tbl_rs_gedung`
--

CREATE TABLE `tbl_rs_gedung` (
  `id` bigint NOT NULL,
  `kode_gedung` varchar(100) NOT NULL,
  `nama_gedung` varchar(40) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_rs_gedung`
--

INSERT INTO `tbl_rs_gedung` (`id`, `kode_gedung`, `nama_gedung`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'GD00001', 'GEDUNG A', 1, '2020-10-01 22:02:20', NULL),
(2, 'GD00002', 'GEDUNG B', 1, '2020-10-01 22:02:20', NULL),
(3, 'GD00003', 'GEDUNG C', 1, '2020-10-01 22:02:20', NULL),
(4, 'GDCND', 'GEDUNG CUT NYAK DHIEN', 1, '2020-10-01 22:02:20', NULL),
(5, 'GDMLYHT', 'GEDUNG MALAYAHATI', 1, '2020-10-01 22:02:20', NULL),
(6, 'TKMR', 'GEDUNG TEUKU UMAROH', 1, '2020-10-01 22:02:20', '2020-10-01 22:10:46');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_rs_ruang`
--

CREATE TABLE `tbl_rs_ruang` (
  `id` bigint NOT NULL,
  `id_ranap_gedung` bigint NOT NULL,
  `id_ruang_kelas` bigint NOT NULL,
  `kode_ruang` varchar(100) NOT NULL,
  `nama_ruangan` varchar(35) NOT NULL,
  `tarif` int NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_rs_ruang`
--

INSERT INTO `tbl_rs_ruang` (`id`, `id_ranap_gedung`, `id_ruang_kelas`, `kode_ruang`, `nama_ruangan`, `tarif`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 1, 1, 'TEST01', 'TESTs', 13500, 1, '2020-10-02 05:42:01', '2020-10-02 06:18:27'),
(2, 1, 2, 'RANAP_002', 'MARIE CURIE A', 37500, 1, '2020-10-02 05:42:01', NULL),
(3, 1, 2, 'RANAP_003', 'MARIE CURIE B', 37500, 1, '2020-10-02 05:42:01', NULL),
(4, 1, 3, 'RANAP_004', 'SIGMUND FREUD', 34950, 1, '2020-10-02 05:42:01', NULL),
(5, 2, 2, 'RANAP_005', 'JOSEPH LISTER', 36776, 1, '2020-10-02 05:42:01', NULL),
(6, 2, 3, 'RANAP_006', 'LOUIS PASTEUR A', 34776, 1, '2020-10-02 05:42:01', NULL),
(7, 2, 3, 'RANAP_007', 'LOUIS PASTEUR B', 34776, 1, '2020-10-02 05:42:01', NULL),
(8, 2, 4, 'RANAP_008', 'FLORENCE NIGHTIGALE', 27540, 1, '2020-10-02 05:42:01', NULL),
(9, 3, 1, 'RANAP_009', 'JOHN SNOW', 50000, 1, '2020-10-02 05:42:01', NULL),
(10, 3, 2, 'RANAP_010', 'EDWARD JENNER', 33231, 1, '2020-10-02 05:42:01', NULL),
(11, 3, 3, 'RANAP_011', 'HIPPOCRATES', 33112, 1, '2020-10-02 05:42:01', NULL),
(12, 3, 5, 'RANAP_012', 'SIR WILLIAM OSLER', 27550, 1, '2020-10-02 05:42:01', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_rs_ruang_kelas`
--

CREATE TABLE `tbl_rs_ruang_kelas` (
  `id` bigint NOT NULL,
  `nama_kelas_ruang_ranap` varchar(50) NOT NULL,
  `deskripsi_kelas_ruang_ranap` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_rs_ruang_kelas`
--

INSERT INTO `tbl_rs_ruang_kelas` (`id`, `nama_kelas_ruang_ranap`, `deskripsi_kelas_ruang_ranap`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'VVIP', NULL, 1, '2020-10-02 05:01:38', NULL),
(2, 'VIP', NULL, 1, '2020-10-02 05:01:38', NULL),
(3, 'KELAS 1', NULL, 1, '2020-10-02 05:01:38', NULL),
(4, 'KELAS 2', NULL, 1, '2020-10-02 05:01:38', NULL),
(5, 'KELAS 3', NULL, 1, '2020-10-02 05:01:38', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_rs_tempat_tidur`
--

CREATE TABLE `tbl_rs_tempat_tidur` (
  `id` bigint NOT NULL,
  `id_ranap_ruang` bigint NOT NULL,
  `kode_tempat_tidur` varchar(254) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_rs_tempat_tidur`
--

INSERT INTO `tbl_rs_tempat_tidur` (`id`, `id_ranap_ruang`, `kode_tempat_tidur`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 1, '1_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(2, 1, '1_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(3, 1, '1_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(4, 1, '1_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(5, 1, '1_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(6, 1, '1_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(7, 1, '1_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(8, 1, '1_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(9, 1, '1_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(10, 1, '1_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(11, 2, '2_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(12, 2, '2_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(13, 2, '2_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(14, 2, '2_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(15, 2, '2_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(16, 2, '2_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(17, 2, '2_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(18, 2, '2_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(19, 2, '2_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(20, 2, '2_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(21, 3, '3_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(22, 3, '3_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(23, 3, '3_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(24, 3, '3_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(25, 3, '3_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(26, 3, '3_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(27, 3, '3_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(28, 3, '3_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(29, 3, '3_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(30, 3, '3_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(31, 4, '4_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(32, 4, '4_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(33, 4, '4_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(34, 4, '4_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(35, 4, '4_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(36, 4, '4_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(37, 4, '4_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(38, 4, '4_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(39, 4, '4_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(40, 4, '4_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(41, 5, '5_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(42, 5, '5_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(43, 5, '5_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(44, 5, '5_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(45, 5, '5_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(46, 5, '5_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(47, 5, '5_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(48, 5, '5_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(49, 5, '5_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(50, 5, '5_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(51, 6, '6_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(52, 6, '6_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(53, 6, '6_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(54, 6, '6_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(55, 6, '6_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(56, 6, '6_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(57, 6, '6_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(58, 6, '6_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(59, 6, '6_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(60, 6, '6_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(61, 7, '7_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(62, 7, '7_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(63, 7, '7_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(64, 7, '7_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(65, 7, '7_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(66, 7, '7_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(67, 7, '7_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(68, 7, '7_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(69, 7, '7_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(70, 7, '7_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(71, 8, '8_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(72, 8, '8_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(73, 8, '8_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(74, 8, '8_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(75, 8, '8_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(76, 8, '8_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(77, 8, '8_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(78, 8, '8_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(79, 8, '8_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(80, 8, '8_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(81, 9, '9_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(82, 9, '9_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(83, 9, '9_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(84, 9, '9_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(85, 9, '9_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(86, 9, '9_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(87, 9, '9_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(88, 9, '9_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(89, 9, '9_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(90, 9, '9_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(91, 10, '10_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(92, 10, '10_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(93, 10, '10_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(94, 10, '10_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(95, 10, '10_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(96, 10, '10_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(97, 10, '10_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(98, 10, '10_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(99, 10, '10_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(100, 10, '10_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(101, 11, '11_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(102, 11, '11_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(103, 11, '11_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(104, 11, '11_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(105, 11, '11_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(106, 11, '11_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(107, 11, '11_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(108, 11, '11_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(109, 11, '11_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(110, 11, '11_KSR0010', 1, '2020-10-02 06:40:50', NULL),
(111, 12, '12_KSR0001', 1, '2020-10-02 06:40:50', NULL),
(112, 12, '12_KSR0002', 1, '2020-10-02 06:40:50', NULL),
(113, 12, '12_KSR0003', 1, '2020-10-02 06:40:50', NULL),
(114, 12, '12_KSR0004', 1, '2020-10-02 06:40:50', NULL),
(115, 12, '12_KSR0005', 1, '2020-10-02 06:40:50', NULL),
(116, 12, '12_KSR0006', 1, '2020-10-02 06:40:50', NULL),
(117, 12, '12_KSR0007', 1, '2020-10-02 06:40:50', NULL),
(118, 12, '12_KSR0008', 1, '2020-10-02 06:40:50', NULL),
(119, 12, '12_KSR0009', 1, '2020-10-02 06:40:50', NULL),
(120, 12, '12_KSR0010', 1, '2020-10-02 06:40:50', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_status_acc`
--

CREATE TABLE `tbl_status_acc` (
  `id` bigint NOT NULL,
  `nama_status_acc` varchar(100) NOT NULL,
  `deskripsi_status_acc` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_status_acc`
--

INSERT INTO `tbl_status_acc` (`id`, `nama_status_acc`, `deskripsi_status_acc`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'pending', 'Menunggu persetujuan', 1, '2020-10-06 21:28:46', NULL),
(2, 'accepted', 'Permintaan telah disetujui', 1, '2020-10-06 21:28:46', NULL),
(3, 'denied', 'Permintaan telah ditolak', 1, '2020-10-06 21:28:46', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_status_menikah`
--

CREATE TABLE `tbl_status_menikah` (
  `id` tinyint NOT NULL,
  `nama_status_menikah` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_status_menikah`
--

INSERT INTO `tbl_status_menikah` (`id`, `nama_status_menikah`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'kawin', 1, '2020-10-01 17:23:42', NULL),
(2, 'belum kawin', 1, '2020-10-01 17:23:42', NULL),
(3, 'duda', 1, '2020-10-01 17:23:42', NULL),
(4, 'janda', 1, '2020-10-01 17:23:42', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_tindakan`
--

CREATE TABLE `tbl_tindakan` (
  `id` bigint NOT NULL,
  `kode_tindakan` varchar(6) NOT NULL,
  `jenis_tindakan` enum('rawat_jalan','rawat_inap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_tindakan` varchar(254) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_kategori_tindakan` bigint NOT NULL,
  `tarif` int NOT NULL,
  `tindakan_oleh` enum('dokter','petugas','dokter_dan_petugas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_poliklinik` int DEFAULT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_tindakan`
--

INSERT INTO `tbl_tindakan` (`id`, `kode_tindakan`, `jenis_tindakan`, `nama_tindakan`, `kode_kategori_tindakan`, `tarif`, `tindakan_oleh`, `id_poliklinik`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, '1', 'rawat_jalan', 'Phacoemulsification Tanpa IOL', 1, 11500, 'dokter', 19, 1, '2020-10-02 07:13:58', NULL),
(2, '10', 'rawat_inap', 'CLITORAL REDUCTION', 5, 27123456, 'dokter', 37, 1, '2020-10-02 07:13:58', NULL),
(3, '11', 'rawat_inap', 'LIPSUCTION > 2 AREA', 1, 81987654, 'dokter', 1, 1, '2020-10-02 07:13:58', '2020-10-02 14:52:29'),
(4, '2', 'rawat_jalan', 'PHACOEMULSIFICATION PAKET LENSA MONOFOCAL', 1, 13500, 'dokter', 19, 1, '2020-10-02 07:13:58', NULL),
(5, '3', 'rawat_jalan', 'PHACOEMULSIFICATION PAKET LENSA MULTIFOCAL', 1, 30000, 'dokter', 19, 1, '2020-10-02 07:13:58', NULL),
(6, '4', 'rawat_jalan', 'PHACOEMULSIFICATION PAKET LENSA TORIX', 1, 33000, 'dokter', 19, 1, '2020-10-02 07:13:58', NULL),
(7, '5', 'rawat_jalan', 'PHACOEMULSIFICATION PAKET LENSA PANOPTIX', 1, 32000, 'dokter', 19, 1, '2020-10-02 07:13:58', NULL),
(8, '6', 'rawat_jalan', 'pemasangan implant denture', 2, 4600000, 'dokter', 12, 1, '2020-10-02 07:13:58', NULL),
(9, '7', 'rawat_jalan', 'PROTESA BAHAN VAPLAS', 1, 2000000, 'dokter', 12, 1, '2020-10-02 07:13:58', '2020-10-02 07:41:47'),
(10, '8', 'rawat_inap', 'LIPSUCTION 1 AREA', 5, 57500123, 'dokter', 37, 1, '2020-10-02 07:13:58', NULL),
(11, '9', 'rawat_inap', 'LIPSUCTION 2 AREA', 5, 70123456, 'dokter', 37, 1, '2020-10-02 07:13:58', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_tindakan_kategori`
--

CREATE TABLE `tbl_tindakan_kategori` (
  `id` bigint NOT NULL,
  `kode_kategori_tindakan` varchar(6) NOT NULL,
  `kategori_tindakan` varchar(40) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_tindakan_kategori`
--

INSERT INTO `tbl_tindakan_kategori` (`id`, `kode_kategori_tindakan`, `kategori_tindakan`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'BM01', 'Bedah Mata', 1, '2020-10-02 07:18:54', NULL),
(2, 'GG001', 'Tindakan Gigi', 1, '2020-10-02 07:18:54', NULL),
(3, 'ILJ1', 'INTERVENSI LAYANAN JANTUNG', 1, '2020-10-02 07:18:54', NULL),
(4, 'JT001', 'Tindakan Jantung', 1, '2020-10-02 07:18:54', NULL),
(5, 'PL01', 'BEDAH PLASTIK', 1, '2020-10-02 07:18:54', NULL),
(6, 'TBA1', 'BEDAH ANAK', 1, '2020-10-02 07:18:54', '2020-10-02 07:28:37');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id_users` bigint NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `images` text NOT NULL,
  `id_user_level` int NOT NULL,
  `is_aktif` enum('y','n') NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_user`
--

INSERT INTO `tbl_user` (`id_users`, `full_name`, `email`, `password`, `images`, `id_user_level`, `is_aktif`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'Adminku', 'admsys@rs.go.id', '21232f297a57a5a743894a0e4a801fc3', 'cc.png', 1, 'y', 1, '2020-10-01 17:37:56', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_user_level`
--

CREATE TABLE `tbl_user_level` (
  `id` bigint NOT NULL,
  `nama_level` varchar(30) NOT NULL,
  `id_uic` bigint NOT NULL,
  `tgl_input` datetime DEFAULT CURRENT_TIMESTAMP,
  `tgl_edit` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_user_level`
--

INSERT INTO `tbl_user_level` (`id`, `nama_level`, `id_uic`, `tgl_input`, `tgl_edit`) VALUES
(1, 'Super Admin', 1, '2020-10-01 17:36:23', NULL),
(2, 'Admin', 1, '2020-10-01 17:36:23', NULL),
(3, 'Dokter', 1, '2020-10-01 17:36:23', NULL),
(4, 'Keuangan', 1, '2020-10-01 17:36:23', NULL),
(5, 'Apoteker', 1, '2020-10-01 17:36:23', NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `abc`
--
ALTER TABLE `abc`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `bh_pasien`
--
ALTER TABLE `bh_pasien`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `bh_pendaftaran_pasien_baru`
--
ALTER TABLE `bh_pendaftaran_pasien_baru`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `bh_pendaftaran_pasien_lama`
--
ALTER TABLE `bh_pendaftaran_pasien_lama`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `bh_pendaftaran_ranap`
--
ALTER TABLE `bh_pendaftaran_ranap`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_agama`
--
ALTER TABLE `tbl_agama`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_antrean`
--
ALTER TABLE `tbl_antrean`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_antrean_type`
--
ALTER TABLE `tbl_antrean_type`
  ADD PRIMARY KEY (`id_tipe_antrean`);

--
-- Indeks untuk tabel `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_satuan_1` (`id_satuan_barang`),
  ADD KEY `ifbk_kat_1` (`id_kat_barang`),
  ADD KEY `ifbk_kat_harga_1` (`id_kat_harga`);

--
-- Indeks untuk tabel `tbl_barang_kategori`
--
ALTER TABLE `tbl_barang_kategori`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_kat_kel_1` (`id_kelompok`);

--
-- Indeks untuk tabel `tbl_barang_kat_harga`
--
ALTER TABLE `tbl_barang_kat_harga`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_barang_kelompok`
--
ALTER TABLE `tbl_barang_kelompok`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_barang_mutasi`
--
ALTER TABLE `tbl_barang_mutasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_brg_1` (`id_barang`);

--
-- Indeks untuk tabel `tbl_barang_pengadaan`
--
ALTER TABLE `tbl_barang_pengadaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_brg_supplier_1` (`id_supplier`);

--
-- Indeks untuk tabel `tbl_barang_pengadaan_detail`
--
ALTER TABLE `tbl_barang_pengadaan_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_pengadaan_1` (`id_barang_pengadaan`),
  ADD KEY `ifbk_barang_1` (`id_barang`);

--
-- Indeks untuk tabel `tbl_barang_satuan`
--
ALTER TABLE `tbl_barang_satuan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_barang_supplier`
--
ALTER TABLE `tbl_barang_supplier`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_departemen`
--
ALTER TABLE `tbl_departemen`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_deposit_mutasi`
--
ALTER TABLE `tbl_deposit_mutasi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_diagnosa_penyakit`
--
ALTER TABLE `tbl_diagnosa_penyakit`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_dokter`
--
ALTER TABLE `tbl_dokter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_dokter_gol_darah_1` (`id_gol_darah`),
  ADD KEY `ifbk_dok_spesialis_1` (`id_spesialis`),
  ADD KEY `ifbk_status_nikah_1` (`id_status_menikah`),
  ADD KEY `ifbk_dok_agama_1` (`id_agama`),
  ADD KEY `ifbk_dok_jk_1` (`id_jenis_kelamin`);

--
-- Indeks untuk tabel `tbl_dokter_jadwal`
--
ALTER TABLE `tbl_dokter_jadwal`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_dokter_spesialis`
--
ALTER TABLE `tbl_dokter_spesialis`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_gol_darah`
--
ALTER TABLE `tbl_gol_darah`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_jabatan`
--
ALTER TABLE `tbl_jabatan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_jenis_bayar`
--
ALTER TABLE `tbl_jenis_bayar`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_jenis_kelamin`
--
ALTER TABLE `tbl_jenis_kelamin`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_jenjang`
--
ALTER TABLE `tbl_jenjang`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_jenjang_pendidikan`
--
ALTER TABLE `tbl_jenjang_pendidikan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_menu`
--
ALTER TABLE `tbl_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_menu_akses`
--
ALTER TABLE `tbl_menu_akses`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pasien`
--
ALTER TABLE `tbl_pasien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `no_kartu` (`no_kartu`),
  ADD KEY `ifbk_pasien_jk` (`id_jenis_kelamin`),
  ADD KEY `ifbk_pasien_agama_1` (`id_agama`),
  ADD KEY `ifbk_pasien_gol_darah_1` (`id_gol_darah`),
  ADD KEY `ifbk_pasien_pekerjaan_1` (`id_pekerjaan`),
  ADD KEY `ibfk_pasien_nikah_1` (`id_status_pernikahan`);

--
-- Indeks untuk tabel `tbl_pasien_cara_masuk`
--
ALTER TABLE `tbl_pasien_cara_masuk`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pasien_hub_pj`
--
ALTER TABLE `tbl_pasien_hub_pj`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pasien_rekamedis`
--
ALTER TABLE `tbl_pasien_rekamedis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_rm_pasien_1` (`id_pasien`);

--
-- Indeks untuk tabel `tbl_pasien_riwayat_perjalanan`
--
ALTER TABLE `tbl_pasien_riwayat_perjalanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_rekamedis_2` (`id_rekamedis`);

--
-- Indeks untuk tabel `tbl_pasien_status_rawat`
--
ALTER TABLE `tbl_pasien_status_rawat`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pegawai`
--
ALTER TABLE `tbl_pegawai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_agama_1` (`id_agama`),
  ADD KEY `ifbk_pg_bidang_1` (`id_bidang`),
  ADD KEY `ifbk_pg_gol_darah_1` (`id_gol_darah`),
  ADD KEY `ifbk_pg_jabatan_1` (`id_jabatan`),
  ADD KEY `ifbk_pg_departemen_1` (`id_departemen`),
  ADD KEY `ibfk_pg_jenjang_karir` (`id_jenjang`),
  ADD KEY `ifbk_pg_jk` (`id_jenis_kelamin`),
  ADD KEY `ifbk_pg_jenjang_pdkn` (`id_jenjang_pendidikan`),
  ADD KEY `ifbk_pg_status_nikah` (`id_status_menikah`);

--
-- Indeks untuk tabel `tbl_pegawai_bidang`
--
ALTER TABLE `tbl_pegawai_bidang`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pegawai_departemen`
--
ALTER TABLE `tbl_pegawai_departemen`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pegawai_jabatan`
--
ALTER TABLE `tbl_pegawai_jabatan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pekerjaan`
--
ALTER TABLE `tbl_pekerjaan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pendaftaran`
--
ALTER TABLE `tbl_pendaftaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_cara_masuk_1` (`id_cara_masuk`),
  ADD KEY `ifbk_jenis_bayar_1` (`id_jenis_bayar`),
  ADD KEY `ifbk_dok_pj_1` (`id_pj_dokter`),
  ADD KEY `ifbk_dok_poli_1` (`id_poli`),
  ADD KEY `ifbk_rekamedis_1` (`id_rekamedis`),
  ADD KEY `ifbk_status_rawat_1` (`id_status_rawat`);

--
-- Indeks untuk tabel `tbl_pendaftaran_diary`
--
ALTER TABLE `tbl_pendaftaran_diary`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pendaftaran_mutasi`
--
ALTER TABLE `tbl_pendaftaran_mutasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_pasien_pdftrn_1` (`id_pendaftaran`);

--
-- Indeks untuk tabel `tbl_pendaftaran_ranap`
--
ALTER TABLE `tbl_pendaftaran_ranap`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_pendaftaran_riwayat_obat`
--
ALTER TABLE `tbl_pendaftaran_riwayat_obat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_rw_iddaftar_1` (`id_pendaftaran`),
  ADD KEY `ifbk_rw_idbarang` (`id_barang`),
  ADD KEY `ifbk_status_acc_2` (`id_status_acc`);

--
-- Indeks untuk tabel `tbl_pendaftaran_riwayat_tindakan`
--
ALTER TABLE `tbl_pendaftaran_riwayat_tindakan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_tindakan_id` (`id_tindakan`),
  ADD KEY `ifbk_tdkn_dokter` (`id_dokter`),
  ADD KEY `ibfk_tdkn_pegawai` (`id_pegawai`),
  ADD KEY `ibfk_tdkn_pdftrn` (`id_pendaftaran`);

--
-- Indeks untuk tabel `tbl_poliklinik`
--
ALTER TABLE `tbl_poliklinik`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_rs_gedung`
--
ALTER TABLE `tbl_rs_gedung`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_rs_ruang`
--
ALTER TABLE `tbl_rs_ruang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_gedung_1` (`id_ranap_gedung`),
  ADD KEY `ifbk_kelas_1` (`id_ruang_kelas`);

--
-- Indeks untuk tabel `tbl_rs_ruang_kelas`
--
ALTER TABLE `tbl_rs_ruang_kelas`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_rs_tempat_tidur`
--
ALTER TABLE `tbl_rs_tempat_tidur`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_status_acc`
--
ALTER TABLE `tbl_status_acc`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_status_menikah`
--
ALTER TABLE `tbl_status_menikah`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_tindakan`
--
ALTER TABLE `tbl_tindakan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ifbk_id_kat_3` (`kode_kategori_tindakan`);

--
-- Indeks untuk tabel `tbl_tindakan_kategori`
--
ALTER TABLE `tbl_tindakan_kategori`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_kategori_tindakan` (`kode_kategori_tindakan`);

--
-- Indeks untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id_users`);

--
-- Indeks untuk tabel `tbl_user_level`
--
ALTER TABLE `tbl_user_level`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `abc`
--
ALTER TABLE `abc`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `bh_pasien`
--
ALTER TABLE `bh_pasien`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `bh_pendaftaran_pasien_baru`
--
ALTER TABLE `bh_pendaftaran_pasien_baru`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `bh_pendaftaran_pasien_lama`
--
ALTER TABLE `bh_pendaftaran_pasien_lama`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `bh_pendaftaran_ranap`
--
ALTER TABLE `bh_pendaftaran_ranap`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_agama`
--
ALTER TABLE `tbl_agama`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tbl_antrean`
--
ALTER TABLE `tbl_antrean`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_antrean_type`
--
ALTER TABLE `tbl_antrean_type`
  MODIFY `id_tipe_antrean` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_barang`
--
ALTER TABLE `tbl_barang`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=952;

--
-- AUTO_INCREMENT untuk tabel `tbl_barang_kategori`
--
ALTER TABLE `tbl_barang_kategori`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_barang_kat_harga`
--
ALTER TABLE `tbl_barang_kat_harga`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_barang_kelompok`
--
ALTER TABLE `tbl_barang_kelompok`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_barang_mutasi`
--
ALTER TABLE `tbl_barang_mutasi`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT untuk tabel `tbl_barang_pengadaan`
--
ALTER TABLE `tbl_barang_pengadaan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tbl_barang_pengadaan_detail`
--
ALTER TABLE `tbl_barang_pengadaan_detail`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `tbl_barang_satuan`
--
ALTER TABLE `tbl_barang_satuan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `tbl_barang_supplier`
--
ALTER TABLE `tbl_barang_supplier`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT untuk tabel `tbl_departemen`
--
ALTER TABLE `tbl_departemen`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tbl_deposit_mutasi`
--
ALTER TABLE `tbl_deposit_mutasi`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_diagnosa_penyakit`
--
ALTER TABLE `tbl_diagnosa_penyakit`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_dokter`
--
ALTER TABLE `tbl_dokter`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT untuk tabel `tbl_dokter_jadwal`
--
ALTER TABLE `tbl_dokter_jadwal`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=290;

--
-- AUTO_INCREMENT untuk tabel `tbl_dokter_spesialis`
--
ALTER TABLE `tbl_dokter_spesialis`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `tbl_gol_darah`
--
ALTER TABLE `tbl_gol_darah`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_jabatan`
--
ALTER TABLE `tbl_jabatan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tbl_jenis_bayar`
--
ALTER TABLE `tbl_jenis_bayar`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_jenis_kelamin`
--
ALTER TABLE `tbl_jenis_kelamin`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_jenjang`
--
ALTER TABLE `tbl_jenjang`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_jenjang_pendidikan`
--
ALTER TABLE `tbl_jenjang_pendidikan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_menu`
--
ALTER TABLE `tbl_menu`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT untuk tabel `tbl_menu_akses`
--
ALTER TABLE `tbl_menu_akses`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_pasien`
--
ALTER TABLE `tbl_pasien`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT untuk tabel `tbl_pasien_cara_masuk`
--
ALTER TABLE `tbl_pasien_cara_masuk`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_pasien_hub_pj`
--
ALTER TABLE `tbl_pasien_hub_pj`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `tbl_pasien_rekamedis`
--
ALTER TABLE `tbl_pasien_rekamedis`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tbl_pasien_riwayat_perjalanan`
--
ALTER TABLE `tbl_pasien_riwayat_perjalanan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `tbl_pasien_status_rawat`
--
ALTER TABLE `tbl_pasien_status_rawat`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `tbl_pegawai`
--
ALTER TABLE `tbl_pegawai`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_pegawai_bidang`
--
ALTER TABLE `tbl_pegawai_bidang`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_pegawai_departemen`
--
ALTER TABLE `tbl_pegawai_departemen`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_pegawai_jabatan`
--
ALTER TABLE `tbl_pegawai_jabatan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_pekerjaan`
--
ALTER TABLE `tbl_pekerjaan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_pendaftaran`
--
ALTER TABLE `tbl_pendaftaran`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tbl_pendaftaran_diary`
--
ALTER TABLE `tbl_pendaftaran_diary`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_pendaftaran_mutasi`
--
ALTER TABLE `tbl_pendaftaran_mutasi`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `tbl_pendaftaran_ranap`
--
ALTER TABLE `tbl_pendaftaran_ranap`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_pendaftaran_riwayat_obat`
--
ALTER TABLE `tbl_pendaftaran_riwayat_obat`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tbl_pendaftaran_riwayat_tindakan`
--
ALTER TABLE `tbl_pendaftaran_riwayat_tindakan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_poliklinik`
--
ALTER TABLE `tbl_poliklinik`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT untuk tabel `tbl_rs_gedung`
--
ALTER TABLE `tbl_rs_gedung`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `tbl_rs_ruang`
--
ALTER TABLE `tbl_rs_ruang`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `tbl_rs_ruang_kelas`
--
ALTER TABLE `tbl_rs_ruang_kelas`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tbl_rs_tempat_tidur`
--
ALTER TABLE `tbl_rs_tempat_tidur`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT untuk tabel `tbl_status_acc`
--
ALTER TABLE `tbl_status_acc`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_status_menikah`
--
ALTER TABLE `tbl_status_menikah`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tbl_tindakan`
--
ALTER TABLE `tbl_tindakan`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `tbl_tindakan_kategori`
--
ALTER TABLE `tbl_tindakan_kategori`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id_users` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_user_level`
--
ALTER TABLE `tbl_user_level`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD CONSTRAINT `ifbk_kat_1` FOREIGN KEY (`id_kat_barang`) REFERENCES `tbl_barang_kategori` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_kat_harga_1` FOREIGN KEY (`id_kat_harga`) REFERENCES `tbl_barang_kat_harga` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_satuan_1` FOREIGN KEY (`id_satuan_barang`) REFERENCES `tbl_barang_satuan` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_barang_kategori`
--
ALTER TABLE `tbl_barang_kategori`
  ADD CONSTRAINT `ifbk_kat_kel_1` FOREIGN KEY (`id_kelompok`) REFERENCES `tbl_barang_kelompok` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_barang_mutasi`
--
ALTER TABLE `tbl_barang_mutasi`
  ADD CONSTRAINT `ifbk_brg_1` FOREIGN KEY (`id_barang`) REFERENCES `tbl_barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_barang_pengadaan`
--
ALTER TABLE `tbl_barang_pengadaan`
  ADD CONSTRAINT `ifbk_brg_supplier_1` FOREIGN KEY (`id_supplier`) REFERENCES `tbl_barang_supplier` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_barang_pengadaan_detail`
--
ALTER TABLE `tbl_barang_pengadaan_detail`
  ADD CONSTRAINT `ifbk_barang_1` FOREIGN KEY (`id_barang`) REFERENCES `tbl_barang` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pengadaan_1` FOREIGN KEY (`id_barang_pengadaan`) REFERENCES `tbl_barang_pengadaan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_dokter`
--
ALTER TABLE `tbl_dokter`
  ADD CONSTRAINT `ifbk_dok_agama_1` FOREIGN KEY (`id_agama`) REFERENCES `tbl_agama` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_dok_jk_1` FOREIGN KEY (`id_jenis_kelamin`) REFERENCES `tbl_jenis_kelamin` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_dok_spesialis_1` FOREIGN KEY (`id_spesialis`) REFERENCES `tbl_dokter_spesialis` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_dokter_gol_darah_1` FOREIGN KEY (`id_gol_darah`) REFERENCES `tbl_gol_darah` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_status_nikah_1` FOREIGN KEY (`id_status_menikah`) REFERENCES `tbl_status_menikah` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_pasien`
--
ALTER TABLE `tbl_pasien`
  ADD CONSTRAINT `ibfk_pasien_nikah_1` FOREIGN KEY (`id_status_pernikahan`) REFERENCES `tbl_status_menikah` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pasien_agama_1` FOREIGN KEY (`id_agama`) REFERENCES `tbl_agama` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pasien_gol_darah_1` FOREIGN KEY (`id_gol_darah`) REFERENCES `tbl_gol_darah` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pasien_jk` FOREIGN KEY (`id_jenis_kelamin`) REFERENCES `tbl_jenis_kelamin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pasien_pekerjaan_1` FOREIGN KEY (`id_pekerjaan`) REFERENCES `tbl_pekerjaan` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_pasien_rekamedis`
--
ALTER TABLE `tbl_pasien_rekamedis`
  ADD CONSTRAINT `ifbk_rm_pasien_1` FOREIGN KEY (`id_pasien`) REFERENCES `tbl_pasien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_pasien_riwayat_perjalanan`
--
ALTER TABLE `tbl_pasien_riwayat_perjalanan`
  ADD CONSTRAINT `ifbk_rekamedis_2` FOREIGN KEY (`id_rekamedis`) REFERENCES `tbl_pasien_rekamedis` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_pegawai`
--
ALTER TABLE `tbl_pegawai`
  ADD CONSTRAINT `ibfk_pg_jenjang_karir` FOREIGN KEY (`id_jenjang`) REFERENCES `tbl_jenjang` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_agama_1` FOREIGN KEY (`id_agama`) REFERENCES `tbl_agama` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pg_bidang_1` FOREIGN KEY (`id_bidang`) REFERENCES `tbl_pegawai_bidang` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_pg_departemen_1` FOREIGN KEY (`id_departemen`) REFERENCES `tbl_pegawai_departemen` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pg_gol_darah_1` FOREIGN KEY (`id_gol_darah`) REFERENCES `tbl_gol_darah` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pg_jabatan_1` FOREIGN KEY (`id_jabatan`) REFERENCES `tbl_jabatan` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pg_jenjang_pdkn` FOREIGN KEY (`id_jenjang_pendidikan`) REFERENCES `tbl_jenjang_pendidikan` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pg_jk` FOREIGN KEY (`id_jenis_kelamin`) REFERENCES `tbl_jenis_kelamin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_pg_status_nikah` FOREIGN KEY (`id_status_menikah`) REFERENCES `tbl_status_menikah` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_pendaftaran`
--
ALTER TABLE `tbl_pendaftaran`
  ADD CONSTRAINT `ifbk_cara_masuk_1` FOREIGN KEY (`id_cara_masuk`) REFERENCES `tbl_pasien_cara_masuk` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_dok_pj_1` FOREIGN KEY (`id_pj_dokter`) REFERENCES `tbl_dokter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_dok_poli_1` FOREIGN KEY (`id_poli`) REFERENCES `tbl_poliklinik` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_jenis_bayar_1` FOREIGN KEY (`id_jenis_bayar`) REFERENCES `tbl_jenis_bayar` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_rekamedis_1` FOREIGN KEY (`id_rekamedis`) REFERENCES `tbl_pasien_rekamedis` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_status_rawat_1` FOREIGN KEY (`id_status_rawat`) REFERENCES `tbl_pasien_status_rawat` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_pendaftaran_mutasi`
--
ALTER TABLE `tbl_pendaftaran_mutasi`
  ADD CONSTRAINT `ifbk_pasien_pdftrn_1` FOREIGN KEY (`id_pendaftaran`) REFERENCES `tbl_pendaftaran` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_pendaftaran_riwayat_obat`
--
ALTER TABLE `tbl_pendaftaran_riwayat_obat`
  ADD CONSTRAINT `ifbk_rw_idbarang` FOREIGN KEY (`id_barang`) REFERENCES `tbl_barang` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_rw_iddaftar_1` FOREIGN KEY (`id_pendaftaran`) REFERENCES `tbl_pendaftaran` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ifbk_status_acc_2` FOREIGN KEY (`id_status_acc`) REFERENCES `tbl_status_acc` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_pendaftaran_riwayat_tindakan`
--
ALTER TABLE `tbl_pendaftaran_riwayat_tindakan`
  ADD CONSTRAINT `ibfk_tdkn_pdftrn` FOREIGN KEY (`id_pendaftaran`) REFERENCES `tbl_pendaftaran` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ibfk_tdkn_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `tbl_pegawai` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_tdkn_dokter` FOREIGN KEY (`id_dokter`) REFERENCES `tbl_dokter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_tindakan_id` FOREIGN KEY (`id_tindakan`) REFERENCES `tbl_tindakan` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_rs_ruang`
--
ALTER TABLE `tbl_rs_ruang`
  ADD CONSTRAINT `ifbk_gedung_1` FOREIGN KEY (`id_ranap_gedung`) REFERENCES `tbl_rs_gedung` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `ifbk_kelas_1` FOREIGN KEY (`id_ruang_kelas`) REFERENCES `tbl_rs_ruang_kelas` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `tbl_tindakan`
--
ALTER TABLE `tbl_tindakan`
  ADD CONSTRAINT `ifbk_id_kat_3` FOREIGN KEY (`kode_kategori_tindakan`) REFERENCES `tbl_tindakan_kategori` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;