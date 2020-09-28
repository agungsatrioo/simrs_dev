<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Pendaftaran extends Private_Controller
{
    /**
     * TODO: 
     * - Beri fitur cetak pada  detail pendaftaran
     * - Pemeriksaan menggunakan select2
     * - Tambahkan kelas ruangan
     * - Tambahkan sistem deposit di rawat inap
     * - Kelebihan biaya ditanggung pasien
     */

    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_pendaftaran_model');
        $this->load->model('Tbl_jadwal_praktek_dokter_model');
        $this->load->model('Antrean_model');
        $this->load->model(['Deposit_model' => 'deposit']);
        $this->load->library('datatables');
    }

    public function json_ralan()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_pendaftaran_model->json("RAWAT JALAN");
    }

    public function json_ranap()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_pendaftaran_model->json("RAWAT INAP");
    }

    public function json_ugd()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_pendaftaran_model->json("UGD");
    }

    private function olahDataRawat($cara_masuk)
    {
        $enable = true;

        $user_level = $this->session->id_user_level;

        switch ($user_level) {
            case 3: //dokter
                $kd_dokter = $this->session->kode_dokter;
                $enable = false;
                break;
        }

        $data = array(
            'enable' => $enable
        );

        switch ($cara_masuk) {
            case "RAWAT JALAN":
                $data['json_url'] = base_url("pendaftaran/json_ralan");
                break;
            case "RAWAT INAP":
                $data['json_url'] = base_url("pendaftaran/json_ranap");
                break;
            case "UGD":
                $data['json_url'] = base_url("pendaftaran/json_ugd");
                break;
        }

        if ($this->router->fetch_method() == "ranap") {
            $data["head_rawat"] = "Kamar Tidur";
            $data["is_ralan"] = false;
        } else {
            $data["head_rawat"] = "Poliklinik";
            $data["is_ralan"] = true;
        }

        $data['script'] = $this->load->view('pendaftaran/tbl_pendaftaran_list_js', $data, true);

        return $data;
    }

    public function ralan()
    {
        $cara_masuk = "RAWAT JALAN";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list_new', $this->olahDataRawat($cara_masuk));
    }

    public function ranap()
    {
        $cara_masuk = "RAWAT INAP";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list_new', $this->olahDataRawat($cara_masuk));
    }

    public function ugd()
    {
        $cara_masuk = "UGD";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list_new', $this->olahDataRawat($cara_masuk));
    }

    public function index()
    {
        redirect("pendaftaran/ralan");
    }

    function detail($id)
    {
        $no_rawat = $this->Tbl_pendaftaran_model->get_by_id($id)->no_rawat;

        $sql_tindakan = "SELECT tt.*,tr.* 
                        FROM tbl_riwayat_tindakan as tr,tbl_tindakan as tt
                        WHERE tr.kode_tindakan=tt.kode_tindakan and tr.no_rawat='$no_rawat'";

        $sql_labor    = "SELECT tp.*,tr.* 
                        FROM tbl_pemeriksaan_laboratorium as tp, tbl_riwayat_pemeriksaan_laboratorium as  tr
                        WHERE tr.kode_periksa=tp.kode_periksa and tr.no_rawat='$no_rawat'";

        $data['no_rawat'] = $no_rawat;

        $data['pendaftaran'] =  $this->Tbl_pendaftaran_model->getDataPasien($no_rawat)->row_array();
        $data['riwayat_obat'] = $this->Tbl_pendaftaran_model->getRiwayatObat($no_rawat)->result();

        foreach ($data['riwayat_obat'] as $item) {
            $item->status_acc = $this->template->drawStatusAcc($item->id_status_acc, $item->deskripsi_status_acc);
        }

        $data['tindakan'] = $this->db->query($sql_tindakan)->result();
        $data['riwayat_labor'] = $this->db->query($sql_labor)->result();

        $data['isUGD'] = $data['pendaftaran']['cara_masuk'] == "UGD";
        $data['isRawatInap'] = $data['pendaftaran']['cara_masuk'] == "RAWAT INAP";

        $data['saldo'] = $this->deposit->saldo_akhir($no_rawat);

        if ($data['saldo'] < 0) {
            $data['kurangnya'] = rupiah(abs($data['saldo']));
        } else {
            $data['kurangnya'] = rupiah(0);
        }

        $data['modal_ranap'] = $this->load->view('pendaftaran/modals/modal_input_ranap', $data, true);
        $data['modal_tindakan'] = $this->load->view('pendaftaran/modals/modal_input_tindakan', $data, true);
        $data['modal_labor'] = $this->load->view('pendaftaran/modals/modal_input_labor', $data, true);

        $data['script'] = $this->load->view('pendaftaran/tbl_pendaftaran_detail_js', $data, true);


        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_detail', $data);
    }

    public function get_poli($nama)
    {
        $this->db->where("nama_satuan", $nama);
        return $this->db->get("tbl_satuan_barang")->row();
    }

    public function ugd2ranap_action()
    {
        $data = $this->input->post();

        $data["tanggal_masuk"] = date("Y-m-d");

        unset($data['nama_gedung']);
        unset($data['kode_gedung']);
        unset($data['kode_kelas']);
        unset($data['kode_ruang']);

        $pendaftaran_update = $this->Tbl_pendaftaran_model->change2Ranap($data['no_rawat']);

        if ($pendaftaran_update) {
            $ranap_update = $this->Tbl_pendaftaran_model->insert2Ranap($data);

            if ($ranap_update) {
                $this->session->set_flashdata('message', 'Berhasil membuat data.');
            } else {
                $this->session->set_flashdata('message', 'Gagal membuat data rawat inap.');
            }
            redirect(base_url("pendaftaran/ranap"));
        } else {
            echo $pendaftaran_update;

            $this->session->set_flashdata('message', 'Gagal membuat data rawat inap.');
            redirect(base_url("pendaftaran/detail/" . enc_str($data['no_rawat'])));
        }
    }

    public function ajax_mutasi()
    {
        $data = $this->input->post("no_rawat");

        echo $this->deposit->datatables_mutasi(dec_str($data));
    }

    public function ajax_mutasi_test()
    {
        echo $this->deposit->datatables_mutasi("2020/09/26/0003");
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
            'asal_rujukan' => "-",
        );
        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_form_new', $data);
    }

    public function mutasi($encoded_no_rawat)
    {
        $data = [];

        $data['json_url'] = base_url("pendaftaran/ajax_mutasi");
        $data['encodedNoRawat'] = $encoded_no_rawat;

        $data['backUrl'] = base_url("pendaftaran/detail/" . $encoded_no_rawat);

        $data['script'] = $this->load->view('pendaftaran/mutasi/mutasi_detail_js', $data, true);

        $this->template->load('template', 'pendaftaran/mutasi/mutasi_detail', $data);
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
                if ($this->db->update('tbl_tempat_tidur', array('status' => 'diisi'))) {
                    $this->session->set_flashdata('success', "Berhasil memperbarui data.");
                } else {
                    $this->session->set_flashdata('error', "Gagal memperbarui data.");
                }



                $redirect_func = site_url('pendaftaran/ranap');
            } else {
                $redirect_func = site_url('pendaftaran/ralan');
            }

            if ($this->Tbl_pendaftaran_model->insert($data)) {
                $this->session->set_flashdata('success', "Berhasil membuat data.");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
            }


            redirect($redirect_func);
        }
    }

    public function ugd2ranap($no_rawat)
    {
        $data_ranap = array(
            'no_rawat'              =>  $no_rawat,
            'tanggal_masuk'         =>  $this->input->post('tanggal_daftar', TRUE),
            'tanggal_keluar'        =>  $this->input->post('tanggal_keluar', TRUE),
            'kode_tempat_tidur'     =>  $this->input->post('kode_tempat_tidur', TRUE)
        );
        $this->db->insert('tbl_rawat_inap', $data_ranap);

        $this->db->where('kode_tempat_tidur', $this->input->post('kode_tempat_tidur', TRUE));
        if ($this->db->update('tbl_tempat_tidur', array('status' => 'diisi'))) {
            $this->session->set_flashdata('success', "Berhasil memperbarui data.");
        } else {
            $this->session->set_flashdata('error', "Gagal memperbarui data.");
        }
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

            if ($this->Tbl_pendaftaran_model->update($this->input->post('no_rawat', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }

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

    function periksa_action()
    {
        if (false) {
            print_r($this->input->post());
            die();
        }

        $tindakan       = $this->input->post('id_tindakan');
        $hasil_periksa  = $this->input->post('hasil_periksa');
        $perkembangan   = $this->input->post('perkembangan');
        $no_rawat       = $this->input->post('no_rawat');

        $id_dokter = $this->input->post('id_dokter');
        $id_petugas = $this->input->post('id_petugas');

        $data = array(
            'no_rawat'      =>  $no_rawat,
            'hasil_periksa' =>  $hasil_periksa,
            'perkembangan'  =>  $perkembangan,
            'kode_tindakan' =>  $tindakan,
            'tanggal'       =>  date('Y-m-d'),
            'id_dokter'     => $id_dokter,
            'id_pegawai'    => $id_petugas
        );

        if ($this->db->insert('tbl_riwayat_tindakan', $data)) {
            if ($this->deposit->tindakan($no_rawat, $tindakan)) {
                $this->session->set_flashdata('message', 'Sukses memberi tindakan');
            } else {
                $this->session->set_flashdata('error', 'Sukses memberi tindakan, namun gagal menambahkan ke data mutasi.');
            }
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

        if ($this->db->insert('tbl_riwayat_pemberian_obat', $data)) {
            if ($this->deposit->beli_barang($no_rawat, $kode_barang, $jumlah)) {
                $this->session->set_flashdata('message', 'Sukses menambah data obat');
            } else {
                $this->session->set_flashdata('error', 'Sukses menambah data obat, namun gagal menambah data mutasi.');
            }
        } else {
            $this->session->set_flashdata('error', 'Gagal menambah data obat');
        }

        redirect('pendaftaran/detail/' . $this->Tbl_pendaftaran_model->encode_no_rawat($no_rawat));
    }

    function sub_periksa_labor_ajax()
    {
        $kode_periksa = $this->input->get('kode_periksa');

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
        $kode_periksa = $this->input->post('kode_periksa');

        // insert tabel riwaway pemeriksaan laboratorium

        $riwayat_labor = array(
            'no_rawat'      =>  $this->input->post('no_rawat'),
            'tanggal'       =>  date('Y-m-d'),
            'kode_periksa'  =>  $kode_periksa
        );

        $this->deposit->periksalabor($this->input->post('no_rawat'), $kode_periksa);

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
        redirect('pendaftaran/detail/' . enc_str($no_rawat));
    }

    function cetak_riwayat_labor($enc_no_rawat)
    {
        $no_rawat = dec_str($enc_no_rawat);

        $sql_labor    = "SELECT tp.*,tr.* 
        FROM tbl_pemeriksaan_laboratorium as tp, tbl_riwayat_pemeriksaan_laboratorium as  tr
        WHERE tr.kode_periksa=tp.kode_periksa and tr.no_rawat='$no_rawat'";

        $data['pendaftaran'] =  $this->Tbl_pendaftaran_model->getDataPasien($no_rawat)->row_array();
        $data['riwayat_labor'] = $this->db->query($sql_labor)->result();

        $data['isUGD'] = $data['pendaftaran']['cara_masuk'] == "UGD";
        $data['isRawatInap'] = $data['pendaftaran']['cara_masuk'] == "RAWAT INAP";

        $this->load->view('pendaftaran/riwayat_labor/riwayat_labor_out',$data);
    }

    /*
        START OF AUTOCOMPLETE FUNCTION
    */

    function autocomplate_dokter()
    {
        $term = $this->input->get("term");

        $dokter = $this->Tbl_jadwal_praktek_dokter_model->get($term);

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