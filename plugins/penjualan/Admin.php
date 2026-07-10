<?php
namespace Plugins\Penjualan;

use Systems\AdminModule;
use Systems\Lib\QRCode;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

class Admin extends AdminModule
{

    public function navigation()
    {
        return [
            'Kelola'   => 'manage',
            'Penjualan' => 'index',
            'Order Baru' => 'order',
            'Laporan' => 'laporan',
        ];
    }

    public function getManage()
    {
      $sub_modules = [
        ['name' => 'Penjualan', 'url' => url([ADMIN, 'penjualan', 'index']), 'icon' => 'money', 'desc' => 'Data Penjualan'],
        ['name' => 'Order Baru', 'url' => url([ADMIN, 'penjualan', 'order']), 'icon' => 'cart-plus', 'desc' => 'Data Penjualan'],
        ['name' => 'Laporan', 'url' => url([ADMIN, 'penjualan', 'laporan']), 'icon' => 'money', 'desc' => 'Laporan Penjualan'],
      ];
      return $this->draw('manage.html', ['sub_modules' => htmlspecialchars_array($sub_modules)]);
    }

    public function getIndex()
    {
        $this->_addHeaderFiles();

        $tanggal_awal  = isset($_GET['tanggal_awal'])  ? $_GET['tanggal_awal']  : '';
        $tanggal_akhir = isset($_GET['tanggal_akhir']) ? $_GET['tanggal_akhir'] : '';
        $status_filter = isset($_GET['status'])        ? $_GET['status']        : '';

        $rows = $this->db('mlite_penjualan')->desc('id')->toArray();

        $penjualan = [];
        $no = 1;
        foreach($rows as $row) {

            // filter tanggal (dari - sampai)
            if ($tanggal_awal !== '' && $row['tanggal'] < $tanggal_awal) {
                continue;
            }
            if ($tanggal_akhir !== '' && $row['tanggal'] > $tanggal_akhir) {
                continue;
            }

            $mlite_penjualan_billing = $this->db('mlite_penjualan_billing')->where('id_penjualan', $row['id'])->desc('id')->oneArray();

            $row['total'] = 'Belum Bayar';
            $row['keterangan_bayar'] = 'Belum Bayar';

            if (!empty($mlite_penjualan_billing)) {
                if (!empty($mlite_penjualan_billing['keterangan'])) {
                    $row['keterangan_bayar'] = $mlite_penjualan_billing['keterangan'];
                } elseif (!empty($mlite_penjualan_billing['jumlah_bayar'])) {
                    $row['keterangan_bayar'] = 'Sudah Bayar';
                }
                if (!empty($mlite_penjualan_billing['jumlah_bayar'])) {
                    $row['total'] = $mlite_penjualan_billing['jumlah_bayar'];
                }
            }

            $row['status_bayar'] = ($row['keterangan_bayar'] === 'Belum Bayar') ? 'Belum Bayar' : 'Sudah Bayar';

            // filter status bayar
            if ($status_filter !== '' && $row['status_bayar'] !== $status_filter) {
                continue;
            }

            $row['no'] = $no++;
            $penjualan[] = $row;
        }

        return $this->draw('index.html', [
            'penjualan'     => $penjualan,
            'tanggal_awal'  => htmlspecialchars($tanggal_awal),
            'tanggal_akhir' => htmlspecialchars($tanggal_akhir),
            'status_filter' => htmlspecialchars($status_filter),
        ]);
    }

