<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Apotek_model extends CI_Model
{
    public function ajax_apotek()
    {
        $this->datatables->select('no_registrasi, no_rawat, nama_pasien, cara_masuk');
        $this->datatables->from('tbl_pendaftaran');

        $this->datatables->join('tbl_pasien', 'tbl_pasien.no_rekamedis = tbl_pendaftaran.no_rekamedis');

        $this->datatables->add_column('action', "<a href='apotek_area/lihat/$1' class='btn btn-primary'>Lihat</a>", 'enc_str(no_rawat)');

        $result = $this->datatables->generate();

        return $result;
    }

    function ajax_obat($noRawat)
    {
        return $this->datatables
            ->select("id_riwayat, no_rawat, tbl_obat_alkes_bhp.kode_barang, nama_barang, tanggal, tbl_riwayat_pemberian_obat.id_status_acc, deskripsi_status_acc, harga, jumlah")
            ->from('tbl_riwayat_pemberian_obat')
            ->where("tbl_riwayat_pemberian_obat.id_status_acc", 2)
            ->join("tbl_obat_alkes_bhp", "tbl_obat_alkes_bhp.kode_barang = tbl_riwayat_pemberian_obat.kode_barang")
            ->join("tbl_status_acc", "tbl_status_acc.id_status_acc = tbl_riwayat_pemberian_obat.id_status_acc")
            ->add_column('harga_readable', '$1', 'rupiah(harga)')
            ->add_column('status', '$1', 'draw_acc(id_status_acc, deskripsi_status_acc)')
            ->add_column('subtotal', '$1', 'jumlah_total(harga, jumlah)')
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
}
