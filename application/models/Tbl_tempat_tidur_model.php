<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tbl_tempat_tidur_model extends CI_Model
{
    public $table = 'tbl_rs_tempat_tidur';
    public $id = 'id';
    public $order = 'DESC';

    function __construct()
    {
        parent::__construct();
    }

    // datatables
    function json()
    {
        $this->datatables->select('tbl_rs_tempat_tidur.id,kode_tempat_tidur, nama_ruangan,nama_gedung');
        $this->datatables->from('tbl_rs_tempat_tidur');
        //add this line for join
        $this->datatables->join('tbl_rs_ruang', 'tbl_rs_tempat_tidur.id_ranap_ruang = tbl_rs_ruang.id');
        $this->datatables->join('tbl_rs_gedung', 'tbl_rs_ruang.id_ranap_gedung = tbl_rs_gedung.id');
        $this->datatables->add_column(
            'action',
            anchor(site_url('tempattidur/update/$1'), '<i class="fa fa-pen" aria-hidden="true"></i>', array('class' => 'btn btn-danger btn-sm')) . " 
                " . anchor(site_url('tempattidur/delete/$1'), '<i class="fa fa-trash-alt" aria-hidden="true"></i>', 'class="btn btn-danger btn-sm" onclick="javasciprt: return confirm(\'Apakah Anda yakin?\')"'),
            'id'
        );
        $this->datatables->add_column('status', '$1', 'a');

        $json = json_decode($this->datatables->generate());

        foreach($json->data as $item) {
            $item->status = $this->cek_kasur($item->id);
        }

        $enc_json = json_encode($json);

        return $enc_json;
    }

    function get($id = "") {
        if(!empty($id)) $this->db->where($this->id, $id);

        $this->db->join('tbl_rs_ruang', 'tbl_rs_tempat_tidur.id_ranap_ruang = tbl_rs_ruang.	id');
        $this->db->join('tbl_rs_gedung', 'tbl_rs_ruang.id_ranap_gedung = tbl_rs_gedung.id');

        return $this->db->get($this->table);
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
    function total_rows($q = NULL)
    {
        $this->db->like('id', $q);
        $this->db->or_like('kode_ruang_rawat_inap', $q);
        $this->db->or_like('status', $q);
        $this->db->from($this->table);
        return $this->db->count_all_results();
    }

    // get data with limit and search
    function get_limit_data($limit, $start = 0, $q = NULL)
    {
        $this->db->order_by($this->id, $this->order);
        $this->db->like('id', $q);
        $this->db->or_like('kode_ruang_rawat_inap', $q);
        $this->db->or_like('status', $q);
        $this->db->limit($limit, $start);
        return $this->db->get($this->table)->result();
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

    function cek_kasur($id_kasur)
    {
        return $this->checkStatusKasur($id_kasur) ? "Diisi" : "Kosong";
    }

    function checkStatusKasur($id_kasur)
    {

        return true;
        
        $this->db->where('id', $id_kasur);
        $this->db->where('tanggal_keluar >=', date('Y-m-d'));
        
        $result = $this->db->get('tbl_rawat_inap')->result();

        return !empty($result);
    }

    function get_kasur_table($id_ruangan, $as_radio = false)
    {
        $this->db->where('id_ranap_ruang', $id_ruangan);
        $result = $this->db->get($this->table)->result();

        $batas = 5;

        $table = "<table class='table table-responsive'>";

        $a = 0;
        foreach ($result as $kasur) {
            $diisi = $this->checkStatusKasur($kasur->id) ? ["danger", "disabled"] : ["success", ""];

            $btn = "<a class='btn btn-{$diisi[0]}' style='width: 100% !important'>{$kasur->kode_tempat_tidur}<br><small><b>".$this->cek_kasur($kasur->id)."</b></small></a>";

            if($as_radio) {
                $btn = "<label class=\"btn btn-{$diisi[0]}\" style='width: 100% !important'>
                        <input type=\"radio\" name=\"id\" value=\"{$kasur->kode_tempat_tidur}\" autocomplete=\"off\" {$diisi[1]}><div>{$kasur->kode_tempat_tidur}<br><small><b>".$this->cek_kasur($kasur->id)."<b></div>
                        </label>";
            }

            if ($a < $batas) {
                $table .= "<td>$btn</td>";
                $a++;
            } else {
                $table .= "</tr></tr>";
                $a = 0;
            }
        }

        $table .= "</div></tr></table>";

        return $table;
    }
}

/* End of file Tbl_tempat_tidur_model.php */
/* Location: ./application/models/Tbl_tempat_tidur_model.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-02 16:27:58 */
/* http://harviacode.com */