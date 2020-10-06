<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Barang_model extends CI_Model
{

    public $table = 'tbl_barang';
    public $id = 'id';
    public $pk =  "tbl_barang.id";
    public $order = 'DESC';

    public $kel_obat = 1;
    public $kel_alkes = 2;

    function __construct()
    {
        parent::__construct();
    }

    function json($kelompok = "") {
        $actions = "
        <div class=\"btn-group\" role=\"group\">
            <a href=\"".site_url('barang/update/$1')."\" class=\"btn btn-default\"><i class=\"fa fa-pen\"></i> Edit</a>
            <a href=\"".site_url('barang/delete/$1')."\" class=\"btn btn-danger\" onclick=\"javascript: return confirm('Apakah Anda yakin?')\"><i class=\"fa fa-trash-alt\"></i> Hapus</a>
        </div>
        ";

        $this->datatables->select("{$this->pk}, nama_kelompok, kode_barang, nama_barang, nama_kategori, nama_satuan, harga, nama_kategori_harga_brg, nama_kelompok, id_kelompok");
        $this->datatables->from($this->table);

        if(!empty($kelompok)) $this->datatables->where('tbl_barang_kategori.id_kelompok', $kelompok);

        $this->datatables->join('tbl_barang_kategori', 'tbl_barang_kategori.id=tbl_barang.id_kat_barang');
        $this->datatables->join('tbl_barang_kat_harga', 'tbl_barang_kat_harga.id=tbl_barang.id_kat_harga');
        $this->datatables->join('tbl_barang_kelompok', 'tbl_barang_kelompok.id=tbl_barang_kategori.id_kelompok');
        $this->datatables->join('tbl_barang_satuan', 'tbl_barang_satuan.id=tbl_barang.id_satuan_barang');

        $this->datatables->add_column('action', $actions, 'id');

        return $this->datatables->generate();
    }

    function get($id = "", $kelompok = "", $limit = 10, $start = 0)
    {
        $this->db->order_by($this->pk, $this->order);

        $this->db->where($this->pk, $id);
        $this->db->select("*, {$this->pk}, tbl_barang_kategori.id_kelompok as kelompok");

        if(!empty($kelompok)) $this->db->where('kelompok', $kelompok);

        $this->db->join('tbl_barang_kategori', 'tbl_barang_kategori.id=tbl_barang.id_kat_barang');
        $this->db->join('tbl_barang_kat_harga', 'tbl_barang_kat_harga.id=tbl_barang.id_kat_harga');
        $this->db->join('tbl_barang_satuan', 'tbl_barang_satuan.id=tbl_barang.id_satuan_barang');
        $this->datatables->join('tbl_barang_kelompok', 'tbl_barang_kelompok.id=tbl_barang_kategori.id_kelompok');

        $this->db->limit($limit, $start);

        return $this->db->get($this->table);
    }
    
    /**
     * ajax
     *
     * @param  mixed $barang    : id barang
     * @param  mixed $kelompok  : kelompok barang (mis. obat atau alkes)
     * @param  mixed $kategori  : kategori barang (mis. obat batuk atau obat lainnya)
     * @return void
     */
    function ajax($barang = null, $kelompok = null, $kategori = null) {
        $ajax = $this->ajax->select("{$this->pk}, nama_barang, nama_kategori, nama_satuan, harga, nama_kategori_harga_brg, nama_kelompok")
                          ->from($this->table)
                          ->searchable_column([$this->pk, "nama_barang"])
                          ->limit(10)
                          ->join('tbl_barang_kategori', 'tbl_barang_kategori.id=tbl_barang.id_kat_barang')
                          ->join('tbl_barang_kelompok', 'tbl_barang_kelompok.id=tbl_barang_kategori.id_kelompok')
                          ->join('tbl_barang_kat_harga', 'tbl_barang_kat_harga.id=tbl_barang.id_kat_harga')
                          ->join('tbl_barang_satuan', 'tbl_barang_satuan.id=tbl_barang.id_satuan_barang');
                          
        if(!empty($barang))   $ajax->where($this->pk, $barang);    
        if(!empty($kelompok)) $ajax->where("id_kelompok", $kelompok);    
        if(!empty($kategori)) $ajax->where("tbl_barang_kategori.id", $kategori);    
        
        return $ajax->generate();
    }

    // get all
    function get_all()
    {
        return $this->get()->result();
    }

    // get data by id
    function get_by_id($id)
    {
        $row = $this->get($id)->row();

        switch($row->id_kelompok) {
            case $this->kel_obat:
                $row->back_link = base_url("barang/obat");
            break;
            case $this->kel_alkes:
                $row->back_link = base_url("barang/alkes");
            break;
            default:
            $row->back_link = base_url("barang");
        }

        return $row;
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
}