<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Spesialis extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_spesialis_model');
        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("spesialis/create");
        $data['file_name'] = "LAPORAN SPESIALISASI DOKTER";
        $data['title'] = "LAPORAN SPESIALISASI DOKTER";
        $data['message'] = "";
        $this->template->load('template', 'spesialis/tbl_spesialis_list', $data);
    }

    public function json()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_spesialis_model->json();
    }

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('spesialis/create_action'),
            'id' => set_value('id'),
            'nama_spesialis' => set_value('nama_spesialis'),
        );
        $this->template->load('template', 'spesialis/tbl_spesialis_form', $data);
    }

    public function create_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $data = array(
                'nama_spesialis' => $this->input->post('nama_spesialis', TRUE),
            );

            if ($this->Tbl_spesialis_model->insert($data)) {
                $this->session->set_flashdata('success', "Berhasil membuat data.");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
            }

            redirect(site_url('spesialis'));
        }
    }

    public function update($id)
    {
        $row = $this->Tbl_spesialis_model->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('spesialis/update_action'),
                'id' => set_value('id', $row->id),
                'nama_spesialis' => set_value('nama_spesialis', $row->nama_spesialis),
            );
            $this->template->load('template', 'spesialis/tbl_spesialis_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('spesialis'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('id', TRUE));
        } else {
            $data = array(
                'nama_spesialis' => $this->input->post('nama_spesialis', TRUE),
            );

            if ($this->Tbl_spesialis_model->update($this->input->post('id', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }

            redirect(site_url('spesialis'));
        }
    }

    public function delete($id)
    {
        $row = $this->Tbl_spesialis_model->get_by_id($id);

        if ($row) {
            if ($this->Tbl_spesialis_model->delete($id)) {
                $this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
                $this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('spesialis'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('spesialis'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('nama_spesialis', 'nama_spesialis', 'trim|required');

        $this->form_validation->set_rules('id', 'id', 'trim');
        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }
}

/* End of file Spesialis.php */
/* Location: ./application/controllers/Spesialis.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-11-27 18:34:40 */
/* http://harviacode.com */