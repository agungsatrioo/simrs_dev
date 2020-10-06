<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Supplier extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_supplier_model');
        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("barang/supplier/create");
        $data['file_name'] = "LAPORAN SUPPLIER";
        $data['title'] = "LAPORAN SUPPLIER";
        $data['message'] = "";
        $this->template->load('template', 'supplier/tbl_supplier_list', $data);
    }

    public function json()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_supplier_model->json();
    }

    public function ajax_supplier() {
        header('Content-Type: application/json');
        echo $this->Tbl_supplier_model->select2_ajax();
    }

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('barang/supplier/do_create'),
            'kode_supplier' => set_value('kode_supplier'),
            'nama_supplier' => set_value('nama_supplier'),
            'alamat' => set_value('alamat'),
            'no_telpon' => set_value('no_telpon'),
        );
        $this->template->load('template', 'supplier/tbl_supplier_form', $data);
    }

    public function create_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $data = array(
                'kode_supplier' => $this->input->post('kode_supplier', TRUE),
                'nama_supplier' => $this->input->post('nama_supplier', TRUE),
                'alamat' => $this->input->post('alamat', TRUE),
                'no_telpon' => $this->input->post('no_telpon', TRUE),
            );

            if ($this->Tbl_supplier_model->insert($data)) {
                $this->session->set_flashdata('success', "Berhasil membuat data.");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
            }
            redirect(site_url('barang/supplier'));
        }
    }

    public function update($id)
    {
        $row = $this->Tbl_supplier_model->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('barang/supplier/do_update'),
                'kode_supplier' => set_value('kode_supplier', $row->kode_supplier),
                'nama_supplier' => set_value('nama_supplier', $row->nama_supplier),
                'alamat' => set_value('alamat', $row->alamat),
                'no_telpon' => set_value('no_telpon', $row->no_telpon),
            );
            $this->template->load('template', 'supplier/tbl_supplier_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('barang/supplier'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('kode_supplier', TRUE));
        } else {
            $data = array(
                'nama_supplier' => $this->input->post('nama_supplier', TRUE),
                'alamat' => $this->input->post('alamat', TRUE),
                'no_telpon' => $this->input->post('no_telpon', TRUE),
            );

            if ($this->Tbl_supplier_model->update($this->input->post('kode_supplier', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }

            redirect(site_url('barang/supplier'));
        }
    }

    public function delete($id)
    {
        $row = $this->Tbl_supplier_model->get_by_id($id);

        if ($row) {
            if ($this->Tbl_supplier_model->delete($id)) {
                $this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
                $this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('barang/supplier'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('barang/supplier'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('nama_supplier', 'nama supplier', 'trim|required');
        $this->form_validation->set_rules('alamat', 'alamat', 'trim|required');
        $this->form_validation->set_rules('no_telpon', 'no telpon', 'trim|required');

        $this->form_validation->set_rules('kode_supplier', 'kode_supplier', 'trim');
        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }

    function autocomplate()
    {
        autocomplate_json('tbl_supplier', 'nama_supplier');
    }
}

/* End of file Supplier.php */
/* Location: ./application/controllers/Supplier.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-12-11 17:19:48 */
/* http://harviacode.com */