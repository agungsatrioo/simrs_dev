<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Barang extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model(["Barang_model" => "barang"]);
        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("barang/create");
        $data['json_url'] = base_url("barang/json");
        $data['file_name'] = "LAPORAN BARANG";
        $data['title'] = "LAPORAN BARANG";
        $data['box_title'] = "LAPORAN BARANG";
        $data['message'] = "";
        $this->template->load('template', 'barang/barang_list', $data);
    }

    public function obat()
    {
        $data = [];

        $data['create_link'] = base_url("barang/create/obat");
        $data['json_url'] = base_url("barang/json_obat");
        $data['file_name'] = "LAPORAN BARANG OBAT";
        $data['title'] = "LAPORAN BARANG OBAT";
        $data['box_title'] = "LAPORAN OBAT";
        $data['message'] = "";

        $this->template->load('template', 'barang/barang_list', $data);
    }

    public function alkes()
    {
        $data = [];

        $data['create_link'] = base_url("barang/create/alkes");
        $data['json_url'] = base_url("barang/json_alkes");
        $data['file_name'] = "LAPORAN BARANG ALAT KESEHATAN";
        $data['title'] = "LAPORAN BARANG KESEHATAN";
        $data['box_title'] = "LAPORAN ALAT KESEHATAN";
        $data['message'] = "";
        $this->template->load('template', 'barang/barang_list', $data);
    }

    public function ajax() {
        echo $this->barang->ajax();
    }

    public function json()
    {
        echo $this->barang->json();
    }

    public function json_obat()
    {
        echo $this->barang->json(1);
    }

    public function json_alkes()
    {
        echo $this->barang->json(2);
    }

    public function create($kelompok = "")
    {
        $redir_link = "";

        switch ($kelompok) {
            case "obat":
                $redir_link = "barang/obat";
                break;
            case "alkes":
                $redir_link = "barang/alkes";
                break;
            default:
                $redir_link = "barang";
        }

        $data = array(
            'button' => 'Create',
            'action' => base_url('barang/create_action'),
            'kode_barang' => set_value('kode_barang'),
            'id' => set_value('id'),
            'cmb_where' => set_value('id'),
            'nama_barang' => set_value('nama_barang'),
            'id_kat_barang' => set_value('id_kat_barang'),
            'id_satuan_barang' => set_value('id_satuan_barang'),
            'id_kategori_harga_brg' => set_value('id_kategori_harga_brg'),
            'harga' => set_value('harga'),
            'back_link' => base_url($redir_link),
        );
        $this->template->load('template', 'barang/barang_form', $data);
    }

    public function create_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $kd_barang = $this->input->post('kode_barang', TRUE);
            $nama_barang = $this->input->post('nama_barang', TRUE);
            $back_link = $this->input->post('back_link', TRUE);

            $data = array(
                'kode_barang' => $kd_barang,
                'nama_barang' => $nama_barang,
                'id_kat_barang' => $this->input->post('id_kat_barang', TRUE),
                'id_satuan_barang' => $this->input->post('id_satuan_barang', TRUE),
                'id_kat_harga' => $this->input->post('id_kat_harga', TRUE),
                'harga' => $this->input->post('harga', TRUE),
            );

            if ($this->barang->insert($data)) {
                $this->session->set_flashdata('success', "Berhasil membuat kode obat \"{$kd_barang}\" dengan nama \"$nama_barang\".");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan mencoba lagi setelah beberapa saat.");
            }

            redirect($back_link);
        }
    }

    public function update($id)
    {
        $row = $this->barang->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('barang/update_action'),
                'id' => set_value('id', $row->id),
                'back_link' => set_value('back_link', $row->back_link),
                'kode_barang' => set_value('kode_barang', $row->kode_barang),
                'nama_barang' => set_value('nama_barang', $row->nama_barang),
                'id_kat_barang' => set_value('id_kat_barang', $row->id_kat_barang),
                'id_kat_harga' => set_value('id_kat_harga', $row->id_kat_harga),
                'id_satuan_barang' => set_value('id_satuan_barang', $row->id_satuan_barang),
                'harga' => set_value('harga', $row->harga),
            );
            $this->template->load('template', 'barang/barang_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Data obat yang dimaksud tidak tersedia.');
            redirect(site_url('barang'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('kode_barang', TRUE));
        } else {
            $back_link = $this->input->post('back_link', TRUE);

            $data = array(
                'nama_barang' => $this->input->post('nama_barang', TRUE),
                'id_kat_barang' => $this->input->post('id_kat_barang', TRUE),
                'id_kat_harga' => $this->input->post('id_kat_harga', TRUE),
                'id_satuan_barang' => $this->input->post('id_satuan_barang', TRUE),
                'harga' => $this->input->post('harga', TRUE),
            );

            if ($this->barang->update($this->input->post('id', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }

            redirect($back_link);
        }
    }

    public function delete($id)
    {
        $row = $this->barang->get_by_id($id);

        if ($row) {
            if ($this->barang->delete($id)) {
                $this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
                $this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('barang'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('barang'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('nama_barang', 'nama barang', 'trim|required');
        $this->form_validation->set_rules('id_kat_barang', 'id kategori barang', 'trim|required');
        $this->form_validation->set_rules('id_satuan_barang', 'id satuan barang', 'trim|required');
        $this->form_validation->set_rules('harga', 'harga', 'trim|required');

        $this->form_validation->set_rules('kode_barang', 'kode_barang', 'trim');
        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }
}

/* End of file Kategoribarang.php */
/* Location: ./application/controllers/Kategoribarang.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-09 11:12:11 */
/* http://harviacode.com */