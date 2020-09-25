<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tbl_pendaftaran_model extends CI_Model
{

    public $table = 'tbl_pendaftaran';
    public $id = 'no_rawat';
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }


    function json($cara_masuk = "RAWAT JALAN", $kode_dokter = "")
    {
        $this->datatables->select('tbl_pendaftaran.no_registrasi, tbl_pendaftaran.no_rawat, tbl_pendaftaran.no_rekamedis, tbl_pasien.nama_pasien, cara_masuk, nama_dokter, nama_poliklinik, jenis_bayar, nama_ruangan');
        $this->datatables->from($this->table);
        $this->datatables->where("cara_masuk", $cara_masuk);

        $this->datatables->join('tbl_poliklinik', 'tbl_poliklinik.id_poliklinik=tbl_pendaftaran.id_poli');
        $this->datatables->join('tbl_pasien', 'tbl_pasien.no_rekamedis=tbl_pendaftaran.no_rekamedis');
        $this->datatables->join('tbl_jenis_bayar', 'tbl_jenis_bayar.id_jenis_bayar=tbl_pendaftaran.id_jenis_bayar');
        $this->datatables->join('tbl_dokter', 'tbl_dokter.kode_dokter=tbl_pendaftaran.kode_dokter_penanggung_jawab');

        $this->datatables->join('tbl_rawat_inap', 'tbl_rawat_inap.no_rawat = tbl_pendaftaran.no_rawat', 'left');
        $this->datatables->join('tbl_tempat_tidur', 'tbl_tempat_tidur.kode_tempat_tidur = tbl_rawat_inap.kode_tempat_tidur', 'left');
        $this->datatables->join('tbl_ruang_rawat_inap', 'tbl_ruang_rawat_inap.kode_ruang_rawat_inap = tbl_tempat_tidur.kode_ruang_rawat_inap', 'left');

        $actions = "
        <div class=\"btn-group\" role=\"group\">
            <a href=\"".base_url('pendaftaran/detail/$1')."\" class=\"btn btn-success\"><i class=\"fa fa-eye\"></i>&nbsp;Lihat</a>
        </div>
        ";

        $this->datatables->add_column('td_isi', '$1', 'str_placeholder(nama_ruangan, nama_poliklinik)');
        $this->datatables->add_column('action', $actions, 'enc_str(no_rawat)');

        $result = $this->datatables->generate();

        return $result;
    }

    function get($id = "", $q = "", $limit = 10, $start = 0, $cara_masuk = "", $kode_dokter = "")
    {
        if (!empty($id)) $this->db->where($this->id, $id);

        $this->db->order_by('tbl_pendaftaran.no_rawat', 'ASC');

        if (!empty($cara_masuk)) {
            $this->db->where('tbl_pendaftaran.cara_masuk', $cara_masuk);
        }

        if (!empty($kode_dokter)) {
            $this->db->where('tbl_pendaftaran.kode_dokter_penanggung_jawab', $kode_dokter);
        }

        if (!empty($q)) {
            $this->db->like('no_rawat', $q);
            $this->db->or_like('no_registrasi', $q);
            $this->db->or_like('no_rekamedis', $q);
            $this->db->or_like('cara_masuk', $q);
            $this->db->or_like('tanggal_daftar', $q);
            $this->db->or_like('kode_dokter_penanggung_jawab', $q);
            $this->db->or_like('id_poli', $q);
            $this->db->or_like('nama_penanggung_jawab', $q);
            $this->db->or_like('hubungan_dengan_penanggung_jawab', $q);
            $this->db->or_like('alamat_penanggung_jawab', $q);
            $this->db->or_like('id_jenis_bayar', $q);
            $this->db->or_like('asal_rujukan', $q);
        }

        $this->db->join('tbl_poliklinik', 'tbl_poliklinik.id_poliklinik=tbl_pendaftaran.id_poli');
        $this->db->join('tbl_pasien', 'tbl_pasien.no_rekamedis=tbl_pendaftaran.no_rekamedis');
        $this->db->join('tbl_jenis_bayar', 'tbl_jenis_bayar.id_jenis_bayar=tbl_pendaftaran.id_jenis_bayar');
        $this->db->join('tbl_dokter', 'tbl_dokter.kode_dokter=tbl_pendaftaran.kode_dokter_penanggung_jawab');

        $this->db->limit($limit, $start);

        return $this->db->get($this->table);
    }

    // get all
    function get_all()
    {
        return $this->get()->result();
    }

    // get data by id
    function get_by_id($id)
    {
        return $this->get($this->decode_no_rawat($id))->row();
    }

    // get total rows
    function total_rows($q = NULL)
    {
        return $this->get("", $q)->num_rows();
    }

    // get data with limit and search
    function get_limit_data($limit, $start = 0, $q = NULL, $cara_masuk, $kode_dokter = "")
    {
        $data = $this->get("", $q, $limit, $start, $cara_masuk, $kode_dokter)->result();

        foreach ($data as $item) {
            $item->no_rawat = $this->encode_no_rawat($item->no_rawat);
        }

        return $data;
    }

    function encode_no_rawat($str)
    {
        return str_replace('=', '-', str_replace('/', '_', base64_encode($str)));
    }

    function decode_no_rawat($str)
    {
        return base64_decode(str_replace('-', '=', str_replace('_', '/', $str)));
    }


    // insert data
    function insert($data)
    {
        $this->db->insert($this->table, $data);
    }

    // update data
    function update($id, $data)
    {
        $this->db->where($this->id, $id);
        return $this->db->update($this->table, $data);
    }

    // delete data
    function delete($id)
    {
        $this->db->where($this->id, $this->decode_no_rawat($id));
        $this->db->delete($this->table);
    }

    /**
     * Start of custom functions
     */


    function change2Ranap($decoded_noRawat) {
        $data = ["cara_masuk" => "RAWAT INAP"];

        return $this->update($decoded_noRawat, $data);
    }

    function insert2Ranap($data) {
        $data['tanggal_masuk'] = date("Y-m-d");

        return $this->db->insert("tbl_rawat_inap", $data);
    }

    function getRiwayatObatJson($decoded_noRawat) {
        return $this->datatables
                    ->select("")
                    ->from('tbl_riwayat_pemberian_obat')
                    ->join("tbl_obat_alkes_bhp", "tbl_obat_alkes_bhp.kode_barang = tbl_riwayat_pemberian_obat.kode_barang")
                    ->join("tbl_status_acc", "tbl_status_acc.id_status_acc = tbl_riwayat_pemberian_obat.id_status_acc")
                    ->where("no_rawat", $decoded_noRawat)
                    ->generate();
    }

    function getRiwayatObat($decoded_noRawat)
    {
        return $this->db->select("*")
            ->join("tbl_obat_alkes_bhp", "tbl_obat_alkes_bhp.kode_barang = tbl_riwayat_pemberian_obat.kode_barang")
            ->join("tbl_status_acc", "tbl_status_acc.id_status_acc = tbl_riwayat_pemberian_obat.id_status_acc")
            ->where("no_rawat", $decoded_noRawat)
            ->get('tbl_riwayat_pemberian_obat');
    }

    function getDataPasien($decoded_noRawat) {
        return $this->db->select("*")
                        ->join("tbl_pasien", "tbl_pasien.no_rekamedis = tbl_pendaftaran.no_rekamedis")
                        ->where("no_rawat", $decoded_noRawat)
                        ->get('tbl_pendaftaran');

    }
}

/* End of file Tbl_pendaftaran_model.php */
/* Location: ./application/models/Tbl_pendaftaran_model.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-04 08:39:11 */
/* http://harviacode.com */