    public function getOrder($id_penjualan = '')
    {
      $this->_addHeaderFiles();
      $penjualan = [];
      $rincian_penjualan = [];
      $total_tagihan = 0;
      if($id_penjualan) {
        $penjualan = $this->db('mlite_penjualan')->where('id', $id_penjualan)->oneArray();
        $rows = $this->db('mlite_penjualan_detail')->where('id_penjualan', $id_penjualan)->toArray();
        $no = 1;
        $total_tagihan = 0;
        foreach($rows as $row) {
          $row['no'] = $no++;
          $total_tagihan += $row['harga_total'];
          $rincian_penjualan[] = $row;
        }
      }

      // ID Penjualan otomatis: kalau order baru (belum ada id), tampilkan preview nomor berikutnya
      // (nomor sebenarnya baru dibuat di postSimpanPenjualan via auto increment, ini hanya preview)
      $id_penjualan_tampil = $id_penjualan;
      if (!$id_penjualan) {
        $last = $this->db('mlite_penjualan')->desc('id')->toArray();
        $id_penjualan_tampil = !empty($last[0]['id']) ? ($last[0]['id'] + 1) : 1;
      }

      $obat = $this->db('gudangbarang')->join('databarang', 'databarang.kode_brng = gudangbarang.kode_brng')
      ->select([
        'id' => 'gudangbarang.kode_brng', 
        'nama_barang' => 'databarang.nama_brng', 
        'stok' => 'gudangbarang.stok', 
        'harga' => 'databarang.dasar'
      ])
      ->where('kd_bangsal', $this->settings->get('farmasi.obatluar'))
      ->toArray();
      $barang = $this->db('mlite_penjualan_barang')
      ->select([
        'id' => 'id', 
        'nama_barang' => 'nama_barang', 
        'stok' => 'stok', 
        'harga' => 'harga'
      ])
      ->toArray();
      return $this->draw('order.html', [
        'barang' => array_merge($barang, $obat),
        'penjualan' => $penjualan,
        'rincian_penjualan' => $rincian_penjualan,
        'total_tagihan' => $total_tagihan,
        'id_penjualan' => isset_or($id_penjualan, ''),
        'id_penjualan_tampil' => $id_penjualan_tampil,
      ]);
    }

    public function getBarang()
    {
        $this->_addHeaderFiles();
        $obat = $this->db('gudangbarang')->join('databarang', 'databarang.kode_brng = gudangbarang.kode_brng')
        ->select([
          'id' => 'gudangbarang.kode_brng', 
          'nama_barang' => 'databarang.nama_brng', 
          'stok' => 'gudangbarang.stok', 
          'harga' => 'databarang.dasar'
        ])
        ->where('kd_bangsal', $this->settings->get('farmasi.obatluar'))
        ->toArray();        
        return $this->draw('barang.html', ['barang' => $this->db('mlite_penjualan_barang')->toArray(), 'obat' => htmlspecialchars_array($obat)]);
    }

  
    public function getLaporan()
    {

    }

    public function getSettings()
    {
        if ($this->core->getUserInfo('role') != 'admin') {
            $this->notify('failure', 'Anda tidak memiliki hak akses untuk halaman ini.');
            redirect(url([ADMIN, 'penjualan', 'index']));
        }

    }

