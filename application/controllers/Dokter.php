<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Dokter extends Private_Controller
{
    function __construct()
    {
        parent::__construct();

        $this->load->model('Tbl_dokter_model');
        $this->load->model('Tbl_jadwal_praktek_dokter_model');
        $this->load->library('datatables');
    }

    public function index()
    {
        $data = [];
        $data['create_link'] = base_url("dokter/create");
        $this->template->load('template', 'dokter/tbl_dokter_list', $data);
    }

    public function json()
    {
        header('Content-Type: application/json');
        echo $this->Tbl_dokter_model->json();
    }

    public function make_user($id)
    {
        $result = $this->Tbl_dokter_model->get_by_id($id);

        $data = array(
            'button' => 'Create',
            'action' => site_url('user/create_action'),
            'id_users' => set_value('id_users'),
            'full_name' => $result->nama_dokter,
            'email' => "{$result->kode_dokter}@dokter.login",
            'password' => set_value('password'),
            'images' => set_value('images'),
            'id_user_level' => 3,
            'is_aktif' => set_value('is_aktif'),
        );
        $this->template->load('template', 'user/tbl_user_form_new', $data);
    }

    public function create()
    {
        $data = array(
            'button' => 'Create',
            'action' => site_url('dokter/create_action'),
            'id' => set_value('id'),
            'kode_dokter' => set_value('kode_dokter'),
            'no_identitas' => set_value('no_identitas'),
            'nama_dokter' => set_value('nama_dokter'),
            'id_jenis_kelamin' => set_value('id_jenis_kelamin'),
            'tempat_lahir' => set_value('tempat_lahir'),
            'tgl_lahir' => set_value('tgl_lahir'),
            'id_agama' => set_value('id_agama'),
            'alamat' => set_value('alamat'),
            'no_telepon' => set_value('no_telepon'),
            'id_status_menikah' => set_value('id_status_menikah'),
            'id_spesialis' => set_value('id_spesialis'),
            'no_izin_praktik' => set_value('no_izin_praktik'),
            'id_gol_darah' => set_value('id_gol_darah'),
            'alumni' => set_value('alumni'),
        );
        $this->template->load('template', 'dokter/tbl_dokter_form', $data);
    }

    public function create_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->create();
        } else {
            $data = array(
                'kode_dokter' => $this->input->post('kode_dokter', TRUE),
                'nama_dokter' => $this->input->post('nama_dokter', TRUE),
                'no_identitas' => $this->input->post('no_identitas', TRUE),
                'id_jenis_kelamin' => $this->input->post('id_jenis_kelamin', TRUE),
                'tempat_lahir' => $this->input->post('tempat_lahir', TRUE),
                'tgl_lahir' => $this->input->post('tgl_lahir', TRUE),
                'id_agama' => $this->input->post('id_agama', TRUE),
                'alamat' => $this->input->post('alamat', TRUE),
                'no_telepon' => $this->input->post('no_telepon', TRUE),
                'id_status_menikah' => $this->input->post('id_status_menikah', TRUE),
                'id_spesialis' => $this->input->post('id_spesialis', TRUE),
                'no_izin_praktik' => $this->input->post('no_izin_praktik', TRUE),
                'id_gol_darah' => $this->input->post('id_gol_darah', TRUE),
                'alumni' => $this->input->post('alumni', TRUE),
            );

            if ($this->Tbl_dokter_model->insert($data)) {
                $this->session->set_flashdata('success', "Berhasil membuat data.");
            } else {
                $this->session->set_flashdata('error', "Gagal membuat data. Silakan coba lagi setelah beberapa saat");
            }
            redirect(site_url('dokter'));
        }
    }

    public function update($id)
    {
        $row = $this->Tbl_dokter_model->get_by_id($id);

        if ($row) {
            $data = array(
                'button' => 'Update',
                'action' => site_url('dokter/update_action'),
                'id' => set_value('id', $row->id),
                'kode_dokter' => set_value('kode_dokter', $row->kode_dokter),
                'no_identitas' => set_value('no_identitas', $row->no_identitas),
                'nama_dokter' => set_value('nama_dokter', $row->nama_dokter),
                'id_jenis_kelamin' => set_value('id_jenis_kelamin', $row->id_jenis_kelamin),
                'tempat_lahir' => set_value('tempat_lahir', $row->tempat_lahir),
                'tgl_lahir' => set_value('tgl_lahir', $row->tgl_lahir),
                'id_agama' => set_value('id_agama', $row->id_agama),
                'alamat' => set_value('alamat', $row->alamat),
                'no_telepon' => set_value('no_telepon', $row->no_telepon),
                'id_status_menikah' => set_value('id_status_menikah', $row->id_status_menikah),
                'id_spesialis' => set_value('id_spesialis', $row->id_spesialis),
                'no_izin_praktik' => set_value('no_izin_praktik', $row->no_izin_praktik),
                'id_gol_darah' => set_value('id_gol_darah', $row->id_gol_darah),
                'alumni' => set_value('alumni', $row->alumni),
            );
            $this->template->load('template', 'dokter/tbl_dokter_form', $data);
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('dokter'));
        }
    }

    public function update_action()
    {
        $this->_rules();

        if ($this->form_validation->run() == FALSE) {
            $this->update($this->input->post('id', TRUE));
        } else {
            $data = array(
                'kode_dokter' => $this->input->post('kode_dokter', TRUE),
                'no_identitas' => $this->input->post('no_identitas', TRUE),
                'nama_dokter' => $this->input->post('nama_dokter', TRUE),
                'id_jenis_kelamin' => $this->input->post('id_jenis_kelamin', TRUE),
                'tempat_lahir' => $this->input->post('tempat_lahir', TRUE),
                'tgl_lahir' => $this->input->post('tgl_lahir', TRUE),
                'id_agama' => $this->input->post('id_agama', TRUE),
                'alamat' => $this->input->post('alamat', TRUE),
                'no_telepon' => $this->input->post('no_telepon', TRUE),
                'id_status_menikah' => $this->input->post('id_status_menikah', TRUE),
                'id_spesialis' => $this->input->post('id_spesialis', TRUE),
                'no_izin_praktik' => $this->input->post('no_izin_praktik', TRUE),
                'id_gol_darah' => $this->input->post('id_gol_darah', TRUE),
                'alumni' => $this->input->post('alumni', TRUE),
            );

            if ($this->Tbl_dokter_model->update($this->input->post('id', TRUE), $data)) {
                $this->session->set_flashdata('success', "Berhasil memperbarui data.");
            } else {
                $this->session->set_flashdata('error', "Gagal memperbarui data.");
            }

            redirect(site_url('dokter'));
        }
    }

    public function delete($id)
    {
        $row = $this->Tbl_dokter_model->get_by_id($id);

        if ($row) {
            if ($this->Tbl_dokter_model->delete($id)) {
                $this->session->set_flashdata('success', "Berhasil menghapus data.");
            } else {
                $this->session->set_flashdata('error', "Gagal menghapus data.");
            }

            redirect(site_url('dokter'));
        } else {
            $this->session->set_flashdata('error', 'Tidak ada data yang tersedia.');
            redirect(site_url('dokter'));
        }
    }

    public function _rules()
    {
        $this->form_validation->set_rules('kode_dokter', 'kode dokter', 'trim|required');
        $this->form_validation->set_rules('nama_dokter', 'nama dokter', 'trim|required');
        $this->form_validation->set_rules('id_jenis_kelamin', 'jenis kelamin', 'trim|required');
        $this->form_validation->set_rules('tempat_lahir', 'tempat lahir', 'trim|required');
        $this->form_validation->set_rules('tgl_lahir', 'tanggal lahir', 'trim|required');
        $this->form_validation->set_rules('id_agama', 'id agama', 'trim|required');
        $this->form_validation->set_rules('alamat', 'alamat tinggal', 'trim|required');
        $this->form_validation->set_rules('no_telepon', 'no hp', 'trim|required');
        $this->form_validation->set_rules('id_status_menikah', 'id status menikah', 'trim|required');
        $this->form_validation->set_rules('id_spesialis', 'id spesialis', 'trim|required');
        $this->form_validation->set_rules('no_izin_praktik', 'no izin praktek', 'trim|required');
        $this->form_validation->set_rules('id_gol_darah', 'golongan darah', 'trim|required');
        //$this->form_validation->set_rules('alumni', 'alumni', 'trim|required');
        //$this->form_validation->set_rules('kode_dokter', 'kode_dokter', 'trim');
        $this->form_validation->set_error_delimiters('<span class="text-danger">', '</span>');
    }
    

    function ajax_dokter()
    {
        echo $this->Tbl_dokter_model->select2_ajax();
    }
}

/* End of file Dokter.php */
/* Location: ./application/controllers/Dokter.php */
/* Please DO NOT modify this information : */
/* Generated by Harviacode Codeigniter CRUD Generator 2017-11-27 18:45:56 */
/* http://harviacode.com */