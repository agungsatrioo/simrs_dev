<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Antrean_model extends CI_Model
{

    public $table = 'tbl_antrean';
    public $id = 'id_antrean';
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }

    function last_id($ongoing = true)
    {
        $this->db->where('date_format(tanggal_antrean,"%Y-%m-%d")', 'CURDATE()', FALSE);
        if($ongoing) $this->db->where('status', 'ongoing');

        $this->db->order_by("no_antrean", "asc");
        $this->db->join('tbl_pendaftaran', 'tbl_pendaftaran.no_rawat = ' . $this->table . '.no_rawat');
        $this->db->join('tbl_pasien', 'tbl_pasien.no_rekamedis = tbl_pendaftaran.no_rekamedis ');
        $this->db->join('tbl_antrean_type', 'tbl_antrean_type.id_tipe_antrean = ' . $this->table . '.id_tipe_antrean');

        $result = $this->db->get($this->table)->first_row();

        return $result;
    }

    function insert($no_rawat, $type_antrean = 1)
    {
        $last_id = $this->last_id(false);
        $last_number = $last_id->no_antrean;
        $next_number = $last_number + 1;

        $data = array(
            'no_rawat' => $no_rawat,
            'id_tipe_antrean' => $type_antrean,
            'no_antrean' => $next_number
        );
    
        return $this->db->insert('tbl_antrean', $data);
    }

    private function alter_antrean($status) {
        $last_id = $this->last_id();

        $data = array(
            'status' => $status,
        );

        $this->db->where('id_antrean', $last_id->id_antrean);

        return $this->db->update('tbl_antrean', $data);
    }

    function skip()
    {
        return $this->alter_antrean("skipped");
    }

    function next()
    {
        return $this->alter_antrean("done");
    }
}
