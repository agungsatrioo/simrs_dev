<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Keuangan_model extends CI_Model
{
    function set_status($table, $id_riwayat, $status = 2) {
        return $this->update_data(
            ['id' => $id_riwayat], 
            ["id_status_acc" => $status], $table
        );
    }

    function update_data($where,$data,$table){
		$this->db->where($where);
		return $this->db->update($table,stamp_update($data));
	}	
}