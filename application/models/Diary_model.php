<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Diary_model extends CI_Model
{
    public $table = "tbl_pendaftaran_diary";
    public $pk = "tbl_pendaftaran_diary.id";

    function dt($id_pendaftaran)
    {
        $actions = "
        <div class=\"btn-group\" role=\"group\">
            <a href=\"" . base_url('pendaftaran/detail/$1/diary/$2/delete') . "\" class=\"btn btn-danger\" onclick=\"javascript: return confirm('Apakah Anda yakin?')\"><i class=\"fa fa-trash-alt\"></i> Hapus</a>
        </div>
        ";

        return $this->datatables->select("{$this->pk}, id_pendaftaran, tgl_input, isi")
            ->from($this->table)
            ->where("id_pendaftaran", $id_pendaftaran)
            ->add_column('action', $actions, 'id_pendaftaran, id')
            ->generate();
    }

    function insert()
    {
        $data = [
            "id_pendaftaran" => $this->input->post("id_pendaftaran", true),
            "isi" => $this->input->post("isi", true),
        ];

        return $this->db->insert($this->table, stamp($data));
    }

    function delete($id_diary)
    {
        $this->db->where($this->pk, $id_diary);
        return $this->db->delete($this->table);
    }
}
