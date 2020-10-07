<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Riwayat_perjalanan_model extends CI_Model
{
    public $table = "tbl_pasien_riwayat_perjalanan";
    public $pk = "tbl_pasien_riwayat_perjalanan.id";

    function dt($id_rekamedis, $id_pendaftaran)
    {
        $actions = "
        <div class=\"btn-group\" role=\"group\">
            <a href=\"" . base_url('pendaftaran/detail/$1/perjalanan/$2/delete') . "\" class=\"btn btn-danger\" onclick=\"javascript: return confirm('Apakah Anda yakin?')\"><i class=\"fa fa-trash-alt\"></i> Hapus</a>
        </div>
        ";

        return $this->datatables->select("{$this->pk}, tgl_berangkat, tgl_pulang, keterangan, {$this->table}.id_rekamedis, tbl_pendaftaran.id as id_pendaftaran")
            ->from($this->table)
            ->join("tbl_pendaftaran", "tbl_pendaftaran.id_rekamedis = {$this->table}.id_rekamedis")
            ->where("{$this->table}.id_rekamedis", $id_rekamedis)
            ->where("tbl_pendaftaran.id", $id_pendaftaran)
            ->add_column('action', $actions, 'id_pendaftaran, id')
            ->generate();
    }

    function get_by_rekamedis($id)
    {
        return $this->db->get_where($this->table, [$this->pk => $id])->row();
    }

    function insert()
    {
        $data = [
            "id_rekamedis" => $this->input->post("id_rekamedis", true),
            "tgl_berangkat" => $this->input->post("tgl_berangkat", true),
            "tgl_pulang" => $this->input->post("tgl_pulang", true),
            "keterangan" => $this->input->post("keterangan", true),
        ];

        return $this->db->insert($this->table, stamp($data));
    }

    function delete($id_pendaftaran, $id_rj)
    {
        $this->db->where($this->pk, $id_rj);
        return $this->db->delete($this->table);
    }
}
