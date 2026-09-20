<?php
namespace Plugins\Esignature;

use Systems\AdminModule;

class Admin extends AdminModule
{
    protected $assign = [];

    public function navigation()
    {
        return [
            'Kelola' => 'manage',
            'Pengaturan' => 'settings'
        ];
    }

    public function anyManage($page = 1)
    {
        $perpage = '10';
        $phrase = '';
        if (isset($_POST['s'])) {
            $phrase = $_POST['s'];
        }

        // pagination
        $totalRecords = $this->db('mlite_esignatures')
            ->like('signer_name', '%' . $phrase . '%')
            ->orLike('ref_id', '%' . $phrase . '%')
            ->toArray();
        $pagination = new \Systems\Lib\Pagination($page, count($totalRecords), $perpage, url([ADMIN, 'esignature', 'manage', '%d']));
        $this->assign['pagination'] = $pagination->nav('pagination', '5');
        $this->assign['totalRecords'] = count($totalRecords);

        $offset = $pagination->offset();
        $signatures = $this->db('mlite_esignatures')
            ->like('signer_name', '%' . $phrase . '%')
            ->orLike('ref_id', '%' . $phrase . '%')
            ->desc('id')
            ->offset($offset)
            ->limit($perpage)
            ->toArray();

        return $this->draw('manage.html', [
            'signatures' => htmlspecialchars_array($signatures),
            'pagination' => $this->assign['pagination'],
            'phrase' => $phrase
        ]);
    }

    public function getSettings()
    {
        if ($this->core->getUserInfo('role') != 'admin') {
            $this->notify('failure', 'Anda tidak memiliki hak akses untuk halaman ini.');
            redirect(url([ADMIN, 'esignature', 'manage']));
        }
        $master_berkas_digital = $this->db('master_berkas_digital')->toArray();
        return $this->draw('settings.html', ['settings' => $this->settings('esignature'), 'master_berkas_digital' => htmlspecialchars_array($master_berkas_digital)]);
    }

    public function postSettings()
    {
        if ($this->core->getUserInfo('role') != 'admin') {
            $this->notify('failure', 'Anda tidak memiliki hak akses untuk halaman ini.');
            redirect(url([ADMIN, 'esignature', 'manage']));
        }
        foreach ($_POST['esignature'] as $key => $val) {
            $this->settings('esignature', $key, $val);
        }
        $this->notify('success', 'Pengaturan telah disimpan');
        redirect(url([ADMIN, 'esignature', 'settings']));
    }

    public function getSign($ref_type, $ref_id)
    {
        // $this->core->addJS(url('plugins/esignature/assets/signature_pad.min.js'));
        // $this->core->addJS(url('plugins/esignature/assets/esignature.js'));

        $signer_role = 'dokter'; // Default for admin/staff
        $signer_id = $this->core->getUserInfo('username');
        $signer_name = $this->core->getUserInfo('fullname');

        // Logic to detect if patient (if this was a public portal or kiosk)
        // For now, assume logged in user is signing
        
        exit($this->draw('sign.html', [
            'ref_type' => $ref_type,
            'ref_id' => $ref_id,
            'signer_role' => $signer_role,
            'signer_id' => $signer_id,
            'signer_name' => $signer_name
        ]));
    }

