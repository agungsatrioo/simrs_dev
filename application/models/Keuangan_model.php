<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Keuangan_model extends CI_Model
{
    public function ajax_keu() {
        $this->datatables->select('no_registrasi, no_rawat, nama_pasien, cara_masuk');
        $this->datatables->from('tbl_pendaftaran');

        $this->datatables->join('tbl_pasien', 'tbl_pasien.no_rekamedis = tbl_pendaftaran.no_rekamedis');

        $this->datatables->add_column('action', "<a href='keuangan_area/lihat/$1' class='btn btn-primary'>Lihat</a>", 'enc_str(no_rawat)');

        $result = $this->datatables->generate();

        return $result;
    }

    function ajax_obat($noRawat) {

        $approve_url = base_url('keuangan_area/approve/$1');
        $approve_html = "<a href='$approve_url' class='btn btn-success'> Terima</a>";

        return $this->datatables
                    ->select("id_riwayat, no_rawat, tbl_obat_alkes_bhp.kode_barang, nama_barang, tanggal, tbl_riwayat_pemberian_obat.id_status_acc, deskripsi_status_acc, harga, jumlah")
                    ->from('tbl_riwayat_pemberian_obat')
                    ->join("tbl_obat_alkes_bhp", "tbl_obat_alkes_bhp.kode_barang = tbl_riwayat_pemberian_obat.kode_barang")
                    ->join("tbl_status_acc", "tbl_status_acc.id_status_acc = tbl_riwayat_pemberian_obat.id_status_acc")
                    ->add_column('harga_readable', '$1', 'rupiah(harga)')
                    ->add_column('status', '$1', 'draw_acc(id_status_acc, deskripsi_status_acc)')
                    ->add_column('subtotal', '$1', 'jumlah_total(harga, jumlah)')
                    ->add_column('action', "$approve_html", 'id_riwayat')
                    ->where("no_rawat", dec_str($noRawat))
                    ->generate();
    }

    function encode_no_rawat($str)
    {
        return str_replace('=', '-', str_replace('/', '_', base64_encode($str)));
    }

    function decode_no_rawat($str)
    {
        return base64_decode(str_replace('-', '=', str_replace('_', '/', $str)));
    }

    function set_status($id_riwayat, $status = 2) {
        return $this->update_data(['id_riwayat' => $id_riwayat], ["id_status_acc" => $status], "tbl_riwayat_pemberian_obat");
    }

    function update_data($where,$data,$table){
		$this->db->where($where);
		return $this->db->update($table,$data);
	}	
}