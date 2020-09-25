<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Apotek_area extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_pegawai_model'); 
        $this->load->model(['Tbl_pendaftaran_model' => 'pendaftaran']); 
        $this->load->model(['Apotek_model' => 'apotek']); 
        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];

        $data['script'] = $this->load->view('area_apoteker/v_apoteker_home_js', $data, true);
        $this->template->load('template', 'area_apoteker/v_apoteker_home', $data);
    }

    public function apotek_ajax()
    {
        header('Content-Type: application/json');
        echo $this->apotek->ajax_apotek();
    }

    public function obat_ajax($no_rawat) {
        header('Content-Type: application/json');
        echo $this->apotek->ajax_obat($no_rawat);
    }

    public function lihat($id)
    {
        $data = [];

        $data['no_rawat'] = $id;

        $data['pendaftaran'] = $this->pendaftaran->getDataPasien(dec_str($id))->row_array();
        $data['script'] = $this->load->view('area_apoteker/v_apoteker_detail_js', $data, true);
        $this->template->load('template', 'area_apoteker/v_apoteker_detail', $data);
    }
}