    public function postSaveSignature()
    {
        // Disable error reporting for JSON response
        error_reporting(0);
        ini_set('display_errors', 0);
        
        // Clear buffer
        while (ob_get_level()) {
            ob_end_clean();
        }
        
        header('Content-Type: application/json');

        try {
            if (!isset($_POST['ref_type']) || !isset($_POST['ref_id']) || !isset($_POST['image_data'])) {
                throw new \Exception("Missing parameters");
            }

            $ref_type = $_POST['ref_type'];
            $ref_id = $_POST['ref_id'];
            $image_data = $_POST['image_data']; 
            
            $filename = 'sign_' . time() . '_' . uniqid() . '.png';
            $dir = WEBAPPS_PATH . '/berkas/esignature/';
            
            if (!file_exists($dir)) {
                if (!mkdir($dir, 0755, true)) {
                    throw new \Exception("Failed to create directory: $dir");
                }
            }

            if (!is_writable($dir)) {
                throw new \Exception("Directory not writable: $dir");
            }

            $path = $dir . $filename;
            $image_data = str_replace('data:image/png;base64,', '', $image_data);
            $image_data = str_replace(' ', '+', $image_data);
            
            if (file_put_contents($path, base64_decode($image_data)) === false) {
                 throw new \Exception("Failed to save image file");
            }

            $hash = hash_file('sha256', $path);

            $save = $this->db('mlite_esignatures')->save([
                'ref_type' => $ref_type,
                'ref_id' => $ref_id,
                'signer_role' => $_POST['signer_role'] ?? 'unknown',
                'signer_id' => $_POST['signer_id'] ?? 'unknown',
                'signer_name' => $_POST['signer_name'] ?? 'unknown',
                'signature_path' => $filename,
                'signature_hash' => $hash,
                'signed_at' => date('Y-m-d H:i:s'),
                'ip_address' => $_SERVER['REMOTE_ADDR'] ?? 'unknown',
                'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? 'unknown',
                'legal_basis' => 'UU ITE No 11 Tahun 2008',
                'audit_json' => json_encode([
                    'server' => $_SERVER,
                    'headers' => function_exists('apache_request_headers') ? apache_request_headers() : []
                ])
            ]);
            
            if (!$save) {
                 throw new \Exception("Database save failed");
            }

            echo json_encode(['status' => 'success', 'hash' => $hash]);

        } catch (\Exception $e) {
            http_response_code(500);
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
        
        exit;
    }

    public function getGeneratePdf($ref_type, $ref_id)
    {
        $signatures = $this->db('mlite_esignatures')
            ->where('ref_type', $ref_type)
            ->where('ref_id', $ref_id)
            ->toArray();
            
        $latest_sig = $this->db('mlite_esignatures')
            ->where('ref_type', $ref_type)
            ->where('ref_id', $ref_id)
            ->desc('id')
            ->oneArray();

        // Use mPDF (Standard in mLITE)
        $mpdf = new \Mpdf\Mpdf([
            'mode' => 'utf-8', 
            'format' => 'A4', 
            'margin_top' => 15,
            'margin_bottom' => 15,
            'margin_left' => 20,
            'margin_right' => 20
        ]);

        // Watermark
        // $mpdf->SetWatermarkText('SIGNED ELECTRONICALLY');
        $mpdf->showWatermarkText = true;
        $mpdf->watermark_font = 'DejaVuSansCondensed';
        $mpdf->watermarkTextAlpha = 0.05;

        // Check if this is a known surat type
        $surat_types = ['surat.sakit', 'surat.rujukan', 'surat.sehat', 'resep'];
        if (in_array($ref_type, $surat_types)) {
            if ($ref_type == 'resep') {
                $resep_obat = $this->db('resep_obat')->where('no_resep', $ref_id)->oneArray();
                $no_rawat = $resep_obat['no_rawat'];
                $no_resep = $ref_id;
                $kd_dokter = $resep_obat['kd_dokter'];
                $tanggal = dateIndonesia($resep_obat['tgl_peresepan']);
                
                // Get detail (non-racikan and racikan)
                $detail = [];
                
                // Non-racikan
                $rows_obat = $this->db('resep_dokter')
                    ->join('databarang', 'databarang.kode_brng=resep_dokter.kode_brng')
                    ->where('no_resep', $no_resep)
                    ->toArray();
                foreach ($rows_obat as $row) {
                    $detail[] = [
                        'nama_brng' => $row['nama_brng'],
                        'jml' => $row['jml'],
                        'satuan' => $this->db('kodesatuan')->where('kode_sat', $row['kode_sat'])->oneArray()['satuan'] ?? '',
                        'aturan_pakai' => $row['aturan_pakai']
                    ];
                }
                
                // Racikan
                $rows_racikan = $this->db('resep_dokter_racikan')
                    ->where('no_resep', $no_resep)
                    ->toArray();
                foreach ($rows_racikan as $row) {
                    $detail[] = [
                        'nama_brng' => $row['nama_racik'],
                        'jml' => $row['jml_dr'],
                        'satuan' => 'Racik',
                        'aturan_pakai' => $row['aturan_pakai']
                    ];
                }
                
                $this->tpl->set('no_resep', $no_resep);
                $this->tpl->set('tanggal', $tanggal);
                $this->tpl->set('detail', $detail);
            } else {
                $no_rawat = revertNoRawat($ref_id);
                $kd_dokter = $this->core->getRegPeriksaInfo('kd_dokter', $no_rawat);
            }
            
            $no_rkm_medis = $this->core->getRegPeriksaInfo('no_rkm_medis', $no_rawat);
            
            $pasien = $this->db('pasien')
              ->join('kelurahan', 'kelurahan.kd_kel=pasien.kd_kel')
              ->join('kecamatan', 'kecamatan.kd_kec=pasien.kd_kec')
              ->join('kabupaten', 'kabupaten.kd_kab=pasien.kd_kab')
              ->join('propinsi', 'propinsi.kd_prop=pasien.kd_prop')
              ->where('no_rkm_medis', $no_rkm_medis)
              ->oneArray();
            
            $kd_pj = $this->core->getRegPeriksaInfo('kd_pj', $no_rawat);
            $penjab = $this->db('penjab')->where('kd_pj', $kd_pj)->oneArray();
            
            $nm_dokter = $this->core->getPegawaiInfo('nama', $kd_dokter);
            $sip_dokter = $this->core->getDokterInfo('no_ijn_praktek', $kd_dokter);
            
            if ($ref_type != 'resep') {
                $table_map = [
                    'surat.sakit' => 'mlite_surat_sakit',
                    'surat.rujukan' => 'mlite_surat_rujukan',
                    'surat.sehat' => 'mlite_surat_sehat'
                ];
                $surat_data = $this->db($table_map[$ref_type])->where('no_rawat', $no_rawat)->oneArray();
                $this->tpl->set('surat', $surat_data);
            }
            
            $this->tpl->set('pasien', $this->tpl->noParse_array(htmlspecialchars_array($pasien)));
            $this->tpl->set('penjab', $penjab);
            $this->tpl->set('nm_dokter', $nm_dokter);
            $this->tpl->set('sip_dokter', $sip_dokter);
            $this->tpl->set('no_rawat', $no_rawat);
            $this->tpl->set('settings', $this->tpl->noParse_array(htmlspecialchars_array($this->settings('settings'))));
            $this->tpl->set('esignature', $latest_sig);
            
            $template_file = MODULES.'/esignature/view/admin/templates/'.($ref_type == 'resep' ? 'resep' : $ref_type).'.html';
            $html = $this->tpl->draw($template_file, true);
        } else {
            // Original generic logic + FALLBACK OTOMATIS GENERATE KONTEN ERM JIKA FILE TIDAK ADA
            $html = '
            <style>
                body { font-family: sans-serif; }
                .header { text-align: center; border-bottom: 2px solid #000; padding-bottom: 10px; margin-bottom: 20px; }
                .content { margin-bottom: 30px; }
                .signature-box { border: 1px solid #ccc; padding: 10px; display: inline-block; width: 45%; margin: 5px; vertical-align: top; }
                .footer { border-top: 1px solid #ccc; margin-top: 10px; padding-top: 10px; font-size: 0.8em; color: #666; }
                table td, table th { padding: 5px; }
                .tbl_form { border-collapse: collapse; width: 100%; }
                .tbl_form td { border: 1px solid #000; padding: 6px 8px; vertical-align: top; }
                .tbl_form td.label { width: 25%; background: #f5f5f5; font-weight: bold; }
                .tbl_form td.value { width: 75%; }
                .section-title { font-size: 1.1em; font-weight: bold; margin: 18px 0 8px; padding: 6px 10px; background: #eef3fb; border-left: 4px solid #2a6ebb; color: #1e3a5f; }
                .meta-info { color: #666; font-size: 0.9em; font-style: italic; }
                h1.title-hospital { font-size: 22px; text-align: center; margin: 0 0 3px; }
                .sub-hospital { text-align: center; font-size: 12px; color: #555; margin: 0 0 10px; }
            </style>
            
            <div class="content">';
            
            // Load external content
            $contentFile = WEBAPPS_PATH . '/../admin/tmp/'.$ref_type.'.html';
            if (file_exists($contentFile)) {
                $rawContent = file_get_contents($contentFile);
                $rawContent = preg_replace('/<del>.*?<\/del>/s', '', $rawContent);
                $rawContent = preg_replace('/<div class="modal-header">.*?<\/div>/s', '', $rawContent);
                $rawContent = preg_replace('/<div class="modal-footer">.*?<\/div>/s', '', $rawContent);
                $rawContent = preg_replace('/<a.*?class="btn.*?>.*?<\/a>/s', '', $rawContent);
                $html .= $rawContent;
            } elseif (method_exists($this, '_buildFallbackErmPdfContent') && $this->_isNoRawatConverted($ref_type, $ref_id)) {
                // === FALLBACK UTAMA: Auto-generate KONTEN ERM PDF dari Database ===
                $fallback = $this->_buildFallbackErmPdfContent($ref_id);
                if (!empty($fallback)) {
                    $html .= $fallback;
                } else {
                    $html .= '<p class="meta-info">Data rekam medis untuk kunjungan ini sedang dalam proses pemutakhiran. Lampiran di bawah ini memuat tanda tangan elektronik yang sah dan dapat diverifikasi.</p>';
                }
            } else {
                $html .= '<p class="meta-info">Konten dokumen untuk ref_type=<b>'.htmlspecialchars($ref_type).'</b> / ref_id=<b>'.htmlspecialchars($ref_id).'</b> belum di-upload. Tanda tangan elektronik yang terlampir di bawah ini tetap berlaku dan dapat diverifikasi sesuai UU ITE No 11 Tahun 2008.</p>';
            }

            $html .= '</div>
            <div class="signer">
            <h3>Tanda Tangan Elektronik:</h3>
            <div style="width: 100%;">';

            // === DEDUPLIKASI SIGNATURE: 1 (nama, jabatan) = 1 tampilan TERBARU ===
            // Masalah: dr. Ataaka Muhammad bisa menandatangani dokumen yang sama BERULANG KALI
            // (setiap klik "bubuhkan tanda tangan" tambah 1 row DB). Loop semua signatures
            // menyebabkan QR Code TAMPIL 13 KALI (duplikat). Solusi: ambil TERBARU per
            // kombinasi (signer_name + '|' + signer_role).
            $uniqueSigs = [];
            foreach ($signatures as $s) {
                $sigKey = trim(($s['signer_name'] ?? '')) . '|' . trim(($s['signer_role'] ?? ''));
                $uniqueSigs[$sigKey] = $s; // overwrite otomatis = simpan YANG TERBARU (urutan id ASC)
            }
            // Kembalikan ke array numerik agar mudah di-loop
            $signaturesToRender = array_values($uniqueSigs);

            foreach ($signaturesToRender as $sig) {
                $path = WEBAPPS_PATH . '/berkas/esignature/' . $sig['signature_path'];
                $verifyUrl = url(['esignature', 'verify', $sig['signature_hash']]);

                if (file_exists($path)) {
                    $html .= '
                    <div class="signature-box">
                        <table width="100%">
                            <tr>
                                <td width="60%" align="center">
                                    <img src="'.$path.'" height="60" /><br>
                                    <strong>'.$sig['signer_name'].'</strong><br>
                                    <small>'.$sig['signer_role'].'</small><br>
                                    <small>'.date('d-m-Y H:i', strtotime($sig['signed_at'])).'</small>
                                </td>
                                <td width="40%" align="center">
                                    <barcode code="'.$verifyUrl.'" type="QR" class="barcode" size="0.7" error="M" disableborder="1" />
                                    <br>
                                    <small>Verify</small>
                                </td>
                            </tr>
                        </table>
                    </div>';
                }
            }
            $html .= '</div></div>';
        }

        $mpdf->shrink_tables_to_fit = 1;
        $mpdf->use_kwt = true;
        $mpdf->WriteHTML($html);

        $mpdf->SetHTMLFooter('
        <p style="font-size: 8px; color: #888;">
            Dokumen ini resmi dan telah ditandatangani secara elektronik sesuai dengan UU ITE No 11 Tahun 2008.
        </p>
        <div class="footer">
            <table width="100%">
                <tr>
                    <td width="50%">Dicetak pada: '.date('d-m-Y H:i').'</td>
                    <td width="50%" align="right">Halaman {PAGENO} dari {nbpg}</td>
                </tr>
            </table>
        </div>');

        $uploadDir = WEBAPPS_PATH . '/berkasrawat/pages/upload/';
        if (!file_exists($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }

        $timestamp = date('YmdHis');
        $fileName = 'doc_'.$ref_id.'_'.$timestamp.'.pdf';
        $filePath = $uploadDir . $fileName;

        $mpdf->Output($filePath, 'F');

        if (file_exists($filePath)) {
            $this->db('berkas_digital_perawatan')->save([
                'no_rawat' => (isset($no_rawat) ? $no_rawat : revertNoRawat($ref_id)),
                'kode' => $this->settings('esignature', 'kode_berkasdigital'),
                'lokasi_file' => 'pages/upload/' . $fileName
            ]);
        }

        $mpdf->Output($fileName, 'I');
        exit;
    }

    /**
     * Detector: Apakah ($ref_type, $ref_id) adalah rujukan ke no_rawat format convertNorawat()
     * (numeric 12-16 digit = Ymd + counter 6 digit, contoh: 20260901000001)
     */
    private function _isNoRawatConverted($ref_type, $ref_id)
    {
        if ($ref_type !== 'pdf') {
            return false;
        }
        if (!is_string($ref_id) || strlen($ref_id) < 12 || strlen($ref_id) > 18) {
            return false;
        }
        if (!ctype_digit($ref_id)) {
            return false;
        }
        $no_rawat = @revertNoRawat($ref_id);
        if (empty($no_rawat)) {
            return false;
        }
        $row = $this->db('reg_periksa')->where('no_rawat', $no_rawat)->oneArray();
        return !empty($row);
    }

    /**
     * FALLBACK GENERATOR KONTEN PDF ERM OTOMATIS DARI DATABASE
     * Digunakan ketika file admin/tmp/<ref_type>.html TIDAK ADA (pesan "Konten tidak ditemukan" lama).
     * Hasil HTML = identitas RS → Identitas Pasien → Riwayat Perawatan →  Diagnosis → Tindakan → Resep → Lab → Radiologi → Resume
     * Mengembalikan string HTML untuk disisipkan ke $html sebelum block tanda tangan.
     */
    private function _buildFallbackErmPdfContent($ref_id_converted)
    {
        $no_rawat = @revertNoRawat($ref_id_converted);
        if (empty($no_rawat)) {
            return '';
        }
        $reg = $this->db('reg_periksa')
            ->join('pasien', 'pasien.no_rkm_medis=reg_periksa.no_rkm_medis')
            ->join('dokter', 'dokter.kd_dokter=reg_periksa.kd_dokter')
            ->join('poliklinik', 'poliklinik.kd_poli=reg_periksa.kd_poli')
            ->join('penjab', 'penjab.kd_pj=reg_periksa.kd_pj')
            ->where('no_rawat', $no_rawat)
            ->oneArray();
        if (empty($reg)) {
            return '';
        }

        $settings_rs = $this->settings('settings');
        $nama_rs = htmlspecialchars($settings_rs['nama_instansi'] ?? 'Rumah Sakit', ENT_QUOTES, 'UTF-8');
        $alamat_rs = htmlspecialchars($settings_rs['alamat_instansi'] ?? '', ENT_QUOTES, 'UTF-8');
        $telp_rs = htmlspecialchars(trim(($settings_rs['kota_instansi'] ?? '').' · Telp. '.($settings_rs['telp_instansi'] ?? '')), ENT_QUOTES, 'UTF-8');

        $e = function ($v, $alt='-') use (&$reg) {
            $val = $reg[$v] ?? null;
            return htmlspecialchars($val !== null && $val !== '' ? $val : $alt, ENT_QUOTES, 'UTF-8');
        };
        $tgl_periksa = $e('tgl_registrasi').' '.($reg['jam_reg'] ?? '00:00');
        $umur = '';
        if (!empty($reg['tgl_lahir'])) {
            $lahir = \DateTime::createFromFormat('Y-m-d', $reg['tgl_lahir']) ?: null;
            if ($lahir) {
                $today = new \DateTime(isset($reg['tgl_registrasi']) ? $reg['tgl_registrasi'] : 'now');
                $diff = $today->diff($lahir);
                $umur = trim($diff->y.' Thn '.$diff->m.' Bln '.$diff->d.' Hr');
            }
        }

        // --- Data diagnosis, tindakan, resep, lab, radiologi ---
        $rows_dx = $this->db('diagnosa_pasien')
            ->join('penyakit', 'penyakit.kd_penyakit=diagnosa_pasien.kd_penyakit')
            ->where('no_rawat', $no_rawat)
            ->asc('prioritas')
            ->toArray();
        $rows_tindakan = $this->db('prosedur_pasien')
            ->join('icd9', 'icd9.kode=prosedur_pasien.kode')
            ->where('no_rawat', $no_rawat)
            ->asc('prioritas')
            ->toArray();
        if (empty($rows_tindakan)) {
            $rows_tindakan = $this->db('rawat_jl_dr')
                ->join('jns_perawatan', 'jns_perawatan.kd_jenis_prw=rawat_jl_dr.kd_jenis_prw')
                ->join('dokter', 'dokter.kd_dokter=rawat_jl_dr.kd_dokter')
                ->where('no_rawat', $no_rawat)
                ->toArray();
        }
        $rows_resep = [];
        $resep = $this->db('resep_obat')->where('no_rawat', $no_rawat)->oneArray();
        if (!empty($resep)) {
            $rows_resep = $this->db('resep_dokter')
                ->join('databarang', 'databarang.kode_brng=resep_dokter.kode_brng')
                ->where('no_resep', $resep['no_resep'])
                ->toArray();
        }
        $rows_lab = $this->db('periksa_lab')
            ->join('jns_perawatan_lab', 'jns_perawatan_lab.kd_jenis_prw=periksa_lab.kd_jenis_prw')
            ->where('no_rawat', $no_rawat)
            ->toArray();
        $rows_rad = $this->db('periksa_radiologi')
            ->join('jns_perawatan_radiologi', 'jns_perawatan_radiologi.kd_jenis_prw=periksa_radiologi.kd_jenis_prw')
            ->where('no_rawat', $no_rawat)
            ->toArray();
        $pemeriksaan_ralan = $this->db('pemeriksaan_ralan')->where('no_rawat', $no_rawat)->oneArray() ?? [];
        $resume = $this->db('resume_pasien')->where('no_rawat', $no_rawat)->oneArray() ?? [];

        $tdSection = function ($lbl, $val) {
            $lblHtml = htmlspecialchars($lbl, ENT_QUOTES, 'UTF-8');
            $valHtml = $val === '' || $val === null ? '-' : $val;
            if (!is_string($valHtml)) { $valHtml = (string)$valHtml; }
            if (strpos($valHtml, '<') === false) {
                $valHtml = htmlspecialchars($valHtml, ENT_QUOTES, 'UTF-8');
            }
            return '<tr><td class="label">'.$lblHtml.'</td><td class="value">'.$valHtml.'</td></tr>';
        };
        $sec = function ($t) { return '<div class="section-title">'.htmlspecialchars($t, ENT_QUOTES, 'UTF-8').'</div>'; };

        $html5 = '<h1 class="title-hospital">'.$nama_rs.'</h1>';
        $html5 .= '<div class="sub-hospital">'.($alamat_rs ? rtrim($alamat_rs, '.').' · ' : '').$telp_rs.'</div>';
        $html5 .= '<hr>';
        $html5 .= '<div style="display:table;width:100%;"><div style="display:table-cell;width:70%;"><b style="font-size:16px;">Rekam Medis Rawat Jalan</b></div>';
        $html5 .= '<div style="display:table-cell;width:30%;text-align:right;">Tanggal Cetak: <b>'.htmlspecialchars(dateIndonesia(date('Y-m-d')).' '.date('H:i')).'</b></div></div>';

        $html5 .= $sec('1. Identitas Pasien & Kunjungan');
        $html5 .= '<table class="tbl_form"><tbody>';
        $html5 .= $tdSection('No. Rawat', $e('no_rawat'));
        $html5 .= $tdSection('No. Rekam Medis', $e('no_rkm_medis'));
        $html5 .= $tdSection('Nama Pasien', $e('nm_pasien'));
        $html5 .= $tdSection('No. Identitas (KTP/BPJS)', ($e('no_ktp', '-').' · No. BPJS: '.$e('no_peserta', '-')));
        $html5 .= $tdSection('Jenis Kelamin / Umur', ($e('jk', '-').' / '.($umur ?: '-')));
        $html5 .= $tdSection('Tempat, Tgl. Lahir', ($e('tempat_lahir').', '.($e('tgl_lahir')?dateIndonesia($e('tgl_lahir')):'-')));
        $html5 .= $tdSection('Alamat Lengkap', ($e('alamat').' RT/RW '.($reg['rt'] ?? '00').'/'.($reg['rw'] ?? '00').' · Kel. '.$e('nm_kel').' · Kec. '.$e('nm_kec').' · '.$e('nm_kab').' · '.$e('nm_prop')));
        $html5 .= $tdSection('Pekerjaan / Pendidikan / Agama / Suku', ($e('pekerjaan').' / '.$e('pnd').' / '.$e('agama').' / '.$e('suku')));
        $html5 .= $tdSection('Nama Orang Tua / Keluarga / PJ', ($e('nama_ibu').' · '.$e('namakeluarga').' / '.$e('png_jawab')));
        $html5 .= $tdSection('Bahasa / Status / HP', ($e('bahasa').' · '.$e('stts_nikah').' · HP: '.$e('no_tlp')));
        $html5 .= '</tbody></table>';

        $html5 .= $sec('2. Data Kunjungan Poliklinik & DPJP');
        $html5 .= '<table class="tbl_form"><tbody>';
        $html5 .= $tdSection('Tanggal & Jam Registrasi', $tgl_periksa);
        $html5 .= $tdSection('Poliklinik Tujuan', $e('nm_poli'));
        $html5 .= $tdSection('Cara Bayar / Penjamin', $e('png_jawab'));
        $html5 .= $tdSection('DPJP / Dokter Pemeriksa', $e('nm_dokter').($e('no_ijn_praktek', '') !== '-' && trim($e('no_ijn_praktek','')) !== '' ? ' (SIP: '.$e('no_ijn_praktek').')' : ''));
        $html5 .= $tdSection('Status Lanjut Kunjungan', $e('status_lanjut'));
        $html5 .= '</tbody></table>';

        if (!empty($pemeriksaan_ralan) || !empty($resume['keluhan_utama'])) {
            $html5 .= $sec('3. Anamnesa & Pemeriksaan Fisik');
            $html5 .= '<table class="tbl_form"><tbody>';
            $keluhan = $resume['keluhan_utama'] ?? ($pemeriksaan_ralan['keluhan_utama'] ?? '');
            $html5 .= $tdSection('Keluhan Utama', $keluhan);
            $rps = $resume['rps'] ?? '';
            $alergi = $pemeriksaan_ralan['alergi'] ?? '-';
            $html5 .= $tdSection('Riwayat Penyakit Sekarang / Alergi', $rps.' · Alergi: '.$alergi);
            $tensi = $pemeriksaan_ralan['tensi'] ?? '-';
            $nadi = $pemeriksaan_ralan['nadi'] ?? '-';
            $respirasi = $pemeriksaan_ralan['respirasi'] ?? '-';
            $suhu = $pemeriksaan_ralan['suhu'] ?? '-';
            $berat = $pemeriksaan_ralan['berat'] ?? '-';
            $tinggi = $pemeriksaan_ralan['tinggi'] ?? '-';
            $tandaVital = $tensi.' mmHg · Nadi: '.$nadi.'/mnt · RR: '.$respirasi.'/mnt · Suhu: '.$suhu.' C · BB: '.$berat.' Kg · TB: '.$tinggi.' Cm';
            $html5 .= $tdSection('Tanda Vital (TD / Nadi / RR / Suhu / BB / TB)', $tandaVital);
            $kesadaran = $pemeriksaan_ralan['kesadaran'] ?? '-';
            $gcs = $pemeriksaan_ralan['gcs'] ?? '-';
            $html5 .= $tdSection('Kesadaran / GCS', $kesadaran.' · GCS: '.$gcs);
            $h2t = $pemeriksaan_ralan['pemeriksaan'] ?? ($resume['pemeriksaan_fisik'] ?? '');
            $html5 .= $tdSection('Pemeriksaan Fisik Head-to-Toe / Status Lokalis', $h2t);
            $html5 .= '</tbody></table>';
        }

        if (!empty($rows_dx)) {
            $html5 .= $sec('4. Diagnosis (ICD-10)');
            $html5 .= '<table class="tbl_form"><thead style="background:#eef3fb;"><tr><th style="border:1px solid #000;width:8%;padding:5px;">Prioritas</th><th style="border:1px solid #000;width:22%;padding:5px;">Kode ICD-10</th><th style="border:1px solid #000;width:70%;padding:5px;">Nama Diagnosis</th></tr></thead><tbody>';
            foreach ($rows_dx as $dx) {
                $html5 .= '<tr><td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($dx['prioritas'] ?? ($dx['status_penyakit'] ?? '-'), ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;font-weight:bold;">'.htmlspecialchars($dx['kd_penyakit'] ?? '', ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($dx['nm_penyakit'] ?? '', ENT_QUOTES, 'UTF-8').'</td></tr>';
            }
            $html5 .= '</tbody></table>';
        }
        if (!empty($rows_tindakan)) {
            $html5 .= $sec('5. Tindakan Medis & Prosedur (ICD-9 CM)');
            $html5 .= '<table class="tbl_form"><thead style="background:#eef3fb;"><tr><th style="border:1px solid #000;width:8%;padding:5px;">No</th><th style="border:1px solid #000;width:22%;padding:5px;">Kode ICD-9 / Jenis</th><th style="border:1px solid #000;width:55%;padding:5px;">Nama Tindakan / Prosedur</th><th style="border:1px solid #000;width:15%;padding:5px;">Petugas</th></tr></thead><tbody>';
            $i = 0;
            foreach ($rows_tindakan as $tx) {
                $i++;
                $kd = $tx['kode'] ?? ($tx['kd_jenis_prw'] ?? '');
                $nm = $tx['deskripsi_panjang'] ?? ($tx['deskripsi_pendek'] ?? ($tx['nama_perawatan'] ?? ''));
                $pet = $tx['nm_dokter'] ?? ($tx['nip'] ?? '-');
                $html5 .= '<tr><td style="border:1px solid #000;padding:5px;">'.$i.'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;font-weight:bold;">'.htmlspecialchars($kd, ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($nm, ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($pet, ENT_QUOTES, 'UTF-8').'</td></tr>';
            }
            $html5 .= '</tbody></table>';
        }
        if (!empty($rows_resep)) {
            $html5 .= $sec('6. Peresepan Obat & Racikan');
            $html5 .= '<table class="tbl_form"><thead style="background:#eef3fb;"><tr><th style="border:1px solid #000;width:8%;padding:5px;">No</th><th style="border:1px solid #000;width:44%;padding:5px;">Nama Obat</th><th style="border:1px solid #000;width:12%;padding:5px;">Jumlah</th><th style="border:1px solid #000;width:36%;padding:5px;">Aturan Pakai</th></tr></thead><tbody>';
            $i = 0;
            foreach ($rows_resep as $rx) {
                $i++;
                $nama = $rx['nama_brng'] ?? '';
                $jml = ($rx['jml'] ?? '0').' '.($rx['kode_sat'] ?? ($rx['satuan'] ?? ''));
                $aturan = $rx['aturan_pakai'] ?? '';
                $html5 .= '<tr><td style="border:1px solid #000;padding:5px;">'.$i.'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($nama, ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($jml, ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($aturan, ENT_QUOTES, 'UTF-8').'</td></tr>';
            }
            $html5 .= '</tbody></table>';
        }
        if (!empty($rows_lab)) {
            $html5 .= $sec('7. Hasil Pemeriksaan Laboratorium');
            $html5 .= '<table class="tbl_form"><thead style="background:#eef3fb;"><tr><th style="border:1px solid #000;width:30%;padding:5px;">Pemeriksaan Lab</th><th style="border:1px solid #000;width:15%;padding:5px;">Tgl/Jam</th><th style="border:1px solid #000;width:25%;padding:5px;">Hasil</th><th style="border:1px solid #000;width:15%;padding:5px;">Satuan</th><th style="border:1px solid #000;width:15%;padding:5px;">Nilai Rujukan</th></tr></thead><tbody>';
            foreach ($rows_lab as $lb) {
                $html5 .= '<tr><td style="border:1px solid #000;padding:5px;">'.htmlspecialchars(($lb['nm_perawatan'] ?? $lb['jenis_perawatan'] ?? ''), ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars(($lb['tgl_periksa'] ?? '-').' '.($lb['jam'] ?? ''), ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;font-weight:bold;">'.htmlspecialchars($lb['nilai_normal'] ?? ($lb['hasil'] ?? '-'), ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($lb['satuan'] ?? '', ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($lb['nilai_rujukan'] ?? '', ENT_QUOTES, 'UTF-8').'</td></tr>';
            }
            $html5 .= '</tbody></table>';
        }
        if (!empty($rows_rad)) {
            $html5 .= $sec('8. Hasil Pemeriksaan Radiologi');
            $html5 .= '<table class="tbl_form"><thead style="background:#eef3fb;"><tr><th style="border:1px solid #000;width:30%;padding:5px;">Pemeriksaan Radiologi</th><th style="border:1px solid #000;width:18%;padding:5px;">Tgl/Jam</th><th style="border:1px solid #000;width:52%;padding:5px;">Hasil / Kesan</th></tr></thead><tbody>';
            foreach ($rows_rad as $rd) {
                $html5 .= '<tr><td style="border:1px solid #000;padding:5px;">'.htmlspecialchars(($rd['nm_perawatan'] ?? $rd['jenis_perawatan'] ?? ''), ENT_QUOTES, 'UTF-8').'</td>';
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars(($rd['tgl_periksa'] ?? '-').' '.($rd['jam'] ?? ''), ENT_QUOTES, 'UTF-8').'</td>';
                $hasil_rad = $this->db('hasil_radiologi')->where('no_rawat', $no_rawat)->where('tgl_periksa', $rd['tgl_periksa'] ?? null)->where('jam', $rd['jam'] ?? null)->oneArray();
                $kesan = $hasil_rad['kesan'] ?? ($hasil_rad['hasil'] ?? '-');
                $html5 .= '<td style="border:1px solid #000;padding:5px;">'.htmlspecialchars($kesan, ENT_QUOTES, 'UTF-8').'</td></tr>';
            }
            $html5 .= '</tbody></table>';
        }
        if (!empty($resume) || !empty($reg['hubungi'])) {
            $html5 .= $sec('9. Resume Medis, Instruksi Pulang & Tindak Lanjut');
            $html5 .= '<table class="tbl_form"><tbody>';
            $html5 .= $tdSection('Diagnosa Akhir / Ringkasan Klinis', ($resume['diagnosa_akhir'] ?? ($resume['keluhan_utama'] ?? '')));
            $html5 .= $tdSection('Terapi / Pengobatan yang Diberikan', ($resume['pengobatan'] ?? ($resume['therapy'] ?? '')));
            $html5 .= $tdSection('Instruksi / Konseling / Diet / Edukasi Pasien', ($resume['konseling'] ?? ($reg['hubungi'] ?? '')));
            $html5 .= $tdSection('Prognosis & Tindak Lanjut Kontrol Kembali', ($resume['prognosa'] ?? ($resume['rencana_tindak_lanjut'] ?? '-')));
            $html5 .= '</tbody></table>';
        }

        return $html5;
    }
}
