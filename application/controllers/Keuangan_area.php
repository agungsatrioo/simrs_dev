<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Keuangan_area extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_pegawai_model');
        $this->load->model(['Tbl_pendaftaran_model' => 'pendaftaran']);
        $this->load->model('Keuangan_model');
        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];

        $data['script'] = $this->load->view('keuangan_area/v_keuangan_home_js', $data, true);
        $this->template->load('template', 'keuangan_area/v_keuangan_home', $data);
    }

    public function keu_ajax()
    {
        header('Content-Type: application/json');
        echo $this->Keuangan_model->ajax_keu();
    }

    public function obat_ajax($no_rawat)
    {
        header('Content-Type: application/json');
        echo $this->Keuangan_model->ajax_obat($no_rawat);
    }

    public function lihat($id)
    {
        $data = [];

        $data['no_rawat'] = $id;

        $data['pendaftaran'] = $this->pendaftaran->getDataPasien(dec_str($id))->row_array();
        $data['script'] = $this->load->view('keuangan_area/v_keuangan_detail_js', $data, true);
        $this->template->load('template', 'keuangan_area/v_keuangan_detail', $data);
    }

    public function approve($no_rawat, $id)
    {
        $status = $this->Keuangan_model->set_status($id);

        if ($status) {
            $this->session->set_flashdata('message', 'Berhasil menyetujui obat.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menyetujui obat.');
        }

        redirect(base_url("keuangan_area/lihat/$no_rawat"));
    }

    public function reject($no_rawat, $id)
    {
        $status = $this->Keuangan_model->set_status($id, 3);

        if ($status) {
            $this->session->set_flashdata('message', 'Berhasil menolak obat.');
        } else {
            $this->session->set_flashdata('error', 'Gagal menolak obat.');
        }

        redirect(base_url("keuangan_area/lihat/$no_rawat"));
    }
}
