<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Deposit_model extends CI_Model
{
    public $table = 'tbl_mutasi_deposit';
    public $pk    = 'id_mutasi';
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }

    private function insert($data)
    {
        return $this->db->insert($this->table, $data);
    }

    function add($no_rawat, $jumlah, $keterangan)
    {
        $data = [
            'no_rawat' => $no_rawat,
            'jumlah_mutasi' => $jumlah,
            'keterangan' => $keterangan,
            'user_in_charge' => $this->session->id_users
        ];

        return $this->insert($data);
    }

    function datatables_mutasi($no_rawat)
    {
        $result = $this->datatables->select("id_mutasi, {$this->table}.no_rawat, user_in_charge, tanggal_mutasi, jumlah_mutasi, keterangan")
            ->from($this->table)
            ->where("tbl_pendaftaran.no_rawat", $no_rawat)
            ->join("tbl_pendaftaran", "tbl_pendaftaran.no_rawat = {$this->table}.no_rawat")
            ->join("tbl_pasien", "tbl_pasien.no_rekamedis = tbl_pendaftaran.no_rekamedis", "left")
            ->add_column('mutasi_awal', '$1', 'jumlah_mutasi')
            ->add_column('mutasi_akhir', '$1', 'jumlah_mutasi')
            ->generate();

        $mutasi_awal = 0;
        $mutasi_akhir = 0;
        $i = 0;

        $json = json_decode($result);


        foreach ($json->data as $item) {
            $i++;

            $item->id_mutasi = $i;

            $item->mutasi_awal = $mutasi_awal;

            $mutasi_akhir = $mutasi_awal + $item->jumlah_mutasi;

            $item->mutasi_akhir = $mutasi_akhir;

            $mutasi_awal = $mutasi_akhir;

            //convert to rupiah format
            /*$item->mutasi_awal = number2rp($item->mutasi_awal);
            $item->jumlah_mutasi = number2rp($item->jumlah_mutasi);
            $item->mutasi_akhir = number2rp($item->mutasi_akhir);*/
        }

        return json_encode($json);
    }

    function saldo_akhir($no_rawat)
    {
        return $this->db->select_sum("jumlah_mutasi")
            ->where("no_rawat", $no_rawat)
            ->get($this->table)->row()->jumlah_mutasi;
    }

    function saldo_awal($no_rawat, $jumlah) {
        return $this->add($no_rawat, $jumlah, "DEPOSIT AWAL");
    }

    function ruang_inap($no_rawat, $kode_kasur, $tgl_masuk, $tgl_keluar) {
        $this->load->model(["Tbl_tempat_tidur_model" => "kasur"]);

        $d_in = strtotime($tgl_masuk);
        $d_out = strtotime($tgl_keluar);

        $kasur = $this->kasur->get($kode_kasur)->row();

        $datediff = $d_out - $d_in;
        $jml_hari = round($datediff / (60 * 60 * 24));
        $jml_muts = -$kasur->tarif * $jml_hari;

        return $this->add($no_rawat, $jml_muts, "BIAYA RAWAT INAP DI RUANGAN \"{$kasur->nama_ruangan}\" SELAMA {$jml_hari} HARI");
    }

    function beli_barang($no_rawat, $kode_barang, $jumlah_pembelian)
    {
        $this->load->model(['Tbl_obat_alkes_bhp_model' => 'barang']);

        $barang = $this->barang->get_by_id($kode_barang);

        $keterangan = "PEMBELIAN \"{$barang->nama_barang}\" (KODE BARANG: \"{$barang->kode_barang}\") SEJUMLAH $jumlah_pembelian {$barang->nama_satuan}";

        $jumlah_mutasi = $barang->harga * $jumlah_pembelian;

        return $this->add($no_rawat, -$jumlah_mutasi, $keterangan);
    }

    function return_barang($no_rawat, $kode_barang, $jumlah_kembali) {
        $this->load->model(['Tbl_obat_alkes_bhp_model' => 'barang']);

        $barang = $this->barang->get_by_id($kode_barang);

        $keterangan = "PENGEMBALIAN \"{$barang->nama_barang}\" (KODE BARANG: \"{$barang->kode_barang}\") SEJUMLAH $jumlah_kembali {$barang->nama_satuan}";

        $jumlah_mutasi = $barang->harga * $jumlah_kembali;

        return $this->add($no_rawat, $jumlah_mutasi, $keterangan);
    }

    function tindakan($no_rawat, $kode_tindakan) {
        $this->load->model(['Tbl_tindakan_model' => 'tindakan']);

        $tindakan = $this->tindakan->get_by_id($kode_tindakan);
        $tarif = -$tindakan->tarif;

        return $this->add($no_rawat, $tarif, "PEMBERIAN TINDAKAN \"{$tindakan->nama_tindakan}\"");
    }

    function periksalabor($no_rawat, $kode_periksa) {
        $this->load->model(['Tbl_pemeriksaan_laboratorium_model' => 'labor']);

        $periksa = $this->labor->get_by_id($kode_periksa);
        $tarif = -$periksa->tarif;

        return $this->add($no_rawat, $tarif, "PEMERIKSAAN KESEHATAN \"{$periksa->nama_periksa}\"");
    }
}
