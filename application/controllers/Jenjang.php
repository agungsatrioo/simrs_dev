<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Jenjang extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_jenjang_model');
        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("jenjang/create");
        $data['file_name'] = "LAPORAN DAFTAR JENJANG";
        $data['title'] = "LAPORAN DAFTAR JENJANG";
        $data['message'] = "";
        
        $this->template->load('template', 'jenjang/tbl_jenjang_list', $data);
    }

    public function json()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_jenjang_model->json();
    }

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('jenjang/create_action'),
            'id' => set_value('id'),
            'kode_jenjang' => set_value('kode_jenjang'),
            'nama_jenjang' => set_value('nama_jenjang'),
        );
        $this->template->load('template', 'jenjang/tbl_jenjang_form', $data);
    }

    public function create_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $data = array(
                'kode_jenjang' => $this->input->post('kode_jenjang', TRUE),
                'nama_jenjang' => $this->input->post('nama_jenjang', TRUE),
            );

            if ($this->Tbl_jenjang_model->insert($data)) {
                $this->session->set_flashdata('success', "Berhasil membuat data.");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
            }

            redirect(site_url('jenjang'));
        }
    }

    public function update($id)
    {
        $row = $this->Tbl_jenjang_model->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('jenjang/update_action'),
                'id' => set_value('id', $row->id),
                'kode_jenjang' => set_value('kode_jenjang', $row->kode_jenjang),
                'nama_jenjang' => set_value('nama_jenjang', $row->nama_jenjang),
            );
            $this->template->load('template', 'jenjang/tbl_jenjang_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('jenjang'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('kode_jenjang', TRUE));
        } else {
            if ($this->Tbl_jenjang_model->update($this->input->post('id', TRUE))) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }
            redirect(site_url('jenjang'));
        }
    }

    public function delete($id)
    {
        $row = $this->Tbl_jenjang_model->get_by_id($id);

        if ($row) {
            if ($this->Tbl_jenjang_model->delete($id)) {
                $this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
                $this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('jenjang'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('jenjang'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('nama_jenjang', 'nama jenjang', 'trim|required');

        $this->form_validation->set_rules('kode_jenjang', 'kode_jenjang', 'trim');
        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }
}

/* End of file Jenjang.php */
/* Location: ./application/controllers/Jenjang.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-11-28 11:46:20 */
/* http://harviacode.com */