    public function postSimpanPenjualan()
    {
        if (empty($_POST['id_barang'])) {
            echo 'ERROR_BARANG';
            exit();
        }
        if (empty($_POST['jumlah']) || !is_numeric($_POST['jumlah']) || intval($_POST['jumlah']) <= 0) {
            echo 'ERROR_JUMLAH';
            exit();
        }

        $tanggal = !empty($_POST['tanggal']) ? $_POST['tanggal'] : date('Y-m-d');
        $jam = !empty($_POST['jam']) ? $_POST['jam'] : date('H:i:s');

        $barang = $this->db('databarang')->select(['harga' => 'dasar'])->where('kode_brng', $_POST['id_barang'])->oneArray();

        if (empty($barang['harga'])) {
            echo 'ERROR_HARGA';
            exit();
        }

        $harga_total = $barang['harga'] * $_POST['jumlah'];
        if(isset($_POST['id']) && $_POST['id'] !='') {
            $detail = $this->db('mlite_penjualan_detail')
            ->save([
                'id_penjualan' => $_POST['id'], 
                'id_barang' => $_POST['id_barang'], 
                'nama_barang' => $_POST['nama_barang'], 
                'harga' => $barang['harga'], 
                'jumlah' => $_POST['jumlah'], 
                'harga_total' => $harga_total, 
                'tanggal' => $tanggal, 
                'jam' => $jam, 
                'id_user' => $this->core->getUserInfo('username', null, true) 
            ]);
            echo htmlspecialchars($_POST['id']);
            if($detail) {
                $mlite_penjualan_barang = $this->db('mlite_penjualan_barang')->where('id', $_POST['id_barang'])->oneArray();
                if($mlite_penjualan_barang) {
                  $this->db('mlite_penjualan_barang')->where('id', $_POST['id_barang'])->update(['stok' => $mlite_penjualan_barang['stok'] - $_POST['jumlah']]);
                } else {
                  $gudangbarang = $this->db('gudangbarang')->where('kode_brng', $_POST['id_barang'])->where('kd_bangsal', $this->settings->get('farmasi.obatluar'))->oneArray();
                  $this->db('gudangbarang')->where('kode_brng', $_POST['id_barang'])->where('kd_bangsal', $this->settings->get('farmasi.obatluar'))->update(['stok' => $gudangbarang['stok'] - $_POST['jumlah']]);
                  $this->db('riwayat_barang_medis')
                    ->save([
                      'kode_brng' => $_POST['id_barang'],
                      'stok_awal' => $gudangbarang['stok'],
                      'masuk' => '0',
                      'keluar' => $_POST['jumlah'],
                      'stok_akhir' => $gudangbarang['stok'] - $_POST['jumlah'],
                      'posisi' => 'Penjualan',
                      'tanggal' => $tanggal,
                      'jam' => $jam,
                      'petugas' => $this->core->getUserInfo('fullname', null, true),
                      'kd_bangsal' => $this->settings->get('farmasi.obatluar'),
                      'status' => 'Simpan',
                      'no_batch' => $gudangbarang['no_batch'],
                      'no_faktur' => $gudangbarang['no_faktur'],
                      'keterangan' => 'Penjualan obat bebas'
                    ]);                  
                }
            }
        } else {
            $penjualan = $this->db('mlite_penjualan')
            ->save([
                'nama_pembeli' => $_POST['nama_pembeli'], 
                'alamat_pembeli' => $_POST['alamat_pembeli'], 
                'nomor_telepon' => $_POST['nomor_telepon'], 
                'email' => $_POST['email'], 
                'tanggal' => $tanggal, 
                'jam' => $jam, 
                'id_user' => $this->core->getUserInfo('username', null, true), 
                'keterangan' => $_POST['keterangan']
            ]);
            $last = $this->db('mlite_penjualan')
                ->desc('id')
                ->oneArray();

            $lastInsertID = $last['id'];
            // $lastInsertID = $this->db()->lastInsertId();
            if($penjualan) {
                $detail = $this->db('mlite_penjualan_detail')
                ->save([
                    'id_penjualan' => $lastInsertID, 
                    'id_barang' => $_POST['id_barang'], 
                    'nama_barang' => $_POST['nama_barang'], 
                    'harga' => $barang['harga'], 
                    'jumlah' => $_POST['jumlah'], 
                    'harga_total' => $harga_total, 
                    'tanggal' => $tanggal, 
                    'jam' => $jam, 
                    'id_user' => $this->core->getUserInfo('username', null, true) 
                ]);
                echo $lastInsertID;
                if($detail) {
                    $mlite_penjualan_barang = $this->db('mlite_penjualan_barang')->where('id', $_POST['id_barang'])->oneArray();
                    if($mlite_penjualan_barang) {
                      $this->db('mlite_penjualan_barang')->where('id', $_POST['id_barang'])->update(['stok' => $mlite_penjualan_barang['stok'] - $_POST['jumlah']]);
                    } else {
                      $gudangbarang = $this->db('gudangbarang')->where('kode_brng', $_POST['id_barang'])->where('kd_bangsal', $this->settings->get('farmasi.obatluar'))->oneArray();
                      $this->db('gudangbarang')->where('kode_brng', $_POST['id_barang'])->where('kd_bangsal', $this->settings->get('farmasi.obatluar'))->update(['stok' => $gudangbarang['stok'] - $_POST['jumlah']]);
                      $this->db('riwayat_barang_medis')
                        ->save([
                          'kode_brng' => $_POST['id_barang'],
                          'stok_awal' => $gudangbarang['stok'],
                          'masuk' => '0',
                          'keluar' => $_POST['jumlah'],
                          'stok_akhir' => $gudangbarang['stok'] - $_POST['jumlah'],
                          'posisi' => 'Penjualan',
                          'tanggal' => $tanggal,
                          'jam' => $jam,
                          'petugas' => $this->core->getUserInfo('fullname', null, true),
                          'kd_bangsal' => $this->settings->get('farmasi.obatluar'),
                          'status' => 'Simpan',
                          'no_batch' => $gudangbarang['no_batch'],
                          'no_faktur' => $gudangbarang['no_faktur'],
                          'keterangan' => 'Penjualan obat bebas'
                        ]);                          
                    }
                }
            }
        }
        exit();
    }

    public function postHapusItemPenjualan()
    {
      $this->db('mlite_penjualan_detail')->where('id', $_POST['id'])->delete();
      exit();
    }

