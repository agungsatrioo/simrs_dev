<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tbl_pasien_model extends CI_Model
{

    public $table = 'tbl_pasien';
    public $table_bh = 'bh_pasien';
    public $id = 'id';
    public $pk = "tbl_pasien.id";
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }

    function json()
    {
        $this->datatables->select("{$this->pk}, no_kartu, nama_pasien, nama_jk, id_jenis_kelamin, nama_gol_darah, tempat_lahir, tgl_lahir, nama_ibu, nama_status_menikah");
        $this->datatables->from($this->table);

        $actions = "
        <div class=\"btn-group\" role=\"group\">
            <a href=\"".site_url('pasien/update/$1')."\" class=\"btn btn-sm btn-default\"><i class=\"fa fa-pen\"></i> Edit</a>
            <a href=\"".site_url('pasien/delete/$1')."\" class=\"btn btn-sm btn-danger\" onclick=\"javascript: return confirm('Apakah Anda yakin?')\"><i class=\"fa fa-trash-alt\"></i> Hapus</a>
        </div>
        ";

        $this->datatables->join('tbl_status_menikah', 'tbl_status_menikah.id = tbl_pasien.id_status_pernikahan');
        
        $this->datatables->join("tbl_gol_darah", "tbl_gol_darah.id = {$this->table}.id_gol_darah");
        $this->datatables->join("tbl_jenis_kelamin", "tbl_jenis_kelamin.id = {$this->table}.id_jenis_kelamin");

        $this->datatables->add_column('action', $actions, 'id');

        return $this->datatables->generate();
    } 

    function get($id = "", $q = "", $limit = 10, $start = 0)
    {
        if (!empty($id)) $this->db->where($this->pk, $id);

        $this->db->select("*, {$this->pk}");
        $this->db->join('tbl_status_menikah', 'tbl_status_menikah.id = tbl_pasien.id_status_pernikahan');
        
        $this->db->join("tbl_gol_darah", "tbl_gol_darah.id = {$this->table}.id_gol_darah");

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
        return $this->db->insert($this->table_bh, stamp($data));
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

}