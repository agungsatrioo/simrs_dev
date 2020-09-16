<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tbl_tindakan_model extends CI_Model
{

    public $table = 'tbl_tindakan';
    public $id = 'kode_tindakan';
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }

    // datatables
    function json() {
        $this->datatables->select('tbl_tindakan.kode_tindakan,tbl_tindakan.jenis_tindakan,tbl_tindakan.nama_tindakan,tbl_kategori_tindakan.kategori_tindakan,tbl_tindakan.tarif,tbl_tindakan.tindakan_oleh,tbl_tindakan.id_poliklinik');
        $this->datatables->from('tbl_tindakan');
        //add this line for join
        $this->datatables->join('tbl_kategori_tindakan', 'tbl_tindakan.kode_kategori_tindakan = tbl_kategori_tindakan.kode_kategori_tindakan');
        $this->datatables->add_column('action',anchor(site_url('data_tindakan/update/$1'),'<i class="fa fa-pencil-square-o" aria-hidden="true"></i>', array('class' => 'btn btn-danger btn-sm'))." 
                ".anchor(site_url('data_tindakan/delete/$1'),'<i class="fa fa-trash-o" aria-hidden="true"></i>','class="btn btn-danger btn-sm" onclick="javasciprt: return confirm(\'Apakah Anda yakin?\')"'), 'kode_tindakan');
        return $this->datatables->generate();
    }

    // get all
    function get_all()
    {
        $this->db->order_by($this->id, $this->order);
        return $this->db->get($this->table)->result();
    }

    // get data by id
    function get_by_id($id)
    {
        $this->db->where($this->id, $id);
        return $this->db->get($this->table)->row();
    }
    
    // get total rows
    function total_rows($q = NULL) {
        $this->db->like('kode_tindakan', $q);
	$this->db->or_like('jenis_tindakan', $q);
	$this->db->or_like('nama_tindakan', $q);
	$this->db->or_like('kode_kategori_tindakan', $q);
	$this->db->or_like('tarif', $q);
	$this->db->or_like('tindakan_oleh', $q);
	$this->db->or_like('id_poliklinik', $q);
	$this->db->from($this->table);
        return $this->db->count_all_results();
    }

    // get data with limit and search
    function get_limit_data($limit, $start = 0, $q = NULL) {
        $this->db->order_by($this->id, $this->order);
        $this->db->like('kode_tindakan', $q);
	$this->db->or_like('jenis_tindakan', $q);
	$this->db->or_like('nama_tindakan', $q);
	$this->db->or_like('kode_kategori_tindakan', $q);
	$this->db->or_like('tarif', $q);
	$this->db->or_like('tindakan_oleh', $q);
	$this->db->or_like('id_poliklinik', $q);
	$this->db->limit($limit, $start);
        return $this->db->get($this->table)->result();
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
        $this->db->update($this->table, $data);
    }

    // delete data
    function delete($id)
    {
        $this->db->where($this->id, $id);
        $this->db->delete($this->table);
    }

}

/* End of file Tbl_tindakan_model.php */
/* Location: ./application/models/Tbl_tindakan_model.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-17 18:17:58 */
/* http://harviacode.com */