    public function anyRincianPenjualan()
    {
        $rows = $this->db('mlite_penjualan_detail')->where('id_penjualan', $_POST['id'])->toArray();
        $no = 1;
        $rincian_penjualan = [];
        foreach($rows as $row) {
            $row['no'] = $no++;
            $rincian_penjualan[] = $row;
        }
        echo $this->draw('rincian.penjualan.html', ['rincian_penjualan' => $rincian_penjualan]);
        exit();
    }

    public function postFormRincianPenjualan()
    {
        $rows = $this->db('mlite_penjualan_detail')->where('id_penjualan', $_POST['id'])->toArray();
        $form_rincian_penjualan = [];
        $total_tagihan = 0;
        foreach($rows as $row) {
            $total_tagihan += $row['harga_total'];
            $row['nama_barang'] = htmlspecialchars($row['nama_barang'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
            $form_rincian_penjualan[] = $row;
        }
        echo $this->draw('form.rincian.penjualan.html', ['form_rincian_penjualan' => htmlspecialchars_array($form_rincian_penjualan), 'total_tagihan' => $total_tagihan]);
        exit();
    }

    public function postSimpanBilling()
    {
        $id_penjualan       = isset($_POST['id_penjualan']) ? $_POST['id_penjualan'] : '';
        $jumlah_total       = isset($_POST['jumlah_total']) ? $_POST['jumlah_total'] : 0;
        $potongan           = isset($_POST['potongan']) ? $_POST['potongan'] : 0;
        $jumlah_harus_bayar = isset($_POST['jumlah_harus_bayar']) ? $_POST['jumlah_harus_bayar'] : 0;
        $jumlah_bayar       = isset($_POST['jumlah_bayar']) ? $_POST['jumlah_bayar'] : 0;
        $tanggal            = !empty($_POST['tanggal']) ? $_POST['tanggal'] : date('Y-m-d');
        $jam                = !empty($_POST['jam']) ? $_POST['jam'] : date('H:i:s');
        // 'keterangan' merangkap sebagai status bayar: 'Belum Bayar' = belum lunas,
        // selain itu ('Tunai' / 'Kurang Bayar') dianggap Sudah Bayar
        $keterangan         = isset($_POST['keterangan']) && $_POST['keterangan'] !== '' ? $_POST['keterangan'] : 'Belum Bayar';

        if ($id_penjualan === '') {
            echo json_encode(['status' => 'FAILED', 'message' => 'id_penjualan kosong']);
            exit();
        }

        $data = [
            'id_penjualan'       => $id_penjualan,
            'jumlah_total'       => $jumlah_total,
            'potongan'           => $potongan,
            'jumlah_harus_bayar' => $jumlah_harus_bayar,
            'jumlah_bayar'       => $jumlah_bayar,
            'keterangan'         => $keterangan,
            'tanggal'            => $tanggal,
            'jam'                => $jam,
            'id_user'            => $this->core->getUserInfo('username', null, true)
        ];

        $existing = $this->db('mlite_penjualan_billing')->where('id_penjualan', $id_penjualan)->oneArray();

        if ($existing) {
            $ok = $this->db('mlite_penjualan_billing')->where('id_penjualan', $id_penjualan)->update($data);
        } else {
            $ok = $this->db('mlite_penjualan_billing')->save($data);
        }

        // hitung ID penjualan berikutnya, dipakai front-end untuk lanjut ke order baru
        $last = $this->db('mlite_penjualan')->desc('id')->toArray();
        $next_id_penjualan = !empty($last[0]['id']) ? ($last[0]['id'] + 1) : 1;

        echo json_encode([
            'status'            => $ok ? 'OK' : 'FAILED',
            'keterangan'        => $keterangan,
            'status_bayar'      => ($keterangan === 'Belum Bayar') ? 'Belum Bayar' : 'Sudah Bayar',
            'next_id_penjualan' => $next_id_penjualan,
        ]);
        exit();
    }

    public function postDelete($id = '')
    {
      if ($id === '') {
        redirect(url([ADMIN, 'penjualan', 'index']));
      }
      $this->db('mlite_penjualan_detail')->where('id_penjualan', $id)->delete();
      $this->db('mlite_penjualan_billing')->where('id_penjualan', $id)->delete();
      $ok = $this->db('mlite_penjualan')->where('id', $id)->delete();
      $this->notify($ok ? 'success' : 'failure', $ok ? 'Data penjualan telah dihapus' : 'Data penjualan gagal dihapus');
      redirect(url([ADMIN, 'penjualan', 'index']));
    }

    public function anyFaktur()
    {
        $settings = $this->settings('settings');
        $this->tpl->set(
            'settings',
            $this->tpl->noParse_array(htmlspecialchars_array($settings))
        );

        $show = $_GET['show'] ?? '';

        switch ($show) {

            /* ===============================
            * VALIDASI DEFAULT
            * =============================== */
            default:
                if (
                    $this->db('mlite_penjualan_billing')
                        ->where('id_penjualan', $_POST['id_penjualan'])
                        ->oneArray()
                ) {
                    echo 'OK';
                }
            break;

            /* ===============================
            * FAKTUR BESAR
            * =============================== */
            case 'besar':

                $id_penjualan = $_GET['id_penjualan'];

                $billing = $this->db('mlite_penjualan_billing')
                    ->where('id_penjualan', $id_penjualan)
                    ->desc('id')
                    ->oneArray();

                $rows = $this->db('mlite_penjualan_detail')
                    ->where('id_penjualan', $id_penjualan)
                    ->toArray();

                $total = 0;
                $detail = [];
                $no = 1;

                foreach ($rows as $row) {
                    $row['no'] = $no++;
                    $total += $row['harga_total'];
                    $detail[] = $row;
                }

                $pembeli = $this->db('mlite_penjualan')
                    ->where('id', $id_penjualan)
                    ->oneArray();

                /* ===== QR CODE ===== */
                $qr = QRCode::getMinimumQRCode(
                    $this->core->getUserInfo('fullname', null, true),
                    QR_ERROR_CORRECT_LEVEL_L
                );
                $im = $qr->createImage(4, 4);
                $qrPath = BASE_DIR.'/'.ADMIN.'/tmp/qrcode.png';
                imagepng($im, $qrPath);
                imagedestroy($im);

                $qrCode = url().'/'.ADMIN.'/tmp/qrcode.png';

                /* ===== INJECT DATA KE TEMPLATE ===== */
                $this->tpl->set('wagateway', $this->settings->get('wagateway'));
                $this->tpl->set('billing', $billing);
                $this->tpl->set('billing_besar_detail', $detail);
                $this->tpl->set('pembeli', $pembeli);
                $this->tpl->set('qrCode', $qrCode);
                $this->tpl->set('fullname', $this->core->getUserInfo('fullname', null, true));
                $this->tpl->set('total', $total);

                /* ===============================
                * RENDER HTML SEKALI
                * =============================== */
                $html = $this->draw('billing.besar.html');

                /* ===============================
                * GENERATE PDF
                * =============================== */
                $pdfPath = UPLOADS.'/invoices/'.$billing['id_penjualan'].'.pdf';
                if (file_exists($pdfPath)) {
                    unlink($pdfPath);
                }

                $mpdf = new \Mpdf\Mpdf([
                    'mode' => 'utf-8',
                    'format' => 'A4',
                    'orientation' => 'P'
                ]);

                $css = '
                    del { display:none; }
                    table { padding-top:1cm; padding-bottom:1cm; }
                    td, th { border-bottom:1px solid #ddd; padding:5px; }
                ';

                $mpdf->WriteHTML(
                    $this->core->setPrintCss(),
                    \Mpdf\HTMLParserMode::HEADER_CSS
                );
                $mpdf->WriteHTML('<style>'.$css.'</style>');
                $mpdf->WriteHTML($html);

                $mpdf->Output($pdfPath, 'F');

                /* ===============================
                * PREVIEW HTML
                * =============================== */
                echo $html;
            break;

            /* ===============================
            * FAKTUR KECIL (HTML SAJA)
            * =============================== */
            case 'kecil':

                $id_penjualan = $_GET['id_penjualan'];

                $pembeli = $this->db('mlite_penjualan')
                    ->where('id', $id_penjualan)
                    ->oneArray();

                $billing = $this->db('mlite_penjualan_billing')
                    ->where('id_penjualan', $id_penjualan)
                    ->desc('id')
                    ->oneArray();

                echo $this->draw('billing.kecil.html', [
                    'billing' => $billing,
                    'pembeli' => $pembeli,
                    'fullname' => $this->core->getUserInfo('fullname', null, true)
                ]);
            break;
        }

        exit;
    }

    private function _addHeaderFiles()
    {
        $this->core->addCSS(url('assets/css/dataTables.bootstrap.min.css'));
        $this->core->addJS(url('assets/jscripts/jquery.dataTables.min.js'));
        $this->core->addJS(url('assets/jscripts/dataTables.bootstrap.min.js'));
    }

}
