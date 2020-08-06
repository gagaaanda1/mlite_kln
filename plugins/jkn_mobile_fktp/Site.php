<?php

namespace Plugins\JKN_Mobile_FKTP;

use Systems\SiteModule;
use Systems\Lib\BpjsRequest;

class Site extends SiteModule
{

    public function routes()
    {
        $this->route('jknmobilefktp', 'getIndex');
        $this->route('jknmobilefktp/auth', 'getAuth');
        $this->route('jknmobilefktp/antrean', 'getAntrean');
        $this->route('jknmobilefktp/antrean/status/(:str)/(:str)', 'getStatusAntrean');
        $this->route('jknmobilefktp/antrean/sisapeserta/(:str)/(:str)/(:str)', 'getSisaAntrean');
        $this->route('jknmobilefktp/antrean/batal', 'getBatalAntrean');
        $this->route('jknmobilefktp/peserta', 'getPeserta');
    }

    public function getIndex()
    {
        $page = [
            'content' => $this->draw('index.html', ['referensi_poli' => $this->db('maping_poli_bpjs')->toArray()])
        ];

        $this->setTemplate('canvas.html');
        $this->tpl->set('page', $page);
    }

    public function getAuth()
    {
        $page = [
            'content' => $this->_resultAuth()
        ];

        $this->setTemplate('canvas.html');
        $this->tpl->set('page', $page);
    }

    private function _resultAuth()
    {
        header("Content-Type: application/json");
        $header = apache_request_headers();
        $response = array();
        if ($header[$this->options->get('jkn_mobile_fktp.header_username')] == $this->options->get('jkn_mobile_fktp.username') && $header[$this->options->get('jkn_mobile_fktp.header_password')] == $this->options->get('jkn_mobile_fktp.password')) {
            $response = array(
                'response' => array(
                    'token' => $this->_getToken()
                ),
                'metadata' => array(
                    'message' => 'Ok',
                    'code' => 200
                )
            );
        } else {
            $response = array(
                'metadata' => array(
                    'message' => 'Access denied',
                    'code' => 401
                )
            );
        }
        echo json_encode(array("response" => $response));
    }

    public function getAntrean()
    {
        $page = [
            'content' => $this->_resultAntrean()
        ];

        $this->setTemplate('canvas.html');
        $this->tpl->set('page', $page);
    }

