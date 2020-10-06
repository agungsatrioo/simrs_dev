<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tbl_ruang_rawat_inap_model extends CI_Model
{

    public $table = 'tbl_rs_ruang';
    public $id = 'id';
    public $pk = "tbl_rs_ruang.id";
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }

    // datatables
    function json()
    {
        $this->datatables->select('tbl_rs_ruang.id, kode_ruang, id_ranap_gedung, nama_gedung,nama_ruangan,nama_kelas_ruang_ranap as kelas,tarif');
        $this->datatables->from($this->table);

        $actions = "
        <div class=\"btn-group\" role=\"group\">
            <a href=\"".site_url('ruangranap/lihat/$1')."\" class=\"btn btn-sm btn-primary\"><i class=\"fa fa-list\"></i> Lihat</a>
            <a href=\"".site_url('ruangranap/update/$1')."\" class=\"btn btn-sm btn-default\"><i class=\"fa fa-pen\"></i> Edit</a>
            <a href=\"".site_url('ruangranap/delete/$1')."\" class=\"btn btn-sm btn-danger\" onclick=\"javascript: return confirm('Apakah Anda yakin?')\"><i class=\"fa fa-trash-alt\"></i> Hapus</a>
        </div>
        ";

        //add this line for join
        $this->datatables->join('tbl_rs_gedung', 'tbl_rs_ruang.id_ranap_gedung = tbl_rs_gedung.id');        
        
        $this->datatables->join('tbl_rs_ruang_kelas', 'tbl_rs_ruang_kelas.id = '.$this->table.'.id_ruang_kelas');

        $this->datatables->add_column('action', $actions, 'id');

        $result = $this->datatables->generate();

        $decodedjson = json_decode($result);

        foreach ($decodedjson->data as $item) {
            $item->tarif = rupiah($item->tarif);
        }

        $result = json_encode($decodedjson);

        return $result;
    }

    function grup_kelas_ruangan($id_ranap_gedung) {
        return $this->ajax->select("id_ruang_kelas, nama_kelas_ruang_ranap")
                          ->from($this->table)
                          ->where("tbl_rs_ruang.id" , $id_ranap_gedung)
                          ->join('tbl_rs_gedung', 'tbl_rs_ruang.id = tbl_rs_gedung.id_ranap_gedung')
                          ->join('tbl_rs_ruang_kelas', 'tbl_rs_ruang_kelas.id_kelas_ruang_ranap = '.$this->table.'.id_ruang_kelas')
                          ->group_by("id_ruang_kelas")
                          ->searchable_column(["nama_kelas_ruang_ranap"])
                          ->generate();
    }

    function get_ruangan() {
        return $this->ajax->select($this->table.'.id,nama_gedung,nama_ruangan, tarif')
                            ->from($this->table)
                            ->join('tbl_rs_gedung', 'tbl_rs_ruang.id = tbl_rs_gedung.id_ranap_gedung')
                            ->searchable_column(["nama_ruangan"])
                            ->generate();
    }

    function get($id = "", $q = "", $limit = 10, $start = 0)
    {
        $kode_gedung = $this->input->post('kode_gedung', TRUE);
        $id_ruang_kelas = $this->input->post('id_ruang_kelas', TRUE);

        $this->db->select("*, {$this->pk}");
        $this->db->order_by($this->table . "." .$this->id, $this->order);

        if (!empty($id)) $this->db->where($this->table . "." .$this->id, $id);

        if (!empty($kode_gedung)) $this->db->where("{$this->table}.id", $kode_gedung);
        if (!empty($id_ruang_kelas)) $this->db->where("id_ruang_kelas", $id_ruang_kelas);

        if (!empty($q)) {
            $this->db->like($this->table.'.id', $q);
            $this->db->or_like('id_ranap_gedung', $q);
            $this->db->or_like('nama_ruangan', $q);
            $this->db->or_like('nama_kelas_ruang_ranap', $q);
            $this->db->or_like('tarif', $q);
        }

        $this->db->join('tbl_rs_gedung', 'tbl_rs_ruang.id_ranap_gedung = tbl_rs_gedung.id');
        $this->db->join('tbl_rs_ruang_kelas', 'tbl_rs_ruang_kelas.id = '.$this->table.'.id_ruang_kelas');

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
        return $this->db->insert($this->table, stamp($data));
    }

    // update data
    function update($id, $data)
    {
        $this->db->where($this->id, $id);
        return $this->db->update($this->table, stamp($data));
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