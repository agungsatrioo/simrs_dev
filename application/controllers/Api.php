<?php
defined('BASEPATH') or exit('No direct script access allowed');

use chriskacerguis\RestServer\RestController;

class Api extends RestController
{

    function __construct()
    {
        parent::__construct();
        $this->load->library(['ajax', 'datatables']);
        $this->load->model([
            "Tbl_pendaftaran_model" => "pendaftaran",
            "Tbl_poliklinik_model" => "poliklinik",
            "Tbl_jadwal_praktek_dokter_model" => "jadwal_dokter",
            "Barang_model" => "barang",
            "Deposit_model" => "deposit",
            "Riwayat_perjalanan_model" => "perjalanan",
            "Diary_model" => "diary",
        ]);
    }

    public function rekamedis_post()
    {
        $this->response(json_decode($this->pendaftaran->rekamedis()), 200);
    }
    
    public function poliklinik_post()
    {
        $this->response(json_decode($this->poliklinik->ajax()), 200);
    }

    public function jadwal_dokter_post() {
        $this->response(json_decode($this->jadwal_dokter->jadwal_all()), 200);
    }
    
    public function pendaftaran_post() {
        $this->response(json_decode($this->pendaftaran->dt()), 200);
    }

    function barang_get() {
        $this->response(json_decode($this->barang->ajax()), 200);
    }
    
    function obat_post() {
        $kelompok = 1;
        $this->response(json_decode($this->barang->ajax(null, $kelompok)), 200);
    }
    
    function dt_riwayat_obat_post() {
        $id_pendaftaran = $this->input->post("id_pendaftaran", true);

        $this->response(json_decode($this->pendaftaran->dt_riwayat_obat($id_pendaftaran), 200));
    } 
    
    function dt_riwayat_alkes_post() {
        $id_pendaftaran = $this->input->post("id_pendaftaran", true);

        $this->response(json_decode($this->pendaftaran->dt_riwayat_alkes($id_pendaftaran), 200));
    }

    function dt_mutasi_post() {
        $id_pendaftaran = $this->input->post("id_pendaftaran", true);

        $this->response(json_decode($this->deposit->dt_mutasi($id_pendaftaran), 200));
    }
    
    function dt_rj_post() {
        $id_rekamedis = $this->input->post("id_rekamedis", true);
        $id_pendaftaran = $this->input->post("id_pendaftaran", true);

        $this->response(json_decode($this->perjalanan->dt($id_rekamedis, $id_pendaftaran), 200));
    }

    function dt_diary_post() {
        $id_pendaftaran = $this->input->post("id_pendaftaran", true);

        $this->response(json_decode($this->diary->dt($id_pendaftaran), 200));

    }
}