    private function _resultAntrean()
    {
        header("Content-Type: application/json");
        $header = apache_request_headers();
        $konten = trim(file_get_contents("php://input"));
        $decode = json_decode($konten, true);
        $response = array();
        $tanggal=$decode['tanggalperiksa'];
        $tentukan_hari=date('D',strtotime($tanggal));
        $day = array(
          'Sun' => 'AKHAD',
          'Mon' => 'SENIN',
          'Tue' => 'SELASA',
          'Wed' => 'RABU',
          'Thu' => 'KAMIS',
          'Fri' => 'JUMAT',
          'Sat' => 'SABTU'
        );
        $hari=$day[$tentukan_hari];

        if ($header[$this->options->get('jkn_mobile_fktp.header_username')] == $this->options->get('jkn_mobile_fktp.username') && $header[$this->options->get('jkn_mobile_fktp.header')] == $this->_getToken()) {

            if (empty($decode['nomorkartu'])or strlen($decode['nik']) < 13) {
                $response = array(
                    'metadata' => array(
                        'message' => 'Maaf Nomor kartu kurang dari 13 Digit',
                        'code' => 201
                    )
                );
            }

            if (empty($decode['nik']) or strlen($decode['nik']) < 15) {
                $response = array(
                    'metadata' => array(
                        'message' => 'Maaf Nomor Induk Kependudukan kurang dari 16 Digit',
                        'code' => 201
                    )
                );
            }

            if (empty($decode['kodepoli'])) {
                $response = array(
                    'metadata' => array(
                        'message' => 'Maaf Poli Tujuan Anda Masih Kosong',
                        'code' => 201
                    )
                );
            }

            if (strtotime($decode['tanggalperiksa']) < strtotime(date('Y-m-d')) or strtotime($decode['tanggalperiksa']) >= strtotime(date('Y-m-d', strtotime('+' . $this->options->get('jkn_mobile_fktp.hari') . ' day', strtotime(date('Y-m-d')))))) {
                $response = array(
                    'metadata' => array(
                        'message' => 'Maaf pemilihan tanggal hanya boleh ' . $this->options->get('jkn_mobile_fktp.hari') . ' Hari Kedepan dari Hari Sekarang',
                        'code' => 201
                    )
                );
            }

            if (!empty($decode['nomorkartu']) && !empty($decode['nik']) && !empty($decode['kodepoli']) && !empty($decode['tanggalperiksa'])) {
                $data_pasien = $this->db('pasien')->where('no_peserta', $decode['nomorkartu'])->oneArray();
                $poli = $this->db('maping_poliklinik_pcare')->where('kd_poli_pcare', $decode['kodepoli'])->oneArray();
                $cek_kouta = $this->db()->pdo()->prepare("SELECT jadwal.kuota - (SELECT COUNT(booking_registrasi.tanggal_periksa) FROM booking_registrasi WHERE booking_registrasi.tanggal_periksa='$decode[tanggalperiksa]' AND booking_registrasi.kd_dokter=jadwal.kd_dokter) as sisa_kouta, jadwal.kd_dokter, jadwal.kd_poli, jadwal.jam_mulai as jam_mulai, poliklinik.nm_poli, dokter.nm_dokter FROM jadwal INNER JOIN maping_poliklinik_pcare ON maping_poliklinik_pcare.kd_poli_rs=jadwal.kd_poli INNER JOIN poliklinik ON poliklinik.kd_poli=jadwal.kd_poli INNER JOIN dokter ON dokter.kd_dokter=jadwal.kd_dokter WHERE jadwal.hari_kerja='$hari' AND maping_poliklinik_pcare.kd_poli_pcare='$decode[kodepoli]' GROUP BY jadwal.kd_dokter HAVING sisa_kouta > 0 ORDER BY sisa_kouta DESC LIMIT 1");
                $cek_kouta->execute();
                $cek_kouta = $cek_kouta->fetch();

                if (!empty($cek_kouta['sisa_kouta']) and $cek_kouta['sisa_kouta'] > 0) {
                    if ($data_pasien['no_ktp'] != '') {
                        $no_reg_akhir = $this->db()->pdo()->prepare("SELECT max(no_reg) FROM booking_registrasi WHERE kd_poli='$poli[kd_poli_rs]' and tanggal_periksa='$decode[tanggalperiksa]'");
                        $no_reg_akhir->execute();
                        $no_reg_akhir = $no_reg_akhir->fetch();
                        if(empty($no_reg_akhir[0])) {
                          $no_reg_akhir[0] = '000';
                        }
                        $no_urut_reg = substr($no_reg_akhir['0'], 0, 3);
                        $no_reg = sprintf('%03s', ($no_urut_reg + 1));
                        $jenisantrean = 2;
                        $minutes = $no_urut_reg * 10;
                        $cek_kouta['jam_mulai'] = date('H:i:s',strtotime('+'.$minutes.' minutes',strtotime($cek_kouta['jam_mulai'])));
                        $query = $this->db('booking_registrasi')->save([
                            'tanggal_booking' => date('Y-m-d'),
                            'jam_booking' => date('H:i:s'),
                            'no_rkm_medis' => $data_pasien['no_rkm_medis'],
                            'tanggal_periksa' => $decode['tanggalperiksa'],
                            'kd_dokter' => $cek_kouta['kd_dokter'],
                            'kd_poli' => $cek_kouta['kd_poli'],
                            'no_reg' => $no_reg,
                            'kd_pj' => $this->options->get('pendaftaran.bpjs'),
                            'limit_reg' => 0,
                            'waktu_kunjungan' => $decode['tanggalperiksa'].' '.$cek_kouta['jam_mulai'],
                            'status' => 'Belum'
                        ]);

                        if ($query) {
                            $response = array(
                                'response' => array(
                                    'nomorantrean' => $no_reg,
                                    'angkaantrean' => $no_reg,
                                    'namapoli' => $cek_kouta['nm_poli'],
                                    'sisaantrean' => strtotime($cek_kouta['jam_mulai']) * 1000,
                                    'antreanpanggil' => $no_reg,
                                    'keterangan' => 'Datang 30 Menit sebelum pelayanan, Konfirmasi kehadiran dibagian pendaftaran dengan menunjukan bukti pendaftaran melalui Mobile JKN, Terima Kasih..'
                                ),
                                'metadata' => array(
                                    'message' => 'Ok',
                                    'code' => 200
                                )
                            );
                        } else {
                            $response = array(
                                'metadata' => array(
                                    'message' => "Maaf Terjadi Kesalahan, Hubungi Admnistrator..",
                                    'code' => 401
                                )
                            );
                        }
                    } elseif ($data_pasien['no_ktp'] == '') {
                        $response = array(
                            'metadata' => array(
                                'message' => "Pasien tidak ditemukan/belum terdaftar di " . $this->core->getSettings('nama_instansi'),
                                'code' => 401
                            )
                        );
                    }
                } else {
                    $response = array(
                        'metadata' => array(
                            'message' => "Maaf kouta antrian tidak tersedia atau Habis ! Mohon pilih tanggal lain!",
                            'code' => 401
                        )
                    );
                }
            }

        } else {
            $response = array(
                'metadata' => array(
                    'message' => 'Access denied',
                    'code' => 401
                )
            );
        }
        echo json_encode($response);
    }

