<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Apoteker_area extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_pegawai_model');
        $this->load->model(['Tbl_pendaftaran_model' => 'pendaftaran', "Deposit_model" => "deposit", "Keuangan_model" => 'keuangan']);
        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];

        $data['json_url'] = api_url("dt_apoteker");
        $data['file_name'] = "LAPORAN KEUANGAN";
        $data['title'] = "LAPORAN KEUANGAN";
        $data['message'] = "";

        $this->template->load('template', 'apoteker_area/v_apoteker_home', $data);
    }

    function detail($id)
    {
        $data = [];

        $data['info_pasien'] = $this->pendaftaran->get($id)->row();

        $data['mutasi_url'] = base_url("apoteker_area/detail/%s/mutasi");

        $this->template->load('template', 'apoteker_area/v_apoteker_detail', $data);
    }

    public function barang_approve($id_pendaftaran, $id)
    {
        $status = $this->keuangan->set_status("tbl_pendaftaran_riwayat_obat", $id);

        if ($status) {
            $this->session->set_flashdata('message', 'Berhasil menyetujui obat/alat kesehatan.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menyetujui obat/alat kesehatan.');
        }

        redirect(base_url("apoteker_area/detail/$id_pendaftaran"));
    }

    public function barang_reject($id_pendaftaran, $id)
    {
        $status = $this->keuangan->set_status("tbl_pendaftaran_riwayat_obat", $id, 3);

        if ($status) {
            $this->session->set_flashdata('message', 'Berhasil menolak obat/alat kesehatan.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menolak obat/alat kesehatan.');
        }

        redirect(base_url("apoteker_area/detail/$id_pendaftaran"));
    }

    public function tindakan_approve($id_pendaftaran, $id)
    {
        $status = $this->keuangan->set_status("tbl_pendaftaran_riwayat_tindakan", $id);

        if ($status) {
            $this->session->set_flashdata('message', 'Berhasil menyetujui tindakan.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menyetujui tindakan.');
        }

        redirect(base_url("apoteker_area/detail/$id_pendaftaran"));
    }

    public function tindakan_reject($id_pendaftaran, $id)
    {
        $status = $this->keuangan->set_status("tbl_pendaftaran_riwayat_tindakan", $id, 3);

        if ($status) {
            $this->session->set_flashdata('message', 'Berhasil menolak tindakan.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menolak tindakan.');
        }

        redirect(base_url("apoteker_area/detail/$id_pendaftaran"));
    }
}
