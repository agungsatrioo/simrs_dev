<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Keuangan_model extends CI_Model
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
            "Tbl_gedung_rawat_inap_model" => "gedung",
            "Tbl_ruang_rawat_inap_model" => "ruang",
            "Tbl_tindakan_model" => "tindakan",
        ]);
    }

    function set_status($table, $id_riwayat, $status = 2) {
        return $this->update_data(
            ['id' => $id_riwayat], 
            ["id_status_acc" => $status], $table
        );
    }

    function update_data($where,$data,$table){
		$this->db->where($where);
		return $this->db->update($table,stamp_update($data));
    }	
    
    function get_tunggakan($id_pendaftaran) {
        $result = new stdClass();

        $result->result = true;
        $result->msg = "";

        $brg = $this->barang->tunggakan_barang($id_pendaftaran);
        $tnd = $this->tindakan->tunggakan_tindakan($id_pendaftaran);

        if(!empty($brg)) {
            $result->result = false;
            $result->msg = "Pasien yang bersangkutan memiliki tunggakan biaya obat/alat kesehatan.";
        } elseif(!empty($tnd)) {
            $result->result = false;
            $result->msg = "Pasien yang bersangkutan memiliki tunggakan biaya tindakan.";
        }

        return $result;
    }
}