    public function getStatusAntrean()
    {
        $page = [
            'content' => $this->_resultStatusAntrean()
        ];

        $this->setTemplate('canvas.html');
        $this->tpl->set('page', $page);
    }

    private function _resultStatusAntrean()
    {
        header("Content-Type: application/json");
        $slug = parseURL();
        if(count($slug) == 4) {$n = 0;}
        if(count($slug) == 5) {$n = 1;}
        if(count($slug) == 6) {$n = 2;}
        if(count($slug) == 7) {$n = 3;}
        $header = apache_request_headers();
        $response = array();
        if ($slug[(1+$n)] == 'status' && $header[$this->options->get('jkn_mobile_fktp.header')] == $this->_getToken() && $header[$this->options->get('jkn_mobile_fktp.header_username')] == $this->options->get('jkn_mobile_fktp.username')) {
            $data = $this->db('reg_periksa')
              ->select('poliklinik.nm_poli')
              ->select(['total_antrean' => 'COUNT(DISTINCT reg_periksa.no_rawat)'])
              ->select(['sisa_antrean' => 'SUM(CASE WHEN reg_periksa.stts=\'Belum\' THEN 1 ELSE 0 END)'])
              ->join('poliklinik', 'poliklinik.kd_poli = reg_periksa.kd_poli')
              ->join('maping_poliklinik_pcare', 'maping_poliklinik_pcare.kd_poli_rs = reg_periksa.kd_poli')
              ->where('reg_periksa.tgl_registrasi', $slug[(3+$n)])
              ->where('maping_poliklinik_pcare.kd_poli_pcare', $slug[(2+$n)])
              ->oneArray();
            $get_no_reg = $this->db('reg_periksa')
              ->select('reg_periksa.no_reg')
              ->join('maping_poliklinik_pcare', 'maping_poliklinik_pcare.kd_poli_pcare = reg_periksa.kd_poli')
              ->where('reg_periksa.tgl_registrasi', $slug[(3+$n)])
              ->where('maping_poliklinik_pcare.kd_poli_pcare', $slug[(2+$n)])
              ->where('reg_periksa.stts', 'Berkas Diterima')
              ->limit(1)
              ->oneArray();
            $data['antrean_panggil'] = '000';
            if(!empty($get_no_reg['no_reg'])) {
               $data['antrean_panggil'] = $get_no_reg['no_reg'];
            }

            if ($data['nm_poli'] != '') {
                $response = array(
                    'response' => array(
                        'namapoli' => $data['nm_poli'],
                        'totalantrean' => $data['total_antrean'],
                        'sisaantrean' => $data['sisa_antrean'],
                        'antreanpanggil' => $data['antrean_panggil'],
                        'keterangan' => 'Datanglah Minimal 30 Menit, jika no antrian anda terlewat, silakan konfirmasi ke bagian Pendaftaran atau Perawat Poli, Terima Kasih.'
                    ),
                    'metadata' => array(
                        'message' => 'Ok',
                        'code' => 200
                    )
                );
            } else {
                $response = array(
                    'metadata' => array(
                        'message' => 'Maaf belum Ada Antrian ditanggal ' . $slug[(3+$n)],
                        'code' => 201
                    )
                );
            }
        } else {
            $response = array(
                'metadata' => array(
                    'message' => 'Access denied',
                    'code' => 401
                )
            );
        }
        echo json_encode($response);
    }

    public function getSisaAntrean()
    {
        $page = [
            'content' => $this->_resultSisaAntrean()
        ];

        $this->setTemplate('canvas.html');
        $this->tpl->set('page', $page);
    }

