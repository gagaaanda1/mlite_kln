/*
 Navicat Premium Data Transfer

 Source Server         : LOCAL_PC
 Source Server Type    : MySQL
 Source Server Version : 80030
 Source Host           : localhost:3306
 Source Schema         : mlite

 Target Server Type    : MySQL
 Target Server Version : 80030
 File Encoding         : 65001

 Date: 10/07/2026 11:31:39
*/

SET sql_mode = '';

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aturan_pakai
-- ----------------------------
DROP TABLE IF EXISTS `aturan_pakai`;
CREATE TABLE `aturan_pakai`  (
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam` time NOT NULL DEFAULT '00:00:00',
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `kode_brng` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `aturan` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tgl_perawatan`, `jam`, `no_rawat`, `kode_brng`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kode_brng`(`kode_brng` ASC) USING BTREE,
  CONSTRAINT `aturan_pakai_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aturan_pakai_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aturan_pakai
-- ----------------------------

-- ----------------------------
-- Table structure for bahasa_pasien
-- ----------------------------
DROP TABLE IF EXISTS `bahasa_pasien`;
CREATE TABLE `bahasa_pasien`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_bahasa` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nama_bahasa`(`nama_bahasa` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of bahasa_pasien
-- ----------------------------
INSERT INTO `bahasa_pasien` VALUES (1, '-');

-- ----------------------------
-- Table structure for bangsal
-- ----------------------------
DROP TABLE IF EXISTS `bangsal`;
CREATE TABLE `bangsal`  (
  `kd_bangsal` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_bangsal` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_bangsal`) USING BTREE,
  INDEX `nm_bangsal`(`nm_bangsal` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bangsal
-- ----------------------------
INSERT INTO `bangsal` VALUES ('-', '-', '1');
INSERT INTO `bangsal` VALUES ('ANG', 'Anggrek', '1');
INSERT INTO `bangsal` VALUES ('APT', 'Apotek', '1');
INSERT INTO `bangsal` VALUES ('GF', 'Gudang Farmasi', '1');
INSERT INTO `bangsal` VALUES ('OBL', 'obatluar', '1');

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank`  (
  `namabank` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`namabank`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bank
-- ----------------------------
INSERT INTO `bank` VALUES ('-');
INSERT INTO `bank` VALUES ('T');

-- ----------------------------
-- Table structure for barcode
-- ----------------------------
DROP TABLE IF EXISTS `barcode`;
CREATE TABLE `barcode`  (
  `id` int NOT NULL,
  `barcode` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `barcode`(`barcode` ASC) USING BTREE,
  CONSTRAINT `barcode_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of barcode
-- ----------------------------

-- ----------------------------
-- Table structure for beri_obat_operasi
-- ----------------------------
DROP TABLE IF EXISTS `beri_obat_operasi`;
CREATE TABLE `beri_obat_operasi`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_obat` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `hargasatuan` double NOT NULL,
  `jumlah` double NOT NULL,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kd_obat`(`kd_obat` ASC) USING BTREE,
  INDEX `tanggal`(`tanggal` ASC) USING BTREE,
  INDEX `hargasatuan`(`hargasatuan` ASC) USING BTREE,
  INDEX `jumlah`(`jumlah` ASC) USING BTREE,
  CONSTRAINT `beri_obat_operasi_ibfk_2` FOREIGN KEY (`kd_obat`) REFERENCES `obatbhp_ok` (`kd_obat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `beri_obat_operasi_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of beri_obat_operasi
-- ----------------------------

-- ----------------------------
-- Table structure for berkas_digital_perawatan
-- ----------------------------
DROP TABLE IF EXISTS `berkas_digital_perawatan`;
CREATE TABLE `berkas_digital_perawatan`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lokasi_file` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode`, `lokasi_file`) USING BTREE,
  INDEX `kode`(`kode` ASC) USING BTREE,
  CONSTRAINT `berkas_digital_perawatan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `berkas_digital_perawatan_ibfk_2` FOREIGN KEY (`kode`) REFERENCES `master_berkas_digital` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of berkas_digital_perawatan
-- ----------------------------

-- ----------------------------
-- Table structure for bidang
-- ----------------------------
DROP TABLE IF EXISTS `bidang`;
CREATE TABLE `bidang`  (
  `nama` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`nama`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bidang
-- ----------------------------
INSERT INTO `bidang` VALUES ('-');

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `id` int NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `slug` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `cover_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `status` int NOT NULL,
  `comments` int NULL DEFAULT NULL,
  `markdown` int NULL DEFAULT NULL,
  `published_at` int NULL DEFAULT NULL,
  `updated_at` int NOT NULL,
  `created_at` int NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES (1, 'Let’s put a smile on that face', 'lets-put-a-smile-on-that-face', 1, '<p>Every man who has lotted here over the centuries, has looked up to the light and imagined climbing to freedom. So easy, so simple! And like shipwrecked men turning to seawater foregoing uncontrollable thirst, many have died trying. And then here there can be no true despair without hope. So as I terrorize Gotham, I will feed its people hope to poison their souls. I will let them believe that they can survive so that you can watch them climbing over each other to stay in the sun. You can watch me torture an entire city. And then when you’ve truly understood the depth of your failure, we will fulfill Ra’s Al Ghul’s destiny. We will destroy Gotham. And then, when that is done, and Gotham is... ashes Then you have my permission to die.</p>', '<p>You wanna know how I got these scars? My father was… a drinker, and a fiend. And one night, he goes off crazier than usual. Mommy gets the kitchen knife to defend herself. He doesn’t like that, not one bit. So, me watching he takes the knife to her, laughing while he does it.</p>', 'default.jpg', 2, 1, 0, 1735819776, 1735819776, 1735819776);

-- ----------------------------
-- Table structure for blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `blog_tags`;
CREATE TABLE `blog_tags`  (
  `id` int NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `slug` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog_tags
-- ----------------------------
INSERT INTO `blog_tags` VALUES (1, 'hello world', 'hello-world');
INSERT INTO `blog_tags` VALUES (2, 'imedic', 'imedic');

-- ----------------------------
-- Table structure for blog_tags_relationship
-- ----------------------------
DROP TABLE IF EXISTS `blog_tags_relationship`;
CREATE TABLE `blog_tags_relationship`  (
  `blog_id` int NOT NULL,
  `tag_id` int NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog_tags_relationship
-- ----------------------------
INSERT INTO `blog_tags_relationship` VALUES (1, 1);
INSERT INTO `blog_tags_relationship` VALUES (1, 2);

-- ----------------------------
-- Table structure for booking_operasi
-- ----------------------------
DROP TABLE IF EXISTS `booking_operasi`;
CREATE TABLE `booking_operasi`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kode_paket` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `jam_mulai` time NULL DEFAULT NULL,
  `jam_selesai` time NULL DEFAULT NULL,
  `status` enum('Menunggu','Proses Operasi','Selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_ruang_ok` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kode_paket`(`kode_paket` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `kd_ruang_ok`(`kd_ruang_ok` ASC) USING BTREE,
  CONSTRAINT `booking_operasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_2` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_4` FOREIGN KEY (`kd_ruang_ok`) REFERENCES `ruang_ok` (`kd_ruang_ok`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booking_operasi
-- ----------------------------

-- ----------------------------
-- Table structure for booking_periksa
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa`;
CREATE TABLE `booking_periksa`  (
  `no_booking` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `nama` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alamat` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_telp` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_poli` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tambahan_pesan` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` enum('Diterima','Ditolak','Belum Dibalas') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tanggal_booking` datetime NOT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE,
  UNIQUE INDEX `tanggal`(`tanggal` ASC, `no_telp` ASC) USING BTREE,
  INDEX `kd_poli`(`kd_poli` ASC) USING BTREE,
  CONSTRAINT `booking_periksa_ibfk_1` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booking_periksa
-- ----------------------------

-- ----------------------------
-- Table structure for booking_periksa_balasan
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa_balasan`;
CREATE TABLE `booking_periksa_balasan`  (
  `no_booking` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `balasan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE,
  CONSTRAINT `booking_periksa_balasan_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking_periksa` (`no_booking`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booking_periksa_balasan
-- ----------------------------

-- ----------------------------
-- Table structure for booking_periksa_diterima
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa_diterima`;
CREATE TABLE `booking_periksa_diterima`  (
  `no_booking` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis` ASC) USING BTREE,
  CONSTRAINT `booking_periksa_diterima_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking_periksa` (`no_booking`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_periksa_diterima_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booking_periksa_diterima
-- ----------------------------

-- ----------------------------
-- Table structure for booking_registrasi
-- ----------------------------
DROP TABLE IF EXISTS `booking_registrasi`;
CREATE TABLE `booking_registrasi`  (
  `tanggal_booking` date NULL DEFAULT NULL,
  `jam_booking` time NULL DEFAULT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tanggal_periksa` date NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_poli` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_reg` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_pj` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `limit_reg` int NULL DEFAULT NULL,
  `waktu_kunjungan` datetime NULL DEFAULT NULL,
  `status` enum('Terdaftar','Belum','Batal','Dokter Berhalangan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`, `tanggal_periksa`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `kd_poli`(`kd_poli` ASC) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis` ASC) USING BTREE,
  INDEX `kd_pj`(`kd_pj` ASC) USING BTREE,
  CONSTRAINT `booking_registrasi_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_registrasi_ibfk_2` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_registrasi_ibfk_3` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_registrasi_ibfk_4` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booking_registrasi
-- ----------------------------

-- ----------------------------
-- Table structure for bpjs_prb
-- ----------------------------
DROP TABLE IF EXISTS `bpjs_prb`;
CREATE TABLE `bpjs_prb`  (
  `no_sep` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prb` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_sep`) USING BTREE,
  CONSTRAINT `bpjs_prb_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bpjs_prb
-- ----------------------------

-- ----------------------------
-- Table structure for bridging_pcare
-- ----------------------------
DROP TABLE IF EXISTS `bridging_pcare`;
CREATE TABLE `bridging_pcare`  (
  `id` int NULL DEFAULT NULL,
  `id_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_pasien` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tgl_daftar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nomor_kunjungan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_provider_peserta` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nomor_jaminan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_poli` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_poli` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kunjungan_sakit` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sistole` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `diastole` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nadi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `respirasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tinggi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `berat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `lingkar_perut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `rujuk_balik` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `subyektif` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_tkp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nomor_urut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_kesadaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_kesadaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `terapi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_status_pulang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_status_pulang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tgl_pulang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tgl_kunjungan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_dokter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_dokter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_diagnosa1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_diagnosa1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_diagnosa2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_diagnosa2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_diagnosa3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_diagnosa3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tgl_estimasi_rujuk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_ppk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_ppk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_spesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_spesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_subspesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_subspesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_sarana` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_sarana` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_referensikhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_referensikhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_faskeskhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_faskeskhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_tacc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_tacc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `alasan_tacc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status_kirim` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kode_alergi_makanan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_alergi_makanan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_alergi_udara` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_alergi_udara` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_alergi_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_alergi_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_prognosa` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_prognosa` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `terapi_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `terapi_non_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bridging_pcare
-- ----------------------------

-- ----------------------------
-- Table structure for bridging_rujukan_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bridging_rujukan_bpjs`;
CREATE TABLE `bridging_rujukan_bpjs`  (
  `no_sep` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tglRujukan` date NULL DEFAULT NULL,
  `tglRencanaKunjungan` date NOT NULL,
  `ppkDirujuk` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_ppkDirujuk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jnsPelayanan` enum('1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `catatan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `diagRujukan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_diagRujukan` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tipeRujukan` enum('0. Penuh','1. Partial','2. Rujuk Balik') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `poliRujukan` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_poliRujukan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_rujukan` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rujukan`) USING BTREE,
  INDEX `no_sep`(`no_sep` ASC) USING BTREE,
  CONSTRAINT `bridging_rujukan_bpjs_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bridging_rujukan_bpjs
-- ----------------------------

-- ----------------------------
-- Table structure for bridging_sep
-- ----------------------------
DROP TABLE IF EXISTS `bridging_sep`;
CREATE TABLE `bridging_sep`  (
  `no_sep` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tglsep` date NULL DEFAULT NULL,
  `tglrujukan` date NULL DEFAULT NULL,
  `no_rujukan` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kdppkrujukan` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nmppkrujukan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kdppkpelayanan` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nmppkpelayanan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jnspelayanan` enum('1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `catatan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `diagawal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nmdiagnosaawal` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kdpolitujuan` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nmpolitujuan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `klsrawat` enum('1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `klsnaik` enum('','1','2','3','4','5','6','7') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pembiayaan` enum('','1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pjnaikkelas` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lakalantas` enum('0','1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nomr` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_pasien` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal_lahir` date NULL DEFAULT NULL,
  `peserta` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jkel` enum('L','P') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_kartu` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tglpulang` datetime NULL DEFAULT NULL,
  `asal_rujukan` enum('1. Faskes 1','2. Faskes 2(RS)') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `eksekutif` enum('0. Tidak','1.Ya') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cob` enum('0. Tidak','1.Ya') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `notelep` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `katarak` enum('0. Tidak','1.Ya') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tglkkl` date NOT NULL,
  `keterangankkl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `suplesi` enum('0. Tidak','1.Ya') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_sep_suplesi` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kdprop` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmprop` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kdkab` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmkab` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kdkec` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmkec` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `noskdp` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kddpjp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmdpdjp` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tujuankunjungan` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `flagprosedur` enum('','0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `penunjang` enum('','1','2','3','4','5','6','7','8','9','10','11','12') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `asesmenpelayanan` enum('','1','2','3','4','5') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kddpjplayanan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmdpjplayanan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`no_sep`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  CONSTRAINT `bridging_sep_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bridging_sep
-- ----------------------------

-- ----------------------------
-- Table structure for bridging_sep_internal
-- ----------------------------
DROP TABLE IF EXISTS `bridging_sep_internal`;
CREATE TABLE `bridging_sep_internal`  (
  `no_sep` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tglsep` date NULL DEFAULT NULL,
  `tglrujukan` date NULL DEFAULT NULL,
  `no_rujukan` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kdppkrujukan` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nmppkrujukan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kdppkpelayanan` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nmppkpelayanan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jnspelayanan` enum('1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `catatan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `diagawal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nmdiagnosaawal` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kdpolitujuan` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nmpolitujuan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `klsrawat` enum('1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `klsnaik` enum('','1','2','3','4','5','6','7') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pembiayaan` enum('','1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pjnaikkelas` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lakalantas` enum('0','1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nomr` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_pasien` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal_lahir` date NULL DEFAULT NULL,
  `peserta` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jkel` enum('L','P') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_kartu` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tglpulang` datetime NULL DEFAULT NULL,
  `asal_rujukan` enum('1. Faskes 1','2. Faskes 2(RS)') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `eksekutif` enum('0. Tidak','1.Ya') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cob` enum('0. Tidak','1.Ya') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `notelep` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `katarak` enum('0. Tidak','1.Ya') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tglkkl` date NOT NULL,
  `keterangankkl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `suplesi` enum('0. Tidak','1.Ya') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_sep_suplesi` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kdprop` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmprop` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kdkab` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmkab` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kdkec` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmkec` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `noskdp` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kddpjp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmdpdjp` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tujuankunjungan` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `flagprosedur` enum('','0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `penunjang` enum('','1','2','3','4','5','6','7','8','9','10','11','12') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `asesmenpelayanan` enum('','1','2','3','4','5') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kddpjplayanan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nmdpjplayanan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `no_sep`(`no_sep` ASC) USING BTREE,
  CONSTRAINT `bridging_sep_internal_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bridging_sep_internal_ibfk_2` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bridging_sep_internal
-- ----------------------------

-- ----------------------------
-- Table structure for bridging_srb_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bridging_srb_bpjs`;
CREATE TABLE `bridging_srb_bpjs`  (
  `no_sep` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_srb` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_srb` date NULL DEFAULT NULL,
  `alamat` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kodeprogram` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `namaprogram` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kodedpjp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nmdpjp` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `saran` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_sep`, `no_srb`) USING BTREE,
  CONSTRAINT `bridging_srb_bpjs_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bridging_srb_bpjs
-- ----------------------------

-- ----------------------------
-- Table structure for bridging_surat_kontrol_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bridging_surat_kontrol_bpjs`;
CREATE TABLE `bridging_surat_kontrol_bpjs`  (
  `no_sep` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_surat` date NOT NULL,
  `no_surat` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_rencana` date NULL DEFAULT NULL,
  `kd_dokter_bpjs` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_dokter_bpjs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_poli_bpjs` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_poli_bpjs` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_surat`) USING BTREE,
  INDEX `bridging_surat_kontrol_bpjs_ibfk_1`(`no_sep` ASC) USING BTREE,
  CONSTRAINT `bridging_surat_kontrol_bpjs_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bridging_surat_kontrol_bpjs
-- ----------------------------

-- ----------------------------
-- Table structure for bridging_surat_pri_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bridging_surat_pri_bpjs`;
CREATE TABLE `bridging_surat_pri_bpjs`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_kartu` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_surat` date NOT NULL,
  `no_surat` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_rencana` date NULL DEFAULT NULL,
  `kd_dokter_bpjs` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_dokter_bpjs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_poli_bpjs` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_poli_bpjs` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `diagnosa` varchar(130) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_sep` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`no_surat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  CONSTRAINT `bridging_surat_pri_bpjs_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bridging_surat_pri_bpjs
-- ----------------------------

-- ----------------------------
-- Table structure for cacat_fisik
-- ----------------------------
DROP TABLE IF EXISTS `cacat_fisik`;
CREATE TABLE `cacat_fisik`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_cacat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nama_cacat`(`nama_cacat` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cacat_fisik
-- ----------------------------
INSERT INTO `cacat_fisik` VALUES (1, '-');

-- ----------------------------
-- Table structure for catatan_adime_gizi
-- ----------------------------
DROP TABLE IF EXISTS `catatan_adime_gizi`;
CREATE TABLE `catatan_adime_gizi`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `asesmen` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `diagnosis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `intervensi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `monitoring` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `evaluasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `instruksi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  CONSTRAINT `catatan_adime_gizi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_adime_gizi_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of catatan_adime_gizi
-- ----------------------------

-- ----------------------------
-- Table structure for catatan_perawatan
-- ----------------------------
DROP TABLE IF EXISTS `catatan_perawatan`;
CREATE TABLE `catatan_perawatan`  (
  `tanggal` date NULL DEFAULT NULL,
  `jam` time NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `catatan` varchar(700) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `catatan_perawatan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_perawatan_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of catatan_perawatan
-- ----------------------------

-- ----------------------------
-- Table structure for data_tb
-- ----------------------------
DROP TABLE IF EXISTS `data_tb`;
CREATE TABLE `data_tb`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_tb_03` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_periode_laporan` enum('1=Januari - Maret','2=April - Juni','3=Juli - September','4=Oktober - Desember') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal_buat_laporan` datetime NULL DEFAULT NULL,
  `tahun_buat_laporan` year NULL DEFAULT NULL,
  `kd_wasor` int NULL DEFAULT NULL,
  `noregkab` int NULL DEFAULT NULL,
  `id_propinsi` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_kabupaten` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_kecamatan` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_kelurahan` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_rujukan` enum('Inisiatif pasien/Keluarga','Anggota Masyarakat/Kader','Faskes','Dokter Praktek Mandiri','Poli lain','Lain-lain') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sebutkan1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tipe_diagnosis` enum('Terkonfirmasi bakteriologis','Terdiagnosis klinis') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `klasifikasi_lokasi_anatomi` enum('Paru','Ekstraparu') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `klasifikasi_riwayat_pengobatan` enum('Baru','Kambuh','Diobati setelah gagal','Diobati Setelah Putus Berobat','Lain-lain','Riwayat Pengobatan Sebelumnya Tidak Diketahui','Pindahan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `klasifikasi_status_hiv` enum('Positif','Negatif','Tidak diketahui') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total_skoring_anak` enum('1','2','3','4','5','6','7','8','9','10','11','12','13','Tidak dilakukan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `konfirmasiSkoring5` enum('Uji Tuberkulin Positif','Ada Kontak TB Paru','Uji Tuberkulin Negatif','Tidak Ada Kontak TB Paru') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `konfirmasiSkoring6` enum('Ada Kontak TB Paru','Tidak Ada','Tidak Jelas Kontak TB Paru') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal_mulai_pengobatan` date NULL DEFAULT NULL,
  `paduan_oat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sumber_obat` enum('Program TB','Bayar Sendiri','Asuransi','Lain-lain') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sebutkan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sebelum_pengobatan_hasil_mikroskopis` enum('Negatif','1-19','1+','2+','3+','Tidak dilakukan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sebelum_pengobatan_hasil_tes_cepat` enum('Rif sensitif','Rif resisten','Negatif','Rif Indeterminated','Invalid','Error','No Result','Tidak dilakukan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sebelum_pengobatan_hasil_biakan` enum('Negatif','1-19 BTA','1+','2+','3+','4+','NTM','Kontaminasi','Tidak dilakukan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `noreglab_bulan_2` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hasil_mikroskopis_bulan_2` enum('Negatif','1-19','1+','2+','3+','Tidak dilakukan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `noreglab_bulan_3` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hasil_mikroskopis_bulan_3` enum('Negatif','1-19','1+','2+','3+','Tidak dilakukan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `noreglab_bulan_5` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hasil_mikroskopis_bulan_5` enum('Negatif','1-19','1+','2+','3+','Tidak dilakukan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `akhir_pengobatan_noreglab` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `akhir_pengobatan_hasil_mikroskopis` enum('Negatif','1-19','1+','2+','3+','Tidak dilakukan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal_hasil_akhir_pengobatan` date NULL DEFAULT NULL,
  `hasil_akhir_pengobatan` enum('Belum','Sembuh','Pengobatan Lengkap','Lost To Follow Up','Meninggal','Gagal','Pindah','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal_dianjurkan_tes` date NULL DEFAULT NULL,
  `tanggal_tes_hiv` date NULL DEFAULT NULL,
  `hasil_tes_hiv` enum('Reaktif','Non Reaktif','Indeterminated') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ppk` enum('Ya','Tidak') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `art` enum('Ya','Tidak') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tb_dm` enum('Ya','Tidak') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `terapi_dm` enum('OHO','Inj. Insulin','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pindah_ro` enum('Ya','Tidak') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status_pengobatan` enum('Sesuai Standar','Tidak Sesuai Standar') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `foto_toraks` enum('Positif','Negatif','Tidak Dilakukan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `toraks_tdk_dilakukan` enum('Tidak dilakukan','Setelah terapi antibioka non OAT: tidak ada perbaikan Klinis, ada faktor resiko TB, dan atas pertimbangan dokter','Setelah terapi antibioka non OAT: ada Perbaikan Klinis') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kode_icd_x` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kode_icd_x`(`kode_icd_x` ASC) USING BTREE,
  CONSTRAINT `data_tb_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_tb_ibfk_2` FOREIGN KEY (`kode_icd_x`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of data_tb
-- ----------------------------

-- ----------------------------
-- Table structure for databarang
-- ----------------------------
DROP TABLE IF EXISTS `databarang`;
CREATE TABLE `databarang`  (
  `kode_brng` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `nama_brng` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kode_satbesar` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `letak_barang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dasar` double NOT NULL,
  `h_beli` double NULL DEFAULT NULL,
  `ralan` double NULL DEFAULT NULL,
  `kelas1` double NULL DEFAULT NULL,
  `kelas2` double NULL DEFAULT NULL,
  `kelas3` double NULL DEFAULT NULL,
  `utama` double NULL DEFAULT NULL,
  `vip` double NULL DEFAULT NULL,
  `vvip` double NULL DEFAULT NULL,
  `beliluar` double NULL DEFAULT NULL,
  `jualbebas` double NULL DEFAULT NULL,
  `karyawan` double NULL DEFAULT NULL,
  `stokminimal` double NULL DEFAULT NULL,
  `kdjns` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `isi` double NOT NULL,
  `kapasitas` double NOT NULL,
  `expire` date NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kode_industri` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kode_kategori` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kode_golongan` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat` ASC) USING BTREE,
  INDEX `kdjns`(`kdjns` ASC) USING BTREE,
  INDEX `nama_brng`(`nama_brng` ASC) USING BTREE,
  INDEX `letak_barang`(`letak_barang` ASC) USING BTREE,
  INDEX `h_beli`(`h_beli` ASC) USING BTREE,
  INDEX `h_distributor`(`ralan` ASC) USING BTREE,
  INDEX `h_grosir`(`kelas1` ASC) USING BTREE,
  INDEX `h_retail`(`kelas2` ASC) USING BTREE,
  INDEX `stok`(`stokminimal` ASC) USING BTREE,
  INDEX `kapasitas`(`kapasitas` ASC) USING BTREE,
  INDEX `kode_industri`(`kode_industri` ASC) USING BTREE,
  INDEX `kelas3`(`kelas3` ASC) USING BTREE,
  INDEX `utama`(`utama` ASC) USING BTREE,
  INDEX `vip`(`vip` ASC) USING BTREE,
  INDEX `vvip`(`vvip` ASC) USING BTREE,
  INDEX `beliluar`(`beliluar` ASC) USING BTREE,
  INDEX `jualbebas`(`jualbebas` ASC) USING BTREE,
  INDEX `karyawan`(`karyawan` ASC) USING BTREE,
  INDEX `expire`(`expire` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `kode_kategori`(`kode_kategori` ASC) USING BTREE,
  INDEX `kode_golongan`(`kode_golongan` ASC) USING BTREE,
  INDEX `kode_satbesar`(`kode_satbesar` ASC) USING BTREE,
  CONSTRAINT `databarang_ibfk_2` FOREIGN KEY (`kdjns`) REFERENCES `jenis` (`kdjns`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_4` FOREIGN KEY (`kode_industri`) REFERENCES `industrifarmasi` (`kode_industri`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_5` FOREIGN KEY (`kode_kategori`) REFERENCES `kategori_barang` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_6` FOREIGN KEY (`kode_golongan`) REFERENCES `golongan_barang` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_7` FOREIGN KEY (`kode_satbesar`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of databarang
-- ----------------------------
INSERT INTO `databarang` VALUES ('B00001', 'Paracetamol 500mg', '-', '-', '-', 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 100, '-', 10, 500, '2024-06-10', '1', '-', '-', '-');
INSERT INTO `databarang` VALUES ('B00002', 'MIX', '-', '-', '-', 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 10, '-', 1, 200, '2026-07-10', '1', '-', '-', '-');

-- ----------------------------
-- Table structure for departemen
-- ----------------------------
DROP TABLE IF EXISTS `departemen`;
CREATE TABLE `departemen`  (
  `dep_id` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`dep_id`) USING BTREE,
  INDEX `nama`(`nama` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of departemen
-- ----------------------------
INSERT INTO `departemen` VALUES ('-', '-');

-- ----------------------------
-- Table structure for detail_obat_racikan
-- ----------------------------
DROP TABLE IF EXISTS `detail_obat_racikan`;
CREATE TABLE `detail_obat_racikan`  (
  `tgl_perawatan` date NOT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_racik` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`tgl_perawatan`, `jam`, `no_rawat`, `no_racik`, `kode_brng`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kode_brng`(`kode_brng` ASC) USING BTREE,
  CONSTRAINT `detail_obat_racikan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_obat_racikan_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of detail_obat_racikan
-- ----------------------------

-- ----------------------------
-- Table structure for detail_pemberian_obat
-- ----------------------------
DROP TABLE IF EXISTS `detail_pemberian_obat`;
CREATE TABLE `detail_pemberian_obat`  (
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam` time NOT NULL DEFAULT '00:00:00',
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `kode_brng` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h_beli` double NULL DEFAULT NULL,
  `biaya_obat` double NULL DEFAULT NULL,
  `jml` double NOT NULL,
  `embalase` double NULL DEFAULT NULL,
  `tuslah` double NULL DEFAULT NULL,
  `total` double NOT NULL,
  `status` enum('Ralan','Ranap') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_bangsal` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_batch` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`tgl_perawatan`, `jam`, `no_rawat`, `kode_brng`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kd_obat`(`kode_brng` ASC) USING BTREE,
  INDEX `tgl_perawatan`(`tgl_perawatan` ASC) USING BTREE,
  INDEX `jam`(`jam` ASC) USING BTREE,
  INDEX `jml`(`jml` ASC) USING BTREE,
  INDEX `tambahan`(`embalase` ASC) USING BTREE,
  INDEX `total`(`total` ASC) USING BTREE,
  INDEX `biaya_obat`(`biaya_obat` ASC) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal` ASC) USING BTREE,
  INDEX `tuslah`(`tuslah` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  CONSTRAINT `detail_pemberian_obat_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pemberian_obat_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pemberian_obat_ibfk_5` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of detail_pemberian_obat
-- ----------------------------

-- ----------------------------
-- Table structure for detail_periksa_lab
-- ----------------------------
DROP TABLE IF EXISTS `detail_periksa_lab`;
CREATE TABLE `detail_periksa_lab`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `id_template` int NOT NULL,
  `nilai` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nilai_rujukan` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `keterangan` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `bagian_perujuk` double NOT NULL,
  `bagian_dokter` double NOT NULL,
  `bagian_laborat` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_item` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`, `id_template`) USING BTREE,
  INDEX `id_template`(`id_template` ASC) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `tgl_periksa`(`tgl_periksa` ASC) USING BTREE,
  INDEX `jam`(`jam` ASC) USING BTREE,
  INDEX `nilai`(`nilai` ASC) USING BTREE,
  INDEX `nilai_rujukan`(`nilai_rujukan` ASC) USING BTREE,
  INDEX `keterangan`(`keterangan` ASC) USING BTREE,
  INDEX `biaya_item`(`biaya_item` ASC) USING BTREE,
  INDEX `menejemen`(`menejemen` ASC) USING BTREE,
  INDEX `kso`(`kso` ASC) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs` ASC) USING BTREE,
  INDEX `bhp`(`bhp` ASC) USING BTREE,
  INDEX `bagian_perujuk`(`bagian_perujuk` ASC) USING BTREE,
  INDEX `bagian_dokter`(`bagian_dokter` ASC) USING BTREE,
  INDEX `bagian_laborat`(`bagian_laborat` ASC) USING BTREE,
  CONSTRAINT `detail_periksa_lab_ibfk_10` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_ibfk_11` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_ibfk_12` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of detail_periksa_lab
-- ----------------------------

-- ----------------------------
-- Table structure for diagnosa_pasien
-- ----------------------------
DROP TABLE IF EXISTS `diagnosa_pasien`;
CREATE TABLE `diagnosa_pasien`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_penyakit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('Ralan','Ranap') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prioritas` tinyint NOT NULL,
  `status_penyakit` enum('Lama','Baru') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_penyakit`, `status`) USING BTREE,
  INDEX `kd_penyakit`(`kd_penyakit` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `prioritas`(`prioritas` ASC) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  CONSTRAINT `diagnosa_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `diagnosa_pasien_ibfk_2` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diagnosa_pasien
-- ----------------------------

-- ----------------------------
-- Table structure for dokter
-- ----------------------------
DROP TABLE IF EXISTS `dokter`;
CREATE TABLE `dokter`  (
  `kd_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_dokter` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jk` enum('L','P') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tmp_lahir` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `gol_drh` enum('A','B','O','AB','-') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `agama` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `almt_tgl` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_telp` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_sps` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alumni` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_ijn_praktek` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_dokter`) USING BTREE,
  INDEX `kd_sps`(`kd_sps` ASC) USING BTREE,
  INDEX `nm_dokter`(`nm_dokter` ASC) USING BTREE,
  INDEX `jk`(`jk` ASC) USING BTREE,
  INDEX `tmp_lahir`(`tmp_lahir` ASC) USING BTREE,
  INDEX `tgl_lahir`(`tgl_lahir` ASC) USING BTREE,
  INDEX `gol_drh`(`gol_drh` ASC) USING BTREE,
  INDEX `agama`(`agama` ASC) USING BTREE,
  INDEX `almt_tgl`(`almt_tgl` ASC) USING BTREE,
  INDEX `no_telp`(`no_telp` ASC) USING BTREE,
  INDEX `stts_nikah`(`stts_nikah` ASC) USING BTREE,
  INDEX `alumni`(`alumni` ASC) USING BTREE,
  INDEX `no_ijn_praktek`(`no_ijn_praktek` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  CONSTRAINT `dokter_ibfk_2` FOREIGN KEY (`kd_sps`) REFERENCES `spesialis` (`kd_sps`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `dokter_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `pegawai` (`nik`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dokter
-- ----------------------------
INSERT INTO `dokter` VALUES ('DR001', 'dr. Ataaka Muhammad', 'L', 'Barabai', '2000-09-18', 'O', 'Islam', 'Barabai', '-', 'MENIKAH', 'UMUM', 'UI', '-', '1');

-- ----------------------------
-- Table structure for dpjp_ranap
-- ----------------------------
DROP TABLE IF EXISTS `dpjp_ranap`;
CREATE TABLE `dpjp_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_dokter`) USING BTREE,
  INDEX `dpjp_ranap_ibfk_2`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `dpjp_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `dpjp_ranap_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dpjp_ranap
-- ----------------------------

-- ----------------------------
-- Table structure for emergency_index
-- ----------------------------
DROP TABLE IF EXISTS `emergency_index`;
CREATE TABLE `emergency_index`  (
  `kode_emergency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_emergency` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `indek` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`kode_emergency`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emergency_index
-- ----------------------------
INSERT INTO `emergency_index` VALUES ('-', '-', 1);

-- ----------------------------
-- Table structure for faktur
-- ----------------------------
DROP TABLE IF EXISTS `faktur`;
CREATE TABLE `faktur`  (
  `id` int NULL DEFAULT NULL,
  `kd_faktur` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jumlah_total` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `potongan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jumlah_harus_bayar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jumlah_bayar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_faktur` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of faktur
-- ----------------------------
INSERT INTO `faktur` VALUES (1, 'F.02.02.2025.10.20.36', '202502021001', '20000', '0', '20000', '20000', '2025-02-02', '1', 'Tunai');
INSERT INTO `faktur` VALUES (2, 'F.02.02.2025.11.49.24', '202502021003', '60500', '500', '60000', '100000', '2025-02-02', '2', 'Tunai');

-- ----------------------------
-- Table structure for faktur_detail
-- ----------------------------
DROP TABLE IF EXISTS `faktur_detail`;
CREATE TABLE `faktur_detail`  (
  `id` int NULL DEFAULT NULL,
  `id_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `harga` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jumlah` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `potongan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `total` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status_jasa` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jenis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of faktur_detail
-- ----------------------------
INSERT INTO `faktur_detail` VALUES (5, '202502021001', 'Rawat Luka', '25000', '1', '0', '25000', 'layanan', '0', '1', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (7, '202502021001', 'Injeksi R', '15000', '1', '0', '15000', 'layanan', '0', '1', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (8, '202502021001', 'LP', '2200', '5', '0', '11000', 'obat', '0', '1', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (9, '202502021001', 'LC', '1500', '7', '0', '10500', 'obat', '0', '1', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (10, '202502021001', 'R22', '1000', '7', '0', '7000', 'obat', '0', '1', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (11, '202502021002', 'INJ DC', '20000', '1', '0', '20000', 'layanan', '0', '2', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (14, '202502021002', 'HISTIGO', '800', '7', '0', '5600', 'obat', '0', '2', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (16, '202502021002', 'RANITIDIN ', '700', '7', '0', '4900', 'obat', '0', '2', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (19, '202502021002', 'MN', '800', '7', '0', '5600', 'obat', '0', '2', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (20, '202502021002', 'M2', '1000', '7', '0', '7000', 'obat', '0', '2', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (21, '202502021003', 'Rawat Luka', '25000', '1', '0', '25000', 'layanan', '0', '2', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (22, '202502021003', 'LP', '2200', '5', '0', '11000', 'obat', '0', '2', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (23, '202502021003', 'R22', '1000', '7', '0', '7000', 'obat', '0', '2', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (24, '202502021003', 'LC', '1500', '7', '0', '10500', 'obat', '0', '2', '2025-02-02', 'ralan');
INSERT INTO `faktur_detail` VALUES (25, '202502021003', 'Novaxifen ', '1000', '7', '0', '7000', 'obat', '0', '2', '2025-02-02', 'ralan');

-- ----------------------------
-- Table structure for gambar_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `gambar_radiologi`;
CREATE TABLE `gambar_radiologi`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `lokasi_gambar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_periksa`, `jam`, `lokasi_gambar`) USING BTREE,
  CONSTRAINT `gambar_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gambar_radiologi
-- ----------------------------

-- ----------------------------
-- Table structure for golongan_barang
-- ----------------------------
DROP TABLE IF EXISTS `golongan_barang`;
CREATE TABLE `golongan_barang`  (
  `kode` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of golongan_barang
-- ----------------------------
INSERT INTO `golongan_barang` VALUES ('-', '-');

-- ----------------------------
-- Table structure for gudangbarang
-- ----------------------------
DROP TABLE IF EXISTS `gudangbarang`;
CREATE TABLE `gudangbarang`  (
  `kode_brng` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_bangsal` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `stok` double NOT NULL,
  `no_batch` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kode_brng`, `kd_bangsal`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `kode_brng`(`kode_brng` ASC) USING BTREE,
  INDEX `stok`(`stok` ASC) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal` ASC) USING BTREE,
  CONSTRAINT `gudangbarang_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gudangbarang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gudangbarang
-- ----------------------------
INSERT INTO `gudangbarang` VALUES ('B00001', 'OBL', 127, '0', '0');
INSERT INTO `gudangbarang` VALUES ('B00002', 'OBL', 195, '0', '0');
INSERT INTO `gudangbarang` VALUES ('B00001', 'APT', 200, '0', '0');

-- ----------------------------
-- Table structure for hasil_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `hasil_radiologi`;
CREATE TABLE `hasil_radiologi`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `hasil` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  CONSTRAINT `hasil_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hasil_radiologi
-- ----------------------------

-- ----------------------------
-- Table structure for icd9
-- ----------------------------
DROP TABLE IF EXISTS `icd9`;
CREATE TABLE `icd9`  (
  `kode` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `deskripsi_panjang` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deskripsi_pendek` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of icd9
-- ----------------------------

-- ----------------------------
-- Table structure for industrifarmasi
-- ----------------------------
DROP TABLE IF EXISTS `industrifarmasi`;
CREATE TABLE `industrifarmasi`  (
  `kode_industri` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `nama_industri` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alamat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kota` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_telp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_industri`) USING BTREE,
  INDEX `nama_industri`(`nama_industri` ASC) USING BTREE,
  INDEX `alamat`(`alamat` ASC) USING BTREE,
  INDEX `kota`(`kota` ASC) USING BTREE,
  INDEX `no_telp`(`no_telp` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of industrifarmasi
-- ----------------------------
INSERT INTO `industrifarmasi` VALUES ('-', '-', '-', '-', '0');

-- ----------------------------
-- Table structure for inventaris
-- ----------------------------
DROP TABLE IF EXISTS `inventaris`;
CREATE TABLE `inventaris`  (
  `no_inventaris` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kode_barang` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `asal_barang` enum('Beli','Bantuan','Hibah','-') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_pengadaan` date NULL DEFAULT NULL,
  `harga` double NULL DEFAULT NULL,
  `status_barang` enum('Ada','Rusak','Hilang','Perbaikan','Dipinjam','-') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_ruang` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_rak` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_box` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_inventaris`) USING BTREE,
  INDEX `kode_barang`(`kode_barang` ASC) USING BTREE,
  INDEX `kd_ruang`(`id_ruang` ASC) USING BTREE,
  INDEX `asal_barang`(`asal_barang` ASC) USING BTREE,
  INDEX `tgl_pengadaan`(`tgl_pengadaan` ASC) USING BTREE,
  INDEX `harga`(`harga` ASC) USING BTREE,
  INDEX `status_barang`(`status_barang` ASC) USING BTREE,
  INDEX `no_rak`(`no_rak` ASC) USING BTREE,
  INDEX `no_box`(`no_box` ASC) USING BTREE,
  CONSTRAINT `inventaris_ibfk_1` FOREIGN KEY (`kode_barang`) REFERENCES `inventaris_barang` (`kode_barang`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_ibfk_2` FOREIGN KEY (`id_ruang`) REFERENCES `inventaris_ruang` (`id_ruang`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventaris
-- ----------------------------

-- ----------------------------
-- Table structure for inventaris_barang
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_barang`;
CREATE TABLE `inventaris_barang`  (
  `kode_barang` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_barang` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jml_barang` int NULL DEFAULT NULL,
  `kode_produsen` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_merk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `thn_produksi` year NULL DEFAULT NULL,
  `isbn` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_kategori` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_jenis` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_barang`) USING BTREE,
  INDEX `kode_produsen`(`kode_produsen` ASC) USING BTREE,
  INDEX `id_merk`(`id_merk` ASC) USING BTREE,
  INDEX `id_kategori`(`id_kategori` ASC) USING BTREE,
  INDEX `id_jenis`(`id_jenis` ASC) USING BTREE,
  INDEX `nama_barang`(`nama_barang` ASC) USING BTREE,
  INDEX `jml_barang`(`jml_barang` ASC) USING BTREE,
  INDEX `thn_produksi`(`thn_produksi` ASC) USING BTREE,
  INDEX `isbn`(`isbn` ASC) USING BTREE,
  CONSTRAINT `inventaris_barang_ibfk_5` FOREIGN KEY (`kode_produsen`) REFERENCES `inventaris_produsen` (`kode_produsen`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_6` FOREIGN KEY (`id_merk`) REFERENCES `inventaris_merk` (`id_merk`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_7` FOREIGN KEY (`id_kategori`) REFERENCES `inventaris_kategori` (`id_kategori`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_8` FOREIGN KEY (`id_jenis`) REFERENCES `inventaris_jenis` (`id_jenis`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventaris_barang
-- ----------------------------

-- ----------------------------
-- Table structure for inventaris_jenis
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_jenis`;
CREATE TABLE `inventaris_jenis`  (
  `id_jenis` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_jenis` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_jenis`) USING BTREE,
  INDEX `nama_jenis`(`nama_jenis` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventaris_jenis
-- ----------------------------

-- ----------------------------
-- Table structure for inventaris_kategori
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_kategori`;
CREATE TABLE `inventaris_kategori`  (
  `id_kategori` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_kategori` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori`) USING BTREE,
  INDEX `nama_kategori`(`nama_kategori` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventaris_kategori
-- ----------------------------

-- ----------------------------
-- Table structure for inventaris_merk
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_merk`;
CREATE TABLE `inventaris_merk`  (
  `id_merk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_merk` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_merk`) USING BTREE,
  INDEX `nama_merk`(`nama_merk` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventaris_merk
-- ----------------------------

-- ----------------------------
-- Table structure for inventaris_peminjaman
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_peminjaman`;
CREATE TABLE `inventaris_peminjaman`  (
  `peminjam` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `tlp` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_inventaris` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `tgl_pinjam` date NOT NULL DEFAULT '0000-00-00',
  `tgl_kembali` date NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `status_pinjam` enum('Masih Dipinjam','Sudah Kembali') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`peminjam`, `no_inventaris`, `tgl_pinjam`, `nip`) USING BTREE,
  INDEX `no_inventaris`(`no_inventaris` ASC) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  INDEX `tgl_kembali`(`tgl_kembali` ASC) USING BTREE,
  INDEX `status_pinjam`(`status_pinjam` ASC) USING BTREE,
  CONSTRAINT `inventaris_peminjaman_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_peminjaman_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of inventaris_peminjaman
-- ----------------------------

-- ----------------------------
-- Table structure for inventaris_produsen
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_produsen`;
CREATE TABLE `inventaris_produsen`  (
  `kode_produsen` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_produsen` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alamat_produsen` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_telp` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `website_produsen` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_produsen`) USING BTREE,
  INDEX `nama_produsen`(`nama_produsen` ASC) USING BTREE,
  INDEX `alamat_produsen`(`alamat_produsen` ASC) USING BTREE,
  INDEX `no_telp`(`no_telp` ASC) USING BTREE,
  INDEX `email`(`email` ASC) USING BTREE,
  INDEX `website_produsen`(`website_produsen` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventaris_produsen
-- ----------------------------

-- ----------------------------
-- Table structure for inventaris_ruang
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_ruang`;
CREATE TABLE `inventaris_ruang`  (
  `id_ruang` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_ruang` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_ruang`) USING BTREE,
  INDEX `nama_ruang`(`nama_ruang` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventaris_ruang
-- ----------------------------

-- ----------------------------
-- Table structure for jabatan
-- ----------------------------
DROP TABLE IF EXISTS `jabatan`;
CREATE TABLE `jabatan`  (
  `kd_jbtn` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `nm_jbtn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_jbtn`) USING BTREE,
  INDEX `nm_jbtn`(`nm_jbtn` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jabatan
-- ----------------------------
INSERT INTO `jabatan` VALUES ('-', '-');

-- ----------------------------
-- Table structure for jadwal
-- ----------------------------
DROP TABLE IF EXISTS `jadwal`;
CREATE TABLE `jadwal`  (
  `kd_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `hari_kerja` enum('SENIN','SELASA','RABU','KAMIS','JUMAT','SABTU','AKHAD') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'SENIN',
  `jam_mulai` time NOT NULL DEFAULT '00:00:00',
  `jam_selesai` time NULL DEFAULT NULL,
  `kd_poli` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kuota` int NULL DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`, `hari_kerja`, `jam_mulai`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `kd_poli`(`kd_poli` ASC) USING BTREE,
  INDEX `jam_mulai`(`jam_mulai` ASC) USING BTREE,
  INDEX `jam_selesai`(`jam_selesai` ASC) USING BTREE,
  CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jadwal_ibfk_2` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jadwal
-- ----------------------------

-- ----------------------------
-- Table structure for jadwal_pegawai
-- ----------------------------
DROP TABLE IF EXISTS `jadwal_pegawai`;
CREATE TABLE `jadwal_pegawai`  (
  `id` int NOT NULL,
  `tahun` year NOT NULL,
  `bulan` enum('01','02','03','04','05','06','07','08','09','10','11','12') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h1` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h2` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h3` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h4` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h5` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h6` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h7` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h8` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h9` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h10` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h11` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h12` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h13` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h14` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h15` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h16` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h17` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h18` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h19` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h20` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h21` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h22` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h23` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h24` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h25` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h26` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h27` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h28` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h29` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h30` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h31` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`, `tahun`, `bulan`) USING BTREE,
  INDEX `h1`(`h1` ASC) USING BTREE,
  INDEX `h2`(`h2` ASC) USING BTREE,
  INDEX `h3`(`h3` ASC) USING BTREE,
  INDEX `h4`(`h4` ASC) USING BTREE,
  INDEX `h30`(`h30` ASC) USING BTREE,
  INDEX `h31`(`h31` ASC) USING BTREE,
  INDEX `h29`(`h29` ASC) USING BTREE,
  INDEX `h28`(`h28` ASC) USING BTREE,
  INDEX `h18`(`h18` ASC) USING BTREE,
  INDEX `h9`(`h9` ASC) USING BTREE,
  CONSTRAINT `jadwal_pegawai_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jadwal_pegawai
-- ----------------------------

-- ----------------------------
-- Table structure for jadwal_tambahan
-- ----------------------------
DROP TABLE IF EXISTS `jadwal_tambahan`;
CREATE TABLE `jadwal_tambahan`  (
  `id` int NOT NULL,
  `tahun` year NOT NULL,
  `bulan` enum('01','02','03','04','05','06','07','08','09','10','11','12') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h1` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h2` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h3` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h4` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h5` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h6` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h7` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h8` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h9` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h10` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h11` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h12` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h13` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h14` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h15` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h16` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h17` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h18` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h19` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h20` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h21` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h22` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h23` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h24` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h25` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h26` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h27` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h28` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h29` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h30` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `h31` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`, `tahun`, `bulan`) USING BTREE,
  CONSTRAINT `jadwal_tambahan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jadwal_tambahan
-- ----------------------------

-- ----------------------------
-- Table structure for jam_jaga
-- ----------------------------
DROP TABLE IF EXISTS `jam_jaga`;
CREATE TABLE `jam_jaga`  (
  `no_id` int NOT NULL AUTO_INCREMENT,
  `dep_id` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`no_id`) USING BTREE,
  UNIQUE INDEX `dep_id_2`(`dep_id` ASC, `shift` ASC) USING BTREE,
  INDEX `dep_id`(`dep_id` ASC) USING BTREE,
  INDEX `shift`(`shift` ASC) USING BTREE,
  INDEX `jam_masuk`(`jam_masuk` ASC) USING BTREE,
  INDEX `jam_pulang`(`jam_pulang` ASC) USING BTREE,
  CONSTRAINT `jam_jaga_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `departemen` (`dep_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jam_jaga
-- ----------------------------

-- ----------------------------
-- Table structure for jam_masuk
-- ----------------------------
DROP TABLE IF EXISTS `jam_masuk`;
CREATE TABLE `jam_masuk`  (
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`shift`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jam_masuk
-- ----------------------------
INSERT INTO `jam_masuk` VALUES ('Pagi', '06:00:00', '16:00:00');
INSERT INTO `jam_masuk` VALUES ('Pagi2', '08:00:00', '14:00:00');
INSERT INTO `jam_masuk` VALUES ('Pagi3', '10:00:00', '17:00:00');
INSERT INTO `jam_masuk` VALUES ('Siang', '14:00:00', '08:00:00');
INSERT INTO `jam_masuk` VALUES ('Siang2', '14:00:00', '21:00:00');
INSERT INTO `jam_masuk` VALUES ('Malam', '20:00:00', '02:00:00');
INSERT INTO `jam_masuk` VALUES ('Midle Siang1', '00:00:00', '06:00:00');
INSERT INTO `jam_masuk` VALUES ('Midle Siang3', '00:00:00', '00:00:00');
INSERT INTO `jam_masuk` VALUES ('Midle Siang4', '04:00:00', '16:00:00');
INSERT INTO `jam_masuk` VALUES ('Midle Malam1', '00:00:00', '06:00:00');
INSERT INTO `jam_masuk` VALUES ('Midle Malam5', '22:00:00', '07:00:00');

-- ----------------------------
-- Table structure for jenis
-- ----------------------------
DROP TABLE IF EXISTS `jenis`;
CREATE TABLE `jenis`  (
  `kdjns` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `keterangan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kdjns`) USING BTREE,
  INDEX `nama`(`nama` ASC) USING BTREE,
  INDEX `keterangan`(`keterangan` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jenis
-- ----------------------------
INSERT INTO `jenis` VALUES ('-', '-', '-');

-- ----------------------------
-- Table structure for jnj_jabatan
-- ----------------------------
DROP TABLE IF EXISTS `jnj_jabatan`;
CREATE TABLE `jnj_jabatan`  (
  `kode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tnj` double NOT NULL,
  `indek` tinyint NOT NULL,
  PRIMARY KEY (`kode`) USING BTREE,
  INDEX `nama`(`nama` ASC) USING BTREE,
  INDEX `tnj`(`tnj` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jnj_jabatan
-- ----------------------------
INSERT INTO `jnj_jabatan` VALUES ('-', '-', 0, 1);

-- ----------------------------
-- Table structure for jns_perawatan
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan`;
CREATE TABLE `jns_perawatan`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_kategori` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `material` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NULL DEFAULT NULL,
  `tarif_tindakanpr` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `total_byrdr` double NULL DEFAULT NULL,
  `total_byrpr` double NULL DEFAULT NULL,
  `total_byrdrpr` double NOT NULL,
  `kd_pj` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_poli` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `kd_kategori`(`kd_kategori` ASC) USING BTREE,
  INDEX `kd_pj`(`kd_pj` ASC) USING BTREE,
  INDEX `kd_poli`(`kd_poli` ASC) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan` ASC) USING BTREE,
  INDEX `material`(`material` ASC) USING BTREE,
  INDEX `tarif_tindakandr`(`tarif_tindakandr` ASC) USING BTREE,
  INDEX `tarif_tindakanpr`(`tarif_tindakanpr` ASC) USING BTREE,
  INDEX `total_byrdr`(`total_byrdr` ASC) USING BTREE,
  INDEX `total_byrpr`(`total_byrpr` ASC) USING BTREE,
  INDEX `kso`(`kso` ASC) USING BTREE,
  INDEX `menejemen`(`menejemen` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `total_byrdrpr`(`total_byrdrpr` ASC) USING BTREE,
  INDEX `bhp`(`bhp` ASC) USING BTREE,
  CONSTRAINT `jns_perawatan_ibfk_1` FOREIGN KEY (`kd_kategori`) REFERENCES `kategori_perawatan` (`kd_kategori`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jns_perawatan
-- ----------------------------
INSERT INTO `jns_perawatan` VALUES ('RJ001', 'Pemeriksaan rutin', '-', 0, 0, 50000, 0, 0, 0, 50000, 0, 50000, '-', '-', '1');

-- ----------------------------
-- Table structure for jns_perawatan_inap
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_inap`;
CREATE TABLE `jns_perawatan_inap`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_kategori` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `material` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NULL DEFAULT NULL,
  `tarif_tindakanpr` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `total_byrdr` double NULL DEFAULT NULL,
  `total_byrpr` double NULL DEFAULT NULL,
  `total_byrdrpr` double NOT NULL,
  `kd_pj` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_bangsal` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kelas` enum('-','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `kd_pj`(`kd_pj` ASC) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal` ASC) USING BTREE,
  INDEX `kd_kategori`(`kd_kategori` ASC) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan` ASC) USING BTREE,
  INDEX `material`(`material` ASC) USING BTREE,
  INDEX `tarif_tindakandr`(`tarif_tindakandr` ASC) USING BTREE,
  INDEX `tarif_tindakanpr`(`tarif_tindakanpr` ASC) USING BTREE,
  INDEX `total_byrdr`(`total_byrdr` ASC) USING BTREE,
  INDEX `total_byrpr`(`total_byrpr` ASC) USING BTREE,
  INDEX `bhp`(`bhp` ASC) USING BTREE,
  INDEX `kso`(`kso` ASC) USING BTREE,
  INDEX `menejemen`(`menejemen` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `total_byrdrpr`(`total_byrdrpr` ASC) USING BTREE,
  CONSTRAINT `jns_perawatan_inap_ibfk_7` FOREIGN KEY (`kd_kategori`) REFERENCES `kategori_perawatan` (`kd_kategori`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_inap_ibfk_8` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_inap_ibfk_9` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jns_perawatan_inap
-- ----------------------------
INSERT INTO `jns_perawatan_inap` VALUES ('RI001', 'Pasang Infus', '-', 0, 0, 0, 25000, 0, 0, 0, 25000, 25000, '-', '-', '1', 'Kelas 1');

-- ----------------------------
-- Table structure for jns_perawatan_lab
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_lab`;
CREATE TABLE `jns_perawatan_lab`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `bagian_rs` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `total_byr` double NULL DEFAULT NULL,
  `kd_pj` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kelas` enum('-','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kategori` enum('PK','PA','MB') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `kd_pj`(`kd_pj` ASC) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan` ASC) USING BTREE,
  INDEX `tarif_perujuk`(`tarif_perujuk` ASC) USING BTREE,
  INDEX `tarif_tindakan_dokter`(`tarif_tindakan_dokter` ASC) USING BTREE,
  INDEX `tarif_tindakan_petugas`(`tarif_tindakan_petugas` ASC) USING BTREE,
  INDEX `total_byr`(`total_byr` ASC) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs` ASC) USING BTREE,
  INDEX `bhp`(`bhp` ASC) USING BTREE,
  INDEX `kso`(`kso` ASC) USING BTREE,
  INDEX `menejemen`(`menejemen` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  CONSTRAINT `jns_perawatan_lab_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jns_perawatan_lab
-- ----------------------------
INSERT INTO `jns_perawatan_lab` VALUES ('LAB001', 'Pemeriksaan Darah', 0, 0, 0, 100000, 0, 0, 0, 100000, '-', '1', 'Kelas 1', 'PK');

-- ----------------------------
-- Table structure for jns_perawatan_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_radiologi`;
CREATE TABLE `jns_perawatan_radiologi`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `bagian_rs` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `total_byr` double NULL DEFAULT NULL,
  `kd_pj` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kelas` enum('-','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `kd_pj`(`kd_pj` ASC) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan` ASC) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs` ASC) USING BTREE,
  INDEX `tarif_perujuk`(`tarif_perujuk` ASC) USING BTREE,
  INDEX `tarif_tindakan_dokter`(`tarif_tindakan_dokter` ASC) USING BTREE,
  INDEX `tarif_tindakan_petugas`(`tarif_tindakan_petugas` ASC) USING BTREE,
  INDEX `total_byr`(`total_byr` ASC) USING BTREE,
  INDEX `bhp`(`bhp` ASC) USING BTREE,
  INDEX `kso`(`kso` ASC) USING BTREE,
  INDEX `menejemen`(`menejemen` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  CONSTRAINT `jns_perawatan_radiologi_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jns_perawatan_radiologi
-- ----------------------------
INSERT INTO `jns_perawatan_radiologi` VALUES ('RAD001', 'Thorax', 0, 0, 0, 150000, 0, 0, 0, 150000, '-', '1', 'Kelas 1');

-- ----------------------------
-- Table structure for kabupaten
-- ----------------------------
DROP TABLE IF EXISTS `kabupaten`;
CREATE TABLE `kabupaten`  (
  `kd_kab` int NOT NULL,
  `nm_kab` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_kab`) USING BTREE,
  UNIQUE INDEX `nm_kab`(`nm_kab` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kabupaten
-- ----------------------------
INSERT INTO `kabupaten` VALUES (1, '-');

-- ----------------------------
-- Table structure for kamar
-- ----------------------------
DROP TABLE IF EXISTS `kamar`;
CREATE TABLE `kamar`  (
  `kd_kamar` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_bangsal` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `trf_kamar` double NULL DEFAULT NULL,
  `status` enum('ISI','KOSONG','DIBERSIHKAN','DIBOOKING') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `statusdata` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_kamar`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal` ASC) USING BTREE,
  INDEX `trf_kamar`(`trf_kamar` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `kelas`(`kelas` ASC) USING BTREE,
  INDEX `statusdata`(`statusdata` ASC) USING BTREE,
  CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kamar
-- ----------------------------
INSERT INTO `kamar` VALUES ('ANG01', 'ANG', 100000, 'KOSONG', 'Kelas 1', '1');
INSERT INTO `kamar` VALUES ('ANG02', 'ANG', 100000, 'KOSONG', 'Kelas 1', '1');

-- ----------------------------
-- Table structure for kamar_inap
-- ----------------------------
DROP TABLE IF EXISTS `kamar_inap`;
CREATE TABLE `kamar_inap`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `kd_kamar` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `trf_kamar` double NULL DEFAULT NULL,
  `diagnosa_awal` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `diagnosa_akhir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_masuk` date NOT NULL DEFAULT '0000-00-00',
  `jam_masuk` time NOT NULL DEFAULT '00:00:00',
  `tgl_keluar` date NULL DEFAULT NULL,
  `jam_keluar` time NULL DEFAULT NULL,
  `lama` double NULL DEFAULT NULL,
  `ttl_biaya` double NULL DEFAULT NULL,
  `stts_pulang` enum('Sehat','Rujuk','APS','+','Meninggal','Sembuh','Membaik','Pulang Paksa','-','Pindah Kamar','Status Belum Lengkap','Atas Persetujuan Dokter','Atas Permintaan Sendiri','Isoman','Lain-lain') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_masuk`, `jam_masuk`) USING BTREE,
  INDEX `kd_kamar`(`kd_kamar` ASC) USING BTREE,
  INDEX `diagnosa_awal`(`diagnosa_awal` ASC) USING BTREE,
  INDEX `diagnosa_akhir`(`diagnosa_akhir` ASC) USING BTREE,
  INDEX `tgl_keluar`(`tgl_keluar` ASC) USING BTREE,
  INDEX `jam_keluar`(`jam_keluar` ASC) USING BTREE,
  INDEX `lama`(`lama` ASC) USING BTREE,
  INDEX `ttl_biaya`(`ttl_biaya` ASC) USING BTREE,
  INDEX `stts_pulang`(`stts_pulang` ASC) USING BTREE,
  INDEX `trf_kamar`(`trf_kamar` ASC) USING BTREE,
  CONSTRAINT `kamar_inap_ibfk_2` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kamar_inap_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kamar_inap
-- ----------------------------

-- ----------------------------
-- Table structure for kategori_barang
-- ----------------------------
DROP TABLE IF EXISTS `kategori_barang`;
CREATE TABLE `kategori_barang`  (
  `kode` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kategori_barang
-- ----------------------------
INSERT INTO `kategori_barang` VALUES ('-', '-');

-- ----------------------------
-- Table structure for kategori_penyakit
-- ----------------------------
DROP TABLE IF EXISTS `kategori_penyakit`;
CREATE TABLE `kategori_penyakit`  (
  `kd_ktg` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_kategori` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ciri_umum` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_ktg`) USING BTREE,
  INDEX `nm_kategori`(`nm_kategori` ASC) USING BTREE,
  INDEX `ciri_umum`(`ciri_umum` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kategori_penyakit
-- ----------------------------
INSERT INTO `kategori_penyakit` VALUES ('-', '-', '-');

-- ----------------------------
-- Table structure for kategori_perawatan
-- ----------------------------
DROP TABLE IF EXISTS `kategori_perawatan`;
CREATE TABLE `kategori_perawatan`  (
  `kd_kategori` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_kategori` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_kategori`) USING BTREE,
  INDEX `nm_kategori`(`nm_kategori` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kategori_perawatan
-- ----------------------------
INSERT INTO `kategori_perawatan` VALUES ('-', '-');

-- ----------------------------
-- Table structure for kecamatan
-- ----------------------------
DROP TABLE IF EXISTS `kecamatan`;
CREATE TABLE `kecamatan`  (
  `kd_kec` int NOT NULL,
  `nm_kec` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_kec`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kecamatan
-- ----------------------------
INSERT INTO `kecamatan` VALUES (1, '-');

-- ----------------------------
-- Table structure for kelompok_jabatan
-- ----------------------------
DROP TABLE IF EXISTS `kelompok_jabatan`;
CREATE TABLE `kelompok_jabatan`  (
  `kode_kelompok` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_kelompok` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `indek` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`kode_kelompok`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kelompok_jabatan
-- ----------------------------
INSERT INTO `kelompok_jabatan` VALUES ('-', '-', 1);

-- ----------------------------
-- Table structure for kelurahan
-- ----------------------------
DROP TABLE IF EXISTS `kelurahan`;
CREATE TABLE `kelurahan`  (
  `kd_kel` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_kel` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_kel`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kelurahan
-- ----------------------------
INSERT INTO `kelurahan` VALUES ('1', '-');

-- ----------------------------
-- Table structure for kodesatuan
-- ----------------------------
DROP TABLE IF EXISTS `kodesatuan`;
CREATE TABLE `kodesatuan`  (
  `kode_sat` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `satuan` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_sat`) USING BTREE,
  INDEX `satuan`(`satuan` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kodesatuan
-- ----------------------------
INSERT INTO `kodesatuan` VALUES ('-', '-');

-- ----------------------------
-- Table structure for laporan_operasi
-- ----------------------------
DROP TABLE IF EXISTS `laporan_operasi`;
CREATE TABLE `laporan_operasi`  (
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `diagnosa_preop` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `diagnosa_postop` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jaringan_dieksekusi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `selesaioperasi` datetime NOT NULL,
  `permintaan_pa` enum('Ya','Tidak') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `laporan_operasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  CONSTRAINT `laporan_operasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of laporan_operasi
-- ----------------------------

-- ----------------------------
-- Table structure for layanan
-- ----------------------------
DROP TABLE IF EXISTS `layanan`;
CREATE TABLE `layanan`  (
  `id` int NOT NULL,
  `nama_layanan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `harga` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of layanan
-- ----------------------------
INSERT INTO `layanan` VALUES (3, 'INJ 1R8', '15000');
INSERT INTO `layanan` VALUES (4, 'INJ 3C', '15000');
INSERT INTO `layanan` VALUES (5, 'INJ 2T0', '15000');
INSERT INTO `layanan` VALUES (6, 'INJ 1N4', '20000');
INSERT INTO `layanan` VALUES (7, 'INJ 2X4', '15000');
INSERT INTO `layanan` VALUES (13, 'INJ 4D', '15000');
INSERT INTO `layanan` VALUES (14, 'INJ 1R7', '15000');
INSERT INTO `layanan` VALUES (15, 'INJ 1T8', '15000');
INSERT INTO `layanan` VALUES (16, 'INJ 6F', '15000');
INSERT INTO `layanan` VALUES (17, 'INJ 1M3', '20000');
INSERT INTO `layanan` VALUES (18, 'INJ 1O3', '15000');
INSERT INTO `layanan` VALUES (19, 'RL 1', '20000');
INSERT INTO `layanan` VALUES (20, 'RL 2', '25000');
INSERT INTO `layanan` VALUES (21, 'RL 3', '30000');
INSERT INTO `layanan` VALUES (22, 'HEACTING < 5', '45000');
INSERT INTO `layanan` VALUES (23, 'HEACTING < 10', '65000');
INSERT INTO `layanan` VALUES (24, 'HEACTING > 10', '80000');
INSERT INTO `layanan` VALUES (25, 'AJ < 5 ', '25000');
INSERT INTO `layanan` VALUES (26, 'AJ < 10', '45000');
INSERT INTO `layanan` VALUES (27, 'AJ >10', '65000');

-- ----------------------------
-- Table structure for login_attempts
-- ----------------------------
DROP TABLE IF EXISTS `login_attempts`;
CREATE TABLE `login_attempts`  (
  `ip` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `attempts` int NOT NULL,
  `expires` int NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of login_attempts
-- ----------------------------
INSERT INTO `login_attempts` VALUES ('110.136.26.244', 0, 0);
INSERT INTO `login_attempts` VALUES ('180.248.6.242', 0, 0);
INSERT INTO `login_attempts` VALUES ('36.73.209.19', 1, 1735815658);
INSERT INTO `login_attempts` VALUES ('114.79.20.182', 0, 0);
INSERT INTO `login_attempts` VALUES ('180.248.0.46', 0, 0);
INSERT INTO `login_attempts` VALUES ('110.138.96.92', 0, 0);
INSERT INTO `login_attempts` VALUES ('110.136.31.82', 0, 0);
INSERT INTO `login_attempts` VALUES ('36.73.215.143', 0, 0);
INSERT INTO `login_attempts` VALUES ('140.213.67.27', 2, 0);
INSERT INTO `login_attempts` VALUES ('180.248.7.101', 0, 0);
INSERT INTO `login_attempts` VALUES ('114.79.20.60', 0, 0);
INSERT INTO `login_attempts` VALUES ('180.248.14.84', 0, 0);
INSERT INTO `login_attempts` VALUES ('36.73.209.80', 0, 0);
INSERT INTO `login_attempts` VALUES ('110.138.96.253', 0, 0);
INSERT INTO `login_attempts` VALUES ('114.79.22.120', 0, 0);
INSERT INTO `login_attempts` VALUES ('110.138.199.249', 0, 0);
INSERT INTO `login_attempts` VALUES ('36.73.208.112', 0, 0);
INSERT INTO `login_attempts` VALUES ('110.138.99.142', 0, 0);
INSERT INTO `login_attempts` VALUES ('36.73.215.9', 0, 0);
INSERT INTO `login_attempts` VALUES ('180.246.231.219', 0, 0);
INSERT INTO `login_attempts` VALUES ('110.138.197.23', 0, 0);
INSERT INTO `login_attempts` VALUES ('180.248.1.224', 0, 0);
INSERT INTO `login_attempts` VALUES ('110.138.99.201', 0, 0);
INSERT INTO `login_attempts` VALUES ('110.136.24.20', 0, 0);
INSERT INTO `login_attempts` VALUES ('110.138.97.186', 0, 0);
INSERT INTO `login_attempts` VALUES ('180.246.231.177', 0, 0);

-- ----------------------------
-- Table structure for maping_dokter_dpjpvclaim
-- ----------------------------
DROP TABLE IF EXISTS `maping_dokter_dpjpvclaim`;
CREATE TABLE `maping_dokter_dpjpvclaim`  (
  `kd_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_dokter_bpjs` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_dokter_bpjs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`) USING BTREE,
  CONSTRAINT `maping_dokter_dpjpvclaim_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of maping_dokter_dpjpvclaim
-- ----------------------------

-- ----------------------------
-- Table structure for maping_dokter_pcare
-- ----------------------------
DROP TABLE IF EXISTS `maping_dokter_pcare`;
CREATE TABLE `maping_dokter_pcare`  (
  `kd_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_dokter_pcare` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_dokter_pcare` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`) USING BTREE,
  CONSTRAINT `maping_dokter_pcare_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of maping_dokter_pcare
-- ----------------------------

-- ----------------------------
-- Table structure for maping_poli_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `maping_poli_bpjs`;
CREATE TABLE `maping_poli_bpjs`  (
  `kd_poli_rs` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_poli_bpjs` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_poli_bpjs` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_poli_rs`) USING BTREE,
  UNIQUE INDEX `kd_poli_bpjs`(`kd_poli_bpjs` ASC) USING BTREE,
  CONSTRAINT `maping_poli_bpjs_ibfk_1` FOREIGN KEY (`kd_poli_rs`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of maping_poli_bpjs
-- ----------------------------

-- ----------------------------
-- Table structure for maping_poliklinik_pcare
-- ----------------------------
DROP TABLE IF EXISTS `maping_poliklinik_pcare`;
CREATE TABLE `maping_poliklinik_pcare`  (
  `kd_poli_rs` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_poli_pcare` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_poli_pcare` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_poli_rs`) USING BTREE,
  CONSTRAINT `maping_poliklinik_pcare_ibfk_1` FOREIGN KEY (`kd_poli_rs`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of maping_poliklinik_pcare
-- ----------------------------

-- ----------------------------
-- Table structure for master_aturan_pakai
-- ----------------------------
DROP TABLE IF EXISTS `master_aturan_pakai`;
CREATE TABLE `master_aturan_pakai`  (
  `aturan` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`aturan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of master_aturan_pakai
-- ----------------------------
INSERT INTO `master_aturan_pakai` VALUES ('3 x 1 Sehari');

-- ----------------------------
-- Table structure for master_berkas_digital
-- ----------------------------
DROP TABLE IF EXISTS `master_berkas_digital`;
CREATE TABLE `master_berkas_digital`  (
  `kode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of master_berkas_digital
-- ----------------------------
INSERT INTO `master_berkas_digital` VALUES ('DIG001', 'Berkas Digital');

-- ----------------------------
-- Table structure for master_masalah_keperawatan
-- ----------------------------
DROP TABLE IF EXISTS `master_masalah_keperawatan`;
CREATE TABLE `master_masalah_keperawatan`  (
  `kode_masalah` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_masalah` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_masalah`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of master_masalah_keperawatan
-- ----------------------------

-- ----------------------------
-- Table structure for metode_racik
-- ----------------------------
DROP TABLE IF EXISTS `metode_racik`;
CREATE TABLE `metode_racik`  (
  `kd_racik` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nm_racik` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kd_racik`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of metode_racik
-- ----------------------------
INSERT INTO `metode_racik` VALUES ('1', 'Puyer');

-- ----------------------------
-- Table structure for mlite_akun_kegiatan
-- ----------------------------
DROP TABLE IF EXISTS `mlite_akun_kegiatan`;
CREATE TABLE `mlite_akun_kegiatan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `kegiatan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_rek` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_akun_kegiatan
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_antrian_loket
-- ----------------------------
DROP TABLE IF EXISTS `mlite_antrian_loket`;
CREATE TABLE `mlite_antrian_loket`  (
  `kd` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `noantrian` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_rkm_medis` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `postdate` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL DEFAULT '00:00:00',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `loket` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`kd`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_antrian_loket
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_antrian_referensi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_antrian_referensi`;
CREATE TABLE `mlite_antrian_referensi`  (
  `tanggal_periksa` date NOT NULL,
  `no_rkm_medis` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nomor_kartu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nomor_referensi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kodebooking` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jenis_kunjungan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status_kirim` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_antrian_referensi
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_antrian_referensi_batal
-- ----------------------------
DROP TABLE IF EXISTS `mlite_antrian_referensi_batal`;
CREATE TABLE `mlite_antrian_referensi_batal`  (
  `tanggal_batal` date NOT NULL,
  `nomor_referensi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kodebooking` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `keterangan` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_antrian_referensi_batal
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_antrian_referensi_taskid
-- ----------------------------
DROP TABLE IF EXISTS `mlite_antrian_referensi_taskid`;
CREATE TABLE `mlite_antrian_referensi_taskid`  (
  `tanggal_periksa` date NOT NULL,
  `nomor_referensi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `taskid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `waktu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_antrian_referensi_taskid
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_apamregister
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apamregister`;
CREATE TABLE `mlite_apamregister`  (
  `nama_lengkap` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nomor_ktp` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nomor_telepon` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_apamregister
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_api_key
-- ----------------------------
DROP TABLE IF EXISTS `mlite_api_key`;
CREATE TABLE `mlite_api_key`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `api_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ip_range` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `exp_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mlite_api_key_ibfk_1`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_api_key
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_apotek_online_log
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apotek_online_log`;
CREATE TABLE `mlite_apotek_online_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `noresep` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal_kirim` datetime NOT NULL,
  `status` enum('success','error') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `response_resep` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `response_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `request` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `tanggal_kirim`(`tanggal_kirim` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_apotek_online_log
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_apotek_online_maping_obat
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apotek_online_maping_obat`;
CREATE TABLE `mlite_apotek_online_maping_obat`  (
  `kode_brng` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kd_obat_bpjs` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_obat_bpjs` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kode_brng`) USING BTREE,
  INDEX `kd_obat_bpjs`(`kd_obat_bpjs` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_apotek_online_maping_obat
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_apotek_online_resep_response_log
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apotek_online_resep_response_log`;
CREATE TABLE `mlite_apotek_online_resep_response_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_sep_kunjungan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_kartu` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `faskes_asal` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_apotik` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_resep` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_resep` date NULL DEFAULT NULL,
  `kd_jns_obat` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `by_tag_rsp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `by_ver_rsp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_entry` date NULL DEFAULT NULL,
  `meta_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `meta_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `raw_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tanggal_simpan` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `idx_no_sep_kunjungan`(`no_sep_kunjungan` ASC) USING BTREE,
  INDEX `idx_no_resep`(`no_resep` ASC) USING BTREE,
  INDEX `idx_tanggal_simpan`(`tanggal_simpan` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_apotek_online_resep_response_log
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_apotek_online_sep_data
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apotek_online_sep_data`;
CREATE TABLE `mlite_apotek_online_sep_data`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_sep` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `faskes_asal_resep` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_faskes_asal_resep` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_kartu` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_peserta` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jns_kelamin` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `pisat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_jenis_peserta` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_jenis_peserta` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kode_bu` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_bu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_sep` date NULL DEFAULT NULL,
  `tgl_plg_sep` date NULL DEFAULT NULL,
  `jns_pelayanan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nm_diag` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `poli` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `flag_prb` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_prb` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kode_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_dokter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal_simpan` datetime NOT NULL,
  `user_simpan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `raw_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `no_sep`(`no_sep` ASC) USING BTREE,
  INDEX `no_kartu`(`no_kartu` ASC) USING BTREE,
  INDEX `nama_peserta`(`nama_peserta` ASC) USING BTREE,
  INDEX `tanggal_simpan`(`tanggal_simpan` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_apotek_online_sep_data
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_billing
-- ----------------------------
DROP TABLE IF EXISTS `mlite_billing`;
CREATE TABLE `mlite_billing`  (
  `id_billing` int NOT NULL AUTO_INCREMENT,
  `kd_billing` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jumlah_total` int NOT NULL,
  `potongan` int NOT NULL,
  `jumlah_harus_bayar` int NOT NULL,
  `jumlah_bayar` int NOT NULL,
  `tgl_billing` date NOT NULL,
  `jam_billing` time NOT NULL,
  `id_user` int NOT NULL,
  `keterangan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_billing`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_billing
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_billing_pembayaran
-- ----------------------------
DROP TABLE IF EXISTS `mlite_billing_pembayaran`;
CREATE TABLE `mlite_billing_pembayaran`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_bayar` date NOT NULL,
  `jam_bayar` time NOT NULL,
  `metode` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Tunai',
  `jumlah_bayar` double NOT NULL DEFAULT 0,
  `id_user` int NULL DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_billing_pembayaran_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `idx_billing_pembayaran_tgl`(`tgl_bayar` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_billing_pembayaran
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_billing_pembayaran_detail
-- ----------------------------
DROP TABLE IF EXISTS `mlite_billing_pembayaran_detail`;
CREATE TABLE `mlite_billing_pembayaran_detail`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `pembayaran_id` int NOT NULL,
  `kelompok` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jumlah_alokasi` double NOT NULL DEFAULT 0,
  `ref_modul` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_periksa` date NULL DEFAULT NULL,
  `jam` time NULL DEFAULT NULL,
  `status_periksa` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_billing_pembayaran_detail_pembayaran`(`pembayaran_id` ASC) USING BTREE,
  INDEX `idx_billing_pembayaran_detail_kelompok`(`kelompok` ASC) USING BTREE,
  CONSTRAINT `fk_billing_pembayaran_detail_header` FOREIGN KEY (`pembayaran_id`) REFERENCES `mlite_billing_pembayaran` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_billing_pembayaran_detail
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bpjs_emr_device
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bpjs_emr_device`;
CREATE TABLE `mlite_bpjs_emr_device`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_alkes` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kategori` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'tindakan',
  `kode_produk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `manufacturer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `manufacture_date` date NULL DEFAULT NULL,
  `expiration_date` date NULL DEFAULT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uq_device_id`(`device_id` ASC) USING BTREE,
  INDEX `idx_nama_alkes`(`nama_alkes` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bpjs_emr_device
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bpjs_emr_logs
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bpjs_emr_logs`;
CREATE TABLE `mlite_bpjs_emr_logs`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_sep` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_rawat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `payload_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `payload_encrypted` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bpjs_emr_logs
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bpjs_emr_mapping_lab
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bpjs_emr_mapping_lab`;
CREATE TABLE `mlite_bpjs_emr_mapping_lab`  (
  `id_template` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `loinc_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `loinc_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `master_device_id` int NULL DEFAULT NULL,
  `focal_device_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_template`) USING BTREE,
  INDEX `idx_mapping_lab_master_device`(`master_device_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bpjs_emr_mapping_lab
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bpjs_emr_mapping_obat
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bpjs_emr_mapping_obat`;
CREATE TABLE `mlite_bpjs_emr_mapping_obat`  (
  `kode_brng` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kode_brng`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bpjs_emr_mapping_obat
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bpjs_emr_mapping_operasi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bpjs_emr_mapping_operasi`;
CREATE TABLE `mlite_bpjs_emr_mapping_operasi`  (
  `kode_paket` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `snomed_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `snomed_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `master_device_id` int NULL DEFAULT NULL,
  `focal_device_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_paket`) USING BTREE,
  INDEX `idx_mapping_operasi_master_device`(`master_device_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bpjs_emr_mapping_operasi
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bpjs_emr_mapping_prosedur
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bpjs_emr_mapping_prosedur`;
CREATE TABLE `mlite_bpjs_emr_mapping_prosedur`  (
  `kd_jenis_prw` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `snomed_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `snomed_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `master_device_id` int NULL DEFAULT NULL,
  `focal_device_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `idx_mapping_proc_master_device`(`master_device_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bpjs_emr_mapping_prosedur
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bpjs_emr_mapping_prosedur_ranap
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bpjs_emr_mapping_prosedur_ranap`;
CREATE TABLE `mlite_bpjs_emr_mapping_prosedur_ranap`  (
  `kd_jenis_prw` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `snomed_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `snomed_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `master_device_id` int NULL DEFAULT NULL,
  `focal_device_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `idx_mapping_proc_ranap_master_device`(`master_device_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bpjs_emr_mapping_prosedur_ranap
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bpjs_emr_mapping_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bpjs_emr_mapping_radiologi`;
CREATE TABLE `mlite_bpjs_emr_mapping_radiologi`  (
  `kd_jenis_prw` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `standard_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `standard_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `system` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `master_device_id` int NULL DEFAULT NULL,
  `focal_device_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `focal_device_action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `idx_mapping_rad_master_device`(`master_device_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bpjs_emr_mapping_radiologi
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bpjs_emr_uuid_condition
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bpjs_emr_uuid_condition`;
CREATE TABLE `mlite_bpjs_emr_uuid_condition`  (
  `kd_penyakit` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `uuid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bpjs_emr_uuid_condition
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_bridging_pcare
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bridging_pcare`;
CREATE TABLE `mlite_bridging_pcare`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_rawat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_rkm_medis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tgl_daftar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nomor_kunjungan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_provider_peserta` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nomor_jaminan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_poli` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_poli` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kunjungan_sakit` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sistole` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `diastole` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nadi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `respirasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tinggi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `berat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `lingkar_perut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `rujuk_balik` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `subyektif` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_tkp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nomor_urut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_kesadaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_kesadaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `terapi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_status_pulang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_status_pulang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tgl_pulang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tgl_kunjungan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_dokter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_dokter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_diagnosa1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_diagnosa1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_diagnosa2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_diagnosa2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_diagnosa3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_diagnosa3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tgl_estimasi_rujuk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_ppk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_ppk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_spesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_spesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_subspesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_subspesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_sarana` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_sarana` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_referensikhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_referensikhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_faskeskhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_faskeskhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_tacc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_tacc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `alasan_tacc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status_kirim` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kode_alergi_makanan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_alergi_makanan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_alergi_udara` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_alergi_udara` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_alergi_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_alergi_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kode_prognosa` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_prognosa` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `terapi_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `terapi_non_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_bridging_pcare
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_clinical_pathway
-- ----------------------------
DROP TABLE IF EXISTS `mlite_clinical_pathway`;
CREATE TABLE `mlite_clinical_pathway`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `kode_cp` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_cp` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jenis_layanan` enum('Ralan','Ranap') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Ranap',
  `target_los` int NOT NULL DEFAULT 0,
  `target_tarif` double NOT NULL DEFAULT 0,
  `confidence_score` decimal(5, 2) NOT NULL DEFAULT 0.00,
  `evidence_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `guideline_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `aktif` enum('Ya','Tidak') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Ya',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `kode_cp`(`kode_cp` ASC) USING BTREE,
  INDEX `nama_cp`(`nama_cp` ASC) USING BTREE,
  INDEX `jenis_layanan`(`jenis_layanan` ASC) USING BTREE,
  INDEX `aktif`(`aktif` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_clinical_pathway
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_clinical_pathway_activity
-- ----------------------------
DROP TABLE IF EXISTS `mlite_clinical_pathway_activity`;
CREATE TABLE `mlite_clinical_pathway_activity`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinical_pathway_day_id` int NOT NULL,
  `kategori` enum('Assessment','Laboratorium','Radiologi','Obat','Tindakan','Nutrisi','Edukasi','Monitoring','Outcome') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `uraian_kegiatan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sumber_tabel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `item_kode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `item_nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `evidence_frequency` int NOT NULL DEFAULT 0,
  `evidence_percentage` decimal(5, 2) NOT NULL DEFAULT 0.00,
  `evidence_status` enum('Wajib','Direkomendasikan','Opsional') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Opsional',
  `wajib` enum('Ya','Tidak') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Ya',
  `urutan` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clinical_pathway_day_id`(`clinical_pathway_day_id` ASC) USING BTREE,
  INDEX `kategori`(`kategori` ASC) USING BTREE,
  INDEX `item_kode`(`item_kode` ASC) USING BTREE,
  CONSTRAINT `fk_cp_activity_day` FOREIGN KEY (`clinical_pathway_day_id`) REFERENCES `mlite_clinical_pathway_day` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_clinical_pathway_activity
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_clinical_pathway_audit
-- ----------------------------
DROP TABLE IF EXISTS `mlite_clinical_pathway_audit`;
CREATE TABLE `mlite_clinical_pathway_audit`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinical_pathway_patient_id` int NULL DEFAULT NULL,
  `clinical_pathway_id` int NULL DEFAULT NULL,
  `aksi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `referensi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_aksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clinical_pathway_patient_id`(`clinical_pathway_patient_id` ASC) USING BTREE,
  INDEX `clinical_pathway_id`(`clinical_pathway_id` ASC) USING BTREE,
  INDEX `aksi`(`aksi` ASC) USING BTREE,
  CONSTRAINT `fk_cp_audit_cp` FOREIGN KEY (`clinical_pathway_id`) REFERENCES `mlite_clinical_pathway` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_cp_audit_patient` FOREIGN KEY (`clinical_pathway_patient_id`) REFERENCES `mlite_clinical_pathway_patient` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_clinical_pathway_audit
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_clinical_pathway_compliance
-- ----------------------------
DROP TABLE IF EXISTS `mlite_clinical_pathway_compliance`;
CREATE TABLE `mlite_clinical_pathway_compliance`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinical_pathway_patient_id` int NOT NULL,
  `planned_activity` int NOT NULL DEFAULT 0,
  `completed_activity` int NOT NULL DEFAULT 0,
  `missed_activity` int NOT NULL DEFAULT 0,
  `compliance_percentage` decimal(5, 2) NOT NULL DEFAULT 0.00,
  `kategori_kepatuhan` enum('Sangat Patuh','Patuh','Kurang Patuh','Tidak Patuh') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Tidak Patuh',
  `last_calculated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `clinical_pathway_patient_id`(`clinical_pathway_patient_id` ASC) USING BTREE,
  CONSTRAINT `fk_cp_compliance_patient` FOREIGN KEY (`clinical_pathway_patient_id`) REFERENCES `mlite_clinical_pathway_patient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_clinical_pathway_compliance
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_crud_permissions
-- ----------------------------
DROP TABLE IF EXISTS `mlite_crud_permissions`;
CREATE TABLE `mlite_crud_permissions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `module` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `can_create` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'true',
  `can_read` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'true',
  `can_update` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'true',
  `can_delete` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'true',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user`(`user` ASC, `module` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_crud_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_detailjurnal
-- ----------------------------
DROP TABLE IF EXISTS `mlite_detailjurnal`;
CREATE TABLE `mlite_detailjurnal`  (
  `no_jurnal` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `arus_kas` int NOT NULL,
  `debet` double NOT NULL,
  `kredit` double NOT NULL,
  INDEX `no_jurnal`(`no_jurnal` ASC) USING BTREE,
  INDEX `kd_rek`(`kd_rek` ASC) USING BTREE,
  INDEX `debet`(`debet` ASC) USING BTREE,
  INDEX `kredit`(`kredit` ASC) USING BTREE,
  CONSTRAINT `mlite_detailjurnal_ibfk_1` FOREIGN KEY (`no_jurnal`) REFERENCES `mlite_jurnal` (`no_jurnal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mlite_detailjurnal_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `mlite_rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_detailjurnal
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_duitku
-- ----------------------------
DROP TABLE IF EXISTS `mlite_duitku`;
CREATE TABLE `mlite_duitku`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tanggal` datetime NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `paymentUrl` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `merchantCode` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `reference` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `vaNumber` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `amount` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusCode` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusMessage` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `reference`(`reference` ASC) USING BTREE,
  INDEX `mlite_duitku_ibfk_1`(`no_rkm_medis` ASC) USING BTREE,
  CONSTRAINT `mlite_duitku_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_duitku
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_eklaim_logs
-- ----------------------------
DROP TABLE IF EXISTS `mlite_eklaim_logs`;
CREATE TABLE `mlite_eklaim_logs`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nomor_sep` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `method` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `request_data` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `response_data` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int NULL DEFAULT 1,
  `username` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_eklaim_logs
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_geolocation_presensi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_geolocation_presensi`;
CREATE TABLE `mlite_geolocation_presensi`  (
  `id` int NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `latitude` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `longitude` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  INDEX `mlite_geolocation_presensi_ibfk_1`(`id` ASC) USING BTREE,
  CONSTRAINT `mlite_geolocation_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_geolocation_presensi
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_idr_codes
-- ----------------------------
DROP TABLE IF EXISTS `mlite_idr_codes`;
CREATE TABLE `mlite_idr_codes`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `code2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `system` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `validcode` tinyint(1) NULL DEFAULT NULL,
  `accpdx` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `asterisk` tinyint(1) NULL DEFAULT NULL,
  `im` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_idr_codes
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_inacbg_codes
-- ----------------------------
DROP TABLE IF EXISTS `mlite_inacbg_codes`;
CREATE TABLE `mlite_inacbg_codes`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `code2` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `system` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `validcode` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_inacbg_codes
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_jurnal
-- ----------------------------
DROP TABLE IF EXISTS `mlite_jurnal`;
CREATE TABLE `mlite_jurnal`  (
  `no_jurnal` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_bukti` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_jurnal` date NULL DEFAULT NULL,
  `jenis` enum('U','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kegiatan` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(350) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_jurnal`) USING BTREE,
  INDEX `no_bukti`(`no_bukti` ASC) USING BTREE,
  INDEX `tgl_jurnal`(`tgl_jurnal` ASC) USING BTREE,
  INDEX `jenis`(`jenis` ASC) USING BTREE,
  INDEX `keterangan`(`keterangan` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_jurnal
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_kasir_shift
-- ----------------------------
DROP TABLE IF EXISTS `mlite_kasir_shift`;
CREATE TABLE `mlite_kasir_shift`  (
  `id_shift` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `waktu_buka` datetime NOT NULL,
  `waktu_tutup` datetime NULL DEFAULT NULL,
  `kas_awal` decimal(14, 2) NULL DEFAULT 0.00,
  `kas_akhir` decimal(14, 2) NULL DEFAULT 0.00,
  `total_transaksi` decimal(14, 2) NULL DEFAULT 0.00,
  `selisih` decimal(14, 2) NULL DEFAULT 0.00,
  `keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_shift`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_kasir_shift
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_login_attempts
-- ----------------------------
DROP TABLE IF EXISTS `mlite_login_attempts`;
CREATE TABLE `mlite_login_attempts`  (
  `ip` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `attempts` int NOT NULL,
  `expires` int NOT NULL DEFAULT 0
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_login_attempts
-- ----------------------------
INSERT INTO `mlite_login_attempts` VALUES ('::1', 0, 0);

-- ----------------------------
-- Table structure for mlite_loinc_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_loinc_radiologi`;
CREATE TABLE `mlite_loinc_radiologi`  (
  `No` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Kategori` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `NamaPemeriksaan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `PermintaanHasil` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Code` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Display` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Component` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Property` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Timing` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `System` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Scale` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Method` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `UnitOfMeasure` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `CodeSystem` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `BodySiteCode` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `BodySiteDisplay` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `BodySiteCodeSystem` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`Code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_loinc_radiologi
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_modules
-- ----------------------------
DROP TABLE IF EXISTS `mlite_modules`;
CREATE TABLE `mlite_modules`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `dir` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `sequence` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 37 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_modules
-- ----------------------------
INSERT INTO `mlite_modules` VALUES (1, 'settings', '9');
INSERT INTO `mlite_modules` VALUES (2, 'dashboard', '0');
INSERT INTO `mlite_modules` VALUES (3, 'master', '1');
INSERT INTO `mlite_modules` VALUES (4, 'pasien', '2');
INSERT INTO `mlite_modules` VALUES (5, 'rawat_jalan', '3');
INSERT INTO `mlite_modules` VALUES (6, 'kasir_rawat_jalan', '4');
INSERT INTO `mlite_modules` VALUES (7, 'kepegawaian', '5');
INSERT INTO `mlite_modules` VALUES (8, 'farmasi', '6');
INSERT INTO `mlite_modules` VALUES (9, 'users', '8');
INSERT INTO `mlite_modules` VALUES (10, 'modules', '7');
INSERT INTO `mlite_modules` VALUES (11, 'wagateway', '10');
INSERT INTO `mlite_modules` VALUES (12, 'apotek_ralan', '11');
INSERT INTO `mlite_modules` VALUES (13, 'dokter_ralan', '12');
INSERT INTO `mlite_modules` VALUES (14, 'igd', '13');
INSERT INTO `mlite_modules` VALUES (15, 'dokter_igd', '14');
INSERT INTO `mlite_modules` VALUES (16, 'laboratorium', '15');
INSERT INTO `mlite_modules` VALUES (17, 'radiologi', '16');
INSERT INTO `mlite_modules` VALUES (18, 'rawat_inap', '17');
INSERT INTO `mlite_modules` VALUES (19, 'apotek_ranap', '18');
INSERT INTO `mlite_modules` VALUES (20, 'dokter_ranap', '19');
INSERT INTO `mlite_modules` VALUES (21, 'kasir_rawat_inap', '20');
INSERT INTO `mlite_modules` VALUES (22, 'operasi', '21');
INSERT INTO `mlite_modules` VALUES (23, 'anjungan', '22');
INSERT INTO `mlite_modules` VALUES (24, 'api', '23');
INSERT INTO `mlite_modules` VALUES (25, 'jkn_mobile', '24');
INSERT INTO `mlite_modules` VALUES (26, 'vclaim', '25');
INSERT INTO `mlite_modules` VALUES (27, 'keuangan', '26');
INSERT INTO `mlite_modules` VALUES (28, 'manajemen', '27');
INSERT INTO `mlite_modules` VALUES (29, 'presensi', '28');
INSERT INTO `mlite_modules` VALUES (30, 'vedika', '29');
INSERT INTO `mlite_modules` VALUES (31, 'profil', '30');
INSERT INTO `mlite_modules` VALUES (32, 'orthanc', '31');
INSERT INTO `mlite_modules` VALUES (33, 'veronisa', '32');
INSERT INTO `mlite_modules` VALUES (36, 'penjualan', '33');

-- ----------------------------
-- Table structure for mlite_news
-- ----------------------------
DROP TABLE IF EXISTS `mlite_news`;
CREATE TABLE `mlite_news`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `slug` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_id` int NOT NULL,
  `content` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `intro` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `cover_photo` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `status` int NOT NULL,
  `comments` int NULL DEFAULT 1,
  `markdown` int NULL DEFAULT 0,
  `published_at` int NULL DEFAULT 0,
  `updated_at` int NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_news
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_news_tags
-- ----------------------------
DROP TABLE IF EXISTS `mlite_news_tags`;
CREATE TABLE `mlite_news_tags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `slug` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_news_tags
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_news_tags_relationship
-- ----------------------------
DROP TABLE IF EXISTS `mlite_news_tags_relationship`;
CREATE TABLE `mlite_news_tags_relationship`  (
  `news_id` int NOT NULL,
  `tag_id` int NOT NULL,
  INDEX `mlite_news_tags_relationship_ibfk_1`(`news_id` ASC) USING BTREE,
  INDEX `tag_id`(`tag_id` ASC) USING BTREE,
  CONSTRAINT `mlite_news_tags_relationship_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `mlite_news` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `mlite_news_tags_relationship_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `mlite_news_tags` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_news_tags_relationship
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_notifications
-- ----------------------------
DROP TABLE IF EXISTS `mlite_notifications`;
CREATE TABLE `mlite_notifications`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `judul` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pesan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `no_rkm_medis` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'unread',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_notifications
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_odontogram
-- ----------------------------
DROP TABLE IF EXISTS `mlite_odontogram`;
CREATE TABLE `mlite_odontogram`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_rkm_medis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pemeriksaan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kondisi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_odontogram
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_ohis
-- ----------------------------
DROP TABLE IF EXISTS `mlite_ohis`;
CREATE TABLE `mlite_ohis`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_rkm_medis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `d_16` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_11` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_26` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_36` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_31` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_46` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_16` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_11` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_26` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_36` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_31` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_46` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `debris` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `calculus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nilai` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kriteria` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_ohis
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_pendaftaran_oral_diagnostic
-- ----------------------------
DROP TABLE IF EXISTS `mlite_pendaftaran_oral_diagnostic`;
CREATE TABLE `mlite_pendaftaran_oral_diagnostic`  (
  `no_reg` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_registrasi` date NULL DEFAULT NULL,
  `jam_reg` time NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_poli` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `p_jawab` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `almt_pj` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hubunganpj` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `biaya_reg` double NULL DEFAULT NULL,
  `stts` enum('Belum','Sudah','Batal','Berkas Diterima','Dirujuk','Meninggal','Dirawat','Pulang Paksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stts_daftar` enum('-','Lama','Baru') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_lanjut` enum('Ralan','Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `umurdaftar` int NULL DEFAULT NULL,
  `sttsumur` enum('Th','Bl','Hr') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_bayar` enum('Sudah Bayar','Belum Bayar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_poli` enum('Lama','Baru') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis` ASC) USING BTREE,
  INDEX `kd_poli`(`kd_poli` ASC) USING BTREE,
  INDEX `kd_pj`(`kd_pj` ASC) USING BTREE,
  INDEX `status_lanjut`(`status_lanjut` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `status_bayar`(`status_bayar` ASC) USING BTREE,
  CONSTRAINT `mlite_pendaftaran_oral_diagnostic_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mlite_pendaftaran_oral_diagnostic_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mlite_pendaftaran_oral_diagnostic_ibfk_6` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `mlite_pendaftaran_oral_diagnostic_ibfk_7` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_pendaftaran_oral_diagnostic
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_pengaduan
-- ----------------------------
DROP TABLE IF EXISTS `mlite_pengaduan`;
CREATE TABLE `mlite_pengaduan`  (
  `id` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pesan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis` ASC) USING BTREE,
  CONSTRAINT `mlite_pengaduan_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_pengaduan
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_pengaduan_detail
-- ----------------------------
DROP TABLE IF EXISTS `mlite_pengaduan_detail`;
CREATE TABLE `mlite_pengaduan_detail`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `pengaduan_id` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pesan` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pengaduan_detail_ibfk_1`(`pengaduan_id` ASC) USING BTREE,
  CONSTRAINT `mlite_pengaduan_detail_ibfk_1` FOREIGN KEY (`pengaduan_id`) REFERENCES `mlite_pengaduan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mlite_pengaduan_detail
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_penjualan
-- ----------------------------
DROP TABLE IF EXISTS `mlite_penjualan`;
CREATE TABLE `mlite_penjualan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_pembeli` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `alamat_pembeli` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `nomor_telepon` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `id_user` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `keterangan` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_penjualan
-- ----------------------------
INSERT INTO `mlite_penjualan` VALUES (31, 'd', 'Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183', '081235846900', 'it.rswilujeng@gmail.com', '2026-07-10', '12:20:07', 'admin', '-');
INSERT INTO `mlite_penjualan` VALUES (33, 'd', 'Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183', '081235846900', 'it.rswilujeng@gmail.com', '2026-07-10', '12:25:14', 'admin', '-');
INSERT INTO `mlite_penjualan` VALUES (32, 'd', 'Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183', '081235846900', 'it.rswilujeng@gmail.com', '2026-07-10', '12:22:01', 'admin', '-');

-- ----------------------------
-- Table structure for mlite_penjualan_barang
-- ----------------------------
DROP TABLE IF EXISTS `mlite_penjualan_barang`;
CREATE TABLE `mlite_penjualan_barang`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stok` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `harga` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_penjualan_barang
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_penjualan_billing
-- ----------------------------
DROP TABLE IF EXISTS `mlite_penjualan_billing`;
CREATE TABLE `mlite_penjualan_billing`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_penjualan` int NOT NULL,
  `jumlah_total` int NOT NULL,
  `potongan` int NULL DEFAULT NULL,
  `jumlah_harus_bayar` int NOT NULL,
  `jumlah_bayar` int NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `id_user` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_penjualan_billing
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_penjualan_detail
-- ----------------------------
DROP TABLE IF EXISTS `mlite_penjualan_detail`;
CREATE TABLE `mlite_penjualan_detail`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_penjualan` int NOT NULL,
  `id_barang` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nama_barang` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `harga` int NOT NULL,
  `jumlah` int NOT NULL,
  `harga_total` int NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `id_user` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_penjualan_detail
-- ----------------------------
INSERT INTO `mlite_penjualan_detail` VALUES (23, 0, 'B00001', 'Paracetamol 500mg', 5000, 5, 25000, '2026-07-10', '12:25:14', 'admin');
INSERT INTO `mlite_penjualan_detail` VALUES (18, 0, 'B00001', 'Paracetamol 500mg', 5000, 5, 25000, '2026-07-10', '12:19:23', 'admin');
INSERT INTO `mlite_penjualan_detail` VALUES (19, 0, 'B00001', 'Paracetamol 500mg', 5000, 5, 25000, '2026-07-10', '12:20:07', 'admin');
INSERT INTO `mlite_penjualan_detail` VALUES (20, 0, 'B00002', 'MIX', 2000, 5, 10000, '2026-07-10', '12:20:07', 'admin');
INSERT INTO `mlite_penjualan_detail` VALUES (21, 0, 'B00001', 'Paracetamol 500mg', 5000, 5, 25000, '2026-07-10', '12:20:07', 'admin');

-- ----------------------------
-- Table structure for mlite_query_logs
-- ----------------------------
DROP TABLE IF EXISTS `mlite_query_logs`;
CREATE TABLE `mlite_query_logs`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sql_text` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bindings` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `error_message` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `username` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_query_logs
-- ----------------------------
INSERT INTO `mlite_query_logs` VALUES (1, 'SELECT * FROM mlite_penjualan_detail WHERE id_penjualan = (?,?)', '[\"Database connection failed\",\"Please check database configuration and ensure MySQL server is running\"]', '2026-07-02 14:22:30', 'SQLSTATE[21000]: Cardinality violation: 1241 Operand should contain 1 column(s)', 'admin');
INSERT INTO `mlite_query_logs` VALUES (2, 'SELECT * FROM mlite_penjualan_detail WHERE id_penjualan = (?,?)', '[\"Database connection failed\",\"Please check database configuration and ensure MySQL server is running\"]', '2026-07-02 14:22:30', 'SQLSTATE[21000]: Cardinality violation: 1241 Operand should contain 1 column(s)', 'admin');
INSERT INTO `mlite_query_logs` VALUES (3, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"\"]', '2026-07-07 09:23:45', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (4, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"\"]', '2026-07-07 09:23:49', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (5, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:55', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (6, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:55', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (7, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:56', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (8, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:56', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (9, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:56', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (10, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:56', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (11, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:57', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (12, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:57', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (13, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:57', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (14, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:57', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (15, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:57', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (16, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:58', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (17, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-07\",null,\"admin\",\"d\"]', '2026-07-07 09:23:58', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (18, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-09\",null,\"admin\",\"\"]', '2026-07-09 09:15:41', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (19, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>SQLSTATE[23000]: Integrity constraint violation: 1048 Column &#039;jam&#039; cannot be null<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:15:46', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (20, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:15:48', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (21, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-09\",null,\"admin\",\"-\"]', '2026-07-09 09:17:02', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (22, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>SQLSTATE[23000]: Integrity constraint violation: 1048 Column &#039;jam&#039; cannot be null<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:17:03', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (23, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-09\",null,\"admin\",\"-\"]', '2026-07-09 09:17:27', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (24, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>SQLSTATE[23000]: Integrity constraint violation: 1048 Column &#039;jam&#039; cannot be null<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:17:28', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (25, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:17:28', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (26, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:17:29', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (27, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:17:29', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (28, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:17:30', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (29, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:17:30', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (30, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:17:30', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (31, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:17:32', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (32, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-09\",null,\"admin\",\"-\"]', '2026-07-09 09:17:45', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (33, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-09\",null,\"admin\",\"-\"]', '2026-07-09 09:25:13', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (34, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>SQLSTATE[23000]: Integrity constraint violation: 1048 Column &#039;jam&#039; cannot be null<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:25:15', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (35, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:25:15', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (36, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:25:16', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (37, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:25:16', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (38, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:25:16', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (39, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:25:17', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (40, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-09\",null,\"admin\",\"-\"]', '2026-07-09 09:25:23', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (41, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>SQLSTATE[23000]: Integrity constraint violation: 1048 Column &#039;jam&#039; cannot be null<\\/p>\\n            \\n        <\\/div>\",\"2\",\"\\n                    para\",\"100000\",\"6\",600000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:25:24', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (42, 'INSERT INTO `mlite_penjualan`(`nama_pembeli`,`alamat_pembeli`,`nomor_telepon`,`email`,`tanggal`,`jam`,`id_user`,`keterangan`) VALUES(?,?,?,?,?,?,?,?)', '[\"d\",\"Jl. Joyoboyo, Prambatan, Padangan, Kec. Kayen Kidul, Kabupaten Kediri, Jawa Timur 64183\",\"081235846900\",\"it.rswilujeng@gmail.com\",\"2026-07-09\",null,\"admin\",\"-\"]', '2026-07-09 09:25:58', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (43, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>SQLSTATE[23000]: Integrity constraint violation: 1048 Column &#039;jam&#039; cannot be null<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:26:01', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (44, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:26:15', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (45, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:26:18', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (46, 'INSERT INTO `mlite_penjualan_billing`(`id_penjualan`,`jumlah_total`,`potongan`,`jumlah_harus_bayar`,`jumlah_bayar`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?)', '[\"0\",\"30000\",\"0\",\"30000\",\"200000\",\"2026-07-09\",null,\"admin\"]', '2026-07-09 09:47:16', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (47, 'INSERT INTO `mlite_penjualan_billing`(`id_penjualan`,`jumlah_total`,`potongan`,`jumlah_harus_bayar`,`jumlah_bayar`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?)', '[\"0\",\"690000\",\"0\",\"690000\",\"99000000\",\"2026-07-09\",null,\"admin\"]', '2026-07-09 12:31:24', 'SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'jam\' cannot be null', 'admin');
INSERT INTO `mlite_query_logs` VALUES (48, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[[{\"id\":13},{\"id\":14},{\"id\":15},{\"id\":16}],\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:47:57\",\"admin\"]', '2026-07-09 13:47:57', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'Array\' for column \'id\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (49, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:47:59\",\"admin\"]', '2026-07-09 13:47:59', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (50, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:48:00\",\"admin\"]', '2026-07-09 13:48:00', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (51, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:48:38\",\"admin\"]', '2026-07-09 13:48:38', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (52, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:48:39\",\"admin\"]', '2026-07-09 13:48:39', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (53, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:13\",\"admin\"]', '2026-07-09 13:58:13', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (54, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:14\",\"admin\"]', '2026-07-09 13:58:14', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (55, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:17\",\"admin\"]', '2026-07-09 13:58:17', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (56, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:18\",\"admin\"]', '2026-07-09 13:58:18', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (57, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:18\",\"admin\"]', '2026-07-09 13:58:18', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (58, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:19\",\"admin\"]', '2026-07-09 13:58:19', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (59, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:19\",\"admin\"]', '2026-07-09 13:58:19', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (60, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:19\",\"admin\"]', '2026-07-09 13:58:19', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (61, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:19\",\"admin\"]', '2026-07-09 13:58:19', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (62, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:21\",\"admin\"]', '2026-07-09 13:58:21', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (63, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:23\",\"admin\"]', '2026-07-09 13:58:23', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (64, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"14:58:23\",\"admin\"]', '2026-07-09 13:58:23', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (65, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"14\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:00:22\",\"admin\"]', '2026-07-09 14:00:23', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (66, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"4\",20000,\"2026-07-09\",\"15:00:29\",\"admin\"]', '2026-07-09 14:00:29', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (67, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"4\",20000,\"2026-07-09\",\"15:00:29\",\"admin\"]', '2026-07-09 14:00:29', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (68, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"4\",20000,\"2026-07-09\",\"15:00:30\",\"admin\"]', '2026-07-09 14:00:30', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (69, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"4\",20000,\"2026-07-09\",\"15:00:30\",\"admin\"]', '2026-07-09 14:00:30', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (70, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"4\",20000,\"2026-07-09\",\"15:00:30\",\"admin\"]', '2026-07-09 14:00:30', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (71, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"122\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:01:55\",\"admin\"]', '2026-07-09 14:01:55', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (72, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:01:58\",\"admin\"]', '2026-07-09 14:01:58', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (73, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:01:59\",\"admin\"]', '2026-07-09 14:01:59', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (74, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:00\",\"admin\"]', '2026-07-09 14:02:00', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (75, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:00\",\"admin\"]', '2026-07-09 14:02:00', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (76, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:00\",\"admin\"]', '2026-07-09 14:02:00', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (77, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:00\",\"admin\"]', '2026-07-09 14:02:00', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (78, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:00\",\"admin\"]', '2026-07-09 14:02:00', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (79, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:01\",\"admin\"]', '2026-07-09 14:02:01', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (80, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:01\",\"admin\"]', '2026-07-09 14:02:01', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (81, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:01\",\"admin\"]', '2026-07-09 14:02:01', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (82, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:02\",\"admin\"]', '2026-07-09 14:02:02', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (83, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:02\",\"admin\"]', '2026-07-09 14:02:02', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (84, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"122\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"6\",30000,\"2026-07-09\",\"15:02:15\",\"admin\"]', '2026-07-09 14:02:15', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (85, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"4\",20000,\"2026-07-09\",\"15:02:22\",\"admin\"]', '2026-07-09 14:02:22', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (86, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"4\",20000,\"2026-07-09\",\"15:02:22\",\"admin\"]', '2026-07-09 14:02:22', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (87, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"122\",\"B00001\",\"Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-09\",\"15:02:34\",\"admin\"]', '2026-07-09 14:02:34', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (88, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"122\",\"B00001\",\"Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"09:30:24\",\"admin\"]', '2026-07-10 08:30:24', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (89, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"09:30:27\",\"admin\"]', '2026-07-10 08:30:27', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (90, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"09:30:34\",\"admin\"]', '2026-07-10 08:30:34', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (91, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"09:30:34\",\"admin\"]', '2026-07-10 08:30:34', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (92, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"09:30:35\",\"admin\"]', '2026-07-10 08:30:35', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (93, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"09:30:36\",\"admin\"]', '2026-07-10 08:30:36', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (94, 'INSERT INTO `databarang`(`kode_brng`,`nama_brng`,`kode_satbesar`,`kode_sat`,`letak_barang`,`dasar`,`h_beli`,`ralan`,`kelas1`,`kelas2`,`kelas3`,`utama`,`vip`,`vvip`,`beliluar`,`jualbebas`,`karyawan`,`stokminimal`,`kdjns`,`isi`,`kapasitas`,`expire`,`status`,`kode_industri`,`kode_kategori`,`kode_golongan`) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', '[\"B00002\",\"MIX\",\"-\",\"-\",\"-\",\"2000\",\"2000\",\"2000\",\"2000\",\"2000\",\"2000\",\"2000\",\"2000\",\"2000\",\"2000\",\"2000\",\"2000\",\"10\",\"-\",\"1\",\"\",\"2026-07-10\",\"1\",\"-\",\"-\",\"-\"]', '2026-07-10 08:31:29', 'SQLSTATE[01000]: Warning: 1265 Data truncated for column \'kapasitas\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (95, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"122\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"09:32:33\",\"admin\"]', '2026-07-10 08:32:33', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (96, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"09:32:43\",\"admin\"]', '2026-07-10 08:32:43', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (97, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"122\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"09:32:52\",\"admin\"]', '2026-07-10 08:32:52', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (98, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"09:33:01\",\"admin\"]', '2026-07-10 08:33:01', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (99, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"09:33:03\",\"admin\"]', '2026-07-10 08:33:03', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (100, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"0\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:14:13\",\"admin\"]', '2026-07-10 10:14:13', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (101, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:14:17\",\"admin\"]', '2026-07-10 10:14:17', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (102, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:14:18\",\"admin\"]', '2026-07-10 10:14:18', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (103, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"0\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"11:15:58\",\"admin\"]', '2026-07-10 10:15:58', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (104, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"11:16:00\",\"admin\"]', '2026-07-10 10:16:00', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (105, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"11:16:02\",\"admin\"]', '2026-07-10 10:16:02', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (106, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:16:06\",\"admin\"]', '2026-07-10 10:16:06', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (107, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:16:07\",\"admin\"]', '2026-07-10 10:16:07', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (108, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:16:08\",\"admin\"]', '2026-07-10 10:16:08', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (109, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:16:08\",\"admin\"]', '2026-07-10 10:16:08', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (110, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:16:09\",\"admin\"]', '2026-07-10 10:16:09', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (111, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:16:09\",\"admin\"]', '2026-07-10 10:16:09', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (112, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:16:10\",\"admin\"]', '2026-07-10 10:16:10', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (113, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00002\",\"\\n                    MIX\",2000,\"5\",10000,\"2026-07-10\",\"11:16:13\",\"admin\"]', '2026-07-10 10:16:13', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (114, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"0\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"11:16:19\",\"admin\"]', '2026-07-10 10:16:19', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (115, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"11:16:20\",\"admin\"]', '2026-07-10 10:16:20', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (116, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"0\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"11:18:16\",\"admin\"]', '2026-07-10 10:18:16', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (117, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"11:18:17\",\"admin\"]', '2026-07-10 10:18:17', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (118, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"0\",\"B00001\",\"Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:34\",\"admin\"]', '2026-07-10 10:18:34', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (119, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:35\",\"admin\"]', '2026-07-10 10:18:35', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (120, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:35\",\"admin\"]', '2026-07-10 10:18:35', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (121, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:35\",\"admin\"]', '2026-07-10 10:18:35', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (122, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:37\",\"admin\"]', '2026-07-10 10:18:37', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (123, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:38\",\"admin\"]', '2026-07-10 10:18:38', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (124, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:38\",\"admin\"]', '2026-07-10 10:18:38', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (125, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:39\",\"admin\"]', '2026-07-10 10:18:39', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (126, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:39\",\"admin\"]', '2026-07-10 10:18:39', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (127, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:39\",\"admin\"]', '2026-07-10 10:18:39', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (128, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:40\",\"admin\"]', '2026-07-10 10:18:40', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (129, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:48\",\"admin\"]', '2026-07-10 10:18:48', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (130, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:52\",\"admin\"]', '2026-07-10 10:18:52', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (131, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"2\",10000,\"2026-07-10\",\"11:18:56\",\"admin\"]', '2026-07-10 10:18:56', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (132, 'INSERT INTO `mlite_penjualan_detail`(`id`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"0\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"11:20:34\",\"admin\"]', '2026-07-10 10:20:34', 'SQLSTATE[HY000]: General error: 1364 Field \'id_penjualan\' doesn\'t have a default value', 'admin');
INSERT INTO `mlite_query_logs` VALUES (133, 'INSERT INTO `mlite_penjualan_detail`(`id_penjualan`,`id_barang`,`nama_barang`,`harga`,`jumlah`,`harga_total`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"<div class=\\\"alert alert-danger alert-dismissible fade in\\\" role=\\\"alert\\\">\\n            <button type=\\\"button\\\" class=\\\"close\\\" data-dismiss=\\\"alert\\\" aria-label=\\\"Close\\\"><span aria-hidden=\\\"true\\\">&times;<\\/span><\\/button>\\n            <h4>Database connection failed<\\/h4>\\n            <p>Please check database configuration and ensure MySQL server is running<\\/p>\\n            \\n        <\\/div>\",\"B00001\",\"\\n                    Paracetamol 500mg\",5000,\"5\",25000,\"2026-07-10\",\"11:20:39\",\"admin\"]', '2026-07-10 10:20:39', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\">\n            <button type=\"button\" class=\"close\" data-dis\' for column \'id_penjualan\' at row 1', 'admin');
INSERT INTO `mlite_query_logs` VALUES (134, 'INSERT INTO `mlite_penjualan_billing`(`id_penjualan`,`jumlah_total`,`potongan`,`jumlah_harus_bayar`,`jumlah_bayar`,`keterangan`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"0\",\"85000\",\"0\",\"85000\",\"200000\",\"Tunai\",\"2026-07-10\",\"12:20:07\",\"admin\"]', '2026-07-10 11:20:43', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'keterangan\' in \'field list\'', 'admin');
INSERT INTO `mlite_query_logs` VALUES (135, 'INSERT INTO `mlite_penjualan_billing`(`id_penjualan`,`jumlah_total`,`potongan`,`jumlah_harus_bayar`,`jumlah_bayar`,`keterangan`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"0\",\"85000\",\"0\",\"85000\",\"200000\",\"Tunai\",\"2026-07-10\",\"12:20:07\",\"admin\"]', '2026-07-10 11:21:01', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'keterangan\' in \'field list\'', 'admin');
INSERT INTO `mlite_query_logs` VALUES (136, 'INSERT INTO `mlite_penjualan_billing`(`id_penjualan`,`jumlah_total`,`potongan`,`jumlah_harus_bayar`,`jumlah_bayar`,`keterangan`,`tanggal`,`jam`,`id_user`) VALUES(?,?,?,?,?,?,?,?,?)', '[\"0\",\"85000\",\"0\",\"85000\",\"200000\",\"Belum Bayar\",\"2026-07-10\",\"12:20:07\",\"admin\"]', '2026-07-10 11:21:07', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'keterangan\' in \'field list\'', 'admin');

-- ----------------------------
-- Table structure for mlite_rekening
-- ----------------------------
DROP TABLE IF EXISTS `mlite_rekening`;
CREATE TABLE `mlite_rekening`  (
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nm_rek` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipe` enum('N','M','R') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `balance` enum('D','K') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_rek`) USING BTREE,
  INDEX `nm_rek`(`nm_rek` ASC) USING BTREE,
  INDEX `tipe`(`tipe` ASC) USING BTREE,
  INDEX `balance`(`balance` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_rekening
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_rekeningtahun
-- ----------------------------
DROP TABLE IF EXISTS `mlite_rekeningtahun`;
CREATE TABLE `mlite_rekeningtahun`  (
  `thn` year NOT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `saldo_awal` double NOT NULL,
  PRIMARY KEY (`thn`, `kd_rek`) USING BTREE,
  INDEX `kd_rek`(`kd_rek` ASC) USING BTREE,
  INDEX `saldo_awal`(`saldo_awal` ASC) USING BTREE,
  CONSTRAINT `mlite_rekeningtahun_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `mlite_rekening` (`kd_rek`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_rekeningtahun
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_remember_me
-- ----------------------------
DROP TABLE IF EXISTS `mlite_remember_me`;
CREATE TABLE `mlite_remember_me`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `user_id` int NOT NULL,
  `expiry` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mlite_remember_me_ibfk_1`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_remember_me
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_rujukan_internal_poli
-- ----------------------------
DROP TABLE IF EXISTS `mlite_rujukan_internal_poli`;
CREATE TABLE `mlite_rujukan_internal_poli`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_poli` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `isi_rujukan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `jawab_rujukan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`no_rawat`, `kd_dokter`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `kd_poli`(`kd_poli` ASC) USING BTREE,
  CONSTRAINT `mlite_rujukan_internal_poli_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mlite_rujukan_internal_poli_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mlite_rujukan_internal_poli_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_rujukan_internal_poli
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_satu_sehat_departemen
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_departemen`;
CREATE TABLE `mlite_satu_sehat_departemen`  (
  `dep_id` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_organisasi_satusehat` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dep_id`) USING BTREE,
  UNIQUE INDEX `id_organisasi_satusehat`(`id_organisasi_satusehat` ASC) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_departemen_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `departemen` (`dep_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_satu_sehat_departemen
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_satu_sehat_lokasi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_lokasi`;
CREATE TABLE `mlite_satu_sehat_lokasi`  (
  `kode` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_organisasi_satusehat` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lokasi_satusehat` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `longitude` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `latitude` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `altitude` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode`) USING BTREE,
  UNIQUE INDEX `id_lokasi_satusehat`(`id_lokasi_satusehat` ASC) USING BTREE,
  INDEX `id_organisasi_satusehat`(`id_organisasi_satusehat` ASC) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_lokasi_ibfk_2` FOREIGN KEY (`id_organisasi_satusehat`) REFERENCES `mlite_satu_sehat_departemen` (`id_organisasi_satusehat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_satu_sehat_lokasi
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_satu_sehat_mapping_lab
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_mapping_lab`;
CREATE TABLE `mlite_satu_sehat_mapping_lab`  (
  `id_template` int NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `system` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `display` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sampel_code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sampel_system` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sampel_display` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_template`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_mapping_lab_ibfk_1` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_satu_sehat_mapping_lab
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_satu_sehat_mapping_obat
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_mapping_obat`;
CREATE TABLE `mlite_satu_sehat_mapping_obat`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_kfa` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_kfa` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_bahan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_bahan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `numerator` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `satuan_num` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `denominator` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `satuan_den` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_satuan_den` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_sediaan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_sediaan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_route` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_route` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` enum('obat','vaksin') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_medication` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_brng`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_mapping_obat_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_satu_sehat_mapping_obat
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_satu_sehat_mapping_praktisi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_mapping_praktisi`;
CREATE TABLE `mlite_satu_sehat_mapping_praktisi`  (
  `practitioner_id` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jenis_praktisi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`practitioner_id`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_mapping_praktisi_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_satu_sehat_mapping_praktisi
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_satu_sehat_mapping_rad
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_mapping_rad`;
CREATE TABLE `mlite_satu_sehat_mapping_rad`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `system` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `display` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sampel_code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sampel_system` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sampel_display` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_mapping_rad_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_satu_sehat_mapping_rad
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_satu_sehat_response
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_response`;
CREATE TABLE `mlite_satu_sehat_response`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_encounter` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_condition` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvnadi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvrespirasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvsuhu` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvspo2` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvgcs` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvtinggi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvberat` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvperut` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvtensi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvkesadaran` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_procedure` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_clinical_impression` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_composition` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_immunization` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_medication_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_medication_dispense` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_medication_statement` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_rad_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_rad_specimen` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_rad_observation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_rad_diagnostic` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pk_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pk_specimen` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pk_observation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pk_diagnostic` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pa_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pa_specimen` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pa_observation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pa_diagnostic` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_mb_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_mb_specimen` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_mb_observation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_mb_diagnostic` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_careplan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_allergy` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_questionnaire` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_response_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_satu_sehat_response
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_settings
-- ----------------------------
DROP TABLE IF EXISTS `mlite_settings`;
CREATE TABLE `mlite_settings`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `module` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `field` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `value` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `module`(`module`, `field`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 167 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_settings
-- ----------------------------
INSERT INTO `mlite_settings` VALUES (1, 'settings', 'logo', 'uploads/settings/logo.png');
INSERT INTO `mlite_settings` VALUES (2, 'settings', 'nama_instansi', 'mLITE Indonesia');
INSERT INTO `mlite_settings` VALUES (3, 'settings', 'alamat', 'Jl. Perintis Kemerdekaan 45');
INSERT INTO `mlite_settings` VALUES (4, 'settings', 'kota', 'Barabai');
INSERT INTO `mlite_settings` VALUES (5, 'settings', 'propinsi', 'Kalimantan Selatan');
INSERT INTO `mlite_settings` VALUES (6, 'settings', 'nomor_telepon', '0812345678');
INSERT INTO `mlite_settings` VALUES (7, 'settings', 'email', 'info@mlite.id');
INSERT INTO `mlite_settings` VALUES (8, 'settings', 'website', 'https://mlite.id');
INSERT INTO `mlite_settings` VALUES (9, 'settings', 'ppk_bpjs', '-');
INSERT INTO `mlite_settings` VALUES (10, 'settings', 'footer', 'Copyright {?=date(\"Y\")?} &copy; by drg. F. Basoro. All rights reserved.');
INSERT INTO `mlite_settings` VALUES (11, 'settings', 'homepage', 'main');
INSERT INTO `mlite_settings` VALUES (12, 'settings', 'wallpaper', 'uploads/settings/wallpaper.jpg');
INSERT INTO `mlite_settings` VALUES (13, 'settings', 'text_color', '#44813e');
INSERT INTO `mlite_settings` VALUES (14, 'settings', 'igd', 'IGDK');
INSERT INTO `mlite_settings` VALUES (15, 'settings', 'laboratorium', '-');
INSERT INTO `mlite_settings` VALUES (16, 'settings', 'pj_laboratorium', 'DR001');
INSERT INTO `mlite_settings` VALUES (17, 'settings', 'radiologi', '-');
INSERT INTO `mlite_settings` VALUES (18, 'settings', 'pj_radiologi', 'DR001');
INSERT INTO `mlite_settings` VALUES (19, 'settings', 'dokter_ralan_per_dokter', 'false');
INSERT INTO `mlite_settings` VALUES (20, 'settings', 'cekstatusbayar', 'false');
INSERT INTO `mlite_settings` VALUES (21, 'settings', 'ceklimit', 'false');
INSERT INTO `mlite_settings` VALUES (22, 'settings', 'responsivevoice', 'false');
INSERT INTO `mlite_settings` VALUES (23, 'settings', 'notif_presensi', 'true');
INSERT INTO `mlite_settings` VALUES (24, 'settings', 'BpjsApiUrl', 'https://apijkn-dev.bpjs-kesehatan.go.id/vclaim-rest-dev/');
INSERT INTO `mlite_settings` VALUES (25, 'settings', 'BpjsConsID', '-');
INSERT INTO `mlite_settings` VALUES (26, 'settings', 'BpjsSecretKey', '-');
INSERT INTO `mlite_settings` VALUES (27, 'settings', 'BpjsUserKey', '-');
INSERT INTO `mlite_settings` VALUES (28, 'settings', 'timezone', 'Asia/Makassar');
INSERT INTO `mlite_settings` VALUES (29, 'settings', 'theme', 'default');
INSERT INTO `mlite_settings` VALUES (30, 'settings', 'theme_admin', 'mlite');
INSERT INTO `mlite_settings` VALUES (31, 'settings', 'admin_mode', 'complex');
INSERT INTO `mlite_settings` VALUES (32, 'settings', 'input_kasir', 'tidak');
INSERT INTO `mlite_settings` VALUES (33, 'settings', 'editor', 'wysiwyg');
INSERT INTO `mlite_settings` VALUES (34, 'settings', 'version', '6.2.0');
INSERT INTO `mlite_settings` VALUES (35, 'settings', 'update_check', '');
INSERT INTO `mlite_settings` VALUES (36, 'settings', 'update_changelog', '');
INSERT INTO `mlite_settings` VALUES (37, 'settings', 'update_version', '0');
INSERT INTO `mlite_settings` VALUES (38, 'settings', 'license', '');
INSERT INTO `mlite_settings` VALUES (39, 'farmasi', 'deporalan', '-');
INSERT INTO `mlite_settings` VALUES (40, 'farmasi', 'igd', '-');
INSERT INTO `mlite_settings` VALUES (41, 'farmasi', 'deporanap', '-');
INSERT INTO `mlite_settings` VALUES (42, 'farmasi', 'gudang', '-');
INSERT INTO `mlite_settings` VALUES (43, 'wagateway', 'server', 'https://mlite.id');
INSERT INTO `mlite_settings` VALUES (44, 'wagateway', 'token', '-');
INSERT INTO `mlite_settings` VALUES (45, 'wagateway', 'phonenumber', '-');
INSERT INTO `mlite_settings` VALUES (46, 'anjungan', 'display_poli', '');
INSERT INTO `mlite_settings` VALUES (47, 'anjungan', 'carabayar', '');
INSERT INTO `mlite_settings` VALUES (48, 'anjungan', 'antrian_loket', '1');
INSERT INTO `mlite_settings` VALUES (49, 'anjungan', 'antrian_cs', '2');
INSERT INTO `mlite_settings` VALUES (50, 'anjungan', 'antrian_apotek', '3');
INSERT INTO `mlite_settings` VALUES (51, 'anjungan', 'panggil_loket', '1');
INSERT INTO `mlite_settings` VALUES (52, 'anjungan', 'panggil_loket_nomor', '1');
INSERT INTO `mlite_settings` VALUES (53, 'anjungan', 'panggil_cs', '1');
INSERT INTO `mlite_settings` VALUES (54, 'anjungan', 'panggil_cs_nomor', '1');
INSERT INTO `mlite_settings` VALUES (55, 'anjungan', 'panggil_apotek', '1');
INSERT INTO `mlite_settings` VALUES (56, 'anjungan', 'panggil_apotek_nomor', '1');
INSERT INTO `mlite_settings` VALUES (57, 'anjungan', 'text_anjungan', 'Running text anjungan pasien mandiri.....');
INSERT INTO `mlite_settings` VALUES (58, 'anjungan', 'text_loket', 'Running text display antrian loket.....');
INSERT INTO `mlite_settings` VALUES (59, 'anjungan', 'text_poli', 'Running text display antrian poliklinik.....');
INSERT INTO `mlite_settings` VALUES (60, 'anjungan', 'text_laboratorium', 'Running text display antrian laboratorium.....');
INSERT INTO `mlite_settings` VALUES (61, 'anjungan', 'text_apotek', 'Running text display antrian apotek.....');
INSERT INTO `mlite_settings` VALUES (62, 'anjungan', 'text_farmasi', 'Running text display antrian farmasi.....');
INSERT INTO `mlite_settings` VALUES (63, 'anjungan', 'vidio', 'G4im8_n0OoI');
INSERT INTO `mlite_settings` VALUES (64, 'api', 'apam_key', 'qtbexUAxzqO3M8dCOo2vDMFvgYjdUEdMLVo341');
INSERT INTO `mlite_settings` VALUES (65, 'api', 'apam_status_daftar', 'Terdaftar');
INSERT INTO `mlite_settings` VALUES (66, 'api', 'apam_status_dilayani', 'Anda siap dilayani');
INSERT INTO `mlite_settings` VALUES (67, 'api', 'apam_webappsurl', 'http://localhost/webapps/');
INSERT INTO `mlite_settings` VALUES (68, 'api', 'apam_normpetugas', '000001,000002');
INSERT INTO `mlite_settings` VALUES (69, 'api', 'apam_limit', '2');
INSERT INTO `mlite_settings` VALUES (70, 'api', 'apam_smtp_host', 'ssl://smtp.gmail.com');
INSERT INTO `mlite_settings` VALUES (71, 'api', 'apam_smtp_port', '465');
INSERT INTO `mlite_settings` VALUES (72, 'api', 'apam_smtp_username', '');
INSERT INTO `mlite_settings` VALUES (73, 'api', 'apam_smtp_password', '');
INSERT INTO `mlite_settings` VALUES (74, 'api', 'apam_kdpj', '');
INSERT INTO `mlite_settings` VALUES (75, 'api', 'apam_kdprop', '');
INSERT INTO `mlite_settings` VALUES (76, 'api', 'apam_kdkab', '');
INSERT INTO `mlite_settings` VALUES (77, 'api', 'apam_kdkec', '');
INSERT INTO `mlite_settings` VALUES (78, 'api', 'duitku_merchantCode', '');
INSERT INTO `mlite_settings` VALUES (79, 'api', 'duitku_merchantKey', '');
INSERT INTO `mlite_settings` VALUES (80, 'api', 'duitku_paymentAmount', '');
INSERT INTO `mlite_settings` VALUES (81, 'api', 'duitku_paymentMethod', '');
INSERT INTO `mlite_settings` VALUES (82, 'api', 'duitku_productDetails', '');
INSERT INTO `mlite_settings` VALUES (83, 'api', 'duitku_expiryPeriod', '');
INSERT INTO `mlite_settings` VALUES (84, 'api', 'duitku_kdpj', '');
INSERT INTO `mlite_settings` VALUES (85, 'api', 'berkasdigital_key', 'qtbexUAxzqO3M8dCOo2vDMFvgYjdUEdMLVo341');
INSERT INTO `mlite_settings` VALUES (86, 'jkn_mobile', 'x_username', 'jkn');
INSERT INTO `mlite_settings` VALUES (87, 'jkn_mobile', 'x_password', 'mobile');
INSERT INTO `mlite_settings` VALUES (88, 'jkn_mobile', 'header_token', 'X-Token');
INSERT INTO `mlite_settings` VALUES (89, 'jkn_mobile', 'header_username', 'X-Username');
INSERT INTO `mlite_settings` VALUES (90, 'jkn_mobile', 'header_password', 'X-Password');
INSERT INTO `mlite_settings` VALUES (91, 'jkn_mobile', 'BpjsConsID', '');
INSERT INTO `mlite_settings` VALUES (92, 'jkn_mobile', 'BpjsSecretKey', '');
INSERT INTO `mlite_settings` VALUES (93, 'jkn_mobile', 'BpjsUserKey', '');
INSERT INTO `mlite_settings` VALUES (94, 'jkn_mobile', 'BpjsAntrianUrl', 'https://apijkn-dev.bpjs-kesehatan.go.id/antreanrs_dev/');
INSERT INTO `mlite_settings` VALUES (95, 'jkn_mobile', 'kd_pj_bpjs', '');
INSERT INTO `mlite_settings` VALUES (96, 'jkn_mobile', 'exclude_taskid', '');
INSERT INTO `mlite_settings` VALUES (97, 'jkn_mobile', 'display', '');
INSERT INTO `mlite_settings` VALUES (98, 'jkn_mobile', 'kdprop', '1');
INSERT INTO `mlite_settings` VALUES (99, 'jkn_mobile', 'kdkab', '1');
INSERT INTO `mlite_settings` VALUES (100, 'jkn_mobile', 'kdkec', '1');
INSERT INTO `mlite_settings` VALUES (101, 'jkn_mobile', 'kdkel', '1');
INSERT INTO `mlite_settings` VALUES (102, 'jkn_mobile', 'perusahaan_pasien', '');
INSERT INTO `mlite_settings` VALUES (103, 'jkn_mobile', 'suku_bangsa', '');
INSERT INTO `mlite_settings` VALUES (104, 'jkn_mobile', 'bahasa_pasien', '');
INSERT INTO `mlite_settings` VALUES (105, 'jkn_mobile', 'cacat_fisik', '');
INSERT INTO `mlite_settings` VALUES (106, 'keuangan', 'jurnal_kasir', '0');
INSERT INTO `mlite_settings` VALUES (107, 'keuangan', 'akun_kredit_pendaftaran', '');
INSERT INTO `mlite_settings` VALUES (108, 'keuangan', 'akun_kredit_tindakan', '');
INSERT INTO `mlite_settings` VALUES (109, 'keuangan', 'akun_kredit_obat_bhp', '');
INSERT INTO `mlite_settings` VALUES (110, 'keuangan', 'akun_kredit_laboratorium', '');
INSERT INTO `mlite_settings` VALUES (111, 'keuangan', 'akun_kredit_radiologi', '');
INSERT INTO `mlite_settings` VALUES (112, 'keuangan', 'akun_kredit_tambahan_biaya', '');
INSERT INTO `mlite_settings` VALUES (113, 'manajemen', 'penjab_umum', 'UMU');
INSERT INTO `mlite_settings` VALUES (114, 'manajemen', 'penjab_bpjs', 'BPJ');
INSERT INTO `mlite_settings` VALUES (115, 'presensi', 'lat', '-2.58');
INSERT INTO `mlite_settings` VALUES (116, 'presensi', 'lon', '115.37');
INSERT INTO `mlite_settings` VALUES (117, 'presensi', 'distance', '2');
INSERT INTO `mlite_settings` VALUES (118, 'presensi', 'helloworld', 'Jangan Lupa Bahagia; \nCara untuk memulai adalah berhenti berbicara dan mulai melakukan; \nWaktu yang hilang tidak akan pernah ditemukan lagi; \nKamu bisa membodohi semua orang, tetapi kamu tidak bisa membohongi pikiranmu; \nIni bukan tentang ide. Ini tentang mewujudkan ide; \nBekerja bukan hanya untuk mencari materi. Bekerja merupakan manfaat bagi banyak orang');
INSERT INTO `mlite_settings` VALUES (119, 'vedika', 'carabayar', '');
INSERT INTO `mlite_settings` VALUES (120, 'vedika', 'sep', '');
INSERT INTO `mlite_settings` VALUES (121, 'vedika', 'skdp', '');
INSERT INTO `mlite_settings` VALUES (122, 'vedika', 'operasi', '');
INSERT INTO `mlite_settings` VALUES (123, 'vedika', 'individual', '');
INSERT INTO `mlite_settings` VALUES (124, 'vedika', 'billing', 'mlite');
INSERT INTO `mlite_settings` VALUES (125, 'vedika', 'periode', '2023-01');
INSERT INTO `mlite_settings` VALUES (126, 'vedika', 'verifikasi', '2023-01');
INSERT INTO `mlite_settings` VALUES (127, 'vedika', 'inacbgs_prosedur_bedah', '');
INSERT INTO `mlite_settings` VALUES (128, 'vedika', 'inacbgs_prosedur_non_bedah', '');
INSERT INTO `mlite_settings` VALUES (129, 'vedika', 'inacbgs_konsultasi', '');
INSERT INTO `mlite_settings` VALUES (130, 'vedika', 'inacbgs_tenaga_ahli', '');
INSERT INTO `mlite_settings` VALUES (131, 'vedika', 'inacbgs_keperawatan', '');
INSERT INTO `mlite_settings` VALUES (132, 'vedika', 'inacbgs_penunjang', '');
INSERT INTO `mlite_settings` VALUES (133, 'vedika', 'inacbgs_pelayanan_darah', '');
INSERT INTO `mlite_settings` VALUES (134, 'vedika', 'inacbgs_rehabilitasi', '');
INSERT INTO `mlite_settings` VALUES (135, 'vedika', 'inacbgs_rawat_intensif', '');
INSERT INTO `mlite_settings` VALUES (136, 'vedika', 'eklaim_url', '');
INSERT INTO `mlite_settings` VALUES (137, 'vedika', 'eklaim_key', '');
INSERT INTO `mlite_settings` VALUES (138, 'vedika', 'eklaim_kelasrs', 'CP');
INSERT INTO `mlite_settings` VALUES (139, 'vedika', 'eklaim_payor_id', '3');
INSERT INTO `mlite_settings` VALUES (140, 'vedika', 'eklaim_payor_cd', 'JKN');
INSERT INTO `mlite_settings` VALUES (141, 'vedika', 'eklaim_cob_cd', '#');
INSERT INTO `mlite_settings` VALUES (142, 'orthanc', 'server', 'http://localhost:8042');
INSERT INTO `mlite_settings` VALUES (143, 'orthanc', 'username', 'orthanc');
INSERT INTO `mlite_settings` VALUES (144, 'orthanc', 'password', 'orthanc');
INSERT INTO `mlite_settings` VALUES (145, 'veronisa', 'username', '');
INSERT INTO `mlite_settings` VALUES (146, 'veronisa', 'password', '');
INSERT INTO `mlite_settings` VALUES (147, 'veronisa', 'obat_kronis', '');
INSERT INTO `mlite_settings` VALUES (148, 'jkn_mobile', 'kirimantrian', 'tidak');
INSERT INTO `mlite_settings` VALUES (149, 'settings', 'keamanan', 'ya');
INSERT INTO `mlite_settings` VALUES (150, 'dokter_ralan', 'set_sudah', 'tidak');
INSERT INTO `mlite_settings` VALUES (151, 'settings', 'websocket', 'tidak');
INSERT INTO `mlite_settings` VALUES (152, 'settings', 'websocket_proxy', '');
INSERT INTO `mlite_settings` VALUES (153, 'settings', 'username_fp', '');
INSERT INTO `mlite_settings` VALUES (154, 'settings', 'password_fp', '');
INSERT INTO `mlite_settings` VALUES (155, 'settings', 'username_frista', '');
INSERT INTO `mlite_settings` VALUES (156, 'settings', 'password_frista', '');
INSERT INTO `mlite_settings` VALUES (157, 'settings', 'billing_obat', 'false');
INSERT INTO `mlite_settings` VALUES (158, 'settings', 'prefix_surat', 'RS');
INSERT INTO `mlite_settings` VALUES (159, 'farmasi', 'keterangan_etiket', '');
INSERT INTO `mlite_settings` VALUES (160, 'pcare', 'consumerUserKeyAntrol', '');
INSERT INTO `mlite_settings` VALUES (161, 'settings', 'set_nomor_surat', '000');
INSERT INTO `mlite_settings` VALUES (162, 'settings', 'password_expire', 'tidak');
INSERT INTO `mlite_settings` VALUES (163, 'farmasi', 'embalase', '0');
INSERT INTO `mlite_settings` VALUES (164, 'farmasi', 'tuslah', '0');
INSERT INTO `mlite_settings` VALUES (165, 'settings', 'log_query', 'tidak');
INSERT INTO `mlite_settings` VALUES (166, 'farmasi', 'obatluar', 'OBL');

-- ----------------------------
-- Table structure for mlite_subrekening
-- ----------------------------
DROP TABLE IF EXISTS `mlite_subrekening`;
CREATE TABLE `mlite_subrekening`  (
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_rek2` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_rek2`) USING BTREE,
  INDEX `kd_rek`(`kd_rek` ASC) USING BTREE,
  CONSTRAINT `mlite_subrekening_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `mlite_rekening` (`kd_rek`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `mlite_subrekening_ibfk_2` FOREIGN KEY (`kd_rek2`) REFERENCES `mlite_rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_subrekening
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_surat_rujukan
-- ----------------------------
DROP TABLE IF EXISTS `mlite_surat_rujukan`;
CREATE TABLE `mlite_surat_rujukan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nomor_surat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rkm_medis` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `umur` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kepada` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `di` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `anamnesa` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_fisik` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosa` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `terapi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alasan_dirujuk` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_surat_rujukan
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_surat_sakit
-- ----------------------------
DROP TABLE IF EXISTS `mlite_surat_sakit`;
CREATE TABLE `mlite_surat_sakit`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nomor_surat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rkm_medis` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `umur` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keadaan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosa` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lama_angka` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lama_huruf` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_mulai` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_selesai` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_surat_sakit
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_surat_sehat
-- ----------------------------
DROP TABLE IF EXISTS `mlite_surat_sehat`;
CREATE TABLE `mlite_surat_sehat`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nomor_surat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rkm_medis` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `umur` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `berat_badan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tinggi_badan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tensi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gol_darah` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `riwayat_penyakit` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keperluan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_surat_sehat
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_temporary
-- ----------------------------
DROP TABLE IF EXISTS `mlite_temporary`;
CREATE TABLE `mlite_temporary`  (
  `temp1` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp2` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp3` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp4` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp5` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp6` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp7` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp8` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp9` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp10` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp11` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp12` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp13` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp14` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp15` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp16` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp17` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp18` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp19` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp20` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp21` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp22` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp23` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp24` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp25` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp26` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp27` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp28` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp29` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp30` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp31` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp32` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp33` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp34` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp35` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp36` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp37` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp38` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp39` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp40` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp41` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp42` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp43` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp44` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp45` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp46` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp47` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp48` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp49` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp50` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp51` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp52` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp53` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp54` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp55` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp56` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp57` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp58` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp59` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp60` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp61` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp62` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp63` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp64` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp65` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp66` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp67` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp68` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp69` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp70` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp71` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp72` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp73` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp74` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp75` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp76` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp77` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp78` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp79` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp80` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp81` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp82` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp83` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp84` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp85` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp86` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp87` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp88` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp89` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp90` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp91` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp92` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp93` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp94` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp95` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp96` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp97` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp98` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp99` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp100` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_temporary
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_triase_igd
-- ----------------------------
DROP TABLE IF EXISTS `mlite_triase_igd`;
CREATE TABLE `mlite_triase_igd`  (
  `id_triase` int NOT NULL AUTO_INCREMENT,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_triase` datetime NOT NULL,
  `petugas_id` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kesadaran` enum('Compos Mentis','Apatis','Somnolen','Sopor','Koma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `airway` enum('Bebas','Sumbatan Parsial','Sumbatan Total') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `breathing` enum('Spontan','Tak Spontan','Distres Nafas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `circulation` enum('Baik','Syok','Perdarahan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tekanan_darah` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nadi` int NULL DEFAULT NULL,
  `respirasi` int NULL DEFAULT NULL,
  `suhu` decimal(4, 1) NULL DEFAULT NULL,
  `spo2` int NULL DEFAULT NULL,
  `gcs_e` tinyint NULL DEFAULT NULL,
  `gcs_v` tinyint NULL DEFAULT NULL,
  `gcs_m` tinyint NULL DEFAULT NULL,
  `kategori` enum('Merah','Kuning','Hijau','Hitam') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `skala_triase` enum('1','2','3','4','5') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keluhan_utama` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `diagnosa_awal` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_triase`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  CONSTRAINT `fk_triase_reg_periksa` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_triase_igd
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_users
-- ----------------------------
DROP TABLE IF EXISTS `mlite_users`;
CREATE TABLE `mlite_users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `fullname` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `password_changed_at` datetime NULL DEFAULT NULL,
  `otp_code` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `otp_expires` datetime NULL DEFAULT NULL,
  `avatar` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `email` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `role` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'user',
  `cap` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `access` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'dashboard',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_users
-- ----------------------------
INSERT INTO `mlite_users` VALUES (1, 'admin', 'Administrator', 'Admin ganteng baik hati, suka menabung dan tidak sombong.', '$2y$10$pgRnDiukCbiYVqsamMM3ROWViSRqbyCCL33N8.ykBKZx0dlplXe9i', NULL, NULL, NULL, 'avatar6422cb573b50c.png', 'info@mlite.id', 'admin', '', 'all');
INSERT INTO `mlite_users` VALUES (8, 'anggi', 'DESTIANA ANGGI P', '-', '$2y$10$4tLaorEMH/XkW7IJ/kEbE.5qxMy/8lU9elsGTauQYBYTaSfEx3zJi', NULL, NULL, NULL, 'avatar688d86e6b6bf8.png', 'anggi@gmail.com', 'rekammedis', '', 'pasien,pendaftaran,master,laporan,pcare,satu_sehat,dashboard');
INSERT INTO `mlite_users` VALUES (9, 'subaktiar', 'subaktiar', '-', '$2y$10$Mq1B3ZeW55lXRJkLJQ.mxeoyU2HLELxm5889v422I8Z42rfJo3qqq', NULL, NULL, NULL, 'avatar688d8865aa1df.png', 'tiar@gmail.com', 'pengguna', '', 'pasien,master,laporan,blog,pcare,satu_sehat,dashboard');
INSERT INTO `mlite_users` VALUES (7, 'lutfia', 'lutfia dyah damayanti', '-', '$2y$10$JrBo6VyB2xTvgsQHWf3Zyut40ZKkG1rrSfv/4eGaX7As7mOagtjwO', NULL, NULL, NULL, 'avatar688d86306f6a2.png', 'lutfia@gmail.com', 'rekammedis', '', 'pasien,pendaftaran,kasir,master,laporan,pcare,satu_sehat,dashboard');
INSERT INTO `mlite_users` VALUES (6, 'aan', 'siti wakhidatul a', '-', '$2y$10$pRHRDZ5HC52vBSR3EgVVZuasDZHbhBtUyGty2m/w1Ewn7q/bm8jJO', NULL, NULL, NULL, 'avatar688d84942016a.png', 'siti@gmail.com', 'apoteker', '', 'kasir,master,laporan,blog,satu_sehat,dashboard');
INSERT INTO `mlite_users` VALUES (5, 'perawat', 'perawat', '-', '$2y$10$bwori.fxI8YSbOeV6D6PLesRovzav40U1lbOFM5DqvZsvoS3Xiy0i', NULL, NULL, NULL, 'avatar688ac50b6dd0c.png', 'perawat@gmail.com', 'rekammedis', '', 'pasien,pendaftaran,master,pcare,satu_sehat,dashboard');
INSERT INTO `mlite_users` VALUES (4, 'apotek', 'apotek', '-', '$2y$10$w0y.GL116spz2tn4dlHmfeokZDChDtxmBUjF4G7jwMGfBPCvrdlnm', NULL, NULL, NULL, 'avatar688ac4d09aa8f.png', 'apotek@gmail.com', 'apoteker', '', 'kasir,master,laporan,blog,satu_sehat,dashboard');
INSERT INTO `mlite_users` VALUES (3, 'pendaftaran', 'pendaftaran', '-', '$2y$10$XkzxPAai/Yv6lUsal1eSB.S6DybcFKyhUi0NfcjbkiK1nn3LwvYL2', NULL, NULL, NULL, 'avatar688ac4993f72e.png', 'pendaftaran@gmail.com', 'pengguna', '', 'pasien,master,laporan,blog,satu_sehat,dashboard');
INSERT INTO `mlite_users` VALUES (2, 'DR000002', 'dr. Fenty Sulistyo E', 'Akun kusus dokter', '$2y$10$L95k.twSe275NULURrNwjOase6kZkZ1Nq8UWboYFw4F.4VS5Al.Am', NULL, NULL, NULL, 'avatar676e40f62bcf0.png', 'drfenty@gmail.com', 'admin', '', 'pasien,pendaftaran,kasir,master,laporan,blog,pcare,satu_sehat,dashboard');

-- ----------------------------
-- Table structure for mlite_users_vedika
-- ----------------------------
DROP TABLE IF EXISTS `mlite_users_vedika`;
CREATE TABLE `mlite_users_vedika`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `fullname` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_users_vedika
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_vedika
-- ----------------------------
DROP TABLE IF EXISTS `mlite_vedika`;
CREATE TABLE `mlite_vedika`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tanggal` date NULL DEFAULT NULL,
  `no_rkm_medis` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `no_rawat` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `tgl_registrasi` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nosep` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `jenis` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `status` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_vedika_status_jenis_tgl`(`status` ASC, `jenis` ASC, `tgl_registrasi` ASC) USING BTREE,
  INDEX `idx_vedika_nosep`(`nosep` ASC) USING BTREE,
  INDEX `idx_vedika_no_rkm_medis`(`no_rkm_medis` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_vedika
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_vedika_feedback
-- ----------------------------
DROP TABLE IF EXISTS `mlite_vedika_feedback`;
CREATE TABLE `mlite_vedika_feedback`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nosep` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `catatan` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_vedika_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_veronisa
-- ----------------------------
DROP TABLE IF EXISTS `mlite_veronisa`;
CREATE TABLE `mlite_veronisa`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tanggal` date NULL DEFAULT NULL,
  `no_rkm_medis` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `no_rawat` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `tgl_registrasi` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nosep` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `status` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_nosep`(`nosep` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_veronisa
-- ----------------------------

-- ----------------------------
-- Table structure for mlite_veronisa_feedback
-- ----------------------------
DROP TABLE IF EXISTS `mlite_veronisa_feedback`;
CREATE TABLE `mlite_veronisa_feedback`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nosep` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `catatan` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mlite_veronisa_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for modules
-- ----------------------------
DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules`  (
  `id` int NOT NULL,
  `dir` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sequence` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of modules
-- ----------------------------
INSERT INTO `modules` VALUES (1, 'settings', 8);
INSERT INTO `modules` VALUES (2, 'pasien', 1);
INSERT INTO `modules` VALUES (3, 'pendaftaran', 2);
INSERT INTO `modules` VALUES (4, 'kasir', 3);
INSERT INTO `modules` VALUES (5, 'master', 4);
INSERT INTO `modules` VALUES (6, 'laporan', 5);
INSERT INTO `modules` VALUES (7, 'dashboard', 0);
INSERT INTO `modules` VALUES (8, 'users', 7);
INSERT INTO `modules` VALUES (9, 'modules', 6);
INSERT INTO `modules` VALUES (10, 'blog', 9);
INSERT INTO `modules` VALUES (11, 'pcare', 10);
INSERT INTO `modules` VALUES (12, 'satu_sehat', 11);

-- ----------------------------
-- Table structure for mutasi_berkas
-- ----------------------------
DROP TABLE IF EXISTS `mutasi_berkas`;
CREATE TABLE `mutasi_berkas`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Sudah Dikirim','Sudah Diterima','Sudah Kembali','Tidak Ada','Masuk Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dikirim` datetime NULL DEFAULT NULL,
  `diterima` datetime NULL DEFAULT NULL,
  `kembali` datetime NULL DEFAULT NULL,
  `tidakada` datetime NULL DEFAULT NULL,
  `ranap` datetime NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  CONSTRAINT `mutasi_berkas_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mutasi_berkas
-- ----------------------------

-- ----------------------------
-- Table structure for mutasibarang
-- ----------------------------
DROP TABLE IF EXISTS `mutasibarang`;
CREATE TABLE `mutasibarang`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml` double NOT NULL,
  `harga` double NOT NULL,
  `kd_bangsaldari` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_bangsalke` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `keterangan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode_brng`, `kd_bangsaldari`, `kd_bangsalke`, `tanggal`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `kd_bangsaldari`(`kd_bangsaldari` ASC) USING BTREE,
  INDEX `kd_bangsalke`(`kd_bangsalke` ASC) USING BTREE,
  INDEX `jml`(`jml` ASC) USING BTREE,
  INDEX `keterangan`(`keterangan` ASC) USING BTREE,
  INDEX `kode_brng`(`kode_brng` ASC) USING BTREE,
  CONSTRAINT `mutasibarang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mutasibarang_ibfk_2` FOREIGN KEY (`kd_bangsaldari`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mutasibarang_ibfk_3` FOREIGN KEY (`kd_bangsalke`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mutasibarang
-- ----------------------------
INSERT INTO `mutasibarang` VALUES ('B00001', 200, 5000, '-', 'APT', '2026-07-02 09:33:19', 'Set Stok - Mutasi', '0', '0');
INSERT INTO `mutasibarang` VALUES ('B00001', 200, 5000, '-', 'OBL', '2026-07-08 11:58:07', 'Set Stok - Mutasi', '0', '0');
INSERT INTO `mutasibarang` VALUES ('B00002', 200, 2000, '-', 'OBL', '2026-07-10 09:32:08', 'Set Stok - Mutasi', '0', '0');

-- ----------------------------
-- Table structure for obat
-- ----------------------------
DROP TABLE IF EXISTS `obat`;
CREATE TABLE `obat`  (
  `id` int NOT NULL,
  `nama_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `harga` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `stok` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of obat
-- ----------------------------
INSERT INTO `obat` VALUES (1, 'AKITA', '6000', '100');
INSERT INTO `obat` VALUES (2, 'AM HJ', '900', '100');
INSERT INTO `obat` VALUES (3, 'paracetamol', '500', '999');
INSERT INTO `obat` VALUES (4, 'LC', '1500', '93');
INSERT INTO `obat` VALUES (5, 'LP', '2200', '95');
INSERT INTO `obat` VALUES (6, 'R22', '1000', '93');
INSERT INTO `obat` VALUES (7, 'HISTIGO', '800', '100');
INSERT INTO `obat` VALUES (8, 'M2', '1000', '100');
INSERT INTO `obat` VALUES (9, 'RANITIDIN ', '700', '100');
INSERT INTO `obat` VALUES (10, 'MN', '800', '100');
INSERT INTO `obat` VALUES (11, 'Novaxifen ', '1000', '93');
INSERT INTO `obat` VALUES (12, 'CAVIPLEX', '15000', '300');
INSERT INTO `obat` VALUES (13, 'SPASMINAL', '15000', '300');
INSERT INTO `obat` VALUES (14, 'DYMENHIDRINATE ', '500', '300');
INSERT INTO `obat` VALUES (15, 'METRONIDAZOLE ', '700', '200');
INSERT INTO `obat` VALUES (16, 'MH TAB', '1500', '300');
INSERT INTO `obat` VALUES (17, 'AMOXAN CAPS 500MG', '5000', '100');
INSERT INTO `obat` VALUES (18, 'MEFINAL TAB', '2200', '100');
INSERT INTO `obat` VALUES (19, 'M2', '1000', '400');
INSERT INTO `obat` VALUES (20, 'MOLAGIT ', '1500', '500');
INSERT INTO `obat` VALUES (21, 'LIDOCAIN INJ', '5000', '100');

-- ----------------------------
-- Table structure for obat_racikan
-- ----------------------------
DROP TABLE IF EXISTS `obat_racikan`;
CREATE TABLE `obat_racikan`  (
  `tgl_perawatan` date NOT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_racik` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_racik` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_racik` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml_dr` int NOT NULL,
  `aturan_pakai` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_perawatan`, `jam`, `no_rawat`, `no_racik`) USING BTREE,
  INDEX `kd_racik`(`kd_racik` ASC) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `no_racik`(`no_racik` ASC) USING BTREE,
  CONSTRAINT `obat_racikan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `obat_racikan_ibfk_2` FOREIGN KEY (`kd_racik`) REFERENCES `metode_racik` (`kd_racik`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of obat_racikan
-- ----------------------------

-- ----------------------------
-- Table structure for obatbhp_ok
-- ----------------------------
DROP TABLE IF EXISTS `obatbhp_ok`;
CREATE TABLE `obatbhp_ok`  (
  `kd_obat` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_obat` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hargasatuan` double NOT NULL,
  PRIMARY KEY (`kd_obat`) USING BTREE,
  INDEX `kode_sat`(`kode_sat` ASC) USING BTREE,
  INDEX `nm_obat`(`nm_obat` ASC) USING BTREE,
  INDEX `hargasatuan`(`hargasatuan` ASC) USING BTREE,
  CONSTRAINT `obatbhp_ok_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of obatbhp_ok
-- ----------------------------

-- ----------------------------
-- Table structure for odontogram
-- ----------------------------
DROP TABLE IF EXISTS `odontogram`;
CREATE TABLE `odontogram`  (
  `id` int NULL DEFAULT NULL,
  `id_pasien` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pemeriksaan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kondisi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of odontogram
-- ----------------------------

-- ----------------------------
-- Table structure for ohis
-- ----------------------------
DROP TABLE IF EXISTS `ohis`;
CREATE TABLE `ohis`  (
  `id` int NULL DEFAULT NULL,
  `id_pasien` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `d_16` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_11` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_26` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_36` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_31` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `d_46` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_16` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_11` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_26` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_36` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_31` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `c_46` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `debris` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `calculus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nilai` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kriteria` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ohis
-- ----------------------------

-- ----------------------------
-- Table structure for operasi
-- ----------------------------
DROP TABLE IF EXISTS `operasi`;
CREATE TABLE `operasi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `jenis_anasthesi` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kategori` enum('-','Khusus','Besar','Sedang','Kecil','Elektive','Emergency') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `operator1` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `operator2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `operator3` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_operator1` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_operator2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_operator3` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `instrumen` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter_anak` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perawaat_resusitas` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dokter_anestesi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_anestesi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_anestesi2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bidan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bidan2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bidan3` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perawat_luar` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `omloop` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `omloop2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `omloop3` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `omloop4` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `omloop5` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter_pjanak` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter_umum` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biayaoperator1` double NOT NULL,
  `biayaoperator2` double NOT NULL,
  `biayaoperator3` double NOT NULL,
  `biayaasisten_operator1` double NOT NULL,
  `biayaasisten_operator2` double NOT NULL,
  `biayaasisten_operator3` double NULL DEFAULT NULL,
  `biayainstrumen` double NULL DEFAULT NULL,
  `biayadokter_anak` double NOT NULL,
  `biayaperawaat_resusitas` double NOT NULL,
  `biayadokter_anestesi` double NOT NULL,
  `biayaasisten_anestesi` double NOT NULL,
  `biayaasisten_anestesi2` double NULL DEFAULT NULL,
  `biayabidan` double NOT NULL,
  `biayabidan2` double NULL DEFAULT NULL,
  `biayabidan3` double NULL DEFAULT NULL,
  `biayaperawat_luar` double NOT NULL,
  `biayaalat` double NOT NULL,
  `biayasewaok` double NOT NULL,
  `akomodasi` double NULL DEFAULT NULL,
  `bagian_rs` double NOT NULL,
  `biaya_omloop` double NULL DEFAULT NULL,
  `biaya_omloop2` double NULL DEFAULT NULL,
  `biaya_omloop3` double NULL DEFAULT NULL,
  `biaya_omloop4` double NULL DEFAULT NULL,
  `biaya_omloop5` double NULL DEFAULT NULL,
  `biayasarpras` double NULL DEFAULT NULL,
  `biaya_dokter_pjanak` double NULL DEFAULT NULL,
  `biaya_dokter_umum` double NULL DEFAULT NULL,
  `status` enum('Ranap','Ralan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_operasi`, `kode_paket`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `operator1`(`operator1` ASC) USING BTREE,
  INDEX `operator2`(`operator2` ASC) USING BTREE,
  INDEX `operator3`(`operator3` ASC) USING BTREE,
  INDEX `asisten_operator1`(`asisten_operator1` ASC) USING BTREE,
  INDEX `asisten_operator2`(`asisten_operator2` ASC) USING BTREE,
  INDEX `dokter_anak`(`dokter_anak` ASC) USING BTREE,
  INDEX `perawaat_resusitas`(`perawaat_resusitas` ASC) USING BTREE,
  INDEX `dokter_anestesi`(`dokter_anestesi` ASC) USING BTREE,
  INDEX `asisten_anestesi`(`asisten_anestesi` ASC) USING BTREE,
  INDEX `bidan`(`bidan` ASC) USING BTREE,
  INDEX `perawat_luar`(`perawat_luar` ASC) USING BTREE,
  INDEX `kode_paket`(`kode_paket` ASC) USING BTREE,
  CONSTRAINT `operasi_ibfk_31` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_32` FOREIGN KEY (`operator1`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_33` FOREIGN KEY (`operator2`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_34` FOREIGN KEY (`operator3`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_35` FOREIGN KEY (`asisten_operator1`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_36` FOREIGN KEY (`asisten_operator2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_38` FOREIGN KEY (`dokter_anak`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_39` FOREIGN KEY (`perawaat_resusitas`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_40` FOREIGN KEY (`dokter_anestesi`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_41` FOREIGN KEY (`asisten_anestesi`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_42` FOREIGN KEY (`bidan`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_43` FOREIGN KEY (`perawat_luar`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_44` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operasi
-- ----------------------------

-- ----------------------------
-- Table structure for opname
-- ----------------------------
DROP TABLE IF EXISTS `opname`;
CREATE TABLE `opname`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h_beli` double NULL DEFAULT NULL,
  `tanggal` date NOT NULL,
  `stok` double NOT NULL,
  `real` double NOT NULL,
  `selisih` double NOT NULL,
  `nomihilang` double NOT NULL,
  `lebih` double NOT NULL,
  `nomilebih` double NOT NULL,
  `keterangan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode_brng`, `tanggal`, `kd_bangsal`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal` ASC) USING BTREE,
  INDEX `stok`(`stok` ASC) USING BTREE,
  INDEX `real`(`real` ASC) USING BTREE,
  INDEX `selisih`(`selisih` ASC) USING BTREE,
  INDEX `nomihilang`(`nomihilang` ASC) USING BTREE,
  INDEX `keterangan`(`keterangan` ASC) USING BTREE,
  INDEX `kode_brng`(`kode_brng` ASC) USING BTREE,
  CONSTRAINT `opname_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `opname_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of opname
-- ----------------------------

-- ----------------------------
-- Table structure for paket_operasi
-- ----------------------------
DROP TABLE IF EXISTS `paket_operasi`;
CREATE TABLE `paket_operasi`  (
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kategori` enum('Kebidanan','Operasi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `operator1` double NOT NULL,
  `operator2` double NOT NULL,
  `operator3` double NOT NULL,
  `asisten_operator1` double NULL DEFAULT NULL,
  `asisten_operator2` double NOT NULL,
  `asisten_operator3` double NULL DEFAULT NULL,
  `instrumen` double NULL DEFAULT NULL,
  `dokter_anak` double NOT NULL,
  `perawaat_resusitas` double NOT NULL,
  `dokter_anestesi` double NOT NULL,
  `asisten_anestesi` double NOT NULL,
  `asisten_anestesi2` double NULL DEFAULT NULL,
  `bidan` double NOT NULL,
  `bidan2` double NULL DEFAULT NULL,
  `bidan3` double NULL DEFAULT NULL,
  `perawat_luar` double NOT NULL,
  `sewa_ok` double NOT NULL,
  `alat` double NOT NULL,
  `akomodasi` double NULL DEFAULT NULL,
  `bagian_rs` double NOT NULL,
  `omloop` double NOT NULL,
  `omloop2` double NULL DEFAULT NULL,
  `omloop3` double NULL DEFAULT NULL,
  `omloop4` double NULL DEFAULT NULL,
  `omloop5` double NULL DEFAULT NULL,
  `sarpras` double NULL DEFAULT NULL,
  `dokter_pjanak` double NULL DEFAULT NULL,
  `dokter_umum` double NULL DEFAULT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kelas` enum('-','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_paket`) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan` ASC) USING BTREE,
  INDEX `operator1`(`operator1` ASC) USING BTREE,
  INDEX `operator2`(`operator2` ASC) USING BTREE,
  INDEX `operator3`(`operator3` ASC) USING BTREE,
  INDEX `asisten_operator1`(`asisten_operator1` ASC) USING BTREE,
  INDEX `asisten_operator2`(`asisten_operator2` ASC) USING BTREE,
  INDEX `asisten_operator3`(`instrumen` ASC) USING BTREE,
  INDEX `dokter_anak`(`dokter_anak` ASC) USING BTREE,
  INDEX `perawat_resusitas`(`perawaat_resusitas` ASC) USING BTREE,
  INDEX `dokter_anestasi`(`dokter_anestesi` ASC) USING BTREE,
  INDEX `asisten_anastesi`(`asisten_anestesi` ASC) USING BTREE,
  INDEX `bidan`(`bidan` ASC) USING BTREE,
  INDEX `perawat_luar`(`perawat_luar` ASC) USING BTREE,
  INDEX `sewa_ok`(`sewa_ok` ASC) USING BTREE,
  INDEX `alat`(`alat` ASC) USING BTREE,
  INDEX `sewa_vk`(`akomodasi` ASC) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs` ASC) USING BTREE,
  INDEX `omloop`(`omloop` ASC) USING BTREE,
  INDEX `kd_pj`(`kd_pj` ASC) USING BTREE,
  INDEX `asisten_anestesi2`(`asisten_anestesi2` ASC) USING BTREE,
  INDEX `omloop2`(`omloop2` ASC) USING BTREE,
  INDEX `omloop3`(`omloop3` ASC) USING BTREE,
  INDEX `omloop4`(`omloop4` ASC) USING BTREE,
  INDEX `omloop5`(`omloop5` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  INDEX `kategori`(`kategori` ASC) USING BTREE,
  INDEX `bidan2`(`bidan2` ASC) USING BTREE,
  INDEX `bidan3`(`bidan3` ASC) USING BTREE,
  INDEX `asisten_operator3_2`(`asisten_operator3` ASC) USING BTREE,
  CONSTRAINT `paket_operasi_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paket_operasi
-- ----------------------------

-- ----------------------------
-- Table structure for pasien
-- ----------------------------
DROP TABLE IF EXISTS `pasien`;
CREATE TABLE `pasien`  (
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_pasien` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_ktp` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tmp_lahir` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `nm_ibu` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamat` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pekerjaan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `agama` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_daftar` date NULL DEFAULT NULL,
  `no_tlp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `umur` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pnd` enum('TS','TK','SD','SMP','SMA','SLTA/SEDERAJAT','D1','D2','D3','D4','S1','S2','S3','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluarga` enum('AYAH','IBU','ISTRI','SUAMI','SAUDARA','ANAK') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `namakeluarga` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_peserta` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_kel` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_kec` int NOT NULL,
  `kd_kab` int NOT NULL,
  `pekerjaanpj` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamatpj` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kelurahanpj` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kecamatanpj` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kabupatenpj` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perusahaan_pasien` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suku_bangsa` int NOT NULL,
  `bahasa_pasien` int NOT NULL,
  `cacat_fisik` int NOT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prop` int NOT NULL,
  `propinsipj` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_pasien` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jenis_kelamin` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cara_bayar` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `nomor_jaminan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `nik` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `telepon` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`no_rkm_medis`) USING BTREE,
  INDEX `kd_pj`(`kd_pj` ASC) USING BTREE,
  INDEX `kd_kec`(`kd_kec` ASC) USING BTREE,
  INDEX `kd_kab`(`kd_kab` ASC) USING BTREE,
  INDEX `nm_pasien`(`nm_pasien` ASC) USING BTREE,
  INDEX `alamat`(`alamat` ASC) USING BTREE,
  INDEX `kd_kel_2`(`kd_kel` ASC) USING BTREE,
  INDEX `no_ktp`(`no_ktp` ASC) USING BTREE,
  INDEX `no_peserta`(`no_peserta` ASC) USING BTREE,
  INDEX `perusahaan_pasien`(`perusahaan_pasien` ASC) USING BTREE,
  INDEX `suku_bangsa`(`suku_bangsa` ASC) USING BTREE,
  INDEX `bahasa_pasien`(`bahasa_pasien` ASC) USING BTREE,
  INDEX `cacat_fisik`(`cacat_fisik` ASC) USING BTREE,
  INDEX `kd_prop`(`kd_prop` ASC) USING BTREE,
  CONSTRAINT `pasien_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_3` FOREIGN KEY (`kd_kec`) REFERENCES `kecamatan` (`kd_kec`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_4` FOREIGN KEY (`kd_kab`) REFERENCES `kabupaten` (`kd_kab`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_5` FOREIGN KEY (`perusahaan_pasien`) REFERENCES `perusahaan_pasien` (`kode_perusahaan`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_6` FOREIGN KEY (`suku_bangsa`) REFERENCES `suku_bangsa` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_7` FOREIGN KEY (`bahasa_pasien`) REFERENCES `bahasa_pasien` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_8` FOREIGN KEY (`cacat_fisik`) REFERENCES `cacat_fisik` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_9` FOREIGN KEY (`kd_prop`) REFERENCES `propinsi` (`kd_prop`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pasien
-- ----------------------------

-- ----------------------------
-- Table structure for pegawai
-- ----------------------------
DROP TABLE IF EXISTS `pegawai`;
CREATE TABLE `pegawai`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jk` enum('Pria','Wanita') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jbtn` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jnj_jabatan` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_kelompok` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_resiko` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_emergency` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `departemen` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bidang` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_wp` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_kerja` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `npwp` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pendidikan` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gapok` double NOT NULL,
  `tmp_lahir` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kota` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mulai_kerja` date NOT NULL,
  `ms_kerja` enum('<1','PT','FT>1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `indexins` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bpd` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rekening` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_aktif` enum('AKTIF','CUTI','KELUAR','TENAGA LUAR') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `wajibmasuk` tinyint NOT NULL,
  `pengurang` double NOT NULL,
  `indek` tinyint NOT NULL,
  `mulai_kontrak` date NULL DEFAULT NULL,
  `cuti_diambil` int NOT NULL,
  `dankes` double NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_ktp` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nik_2`(`nik` ASC) USING BTREE,
  INDEX `departemen`(`departemen` ASC) USING BTREE,
  INDEX `bidang`(`bidang` ASC) USING BTREE,
  INDEX `stts_wp`(`stts_wp` ASC) USING BTREE,
  INDEX `stts_kerja`(`stts_kerja` ASC) USING BTREE,
  INDEX `pendidikan`(`pendidikan` ASC) USING BTREE,
  INDEX `indexins`(`indexins` ASC) USING BTREE,
  INDEX `jnj_jabatan`(`jnj_jabatan` ASC) USING BTREE,
  INDEX `bpd`(`bpd` ASC) USING BTREE,
  INDEX `nama`(`nama` ASC) USING BTREE,
  INDEX `jbtn`(`jbtn` ASC) USING BTREE,
  INDEX `npwp`(`npwp` ASC) USING BTREE,
  INDEX `dankes`(`dankes` ASC) USING BTREE,
  INDEX `cuti_diambil`(`cuti_diambil` ASC) USING BTREE,
  INDEX `mulai_kontrak`(`mulai_kontrak` ASC) USING BTREE,
  INDEX `stts_aktif`(`stts_aktif` ASC) USING BTREE,
  INDEX `tmp_lahir`(`tmp_lahir` ASC) USING BTREE,
  INDEX `alamat`(`alamat` ASC) USING BTREE,
  INDEX `mulai_kerja`(`mulai_kerja` ASC) USING BTREE,
  INDEX `gapok`(`gapok` ASC) USING BTREE,
  INDEX `kota`(`kota` ASC) USING BTREE,
  INDEX `pengurang`(`pengurang` ASC) USING BTREE,
  INDEX `indek`(`indek` ASC) USING BTREE,
  INDEX `jk`(`jk` ASC) USING BTREE,
  INDEX `ms_kerja`(`ms_kerja` ASC) USING BTREE,
  INDEX `tgl_lahir`(`tgl_lahir` ASC) USING BTREE,
  INDEX `rekening`(`rekening` ASC) USING BTREE,
  INDEX `wajibmasuk`(`wajibmasuk` ASC) USING BTREE,
  INDEX `kode_emergency`(`kode_emergency` ASC) USING BTREE,
  INDEX `kode_kelompok`(`kode_kelompok` ASC) USING BTREE,
  INDEX `kode_resiko`(`kode_resiko` ASC) USING BTREE,
  CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`jnj_jabatan`) REFERENCES `jnj_jabatan` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_10` FOREIGN KEY (`kode_kelompok`) REFERENCES `kelompok_jabatan` (`kode_kelompok`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_11` FOREIGN KEY (`kode_resiko`) REFERENCES `resiko_kerja` (`kode_resiko`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_2` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`dep_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_3` FOREIGN KEY (`bidang`) REFERENCES `bidang` (`nama`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_4` FOREIGN KEY (`stts_wp`) REFERENCES `stts_wp` (`stts`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_5` FOREIGN KEY (`stts_kerja`) REFERENCES `stts_kerja` (`stts`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_6` FOREIGN KEY (`pendidikan`) REFERENCES `pendidikan` (`tingkat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_7` FOREIGN KEY (`indexins`) REFERENCES `departemen` (`dep_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_8` FOREIGN KEY (`bpd`) REFERENCES `bank` (`namabank`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_9` FOREIGN KEY (`kode_emergency`) REFERENCES `emergency_index` (`kode_emergency`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pegawai
-- ----------------------------
INSERT INTO `pegawai` VALUES (1, 'DR001', 'dr. Ataaka Muhammad', 'Pria', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', 0, 'Barabai', '2016-06-10', '-', 'Barabai', '2019-09-18', '<1', '-', '-', '-', 'AKTIF', 0, 0, 0, '2019-09-18', 1, 0, '-', '0');

-- ----------------------------
-- Table structure for pemberian_layanan
-- ----------------------------
DROP TABLE IF EXISTS `pemberian_layanan`;
CREATE TABLE `pemberian_layanan`  (
  `id` int NULL DEFAULT NULL,
  `id_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_layanan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_layanan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `jumlah` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pemberian_layanan
-- ----------------------------
INSERT INTO `pemberian_layanan` VALUES (1, '202502021001', '1', 'Tensi', '1', '', '1', '2025-02-02');
INSERT INTO `pemberian_layanan` VALUES (2, '202502021001', '2', 'Rawat Luka', '1', '', '1', '2025-02-02');
INSERT INTO `pemberian_layanan` VALUES (3, '202502021001', '2', 'Rawat Luka', '1', '', '1', '2025-02-02');
INSERT INTO `pemberian_layanan` VALUES (4, '202502021001', '3', 'Injeksi R', '1', '', '1', '2025-02-02');
INSERT INTO `pemberian_layanan` VALUES (5, '202502021002', '4', 'INJ DC', '1', '', '2', '2025-02-02');
INSERT INTO `pemberian_layanan` VALUES (6, '202502021003', '2', 'Rawat Luka', '1', '', '2', '2025-02-02');

-- ----------------------------
-- Table structure for pemberian_obat
-- ----------------------------
DROP TABLE IF EXISTS `pemberian_obat`;
CREATE TABLE `pemberian_obat`  (
  `id` int NULL DEFAULT NULL,
  `id_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nama_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `jumlah` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pemberian_obat
-- ----------------------------
INSERT INTO `pemberian_obat` VALUES (1, '202502021001', '3', 'paracetamol', '1', '3x1', '1', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (2, '202502021001', '3', 'paracetamol', '10', '', '1', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (3, '202502021001', '3', 'paracetamol', '7', '', '1', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (4, '202502021001', '5', 'LP', '5', '', '1', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (5, '202502021001', '4', 'LC', '7', '', '1', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (6, '202502021001', '6', 'R22', '7', '', '1', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (7, '202502021002', '7', 'HISTIGO', '1', '', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (8, '202502021002', '7', 'HISTIGO', '7', '', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (9, '202502021002', '7', 'HISTIGO', '7', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (10, '202502021002', '7', '', '7', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (11, '202502021002', '9', 'RANITIDIN ', '7', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (12, '202502021002', '9', '', '7', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (13, '202502021002', '10', 'MN', '1', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (14, '202502021002', '10', 'MN', '7', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (15, '202502021002', '8', 'M2', '7', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (16, '202502021003', '5', 'LP', '5', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (17, '202502021003', '6', 'R22', '7', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (18, '202502021003', '4', 'LC', '7', '3X1', '2', '2025-02-02');
INSERT INTO `pemberian_obat` VALUES (19, '202502021003', '11', 'Novaxifen ', '7', '3X1', '2', '2025-02-02');

-- ----------------------------
-- Table structure for pemeliharaan_inventaris
-- ----------------------------
DROP TABLE IF EXISTS `pemeliharaan_inventaris`;
CREATE TABLE `pemeliharaan_inventaris`  (
  `no_inventaris` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `uraian_kegiatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pelaksana` enum('Teknisi Rumah Sakit','Teknisi Rujukan','Pihak ke III') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biaya` double NOT NULL,
  `jenis_pemeliharaan` enum('Running Maintenance','Shut Down Maintenance','Emergency Maintenance') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_inventaris`, `tanggal`) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  CONSTRAINT `pemeliharaan_inventaris_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemeliharaan_inventaris_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pemeliharaan_inventaris
-- ----------------------------

-- ----------------------------
-- Table structure for pemeriksaan
-- ----------------------------
DROP TABLE IF EXISTS `pemeriksaan`;
CREATE TABLE `pemeriksaan`  (
  `id` int NULL DEFAULT NULL,
  `id_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `suhu_tubuh` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tensi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nadi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `respirasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `tinggi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `berat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `lingkarperut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `gcs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `kesadaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `alergi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `penilaian` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `subyektif` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `obyektif` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `assesment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `plan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `jenis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pemeriksaan
-- ----------------------------
INSERT INTO `pemeriksaan` VALUES (1, '202412281001', '45', '120', '88', '23', '160', '50', '60', '', 'Compos Mentis', 'Tidak ada', NULL, 'A', 'A', '', 'Kontrol ke 1', '1', '2024-12-28 06:53', 'ralan');
INSERT INTO `pemeriksaan` VALUES (2, '202502021001', '37', '110', '88', '20', '110', '28', '40', '456', 'Compos Mentis', 'disangkal', NULL, 'demam, batuk, pusing', 'kontrol pertamam', 'terapi', '3 hari kontrol', '1', '2025-02-02 10:08', 'ralan');
INSERT INTO `pemeriksaan` VALUES (5, '202502021002', '36', '150', '80', '22', '160', '60', '70', '456', 'Compos Mentis', 'Disangkal', NULL, 'Pusing berputar, mual, muntah', '-', '-', '-', '2', '2025-02-02 11:23', 'ralan');
INSERT INTO `pemeriksaan` VALUES (7, '202502021003', '36', '120', '88', '20', '150', '79', '78', '456', 'Compos Mentis', '-', NULL, 'LUKA POST KLL DI JARI KAKI KANAN', '-', '-', '-', '2', '2025-02-02 11:44', 'ralan');
INSERT INTO `pemeriksaan` VALUES (8, '202502031001', '37', '120', '88', '22', '160', '67', '67', '456', 'Compos Mentis', 'Disangkal', NULL, 'Nyeri ulu hati tembus belakang, muntah tiap makan, nyeri perut bagian bawah', '-', '-', '-', '2', '2025-02-03 17:07', 'ralan');
INSERT INTO `pemeriksaan` VALUES (9, '202502061001', '36', '', '98', '20', '100', '8.5', '', '', '', '', NULL, '', '', 'DEMAM \nBATUK BERDAHAK \nPILEK BUNTU \nMUAL ', '', '2', '2025-02-06 09:11', 'ralan');
INSERT INTO `pemeriksaan` VALUES (10, '202502061002', '37', '120/80', '98', '89', '160', '60', '66', '', '', '', NULL, '', '', 'DEMAM\nBATUK KERING \nBADAN NYERI', '', '2', '2025-02-06 09:23', 'ralan');
INSERT INTO `pemeriksaan` VALUES (11, '202502061003', '36', '160/90', '98', '89', '160', '55', '66', '', '', '', NULL, '', '', 'BADAN KEMENG \nLEHER KAKU\nPUSING CEKOT', '', '2', '2025-02-06 09:26', 'ralan');
INSERT INTO `pemeriksaan` VALUES (12, '202502061004', '36', '130/90', '88', '20', '160', '50', '55', '', '', '', NULL, '', '', 'KAKI KESEMUTAN + KEMENG ', '', '2', '2025-02-06 09:28', 'ralan');
INSERT INTO `pemeriksaan` VALUES (13, '202502061005', '36.6', '', '', '', '100', '18', '', '', '', '', NULL, '', '', 'GONDONGAN ', '', '2', '2025-02-06 09:32', 'ralan');
INSERT INTO `pemeriksaan` VALUES (14, '202502061006', '36.7', '130/80', '98', '20', '', '', '', '', '', '', NULL, '', '', 'DIARE 4X CAIR \nPERUT MULES ', '', '2', '2025-02-06 09:34', 'ralan');
INSERT INTO `pemeriksaan` VALUES (15, '202502061007', '36', '140/90', '89', '20', '', '', '', '', '', '', NULL, '', '', 'PUSING BLIYUR \nMUAL \nBADAN DREDEK ', '', '2', '2025-02-06 09:36', 'ralan');
INSERT INTO `pemeriksaan` VALUES (16, '202502061008', '36', '140/80', '90', '20', '', '', '', '', '', '', NULL, '', '', 'PUSING BLIYUR \nMUAL \nKAKI KEMENG ', '', '2', '2025-02-06 09:37', 'ralan');

-- ----------------------------
-- Table structure for pemeriksaan_ralan
-- ----------------------------
DROP TABLE IF EXISTS `pemeriksaan_ralan`;
CREATE TABLE `pemeriksaan_ralan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `suhu_tubuh` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tensi` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nadi` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `respirasi` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tinggi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `berat` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spo2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kesadaran` enum('Compos Mentis','Somnolence','Sopor','Coma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lingkar_perut` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rtl` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `instruksi` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `evaluasi` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  CONSTRAINT `pemeriksaan_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemeriksaan_ralan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pemeriksaan_ralan
-- ----------------------------

-- ----------------------------
-- Table structure for pemeriksaan_ranap
-- ----------------------------
DROP TABLE IF EXISTS `pemeriksaan_ranap`;
CREATE TABLE `pemeriksaan_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `suhu_tubuh` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tensi` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nadi` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `respirasi` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tinggi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `berat` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spo2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kesadaran` enum('Compos Mentis','Somnolence','Sopor','Coma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rtl` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `instruksi` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `evaluasi` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  CONSTRAINT `pemeriksaan_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemeriksaan_ranap_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pemeriksaan_ranap
-- ----------------------------

-- ----------------------------
-- Table structure for pendaftaran
-- ----------------------------
DROP TABLE IF EXISTS `pendaftaran`;
CREATE TABLE `pendaftaran`  (
  `id` int NULL DEFAULT NULL,
  `tgl_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_pasien` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status_periksa` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cara_bayar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_antrian` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status_bayar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pendaftaran
-- ----------------------------

-- ----------------------------
-- Table structure for pendidikan
-- ----------------------------
DROP TABLE IF EXISTS `pendidikan`;
CREATE TABLE `pendidikan`  (
  `tingkat` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `indek` tinyint NOT NULL,
  `gapok1` double NOT NULL,
  `kenaikan` double NOT NULL,
  `maksimal` int NOT NULL,
  PRIMARY KEY (`tingkat`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pendidikan
-- ----------------------------
INSERT INTO `pendidikan` VALUES ('-', 1, 0, 0, 1);

-- ----------------------------
-- Table structure for penilaian_awal_keperawatan_igd
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_awal_keperawatan_igd`;
CREATE TABLE `penilaian_awal_keperawatan_igd`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_kehamilan` enum('Tidak Hamil','Hamil') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gravida` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `para` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `abortus` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hpht` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tekanan` enum('TAK','Sakit Kepala','Muntah','Pusing','Bingung') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pupil` enum('Normal','Miosis','Isokor','Anisokor') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `neurosensorik` enum('TAK','Spasme Otot','Perubahan Sensorik','Perubahan Motorik','Perubahan Bentuk Ekstremitas','Penurunan Tingkat Kesadaran','Fraktur/Dislokasi','Luksasio','Kerusakan Jaringan/Luka') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `integumen` enum('TAK','Luka Bakar','Luka Robek','Lecet','Luka Decubitus','Luka Gangren') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `turgor` enum('Baik','Menurun') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `edema` enum('Tidak Ada','Ekstremitas','Seluruh Tubuh','Asites','Palpebrae') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mukosa` enum('Lembab','Kering') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perdarahan` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah_perdarahan` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `warna_perdarahan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `intoksikasi` enum('Tidak Ada','Ada','Gigitan Binatang','Zat Kimia','Gas','Obat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bab` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `xbab` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kbab` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wbab` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bak` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `xbak` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wbak` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `lbak` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `psikologis` enum('Tidak Ada Masalah','Marah','Takut','Depresi','Cepat Lelah','Cemas','Gelisah','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jiwa` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perilaku` enum('Perilaku Kekerasan','Gangguan Efek','Gangguan Memori','Halusinasi','Kecenderungan Percobaan Bunuh Diri','Lainnya','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dilaporkan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sebutkan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hubungan` enum('Harmonis','Kurang Harmonis','Tidak Harmonis','Konflik Besar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tinggal_dengan` enum('Sendiri','Orang Tua','Suami / Istri','Lainnya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_tinggal` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `budaya` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_budaya` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pendidikan_pj` enum('-','TS','TK','SD','SMP','SMA','SLTA/SEDERAJAT','D1','D2','D3','D4','S1','S2','S3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_pendidikan_pj` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `edukasi` enum('Pasien','Keluarga') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_edukasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kemampuan` enum('Mandiri','Bantuan Minimal','Bantuan Sebagian','Ketergantungan Total') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `aktifitas` enum('Tirah Baring','Duduk','Berjalan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alat_bantu` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_bantu` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `provokes` enum('Proses Penyakit','Benturan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_provokes` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `quality` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_quality` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `menyebar` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_nyeri` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pada_dokter` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_dokter` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `berjalan_a` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_b` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_c` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hasil` enum('Tidak beresiko (tidak ditemukan a dan b)','Resiko rendah (ditemukan a/b)','Resiko tinggi (ditemukan a dan b)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lapor` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lapor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rencana` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  CONSTRAINT `penilaian_awal_keperawatan_igd_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_igd_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penilaian_awal_keperawatan_igd
-- ----------------------------

-- ----------------------------
-- Table structure for penilaian_awal_keperawatan_ralan
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_awal_keperawatan_ralan`;
CREATE TABLE `penilaian_awal_keperawatan_ralan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `gcs` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `bmi` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpd` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `alat_bantu` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_bantu` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `prothesa` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_pro` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `adl` enum('Mandiri','Dibantu') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_psiko` enum('Tenang','Takut','Cemas','Depresi','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_psiko` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hub_keluarga` enum('Baik','Tidak Baik') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tinggal_dengan` enum('Sendiri','Orang Tua','Suami / Istri','Lainnya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_tinggal` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekonomi` enum('Baik','Cukup','Kurang') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `budaya` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_budaya` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `edukasi` enum('Pasien','Keluarga') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_edukasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_a` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_b` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_c` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hasil` enum('Tidak beresiko (tidak ditemukan a dan b)','Resiko rendah (ditemukan a/b)','Resiko tinggi (ditemukan a dan b)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lapor` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lapor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sg1` enum('Tidak','Tidak Yakin','Ya, 1-5 Kg','Ya, 6-10 Kg','Ya, 11-15 Kg','Ya, >15 Kg') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai1` enum('0','1','2','3','4') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sg2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai2` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `total_hasil` tinyint NOT NULL,
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `provokes` enum('Proses Penyakit','Benturan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_provokes` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `quality` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_quality` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `menyebar` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_nyeri` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pada_dokter` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_dokter` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rencana` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  CONSTRAINT `penilaian_awal_keperawatan_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ralan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penilaian_awal_keperawatan_ralan
-- ----------------------------

-- ----------------------------
-- Table structure for penilaian_awal_keperawatan_ranap
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_awal_keperawatan_ranap`;
CREATE TABLE `penilaian_awal_keperawatan_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_informasi` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tiba_diruang_rawat` enum('Jalan Tanpa Bantuan','Kursi Roda','Brankar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kasus_trauma` enum('Trauma','Non Trauma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cara_masuk` enum('Poli','IGD','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rps` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_pembedahan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_dirawat_dirs` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alat_bantu_dipakai` enum('Kacamata','Prothesa','Alat Bantu Dengar','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_kehamilan` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_kehamilan_perkiraan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_tranfusi` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_alergi` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_merokok` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_merokok_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_alkohol` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_alkohol_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_narkoba` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_olahraga` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_mental` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_keadaan_umum` enum('Baik','Sedang','Buruk') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_spo2` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_kepala` enum('TAK','Hydrocephalus','Hematoma','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_kepala_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_wajah` enum('TAK','Asimetris','Kelainan Kongenital') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_wajah_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_leher` enum('TAK','Kaku Kuduk','Pembesaran Thyroid','Pembesaran KGB') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_kejang` enum('TAK','Kuat','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_kejang_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_sensorik` enum('TAK','Sakit Nyeri','Rasa kebas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_kardiovaskuler_denyut_nadi` enum('Teratur','Tidak Teratur') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_kardiovaskuler_sirkulasi` enum('Akral Hangat','Akral Dingin','Edema') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_kardiovaskuler_sirkulasi_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_kardiovaskuler_pulsasi` enum('Kuat','Lemah','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_pola_nafas` enum('Normal','Bradipnea','Tachipnea') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_retraksi` enum('Tidak Ada','Ringan','Berat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_suara_nafas` enum('Vesikuler','Wheezing','Rhonki') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_volume_pernafasan` enum('Normal','Hiperventilasi','Hipoventilasi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_jenis_pernafasan` enum('Pernafasan Dada','Alat Bantu Pernafasaan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_jenis_pernafasan_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_irama_nafas` enum('Teratur','Tidak Teratur') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_batuk` enum('Tidak','Ya : Produktif','Ya : Non Produktif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_mulut` enum('TAK','Stomatitis','Mukosa Kering','Bibir Pucat','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_mulut_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_gigi` enum('TAK','Karies','Goyang','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_gigi_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_lidah` enum('TAK','Kotor','Gerak Asimetris','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_lidah_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_tenggorokan` enum('TAK','Gangguan Menelan','Sakit Menelan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_tenggorokan_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_abdomen` enum('Supel','Asictes',' Tegang','Nyeri Tekan/Lepas','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_abdomen_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_peistatik_usus` enum('TAK','Tidak Ada Bising Usus','Hiperistaltik') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_anus` enum('TAK','Atresia Ani') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_pengelihatan` enum('TAK','Ada Kelainan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_pengelihatan_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_alat_bantu_penglihatan` enum('Tidak','Kacamata','Lensa Kontak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_pendengaran` enum('TAK','Berdengung','Nyeri','Tuli','Keluar Cairan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_bicara` enum('Jelas','Tidak Jelas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_bicara_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_sensorik` enum('TAK','Sakit Nyeri','Rasa Kebas','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_motorik` enum('TAK','Hemiparese','Tetraparese','Tremor','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_kekuatan_otot` enum('Kuat','Lemah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_integument_warnakulit` enum('Pucat','Sianosis','Normal','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_integument_turgor` enum('Baik','Sedang','Buruk') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_integument_kulit` enum('Normal','Rash/Kemerahan','Luka','Memar','Ptekie','Bula') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_integument_dekubitas` enum('Tidak Ada','Usia > 65 tahun','Obesitas','Imobilisasi','Paraplegi/Vegetative State','Dirawat Di HCU','Penyakit Kronis (DM, CHF, CKD)','Inkontinentia Uri/Alvi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_pergerakan_sendi` enum('Bebas','Terbatas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_kekauatan_otot` enum('Baik','Lemah','Tremor') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_nyeri_sendi` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_nyeri_sendi_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_oedema` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_oedema_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_fraktur` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_fraktur_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bab_frekuensi_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bab_frekuensi_durasi` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bab_konsistensi` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bab_warna` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bak_frekuensi_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bak_frekuensi_durasi` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bak_warna` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bak_lainlain` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_makanminum` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_mandi` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_eliminasi` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_berpakaian` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_berpindah` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_nutrisi_frekuesi_makan` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_nutrisi_jenis_makanan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_nutrisi_porsi_makan` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_tidur_lama_tidur` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_tidur_gangguan` enum('Tidak Ada Gangguan','Insomnia') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_kemampuan_sehari` enum('Mandiri','Bantuan Minimal','Bantuan Sebagian','Ketergantungan Total') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_aktifitas` enum('Tirah Baring','Duduk','Berjalan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_berjalan` enum('TAK','Penurunan Kekuatan/ROM','Paralisis','Sering Jatuh','Deformitas','Hilang Keseimbangan','Riwayat Patah Tulang','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_berjalan_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ambulasi` enum('Walker','Tongkat','Kursi Roda','Tidak Menggunakan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ekstrimitas_atas` enum('TAK','Lemah','Oedema','Tidak Simetris','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ekstrimitas_atas_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ekstrimitas_bawah` enum('TAK','Varises','Oedema','Tidak Simetris','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ekstrimitas_bawah_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_menggenggam` enum('Tidak Ada Kesulitan','Terakhir','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_menggenggam_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_koordinasi` enum('Tidak Ada Kesulitan','Ada Masalah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_koordinasi_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_kesimpulan` enum('Ya (Co DPJP)','Tidak (Tidak Perlu Co DPJP)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_kondisi_psiko` enum('Tidak Ada Masalah','Marah','Takut','Depresi','Cepat Lelah','Cemas','Gelisah','Sulit Tidur','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_gangguan_jiwa` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_perilaku` enum('Tidak Ada Masalah','Perilaku Kekerasan','Gangguan Efek','Gangguan Memori','Halusinasi','Kecenderungan Percobaan Bunuh Diri','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_perilaku_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_hubungan_keluarga` enum('Harmonis','Kurang Harmonis','Tidak Harmonis','Konflik Besar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_tinggal` enum('Sendiri','Orang Tua','Suami/Istri','Keluarga','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_tinggal_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_nilai_kepercayaan` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_nilai_kepercayaan_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_pendidikan_pj` enum('-','TS','TK','SD','SMP','SMA','SLTA/SEDERAJAT','D1','D2','D3','D4','S1','S2','S3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_edukasi_diberikan` enum('Pasien','Keluarga') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_edukasi_diberikan_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_penyebab` enum('Proses Penyakit','Benturan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_ket_penyebab` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_kualitas` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_ket_kualitas` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_lokasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_menyebar` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_skala` enum('0','1','2','3','4','5','6','7','8','9','10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_waktu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_ket_hilang` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_diberitahukan_dokter` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_jam_diberitahukan_dokter` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_jatuhmorse_skala1` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai1` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala2` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai2` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala3` enum('Tidak Ada/Kursi Roda/Perawat/Tirah Baring','Tongkat/Alat Penopang','Berpegangan Pada Perabot') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai3` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala4` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai4` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala5` enum('Normal/Tirah Baring/Imobilisasi','Lemah','Terganggu') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai5` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala6` enum('Sadar Akan Kemampuan Diri Sendiri','Sering Lupa Akan Keterbatasan Yang Dimiliki') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai6` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhmorse_totalnilai` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala1` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai1` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala2` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai2` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala3` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai3` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala4` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai4` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala5` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai5` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala6` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai6` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala7` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai7` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala8` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai8` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala9` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai9` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala10` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai10` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala11` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai11` tinyint NULL DEFAULT NULL,
  `penilaian_jatuhsydney_totalnilai` tinyint NULL DEFAULT NULL,
  `skrining_gizi1` enum('Tidak ada penurunan berat badan','Tidak yakin/ tidak tahu/ terasa baju lebih longgar','Ya 1-5 kg','Ya 6-10 kg','Ya 11-15 kg','Ya > 15 kg') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nilai_gizi1` int NULL DEFAULT NULL,
  `skrining_gizi2` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nilai_gizi2` int NULL DEFAULT NULL,
  `nilai_total_gizi` double NULL DEFAULT NULL,
  `skrining_gizi_diagnosa_khusus` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `skrining_gizi_ket_diagnosa_khusus` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `skrining_gizi_diketahui_dietisen` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `skrining_gizi_jam_diketahui_dietisen` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rencana` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip1` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `nip1`(`nip1` ASC) USING BTREE,
  INDEX `nip2`(`nip2` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `penilaian_awal_keperawatan_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ranap_ibfk_2` FOREIGN KEY (`nip1`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ranap_ibfk_3` FOREIGN KEY (`nip2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ranap_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penilaian_awal_keperawatan_ranap
-- ----------------------------

-- ----------------------------
-- Table structure for penilaian_medis_igd
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_medis_igd`;
CREATE TABLE `penilaian_medis_igd`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `anamnesis` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hubungan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rps` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpk` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `keadaan` enum('Sehat','Sakit Ringan','Sakit Sedang','Sakit Berat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kesadaran` enum('Compos Mentis','Apatis','Somnolen','Sopor','Koma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `spo` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kepala` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mata` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gigi` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `leher` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `thoraks` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `abdomen` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `genital` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekstremitas` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_fisik` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lokalis` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekg` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rad` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lab` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosis` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tata` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `penilaian_medis_igd_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_medis_igd_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penilaian_medis_igd
-- ----------------------------

-- ----------------------------
-- Table structure for penilaian_medis_ralan
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_medis_ralan`;
CREATE TABLE `penilaian_medis_ralan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `anamnesis` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hubungan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rps` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpk` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `keadaan` enum('Sehat','Sakit Ringan','Sakit Sedang','Sakit Berat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kesadaran` enum('Compos Mentis','Apatis','Somnolen','Sopor','Koma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `spo` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kepala` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gigi` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tht` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `thoraks` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `abdomen` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `genital` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekstremitas` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kulit` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_fisik` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lokalis` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penunjang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosis` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tata` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `konsulrujuk` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `penilaian_medis_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_medis_ralan_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penilaian_medis_ralan
-- ----------------------------

-- ----------------------------
-- Table structure for penilaian_medis_ranap
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_medis_ranap`;
CREATE TABLE `penilaian_medis_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `anamnesis` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hubungan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rps` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpk` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `keadaan` enum('Sehat','Sakit Ringan','Sakit Sedang','Sakit Berat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kesadaran` enum('Compos Mentis','Apatis','Somnolen','Sopor','Koma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `spo` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kepala` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mata` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gigi` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tht` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `thoraks` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jantung` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `paru` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `abdomen` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `genital` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekstremitas` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kulit` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_fisik` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lokalis` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lab` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rad` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penunjang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosis` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tata` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `edukasi` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `penilaian_medis_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_medis_ranap_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penilaian_medis_ranap
-- ----------------------------

-- ----------------------------
-- Table structure for penilaian_ulang_nyeri
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_ulang_nyeri`;
CREATE TABLE `penilaian_ulang_nyeri`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `provokes` enum('Proses Penyakit','Benturan','Lain-lain','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_provokes` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `quality` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-lain','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_quality` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `menyebar` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_nyeri` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  CONSTRAINT `penilaian_ulang_nyeri_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_ulang_nyeri_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penilaian_ulang_nyeri
-- ----------------------------

-- ----------------------------
-- Table structure for penjab
-- ----------------------------
DROP TABLE IF EXISTS `penjab`;
CREATE TABLE `penjab`  (
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `png_jawab` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_perusahaan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamat_asuransi` varchar(130) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_telp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `attn` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_pj`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penjab
-- ----------------------------
INSERT INTO `penjab` VALUES ('-', '-', '-', '-', '0', '0', '1');
INSERT INTO `penjab` VALUES ('BPJ', 'BPJS Kesehatan', '-', '-', '0', '0', '1');
INSERT INTO `penjab` VALUES ('UMU', 'Umum', '-', '-', '0', '0', '1');

-- ----------------------------
-- Table structure for penjamin
-- ----------------------------
DROP TABLE IF EXISTS `penjamin`;
CREATE TABLE `penjamin`  (
  `id` int NOT NULL,
  `nama_penjamin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penjamin
-- ----------------------------
INSERT INTO `penjamin` VALUES (1, 'Umum');
INSERT INTO `penjamin` VALUES (2, 'BPJS Kesehatan');

-- ----------------------------
-- Table structure for penyakit
-- ----------------------------
DROP TABLE IF EXISTS `penyakit`;
CREATE TABLE `penyakit`  (
  `kd_penyakit` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_penyakit` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ciri_ciri` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `keterangan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_ktg` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Menular','Tidak Menular') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_penyakit`) USING BTREE,
  INDEX `kd_ktg`(`kd_ktg` ASC) USING BTREE,
  INDEX `nm_penyakit`(`nm_penyakit` ASC) USING BTREE,
  INDEX `status`(`status` ASC) USING BTREE,
  CONSTRAINT `penyakit_ibfk_1` FOREIGN KEY (`kd_ktg`) REFERENCES `kategori_penyakit` (`kd_ktg`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penyakit
-- ----------------------------

-- ----------------------------
-- Table structure for perbaikan_inventaris
-- ----------------------------
DROP TABLE IF EXISTS `perbaikan_inventaris`;
CREATE TABLE `perbaikan_inventaris`  (
  `no_permintaan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `uraian_kegiatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pelaksana` enum('Teknisi Rumah Sakit','Teknisi Rujukan','Pihak ke III') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biaya` double NOT NULL,
  `keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Bisa Diperbaiki','Tidak Bisa Diperbaiki') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_permintaan`) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  CONSTRAINT `perbaikan_inventaris_ibfk_1` FOREIGN KEY (`no_permintaan`) REFERENCES `permintaan_perbaikan_inventaris` (`no_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `perbaikan_inventaris_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of perbaikan_inventaris
-- ----------------------------

-- ----------------------------
-- Table structure for periksa_lab
-- ----------------------------
DROP TABLE IF EXISTS `periksa_lab`;
CREATE TABLE `periksa_lab`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `dokter_perujuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya` double NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Ralan','Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kategori` enum('PA','PK','MB') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `dokter_perujuk`(`dokter_perujuk` ASC) USING BTREE,
  CONSTRAINT `periksa_lab_ibfk_10` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_11` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_12` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_13` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_9` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of periksa_lab
-- ----------------------------

-- ----------------------------
-- Table structure for periksa_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `periksa_radiologi`;
CREATE TABLE `periksa_radiologi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `dokter_perujuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya` double NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Ranap','Ralan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `proyeksi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kV` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mAS` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `FFD` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `BSF` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `inak` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml_penyinaran` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dosis` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `dokter_perujuk`(`dokter_perujuk` ASC) USING BTREE,
  CONSTRAINT `periksa_radiologi_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_5` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_7` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_8` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of periksa_radiologi
-- ----------------------------

-- ----------------------------
-- Table structure for permintaan_detail_permintaan_lab
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_detail_permintaan_lab`;
CREATE TABLE `permintaan_detail_permintaan_lab`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_template` int NOT NULL,
  `stts_bayar` enum('Sudah','Belum') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`noorder`, `kd_jenis_prw`, `id_template`) USING BTREE,
  INDEX `id_template`(`id_template` ASC) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  CONSTRAINT `permintaan_detail_permintaan_lab_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_detail_permintaan_lab_ibfk_3` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_detail_permintaan_lab_ibfk_4` FOREIGN KEY (`noorder`) REFERENCES `permintaan_lab` (`noorder`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permintaan_detail_permintaan_lab
-- ----------------------------

-- ----------------------------
-- Table structure for permintaan_lab
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_lab`;
CREATE TABLE `permintaan_lab`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_permintaan` date NOT NULL,
  `jam_permintaan` time NOT NULL,
  `tgl_sampel` date NOT NULL,
  `jam_sampel` time NOT NULL,
  `tgl_hasil` date NOT NULL,
  `jam_hasil` time NOT NULL,
  `dokter_perujuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('ralan','ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `informasi_tambahan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_klinis` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`noorder`) USING BTREE,
  INDEX `dokter_perujuk`(`dokter_perujuk` ASC) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  CONSTRAINT `permintaan_lab_ibfk_2` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_lab_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permintaan_lab
-- ----------------------------

-- ----------------------------
-- Table structure for permintaan_pemeriksaan_lab
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_pemeriksaan_lab`;
CREATE TABLE `permintaan_pemeriksaan_lab`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_bayar` enum('Sudah','Belum') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`noorder`, `kd_jenis_prw`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  CONSTRAINT `permintaan_pemeriksaan_lab_ibfk_1` FOREIGN KEY (`noorder`) REFERENCES `permintaan_lab` (`noorder`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_pemeriksaan_lab_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permintaan_pemeriksaan_lab
-- ----------------------------

-- ----------------------------
-- Table structure for permintaan_pemeriksaan_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_pemeriksaan_radiologi`;
CREATE TABLE `permintaan_pemeriksaan_radiologi`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_bayar` enum('Sudah','Belum') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`noorder`, `kd_jenis_prw`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  CONSTRAINT `permintaan_pemeriksaan_radiologi_ibfk_1` FOREIGN KEY (`noorder`) REFERENCES `permintaan_radiologi` (`noorder`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_pemeriksaan_radiologi_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permintaan_pemeriksaan_radiologi
-- ----------------------------

-- ----------------------------
-- Table structure for permintaan_perbaikan_inventaris
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_perbaikan_inventaris`;
CREATE TABLE `permintaan_perbaikan_inventaris`  (
  `no_permintaan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_inventaris` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` datetime NULL DEFAULT NULL,
  `deskripsi_kerusakan` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_permintaan`) USING BTREE,
  INDEX `no_inventaris`(`no_inventaris` ASC) USING BTREE,
  INDEX `nik`(`nik` ASC) USING BTREE,
  CONSTRAINT `permintaan_perbaikan_inventaris_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_perbaikan_inventaris_ibfk_2` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permintaan_perbaikan_inventaris
-- ----------------------------

-- ----------------------------
-- Table structure for permintaan_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_radiologi`;
CREATE TABLE `permintaan_radiologi`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_permintaan` date NOT NULL,
  `jam_permintaan` time NOT NULL,
  `tgl_sampel` date NOT NULL,
  `jam_sampel` time NOT NULL,
  `tgl_hasil` date NOT NULL,
  `jam_hasil` time NOT NULL,
  `dokter_perujuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('ralan','ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `informasi_tambahan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_klinis` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`noorder`) USING BTREE,
  INDEX `dokter_perujuk`(`dokter_perujuk` ASC) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  CONSTRAINT `permintaan_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_radiologi_ibfk_3` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permintaan_radiologi
-- ----------------------------

-- ----------------------------
-- Table structure for personal_pasien
-- ----------------------------
DROP TABLE IF EXISTS `personal_pasien`;
CREATE TABLE `personal_pasien`  (
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gambar` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`) USING BTREE,
  CONSTRAINT `personal_pasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_pasien
-- ----------------------------

-- ----------------------------
-- Table structure for perusahaan_pasien
-- ----------------------------
DROP TABLE IF EXISTS `perusahaan_pasien`;
CREATE TABLE `perusahaan_pasien`  (
  `kode_perusahaan` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_perusahaan` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kota` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(27) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_perusahaan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of perusahaan_pasien
-- ----------------------------
INSERT INTO `perusahaan_pasien` VALUES ('-', '-', '-', '-', '0');

-- ----------------------------
-- Table structure for petugas
-- ----------------------------
DROP TABLE IF EXISTS `petugas`;
CREATE TABLE `petugas`  (
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tmp_lahir` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `agama` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_jbtn` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`nip`) USING BTREE,
  INDEX `kd_jbtn`(`kd_jbtn` ASC) USING BTREE,
  INDEX `nama`(`nama` ASC) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  INDEX `tmp_lahir`(`tmp_lahir` ASC) USING BTREE,
  INDEX `tgl_lahir`(`tgl_lahir` ASC) USING BTREE,
  INDEX `agama`(`agama` ASC) USING BTREE,
  INDEX `stts_nikah`(`stts_nikah` ASC) USING BTREE,
  INDEX `alamat`(`alamat` ASC) USING BTREE,
  CONSTRAINT `petugas_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `petugas_ibfk_5` FOREIGN KEY (`kd_jbtn`) REFERENCES `jabatan` (`kd_jbtn`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of petugas
-- ----------------------------
INSERT INTO `petugas` VALUES ('DR001', 'dr. Ataaka Muhammad', 'L', 'Barabai', '2020-12-01', 'A', 'Islam', 'MENIKAH', '-', '-', '0', '1');

-- ----------------------------
-- Table structure for poliklinik
-- ----------------------------
DROP TABLE IF EXISTS `poliklinik`;
CREATE TABLE `poliklinik`  (
  `kd_poli` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nm_poli` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `registrasi` double NOT NULL,
  `registrasilama` double NOT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_poli`) USING BTREE,
  INDEX `nm_poli`(`nm_poli` ASC) USING BTREE,
  INDEX `registrasi`(`registrasi` ASC) USING BTREE,
  INDEX `registrasilama`(`registrasilama` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of poliklinik
-- ----------------------------
INSERT INTO `poliklinik` VALUES ('-', '-', 0, 0, '1');
INSERT INTO `poliklinik` VALUES ('IGDK', 'IGD', 0, 0, '1');
INSERT INTO `poliklinik` VALUES ('UMU', 'Umum', 0, 0, '1');

-- ----------------------------
-- Table structure for propinsi
-- ----------------------------
DROP TABLE IF EXISTS `propinsi`;
CREATE TABLE `propinsi`  (
  `kd_prop` int NOT NULL,
  `nm_prop` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_prop`) USING BTREE,
  UNIQUE INDEX `nm_prop`(`nm_prop` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of propinsi
-- ----------------------------
INSERT INTO `propinsi` VALUES (1, '-');

-- ----------------------------
-- Table structure for prosedur_pasien
-- ----------------------------
DROP TABLE IF EXISTS `prosedur_pasien`;
CREATE TABLE `prosedur_pasien`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Ralan','Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas` tinyint NOT NULL,
  `id` int NULL DEFAULT NULL,
  `id_pendaftaran` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_prosedur` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_prosedur` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_user` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_input` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode`, `status`) USING BTREE,
  INDEX `kode`(`kode` ASC) USING BTREE,
  CONSTRAINT `prosedur_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prosedur_pasien_ibfk_2` FOREIGN KEY (`kode`) REFERENCES `icd9` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prosedur_pasien
-- ----------------------------

-- ----------------------------
-- Table structure for rawat_inap_dr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_inap_dr`;
CREATE TABLE `rawat_inap_dr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `kd_dokter`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `tgl_perawatan`(`tgl_perawatan` ASC) USING BTREE,
  INDEX `biaya_rawat`(`biaya_rawat` ASC) USING BTREE,
  INDEX `jam_rawat`(`jam_rawat` ASC) USING BTREE,
  CONSTRAINT `rawat_inap_dr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_dr_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_dr_ibfk_7` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rawat_inap_dr
-- ----------------------------

-- ----------------------------
-- Table structure for rawat_inap_drpr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_inap_drpr`;
CREATE TABLE `rawat_inap_drpr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NULL DEFAULT NULL,
  `tarif_tindakanpr` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `kd_dokter`, `nip`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `rawat_inap_drpr_ibfk_2`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `rawat_inap_drpr_ibfk_3`(`kd_dokter` ASC) USING BTREE,
  INDEX `rawat_inap_drpr_ibfk_4`(`nip` ASC) USING BTREE,
  CONSTRAINT `rawat_inap_drpr_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rawat_inap_drpr
-- ----------------------------

-- ----------------------------
-- Table structure for rawat_inap_pr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_inap_pr`;
CREATE TABLE `rawat_inap_pr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `nip`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  INDEX `biaya_rawat`(`biaya_rawat` ASC) USING BTREE,
  CONSTRAINT `rawat_inap_pr_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_pr_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_pr_ibfk_7` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rawat_inap_pr
-- ----------------------------

-- ----------------------------
-- Table structure for rawat_jl_dr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_jl_dr`;
CREATE TABLE `rawat_jl_dr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  `stts_bayar` enum('Sudah','Belum','Suspen') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `kd_dokter`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `biaya_rawat`(`biaya_rawat` ASC) USING BTREE,
  CONSTRAINT `rawat_jl_dr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_dr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_dr_ibfk_5` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rawat_jl_dr
-- ----------------------------

-- ----------------------------
-- Table structure for rawat_jl_drpr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_jl_drpr`;
CREATE TABLE `rawat_jl_drpr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `material` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NULL DEFAULT NULL,
  `tarif_tindakanpr` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  `stts_bayar` enum('Sudah','Belum','Suspen') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `kd_dokter`, `nip`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `rawat_jl_drpr_ibfk_2`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `rawat_jl_drpr_ibfk_3`(`kd_dokter` ASC) USING BTREE,
  INDEX `rawat_jl_drpr_ibfk_4`(`nip` ASC) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  CONSTRAINT `rawat_jl_drpr_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rawat_jl_drpr
-- ----------------------------

-- ----------------------------
-- Table structure for rawat_jl_pr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_jl_pr`;
CREATE TABLE `rawat_jl_pr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  `stts_bayar` enum('Sudah','Belum','Suspen') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `nip`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `nip`(`nip` ASC) USING BTREE,
  INDEX `biaya_rawat`(`biaya_rawat` ASC) USING BTREE,
  CONSTRAINT `rawat_jl_pr_ibfk_10` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_pr_ibfk_8` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_pr_ibfk_9` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rawat_jl_pr
-- ----------------------------

-- ----------------------------
-- Table structure for reg_periksa
-- ----------------------------
DROP TABLE IF EXISTS `reg_periksa`;
CREATE TABLE `reg_periksa`  (
  `no_reg` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_registrasi` date NULL DEFAULT NULL,
  `jam_reg` time NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_poli` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `p_jawab` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `almt_pj` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hubunganpj` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `biaya_reg` double NULL DEFAULT NULL,
  `stts` enum('Belum','Sudah','Batal','Berkas Diterima','Dirujuk','Meninggal','Dirawat','Pulang Paksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stts_daftar` enum('-','Lama','Baru') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_lanjut` enum('Ralan','Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `umurdaftar` int NULL DEFAULT NULL,
  `sttsumur` enum('Th','Bl','Hr') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_bayar` enum('Sudah Bayar','Belum Bayar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_poli` enum('Lama','Baru') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis` ASC) USING BTREE,
  INDEX `kd_poli`(`kd_poli` ASC) USING BTREE,
  INDEX `kd_pj`(`kd_pj` ASC) USING BTREE,
  INDEX `status_lanjut`(`status_lanjut` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  INDEX `status_bayar`(`status_bayar` ASC) USING BTREE,
  CONSTRAINT `reg_periksa_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_6` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_7` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reg_periksa
-- ----------------------------

-- ----------------------------
-- Table structure for rekap_presensi
-- ----------------------------
DROP TABLE IF EXISTS `rekap_presensi`;
CREATE TABLE `rekap_presensi`  (
  `id` int NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam_datang` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `jam_pulang` datetime NULL DEFAULT NULL,
  `status` enum('Tepat Waktu','Terlambat Toleransi','Terlambat I','Terlambat II','Tepat Waktu & PSW','Terlambat Toleransi & PSW','Terlambat I & PSW','Terlambat II & PSW') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterlambatan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`, `jam_datang`) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE,
  CONSTRAINT `rekap_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rekap_presensi
-- ----------------------------

-- ----------------------------
-- Table structure for remember_me
-- ----------------------------
DROP TABLE IF EXISTS `remember_me`;
CREATE TABLE `remember_me`  (
  `id` int NOT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  `expiry` int NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of remember_me
-- ----------------------------

-- ----------------------------
-- Table structure for resep_dokter
-- ----------------------------
DROP TABLE IF EXISTS `resep_dokter`;
CREATE TABLE `resep_dokter`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml` double NULL DEFAULT NULL,
  `aturan_pakai` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_resep`(`no_resep` ASC) USING BTREE,
  INDEX `kode_brng`(`kode_brng` ASC) USING BTREE,
  CONSTRAINT `resep_dokter_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resep_dokter
-- ----------------------------

-- ----------------------------
-- Table structure for resep_dokter_racikan
-- ----------------------------
DROP TABLE IF EXISTS `resep_dokter_racikan`;
CREATE TABLE `resep_dokter_racikan`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_racik` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_racik` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_racik` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml_dr` int NOT NULL,
  `aturan_pakai` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_resep`, `no_racik`) USING BTREE,
  INDEX `kd_racik`(`kd_racik` ASC) USING BTREE,
  CONSTRAINT `resep_dokter_racikan_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_racikan_ibfk_2` FOREIGN KEY (`kd_racik`) REFERENCES `metode_racik` (`kd_racik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resep_dokter_racikan
-- ----------------------------

-- ----------------------------
-- Table structure for resep_dokter_racikan_detail
-- ----------------------------
DROP TABLE IF EXISTS `resep_dokter_racikan_detail`;
CREATE TABLE `resep_dokter_racikan_detail`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_racik` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `p1` double NULL DEFAULT NULL,
  `p2` double NULL DEFAULT NULL,
  `kandungan` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_resep`, `no_racik`, `kode_brng`) USING BTREE,
  INDEX `kode_brng`(`kode_brng` ASC) USING BTREE,
  CONSTRAINT `resep_dokter_racikan_detail_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_racikan_detail_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resep_dokter_racikan_detail
-- ----------------------------

-- ----------------------------
-- Table structure for resep_obat
-- ----------------------------
DROP TABLE IF EXISTS `resep_obat`;
CREATE TABLE `resep_obat`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_perawatan` date NULL DEFAULT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_peresepan` date NULL DEFAULT NULL,
  `jam_peresepan` time NULL DEFAULT NULL,
  `status` enum('ralan','ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_penyerahan` date NOT NULL,
  `jam_penyerahan` time NOT NULL,
  PRIMARY KEY (`no_resep`) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `resep_obat_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `resep_obat_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resep_obat
-- ----------------------------

-- ----------------------------
-- Table structure for resep_pulang
-- ----------------------------
DROP TABLE IF EXISTS `resep_pulang`;
CREATE TABLE `resep_pulang`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml_barang` double NOT NULL,
  `harga` double NOT NULL,
  `total` double NOT NULL,
  `dosis` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `kd_bangsal` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode_brng`, `tanggal`, `jam`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `kode_brng`(`kode_brng` ASC) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal` ASC) USING BTREE,
  INDEX `no_rawat`(`no_rawat` ASC) USING BTREE,
  CONSTRAINT `resep_pulang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_pulang_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `resep_pulang_ibfk_4` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resep_pulang
-- ----------------------------

-- ----------------------------
-- Table structure for resiko_kerja
-- ----------------------------
DROP TABLE IF EXISTS `resiko_kerja`;
CREATE TABLE `resiko_kerja`  (
  `kode_resiko` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_resiko` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `indek` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`kode_resiko`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resiko_kerja
-- ----------------------------
INSERT INTO `resiko_kerja` VALUES ('-', '-', 1);

-- ----------------------------
-- Table structure for resume_pasien
-- ----------------------------
DROP TABLE IF EXISTS `resume_pasien`;
CREATE TABLE `resume_pasien`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jalannya_penyakit` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_penunjang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hasil_laborat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_utama` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_utama` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder2` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder2` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder3` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder3` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder4` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder4` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_utama` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_utama` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder2` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder2` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder3` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder3` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kondisi_pulang` enum('Hidup','Meninggal') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `obat_pulang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `resume_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resume_pasien_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resume_pasien
-- ----------------------------

-- ----------------------------
-- Table structure for resume_pasien_ranap
-- ----------------------------
DROP TABLE IF EXISTS `resume_pasien_ranap`;
CREATE TABLE `resume_pasien_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_awal` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alasan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_fisik` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jalannya_penyakit` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_penunjang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hasil_laborat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tindakan_dan_operasi` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `obat_di_rs` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_utama` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_utama` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder2` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder2` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder3` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder3` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder4` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder4` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_utama` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_utama` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder2` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder2` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder3` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder3` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diet` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lab_belum` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `edukasi` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cara_keluar` enum('Atas Izin Dokter','Pindah RS','Pulang Atas Permintaan Sendiri','Lainnya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_keluar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keadaan` enum('Membaik','Sembuh','Keadaan Khusus','Meninggal') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_keadaan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dilanjutkan` enum('Kembali Ke RS','RS Lain','Dokter Luar','Puskesmes','Lainnya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_dilanjutkan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontrol` datetime NULL DEFAULT NULL,
  `obat_pulang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `resume_pasien_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resume_pasien_ranap_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resume_pasien_ranap
-- ----------------------------

-- ----------------------------
-- Table structure for riwayat_barang_medis
-- ----------------------------
DROP TABLE IF EXISTS `riwayat_barang_medis`;
CREATE TABLE `riwayat_barang_medis`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stok_awal` double NULL DEFAULT NULL,
  `masuk` double NULL DEFAULT NULL,
  `keluar` double NULL DEFAULT NULL,
  `stok_akhir` double NOT NULL,
  `posisi` enum('Pemberian Obat','Pengadaan','Penerimaan','Piutang','Retur Beli','Retur Jual','Retur Piutang','Mutasi','Opname','Resep Pulang','Retur Pasien','Stok Pasien Ranap','Pengambilan Medis','Penjualan','Stok Keluar','Hibah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `jam` time NULL DEFAULT NULL,
  `petugas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Simpan','Hapus') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  INDEX `riwayat_barang_medis_ibfk_1`(`kode_brng` ASC) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal` ASC) USING BTREE,
  CONSTRAINT `riwayat_barang_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `riwayat_barang_medis_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of riwayat_barang_medis
-- ----------------------------
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 0, 0, 200, -200, 'Mutasi', '2026-07-02', '09:33:19', 'Administrator', '-', 'Simpan', '0', '0', '-');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 0, 200, 0, 200, 'Mutasi', '2026-07-02', '09:33:19', 'Administrator', 'APT', 'Simpan', '0', '0', '');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 0, 0, 200, -200, 'Mutasi', '2026-07-08', '11:58:07', 'Administrator', '-', 'Simpan', '0', '0', '-');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 0, 200, 0, 200, 'Mutasi', '2026-07-08', '11:58:07', 'Administrator', 'OBL', 'Simpan', '0', '0', '');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 200, 0, 6, 194, 'Penjualan', '2026-07-09', '10:46:55', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 194, 0, 6, 188, 'Penjualan', '2026-07-09', '13:29:22', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 188, 0, 6, 182, 'Penjualan', '2026-07-09', '13:31:09', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 182, 0, 6, 176, 'Penjualan', '2026-07-09', '13:32:42', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 176, 0, 6, 170, 'Penjualan', '2026-07-09', '13:43:07', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 170, 0, 6, 164, 'Penjualan', '2026-07-09', '13:48:31', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 164, 0, 6, 158, 'Penjualan', '2026-07-09', '14:36:51', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 158, 0, 6, 152, 'Penjualan', '2026-07-09', '14:40:05', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00002', 0, 0, 200, -200, 'Mutasi', '2026-07-10', '09:32:08', 'Administrator', '-', 'Simpan', '0', '0', '-');
INSERT INTO `riwayat_barang_medis` VALUES ('B00002', 0, 200, 0, 200, 'Mutasi', '2026-07-10', '09:32:08', 'Administrator', 'OBL', 'Simpan', '0', '0', '');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 152, 0, 5, 147, 'Penjualan', '2026-07-10', '12:19:23', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 147, 0, 5, 142, 'Penjualan', '2026-07-10', '12:20:07', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00002', 200, 0, 5, 195, 'Penjualan', '2026-07-10', '12:20:07', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 142, 0, 5, 137, 'Penjualan', '2026-07-10', '12:20:07', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 137, 0, 5, 132, 'Penjualan', '2026-07-10', '12:22:01', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');
INSERT INTO `riwayat_barang_medis` VALUES ('B00001', 132, 0, 5, 127, 'Penjualan', '2026-07-10', '12:25:14', 'Administrator', 'OBL', 'Simpan', '0', '0', 'Penjualan obat bebas');

-- ----------------------------
-- Table structure for ruang_ok
-- ----------------------------
DROP TABLE IF EXISTS `ruang_ok`;
CREATE TABLE `ruang_ok`  (
  `kd_ruang_ok` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_ruang_ok` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_ruang_ok`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ruang_ok
-- ----------------------------

-- ----------------------------
-- Table structure for satu_sehat
-- ----------------------------
DROP TABLE IF EXISTS `satu_sehat`;
CREATE TABLE `satu_sehat`  (
  `id` int NULL DEFAULT NULL,
  `id_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of satu_sehat
-- ----------------------------

-- ----------------------------
-- Table structure for satu_sehat_response
-- ----------------------------
DROP TABLE IF EXISTS `satu_sehat_response`;
CREATE TABLE `satu_sehat_response`  (
  `id` int NULL DEFAULT NULL,
  `id_pendaftaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_encounter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_condition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvnadi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvrespirasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvsuhu` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvspo2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvgcs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvtinggi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvberat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvperut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvtensi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `id_observation_ttvkesadaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of satu_sehat_response
-- ----------------------------

-- ----------------------------
-- Table structure for set_keterlambatan
-- ----------------------------
DROP TABLE IF EXISTS `set_keterlambatan`;
CREATE TABLE `set_keterlambatan`  (
  `toleransi` int NULL DEFAULT NULL,
  `terlambat1` int NULL DEFAULT NULL,
  `terlambat2` int NULL DEFAULT NULL
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of set_keterlambatan
-- ----------------------------

-- ----------------------------
-- Table structure for set_no_rkm_medis
-- ----------------------------
DROP TABLE IF EXISTS `set_no_rkm_medis`;
CREATE TABLE `set_no_rkm_medis`  (
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of set_no_rkm_medis
-- ----------------------------
INSERT INTO `set_no_rkm_medis` VALUES ('000000');

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings`  (
  `id` int NOT NULL,
  `module` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `field` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES (1, 'settings', 'logo', 'uploads/drfentysulistyo/settings/logo_676e95346114d.png');
INSERT INTO `settings` VALUES (2, 'settings', 'nama_instansi', 'dr. Fenty Sulistyo E');
INSERT INTO `settings` VALUES (3, 'settings', 'alamat', 'RT.04/RW.07, Dingin, Dusun Dingin, Ngronggot');
INSERT INTO `settings` VALUES (4, 'settings', 'kota', 'Nganjuk');
INSERT INTO `settings` VALUES (5, 'settings', 'propinsi', 'Jawa Timur');
INSERT INTO `settings` VALUES (6, 'settings', 'nomor_telepon', '085808441118');
INSERT INTO `settings` VALUES (7, 'settings', 'email', 'drfentysulistyoe@gmail.com');
INSERT INTO `settings` VALUES (8, 'settings', 'website', '-');
INSERT INTO `settings` VALUES (9, 'settings', 'input_kasir', 'ya');
INSERT INTO `settings` VALUES (10, 'settings', 'cek_status_bayar', 'ya');
INSERT INTO `settings` VALUES (11, 'settings', 'pemeriksaan', 'lengkap');
INSERT INTO `settings` VALUES (12, 'settings', 'footer', 'Copyright {?=date(\"Y\")?} &copy; by drg. Faisol Basoro. All rights reserved.');
INSERT INTO `settings` VALUES (13, 'settings', 'homepage', 'main');
INSERT INTO `settings` VALUES (14, 'settings', 'timezone', 'Asia/Jakarta');
INSERT INTO `settings` VALUES (15, 'settings', 'theme', 'default');
INSERT INTO `settings` VALUES (16, 'settings', 'theme_admin', 'cerulean');
INSERT INTO `settings` VALUES (17, 'settings', 'waapitoken', '-');
INSERT INTO `settings` VALUES (18, 'settings', 'editor', 'html');
INSERT INTO `settings` VALUES (19, 'settings', 'version', '1.0.2');
INSERT INTO `settings` VALUES (20, 'settings', 'update_check', '0');
INSERT INTO `settings` VALUES (21, 'settings', 'update_changelog', '');
INSERT INTO `settings` VALUES (22, 'settings', 'update_version', '0');
INSERT INTO `settings` VALUES (23, 'settings', 'license', '');
INSERT INTO `settings` VALUES (24, 'settings', 'vidio_anjungan', 'cz9nRpvWOIQ');
INSERT INTO `settings` VALUES (25, 'settings', 'running_text', 'Running text anjungan pasien mandiri aplikasi iMedic.ID.....');
INSERT INTO `settings` VALUES (26, 'settings', 'tampilkan_chat', 'tidak');
INSERT INTO `settings` VALUES (27, 'blog', 'perpage', '5');
INSERT INTO `settings` VALUES (28, 'blog', 'disqus', '');
INSERT INTO `settings` VALUES (29, 'blog', 'dateformat', 'M d, Y');
INSERT INTO `settings` VALUES (30, 'blog', 'title', 'Blog');
INSERT INTO `settings` VALUES (31, 'blog', 'desc', '... Why so serious? ...');
INSERT INTO `settings` VALUES (32, 'blog', 'latestPostsCount', '5');
INSERT INTO `settings` VALUES (33, 'pcare', 'usernamePcare', '');
INSERT INTO `settings` VALUES (34, 'pcare', 'passwordPcare', '');
INSERT INTO `settings` VALUES (35, 'pcare', 'consumerID', '');
INSERT INTO `settings` VALUES (36, 'pcare', 'consumerSecret', '');
INSERT INTO `settings` VALUES (37, 'pcare', 'consumerUserKey', '');
INSERT INTO `settings` VALUES (38, 'pcare', 'PCareApiUrl', '');
INSERT INTO `settings` VALUES (39, 'pcare', 'kode_fktp', '');
INSERT INTO `settings` VALUES (40, 'pcare', 'nama_fktp', '');
INSERT INTO `settings` VALUES (41, 'pcare', 'wilayah', 'REGIONAL VIII - Balikpapan');
INSERT INTO `settings` VALUES (42, 'pcare', 'cabang', 'BARABAI');
INSERT INTO `settings` VALUES (43, 'pcare', 'kabupatenkota', 'Kab. Hulu Sungai Tengah');
INSERT INTO `settings` VALUES (44, 'pcare', 'kode_kabupatenkota', '0287');
INSERT INTO `settings` VALUES (45, 'pcare', 'username_antrol', '');
INSERT INTO `settings` VALUES (46, 'pcare', 'password_antrol', '');
INSERT INTO `settings` VALUES (47, 'pcare', 'header_antrol', 'X-Token');
INSERT INTO `settings` VALUES (48, 'pcare', 'header_username_antrol', 'X-Username');
INSERT INTO `settings` VALUES (49, 'pcare', 'header_password_antrol', 'X-Password');
INSERT INTO `settings` VALUES (50, 'pcare', 'kode_bpjs_antrol', '');
INSERT INTO `settings` VALUES (51, 'pcare', 'hari_antrol', '3');
INSERT INTO `settings` VALUES (52, 'pcare', 'kode_poli', '');
INSERT INTO `settings` VALUES (53, 'pcare', 'usernameICare', '');
INSERT INTO `settings` VALUES (54, 'pcare', 'passwordICare', '');
INSERT INTO `settings` VALUES (55, 'satu_sehat', 'nama_dokter', '');
INSERT INTO `settings` VALUES (56, 'satu_sehat', 'practitioner_id', '');
INSERT INTO `settings` VALUES (57, 'satu_sehat', 'organizationid', '');
INSERT INTO `settings` VALUES (58, 'satu_sehat', 'clientid', '');
INSERT INTO `settings` VALUES (59, 'satu_sehat', 'secretkey', '');
INSERT INTO `settings` VALUES (60, 'satu_sehat', 'authurl', 'https://api-satusehat-dev.dto.kemkes.go.id/oauth2/v1');
INSERT INTO `settings` VALUES (61, 'satu_sehat', 'fhirurl', 'https://api-satusehat-dev.dto.kemkes.go.id/fhir-r4/v1');
INSERT INTO `settings` VALUES (62, 'satu_sehat', 'kelurahan', '');
INSERT INTO `settings` VALUES (63, 'satu_sehat', 'kecamatan', '');
INSERT INTO `settings` VALUES (64, 'satu_sehat', 'kabupaten', '');
INSERT INTO `settings` VALUES (65, 'satu_sehat', 'propinsi', '');
INSERT INTO `settings` VALUES (66, 'satu_sehat', 'kodepos', '');
INSERT INTO `settings` VALUES (67, 'satu_sehat', 'longitude', '');
INSERT INTO `settings` VALUES (68, 'satu_sehat', 'latitude', '');
INSERT INTO `settings` VALUES (69, 'satu_sehat', 'zonawaktu', 'WIB');
INSERT INTO `settings` VALUES (70, 'satu_sehat', 'id_lokasi', '');

-- ----------------------------
-- Table structure for skdp_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `skdp_bpjs`;
CREATE TABLE `skdp_bpjs`  (
  `tahun` year NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosa` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `terapi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alasan1` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alasan2` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rtl1` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rtl2` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_datang` datetime NULL DEFAULT NULL,
  `tanggal_rujukan` datetime NOT NULL,
  `no_antrian` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Menunggu','Sudah Periksa','Batal Periksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tahun`, `no_antrian`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis` ASC) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter` ASC) USING BTREE,
  CONSTRAINT `skdp_bpjs_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `skdp_bpjs_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of skdp_bpjs
-- ----------------------------

-- ----------------------------
-- Table structure for spesialis
-- ----------------------------
DROP TABLE IF EXISTS `spesialis`;
CREATE TABLE `spesialis`  (
  `kd_sps` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nm_sps` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_sps`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spesialis
-- ----------------------------
INSERT INTO `spesialis` VALUES ('UMUM', 'Dokter Umum');

-- ----------------------------
-- Table structure for stts_kerja
-- ----------------------------
DROP TABLE IF EXISTS `stts_kerja`;
CREATE TABLE `stts_kerja`  (
  `stts` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ktg` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `indek` tinyint NOT NULL,
  PRIMARY KEY (`stts`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stts_kerja
-- ----------------------------
INSERT INTO `stts_kerja` VALUES ('-', '-', 1);

-- ----------------------------
-- Table structure for stts_wp
-- ----------------------------
DROP TABLE IF EXISTS `stts_wp`;
CREATE TABLE `stts_wp`  (
  `stts` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ktg` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`stts`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stts_wp
-- ----------------------------
INSERT INTO `stts_wp` VALUES ('-', '-');

-- ----------------------------
-- Table structure for suku_bangsa
-- ----------------------------
DROP TABLE IF EXISTS `suku_bangsa`;
CREATE TABLE `suku_bangsa`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_suku_bangsa` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nama_suku_bangsa`(`nama_suku_bangsa` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of suku_bangsa
-- ----------------------------
INSERT INTO `suku_bangsa` VALUES (1, '-');

-- ----------------------------
-- Table structure for tambahan_biaya
-- ----------------------------
DROP TABLE IF EXISTS `tambahan_biaya`;
CREATE TABLE `tambahan_biaya`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_biaya` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `besar_biaya` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `nama_biaya`) USING BTREE,
  CONSTRAINT `tambahan_biaya_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tambahan_biaya
-- ----------------------------

-- ----------------------------
-- Table structure for template_laboratorium
-- ----------------------------
DROP TABLE IF EXISTS `template_laboratorium`;
CREATE TABLE `template_laboratorium`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_template` int NOT NULL AUTO_INCREMENT,
  `Pemeriksaan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `satuan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai_rujukan_ld` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai_rujukan_la` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai_rujukan_pd` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai_rujukan_pa` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `bagian_perujuk` double NOT NULL,
  `bagian_dokter` double NOT NULL,
  `bagian_laborat` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_item` double NOT NULL,
  `urut` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_template`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw` ASC) USING BTREE,
  INDEX `Pemeriksaan`(`Pemeriksaan` ASC) USING BTREE,
  INDEX `satuan`(`satuan` ASC) USING BTREE,
  INDEX `nilai_rujukan_ld`(`nilai_rujukan_ld` ASC) USING BTREE,
  INDEX `nilai_rujukan_la`(`nilai_rujukan_la` ASC) USING BTREE,
  INDEX `nilai_rujukan_pd`(`nilai_rujukan_pd` ASC) USING BTREE,
  INDEX `nilai_rujukan_pa`(`nilai_rujukan_pa` ASC) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs` ASC) USING BTREE,
  INDEX `bhp`(`bhp` ASC) USING BTREE,
  INDEX `bagian_perujuk`(`bagian_perujuk` ASC) USING BTREE,
  INDEX `bagian_dokter`(`bagian_dokter` ASC) USING BTREE,
  INDEX `bagian_laborat`(`bagian_laborat` ASC) USING BTREE,
  INDEX `kso`(`kso` ASC) USING BTREE,
  INDEX `menejemen`(`menejemen` ASC) USING BTREE,
  INDEX `biaya_item`(`biaya_item` ASC) USING BTREE,
  INDEX `urut`(`urut` ASC) USING BTREE,
  CONSTRAINT `template_laboratorium_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of template_laboratorium
-- ----------------------------
INSERT INTO `template_laboratorium` VALUES ('LAB001', 1, 'Leukosit', 'LK', '10', '5', '10', '5', 0, 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO `template_laboratorium` VALUES ('LAB001', 2, 'Hemoglobin', 'HB', '20', '10', '20', '10', 0, 0, 0, 0, 0, 0, 0, 0, 2);

-- ----------------------------
-- Table structure for temporary_presensi
-- ----------------------------
DROP TABLE IF EXISTS `temporary_presensi`;
CREATE TABLE `temporary_presensi`  (
  `id` int NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam_datang` datetime NULL DEFAULT NULL,
  `jam_pulang` datetime NULL DEFAULT NULL,
  `status` enum('Tepat Waktu','Terlambat Toleransi','Terlambat I','Terlambat II','Tepat Waktu & PSW','Terlambat Toleransi & PSW','Terlambat I & PSW','Terlambat II & PSW') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterlambatan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `temporary_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of temporary_presensi
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL,
  `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fullname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `avatar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `access` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'Administrator', 'Admin ganteng baik hati, suka menabung dan tidak sombong.', '$2y$10$yRQmDWOXM0PhoKZ.1.kix.K.Ckw8oR1i/ToPAR/WYRt/4SDD5u1eO', 'avatar676e3e79ec70b.png', 'adminfe@gmail.com', 'admin', 'all');
INSERT INTO `users` VALUES (2, 'DR000002', 'dr. Fenty Sulistyo E', 'Akun kusus dokter', '$2y$10$L95k.twSe275NULURrNwjOase6kZkZ1Nq8UWboYFw4F.4VS5Al.Am', 'avatar676e40f62bcf0.png', 'drfenty@gmail.com', 'admin', 'pasien,pendaftaran,kasir,master,laporan,blog,pcare,satu_sehat,dashboard');

-- ----------------------------
-- Table structure for utd_donor
-- ----------------------------
DROP TABLE IF EXISTS `utd_donor`;
CREATE TABLE `utd_donor`  (
  `no_donor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_pendonor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tensi` varchar(7) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_bag` int NULL DEFAULT NULL,
  `jenis_bag` enum('SB','DB','TB','QB') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jenis_donor` enum('DB','DP','DS') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tempat_aftap` enum('Dalam Gedung','Luar Gedung') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas_aftap` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hbsag` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hcv` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hiv` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spilis` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `malaria` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas_u_saring` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Aman','Cekal') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_donor`) USING BTREE,
  INDEX `petugas_aftap`(`petugas_aftap` ASC) USING BTREE,
  INDEX `petugas_u_saring`(`petugas_u_saring` ASC) USING BTREE,
  INDEX `no_pendonor`(`no_pendonor` ASC) USING BTREE,
  CONSTRAINT `utd_donor_ibfk_1` FOREIGN KEY (`petugas_aftap`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_donor_ibfk_2` FOREIGN KEY (`petugas_u_saring`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_donor_ibfk_3` FOREIGN KEY (`no_pendonor`) REFERENCES `utd_pendonor` (`no_pendonor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of utd_donor
-- ----------------------------

-- ----------------------------
-- Table structure for utd_komponen_darah
-- ----------------------------
DROP TABLE IF EXISTS `utd_komponen_darah`;
CREATE TABLE `utd_komponen_darah`  (
  `kode` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lama` smallint NULL DEFAULT NULL,
  `jasa_sarana` double NULL DEFAULT NULL,
  `paket_bhp` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `manajemen` double NULL DEFAULT NULL,
  `total` double NULL DEFAULT NULL,
  `pembatalan` double NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of utd_komponen_darah
-- ----------------------------

-- ----------------------------
-- Table structure for utd_pendonor
-- ----------------------------
DROP TABLE IF EXISTS `utd_pendonor`;
CREATE TABLE `utd_pendonor`  (
  `no_pendonor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_ktp` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jk` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tmp_lahir` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_kel` int NOT NULL,
  `kd_kec` int NOT NULL,
  `kd_kab` int NOT NULL,
  `kd_prop` int NOT NULL,
  `golongan_darah` enum('A','AB','B','O') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `resus` enum('(-)','(+)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_telp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_pendonor`) USING BTREE,
  INDEX `kd_kec`(`kd_kec` ASC) USING BTREE,
  INDEX `kd_kab`(`kd_kab` ASC) USING BTREE,
  INDEX `kd_prop`(`kd_prop` ASC) USING BTREE,
  INDEX `kd_kel`(`kd_kel` ASC) USING BTREE,
  CONSTRAINT `utd_pendonor_ibfk_1` FOREIGN KEY (`kd_kec`) REFERENCES `kecamatan` (`kd_kec`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `utd_pendonor_ibfk_2` FOREIGN KEY (`kd_kab`) REFERENCES `kabupaten` (`kd_kab`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `utd_pendonor_ibfk_3` FOREIGN KEY (`kd_prop`) REFERENCES `propinsi` (`kd_prop`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of utd_pendonor
-- ----------------------------

-- ----------------------------
-- Table structure for utd_stok_darah
-- ----------------------------
DROP TABLE IF EXISTS `utd_stok_darah`;
CREATE TABLE `utd_stok_darah`  (
  `no_kantong` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_komponen` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `golongan_darah` enum('A','AB','B','O') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `resus` enum('(-)','(+)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_aftap` date NULL DEFAULT NULL,
  `tanggal_kadaluarsa` date NULL DEFAULT NULL,
  `asal_darah` enum('Hibah','Beli','Produksi Sendiri') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Ada','Diambil','Dimusnahkan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_kantong`) USING BTREE,
  INDEX `kode_komponen`(`kode_komponen` ASC) USING BTREE,
  CONSTRAINT `utd_stok_darah_ibfk_1` FOREIGN KEY (`kode_komponen`) REFERENCES `utd_komponen_darah` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of utd_stok_darah
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
