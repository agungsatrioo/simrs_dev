<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tbl_tindakan_model extends CI_Model
{

    public $table = 'tbl_tindakan';
    public $id = 'id';
    public $pk = 'tbl_tindakan.id';
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }

    // datatables
    function json()
    {
        $this->datatables->select('tbl_tindakan.id,kode_tindakan,tbl_tindakan.jenis_tindakan,tbl_tindakan.nama_tindakan,tbl_tindakan_kategori.kategori_tindakan,tbl_tindakan.tarif,tbl_tindakan.id_poliklinik');
        $this->datatables->from('tbl_tindakan');
        //add this line for join
        $this->datatables->join('tbl_tindakan_kategori', 'tbl_tindakan.kode_kategori_tindakan = tbl_tindakan_kategori.id');

        $this->datatables->add_column('action', anchor(site_url('data_tindakan/update/$1'), '<i class="fa fa-pen" aria-hidden="true"></i>', array('class' => 'btn btn-danger btn-sm')) . " 
                " . anchor(site_url('data_tindakan/delete/$1'), '<i class="fa fa-trash-alt" aria-hidden="true"></i>', 'class="btn btn-danger btn-sm" onclick="javasciprt: return confirm(\'Apakah Anda yakin?\')"'), 'id');

        $result = $this->datatables->generate();

        $decodedjson = json_decode($result);

        foreach ($decodedjson->data as $item) {
            $item->tarif = rupiah($item->tarif);
        }

        $result = json_encode($decodedjson);

        return $result;
    }

    function get($id = "", $q = "", $limit = 10, $start = 0)
    {
        $this->db->order_by($this->pk, $this->order);
        $this->db->where($this->pk, $id);

        $this->db->select("*, {$this->pk}");
        $this->db->join('tbl_tindakan_kategori', 'tbl_tindakan.kode_kategori_tindakan = tbl_tindakan_kategori.id');

        if (!empty($q)) {
            $this->db->like('id', $q);
            $this->db->or_like('jenis_tindakan', $q);
            $this->db->or_like('nama_tindakan', $q);
            $this->db->or_like('tbl_tindakan.kode_kategori_tindakan', $q);
            $this->db->or_like('tarif', $q);
            //$this->db->or_like('tindakan_oleh', $q);
            $this->db->or_like('id_poliklinik', $q);
        }

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

    function next_number()
    {
        $h = intval($this->get()->row()->id);
        return $h;
    }

    // get data with limit and search
    function get_limit_data($limit, $start = 0, $q = NULL)
    {
        $data = $this->get("", $q, $limit, $start)->result();

        foreach ($data as $item) {
            $item->tarif_readable = rupiah($item->tarif);
        }

        return $data;
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

    function dt_riwayat_tindakan($id_pendaftaran = null, $tipe_display)
    {
        $table = "tbl_pendaftaran_riwayat_tindakan";
        $pk = "tbl_pendaftaran_riwayat_tindakan.id";

        $actions = "";

        switch ($tipe_display) {
            case "keuangan":
                $actions = "
                <div class=\"btn-group\" role=\"group\">
                    <a href=\"" . base_url("keuangan_area/detail/$id_pendaftaran/tindakan/$1/approve") . "\" class=\"btn btn-sm btn-success\" onclick=\"javascript: return confirm('Apakah Anda yakin?')\"><i class=\"fa fa-check\"></i> Setujui</a>
                    <a href=\"" . base_url("keuangan_area/detail/$id_pendaftaran/tindakan/$1/reject") . "\" class=\"btn btn-sm btn-danger\" onclick=\"javascript: return confirm('Apakah Anda yakin?')\"><i class=\"fa fa-times\"></i> Tolak</a>
                </div>
                ";
                break;
            case "apoteker":
                $actions = "&nbsp;";
                break;
            default:
                $actions = "
            <div class=\"btn-group\" role=\"group\">
                <a href=\"" . base_url("pendaftaran/detail/$id_pendaftaran/tindakan/$1/delete") . "\" class=\"btn btn-sm btn-danger\" onclick=\"javascript: return confirm('Apakah Anda yakin?')\"><i class=\"fa fa-trash-alt\"></i> Hapus</a>
            </div>
            ";
        }

        return $this->datatables->select("$pk, $table.id_pendaftaran, nama_tindakan, tarif, nama_dokter, nama_pegawai, tanggal, hasil_periksa, perkembangan, id_status_acc, deskripsi_status_acc")
            ->from($table)
            ->where("$table.id_pendaftaran", $id_pendaftaran)
            ->join("tbl_pegawai", "tbl_pegawai.id = $table.id_pegawai", "left")
            ->join("tbl_dokter", "tbl_dokter.id = $table.id_dokter")
            ->join("tbl_tindakan", "tbl_tindakan.id = $table.id_tindakan")
            ->join("tbl_status_acc", "tbl_status_acc.id = $table.id_status_acc")
            ->add_column('action', $actions, 'id')
            ->add_column('status', '$1', 'draw_acc(id_status_acc, deskripsi_status_acc)')
            ->generate();
    }

    function delete_riwayat_tindakan($id)
    {
        $this->db->where("id", $id);
        return $this->db->delete("tbl_pendaftaran_riwayat_tindakan");
    }

    function ajax()
    {
        return $this->ajax->select("{$this->pk}, nama_tindakan, tarif, kategori_tindakan")
            ->from($this->table)
            ->join("tbl_tindakan_kategori", "tbl_tindakan_kategori.id = {$this->table}.kode_kategori_tindakan")
            ->generate();
    }
}

/* End of file Tbl_tindakan_model.php */
/* Location: ./application/models/Tbl_tindakan_model.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-17 18:17:58 */
/* http://harviacode.com */