    private function _resultSisaAntrean()
    {
        header("Content-Type: application/json");
        $header = apache_request_headers();
        $konten = trim(file_get_contents("php://input"));
        $decode = json_decode($konten, true);
        $response = array();
        $response = array(
            'metadata' => array(
                'message' => 'Cooming Soon',
                'code' => 505
            )
        );
        echo json_encode($response);

    }

    public function getBatalAntrean()
    {
        $page = [
            'content' => $this->_resultBatalAntrean()
        ];

        $this->setTemplate('canvas.html');
        $this->tpl->set('page', $page);
    }

    private function _resultBatalAntrean()
    {
        header("Content-Type: application/json");
        $header = apache_request_headers();
        $konten = trim(file_get_contents("php://input"));
        $decode = json_decode($konten, true);
        $response = array();
        if ($header[$this->options->get('jkn_mobile_fktp.header')] == $this->_getToken() && $header[$this->options->get('jkn_mobile_fktp.header_username')] == $this->options->get('jkn_mobile_fktp.username')) {
            if (!empty($decode['nomorkartu']) && !empty($decode['kodepoli']) && !empty($decode['tanggalperiksa'])) {
                $data_pasien = $this->db('pasien')->where('no_peserta', $decode['nomorkartu'])->oneArray();
                $poli = $this->db('maping_poliklinik_pcare')->where('kd_poli_pcare', $decode['kodepoli'])->oneArray();
                $cek = $this->db('booking_registrasi')
                    ->where('no_rkm_medis', $data_pasien['no_rkm_medis'])
                    ->where('kd_poli', $poli['kd_poli_rs'])
                    ->where('tanggal_periksa', $decode['tanggalperiksa'])
                    ->where('status', 'Belum')
                    ->oneArray();
                if (!empty($data_pasien['no_rkm_medis'])) {
                    $query = $this->db('booking_registrasi')
                        ->where('no_rkm_medis', $data_pasien['no_rkm_medis'])
                        ->where('kd_poli', $poli['kd_poli_rs'])
                        ->where('tanggal_periksa', $decode['tanggalperiksa'])
                        ->where('status', 'Belum')
                        ->delete();
                    if ($query) {
                        $response = array(
                            'metadata' => array(
                                'message' => 'Ok',
                                'code' => 200
                            )
                        );
                    } else {
                        $response = array(
                            'metadata' => array(
                                'message' => "Maaf Terjadi kesalahan, Silahkan hubungi Administrator!",
                                'code' => 401
                            )
                        );
                    }
                } else  {
                    $response = array(
                        'metadata' => array(
                            'message' => 'Data ini  Tidak bisa Di Hapus Karena Sudah Terdaftar !',
                            'code' => 201
                        )
                    );
                }
            }
        }
        echo json_encode($response);
    }

    public function getPeserta()
    {
        $page = [
            'content' => $this->_resultPeserta()
        ];

        $this->setTemplate('canvas.html');
        $this->tpl->set('page', $page);
    }

    private function _resultPeserta()
    {
        header("Content-Type: application/json");
        $header = apache_request_headers();
        $konten = trim(file_get_contents("php://input"));
        $decode = json_decode($konten, true);
        $response = array();
        $response = array(
            'metadata' => array(
                'message' => 'Cooming Soon',
                'code' => 505
            )
        );
        echo json_encode($response);

    }

    private function _setUmur($tanggal)
    {
        list($cY, $cm, $cd) = explode('-', date('Y-m-d'));
        list($Y, $m, $d) = explode('-', date('Y-m-d', strtotime($tanggal)));
        $umur = $cY - $Y;
        return $umur;
    }

    private function _getToken()
    {
        $header = json_encode(['typ' => 'JWT', 'alg' => 'HS256']);
        $payload = json_encode(['username' => $this->options->get('jkn_mobile_fktp.username'), 'password' => $this->options->get('jkn_mobile_fktp.password'), 'date' => strtotime(date('Y-m-d')) * 1000]);
        $base64UrlHeader = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($header));
        $base64UrlPayload = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($payload));
        $signature = hash_hmac('sha256', $base64UrlHeader . "." . $base64UrlPayload, 'abC123!', true);
        $base64UrlSignature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($signature));
        $jwt = $base64UrlHeader . "." . $base64UrlPayload . "." . $base64UrlSignature;
        return $jwt;
    }
    private function _getErrors($error)
    {
        $errors = $error;
        return $errors;
    }
}
