<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Pendaftaran extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_pendaftaran_model');
        $this->load->model('Tbl_jadwal_praktek_dokter_model');
        $this->load->model('Antrean_model');
        $this->load->library('datatables');

    }

    public function json()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_pendaftaran_model->json();
    }

    private function olahDataRawat($cara_masuk)
    {
        $q = urldecode($this->input->get('q', TRUE));
        $start = intval($this->input->get('start'));
        $kd_dokter = "";
        $enable = true;

        $user_level = $this->session->id_user_level;


		switch($user_level) {
            case 3: //dokter
                $kd_dokter = $this->session->kode_dokter;
                $enable = false;
			break;
		}

        $config['per_page'] = 10;
        $config['page_query_string'] = TRUE;
        $config['total_rows'] = $this->Tbl_pendaftaran_model->total_rows($q);

        $pendaftaran = $this->Tbl_pendaftaran_model->get_limit_data($config['per_page'], $start, $q, $cara_masuk, $kd_dokter);

        $config['full_tag_open'] = '<ul class="pagination pagination-sm no-margin pull-right">';
        $config['full_tag_close'] = '</ul>';
        $this->load->library('pagination');
        $this->pagination->initialize($config);

        foreach ($pendaftaran as $item) {
            $item->no_rawat_readable = $this->Tbl_pendaftaran_model->decode_no_rawat($item->no_rawat);
        }

        $data = array(
            'pendaftaran_data' => $pendaftaran,
            'q' => $q,
            'pagination' => $this->pagination->create_links(),
            'total_rows' => $config['total_rows'],
            'start' => $start,
            'enable' => $enable
        );

        if ($this->router->fetch_method() == "ranap") {
            $data["head_rawat"] = "Kamar Tidur";
            $data["is_ralan"] = false;

            foreach ($pendaftaran as $list) {
                $ranap = $this->db->get_where('tbl_rawat_inap', array('no_rawat' => $list->no_rawat_readable))->row_array();

                $kodeTempatTidur = $ranap['kode_tempat_tidur'];

                $sqlRuangRanap = "SELECT ri.nama_ruangan 
                                    FROM tbl_tempat_tidur as tt,tbl_ruang_rawat_inap as ri 
                                    WHERE tt.kode_ruang_rawat_inap=ri.kode_ruang_rawat_inap
                                    and tt.kode_tempat_tidur='$kodeTempatTidur'";

                $bed = $this->db->query($sqlRuangRanap)->row_array();
                
                $list->nama_ruangan = $bed['nama_ruangan'];
            }
        } else {
            $data["head_rawat"] = "Poliklinik";
            $data["is_ralan"] = true;
        }
 
        return $data;
    }

    public function ralan()
    {
        $cara_masuk = "RAWAT JALAN";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list', $this->olahDataRawat($cara_masuk));
    }

    public function ranap()
    {
        $cara_masuk = "RAWAT INAP";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list', $this->olahDataRawat($cara_masuk));
    }
    
    public function ugd()
    {
        $cara_masuk = "UGD";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list', $this->olahDataRawat($cara_masuk));
    }

    public function index() {
        redirect("pendaftaran/ralan");
    }

    function detail($id)
    {
        $no_rawat = $this->Tbl_pendaftaran_model->get_by_id($id)->no_rawat;

        $sql_daftar = "SELECT pd.*,ps.* FROM 
                        tbl_pendaftaran as pd,tbl_pasien as ps
                        WHERE pd.no_rekamedis=ps.no_rekamedis and pd.no_rawat='$no_rawat'";

        $sql_tindakan = "SELECT tt.*,tr.* 
                        FROM tbl_riwayat_tindakan as tr,tbl_tindakan as tt
                        WHERE tr.kode_tindakan=tt.kode_tindakan and tr.no_rawat='$no_rawat'";

        $sql_labor    = "SELECT tp.*,tr.* 
                        FROM tbl_pemeriksaan_laboratorium as tp, tbl_riwayat_pemeriksaan_laboratorium as  tr
                        WHERE tr.kode_periksa=tp.kode_periksa and tr.no_rawat='$no_rawat'";

        $data['pendaftaran'] =  $this->Tbl_pendaftaran_model->getDataPasien($no_rawat)->row_array();
        
        $data['no_rawat'] = $no_rawat;

        $data['riwayat_obat'] = $this->Tbl_pendaftaran_model->getRiwayatObat($no_rawat)->result();

        foreach($data['riwayat_obat'] as $item) {
            $item->status_acc = $this->template->drawStatusAcc($item->id_status_acc, $item->deskripsi_status_acc);
        }

        $data['tindakan'] = $this->db->query($sql_tindakan)->result();
        $data['riwayat_labor'] = $this->db->query($sql_labor)->result();
        $data['isUGD'] = $data['pendaftaran']['cara_masuk'] == "UGD";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_detail', $data);
    }

    public function get_poli($nama)
    {
        $this->db->where("nama_satuan", $nama);
        return $this->db->get("tbl_satuan_barang")->row();
    }

    public function ugd2ranap_action() {
        $data = $this->input->post();

        $data["tanggal_masuk"] = date("Y-m-d");

        unset($data['nama_gedung']);
        unset($data['kode_gedung']);

        $pendaftaran_update = $this->Tbl_pendaftaran_model->change2Ranap($data['no_rawat']);

        if($pendaftaran_update) {
            $ranap_update = $this->Tbl_pendaftaran_model->insert2Ranap($data);

            if($ranap_update) {
                $this->session->set_flashdata('message', 'Berhasil membuat data.');
            } else {
                $this->session->set_flashdata('message', 'Gagal membuat data rawat inap.');
            }
            redirect(base_url("pendaftaran/ranap"));
        } else {
            echo $pendaftaran_update;

            $this->session->set_flashdata('message', 'Gagal membuat data rawat inap.');
            redirect(base_url("pendaftaran/detail/".enc_str($data['no_rawat'])));
        }
    }


    public function test()
    {
        $lines = [];

        echo "<pre>";
        if (($handle = fopen(base_url("assets/obat.csv"), "r")) !== FALSE) {
            while (($data = fgetcsv($handle, 0, ":")) !== FALSE) {
                $lines[] = $data;
            }
            fclose($handle);
        }

        array_shift($lines);
        $i = 0;

        echo "INSERT INTO `tbl_obat_alkes_bhp`(`kode_barang`, `nama_barang`, `id_kategori_harga_brg`, `id_kategori_barang`, `id_satuan_barang`, `harga`)<br> VALUES";

        foreach ($lines as $line) {
            $id_satuan = $this->get_poli($line[1])->id_satuan;
            $id_kategori = 6;
            $id_gol_harga = 1;
            $nama_barang = $line[0];
            $harga = $line[2];

            if (is_numeric($harga) && mb_detect_encoding($nama_barang, 'ASCII', true)) {
                $n2 = str_pad(++$i, 5, 0, STR_PAD_LEFT);

                echo "('$n2', \"$nama_barang\", $id_gol_harga, $id_kategori, $id_satuan, {$harga}),<br>";
            }
        }
    }

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('pendaftaran/create_action'),
            'no_registrasi' => set_value('no_registrasi'),
            'no_rawat' => set_value('no_rawat'),
            'no_rekamedis' => set_value('no_rekamedis'),
            'cara_masuk' => set_value('cara_masuk'),
            'tanggal_daftar' => set_value('tanggal_daftar'),
            'kode_dokter_penanggung_jawab' => set_value('kode_dokter_penanggung_jawab'),
            'id_poli' => set_value('id_poli'),
            'nama_penanggung_jawab' => set_value('nama_penanggung_jawab'),
            'hubungan_dengan_penanggung_jawab' => set_value('hubungan_dengan_penanggung_jawab'),
            'alamat_penanggung_jawab' => set_value('alamat_penanggung_jawab'),
            'id_jenis_bayar' => set_value('id_jenis_bayar'),
            'asal_rujukan' => set_value('asal_rujukan'),
        );
        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_form_new', $data);
    }

    function getKodeDokter($namaDokter)
    {
        $this->db->where('nama_dokter', $namaDokter);

        $dokter = $this->db->get('tbl_dokter')->row_array();
        return $dokter['kode_dokter'];
    }

    public function create_action()
    {
        $this->_rules();

        $redirect_func = "";

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $no_rawat = $this->input->post('no_rawat', TRUE);

            $data = array(
                'no_rawat' =>  $no_rawat,
                'no_registrasi' => $this->input->post('no_registrasi', TRUE),
                'no_rekamedis' => $this->input->post('no_rekamedis', TRUE),
                'cara_masuk' => $this->input->post('cara_masuk', TRUE),
                'tanggal_daftar' => $this->input->post('tanggal_daftar', TRUE),
                'kode_dokter_penanggung_jawab' => $this->input->post('kode_dokter_penanggung_jawab', TRUE),
                'id_poli' => $this->input->post('id_poli', TRUE),
                'nama_penanggung_jawab' => $this->input->post('nama_penanggung_jawab', TRUE),
                'hubungan_dengan_penanggung_jawab' => $this->input->post('hubungan_dengan_penanggung_jawab', TRUE),
                'alamat_penanggung_jawab' => $this->input->post('alamat_penanggung_jawab', TRUE),
                'id_jenis_bayar' => $this->input->post('id_jenis_bayar', TRUE),
                'asal_rujukan' => $this->input->post('asal_rujukan', TRUE),
            );

            // script ini digunakan untuk menyimpan data rawat inap
            $cara_masuk = $this->input->post('cara_masuk', TRUE);

            if ($cara_masuk == 'RAWAT INAP') {
                $data_ranap = array(
                    'no_rawat'              =>  $no_rawat,
                    'tanggal_masuk'         =>  $this->input->post('tanggal_daftar', TRUE),
                    'kode_tempat_tidur' => $this->input->post('kode_tempat_tidur', TRUE)
                );
                $this->db->insert('tbl_rawat_inap', $data_ranap);

                $this->db->where('kode_tempat_tidur', $this->input->post('kode_tempat_tidur', TRUE));
                $this->db->update('tbl_tempat_tidur', array('status' => 'diisi'));

                $redirect_func = site_url('pendaftaran/ranap');
            } else {
                $redirect_func = site_url('pendaftaran/ralan');
            }

            $this->Tbl_pendaftaran_model->insert($data);

            $this->session->set_flashdata('message', 'Berhasil membuat data.');

            redirect($redirect_func);
        }
    }

    public function ugd2ranap($no_rawat) {
        $data_ranap = array(
            'no_rawat'              =>  $no_rawat,
            'tanggal_masuk'         =>  $this->input->post('tanggal_daftar', TRUE),
            'tanggal_keluar'        =>  $this->input->post('tanggal_keluar', TRUE),
            'kode_tempat_tidur'     =>  $this->input->post('kode_tempat_tidur', TRUE)
        );
        $this->db->insert('tbl_rawat_inap', $data_ranap);

        $this->db->where('kode_tempat_tidur', $this->input->post('kode_tempat_tidur', TRUE));
        $this->db->update('tbl_tempat_tidur', array('status' => 'diisi'));

        $redirect_func = site_url('pendaftaran/ranap');
    }

    public function update($id)
    {
        $row = $this->Tbl_pendaftaran_model->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('pendaftaran/update_action'),
                'no_registrasi' => set_value('no_registrasi', $row->no_registrasi),
                'no_rawat' => set_value('no_rawat', $row->no_rawat),
                'no_rekamedis' => set_value('no_rekamedis', $row->no_rekamedis),
                'cara_masuk' => set_value('cara_masuk', $row->cara_masuk),
                'tanggal_daftar' => set_value('tanggal_daftar', $row->tanggal_daftar),
                'kode_dokter_penanggung_jawab' => set_value('kode_dokter_penanggung_jawab', $row->kode_dokter_penanggung_jawab),
                'id_poli' => set_value('id_poli', $row->id_poli),
                'nama_penanggung_jawab' => set_value('nama_penanggung_jawab', $row->nama_penanggung_jawab),
                'hubungan_dengan_penanggung_jawab' => set_value('hubungan_dengan_penanggung_jawab', $row->hubungan_dengan_penanggung_jawab),
                'alamat_penanggung_jawab' => set_value('alamat_penanggung_jawab', $row->alamat_penanggung_jawab),
                'id_jenis_bayar' => set_value('id_jenis_bayar', $row->id_jenis_bayar),
                'asal_rujukan' => set_value('asal_rujukan', $row->asal_rujukan),
            );
            $this->template->load('template', 'pendaftaran/tbl_pendaftaran_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('pendaftaran'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('no_rawat', TRUE));
        } else {
            $data = array(
                'no_registrasi' => $this->input->post('no_registrasi', TRUE),
                'no_rekamedis' => $this->input->post('no_rekamedis', TRUE),
                'cara_masuk' => $this->input->post('cara_masuk', TRUE),
                'tanggal_daftar' => $this->input->post('tanggal_daftar', TRUE),
                'kode_dokter_penanggung_jawab' => $this->input->post('kode_dokter_penanggung_jawab', TRUE),
                'id_poli' => $this->input->post('id_poli', TRUE),
                'nama_penanggung_jawab' => $this->input->post('nama_penanggung_jawab', TRUE),
                'hubungan_dengan_penanggung_jawab' => $this->input->post('hubungan_dengan_penanggung_jawab', TRUE),
                'alamat_penanggung_jawab' => $this->input->post('alamat_penanggung_jawab', TRUE),
                'id_jenis_bayar' => $this->input->post('id_jenis_bayar', TRUE),
                'asal_rujukan' => $this->input->post('asal_rujukan', TRUE),
            );

            $this->Tbl_pendaftaran_model->update($this->input->post('no_rawat', TRUE), $data);
            $this->session->set_flashdata('message', 'Update Record Success');
            redirect(site_url('pendaftaran'));
        }
    }

    public function delete($id)
    {
        $row = $this->Tbl_pendaftaran_model->get_by_id($id);

        if ($row) {
            if ($this->Tbl_pendaftaran_model->delete($id)) {
                $this->session->set_flashdata('message', 'Delete Record Success');
            } else {
                $this->session->set_flashdata('error', 'Gagal menghapus pasien');
            }
            redirect(site_url('pendaftaran/ralan'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('pendaftaran/ralan'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('no_registrasi', 'no registrasi', 'trim|required');
        $this->form_validation->set_rules('no_rekamedis', 'no rekamedis', 'trim|required');
        $this->form_validation->set_rules('cara_masuk', 'cara masuk', 'trim|required');
        $this->form_validation->set_rules('tanggal_daftar', 'tanggal daftar', 'trim|required');
        $this->form_validation->set_rules('kode_dokter_penanggung_jawab', 'kode dokter penanggung jawab', 'trim|required');
        $this->form_validation->set_rules('id_poli', 'id poli', 'trim|required');
        $this->form_validation->set_rules('nama_penanggung_jawab', 'nama penanggung jawab', 'trim|required');
        $this->form_validation->set_rules('hubungan_dengan_penanggung_jawab', 'hubungan dengan penanggung jawab', 'trim|required');
        $this->form_validation->set_rules('alamat_penanggung_jawab', 'alamat penanggung jawab', 'trim|required');
        $this->form_validation->set_rules('id_jenis_bayar', 'id jenis bayar', 'trim|required');
        $this->form_validation->set_rules('asal_rujukan', 'asal rujukan', 'trim|required');

        $this->form_validation->set_rules('no_rawat', 'no_rawat', 'trim');
        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }

    public function excel()
    {
        $this->load->helper('exportexcel');
        $namaFile = "tbl_pendaftaran.xls";
        $judul = "tbl_pendaftaran";
        $tablehead = 0;
        $tablebody = 1;
        $nourut = 1;
        //penulisan header
        header("Pragma: public");
        header("Expires: 0");
        header("Cache-Control: must-revalidate, post-check=0,pre-check=0");
        header("Content-Type: application/force-download");
        header("Content-Type: application/octet-stream");
        header("Content-Type: application/download");
        header("Content-Disposition: attachment;filename=" . $namaFile . "");
        header("Content-Transfer-Encoding: binary ");

        xlsBOF();

        $kolomhead = 0;
        xlsWriteLabel($tablehead, $kolomhead++, "No");
        xlsWriteLabel($tablehead, $kolomhead++, "No Registrasi");
        xlsWriteLabel($tablehead, $kolomhead++, "No Rekamedis");
        xlsWriteLabel($tablehead, $kolomhead++, "Cara Masuk");
        xlsWriteLabel($tablehead, $kolomhead++, "Tanggal Daftar");
        xlsWriteLabel($tablehead, $kolomhead++, "Kode Dokter Penanggung Jawab");
        xlsWriteLabel($tablehead, $kolomhead++, "Id Poli");
        xlsWriteLabel($tablehead, $kolomhead++, "Nama Penanggung Jawab");
        xlsWriteLabel($tablehead, $kolomhead++, "Hubungan Dengan Penanggung Jawab");
        xlsWriteLabel($tablehead, $kolomhead++, "Alamat Penanggung Jawab");
        xlsWriteLabel($tablehead, $kolomhead++, "Id Jenis Bayar");
        xlsWriteLabel($tablehead, $kolomhead++, "Asal Rujukan");

        foreach ($this->Tbl_pendaftaran_model->get_all() as $data) {
            $kolombody = 0;

            //ubah xlsWriteLabel menjadi xlsWriteNumber untuk kolom numeric
            xlsWriteNumber($tablebody, $kolombody++, $nourut);
            xlsWriteLabel($tablebody, $kolombody++, $data->no_registrasi);
            xlsWriteLabel($tablebody, $kolombody++, $data->no_rekamedis);
            xlsWriteLabel($tablebody, $kolombody++, $data->cara_masuk);
            xlsWriteLabel($tablebody, $kolombody++, $data->tanggal_daftar);
            xlsWriteNumber($tablebody, $kolombody++, $data->kode_dokter_penanggung_jawab);
            xlsWriteNumber($tablebody, $kolombody++, $data->id_poli);
            xlsWriteLabel($tablebody, $kolombody++, $data->nama_penanggung_jawab);
            xlsWriteLabel($tablebody, $kolombody++, $data->hubungan_dengan_penanggung_jawab);
            xlsWriteLabel($tablebody, $kolombody++, $data->alamat_penanggung_jawab);
            xlsWriteNumber($tablebody, $kolombody++, $data->id_jenis_bayar);
            xlsWriteLabel($tablebody, $kolombody++, $data->asal_rujukan);

            $tablebody++;
            $nourut++;
        }

        xlsEOF();
        exit();
    }

    public function word()
    {
        header("Content-type: application/vnd.ms-word");
        header("Content-Disposition: attachment;Filename=tbl_pendaftaran.doc");

        $data = array(
            'tbl_pendaftaran_data' => $this->Tbl_pendaftaran_model->get_all(),
            'start' => 0
        );

        $this->load->view('pendaftaran/tbl_pendaftaran_doc', $data);
    }

    function pemberi_tindakan_ajax()
    {
        $tindakan_oleh = $_GET['tindakan_oleh'];
        echo "<table class='table table-bordered'>";
        if ($tindakan_oleh == 'petugas') {
            echo "<tr><td width='200'>Nama Petugas</td><td><input required type='text' onkeyup='cari_petugas()' id='txt_nama_petugas' name='nama_petugas' placeholder='Masukan Nama Petugas' class='form-control'></td></tr>";
        } elseif ($tindakan_oleh == 'dokter') {
            echo "<tr><td width='200'>Nama Dokter</td><td><input required onkeyup='cari_dokter()' id='txt_nama_dokter' type='text' name='nama_dokter' placeholder='Masukan Nama Dokter' class='form-control'></td></tr>";
        } else {
            echo "<tr><td width='200'>Nama Petugas</td><td><input required onkeyup='cari_petugas()' id='txt_nama_petugas' type='text' name='nama_petugas' placeholder='Masukan Nama Petugas' class='form-control'></td></tr>";
            echo "<tr><td>Nama Dokter</td><td><input required type='text' onkeyup='cari_dokter()' id='txt_nama_dokter' name='nama_dokter' placeholder='Masukan Nama Dokter' class='form-control'></td></tr>";
        }
        echo "</table>";
    }

    function periksa_action()
    {
        if (false) {
            print_r($this->input->post());
            die();
        }

        $nama_tindakan  = $this->input->post('nama_tindakan');
        $tindakan       = $this->input->post('id_tindakan');
        $hasil_periksa  = $this->input->post('hasil_periksa');
        $perkembangan   = $this->input->post('perkembangan');
        $no_rawat       = $this->input->post('no_rawat');

        $id_pj_riwayat_tindakan = $this->input->post('id_pj_riwayat_tindakan');

        $id_dokter = $this->input->post('id_dokter');
        $id_petugas = $this->input->post('id_petugas');

        $data = array(
            'no_rawat'      =>  $no_rawat,
            'hasil_periksa' =>  $hasil_periksa,
            'perkembangan'  =>  $perkembangan,
            'kode_tindakan' =>  $tindakan,
            'tanggal'       =>  date('Y-m-d'),
            'id_pj_riwayat_tindakan' => $id_pj_riwayat_tindakan,
            'id_dokter' => $id_dokter,
            'id_pegawai'    => $id_petugas
        );

        if ($this->db->insert('tbl_riwayat_tindakan', $data)) {
            $this->session->set_flashdata('message', 'Sukses memberi tindakan');
        } else {
            $this->session->set_flashdata('error', 'Gagal memberi tindakan');
        }

        redirect('pendaftaran/detail/' . $this->Tbl_pendaftaran_model->encode_no_rawat($no_rawat));
    }

    function beriobat_action()
    {
        $nama_barang    = $this->input->post('nama_obat');
        $kode_barang    = $this->input->post('kode_obat');
        $no_rawat       = $this->input->post('no_rawat');
        $tanggal        = date('Y-m-d');
        $jumlah         = $this->input->post('qty');

        $data = array(
            'no_rawat'      =>  $no_rawat,
            'kode_barang'   =>  $kode_barang,
            'tanggal'       =>  $tanggal,
            'jumlah'        =>  $jumlah
        );
        $this->db->insert('tbl_riwayat_pemberian_obat', $data);

        redirect('pendaftaran/detail/' . $this->Tbl_pendaftaran_model->encode_no_rawat($no_rawat));
    }

    function sub_periksa_labor_ajax()
    {
        $nama_periksa = $_GET['nama_periksa'];
        $kode_periksa = getFieldValue('tbl_pemeriksaan_laboratorium', 'kode_periksa', 'nama_periksa', $nama_periksa);
        echo "<table class='table table-bordered'>
            <tr>
            <th>Nama Pemeriksaan</th>
            <th>Satuan</th>
            <th>Nilai Rujukan</th>
            <th>Hasil</th>
            <th>Keterangan</th></tr>";
        $this->db->where('kode_periksa', $kode_periksa);
        $sub_periksa = $this->db->get('tbl_sub_pemeriksaan_laboratoirum')->result();
        foreach ($sub_periksa as $row) {
            echo "
            <tr>
            <td>$row->nama_pemeriksaan</td>
            <td>$row->satuan</td>
            <td>$row->nilai_rujukan</td>
            <td><input type='text' name='hasil-$row->kode_sub_periksa' placeholder='hasil' class='form-control'></td>
            <td><input type='text' name='keterangan-$row->kode_sub_periksa' placeholder='Keterangan' class='form-control'></td>
            </tr>";
        }

        echo "</table>";
    }

    function periksa_labor_action()
    {
        $nama_periksa = $this->input->post('nama_periksa');
        $kode_periksa = getFieldValue('tbl_pemeriksaan_laboratorium', 'kode_periksa', 'nama_periksa', $nama_periksa);
        // insert tabel riwaway pemeriksaan laboratorium

        $riwayat_labor = array(
            'no_rawat'      =>  $this->input->post('no_rawat'),
            'tanggal'       =>  date('Y-m-d'),
            'kode_periksa'  =>  $kode_periksa
        );
        $this->db->insert('tbl_riwayat_pemeriksaan_laboratorium', $riwayat_labor);

        $id_rawat = $this->db->insert_id();

        $this->db->where('kode_periksa', $kode_periksa);
        $sub_periksa = $this->db->get('tbl_sub_pemeriksaan_laboratoirum')->result();
        foreach ($sub_periksa as $row) {
            $hasil      = $this->input->post('hasil-' . $row->kode_sub_periksa);
            $keterangan = $this->input->post('keterangan-' . $row->kode_sub_periksa);
            $no_rawat   = $this->input->post('no_rawat');
            $data = array(
                'hasil'             =>  $hasil,
                'keterangan'        =>  $keterangan,
                'id_rawat'          =>  $id_rawat,
                'kode_sub_periksa'  =>  $row->kode_sub_periksa
            );
            $this->db->insert('tbl_riwayat_pemeriksaan_laboratorium_detail', $data);
        }
        redirect('pendaftaran/detail/' . $no_rawat);
    }

    function cetak_riwayat_labor()
    {
        $no_rawat = substr($this->uri->uri_string(3), 32);
        $sql_daftar = "SELECT pd.no_rekamedis,pd.no_rawat,ps.nama_pasien,td.nama_dokter 
                        FROM 
                        tbl_pendaftaran as pd,tbl_pasien as ps, tbl_dokter as td
                        WHERE pd.no_rekamedis=ps.no_rekamedis and td.kode_dokter=pd.kode_dokter_penanggung_jawab and pd.no_rawat='$no_rawat'";

        $sql_labor    = "SELECT tp.*,tr.tanggal,tr.id_riwayat 
                        FROM tbl_pemeriksaan_laboratorium as tp, tbl_riwayat_pemeriksaan_laboratorium as  tr
                        WHERE tr.kode_periksa=tp.kode_periksa and tr.no_rawat='$no_rawat'";
        $this->load->library('pdf');
        $pdf = new FPDF('l', 'mm', 'A5');
        // membuat halaman baru
        $pdf->AddPage();
        // setting jenis font yang akan digunakan
        $pdf->SetFont('Arial', 'B', 16);

        $pdf->Image(base_url() . 'assets/foto_profil/' .  getInfoRS('logo'), 8, 0, 35);
        //$pdf->Image($file, $x, $y, $w, $h)

        // mencetak string 
        $pdf->Cell(190, 7, getInfoRS('nama_rumah_sakit'), 0, 1, 'C');
        $pdf->SetFont('Arial', '', 12);
        $pdf->Cell(190, 7, 'Jl Pesantren Km 2, Cibabat, Cimahi Utara', 0, 1, 'C');
        $pdf->Cell(190, 7, 'No Telpon : +62896232323  Email : rspurwokerto@gmail.com', 0, 1, 'C');
        $pdf->Line(20, 35, 210 - 20, 35);
        $pdf->Line(20, 36, 210 - 20, 36);
        $pdf->Cell(8, 8, '', 0, 1);
        $pdf->Cell(190, 7, 'HASIL PEMERIKSAAN LABORATORIUM', 0, 1, 'C');

        // data pasien

        $pasien = $this->db->query($sql_daftar)->row_array();

        $pdf->Cell(30, 7, 'NO RM', 0, 0, 'l');
        $pdf->Cell(50, 7, ': ' . $pasien['no_rekamedis'], 0, 0, 'l');

        $pdf->Cell(50, 7, 'Penanggung Jawab', 0, 0, 'l');
        $pdf->Cell(30, 7, ': ' . $pasien['nama_dokter'], 0, 1, 'l');


        $pdf->Cell(30, 7, 'Nama Pasien', 0, 0, 'l');
        $pdf->Cell(50, 7, ': ' . $pasien['nama_pasien'], 0, 0, 'l');

        $pdf->Cell(50, 7, 'Dokter Pengirim', 0, 0, 'l');
        $pdf->Cell(30, 7, ': -', 0, 1, 'l');

        $pdf->Cell(10, 10, '', 0, 1);

        // tabel hasil pemeriksaan
        $pdf->Cell(50, 7, 'Pemeriksaan', 1, 0, 'C');
        $pdf->Cell(20, 7, 'Hasil', 1, 0, 'C');
        $pdf->Cell(20, 7, 'Satuan', 1, 0, 'C');
        $pdf->Cell(50, 7, 'Nilai Rujukan', 1, 0, 'C');
        $pdf->Cell(50, 7, 'Keterangan', 1, 1, 'C');

        $pemeriksaan = $this->db->query($sql_labor)->result();
        foreach ($pemeriksaan as $p) {
            $pdf->Cell(50, 7, $p->nama_periksa, 1, 0, 'L');
            $pdf->Cell(20, 7, '', 1, 0, 'C');
            $pdf->Cell(20, 7, '', 1, 0, 'C');
            $pdf->Cell(50, 7, '', 1, 0, 'C');
            $pdf->Cell(50, 7, '', 1, 1, 'C');

            // sub pemeriksaan
            $sub_periksa_sql = "SELECT ts.nama_pemeriksaan,ts.satuan,ts.nilai_rujukan,td.hasil,td.keterangan 
                                FROM tbl_sub_pemeriksaan_laboratoirum  as ts, tbl_riwayat_pemeriksaan_laboratorium_detail as td
                                WHERE td.kode_sub_periksa=ts.kode_sub_periksa 
                                 and td.id_rawat=$p->id_riwayat";
            $sub_periksa = $this->db->query($sub_periksa_sql)->result();
            foreach ($sub_periksa as $s) {
                $pdf->Cell(50, 7, ' - ' . $s->nama_pemeriksaan, 1, 0, 'L');
                $pdf->Cell(20, 7, $s->hasil, 1, 0, 'C');
                $pdf->Cell(20, 7, $s->satuan, 1, 0, 'C');
                $pdf->Cell(50, 7, $s->nilai_rujukan, 1, 0, 'C');
                $pdf->Cell(50, 7, $s->keterangan, 1, 1, 'C');
            }
        }



        $pdf->Cell(10, 7, '', 0, 1);
        $pdf->Cell(120, 7, '', 0, 0);
        $pdf->Cell(50, 7, 'Tanggal Cetak : ' . date('Y-m-d H:i:s'), 0, 1, 'C');
        $pdf->Cell(120, 7, '', 0, 0);
        $pdf->Cell(50, 7, 'Petugas Laboratorium', 0, 1, 'C');

        $pdf->Cell(10, 15, '', 0, 1);

        $pdf->Cell(120, 7, '', 0, 0);
        $pdf->Cell(50, 7, 'Nuris Akbar', 0, 1, 'C');

        $pdf->Output();
    }

    function catak_rekamedis()
    {
        $this->load->library('pdf');
        $pdf = new FPDF('p', 'mm', 'A4');
        // membuat halaman baru
        $pdf->AddPage();
        // setting jenis font yang akan digunakan
        $pdf->SetFont('Arial', '', 13);
        $pdf->Cell(130, 7, '', 0, 0);
        $pdf->Cell(30, 7, 'Cara bayar : -', 0, 1);

        $pdf->SetFont('Arial', 'B', 16);
        $pdf->Cell(190, 30, '', 1, 1);
        $pdf->Image(base_url() . 'assets/foto_profil/' .  getInfoRS('logo'), 15, 18, 30);
        $pdf->Text(50, 24, getInfoRS('nama_rumah_sakit'));
        $pdf->SetFont('Arial', '', 13);
        $pdf->Text(50, 31, getInfoRS('alamat'));
        $pdf->Text(50, 37, 'No Telpon : ' . getInfoRS('no_telpon') . ' Email : rslangsa@gmail.com');
        // mencetak string 

        $pdf->SetFont('Arial', '', 12);
        $pdf->Cell(190, 7, 'IDENTITAS PASIEN', 1, 1, 'C');
        $pdf->SetFont('Arial', '', 13);
        $pdf->Cell(60, 14, 'NOMOR REKAM MEDIK', 1, 0, 'l');
        $pdf->SetFont('Arial', 'B', 22);
        $pdf->Cell(130, 14, '    000002', 1, 1, 'l');

        $pdf->SetFont('Arial', '', 11);
        $pdf->Cell(190, 7, 'NAMA PASIEN    : Alia Jamilah               
                               NAMA IBU : Jamilah', 1, 1, 'l');

        $pdf->Cell(130, 7, 'No Identitas         : 1235678901234', 1, 0, 'l');
        $pdf->Cell(60, 7, 'KTP / SIM/ PASPOR', 1, 1, 'l');

        $pdf->Cell(130, 7, 'Agama                 : Islam', 1, 0, 'l');
        $pdf->Cell(60, 7, 'Tanggal Lahir : 24-08-1992', 1, 1, 'l');
        $pdf->Cell(130, 7, 'Status                  : Menikah', 1, 0, 'l');
        $pdf->Cell(60, 7, 'Jenis Kelamin : P', 1, 1, 'l');
        $pdf->Cell(130, 7, 'Pekerjaan            : Dosen', 1, 0, 'l');
        $pdf->Cell(60, 7, 'Pendidikan      : S2', 1, 1, 'l');
        $pdf->Cell(190, 7, 'Alamat                 : KP CITAMAN RT 04 RW 16, KEL CIBABAT, KAB CIMAHI UTARA ', 1, 1, 'l');
        $pdf->Cell(40, 14, 'Bila Ada Sesuatu', 1, 0, 'l');
        $pdf->Cell(150, 7, 'Nama      : Desi Handayani', 1, 1, 'l');
        $pdf->Cell(40, 7, '', 0, 0);
        $pdf->Cell(150, 7, 'Alamat     : Kp Citaman Rt 01/16, Kel Cibabat, Kec Cimahi Utara - Kota Cimahi', 1, 1, 'l');
        $pdf->Cell(190, 7, '*) Lingkari yang sesuai', 1, 1);


        $pdf->Cell(22, 7, 'Tanggal', 1, 0, 'l');
        $pdf->Cell(30, 7, 'Poliklinik Tujuan', 1, 0, 'l');
        $pdf->Cell(67, 7, 'Riwayat penyakit / Pemeriksaan', 1, 0, 'l');
        $pdf->Cell(23, 7, 'Diagnosa', 1, 0, 'l');
        $pdf->Cell(35, 7, 'Obat Terapi', 1, 0, 'l');
        $pdf->Cell(13, 7, 'Paraf', 1, 1, 'l');


        $pdf->Cell(22, 57, '', 1, 0, 'l');
        $pdf->Cell(30, 57, '', 1, 0, 'l');
        $pdf->Cell(67, 57, '', 1, 0, 'l');
        $pdf->Cell(23, 57, '', 1, 0, 'l');
        $pdf->Cell(35, 57, '', 1, 0, 'l');
        $pdf->Cell(13, 57, '', 1, 0, 'l');

        $pdf->Output();
    }

    /*
        START OF AUTOCOMPLETE FUNCTION
    */

    function autocomplate_dokter()
    {
        $term = $this->input->get("term");
        $id_poli = $this->input->get("id_poli");

        $dokter = $this->Tbl_jadwal_praktek_dokter_model->get($term, $id_poli);

        echo json_encode($dokter);
    }

    function ajax_pasien()
    {
        $term = $this->input->get("term");

        $this->db->like(["nama_pasien" => $term["term"]]);
        $this->db->limit(10);

        $pasien = $this->db->get('tbl_pasien')->result();

        echo json_encode($pasien);
    }

    function ajax_poliklinik()
    {
        $term = $this->input->get("term");

        $this->db->like(["nama_poliklinik" => $term["term"]]);
        $this->db->limit(10);

        $result = $this->db->get('tbl_poliklinik')->result();

        echo json_encode($result);
    }

    function ajax_tempat_tidur()
    {
        $term = $this->input->get("term");

        $this->db->like(["nama_poliklinik" => $term["term"]]);
        $this->db->limit(10);

        $result = $this->db->get('tbl_poliklinik')->result();

        echo json_encode($result);
    }
}

/* End of file Pendaftaran.php */
/* Location: ./application/controllers/Pendaftaran.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-04 08:39:11 */
/* http://harviacode.com */