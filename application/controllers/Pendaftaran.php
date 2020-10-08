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
        $this->load->model(['Riwayat_perjalanan_model' => 'perjalanan']);
        $this->load->model(['Barang_model' => 'barang']);
        $this->load->model(['Tbl_tindakan_model' => 'tindakan']);
        $this->load->model(['Diary_model' => 'diary']);
        $this->load->library('datatables');
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

        $data['create_link'] = base_url("pendaftaran/create");

        return $data;
    }

    public function ralan()
    {
        $cara_masuk = "RALAN";

        $data = $this->olahDataRawat($cara_masuk);

        $data['json_url'] = api_url('dt_ralan');
        $data['file_name'] = "LAPORAN $cara_masuk";
        $data['title'] = "LAPORAN PASIEN $cara_masuk";
        $data['message'] = "";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list_new', $data);
    }

    public function ranap()
    {
        $cara_masuk = "RANAP";

        $data = $this->olahDataRawat($cara_masuk);

        $data['json_url'] = api_url("dt_ranap");
        $data['file_name'] = "LAPORAN $cara_masuk";
        $data['title'] = "LAPORAN PASIEN $cara_masuk";
        $data['message'] = "";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list_new', $data);
    } 
    
    public function history()
    {
        $cara_masuk = "HISTORI";

        $data = $this->olahDataRawat($cara_masuk);

        $data['json_url'] = api_url("dt_history");
        $data['file_name'] = "HISTORI PENDAFTARAN PASIEN";
        $data['title'] = "HISTORI PENDAFTARAN PASIEN";
        $data['message'] = "";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list_new', $data);
    }

    public function ugd()
    {
        $cara_masuk = "UGD";

        $data = $this->olahDataRawat($cara_masuk);

        $data['file_name'] = "LAPORAN $cara_masuk";
        $data['title'] = "LAPORAN PASIEN $cara_masuk";
        $data['message'] = "";

        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_list_new', $data);
    }

    public function index()
    {
        redirect("pendaftaran/ralan");
    }

    /*
    function dtl($id)
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
    }*/

    function detail($id)
    {
        $data = [];

        $data['info_pasien'] = $this->Tbl_pendaftaran_model->get($id)->row();

        $data['modal_obat']  = $this->load->view("pendaftaran/modals/modal_input_obat", $data, true);
        $data['modal_alkes']  = $this->load->view("pendaftaran/modals/modal_input_alkes", $data, true);
        $data['modal_ranap']  = $this->load->view("pendaftaran/modals/modal_input_ranap", $data, true);
        $data['modal_tindakan']  = $this->load->view("pendaftaran/modals/modal_input_tindakan", $data, true);

        $data['mutasi_url'] = base_url("pendaftaran/detail/%s/mutasi");
        $data['perjalanan_url'] = base_url("pendaftaran/detail/%s/perjalanan");
        $data['diary_url'] = base_url("pendaftaran/detail/%s/diary");

        $this->template->load('template', 'pendaftaran/detail/detail', $data);
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

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('pendaftaran/create_action'),
            'id' => set_value('id'),
            'id_gol_darah' => set_value('id_gol_darah'),
            'id_pekerjaan' => set_value('id_pekerjaan'),
            'id_agama' => set_value('id_agama'),
            'id_status_pernikahan' => set_value('id_status_pernikahan'),
            'id_alamat_kecamatan' => set_value('id_alamat_kecamatan'),
            'id_alamat_kota' => set_value('id_alamat_kota'),
            'no_kartu' => set_value('no_kartu'),
            'no_identitas' => set_value('no_identitas'),
            'id_jenis_kelamin' => set_value('id_jenis_kelamin'),
            'nama_ibu' => set_value('nama_ibu'),
            'tempat_lahir' => set_value('tempat_lahir'),
            'tgl_lahir' => set_value('tgl_lahir'),
            'nama_pasien' => set_value('nama_pasien'),
            'alamat' => set_value('alamat'),
            'no_telepon' => set_value('no_telepon'),
            'asal_rujukan' => set_value('asal_rujukan'),
            'id_rekamedis' => set_value('id_rekamedis'),
            'id_cara_masuk' => set_value('id_cara_masuk'),
            'id_status_rawat' => set_value('id_status_rawat'),
            'id_pj_dokter' => set_value('id_pj_dokter'),
            'id_poli' => set_value('id_poli'),
            'id_jenis_bayar' => set_value('id_jenis_bayar'),
            'tgl_daftar' => set_value('tgl_daftar'),
            'nama_pj' => set_value('nama_pj'),
            'id_hub_dg_pj' => set_value('id_hub_dg_pj'),
            'alamat_pj' => set_value('alamat_pj'),
            'no_identitas_pj' => set_value('no_identitas_pj'),
        );
        $this->template->load('template', 'pendaftaran/tbl_pendaftaran_form', $data);
    }

    public function mutasi($id_pendaftaran)
    {
        $data = [];

        $data['json_url'] = base_url("pendaftaran/ajax_mutasi");
        $data['info_pasien'] = $this->Tbl_pendaftaran_model->get($id_pendaftaran)->row();

        $data['backUrl'] = base_url("pendaftaran/detail/" . $id_pendaftaran);

        $this->template->load('template', 'pendaftaran/mutasi/mutasi_detail', $data);
    }

    public function create_action()
    {
        $this->_rules();

        $redirect_func = "";

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {

            /*
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
            }*/

            if ($this->Tbl_pendaftaran_model->insert_pendaftaran()) {
                $this->session->set_flashdata('success', "Berhasil membuat data.");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
            }


            redirect("pendaftaran");
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
                'id' => set_value('id', $row->id),
                'id_gol_darah' => set_value('id_gol_darah', $row->id_gol_darah),
                'id_pekerjaan' => set_value('id_pekerjaan', $row->id_pekerjaan),
                'id_agama' => set_value('id_agama', $row->id_agama),
                'id_status_pernikahan' => set_value('id_status_pernikahan', $row->id_status_pernikahan),
                'id_alamat_kecamatan' => set_value('id_alamat_kecamatan', $row->id_alamat_kecamatan),
                'id_alamat_kota' => set_value('id_alamat_kota', $row->id_alamat_kota),
                'no_kartu' => set_value('no_kartu', $row->no_kartu),
                'no_identitas' => set_value('no_identitas', $row->no_identitas),
                'id_jenis_kelamin' => set_value('id_jenis_kelamin', $row->id_jenis_kelamin),
                'nama_ibu' => set_value('nama_ibu', $row->nama_ibu),
                'tempat_lahir' => set_value('tempat_lahir', $row->tempat_lahir),
                'tgl_lahir' => set_value('tgl_lahir', $row->tgl_lahir),
                'nama_pasien' => set_value('nama_pasien', $row->nama_pasien),
                'alamat' => set_value('alamat', $row->alamat),
                'no_telepon' => set_value('no_telepon', $row->no_telepon),
                'asal_rujukan' => set_value('asal_rujukan', $row->asal_rujukan),
                'id_rekamedis' => set_value('id_rekamedis', $row->id_rekamedis),
                'id_cara_masuk' => set_value('id_cara_masuk', $row->id_cara_masuk),
                'id_status_rawat' => set_value('id_status_rawat', $row->id_status_rawat),
                'id_pj_dokter' => set_value('id_pj_dokter', $row->id_pj_dokter),
                'id_poli' => set_value('id_poli', $row->id_poli),
                'id_jenis_bayar' => set_value('id_jenis_bayar', $row->id_jenis_bayar),
                'tgl_daftar' => set_value('tgl_daftar', $row->tgl_daftar),
                'nama_pj' => set_value('nama_pj', $row->nama_pj),
                'id_hub_dg_pj' => set_value('id_hub_dg_pj', $row->id_hub_dg_pj),
                'alamat_pj' => set_value('alamat_pj', $row->alamat_pj),
                'no_identitas_pj' => set_value('no_identitas_pj', $row->no_identitas_pj),
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
            $this->update($this->input->post('id', TRUE));
        } else {
            $data = array(
                'id_gol_darah' => $this->input->post('id_gol_darah', TRUE),
                'id_pekerjaan' => $this->input->post('id_pekerjaan', TRUE),
                'id_agama' => $this->input->post('id_agama', TRUE),
                'id_status_pernikahan' => $this->input->post('id_status_pernikahan', TRUE),
                'id_alamat_kecamatan' => $this->input->post('id_alamat_kecamatan', TRUE),
                'id_alamat_kota' => $this->input->post('id_alamat_kota', TRUE),
                'no_kartu' => $this->input->post('no_kartu', TRUE),
                'no_identitas' => $this->input->post('no_identitas', TRUE),
                'id_jenis_kelamin' => $this->input->post('id_jenis_kelamin', TRUE),
                'nama_ibu' => $this->input->post('nama_ibu', TRUE),
                'tempat_lahir' => $this->input->post('tempat_lahir', TRUE),
                'tgl_lahir' => $this->input->post('tgl_lahir', TRUE),
                'nama_pasien' => $this->input->post('nama_pasien', TRUE),
                'alamat' => $this->input->post('alamat', TRUE),
                'no_telepon' => $this->input->post('no_telepon', TRUE),
                'asal_rujukan' => $this->input->post('asal_rujukan', TRUE),
                'id_rekamedis' => $this->input->post('id_rekamedis', TRUE),
                'id_cara_masuk' => $this->input->post('id_cara_masuk', TRUE),
                'id_status_rawat' => $this->input->post('id_status_rawat', TRUE),
                'id_pj_dokter' => $this->input->post('id_pj_dokter', TRUE),
                'id_poli' => $this->input->post('id_poli', TRUE),
                'id_jenis_bayar' => $this->input->post('id_jenis_bayar', TRUE),
                'tgl_daftar' => $this->input->post('tgl_daftar', TRUE),
                'nama_pj' => $this->input->post('nama_pj', TRUE),
                'id_hub_dg_pj' => $this->input->post('id_hub_dg_pj', TRUE),
                'alamat_pj' => $this->input->post('alamat_pj', TRUE),
                'no_identitas_pj' => $this->input->post('no_identitas_pj', TRUE),
            );

            if ($this->Tbl_pendaftaran_model->update($this->input->post('id', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }

            redirect(site_url('pendaftaran'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('id', 'id', 'trim');
        $this->form_validation->set_rules('id_gol_darah', 'id_gol_darah', 'trim');
        $this->form_validation->set_rules('id_pekerjaan', 'id_pekerjaan', 'trim');
        $this->form_validation->set_rules('id_agama', 'id_agama', 'trim');
        $this->form_validation->set_rules('id_status_pernikahan', 'id_status_pernikahan', 'trim');
        $this->form_validation->set_rules('id_alamat_kecamatan', 'id_alamat_kecamatan', 'trim');
        $this->form_validation->set_rules('id_alamat_kota', 'id_alamat_kota', 'trim');
        $this->form_validation->set_rules('no_kartu', 'no_kartu', 'trim');
        $this->form_validation->set_rules('no_identitas', 'no_identitas', 'trim');
        $this->form_validation->set_rules('id_jenis_kelamin', 'id_jenis_kelamin', 'trim');
        $this->form_validation->set_rules('nama_ibu', 'nama_ibu', 'trim');
        $this->form_validation->set_rules('tempat_lahir', 'tempat_lahir', 'trim');
        $this->form_validation->set_rules('tgl_lahir', 'tgl_lahir', 'trim');
        $this->form_validation->set_rules('nama_pasien', 'nama_pasien', 'trim');
        $this->form_validation->set_rules('alamat', 'alamat', 'trim');
        $this->form_validation->set_rules('no_telepon', 'no_telepon', 'trim');
        $this->form_validation->set_rules('asal_rujukan', 'asal_rujukan', 'trim');
        $this->form_validation->set_rules('id_rekamedis', 'id_rekamedis', 'trim');
        $this->form_validation->set_rules('id_cara_masuk', 'id_cara_masuk', 'trim');
        $this->form_validation->set_rules('id_status_rawat', 'id_status_rawat', 'trim');
        $this->form_validation->set_rules('id_pj_dokter', 'id_pj_dokter', 'trim');
        $this->form_validation->set_rules('id_poli', 'id_poli', 'trim');
        $this->form_validation->set_rules('id_jenis_bayar', 'id_jenis_bayar', 'trim');
        $this->form_validation->set_rules('tgl_daftar', 'tgl_daftar', 'trim');
        $this->form_validation->set_rules('nama_pj', 'nama_pj', 'trim');
        $this->form_validation->set_rules('id_hub_dg_pj', 'id_hub_dg_pj', 'trim');
        $this->form_validation->set_rules('alamat_pj', 'alamat_pj', 'trim');
        $this->form_validation->set_rules('no_identitas_pj', 'no_identitas_pj', 'trim');

        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }

    function periksa_action()
    {
        $no_rawat       = $this->input->post('no_rawat');

        if ($this->Tbl_pendaftaran_model->tambahRiwayatTindakan()) {
            $this->session->set_flashdata('message', 'Sukses menambah tindakan.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menambah data tindakan.');
        }

        redirect('pendaftaran/detail/' . $this->Tbl_pendaftaran_model->encode_no_rawat($no_rawat));
    }

    function beriobat_action()
    {
        $no_rawat       = $this->input->post('no_rawat');

        if ($this->Tbl_pendaftaran_model->tambahRiwayatBarang()) {
            $this->session->set_flashdata('message', 'Sukses menambah data obat');
        } else {
            $this->session->set_flashdata('error', 'Gagal menambah data obat');
        }

        redirect('pendaftaran/detail/' . $this->Tbl_pendaftaran_model->encode_no_rawat($no_rawat));
    }

    function do_beribarang()
    {
        $id_pendaftaran       = $this->input->post('id_pendaftaran', true);

        if ($this->Tbl_pendaftaran_model->do_beriobat()) {
            $this->session->set_flashdata('message', 'Sukses menambah data obat');
        } else {
            $this->session->set_flashdata('error', 'Gagal menambah data obat');
        }
        redirect('pendaftaran/detail/' . $id_pendaftaran);
    }

    function do_tindakan()
    {
        $id_pendaftaran = $this->input->post("id_pendaftaran", true);

        $data = [
            'id_pegawai' => $this->input->post('id_pegawai', TRUE),
            'id_dokter' => $this->input->post('id_dokter', TRUE),
            'id_tindakan' => $this->input->post('id_tindakan', TRUE),
            'id_pendaftaran' => $this->input->post('id_pendaftaran', TRUE),
            'hasil_periksa' => $this->input->post('hasil_periksa', TRUE),
            'perkembangan' => $this->input->post('perkembangan', TRUE),
        ];

        if ($this->db->insert("tbl_pendaftaran_riwayat_tindakan", stamp_insert($data))) {
            $this->session->set_flashdata('message', 'Sukses menambah data.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menambah data.');
        }
        redirect("pendaftaran/detail/$id_pendaftaran");
    }

    function periksa_labor_action()
    {
        $kode_periksa = $this->input->post('kode_periksa');

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

        $this->load->view('pendaftaran/riwayat_labor/riwayat_labor_out', $data);
    }

    /*
        START OF RIWAYAT PERJALANAN FUNCTION
    */

    function perjalanan($id)
    {
        $data = [];

        $data['info_pasien'] = $this->Tbl_pendaftaran_model->get($id)->row();

        $data['id_rekamedis'] = $data['info_pasien']->id_rekamedis;
        $data['back_url'] = base_url("pendaftaran/detail/" . $id);

        $id_rekamedis = $data['id_rekamedis'];

        $data['create_link'] = base_url("pendaftaran/detail/$id/perjalanan/create/");
        $data['file_name'] = "Laporan Riwayat Perjalanan Pasien";
        $data['title'] = "RIWAYAT PERJALANAN";
        $data['message'] = "";

        $this->template->load('template', 'pendaftaran/riwayat_perjalanan/list', $data);
    }

    function rj_form($id_pendaftaran, $id = null)
    {
        $row = [];

        $id_rj = "";
        $tgl_berangkat = "";
        $tgl_pulang = "";
        $keterangan = "";

        $data['info_pasien'] = $this->Tbl_pendaftaran_model->get($id_pendaftaran)->row();



        $id_rekamedis = $data['info_pasien']->id_rekamedis;

        $data = [
            'action' => base_url("pendaftaran/do_rj_create"),
        ];

        if (!empty($id)) {
            $row = $this->perjalanan->get($id);

            if (empty($row)) {
                $this->session->set_flashdata('error', 'Data riwayat perjalanan yang dimaksud tidak tersedia.');
                redirect(base_url("pendaftaran/riwayat_perjalanan/$id"));
            } else {
                $data['action'] = base_url("pendaftaran/do_rj_update");

                $id_rj = $row->id;
                $tgl_berangkat = $row->tgl_berangkat;
                $tgl_pulang = $row->tgl_pulang;
                $keterangan = $row->keterangan;
            }
        }

        $data = array_merge($data, [
            'id' => set_value('id', $id_rj),
            'id_pendaftaran' => set_value('id_pendaftaran', $id_pendaftaran),
            'id_rekamedis' => set_value('id_rekamedis', $id_rekamedis),
            'tgl_berangkat' => set_value('tgl_berangkat', $tgl_berangkat),
            'tgl_pulang' => set_value('tgl_pulang', $tgl_pulang),
            'keterangan' => set_value('keterangan', $keterangan),
        ]);

        $this->template->load('template', 'pendaftaran/riwayat_perjalanan/form', $data);
    }

    public function do_rj_create()
    {
        $id_rekamedis = $this->input->post("id_rekamedis", true);
        $id_pendaftaran = $this->input->post("id_pendaftaran", true);

        if ($this->perjalanan->insert()) {
            $this->session->set_flashdata('message', 'Sukses menambah data.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menambah data.');
        }
        redirect("pendaftaran/detail/$id_pendaftaran/perjalanan");
    }

    public function rj_delete($id, $id_rj)
    {
        if ($this->perjalanan->delete($id, $id_rj)) {
            $this->session->set_flashdata('message', 'Sukses menghapus data.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menghapus data.');
        }
        redirect("pendaftaran/detail/$id/perjalanan");
    }

    /*
        END OF RIWAYAT PERJALANAN FUNCTION
    */

    /**
     * 
     *  START OF DIARY FUNCTIONS
     * 
     */

    function diary($id_pendaftaran)
    {
        $data = [];

        $data['info_pasien'] = $this->Tbl_pendaftaran_model->get($id_pendaftaran)->row();

        $data['back_url'] = base_url("pendaftaran/detail/" . $id_pendaftaran);

        $data['create_link'] = base_url("pendaftaran/detail/$id_pendaftaran/diary/create/");
        $data['file_name'] = "Catatan HARIAN MEDIS Pasien";
        $data['title'] = "CATATAN HARIAN MEDIS PASIEN";
        $data['message'] = "";

        $this->template->load('template', 'pendaftaran/diary/list', $data);
    }

    function diary_form($id_pendaftaran, $id_diary = "")
    {
        $row = $this->Tbl_pendaftaran_model->get($id_pendaftaran)->row();

        $data = [
            'info_pasien' => $row,
            'action' => base_url("pendaftaran/do_diary_create"),
            'back_url' => base_url("pendaftaran/detail/$id_pendaftaran/diary"),
            'id_pendaftaran' => set_value('id_pendaftaran', $row->id),
            'isi' => set_value('isi'),
            'id' => set_value('id'),
        ];

        $this->template->load('template', 'pendaftaran/diary/form', $data);
    }

    function do_diary_create()
    {
        $id_pendaftaran = $this->input->post("id_pendaftaran", true);

        if ($this->diary->insert()) {
            $this->session->set_flashdata('message', 'Sukses menambah data.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menambah data.');
        }
        redirect("pendaftaran/detail/$id_pendaftaran/diary");
    }

    function diary_delete($id_pendaftaran, $id_diary)
    {
        if ($this->diary->delete($id_diary)) {
            $this->session->set_flashdata('message', 'Sukses menghapus data.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menghapus data.');
        }
        redirect("pendaftaran/detail/$id_pendaftaran/diary");
    }

    /**
     * 
     *  END OF DIARY FUNCTIONS
     * 
     */


    function to_ranap()
    {
        $id_pendaftaran = $this->input->post("id_pendaftaran", true);

        $data = [
            'id_pendaftaran' => $id_pendaftaran,
            'id_ruang_ranap' => $this->input->post('id_ruang_ranap', TRUE),
            'tgl_keluar' => $this->input->post('tgl_keluar', TRUE),
            'deposit_awal' => $this->input->post('deposit_awal', TRUE),
            'id_uic' => $this->input->post('id_uic', TRUE),
        ];

        if ($this->db->insert("bh_pendaftaran_ranap", stamp_insert($data))) {
            $this->session->set_flashdata('message', 'Sukses menambah data.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menambah data.');
        }
        redirect("pendaftaran/detail/$id_pendaftaran");
    }

    public function riwayat_barang_delete($id, $item)
    {
        if ($this->barang->delete_riwayat_barang($item)) {
            $this->session->set_flashdata('message', 'Sukses menghapus data.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menghapus data.');
        }
        redirect("pendaftaran/detail/$id");
    }

    public function riwayat_tindakan_delete($id, $item)
    {
        if ($this->tindakan->delete_riwayat_tindakan($item)) {
            $this->session->set_flashdata('message', 'Sukses menghapus data.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menghapus data.');
        }
        redirect("pendaftaran/detail/$id");
    }

    /**
     * 
     * START OF UBAH QTY FUNCTION
     * 
     */

    function ubah_qty($id_pendaftaran, $id_barang)
    {
        $row = $this->barang->get_riwayat_obat($id_barang);

        if (!empty($row)) {
            $data = [
                'action' => base_url("pendaftaran/do_ubah_qty"),
                'id' => set_value('id', $id_barang),
                'id_pendaftaran' => set_value('id_pendaftaran', $id_pendaftaran),
                'nama_barang' => set_value('nama_barang', $row->nama_barang),
                'qty' => set_value('qty', $row->qty),
            ];

            $this->template->load('template', 'pendaftaran/ubah_qty/ubah', $data);
        } else {
            $this->session->set_flashdata('error', 'Gagal mendapatkan data.');
            redirect(base_url("pendaftaran/detail/$id_pendaftaran"));
        }
    }

    function do_ubah_qty()
    {
        $id_pendaftaran = $this->input->post('id_pendaftaran', TRUE);
        $id_barang      = $this->input->post('id', TRUE);
        $qty            = $this->input->post('qty', TRUE);

        if ($this->barang->update_riwayat_barang($id_barang, $qty)) {
            $this->session->set_flashdata('message', 'Sukses mengubah jumlah barang.');
        } else {
            $this->session->set_flashdata('error', 'Sukses mengubah jumlah barang.');
        }
        redirect(base_url("pendaftaran/detail/$id_pendaftaran"));
    }
}