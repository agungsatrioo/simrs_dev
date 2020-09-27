<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tbl_ruang_rawat_inap_model extends CI_Model
{

    public $table = 'tbl_ruang_rawat_inap';
    public $id = 'kode_ruang_rawat_inap';
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }

    // datatables
    function json()
    {
        $this->datatables->select('kode_ruang_rawat_inap,nama_gedung,nama_ruangan,nama_kelas_ruang_ranap as kelas,tarif');
        $this->datatables->from($this->table);

        $actions = "
        <div class=\"btn-group\" role=\"group\">
            <a href=\"".site_url('ruangranap/lihat/$1')."\" class=\"btn btn-sm btn-primary\"><i class=\"fa fa-list\"></i> Lihat</a>
            <a href=\"".site_url('ruangranap/update/$1')."\" class=\"btn btn-sm btn-default\"><i class=\"fa fa-pen\"></i> Edit</a>
            <a href=\"".site_url('ruangranap/delete/$1')."\" class=\"btn btn-sm btn-danger\" onclick=\"javascript: return confirm('Apakah Anda yakin?')\"><i class=\"fa fa-trash-alt\"></i> Hapus</a>
        </div>
        ";

        //add this line for join
        $this->datatables->join('tbl_gedung_rawat_inap', 'tbl_ruang_rawat_inap.kode_gedung_rawat_inap = tbl_gedung_rawat_inap.kode_gedung_rawat_inap');        
        
        $this->datatables->join('tbl_kelas_ruang_ranap', 'tbl_kelas_ruang_ranap.id_kelas_ruang_ranap = '.$this->table.'.kode_kelas');

        $this->datatables->add_column('action', $actions, 'kode_ruang_rawat_inap');

        $result = $this->datatables->generate();

        $decodedjson = json_decode($result);

        foreach ($decodedjson->data as $item) {
            $item->tarif = rupiah($item->tarif);
        }

        $result = json_encode($decodedjson);

        return $result;
    }

    function grup_kelas_ruangan($kode_gedung_rawat_inap) {
        return $this->ajax->select("kode_kelas, nama_kelas_ruang_ranap")
                          ->from($this->table)
                          ->where("tbl_ruang_rawat_inap.kode_gedung_rawat_inap" , $kode_gedung_rawat_inap)
                          ->join('tbl_gedung_rawat_inap', 'tbl_ruang_rawat_inap.kode_gedung_rawat_inap = tbl_gedung_rawat_inap.kode_gedung_rawat_inap')
                          ->join('tbl_kelas_ruang_ranap', 'tbl_kelas_ruang_ranap.id_kelas_ruang_ranap = '.$this->table.'.kode_kelas')
                          ->group_by("kode_kelas")
                          ->searchable_column(["nama_kelas_ruang_ranap"])
                          ->generate();
    }

    function get_ruangan() {
        return $this->ajax->select('kode_ruang_rawat_inap,nama_gedung,nama_ruangan, tarif')
                            ->from($this->table)
                            ->join('tbl_gedung_rawat_inap', 'tbl_ruang_rawat_inap.kode_gedung_rawat_inap = tbl_gedung_rawat_inap.kode_gedung_rawat_inap')
                            ->searchable_column(["nama_ruangan"])
                            ->generate();
    }

    function get($id = "", $q = "", $limit = 10, $start = 0)
    {
        $kode_gedung = $this->input->post('kode_gedung', TRUE);
        $kode_kelas = $this->input->post('kode_kelas', TRUE);

        $this->db->order_by($this->id, $this->order);

        if (!empty($id)) $this->db->where($this->id, $id);

        if (!empty($kode_gedung)) $this->db->where("{$this->table}.kode_gedung_rawat_inap", $kode_gedung);
        if (!empty($kode_kelas)) $this->db->where("kode_kelas", $kode_kelas);

        if (!empty($q)) {
            $this->db->like('kode_ruang_rawat_inap', $q);
            $this->db->or_like('kode_gedung_rawat_inap', $q);
            $this->db->or_like('nama_ruangan', $q);
            $this->db->or_like('nama_kelas_ruang_ranap', $q);
            $this->db->or_like('tarif', $q);
        }

        $this->db->join('tbl_gedung_rawat_inap', 'tbl_ruang_rawat_inap.kode_gedung_rawat_inap = tbl_gedung_rawat_inap.kode_gedung_rawat_inap');
        $this->db->join('tbl_kelas_ruang_ranap', 'tbl_kelas_ruang_ranap.id_kelas_ruang_ranap = '.$this->table.'.kode_kelas');

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
        return $this->get($id)->row();
    }

    // get total rows
    function total_rows($q = NULL)
    {
        return $this->get("", $q)->num_rows();
    }

    // get data with limit and search
    function get_limit_data($limit, $start = 0, $q = NULL)
    {
        return $this->get("", $q, $limit, $start)->result();
    }

    // insert data
    function insert($data)
    {
        return $this->db->insert($this->table, $data);
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
        $this->db->where($this->id, $id);
        return $this->db->delete($this->table);

    }

    /**
     * 
     * 
     */
}

/* End of file Tbl_ruang_rawat_inap_model.php */
/* Location: ./application/models/Tbl_ruang_rawat_inap_model.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-11-30 19:44:55 */
/* http://harviacode.com */